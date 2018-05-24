#include "macros.hpp"
/**
 * OurAltis_Mission - fn_prepareVehiclesMobileCamp
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Adds mobile camp feature to object.
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

if (_type isEqualTo (VEHICLE_MOBILE_CAMP select 0)) then {
	private _jipID = str(_pos);
	
	_obj setVariable [QGVAR(spawnPosition), _pos, true];
	_obj setVariable [QGVAR(JIPID), _jipID, true];
	[_obj, objNull] remoteExecCall [QFUNC(createAddAction), -2, _jipID];
	
	private _FOBCargo = [] call compile preprocessFileLineNumbers "scripts\compositions\cargoFOB1.sqf";						
	[_obj, _FOBCargo, false] call FUNC(cargoVehicle);
	
	for "_i" from 1 to 13 do {
		_obj lockCargo [_i, true];
	};
};

if (_type isEqualTo (VEHICLE_MOBILE_CAMP select 1)) then {
	private _FOBCargo = [] call compile preprocessFileLineNumbers "scripts\compositions\cargoFOB2.sqf";
	[_obj, _FOBCargo, false] call FUNC(cargoVehicle);
	
	for "_i" from 1 to 15 do {
		_obj lockCargo [_i, true];
	};
};

nil
