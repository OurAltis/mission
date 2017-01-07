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
 
private _baseDir = _this call FUNC(getBaseDir);
 
{
	private ["_success"];
	
	_success = _x params[
		["_position", nil, [[]], [2,3]],
		["_side", sideUnknown, [sideUnknown]],
		["_id", nil, [""]],
		["_isCamp", nil, [true]],
		["_baseType", 0, [0]]
	];
	
	CHECK_TRUE(_success, Invalid baseFormat!, {});	
	
	if(_isCamp) then {
		// create a camp
		[_position, _side, _id] call FUNC(createCamp);
	} else {
		// create a base
		[_position, _side, _id, _baseType, _baseDir] call FUNC(createBase);
	};
	
	// add base to list
	GVAR(BaseList) pushBack [_id, _side, _position, _isCamp]; // [<ID>, <Side>, <Position>, <IsCamp>]
	
	nil;
} count _this;

[EVENT_BASES_INITIALIZED, []] call FUNC(fireGlobalClientEvent);

nil
