#include "macros.hpp"
/**
 * OurAltis_Mission - fn_respawnInit
 * 
 * Author: Raven
 * 
 * Description:
 * Initializes the respawn system. Can only be called if the map has already been initialized...
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

RGVAR(RespawnPositions) = [];
RGVAR(RespawnRoles) = [];
RGVAR(NewPositionID) = 0;
RGVAR(NewRoleID) = 0;

RGVAR(RespawnTime) = 0;

RGVAR(DeadGroup) = createGroup civilian;

RGVAR(PreOpenRespawnMenuHandlerIsPresent) = !(isNil {getMissionConfigValue "respawnMenuAboutToOpen"});
RGVAR(PostOpenRespawnMenuHandlerIsPresent) = !(isNil {getMissionConfigValue "respawnMenuOpened"});
RGVAR(PreCloseRespawnMenuHandlerIsPresent) = !(isNil {getMissionConfigValue "respawnMenuAboutToClose"});
RGVAR(PostCloseRespawnMenuHandlerIsPresent) = !(isNil {getMissionConfigValue "respawnMenuClosed"});

// create the respective controls
disableSerialization;

with uiNamespace do {
	private ["_mapDisplay", "_currentControl", "_tempPos"];
	
	_mapDisplay = findDisplay 12;
	
	RGVAR(RespawnMenuControlsGroup) = _mapDisplay ctrlCreate ["RscControlsGroup", 1200];
	RGVAR(RespawnMenuControlsGroup) ctrlSetPosition [0.22 * safeZoneW + safeZoneX, 0.7 * safeZoneH + safeZoneY  , 0.555 * safeZoneW, 0.29 * safeZoneH];
	RGVAR(RespawnMenuControlsGroup) ctrlCommit 0;
	
	// Background
	_currentControl = _mapDisplay ctrlCreate ["IGUIBack", 1100, RGVAR(RespawnMenuControlsGroup)];
	_tempPos = ctrlPosition RGVAR(RespawnMenuControlsGroup);
	_tempPos set [0,0];
	_tempPos set [1,0];
	_currentControl ctrlSetPosition _tempPos;
//	_currentControl ctrlSetBackgroundColor [0.08,0.168,0.137,0.3];
	_currentControl ctrlSetBackgroundColor [0,0,0,0.3];
	_currentControl ctrlCommit 0;
	
	// Reinforcements background
	_currentControl = _mapDisplay ctrlCreate ["IGUIBack", 1101, RGVAR(RespawnMenuControlsGroup)];
	_currentControl ctrlSetPosition [0.635, 0.05, 0.225, 0.085];
	_currentControl ctrlSetBackgroundColor [0,0,1,0.2];
	_currentControl ctrlCommit 0;
	
	// position selection background
	_currentControl = _mapDisplay ctrlCreate ["IGUIBack", 1107, RGVAR(RespawnMenuControlsGroup)];
	_currentControl ctrlSetPosition [0.01, 0.05, 0.3, 0.275];
	_currentControl ctrlSetBackgroundColor [0,0,0,0.2];
	_currentControl ctrlCommit 0;
	
	// Position selection
	RGVAR(RespawnMenuPositionSelection) = _mapDisplay ctrlCreate ["RscListbox", 1201, RGVAR(RespawnMenuControlsGroup)];
	RGVAR(RespawnMenuPositionSelection) ctrlSetPosition [0.01, 0.05, 0.3, 0.275];
	RGVAR(RespawnMenuPositionSelection) ctrlSetTextColor [0.7,0.4,0,1];
	RGVAR(RespawnMenuPositionSelection) ctrlSetEventHandler ["LBSelChanged", QUOTE([] call FUNC(selectedPositionChanged))];
	RGVAR(RespawnMenuPositionSelection) ctrlCommit 0;
	
	// No respawn position text
	RGVAR(RespawnMenuNoPositionText) = _mapDisplay ctrlCreate ["RscText", 1105, RGVAR(RespawnMenuControlsGroup)];
	RGVAR(RespawnMenuNoPositionText) ctrlSetText "No respawn position available";
	RGVAR(RespawnMenuNoPositionText) ctrlSetPosition [0.01, 0.1725, 0.3, 0.03];
	RGVAR(RespawnMenuNoPositionText) ctrlCommit 0;
	
	// Role selection background
	_currentControl = _mapDisplay ctrlCreate ["IGUIBack", 1106, RGVAR(RespawnMenuControlsGroup)];
	_currentControl ctrlSetPosition [0.32, 0.05, 0.3, 0.275];
	_currentControl ctrlSetBackgroundColor [0,0,0,0.2];
	_currentControl ctrlCommit 0;
	
	// Role selection
	RGVAR(RespawnMenuRoleSelection) = _mapDisplay ctrlCreate ["RscListbox", 1202, RGVAR(RespawnMenuControlsGroup)];
	RGVAR(RespawnMenuRoleSelection) ctrlSetPosition [0.32, 0.05, 0.3, 0.275];
	RGVAR(RespawnMenuRoleSelection) ctrlSetTextColor [0.607,0.729,0,1];
	RGVAR(RespawnMenuRoleSelection) ctrlSetEventHandler ["LBSelChanged", QUOTE([] call FUNC(selectedRoleChanged))];
	RGVAR(RespawnMenuRoleSelection) ctrlCommit 0;
	
	// No respawn role text
	RGVAR(RespawnMenuNoRoleText) = _mapDisplay ctrlCreate ["RscText", 1106, RGVAR(RespawnMenuControlsGroup)];
	RGVAR(RespawnMenuNoRoleText) ctrlSetText "No respawn role available";
	RGVAR(RespawnMenuNoRoleText) ctrlSetPosition [0.32, 0.1725, 0.3, 0.03];
	RGVAR(RespawnMenuNoRoleText) ctrlSetTextColor [1,1,1,0.5];
	RGVAR(RespawnMenuNoRoleText) ctrlCommit 0;
	
	//Position text
	_currentControl = _mapDisplay ctrlCreate ["RscText", 1102, RGVAR(RespawnMenuControlsGroup)];
	_currentControl ctrlSetPosition [0.01, 0.01];
	_currentControl ctrlSetText "Position:";
	_currentControl ctrlCommit 0;
	
	//Role text
	_currentControl = _mapDisplay ctrlCreate ["RscText", 1103, RGVAR(RespawnMenuControlsGroup)];
	_currentControl ctrlSetPosition [0.32, 0.01];
	_currentControl ctrlSetText "Role:";
	_currentControl ctrlCommit 0;
	
	// Reinforcements text
	_currentControl = _mapDisplay ctrlCreate ["RscText", 1104, RGVAR(RespawnMenuControlsGroup)];
	_currentControl ctrlSetText "Role-Reinforcements:";
	_currentControl ctrlSetPosition [0.64, 0.06, 0.22, 0.03];
	_currentControl ctrlSetTooltip "The available reinforcements for the currently selected role";
	_currentControl ctrlCommit 0;
	
	// Reinforcements value
	RGVAR(RespawnMenuReinforcements) = _mapDisplay ctrlCreate ["RscText", 1203, RGVAR(RespawnMenuControlsGroup)];
	RGVAR(RespawnMenuReinforcements) ctrlSetText "-1";
	RGVAR(RespawnMenuReinforcements) ctrlSetPosition [0.64, 0.095,0.22, 0.03];
	RGVAR(RespawnMenuReinforcements) ctrlSetTooltip "The available reinforcements for the currently selected role";
	RGVAR(RespawnMenuReinforcements) ctrlCommit 0;
	
	// respawn button
	RGVAR(RespawnMenuRespawnButton) = _mapDisplay ctrlCreate ["RscButton", 1204, RGVAR(RespawnMenuControlsGroup)];
	RGVAR(RespawnMenuRespawnButton) ctrlSetText "Respawn";
	RGVAR(RespawnMenuRespawnButton) ctrlSetPosition [0.635, 0.1825, 0.1125, 0.0425];
	RGVAR(RespawnMenuRespawnButton) ctrlSetScale 2;
	RGVAR(RespawnMenuRespawnButton) ctrlSetTextColor [0.93, 0.576, 0.082, 1];
	RGVAR(RespawnMenuRespawnButton) ctrlSetEventHandler ["ButtonClick", QUOTE([] call FUNC(respawnButtonPressed))];
	RGVAR(RespawnMenuRespawnButton) ctrlEnable false;
	RGVAR(RespawnMenuRespawnButton) ctrlCommit 0;
	
	// spectate button
	RGVAR(RespawnMenuSpectateButton) = _mapDisplay ctrlCreate ["RscButton", 1205, RGVAR(RespawnMenuControlsGroup)];
	RGVAR(RespawnMenuSpectateButton) ctrlSetText "Spectate";
	RGVAR(RespawnMenuSpectateButton) ctrlSetPosition [0.635, 0.2825, 0.225, 0.0425];
	RGVAR(RespawnMenuSpectateButton) ctrlSetTextColor [0,1,0,1];
	RGVAR(RespawnMenuSpectateButton) ctrlEnable false;
	RGVAR(RespawnMenuSpectateButton) ctrlSetTooltip "Not yet implemented!";
	RGVAR(RespawnMenuSpectateButton) ctrlCommit 0;
	
	
	// hide controls
	RGVAR(RespawnMenuControlsGroup) ctrlShow false;
	RGVAR(RespawnMenuControlsGroup) ctrlCommit 0;
};

nil;
