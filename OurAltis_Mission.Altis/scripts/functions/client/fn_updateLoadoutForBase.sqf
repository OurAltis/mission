#include "macros.hpp"
/**
 * OurAltis_Mission - fn_updateLoadoutForBase
 * 
 * Author: Raven
 * 
 * Description:
 * Updates the available loadout for the given base
 * 
 * Parameter(s):
 * 0: The base the available loadouts should correspond to <String>
 * 
 * Return Value:
 * None <Any>
 * 
 */

params [
	["_base", nil, [""]]
];

CHECK_FALSE(isNil "_base", Invalid baseName!, {});

[
	{
		private ["_success", "_roles", "_inventoryNamespaces", "_loadoutsToAdd"];
		
		_success = params[
			["_infantryList", [], [[]]]
		];
		
		CHECK_TRUE(_success, Invalid infantryFormat!, {});
		
		// get loadouts for base
		_roles = [_base, _infantryList] call FUNC(getLoadoutsForBase);
		
		_inventoryNamespaces = [player, true, true] call BIS_fnc_getRespawnInventories;
		
		/*
		// clear all available inventories
		{
			private _currentInventoryNamespace = _inventoryNamespaces select _forEachIndex select 0;
			
			[_currentInventoryNamespace, _x] call BIS_fnc_removeRespawnInventory;
		} forEach ([player, true] call BIS_fnc_getRespawnInventories);
		*/
		
		_loadoutsToAdd = [];
		
		// add the actual loadouts
		{
			_loadoutsToAdd pushBack ((_x select 0) + "_" + str (side group player));
			
			nil;
		} count _roles;
		
		[player, _loadoutsToAdd] call BIS_fnc_setRespawnInventory;
		
		// update loadout list
		with uiNamespace do {
			[] spawn BIS_fnc_showRespawnMenuInventory;
		};
		
		nil;
	},
	[]
] call FUNC(workWithInfantryList);
