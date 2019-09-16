#include "macros.hpp"
/**
 * OurAltis_Mission - fn_getTaskPic
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Returns a picture path for task description
 * 
 * Parameter(s):
 * 0: Type Of Task <String>
 * 
 * Return Value:
 * Picture Path <String>
 *  
 */

_success = params [
	["_taskType", "", [""]]
];

CHECK_TRUE(_success, Invalid base format!)

private _return = switch (_taskType) do {
	case "barracks": {"<br/><br/><img image='image\barraks.jpg' width='160' height='90'/>"};
	case "factory": {"<br/><br/><img image='image\factory.jpg' width='160' height='90'/>"};
	case "hangar": {"<br/><br/><img image='image\hangar.jpg' width='160' height='90'/>"};
	case "IDAPCamp": {"<br/><br/><img image='image\idap.jpg' width='160' height='90'/>"};
	case "IDAPSupply": {"<br/><br/><img image='image\idapSupply.jpg' width='160' height='90'/>"};
	default {"<br/><br/>Please add Picture to fn_getTaskPic!"};
};

_return
