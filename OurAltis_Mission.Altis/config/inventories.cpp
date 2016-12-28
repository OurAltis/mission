// Defines all used inventories

class CfgRespawnInventory
{
     class Medic_WEST
     {
          displayName = "Medic_Civ"; // Name visible in the menu
          icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa"; // Icon displayed next to the name
          role = "Medic";
          
          // Loadout definition, uses same entries as CfgVehicles classes
          weapons[] = {
               "arifle_MXC_F",
               "Binocular"
          };
          magazines[] = {
               "30Rnd_65x39_caseless_mag",
               "30Rnd_65x39_caseless_mag",
               "SmokeShell"
          };
          items[] = {
               "FirstAidKit"
          };
          linkedItems[] = {
               "V_Chestrig_khk",
               "H_Watchcap_blk",
               "optic_Aco",
               "acc_flashlight",
               "ItemMap",
               "ItemCompass",
               "ItemWatch",
               "ItemRadio"
          };
          uniformClass = "U_B_CombatUniform_mcam_tshirt";
          backpack = "B_AssaultPack_mcamo";
     };
     
     class Rifleman_WEST
     {
          displayName = "Rifleman_Civ"; // Name visible in the menu
          icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa"; // Icon displayed next to the name
          role = "Rifleman";
          
          // Loadout definition, uses same entries as CfgVehicles classes
          weapons[] = {
               "arifle_MXC_F",
               "Binocular"
          };
          magazines[] = {
               "30Rnd_65x39_caseless_mag",
               "30Rnd_65x39_caseless_mag",
               "SmokeShell"
          };
          items[] = {
               "FirstAidKit"
          };
          linkedItems[] = {
               "V_Chestrig_khk",
               "H_Watchcap_blk",
               "optic_Aco",
               "acc_flashlight",
               "ItemMap",
               "ItemCompass",
               "ItemWatch",
               "ItemRadio"
          };
          uniformClass = "U_B_CombatUniform_mcam_tshirt";
          backpack = "B_AssaultPack_mcamo";
     };
     
     class dummy 
     {
     	displayName = "Dummy";
     	role = "Dummy";
     	
     };
};
