#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createInvHelipad
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Creates Helipads at base position
 * 
 * Parameter(s):
 * 0: Amount Invisible Helipads <Number>
 * 0: Amount Helipads <Number>
 *
 * Return Value:
 * None <Any>
 * 
 */

private["_success", "_obj", "_marker"]; 
 
_success = _this params[
	["_amountInvHp", 0, [0]],
	["_amountHp", 0, [0]]
];

CHECK_TRUE(_success, Invalid amount!, {});

{
	for "_i" from 1 to _amountInvHp do {	
		_obj = createVehicle ["Land_HelipadEmpty_F", _x select 2, [], 50, "NONE"];
		
		if(DEBUG) then{
			_marker = createMarker [(_x select 0) + str(_i), _obj];
			_marker setMarkerShape "ELLIPSE";
			_marker setMarkerSize [5, 5];
			_marker setMarkerColor "ColorWhite";
		};
	};
	
	for "_i" from 1 to _amountHp do {	
		_obj = createVehicle ["Land_HelipadCircle_F", _x select 2, [], 50, "NONE"];
		
		if(DEBUG) then{
			_marker = createMarker [(_x select 0) + str(_i) + "air", _obj];
			_marker setMarkerShape "ELLIPSE";
			_marker setMarkerSize [5, 5];
			_marker setMarkerColor "ColorBlack";
		};
	};
	nil
} count GVAR(BaseList);

nil
