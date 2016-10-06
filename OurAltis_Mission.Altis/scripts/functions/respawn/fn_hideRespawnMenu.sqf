#include "macros.hpp"
/**
 * OurAltis_Mission - fn_hideRespawnMenu
 * 
 * Author: Raven
 * 
 * Description:
 * Hides the respawn menu. Can only be called after OurA_fnc_showRespawnMenu has been called
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

if(RGVAR(PreCloseRespawnMenuHandlerIsPresent)) then {
	// hook up pre-menu event handler
	private _preRespawnMenu = getMissionConfigValue "respawnMenuAboutToClose";
	
	if (!((missionNamespace getVariable [_preRespawnMenu, ""]) isEqualTo "")) then {
		[] call (missionNamespace getVariable [_preRespawnMenu]);
	} else {
		[] call compile preprocessFile _preRespawnMenu;
	};
};


// hide respawn menu
with uiNamespace do {
	// disable respawn button for next respawn
	RGVAR(RespawnMenuRespawnButton) ctrlEnable false;
	RGVAR(RespawnMenuRespawnButton) ctrlCommit 0;
	
	// hide controls
	RGVAR(RespawnMenuControlsGroup) ctrlShow false;
	RGVAR(RespawnMenuControlsGroup) ctrlCommit 0;
};

// close map again
openMap [false, false];

// remove escape handler
(findDisplay 12) displayRemoveEventHandler ["KeyDown", RGVAR(RespawnMenuEscHandler)];

// remove position change handler
[RGVAR(PositionChangeHandler)] call FUNC(removeEventHandler);
// remove role change handler
[RGVAR(RoleChangeHandler)] call FUNC(removeEventHandler);


if(RGVAR(PostCloseRespawnMenuHandlerIsPresent)) then {
	// hook up pre-menu event handler
	private _postRespawnMenu = getMissionConfigValue "respawnMenuClosed";
	
	if (!((missionNamespace getVariable [_preRespawnMenu, ""]) isEqualTo "")) then {
		[] call (missionNamespace getVariable [_preRespawnMenu]);
	} else {
		[] call compile preprocessFile _preRespawnMenu;
	};
};

nil;
