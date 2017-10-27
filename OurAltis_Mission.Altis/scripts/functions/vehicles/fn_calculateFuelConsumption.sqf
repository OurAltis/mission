#include "macros.hpp"
/**
 * OurAltis_Mission - fn_calculateFuelConsumption
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Calculates fuel consuption of given vehicle.
 * 
 * Parameter(s):
 * 0: Array containing the respective vehicle <Array>
 * 1: The ID of the corresponding perframe-Handler <Number>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _succcess = params [
	["_args", [], [[]]],
	["_handlerID", -1, [0]]
];

CHECK_TRUE(_succcess, Invalid parameters!, {})

_args params ["_vehicle"];

if (!alive _vehicle) exitWith {[_handlerID] call CBA_fnc_removePerFrameHandler};

private _lastFuelLevel = (_vehicle getVariable [QGVAR(fuelInfo), 0]);
private _currentFuelLevel = fuel _vehicle; 

if (_currentFuelLevel < _lastFuelLevel) then {
	private _fuelCapacity = getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "fuelCapacity");
	private _vehicleSideID = getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "side");
	private _vehicleSide = [_vehicleSideID] call BIS_fnc_sideType;

	if (_vehicleSide isEqualTo west) then {
		GVAR(fuelConsumption) set [0, (GVAR(fuelConsumption) select 0) + ((_lastFuelLevel - _currentFuelLevel) * _fuelCapacity)];
	} else {
		GVAR(fuelConsumption) set [1, (GVAR(fuelConsumption) select 1) + ((_lastFuelLevel - _currentFuelLevel) * _fuelCapacity)];
	};
	
	_vehicle setVariable [QGVAR(fuelInfo), _currentFuelLevel];	
};

nil;
