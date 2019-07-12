#include "macros.hpp"
/**
 * OurAltis_Mission - fn_prepareAirVehicleSpawn
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Reduce helipads if a big heli is in vehicle list and return helipads (Spawnpoints).
 * 
 * Parameter(s):
 * 0: Air vehicles <Array>
 * 1: Base/Camp position <Array>
 * 2: Spawn Type <String>
 * 
 * Return Value:
 * Air spawn pads <Array> 
 * 
 */

private _success = params [
	["_matchedAirVehicles", [], [[]]],
	["_airSpawnpoints", [], [[]]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

if ((_matchedAirVehicles select 0) select 0 in HELI_BIG) then {
	_airSpawnpoints params ["_pad0", "_pad1", "_pad2"];

	private _dist01 = _pad0 distance2D _pad1;
	private _dist02 = _pad0 distance2D _pad2;
	private _dist12 = _pad1 distance2D _pad2;	
	
	private _matchingPads = if (_dist01 < _dist02) then {
		if (_dist01 < _dist12) then {[_pad0, _pad1]} else {[_pad1, _pad2]};
	} else {
		if (_dist02 < _dist12) then {[_pad0, _pad2]} else {[_pad1, _pad2]};
	};
	
	private _posPad0 = getPos (_matchingPads select 0);	
	private _posPad1 = getPos (_matchingPads select 1);	
	private _mpos = [((_posPad0 select 0) + (_posPad1 select 0)) / 2, ((_posPad0 select 1) + (_posPad1 select 1)) / 2];	
	private _dir = _posPad0 getDir _posPad1;
	
	_airSpawnpoints = _airSpawnpoints - _matchingPads;
	
	(_airSpawnpoints select 0) setVariable [QGVAR(heliSmall), true]; 
	
	{
		_x setPos [0, 0, 0];
		deleteVehicle _x;
		
		nil
	} count _matchingPads;
	
	private _pad = createVehicle ["Land_HelipadCircle_F", _mpos, [], 0, "CAN_COLLIDE"];
	_pad setDir _dir;
	_pad setVariable [QGVAR(heliBig), true];
	
	_airSpawnpoints pushback _pad;
	reverse _airSpawnpoints;
};

_airSpawnpoints
