#include "macros.hpp"
/**
 * OurAltis_Mission - fn_removeMultipleRespawnRoles
 * 
 * Author: Raven
 * 
 * Description:
 * Removes the given list of roles from the respawn menu
 * 
 * Parameter(s):
 * 0: The list of IDs of the roles to remove <Array>
 * 1: Whether a change event should be fired <Boolean>
 * 
 * Return Value:
 * Whether all roles have been removed successfully <Boolean>
 * 
 */

private ["_success", "_foundNone", "_foundAll"];

_success = params [
	["_idList", [], [[]]]
];

CHECK_TRUE(_success, Invaild IdList!, {});


_foundNone = true;
_foundAll = true;

{
	if ([_x, false] call FUNC(removeRespawnRole)) then {
		_foundNone = false;
	} else {
		_foundAll = false;
	};
	
	nil;
} count _idList;


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
	// fire event that position has been removed
	[EVENT_RESPAWN_ROLES_CHANGED, [false]] call FUNC(fireEvent);
};


_foundAll;
