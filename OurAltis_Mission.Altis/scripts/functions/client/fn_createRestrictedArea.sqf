#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createRestrictedArea
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Creates a trigger which will be deleted when mission starts
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */
diag_log ("createRestrictedArea: " + str(PGVAR(restrictedArea)));

private _positionTrigger = [];
private _dirTrigger = [];
private _triggerAll = [];

if (side (group player) isEqualTo (PGVAR(restrictedArea) select 0)) then {
	_positionTrigger pushBack (PGVAR(restrictedArea) select 1);
	_dirTrigger pushBack (PGVAR(restrictedArea) select 2);
} else {	
	{
		_positionTrigger pushback (getMarkerPos _x);
		_dirTrigger pushback (markerDir _x);
		
		nil
	} count GVAR(markerCamps);
};

{
	private _trigger = createTrigger ["EmptyDetector", _x, false];
	_trigger setTriggerArea [45, 45, _dirTrigger select _forEachIndex, true];
	_trigger setTriggerActivation ["Any", "NOT PRESENT", true];
	_trigger setTriggerStatements ["!((vehicle player) in thisList) && alive (vehicle player)",
		format ["call %1", FUNC(triggerRAAct)],
		format ["call %1", FUNC(triggerRADeact)]
	];
	
	_triggerAll pushBack _trigger;
	
	nil
} forEach _positionTrigger;

_triggerAll
