comment "OUR Altis Loadout for OPFOR ArmoredVehicleCrew by Yoshi";

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
_this forceAddUniform "U_O_SpecopsUniform_ocamo";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "ACRE_PRC148_ID_1";
for "_i" from 1 to 2 do {_this addItemToUniform "Chemlight_green";};
for "_i" from 1 to 3 do {_this addItemToUniform "16Rnd_9x21_Mag";};
_this addVest "V_BandollierB_khk";
_this addItemToVest "B_IR_Grenade";
_this addItemToVest "SmokeShellGreen";
for "_i" from 1 to 4 do {_this addItemToVest "30Rnd_9x21_Mag_SMG_02";};
_this addBackpack "B_TacticalPack_ocamo";
_this addItemToBackpack "ACRE_PRC117F_ID_1";
_this addHeadgear "H_HelmetCrew_O";

comment "Add weapons";
_this addWeapon "SMG_02_F";
_this addPrimaryWeaponItem "optic_Aco_smg";
_this addWeapon "hgun_Rook40_F";
_this addWeapon "Rangefinder";


comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadioAcreFlagged";
_this linkItem "ItemGPS";
_this linkItem "NVGoggles_OPFOR";
