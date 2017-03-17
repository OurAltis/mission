comment "OUR Altis Loadout for OPFOR Grenadier by Yoshi";

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
_this addVest "V_HarnessOGL_brn";
for "_i" from 1 to 6 do {_this addItemToVest "30Rnd_65x39_caseless_green";};
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
_this addItemToVest "1Rnd_SmokeGreen_Grenade_shell";
for "_i" from 1 to 11 do {_this addItemToVest "1Rnd_HE_Grenade_shell";};
_this addItemToVest "1Rnd_SmokeRed_Grenade_shell";
_this addHeadgear "H_HelmetO_ocamo";

comment "Add weapons";
_this addWeapon "arifle_Katiba_GL_F";
_this addPrimaryWeaponItem "optic_Hamr";
_this addWeapon "hgun_Rook40_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "NVGoggles";

