#include "macros.hpp"

class CfgRespawnTemplates {
	class OurAltis {
		onPlayerKilled = QFUNC(handlePlayerDeath);		
		respawnDelay = 10;		
		respawnOnStart = -1;
	};
};
