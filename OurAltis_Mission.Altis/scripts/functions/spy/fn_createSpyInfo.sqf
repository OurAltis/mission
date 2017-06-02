#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createSpyInfo
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Create diary report
 * 
 * Parameter(s):
 * 0: Infantry list <Array>
 * 1: Vehicle list <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_budget", 0, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

diag_log _this;

hint "Information received";

player createDiaryRecord ["Diary", ["Intel", format ["The enemy has a budget of %1 Mio $", _budget]];

nil