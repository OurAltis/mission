#include "macros.hpp"
/**
 * OurAltis_Mission - fn_updateLoadoutForBase
 * 
 * Author: Raven
 * 
 * Description:
 * Updates the available loadout for the given base
 * 
 * Parameter(s):
 * 0: The base the available loadouts should correspond to <String>
 * 
 * Return Value:
 * None <Any>
 * 
 */

params [
	["_base", nil, [""]]
];

CHECK_FALSE(isNil "_base", Invalid baseName!, {});

