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
		
		// create unit by calling the stored creation code with the respective information
		_newPlayer = [_roleData select 0, _position, _baseName] call (_roleData select 1);
		
		CHECK_FALSE(isNil "_newPlayer", Failed at creating new player unit!, {})
		
		
		// switch the player to the new unit and kill old unit if necessary
		_oldPlayer = player;
		
		selectPlayer _newPlayer;
		
		[_oldPlayer] joinSilent RGVAR(DeadGroup); // remove dead unit from player's group
		_oldPlayer setDammage 1; // Make sure that the old player unit is dead
		
		
		//clear mapPositions
		[] call FUNC(clearMapPositions);
		
		
		// create blackscreen
		"respawnBlackScreen" cutText ["", "BLACK", 0.0001, true];
		
		// remove the ammo from the player's weapon in order to prevent accidental shooting
		player setAmmo [currentWeapon player, 0];
		
		// close the respawn dialog
		[] call FUNC(hideRespawnMenu);
		
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
