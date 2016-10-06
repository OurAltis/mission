#include "macros.hpp"
/**
 * OurAltis_Mission - fn_checkRespawn
 * 
 * Author: Raven
 * 
 * Description:
 * Checks whether the respawn with given data is valid. If so the infantry list will be updated.
 * 
 * Parameter(s):
 * 1: The base the respawn took playe <String>
 * 2: The role the respawn has been committed as <String>
 * 
 * Return Value:
 * The error message or an empty String if everything is okay <String>
 * 
 */

private ["_success", "_errorMsg", "_baseSide"];

_success = params [
	["_base", "", [""]],
	["_role", "", [""]]
];

CHECK_TRUE(_success, Invalid parameters!, {"[Error]: Invalid respawn data!"});

_errorMsg = "";

_baseSide = [_base] call FUNC(getBaseSide);

if(_baseSide isEqualTo sideUnknown || !(typeName _baseSide isEqualTo typeName sideUnknown)) then {
	// The base couldn't be found
	_errorMsg = "[Error]: Couldn't retrieve base side!";
} else {
	private _found = false;
	private _needsClearing = false;
	
	{
		private _currentSideInfantry = _x;
		
		// search for the respective side's baseList
		if ((_currentSideInfantry select 0) isEqualTo _baseSide) then {
			{
				private _currentBaseInfantryList = _x;
				
				// search for the respective base
				if((_currentBaseInfantryList select 0) isEqualTo _base) then {		
					{
						private _currentInfantryType = _x;
						
						if((_currentInfantryType select 0) isEqualTo _role) then {
							// found the respective role in the list
							private _amount = _currentInfantryType select 1;
							
							// decrease amount
							_amount = _amount - 1;
							
							if(_amount < 0) then {
								ERROR_LOG(Negative infantry amount!);
							};
							
							if(_amount == 0) then {
								// This role is no longer available
								_currentInfantryType = objNull; //TODO: remove later
								
								_needsClearing = true;
							} else {
								// store new amount
								_currentInfantryType set [1, _amount];
							};
							
							(_currentBaseInfantryList select 1) set [_forEachIndex, _currentInfantryType];
							
							_found = true;
						};
						
						if(_found) exitWith {};
					} forEach (_currentBaseInfantryList select 1); // iterate through all available roles
					
					if(_needsClearing) then {
						// remove empty entries
						_currentBaseInfantryList set [1, (_currentBaseInfantryList select 1) - [objNull]];
						
						if(count (_currentBaseInfantryList select 1) > 0) then {
							// There are still roles for that base
							_needsClearing = false;
						} else {
							// can't respawn at that base anymore
							_currentBaseInfantryList = objNull;
							
							// remove respawn location
							[_base] call FUNC(removeBaseRespawn);
						};
					};
					
					(_currentSideInfantry select 1) set [_forEachIndex, _currentBaseInfantryList];
					
					_found = true;
				};
				
				if(_found) exitWith {}; // break out of loop
			} forEach (_currentSideInfantry select 1); // iterate through the base-specific list
			
			if(_needsClearing) then {
				// remove empty bases
				_currentSideInfantry set [1, (_currentSideInfantry select 1) - [objNull]];
				
				if(count (_currentSideInfantry select 1) > 0) then {
					_needsClearing = false;
				} else {
					// This side does no longer has reinforcements
					_currentSideInfantry = objNull;
				};
			};
			
			GVAR(Infantry) set [_forEachIndex, _currentSideInfantry];
			
			_found = true;
		};
		
		if(_found) exitWith {}; // don't search further as it has been found
	} forEach GVAR(Infantry); // iterate through the complete infantry list
	
	if(_needsClearing) then {
		GVAR(Infantry) = GVAR(Infantry) - [objNull];
	};
	
	if(!_found) then {
		_errorMsg = "The role '" + _role + "' is no longer available...";
	};
};

_errorMsg;
