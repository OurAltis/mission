#include "macros.hpp"
/**
 * OurAltis_Mission - fn_getLoadoutsForBase
 * 
 * Author: Raven
 * 
 * Description:
 * Gets the available loadouts for the given base
 * 
 * Parameter(s):
 * 0: The base's ID <String>
 * 1: The infantry list as returned from the server <Array>
 * 
 * Return Value:
 * The list of available loadouts in format [[<ClassName>, amount], ...] <Array>
 * 
 */

private ["_success", "_infantryCollection"];

_success = params [
	["_baseID", nil, [""]],
	["_infantryList", [], [[]]]
];

CHECK_TRUE(_success, Invalid parameters!, {});

_infantryCollection = [];

// search for the base and retrieve the respective infantry list
{
	private _exit = false;
	
	for "_i" from 1 to (count _x) do {
		private _currentList = _x select _i;
		
		{
			if(_baseID in _x) exitWith {
				_infantryCollection = _x select 1;
				_exit = true;
			};
			
			nil;
		} count _currentList;
		
		if(_exit) exitWith {};
	};
	
	nil;
} count _infantryList;

// return the list
_infantryCollection;
