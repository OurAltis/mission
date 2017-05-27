#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createTasks
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Create the tasks
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

//ToDo localize text 
private _attackerSide = sideUnknown;
 
if (GVAR(defenderSide) isEqualTo sideUnknown) then {
	{
		_x params ["_id", "_side", "_posiiton", "_isCamp"];
		
		private _sideTask = if (_side isEqualTo east) then {west} else {east};
		[_sideTask, "base", ["Eliminate all enemy forces!", "Eliminate all Enemies!", ""], objNull, "Created", 10, false, "attack", false] call BIS_fnc_taskCreate;		
		
		nil
	} count GVAR(BaseList)
} else {
	_attackerSide = if (GVAR(defenderSide) isEqualTo west) then {east} else {west};	
	
	[GVAR(defenderSide), "baseDefender", ["Soldier! Get ready to defend the our base. The enemy sending forces to take " + GVAR(targetAreaName) + "!", "Defend our base!", ""], objNull, "Created", 10, false, "defend", false] call BIS_fnc_taskCreate;
	[_attackerSide, "baseAttacker", ["Soldier! Get ready to attack the enemy base. We take " + GVAR(targetAreaName) + " or die!", "Attack the enemy base!", ""], objNull, "Created", 10, false, "attack", false] call BIS_fnc_taskCreate;
};

if (!isNil QGVAR(spyUnit)) then {
	[GVAR(defenderSide), ["spyDefender", "baseDefender"], ["Soldier, we are in contact with a person who named himself Duke! He said, he have information about the strength of enemy forces in " + GVAR(targetAreaName) + " and more! If you think it will usefull find him and get the intel!", "Meet the spy!", "markerSpy"], "markerSpy", "Created", 5, false, "meet", false] call BIS_fnc_taskCreate;
	[_attackerSide, ["spyAttacker", "baseAttacker"], ["Soldier, we are in contact with a person who named himself Duke! He said, he have information about the strength of enemy forces in " + GVAR(targetAreaName) + " and more! If you think it will usefull find him and get the intel!", "Meet the spy!", "markerSpy"], "markerSpy", "Created", 5, false, "meet", false] call BIS_fnc_taskCreate;
}; 

if (!isNil QGVAR(markerEco)) then {
	[GVAR(defenderSide), ["ecoDefender", "baseDefender"], ["We have a " + GVAR(economy) + " in " + GVAR(targetAreaName) + "! Protect it! Eventually the enemy will try to destroy it!", "Defend the " + GVAR(economy) + "!", ""], "markerEco", "Created", 5, false, "defend", false] call BIS_fnc_taskCreate;
	[_attackerSide, ["ecoAttacker", "baseAttacker"], ["The enemy have a " + GVAR(economy) + " in " + GVAR(targetAreaName) + "! If you are forced to retreat destroy it to damage enemy enonomy!", "Destroy the " + GVAR(economy) + "!", ""], "markerEco", "Created", 5, false, "attack", false] call BIS_fnc_taskCreate;
};

nil