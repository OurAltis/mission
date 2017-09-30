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

// add EH for connects
addMissionEventHandler [
	"PlayerConnected",
	{		
		diag_log ("PlayerConnected: " + (_this select 2));
		GVAR(connectedPlayer) pushBack (_this select 2);
		
		nil;
	}
];

// add EH for disconnects
addMissionEventHandler [
	"PlayerDisconnected",
	{		
		diag_log ("PlayerDisconnected: " + (_this select 2));
		
		if ((_this select 2) in GVAR(connectedPlayer)) then {
			[
				SEND_STATISTIC,
				[],
				_this select 4
			] call FUNC(fireClientEvent);
			
			GVAR(connectedPlayer) = GVAR(connectedPlayer) - [_this select 2];
		};
		
		nil;
	}
];

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
		
		if (_oldObj getVariable [IS_ECONOMY_BUILDING, false]) then {
			if (_isRuin) then {
				NOTIFICATION_LOG(Economy building destroyed!)
				
				_type = _oldObj getVariable [TYPE_OF_ECONOMY, ""];
				_count = [_type] call FUNC(getEconomyVariable);
				
				if (_count > 1) then {
					[_type] call FUNC(setEconomyVariable);
				} else {
					[_oldObj] call FUNC(reportEconomyStatus);
					["ecoAttacker", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
					["ecoDefender", "FAILED"] spawn BIS_fnc_taskSetState;
				};				
			} else {
				_newObj setVariable [IS_ECONOMY_BUILDING, true];
				_newObj setVariable [TYPE_OF_ECONOMY, _oldObj getVariable [TYPE_OF_ECONOMY, ""]];
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

// handler for when all players iof one side are dead
[
	ALL_PLAYER_OF_SIDE_DEAD,
	{
		private _success = params [
			["_clientID", nil, [0]],
			["_side", sideUnknown, [sideUnknown]]
		];
		
		CHECK_TRUE(_success, Invalid parameters!, {})
		
		diag_log "ALL_PLAYER_DEAD";
		diag_log _this;
		
		private _remainingSides = [blufor, opfor, independent];
		_remainingSides = _remainingSides - [_side];
		
		{
			if (!([_x] call FUNC(sideHasLivingUnits))) then {
				_remainingSides set [_forEachIndex, objNull];
			};
		} forEach _remainingSides;
		
		_allSides = _remainingSides - [objNull];
		
		diag_log "Ending mission because all player are dead";
		
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
