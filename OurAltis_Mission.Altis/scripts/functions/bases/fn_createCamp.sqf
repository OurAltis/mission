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
	["_baseDir", 0, [0]],
	["_baseNumber", 1, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _objectArray = call compile preprocessfilelinenumbers ("scripts\compositions\" + (toLower worldName) + "\camp\" + (toLower _id) + "_camp_" + str(_baseNumber) + ".sqf");
private _flagpoleObj = _objectArray call FUNC(spawnComposition);
GVAR(flagPolesCamp) = [[GVAR(defenderSide), false] call FUNC(getAttackerSide), [_flagpoleObj]] call FUNC(setFlagTexture);

private _marker = createMarker ["marker_noCiv_" + _id, getPos _flagpoleObj];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [150, 150];
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 1;

GVAR(markerNoCiv) pushBack _marker;
PGVAR(markerCamps) pushBack [_id, _position, _marker];

nil
