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
	["_infantryList", [], [[]]],
	["_resistanceUnits", [], [[]]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

diag_log _this;

private _side = if (side (group player) isEqualTo west) then {east} else {west};
private _indexVehicleList = _vehicleList find _side;

private _endl = "<br/>";
private _tab = "    ";
private _separateLong = "==================================================<br/><br/>";
private _separateShort = "========================<br/>";

private _infantryListNew = if ((_infantryList select 0) isEqualTo objNull) then {[]} else {_infantryList select 0};
_infantryListNew append (if ((_infantryList select 1) isEqualTo objNull) then {[]} else {_infantryList select 1});
private _indexInfantryList = _infantryListNew find _side;

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
	} count (_infantryListNew select (_indexInfantryList + 1));
	
	_info = _info + _endl;
	
	nil
} count (_vehicleList select (_indexVehicleList + 1));

if !(GVAR(Resist) isEqualTo "") then {
	_info = _info + _endl + "Widerstand" + _endl + _separateLong + _tab + "Last known position" + _endl + _tab + _separateShort;
	
	if (({alive _x} count _resistanceUnits) > 0) then {		
		{
			if (alive _x) then {
				private _vehicleName = getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName");
			
				private _marker = createMarkerLocal ["resistanceUnit_" + str(_forEachIndex), position _x];
				_marker setMarkerShapeLocal "ICON";
				_marker setMarkerTypeLocal "n_inf";
				
				_info = _info + _tab + format["<marker name='%1'>%2</marker>", "resistanceUnit_" + str(_forEachIndex), _vehicleName] + _endl;
			};	
		} forEach _resistanceUnits;
	} else {
		_info = _info + _tab + "They are all dead!" + _endl;
	};
};

hint "Information received!";

private _general = if (_side isEqualTo west) then {GVAR(NATO)} else {GVAR(CSAT)};

player createDiaryRecord ["Diary", ["Intel", (format ["The enemy leader General %1 decreeds about a budget of %2 Mio $", _general, _budget]) + _endl + _endl + _info]];

nil
