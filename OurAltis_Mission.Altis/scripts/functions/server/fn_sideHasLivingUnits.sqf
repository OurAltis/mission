#include "macros.hpp"
/**
 * OurAltis_Mission - fn_sideHasLivingUnits
 * 
 * Author: Raven
 * 
 * Description:
 * Checks whether the given side has living units. units not yet spüawned are also considered living.
 * 
 * Parameter(s):
 * 0: The side to check <Any>
 * 
 * Return Value:
 * Whether or not the given side has living units <Boolean>
 * 
 */

private _success = params[
	["_side"]
];

CHECK_TRUE(_success, invalid parameters!, {false})
CHECK_TRUE(isServer, Function has to be executed n server!, {})

private _hasAliveUnits = false;

// first check reinforcements
{
	if(_x select 1 isEqualTo _Side) exitWith {
		_hasAliveUnits = true;
	};
	
	nil;
} count GVAR(BaseList);


if(!_hasAliveUnits) then {
	// check units on field
	{
		if (side _x isEqualTo _side) exitWith {
			_hasAliveUnits = true;
		};
		
		nil;
	} count allUnits;
};

_hasAliveUnits;
