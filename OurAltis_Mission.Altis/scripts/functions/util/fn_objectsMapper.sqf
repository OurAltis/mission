/*
	File: objectMapper.sqf
	Author: Joris-Jan van 't Land modified by PhilipJFry

	Description:
	Takes an array of data about a dynamic object template and creates the objects.

	Parameter(s):
	_this select 0: position of the template - Array [X, Y, Z]
	_this select 1: azimuth of the template in degrees - Number 
	_this select 2: objects for the template - Array

	Returns:
	Created objects (Array)
*/

private ["_pos", "_azi", "_objs", "_newObjs", "_terrainobjects"];

params[["_pos", [0, 0], [[]]], ["_azi", 0, [-1]], ["_objs", [], [[]]]];

//Make sure there are definitions in the final object array
if ((count _objs) == 0) exitWith {debugLog "Log: [BIS_fnc_objectMapper] No elements in the object composition array!"; []};

_terrainobjects = nearestTerrainObjects [_pos, [], 80];

{
	hideObjectGlobal _x;	
	nil
} count _terrainobjects; 

_newObjs = [];

private ["_posX", "_posY"];
_posX = _pos select 0;
_posY = _pos select 1;

//Function to multiply a [2, 2] matrix by a [2, 1] matrix
private ["_multiplyMatrixFunc"];
_multiplyMatrixFunc =
{
	private ["_array1", "_array2", "_result"];
	_array1 = _this select 0;
	_array2 = _this select 1;

	_result =
	[
		(((_array1 select 0) select 0) * (_array2 select 0)) + (((_array1 select 0) select 1) * (_array2 select 1)),
		(((_array1 select 1) select 0) * (_array2 select 0)) + (((_array1 select 1) select 1) * (_array2 select 1))
	];

	_result
};

{	
	private ["_newObj"];
	
	_x params [
		["_type", "", [""]],
		["_relPos", [], [[]]],
		["_azimuth", 0, [0]],
		["_orientation", [], [[]]],
		["_varName", "", [""]],
		["_init", "", []],
		["_simulation", true, [false]]
	];

	//Rotate the relative position using a rotation matrix
	private ["_rotMatrix", "_newRelPos", "_newPos"];
	_rotMatrix =
	[
		[cos _azi, sin _azi],
		[-(sin _azi), cos _azi]
	];
	_newRelPos = [_rotMatrix, _relPos] call _multiplyMatrixFunc;

	//Backwards compatability causes for height to be optional
	private ["_z"];
	if ((count _relPos) > 2) then {_z = _relPos select 2} else {_z = 0};

	_newPos = [_posX + (_newRelPos select 0), _posY + (_newRelPos select 1), _z];

	//Create the object and make sure it's in the correct location
	_newObj = _type createVehicle _newPos;	
	
	_newObj setDir (_azi + _azimuth);
	_newObj setPosATL _newPos;
		
	if (!isNil "_orientation") then 
	{
		if ((count _orientation) > 0) then 
		{
			([_newObj] + _orientation) call BIS_fnc_setPitchBank;
		};
	};
	if (!isNil "_varName") then 
	{
		if (_varName != "") then 
		{
			_newObj setVehicleVarName _varName;
			call (compile (_varName + " = _newObj;"));
		};
	};
	if (!isNil "_init") then {_newObj call (compile ("this = _this; " + _init));}; //TODO: remove defining this hotfix?
	if (!isNil "_simulation") then {_newObj enableSimulationGlobal _simulation; _newObj setVariable ["BIS_DynO_simulation", _simulation];};
	_newObjs = _newObjs + [_newObj];

	nil
} count _objs;

_newObjs