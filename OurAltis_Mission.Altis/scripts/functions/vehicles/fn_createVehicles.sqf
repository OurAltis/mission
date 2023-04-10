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
 
GVAR(vehicleListAll) = [];

{	
	_success = _x params [
		["_baseID", nil, [""]],
		["_side", sideUnknown, [sideUnknown]],
		["_position", nil, [[]], [2,3]],
		["_spawnType", nil, [""]]
	];
	
	CHECK_TRUE(_success, Invalid base format!)
	
	private _landSpawnPoints = [_position, _spawnType, true] call FUNC(getVehicleSpawn);
	private _airSpawnpoints = [_position, _spawnType, false] call FUNC(getVehicleSpawn);
	private _sortedVehicles = [_baseID, _this] call FUNC(sortVehicles);	
	private _vehicleClass = [];
	
	{	
		{
			_vehicleClass pushBack (_x select 0);
			nil
		} count _x;
		
		nil
	} count _sortedVehicles;	
	
	private _vehicleListType = [];
		
	{
		private _index = _vehicleListType pushBackUnique _x;
		
		if (_index != -1) then {
			private _type = _x;			
			private _count = {_x isEqualTo _type} count _vehicleClass;
			_vehicleListType pushBack _count;
		};
		
		nil
	} count _vehicleClass;
	
	private _indexSide = GVAR(vehicles) find _side;	
	private _indexBase = GVAR(vehicles) select (_indexSide + 1) pushBack [_baseID, []];
	
	{		
		if (_x isEqualType "") then {
			((GVAR(vehicles) select (_indexSide + 1)) select _indexBase) select 1 pushBack [_x, _vehicleListType select (_foreachIndex + 1)];
		};
	} forEach _vehicleListType;
	
	_sortedVehicles params ["_matchedLandVehicles", "_matchedAirVehicles", "_matchedSeeVehicles"];
		
	_landSpawnPoints = [_landSpawnPoints, 100] call FUNC(KK_arrayShuffle);
	_landSpawnPoints = [_landSpawnPoints, (count _matchedLandVehicles) + (count _matchedSeeVehicles)] call FUNC(resizeVehicleSpawn);
	_airSpawnpoints = [_airSpawnpoints, count _matchedAirVehicles] call FUNC(resizeVehicleSpawn);
	
	{
		deleteVehicle _x;
	} forEach (_landSpawnPoints # 1);
	
	private _allSpawnPoints = (_landSpawnPoints # 0) + (_airSpawnPoints # 0);
	reverse _allSpawnPoints;
		
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
		
		private _xDummy = _allSpawnPoints select ((count _allSpawnPoints) - 1);		
		private _tempPos = [];
		private _tempDir = 0;
		
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
				_tempPos = getPos _xDummy;
				_tempDir = getDir _xDummy;
				
				if ((typeOf _xDummy) in VEHICLE_SPAWN_LAND) then {
					_xDummy setPos [0, -10, 0];
					deleteVehicle _xDummy;
				};
				
				createVehicle [_type, _tempPos, [], 0, "CAN_COLLIDE"];
			};
		};
		
		_obj setDamage 0;
		
		if (_type in VEHICLE_MOBILE_CAMP) then {
			[_obj, _type] call FUNC(prepareVehicleMobileCamp);
		};
		
		private _objBoat = if (_type isKindOf "Ship") then {
			//private _objs = [_obj, _type, _side, position _xDummy] call FUNC(prepareVehicleBoat);
			private _objs = [_obj, _type, _side, _tempPos] call FUNC(prepareVehicleBoat);
			_obj = _objs select 0;
			GVAR(vehicleListAll) pushBack _obj;
			_objs select 1
		} else {objNull};	
		
		if (_type in VEHICLE_IDAP) then {
			if (isNil QGVAR(countIDAPVehicle)) then {				
				GVAR(countIDAPVehicle) = 1;
			} else {
				GVAR(countIDAPVehicle) = GVAR(countIDAPVehicle) + 1;
			};
			
			if !(_type isEqualTo (VEHICLE_IDAP select 0)) then {
				[_obj, _type] call FUNC(prepareVehicleIDAP);
			};
		};
		
		private _objWebGUI = if (_objBoat isEqualTo objNull) then {_obj} else {_objBoat};					

		GVAR(vehicleListAll) pushBack _objWebGUI;
		_objWebGUI setFuel _fuel;		
		//_obj setDir (getDir _xDummy);	
		_obj setDir _tempDir;			
				
		//if (_spawnType isEqualTo "carrier") then {_obj setPosASL ((_xDummy getVariable [QGVAR(vehiclePos), []]) vectorAdd [0,0,0.2])} else {_obj setPosATL (getPos _xDummy vectorAdd [0,0,0.2])};
		if (_spawnType isEqualTo "carrier") then {_obj setPosASL ((_xDummy getVariable [QGVAR(vehiclePos), []]) vectorAdd [0,0,0.2])} else {_obj setPosATL (_tempPos vectorAdd [0,0,0.2])};
		//if (_spawnType isEqualTo "carrier") then {_obj setPosASL ((_xDummy getVariable [QGVAR(vehiclePos), []]) vectorAdd [0,0,0.2])} else {_objWebGUI setVectorUp (surfacenormal (getPosATL _objWebGUI))};
		
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
				params ["_unit", "_killer", "_instigator"];
				
				if (isServer) then {
					if (typeOf _unit isEqualTo (VEHICLE_MOBILE_CAMP select 0)) then {
						[] remoteExecCall ["", _unit getVariable [QGVAR(JIPID, "")]];
					};
					
					if (typeOf _unit in VEHICLE_IDAP) then {
						diag_log ("MPKilled (Unit, Killer, WhoPulledTheTrigger): " + str(_unit) + "," + str(_killer) + "," + str(_instigator));
						[_instigator] call FUNC(reportAidSupplyDestroyed);						
						
						GVAR(countIDAPVehicle) = GVAR(countIDAPVehicle) - 1;
						
						if (GVAR(countIDAPVehicle) isEqualTo 0 && !(GVAR(supplyPoint) isEqualTo [])) then {
							if ((GVAR(taskState) select 6) isEqualType 0) then {
								["IDAPSupplier", "FAILED"] spawn BIS_fnc_taskSetState;
								["IDAPDisturber", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
								
								GVAR(taskState) set [6, if (GVAR(defenderSide) isEqualTo west) then {"west"} else {"ost"}];
							};
						};
					};
					
					// set the damage to 1 in case it died of critical hit
					_unit setDamage  1;
					
					// report destroyed vehicle to the DB immediately
					[_unit] call FUNC(reportVehicleStatus);
					[_unit] call FUNC(reportDestroyedVehicleStatistic);
				};
				
				if (hasInterface) then {
					if (typeOf _unit isEqualTo (VEHICLE_MOBILE_CAMP select 0)) then {
						_unit removeAction (_unit getVariable [QGVAR(FOBAddAction), -1]);
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

{
	_x lock true;
	nil
} count GVAR(vehicleListAll);

GVAR(createVehicleReady) = "ready";

nil
