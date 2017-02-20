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

with uiNamespace do {
	private _selectionIndex = lbCurSel RGVAR(RespawnMenuPositionSelection);
	
	// get current selected role in order to restore selection afterwards
	private _selectedRoleIndex = lbCurSel RGVAR(RespawnMenuRoleSelection);
	
	for "_i" from 0 to (lbSize RGVAR(RespawnMenuRoleSelection)) do {
		// delete all previously set meta variables
		RGVAR(RespawnMenuRoleSelection) setVariable [str _i, nil];
	};
	
	
	// clear role display
	lbClear RGVAR(RespawnMenuRoleSelection);
	
	
	if(_selectionIndex >= 0) then {
		private _selectedBase = RGVAR(RespawnMenuPositionSelection) getVariable [str _selectionIndex, ""];
		
		{
			_x params [
				["_id", -1, [0]],
				["_bases", [], [[]]],
				["_classNameInternal", "Error", [""]],
				["_createCode", {ERROR_LOG(Creation code not given!)}, [{}]]
			];
			
			private _className = localize ("OurA_str_" + _classNameInternal);
			
			CHECK_FALSE(count _className == 0, Invalid class!)
			
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
		
		// indicate that respawn button should be enabled
		missionNamespace setVariable [QRGVAR(RespawnButtonEnabled), true];
		
		// restore selection
		if (_selectedRoleIndex >= lbSize RGVAR(RespawnMenuRoleSelection)) then {
			RGVAR(RespawnMenuRoleSelection) lbSetCurSel (lbSize RGVAR(RespawnMenuRoleSelection) - 1);
		} else {
			if(_selectedRoleIndex == -1) then {
				RGVAR(RespawnMenuRoleSelection) lbSetCurSel 0;
			} else {
				RGVAR(RespawnMenuRoleSelection) lbSetCurSel _selectedRoleIndex;
			};
		};
		
		// enable reinforcements display
		RGVAR(RespawnMenuReinforcements) ctrlShow true;
		RGVAR(RespawnMenuReinforcements) ctrlCommit 0;
	} else {
		// show "no-roles"-text
		RGVAR(RespawnMenuNoRoleText) ctrlEnable true;
		RGVAR(RespawnMenuNoRoleText) ctrlShow true;
		RGVAR(RespawnMenuNoRoleText) ctrlCommit 0;
		
		// indicate that respawn button should be disabled
		missionNamespace setVariable [QRGVAR(RespawnButtonEnabled), false];
		
		// disable reinforcements display
		RGVAR(RespawnMenuReinforcements) ctrlShow false;
		RGVAR(RespawnMenuReinforcements) ctrlCommit 0;
	};
	
	RGVAR(RespawnMenuRoleSelection) ctrlCommit 0;
};

nil;
