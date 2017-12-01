comment "OUR Altis Loadout for BLUEFOR VehicleCrew by Yoshi";

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
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_this addItemToUniform "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_this addItemToUniform "Chemlight_green";};
_this addVest "V_BandollierB_rgr";
_this addItemToVest "B_IR_Grenade";
_this addItemToVest "SmokeShellGreen";
_this addVest "V_Chestrig_rgr";
for "_i" from 1 to 9 do {_this addItemToVest "30Rnd_45ACP_Mag_SMG_01";};
_this addHeadgear "H_Cap_tan_specops_US";

comment "Add weapons";
_this addWeapon "SMG_01_F";
_this addPrimaryWeaponItem "optic_Aco_smg";
_this addWeapon "hgun_P07_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "tf_anprc152";
_this linkItem "ItemGPS";
