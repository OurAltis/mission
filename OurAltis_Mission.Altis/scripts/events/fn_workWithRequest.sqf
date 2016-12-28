#include "macros.hpp"
/**
 * OurAltis_Mission - fn_workWithRequest
 * 
 * Author: Raven
 * 
 * Description:
 * Sends a request to the given ID and executed given code upon receiving the data
 * 
 * Parameter(s):
 * 0: The ID of the machine to request from <Number>
 * 1: The ID of the request-event <String>
 * 2: The ID of the receive-event <String>
 * 3: The code to execute upon receiving <Code>
 * 4: The additional parameter for the code <Array>
 * 5: The additional parameter that should be passed to the machine answering the request <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private ["_default", "_handlerID"];

_default = params [
	["_machine", nil, [0]],
	["_requestID", nil, [""]],
	["_receiveID", nil, [""]],
	["_code", {}, [{}]],
	["_originalParameter", [], [[]]],
	["_parameterToPass", [], [[]]]
];

CHECK_TRUE(_default, Invalid parameters!, {});

[
	_receiveID,
	{		
		// read out passed data
		private _hasParameter = _thisParameter select 0;
		private _parameterToAdd = _thisParameter select 1;
		private _code = _thisParameter select 2;
		
		params [
			"",
			["_data", [], [[]]]
		];
		
		private _parameter = [];
		
		// assemble parameters
		if(!_hasParameter) then {
			_parameter = [_data];
		} else {
			_parameter = [_data] + _parameterToAdd;
		};
		
		// executethe respective code
		_parameter call _code;
		
		// remove this handler as it now has been executed
		[_thisHandler] call FUNC(removeEventHandler);
		
		nil;
	},
	[_default, _originalParameter, _code]
] call FUNC(addEventHandler);

[_requestID, _parameterToPass, _machine] call FUNC(fireClientEvent);

nil;
