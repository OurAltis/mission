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
 * 0: The unit's localized class name <String>
 * 1: The unit's position <Position>
 * 
 * Return Value:
 * The created unit <Object>
 * 
 */

private _success = params [
	["_className", "Rifleman", [""]],
	["_position", [0,0,0], [[]], [2,3]],
	["_spawnBase", "Unknown", [""]]
];

CHECK_TRUE(_success, Invalid parameters!)

private _sidePrefix = toString [toArray str group player select 0];

private _newPlayerUnit = group player createUnit [_sidePrefix + "_Survivor_F", _position, [], 0, "NONE"];

private _internalClassName = [_className] call FUNC(getInternalClassName);

[_newPlayerUnit, _internalClassName] call FUNC(equipUnitAsClass);


// store meta data on the unit
_newPlayerUnit setVariable [CLASS_NAME_VARIABLE, _internalClassName];

if (!(_internalClassName in ["Driver", "Crew", "Pilot"])) then {
	private _classCode = [_internalClassName, side group player] call FUNC(getClassCode);
	_newPlayerUnit setVariable [CLASS_CODE_VARIABLE, _classCode, true];
};

_newPlayerUnit setVariable [SPAWN_BASE_VARIABLE, _spawnBase, true];


// add EH that fires when the unit dies
_newPlayerUnit addMPEventHandler [
	"MPKilled",
	{
		if(!isServer) exitWith {}; // execute only on server
		
		private _classCode = _this select 0 getVariable CLASS_CODE_VARIABLE;
		private _base = _this select 0 getVariable SPAWN_BASE_VARIABLE;
		
		if(_classCode >= 0) then {
			// fire event that the respectiev unit has died
			[UNIT_DIED, [clientOwner, _classCode, _base]] call FUNC(fireEvent);			
			
			// dynamic groups
			(_this select 0) setVariable [QGVAR(group), group (_this select 0)];
			diag_log (group (_this select 0));
			
			(_this select 0) setVariable [QGVAR(leader), leader (_this select 0)];	
			diag_log (leader (_this select 0));
			
			//count dead units for each side
			if (side (group (_this select 0)) isEqualTo west) then {
				GVAR(deadUnits) set [0, (GVAR(deadUnits) select 0) + 1];
			} else {
				GVAR(deadUnits) set [1, (GVAR(deadUnits) select 0) + 1];
			};
		};
		
		nil;
	}
];


// Variable assigned in init; return created unit
_newPlayerUnit;
