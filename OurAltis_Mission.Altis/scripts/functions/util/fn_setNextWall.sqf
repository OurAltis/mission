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

diag_log ("Start fn_setNextWall");

params [
	["_obj", objNull, [objNull]],
	["_forward", true, [true]]
];	

diag_log ("Objects: " + str(_obj));
diag_log ("Forward: " + str(_forward));

if (_obj isEqualTo objNull) exitWith {
	systemChat ("ERROR! NO OBJECT GIVIN: " + str(_obj) + " : " + str(_pos));
	diag_log ("ERROR! NO OBJECT GIVIN: " + str(_obj) + " : " + str(_pos));
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

diag_log ("_pos: " + str(_pos));

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
		
		if (_return isEqualTo objNull) then {diag_log ("Error, No connector found: " + str(_obj))};
		
		_obj setVariable ["nextFence_" + (["backward", "forward"] select _forward), _return];
	} else {			
		_error = 1;
	};		
};

_obj setVariable ["error", _error];

if (_error > 0) then {	
	systemChat ("Error: " + str(_error) + ", " + str(_obj));
	diag_log ("Error: " + str(_error) + ", " + str(_obj));
};

private _helperObj = if (_error > 0) then {
	createVehicle ["Sign_Arrow_Large_F", _posHelper, [], 0, "CAN_COLLIDE"];
} else {
	createVehicle ["Sign_Arrow_Large_Green_F", _posHelper, [], 0, "CAN_COLLIDE"];
};

_obj setVariable ["helperObj_" + (["backward", "forward"] select _forward), _helperObj];

diag_log ("End fn_setNextWall");
