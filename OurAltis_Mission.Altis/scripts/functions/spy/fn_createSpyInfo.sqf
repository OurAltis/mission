#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createSpyInfo
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Create diary report
 * 
 * Parameter(s):
 * 0: Infantry list <Array>
 * 1: Vehicle list <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_budget", 0, [0]],
	["_vehicleList", [], [[]]],
	["_infantryList", [], [[]]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

diag_log _this;

private _side = if (side (group player) isEqualTo west) then {east} else {west};
private _index = _vehicleList find _side;

private _endl = "<br/>";
private _tab = "    ";
private _separateLong = "==================================================<br/><br/>";
private _separateShort = "========================<br/>";

private _info = "Fuhrpark" + _endl + _separateLong;

{
	_x params [
		["_location", "MissingNo", [""]],
		["_objects", [], [[]]] 
	];		
	
	_info = _info + _tab + format ["<font color='#00ff00'>%1</font>", _location] + _endl + _tab + _separateShort;
	
	{
		_x params [
			["_objectType", "", [""]],
			["_amount", 0, [0]]
		];
		
		private _vehicleName = getText (configFile >> "CfgVehicles" >> _objectType >> "displayName");
		_info = _info + _tab + str(_amount) + " x " + _vehicleName + _endl; 
		
		nil
	} count _objects;	
	
	_info = _info + _endl;
	
	nil
} count (_vehicleList select (_index + 1));

_index = _infantryList find _side;

_info = _info + _endl + "Truppenstaerke" + _endl + _separateLong;

{
	_x params [
		["_location", "MissingNo", [""]],
		["_objects", [], [[]]] 
	];		
	
	_info = _info + _tab + format ["<font color='#00ff00'>%1</font>", _location] + _endl + _tab + _separateShort;
	
	{
		_x params [
			["_objectType", "", [""]],
			["_amount", 0, [0]]
		];
		
		private _vehicleName = getText (configFile >> "CfgVehicles" >> _objectType >> "displayName");
		_info = _info + _tab + str(_amount) + " x " + _vehicleName + _endl; 
		
		nil
	} count _objects;	
	
	_info = _info + _endl;
	
	nil
} count (_infantryList select (_index + 1));

hint "Information received!";

player createDiaryRecord ["Diary", ["Intel", (format ["The enemy has a budget of %1 Mio $", _budget]) + _endl + _endl + _info]];

nil