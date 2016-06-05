#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createBases
 * 
 * Author: Raven
 * 
 * Description:
 * Creates and initializes the given bases
 * 
 * Parameter(s):
 * 0: Bases <Array> - format [Position<Position3D, Position2D>, baseSide<Side>, ID<String>, isCamp<Boolean>]
 * 
 * Return Value:
 * None <Any>
 * 
 */

{
	private _success = _x params[
			["_position", nil, [[]], [2,3]],
			["_side", sideUnknown, [sideUnknown]],
			["_id", nil, [""]],
			["_isCamp", nil, [true]]
		];
	
	CHECK_TRUE(_success, Invalid parameters!)
	
	if(_isCamp) then {
		// create a camp
		[_position, _side, _id] call FUNC(createCamp);
	}else {
		// create a base
		[_position, _side, _id] call FUNC(createBase);
	};
	
} count _this;

// broadcast base list TODO: write function to acces bases from server
publicVariable QGVAR(BaseList);
