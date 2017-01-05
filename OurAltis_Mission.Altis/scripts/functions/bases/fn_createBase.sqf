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

private ["_dir", "_baseTemplate"];
 
private _success = params[
	["_position", nil, [[]], [2,3]],
	["_side", sideUnknown, [sideUnknown]],
	["_id", nil, [""]],
	["_baseType", 0, [0]],
	["_baseDir", [0, 0], [[]]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

//+90 Degrees because of the orientation of the basetemplates (Mainentrance)
_dir = if(_side isEqualTo west) then{(_baseDir select 0) + 90} else{(_baseDir select 1) + 90};
_baseTemplate = "base" + str(_baseType);

_objs = call compile preprocessfilelinenumbers (format["scripts\compositions\%1.sqf", _baseTemplate]);

[_position, _dir, _objs] call FUNC(objectsMapper);

nil