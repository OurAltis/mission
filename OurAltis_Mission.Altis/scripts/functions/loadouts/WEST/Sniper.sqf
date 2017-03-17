comment "OUR Altis Loadout for BLUEFOR Sniper by Yoshi";

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
_this forceAddUniform "U_B_GhillieSuit";
_this addItemToUniform "ACRE_PRC148_ID_1";
for "_i" from 1 to 3 do {_this addItemToUniform "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_this addItemToUniform "Chemlight_green";};
_this addHeadgear "H_HelmetSpecB_snakeskin";
_this addVest "V_PlateCarrier1_rgr";
for "_i" from 1 to 6 do {_this addItemToVest "7Rnd_408_Mag";};

comment "Add weapons";
_this addWeapon "srifle_LRR_F";
_this addPrimaryWeaponItem "optic_LRPS";
_this addWeapon "hgun_P07_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadioAcreFlagged";
_this linkItem "NVGoggles";
