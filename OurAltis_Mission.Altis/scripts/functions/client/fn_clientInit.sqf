#include "macros.hpp"
/**
 * OurAltis_Mission - fn_clientInit
 * 
 * Author: Raven
 * 
 * Description:
 * Initializes OurAltis on the client
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

if (!hasInterface) exitWith {}; // server shouldn't execute this

[] call FUNC(markBases);

[] call FUNC(compileLoadouts);

nil;
