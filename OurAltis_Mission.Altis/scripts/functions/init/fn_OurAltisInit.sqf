#include "macros.hpp"
/**
 * OurAltis_Mission - fn_OurAltisInit
 * 
 * Author: Raven
 * 
 * Description:
 * Initializes the OurAltis framework
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

// set preferences
GVAR(SpyInfo) = [[15376,16017], "ost", 20.0];
GVAR(Resist) = "";
GVAR(supplyPoint) = [];
GVAR(NATO) = "Smith";
GVAR(CSAT) = "Iwanow";
GVAR(resistanceUnits) = [];
GVAR(canRetreat) = [west, east];

if(isServer) then {	
	GVAR(timeLimit) = 5;
	GVAR(round) = 1;
	GVAR(BaseList) = [];
	GVAR(Infantry) = [];
	GVAR(vehicleListAll) = [];
	GVAR(Vehicles) = [west, [], east, []];
	GVAR(OperationName) = "Graceful Bird";
	GVAR(MissionID) = 11483;
	GVAR(targetAreaName) = "Aeroport";
	GVAR(dataBase) = "a";
	GVAR(defenderSide) = east;
	GVAR(polygon) = [];
	diag_log ("fn_ourAltisInit(1): - " + str(GVAR(polygon)));
	
	[
		[[13462.875,15969.920], east, "Aeroport", "base", 1, -17.492],
		[[16372.000,19664.000], blufor, "AgiaTriada", "camp", 4, 241.375]
	] call FUNC(createBases);
	
	diag_log ("fn_ourAltisInit(2): - " + str(GVAR(polygon)));
	
	[
		[12462.875,15969.920], "barracks", 0
	] call FUNC(createEconomy);
	
	[0, 05, 15] call FUNC(setMissionParameter);
	
	[
		["Rifleman", 9, "Aeroport", "Aeroport"],
		["MG", 5, "Aeroport", "Aeroport"],
		["MGAssistant", 3, "Aeroport", "Aeroport"],
		["AT", 1, "Aeroport", "Aeroport"],
		["AA", 1, "Aeroport", "Aeroport"],
		["Medic", 1, "Aeroport", "Aeroport"],
		["Marksman", 1, "Aeroport", "Aeroport"],
		["UAV", 3, "Aeroport", "Aeroport"],
		["Crew", 11, "Aeroport", "Aeroport"],
		["Driver", 7, "AgiaTriada", "Aeroport"],
		["Crew", 11, "AgiaTriada", "Aeroport"],
		["Pilot", 6, "AgiaTriada", "Aeroport"]
	] call FUNC(configureInfantry);
	
	[
		{
			VEHICLE_ARRAY call FUNC(createVehicles);
		},
		[]		
	] call CBA_fnc_execNextFrame;
	
	 GVAR(SpyInfo) call FUNC(createSpy);
	 GVAR(Resist) call FUNC(createResistance);
	 GVAR(supplyPoint) call FUNC(createSupplyPoint);
};

[] call FUNC(initializeGenericMissionPart);

nil;
