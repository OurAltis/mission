#include "macros.hpp"

class CfgFunctions {
	class TAG {
		class bases {
			file = FUNC_PATH(bases);
			
			class createBases {};
			class createBase {};
			class createCamp {};
			class getBaseSide {};
			class getBaseDir {};
			class createFOB {};
			class createCarrier {};
		};
		
		class client {
			file = FUNC_PATH(client);
			
			class clientInit {postInit = 1;};
			class doWithServerPermission {};
			class deleteRetreatOption {};
			class showUnitsOutsideMarker {};
			class synchronizeBaseList {};
			class workWithBaseList {};
			class workWithInfantryList {};
			class doVote {};
			class createRestrictedArea {};
			class triggerRAAct {};
			class triggerRADeact {};
		};
		
		class server {
			file = FUNC_PATH(server);
			
			class checkRespawn {};
			class configureInfantry {};			
			class configureServerEventHandler {};
			class endMission {};
			class reportDeadUnit {};
			class reportVehicleStatus {};
			class reportEconomyStatus {};
			class setMissionParameter {};
			class sideHasLivingUnits {};
			class watchForAliveUnits {};
			class watchCapturingBase {};
			class watchCapturingFOB {};
			class watchFlagpoleStatus {};
			class retreat {};
			class retreatInfantry {};
			class retreatVehicles {};
			class reportDeadCivilian {};
			class createTasks {};
			class reportServerStatus {};
			class reportDefeatResistance {};
			class createBorderWar {};
			class shrinkMarker {};
			class reportPlayerStatistic {};
			class createDBEntryStatistic {};
			class timeLimitExceeded {};
			class reportVehicleStatistic {};
			class reportStatusSideMissions {};
			class reportMissionDuration {};
			class reportDestroyedVehicleStatistic {};
			class reportDeadUnitStatistic {};
			class reportIncident {};
			class switchGroupAndLeader {};			
			class confirmVote {};
			class reportAidSupply {};
			class reportAidSupplyDestroyed {};
		};
		
		class database {
			file=FUNC_PATH(server\database);
			
			class initializeDataBase {};
			class transferSQLRequestToDataBase {};
		};
		
		class init {
			file = FUNC_PATH(init);
			
			class OurAltisInit {
				preInit = 1;
			};
			
			class initializeGenericMissionPart {};
			class variableWebGUI {};
			class configureTFAR {};
		};
		
		class loadouts {
			file = FUNC_PATH(loadouts);
			
			class compileLoadouts {};
			class equipUnitAsClass {};
		};
		
		class mapPositions {
			file = FUNC_PATH(mapPositions);
			
			class clearMapPositions {};
			class createMapPosition {};
			class deleteMapPosition {};
			class lockMapPositions {};
			class mapPositionsInit {};
			class setActiveMapPosition {};
		};
		
		class respawn {
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
		
		class util {
			file = FUNC_PATH(util);
			
			class calculateOffset {};
			class displayServerErrorMessages {};
			class getBasePosition {};
			class getClassCode {};
			class getConfigRespawnDelay {};
			class getInternalClassName {};
			class getLoadoutsForBase {};
			class getNearestBase {};
			class getReinforcementCount {};
			class hideMarkerByPrefix {};
			class hideUserMapMarker {};
			class KK_arrayShuffle {};
			class objectsGrabber {};
			class objectsMapper {};
			class setMarkerAlphaByPrefix {};
			class showPauseMenu {};
			class unhideMarkerByPrefix {};
			class unhideUserMapMarker {};
			class setFlagTexture {};
			class createAddAction {};
			class checkFOBPosition {};
			class createMarkerCamps {};
			class getAttackerSide {};
			class getTaskPic {};
			class spawnComposition {};
			class setNextWall {};
			class getPolygonArray {};
		};
		
		class events {
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
		
		class vehicles {
			file = FUNC_PATH(vehicles);
			
			class createVehicles {};
			class createAmbientVehicles {};
			class calculateFuelConsumption {};
			class cargoVehicle {};
			class deployBoat {};
			class loadUpBoat {};
			class getVehicleSpawn {};
			class prepareAirVehicleSpawn {};
			class prepareVehicleBoat {};
			class prepareVehicleMobileCamp {};
			class resizeVehicleSpawn {};
			class sortVehicles {};
			class prepareVehicleIDAP {};
		};
		
		class economy {
			file = FUNC_PATH(economy);
			
			class createEconomy {};
			class initializeEconomyVariable {};
			class getEconomyVariable {};
			class setEconomyVariable {};
		};
		
		class spy {
			file = FUNC_PATH(spy);
			
			class createSpy {};
			class askSpy {};
			class reactionSpy {};
			class createSpyInfo {};
		};
		
		class resistance {
			file = FUNC_PATH(resistance);
			
			class createResistance {};
		};
		
		class supplyPoint {
			file = FUNC_PATH(supplyPoint);
			
			class createSupplyPoint {};
			class checkAidSupply {};
		};

		class obsolete {
			file = FUNC_PATH(obsolete);

			class adjustBuildingsToMap {};
		};
	};
};
