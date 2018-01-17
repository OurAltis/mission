#include "macros.hpp"
/**
 * OurAltis_Mission - fn_loadUpBoat
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Load up boat.
 * 
 * Parameter(s):
 * 0: Target  <Object>
 * 1: Caller <Object>
 * 2: ID <Scalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_target", objNull, [objNull]],
	["_caller", objNull, [objNull]],
	["_actionID", -1, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _pos = _target modelToWorld [0, -12];

private _marker = createMarker ["tempMarker_boat_" + str(_target), _pos];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerSize [2, 4];
_marker setMarkerColor "ColorRed";
_marker setMarkerDir (getDir _target);

private _objs = _pos nearEntities [VEHICLE_BOAT_SMALL + VEHICLE_BOAT_BIG, 10];

{
	if !(_x inArea _marker) then {
		_objs set [_forEachIndex, objNull];
	};
} forEach _objs;

_objs = _objs - [objNull];

if (count _objs > 1) then {
	hint (localize "OurA_str_BoatToManyBoats");
} else {
	if (count _objs == 0) then {
		hint (localize "OurA_str_BoatNoBoats");
	} else {
		private _boat = _objs select 0;	
		
		if (count (crew _boat) isEqualTo 0) then {		
			if ((typeOf _boat) in VEHICLE_BOAT_SMALL) then {
				_boat attachTo [_target, _boat getVariable [QGVAR(cargoPos), [0,0,0]]];
			} else {
				private _obj = (attachedObjects _target) select 0;
				
				_obj animateSource ["Door_1_sound_source", 0];
				_obj animateSource ["Door_2_sound_source", 0];
				
				deleteVehicle _boat;
			};
			
			_target setVariable [QGVAR(hasCargo), true, true];
		} else {
			hint (localize "OurA_str_BoatCrewInsideBoat");
		};
	};
};

deleteMarker _marker;

nil
