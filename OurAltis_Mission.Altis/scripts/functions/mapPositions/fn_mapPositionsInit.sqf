#include "macros.hpp"

#define CANDIDATES QUOTE(potentialHoverCandidates)
#define CLOSEST_DISTANCE QUOTE(closestDistance)
#define CLOSEST QUOTE(clostestMapPosition)
/**
 * OurAltis_Mission - fn_mapPositionsInit
 * 
 * Author: Raven - model by PhilipJFry
 * 
 * Description:
 * Initializes the mapPosition framework
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

MGVAR(mapPositions) = [] call CBA_fnc_createNamespace;
MGVAR(mapPositionIDs) = [];
MGVAR(selectedMapPosition) = "";

// set up EH to display the map positions
findDisplay 12 displayCtrl 51 ctrlAddEventHandler[
	"Draw",
	{
		// get mouse position on the map and convert it into world coordinates
		private _mousePosition = _this select 0 ctrlMapScreenToWorld getMousePosition;
		private _map = _this select 0;
		
		private _potentialSelected = [] call CBA_fnc_createNamespace;
		_potentialSelected setVariable [CANDIDATES, []];
		_potentialSelected setVariable [CLOSEST_DISTANCE, HOVER_OFFSET * (ctrlMapScale _map) * 2];
		
		// draw the respective icons on the screen
		{
			private _data = MGVAR(mapPositions) getVariable _x;
			
			// entry does no longer exist -> abort
			if(isNil "_data") exitWith {};
			
			private _pos = _data select 0;			
			private _distance = vectorMagnitude ((_mousePosition + [0]) vectorDiff (_pos + [0]));
			
			
			// draw the actual position icon
			_this select 0 drawIcon [
				"\a3\ui_f\data\map\markers\nato\respawn_inf_ca.paa",
				[1,1,1,1],
				_pos,
				20,
				20,
				0,
				"",
				false
			];
			
			if (_distance > HOVER_OFFSET * (ctrlMapScale _map)) then {
				_map drawIcon [
					"\a3\ui_f\data\map\respawn\respawn_background_ca.paa",
					[0,0.3,0.6,0.8],
					_pos,
					36,
					36,
					0,
					"",
					false
				];
			} else {
				// Check if this is the closest to the mouse so far	
				if(_distance < _potentialSelected getVariable CLOSEST_DISTANCE) then {
					private _prevClosest = _potentialSelected getVariable CLOSEST;
					
					if(!isNil "_prevClosest") then {
						_potentialSelected setVariable [
							CANDIDATES,
							(_potentialSelected getVariable CANDIDATES) + [_prevClosest]
						];
					};
							
					_potentialSelected setVariable [CLOSEST_DISTANCE, _distance];
					_potentialSelected setVariable [CLOSEST, _x];
				} else {
					_potentialSelected setVariable [CANDIDATES,(_potentialSelected getVariable CANDIDATES) + [_x]];
				};
			};
			
			if(_x isEqualTo MGVAR(selectedMapPosition)) then {
				// if this is the active position add the circling icon around it
				_map drawIcon [
					"\a3\ui_f\data\map\groupicons\selector_selectedMission_ca.paa",
					[1,1,1,1],
					_pos,
					48,
					48,
					time * 60,
					"",
					1			
				];
			};
			
			// display ID if wished
			if((MGVAR(mapPositions) getVariable _x) select 1) then {
				_map drawIcon [
					"#(argb,8,8,3)color(0,0,0,0)",
					[1,1,1,1],
					_pos,
					48,
					48,
					0,
					_x,
					2,
					0.07,
					'RobotoCondensed',
					'right'
				];
			};
			
			nil;
		} count +MGVAR(mapPositionIDs); // use array copy in order to prevent errors
		
		// Draw remaining non-hovered positions normally
		{
			_map drawIcon [
					"\a3\ui_f\data\map\respawn\respawn_background_ca.paa",
					[0,0.3,0.6,0.8],
					(MGVAR(mapPositions) getVariable _x) select 0,
					36,
					36,
					0,
					"",
					false
				];
			
			nil;
		} count (_potentialSelected getVariable CANDIDATES);
		
		// mark hovered position
		if(!isNil {_potentialSelected getVariable CLOSEST}) then {
			_map drawIcon [
					"\a3\ui_f\data\map\respawn\respawn_backgroundHover_ca.paa",
					[0,0.3,0.6,0.8],
					(MGVAR(mapPositions) getVariable (_potentialSelected getVariable CLOSEST)) select 0,
					36,
					36,
					0,
					"",
					false
				];
		};
	}
];


// add mission-EH for the selection logic
(findDisplay 12) displayAddEventHandler [
	"MouseButtonUp",
	{
		//TODO: implement some rectangle area in which the positions are
		
		// get 3D mouse position
		private _map = findDisplay 12 displayCtrl 51;
		private _mousePosition = (_map ctrlMapScreenToWorld getMousePosition) + [0];
		private _maxDistance = HOVER_OFFSET * ctrlMapScale _map;
		private _closestDistance = _maxDistance + 1;
		private _clickedPosition = objNull;
		
		{
			private _distance = vectorMagnitude (
				_mousePosition vectorDiff (((MGVAR(mapPositions) getVariable _x) select 0) + [0]));
			
			if(_distance < _maxDistance && _distance < _closestDistance) then {
				_clickedPosition = _x;
				_closestDistance = _distance;
			};
			
			nil;
		} count +MGVAR(mapPositionIDs);
		
		if(!(_clickedPosition isEqualTo objNull)) then {
			// fire event
			[
				EVENT_MAPPOSITION_SELECTED,
				[_clickedPosition]
			] call FUNC(fireEvent);
			
			// change active map position
			[_clickedPosition] call FUNC(setActiveMapPosition);
		};
		
		nil;
	}
];


// Add EH notifed on mapPosition selection (via mouse)
[
	EVENT_MAPPOSITION_SELECTED,
	{
		private _success = params [["_selectedPosition", "", [""]]];
		
		CHECK_TRUE(_success, Invalid selected mapPosition!, {})
		
		private _data = MGVAR(MapPositions) getVariable _selectedPosition;
		
		[_selectedPosition, [_data select 0, _data select 1]] call (_data select 2);
		
		nil;
	}
] call FUNC(addEventHandler);


nil;
