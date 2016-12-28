#include "macros.hpp"
/**
 * OurAltis_Mission - fn_configureRespawnData
 * 
 * Author: Raven
 * 
 * Description:
 * Configures the respawn data (Positions and roles)
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

[
	{
		private ["_respawnPositions"];
		
		params [
			["_list", [], [[]]]
		];
		
		_respawnPositions = [];
		
		{
			if((_x select 1) isEqualTo side player) then {
				_respawnPositions pushBack [_x select 0, _x select 2];
			};
			
			nil;
		} count _list;
		
		[] call FUNC(clearRespawnPositions);
		[_respawnPositions] call FUNC(addMultipleRespawnPositions);
	},
	[]
] call FUNC(workWithBaseList);


nil;
