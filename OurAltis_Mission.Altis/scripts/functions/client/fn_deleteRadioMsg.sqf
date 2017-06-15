#include "macros.hpp"
/**
 * OurAltis_Mission - fn_deleteRadioMsg
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Delete retreat option
 * 
 * Parameter(s):
 * 0: Side <Side>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
private _success = params [
	["_side", sideUnknown, [west]]
];
 
CHECK_TRUE(_success, Invalid parameters!, {}) 
 
1 setRadioMsg "Null";

if (side (group player) isEqualTo _side) then {
	GVAR(retreatHandlerID) = [
		{			
			private _time = _this select 0 select 0;
			private _side = _this select 0 select 1;
			
			if (round (_time - time) >= 0) then {
				hint format [localize "OurA_str_RetreatHint", round (_time - time)];
			} else {[GVAR(retreatHandlerID)] call CBA_fnc_removePerFrameHandler};
			
			nil
		},
		5,
		[time + 30, _side]
	] call CBA_fnc_addPerFrameHandler;
};

nil
