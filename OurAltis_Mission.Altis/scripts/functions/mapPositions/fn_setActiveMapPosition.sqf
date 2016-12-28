#include "macros.hpp"

#define ANIMATION_TIME 0.75
/**
 * OurAltis_Mission - fn_setActiveMapPosition
 * 
 * Author: Raven
 * 
 * Description:
 * Sets the active mapPosition. Use an empty String in order to deactivate all mapPositions
 * 
 * Parameter(s):
 * 0: The mapPosition to make active <String>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _succes = params [
	["_id", "", [""]]
];

CHECK_TRUE(_succes, Invalid parameters!, {})

MGVAR(selectedMapPosition) = _id;

private _map = (findDisplay 12) displayCtrl 51;
private _mapPos = MGVAR(mapPositions) getVariable _id;

if(!isNull _map && !isNil "_mapPos") then {
	ctrlMapAnimClear _map;
	
	_map ctrlMapAnimAdd [ANIMATION_TIME, ctrlMapScale _map, _mapPos select 0];
	
	ctrlMapAnimCommit _map;
};

nil;
