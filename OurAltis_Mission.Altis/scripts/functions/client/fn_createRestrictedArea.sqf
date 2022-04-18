#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createRestrictedArea
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Creates a trigger which will be deleted when mission starts
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

if (PGVAR(PREPARATION_FINISHED) select 0) exitWith {nil};

private _positionTrigger = [];
private _dirTrigger = [];
private _triggerAll = [];

if (side (group player) isEqualTo (PGVAR(restrictedArea) select 0)) then {
	if (worldName isEqualTo "Altis") then {
		GVAR(testKillzone1) = GVAR(testKillzone1) + 1;
		
		[
			{
				params[
					["_args", [], [[]]],
					["_handle", -1, [0]]
				];
								
				if (alive (vehicle player)) then {
					if (!(position (vehicle player) inPolygon (PGVAR(restrictedArea) # 1))) then {
						if ((PGVAR(PREPARATION_FINISHED) # 1 <= CBA_missionTime) && (PGVAR(PREPARATION_FINISHED) # 1) != 0) then {						
							[_handle] call CBA_fnc_removePerFrameHandler;
							GVAR(roundStart) = true;
							GVAR(testKillzone1) = GVAR(testKillzone1) - 1;
						};
						
						if !(missionNamespace getVariable [QGVAR(outOfZone), false]) then {
							GVAR(outOfZone) = true;
							
							GVAR(testKillzone2) = GVAR(testKillzone2) + 1;
							
							[
								{
									params[
										["_args", [], [[]]],
										["_handle", -1, [0]]
									];
									
									diag_log ("Player: " + str(player));
									
									if (GVAR(outOfZone) && !(GVAR(roundStart))) then {
										if ((_args select 0) >= CBA_missionTime) then{
											_text = format ["<t color='#99ffffff' align='center'>Go back or you will die in %1 seconds!</t>", round ((_args select 0) - CBA_missionTime)];
											(uiNamespace getVariable [QGVAR(infoPunishmentControl), displayNull]) ctrlSetStructuredText parseText _text;
										} else {
											(uiNamespace getVariable [QGVAR(infoPunishmentControl), displayNull]) ctrlSetStructuredText parseText "";
											(vehicle player) setDamage 1;
											[_handle] call CBA_fnc_removePerFrameHandler;
											GVAR(testKillzone2) = GVAR(testKillzone2) - 1;
										};
									} else {
										(uiNamespace getVariable [QGVAR(infoPunishmentControl), displayNull]) ctrlSetStructuredText parseText "";
										[_handle] call CBA_fnc_removePerFrameHandler;
										GVAR(testKillzone2) = GVAR(testKillzone2) - 1;
									};
								},
								1,
								[CBA_missionTime + 10]
							] call CBA_fnc_addPerFrameHandler;
						};				
					} else {
						GVAR(outOfZone) = false;
					};
				} else {
					GVAR(outOfZone) = false;
					[_handle] call CBA_fnc_removePerFrameHandler;
					GVAR(testKillzone1) = GVAR(testKillzone1) - 1;
				};
			},
			1,
			[]
		] call CBA_fnc_addPerFrameHandler;
		
		/*[
			{
				params[
					["_args", [], [[]]],
					["_handle", -1, [0]]
				];		
				
				if !((position player) inPolygon (PGVAR(restrictedArea) # 1)) then {
					if ((_args select 0) >= CBA_missionTime) then{
						_text = format ["<t color='#99ffffff' align='center'>Go back or you will die in %1 seconds!</t>", round ((_args select 0) - CBA_missionTime)];
						(uiNamespace getVariable [QGVAR(infoPunishmentControl), displayNull]) ctrlSetStructuredText parseText _text;
					} else {
						(vehicle player) setDamage 1;
						[_handle] call CBA_fnc_removePerFrameHandler;
					};
				}else{
					[_handle] call CBA_fnc_removePerFrameHandler;
				};
			},
			1,
			[CBA_missionTime + 10]
		] call CBA_fnc_addPerFrameHandler;*/
	} else {
		_positionTrigger pushBack (PGVAR(restrictedArea) select 1);	
		_dirTrigger pushBack (PGVAR(restrictedArea) select 2);
	};
} else {	
	{
		_positionTrigger pushback (getMarkerPos _x);
		_dirTrigger pushback (markerDir _x);
		
		nil
	} count GVAR(markerCamps);
};

{
	private _trigger = createTrigger ["EmptyDetector", _x, false];
	_trigger setTriggerArea [250, 250, _dirTrigger select _forEachIndex, true];
	_trigger setTriggerActivation ["ANY", "NOT PRESENT", true];
	_trigger setTriggerStatements ["!((vehicle player) in thisList) && alive (vehicle player)",
		"call " + QFUNC(triggerRAAct),
		"call " + QFUNC(triggerRADeact)
	];
	
	_trigger enableSimulation false;
	
	_triggerAll pushBack _trigger;
	
	nil
} forEach _positionTrigger;

_triggerAll
