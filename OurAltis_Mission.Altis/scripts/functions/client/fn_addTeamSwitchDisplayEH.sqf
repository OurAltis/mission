#include "macros.hpp"
/**
 * OurAltis_Mission - fn_addTeamSwitchDisplayEH
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Add DEH to main display and watch if teamswitch button is pressed
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

GVAR(teamSwitchDEH) = (findDisplay 46) displayAddEventHandler[
	"KeyDown",{						
		if(inputAction "TeamSwitch" > 0) then{
			if (!GVAR(TSButtonPressed)) then {
				GVAR(TSButtonPressed) = true;
				
				[
					{
						!isNull (findDisplay 60490)
					},
					{
						[
							{
								isNull (findDisplay 60490)
							},
							{
								if (alive player) then {
									//player setVariable [QGVAR(group), group player];
									diag_log "Menu Closed";
									diag_log (group player);
									//player setVariable [QGVAR(leader), if (leader player isEqualTo player) then {true} else {false}];
									diag_log "Menu Closed";
									diag_log (leader player);
								};
								
								GVAR(TSButtonPressed) = false;
							}
						] call CBA_fnc_waitUntilAndExecute;
					}
				] call CBA_fnc_waitUntilAndExecute;
			};
		};
		
		false
	}
];

nil
