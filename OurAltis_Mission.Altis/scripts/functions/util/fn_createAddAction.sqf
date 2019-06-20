#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createAddAction
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Adds an action to something
 * 
 * Parameter(s):
 * 0: Object <Object>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
private _success = params [
	["_object1", objNull, [objNull]],
	["_object2", objNull, [objNull]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

if (!alive _object1 || isNull _object1) exitWith {NOTIFICATION_LOG(Object1 is not there!)};

if (_object1 isKindOf "Man") then {
	if (side group _object1 isEqualTo civilian) then {
		GVAR(spyAddAction) = _object1 addAction [localize "OurA_str_SpyGetInfo", {_this call FUNC(askSpy)}, nil, 0, false, true, "", "(_target distance2D _this) <= 3"];
		_object1 setVariable [QGVAR(askSpyAction), GVAR(spyAddAction)];
	} else {
		GVAR(voteActionReady) = _object1 addAction [localize "OurA_str_voteOptionReady", {_this call FUNC(doVote)}, nil, 0, false, true, "", "!(" + QPGVAR(votingFinish) + ") && !(" + QGVAR(playerReady) + ")"];
		GVAR(voteActionNotReady) = _object1 addAction [localize "OurA_str_voteOptionNotReady", {_this call FUNC(doVote)}, nil, 0, false, true, "", "!(" + QPGVAR(votingFinish) + ") && " + QGVAR(playerReady)];
	}
};

if (_object1 isKindOf "Car" && (_object1 getVariable [QGVAR(FOBAddAction), -1]) isEqualTo -1) then {
	private _actionID = _object1 addAction [localize "OurA_str_FOBBuild", {_this call FUNC(checkFOBPosition)}, nil, 0, false, true, "", "(_target distance2D _this) <= 3 && (vehicle _this) isEqualTo _this && !(_target getVariable ['OurA_isUsed', false])"];
	_object1 setVariable [QGVAR(FOBAddAction), _actionID];
};

if (!isNull _object2) then {
	if (alive _object2) then {
		if (!isNil {_object2 getVariable QGVAR(hasCargo)} && (_object2 getVariable [QGVAR(deployAddAction), -1]) isEqualTo -1) then {
			private _actionID = _object2 addAction [localize "OurA_str_DeployBoat", {_this call FUNC(deployBoat)}, nil, 0, false, true, "", "(_target distance2D _this) <= 3 && (vehicle _this) isEqualTo _this && _target getVariable ['OurA_hasCargo', false]"];
			_object2 setVariable [QGVAR(deployAddAction), _actionID];
		};

		if (!isNil {_object2 getVariable QGVAR(hasCargo)} && (_object2 getVariable [QGVAR(loadUpAddAction), -1]) isEqualTo -1) then {
			private _actionID = _object2 addAction [localize "OurA_str_LoadUpBoat", {_this call FUNC(loadUpBoat)}, nil, 0, false, true, "", "(_target distance2D _this) <= 3 && (vehicle _this) isEqualTo _this && !(_target getVariable ['OurA_hasCargo', false])"];
			_object2 setVariable [QGVAR(loadUpAddAction), _actionID];
		};
	} else {NOTIFICATION_LOG(Object2 is not alive!)};
};

nil
