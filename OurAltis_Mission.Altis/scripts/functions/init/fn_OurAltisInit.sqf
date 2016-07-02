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
	GVAR(OperationName) = "Operation Beispiel";
	
	
	// initialize unique mission part
	// erstellt ein Feldlager und eine Basis
	[
		[[14917, 16471], blufor, "Conner", false],
		[[14817, 17671], independent, "Maxwell", true],
		[[15317, 13471], east, "Rainbow", false]
	] call FUNC(createBases);
	
	// schoenes Wetter mit Nebel tagsueber
	[0,1,0] call FUNC(setMissionParameter);
	
	// Infanterie hinzufuegen
	[["Rifleman", 5, "Conner"], ["Medic", 3, "Conner"], ["Medic", 2, "Maxwell"]] call FUNC(configureInfantry);
	/*
	// Fuegt einFahrzeug mit vollem Tank und voller Gesundheit hinzu
	[["KlassenNameDesFahrzeugsDerMirGradNichtEinfaellt", "ID1", 1, 0, "Conner"], [...]] call FUNC(configureVehicles);*/
};

[] call FUNC(initializeGenericMissionPart);

nil;
