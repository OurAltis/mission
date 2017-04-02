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

// make sure the fra,ework is unlocked
if(MGVAR(mapPositionsAreLocked)) exitWith {WARNING_LOG(Blocked access to mapPosition framework as it is currently locked!)};

{
	[_x] call FUNC(deleteMapPosition);
	
	nil;
} count +MGVAR(mapPositionIDs);


nil;
