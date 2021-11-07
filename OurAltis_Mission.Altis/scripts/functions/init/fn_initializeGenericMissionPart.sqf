#include "macros.hpp"
/**
 * OurAltis_Mission - fn_initializeGenericMissionPart
 * 
 * Author: Raven
 * 
 * Description:
 * Initializes the generic part of the OurAltis mission
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

[] call FUNC(initializeEventHandler);

GVAR(spySound) = ["wasting", "ugly", "talkToMe", "suck", "sob", "rip", "getSome", "gameOver", "difference", "bubblegum", "birthControle", "beYou"];

#ifdef TFAR
	[] call FUNC(configureTFAR);
#endif

if (isServer) then {
	// [west, ost]
	GVAR(fuelConsumption) = [0, 0];
	// [west, ost]
	GVAR(deadUnits) = [0, 0];
	// [spy, resistance, economy, aidSupply]
	GVAR(taskState) = [0, 0, 0, 0, 0, 0, 0];
	GVAR(nameFOB) = [[], []];
	GVAR(playerVote) = [];
	
	if (GVAR(defenderSide) isEqualTo sideUnknown) then {
		[] call FUNC(createBorderWar);
	} else {	
		// Sets up a checking framework that repeatedly checks whether there are units in the base	
		GVAR(isFlagCaptured) = [GVAR(defenderSide)];
		
		GVAR(captureBaseHandlerID) = [
			FUNC(watchCapturingBase),
			0.1,
			[GVAR(flagPolesBase), 0]
		] call CBA_fnc_addPerFrameHandler;		
		
		GVAR(flagpoleStatusHandlerID) = [
			FUNC(watchFlagpoleStatus),
			0.1,
			[if (GVAR(defenderSide) isEqualTo west) then {east} else {west}]
		] call CBA_fnc_addPerFrameHandler;
	};
	
	// indicators on client
	PGVAR(BASES_CHANGED) = true;
	PGVAR(INF_CHANGED) = true;
	PGVAR(SERVER_INITIALIZED) = false;
	PGVAR(SERVER_ERRORS) = []; // an array of Strings containing error messages from the server
	PGVAR(retreat) = false;
	PGVAR(countFOB) = [0, 0];
	PGVAR(PREPARATION_FINISHED) = [false, 0];
	PGVAR(restrictedArea) = [GVAR(defenderSide), if (worldName isEqualTo "Altis") then {GVAR(polygon)} else {getMarkerPos GVAR(markerBase)}, if (worldName isEqualTo "Altis") then {0} else {markerDir GVAR(markerBase)}];
	
	[] call FUNC(configureServerEventHandler);
	
	if (!([] call FUNC(initializeDataBase))) then {
		PGVAR(SERVER_ERRORS) pushBack "Failed at initializing database";
	};
	
	[] call FUNC(createDBEntryStatistic);
	
	[] call compile preprocessFileLineNumbers "scripts\Engima\Civilians\Init.sqf";
	//[] call compile preprocessFileLineNumbers "scripts\Engima\Traffic\Init.sqf";
	
	[] call compile preprocessFileLineNumbers "scripts\advancedSlingLoading\functions\fn_advancedSlingLoadingInit.sqf";
	
	[
		{
			[] call FUNC(createTasks);
		},
		[]
	] call CBA_fnc_execNextFrame;
	
	["Initialize"] call BIS_fnc_dynamicGroups;
	
	// broadcast indicators to all clients
	publicVariable QPGVAR(BASES_CHANGED);
	publicVariable QPGVAR(INF_CHANGED);
	publicVariable QPGVAR(retreat);
	publicVariable QPGVAR(countFOB);
	publicVariable QPGVAR(markerCamps);
	publicVariable QPGVAR(PREPARATION_FINISHED);
	publicVariable QPGVAR(restrictedArea);
	
	publicVariable QPGVAR(SERVER_ERRORS);
	[] call FUNC(reportServerStatus);
	
	// give the server some time to really start the mission in order to prevent it from doing stupid stuff on its own
	[
		{
			PGVAR(SERVER_INITIALIZED) = true;
			// indicate that the server framework is ready
			publicVariable QPGVAR(SERVER_INITIALIZED);			
			
			nil;
		},
		[],
		7
	] call CBA_fnc_waitAndExecute;	
};

if (hasInterface) then {	
	// TODO: use pretty image
	"loadingBlackScreen" cutText ["Initializing Mission...", "BLACK", 0.00000001, true];
		
	[
		{
			// wait until the map is loaded
			!((findDisplay 12) isEqualTo displayNull)
		},
		{
			// initialize the respawn system
			[] call FUNC(respawnInit);
			
			// initialize the map-position system
			[] call FUNC(mapPositionsInit);
			
			// disable "faggot-button"
			_display = uiNamespace getVariable "RSCDiary";
			_ctrl = _display displayCtrl 1202;
			_ctrl ctrlEnable false;
			_ctrl ctrlsettextcolor [0,0,0,0];
			_ctrl ctrlSetTooltip "";
			_ctrl ctrlCommit 0;
			
			// add EH for the infantry list change
			QPGVAR(INF_CHANGED) addPublicVariableEventHandler {
				// fire event on this client
				[
					EVENT_INF_CHANGED,
					[]
				] call FUNC(fireEvent);
			};
			
			// add EH for base list change
			QPGVAR(BASES_CHANGED) addPublicVariableEventHandler {
				[
					EVENT_BASES_CHANGED,
					[]
				] call FUNC(fireEvent);
			};
			
			QPGVAR(PREPARATION_FINISHED) addPublicVariableEventHandler {
				(_this select 1) params [					
					["_preparationFinished", false, [true]],
					["_time", -1, [0]]
				];				
				
				if (_preparationFinished) then {
					[
						{
							private _succcess = params [
								["_args", [], [[]]],
								["_handlerID", -1, [0]]
							];

							CHECK_TRUE(_succcess, Invalid parameters!, {})
							
							if ((_args select 0) >= CBA_missionTime) then {							
								_text = format ["<t color='#99ffffff' size='2' align='center'>All players are prepared! Mission starts in %1 seconds!</t>", round ((_args select 0) - CBA_missionTime)];
								(uiNamespace getVariable [QGVAR(infoControl), displayNull]) ctrlSetStructuredText parseText _text;
							} else {
								(uiNamespace getVariable [QGVAR(infoControl), displayNull]) ctrlSetStructuredText parseText "";
								(uiNamespace getVariable [QGVAR(infoPlayerReady), displayNull]) ctrlSetStructuredText parseText "";
								
								if (!GVAR(inTriggerRA)) then {
									[] call FUNC(triggerRADeact);
								};
								
								{
									deleteVehicle _x;
									nil									
								} count GVAR(triggerRA);
								
								[_handlerID] call CBA_fnc_removePerFrameHandler;
							}
						},
						1,
						[_time]
					] call CBA_fnc_addPerFrameHandler;					
				};
			};
			
			[] call FUNC(synchronizeBaseList);
			
			// wait for the server to initialize the framework and for the local baseList to get synchronnized
			[
				{
					!isNil QPGVAR(SERVER_INITIALIZED) && {PGVAR(SERVER_INITIALIZED) && !PGVAR(BASES_CHANGED)}
				},
				{
					hint "Starting...";
					
					// Check for error messages
					if(count PGVAR(SERVER_ERRORS) != 0) then {
						// Display error messages to the user
						[] call FUNC(displayServerErrorMessages);
					} else {
						// configure teh respawn data
						[] call FUNC(updateRespawnData);
						
						"loadingBlackScreen" cutFadeOut 0.1;
						[] call FUNC(showRespawnMenu);
						
						with uiNamespace do {
							_text1 = format ["<t color='#99ffffff' size='2' align='center'>Mission starts when all players are prepared to fight!</t>"];
							_text2 = format ["<t color='#99ffffff' size='1' align='center'>Players ready: 0%1</t>", "%"];
							
							GVAR(infoControl) = findDisplay 46 ctrlCreate ["RscStructuredText", -1];
							
							GVAR(infoControl) ctrlSetPosition [safeZoneX, 0, safeZoneW, 0.1];
							GVAR(infoControl) ctrlSetStructuredText parseText _text1;
							GVAR(infoControl) ctrlCommit 0;

							GVAR(infoPunishmentControl) = findDisplay 46 ctrlCreate ["RscStructuredText", -1];
							
							GVAR(infoPunishmentControl) ctrlSetPosition [safeZoneX,safeZoneY + 0.5,safeZoneW,0.1];	
							GVAR(infoPunishmentControl) ctrlCommit 0;
							
							GVAR(infoPlayerReady) = findDisplay 46 ctrlCreate ["RscStructuredText", -1];
				
							GVAR(infoPlayerReady) ctrlSetPosition [safeZoneX,safeZoneY + 0.35,safeZoneW,0.1];
							GVAR(infoPlayerReady) ctrlSetStructuredText parseText _text2;	
							GVAR(infoPlayerReady) ctrlCommit 0;				
						};
					};
				}
			] call CBA_fnc_waitUntilAndExecute;
			
			nil;
		}
	] call CBA_fnc_waitUntilAndExecute;	
};

nil;
