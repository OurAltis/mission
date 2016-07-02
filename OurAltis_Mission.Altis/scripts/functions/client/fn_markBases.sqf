#include "macros.hpp"
/**
 * OurAltis_Mission - fn_markBases
 * 
 * Author: Raven
 * 
 * Description:
 * Marks all bases on the map. The own bases are marked precice and the enemy bases roughly
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */
[
	{
		params [
			["_baseList", [], [[]]]
		];
		
		// loop through all bases
		{
			private ["_success", "_marker", "_offset"];
			
			_success = _x params [
				["_id", "", [""]],
				["_side", sideUnknown, [west]],
				["_position", nil, [[]], [2, 3]]
			];
			
			CHECK_TRUE(_success, Invalid base information!)
			
			if(_side isEqualTo (side player)) then {
				// own base -> mark precicely
				
				_marker = createMarkerLocal [_id, _position];
				_marker setMarkerTextLocal _id;
				_marker setMarkerTypeLocal "b_hq";
			} else {
				// enemy base -> mark roughly
				
				// mark exact base location
				private _tester = createMarker [_id + "Tester", _position];
				_tester setMarkerTypeLocal "mil_dot";
				_tester setMarkerTextLocal _id;
				
				_offset = GVAR(BaseMarkerOffset) select _forEachIndex;
				
				// randomize position
				_position = [(_position select 0) + (_offset select 0), (_position select 1) + (_offset select 1)];
				_marker = createMarkerLocal [_id, _position];
				_marker setMarkerShapeLocal "ELLIPSE";
				_marker setMarkerSizeLocal [GVAR(MarkerAccuracy), GVAR(MarkerAccuracy)];
				_marker setMarkerColorLocal "ColorRed";
				_marker setMarkerAlphaLocal 0.5;
			};
		} forEach _baseList;
	},
	[]
] call FUNC(workWithBaseList);

nil;
