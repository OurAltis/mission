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
GVAR(MarkerAccuracy) = 500;


if(isServer) then {
	// only initialize on server
	
	// variable init
	GVAR(BaseList) = [];
	GVAR(Infantry) = [];
	GVAR(VehicleListVirtual) = [];	
	GVAR(OperationName) = "Operation Beispiel";
	GVAR(targetAreaName) = "Telos";
	GVAR(dataBase) = "a";
	GVAR(defenderSide) = east;
	
	
	// initialize unique mission part
	// erstellt ein Feldlager und eine Basis
	[
		[[14917, 16471], blufor, "Charkia", false, 1],
		[[14817, 17671], blufor, "Maxwell", true, 6],
		[[18317, 13471], east, "Rainbow", false, 6]
	] call FUNC(createBases);
	
	// schoenes Wetter ohne Nebel tagsueber
	[0,0,0] call FUNC(setMissionParameter);
	
	// Infanterie hinzufuegen
	[
		["Rifleman", 2, "Charkia"],
		["Rifleman", 2, "Rainbow"],
		["Medic", 1, "Charkia"],
		["Engineer", 8, "Maxwell"],
		["Grenadier", 5, "Charkia"],
		["Spotter", 3, "Charkia"],
		["Marksman", 2, "Charkia"],
		["UAV", 3, "Charkia"],
		["Driver", 1, "Charkia"],
		["AA", 7, "Charkia"],
		["Pilot", 9, "Charkia"],
		["SQL", 53, "Charkia"],
		["Crew", 3, "Charkia"],
		["MG", 4, "Charkia"],
		["MGAssistant", 1, "Charkia"]
	] call FUNC(configureInfantry);
	
	// Erstellt sichtbare und unsichtbare Helipads in den Basen um den Fahrzeugspawn zu testen 
	// [3, 1] call FUNC(createHelipads);
	
	// Erstellt die Fahrzeuge ["CLassenname", Treibstofff�llstand, Schaden, Spawnpunkt, ID]	
	[
		["B_MRAP_01_F", 1, 0, "Charkia", 0],
		["B_G_Offroad_01_armed_F", 0.5, 0.8, "Charkia", 1],
		["B_MRAP_01_F", 1, 0, "Charkia", 2],
		["B_MRAP_01_F", 1, 0, "Charkia", 3],
		["B_MRAP_01_F", 1, 0, "Charkia", 4],
		["B_MRAP_01_F", 1, 0, "Charkia", 5],
		["B_MRAP_01_F", 1, 0, "Charkia", 555],
		["B_MRAP_01_F", 1, 0, "Charkia", 12],
		["B_MRAP_01_F", 1, 0, "Charkia", 44987],
		["B_MRAP_01_F", 1, 0, "Charkia", 79],
		["B_MRAP_01_F", 1, 0, "Charkia", 80],
		["B_MRAP_01_F", 1, 0, "Charkia", 81],
		["B_MRAP_01_F", 1, 0, "Charkia", 82],
		["B_MRAP_01_F", 1, 0, "Charkia", 83],
		["B_MRAP_01_F", 1, 0, "Charkia", 45],
		["B_MRAP_01_F", 1, 0, "Charkia", 450],
		["B_MRAP_01_F", 1, 0, "Charkia", 348],
		["B_MRAP_01_F", 1, 0, "Charkia", 349],
		["B_MRAP_01_F", 1, 0, "Charkia", 350],
		["B_Quadbike_01_F", 0.5, 0.2, "Maxwell", 351],
		["B_Quadbike_01_F", 0, 0.7, "Maxwell", 352],
		["B_Quadbike_01_F", 0.3, 0.1, "Maxwell", 353],
		["B_Quadbike_01_F", 1, 0.9, "Maxwell", 89016],
		["B_Heli_Light_01_armed_F", 0, 0.8, "Charkia", 355],
		["B_Heli_Light_01_armed_F", 0, 0.9, "Charkia", 356],
		["B_Heli_Light_01_armed_F", 1, 0, "Charkia", 357],
		["B_Heli_Light_01_armed_F", 0.2, 0, "Maxwell", 358]
	] call FUNC(createVehicles);	
};

[] call FUNC(initializeGenericMissionPart);

nil;
