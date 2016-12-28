#include "macros.hpp"
/**
 * OurAltis_Mission - fn_getBaseSide
 * 
 * Author: Raven
 * 
 * Description:
 * Gets the side of the given base. Has to be executed on server!
 * 
 * Parameter(s):
 * 0: The base's name <String>
 * 
 * Return Value:
 * The base's side (sideUnknown if something goes wrong) <Side>
 * 
 */

private _success = params[
	["_base", "", [""]]
];

CHECK_TRUE(_success, Invalid baseName!)

private _baseSide = sideUnknown;

{
	_x params["_id", "_side"];
	
	if(_id isEqualTo _base) exitWith {_baseSide = _side};
	
	nil;
} count GVAR(BaseList);

_baseSide;
