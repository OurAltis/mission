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
				format [(localize "OurA_str_SpyDescription") + "<br/><br/><img image='image\spy.jpg' width='160' height='90'/>", GVAR(targetAreaName)],
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
				format [(localize "OurA_str_SpyDescription") + "<br/><br/><img image='image\spy.jpg' width='160' height='90'/>", GVAR(targetAreaName)],
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
			
			private _ecoPictures = "";
			
			if (_type isEqualTo "barracks") then {
				GVAR(taskState) set [2, if (GVAR(defenderSide) isEqualTo west) then {"west"} else {"ost"}];
				_ecoPictures = "<br/><br/><img image='image\barraks.jpg' width='160' height='90'/>";
			};
			
			if (_type isEqualTo "factory") then {
				GVAR(taskState) set [3, if (GVAR(defenderSide) isEqualTo west) then {"west"} else {"ost"}];
				_ecoPictures = "<br/><br/><img image='image\factory.jpg' width='160' height='90'/>";
			};
			
			if (_type isEqualTo "hangar") then {
				GVAR(taskState) set [4, if (GVAR(defenderSide) isEqualTo west) then {"west"} else {"ost"}];
				_ecoPictures = "<br/><br/><img image='image\hangar.jpg' width='160' height='90'/>";
			};
			
			if (_type isEqualTo "IDAPCamp") then {
				GVAR(taskState) set [5, if (GVAR(defenderSide) isEqualTo west) then {"west"} else {"ost"}];
				_ecoPictures = "<br/><br/><img image='image\hangar.jpg' width='160' height='90'/>";
			};
			
			[
				GVAR(defenderSide),
				"ecoDefender_" + str(_indexDB),				
				if (_type isEqualTo "IDAPCamp") then {
					[
						format [localize "OurA_str_EcoDefIDAPDescription", _type, GVAR(targetAreaName)],
						format [localize "OurA_str_EcoDefIDAPTitle", _type],
						""
					]
				} else {
					[
						format [localize "OurA_str_EcoDefDescription", _type, GVAR(targetAreaName)],
						format [localize "OurA_str_EcoDefTitle", _type],
						""
					]
				},
				"marker_eco_" + str(_indexDB),
				"Created",
				5,
				false,
				if (!(GVAR(supplypoint) isEqualTo []) && _type isEqualTo "IDAPCamp") then {"move"} else {"defend"},
				false
			] call BIS_fnc_taskCreate;
			
			[
				_attackerSide,
				"ecoAttacker_" + str(_indexDB), 
				if (_type isEqualTo "IDAPCamp") then {
					[
						format [localize "OurA_str_EcoAttIDAPDescription", _type, GVAR(targetAreaName)],
						format [localize "OurA_str_EcoAttIDAPTitle", _type],
						""
					]
				} else {
					[
						format [localize "OurA_str_EcoAttDescription", _type, GVAR(targetAreaName)],
						format [localize "OurA_str_EcoAttTitle", _type],
						""
					]
				},
				"marker_eco_"  + str(_indexDB),
				"Created",
				5,
				false,
				if (!(GVAR(supplypoint) isEqualTo []) && _type isEqualTo "IDAPCamp") then {"move"} else {"destroy"},
				false
			] call BIS_fnc_taskCreate;
			
			nil
		} count GVAR(economy);
	};
	
	if !(count GVAR(supplypoint) isEqualTo 0) then {
		[
			GVAR(defenderSide),
			"IDAPDefender",
			[
				localize "OurA_str_IDAPDescription",
				localize "OurA_str_IDAPTitle",
				""
			],
			"marker_sup",
			"Created",
			5,
			false,
			"meet",
			false
		] call BIS_fnc_taskCreate;
		
		[
			_attackerSide,
			"IDAPAttacker",
			[
				localize "OurA_str_IDAPDescription",
				localize "OurA_str_IDAPTitle",
				""
			],
			"marker_sup",
			"Created",
			5,
			false,
			"meet",
			false
		] call BIS_fnc_taskCreate;
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

		GVAR(taskState) set [1, 1];
	};	
};

nil
