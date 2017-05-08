#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createEconomy
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Creates economy buildings
 * 
 * Parameter(s):
 * 0: Position <Any>
 * 1: Type <String>
 * 2: Direction <Scalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */ 

private _success = params [
	["_position", nil, [[]], [2,3]],
	["_type", "", [""]],
	["_dir", 0, [0]]
];
 
CHECK_TRUE(_success, Invalid parameters!, {})

private _objsArray = call compile preprocessFileLineNumbers (format ["scripts\compositions\%1.sqf", _type]);

if (_type isEqualTo "barracks") then {GVAR(destroyedBarracks) = 0};

_objsArray = [_position, _dir, _objsArray, [FLAGPOLE]] call FUNC(objectsMapper);

{
	_x setFlagTexture ([GVAR(defenderSide)] call FUNC(getFlagTexture));
	nil	
} count _objsArray;

_objsArray = nearestObjects [_position, ["Land_HelipadEmpty_F", "Land_HelipadCircle_F", "Land_HelipadCivil_F", "Land_HelipadRescue_F", "Land_HelipadSquare_F"], 80];

[_objsArray] call FUNC(createAmbientVehicles);

nil
