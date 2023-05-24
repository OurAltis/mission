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
 * 0: Bases <Array> - format [Position<Position3D, Position2D>, baseSide<Side>, ID<String>, spawn<String>, baseLevel<Scalar>, angle<Scalar>]
 *
 * Return Value:
 * None <Any>
 * 
 */

private _attackerSide = [GVAR(defenderSide), false] call FUNC(getAttackerSide);

GVAR(markerNoCiv) = [];
PGVAR(markerCamps) = [_attackerSide];

{
	private ["_success"];
	
	_success = _x params[
		["_position", nil, [[]], [2,3]],
		["_side", sideUnknown, [sideUnknown]],
		["_id", nil, [""]],
		["_spawn", nil, [""]],
		["_baseType", 0, [0]],
		["_baseDir", 0, [0]],
		["_baseNumber", 1, [0]]
	];
	
	CHECK_TRUE(_success, Invalid baseFormat!, {});	
	
	// Workaround do to inconsistent position variable in DB (_falgpolPos)
	private _flagpolPos = switch (_spawn) do {
		case "camp": {
			// create a camp
			[_position, _side, _id, _baseDir, _baseNumber] call FUNC(createCamp);
		};

		case "base": {
			// create a base
			[_position, _side, _id, _baseType, _baseDir, _baseNumber] call FUNC(createBase);
		};
		
		case "carrier": {
			// create a carrier
			[_position, _side, _id, random 360] call FUNC(createCarrier);
		};
	};	
	
	// add base to list
	GVAR(BaseList) pushBack [_id, _side, _flagpolPos, _spawn]; // [<ID>, <Side>, <Position>, <Spawn>]
	
	nil;
} count _this;

[EVENT_BASES_INITIALIZED, []] call FUNC(fireGlobalClientEvent);

nil
