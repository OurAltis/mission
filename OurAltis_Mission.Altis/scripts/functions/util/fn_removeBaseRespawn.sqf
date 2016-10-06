#include "macros.hpp"
/**
 * OurAltis_Mission - fn_removeBaseRespawn
 * 
 * Author: Raven
 * 
 * Description:
 * Removes the given base from the available respawn positions
 * 
 * Parameter(s):
 * 0: The ID of the base that should be removed as a respawn <String>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private ["_success", "_removalFunction"];

_success = params [
	["_baseID", "", [""]]
];

CHECK_TRUE(_success, Invalid baseID!, {});

// function for actual removal
_removalFunction = {
	private _exit = false;
	
	// remove respawn position
	{
		if((_x select 0) isEqualTo _baseID) then {
			private _respawnID = _x select 1;
			
			_respawnID call BIS_fnc_removeRespawnPosition;
			
			_exit = true;
		};
		
		if(_exit) exitWith {};
		
		nil;
	} count GVAR(RespawnLocations);
	
	_exit = false;
	
	// remove the base from the list (in case of JIP)
	{
		if((_x select 0) isEqualTo _baseID) then {
			GVAR(BaseList) set [_forEachIndex, objNull];
			_exit = true;
		};
		
		if(_exit) exitWith {};
	} forEach GVAR(BaseList);
	
	GVAR(BaseList) = GVAR(BaseList) - [objNull];
	
	nil;
};

if(isServer) then {
	[] call _removalFunction;
} else {
	[_baseID] remoteExecCall [QFUNC(removeBaseRespawn), 2];
};
