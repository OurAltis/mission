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

private _infantryListNew = _infantryList select 0;
_infantryListNew append (_infantryList select 1);
diag_log _infantryListNew;
private _info = "";

{
	_x params [
		["_locationVehicle", "MissingNo", [""]],
		["_objectsVehicle", [], [[]]] 
	];		
		
	//_info = _info + _tab + format ["<font color='#00ff00'>%1</font>", _location] + _endl + _tab + _separateShort;
	_info = _info + format ["<font color='#00ff00'>%1</font>", _locationVehicle] + _endl + _separateLong + _tab + "Fuhrpark" + _endl + _tab + _separateShort;
	
	{
		_x params [
			["_objectType", "", [""]],
			["_amount", 0, [0]]
		];
		
		private _vehicleName = getText (configFile >> "CfgVehicles" >> _objectType >> "displayName");
		_info = _info + _tab + str(_amount) + " x " + _vehicleName + _endl; 
		
		nil
	} count _objectsVehicle;
	
	_info = _info + _endl + _tab + "Truppenstaerke" + _endl + _tab + _separateShort;
	
	{
		_x params [
			["_locationInfantry", "MissingNo", [""]],
			["_objectsInfantry", [], [[]]] 
		];
		
		if (_locationInfantry isEqualTo _locationVehicle) then {
			{
				_x params [
					["_objectType", "", [""]],
					["_amount", 0, [0]]
				];				
				
				_info = _info + _tab + str(_amount) + " x " + _objectType + _endl;
				
				nil
			} count _objectsInfantry;
		};
		
		nil
	} count (_infantryListNew select (_index + 1));
	
	_info = _info + _endl;
	
	nil
} count (_vehicleList select (_index + 1));

hint "Information received!";

private _general = if (_side isEqualTo west) then {GVAR(NATO)} else {GVAR(CSAT)};

player createDiaryRecord ["Diary", ["Intel", (format ["The enemy leader General %1 decreed about a budget of %2 Mio $", _general, _budget]) + _endl + _endl + _info]];

nil