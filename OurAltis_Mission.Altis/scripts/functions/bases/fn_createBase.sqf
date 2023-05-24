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
 * Flagpol Position <Array>
 * 
 */
 
private _success = params [
	["_position", nil, [[]], [2,3]],
	["_side", sideUnknown, [sideUnknown]],
	["_id", nil, [""]],
	["_baseType", 0, [0]],
	["_baseDir", 0, [0]],
	["_baseNumber", 1, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

GVAR(baseTier) = _baseType;
private _objectArray = call compile preprocessfilelinenumbers ("scripts\compositions\" + (toLower worldName) + "\base\" + (toLower _id) + "_base_" + str(_baseNumber) + ".sqf");
private _flagpoleObj = _objectArray call FUNC(spawnComposition);
GVAR(flagPolesBase) = [GVAR(defenderSide), [_flagpoleObj]] call FUNC(setFlagTexture);

private _flagplePos = getPos _flagpoleObj;

private _marker = createMarker ["marker_noCiv_" + _id, _flagplePos];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerSize [250, 250];
_marker setMarkerDir 0;
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 1;

GVAR(markerNoCiv) pushBack _marker;

GVAR(markerBase) = createMarker ["marker_base", _flagplePos];
GVAR(markerBase) setMarkerShape "ELLIPSE";
GVAR(markerBase) setMarkerSize [300, 300];
GVAR(markerBase) setMarkerDir 0;
GVAR(markerBase) setMarkerColor "ColorRed";
GVAR(markerBase) setMarkerAlpha 0;

private _allObjs = nearestObjects [_flagplePos, ["Land_Mil_WallBig_4m_F"], 500];
private _connected = [];

{
	if (_x getVariable ["ignor", false]) then {
		_allObjs set [_forEachIndex, objNull];
	};
	
	if (_x getVariable ["connect", 0] > 0) then {
		_connected pushBack _x;
	};
} forEach _allObjs;

_allObjs = _allObjs - [objNull];

{	
	deleteVehicle (_x getVariable ["helperObj_backward", objNull]);
	deleteVehicle (_x getVariable ["helperObj_forward", objNull]);
	_x setVariable ["helperObj_backward", nil];
	_x setVariable ["helperObj_forward", nil];
	_x setVariable ["nextFence_forward", nil];	
	_x setVariable ["nextFence_backward", nil];
	_x setVariable ["moreThanOne", nil];
} forEach _allObjs;

NOTIFICATION_FORMAT_LOG(Walls (Base): , count _allObjs)

{
	[_x, true] call FUNC(setNextWall);
	[_x, false] call FUNC(setNextWall);
} forEach _allObjs;

[[_flagplePos]] call FUNC(getPolygonArray);

_flagplePos
