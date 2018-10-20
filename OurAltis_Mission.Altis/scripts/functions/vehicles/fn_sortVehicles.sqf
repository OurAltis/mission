#include "macros.hpp"
/**
 * OurAltis_Mission - fn_sortVehicles
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Sort and return all vehicles which have the same spawnID
 * 
 * Parameter(s):
 * 0: BaseID <String>
 * 1: Vehicles <Array>
 * 
 * Return Value:
 * Sorted vehicles <Array> - format [[LandVehicles], [AirVehicles], [SeeVehicles]]
 * 
 */

private _success = params [
	["_baseID", "", [""]],
	["_vehicles", [], [[]]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

diag_log ("sortedVehicles vehicles count: " + str(count _vehicles));

private _matchedLandVehicles = [];
private _matchedAirVehicles = [];
private _matchedSeeVehicles = [];

{
	diag_log ("_x count: " + str(count _x));
	diag_log ("_x e1: " + str(_x select 0));
	diag_log ("_x e2: " + str(_x select 1));
	diag_log ("_x e3: " + str(_x select 2));
	diag_log ("_x e4: " + str(_x select 3));
	diag_log ("_x e5: " + str(_x select 4));
	
	_x params [
		["_type", "", [""]],
		["_fuel", 0, [0]],
		["_damage", 0, [0,"",[]]],
		["_ammo", [], [[]]],
		["_spawn", "", [""]]
	];
	
	diag_log ("sortedVehicles _type: " + str(_type));
	diag_log ("sortedVehicles: _fuel: " + str(_fuel));
	diag_log ("sortedVehicles _damage: " + str(_damage));
	diag_log ("sortedVehicles: _ammo: " + str(_ammo));
	diag_log ("sortedVehicles: _spawn: " + str(_spawn));
	
	if (_baseID isEqualTo _spawn) then {
		if (_type isKindOf "LandVehicle") then {
			_matchedLandVehicles pushBack _x;
		};
		
		if (_type isKindOf "Air") then {
			_matchedAirVehicles pushBack _x;
		};
		
		if (_type isKindOf "Ship") then {
			_matchedSeeVehicles pushBack _x;
		};
	};
	
	nil
} count _vehicles;

[_matchedLandVehicles, _matchedAirVehicles, _matchedSeeVehicles]
