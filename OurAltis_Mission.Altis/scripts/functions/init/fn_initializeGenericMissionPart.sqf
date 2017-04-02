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

if (isServer) then {
	// indicators on client
	PGVAR(BASES_CHANGED) = true;
	PGVAR(INF_CHANGED) = true;
	PGVAR(SERVER_INITIALIZED) = false;
	PGVAR(SERVER_ERRORS) = []; // an array of Strings containing error messages from the server
	
	
	[] call FUNC(configureServerEventHandler);
	[] call FUNC(calculateBaseMarkerOffset);
	
	if (!([] call FUNC(initializeDataBase))) then {
		PGVAR(SERVER_ERRORS) pushBack "Failed at initializing database";
	};
	
	// broadcast indicators to all clients
	publicVariable QPGVAR(BASES_CHANGED);
	publicVariable QPGVAR(INF_CHANGED);
	
	publicVariable QPGVAR(SERVER_ERRORS);
	
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
			[] call FUNC(updateRespawnData);
			
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
			
			// wait for the server to initialize the framework
			[
				{
					!isNil QPGVAR(SERVER_INITIALIZED) && PGVAR(SERVER_INITIALIZED)
				},
				{
					// Check for error messages
					if(count PGVAR(SERVER_ERRORS) != 0) then {
						// Display error messages to the user
						[] call FUNC(displayServerErrorMessages);
					} else {
						"loadingBlackScreen" cutFadeOut 0.1;
						[] call FUNC(showRespawnMenu);
					};
				}
			] call CBA_fnc_waitUntilAndExecute;
			
			nil;
		}
	] call CBA_fnc_waitUntilAndExecute;
};
