#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createFOB
 * 
 * Author: Raven
 * 
 * Description:
 * Creates a FOB out of two spezial vehicles
 * 
 * Parameter(s):
 * 0: Target  <Object>
 * 1: Caller <Object>
 * 2: ID <Scalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_target", objNull, [objNull]],
	["_caller", objNull, [objNull]],
	["_actionID", -1, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _nearCars = (position _target) nearEntities [typeOf _target, 10];

if (count _nearCars > 1) then {
	if ((_nearCars select 0) isEqualTo _target) then {
		_nearCars deleteAt 0;	
	};
	
	private _bbr = boundingBoxReal _target;
	private _p1 = _bbr select 0;
	private _p2 = _bbr select 1;
	private _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
	private _maxLength = abs ((_p2 select 1) - (_p1 select 1));
	private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));
	
	private _markerPos = _target modelToWorld [0, - _maxLength, 0];
	
	private _marker = createMarker ["markerFOB", _markerPos];
	_marker setMarkerShape "RECTANGLE";
	_marker setMarkerSize [_maxWidth, _maxLength];
	_marker setMarkerDir (getDir _target);
	_marker setMarkerColor "ColorRed";
} else {hint "You need two cars!"};
