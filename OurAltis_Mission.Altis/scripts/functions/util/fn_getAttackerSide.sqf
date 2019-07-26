#include "macros.hpp"
/**
 * OurAltis_Mission - fn_getAttackerSide
 * 
 * Author: PhilipJFry		
 * 
 * Description:
 * Gets the attacker side
 * 
 * Parameter(s):
 * 0: Side <Side>
 * 1: Side as string <Booln>
 * 
 * Return Value:
 * Side <Side/String>
 * 
 */

private _success = params [
	["_sideDefender", sideUnknown, [west]],
	["_sideAsString", false, [true]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _sideAttacker = if (_sideDefender isEqualTo west) then {east} else {west};

if (_sideAsString) then {
	_sideAttacker = str(_sideAttacker);
};

_sideAttacker
