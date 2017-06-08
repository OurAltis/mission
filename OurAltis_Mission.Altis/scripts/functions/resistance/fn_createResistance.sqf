#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createResistent
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Creates a group of resistent soldier
 * 
 * Parameter(s):
 * 0: Side <String>
 * 
 * Return Value:
 * None <Any>
 * 
 */ 
 
private _success = params [
	["_sideString", "", [""]]
];
 
CHECK_TRUE(_success, Invalid parameters!, {})

private _groupArray = (configFile >> "CfgGroups" >> "Indep" >> "IND_C_F" >> "Infantry") call BIS_fnc_getCfgSubClasses;
diag_log _groupArray;
private _side = if (_sideString isEqualTo "west") then {west} else {east};
private _isFriendly = [resistance, _side] call BIS_fnc_sideIsFriendly;

diag_log _isFriendly;

if (_isFriendly) then {
	resistance setFriend [_side, 0];
	resistance setFriend [east, 1];
};

diag_log _isFriendly;

private _positionBase = {
	_x param [_id, _side, _position, _isCamp];
	if (!_isCamp) exitWith {_position};
} count GVAR(BaseList);

diag_log _positionBase;

{
	_x param [_id, _side, _position, _isCamp];
	
	if (_isCamp) then {
		private _mPos = [((_position select 0) + (_positionBase select 0)) / 2, ((_position select 1) + (_positionBase select 1)) / 2];
		
		diag_log _mPos;
		
		private _marker = createMarker ["marker_resistance_" + str(_forEachIndex), _mPos];
		_marker setMarkerShape "RECTANGLE";
		_marker setMarkerSize [200, (_positionBase distance2D _position) - 300];
		_marker setMarkerColor "ColorRed";		
		_marker setMarkerDir (_positionBase getDir _position);
		
		private _group = [getMarkerPos _marker, independent, selectRandom _groupArray] call BIS_fnc_spawnGroup;
		diag_log _group;
		
		[_group, _marker] call CBA_fnc_taskSearchArea;
	};
} forEach GVAR(BaseList);

nil
