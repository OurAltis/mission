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
private _heliBig = [];
private _heliSmall = [];

{	
	_x params [
		["_type", "", [""]],
		["_fuel", 0, [0]],
		["_damage", 0, [0,"",[]]],
		["_ammo", [], [[]]],
		["_spawn", "", [""]]
	];	
	
	if (_baseID isEqualTo _spawn) then {
		if (_type isKindOf "LandVehicle") then {
			_matchedLandVehicles pushBack _x;
		};
		
		if (_type isKindOf "Air") then {			
			if (_type in HELI_BIG) then {
				_heliBig pushback _x;
			} else {
				_heliSmall pushBack _x;
			};		
		};
		
		if (_type isKindOf "Ship") then {
			_matchedSeeVehicles pushBack _x;
		};
	};
	
	nil
} count _vehicles;

diag_log ("_sortVehicles _heliBig: " + str(_heliBig));
diag_log ("_sortVehicles _heliSmall: " + str(_heliSmall));

if (count _heliBig >= 1) then {
	_matchedAirVehicles pushBack (_heliBig select 0);
	_heliBig deleteAt 0;
};

diag_log ("_sortVehicles _matchedAirVehicles: " + str(_matchedAirVehicles));

_matchedAirVehicles = _matchedAirVehicles + _heliSmall + _heliBig;

diag_log ("_sortVehicles _matchedAirVehicles: " + str(_matchedAirVehicles));

[_matchedLandVehicles, _matchedAirVehicles, _matchedSeeVehicles]
