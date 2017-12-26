#include "macros.hpp"

/**
 * OurAltis_Mission - fn_getNearestBase
 * 
 * Author: Raven
 * 
 * Description:
 * Gets the nearest base or camp from the given position of the given side
 * 
 * Parameter(s):
 * 0: The reference position <Position>
 * 1: The side the returned base should have <Side>
 * 
 * Return Value:
 * The respective Base <Array - format Base>
 * 
 */

CHECK_TRUE(isServer, Function can only be executed on server!, {})

private _success = params[
	["_pos", [0,0,0], [[]], [2,3]],
	["_side", sideUnknown, [sideUnknown]]
];

CHECK_TRUE(_success, Invalid parameters, {})

private _distance = -1;
private _base = [];

_pos set [2,0]; // make sure z-index is present and zero

{
	if !((_x select 2) isEqualTo _side) then {
		(_x select 2) set [2,0]; // make sure z-index is present and zero
		
		private _currentDist = _pos vectorDistance (_x select 2);
		
		if(_currentDist < _distance || _distance < 0) then {
			_distance = _currentDist;
			_base = _x;
		};
	};
	
	nil;
} count GVAR(BaseList)

_base
