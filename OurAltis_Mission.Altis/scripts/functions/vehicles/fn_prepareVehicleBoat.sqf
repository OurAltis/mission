#include "macros.hpp"
/**
 * OurAltis_Mission - fn_prepareVehicleBoat
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Adds mobile boots feature to object.
 * 
 * Parameter(s):
 * 0: Vehicle Object <Object>
 * 1: Vehicle Type <String>
 * 2: Base side <Side>
 * 3: Spawn position <Array>
 *
 * Return Value:
 * Original object <Object>
 * 
 */

diag_log ("prepareVehicleBoat: " + str(_this));
 
private _success = params [
	["_obj", objNull, [objNull]],
	["_type", "", [""]],
	["_side", sideUnknown, [west]],
	["_position", [0, 0, 0], [[]]]
];

CHECK_TRUE(_success, Invalid parameter!)

private _objBoat = objNull;

if (_type in VEHICLE_BOAT_SMALL) then {
	private _cargoBoat = [] call compile preprocessFileLineNumbers (format ["scripts\compositions\cargoAssaultBoat%1.sqf", _side]);
	
	deleteVehicle _obj;
	
	_obj = createVehicle [[VEHICLE_BOAT_TRANSPORT select 0, VEHICLE_BOAT_TRANSPORT select 1] select (_side isEqualTo east), _x, [], 0, "CAN_COLLIDE"];
	
	for "_i" from 1 to 15 do {
		_obj lockCargo [_i, true];
	};
	
	_objBoat = ([_obj, _cargoBoat, true] call FUNC(cargoVehicle)) select 0;		
	_obj setVariable [QGVAR(hasCargo), true, true];
	
	private _jipID = str(_position);
	
	_obj setVariable [QGVAR(JIPID), _jipID, true];
	[_objBoat, _obj] remoteExecCall [QFUNC(createAddAction), -2, _jipID];						
};

if (_type in VEHICLE_BOAT_BIG) then {
	private _cargoBoat = [] call compile preprocessFileLineNumbers (format ["scripts\compositions\cargoSpeedboat%1.sqf", _side]);
	
	deleteVehicle _obj;
	
	_obj = createVehicle [[VEHICLE_BOAT_TRANSPORT select 0, VEHICLE_BOAT_TRANSPORT select 1] select (_side isEqualTo east), _x, [], 0, "CAN_COLLIDE"];
	
	for "_i" from 1 to 15 do {
		_obj lockCargo [_i, true];
	};
	
	_objBoat = ([_obj, _cargoBoat, true] call FUNC(cargoVehicle)) select 0;
	_obj setVariable [QGVAR(hasCargo), true, true];

	private _jipID = str(_position);
	
	_obj setVariable [QGVAR(JIPID), _jipID, true];
	[_objBoat, _obj] remoteExecCall [QFUNC(createAddAction), -2, _jipID];							
};

_objBoat
