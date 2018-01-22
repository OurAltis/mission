#include "config\settings.hpp"
/*
 * Defines all necessary macros used within the mission
 */

 #define MAJOR 0
 #define MINOR 1
 #define BUILD 0
 
 #define VERSION MAJOR.MINOR.BUILD
 #define QVERSION QUOTE(VERSION)
 
 #define SHOW_ONSCREEN_NOTIFICATIONS true
  
 #define TAG OurA
 
 #define GVAR(var) TAG##_##var
 #define QGVAR(var) QUOTE(GVAR(var))
 #define PGVAR(var) TAG##_Public_##var
 #define QPGVAR(var) QUOTE(PGVAR(var))
 
 #define FUNC(function) TAG##_fnc_##function
 #define QFUNC(function) QUOTE(FUNC(function))
 
 #define QUOTE(txt) #txt
 #define FORMAT(txt, var) format [QUOTE(txt), var]
 
 // Debug tools
 #ifdef DEBUG
 	// define debug macros
 	#define CHECK_TRUE(bool) if (!(bool)) then { ERROR_LOG(Expected true but was false) };
 	#define CHECK_TRUE(bool, msg) if (!(bool)) then { ERROR_LOG(msg) };
 	#define CHECK_TRUE(bool, msg, code) if (!(bool)) then { ERROR_LOG(msg) }; if(!(bool)) exitWith code;
 	#define CHECK_FALSE(bool) if (bool) then { ERROR_LOG(Expected false but was true) };
 	#define CHECK_FALSE(bool, msg) if (bool) then { ERROR_LOG(msg) };
 	#define CHECK_FALSE(bool, msg, code) if (bool) then { ERROR_LOG(msg) }; if(bool) exitWith code;
 	#define FUNCTIONS_RECOMPILE allowFunctionsRecompile = 1;
 	#define DEBUG_LOG(msg) LOG(OurAltis VERSION [DEBUG]: msg)
 	#define DEBUG_EXEC(code) code;
 #else 
 	// do nothing
 	#define CHECK_TRUE(bool)
 	#define CHECK_TRUE(bool, msg)
 	#define CHECK_TRUE(bool, msg, code)
 	#define CHECK_FALSE(bool)
 	#define CHECK_FALSE(bool, msg)
 	#define CHECK_FALSE(bool, msg, code)
 	#define FUNCTIONS_RECOMPILE
 	#define DEBUG_LOG(msg)
 	#define DEBUG_EXEC(code)
 #endif
 
 // Logging
 #define ERROR_LOG(msg) LOG(<t color='#ff0000'>OurAltis VERSION [Error]:</t> msg)
 #define NOTIFICATION_LOG(msg) LOG(<t color='#50dd00'>OurAltis VERSION [Notification]:</t> msg)
 #define WARNING_LOG(msg) LOG(<t color='#ff8f00'>OurAltis VERSION [Warning]:</t> msg)
 
 #define SCRIPT_REFERENCE format["(%1: %2)", _fnc_scriptName, __LINE__]
 
 #ifdef SHOW_ONSCREEN_NOTIFICATIONS
 	//TODO: use popup window for error display
 	#define LOG(msg) diag_log (parseText(QUOTE(msg) + " - " + SCRIPT_REFERENCE)); \
 		hintSilent (parseText(QUOTE(msg) + "</br>" + SCRIPT_REFERENCE));
 	#define LOG_VAR(var) diag_log (parseText(str var + " - " + SCRIPT_REFERENCE)); \
 		hintSilent (parseText(str var + "</br>" + SCRIPT_REFERENCE));
 	#define FORMAT_LOG(msg, var) diag_log (parseText(FORMAT(msg, var) + " - " + SCRIPT_REFERENCE)); \
 		hintSilent (parseText(FORMAT(msg, var) + " - " + SCRIPT_REFERENCE));
 #else
	 #define LOG(msg) diag_log (QUOTE(msg) + " " + SCRIPT_REFERENCE);
	 #define LOG_VAR(var) diag_log (str var + " " + SCRIPT_REFERENCE);
	 #define FORMAT_LOG(msg, var) diag_log (parseText(FORMAT(msg, var) + " - " + SCRIPT_REFERENCE));
 #endif 
 
 // define event IDs
 #define EVENT_PREFIX OurAltis.Event
 
 #define EVENT_BASE_LIST_REQUEST QUOTE(EVENT_PREFIX.getBaseList)
 #define EVENT_BASE_LIST_RECEIVED QUOTE(EVENT_PREFIX.baseListReceived)
 
 #define EVENT_INFANTRY_LIST_REQUEST QUOTE(EVENT_PREFIX.getInfantryList)
 #define EVENT_INFANTRY_LIST_RECEIVED QUOTE(EVENT_PREFIX.InfantryListReceived)
 
 #define EVENT_BASES_INITIALIZED QUOTE(EVENT_PREFIX.basesInitialized)
 
 #define EVENT_REQUEST_RESPAWN QUOTE(EVENT_PREFIX.requestRespawn)
 #define EVENT_ANSWER_REQUEST_RESPAWN QUOTE(EVENT_PREFIX.answerRespawnRequest)
 
 #define EVENT_INF_CHANGED QUOTE(EVENT_PREFIX.INF_CHANGED)
 #define EVENT_BASES_CHANGED QUOTE(EVENT_PREFIX.BASES_CHANGED)
 
 #define EVENT_MAPPOSITION_SELECTED QUOTE(EVENT_PREFIX.mapPositionChanged)
 
 #define UNIT_DIED QUOTE(EVENT_PREFIX.unitDied)
 
 #define ALL_PLAYER_OF_SIDE_DEAD QUOTE(EVENT_PREFIX.allPlayerOfSideDead)
 
 #define MISSION_ENDED QUOTE(EVENT_PREFIX.missionEnded)
  
 #define SEND_STATISTIC QUOTE(EVENT_PREFIX.sendStatistic)
 
 // define constants
 #define BASES_CHANGED baseListChangedOnServer
 #define INF_CHANGED infantryListChangedOnServer
 #define SERVER_INITIALIZED serverFrameworkInitialized
 #define SERVER_ERRORS serverErrors
 #define OWN_BASE_MARKER_PREFIX QUOTE(TAG.OWN_BASE_)
 #define ENEMY_BASE_MARKER_PREFIX QUOTE(TAG.ENEMY_BASE_)
 #define CLASS_NAME_VARIABLE "currentClassName"
 #define CLASS_CODE_VARIABLE "currentClassCode"
 #define SPAWN_BASE_VARIABLE "lastSpawnBase"
 #define VEHICLE_SPAWN_LAND ["Land_HelipadEmpty_F"]
 #define VEHICLE_SPAWN_AIR ["Land_HelipadCircle_F", "Land_HelipadCivil_F", "Land_HelipadRescue_F", "Land_HelipadSquare_F"]
 #define VEHICLE_ID QGVAR(VehicleID)
 #define VEHICLE_TYPE QGVAR(VehicleType)
 #define FLAGPOLE "FlagPole_F"
 #define IS_ECONOMY_BUILDING QGVAR(IsEconomyBuilding)
 #define IS_RESPAWN_BUILDING QGVAR(IsRespawnBuilding)
 #define TYPE_OF_ECONOMY QGVAR(TypeOfEconomy) 
 #define VEHICLE_CIVIL_PKW ["C_Van_01_fuel_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Offroad_02_unarmed_F","C_Offroad_01_F","C_Offroad_01_repair_F","C_Quadbike_01_F","C_SUV_01_F","C_Van_01_transport_F","C_Van_01_box_F"]
 #define VEHICLE_CIVIL_LKW ["C_Truck_02_fuel_F","C_Truck_02_box_F","C_Truck_02_transport_F","C_Truck_02_covered_F"]
 #define VEHICLE_MILITARY_LKW_WEST ["B_Truck_01_mover_F","B_Truck_01_ammo_F","B_Truck_01_fuel_F","B_Truck_01_medical_F","B_Truck_01_transport_F","B_Truck_01_covered_F"] 
 #define VEHICLE_MILITARY_LKW_EAST ["O_Truck_03_device_F","O_Truck_03_ammo_F","O_Truck_03_fuel_F","O_Truck_03_medical_F","O_Truck_03_repair_F","O_Truck_03_transport_F","O_Truck_03_covered_F","O_Truck_02_Ammo_F","O_Truck_02_fuel_F","O_Truck_02_medical_F","O_Truck_02_box_F","O_Truck_02_transport_F","O_Truck_02_covered_F"]
 #define VEHICLE_MILITARY_HELI_WEST ["B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_Heli_Transport_01_camo_F","B_Heli_Light_01_F"]
 #define VEHICLE_MILITARY_HELI_EAST ["O_Heli_Light_02_F","O_Heli_Light_02_v2_F","O_Heli_Light_02_unarmed_F"]
 #define VEHICLE_MILITARY_TANK_WEST ["B_MBT_01_cannon_F","B_MBT_01_TUSK_F"]
 #define VEHICLE_MILITARY_TANK_EAST ["O_MBT_02_cannon_F"]
 #define VEHICLE_MOBILE_CAMP ["C_Truck_02_covered_F", "C_Truck_02_transport_F"]
 #define VEHICLE_BOAT_SMALL ["B_Boat_Transport_01_F", "O_Boat_Transport_01_F"]
 #define VEHICLE_BOAT_BIG ["B_Boat_Armed_01_minigun_F", "O_Boat_Armed_01_hmg_F"]
 #define VEHICLE_BOAT_TRANSPORT ["B_Truck_01_transport_F", "O_Truck_03_transport_F"]
 #define VALUE_CIV 50
 #define VALUE_RESIST 20
 #define SPAWN_BUILDING_INDICATOR "OurA_IsRespawnBuilding"
 #define SPAWN_BUILDING_POSITIONS "OurA.RespawnBuilding.Positions"
 #define SPAWN_BUILDING_TYPES [["Land_Cargo_House_V1_F","Land_Cargo_HQ_V3_F","Land_Medevac_house_V1_F","Land_Cargo_Tower_V3_F", "Land_Cargo_House_V4_F", "Land_Cargo_HQ_V4_F", "Land_Cargo_Tower_V4_F"], [[], [], [], [9, 18], [], [], [9, 18]]]
 #define ALPHABET_NATO ["Alfa", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "India", "Juliett", "Kilo", "Lima", "Mike", "November", "Oscar", "Papa", "Quebec", "Romeo", "Sierra", "Tango", "Uniform", "Victor", "Whiskey", "X-Ray", "Yankee", "Zulu"]
 #define ALPHABET_RUSSIAN ["Anna", "Boris", "Vasily", "Gregory", "Dmitri", "Yelena", "Zhenya", "Zinaida", "Ivan", "Konstantin", "Leonid", "Mikhail", "Nikolai", "Olga", "Pavel", "Roman", "Semyon", "Tatyana", "Ulyana", "Fyodor", "Khariton", "Tsaplya", "Chelovek", "Shura", "Shchuka", "Yery", "Echo", "Yuri", "Yakov"]
 #define BASEBUILDINGS_SAM ["Land_HBarrier_Big_F", "Land_Cargo_HQ_V3_F", "Land_Cargo_Patrol_V3_F", "Land_Cargo_Tower_V3_F", "Land_BagFence_Corner_F", "Land_BagFence_End_F", "Land_BagFence_Long_F", "Land_BagFence_Round_F", "Land_Cargo_House_V1_F", "Land_BagFence_Short_F"]
 #define BASEBUILDINGS_T ["Land_HBarrier_01_big_4_green_F", "Land_Cargo_HQ_V4_F", "Land_Cargo_Patrol_V4_F", "Land_Cargo_Tower_V4_F", "Land_BagFence_01_corner_green_F", "Land_BagFence_01_end_green_F", "Land_BagFence_01_long_green_F", "Land_BagFence_01_round_green_F", "Land_Cargo_House_V4_F", "Land_BagFence_01_short_green_F"]
 #define HELI_BIG ["B_Heli_Transport_03_unarmed_F", "O_Heli_Transport_04_covered_F"]
