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

private _groupUnitsArray = [];

{
	if (_x isKindOf "I_C_Soldier_base_F" && (_x find "_unarmed_") isEqualTo -1 && (_x find "I_C_Soldier_base_F") isEqualTo -1) then {
		_groupUnitsArray pushBack _x;
	};
	nil
} count ((configFile >> "CfgVehicles") call BIS_fnc_getCfgSubClasses);

private _side = if (_sideString isEqualTo "west") then {west} else {east};
private _isFriendly = [resistance, _side] call BIS_fnc_sideIsFriendly;

if (!_isFriendly) then {
	resistance setFriend [_side, 1];
	resistance setFriend [west, 0];
};

private _positionBase = {
	_x params ["_id", "_side", "_position", "_spawn"];
	if (_spawn isEqualTo "base") exitWith {_position};
} count GVAR(BaseList);

private _camps = [];
private _campID = "";

{
	_x params ["_id", "_side", "_position", "_spawn"];
	if (_spawn in ["camp", "carrier"]) then {_camps pushBack _id};
	nil
} count GVAR(BaseList);
	
_campID = selectRandom _camps;

{
	_x params ["_id", "_side", "_position", "_spawn"];
	
	if (_id isEqualTo _campID) then {		
		private _mPos = [((_position select 0) + (_positionBase select 0)) / 2, ((_position select 1) + (_positionBase select 1)) / 2];
		
		private _marker = createMarker ["marker_resistance_" + str(_forEachIndex), _mPos];
		_marker setMarkerShape "RECTANGLE";
		_marker setMarkerSize [150, ((_positionBase distance2D _position) / 2) - 300];
		_marker setMarkerColor "ColorRed";		
		_marker setMarkerDir (_positionBase getDir _position);
		_marker setMarkerAlpha 0;
		
		for "_i" from 1 to 4 do {		 
			private _group = [getMarkerPos _marker, independent, [selectRandom _groupUnitsArray, selectRandom _groupUnitsArray]] call BIS_fnc_spawnGroup;			
			
			{
				GVAR(resistanceUnits) pushBack _x;
				_x addEventHandler [
					"Killed", {
						params ["_unit", "_killer"];
						
						if (side (group _killer) isEqualTo resistance || side (group _killer) isEqualTo civilian) exitWith {NOTIFICATION_LOG(Resistance unit not counted!)};
						if (({alive _x} count GVAR(resistanceUnits)) isEqualTo 0) then {
							[] call FUNC(reportDefeatResistance);
							["resistance", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
							GVAR(taskState) set [2, if (GVAR(resist) isEqualTo "west") then {"ost"} else {"west"}];
						} else {
							[side (group _killer), VALUE_RESIST] call FUNC(reportDeadCivilian);
						};
					}
				];
				
				nil
			} count (units _group);
			
			[_group, _marker] call CBA_fnc_taskSearchArea;
		};
	};
} forEach GVAR(BaseList);

nil
