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

params [
	["_className", "Rifleman", [""]],
	["_position", [0,0,0], [[]], [2,3]]
];

//TODO: create actual unit of respective class
"B_Survivor_F" createUnit [_position, group player, "NewPlayerUnit = this;"];

[NewPlayerUnit, _className] call FUNC(equipUnitAsClass);

NewPlayerUnit setVariable [CLASS_NAME_VARIABLE, _className];

// Variable assigned in init; return created unit
NewPlayerUnit;
