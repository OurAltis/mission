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
	["_id", nil, [""]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _objsArray = call compile preprocessfilelinenumbers "scripts\compositions\camp.sqf";
_objsArray = [_position, floor random 360, _objsArray, [FLAGPOLE]] call FUNC(objectsMapper);

{
	_x setFlagTexture ([_side] call FUNC(getFlagTexture));
	nil
} count _objsArray;

private _marker = createMarker ["marker_noCiv_" + _id, _position];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerSize [45,40];
_marker setMarkerDir _baseDir;
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 0;

GVAR(markerNoCiv) pushBack _marker;

nil
