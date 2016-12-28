#include "macros.hpp"
/**
 * OurAltis_Mission - fn_calculateBaseMarkerOffset
 * 
 * Author: Raven
 * 
 * Description:
 * Calculates the offset of the base markers and broadcasts them
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

GVAR(BaseMarkerOffset) = [];

{
	private ["_offset", "_dir", "_markerOffset", "_x", "_y"];
	
	// calculate how far the offset is
	_length = floor random GVAR(MarkerAccuracy);
	
	if((random 2) > 1) then {
		// negate the length by random
		_length = -_length;
	};
	
	GVAR(BaseMarkerOffset) pushBack ([_length] call FUNC(calculateOffset));
	
	nil;
} count GVAR(BaseList);

publicVariable QGVAR(BaseMarkerOffset);

nil;
