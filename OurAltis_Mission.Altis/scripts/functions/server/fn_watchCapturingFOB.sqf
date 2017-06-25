#include "macros.hpp"
/**
 * OurAltis_Mission - fn_watchCapturingFOB
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Sets up a capturing framework that repeatedly checks whether there are still alive units in the base. 
 * 
 * Parameter(s):
 * 0: Flag Poles <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _succcess = params [
	["_array", [], [[]]]
];

CHECK_TRUE(_succcess, Invalid parameters!, {})

private _handlerID = _array select 1;
private _args = _array select 0;
private _objects = _args select 0;
private	_flagpoles = _objects select 0;
private _index = _args select 1;
private _westUnits = west countSide (allUnits inAreaArray "marker_base");
private _eastUnits = east countSide (allUnits inAreaArray "marker_base");
private _flagPosition = flagAnimationPhase _flagPoles;

if (_westUnits > _eastUnits) then {				
	if ((flagTexture _flagPoles) isEqualTo (toLower "A3\Data_F\Flags\Flag_CSAT_CO.paa")) then {				
		if ((flagAnimationPhase _flagPoles) isEqualTo 0) then {
			[_flagPoles, "A3\Data_F\Flags\Flag_nato_CO.paa"] remoteExecCall ["setFlagTexture", 0];
		} else {
			[_flagPoles, (_flagPosition - 0.002)] remoteExecCall ["setFlagAnimationPhase", 0];
		};
	} else {				
		if ((flagAnimationPhase _flagPoles) isEqualTo 1) then {
			if (GVAR(defenderSide) isEqualTo east) then {
				//[west] call FUNC(endMission);				
				[_handlerID] call CBA_fnc_removePerFrameHandler;
				if !((GVAR(isFlagCaptured) select _index) isEqualTo west) then {GVAR(isFlagCaptured) set [_index, west]};
			};
		} else {
			if ((GVAR(isFlagCaptured) select _index) isEqualTo west) then {GVAR(isFlagCaptured) set [_index, east]};
			[_flagPoles, (_flagPosition + 0.002)] remoteExecCall ["setFlagAnimationPhase", 0];
		};
	};			
};

if (_eastUnits > _westUnits) then {
	if ((flagTexture _flagPoles) isEqualTo (toLower "A3\Data_F\Flags\Flag_CSAT_CO.paa")) then {
		if ((flagAnimationPhase _flagPoles) isEqualTo 1) then {
			if (GVAR(defenderSide) isEqualTo west) then {
				//[east] call FUNC(endMission);
				[_handlerID] call CBA_fnc_removePerFrameHandler;
				if !((GVAR(isFlagCaptured) select _index) isEqualTo east) then {GVAR(isFlagCaptured) set [_index, east]};
			};
		} else {
			if ((GVAR(isFlagCaptured) select _index) isEqualTo east) then {GVAR(isFlagCaptured) set [_index, west]};
			[_flagPoles, (_flagPosition + 0.002)] remoteExecCall ["setFlagAnimationPhase", 0];
		};
	} else {				
		if ((flagAnimationPhase _flagPoles) isEqualTo 0) then {
			[_flagPoles, "A3\Data_F\Flags\Flag_CSAT_CO.paa"] remoteExecCall ["setFlagTexture", 0];
		} else {
			[_flagPoles, (_flagPosition - 0.002)] remoteExecCall ["setFlagAnimationPhase", 0];
		};
	};
};

nil
