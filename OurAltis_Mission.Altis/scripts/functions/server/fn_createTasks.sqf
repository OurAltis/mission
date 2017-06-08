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
if (GVAR(defenderSide) isEqualTo sideUnknown) then {
	[GVAR(BaseList) select 0 select 1, "base" + str(GVAR(BaseList) select 0 select 1), ["Eliminate all enemy forces!", "Eliminate all Enemies!", ""], GVAR(BaseList) select 1 select 2, "Created", 10, false, "attack", false] call BIS_fnc_taskCreate;
	[GVAR(BaseList) select 1 select 1, "base" + str(GVAR(BaseList) select 1 select 1), ["Eliminate all enemy forces!", "Eliminate all Enemies!", ""], GVAR(BaseList) select 0 select 2, "Created", 10, false, "attack", false] call BIS_fnc_taskCreate;	
} else {	
	private _attackerSide = if (GVAR(defenderSide) isEqualTo west) then {east} else {west};
	
	[GVAR(defenderSide), "baseDefender", ["Soldier! Get ready to defend the our base. The enemy sending forces to take " + GVAR(targetAreaName) + "!", "Defend our base!", ""], GVAR(markerBase), "Created", 10, false, "defend", false] call BIS_fnc_taskCreate;
	[_attackerSide, "baseAttacker", ["Soldier! Get ready to attack the enemy base. We take " + GVAR(targetAreaName) + " or die!", "Attack the enemy base!", ""], GVAR(markerBase), "Created", 10, false, "attack", false] call BIS_fnc_taskCreate;
	
	if (!isNil QGVAR(spyUnit)) then {
		[GVAR(defenderSide), "spyDefender", ["Soldier, we are in contact with a person who named himself Duke! He said, he have information about the strength of enemy forces in " + GVAR(targetAreaName) + " and more! If you think it will usefull find him and get the intel!", "Meet the spy!", "markerSpy"], GVAR(markerSpy), "Created", 5, false, "meet", false] call BIS_fnc_taskCreate;
		[_attackerSide, "spyAttacker", ["Soldier, we are in contact with a person who named himself Duke! He said, he have information about the strength of enemy forces in " + GVAR(targetAreaName) + " and more! If you think it will usefull find him and get the intel!", "Meet the spy!", "markerSpy"], GVAR(markerSpy), "Created", 5, false, "meet", false] call BIS_fnc_taskCreate;
	}; 

	if (!isNil QGVAR(markerEco)) then {
		[GVAR(defenderSide), "ecoDefender", ["We have a " + GVAR(economy) + " in " + GVAR(targetAreaName) + "! Protect it! Eventually the enemy will try to destroy it!", "Defend the " + GVAR(economy) + "!", ""], "markerEco", "Created", 5, false, "defend", false] call BIS_fnc_taskCreate;
		[_attackerSide, "ecoAttacker", ["The enemy have a " + GVAR(economy) + " in " + GVAR(targetAreaName) + "! If you are forced to retreat destroy it to damage enemy enonomy!", "Destroy the " + GVAR(economy) + "!", ""], "markerEco", "Created", 5, false, "attack", false] call BIS_fnc_taskCreate;
	};
	
	if !(GVAR(Resist) isEqualTo "") then {
		private _side = if (GVAR(Resist) isEqualTo "west") then {east} else {west};
		[_side, "resistance", ["Soldier, Hawkeye has reported enemy resistance in this area! Be careful we have to fight at two fronts! It will be a good statement if you find and kill them all. Your choice!", "Defeat the resistance!", ""], objNull, "Created", 5, false, "search", false] call BIS_fnc_taskCreate;		
	};
};

nil