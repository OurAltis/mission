#include "macros.hpp"
/**
 * OurAltis_Mission - fn_deployBoat
 * 
 * Author: Raven
 * 
 * Description:
 * Unload boat.
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

private _obj = (attachedObjects _target) select 0;
private _pos = _obj modelToWorld [0, -10, 1];

if (surfaceIsWater _pos && !(lineIntersects [_pos, [_pos select 0, _pos select 1, -10]])) then {
	if (typeOf _obj in VEHICLE_BOAT_SMALL) then {
		_obj attachTo [_target, [0, -10, 1]];
		detach _obj;
	} else {
		_obj animateSource ["Door_1_sound_source", 1];
		_obj animateSource ["Door_2_sound_source", 1];
		
		private _index = VEHICLE_BOAT_TRANSPORT find (typeOf _target);
		private _veh = createVehicle [VEHICLE_BOAT_BIG select _index, [0,0,0], [], 0, "CAN_COLLIDE"];
		_veh setDir (getDir _target);
		_veh setPos (_target modelToWorld [0, -15, 1]);
		detach _veh;
	};
	
	_target setVariable [QGVAR(hasCargo), false, true];
} else {
	hint (localize "OurA_str_BoatNoWater");
};

nil
