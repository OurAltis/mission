/**
* Creates all respective attackers
*/
scopeName "rvn_initializeAttackers";

private _attackerList = param [0, [], [["Array"]]];

{
	_dir = _x param [0, 0, [0]];
	_units = _x param [1, [], [["Array"]]];
	
	if(_dir < 0 || _dir >=360) then {
		// invalid direction
		[0, "rvn_initializeAttackers", "The given direction (" + _dir + ") exceeds the expected range!"] call rvn_fnc_log;
		_dir = 0;
	};
	
	//TODO: calc pos
	_pos = [9710,7840,0];
	
	if(count _units > 0) then {
		// create the group for the current attacker squad
		_group = createGroup SIDE_ATTACKER;
		
		{
			_unitName = _x select 0;
			_damage = _x select 1;
			
			// create respective unit
			[_unitName, _group, _damage, _pos] call rvn_fnc_createUnit;
		} forEach _units;
	};
	
} forEach _attackerList;
