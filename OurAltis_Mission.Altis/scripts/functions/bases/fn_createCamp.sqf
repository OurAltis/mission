#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createCamp
 * 
 * Author: Raven
 * 
 * Description:
 * Creates a camp at the given position and adds it to the given side
 * 
 * Parameter(s):
 * 0: Position <Position3D, Position2D>
 * 1: BaseSide <Side>
 * 2: ID <String>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_position", nil, [[]], [2, 3]],
	["_side", nil, [sideUnknown]],
	["_id", nil, [""]],
	["_baseDir", 0, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _objsArray = call compile preprocessfilelinenumbers "scripts\compositions\camp.sqf";
_objsArray = [_position, _baseDir, _objsArray, [FLAGPOLE]] call FUNC(objectsMapper);

private _marker = _objsArray deleteAt ((count _objsArray) - 1);
private _size = getMarkerSize _marker;
private _markerDir = markerDir _marker;
_position = getMarkerPos _marker;

deleteMarker _marker;

[_side, _objsArray] call FUNC(setFlagTexture);

_marker = createMarker ["marker_noCiv_" + _id, _position];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerSize _size;
_marker setMarkerDir _markerDir;
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 0;

GVAR(markerNoCiv) pushBack _marker;
GVAR(markerCamps) pushBack _marker;

_marker = createMarker ["marker_camp_" + _id, _position];
_marker setMarkerShape "ICON";
_marker setMarkerType "mil_dot";
_marker setMarkerColor "ColorBlack";
_marker setMarkerText ("Camp " + _id);

nil
