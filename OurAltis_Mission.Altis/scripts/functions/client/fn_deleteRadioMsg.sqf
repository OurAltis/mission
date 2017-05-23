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
			
			hint format ["We prepare retreat!\n I repeat, we prepare retreat!\n %1 seconds to go!", _time - time];
		},
		5,
		[time + 30, _side]
	] call CBA_fnc_addPerFrameHandler;
};

nil
