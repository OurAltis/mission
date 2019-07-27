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
	["_position", nil, [[]], [2,3]],
	["_dir", 0, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _objsArray = call compile preprocessFileLineNumbers "scripts\compositions\supplyPoint.sqf";

_objsArray = [_position, _dir, _objsArray, []] call FUNC(objectsMapper);

private _marker = _objsArray deleteAt (count _objsArray - 1);
private _size = getMarkerSize _marker;
private _markerDir = markerDir _marker;
_position = getMarkerPos _marker;
	
deleteMarker _marker;

_marker = createMarker ["marker_sup", _position];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerSize _size;
_marker setMarkerDir _markerDir;
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 0;

private _sideAttacker = [GVAR(defenderSide), false] call FUNC(getAttackerSide);
diag_log ("createSupplyPoint: sideAttacker - " + _sideAttacker;

private _trigger = createTrigger ["EmptyDetector", _position, false];
_trigger setTriggerArea [_size select 0, _size select 1, _markerDir, true];
_trigger setTriggerActivation [str(_sideAttacker), "PRESENT", true];
_trigger setTriggerStatements [
	"this",
	"[thisTrigger, " + _sideAttacker + "] call " + QFUNC(checkAidSupply),
	""
];

_trigger setVariable [QGVAR(countIDAParrived), 0];

nil
