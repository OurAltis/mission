#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createOurAltisUnit
 * 
 * Author: Raven
 * 
 * Description:
 * Creates a unit of the given class. 
 * This function assumes that there is currently a valid player object!
 * 
 * Parameter(s):
 * 0: The unit's class name <String>
 * 1: The unit's position <Position>
 * 
 * Return Value:
 * The created unit <Object>
 * 
 */

diag_log "Creating unit";
diag_log ("Parameter: " + str _this);

private _success = params [
	["_className", "Rifleman", [""]],
	["_position", [0,0,0], [[]], [2,3]],
	["_spawnBase", "Unknown", [""]]
];

CHECK_TRUE(_success, Invalid parameters!)

"B_Survivor_F" createUnit [_position, group player, "NewPlayerUnit = this;"];

[NewPlayerUnit, _className] call FUNC(equipUnitAsClass);

// store meta data on the unit
NewPlayerUnit setVariable [CLASS_NAME_VARIABLE, _className];
NewPlayerUnit setVariable [SPAWN_BASE_VARIABLE, _spawnBase];

// Variable assigned in init; return created unit
NewPlayerUnit;
