#include "macros.hpp"
/**
 * OurAltis_Mission - fn_loadVehicle
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Attach objects to a vehicle
 * 
 * Parameter(s):
 * 0: Vehicle <Object>
 * 1: Cargo Array <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_vehicle", objNull, [objNull]],
	["_cargo", [], [[]]]
];

CHECK_TRUE(_success, Invalid parameters!, {})
 
{	
	_x params ["_class", "_pos", "_dir"];
	
	private _obj = _class createVehicle [0,0,0];	
	_obj attachTo [_vehicle, _pos];	
	_obj setPos getPos _obj;
	_obj setDir _dir;
	
	nil
} count _cargo;

nil
