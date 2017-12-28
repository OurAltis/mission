#include "macros.hpp"
/*
	File: fn_objectMapper.sqf
	Author: Joris-Jan van 't Land modified by PhilipJFry

	Description:
	Takes an array of data about a dynamic object template and creates the objects.

	Parameter(s):
	0: position of the template - <Array> [X, Y, Z]
	1: azimuth of the template in degrees - <Number>
	2: objects for the template - <Array>
	3: classname of object which will be returned - <Array>

	Returns:
	Special objects (Array) (last element is always the marker)
*/

params [
	["_pos", [], [[]]],
	["_azi", 0, [0]],
	["_objs", [], [[]]],
	["_objClass", [], [[]]]
];

//Make sure there are definitions in the final object array
if ((count _objs) == 0) exitWith {debugLog "Log: [OurA_fnc_objectMapper] No elements in the object composition array!"; []};

private _posX = _pos select 0;
private _posY = _pos select 1;

//Function to multiply a [2, 2] matrix by a [2, 1] matrix
private _multiplyMatrixFunc = {
	private _array1 = _this select 0;
	private _array2 = _this select 1;

	private _result = [
		(((_array1 select 0) select 0) * (_array2 select 0)) + (((_array1 select 0) select 1) * (_array2 select 1)),
		(((_array1 select 1) select 0) * (_array2 select 0)) + (((_array1 select 1) select 1) * (_array2 select 1))
	];

	_result
};

//Rotate the relative position using a rotation matrix
private _rotMatrix = [
	[cos _azi, sin _azi],
	[-(sin _azi), cos _azi]
];

private _marker = "";

{
	_x params [
		["_type", "", [""]],
		["_relPos", [], [[]]],
		["_azimuth", 0, [0]],
		["_varName", "", [""]],
		["_init", "", [""]],
		["_size", [], [false, []]],
		["_isSimpleObject", false, [false]],
		["_lockState", 0, [0]],
		["_size", [], [[]]],
		["_isRectangle", false, [true]]
	];	
	
	if ((_type find "EmptyDetector") > -1) then {		
		if ((_varName find "FOB") > -1) then {
			private _count = {
				diag_log _varName;
				private _index = _varName find "FOB";
				diag_log _index;
				private _string = _varName select [_index];
				diag_log _string;
				
				if ((_x find _string) > -1) then {true} else {false};
			} count allMapMarkers;
			
			diag_log _count;
			
			_varName = (_varName select [_varName find "FOB"]) + (if (_count isEqualTo 0) then {"1"} else {str(_count + 1)}); 
		};
		
		private _newRelPos = [_rotMatrix, _relPos] call _multiplyMatrixFunc;
		
		_marker = createMarker [_varName , [_posX + (_newRelPos select 0), _posY + (_newRelPos select 1)]];
		_marker setMarkerShape (if (_isRectangle) then {"RECTANGLE"} else {"ELLIPSE"});
		_marker setMarkerSize [_size select 0, _size select 1];
		_marker setMarkerDir (_azi + _azimuth);
		_marker setMarkerColor "ColorRed";
		_marker setMarkerAlpha 0;
		
		_terrainObjects = nearestTerrainObjects [[_posX + (_newRelPos select 0), _posY + (_newRelPos select 1)], [], if ((_size select 0) >= (_size select 1)) then {_size select 0} else {_size select 1}, false, true];

		{
			if (_x inArea _marker) then {hideObjectGlobal _x};
			nil
		} count _terrainObjects;		

		_objs resize ((count _objs) - 1);		
	};
	
	nil
} count _objs;

private _cObjs = [];
private _return = [];

{		
	_x params [
		["_type", "", [""]],
		["_relPos", [], [[]]],
		["_azimuth", 0, [0]],
		["_varName", "", [""]],
		["_init", "", [""]],
		["_simulation", true, [false]],
		["_isSimpleObject", false, [false]],
		["_lockState", 0, [0]],
		["_size", [], [[]]],
		["_isRectangle", false, [true]]
	];
	
	private _newRelPos = [_rotMatrix, _relPos] call _multiplyMatrixFunc;

	//Backwards compatability causes for height to be optional
	private _z = if ((count _relPos) > 2) then {_relPos select 2} else {0};

	private _newPos = [_posX + (_newRelPos select 0), _posY + (_newRelPos select 1), _z];
	
	private _newObj = if (_isSimpleObject) then {
		createSimpleObject [_type, _newPos];
	} else {
		if (_type isKindOf "Man") then {
			private _group = createGroup civilian;
			_group createUnit [_type, _newPos, [], 0, "NONE"];
		} else {
			//_type createVehicle _newPos
			createVehicle [_type, [0,0,0], [], 0, "CAN_COLLIDE"];
		};
	};	
	
	if (_type in _objClass) then {_return pushBack _newObj};
	_cObjs pushBack _newObj;	
	_newObj allowDamage false;
	_newObj setDir (_azi + _azimuth);
	_newObj setPosATL _newPos;
	if (_newObj isKindOf "AllVehicles") then {_newObj lock _lockState};
	
	if (_init != "") then {_newObj call (compile ("this = _this; " + _init))};	
	if (!_simulation) then {_newObj enableSimulationGlobal false};	
	
	nil
} count _objs;

{
	_x allowDamage true;
} count _cObjs;

_return pushBack _marker;

_return
