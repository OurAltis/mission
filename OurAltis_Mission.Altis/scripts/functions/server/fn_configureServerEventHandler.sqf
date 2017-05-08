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
		
		if ((typeOf _newObj) isEqualTo "Land_i_Barracks_V1_dam_F" && _oldObj getVariable [IS_ECONOMY_BUILDING, false]) then {
			_newObj setVariable [IS_ECONOMY_BUILDING, true];
			_newObj setVariable [TYPE_OF_ECONOMY, _oldObj getVariable [TYPE_OF_ECONOMY, ""]];
		};
		
		if ((typeOf _oldObj) in ECONOMY_BUILDING && _isRuin) then {
			if (_oldObj getVariable [IS_ECONOMY_BUILDING, false]) then {
				NOTIFICATION_LOG(Economy building destroyed!)
								
				if ((_oldObj getVariable [TYPE_OF_ECONOMY, ""]) isEqualTo "barracks") then {
					if (GVAR(destroyedBarracks) isEqualTo 2) then {						
						[_oldObj] call FUNC(reportEconomyStatus);
					} else {
						GVAR(destroyedBarracks) = GVAR(destroyedBarracks) + 1;
					};
				} else {
					[_oldObj] call FUNC(reportEconomyStatus);
				};				
			};
		};
		
		if ((typeOf _oldObj) in RESPAWN_BUILDING && _isRuin) then {
			if (_oldObj getVariable [IS_RESPAWN_BUILDING, false]) then {
				NOTIFICATION_LOG(Respawn building destroyed!)
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
		
		private _remainingSides = [blufor, opfor, independent];
		_remainingSides = _remainingSides - [_side];
		
		{
			if (!([_x] call FUNC(sideHasLivingUnits))) then {
				_remainingSides set [_forEachIndex, objNull];
			};
		} forEach _remainingSides;
		
		_allSides = _remainingSides - [objNull];
		
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
