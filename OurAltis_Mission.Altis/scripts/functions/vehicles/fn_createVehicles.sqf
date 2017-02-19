#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createVehicles
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Creates the Vehicles at Bases
 * 
 * Parameter(s):
 * 0: Vehicles <Array> - format [Type<Classname>, Fuel Level<Number>, Damage Level<Number>, Spawn<BaseID>, ID<Number>]
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
{
	private["_success", "_objList", "_return"];
	
	_success = _x params [
		["_id", nil, [""]],
		["_side", sideUnknown, [sideUnknown]],
		["_position", nil, [[]], [2,3]],
		["_isCamp", nil, [true]]
	];

	CHECK_TRUE(_success, Invalid baseFormat!)
	
	{
		_success = _x params [
			["_type", "", [""]],
			["_fuel", 0, [0]],
			["_damage", 0, [0]],
			["_spawn", "", [""]],
			["_vehID", -1, [0]]
		];

		CHECK_TRUE(_success, Invalid vehicleFormat!)
		
		if(_spawn isEqualTo _id) then{
			_objList = if(_type isKindOf "LandVehicle") then{
				nearestObjects [_position, ["Land_HelipadEmpty_F"], 80];
			} else {
				nearestObjects [_position, ["Land_HelipadCircle_F", "Land_HelipadCivil_F", "Land_HelipadRescue_F", "Land_HelipadSquare_F"], 80];
			};		
			
			_objList = [_objList, 100] call FUNC(KK_arrayShuffle);
			
			_return = {
				if(!(_x getVariable [QGVAR(VehiclePlaced), false])) exitWith{
					_obj = createVehicle [_type, _x, [], 0, "CAN_COLLIDE"];
					_obj setFuel _fuel;
					_obj setDamage _damage;	
					_obj setDir (getDir _x);
					
					_obj setVariable [VEHICLE_ID, _vehID];
					_x setVariable [QGVAR(VehiclePlaced), true];
					
					true
				};				
			} count _objList;		
			
			if(_return isEqualTo 0) then{GVAR(VehicleListVirtual) pushback _x};			
		};
		
		nil
	} count _this;
	
	nil
} count GVAR(BaseList);

nil
