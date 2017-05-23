#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createAddAction
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Adds an action to something
 * 
 * Parameter(s):
 * 0: Object <Object>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
private _success = params [
	["_object", objNull, [objNull]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

if (!alive _object || isNull _object) exitWith {NOTIFICATION_LOG(Spy is not there!)};
 
_object addAction ["Ask for informations!", {_this call FUNC(askSpy)}, nil, 0, false, true, "", "_target distance2D _this =< 3"];