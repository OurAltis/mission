#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createSpy
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Create the Spy
 * 
 * Parameter(s):
 * 0: Position <Array>
 * 1: Mood <Scalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
private _success = params [
	["_position", nil, [[]], [2,3]],
	["_mood", 0, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

GVAR(spyGroup) = createGroup [civilian, true];

GVAR(spyVehicle) = createVehicle ["C_Van_01_fuel_F", _position, [], 0, "NONE"];
GVAR(spyUnit) = GVAR(spyGroup) createUnit ["C_man_polo_1_F_asia", _position, [], 0, "NONE"];

[GVAR(spyUnit)] remoteExecCall [QFUNC(createAddAction), -2, true];

GVAR(markerSpy) = createMarker ["marker_spy", _position];
GVAR(markerSpy) setMarkerShape "ELLIPSE";
GVAR(markerSpy) setMarkerSize [5,5];
GVAR(markerSpy) setMarkerColor "ColorRed";

nil
 