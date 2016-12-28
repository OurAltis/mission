/**
 * OurAltis_Mission - fn_getConfigRespawnDelay
 * 
 * Author: Raven
 * 
 * Description:
 * Gets the value set for the respawn dealy in the config. If none could be found -1 will be returned.
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * The respawn delay set in the config or -1 <Number>
 * 
 */

private ["_respawnDelay", "_respawnTemplates", "_configEntry"];

_respawnDelay = getMissionConfigValue "respawnDelay";

// use override from config if present
if(!isNil "_respawnDelay") exitWith {_respawnDelay};


_respawnTemplates = getMissionConfigValue "respawnTemplates";


if(isNil "_respawnTemplates") exitWith {-1}; // can't find any confog entry


_configEntry = configNull;

// go and try to locate the respective respawn template that might specify the delay -> first match wins
{
	// search in normal config first
	_configEntry = configFile >> "CfgRespawnTemplates" >> _x;
	
	if (isClass _configEntry && !isNil {isNumber (_configEntry >> "respawnDelay")}) exitWith {};
	
	// then check mission config
	_configEntry = missionConfigFile >> "CfgRespawnTemplates" >> _x;
	
	if(isClass _configEntry && !isNil {isNumber (_configEntry >> "respawnDelay")}) exitWith {};
	
	nil;
} count _respawnTemplates;


if(_configEntry isEqualTo configNull) exitWith {-1}; // no suitable respawn template found

getNumber (_configEntry >> "respawnDelay"); // return respective delay
