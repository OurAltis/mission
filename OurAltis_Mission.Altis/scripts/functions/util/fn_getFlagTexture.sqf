#include "macros.hpp"
/**
 * OurAltis_Mission - fn_getFlagTexture
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Return flag texture by side
 * 
 * Parameter(s):
 * 0: Side <Side> 
 * 
 * Return Value:
 * Texture path <String>
 * 
 */

private _success = params [	
	["_side", nil, [sideUnknown]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _return = switch (_side) do {
	case west: {"\A3\Data_F\Flags\Flag_nato_CO.paa"};
	case east: {"\A3\Data_F\Flags\Flag_CSAT_CO.paa"};
	case independent: {"\A3\Data_F\Flags\Flag_FIA_CO.paa"};
};

_return
