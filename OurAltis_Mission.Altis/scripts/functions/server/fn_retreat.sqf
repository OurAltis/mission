#include "macros.hpp"
/**
 * OurAltis_Mission - fn_retreat
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * End mission if someone decide to retreat 
 * 
 * Parameter(s):
 * 0: Side <Side>
 * 1: Client ID <Scalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
private _success = params [
	["_side", sideUnknown, [west]],
	["_clientID", -1, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

if (PGVAR(retreat)) exitWith {NOTIFICATION_LOG(Retreat already in Progress!)};

PGVAR(retreat) = true;
publicVariable QPGVAR(retreat);

[] remoteExecCall [QFUNC(deleteRetreatOption), -2];

private _winnerSide = if (_side isEqualTo west) then {east} else {west};

// end mission
[_winnerSide] call FUNC(endMission);

// check infantry retreat-mode -> ordered or unordered
[_side] call FUNC(retreatInfantry);
[_side] call FUNC(retreatVehicles);

nil
