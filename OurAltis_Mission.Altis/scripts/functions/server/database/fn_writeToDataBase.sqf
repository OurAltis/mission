#include "macros.hpp"
/**
 * OurAltis_Mission - fn_writeToDataBase
 * 
 * Author: Raven
 * 
 * Description:
 * Writes the given values into the given dataBase columns.
 * If there are more values than columns the additional values will be ignored.
 * If there are more columns than values an error will be thrown
 * 
 * Parameter(s):
 * 0: Name of the table to write <String>
 * 1: Columns <Array of Strings>
 * 2: Values that should be written into the columns <Array>
 * 
 * Return Value:
 * The database result (0=failed, 1=Success) <Number>
 * 
 */

private _success = params[
	["_tableName", "", [""]],
	["_columns", [], [[]]],
	["_values", [], [[]]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

CHECK_TRUE(count _columns <= count _values, There are less values than columns specified!, {})

CHECK_TRUE(DB_INITIALIZED, Database is not yet initialized!)


private _argument = toArray format ["0:SQL:INSERT INTO %1.%2 (", DATABASE_NAME, _tableName];

// add columns to the argument
{
	CHECK_TRUE(typeName _x isEqualTo typeName "", Column name has to be a String!, {})
	
	_argument append toArray _x;
	_argument append toArray ",";
	
	nil;
} count _columns;

// remove last comma
_argument resize (count _argument - 1);


// add values
_argument append toArray ") VALUES (";

{
	switch(typeName _x) do {
		case typeName "" : {
			_argument append toArray '"';
			_argument append toArray _x;
			_argument append toArray '",';
		};
		case typeName 0 : {
			_argument append toArray str _x;
			_argument append toArray ',';
		};
		default {
			ERROR_LOG(Unsupported value type (Other than String or number))
		};
	};
	
	nil;
} count _values;

// remove last comma
_argument resize (count _argument - 1);

_argument append toArray ");";


// pass the request to the DB extension
private _result = DATABASE_EXT callExtension toString _argument;

CHECK_DB_RESULT(_result)


_result;
