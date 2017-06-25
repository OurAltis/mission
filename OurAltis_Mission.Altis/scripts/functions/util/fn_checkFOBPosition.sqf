#include "macros.hpp"
/**
 * OurAltis_Mission - fn_checkFOBPosition
 * 
 * Author: Raven
 * 
 * Description:
 * Checks position of respective cars which are needed to build the FOB
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

if ((_target distance2D (_target getVariable [QGVAR(spawnPosition), [0, 0, 0]])) <= 2400) then {
	private _nearCars = (position _target) nearEntities [(VEHICLE_MOBILE_CAMP select 1), 10];
	diag_log _nearCars;
	_nearCars deleteAt 0;
	diag_log _nearCars;
	private _centerTarget = boundingCenter _target;

	private _marker = createMarkerLocal ["tempMarker_FOB", _target modelToWorld [_centerTarget select 0, (_centerTarget select 1) - 8]];
	_marker setMarkerShapeLocal "RECTANGLE";
	_marker setMarkerSizeLocal [1, 1];
	_marker setMarkerDirLocal (getDir _target);
	_marker setMarkerAlphaLocal 1;

	private _carsInMarker = _nearCars inAreaArray "tempMarker_FOB";
	diag_log _carsInMarker;
	if (count _carsInMarker > 1) exitWith {hint "There are to many cars in the construction area!"};
	if (count _carsInMarker isEqualTo 0) exitWith {hint "You need the other car to build the FOB!"};

	private _dirVectorCar1 = vectorDir _target;
	_dirVectorCar1 set [2, 0];
	private _dirVectorCar2 = vectorDir (_nearCars select 0);
	_dirVectorCar2 set [2, 0];
	private _tolerance = 10;	

	private _angle = acos((_dirVectorCar1 vectorDotProduct _dirVectorCar2) / ((vectorMagnitude _dirVectorCar1) * (vectorMagnitude _dirVectorCar2)));

	if (_angle <= _tolerance) then {
		hint "Building FOB";	
		
		_arrayPos = if (side (group _caller) isEqualTo west) then{0} else {1};
		_countFOB = PGVAR(countFOB) select _arrayPos;
		
		PGVAR(countFOB) set [_arrayPos, _countFOB + 1, true];
		[getPosATL _target, side group _caller, _countFOB + 1] remoteExecCall [QFUNC(createFOB), 2];

		if ((_countFOB + 1) isEqualTo 2) then {
			[_target, _actionID] remoteExecCall ["removeAction",  side group _caller];			
			[] remoteExecCall ["", (_target getVariable [QGVAR(JIPID), ""])];
		};
	} else {
		hint "You have to park the car with the platform behind the car with the container in same direction!";	
	};
	
	deleteMarkerLocal "tempMarker_FOB";
} else {hint "You are to far away from the base!"};

nil
