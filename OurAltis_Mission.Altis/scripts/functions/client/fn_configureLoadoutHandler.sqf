#include "macros.hpp"
/**
 * OurAltis_Mission - fn_configureLoadoutHandler
 * 
 * Author: Raven
 * 
 * Description:
 * Configures the event handlers for displaying the respective loadout depending on selected respawn location
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */


// EH for control on normal map
[
	{
		with uiNamespace do {
			// wait until the location list control of the respawn screen does exist
			!(BIS_RscRespawnControlsMap_ctrlLocList isEqualTo controlNull);
		};
	},
	{
		// add the handler for selection changes to the respawn location control
		with uiNamespace do {
			BIS_RscRespawnControlsMap_ctrlLocList ctrlAddEventHandler ["LBSelChanged",
				{
					params ["_list", "_index"];
					
					private _selectedBase = _list lbText _index;
					
					[_selectedBase] call FUNC(updateLoadoutForBase);
					
					nil;
				}
			];
			
			NOTIFICATION_LOG(Added EH to respawn location selection - Map);
			
			nil;
		};
		nil;
	}
] call CBA_fnc_waitUntilAndExecute;


// EH for control in spectator mode
[
	{
		with uiNamespace do {
			// wait until the location list control of the respawn screen does exist
			!(BIS_RscRespawnControlsSpectate_ctrlLocList isEqualTo controlNull);
		};
	},
	{
		// add the handler for selection changes to the respawn location control
		with uiNamespace do {
			BIS_RscRespawnControlsSpectate_ctrlLocList ctrlAddEventHandler ["LBSelChanged",
				{
					params ["_list", "_index"];
					
					private _selectedBase = _list lbText _index;
					
					[_selectedBase] call FUNC(updateLoadoutForBase);
					
					nil;
				}
			];
			
			NOTIFICATION_LOG(Added EH to respawn location selection - SpectatorMode);
			
			nil;
		};
		nil;
	}
] call CBA_fnc_waitUntilAndExecute;

nil;
