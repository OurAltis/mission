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

	if (!isNil QGVAR(markerEco)) then {
		[
			GVAR(defenderSide),
			"ecoDefender",
			[
				format [localize "OurA_str_EcoDefDescription", GVAR(economy), GVAR(targetAreaName)],
				format [localize "OurA_str_EcoDefTitle", GVAR(economy)],
				""
			],
			"marker_eco",
			"Created",
			5,
			false,
			"defend",
			false
		] call BIS_fnc_taskCreate;
		
		[
			_attackerSide,
			"ecoAttacker", 
			[
				format [localize "OurA_str_EcoAttDescription", GVAR(economy), GVAR(targetAreaName)],
				format [localize "OurA_str_EcoAttTitle", GVAR(economy)],
				""
			],
			"marker_eco",
			"Created",
			5,
			false,
			"destroy",
			false
		] call BIS_fnc_taskCreate;
		
		GVAR(taskState) set [1, str(GVAR(defenderSide))];
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

		GVAR(taskState) set [2, 1];
	};
};

nil
