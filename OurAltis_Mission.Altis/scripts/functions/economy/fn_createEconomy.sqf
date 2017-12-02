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
 * 0: Position <Array>
 * 1: Type <String>
 * 2: Direction <Scalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */ 

if( _this isEqualTo []) exitWith {}; // if there is no economy simply exit again

private _success = params [
	["_position", nil, [[]], [2,3]],
	["_type", "", [""]],
	["_dir", 0, [0]]
];
 
CHECK_TRUE(_success, Invalid parameters!, {})

private _objsArray = call compile preprocessFileLineNumbers (format ["scripts\compositions\%1.sqf", _type]);

_objsArray = [_position, _dir, _objsArray, [FLAGPOLE]] call FUNC(objectsMapper);

// remove last entry which is a marker and not an object
deleteMarker (_objsArray deleteAt (count _objsArray - 1));


[GVAR(defenderSide), _objsArray] call FUNC(setFlagTexture);

_objsArray = nearestObjects [_position, ["house"], 90];

private _count = {
	_x getVariable [IS_ECONOMY_BUILDING, false];
} count _objsArray;

[_type, _count] call FUNC(initializeEconomyVariable);

_objsArray = nearestObjects [_position, ["Land_HelipadCircle_F", "Land_HelipadCivil_F", "Land_HelipadRescue_F", "Land_HelipadSquare_F", "Land_HelipadEmpty_F"], 90];

[_objsArray] call FUNC(createAmbientVehicles);

GVAR(markerEco) = createMarker ["marker_eco", _position];
GVAR(markerEco) setMarkerShape "RECTANGLE";
GVAR(markerEco) setMarkerSize [50,50];
GVAR(markerEco) setMarkerDir _dir;
GVAR(markerEco) setMarkerColor "ColorRed";
GVAR(markerEco) setMarkerAlpha 0;

GVAR(economy) = _type;

nil
