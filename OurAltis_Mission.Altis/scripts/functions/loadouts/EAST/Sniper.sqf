comment "OUR Altis Loadout for OPFOR Sniper by Yoshi";

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
for "_i" from 1 to 3 do {_this addItemToUniform "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_this addItemToUniform "Chemlight_green";};
_this addHeadgear "H_HelmetO_ocamo";
_this addVest "V_TacVest_khk";
for "_i" from 1 to 6 do {_this addItemToVest "5Rnd_127x108_Mag";};

comment "Add weapons";
_this addWeapon "srifle_GM6_camo_F";
_this addPrimaryWeaponItem "optic_LRPS";
_this addWeapon "hgun_Rook40_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemGPS";
_this linkItem "tf_fadak";
_this linkItem "NVGoggles";
