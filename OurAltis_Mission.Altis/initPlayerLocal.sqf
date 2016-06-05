#include "macros.hpp"
/**
 * OurAltis_Mission - initPlayerLocal.sqf
 * 
 * Author: Raven
 * 
 * Description:
 * Initializes OurAltis on the client
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

// create markers for bases
{
	_x params ["_id", "_side", "_position", ""];
	
	if(_side == side player) then {
		private _marker = createMarker [format["base", _forEachIndex], _position];
		_marker setMarkerText _id;
		_marker setMarkerType "mil_triangle"
	};
} forEach GVAR(BaseList);
