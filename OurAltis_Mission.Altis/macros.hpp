/*
 * Defines all necessary macros used within the mission
 */
 
 #define MAJOR 0
 #define MINOR 1
 #define BUILD 0
 
 #define VERSION MAJOR.MINOR.BUILD
 
 // indicate that developer mode is on
 #define DEBUG true
 #define SHOW_ONSCREEN_NOTIFICATIONS true
 
 
 #define TAG OurA
 
 #define GVAR(var) TAG##var
 #define QGVAR(var) QUOTE(GVAR(msg))
 
 #define FUNC(function) TAG##_fnc_##function
 
 #define QUOTE(txt) #txt 
 
 // Debug tools
 #ifdef DEBUG
 	// define debug macros
 	#define CHECK_TRUE(bool) if (!bool) then { ERROR_LOG(Expected true but was false) };
 	#define CHECK_TRUE(bool, msg) if (!bool) then { ERROR_LOG(msg) };
 	#define CHECK_FALSE(bool) if (bool) then { ERROR_LOG(Expected false but was true) };
 	#define CHECK_FALSW(bool, msg) if (bool) then { ERROR_LOG(msg) };
 #else 
 	// do nothing
 	#define CHECK_TRUE(bool)
 	#define CHECK_TRUE(bool, msg)
 	#define CHECK_FALSE(bool)
 	#define CHECK_FALSE(bool, msg)
 #endif
 
 // Logging
 #define ERROR_LOG(msg) LOG(OurAltis VERSION [Error]: msg)
 #define NOTIFICATION_LOG(msg) LOG(OurAltis VERSION [Notification]: msg)
 #define WARNING_LOG(msg) LOG(OurAltis VERSION [Warning]: msg)
 
 #define SCRIPT_REFERENCE format["(%1: %2)", _fnc_scriptName, __LINE__]
 
 #ifdef SHOW_ONSCREEN_NOTIFICATIONS
 	//TODO: use popup window for error display
 	#define LOG(msg) diag_log QUOTE(msg) + SCRIPT_REFERENCE; hint QUOTE(Log: msg) + SCRIPT_REFERENCE;
 #else
	 #define LOG(msg) diag_log QUOTE(msg (_fnc_scriptName: __LINE__));
 #endif
