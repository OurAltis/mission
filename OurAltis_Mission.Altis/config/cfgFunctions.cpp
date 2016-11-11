#include "macros.hpp"

class CfgFunctions 
{
	class TAG 
	{
		class bases 
		{
			file = FUNC_PATH(bases);
			
			class createBases {};
			class createBase {};
			class createCamp {};
			class getBaseSide {};
			class detachBaseObjs {};
			class getBaseDir {};
		};
		
		class client
		{
			file = FUNC_PATH(client);
			
			class clientInit {postInit = 1};
			class doWithServerPermission {};
			class markBases {};
			class updateLoadoutForBase {};
			class workWithBaseList {};
			class workWithInfantryList {};
		};
		
		class server
		{
			file = FUNC_PATH(server);
			
			class calculateBaseMarkerOffset {};
			class checkRespawn {};
			class configureInfantry {};			
			class configureServerEventHandler {};
			class setMissionParameter {};
		};
		
		class init
		{
			file = FUNC_PATH(init);
			
			class OurAltisInit 
			{
				preInit = 1;
			};
			
			class initializeGenericMissionPart {};
		};
		
		class mapPositions 
		{
			file = FUNC_PATH(mapPositions);
			
			class clearMapPositions {};
			class createMapPosition {};
			class deleteMapPosition {};
			class mapPositionsInit {};
			class setActiveMapPosition {};
		};
		
		class respawn
		{
			file = FUNC_PATH(respawn);
			
			class addMultipleRespawnPositions {};
			class addMultipleRespawnRoles {};
			class addRespawnPosition {};
			class addRespawnRole {};
			class clearRespawnPositions {};
			class clearRespawnRoles {};
			class configureRespawnData {};
			class createOurAltisUnit {};
			class handlePlayerDeath {};
			class hideRespawnMenu {};
			class removeMultipleRespawnPositions {};
			class removeMultipleRespawnRoles {};
			class removeRespawnPosition {};
			class removeRespawnRole {};
			class RespawnButtonPressed {};
			class respawnInit {};
			class selectedPositionChanged {};
			class selectedRoleChanged {};
			class showRespawnMenu {};
			class showRolesForSelectedPosition {};
			class updateDisplayedRespawnPositions {};
			class updateRespawnData {};
		};
		
		class util
		{
			file = FUNC_PATH(util);
			
			class calculateOffset {};
			class getBasePosition {};
			class getConfigRespawnDelay {};
			class getLoadoutsForBase {};
			class getReinforcementCount {};
			class hideMarkerByPrefix {};
			class hideUserMapMarker {};
			class setMarkerAlphaByPrefix {};
			class showPauseMenu {};
			class unhideMarkerByPrefix {};
			class unhideUserMapMarker {};
			class KK_arrayShuffle {};
		};
		
		class events
		{
			file = "scripts\events";
			
			class addEventHandler {};
			class fireClientEvent {};
			class fireEvent {};
			class fireGlobalClientEvent {};
			class fireGlobalEvent {};
			class fireServerEvent {};
			class getEventHandlerTypes {};
			class initializeEventHandler {};
			class removeEventHandler {};
			class removeEventHandlerType {};
			class workWithRequest {};
		};
		
		class vehicles
		{
			file = FUNC_PATH(vehicles);
			
			class createVehicles {}; 
		};
		
		class dev
		{
			file = FUNC_PATH(dev);
			
			class createHelipads {};
		};
	};
};
