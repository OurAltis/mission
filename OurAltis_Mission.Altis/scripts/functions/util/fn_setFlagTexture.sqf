#include "macros.hpp"
/**
 * OurAltis_Mission - fn_setFlagTexture
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Set flag textur for given side
 * 
 * Parameter(s):
 * 0: Side <Side>
 * 1: Objects <Array> 
 * 
 * Return Value:
 * Flagpole Objects <Array>
 * 
 */

private _success = params [
	["_side", nil, [sideUnknown]],
	["_objs", [], [[]]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _texture = switch (_side) do {
	case west: {"\A3\Data_F\Flags\Flag_nato_CO.paa"};
	case east: {"\A3\Data_F\Flags\Flag_CSAT_CO.paa"};
	case independent: {"\A3\Data_F\Flags\Flag_FIA_CO.paa"};
};

private _return = [];

{
	if (typeOf _x isEqualTo FLAGPOLE) then {
		_x setFlagTexture _texture;
		_return pushBack _x;
	};
	
	nil
} count _objs;

_return
