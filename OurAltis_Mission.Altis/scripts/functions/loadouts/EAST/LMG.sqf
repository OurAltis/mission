comment "OUR Altis Loadout for OPFOR LMG by Yoshi";

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
_this forceAddUniform "U_O_CombatUniform_ocamo";
_this addItemToUniform "ACRE_PRC148_ID_1";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_this addItemToUniform "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_this addItemToUniform "Chemlight_green";};
_this addVest "V_HarnessO_brn";
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShell";};
_this addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {_this addItemToVest "150Rnd_762x54_Box_Tracer";};
_this addHeadgear "H_HelmetO_ocamo";

comment "Add weapons";
_this addWeapon "LMG_Zafir_F";
_this addPrimaryWeaponItem "optic_Holosight";
_this addWeapon "hgun_Rook40_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadioAcreFlagged";
_this linkItem "NVGoggles";



