#include "macros.hpp"
/**
 * OurAltis_Mission - fn_fireEvent
 * 
 * Author: Raven
 * 
 * Description:
 * Fires an event of the given type
 * 
 * Parameter(s):
 * 0: The event type <String>
 * 1: Parameter to hand over to the running script. 
 *    The first element must be the ID of the client calling this function <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */

params [
	["_type", nil, [""]],
	["_eventParameter", [], [[]]]
];

CHECK_FALSE(isNil "_type", Invalid eventType!, {})

DEBUG_EXEC(EVENT_LOG(fired - %1, str _type))

{
	if((_x select 0) isEqualTo _type) exitWith {
		// execute all listeners
		{
			private _thisHandler = _x select 1;
			
			_eventParameter call (_x select 0);
			
			nil;
		} count (_x select 1);
	};
} count GVAR(EventHandler);

nil;
