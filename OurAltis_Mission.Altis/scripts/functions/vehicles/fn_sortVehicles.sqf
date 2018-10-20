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

private _matchedLandVehicles = [];
private _matchedAirVehicles = [];
private _matchedSeeVehicles = [];

diag_log "sortVehicles: _this: " + str(_this);
diag_log "sortVehicles: _this: " + str(_vehicles);

_vehicles params [
	["_type", "", [""]],
	["_fuel", 0, [0]],
	["_damage", 0, [0,"",[]]],
	["_ammo", [], [[]]],
	["_spawn", "", [""]]
];

{
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
