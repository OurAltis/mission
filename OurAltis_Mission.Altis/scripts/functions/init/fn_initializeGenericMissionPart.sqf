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

if(isServer) then {
	[] call FUNC(configureServerEventHandler);
	[] call FUNC(calculateBaseMarkerOffset);
	[] call FUNC(setUpLoadouts);
};
