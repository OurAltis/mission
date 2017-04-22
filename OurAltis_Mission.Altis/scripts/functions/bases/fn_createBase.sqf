#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createBase
 * 
 * Author: Raven
 * 
 * Description:
 * Creates a base at the given position
 * 
 * Parameter(s):
 * 0: Position <Position3D, Position2D>
 * 1: BaseSide <Side>
 * 2: ID <String>
 * 3: Base Type <Number>
 * 4: Base Direction [dirWest, dirEast] <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
private _success = params [
	["_position", nil, [[]], [2,3]],
	["_side", sideUnknown, [sideUnknown]],
	["_id", nil, [""]],
	["_baseType", 0, [0]],
	["_baseDir", 0, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _baseTemplate = "base" + str(_baseType);
private _objs = call compile preprocessfilelinenumbers (format["scripts\compositions\%1.sqf", _baseTemplate]);
private _flagpole = [_position, _baseDir, _objs, FLAGPOLE] call FUNC(objectsMapper);

_flagpole setFlagTexture ([_side] call FUNC(getFlagTexture));

nil
