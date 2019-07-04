#include "macros.hpp"
/**
 * OurAltis_Mission - fn_triggerRADeact
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Deactivate player punishment
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

GVAR(inTriggerRA) = true;
'colorCorrections' ppEffectEnable false; 
(uiNamespace getVariable [QGVAR(infoPunishmentControl), displayNull]) ctrlSetStructuredText parseText "";

nil
