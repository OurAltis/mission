#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createAmbientVehicles
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Creates the vehicles at economy buildings
 * 
 * Parameter(s):
 * 0: Helipads <Array> - format [Objects <Object>]
 * 
 * Return Value:
 * None <Any>
 * 
 */ 
 
private _success = params [
	["_vehPosObj", [], [[]]]
]; 

CHECK_TRUE(_success, Invalid parameters!)

{
	private _vehGroup = if (typeOf _x isEqualTo "FlagSmall_F") then {"idap"} else {
		toLower(_x getVariable [VEHICLE_TYPE, ""]);
	};
	
	_vehGroup = if ((_vehGroup find "military") > -1) then {toLower(_vehGroup + "_" + str GVAR(defenderSide))} else {_vehGroup};
	
	private _vehArray = switch (_vehGroup) do {
		case "civil_pkw": {VEHICLE_CIVIL_PKW};
		case "civil_lkw": {VEHICLE_CIVIL_LKW};
		case "military_lkw_west": {VEHICLE_MILITARY_LKW_WEST};
		case "military_lkw_east": {VEHICLE_MILITARY_LKW_EAST};
		case "military_tank_west": {VEHICLE_MILITARY_TANK_WEST};
		case "military_tank_east": {VEHICLE_MILITARY_TANK_EAST};
		case "military_heli_west": {VEHICLE_MILITARY_HELI_WEST};
		case "military_heli_east": {VEHICLE_MILITARY_HELI_EAST};
		case "idap": {VEHICLE_IDAP};
		default {[]};
	};
	
	if ((count _vehArray) isEqualTo 0) exitWith {NOTIFICATION_LOG(No vehicle type defined!)};	
	
	if (selectRandom [true, false]) then {
		private _pos = position _x;
		private _dir = getDir _x;
		
		deleteVehicle _x;
		
		private _obj = createVehicle [selectRandom _vehArray, _pos, [], 0, "CAN_COLLIDE"];
		_obj setDir _dir;
		_obj lock (if ((_vehGroup find "military") > -1) then {3} else {0});
		
		clearWeaponCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
	} else {deleteVehicle _x};
	
	nil
} count _vehPosObj;

nil
