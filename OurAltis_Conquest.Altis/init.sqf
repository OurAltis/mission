scopeName init;

// declare variables
// Insert generated parameters as variable values here at the respective position
_baseCoordinates = [0,0,0];
_operationName = "Sleeping Dog";
_wheather = 000;

_defenderSite = west;
// unit format: ["Name", damage (from 0 to 1)]
_defenderUnits = [["RifleMan", 1], ["Medic", 0.7]];
_supportUnits1 = [["RifleMan", 1]];
_supportUnits2 = [["Medic", 1]];
// Squad format: [[direction (0 - 359), unitArray (see above)], <nextSquad>];
_supportSquads = [[120, _supportUnits1], [0, _supportUnits2]]

_attackerSite = east;
_attackerUnits1 = [["Tank", 0.8], ["RifleMan", 1]];
_attackerUnits2 = [["Medic", 1], ["RifleMan", 0.5], ["Sniper", 1]];
_attackerSquads = [[260, _attackerUnits1], [180, _attackerUnits2]];

// initialize defenders
_baseCreation = [_baseCoordinates, _defenderSite] execVM "createBase.sqf";
_poulateDefenders = [_defenderUnits] execVM "populateDefenders.sqf";
_initializeSupport = [_supportSquads] execVM "initializeSupport.sqf";

// initialize attackers
_createAttackerSquads = [_defenderSquads] execVM "createAttackerSquads.sqf";
