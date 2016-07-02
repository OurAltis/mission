#include "macros.hpp"
/**
 * OurAltis_Mission - fn_calculateOffset
 * 
 * Author: Raven
 * 
 * Description:
 * Calculates an offset of the given length. The direction of the offset is chosen at random
 * 
 * Parameter(s):
 * 0: The length of the offset (positive for left association, negative for rigth association) <Number>
 * 
 * Return Value:
 * The calculated offset (format: [_x, _y]) <Array>
 * 
 */

params [
	["_length", nil, [0]]
];

CHECK_FALSE(isNil "_length", Invalid offset length!, {})

private ["_x", "_y", "_result"];

// calculate in which direction the offset should be
_dir = floor random 360;


_y = floor ((cos _dir) * _length);
_x = floor sqrt((_length ^ 2) - (_y ^ 2));

if(_length < 0) then {
	// counter the fact that squaring always results in a positive number
	_x = -_x;
};

_result = [_x, _y];

_result;
