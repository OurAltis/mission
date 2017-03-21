#include "..\macros.hpp"

#define RGVAR(var) TAG##_Respawn_##var
#define QRGVAR(var) QUOTE(RGVAR(var))

#define EVENT_RESPAWN_POSITIONS_CHANGED QUOTE(EVENT_PREFIX.respawnPositionsChanged)
#define EVENT_RESPAWN_ROLES_CHANGED QUOTE(EVENT_PREFIX.respawnRolesChanged)

// Defines the time in seconds that is needed in order to fade out the sound and to a blackscreen after having died
#define FADE_OUT_TIME 10
