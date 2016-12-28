#include "macros.hpp"
/**
 * OurAltis_Mission - fn_handlePlayerDeath
 * 
 * Author: Raven
 * 
 * Description:
 * Gets called when the player died
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
// this function will be called in scheduled env -> switch to unscheduled
isNil {
	// prevent auto-respawn
	setPlayerRespawnTime 99999999;
	
	if(time < 1) exitWith {[] call FUNC(showRespawnMenu); nil;};
	
	RGVAR(RespawnTime) = time + ([] call FUNC(getConfigRespawnDelay));
	
	// blend in blackscreen
	"respawnBlackScreen" cutText ["", "BLACK", 10, true];
	// fade out sound
	10 fadeSound 0;
	
	[
		{
			"respawnBlackScreen" cutFadeOut 0.001;
			
			[] call FUNC(showRespawnMenu);
		},
		[],
		10
	] call CBA_fnc_waitAndExecute;
};
