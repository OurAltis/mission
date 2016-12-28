#include "macros.hpp"
/**
 * OurAltis_Mission - fn_removeEventHandler
 * 
 * Author: Raven
 * 
 * Description:
 * Removes the event handler with the given ID
 * 
 * Parameter(s):
 * 0: The ID of the handler that should be removed <Number>
 * 
 * Return Value:
 * None <Any>
 * 
 */

params [
	["_id", nil, [0]]
];

CHECK_FALSE(isNil "_id", Invalid handler ID!, {})

private ["_found", "_handlerType", "_handlerTypeIndex"];
_found = false;

{
	// search through all EHs
	_handlerType = _x;
	_outerIndex = _forEachIndex;
	
	{
		if((_x select 1) == _id) then {
			// "remove" the respective handler
			(_handlerType select 1) set [_forEachIndex, objNull];
			
			_found = true;
		};
		
		if(_found) exitWith {_handlerTypeIndex = _outerIndex};
		
		nil;
	} forEach +(_x select 1);
	
	if(_found) exitWith {};
	
	nil;
} forEach GVAR(EventHandler);

if(_found) then {
	// do the actual removing here
	_handlerType set [1, (_handlerType select 1) - [objNull]];
	
	if(count (_handlerType select 1) == 0) then {
		// This  type does no longer exist as there are no handlers for it
		GVAR(EventHandler) set [_handlerTypeIndex, objNull];
		
		GVAR(EventHandler) = GVAR(EventHandler) - [objNull];
	};
};

nil;
