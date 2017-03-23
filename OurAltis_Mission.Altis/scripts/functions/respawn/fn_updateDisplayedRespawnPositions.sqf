#include "macros.hpp"
/**
 * OurAltis_Mission - fn_updateDisplayedRespawnPositions
 * 
 * Author: Raven
 * 
 * Description:
 * Updates the displayedRespawn positions according to the respective list on the client
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

with uiNamespace do {
	// get the text of the currently selected position
	private _currentSelectionText = RGVAR(RespawnMenuPositionSelection) lbText lbCurSel RGVAR(RespawnMenuPositionSelection);
	
	// clear the current list
	lbClear RGVAR(RespawnMenuPositionSelection);
	
	{
		_x params [
			["_id", -1, [0]],
			["_name", "Error", [""]],
			["_pos", [], [[]], [2,3]]
		];
		
		// add to list
		private _index = RGVAR(RespawnMenuPositionSelection) lbAdd _name;
		
		// save the id and the corresponding position to the list
		RGVAR(RespawnMenuPositionSelection) setVariable [_name + "Data", [_id, _pos]];
		// save the index with the corresponding text because lbText does only work if list has already refreshed
		RGVAR(RespawnMenuPositionSelection) setVariable [str _index, _name];
		
		nil;
	} count (missionNamespace getVariable [QRGVAR(RespawnPositions), []]);
	
	if (lbSize RGVAR(RespawnMenuPositionSelection) > 0) then {
		// enable position selection
		RGVAR(RespawnMenuPositionSelection) ctrlEnable true;
		RGVAR(RespawnMenuPositionSelection) lbSetCurSel 0;
		RGVAR(RespawnMenuPositionSelection) ctrlCommit 0;
		
		// disable no-position-text
		RGVAR(RespawnMenuNoPositionText) ctrlEnable false;
		RGVAR(RespawnMenuNoPositionText) ctrlShow false;
		RGVAR(RespawnMenuNoPositionText) ctrlCommit 0;
		
		
		// restore the previous selection if possible
		for "_i" from 0 to (lbSize RGVAR(RespawnMenuPositionSelection) - 1) do {
			if (RGVAR(RespawnMenuPositionSelection) lbText _i isEqualTo _currentSelectionText) exitWith {
				RGVAR(RespawnMenuPositionSelection) lbSetCurSel _i;
			};
		};
	} else {
		RGVAR(RespawnMenuPositionSelection) ctrlEnable false;
		RGVAR(RespawnMenuPositionSelection) ctrlCommit 0;
		
		RGVAR(RespawnMenuNoPositionText) ctrlEnable true;
		RGVAR(RespawnMenuNoPositionText) ctrlShow true;
		RGVAR(RespawnMenuNoPositionText) ctrlCommit 0;
	};
	
	RGVAR(RespawnMenuPositionSelection) ctrlCommit 0;
};

nil;
