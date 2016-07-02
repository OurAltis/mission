#include "macros.hpp"
/**
 * OurAltis_Mission - fn_removeEventHandlerType
 * 
 * Author: Raven
 * 
 * Description:
 * Removes the given EH type with all the registered handler
 * 
 * Parameter(s):
 * 0: The EventHandler type to remove <String>
 * 
 * Return Value:
 * True on successfull removal <Boolean>
 * 
 */

params [
	["_type", "", [""]]
];

private _removed = false;

{
	if((_x select 0) isEqualTo _type) then {
		GVAR(EventHandler) set [_forEachIndex, objNull];
		_removed = true;
	};
	
	if(_removed) exitWith {};
} forEach +GVAR(EventHandler);

if(_removed) then {
	// remove nil elements from Array
	GVAR(EventHandler) = GVAR(EventHandler) - [objNull];
};

_removed;
