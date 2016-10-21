#include "macros.hpp"
/**
 * OurAltis_Mission - fn_removeMultipleRespawnPositions
 * 
 * Author: Raven
 * 
 * Description:
 * Removes the given list of respawn positions
 * 
 * Parameter(s):
 * 0: The list of IDs or names <Array>
 * 1: Whether to fire a change event(optional, default: true) <Boolean>
 * 
 * Return Value:
 * Whether or not all positions have been foudn and removed <Boolean>
 * 
 */

private ["_success", "_foundAll", "_foundNone"];

_success = params [
	["_list", [], [[]]]
];

CHECK_TRUE(_success, Invalid parameters!, {});

_foundAll = true;
_foundNone = true;

{	
	if([_x] call FUNC(removeRespawnPosition)) then {
		_foundNone = false;
	} else {
		_foundAll = false;
	};
	
	nil;
} count _list;

if(!_foundNone) then {
	[{[] call FUNC(showRolesForSelectedPosition);}] call CBA_fnc_execNextFrame;
};


_fireEvent = true;
// check if event should be fired
if(count _this > 1 && !_foundNone) then {
	_fireEvent = _this select 1;
	
	if(!(_fireEvent isEqualType false)) then {
		ERROR_LOG(Expected Boolean, but was different!);
		
		_fireEvent = true;
	};
};
// fire event if wished
if (_fireEvent && !_foundNone) then {
	// fire event that a position has been added
	[EVENT_RESPAWN_POSITIONS_CHANGED, [false]] call FUNC(fireEvent);
};


_foundAll;
