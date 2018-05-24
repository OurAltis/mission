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
	
{
	if (_baseID isEqualTo (_x select 4)) then {
		if ((_x select 0) isKindOf "LandVehicle") then {
			_matchedLandVehicles pushBack _x;
		};
		
		if ((_x select 0) isKindOf "Air") then {
			_matchedAirVehicles pushBack _x;
		};
		
		if ((_x select 0) isKindOf "Ship") then {
			_matchedSeeVehicles pushBack _x;
		};
	};
	
	nil
} count _vehicles;

[_matchedLandVehicles, _matchedAirVehicles, _matchedSeeVehicles]
