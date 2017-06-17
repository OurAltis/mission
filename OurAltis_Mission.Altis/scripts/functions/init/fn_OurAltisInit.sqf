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
 
diag_log ("Starting time: " + str diag_tickTime);

// set preferences
GVAR(MarkerAccuracy) = 500;
//GVAR(SpyInfo) = [[blufor, localize "OurA_str_enemyHasTanks"], [opfor, localize "OurA_str_enemyHasHelicopter"]];
GVAR(SpyInfo) = [[123,456], "west", 20030000]; // [position, side, budget]
GVAR(Resist) = "ost";
GVAR(NATO) = "Mario";
GVAR(CSAT) = "Luigi";
GVAR(resistanceUnits) = [];

if(isServer) then {
	// only initialize on server	
	// variable init
	GVAR(BaseList) = [];
	GVAR(Infantry) = [];
	GVAR(Vehicles) = [];
	GVAR(VehicleListVirtual) = [];
	GVAR(OperationName) = "Operation Beispiel";
	GVAR(MissionID) = 84303;
	GVAR(targetAreaName) = "Telos";
	GVAR(dataBase) = "a";
	GVAR(defenderSide) = east;	
	
	// initialize unique mission part
	// erstellt ein Feldlager und eine Basis
	[
		[[14917, 16471], blufor, "Charkia", false, 1, 45],
		[[14817, 17671], blufor, "Maxwell", true, 6, 0],
		[[18317, 13471], east, "Rainbow", false, 6, 90]
	] call FUNC(createBases);
	
	[
		[123, 456],
		"factory",
		45
	] call FUNC(createEconomy);
	
	// schoenes Wetter ohne Nebel tagsueber
	[0,0,0] call FUNC(setMissionParameter);
	
	// Infanterie hinzufuegen
	[
		["Rifleman", 2, "Charkia"],
		["AT", 2, "Rainbow"],
		["Medic", 1, "Charkia"],
		["Engineer", 2, "Maxwell"],
		["Grenadier", 5, "Charkia"],
		["Spotter", 3, "Charkia"],
		["Marksman", 2, "Charkia"],
		["UAV", 3, "Charkia"],
		["Driver", 1, "Charkia"],
		["AT", 8, "Charkia"],
		["Pilot", 9, "Charkia"],
		["SQL", 53, "Charkia"],
		["Crew", 3, "Charkia"],
		["MG", 4, "Charkia"],
		["MGAssistant", 1, "Charkia"]
	] call FUNC(configureInfantry);
	
	// Erstellt sichtbare und unsichtbare Helipads in den Basen um den Fahrzeugspawn zu testen 
	// [3, 1] call FUNC(createHelipads);
	
	[
		{
			// Erstellt die Fahrzeuge ["CLassenname", Treibstofff�llstand, Schaden, Spawnpunkt, ID]	
			[
				["B_G_Offroad_01_armed_F", 1, 0, "Charkia", "0"],
				["B_G_Offroad_01_armed_F", 0.5, 0.8, "Charkia", "1"],
				["B_G_Offroad_01_armed_F", 1, 0, "Charkia", "2"],
				["B_G_Offroad_01_armed_F", 1, 0, "Charkia", "3"],
				["B_G_Offroad_01_armed_F", 1, 0, "Charkia", "4"],
				["B_G_Offroad_01_armed_F", 1, 0, "Charkia", "5"],
				["B_G_Offroad_01_armed_F", 1, 0, "Charkia", "555"],
				["B_G_Offroad_01_armed_F", 1, 0, "Charkia", "12"],
				["B_G_Offroad_01_armed_F", 1, 0, "Charkia", "44987"],
				["B_MRAP_01_F", 1, 0, "Charkia", "79"],
				["B_MRAP_01_F", 1, 0, "Charkia", "80"],
				["B_MRAP_01_F", 1, 0, "Charkia", "81"],
				["B_G_Offroad_01_armed_F", 1, 0, "Charkia", "82"],
				["B_MRAP_01_F", 1, 0, "Charkia", "83"],
				["B_MRAP_01_F", 1, 0, "Charkia", "45"],
				["B_MRAP_01_F", 1, 0, "Charkia", "450"],
				["B_G_Offroad_01_armed_F", 1, 0, "Charkia", "348"],
				["B_MRAP_01_F", 1, 0, "Charkia", "349"],
				["B_MRAP_01_F", 1, 0, "Charkia", "350"],
				["B_Quadbike_01_F", 0.5, 0.2, "Maxwell", "351"],
				["B_Quadbike_01_F", 0, 0.7, "Maxwell", "352"],
				["B_Quadbike_01_F", 0.3, 0.1, "Maxwell", "353"],
				["B_Quadbike_01_F", 1, 0.9, "Maxwell", "89016"],
				["B_Heli_Light_01_armed_F", 0, 0.8, "Charkia", "355"],
				["B_Heli_Light_01_armed_F", 0, 0.9, "Charkia", "356"],
				["B_Heli_Light_01_armed_F", 1, 0, "Charkia", "357"],
				["B_Heli_Light_01_armed_F", 0.2, 0, "Maxwell", "358"],
				["B_Heli_Light_01_armed_F", 1, 0, "Rainbow", "12345678"]
			] call FUNC(createVehicles);
		},
		[],
		0.5
	] call CBA_fnc_waitAndExecute;
	
	GVAR(SpyInfo) call FUNC(createSpy);
	GVAR(Resist) call FUNC(createResistance);
};

[] call FUNC(initializeGenericMissionPart);

nil;
