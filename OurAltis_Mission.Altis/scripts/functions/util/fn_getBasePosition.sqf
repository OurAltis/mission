#include "macros.hpp"
/**
 * OurAltis_Mission - fn_getBasePosition
 * 
 * Author: Raven
 * 
 * Description:
 * Gets the position of the base with the given ID
 * 
 * Parameter(s):
 * 0: The base ID to search for <String>
 * 
 * Return Value:
 * The base's position ([0,0] in case the base couldn't be found) <Position>
 * 
 */

private ["_success", "_position"];

_success = params [
	["_base", "", [""]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

DEBUG_EXEC(if(PGVAR(BASES_CHANGED)) then {NOTIFICATION_LOG(Base list out of sync!)};)

_position = [0,0];

{
	_x params ["_currentBase", "", "_basePosition"];
	
	if(_currentBase isEqualTo _base) exitWith {
		_position = _basePosition;
	};
	
	nil;
} count GVAR(BaseList);


_position;
