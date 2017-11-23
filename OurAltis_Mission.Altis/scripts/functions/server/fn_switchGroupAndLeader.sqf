#include "macros.hpp"
/**
 * OurAltis_Mission - fn_switchGroupAndLeader
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Change group and leader after respawn
 * 
 * Parameter(s):
 * 0: Group <Group>
 * 1: Leader <Booln>
 * 2: New Unit <Object>
 * 3: Old Unit <Object>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
private _success = params [
	["_group", grpNull, [grpNull]],
	["_leader", false, [true]],
	["_newUnit", objNull, [objNull]],
	["_oldUnit", objNull, [objNull]]
];
 
CHECK_TRUE(_success, Invalid parameters!, {})

if !(_group isEqualTo grpNull) then {
	["RemoveGroupMember", [_group, _oldUnit]] call BIS_fnc_dynamicGroups;			
};	

if (_leader) then {
	["SwitchLeader", [_group, _newUnit]] call BIS_fnc_dynamicGroups;
};

nil
