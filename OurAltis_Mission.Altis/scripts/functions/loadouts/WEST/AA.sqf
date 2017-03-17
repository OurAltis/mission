comment "OUR Altis Loadout for BLUEFOR AA by Yoshi";

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
_this forceAddUniform "U_B_CombatUniform_mcam_vest";
_this addItemToUniform "ACRE_PRC148_ID_1";
for "_i" from 1 to 3 do {_this addItemToUniform "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_this addItemToUniform "Chemlight_green";};
_this addVest "V_PlateCarrier2_rgr";
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShell";};
_this addItemToVest "SmokeShellGreen";
for "_i" from 1 to 6 do {_this addItemToVest "30Rnd_65x39_caseless_mag";};
_this addBackpack "B_TacticalPack_mcamo";
for "_i" from 1 to 2 do {_this addItemToBackpack "Titan_AA";};
_this addHeadgear "H_HelmetSpecB_snakeskin";

comment "Add weapons";
_this addWeapon "arifle_MXC_F";
_this addPrimaryWeaponItem "optic_Arco";
_this addWeapon "launch_B_Titan_F";
_this addWeapon "hgun_P07_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadioAcreFlagged";
_this linkItem "NVGoggles";
