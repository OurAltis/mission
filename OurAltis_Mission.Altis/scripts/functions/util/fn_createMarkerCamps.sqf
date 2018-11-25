#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createMarkerCamps
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Add camp markers to specific clients
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
{
	if (_x isEqualType []) then {
		_x params [
			["_id", "FALSE", [""]],
			["_position", [0,0,0], [[]]]
		];
	
		private _marker = createMarkerLocal ["marker_camp_" + _id, _position];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "mil_dot";
		_marker setMarkerColorLocal "ColorBlack";
		_marker setMarkerTextLocal ("Camp " + _id);
		
		GVAR(markerCamps) pushBack _marker;
	};
	
	nil
} count PGVAR(markerCamps);

nil 
