#include "macros.hpp"
/**
 * OurAltis_Mission - fn_watchForAliveUnits
 * 
 * Author: Raven
 * 
 * Description:
 * Sets up a checking framework that repeatedly checks whether there are still alive units of the given side in the mission. If 
 * 
 * Parameter(s):
 * 0: The side to check the alive units of <Side>
 * 
 * Return Value:
 * None <Any>
 * 
 */

diag_log "Starting to watch units";

private _succcess = params [
	["_side", sideUnknown, [sideUnknown]]
];

CHECK_TRUE(_succcess, Invalid parameters!, {})

diag_log ("Watched side: " + str _side);

[
	{
		! ([_this select 0] call FUNC(sideHasLivingUnits));
	},
	{
	 	private _side = _this select 0;
	 	
 		// all units of the given side are dead -> fire event
		[
			ALL_PLAYER_OF_SIDE_DEAD,
			[_side],
 			true
 		] call FUNC(fireGlobalEvent);
 			
 		nil;
	 },
 	[_side]
] call CBA_fnc_waitUntilAndExecute;

nil;
