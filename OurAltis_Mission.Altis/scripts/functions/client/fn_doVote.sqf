#include "macros.hpp"
/**
 * OurAltis_Mission - fn_doVote
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Send player vote to server
 * 
 * Parameter(s):
 * 0: Target <OBJECT>
 * 1: Caller <OBJECT>
 + 2: Action ID <SCALAR>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
private _success = params [
	["_target", objNull, [objNull]],
	["_caller", objNull, [objNull]],
	["_actionID", -1, [0]]
];

CHECK_TRUE(_success, Invalid parameter!, {})

private _vote = missionNamespace getVariable [QGVAR(playerReady), false];

GVAR(playerReady) = !_vote;

[
	UNIT_VOTE,
	[GVAR(playerReady)],
	true
] call FUNC(fireServerEvent);

nil
