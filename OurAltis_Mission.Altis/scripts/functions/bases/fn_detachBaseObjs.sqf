#include "macros.hpp"
/**
 * OurAltis_Mission - fn_detachBaseObjs
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Detach all base objects and delete helper object
 * 
 * Parameter(s):
 * 0: Center Object <Object>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params[
		["_center", objNull, [objNull]]		
];

CHECK_TRUE(_success, Invalid parameters!, {})

{ 
  _x setpos [(getPos _x select 0), getPos _x select 1];
  if(typeOf _x isEqualTo "ArrowDesk_R_F") then{_x enableSimulationGlobal false};
  detach _x;
  
  nil
} count attachedObjects _center;

deleteVehicle _center;

nil
