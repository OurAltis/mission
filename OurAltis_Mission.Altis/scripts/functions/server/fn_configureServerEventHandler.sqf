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

nil;
