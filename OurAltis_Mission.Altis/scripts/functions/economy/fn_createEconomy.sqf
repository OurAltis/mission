<<<<<<< HEAD
#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createIndustry
=======

#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createEconomy
>>>>>>> 744a8e23c49c12145d2c5746b52021161a985128
 * 
 * Author: PhilipJFry
 * 
 * Description:
<<<<<<< HEAD
 * Creates economy buildings
 * 
 * Parameter(s):
 * 0: Position <Any>
 * 1: Type <String>
 * 2: Direction <Scalar>
=======
 * Create the economy buildings
 * 
 * Parameter(s):
>>>>>>> 744a8e23c49c12145d2c5746b52021161a985128
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
<<<<<<< HEAD
private _success = params [
	["_position", nil, [[]], [2,3]],
	["_type", "", [""]],
	["_dir", 0, [0]]
];
 
CHECK_TRUE(_success, Invalid parameters!, {})

private _objsArray = call compile preprocessFileLineNumbers (format ["scripts\compositions\%1.sqf", _type]);
_objsArray = [_position, _dir, _objsArray, [FLAGPOLE]] call FUNC(objectsMapper);

{
	_x setFlagTexture ([GVAR(defenderSide)] call FUNC(getFlagTexture));
	nil	
} count _objsArray;

_objsArray = nearestObjects [_position, ["Land_HelipadEmpty_F", "Land_HelipadCircle_F", "Land_HelipadCivil_F", "Land_HelipadRescue_F", "Land_HelipadSquare_F"], 80];

[_objsArray] call FUNC(createAmbientVehicles);

nil
=======
 nil
 
>>>>>>> 744a8e23c49c12145d2c5746b52021161a985128
