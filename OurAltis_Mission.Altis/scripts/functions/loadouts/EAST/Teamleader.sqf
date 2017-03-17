comment "OUR Altis Loadout for OPFOR Teamlead by Yoshi";

comment "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

comment "Add containers";
_this forceAddUniform "U_O_OfficerUniform_ocamo";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "ACRE_PRC148_ID_1";
for "_i" from 1 to 3 do {_this addItemToUniform "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_this addItemToUniform "Chemlight_green";};
_this addVest "V_TacVest_khk";
for "_i" from 1 to 6 do {_this addItemToVest "30Rnd_65x39_caseless_green";};
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellRed";};
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellGreen";};
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShell";};
_this addItemToVest "SmokeShellBlue";
_this addItemToVest "O_IR_Grenade";
_this addItemToVest "SmokeShellYellow";
_this addBackpack "B_AssaultPack_ocamo";
_this addItemToBackpack "ACRE_PRC117F_ID_1";
_this addHeadgear "H_HelmetLeaderO_ocamo";

comment "Add weapons";
_this addWeapon "arifle_Katiba_F";
_this addPrimaryWeaponItem "optic_Hamr";
_this addWeapon "hgun_Rook40_F";
_this addWeapon "Rangefinder";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadioAcreFlagged";
_this linkItem "ItemGPS";
_this linkItem "NVGoggles";
