#include "macros.hpp"
/**
 * OurAltis_Mission - fn_setNextWall
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Set successor and predecessor of base walls 
 * 
 * Parameter(s):
 * 0: Object <Object>
 * 1: Richtung <Booln>
 * 
 * Return Value:
 * None <Any>
 * 
 */

params [
	["_obj", objNull, [objNull]],
	["_forward", true, [true]]
];

if (_obj isEqualTo objNull) exitWith {	
	ERROR_LOG(objNull)
};

private _pos = [];
private _class = "Land_Mil_WallBig_4m_F";

_pos = if (count _pos isEqualTo 0) then {
	if (_forward) then {			
		_obj modelToWorld [((0 boundingBox _obj) # 0) # 0, 0, 1];			
	} else {
		_obj modelToWorld [((0 boundingBox _obj) # 1) # 0, 0, 1];
	};
} else {_pos};

private _posHelper = if (_forward) then {
	_obj modelToWorld [(((0 boundingBox _obj) # 0) # 0) / 2, 0, ((0 boundingBox _obj) # 1) # 2];
} else {
	_obj modelToWorld [(((0 boundingBox _obj) # 1) # 0) / 2, 0, ((0 boundingBox _obj) # 1) # 2];
};

private _error = 0;	
private _nextObj = nearestObjects [_pos, [_class], 2.5, true];

if (_obj in _nextObj) then {
	_nextObj set [_nextObj find _obj, objNull];
	_nextObj = _nextObj - [objNull];
};

if (count _nextObj isEqualTo 1) then {
	if ((_nextObj # 0) in _allObjs) then {
		_obj setVariable ["nextFence_" + (["backward", "forward"] select _forward), _nextObj # 0];
	} else {
		_nextObj = [];
	};
};

if (count _nextObj != 1) then {
	private _connect = _obj getVariable ["connect", 0];
	private _return = objNull;
	
	if (_connect > 0) then {
		_return = {
			if ((_x getVariable ["connect", 0] isEqualTo _connect) && _x != _obj) exitWith {_x};
		} forEach _connected;
		
		if (_return isEqualTo objNull) then {NOTIFICATION_FORMAT_LOG(No connector found: %1, _obj)};
		
		_obj setVariable ["nextFence_" + (["backward", "forward"] select _forward), _return];
	} else {			
		_error = 1;
	};		
};

_obj setVariable ["error", _error];

if (_error > 0) then {	
	NOTIFICATION_FORMAT_LOG(Error: %1, _error);
};

nil
