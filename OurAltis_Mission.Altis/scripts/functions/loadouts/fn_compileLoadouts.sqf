#include "macros.hpp"
/**
 * OurAltis_Mission - fn_compileLoadouts
 * 
 * Author: Raven
 * 
 * Description:
 * This function will compile the loadouts for the player's side. In order to do so it needs the player object to be initialized
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

CHECK_FALSE(isNull player, Player object not yet initialized!, {})

private _sidePrefix = str (side player) + "\";

COMPILE_LOADOUT(AA);
COMPILE_LOADOUT(AT);
COMPILE_LOADOUT(CombatMedic);
COMPILE_LOADOUT(Crew);
COMPILE_LOADOUT(Driver);
COMPILE_LOADOUT(Engineer);
COMPILE_LOADOUT(Grenadier);
COMPILE_LOADOUT(LMG_AS);
COMPILE_LOADOUT(LMG);
COMPILE_LOADOUT(Pilot);
COMPILE_LOADOUT(Rifleman);
COMPILE_LOADOUT(Sniper);
COMPILE_LOADOUT(Spotter);
COMPILE_LOADOUT(Teamleader);
COMPILE_LOADOUT(UAV);

nil;
