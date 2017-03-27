#include "macros.hpp"

class CfgRespawnTemplates
{
	class OurAltis
	{
		onPlayerKilled = QFUNC(handlePlayerDeath);
		
		respawnDelay = 30;
		
		respawnOnStart = -1;
	};
};
