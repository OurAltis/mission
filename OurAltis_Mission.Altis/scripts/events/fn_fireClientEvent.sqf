#include "macros.hpp"
/**
 * OurAltis_Mission - fn_fireClientEvent
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
 * 2: The ID of the client the event should be fired on <Number>
 * 
 * Return Value:
 * None <Any>
 * 
 */

params [
	["_type", nil, [""]],
	["_givenParameter", [], [[]]],
	["_id", nil, [0]]
];

CHECK_FALSE(isNil "_type" || isNil "_id", Invalid arguments!, {})

private _parameter = [clientOwner];
_parameter pushBack _givenParameter;

if(clientOwner == _id) then {
	[_type, _parameter] call FUNC(fireEvent);
} else {
	[_type, _parameter] remoteExecCall [QFUNC(fireEvent), _id];
};

nil;
