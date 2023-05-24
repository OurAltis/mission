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
 * Flagpol Position <Array>
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

private _flagpolPos = getPos _flagpoleObj;

private _marker = createMarkerLocal ["marker_noCiv_" + _id, _flagpolPos];
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerSizeLocal [150, 150];
//_marker setMarkerColorLocal "ColorRed";
_marker setMarkerAlphaLocal 0;

GVAR(markerNoCiv) pushBack _marker;
PGVAR(markerCamps) pushBack [_id, _flagpolPos, _marker];

_flagpolPos
