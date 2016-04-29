/**
* Creates the defending units
*/

scopeName "rvn_populateDefenders";

private ["_unitList", "defenderGroup"];

_unitList = param[0, [], [["Array"]]];

// create group for all defender units
_defenderGroup = createGroup SIDE_DEFENDER;

{
	_unitName = _x select 0;
	_damage = _x select 1;
	_pos = getMarkerPos DEFENDER_RESPAWN_MARKER;
	
	// TODO: watch for custom classes
	
	// create respective unit
	[_unitName, _defenderGroup, _damage, _pos] call rvn_fnc_createUnit;
} forEach _unitList;
