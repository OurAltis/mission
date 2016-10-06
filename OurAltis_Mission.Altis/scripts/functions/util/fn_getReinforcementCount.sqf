#include "macros.hpp"
/**
 * OurAltis_Mission - fn_getReinforcementCount
 * 
 * Author: Raven
 * 
 * Description:
 * This function finds the amount of reinforcements for a given class in a given base
 * 
 * Parameter(s):
 * 0: The classname the reinforcements should be checked for <String>
 * 1: The base name to search for <String>
 * 2: The infantry list <Array format InfantryList>
 * 
 * Return Value:
 * The amount of reinforcements <Number>
 * 
 */

private ["_success", "_finished", "_amount"];

_succes = params [
	["_className", "", [""]],
	["_baseName", "", [""]],
	["_infantryList", [],[[]]]
];

CHECK_TRUE(_succes, Invalid parameters!, {})

_amount = 0;
_finished = false;

// iterate through the list in orde to find amount -> see formats.txt for structure details
{
	_x params ["_side", "_baseInfantryList"];
	
	if(_side isEqualTo (side player)) then {
		{			
			_x params ["_base", "_infantryCollection"];
			
			if(_base isEqualTo _baseName) then {
				{
					// read out actual amount
					if((_x select 0) isEqualTo _className) exitWith {_amount = _x select 1;};
				} count _infantryCollection;
				
				_finished = true;
			};
			
			if(_finished) exitWith {}; // exit loop
			
			nil;
		} count _baseInfantryList;
		
		_finished = true;
	};
	
	if(_finished) exitWith {}; // exit loop
	
	nil;
} count _infantryList;

// return reinforcements amount
_amount;
