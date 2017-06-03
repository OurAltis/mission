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
 
private _baseVehicleList = [west, [], east, []];
 
{	
	private _success = _x params [
		["_id", nil, [""]],
		["_side", sideUnknown, [sideUnknown]],
		["_position", nil, [[]], [2,3]],
		["_isCamp", nil, [true]]
	];
	
	CHECK_TRUE(_success, Invalid baseFormat!)	
	
	private _sideVehicleList = [_id, []];
	private _vehicleType = [];
	private _vehicleCount = [];
	
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
			private _return = _vehicleType pushBackUnique _type;
			
			if (_return isEqualTo -1) then {
				private _index = _vehicleType find _type;
				
				if (count _vehicleCount >= (_index + 1)) then {
					if (isNil {_vehicleCount select _index}) then {
						_vehicleCount set [_index, 1];
					} else {
						_vehicleCount set [_index, (_vehicleCount select _index) + 1];
					};					
				} else {
					_vehicleCount set [_index, 1];
				};				
			};
			
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
	
	{
		(_sideVehicleList select 1) pushBack [_x, _vehicleCount select _forEachIndex];
	} forEach _vehicleType;
	
	if (_side isEqualTo (_baseVehicleList select 0)) then {
		(_baseVehicleList select 1) pushBack _sideVehicleList;
	} else {
		(_baseVehicleList select 3) pushBack _sideVehicleList;
	};	
	
	nil
} count GVAR(BaseList);

GVAR(Vehicles) = +_baseVehicleList;
diag_log GVAR(Vehicles);

nil
