#include "macros.hpp"
/*
* SL_Markierungsdienst - fn_getSide
* 
* Author: PhilipJFry
* 
* Description:
* Get side of the player and color of the side
* 
* Parameter(s):
* 0: Object <OBJECT>
* 
* Return Value:
* None <ANY>
*/

params [
	["_unit", objNull, [objNull]]	
];

GVAR(side) = side group _unit;
[GVAR(side), false] call BIS_fnc_sideColor;

nil
