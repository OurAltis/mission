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
 
diag_log ("reactionSpy _this: " + str(_this));
 
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
	diag_log ("reactionSpy _budget: " + str(_budget));
	diag_log ("reactionSpy GVAR(Vehicles): " + str(GVAR(Vehicles)));
	diag_log ("reactionSpy GVAR(spyInfantryList): " + str(GVAR(spyInfantryList)));
	diag_log ("reactionSpy GVAR(resistanceUnits): " + str(GVAR(resistanceUnits)));
	[_budget, GVAR(Vehicles), GVAR(spyInfantryList), GVAR(resistanceUnits)] remoteExecCall [QFUNC(createSpyInfo), side (group _caller), true];
	
	[
		{
			GVAR(spyVehicle) lock 3;
			GVAR(spyUnit) enableAI "PATH";
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
	
	_enemies = _enemies - [objNull];
	
	if ((count _enemies) <= 2) then {
		private _grp = createGroup _spySide;
		[GVAR(spyUnit)] joinSilent _grp;
		GVAR(spyUnit) enableAI "PATH";
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

if (side (group _caller) isEqualTo GVAR(defenderSide)) then {
	["spyDefender", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
	["spyAttacker", "FAILED"] spawn BIS_fnc_taskSetState;	
} else {
	["spyDefender", "FAILED"] spawn BIS_fnc_taskSetState;
	["spyAttacker", "SUCCEEDED"] spawn BIS_fnc_taskSetState;	
};

GVAR(taskState) set [0, if (side (group _caller) isEqualTo west) then {"west"} else {"ost"}];

nil
