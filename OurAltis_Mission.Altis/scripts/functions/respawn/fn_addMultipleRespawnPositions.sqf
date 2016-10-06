#include "macros.hpp"
/**
 * OurAltis_Mission - fn_addMultipleRespawnPositions
 * 
 * Author: Raven
 * 
 * Description:
 * Adds the given list as individual respawn positions
 * 
 * Parameter(s):
 * 0: The list of positions to add (format: [[Name, Position], ...]) <Array>
 * 1: Whether to fire a change event <Boolean>
 * 
 * Return Value:
 * The respective positions IDs <Array>
 * 
 */

private ["_success", "_ids", "_fireEvent"];

_success = params [
	["_list", [], []]
];

CHECK_TRUE(_success, Invalid parameters!, {});

_ids = [];

{
	_ids pushBack ([_x select 0, _x select 1, false] call FUNC(addRespawnPosition));
	
	nil;
} count _list;


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
	// fire event that a position has been added
	[EVENT_RESPAWN_POSITIONS_CHANGED, [true]] call FUNC(fireEvent);
};


nil;
