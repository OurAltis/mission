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
GVAR(SpyInfo) = [[15376,16017], "ost", 20.0];
GVAR(Resist) = "";
GVAR(NATO) = "Smith";
GVAR(CSAT) = "Iwanow";
GVAR(resistanceUnits) = [];

if(isServer) then {
	GVAR(timeLimit) = 3600;
	GVAR(BaseList) = [];
	GVAR(Infantry) = [];
	GVAR(VehicleListVirtual) = [];
	GVAR(OperationName) = "Graceful Bird";
	GVAR(MissionID) = 11483;
	GVAR(targetAreaName) = "Aeroport";
	GVAR(dataBase) = "a";
	GVAR(defenderSide) = east;
	[
		[[13462.875,15969.920], east, "Aeroport", false, 1, -17.492],
		[[16372.000,19664.000], blufor, "AgiaTriada", true, 4, 241.375]
	] call FUNC(createBases);
	
	[] call FUNC(createEconomy);
	
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
			[
				["O_MBT_02_cannon_F", 0.16, 0.59, "Aeroport", "35990"],
				["O_APC_Tracked_02_AA_F", 0.4, 0.16, "Aeroport", "73912"],
				["O_APC_Wheeled_02_rcws_F", 0.95, 0.46, "Aeroport", "49916"],
				["O_APC_Wheeled_02_rcws_F", 0.79, 0.5, "Aeroport", "20434"],
				["B_Heli_Transport_01_F", 0.95, 0.09, "AgiaTriada", "29550"],
				["B_Heli_Attack_01_F", 0.96, 0.47, "AgiaTriada", "77607"],
				["B_MBT_01_cannon_F", 0.1, 0.51, "AgiaTriada", "36982"],
				["B_T_APC_Tracked_01_AA_F", 0.81, 0.43, "AgiaTriada", "33705"],
				["B_APC_Wheeled_01_cannon_F", 0.71, "[[""HitBody"",""HitEngine"",""HitFuel"",""HitHull"",""HitLFWheel"",""HitLBWheel"",""HitLMWheel"",""HitLF2Wheel"",""HitRFWheel"",""HitRBWheel"",""HitRMWheel"",""HitRF2Wheel"",""HitRGlass"",""HitLGlass"",""HitGlass1"",""HitGlass2"",""HitGlass3"",""HitGlass4"",""HitGlass5"",""HitGlass6"","""","""","""","""","""","""",""HitTurret"",""HitGun"",""HitTurret"",""HitGun""],[""karoserie"",""motor"",""palivo"",""palivo"",""wheel_1_1_steering"",""wheel_1_4_steering"",""wheel_1_3_steering"",""wheel_1_2_steering"",""wheel_2_1_steering"",""wheel_2_4_steering"",""wheel_2_3_steering"",""wheel_2_2_steering"","""","""","""","""","""","""","""","""",""light_l"",""light_l"","""",""light_r"",""light_r"","""",""vez"",""zbran"",""vezvelitele"",""zbranvelitele""],[0.641732,0.641732,0.641732,0.641732,0.775591,0.641732,0.665354,0.748031,1,0.775591,1,1,0.641732,0.641732,0.641732,0.641732,0.641732,0.641732,0.641732,0.641732,1,1,0.641732,1,1,0.641732,0.641732,0.641732,0.641732,0.641732]]", "AgiaTriada", "73424"],
				["B_APC_Wheeled_01_cannon_F", 0.16, 0.17, "AgiaTriada", "57771"],
				["B_MRAP_01_F", 0.07, 0.14, "AgiaTriada", "60473"],
				["B_MRAP_01_hmg_F", 0.8, 0.49, "AgiaTriada", "52374"],
				["B_MRAP_01_hmg_F", 0.5, 0.16, "AgiaTriada", "82232"],
				["B_Truck_01_covered_F", 0.16, 0.33, "AgiaTriada", "99870"],
				["B_Truck_01_covered_F", 0.23, 0.1, "AgiaTriada", "87821"]
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
