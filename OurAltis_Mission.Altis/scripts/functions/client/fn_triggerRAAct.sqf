#include "macros.hpp"
/**
 * OurAltis_Mission - fn_triggerRAAct
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Punish player if he leaves the restricted area
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

GVAR(inTriggerRA) = false;

"colorCorrections" ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [1, 1, 1, 0], [0.75, 0.25, 0, 1.0]];
"colorCorrections" ppEffectCommit 1;
"colorCorrections" ppEffectEnable TRUE;

[
	{
		params[
			["_args", [], [[]]],
			["_handle", -1, [0]]
		];

		private _time = _args select 0;

		if (!GVAR(inTriggerRA)) then {
			if (_time >= time) then{
				titleText [format["Go back or you will die in %1 seconds!", round(_time - time)], "PLAIN", 0.05];
			} else {
				(vehicle player) setDamage 1;
				[_handle] call CBA_fnc_removePerFrameHandler;
			};
		}else{
			[_handle] call CBA_fnc_removePerFrameHandler;
		};
	},
	0.5,
	[CBA_missionTime + 10]
] call CBA_fnc_addPerFrameHandler;

nil
