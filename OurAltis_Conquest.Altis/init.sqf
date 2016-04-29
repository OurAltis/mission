scopeName "init";

// initialize static variables
DEFENDER_RESPAWN_MARKER = "RespawnPoint Defenders";

// static generated variables
SIDE_DEFENDER = west;
SIDE_ATTACKER = east;

// initialize functions
//TODO: use CfgFunctions
rvn_fnc_log = compile preprocessFileLineNumbers "scripts\functions\rvn_fnc_log.sqf";
rvn_fnc_createUnit = compile preprocessFileLineNumbers "scripts\functions\rvn_fnc_createUnit.sqf";

[1, "init", "initializing mission..."] call rvn_fnc_log;

// declare variables
// Insert generated parameters as variable values here at the respective position
_baseCoordinates = [9700,7830,0];
_operationName = "Sleeping Dog";
_wheather = [0,0,0]; // wheather has to be an array
_date = [2040, 11, 6];

// unit format: ["Name", damage (from 0 to 1)]
_defenderUnits = [["B_Soldier_A_F", 1], ["B_Medic_F", 0.7]];
_supportUnits1 = [["B_Soldier_A_F", 1]];
_supportUnits2 = [["B_Medic_F", 1]];
// Squad format: [[direction (0 - 359), unitArray (see above)], <nextSquad>];
_supportSquads = [[120, _supportUnits1], [0, _supportUnits2]];

_attackerUnits1 = [["B_Soldier_A_F", 0.8], ["B_Soldier_A_F", 1]];
_attackerUnits2 = [["B_Medic_F", 1], ["B_Soldier_A_F", 0.5], ["B_Soldier_A_F", 1]];
_attackerSquads = [[260, _attackerUnits1], [180, _attackerUnits2]];

// initialize defenders
_baseCreation = [_baseCoordinates] execVM "scripts\init\rvn_createBase.sqf";
_poulateDefenders = [_defenderUnits] execVM "scripts\init\rvn_populateDefenders.sqf";
_initializeSupport = [_supportSquads] execVM "scripts\init\rvn_initializeSupport.sqf";

// initialize attackers
_createAttacker = [_attackerSquads] execVM "scripts\init\rvn_initializeAttackers.sqf";

// set mission parameters
[_wheather, _date] execVM "scripts\init\rvn_configureMissionParameter.sqf";

[1, "Waiting for init scripts to finish..."] call rvn_fnc_log;

waitUntil {sleep 0.5; (scriptDone _baseCreation && scriptDone _poulateDefenders && scriptDone _initializeSupport && scriptDone _createAttacker)};

[1, "Finished initialization"] call rvn_fnc_log;
