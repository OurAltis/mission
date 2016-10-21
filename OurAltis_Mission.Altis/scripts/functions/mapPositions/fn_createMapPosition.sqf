#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createMapPosition
 * 
 * Author: Raven
 * 
 * Description:
 * Creates a position on the map which has a visual indicator and is selectable.
 * Calling this function again with the same ID will overwrite the previous mapPosition
 * 
 * Parameter(s):
 * 0: The ID of the position (not empty) <String>
 * 1: The position <Position2D>
 * 2: Whether to display the ID next to the position on the map <Boolean>
 * 3: The code to execute when the mapPosition gets selected
 * 
 * Return Value:
 * The created mapPosition (used to delete it later) <String>
 * 
 */

private _success = params [
	["_id", "", [""]],
	["_pos", [], [[], [2]]],
	["_displayID", false, [false]],
	["_selectionCode", {}, [{}]]
];

CHECK_TRUE(_success, Invalid parameters!, {})
CHECK_FALSE(_id isEqualTo "", ID may not be empty!, {})


MGVAR(mapPositions) setVariable [_id, [_pos, _displayID, _selectionCode]];
MGVAR(mapPositionIDs) pushBack _id;


_id;
