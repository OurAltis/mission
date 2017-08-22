#include "macros.hpp"
/*
* SL_Markierungsdienst - fn_initClient
* 
* Author: PhilipJFry
* 
* Description:
* Initializes SL Markierungsdienst on the client
* 
* Parameter(s):
* 0: None <ANY>
* 
* Return Value:
* None <ANY>
*/

FUNC(getSide) = compile preprocessFileLineNumbers "scripts\slmd\fn_getSide.sqf";
FUNC(slowCode) = compile preprocessFileLineNumbers "scripts\slmd\fn_slowCode.sqf";
FUNC(realTimeCode) = compile preprocessFileLineNumbers "scripts\slmd\fn_realTimeCode.sqf";

GVAR(relevantUnits) = [];
GVAR(kRain) = 0;
GVAR(kFog) = 0;
GVAR(kDayKnight) = 0;
GVAR(knightVision) = 0;

[player] call FUNC(getSide);

[
	FUNC(slowCode),	
	5,
	[]
] call CBA_fnc_addPerFrameHandler;

[
	FUNC(realTimeCode),
	0,
	[]
] call CBA_fnc_addPerFrameHandler;

[] spawn {
	waitUntil {!isNull (findDisplay 46)};
	
	systemChat "SL Markierungsdienst: Verbunden";
};

nil
