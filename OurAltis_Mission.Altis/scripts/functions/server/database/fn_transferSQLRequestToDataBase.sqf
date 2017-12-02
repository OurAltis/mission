#include "macros.hpp"
/**
 * OurAltis_Mission - fn_transferSQLRequestToDataBase
 * 
 * Author: Raven
 * 
 * Description:
 * Transfers the given SQL statement to the configured database and requests it to execute it
 * 
 * Parameter(s):
 * 0: The SQL statement that should be executed <String>
 * 
 * Return Value:
 * The return value of the database extension <String>
 * 
 */

private _success = params [
	["_sqlStatement", "", [""]]
];

#ifdef DISABLE_DATABASE
	// log the SQL instead of executing it
	diag_log (QUOTE(OurAltis VERSION [Pseudo-Database]: ) + _sqlStatement);
#else
	CHECK_TRUE(isServer, Function can only be executed on the server!, {""})
	CHECK_TRUE(_success, Can only process sql-statements wrapped in a String!, {""})
	CHECK_TRUE(DB_INITIALIZED, Database is not yet initialized!, {""})
	
	// execute SQL and return the status returned by the extension
	DATABASE_EXT callExtension ("0:SQL:" + _sqlStatement);
#endif