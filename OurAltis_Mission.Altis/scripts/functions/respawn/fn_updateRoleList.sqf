#include "macros.hpp"
/**
 * OurAltis_Mission - fn_updateRoleList
 * 
 * Author: Raven
 * 
 * Description:
 * Updates the role list for the respawn menu according to the infantry list
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
		
		// clear the list before update
		[] call FUNC(clearRespawnRoles);
		
		private ["_done", "_roleList"];
		
		_done = false;
		_roleList = [];
		
		{
			if((_x select 0) isEqualTo (side group player)) then {
				// only process the relevant side
				{
					_x params [
						["_base", "", [""]],
						["_infantryCollection", [], [[]]]
					];
					
					{
						// add the respective role to the list
						_roleList pushBack [[_base], _x select 0, {_this call FUNC(createOurAltisUnit)}];
						
						nil;
					} count _infantryCollection;
					
					nil;
				} count (_x select 1);
				
				_done = true;
			};
			
			if(_done) exitWith {
				// add all the gathered roles
				[_roleList] call FUNC(addMultipleRespawnRoles);
			};			
			nil;
		} count _infantryList;
	},
	[]
] call FUNC(workWithInfantryList);

nil;
