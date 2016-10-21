#include "macros.hpp"
/**
 * OurAltis_Mission - fn_setMarkerAlphaByPrefix
 * 
 * Author: Raven
 * 
 * Description:
 * Sets the local alpha of the markers starting with the given prefix to the given value
 * 
 * Parameter(s):
 * 0: The prefix of the markers to hide <String>
 * 1: The new alpha value <Number>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_prefix", "", [""]],
	["_alpha", 1, [0]]
];

CHECK_TRUE(_success, Invalid parameter!, {})

{
	private _currentPrefix = toArray _x;
	_currentPrefix resize (count _prefix);
	
	if(toString _currentPrefix isEqualTo _prefix) then {
		_x setMarkerAlphaLocal _alpha;
	};
	
	nil;
} count allMapMarkers;

nil;
