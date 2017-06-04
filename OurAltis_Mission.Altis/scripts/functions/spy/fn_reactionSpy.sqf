#include "macros.hpp"
/**
 * OurAltis_Mission - fn_reactionSpy
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Reaction to caller
 * 
 * Parameter(s):
 * 0: Caller <Object>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
private _success = params [
	["_caller", objNull, [objNull]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _info = GVAR(spyUnit) getVariable [QGVAR(info), []];

_info params [
	["_side", "", [""]],
	["_budget", 0, [0]]
];

private _spySide = if (_side isEqualTo "west") then {west} else {east};

if (side (group _caller) isEqualTo _spySide) then {
	[_budget, GVAR(Vehicles), GVAR(Infantry)] remoteExecCall [QFUNC(createSpyInfo), side (group _caller), true];
	
	[
		{
			GVAR(spyUnit) enableAI "MOVE";
			GVAR(spyUnit) assignasdriver GVAR(spyVehicle);
			[GVAR(spyUnit)] orderGetIn true;
		},
		[],
		5
	] call CBA_fnc_waitAndExecute;
} else {
	private _enemies = GVAR(spyUnit) nearEntities  ["Man", 10];
	if (GVAR(spyUnit) in _enemies) then {_enemies deleteAt (_enemies find GVAR(spyUnit))};
	
	{
		if !(side (group _x) isEqualTo _spySide) then {_enemies set [_forEachIndex, objNull]};
	} forEach _enemies;	
	diag_log _enemies;
	
	_enemies = _enemies - [objNull];
	diag_log _enemies;
	
	if ((count _enemies) <= 2) then {
		private _grp = createGroup _spySide;
		[GVAR(spyUnit)] joinSilent _grp;
		GVAR(spyUnit) enableAI "MOVE";
		GVAR(spyUnit) addMagazines ["30Rnd_762x39_Mag_F", 4];
		GVAR(spyUnit) addWeapon "arifle_AKM_F";		
	} else {
		private _soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
		private _soundToPlay = _soundPath + "sounds\" + "gameOver" + ".ogg";			
		playSound3D [_soundToPlay, GVAR(spyUnit), false, position GVAR(spyUnit), 1, 1, 0];
		
		[
			{							
				"Bo_GBU12_LGB" createVehicle getPos GVAR(spyVehicle);				
				nil
			},
			[],
			1.5
		] call CBA_fnc_waitAndExecute;
	};
};

nil
