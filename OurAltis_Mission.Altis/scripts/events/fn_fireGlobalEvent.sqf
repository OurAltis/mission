#include "macros.hpp"
/**
 * OurAltis_Mission - fn_fireGlobalEvent
 * 
 * Author: Raven
 * 
 * Description:
 * Fires an event on all machines.
 * The appended ID can either be the calling client's one or one referencing all machines
 * 
 * Parameter(s):
 * 0: The event type <String>
 * 1: Parameter to hand over to the running script <Array>
 * 2: Whether to use the clients ID <Boolean> (optional)
 * 
 * Return Value:
 * None <Any>
 * 
 */

params [
	["_type", nil, [""]],
	["_parameter", [], [[]]],
	["_useClientID", false, [false]]
];

CHECK_FALSE(isNil "_type" || isNil "_useClientID", Invalid arguments!, {})

private _id = 0;
if(_useClientID) then {
	_id = clientOwner;
};

_parameter = [_id] + _parameter;

[_type, _parameter] remoteExecCall [QFUNC(fireEvent), 0];

nil;
