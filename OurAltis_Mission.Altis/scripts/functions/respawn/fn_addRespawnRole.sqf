#include "macros.hpp"
/**
 * OurAltis_Mission - fn_addRespawnRole
 * 
 * Author: Raven
 * 
 * Description:
 * Adds the respective role to the respawn menu
 * 
 * Parameter(s):
 * 0: For which bases the role should be available (-> String ID) (Empty Array means everywhere) <Array>
 * 1: The name of the role
 * 2: The code that will create a unit of this role <Code>
 * 3: Whether a change event should be fired (optional, default: true) <Boolean>
 * 
 * Return Value:
 * The ID of the added role <Number>
 * 
 */

private ["_success", "_id", "_fireEvent"];

_success = params [
	["_availability", [], [[]]],
	["_name", "", [""]],
	["_equipCode", {}, [{}]]
];

CHECK_TRUE(_success, Invalid parameter!, {});


_id = RGVAR(NewRoleID);
// add role
RGVAR(RespawnRoles) pushBack [_id, _availability, _name, _equipCode];

RGVAR(NewRoleID) = RGVAR(NewRoleID) + 1;


_fireEvent = true;
// check if event should be fired
if(count _this > 3) then {
	_fireEvent = _this select 3;
	
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


_id;
