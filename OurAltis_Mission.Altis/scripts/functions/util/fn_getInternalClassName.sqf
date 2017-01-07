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
	case localize "OurA_str_Schütze" : {_internalClassName = "Schütze";};
	case localize "OurA_str_Grenadier" : {_internalClassName = "Grenadier";};
	case localize "OurA_str_MG-Schütze" : {_internalClassName = "MG-Schütze";};
	case localize "OurA_str_Panzerabwehr" : {_internalClassName = "Panzerabwehr";};
	case localize "OurA_str_Luftabwehr" : {_internalClassName = "Luftabwehr";};
	case localize "OurA_str_Scharfschütze" : {_internalClassName = "Scharfschütze"};
	case localize "OurA_str_Aufklärer" : {_internalClassName = "Aufklärer";};
	case localize "OurA_str_Sanitäter" : {_internalClassName = "Sanitäter";};
	case localize "OurA_str_Ingenieur" : {_internalClassName = "Ingenieur";};
	case localize "OurA_str_Pilot" : {_internalClassName = "Pilot";};
	case localize "OurA_str_Fahrer" : {_internalClassName = "Fahrer";};
	case localize "OurA_str_Crew" : {_internalClassName = "Crew";};
	case localize "OurA_str_MG-Assistent" : {_internalClassName = "MG-Assistent";};
	case localize "OurA_str_Truppführer": {_internalClassName = "Trupführer";};
	case localize "OurA_str_Drohnenoperator" : {__internalClassName = "Drohnenoperator";};
	default {FORMAT_LOG(Unknown class %1!, _className);};
};

_internalClassName;
