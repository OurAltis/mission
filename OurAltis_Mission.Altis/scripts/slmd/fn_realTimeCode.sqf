#include "macros.hpp"
/*
* SL_Markierungsdienst - fn_realTimeCode
* 
* Author: PhilipJFry
* 
* Description:
* Draw Icons
* 
* Parameter(s):
* 0: None <ANY>
* 
* Return Value:
* None <ANY>
*/

private ["_knightVision", "_zoom", "_zoomRevision", "_viewDist", "_playerDist", "_sizeIcon", "_alphaIcon", "_icon", "_iconPath", "_alphaName"];

if (currentVisionMode player == 1) then {
	_knightVision = if (sunOrMoon == 1) then {0} else {1.5};		
} else {
	_knightVision = 1;
};
  
_zoom = round (([0.5,0.5] distance worldToScreen positionCameraToWorld [0,1.05,1]) * (getResolution select 5));
_zoomRevision = if (fog > 0.6) then {_zoom} else {1};
_viewDist = 1000 * GVAR(kDayKnight) * GVAR(kFog) * GVAR(kRain) * _knightVision * (_zoom/_zoomRevision);

{
	if (((worldToScreen (visiblePosition _x)) select 0 > (0 * safeZoneWAbs + safeZoneXAbs)) && ((worldToScreen (visiblePosition _x)) select 0 < (1 * safeZoneWAbs + safeZoneXAbs))) then {
		_intersects = lineIntersectsSurfaces [eyePos (vehicle player), AGLToASL(_x modelToWorld [0, 0, 2.25]),vehicle player, _x];
		
		if (count _intersects == 0) then {	
			_playerDist = player distance _x;
			
			if (_playerDist <= _viewDist && _x != player) then {
				_sizeIcon = if (_playerDist > 0) then {(rad(2 * atan((0.422793 * 30) / _playerDist))) * _zoom} else {0.8};
				
				if (_sizeIcon > 0.8) then {
					_sizeIcon = 0.8;
				};
				
				_alphaIcon = linearConversion [0, _viewDist, _playerDist, 1, 0, true];
				
				if ((vehicle _x) isEqualTo _x && alive _x) then {		
					//---GET THE PATH OF THE ICON OF THE SOLDIER
					_icon = getText (configFile >> "CfgVehicles" >> typeOf _x >> "icon");
					_iconPath = (getText (configfile >> "CfgVehicleIcons" >> _icon));
								
					//---IF THE SOLDIER IS A HUMAN PLAYER
					if (isPlayer _x) then{
						//---TRANSPARENCY FOR THE NAMEICON OF THE SOLDIER
						_alphaName = linearConversion [5, 30, _playerDist, 1, 0, true];			
						
						drawIcon3D [
							_iconPath,
							[GVAR(color) select 0, GVAR(color) select 1, GVAR(color) select 2, (GVAR(color) select 3) * _alphaIcon],
							_x modelToWorldVisual [0, 0, ((_x selectionPosition "Spine3") select 2) + 1], //_x modelToWorldVisual [0, 0, 2.25],
							_sizeIcon,
							_sizeIcon,
							0				
						];
						
						//---NAME OF PLAYERS			
						drawIcon3D ["", [1,1,1,1 * _alphaName], _x modelToWorldVisual [0, 0, 1.25], 0, 0, 0, format["%1", name _x],0,0.03];						
					} else {
						//---SET THE PARAMAETER ARRAY FOR THE GIVIN SOLDIER AND STORE IT IN THE _UNITSREADY ARRAY			
						drawIcon3D [
							_iconPath,
							[GVAR(color) select 0, GVAR(color) select 1, GVAR(color) select 2, (GVAR(color) select 3) * _alphaIcon],
							_x modelToWorldVisual [0, 0, ((_x selectionPosition "Spine3") select 2) + 1], //_x modelToWorldVisual [0, 0, 2.25],
							_sizeIcon,
							_sizeIcon,
							0				
						];
					};		
				};
				
				if ((vehicle _x) != _x && count (crew vehicle _x) > 0 && !(player in (crew vehicle _x))) then {
					//---GET THE PATH OF THE ICON OF THE VEHICLE
					_iconPath = getText (configFile >> "CfgVehicles" >> typeOf (vehicle _x) >> "picture");			
					
					drawIcon3D [
						_iconPath,
						[GVAR(color) select 0, GVAR(color) select 1, GVAR(color) select 2, (GVAR(color) select 3) * _alphaIcon],
						(vehicle _x) modelToWorldVisual [0, 0, 2.25],
						_sizeIcon * 2,
						_sizeIcon,
						0				
					];
				};
			};
		};
	};
	
	nil
} count GVAR(relevantUnits);

nil
