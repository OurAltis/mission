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
		[[14917, 16471], blufor, "Conner", false, 1],
		[[14817, 17671], blufor, "Maxwell", true, 6],
		[[15317, 13471], east, "Rainbow", false, 6]
	] call FUNC(createBases);
	
	// schoenes Wetter mit Nebel tagsueber
	[0,1,0] call FUNC(setMissionParameter);
	
	// Infanterie hinzufuegen
	[["Schütze", 2, "Conner"], ["Sanitäter", 1, "Conner"], ["Ingenieur", 1, "Maxwell"]] call FUNC(configureInfantry);
	
	// Erstellt sichtbare und unsichtbare Helipads in den Basen um den Fahrzeugspawn zu testen 
	// [3, 1] call FUNC(createHelipads);
	
	// Erstellt die Fahrzeuge ["CLassenname", Treibstofffüllstand, Schaden, Spawnpunkt]	
	[
		["B_MRAP_01_F", 1, 0, "Conner", 0],
		["B_G_Offroad_01_armed_F", 0.5, 0.8, "Conner", 1],
		["B_MRAP_01_F", 1, 0, "Conner", 2],
		["B_MRAP_01_F", 1, 0, "Conner", 3],
		["B_MRAP_01_F", 1, 0, "Conner", 4],
		["B_MRAP_01_F", 1, 0, "Conner", 5],
		["B_MRAP_01_F", 1, 0, "Conner", 555],
		["B_MRAP_01_F", 1, 0, "Conner", 12],
		["B_MRAP_01_F", 1, 0, "Conner", 44987],
		["B_MRAP_01_F", 1, 0, "Conner", 79],
		["B_MRAP_01_F", 1, 0, "Conner", 80],
		["B_MRAP_01_F", 1, 0, "Conner", 81],
		["B_MRAP_01_F", 1, 0, "Conner", 82],
		["B_MRAP_01_F", 1, 0, "Conner", 83],
		["B_MRAP_01_F", 1, 0, "Conner", 45],
		["B_MRAP_01_F", 1, 0, "Conner", 450],
		["B_MRAP_01_F", 1, 0, "Conner", 348],
		["B_MRAP_01_F", 1, 0, "Conner", 349],
		["B_MRAP_01_F", 1, 0, "Conner", 350],
		["B_Quadbike_01_F", 0.5, 0.2, "Maxwell", 351],
		["B_Quadbike_01_F", 0, 0.7, "Maxwell", 352],
		["B_Quadbike_01_F", 0.3, 0.1, "Maxwell", 353],
		["B_Quadbike_01_F", 1, 0.9, "Maxwell", 354],
		["B_Heli_Light_01_armed_F", 0, 0.8, "Conner", 355],
		["B_Heli_Light_01_armed_F", 0, 0.9, "Conner", 356],
		["B_Heli_Light_01_armed_F", 1, 0, "Conner", 357],
		["B_Heli_Light_01_armed_F", 0.2, 0, "Maxwell", 358]
	] call FUNC(createVehicles);	
};

[] call FUNC(initializeGenericMissionPart);

nil;
