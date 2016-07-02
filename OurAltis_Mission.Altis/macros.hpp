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
 #define QGVAR(var) QUOTE(GVAR(msg))
 
 #define FUNC(function) TAG##_fnc_##function
 #define QFUNC(function) QUOTE(FUNC(function))
 
 #define QUOTE(txt) #txt 
 
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
 #define ERROR_LOG(msg) LOG(OurAltis VERSION [Error]: msg)
 #define NOTIFICATION_LOG(msg) LOG(OurAltis VERSION [Notification]: msg)
 #define WARNING_LOG(msg) LOG(OurAltis VERSION [Warning]: msg)
 
 #define SCRIPT_REFERENCE format["(%1: %2)", _fnc_scriptName, __LINE__]
 
 #ifdef SHOW_ONSCREEN_NOTIFICATIONS
 	//TODO: use popup window for error display
 	#define LOG(msg) diag_log (QUOTE(msg) + SCRIPT_REFERENCE); hint (QUOTE(msg) + " " + SCRIPT_REFERENCE);
 	#define LOG_VAR(var) diag_log (str var + SCRIPT_REFERENCE); hint (str var + " " + SCRIPT_REFERENCE);
 #else
	 #define LOG(msg) diag_log (QUOTE(msg) + " " + SCRIPT_REFERENCE);
	 #define LOG_VAR(var) diag_log (str var + " " + SCRIPT_REFERENCE);
 #endif
 
 
 
 // define event IDs
 #define EVENT_PREFIX OurAltis.Event
 
 #define EVENT_BASE_LIST_REQUEST QUOTE(EVENT_PREFIX.getBaseList)
 #define EVENT_BASE_LIST_RECEIVED QUOTE(EVENT_PREFIX.baseListReceived)
 
 #define EVENT_INFANTRY_LIST_REQUEST QUOTE(EVENT_PREFIX.getInfantryList)
 #define EVENT_INFANTRY_LIST_RECEIVED QUOTE(EVENT_PREFIX.InfantryListReceived)
 
 #define EVENT_BASES_INITIALIZED QUOTE(EVENT_PREFIX.basesInitialized)
