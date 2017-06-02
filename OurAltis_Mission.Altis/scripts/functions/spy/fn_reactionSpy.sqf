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
	[_budget] remoteExecCall [QFUNC(createSpyInfo), side (group _caller), true];
	
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
	private _enemies = GVAR(spyUnit) nearEntities 10;
	
	if ((count _enemies) <= 2) then {
		private _grp = createGroup _spySide;
		[GVAR(spyUnit)] joinSilent _grp;
		GVAR(spyUnit) addMagazines ["30Rnd_762x39_Mag_F", 4];
		GVAR(spyUnit) addWeapon "arifle_AKM_F";
		GVAR(spyUnit) enableAI "MOVE";
	} else {		
		{
			{
				private _soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
				private _soundToPlay = _soundPath + "sounds\" + "gameOver" + ".ogg" ;
				playSound3D [_soundToPlay, GVAR(spyUnit), false, position GVAR(spyUnit), 1, 1, 0];
				
				"Bo_GBU12_LGB" createVehicle getPos GVAR(spyUnit);
			},
			[],
			1
		} call CBA_fnc_waitAndExecute;
	};
};

nil
