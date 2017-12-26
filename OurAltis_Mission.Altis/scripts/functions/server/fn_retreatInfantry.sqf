#include "macros.hpp"
/**
 * OurAltis_Mission - fn_retreatInfantry
 * 
 * Author: Raven
 * 
 * Description:
 * Retreat all infantry of the given side. Vehicles occupied by players arte being retreated as well.
 * 
 * Parameter(s):
 * 0: The side whose infantry should be retreated <Side>
 * 
 * Return Value:
 * None <Any>
 * 
 */

CHECK_TRUE(isServer, Function has to be executed on server!, {})

private _success = params[
	["_side", sideUnknown, [sideUnknown]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

{
	if (side _x isEqualTo _side && alive _x) then {
		private _classCode = _x getVariable [CLASS_CODE_VARIABLE, 0];
				
		private _unitPos = getPos _x;
		
		private _ordered = "";
		
		if (_unitPos select 2 > RETREAT_HEIGHT) then {
			_ordered = "ordered";
		} else {
			private _nearestBase = [getPos _x, _side] call FUNC(getNearestBase);
			
			(_nearestBase select 2) set [2,0]; // make sure z-index is 0
			
			private _distance = (_nearestBase select 2) vectorDistance _unitPos;
			
			_ordered = if(_distance < RETREAT_RADIUS) then {"ordered"} else {"unordered"};
		};
		
		if(_classCode > 0) then {
			["UPDATE armeen SET rueckzug = '" + _ordered + "' WHERE code = '" + _classCode 
				+ "' && einsatz = '" + GVAR(targetAreaName) + "' && rueckzug = '' && bestand = ''"] call FUNC(transferSQLRequestToDataBase);
		};
			
		// retreat occopied vehcicle as well
		private _vehicle = vehicle _x;
		
		if !(_vehicle isEqualTo _x) then {
			["UPDATE armeen SET rueckzug = '" + _ordered + "' WHERE id = '" 
				+ ((_vehicle getVariable [VEHICLE_ID, nil]) select [3]) + "'"] call FUNC(transferSQLRequestToDataBase);
		};
	};
	
	nil
} count playableUnits;

// retreat all un-spaned units
["UPDATE armeen SET rueckzug = 'ordered' WHERE einsatz = '" + GVAR(targetAreaName) + "' && rueckzug = '' && bestand = ''"] call FUNC(transferSQLRequestToDataBase);

nil
