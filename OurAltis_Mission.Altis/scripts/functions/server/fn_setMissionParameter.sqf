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
 * 0: The rain value (ranging from 0 to 1) <Number>
 * 1: The fog value (ranging from 0 to 1) <Number>
 * 2: The daytime (0 or 1, where 1 means night) <Number>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_rain", 0, [0]],
	["_fog", 0, [0]],
	["_daytime", 0, [0]]
];

CHECK_TRUE(_success, Invalid mission parameters!, {})


//	randomize strengths
_rain = random [_rain*0.5, _rain*0.75, _rain];
_fog = random [_fog*0.5, _fog*0.75, _fog];

_date = date;

// get random time
if(_daytime == 1) then {
	_hour = [21, 22, 23, 24, 1, 2, 3] select (floor random 7) ;
	
	_date set [3, _hour];
} else {
	_hour = [10, 11, 12, 13, 14, 15, 16] select (floor random 7) ;
	
	_date set [3, _hour];
};

_date set [4, floor random 60];

// apply values
if(_rain != 0) then {
	// make rain possible
	86400 setOvercast 1;
	
	_date set [2, (_date select 2) - 1];
};

0 setRain _rain;
0 setFog _fog;
setDate _date;

if(_rain != 0) then {
	skipTime 24;
};
