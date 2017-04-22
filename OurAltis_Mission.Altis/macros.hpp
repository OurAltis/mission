/*
 * Defines all necessary macros used within the mission
 */

 #define MAJOR 0
 #define MINOR 1
 #define BUILD 0
 
 #define VERSION MAJOR.MINOR.BUILD
 #define QVERSION QUOTE(VERSION)
 
 // indicate that developer mode is on
 #define DEBUG true
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
 	#define DEBUG false
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
 #define VEHICLE_ID QGVAR(VehicleID)
 #define FLAGPOLE "Flag_White_F"
