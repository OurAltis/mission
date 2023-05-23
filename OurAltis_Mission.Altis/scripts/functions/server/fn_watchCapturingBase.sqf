#include "macros.hpp"
/**
 * OurAltis_Mission - fn_watchCapturingBase
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Sets up a capturing framework that repeatedly checks whether there are still alive units in the base. 
 * 
 * Parameter(s):
 * 0: Flag Poles <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _succcess = params [
	["_args", [], [[]]],
	["_handlerID", -1, [0]]
];

CHECK_TRUE(_succcess, Invalid parameters!, {})

private _objects = _args select 0;
private	_flagpoles = _objects select 0;
private _index = _args select 1;
private _westUnits = {(side group _x) isEqualTo west && (vehicle _x) isEqualTo _x && _x inPolygon GVAR(polygon)} count (allUnits inAreaArray GVAR(markerBase));
private _eastUnits = {(side group _x) isEqualTo east && (vehicle _x) isEqualTo _x && _x inPolygon GVAR(polygon)} count (allUnits inAreaArray GVAR(markerBase));
private _flagPosition = flagAnimationPhase _flagPoles;
private _flagTextureWest = toLower "A3\Data_F\Flags\Flag_nato_CO.paa";
private _flagTextureEast = toLower "A3\Data_F\Flags\Flag_CSAT_CO.paa";

if (_westUnits > _eastUnits) then {				
	if (_flagPosition isEqualTo 1) then {
		if ((flagTexture _flagpoles) isEqualTo _flagTextureWest) then {
			if ((GVAR(isFlagCaptured) select _index) isEqualTo east) then {GVAR(isFlagCaptured) set [_index, west]};					
		} else {
			[_flagPoles, (_flagPosition - 0.002)] remoteExecCall ["setFlagAnimationPhase", 0];
		};				
	} else {
		if (_flagPosition isEqualTo 0) then {
			if ((flagTexture _flagpoles) isEqualTo _flagTextureEast) then {
				[_flagPoles, _flagTextureWest] remoteExecCall ["setFlagTexture", 0];
				[_flagPoles, (_flagPosition + 0.002)] remoteExecCall ["setFlagAnimationPhase", 0];			
			};
		} else {
			if ((flagTexture _flagpoles) isEqualTo _flagTextureEast) then {
				[_flagPoles, (_flagPosition - 0.002)] remoteExecCall ["setFlagAnimationPhase", 0];
			} else {
				[_flagPoles, (_flagPosition + 0.002)] remoteExecCall ["setFlagAnimationPhase", 0];
			};
		};
	};
};

if (_eastUnits > _westUnits) then {
	if (_flagPosition isEqualTo 1) then {
		if ((flagTexture _flagpoles) isEqualTo _flagTextureEast) then {			
			if ((GVAR(isFlagCaptured) select _index) isEqualTo west) then {GVAR(isFlagCaptured) set [_index, east]};
		} else {
			[_flagPoles, (_flagPosition - 0.002)] remoteExecCall ["setFlagAnimationPhase", 0];
		};			
	} else {
		if (_flagPosition isEqualTo 0) then {
			if ((flagTexture _flagpoles) isEqualTo _flagTextureWest) then {
				[_flagPoles, _flagTextureEast] remoteExecCall ["setFlagTexture", 0];
				[_flagPoles, (_flagPosition + 0.002)] remoteExecCall ["setFlagAnimationPhase", 0];			
			};
		} else {
			if ((flagTexture _flagpoles) isEqualTo _flagTextureWest) then {
				[_flagPoles, (_flagPosition - 0.002)] remoteExecCall ["setFlagAnimationPhase", 0];
			} else {
				[_flagPoles, (_flagPosition + 0.002)] remoteExecCall ["setFlagAnimationPhase", 0];
			};
		};
	};
};

nil
