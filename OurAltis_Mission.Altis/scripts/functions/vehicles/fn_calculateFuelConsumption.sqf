#include "macros.hpp"
/**
 * OurAltis_Mission - fn_calculateFuelConsumption
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Calculates fuel consuption of givin vehicle.
 * 
 * Parameter(s):
 * None <Any>
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

diag_log ("Parameter: " + str(_this))

_args params ["_vehicle"];

if (!alive _vehicle) exitWith {[_handlerID] call CBA_fnc_removePerFrameHandler};

private _lastFuelLevel = (_vehicle getVariable [QGVAR(fuelInfo), 0]);
private _currentFuelLevel = fuel _vehicle;
 
if !(_currentFuelLevel isEqualTo _lastFuelLevel) then {
	private _fuelCapacity = getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "fuelCapacity");
	
	if (_currentFuelLevel < _lastFuelLevel) then {
		GVAR(fuelConsumption) = GVAR(fuelConsumption) + ((_lastFuelLevel - _currentFuelLevel) * _fuelCapacity);
		_vehicle setVariable [QGVAR(fuelInfo), _currentFuelLevel];	
	};
};

nil;
