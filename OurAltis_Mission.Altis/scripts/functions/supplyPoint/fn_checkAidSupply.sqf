#include "macros.hpp"
/**
 * OurAltis_Mission - fn_checkAidSupply
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Checks if vehicle is IDAP vehicle and send a incidend to the database
 * 
 * Parameter(s):
 * 0: Trigger Object <Object>
 * 1: Side <Side>
 * 
 * Return Value:
 * None <Any>
 * 
 */
private _success = params [
	["_triggerObj", objNull, [objNull]],
	["_side", sideUnknown, [west]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _objInTrigger = list _triggerObj;
private _countIDAPArrived = _triggerObj getVariable [QGVAR(countIDAPArrived), 0];

{
	if (typeOf (vehicle _x) in VEHICLE_IDAP && !((vehicle _x) getVariable [QGVAR(arrived), false]) && _side isEqualTo side (group (vehicle _x))) then {
		(vehicle _x) setVariable [QGVAR(arrived), true];
		[_side, name (vehicle _x)] call FUNC(reportAidSupply);		
		
		[
			"IDAPSupplier",
			[
				format [localize "OurA_str_IDAPSupDescription", GVAR(targetAreaName), missionNamespace getVariable [QGVAR(countIDAPVehicle), 0]],
				localize "OurA_str_IDAPSupTitle",
				""
			]
		] call BIS_fnc_taskSetDescription;
		
		_countIDAPArrived = _countIDAPArrived + 1;
		_triggerObj setVariable [QGVAR(countIDAPArrived), _countIDAPArrived];
		
		if (_countIDAPArrived isEqualTo GVAR(countIDAPVehicle) && _countIDAPArrived != 0) then {
			["IDAPSupplier", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
			["IDAPDisturber", "FAILED"] spawn BIS_fnc_taskSetState;
			
			deleteVehicle _triggerObj;
		};
	};
	
	nil
} count _objInTrigger;

nil
