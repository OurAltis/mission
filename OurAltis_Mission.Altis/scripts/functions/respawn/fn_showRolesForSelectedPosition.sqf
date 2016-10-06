#include "macros.hpp"
/**
 * OurAltis_Mission - fn_showRolesForSelectedPosition
 * 
 * Author: Raven
 * 
 * Description:
 * Displays the available roles for the currently selected base in the respawn menu
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

disableSerialization;

with uiNamespace do {
	private ["_selectionIndex", "_selectedBase", "_rolesToDisplay"];
	
	_rolesToDisplay = [];
	_selectionIndex = lbCurSel RGVAR(RespawnMenuPositionSelection);
	
	// clear role display
	lbClear RGVAR(RespawnMenuRoleSelection);
	
	
	if(_selectionIndex >= 0) then {
		_selectedBase = RGVAR(RespawnMenuPositionSelection) getVariable [str _selectionIndex, ""];
		
		{
			_x params [
				["_id", -1, [0]],
				["_bases", [], [[]]],
				["_className", "Error", [""]],
				["_createCode", {ERROR_LOG(Creation code not given!)}, [{}]]
			];
			
			if(_selectedBase in _bases || count _bases == 0) then {
				// display respective role
				private _addIndex = RGVAR(RespawnMenuRoleSelection) lbAdd _className;
				RGVAR(RespawnMenuRoleSelection) setVariable [str _addIndex, [_className, _createCode]];
			};
			
			nil;
		} count (missionNamespace getVariable [QRGVAR(RespawnRoles), []]);
	};
	
	if(lbSize RGVAR(RespawnMenuRoleSelection) > 0) then {
		// hide "no-role"-text
		RGVAR(RespawnMenuNoRoleText) ctrlEnable false;
		RGVAR(RespawnMenuNoRoleText) ctrlShow false;
		RGVAR(RespawnMenuNoRoleText) ctrlCommit 0;
		
		RGVAR(RespawnMenuRoleSelection) lbSetCurSel 0;
		
		// enable respawn button
		RGVAR(RespawnMenuRespawnButton) ctrlEnable true;
		RGVAR(RespawnMenuRespawnButton) ctrlCommit 0;
		
		// enable reinforcements display
		RGVAR(RespawnMenuReinforcements) ctrlShow true;
		RGVAR(RespawnMenuReinforcements) ctrlCommit 0;
	} else {
		// show "no-roles"-text
		RGVAR(RespawnMenuNoRoleText) ctrlEnable true;
		RGVAR(RespawnMenuNoRoleText) ctrlShow true;
		RGVAR(RespawnMenuNoRoleText) ctrlCommit 0;
		
		// disable respawn button
		RGVAR(RespawnMenuRespawnButton) ctrlEnable false;
		RGVAR(RespawnMenuRespawnButton) ctrlCommit 0;
		
		// disable reinforcements display
		RGVAR(RespawnMenuReinforcements) ctrlShow false;
		RGVAR(RespawnMenuReinforcements) ctrlCommit 0;
	};
	
	RGVAR(RespawnMenuRoleSelection) ctrlCommit 0;
};

nil;
