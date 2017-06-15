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
	["_args", [], [[]]],
	["_handle", -1, [0]]
];

_args params [
	["_marker", "", [""]],
	["_deltaR", 0, [0]]
];

private _mSize = ((getMarkerSize _marker) select 0) - _deltaR;
_marker setMarkerSize [_mSize, _mSize];

if (_mSize <= 0) then {
	[_handle] call CBA_fnc_removePerFrameHandler;
};

nil
