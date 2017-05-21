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

diag_log _this;

private _objsArray = call compile preprocessFileLineNumbers (format ["scripts\compositions\%1.sqf", _type]);

diag_log _objsArray;

_objsArray = [_position, _dir, _objsArray, [FLAGPOLE]] call FUNC(objectsMapper);

diag_log _objsArray;

{
	_x setFlagTexture ([GVAR(defenderSide)] call FUNC(getFlagTexture));
	nil	
} count _objsArray;

_objsArray = nearestObjects [_position, ["house"], 90];

diag_log _objsArray;

private _count = {
	_x getVariable [IS_ECONOMY_BUILDING, false];
} count _objsArray;

diag_log _count;

[_type, _count] call FUNC(initializeEconomyVariable);

_objsArray = nearestObjects [_position, ["Land_HelipadCircle_F", "Land_HelipadCivil_F", "Land_HelipadRescue_F", "Land_HelipadSquare_F", "Land_HelipadEmpty_F"], 90];

diag_log _objsArray;

[_objsArray] call FUNC(createAmbientVehicles);

GVAR(markerEco) = createMarker ["marker_eco", _position];
GVAR(markerEco) setMarkerShape "RECTANGLE";
GVAR(markerEco) setMarkerSize [50,50];
GVAR(markerEco) setMarkerDir _dir;
GVAR(markerEco) setMarkerColor "ColorRed";

nil
