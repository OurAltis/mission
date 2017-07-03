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
	private _centerTarget = boundingCenter _target;

	private _marker = createMarkerLocal ["tempMarker_FOB", _target modelToWorld [_centerTarget select 0, (_centerTarget select 1) - 8]];
	_marker setMarkerShapeLocal "RECTANGLE";
	_marker setMarkerSizeLocal [1, 1];
	_marker setMarkerDirLocal (getDir _target);
	_marker setMarkerAlphaLocal 0;
	
	private _arrayPos = if (side (group _caller) isEqualTo west) then{0} else {1};
	private _countFOB = PGVAR(countFOB) select _arrayPos;
	
	diag_log _arrayPos;
	diag_log PGVAR(countFOB);
	diag_log _countFOB;
	
	private _carsInMarker = _nearCars inAreaArray "tempMarker_FOB";
	if (count _carsInMarker > 1) exitWith {hint localize "OurA_str_manyCars"};
	if (count _carsInMarker isEqualTo 0) exitWith {hint localize "OurA_str_noCar"};
	if (count crew (_carsInMarker select 0) != 0 || count crew _target != 0) exitWith {hint localize "OurA_str_noCrew"};
	if (_countFOB isEqualTo 2) exitWith {hint localize "OurA_str_maxFOBBuild"};	
	
	private _dirVectorCar1 = vectorDir _target;
	_dirVectorCar1 set [2, 0];
	private _dirVectorCar2 = vectorDir (_carsInMarker select 0);
	_dirVectorCar2 set [2, 0];
	private _tolerance = 10;	

	private _angle = acos((_dirVectorCar1 vectorDotProduct _dirVectorCar2) / ((vectorMagnitude _dirVectorCar1) * (vectorMagnitude _dirVectorCar2)));

	if (_angle <= _tolerance) then {
		hint localize "OurA_str_FOBIsBuild";		
		
		PGVAR(countFOB) set [_arrayPos, _countFOB + 1];
		publicVariable QPGVAR(countFOB);
		diag_log PGVAR(countFOB);
		[_target, side group _caller] remoteExecCall [QFUNC(createFOB), 2];
		
		[_target, _actionID] remoteExecCall ["removeAction", -2];
		[_target, 3] remoteExecCall ["lock", 0];
		[(_carsInMarker select 0), 3] remoteExecCall ["lock", 0];
		[] remoteExecCall ["", (_target getVariable [QGVAR(JIPID), ""])];		
	} else {
		hint localize "OurA_str_FOBWrongPosition";	
	};
	
	deleteMarkerLocal "tempMarker_FOB";
} else {hint localize "OurA_str_FOBFar"};

nil
