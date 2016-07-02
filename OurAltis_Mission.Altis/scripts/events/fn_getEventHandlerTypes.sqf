#include "macros.hpp"
/**
 * OurAltis_Mission - fn_getEventHandlerTypes
 * 
 * Author: Raven
 * 
 * Description:
 * Gets an array of all event types an EventHandler is configured for on this machine
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * The list of event types <Array>
 * 
 */

private _types = [];
{
	_types pushBack (_x select 0);
} count GVAR(EventHandler);

_types;
