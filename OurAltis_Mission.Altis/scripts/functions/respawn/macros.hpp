#include "..\macros.hpp"

#define RGVAR(var) TAG##_Respawn_##var
#define QRGVAR(var) QUOTE(RGVAR(var))

#define EVENT_RESPAWN_POSITIONS_CHANGED QUOTE(EVENT_PREFIX.respawnPositionsChanged)
#define EVENT_RESPAWN_ROLES_CHANGED QUOTE(EVENT_PREFIX.respawnRolesChanged)
