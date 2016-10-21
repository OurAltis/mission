#include "macros.hpp";
/**
 * OurAltis_Mission - fn_addRespawnPosition
 * 
 * Author: Raven
 * 
 * Description:
 * Adds a respawn position to the player
 * 
 * Parameter(s):
 * 0: The display name of the position <String>
 * 1: The actual position <Position>
 * 2: Whether a change event should get fired (optional, default: true) <Boolean>
 * 
 * Return Value:
 * The ID of the added position <Number>
 * 
 */

private _success = params [
	["_name", "", [""]],
	["_position", "", [[]], [2,3]]
];

CHECK_TRUE(_success, Invalid arguments!, {});

private _id = RGVAR(NewPositionID);

// add position
RGVAR(RespawnPositions) pushBack [_id, _name, _position];

// increase ID counter
RGVAR(NewPositionID) = RGVAR(NewPositionID) + 1;


// add mapPosition for respawn position
private _pos2d = _position;
_pos2d resize 2;
[
	_name,
	_pos2d,
	true,
	{
		private _success = params [
			["_selectedPosition", "", [""]],
			["_data", [], [[]], [2]]
		];
		
		CHECK_TRUE(_success, Invalid parameters!, {})
		
		with uiNamespace do {
			for "_i" from 0 to (lbSize RGVAR(RespawnMenuPositionSelection)) do {
				if((RGVAR(RespawnMenuPositionSelection) lbText _i) isEqualTo _selectedPosition) exitWith {
					RGVAR(RespawnMenuPositionSelection) lbSetCurSel _i;
					RGVAR(RespawnMenuPositionSelection) ctrlCommit 0;
				};
			};
		};
	}
] call FUNC(createMapPosition);


private _fireEvent = true;
// check if event should be fired
if(count _this > 2) then {
	_fireEvent = _this select 2;
	
	if(!(_fireEvent isEqualType false)) then {
		ERROR_LOG(Expected Boolean, but was different!);
		
		_fireEvent = true;
	};
};
// fire event if wished
if (_fireEvent) then {
	// fire event that a position has been added
	[EVENT_RESPAWN_POSITIONS_CHANGED, [true]] call FUNC(fireEvent);
};


_id;
