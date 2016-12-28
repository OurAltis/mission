#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createVehicles
 * 
 * Author: KillzoneKid
 * 
 * Description:
 * Used to shuffle an array
 * 
 * Parameter(s):
 * 0: <Array>
 * 
 * Return Value:
 * Shuffled Array <Array>
 * 
 */

private ["_arr","_cnt"];

_arr = _this select 0;
_cnt = count _arr;

for "_i" from 1 to (_this select 1) do {
	_arr pushBack (_arr deleteAt floor random _cnt);
};

_arr
