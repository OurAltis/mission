#include "macros.hpp"
/**
 * OurAltis_Mission - fn_showPauseMenu
 * 
 * Author: Raven - original from PRA3/addons/PRA3_Server/RespawnUI/fn_showDisplayInterruptEH.sqf (BadGuy, NetFusion)
 * 
 * Description:
 * This will open the pause menu that normally is triggered by Esc
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

createDialog (["RscDisplayInterrupt", "RscDisplayMPInterrupt"] select isMultiplayer);
private _dialog = findDisplay 49;

// Disable all buttons first
for "_i" from 100 to 2000 do {
    (_dialog displayCtrl _i) ctrlEnable false;
    (_dialog displayCtrl _i) ctrlSetTooltip "";
};


private _control = _dialog displayCtrl 104;
_control ctrlSetEventHandler ["buttonClick", "endMission ""LOSER"""];
_control ctrlEnable true;
_control ctrlSetText "ABORT";
