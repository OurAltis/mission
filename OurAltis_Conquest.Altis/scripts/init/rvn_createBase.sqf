/**
* Creates the base for the defenders including respawn markers
* 
* @param The center coordinates of the base to create
*/

scopeName "rvn_createBase";

private ["_coordinates", "_markerPos"];

_coordinates = param[0, [0,0], [["Array"]], [2, 3]];

// create dummy indicator at position
//TODO: create actual base
"Land_Pallet_MilBoxes_F" createVehicle _coordinates;

// create marker for the defending player respawn
_markerPos = [(_coordinates select 0) + 1, _coordinates select 1];
createMarker [DEFENDER_RESPAWN_MARKER, _coordinates];
