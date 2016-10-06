#include "macros.hpp"
/**
 * OurAltis_Mission - fn_removeRespawnPosition
 * 
 * Author: Raven
 * 
 * Description:
 * Removes the given respawn position
 * 
 * Parameter(s):
 * 0: The ID or the name of the position to remove (names work with first-matched) <Number, String>
 * 1: Whether a change event should be fired (optional, default: true) <Boolean>
 * 
 * Return Value:
 * Whether the position has been successfully removed <Boolean>
 * 
 */

private ["_success", "_searchIndex", "_found", "_fireEvent"];

_success = params [
	["_id", -1, [0, ""]]
];

CHECK_TRUE(_success, Invalid ID!, {});

if (typeName _id isEqualTo typeName 0) then {
	// remove via ID	
	_searchIndex = 0;
} else {
	// remove via name
	_searchIndex = 1;
};

_found = false;

{
	if ((_x select _searchIndex) isEqualTo _id) then {
		RGVAR(RespawnPositions) set [_forEachIndex, objNull];
		_found = true;
	};
	
	if (_found || if (_searchIndex == 0) then {(_x select _searchIndex) > _id} else {false}) exitWith {}; // prevent unnecessary iterations
} forEach RGVAR(RespawnPositions);


if (_found) then {
	RGVAR(RespawnPositions) = RGVAR(RespawnPositions) - [objNull];
};


_fireEvent = true;
// check if event should be fired
if(count _this > 1 && _found) then {
	_fireEvent = _this select 2;
	
	if(!(_fireEvent isEqualType false)) then {
		ERROR_LOG(Expected Boolean, but was different!);
		
		_fireEvent = true;
	};
};
// fire event if wished
if (_fireEvent && _found) then {
	// fire event that position has been removed
	[EVENT_RESPAWN_POSITIONS_CHANGED, [false]] call FUNC(fireEvent);
};


_found;
