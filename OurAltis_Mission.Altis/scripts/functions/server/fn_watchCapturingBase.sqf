#include "macros.hpp"
/**
 * OurAltis_Mission - fn_watchCapturingBase
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
	["_flagPoles", [], [[]]]
];

CHECK_TRUE(_succcess, Invalid parameters!, {})

_flagPoles = _flagPoles select 0;

_westUnits = west countSide (allUnits inAreaArray "marker_base");
_eastUnits = east countSide (allUnits inAreaArray "marker_base");
_flagPosition = flagAnimationPhase (_flagPoles select 0);

if (_westUnits > _eastUnits) then {				
	if ((flagTexture (_flagPoles select 0)) isEqualTo (toLower "A3\Data_F\Flags\Flag_CSAT_CO.paa")) then {				
		if ((flagAnimationPhase (_flagPoles select 0)) isEqualTo 0) then {
			[(_flagPoles select 0), "A3\Data_F\Flags\Flag_nato_CO.paa"] remoteExecCall ["setFlagTexture", 0];
			  ;
		} else {
			[(_flagPoles select 0), (_flagPosition - 0.002)] remoteExecCall ["setFlagAnimationPhase", 0];
		};
	} else {				
		if ((flagAnimationPhase (_flagPoles select 0)) isEqualTo 1) then {
			if (GVAR(defenderSide) isEqualTo east) then {
				[west] call FUNC(endMission);
				[GVAR(captureBaseHandlerID)] call CBA_fnc_removePerFrameHandler;
			};
		} else {
			[(_flagPoles select 0), (_flagPosition + 0.002)] remoteExecCall ["setFlagAnimationPhase", 0];
		};
	};			
};

if (_eastUnits > _westUnits) then {
	if ((flagTexture (_flagPoles select 0)) isEqualTo (toLower "A3\Data_F\Flags\Flag_CSAT_CO.paa")) then {
		if ((flagAnimationPhase (_flagPoles select 0)) isEqualTo 1) then {
			if (GVAR(defenderSide) isEqualTo west) then {
				[east] call FUNC(endMission);
				[GVAR(captureBaseHandlerID)] call CBA_fnc_removePerFrameHandler;
			};
		} else {
			[(_flagPoles select 0), (_flagPosition + 0.002)] remoteExecCall ["setFlagAnimationPhase", 0];
		};
	} else {				
		if ((flagAnimationPhase (_flagPoles select 0)) isEqualTo 0) then {
			[(_flagPoles select 0), "A3\Data_F\Flags\Flag_CSAT_CO.paa"] remoteExecCall ["setFlagTexture", 0];
		} else {
			[(_flagPoles select 0), (_flagPosition - 0.002)] remoteExecCall ["setFlagAnimationPhase", 0];
		};
	};
};

nil
