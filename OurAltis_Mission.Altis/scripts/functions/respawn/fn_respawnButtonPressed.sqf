#include "macros.hpp"
/**
 * OurAltis_Mission - fn_respawnButtonPressed
 * 
 * Author: Raven
 * 
 * Description:
 * Gets executed whenever the respawn button is pressed.
 * This function takes care of the player's respawn according to the selected position and role in the 
 * respawn screen.
 * This function assumes that there is a selected role and position in the respawn screen!
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private ["_selectedRoleIndex", "_roleData", "_base", "_position", "_oldPlayer", "_newPlayer"];

// get needed data
_selectedRoleIndex = lbCurSel (uiNamespace getVariable QRGVAR(RespawnMenuRoleSelection)); // get selection index

CHECK_TRUE(_selectedRoleIndex >= 0, Invalid role index!, {})

// get the selected class name
_roleData = (uiNamespace getVariable QRGVAR(RespawnMenuRoleSelection)) getVariable [str _selectedRoleIndex, []];
				 
CHECK_FALSE(count _roleData != 2, Invalid role data!, {})

// get the selected base + position
with uiNamespace do {
	_base = RGVAR(RespawnMenuPositionSelection) getVariable [(str (lbCurSel RGVAR(RespawnMenuPositionSelection))), ""];
	
	CHECK_FALSE(_base isEqualTo "", Unable to get selected base, {})
	
	_position = (RGVAR(RespawnMenuPositionSelection) getVariable [
		_base + "Data",
		[-1, []] // default return value in case something goes wrong
	]) select 1; // see fn_updateDisplayedRespawnPositions.sqf for implementation details
	
	CHECK_TRUE(!isNil "_position" && count _position > 0, Unable to get respawn location!, {})
};


// check on server if respawn is valid -> local list isn't desynced
[
	EVENT_REQUEST_RESPAWN,
	EVENT_ANSWER_REQUEST_RESPAWN,
	{ // on permission
		private _roleData = _this select 0;
		private _position = _this select 1;
		private _baseName = _this select 2;
		
		// search for nearby spawn-buildings
		private _potentialSpawnBuildings = nearestObjects [_position, ["House", "Building"], 50];
		diag_log _potentialSpawnBuildings;
		private _spawnBuildings = [];
		
		{
			if (_x getVariable [SPAWN_BUILDING_INDICATOR, false]) then {
				_spawnBuildings pushBack _x;
			};
			
			nil;
		} count _potentialSpawnBuildings;
		
		diag_log _spawnBuildings;
		
		if (count _spawnBuildings > 0) then {
			private _building = selectRandom _spawnBuildings;
			
			private _prevPos = _position;
			
			SPAWN_BUILDING_TYPES params [
				["_types", [],[[]]],
				["_minMaxArray", [], [[]]]
			];
			
			private _buildingType = typeOf _building;
			
			if ((_buildingType find "ruins") > -1) then {
				private _stringArray = (typeOf _building) splitString "_";
				
				_stringArray resize (count _stringArray - 2);
				_stringArray pushBack "F";
				_buildingType = _stringArray joinString "_";			
			};
			
			private _possiblePositionsInBuilding = [];
			
			if (_buildingType in _types) then {
				private _minMaxHeight = _minMaxArray select (_types find _buildingType);
				
				if (count _minMaxHeight > 0) then {				
					{
						if ((_x select 2) > (_minMaxHeight select 0) && (_x select 2) < (_minMaxHeight select 1)) then {
							_possiblePositionsInBuilding pushBack _x;
						};
						
						nil
					} count (_building buildingPos -1);
				} else {
					_possiblePositionsInBuilding = _building buildingPos -1;
				};
				
				_position = selectRandom _possiblePositionsInBuilding;
			} else {
				if (_building getVariable [QGVAR(isFOB), false]) then {
					_position = [getPos _building select 0, getPos _building select 1, 0];
				} else {
					_position = _building buildingPos 0;
				};
			};
			// failsave if buildingPos fails at finding the respective position
			if (_position isEqualTo [0, 0, 0]) then {
				_position = _prevPos;
			};
		};
		
		
		// create unit by calling the stored creation code with the respective information
		_newPlayer = [_roleData select 0, _position, _baseName] call (_roleData select 1);
		
		CHECK_FALSE(isNil "_newPlayer", Failed at creating new player unit!, {})
		
		
		// switch the player to the new unit and kill old unit if necessary
		_oldPlayer = player;
		
		//private _group = group _oldPlayer;
		selectPlayer _newPlayer;		
		
		_newPlayer addEventHandler [
			"Fired", {
				if ((_this select 1) isEqualTo "Throw") then {
					GVAR(grenadeCount) = GVAR(grenadeCount) + 1;
				} else {
					if ((_this select 1) isEqualTo (primaryWeapon player) || (_this select 1) isEqualTo (handgunWeapon player)) then {
						GVAR(shotCount) = GVAR(shotCount) + 1;
					};
					
					if ((_this select 1) isEqualTo (secondaryWeapon player)) then {
						GVAR(rocketCount) = GVAR(rocketCount) + 1;
					};					
				};				
			}
		];
		
		_newPlayer addEventHandler ["HandleRating", {0}];
		
		private _group = _oldPlayer getVariable [QGVAR(group), grpNull];
		private _leader = _oldPlayer getVariable [QGVAR(leader), false];
				
		[_group, _leader,  _newPlayer, _oldPlayer] remoteExecCall [QFUNC(switchGroupAndLeader), 2];
				
		_oldPlayer setDamage 1; // Make sure that the old player unit is dead
		
		// workaround for created player unit because they don't get the tasks
		private _tasks = [_oldPlayer] call BIS_fnc_tasksUnit; 
		
		{
			[_x, false] call BIS_fnc_setTaskLocal;
			
			nil;
		} count _tasks;
		
		private _currentTask = [_oldPlayer] call BIS_fnc_taskCurrent;
		
		if !(_currentTask isEqualTo "") then {
			[_currentTask, false] call BIS_fnc_taskSetCurrent;
		};
		
		// create blackscreen
		"respawnBlackScreen" cutText ["", "BLACK", 0.0001, true];
		
		// remove the ammo from the player's weapon in order to prevent accidental shooting
		player setAmmo [currentWeapon player, 0];
				
		// close the respawn dialog
		[] call FUNC(hideRespawnMenu);
		
		{
			_x enableSimulation true;
			nil
		} count GVAR(triggerRA);
		
		[
			{
				// restore the sound + fade in
				5 fadeSound 1;
				"respawnBlackScreen" cutFadeOut 50000;
			},
			[],
			0.5
		
		] call CBA_fnc_waitAndExecute;
	},
	{ // on denial
		diag_log "Respawn denied!";
		hint "Respawn denied!";
		
		//TODO: open proper dialog + use server message
	},
	[_roleData, _position, _base], // parameter passed to the code
	[_base, [_roleData select 0] call FUNC(getInternalClassName)] // parameter passed to the server
] call FUNC(doWithServerPermission);

nil;
