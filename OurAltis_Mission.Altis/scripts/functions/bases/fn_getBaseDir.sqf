#include "macros.hpp"
/**
 * OurAltis_Mission - fn_getBaseDir
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Calculate direction from base to base for every side
 * 
 * Parameter(s):
 * 0: Bases <Array> - format [Position<Position3D, Position2D>, baseSide<Side>, ID<String>, isCamp<Boolean>]
 * 
 * Return Value:
 * [directionWest, directionEast] <Array>
 * 
 */

private["_positionWest", "_positionEast"];

{
	private _success = _x params[
		["_position", nil, [[]], [2, 3]],
		["_side", nil, [sideUnknown]],
		["_id", nil, [""]],
		["_isCamp", nil, [true]]
	];

	CHECK_TRUE(_success, Invalid parameters!, {})
	
	if(!_isCamp) then{
		if(_side isEqualTo east) then{_positionEast = _position} else{_positionWest = _position};
	};
	
	nil
} count _this;

[_positionWest getDir _positionEast, _positionEast getDir _positionWest]