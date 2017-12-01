comment "OUR Altis Loadout for BLUEFOR Ingenieur by Yoshi";

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
for "_i" from 1 to 3 do {_this addItemToUniform "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_this addItemToUniform "Chemlight_green";};
_this addVest "V_PlateCarrierSpec_mtp";
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShell";};
for "_i" from 1 to 6 do {_this addItemToVest "30Rnd_65x39_caseless_mag";};
_this addItemToVest "SmokeShellGreen";
_this addBackpack "B_TacticalPack_mcamo";
_this addItemToBackpack "ToolKit";
_this addItemToBackpack "SatchelCharge_Remote_Mag";
for "_i" from 1 to 2 do {_this addItemToBackpack "DemoCharge_Remote_Mag";};
_this addItemToBackpack "APERSTripMine_Wire_Mag";
for "_i" from 1 to 2 do {_this addItemToBackpack "APERSMine_Range_Mag";};
_this addHeadgear "H_HelmetSpecB_snakeskin";

comment "Add weapons";
_this addWeapon "arifle_MXC_F";
_this addPrimaryWeaponItem "optic_Arco";
_this addWeapon "hgun_P07_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemGPS";
_this linkItem "tf_anprc152";
_this linkItem "NVGoggles";

_this setUnitTrait ["Engineer", true];
