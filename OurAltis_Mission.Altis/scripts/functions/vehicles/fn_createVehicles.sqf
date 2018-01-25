#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createVehicles
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Creates the Vehicles at Bases. Note that the specified damage can either be a number ranging from 0 to 1 which will the�n be applied via setDamage. 
 * The alternative is to provide the array returned by getAllHitPointsDamage or the String representation of that array obtained via the str command. 
 * If this approach is chosen then the damage for the different HitPoints are transferred to the vehicle.
 * Note: There is n check that the given array actually suits the given vehicle!
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
		["_spawnType", nil, [""]]
	];
	
	CHECK_TRUE(_success, Invalid vehicleFormat!)
	
	private _sideVehicleList = [_id, []];
	private _vehicleType = [];
	private _vehicleCount = [];
	private _bigHeli = false;
		
	if (_spawnType isEqualTo "base") then {
		{
			_x params [
				["_type", "", [""]],
				["_fuel", 0, [0]],
				["_damage", 0, [0,"",[]]],
				["_ammo", [], [[]]],
				["_spawn", "", [""]]
			];
			
			if (_type in HELI_BIG && _spawn isEqualTo _id) then {
				private _helipads = nearestObjects [_position, VEHICLE_SPAWN_AIR, 80];
			
				_helipads params ["_pad0", "_pad1", "_pad2"];
		
				private _dist01 = _pad0 distance2D _pad1;
				private _dist02 = _pad0 distance2D _pad2;
				private _dist12 = _pad1 distance2D _pad2;
				
				private _matchingPads = if (_dist01 < _dist02) then {
					if (_dist01 < _dist12) then {[_pad0, _pad1]} else {[_pad1, _pad2]};
				} else {
					if (_dist02 < _dist12) then {[_pad0, _pad2]} else {[_pad1, _pad2]};
				};
				
				private _posPad0 = getPos (_matchingPads select 0);
				private _posPad1 = getPos (_matchingPads select 1);
				
				private _mpos = [((_posPad0 select 0) + (_posPad1 select 0)) / 2, ((_posPad0 select 1) + (_posPad1 select 1)) / 2];
				private _dir = _posPad0 getDir _posPad1;
				_helipads = _helipads - _matchingPads;
								
				(_helipads select 0) setVariable [QGVAR(heliSmall), true]; 
				{_x setPos [0, 0, 0]; deleteVehicle _x; nil} count _matchingPads;
				
				private _pad = createVehicle ["Land_HelipadCircle_F", _mpos, [], 0, "CAN_COLLIDE"];
				_pad setDir _dir;
				_pad setVariable [QGVAR(heliBig), true];
			};
			
			nil
		} count _this;
	};	
	
	{
		_success = _x params [
			["_type", "", [""]],
			["_fuel", 0, [0]],
			["_damage", 0, [0,"",[]]],
			["_ammo", [], [[]]],
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
			} else {
				_vehicleCount set [_return, 1];
			};
			
			private _objList = if (_type isKindOf "LandVehicle" || _type isKindOf "Ship") then {
				nearestObjects [_position, VEHICLE_SPAWN_LAND, if (_spawnType isEqualTo "carrier") then {200} else {80}];
			} else {
				nearestObjects [_position, VEHICLE_SPAWN_AIR, if (_spawnType isEqualTo "carrier") then {200} else {80}];								
			};
			
			diag_log _spawnType;
			diag_log (count _objList);
			
			_objList = if ((count _objList) isEqualTo 2) then {				
				if (_type in HELI_BIG) then {					
					{
						if (_x getVariable [QGVAR(heliBig), false]) exitWith {[_x]};
					} count _objList;
				} else {				
					{
						if (_x getVariable [QGVAR(heliSmall), false]) exitWith {[_x]};
					} count _objList;
				};
			} else {
				[_objList, 100] call FUNC(KK_arrayShuffle)
			};
			
			private _return = {
				if (!(_x getVariable [QGVAR(VehiclePlaced), false])) exitWith {					
					private _obj = if (_spawnType isEqualTo "carrier") then {
						private _obj = createVehicle [_type, [0, 0, 0], [], 0, "CAN_COLLIDE"];
						diag_log (_x getVariable [QGVAR(vehiclePos), []]);
						_obj setPosASL (_x getVariable [QGVAR(vehiclePos), []]);
						diag_log _obj;
						_obj
					} else {
						createVehicle [_type, _x, [], 0, "CAN_COLLIDE"];
					};
					
					diag_log _obj;
					
					if (_type isEqualTo (VEHICLE_MOBILE_CAMP select 0)) then {
						private _jipID = str(position _x);
						
						_obj setVariable [QGVAR(spawnPosition), position _x, true];
						_obj setVariable [QGVAR(JIPID), _jipID, true];
						[_obj, objNull] remoteExecCall [QFUNC(createAddAction), -2, _jipID];
						
						private _FOBCargo = [] call compile preprocessFileLineNumbers "scripts\compositions\cargoFOB1.sqf";						
						[_obj, _FOBCargo, false] call FUNC(cargoVehicle);
						
						for "_i" from 1 to 13 do {
							_obj lockCargo [_i, true];
						};
					};
					
					if (_type isEqualTo (VEHICLE_MOBILE_CAMP select 1)) then {
						private _FOBCargo = [] call compile preprocessFileLineNumbers "scripts\compositions\cargoFOB2.sqf";
						[_obj, _FOBCargo, false] call FUNC(cargoVehicle);
						
						for "_i" from 1 to 15 do {
							_obj lockCargo [_i, true];
						};
					};
					
					private _objBoat = objNull;
					
					if (_type in VEHICLE_BOAT_SMALL) then {
						private _cargoBoat = [] call compile preprocessFileLineNumbers (format ["scripts\compositions\cargoAssaultBoat%1.sqf", _side]);
						
						deleteVehicle _obj;
						
						_obj = createVehicle [if (_side isEqualTo west) then {VEHICLE_BOAT_TRANSPORT select 0} else {VEHICLE_BOAT_TRANSPORT select 1}, _x, [], 0, "CAN_COLLIDE"];
						
						for "_i" from 1 to 15 do {
							_obj lockCargo [_i, true];
						};
						
						_objBoat = ([_obj, _cargoBoat, true] call FUNC(cargoVehicle)) select 0;		
						_obj setVariable [QGVAR(hasCargo), true, true];
						
						private _jipID = str(position _x);
						
						_obj setVariable [QGVAR(JIPID), _jipID, true];
						[_objBoat, _obj] remoteExecCall [QFUNC(createAddAction), -2, _jipID];						
					};
					
					if (_type in VEHICLE_BOAT_BIG) then {
						private _cargoBoat = [] call compile preprocessFileLineNumbers (format ["scripts\compositions\cargoSpeedboat%1.sqf", _side]);
						
						deleteVehicle _obj;
						
						_obj = createVehicle [if (_side isEqualTo west) then {VEHICLE_BOAT_TRANSPORT select 0} else {VEHICLE_BOAT_TRANSPORT select 1}, _x, [], 0, "CAN_COLLIDE"];
						
						for "_i" from 1 to 15 do {
							_obj lockCargo [_i, true];
						};
						
						_objBoat = ([_obj, _cargoBoat, true] call FUNC(cargoVehicle)) select 0;
						_obj setVariable [QGVAR(hasCargo), true, true];

						private _jipID = str(position _x);
						
						_obj setVariable [QGVAR(JIPID), _jipID, true];
						[_objBoat, _obj] remoteExecCall [QFUNC(createAddAction), -2, _jipID];							
					};
					
					private _objWebGUI = if (_objBoat isEqualTo objNull) then {_obj} else {_objBoat};					
				
					_objWebGUI setFuel _fuel;					
					//if (_spawnType isEqualTo "carrier") then {_obj setDir (_x getVariable [QGVAR(vehicleDir), 0])} else {_obj setDir (getDir _x)};
					_obj setDir (getDir _x);
					
					// apply damage
					if (typeName _damage isEqualTo typeName 0) then {
						_objWebGUI setDamage _damage;
					} else {
						if (typeName _damage isEqualTo typeName "") then {
							// convert string into array
							_damage = parseSimpleArray _damage;
						};
						
						// apply damage to each part
						for "_i" from 0 to (count (_damage select 0) - 1) do {
							_objWebGUI setHitPointDamage [_damage select 0 select _i, _damage select 2 select _i];
						};
					};
					
					// apply ammo
					if !((count _ammo) isEqualTo 0) then {
						{
							_x params ["_ammoType", "_turret"];
							_objWebGUI removeMagazinesTurret [_ammoType, _turret];
							nil
						} count (magazinesAllTurrets _objWebGUI);								
						
						// apply ammo to each turret
						for "_i" from 0 to ((count _ammo) - 1) do {							
							_objWebGUI addMagazineTurret [(_ammo select _i) select 0, (_ammo select _i) select 1, (_ammo select _i) select 2];
						};
					};
					
					if (_spawnType isEqualTo "carrier") then {_obj setPosASL ((_x getVariable [QGVAR(vehiclePos), []]) vectorAdd [0,0,0.2])} else {_obj setPosATL (getPos _x vectorAdd [0,0,0.2])};
					
					clearWeaponCargoGlobal _obj;
					clearBackpackCargoGlobal _obj;
					clearMagazineCargoGlobal _obj;
					clearItemCargoGlobal _obj;
					
					_objWebGUI disableTIEquipment true;
					
					// save the vehicle's ID
					_objWebGUI setVariable [VEHICLE_ID, _vehID];
					_objWebGUI setVariable [QGVAR(fuelInfo), fuel _obj];
					
					[
						FUNC(calculateFuelConsumption),
						1,
						[_objWebGUI]
					] call CBA_fnc_addPerFrameHandler;
					
					// add EH for vehicle destruction (MP-EH is needed in case the vehicle's locality changes (e.g. a player enter it))
					_objWebGUI addMPEventHandler [
						"MPKilled", {
							if (isServer) then {
								if (typeOf (_this select 0) isEqualTo (VEHICLE_MOBILE_CAMP select 0)) then {
									[] remoteExecCall ["", (_this select 0) getVariable [QGVAR(JIPID, "")]];
								};
								
								// set the damage to 1 in case it died of critical hit
								(_this select 0) setDamage 1;
								
								// report destroyed vehicle to the DB immediately
								[_this select 0] call FUNC(reportVehicleStatus);
								[_this select 0] call FUNC(reportDestroyedVehicleStatistic);
							};
							
							if (hasInterface) then {
								if (typeOf (_this select 0) isEqualTo (VEHICLE_MOBILE_CAMP select 0)) then {
									(_this select 0) removeAction ((_this select 0) getVariable [QGVAR(FOBAddAction), -1]);
								};
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

nil
