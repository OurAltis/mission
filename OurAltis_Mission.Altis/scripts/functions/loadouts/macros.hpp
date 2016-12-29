#include "..\macros.hpp"

#define LOADOUT_FUNC_NAME(name) EquipAs_##name
#define LOADOUT_FUNC(name) FUNC(LOADOUT_FUNC_NAME(name))
#define COMPILE_LOADOUT(name) LOADOUT_FUNC(name) = compile preprocessFileLineNumbers ("scripts\functions\loadouts\" + _sidePrefix + #name + ".sqf")
