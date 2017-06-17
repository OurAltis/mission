#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createBorderWar
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Create marker and make player visible in this area
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _position0 = (GVAR(BaseList) select 0) select 2;
private _position1 = (GVAR(BaseList) select 1) select 2;

private _mPos = [((_position0 select 0) + (_position1 select 0)) / 2, ((_position0 select 1) + (_position1 select 1)) / 2];
private _dist = _position0 distance2D _position1;
private _r = (_dist + (_dist * 0.1)) / 2;
private _deltaR = _r * 0.1;

GVAR(markerBorderWar) = createMarker ["borderWar", _mPos];
GVAR(markerBorderWar) setMarkerShape "ELLIPSE";
GVAR(markerBorderWar) setMarkerSize [_r, _r];
GVAR(markerBorderWar) setMarkerBrush "SolidBorder";
GVAR(markerBorderWar) setMarkerColor "ColorOrange";
GVAR(markerBorderWar) setMarkerAlpha 0.5;

publicVariable QGVAR(markerBorderWar);

[
	FUNC(shrinkMarker),
	60,
	[GVAR(markerBorderWar), _deltaR]
] call CBA_fnc_addPerFrameHandler;
