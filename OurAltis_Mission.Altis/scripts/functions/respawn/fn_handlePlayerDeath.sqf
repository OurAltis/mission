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
	setPlayerRespawnTime 99999999999;
	
	CHECK_FALSE(alive player, PlayerUnit is still alive!)	
	
	RGVAR(RespawnTime) = time + ([] call FUNC(getConfigRespawnDelay));
	
	// close map
	openMap [false, true];
	
	// blend in blackscreen
	"respawnBlackScreen" cutText ["", "BLACK", 10, true];
	// fade out sound
	FADE_OUT_TIME fadeSound 0;
	
	[
		{
			"respawnBlackScreen" cutFadeOut 0.001;
			
			[] call FUNC(showRespawnMenu);
		},
		[],
		FADE_OUT_TIME
	] call CBA_fnc_waitAndExecute;
};
