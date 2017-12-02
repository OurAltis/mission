#include "macros.hpp"
/**
 * OurAltis_Mission - fn_displayServerErrorMessages
 * 
 * Author: Raven
 * 
 * Description:
 * Displays the error messages recceiveed from the server to the user.
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

for "_i" from 0 to count PGVAR(SERVER_ERRORS) do {
	if(_i == count PGVAR(SERVER_ERRORS)) exitWith {
		[
			{
				if(_this select 0 > 0) then {
					("loadingScreen" + str ((_this select 0) - 1)) cutFadeOut 1;
				};
			
				"errorMessage" + str (_this select 0) + "BlackScreen" cutText [
					localize "OurA_str_ServerInitFailed",
					"BLACK",
					0.5,
					true];
			},
			[_i],
			_i * 5
		] call CBA_fnc_waitAndExecute;
	};
	
	[
		{
			params ["_screenNumber", "_msg"];
			
			if(_screenNumber > 0) then {
				("loadingScreen" + str (_screenNumber - 1)) cutFadeOut 1;
			};
			
			("loadingBlackScreen" + str _screenNumber) cutText ["Server error: " + _msg, "BLACK", 0.5, true];
		},
		[_i, PGVAR(SERVER_ERRORS) select _i],
		_i * 5
	] call CBA_fnc_waitAndExecute;
};

nil;
