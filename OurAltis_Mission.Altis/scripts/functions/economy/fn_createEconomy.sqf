#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createEconomy
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Creates economy buildings
 * 
 * Parameter(s):
 * 0: Position <Array>
 * 1: Type <String>
 * 2: Direction <Scalar>
 * 3: Index DB <Scalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */ 

if( _this isEqualTo []) exitWith {}; // if there is no economy simply exit the function

{
	private _success = _x params [
		["_position", nil, [[]], [2,3]],
		["_type", "", [""]],
		["_dir", 0, [0]],
		["_indexDB", 0, [0]]
	];

	CHECK_TRUE(_success, Invalid parameters!, {})

	private _objsArray = call compile preprocessFileLineNumbers (format ["scripts\compositions\%1.sqf", _type]);
	
	_objsArray = [_position, _dir, _objsArray, if (_type isEqualTo "IDAPCamp") then {VEHICLE_IDAP + [FLAGPOLE]} else {[FLAGPOLE]}] call FUNC(objectsMapper);

	private _marker = _objsArray deleteAt (count _objsArray - 1);
	private _size = getMarkerSize _marker;
	private _markerDir = markerDir _marker;
	_position = getMarkerPos _marker;
	
	deleteMarker _marker;	
	
	[GVAR(defenderSide), _objsArray] call FUNC(setFlagTexture);
	
	if (_type isEqualTo "IDAPCamp") then {
		diag_log ("createSupplyPoint IDAPCamp: " + str(_objsArray));
		
		{
			if ((typeOf _x) in VEHICLE_IDAP) then {			
				_x addEventHandler [
					"Killed", {		
						params ["_unit", "_killer", "_instigator"];
						
						[_instigator] call FUNC(reportAidSupplyDestroyed);
					}
				];				
			};
			
			nil
		} count _objsArray;
	};	
	
	_objsArray = nearestObjects [_position, ["house"], 90];

	private _buildingCount = {
		private _isEco = _x getVariable [IS_ECONOMY_BUILDING, false];
		
		if (_isEco) then {
			_x setVariable [QGVAR(indexDB), _indexDB];
		};
		
		_isEco
	} count _objsArray;
		
	[_type, _buildingCount, _indexDB] call FUNC(initializeEconomyVariable);	
	
	_marker = createMarker ["marker_eco_" + str(_indexDB), _position];
	_marker setMarkerShape "RECTANGLE";
	_marker setMarkerSize _size;
	_marker setMarkerDir _markerDir;
	_marker setMarkerColor "ColorRed";
	_marker setMarkerAlpha 0;	
	
	_objsArray = nearestObjects [_position, ["Land_HelipadCircle_F", "Land_HelipadCivil_F", "Land_HelipadRescue_F", "Land_HelipadSquare_F", "Land_HelipadEmpty_F"], 90];

	[_objsArray] call FUNC(createAmbientVehicles);
	
	nil
} count _this;

nil
