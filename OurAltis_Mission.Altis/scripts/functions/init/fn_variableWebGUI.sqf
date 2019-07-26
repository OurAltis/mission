#include "macros.hpp"
/**
 * OurAltis_Mission - fn_variableWebGUI
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Contains all generated variables from web GUI
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

// This Function is not yet implemented 

WEBVAR(SpyInfo) = [[13981.633,20772.578], "ost", 90.00];
WEBVAR(Resist) = "ost";
WEBVAR(supplyPoint) = [[14674.602,20813.512],348.727];
WEBVAR(NATO) = "Fry1";
WEBVAR(CSAT) = "Fry2";

if (isServer) then {
	WEBVAR(timeLimit) = 90;
	WEBVAR(round) = 3;	
	WEBVAR(OperationName) = "Red Eagle";
	WEBVAR(MissionID) = 87186;
	WEBVAR(targetAreaName) = "Frini";
	WEBVAR(dataBase) = "27310";
	WEBVAR(defenderSide) = west;
	
	WEBVAR(baseArray) = [];
	WEBVAR(economyArray) = [];
	WEBVAR(environmentArray) = [];
	WEBVAR(infantryArray) = [];
	WEBVAR(vehicleArray) = [];
};
