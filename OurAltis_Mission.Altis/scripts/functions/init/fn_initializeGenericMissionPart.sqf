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
	[] call FUNC(configureServerEventHandler);
	[] call FUNC(calculateBaseMarkerOffset);
	[] call FUNC(initializeDataBase);
	
	// indicators on client whether the lists have changed on the server
	PGVAR(BASES_CHANGED) = true;
	PGVAR(INF_CHANGED) = true;
	PGVAR(SERVER_INITIALIZED) = true;
	
	// broadcast indicators to all clients
	publicVariable QPGVAR(BASES_CHANGED);
	publicVariable QPGVAR(INF_CHANGED);
	
	// indicate that the server framework is ready
	publicVariable QPGVAR(SERVER_INITIALIZED);
};

if (hasInterface) then {
	[
		// wait until server framework has initialized
		{
			!isNil QPGVAR(SERVER_INITIALIZED) && QPGVAR(SERVER_INITIALIZED)
		},
		{}
	] call CBA_waitUntilAndExecute;
	
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
		}
	] call CBA_fnc_waitUntilAndExecute;
	
	JUST_CONNECTED = true;
};
