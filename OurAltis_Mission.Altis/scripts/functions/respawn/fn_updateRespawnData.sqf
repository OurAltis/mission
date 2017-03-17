#include "macros.hpp"
/**
 * OurAltis_Mission - fn_updateRespawnData
 * 
 * Author: Raven
 * 
 * Description:
 * Updates the respawn roles and positions according to the infantry list
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
		params [
			["_infantryList", [], [[]]]
		];
		
		CHECK_FALSE(isNil "_infantryList", Nil-infantry list!, {})
		
		// clear the old data
		[] call FUNC(clearRespawnRoles);
		[] call FUNC(clearRespawnPositions);
		// clear map positions
		[] call FUNC(clearMapPositions);
		
		private _roleList = [];
		private _baseList = [];
		
		private _addedNewData = false;
		
		{
			if((_x select 0) isEqualTo (side group player)) exitWith {
				// only process the relevant side
				{
					_x params [
						["_base", "", [""]],
						["_infantryCollection", [], [[]]]
					];
					
					_baseList pushBack [_base, [_base] call FUNC(getBasePosition)];
					
					{
						// add the respective role to the list
						_roleList pushBack [[_base], _x select 0, {_this call FUNC(createOurAltisUnit)}];
						//TODO: use work with to always have up to date list
						
						nil;
					} count _infantryCollection;
					
					nil;
				} count (_x select 1);
				
				// add all the gathered bases + roles
				[_baseList] call FUNC(addMultipleRespawnPositions);
				[_roleList] call FUNC(addMultipleRespawnRoles);
				
				_addedNewData = true; // indicate that data have been added
			};
			
			nil;
		} count _infantryList;
		
		if(!_addedNewData) then {
			// fire change events manually as the add-functions haven't been called
			[EVENT_RESPAWN_POSITIONS_CHANGED, []] call FUNC(fireEvent);
			[EVENT_RESPAWN_ROLES_CHANGED, []] call FUNC(fireEvent);
		};
		
		nil;
	},
	[]
] call FUNC(workWithInfantryList);

nil;
