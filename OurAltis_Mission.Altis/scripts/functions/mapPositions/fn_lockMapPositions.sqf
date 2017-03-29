#include "macros.hpp"
/**
 * OurAltis_Mission - fn_lockMapPositions
 * 
 * Author: Raven
 * 
 * Description:
 * Locks or unlocks the map-positions framework. If it is locked no changes can be done to it unless it is unlocked before. The only exception to this is specificating the active mapPosition
 * 
 * Parameter(s):
 * 0: The new lock status <Boolean>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_lock", false, [false]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

MGVAR(mapPositionsAreLocked) = _lock;

nil;
