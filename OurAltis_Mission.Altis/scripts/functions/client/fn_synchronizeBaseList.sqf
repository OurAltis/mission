#include "macros.hpp"
/**
 * OurAltis_Mission - fn_synchronizeBaseList
 * 
 * Author: Raven
 * 
 * Description:
 * Synchronizes the local base list with the server
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

[
	2,
	EVENT_BASE_LIST_REQUEST,
	EVENT_BASE_LIST_RECEIVED,
	{
		// update local list
		GVAR(BaseList) = _this select 0;
		PGVAR(BASES_CHANGED) = false;
	},
	[],
	[]
] call FUNC(workWithRequest);

nil;
