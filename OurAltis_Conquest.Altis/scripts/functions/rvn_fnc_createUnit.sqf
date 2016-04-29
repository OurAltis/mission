/**
* Creates the given unit and applies the given damage to it
*
* @param The class name of the unit to create
* @param The group the created unit should be added to
* @param The damage the unit should be initialized with
* @param The position where the unti should be created
*/
scopeName "rvn_fnc_createUnit";

private _unitName = param [0, "", ["String"]];
private _group = param [1, grpNull, [grpNull]];
private _damage = param [2, 1, [0]];
private _pos = param [3, [0,0,0], [["Array"]], [2, 3]];

if(_unitName isEqualTo "") then {
	// can't create unit without name
	[0, "rvn_fnc_createUnit", "No unit name given!"] call rvn_fnc_log;
} else {
	// create unit
	if(_damage <= 0 || _damage >= 1) then {
		// check damage value
		[0, "rvn_populateDefenders", "The given damage (" + str _damage + ") is inappropriate!"] call rvn_fnc_log;
		_damage = 0;
	};
	
	_unitName createUnit [_pos, _group, "this setDamage _damage"];
};
