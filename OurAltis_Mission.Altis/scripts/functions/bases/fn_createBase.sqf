#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createBase
 * 
 * Author: Raven
 * 
 * Description:
 * Creates a base at the given position
 * 
 * Parameter(s):
 * 0: Position <Position3D, Position2D>
 * 1: BaseSide <Side>
 * 2: ID <String>
 * 3: Base Type <Number>
 * 4: Base Direction [dirWest, dirEast] <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
private _success = params [
	["_position", nil, [[]], [2,3]],
	["_side", sideUnknown, [sideUnknown]],
	["_id", nil, [""]],
	["_baseType", 0, [0]],
	["_baseDir", 0, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _objsArray = call compile preprocessfilelinenumbers (format["scripts\compositions\%1.sqf", "base" + str(_baseType)]);

if (worldName isEqualTo "Tanoa") then {
	_objsArray = [_objsArray] call FUNC(adjustBuildingsToMap);
};

GVAR(flagPolesBase) = [_position, _baseDir, _objsArray, [FLAGPOLE]] call FUNC(objectsMapper);

{
	_x setFlagTexture ([_side] call FUNC(getFlagTexture));
	nil
} count GVAR(flagPolesBase);

GVAR(markerBase) = createMarker ["marker_base", _position];
GVAR(markerBase) setMarkerShape "ELLIPSE";
GVAR(markerBase) setMarkerSize [20,20];
GVAR(markerBase) setMarkerDir _baseDir;
GVAR(markerBase) setMarkerColor "ColorRed";
GVAR(markerBase) setMarkerAlpha 0;

private _marker = createMarker ["marker_noCiv_" + _id, _position];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerSize [45,40];
_marker setMarkerDir _baseDir;
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 0;

GVAR(markerNoCiv) pushBack _marker;

nil
