#include "macros.hpp"
/**
 * OurAltis_Mission - fn_doWithServerPermission
 * 
 * Author: Raven
 * 
 * Description:
 * Requests server permission. If granted the given code will be executed (on the client that called this function)
 * 
 * Parameter(s):
 * 0: The request ID <String>
 * 1: The request-answer ID <String>
 * 1: The code to execute upon permission <Code>
 * 2: The code to execute upon denial <Code>
 * 3: The parameters that should be passed to either code <Array>
 * 4: The parameters that should be passed to the server for evaluation <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_request", "", [""]],
	["_answer", "", [""]],
	["_permissionCode", {}, [{}]],
	["_denialCode", {}, [{}]],
	["_codeParameter", [], [[]]],
	["_serverParameter", [], [[]]]
];

CHECK_TRUE(_success, Invalid parameters!, {});

[
	2,
	_request,
	_answer,
	{
		diag_log "Executed server permission code";
		
		params [
			["_serverParams", nil, [[]]],
			["_parameter", nil, [[]]],
			["_permissionCode", nil, [{}]],
			["_denialCode", nil, [{}]]
		];
		
		CHECK_FALSE(isNil "_serverParams" || isNil "_parameter" || isNil "_permissionCode" || isNil "_denialCode", Failed at retrieving parameter!, {})
		
		_serverParams params [
			["_granted", false, [false]],
			["_additionalParams", [], [[]]]
		];
		
		// execute respective piece of code
		if(_granted) then {
			_parameter call _permissionCode;
		} else {
			//TODO: add additional parameter
			_parameter call _denialCode;
		};
	},
	[_codeParameter, _permissionCode, _denialCode],
	_serverParameter
] call FUNC(workWithRequest);
