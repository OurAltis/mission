#include "macros.hpp"
/**
 * OurAltis_Mission - fn_reactionSpy
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Reaction to caller
 * 
 * Parameter(s):
 * 0: Caller <Object>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
private _success = params [
	["_caller", objNull, [objNull]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _info = GVAR(spyUnit) getVariable [QGVAR(info), []];

_info params [
	["_side", "", [""]],
	["_budged", 0, [0]]
];

private _sideSpy = if {_side isEqualTo "west"} then {west} else {east};

if (side (group _caller) isEqualTo _sideSpy) then {
	private _infantryList = if ((GVAR(Infantry) select 0) isEqualTo _sideSpy) then {
		(GVAR(Infantry) select 3) call FUNC(getLoadoutsForBase);
	} else {
		(GVAR(Infantry) select 1) call FUNC(getLoadoutsForBase);
	};
	
	private _vehicleList = [];
	
	if ((GVAR(Vehicles) select 0) isEqualTo _sideSpy) then {		
		
		{
			_x params ["_id", "_vehicles"];						
			
			private _vehicleTypes = [];
			
			{
				private _index = _vehicleTypes pushBackUnique [_x];
				if (_index > -1) then {(_vehicleTypes select _index)  pushBack ({_x isEqualTo (_vehicleTypes select _index)} count _vehicles;)};
				
				nil
			} count _vehicles;		
			
			_vehicleList pushBack [_id, _vehicleTypes];
			
			nil
		} count (GVAR(vehicles) select 3);	
	} else {
		{
			_x params ["_id", "_vehicles"];
			
			private _vehicleTypes = [];			
			
			{
				private _index = _vehicleTypes pushBackUnique [_x];
				if (_index > -1) then {(_vehicleTypes select _index)  pushBack ({_x isEqualTo (_vehicleTypes select _index)} count _vehicles;)};
				
				nil
			} count _vehicles;			
			
			_vehicleList pushBack [_id, _vehicleTypes];
			
			nil
		} count (GVAR(vehicles) select 1);
	};
	
	diag_log _infantryList;
	diag_log _vehicleList;
	
	[_infantryList, _vehicleList] remoteExecCall [QFUNC(createSpyInfo), side (group _caller), true];
	//player createDiaryRecord ["Diary", ["Intel", "Enemy base is on grid <marker name='enemyBase'>161170</marker>"]]
};