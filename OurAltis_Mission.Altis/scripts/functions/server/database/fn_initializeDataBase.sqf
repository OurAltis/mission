#include "macros.hpp"
/**
 * OurAltis_Mission - fn_initializeDataBase
 * 
 * Author: Raven
 * 
 * Description:
 * Initializes the database
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

DB_INITIALIZED = false;

CHECK_TRUE(isServer, Function can only be executed on the server!, {})

private _result = DATABASE_EXT callExtension format ["9:ADD_DATABASE:%1", DATABASE_NAME];

CHECK_DB_RESULT(_result)

_result = DATABASE_EXT callExtension format["9:ADD_DATABASE_PROTOCOL:%1:SQL:SQL", DATABASE_NAME];

CHECK_DB_RESULT(_result)

DB_INITIALIZED = true;

nil;
