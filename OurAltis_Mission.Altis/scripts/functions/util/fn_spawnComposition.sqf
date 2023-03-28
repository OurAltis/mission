#include "macros.hpp"
/**
 * OurAltis_Mission - fn_spawnComposition
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Creates givin composition
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */ 
diag_log ("fn_spawnCompositon (all): " + str(_this));
private _adString = "CAN_COLLIDE";
private _return = objNull;
private _obj = objNull;

{
	private _x;
	diag_log ("fn_spawnCompositon (_dat): " + str(_dat));
	
	if ((_dat select 0) isEqualTo "FlagMarker_01_F") then {
		private _pos = call compile (_dat select 1);
		private _offset = if ((_dat select 6) isEqualType 0) then {_dat select 6} else {0};
		
		{
			_x hideObjectGlobal true;
		} forEach nearestTerrainObjects [
			[_pos select 0, _pos select 1, (_pos select 2) + _offset], 
			[], 
			6
		];
	} else {	
		_obj = createVehicle [(_dat select 0), [0, 0, 0], [], 0, _adString];
		if ((_dat select 0) in RESPAWN_BUILDING) then {_obj setVariable [QGVAR(isRespawnBuilding), true, true]};
		if ((_dat select 0) in [FLAGPOLE]) then {_return =_obj};
		if ((_dat select 4) == 0) then {_obj enableSimulation false};
		if ((_dat select 8) == 0) then {_obj allowDamage false};
		_obj setdir (_dat select 2);
		if (count (_dat select 6) > 0) then {{call _x} foreach (_dat select 6)};
		if ((_dat select 0) isEqualTo "B_supplyCrate_F") then {
			clearWeaponCargoGlobal _obj;
			clearMagazineCargoGlobal _obj;
			clearItemCargoGlobal _obj;
			clearBackpackCargoGlobal _obj;
			_obj addBackpackCargoGlobal ['I_AT_01_weapon_F', 4];
			_obj addBackpackCargoGlobal ['I_AA_01_weapon_F', 4];
			_obj addBackpackCargoGlobal ['I_HMG_01_support_F', 8];
		};
		
		private _delete = false;
		
		if (_obj getVariable ["random", false]) then {
			_delete = selectRandom [true, false];	
			
			if (_obj getVariable ["boat", false] && GVAR(crisis) != 2) then {
				_delete = true;
			};					
		};
		
		if (GVAR(baseTier) in (_obj getVariable ["baseTier", []]) || (count (_obj getVariable ["baseTier", []]) isEqualTo 0 && !_delete)) then {
			if ((_dat select 3) == -100) then {
				_obj setposATL (call compile (_dat select 1));
				if ((_dat select 5) == 0) then {_obj setVectorUp [0,0,1]} else {_obj setVectorUp (surfacenormal (getPosATL _obj))};
			}
			else {
				_obj setposworld [((call compile (_dat select 1)) select 0), ((call compile (_dat select 1)) select 1), (_dat select 3)];
				[_obj, ((_dat select 7) select 0), ((_dat select 7) select 1)] call BIS_fnc_setPitchBank;
			};
				
			if (typeOf _obj != "FlagSmall_F") then {
				private _markerObj = createmarker [format["iom_m_%1",_obj], (getPosATL _obj)];
				_markerObj setMarkerShape "RECTANGLE";
				_markerObj setMarkerColor "ColorBlack";
				_markerObj setMarkerAlpha 1;				
				_markerObj setMarkerBrush "SOLID";
				_markerObj setMarkerSize [((0 boundingBox _obj select 1) select 0),((0 boundingBox _obj select 1) select 1)];
				_markerObj setMarkerDir (direction _obj);
				_obj setVariable ["marker",format["iom_m_%1",_obj],false];
			};
		} else {
			deleteVehicle _obj;
		};	
	};
} forEach _this;

_return
