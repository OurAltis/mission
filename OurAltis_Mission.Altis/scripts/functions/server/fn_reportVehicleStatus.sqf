#include "macros.hpp"
/**
 * OurAltis_Mission - fn_reportVehicleStatus
 * 
 * Author: Raven
 * 
 * Description:
 * Reports the given vehicle and it's current state to the database
 * 
 * Parameter(s):
 * 0: The vehicle to report <Object>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_vehicle", objNull, [objNull]]
];

CHECK_TRUE(isServer, Function can only be executed on the server!, {})
CHECK_TRUE(_success, Invalid parameter!, {})

private _damage = getAllHitPointsDamage _vehicle;
private _fuel = floor ((fuel _vehicle) * 100);
private _id = _vehicle getVariable [VEHICLE_ID, nil];

CHECK_FALSE(isNil "_id", No vehicle ID given!, {})

// report status to the DB
private _result = ["UPDATE armeen SET bestand = '" + str _damage + "', tank = '" + str _fuel + "' WHERE id = '" + _id + "'"] call FUNC(transferSQLRequestToDataBase);
CHECK_DB_RESULT(_result)

nil;
