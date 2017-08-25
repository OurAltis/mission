#include "macros.hpp"
/**
 * OurAltis_Mission - fn_setMissionParameter
 * 
 * Author: Raven
 * 
 * Description:
 * Sets the mission parameters to the given values
 * 
 * Parameter(s):
 * 0: Weather <Number>
 * 1: Daytime <Number>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_weather", 0, [0]],
	["_hour", 0, [0]],
	["_minute", 0, [0]]
];

CHECK_TRUE(_success, Invalid mission parameters!, {})

private _date = date;
_date set [3, _hour];
_date set [4, _minute];
setDate _date;

_weather = switch (_weather) do {
	case 0: {[0, 0, 0]};
	case 1: {[0, 0, 1]};
	case 2: {[1, 0, 1]};
	case 3: {[0, 1, 1]};
	case 4: {[1, 1, 1]};
};

if ((_weather select 2) isEqualTo 0) then {
	300 setOvercast 0;
} else {
	300 setOvercast 0.55;
};

forceWeatherChange;

if ((_weather select 1) isEqualTo 0) then {
	0 setFog 0;
} else {
	0 setFog (random [0, 1, 0.5]);
};

if ((_weather select 0) isEqualTo 0) then {
	0 setRain 0;
} else {
	0 setRain (random [0, 1, 0.5]);
};

nil
