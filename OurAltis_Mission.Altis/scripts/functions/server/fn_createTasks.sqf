#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createTasks
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Create the tasks
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 *  
 */
 
//ToDo localize text
if (GVAR(defenderSide) isEqualTo sideUnknown) then {
	[
		GVAR(BaseList) select 0 select 1,
		"base" + str(GVAR(BaseList) select 0 select 1),
		[
			localize "OurA_str_BaseBorderDescription",
			localize "OurA_str_BaseBorderTitle",
			""
		],
		GVAR(BaseList) select 1 select 2,
		"Created",
		10,
		false,
		"attack",
		false
	] call BIS_fnc_taskCreate;	
	
	[
		GVAR(BaseList) select 0 select 1,
		"camp" + str(GVAR(BaseList) select 0 select 1),
		[
			"",
			localize "OurA_str_CampTitle",
			""
		],
		GVAR(BaseList) select 0 select 2,
		"Created",
		10,
		false,
		"default",
		false
	] call BIS_fnc_taskCreate;
	
	[
		GVAR(BaseList) select 1 select 1,
		"base" + str(GVAR(BaseList) select 1 select 1),
		[
			localize "OurA_str_BaseBorderDescription",
			localize "OurA_str_BaseBorderTitle",
			""
		],
		GVAR(BaseList) select 0 select 2,
		"Created",
		10,
		false,
		"attack",
		false
	] call BIS_fnc_taskCreate;
	
	[
		GVAR(BaseList) select 1 select 1,
		"camp" + str(GVAR(BaseList) select 1 select 1),
		[
			"",
			localize "OurA_str_CampTitle",
			""
		],
		GVAR(BaseList) select 1 select 2,
		"Created",
		10,
		false,
		"default",
		false
	] call BIS_fnc_taskCreate;
} else {	
	private _attackerSide = if (GVAR(defenderSide) isEqualTo west) then {east} else {west};
	
	[
		GVAR(defenderSide),
		"baseDefender",
		[
			format [localize "OurA_str_BaseDefDescription", GVAR(targetAreaName)],
			localize "OurA_str_BaseDefTitle",
			""
		],
		GVAR(markerBase),
		"Created",
		10,
		false,
		"defend",
		false
	] call BIS_fnc_taskCreate;
	
	[
		_attackerSide,
		"baseAttacker",
		[
			format [localize "OurA_str_BaseAttDescription",	GVAR(targetAreaName)],
			localize "OurA_str_BaseAttTitle",
			""
		],
		GVAR(markerBase),
		"Created",
		10,
		false,
		"attack",
		false
	] call BIS_fnc_taskCreate;
	
	{
		[
			_attackerSide,
			"camp" + str(_forEachIndex),
			[
				"",
				localize "OurA_str_CampTitle",
				""
			],
			_x,
			"Created",
			10,
			false,
			"default",
			false
		] call BIS_fnc_taskCreate;
	} forEach GVAR(markerCamps);
	
	if (!isNil QGVAR(spyUnit)) then {
		[
			GVAR(defenderSide),
			"spyDefender",
			[
				format [localize "OurA_str_SpyDescription", GVAR(targetAreaName)],
				localize "OurA_str_SpyTitle",
				""
			],
			GVAR(markerSpy),
			"Created",
			5,
			false,
			"meet",
			false
		] call BIS_fnc_taskCreate;
		
		[
			_attackerSide,
			"spyAttacker",
			[
				format [localize "OurA_str_SpyDescription", GVAR(targetAreaName)],
				localize "OurA_str_SpyTitle",
				""
			],
			GVAR(markerSpy),
			"Created",
			5,
			false,
			"meet",
			false
		] call BIS_fnc_taskCreate;
		
		GVAR(taskState) set [0, 1];
	}; 

	if (!isNil QGVAR(economy)) then {
		{
			_x params ["_type", "_buildingCount", "_indexDB"];
			
			[
				GVAR(defenderSide),
				"ecoDefender_" + str(_indexDB),
				[
					format [localize "OurA_str_EcoDefDescription", _type, GVAR(targetAreaName)],
					format [localize "OurA_str_EcoDefTitle", _type],
					""
				],
				"marker_eco_" + str(_indexDB),
				"Created",
				5,
				false,
				"defend",
				false
			] call BIS_fnc_taskCreate;
			
			[
				_attackerSide,
				"ecoAttacker_" + str(_indexDB), 
				[
					format [localize "OurA_str_EcoAttDescription", _type, GVAR(targetAreaName)],
					format [localize "OurA_str_EcoAttTitle", _type],
					""
				],
				"marker_eco_"  + str(_indexDB),
				"Created",
				5,
				false,
				"destroy",
				false
			] call BIS_fnc_taskCreate;
			
			if (_type isEqualTo "barracks") then {
				GVAR(taskState) set [1, if (GVAR(defenderSide) isEqualTo west) then {"west"} else {"ost"}];
			};
			
			if (_type isEqualTo "factory") then {
				GVAR(taskState) set [2, if (GVAR(defenderSide) isEqualTo west) then {"west"} else {"ost"}];
			};
			
			if (_type isEqualTo "hangar") then {
				GVAR(taskState) set [3, if (GVAR(defenderSide) isEqualTo west) then {"west"} else {"ost"}];
			};
			
			nil
		} count GVAR(economy);
	};
	
	if !(GVAR(Resist) isEqualTo "") then {
		private _side = if (GVAR(Resist) isEqualTo "west") then {east} else {west};
		
		[
			_side,
			"resistance",
			[
				localize "OurA_str_ResistanceDescription",
				localize "OurA_str_ResistanceTitle",
				""
			],
			objNull,
			"Created",
			5,
			false,
			"search",
			false
		] call BIS_fnc_taskCreate;

		GVAR(taskState) set [4, 1];
	};
};

nil
