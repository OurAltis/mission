/*
	File: objectGrabber.sqf
	Author: Joris-Jan van 't Land modified by PhilipJFry

	Description:
	Converts a set of placed objects to an object array for the DynO mapper.
	Places this information in the debug output for processing.

	Parameter(s):
	_this select 0: position of the anchor point (Array)
	_this select 1: size of the covered area (Scalar)
	_this select 2: grab object orientation? (Boolean) [default: false]
	
	Returns:
	Ouput text (String)
*/

private ["_anchorPos", "_anchorDim", "_grabOrientation"];
params[["_anchorPos", [0, 0], [[]]], ["_anchorDim", 50, [-1]], ["_grabOrientation", false, [false]]];

private ["_objs"];
_objs = nearestObjects [_anchorPos, ["All"], _anchorDim];

private ["_br", "_tab", "_outputText"];
_br = toString [13, 10];
_tab = toString [9];

_outputText = "/*" + _br + "Grab data:" + _br;
_outputText = _outputText + "Mission: " + (if (missionName == "") then {"Unnamed"} else {missionName}) + _br;
_outputText = _outputText + "World: " + worldName + _br;
_outputText = _outputText + "Anchor position: [" + (str (_anchorPos select 0)) + ", " + (str (_anchorPos select 1)) + "]" + _br;
_outputText = _outputText + "Area size: " + (str _anchorDim) + _br;
_outputText = _outputText + "Using orientation of objects: " + (if (_grabOrientation) then {"yes"} else {"no"}) + _br + "*/" + _br + _br;
_outputText = _outputText + "[" + _br;

{
	private ["_allDynamic"];
	_allDynamic = allMissionObjects "All";
	
	if (_x in _allDynamic) then 
	{	
		
		private ["_sim"];
		_sim = getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "simulation");
		
		if (_sim in ["soldier"]) then
		{
			_objs set [_forEachIndex, -1];
		};
	} 
	else 
	{
		_objs set [_forEachIndex, -1];
	};
} forEach _objs;

_objs = _objs - [-1];

{
	private ["_type", "_objPos", "_dX", "_dY", "_z", "_azimuth", "_orientation", "_varName", "_init", "_simulation", "_outputArray"];
	_type = typeOf _x;
	_objPos = getPosATL _x;
	_dX = (_objPos select 0) - (_anchorPos select 0);
	_dY = (_objPos select 1) - (_anchorPos select 1);
	_z = _objPos select 2;
	_azimuth = direction _x;	
	if (_grabOrientation) then {_orientation = _x call BIS_fnc_getPitchBank} else {_orientation = []};
	_varName = (_x get3DENAttribute "name") select 0;
	_init = (_x get3DENAttribute "init") select 0;	
	_simulation = (_x get3DENAttribute "enableSimulation") select 0;
	
	_outputArray = [_type, [_dX, _dY, _z], _azimuth, _orientation, _varName, _init, _simulation];
	_outputText = _outputText + _tab + (str _outputArray);
	_outputText = if (_forEachIndex < ((count _objs) - 1)) then {_outputText + ", " + _br} else {_outputText + _br};

	debugLog (format ["Log: objectGrabber: %1", _outputArray]);
} forEach _objs;

_outputText = _outputText + "]";
copyToClipboard _outputText;

_outputText