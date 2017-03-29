#include "macros.hpp"
/**
 * OurAltis_Mission - fn_showRespawnMenu
 * 
 * Author: Raven
 * 
 * Description:
 * Shows/Opens the respawn menu and invokes respective entry points if present. If the current player unit does not have a map it will receive one
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private ["_preRespawnMenu", "_postRespawnMenu"];

if(RGVAR(PreOpenRespawnMenuHandlerIsPresent)) then {
	// hook up pre-menu event handler
	private _preRespawnMenu = getMissionConfigValue "respawnMenuAboutToOpen";
	
	if (!((missionNamespace getVariable [_preRespawnMenu, ""]) isEqualTo "")) then {
		[] call (missionNamespace getVariable [_preRespawnMenu]);
	} else {
		[] call compile preprocessFile _preRespawnMenu;
	};
};

// make sure the player has a map
player linkItem "ItemMap";
// open map
openMap [true, true];

with  uiNamespace do {
	// show controls
	RGVAR(RespawnMenuControlsGroup) ctrlShow true;
	RGVAR(RespawnMenuControlsGroup) ctrlCommit 0;
};

// allow changes in the mapPositions
[false] call FUNC(lockMapPositions);

// update respawn data
[] call FUNC(updateRespawnData);

// update position display
[] call FUNC(updateDisplayedRespawnPositions);

// update role display
[] call FUNC(showRolesForSelectedPosition);

// add escape handler
RGVAR(RespawnMenuEscHandler) = (findDisplay 12) displayAddEventHandler [
									"KeyDown",
									QUOTE(if((_this select 1) isEqualTo 1) then {[] call FUNC(showPauseMenu)};)
								];
								
// add EH for closing the marker-place display when opened
RGVAR(MarkerDisplayHandler) = [
			{
				if !(isNull (findDisplay 54)) then {
					// close display as if pressed the cancel button
					(findDisplay 54) closeDisplay 2;
				};
			}
		] call CBA_fnc_addPerFrameHandler;
		
// hide user map-marker
[] call FUNC(hideUserMapMarker);
// hide own base marker
[OWN_BASE_MARKER_PREFIX] call FUNC(hideMarkerByPrefix);


// add EH for position change
RGVAR(PositionChangeHandler) = [
	EVENT_RESPAWN_POSITIONS_CHANGED,
	{
		[] call FUNC(updateDisplayedRespawnPositions);
		[] call FUNC(showRolesForSelectedPosition);
		
		// update respawn button status if the respawn time has been reached
		if ((RGVAR(RespawnTime) - time) <= 0) then {
			(uiNamespace getVariable QRGVAR(RespawnMenuRespawnButton)) ctrlEnable RGVAR(RespawnButtonEnabled);
			(uiNamespace getVariable QRGVAR(RespawnMenuRespawnButton)) ctrlCommit 0;
		};
	}
] call FUNC(addEventHandler);

// add EH for role change
RGVAR(RoleChangeHandler) = [
	EVENT_RESPAWN_ROLES_CHANGED,
	{
		[] call FUNC(showRolesForSelectedPosition);
		
		// update respawn button status if the respawn time has been reached
		if ((RGVAR(RespawnTime) - time) <= 0) then {
			(uiNamespace getVariable QRGVAR(RespawnMenuRespawnButton)) ctrlEnable RGVAR(RespawnButtonEnabled);
			(uiNamespace getVariable QRGVAR(RespawnMenuRespawnButton)) ctrlCommit 0;
		};
	}
] call FUNC(addEventHandler);


// add EH for infantry list changes
RGVAR(InfantryListChangeHandler) = [
	EVENT_INF_CHANGED,
	{
		// update the respawn data according to the new list
		[] call FUNC(updateRespawnData);
	}
] call FUNC(addEventHandler);


// add handler that checks the remaining respawn time
RGVAR(RespawnTimeChecker) = [
	{
		if ((RGVAR(RespawnTime) - time) > 0) then {
			with uiNamespace do {
				if(!(missionNamespace getVariable QRGVAR(RespawnButtonEnabled))) exitWith {
					// Make sure the button doesn't show the countdown if it can't be enabled anyway
					RGVAR(RespawnMenuRespawnButton) ctrlSetText "Respawn";
					RGVAR(RespawnMenuRespawnButton) ctrlCommit 0;
				};
				
				private _delayArray  = (str ((missionNamespace getVariable QRGVAR(RespawnTime)) - time)) splitString ".";
			 	
				if (count _delayArray < 2) then {
					// even number -> append zeros after comma
					_delayArray pushBack "000";
				} else {
					// uneven number -> make sure there are (only) 3 digits after comma
					_delayArray set [1, 
						if (count (_delayArray select 1) >= 3) then {
							// only use first 3 digits
							(_delayArray select 1) select [0, 3];
						} else {
							private _digits = (_delayArray select 1) select [0, count (_delayArray select 1)];
							
							
							for "_i" from 1 to (3 - (count (_delayArray select 1))) do {
								_digits = _digits  + "0";
							};
							
							_digits;
						}
					];
				};
				
				RGVAR(RespawnMenuRespawnButton) ctrlSetText (_delayArray joinString ".");
				RGVAR(RespawnMenuRespawnButton) ctrlCommit 0;
			};
		} else {
			with uiNamespace do {
				RGVAR(RespawnMenuRespawnButton) ctrlSetText "0";
				RGVAR(RespawnMenuRespawnButton) ctrlCommit 0;
			};
			
			// remove the time checker
			[RGVAR(RespawnTimeChecker)] call CBA_fnc_removePerFrameHandler;
			
			// reset respawn button
			[
				{
					with uiNamespace do {
						RGVAR(RespawnMenuRespawnButton) ctrlSetText "Respawn";
						RGVAR(RespawnMenuRespawnButton) ctrlEnable (
							missionNameSpace getVariable QRGVAR(RespawnButtonEnabled));
						RGVAR(RespawnMenuRespawnButton) ctrlCommit 0;
					};
				}
			] call CBA_fnc_execNextFrame;
		};
	}
] call CBA_fnc_addPerFrameHandler;



if(RGVAR(PostOpenRespawnMenuHandlerIsPresent)) then {
	// hook up post-menu event handler
	private _postRespawnMenu = getMissionConfigValue "respawnMenuOpened";
	
	if (!((missionNamespace getVariable [_postRespawnMenu, ""]) isEqualTo "")) then {
		[] call (missionNamespace getVariable [_postRespawnMenu]);
	} else {
		[] call compile preprocessFile _postRespawnMenu;
	};
};

nil;
