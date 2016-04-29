/*
* Sets the whether conditions
*
* @param The wheather code consisting of 3 digits: <rain><fog><night> (1 = true, 0 = false)
*		-> example: rainy day without fog: 100
* @param The date consisting of year, month and day: [<year>, <month>, <day>]
*/
scopeName "rvn_configureMissionParameter";

private _wheatherCode = param [0, [0,0,0], [["Array"]], 3];
private _date = param [1,[2035, 3, 15], [["Array"]], 3];

private _rain = _wheatherCode param [0, 0, [0]];
private _fog = _wheatherCode param [1, 0, [0]];
private _night = (_wheatherCode param [2, 0, [0]]) == 1;

// validate parameters
if(_rain < 0 || _rain > 1) then {
	[0, "Invalid rain value (" + _rain + ")"] call rvn_fnc_log;
	_rain = 0;
};
if(_fog < 0 || _fog > 1) then {
	[0, "Invalid fog value (" + _fog + ")"] call rvn_fnc_log;
	_fog = 0;
};
private _month = _date select 1;
private _day = _date select 2;
if(_month < 1 || _month > 12) then {
	[0, "Invalid month (" + _month + ")"] call rvn_fnc_log;
	_date set [1, 3];
};
if(_day < 1 || _day > 31) then {
	[0, "Invalid day(" + _day + ")"] call rvn_fnc_log;
	_date set [2, 15];
};
_month = nil;
_day = nil;


//	randomize strengths
_rain = random [_rain*0.5, _rain*0.75, _rain];
_fog = random [_fog*0.5, _fog*0.75, _fog];

// get random time
if(_night) then {
	_nightHours = [21, 22, 23, 24, 1, 2, 3];
	_hour = _nightHours select (floor random count _nightHours) ;
	
	_date set [3, _hour];
} else {
	_dayHours = [11, 12, 13, 14, 15, 16, 17];
	_hour = _dayHours select (floor random count _dayHours) ;
	
	_date set [3, _hour];
};

// set minutes
_date set [4, floor random 60];

// apply parameters
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
