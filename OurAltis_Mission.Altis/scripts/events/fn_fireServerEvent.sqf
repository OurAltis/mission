#include "macros.hpp"
/**
 * OurAltis_Mission - fn_fireServerEvent
 * 
 * Author: Raven
 * 
 * Description:
 * Fires an event on the server with the given type. 
 * The ID of the client calling this will be preappended to the list of parameters
 * 
 * Parameter(s):
 * 0: The event type <String>
 * 1: Parameter to hand over to the running script <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */

params [
	["_type", nil, [""]],
	["_parameter", [], [[]]]
];

CHECK_FALSE(isNil "_type", Invalid arguments!, {})

_parameter = [clientOwner] + _parameter;

if(isServer) then {
	[_type, _parameter] call FUNC(fireEvent);
} else {
	[_type, _parameter] remoteExecCall [QFUNC(fireEvent), 2];
};

nil;
