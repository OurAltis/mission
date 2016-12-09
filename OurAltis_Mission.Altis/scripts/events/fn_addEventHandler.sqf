#include "macros.hpp"
/**
 * OurAltis_Mission - fn_addEventHandler
 * 
 * Author: Raven
 * 
 * Description:
 * Adds an event handler of the respective type
 * 
 * Parameter(s):
 * 0: The type of the event this listener should correspond to <String>
 * 1: The code to run when this listener is notified <Code>
 * 
 * Return Value:
 * The EHs ID <Number>
 * 
 */

params [
	["_type", nil, [""]],
	["_code", nil, [{}]]
];

CHECK_FALSE(isNil "_type" || isNil "_code", Error during listener registration!, {})

private ["_matched", "_id"];

_matched = false;
_id = GVAR(NextID);

// increase ID counter
GVAR(NextID) = GVAR(NextID) + 1;

{
	if((_x select 0) isEqualTo _type) then {
		// if the current type is the same as the new listener's
		// add the code to the list
		_x select 1 pushBack [_code, _id];
		
		_matched = true;
	};
	
	// don't loop any further
	if(_matched) exitWith {};
	
	nil;
} count GVAR(EventHandler);

if(!_matched) then {
	// create a new type list
	GVAR(EventHandler) pushBack [_type, [[_code, _id]]];
};

_id;
