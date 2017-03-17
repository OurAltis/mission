comment "OUR Altis Loadout for OPFOR Spotter by Yoshi";

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
_this forceAddUniform "U_O_GhillieSuit";
_this addItemToUniform "ACRE_PRC148_ID_1";
for "_i" from 1 to 3 do {_this addItemToUniform "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_this addItemToUniform "Chemlight_green";};
_this addVest "V_TacVest_khk";
for "_i" from 1 to 6 do {_this addItemToVest "10Rnd_762x54_Mag";};
_this addBackpack "B_TacticalPack_ocamo";
_this addItemToBackpack "ACRE_PRC117F_ID_1";
_this addHeadgear "H_HelmetO_ocamo";

comment "Add weapons";
_this addWeapon "srifle_DMR_01_F";
_this addPrimaryWeaponItem "muzzle_snds_B";
_this addPrimaryWeaponItem "optic_MRCO";
_this addWeapon "hgun_Rook40_F";
_this addWeapon "Rangefinder";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadioAcreFlagged";
_this linkItem "NVGoggles";
_this linkItem "ItemGPS";

