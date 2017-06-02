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
	private _positionDefender = [0, 0, 0];
	diag_log _positionDefender;
	{
		_x params ["_id", "_side", "_posiiton", "_isCamp"];		
		
		if (!_isCamp) then {
			_positionDefender = _position;
		};					
		
		nil
	} count GVAR(BaseList);
	
	diag_log _positionDefender;
	
	private _attackerSide = if (GVAR(defenderSide) isEqualTo west) then {east} else {west};
	
	[GVAR(defenderSide), "baseDefender", ["Soldier! Get ready to defend the our base. The enemy sending forces to take " + GVAR(targetAreaName) + "!", "Defend our base!", ""], [_positionDefender select 0, _positionDefender select 1, 0], "Created", 10, false, "defend", false] call BIS_fnc_taskCreate;
	[_attackerSide, "baseAttacker", ["Soldier! Get ready to attack the enemy base. We take " + GVAR(targetAreaName) + " or die!", "Attack the enemy base!", ""], [_positionDefender select 0, _positionDefender select 1, 0], "Created", 10, false, "attack", false] call BIS_fnc_taskCreate;
	
	if (!isNil QGVAR(spyUnit)) then {
		[GVAR(defenderSide), ["spyDefender", "baseDefender"], ["Soldier, we are in contact with a person who named himself Duke! He said, he have information about the strength of enemy forces in " + GVAR(targetAreaName) + " and more! If you think it will usefull find him and get the intel!", "Meet the spy!", "markerSpy"], GVAR(markerSpy), "Created", 5, false, "meet", false] call BIS_fnc_taskCreate;
		[_attackerSide, ["spyAttacker", "baseAttacker"], ["Soldier, we are in contact with a person who named himself Duke! He said, he have information about the strength of enemy forces in " + GVAR(targetAreaName) + " and more! If you think it will usefull find him and get the intel!", "Meet the spy!", "markerSpy"], GVAR(markerSpy), "Created", 5, false, "meet", false] call BIS_fnc_taskCreate;
	}; 

	if (!isNil QGVAR(markerEco)) then {
		[GVAR(defenderSide), ["ecoDefender", "baseDefender"], ["We have a " + GVAR(economy) + " in " + GVAR(targetAreaName) + "! Protect it! Eventually the enemy will try to destroy it!", "Defend the " + GVAR(economy) + "!", ""], "markerEco", "Created", 5, false, "defend", false] call BIS_fnc_taskCreate;
		[_attackerSide, ["ecoAttacker", "baseAttacker"], ["The enemy have a " + GVAR(economy) + " in " + GVAR(targetAreaName) + "! If you are forced to retreat destroy it to damage enemy enonomy!", "Destroy the " + GVAR(economy) + "!", ""], "markerEco", "Created", 5, false, "attack", false] call BIS_fnc_taskCreate;
	};
};

nil