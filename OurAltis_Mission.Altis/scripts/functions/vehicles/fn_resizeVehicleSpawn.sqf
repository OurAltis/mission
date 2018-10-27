#include "macros.hpp"
/**
 * OurAltis_Mission - fn_resizeVehicleSpawn
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Resize the number of spawn points in relation to number of vehicles.
 * 
 * Parameter(s):
 * 0: Spawn points <Array>
 * 1: Vehicle count <Scalar>
 * 
 * Return Value:
 * Resized shuffled spawn points <Array>
 *
 */

diag_log ("resizeVehicleSpawn: " + str(_this));
 
private _success = params [
	["_spawnPoints", [], [[]]],
	["_countVehiclesVehicles", 0, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

if (_countVehicles > count _spawnPoints) then {
	_spawnPoints resize _countVehicles;
	_spawnPoints = _spawnPoints apply {if (isnil "_x") then {""} else {_x}};
} else {
	if (_countVehicles < count _spawnPoints) then {
		_spawnPoints resize _countVehicles;		
	};
};

diag_log ("resizeVehicleSpawn: " + str(_spawnPoints));

_spawnPoints
