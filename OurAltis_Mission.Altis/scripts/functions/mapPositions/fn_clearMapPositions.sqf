#include "macros.hpp"
/**
 * OurAltis_Mission - fn_clearMapPositions
 * 
 * Author: Raven
 * 
 * Description:
 * Deletes all map positions
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

{
	[_x] call FUNC(deleteMapPosition);
	
	nil;
} count MGVAR(mapPositionIDs);


nil;
