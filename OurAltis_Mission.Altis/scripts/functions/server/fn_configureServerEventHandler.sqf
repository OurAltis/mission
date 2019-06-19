#include "macros.hpp"
/**
 * OurAltis_Mission - fn_configureServerEventHandler
 * 
 * Author: Raven
 * 
 * Description:
 * Configures all server event handler
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

// add EH for disconnects
addMissionEventHandler [
	"HandleDisconnect",
	{		
		// kill player's unit in order for the 'Killed' EH to get executed
		_this select 0 setDamage 1;
		
		nil;
	}
];

addMissionEventHandler [
	"BuildingChanged", {
		params ["_oldObj", "_newObj", "_isRuin"];
		
		private _isEco = _oldObj getVariable [IS_ECONOMY_BUILDING, false];
		
		if (_isEco) then {
			if (_isRuin) then {
				NOTIFICATION_LOG(Economy building destroyed!)
				
				private _indexDB = _oldObj getVariable [QGVAR(indexDB), 0];
				private _type = _oldObj getVariable [TYPE_OF_ECONOMY, ""];
				private _count = [_indexDB] call FUNC(getEconomyVariable);
				
				if (_count > 1) then {
					[_indexDB] call FUNC(setEconomyVariable);					
				} else {					
					[_indexDB] call FUNC(reportEconomyStatus);
					["ecoDes", _type, objNull] call FUNC(reportIncident);
					["ecoAttacker_" + str(_indexDB), "SUCCEEDED"] spawn BIS_fnc_taskSetState;
					["ecoDefender_" + str(_indexDB), "FAILED"] spawn BIS_fnc_taskSetState;					
					
					private _sideDB = if (GVAR(defenderSide) isEqualTo west) then {"ost"} else {"west"};
					
					if (_type isEqualTo "barracks") then {
						GVAR(taskState) set [1, _sideDB];
					};
					
					if (_type isEqualTo "factory") then {
						GVAR(taskState) set [2, _sideDB];
					};
					
					if (_type isEqualTo "hangar") then {
						GVAR(taskState) set [3, _sideDB];
					};					
				};				
			} else {
				_newObj setVariable [IS_ECONOMY_BUILDING, _oldObj getVariable [IS_ECONOMY_BUILDING, false]];
				_newObj setVariable [TYPE_OF_ECONOMY, _oldObj getVariable [TYPE_OF_ECONOMY, ""]];
				_newObj setVariable [QGVAR(indexDB), _oldObj getVariable [QGVAR(indexDB), 0]];
			};
		};		
		
		
		if (_oldObj getVariable [IS_RESPAWN_BUILDING, false]) then {
			if (_isRuin) then {
				NOTIFICATION_LOG(Respawn building destroyed!)
			} else {
				_newObj setVariable [IS_RESPAWN_BUILDING, true];
			};			
		};		
	}
];

// handler for providing the base list on request
[
	EVENT_BASE_LIST_REQUEST,
	{
		params [
			["_clientID", nil, [0]]
		];
		
		CHECK_FALSE(isNil "_clientID", Invalid client ID!, {})
		
		// send the base list to the respective client
		[EVENT_BASE_LIST_RECEIVED, GVAR(BaseList), _clientID] call FUNC(fireClientEvent);
		
		nil;
	}
] call FUNC(addEventHandler);

// handler for providing the infantry list on request
[
	EVENT_INFANTRY_LIST_REQUEST,
	{
		params [
			["_clientID", nil, [0]]
		];
		
		CHECK_FALSE(isNil "_clientID", Invalid client ID!, {})
		
		// send the base list to the respective client
		[EVENT_INFANTRY_LIST_RECEIVED, GVAR(Infantry), _clientID] call FUNC(fireClientEvent);
		
		nil;
	}
] call FUNC(addEventHandler);

// handler for respawn requests
[
	EVENT_REQUEST_RESPAWN,
	{
		params [
			["_clientID", nil, [0]],
			["_respawnInfo", [], [[]]]
		];
		
		CHECK_FALSE(isNil "_clientID", Invalid client ID!, {})
		
		private _allow = false;
		private _extraParams = ["!Respawn error!"];
		
		CHECK_TRUE(count _respawnInfo == 2, Invalid respawn information!, {})
		
		_respawnInfo params [
			"_base",
			"_role"
		];
		
		private _msg = [_base, _role] call FUNC(checkRespawn);
		
		_allow = _msg isEqualTo "";
		_extraParams = [_msg];
		
		
		// send the base list to the respective client
		[EVENT_ANSWER_REQUEST_RESPAWN, [_allow, _extraParams], _clientID] call FUNC(fireClientEvent);
		
		nil;
	}
] call FUNC(addEventHandler);

// handler for unit death
[
	UNIT_DIED,
	{
		private _success = params [
			["_clientID", nil, [0]],
			["_classCode", -2, [0]],
			["_base", "", [""]]
		];
		
		CHECK_TRUE(_success, Invalid parameters!, {})
		
		[_classCode, _base] call FUNC(reportDeadUnit);
		
		nil;
	}
] call FUNC(addEventHandler);

// handler for voting and round start
[
	UNIT_VOTE,
	{
		private _success = params [
			["_clientID", nil, [0]],
			["_vote", false, [true]]
		];
		
		CHECK_TRUE(_success, Invalid parameters!, {})		
		
		[_clientID, _vote] call FUNC(confirmVote);
		
		nil;
	}
] call FUNC(addEventHandler);

// handler for when all players of one side are dead
[
	ALL_PLAYER_OF_SIDE_DEAD,
	{
		private _success = params [
			["_clientID", nil, [0]],
			["_side", sideUnknown, [sideUnknown]]
		];
		
		CHECK_TRUE(_success, Invalid parameters!, {})
		
		//private _remainingSides = [blufor, opfor, independent];
		private _remainingSides = [blufor, opfor];
		_remainingSides = _remainingSides - [_side];
		
		{
			if (!([_x] call FUNC(sideHasLivingUnits))) then {
				_remainingSides set [_forEachIndex, objNull];
			};
		} forEach _remainingSides;
				
		private _allSides = _remainingSides - [objNull];
				
		if (count _allSides == 1) then {
			// There are only players of one side left -> end mission in their favour			
			[_remainingSides select 0] call FUNC(endMission);
		} else {
			if(count _allSides == 0) then {
				// no one is left alive -> defender has won
				[GVAR(defenderSide)] call FUNC(endMission);
			};
		};
		
		nil;
	}
] call FUNC(addEventHandler);

nil;
