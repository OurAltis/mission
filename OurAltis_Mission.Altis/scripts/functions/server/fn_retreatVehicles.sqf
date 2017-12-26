#include "macros.hpp"
/**
 * OurAltis_Mission - fn_retreatVehicles
 * 
 * Author: Raven
 * 
 * Description:
 * Retreat all vehicles of the given side. Only vehicles in the range of the base are being retreated
 * 
 * Parameter(s):
 * 0: The side whose vehicles should be retreated <Side>
 * 
 * Return Value:
 * None <Any>
 * 
 */

CHECK_TRUE(isServer, Can only bhe executed on server!, {})

private _success = params[
	["_side", sideUnknown, [sideUnknown]]
];

CHECK_TRUE(_success, Invalid parameters!, {})


{
	if((_x select 1) isEqualTo _side) then {
		private _vehicles = nearestObjects [_x select RETREAT_RADIUS, ["LandVehicle", "Air"], 10];
		
		{
			private _id = (_x getVariable [VEHICLE_ID, nil]) select [3];
			
			if (!isNil "_id") then {
				// retreat respective vehicle
				["UPDATE armeen SET rueckzug = 'ordered' WHERE id = '" + _id + "'"] call FUNC(transferSQLRequestToDataBase);
			};
			
			nil
		} count _vehicles;
	};
	
	nil
} count GVAR(BaseList);
