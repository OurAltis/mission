#include "macros.hpp"
/**
 * OurAltis_Mission - fn_shrinkMarker
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Shrink marker size
 * 
 * Parameter(s):
 * 0: Marker <String>
 * 1: Value <Scalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */

_this params [
	["_args", [], [[]]]
];

diag_log _this;

_args params [
	["_marker", "", [""]],
	["_deltaR", 0, [0]]
];

diag_log _args;

private _mSize = ((getMarkerSize _marker) select 0) - _deltaR;
_marker setMarkerSize [_mSize, _mSize];

nil
