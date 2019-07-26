#include "macros.hpp"
/**
 * OurAltis_Mission - fn_prepareVehiclesIDAP
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Adds IDAP feature to object.
 * 
 * Parameter(s):
 * 0: Vehicle Object <Object>
 * 1: Vehicle Type <String>
 *
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_obj", objNull, [objNull]],
	["_type", "", [""]]
];

CHECK_TRUE(_success, Invalid parameter!)

private _cargoIDAP = [] call compile preprocessFileLineNumbers "scripts\compositions\cargoIDAP.sqf";						
[_obj, _cargoIDAP, false] call FUNC(cargoVehicle);

for "_i" from 1 to 13 do {
	_obj lockCargo [_i, true];
};

nil
