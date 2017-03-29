#include "macros.hpp"
/**
 * OurAltis_Mission - fn_deleteMapPosition
 * 
 * Author: Raven
 * 
 * Description:
 * Deletes the given mapPosition
 * 
 * Parameter(s):
 * 0: The mapPosition to delete <String>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_mapPos", "", [""]]
];

CHECK_TRUE(_success, Invalid mapPosition!, {})

// make sure the fra,ework is unlocked
if(MGVAR(mapPositionsAreLocked)) exitWith {WARNING_LOG(Blocked access to mapPosition framework as it is currently locked!)};


MGVAR(mapPositions) setVariable [_mapPos, nil];
MGVAR(mapPositionIDs) deleteAt (MGVAR(mapPositionIDs) find _mapPos);


nil;
