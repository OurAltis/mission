#include "macros.hpp"
/**
 * OurAltis_Mission - fn_selectedRoleChanged
 * 
 * Author: Raven
 * 
 * Description:
 * Gets executed whenever the role selection in the respawn screen changes
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private ["_selectedClass", "_selectedBase"];

// Don't proceed  if there is no selection
if (lbCurSel (uiNamespace getVariable QRGVAR(RespawnMenuRoleSelection)) == -1) exitWith {};

// get the current selection
with uiNamespace do {
	_selectedClass = (RGVAR(RespawnMenuRoleSelection) getVariable [
			str (lbCurSel RGVAR(RespawnMenuRoleSelection)),
			[""]
		]) select 0;
	
	CHECK_FALSE(_selectedClass isEqualTo "", Unable to obtain selected class!, {})
	
	_selectedBase = RGVAR(RespawnMenuPositionSelection) getVariable [
			str (lbCurSel RGVAR(RespawnMenuPositionSelection)),
			""
		];
		
	CHECK_FALSE(_selectedBase isEqualTo "", Unable to obtain selected position!, {})
};

[
	{		
		params [
			["_infantryList", [], [[]]],
			"_className",
			"_baseName"
		];
		
		private _reinforcements = [
					_className,
					_baseName,
					_infantryList
				 ] call FUNC(getReinforcementCount);
		
		CHECK_TRUE(_reinforcements > 0, Role with 0 reinforcements selected!)
		
		with uiNamespace do {
			// update the reinforcements display
			RGVAR(RespawnMenuReinforcements) ctrlSetText (str _reinforcements);
			RGVAR(RespawnMenuReinforcements) ctrlCommit 0;
		};
	},
	[_selectedClass, _selectedBase]
] call FUNC(workWithInfantryList);

nil;
