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
		};
		
		class client
		{
			file = FUNC_PATH(client);
			
			class clientInit {postInit = 1};
			class configureLoadoutHandler {};
			class markBases {};
			class updateLoadoutForBase {};
			class workWithBaseList {};
			class workWithInfantryList {};
		};
		
		class server
		{
			file = FUNC_PATH(server);
			
			class calculateBaseMarkerOffset {};
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
		
		class util
		{
			file = FUNC_PATH(util);
			
			class calculateOffset {};
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
	};
};
