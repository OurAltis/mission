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

{	
	_success = _x params [
		["_baseID", nil, [""]],
		["_side", sideUnknown, [sideUnknown]],
		["_position", nil, [[]], [2,3]],
		["_spawnType", nil, [""]]
	];
	
	CHECK_TRUE(_success, Invalid base format!)
	
	diag_log ("Start baseID: " + str(_baseID));
	
	diag_log "Start getVehicleSpawn";
	private _landSpawnPoints = [_position, _spawnType, true] call FUNC(getVehicleSpawn);
	private _airSpawnpoints = [_position, _spawnType, false] call FUNC(getVehicleSpawn);
	diag_log "End getVehicleSpawn";
	
	diag_log "Start sortVehicles";
	private _sortedVehicles = [_baseID, _this] call FUNC(sortVehicles);

	{	
		diag_log ("sortedVehicles Index: " + str(_forEachIndex));
		diag_log ("sortedVehicles Count: " + str(count _x));
		
		{
			diag_log format ["sortedVehicles Class: %1", _x select 0];
		} forEach _x;
	} forEach _sortedVehicles;
	diag_log "End sortVehicles";
	
	_sortedVehicles params ["_matchedLandVehicles", "_matchedAirVehicles", "_matchedSeeVehicles"];		
	diag_log format ["count LandVeh: %1; count AirVeh: %2; count SeeVeh: %3", count _matchedLandVehicles, count _matchedAirVehicles, count _matchedSeeVehicles];	
	
	diag_log "Start prepareAirVehicleSpawn";
	if (_spawnType isEqualTo "base" && count _matchedAirVehicles > 0) then {
		_airSpawnpoints = [_matchedAirVehicles, _airSpawnpoints] call FUNC(prepareAirVehicleSpawn);
	};
	
	diag_log ("airSpawnPoints Count: " + str(count _airSpawnPoints));
	
	{
		diag_log format ["airSpawnPoint index: %1; airSpawnPoint name: %2; airSpawnPoint HeliBig: %3; airSpawnPoint HeliSmall: %4", _forEachIndex, _x, _x getVariable [QGVAR(heliBig), false], _x getVariable [QGVAR(heliSmall), false]];
	} forEach _airSpawnPoints;
	diag_log "End prepareAirVehicleSpawn";
	
	diag_log "Start landSpawn shuffle";
	_landSpawnPoints = [_landSpawnPoints, 100] call FUNC(KK_arrayShuffle);
	diag_log "End landSpawn shuffle";
	
	diag_log "Start airSpawn shuffle";
	_matchedAirVehicles = if ((count _airSpawnpoints) isEqualTo 2) then {
		if (((_matchedAirVehicles select 0) select 0) in HELI_BIG) then {[_matchedAirVehicles select 1, _matchedAirVehicles select 0]} else {_matchedAirVehicles};
	} else {
		[_airSpawnpoints, 100] call FUNC(KK_arrayShuffle);
		_matchedAirVehicles
	};
	
	diag_log ("airSpawnPoints Count: " + str(count _airSpawnPoints));
	
	{
		diag_log format ["airSpawnPoint index: %1; airSpawnPoint name: %2; airSpawnPoint HeliBig: %3; airSpawnPoint HeliSmall: %4", _forEachIndex, _x, _x getVariable [QGVAR(heliBig), false], _x getVariable [QGVAR(heliSmall), false]];
	} forEach _airSpawnPoints;
	diag_log "End airSpawn shuffle";
	
	diag_log "Start resizeVehicleSpawn land";
	_landSpawnPoints = [_landSpawnPoints, (count _matchedLandVehicles) + (count _matchedSeeVehicles)] call FUNC(resizeVehicleSpawn);
	
	diag_log ("landSpawnPoints count: " + str(count _landSpawnPoints));
	
	{
		diag_log format ["landSpawnPoints index: %1; landSpawnPoints name: %2; landSpawnPoints HeliBig: %3; landSpawnPoints HeliSmall: %4", _forEachIndex, _x, _x getVariable [QGVAR(heliBig), false], _x getVariable [QGVAR(heliSmall), false]];
	} forEach _landSpawnPoints;
	diag_log "End resizeVehicleSpawn land";
	
	diag_log "Start resizeVehicleSpawn air";
	_airSpawnpoints = [_airSpawnpoints, count _matchedAirVehicles] call FUNC(resizeVehicleSpawn);
	
	diag_log ("airSpawnpoints count: " + str(count _airSpawnpoints));
	
	{
		diag_log format ["airSpawnPoint index: %1; airSpawnPoint name: %2; airSpawnPoint HeliBig: %3; airSpawnPoint HeliSmall: %4", _forEachIndex, _x, _x getVariable [QGVAR(heliBig), false], _x getVariable [QGVAR(heliSmall), false]];
	} forEach _airSpawnpoints;
	diag_log "End resizeVehicleSpawn air";
	
	private _allSpawnPoints = _landSpawnPoints + _airSpawnPoints;
	reverse _allSpawnPoints;
	
	diag_log ("End baseID: " + str(_baseID));
		
	private _countIndex = 0;
	
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
	
		_countIndex = _countIndex + 1;
		diag_log ("countIndex = " + str(_countIndex));
		
		private _xDummy = _allSpawnPoints select ((count _allSpawnPoints) - 1);
		
		private _obj = if (_spawnType isEqualTo "carrier") then {
			private _obj = createVehicle [_type, [0, 0, 0], [], 0, "CAN_COLLIDE"];
			_obj setPosASL (_xDummy getVariable [QGVAR(vehiclePos), []]);
			_obj
		} else {
			if (_xDummy isEqualType "") then {
				private _suitablePos = _position findEmptyPosition [150, 500, _type];
				_xDummy = createVehicle ["Land_HelipadCircle_F", _suitablePos, [], 0, "CAN_COLLIDE"];
				createVehicle [_type, _xDummy, [], 0, "CAN_COLLIDE"];
			} else {
				createVehicle [_type, _xDummy, [], 0, "CAN_COLLIDE"];
			};
		};
		
		_obj setDamage 0; _x
		
		if (_type in VEHICLE_MOBILE_CAMP) then {
			[_obj, _type] call FUNC(prepareVehicleMobileCamp);
		};		
		
		private _objBoat = if (_type isKindOf "Ship") then {
			[_obj, _type, _side, position _xDummy] call FUNC(prepareVehicleBoot);
		} else {objNull};
		
		private _objWebGUI = if (_objBoat isEqualTo objNull) then {_obj} else {_objBoat};					
	
		_objWebGUI setFuel _fuel;					
		_obj setDir (getDir _xDummy);
		
		if (_spawnType isEqualTo "carrier") then {_obj setPosASL ((_xDummy getVariable [QGVAR(vehiclePos), []]) vectorAdd [0,0,0.2])} else {_obj setPosATL (getPos _xDummy vectorAdd [0,0,0.2])};
		
		[
			{
				_this params ["_damage", "_objWebGUI"];
				
				_objWebGUI setDamage 0;
				
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
			},
			[_damage, _objWebGUI],
			6
		] call CBA_fnc_waitAndExecute;
		
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
					(_this select 0) setDamage  1;
					
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
		
		_allSpawnPoints resize ((count _allSpawnPoints) - 1);
		
		nil
	} count (_matchedLandVehicles + _matchedSeeVehicles + _matchedAirVehicles);		
	
	nil
} count GVAR(BaseList);

nil
