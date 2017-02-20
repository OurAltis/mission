#include "macros.hpp"
/**
 * OurAltis_Mission - fn_getInternalClassName
 * 
 * Author: Raven
 * 
 * Description:
 * This function gets the internal class name for the given displayed class name
 * 
 * Parameter(s):
 * 0: The displayed classname that should be converted <String>
 * 
 * Return Value:
 * The internal className <String>
 * 
 */

private _success = params [
	["_displayedClassName", "", [""]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _internalClassName = "UnableToResolveClassName";

switch (_displayedClassName) do {
	case localize "OurA_str_Rifleman" : {_internalClassName = "Rifleman";};
	case localize "OurA_str_Grenadier" : {_internalClassName = "Grenadier";};
	case localize "OurA_str_MG" : {_internalClassName = "MG";};
	case localize "OurA_str_AT" : {_internalClassName = "AT";};
	case localize "OurA_str_AA" : {_internalClassName = "AA";};
	case localize "OurA_str_Marksman" : {_internalClassName = "Marksman"};
	case localize "OurA_str_Spotter" : {_internalClassName = "Spotter";};
	case localize "OurA_str_Medic" : {_internalClassName = "Medic";};
	case localize "OurA_str_Engineer" : {_internalClassName = "Engineer";};
	case localize "OurA_str_Pilot" : {_internalClassName = "Pilot";};
	case localize "OurA_str_Driver" : {_internalClassName = "Driver";};
	case localize "OurA_str_Crew" : {_internalClassName = "Crew";};
	case localize "OurA_str_MGAssistant" : {_internalClassName = "MGAssistent";};
	case localize "OurA_str_SQL": {_internalClassName = "SQL";};
	case localize "OurA_str_UAV" : {_internalClassName = "UAV";};
	default {FORMAT_LOG(Unknown class %1!, _className);};
};

_internalClassName;
