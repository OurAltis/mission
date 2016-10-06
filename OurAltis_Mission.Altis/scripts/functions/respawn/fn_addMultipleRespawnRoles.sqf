#include "macros.hpp"
/**
 * OurAltis_Mission - fn_addMultipleRespawnRoles
 * 
 * Author: Raven
 * 
 * Description:
 * Adds the list of roles to the respawn menu. The roles must have the same format as for fn_addRespawnRole
 * 
 * Parameter(s):
 * 0: The role list <Array>
 * 1: Whether a change event should be fired (optional, default: true) <Boolean>
 * 
 * Return Value:
 * The IDs of the added roles <Array>
 * 
 */

private ["_success", "_ids", "_fireEvent"];

_success = params [
	["_roleList", [], [[]]]
];

CHECK_TRUE(_success, Invalid roleList!, {});


_ids = [];

{
	_x params [
		["_availability", [], [[]]],
		["_name", "", [""]],
		["_equipCode", {}, [{}]]
	];
	
	_ids pushBack ([_availability, _name, _equipCode, false] call FUNC(addRespawnRole));
	
	nil;
} count _roleList;


_fireEvent = true;
// check if event should be fired
if(count _this > 1) then {
	_fireEvent = _this select 1;
	
	if(!(_fireEvent isEqualType false)) then {
		ERROR_LOG(Expected Boolean, but was different!);
		
		_fireEvent = true;
	};
};
// fire event if wished
if (_fireEvent) then {
	// fire event that a role has been added
	[EVENT_RESPAWN_ROLES_CHANGED, [true]] call FUNC(fireEvent);
};


_ids;
