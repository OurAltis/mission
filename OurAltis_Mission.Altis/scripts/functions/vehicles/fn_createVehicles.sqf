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
 
private _vehicleListSide = [west, [], east, []];
 
{	
	private _success = _x params [
		["_id", nil, [""]],
		["_side", sideUnknown, [sideUnknown]],
		["_position", nil, [[]], [2,3]],
		["_isCamp", nil, [true]]
	];
	
	private _vehicleListBase = [_id, []];
	
	CHECK_TRUE(_success, Invalid baseFormat!)	
	
	{
		_success = _x params [
			["_type", "", [""]],
			["_fuel", 0, [0]],
			["_damage", 0, [0]],
			["_spawn", "", [""]],
			["_vehID", "", [""]]
		];

		CHECK_TRUE(_success, Invalid vehicleFormat!)
		
		if (_spawn isEqualTo _id) then {
			(_vehicleListBase select 1) pushBack _type;
			
			private _objList = if (_type isKindOf "LandVehicle") then {
				nearestObjects [_position, VEHICLE_SPAWN_LAND, 80];
			} else {
				nearestObjects [_position, VEHICLE_SPAWN_AIR, 80];
			};		
			
			_objList = [_objList, 100] call FUNC(KK_arrayShuffle);
			
			private _return = {
				if (!(_x getVariable [QGVAR(VehiclePlaced), false])) exitWith {
					_obj = createVehicle [_type, _x, [], 0, "CAN_COLLIDE"];
					_obj setFuel _fuel;
					_obj setDamage _damage;
					_obj setDir (getDir _x);
					
					clearWeaponCargoGlobal _obj;
					clearBackpackCargoGlobal _obj;
					clearMagazineCargoGlobal _obj;
					clearItemCargoGlobal _obj;
					
					// save the vehicle's ID
					_obj setVariable [VEHICLE_ID, _vehID];
					
					// add EH for vehicle destruction (MP-EH is needed in case the vehicle's locality changes (e.g. a player enter it))
					_obj addMPEventHandler [
						"MPKilled", {
							if (isServer) then {
								// set the damage to 1 in case it died of critical hit
								(_this select 0) setDamage 1;
								
								// report destroyed vehicle to the DB immediately
								[_this select 0] call FUNC(reportVehicleStatus);
							};
							
							nil
						}
					];
					
					_x setVariable [QGVAR(VehiclePlaced), true];
					
					true
				};				
			} count _objList;		
			
			if(_return isEqualTo 0) then{GVAR(VehicleListVirtual) pushback _x};			
		};
		
		nil
	} count _this;
	
	if (_side isEqualTo (_vehicleListSide select 0)) then {
		(_vehicleListSide select 1) pushBack _vehicleListBase;
	} else {
		(_vehicleListSide select 3) pushBack _vehicleListBase;
	};	
	
	nil
} count GVAR(BaseList);

GVAR(Vehicles) = +_vehicleListSide;
diag_log GVAR(Vehicles);

nil
