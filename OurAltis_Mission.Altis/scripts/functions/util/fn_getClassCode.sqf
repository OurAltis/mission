#include "macros.hpp"
/**
 * OurAltis_Mission - fn_getClassCode
 * 
 * Author: Raven
 * 
 * Description:
 * Gets the integer code that represents the given class name on the given side
 * 
 * Parameter(s):
 * 0: The internal classname to encode <String>
 * 1: The side to encode the clasname for <Side>
 * 
 * Return Value:
 * The respective integer code <Number>
 * 
 */

private _success = params [
	["_className", "", [""]],
	["_side", sideUnknown, [sideUnknown]]
];

CHECK_TRUE(_success, Invalid parameters!, {})


private _classCode = -10; 

switch (_className) do {
	case "Rifleman" : {_classCode = 100;};
	case "MG" : {_classCode = 110;};
	case "MGAssistant" : {_classCode = 120;};
	case "AT" : {_classCode = 130;};
	case "AA" : {_classCode = 140;};
	case "Medic" : {_classCode = 150;};
	case "Marksman" : {_classCode = 160};
	case "Spotter" : {_classCode = 170;};
	case "Engineer" : {_classCode = 180;};
	case "UAV" : {_classCode = 190;};	
	default {FORMAT_LOG(Unknown internal class %1!, _className);};
};

CHECK_TRUE(_classCode > 0, Error during class code retrieval!, {})

switch(_side) do {
	case west : {_classCode = _classCode + 1};
	case east : {_classCode = _classCode + 2};
	default {FORMAT_LOG(Unexpected side %1!, str _side);};
};

_classCode;
