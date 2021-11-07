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
	["_baseDir", 0, [0]],
	["_baseNumber", 1, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

if (worldName isEqualTo "Altis") then {
	GVAR(baseTier) = _baseType;
	private _objectArray = call compile preprocessfilelinenumbers ("scripts\compositions\" + (toLower worldName) + "\" + (toLower _id) + "_base_" + str(_baseNumber) + ".sqf");
	private _flagpoleObj = _objectArray call FUNC(spawnComposition);
	GVAR(flagPolesBase) = [GVAR(defenderSide), [_flagpoleObj]] call FUNC(setFlagTexture);
	
	private _marker = createMarker ["marker_noCiv_" + _id, getPos _flagpoleObj];
	_marker setMarkerShape "RECTANGLE";
	_marker setMarkerSize [250, 250];
	_marker setMarkerDir 0;
	_marker setMarkerColor "ColorRed";
	_marker setMarkerAlpha 0;

	GVAR(markerNoCiv) pushBack _marker;

	GVAR(markerBase) = createMarker ["marker_base", getPos _flagpoleObj];
	GVAR(markerBase) setMarkerShape "ELLIPSE";
	GVAR(markerBase) setMarkerSize [20,20];
	GVAR(markerBase) setMarkerDir 0;
	GVAR(markerBase) setMarkerColor "ColorRed";
	//GVAR(markerBase) setMarkerAlpha 0;
	
	private _allObjs = nearestObjects [_position, ["Land_Mil_WallBig_4m_F"], 500];
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

	private _count = count _allObjs;
	systemchat ("WALL COUNT: " + str(_count));
	diag_log ("WALL COUNT: " + str(_count));

	{
		[_x, true] call FUNC(setNextWall);
		[_x, false] call FUNC(setNextWall);
	} forEach _allObjs;
	
	diag_log ("fn_createBase: entry fn_getPolygonArray");
	[[_position]] call FUNC(getPolygonArray);
	diag_log ("fn_createBase: exit fn_getPolygonArray");
} else {
	private _objsArray = call compile preprocessfilelinenumbers (format["scripts\compositions\%1.sqf", "base" + str(_baseType)]);

	if (worldName isEqualTo "Tanoa") then {
		_objsArray = [_objsArray] call FUNC(adjustBuildingsToMap);
	};

	_objsArray = [_position, _baseDir, _objsArray, [FLAGPOLE]] call FUNC(objectsMapper);

	private _marker = _objsArray deleteAt ((count _objsArray) - 1);
	private _size = getMarkerSize _marker;
	private _markerDir = markerDir _marker;
	_position = getMarkerPos _marker;

	deleteMarker _marker;

	GVAR(flagPolesBase) = [GVAR(defenderSide), _objsArray] call FUNC(setFlagTexture);

	_marker = createMarker ["marker_noCiv_" + _id, _position];
	_marker setMarkerShape "RECTANGLE";
	_marker setMarkerSize _size;
	_marker setMarkerDir _markerDir;
	_marker setMarkerColor "ColorRed";
	_marker setMarkerAlpha 0;

	GVAR(markerNoCiv) pushBack _marker;

	GVAR(markerBase) = createMarker ["marker_base", _position];
	GVAR(markerBase) setMarkerShape "ELLIPSE";
	GVAR(markerBase) setMarkerSize [20,20];
	GVAR(markerBase) setMarkerDir _baseDir;
	GVAR(markerBase) setMarkerColor "ColorRed";
	//GVAR(markerBase) setMarkerAlpha 0;
};

nil
