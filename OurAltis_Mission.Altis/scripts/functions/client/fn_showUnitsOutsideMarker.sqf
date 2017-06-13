#include "macros.hpp"
/**
 * OurAltis_Mission - fn_showUnitsOutsideMarker
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Show units outside of marker
 * 
 * Parameter(s):
 * 0: Marker <String>
 * 
 * Return Value:
 * None <Any>
 * 
 */

_this params [
	["_args", [], [[]]]
];

_args params [
	["_marker", "", [""]]
];

{	
	if (alive _x) then {
		if !(_x inArea _marker) then {
			if !(side (group _x) isEqualTo side (group player) && isPlayer _x) then {
				if ((allMapMarkers find str(_x)) isEqualTo -1) then {
					private _unitMarker = createMarkerLocal [str(_x), position _x];
					_unitMarker setMarkerShapeLocal "ICON";
					_unitMarker setMarkerTypeLocal (if (side (group _x) isEqualTo west) then {"b_inf"} else {"o_inf"});					
				} else {
					(allMapMarkers select (allMapMarkers find str(_x))) setMarkerPosLocal (position _x);
				};		
			};
		} else {
			if !((allMapMarkers find str(_x)) isEqualTo -1) then {
				deleteMarkerLocal str(_x);
			};
		};
	} else {
		if !((allMapMarkers find str(_x)) isEqualTo -1) then {
			deleteMarkerLocal str(_x);
		};
	};	
} count allPlayers;

nil
