comment "OUR Altis Loadout for BLUEFOR LMG by Yoshi";

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
_this forceAddUniform "U_B_CombatUniform_mcam";
_this addItemToUniform "ACRE_PRC148_ID_1";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_this addItemToUniform "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_this addItemToUniform "Chemlight_green";};
_this addVest "V_PlateCarrier2_rgr";
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShell";};
_this addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {_this addItemToVest "200Rnd_65x39_cased_Box_Tracer";};
_this addHeadgear "H_HelmetSpecB_snakeskin";

comment "Add weapons";
_this addWeapon "LMG_Mk200_F";
_this addPrimaryWeaponItem "optic_Holosight";
_this addPrimaryWeaponItem "bipod_01_F_snd";
_this addWeapon "hgun_P07_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadioAcreFlagged";
_this linkItem "NVGoggles";


