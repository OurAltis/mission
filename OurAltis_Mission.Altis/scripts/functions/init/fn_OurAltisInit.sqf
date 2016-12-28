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
	
	
	// initialize unique mission part
	// erstellt ein Feldlager und eine Basis
	[
		[[14917, 16471], blufor, "Conner", false],
		[[14817, 17671], blufor, "Maxwell", true],
		[[15317, 13471], east, "Rainbow", false]
	] call FUNC(createBases);
	
	// schoenes Wetter mit Nebel tagsueber
	[0,1,0] call FUNC(setMissionParameter);
	
	// Infanterie hinzufuegen
	[["Rifleman", 2, "Conner"], ["Medic", 1, "Conner"], ["Medic", 1, "Maxwell"]] call FUNC(configureInfantry);
	
	// Erstellt sichtbare und unsichtbare Helipads in den Basen um den Fahrzeugspawn zu testen 
	// [3, 1] call FUNC(createHelipads);
	
	// Erstellt die Fahrzeuge ["CLassenname", Treibstofffüllstand, Schaden, Spawnpunkt]	
	/*[
		["B_MRAP_01_F", 1, 0, "Conner"],
		["B_G_Offroad_01_armed_F", 0.5, 0.8, "Conner"],
		["B_MRAP_01_F", 1, 0, "Conner"],
		["B_MRAP_01_F", 1, 0, "Conner"],
		["B_Quadbike_01_F", 0.5, 0.2, "Maxwell"],
		["B_Quadbike_01_F", 0, 0.7, "Maxwell"],
		["B_Quadbike_01_F", 0.3, 0.1, "Maxwell"],
		["B_Quadbike_01_F", 1, 0.9, "Maxwell"],
		["B_Heli_Light_01_armed_F", 0, 0.8, "Conner"],
		["B_Heli_Light_01_armed_F", 0, 0.9, "Conner"],
		["B_Heli_Light_01_armed_F", 1, 0, "Conner"],
		["B_Heli_Light_01_armed_F", 0.2, 0, "Maxwell"]
	] call FUNC(createVehicles);*/
	
	[
		FUNC(createVehicles),
		[
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_G_Offroad_01_armed_F", 0.5, 0.8, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_MRAP_01_F", 1, 0, "Conner"],
			["B_Quadbike_01_F", 0.5, 0.2, "Maxwell"],
			["B_Quadbike_01_F", 0, 0.7, "Maxwell"],
			["B_Quadbike_01_F", 0.3, 0.1, "Maxwell"],
			["B_Quadbike_01_F", 1, 0.9, "Maxwell"],
			["B_Heli_Light_01_armed_F", 0, 0.8, "Conner"],
			["B_Heli_Light_01_armed_F", 0, 0.9, "Conner"],
			["B_Heli_Light_01_armed_F", 1, 0, "Conner"],
			["B_Heli_Light_01_armed_F", 0.2, 0, "Maxwell"]
		],
		1
	] call CBA_fnc_waitAndExecute;
};

[] call FUNC(initializeGenericMissionPart);

nil;
