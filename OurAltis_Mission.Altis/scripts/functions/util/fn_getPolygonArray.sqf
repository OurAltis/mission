#include "macros.hpp"
/**
 * OurAltis_Mission - fn_getPolygonArray
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Set successor and predecessor of base walls 
 * 
 * Parameter(s):
 * 0: Position <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
private _success = params [
	["_pos", [], [[]]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

diag_log ("fn_getPolygonArray: start");
diag_log ("fn_getPolygonArray: _pos - " + str(_pos));

{
	private _allObjs = nearestObjects [_x, ["Land_Mil_WallBig_4m_F"], 500];
	
	{
		if ((_x getVariable ["nextFence_forward", objNull]) isEqualTo objNull) then {_allObjs set [_forEachIndex, objNull]};
	} forEach _allObjs;

	_allObjs = _allObjs - [objNull];

	private _sortedObjs = [];
	_sortedObjs pushBack (_allObjs # 0);
	
	for "_i" from 0 to (count _allObjs) - 2 do {
		private _obj = (_sortedObjs # (count _sortedObjs - 1)) getVariable ["nextfence_forward", objNull];
		_sortedObjs pushBack _obj;
	};
	
	private _dummyArray = [];
	
	{
		private _posForward = _x modelToWorld [((0 boundingBox _x) # 0) # 0, 0, 1];
		private _posBackward = _x modelToWorld [((0 boundingBox _x) # 1) # 0, 0, 1];
		
		_dummyArray pushBack _posBackward;
		_dummyArray pushBack _posForward;
		//_dummyArray pushBack (getpos _x);		
	} forEach _sortedObjs;	
	
	diag_log ("GETPOLYGONARRAY: _dumyArray - " + str(_dummyArray));
	
	GVAR(polygon) pushBack _dummyArray;
	diag_log ("GETPOLYGONARRAY: " + QGVAR(polygon) + " - "  + str(GVAR(polygon)));
} forEach (_pos);

diag_log ("fn_getPolygonArray: end");

/*
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", 
	{		
		params ["_control"];		
		
		{		
			_control drawPolygon [_x, [0,0,1,1]];
		} forEach sortedPos;
	}
];*/
