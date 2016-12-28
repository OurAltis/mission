#include "macros.hpp"
/**
 * OurAltis_Mission - fn_hideMarkerByPrefix
 * 
 * Author: Raven
 * 
 * Description:
 * Hides all markers starting with the given prefix locally
 * 
 * Parameter(s):
 * 0: The prefix of the markers to hide <String>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_prefix", "", [""]]
];

CHECK_TRUE(_success, Invalid prefix!, {})

[_prefix, 0] call FUNC(setMarkerAlphaByPrefix);

nil;
