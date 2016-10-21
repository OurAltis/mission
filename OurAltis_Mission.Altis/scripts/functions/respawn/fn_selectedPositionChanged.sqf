#include "macros.hpp"
/**
 * OurAltis_Mission - fn_selectedPositionChanged
 * 
 * Author: Raven
 * 
 * Description:
 * Gets called whenever the position selection in the respawn menu has changed
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

[] call FUNC(showRolesForSelectedPosition);

[
	{
		// make respective mapPosition active
		private _id = "";
		
		with uiNamespace do {
			_id =  RGVAR(RespawnMenuPositionSelection) lbText (lbCurSel RGVAR(RespawnMenuPositionSelection));
		};
		
		[_id] call FUNC(setActiveMapPosition);
		
		nil;
	}
] call CBA_fnc_execNextFrame;
//TODO: map animation

nil;
