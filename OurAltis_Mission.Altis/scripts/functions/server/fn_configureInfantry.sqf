#include "macros.hpp"
/**
 * OurAltis_Mission - fn_configureInfantry
 * 
 * Author: Raven
 * 
 * Description:
 * Configures the infantry units
 * 
 * Parameter(s):
 * 0: Infantrylist in format [[<Class>, <Amount>, <Base>], ...] <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */

{
	private ["_success", "_side", "_sideIndex", "_baseIndex"];
	
	_success = _x params [
		["_className", "Rifleman", [""]],
		["_amount", 0, [0]],
		["_base", "", [""]]
	];
	
	CHECK_TRUE(_success, Invalid infatryFormat!)
	
	// check what side the current base corresponds to
	_side = [_base] call FUNC(getBaseSide);
	
	
	// get the side specific infantry list index
	_sideIndex = -1;
	
	{
		if(_side isEqualTo (_x select 0)) exitWith {_sideIndex = _forEachIndex;};
	} forEach GVAR(Infantry);
	
	if(_sideIndex == -1) then {
		// no loadout for this side has yet been configured -> create basic structure
		_sideIndex = GVAR(Infantry) pushBack [_side, [_base, []]];
	};
	
	
	// get the index of the current base within the current side's infantry list
	_baseIndex = -1;
	
	{
		if(_forEachIndex != 0) then {
			// skip side element
			if((_x select 0) isEqualTo _base) exitWith {_baseIndex = _forEachIndex;};
		};
	} forEach (GVAR(Infantry) select _sideIndex);
	
	if(_baseIndex == -1) then {
		// base has not yet been associated with any loadouts -> initialize
		_baseIndex = GVAR(Infantry) select _sideIndex pushBack [_base, []];
	};
	
	
	// add unit to respective side and base
	(((GVAR(Infantry) select _sideIndex) select _baseIndex) select 1) pushBack [_className, _amount];
	
	nil;
} count _this;

nil;
