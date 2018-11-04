#include "macros.hpp"
/**
 * OurAltis_Mission - fn_askSpy
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Reaction to caller
 * 
 * Parameter(s):
 * 0: Target  <Object>
 * 1: Caller <Object>
 * 2: ID <Scalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */
diag_log ("askSpy _this: " + str(_this));
 
private _success = params [
	["_target", objNull, [objNull]],
	["_caller", objNull, [objNull]],
	["_actionID", -1, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

_soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
_soundToPlay = _soundPath + "sounds\" + (selectRandom GVAR(spySound)) + ".ogg" ;
playSound3D [_soundToPlay, _target, false, position _target, 1, 1, 0];

[] remoteExecCall ["", QGVAR(createSpyActionJip)];
[_target, _actionID] remoteExecCall ["removeAction", -2];
[_caller] remoteExecCall [QFUNC(reactionSpy), 2];

nil
