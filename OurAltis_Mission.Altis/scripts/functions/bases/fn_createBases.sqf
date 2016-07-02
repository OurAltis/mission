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
	
	CHECK_TRUE(_success, Invalid baseFormat!, {})
	
	if(_isCamp) then {
		// create a camp
		[_position, _side, _id] call FUNC(createCamp);
	} else {
		// create a base
		[_position, _side, _id] call FUNC(createBase);
	};
	
	// add base to list
	GVAR(BaseList) pushBack [_id, _side, _position, _isCamp]; // [<ID>, <Side>, <Position>, <IsCamp>]
	
	// add respective respawn positions
	if(count _position < 3) then {
		// convert to Position3D
		_position = [_position select 0, _position select 1, 0];
	};
	
	[_side, _position, _id] call BIS_fnc_addRespawnPosition;
	
	nil;
} count _this;

[EVENT_BASES_INITIALIZED, []] call FUNC(fireGlobalClientEvent);

nil;
