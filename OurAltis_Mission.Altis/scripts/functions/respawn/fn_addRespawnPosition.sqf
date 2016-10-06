#include "macros.hpp";
/**
 * OurAltis_Mission - fn_addRespawnPosition
 * 
 * Author: Raven
 * 
 * Description:
 * Adds a respawn position to the player
 * 
 * Parameter(s):
 * 0: The display name of the position <String>
 * 1: The actual position <Position>
 * 2: Whether a change event should get fired (optional, default: true) <Boolean>
 * 
 * Return Value:
 * The ID of the added position <Number>
 * 
 */

private ["_success", "_id", "_fireEvent"];

_success = params [
	["_name", "", [""]],
	["_position", "", [[]], [2,3]]
];

CHECK_TRUE(_success, Invalid arguments!, {});

_id = RGVAR(NewPositionID);

// add position
RGVAR(RespawnPositions) pushBack [_id, _name, _position];

// increase ID counter
RGVAR(NewPositionID) = RGVAR(NewPositionID) + 1;


_fireEvent = true;
// check if event should be fired
if(count _this > 2) then {
	_fireEvent = _this select 2;
	
	if(!(_fireEvent isEqualType false)) then {
		ERROR_LOG(Expected Boolean, but was different!);
		
		_fireEvent = true;
	};
};
// fire event if wished
if (_fireEvent) then {
	// fire event that a position has been added
	[EVENT_RESPAWN_POSITIONS_CHANGED, [true]] call FUNC(fireEvent);
};


_id;
