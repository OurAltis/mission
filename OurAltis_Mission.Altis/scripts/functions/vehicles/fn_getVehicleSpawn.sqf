#include "macros.hpp"
/**
 * OurAltis_Mission - fn_getVehicleSpawn
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Return all spawn points at givin position.
 * 
 * Parameter(s):
 * 1: Overall spawn position <Array>
 * 0: Spawn type <String>
 * 2: Is land vehicle <Booln>
 *
 * Return Value:
 * Spawn points <Array>
 * 
 */

private _success = params [
	["_position", [0, 0, 0], [[]]],
	["_spawnType", "", [""]],
	["_isLand", true, [true]]
];

CHECK_TRUE(_success, Invalid parameter!)

private _spawnPoints = nearestObjects [
	_position,
	[VEHICLE_SPAWN_AIR, VEHICLE_SPAWN_LAND] select _isLand,
	[80, 200] select (_spawnType isEqualTo "carrier")
];

_spawnPoints
