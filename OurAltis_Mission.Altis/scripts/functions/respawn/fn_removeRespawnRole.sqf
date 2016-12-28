#include "macros.hpp"
/**
 * OurAltis_Mission - fn_removeRespawnRole
 * 
 * Author: Raven
 * 
 * Description:
 * Removes the given role from the respawn menu
 * 
 * Parameter(s):
 * 0: The ID of the role to remove <Number>
 * 1: Whether a change event should get fired (optional, default: true) <Boolean>
 * 
 * Return Value:
 * Whether the role was successfully removed <Boolean>
 * 
 */

private ["_success", "_found", "_fireEvent"];

_success = params [
	["_id", -1, [0]]
];

CHECK_TRUE(_success, Invalid ID!, {});


_found = false;

{
	if((_x select 0) isEqualTo _id) then {
		RGVAR(RespawnRoles) set [_forEachIndex, objNull];
		
		_found = true;
	};
		
	if(_found) exitWith {};
} forEach RGVAR(RespawnRoles);

if(_found) then {
	// delete null objects
	RGVAR(RespawnRoles) = RGVAR(RespawnRoles) - [objNull];
};


_fireEvent = true;
// check if event should be fired
if(count _this > 1 && _found) then {
	_fireEvent = _this select 1;
	
	if(!(_fireEvent isEqualType false)) then {
		ERROR_LOG(Expected Boolean, but was different!);
		
		_fireEvent = true;
	};
};
// fire event if wished
if (_fireEvent && _found) then {
	// fire event that position has been removed
	[EVENT_RESPAWN_ROLES_CHANGED, [false]] call FUNC(fireEvent);
};


_found;
