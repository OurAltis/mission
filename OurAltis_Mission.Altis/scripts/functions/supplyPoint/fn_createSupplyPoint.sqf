#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createSupplyPoint
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Create IDAP supply mission
 * 
 * Parameter(s):
 * 0: Position <Array>
 * 1: Direction <Scalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
if (_this isEqualTo []) exitWith {}; // if there is no supply point simply exit the function

private _success = params [
	["_supplypointPos", 0, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _objectArray = call compile preprocessfilelinenumbers ("scripts\compositions\" + (toLower worldName) + "\idapSupply\" + (toLower GVAR(targetAreaName)) + "_idapSupply_" + str(_supplypointPos) + ".sqf");
private _flagpoleObj = _objectArray call FUNC(spawnComposition);

diag_log ("supplyPoint flagpoleobj: " + str(_flagpoleObj));

_objectArray = nearestObjects [position _flagpoleObj, ["FlagSmall_F"], 100];
diag_log ("supplyPoint _objectArray: " + str(_objectArray));
[_objectArray] call FUNC(createAmbientVehicles);

_objectArray = nearestObjects [position _flagpoleObj, ["Land_RoadCone_01_F"], 100];

private _cornerArray = [];

{
	if (_x getVariable ["corner", false]) then {_cornerArray pushBack (position _x)};
} forEach _objectArray;

_cornerArray params ["_corner1", "_corner2", "_corner3", "_corner4"];

diag_log ("supplyPoint _cornerArray: " + str(_cornerArray));

private _secondTurn = [];

private _distance12 = _corner1 distance2d _corner2;
private _distance13 = _corner1 distance2d _corner3;
private _distance14 = _corner1 distance2d _corner4;
private _distance23 = _corner2 distance2d _corner3;
private _distance24 = _corner2 distance2d _corner4;
private _distance34 = _corner3 distance2d _corner4;

private _distanceArray = [
	[_distance12, _corner1, _corner2],
	[_distance13, _corner1, _corner3],
	[_distance14, _corner1, _corner4],
	[_distance23, _corner2, _corner3],
	[_distance24, _corner2, _corner4],
	[_distance34, _corner3, _corner4]
];

diag_log ("_distianceArray: " + str(_distanceArray));

_distanceArray sort false;

diag_log ("_distianceArray sorted: " + str(_distanceArray));

private _finish = [];

private _pointA = _distanceArray # 0 # 1; //(-10|10)
private _pointB = _distanceArray # 0 # 2; //(10|-10)
private _pointC = _distanceArray # 1 # 1; //(-10|-10)
private _pointD = _distanceArray # 1 # 2; //(10|10)

diag_log ("supplyPoint pA: " + str(_pointA));
diag_log ("supplyPoint pB: " + str(_pointB));
diag_log ("supplyPoint pC: " + str(_pointC));
diag_log ("supplyPoint pD: " + str(_pointD));

private _m1 = ((_pointB # 1) - (_pointA # 1)) / ((_pointB # 0) - (_pointA # 0));
private _t1 = (_pointA # 1) - (_m1 * (_pointA # 0));

diag_log ("supplyPoint m1: " + str(_m1));
diag_log ("supplyPoint t1: " + str(_t1));

private _m2 = ((_pointD # 1) - (_pointC # 1)) / ((_pointD # 0) - (_pointC # 0));
private _t2 = (_pointC # 1) - (_m2 * (_pointC # 0));

diag_log ("supplyPoint m2: " + str(_m2));
diag_log ("supplyPoint t2: " + str(_t2));

private _xS = (_t2 - _t1) / (_m1 - _m2);
private _yS = (_m1 * _xS) + _t1;

diag_log ("Abgabepunkt (M): " + str([_xS, _yS]));

private _sideAttacker = [GVAR(defenderSide), false] call FUNC(getAttackerSide);
diag_log ("createSupplyPoint: sideAttacker - " + str(_sideAttacker));

private _position = [_xS, _yS];

private _marker = createMarker ["marker_idapSupply", _position];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerSize [(_distanceArray # 4 # 0) / 2, (_distanceArray # 2 # 0) / 2];
_marker setMarkerDir ((_distanceArray # 2 # 1) getDir (_distanceArray # 2 # 2));
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 1;

_marker = createMarker ["marker_idapSupply_pointA", _pointA];
_marker setMarkerShape "ICON";
_marker setMarkerType "hd_dot_noShadow";
_marker setMarkerColor "ColorGreen";

_marker = createMarker ["marker_idapSupply_pointB", _pointB];
_marker setMarkerShape "ICON";
_marker setMarkerType "hd_dot_noShadow";
_marker setMarkerColor "ColorGreen";

_marker = createMarker ["marker_idapSupply_pointC", _pointC];
_marker setMarkerShape "ICON";
_marker setMarkerType "hd_dot_noShadow";
_marker setMarkerColor "ColorBlue";

_marker = createMarker ["marker_idapSupply_pointD", _pointD];
_marker setMarkerShape "ICON";
_marker setMarkerType "hd_dot_noShadow";
_marker setMarkerColor "ColorBlue";

_marker = createMarker ["marker_idapSupply_center", [_xS, _yS]];
_marker setMarkerShape "ICON";
_marker setMarkerType "hd_dot_noShadow";
_marker setMarkerColor "ColorYellow";

/*
private _trigger = createTrigger ["EmptyDetector", _position, false];
_trigger setTriggerArea [_size select 0, _size select 1, _markerDir, true];
_trigger setTriggerActivation [str(_sideAttacker), "PRESENT", true];
_trigger setTriggerStatements [
	"this",
	"[thisTrigger, " + str(_sideAttacker) + "] call " + QFUNC(checkAidSupply),
	""
];

_trigger setVariable [QGVAR(countIDAParrived), 0];
*/

nil
