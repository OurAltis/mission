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
 * 2: Save Position in Object <Booln> 
 * 
 * Return Value:
 * Objects <Object>
 * 
 */

private _success = params [
	["_vehicle", objNull, [objNull]],
	["_cargo", [], [[]]],
	["_savePos", false, [true]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _objs = [];

{	
	_x params ["_class", "_pos", "_dir"];
	
	private _obj = _class createVehicle [0,0,0];	
	_obj attachTo [_vehicle, _pos];	
	_obj setPos getPos _obj;
	_obj setDir _dir;	
	_objs pushBack _obj;
	
	if (_savePos) then {
		_obj setVariable [QGVAR(cargoPos), _pos, true];
	};
	
	nil
} count _cargo;

_objs
