#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createCarrier
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Creates a carrier at the given position
 * 
 * Parameter(s):
 * 0: Position <Position3D, Position2D>
 * 1: BaseSide <Side>
 * 2: ID <String>
 * 3: Base Direction <Scalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
private _success = params [
	["_position", nil, [[]], [2,3]],
	["_side", sideUnknown, [sideUnknown]],
	["_id", nil, [""]],
	["_baseDir", 0, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _objsArray = call compile preprocessfilelinenumbers "scripts\compositions\carrier.sqf";

_objsArray = [_position, _baseDir, _objsArray, [], true] call FUNC(objectsMapper);

nil
