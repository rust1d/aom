//==============================================================================
// AOMDefaultAI.xs
//
//This is the default AOM AI script code for Computer Player AI players.
//==============================================================================


//==============================================================================
//The first part of this file is just a long list of global variables.  The
//'extern' keyword allows them to be used in any of the included files.  These
//are here to facilitate information sharing, etc.  The global variables are
//attempted to be named appropriately, but you should take a look at how they are
//used before making any assumptions about their actual utility.


//==============================================================================
//Map-Related Globals.
extern bool gWaterMap=false;

//==============================================================================
//Escrow stuff.
extern int gEconomyUnitEscrowID=-1;
extern int gEconomyTechEscrowID=-1;
extern int gEconomyBuildingEscrowID=-1;
extern int gMilitaryUnitEscrowID=-1;
extern int gMilitaryTechEscrowID=-1;
extern int gMilitaryBuildingEscrowID=-1;

//==============================================================================
//Housing & PopCap.
extern int gHouseBuildLimit=-1;
extern int gHouseAvailablePopRebuild=10;
extern int gBuildersPerHouse=1;
extern int gHardEconomyPopCap=-1;

//==============================================================================
//Econ Globals.
extern int   gGatherGoalPlanID=-1;
extern int   gCivPopPlanID=-1;
extern int   gNumBoatsToMaintain=6;
extern int   gAgeToStartFarming=2;
//AgeCapHouses.  True caps the number of houses by age (if you're using the econ's house rule).
extern bool  gAgeCapHouses=true;
extern float gMaxFoodImbalance=1500.0;
extern float gMaxWoodImbalance=1500.0;
extern float gMaxGoldImbalance=1500.0;
extern float gMinWoodMarketSellCost=20.0;
extern float gMinFoodMarketSellCost=20.0;
extern int   gMaxTradeCarts=5;

//==============================================================================
//Minor Gods.
extern int gAge2MinorGod = -1;
extern int gAge3MinorGod = -1;
extern int gAge4MinorGod = -1;


//==============================================================================
//God Powers
extern int gAge1GodPowerID = -1;
extern int gAge2GodPowerID = -1;
extern int gAge3GodPowerID = -1;
extern int gAge4GodPowerID = -1;
extern int gAge1GodPowerPlanID = -1;
extern int gAge2GodPowerPlanID = -1;
extern int gAge3GodPowerPlanID = -1;
extern int gAge4GodPowerPlanID = -1;
extern int gTownDefenseGodPowerPlanID = -1;
extern int gTownDefenseEvalModel = -1;
extern int gTownDefensePlayerID = -1;

//==============================================================================
//Special Case Stuff
extern int gDwarvenMinePlanID = -1;
extern int gLandScout = -1;
extern int gAirScout = -1;
extern int gWaterScout = -1;
extern int gMaintainNumberLandScouts = 1;
extern int gMaintainNumberAirScouts = 1;
extern int gMaintainNumberWaterScouts = 1;
extern int gEmpowerPlanID = -1;
extern int gRelicGatherPlanID = -1;
extern bool gBuildWalls=false;
extern bool gBuildTowers=false;
extern int gTowerEscrowID=-1;
extern int gLateUPID=-1;
extern int gNavalUPID=-1;
extern int gNavalAttackGoalID=-1;
extern int gMaintainWaterXPortPlanID=-1;
extern int gResignType = -1;
extern int gVinlandsagaTransportExplorePlanID=-1;
extern int gVinlandsagaInitialBaseID=-1;
extern int gNomadExplorePlanID=-1;
extern int gKOTHPlentyUnitID=-1;
extern int gDwarfMaintainPlanID=-1;
extern int gLandExplorePlanID=-1;
extern int gFarmBaseID = -1;
//==============================================================================
// tracking expansion
extern int gTrackingPlayer = -1;
extern int gNumberTrackedPlayerSettlements=-1;
extern int gNumberMySettlements=-1;

//==============================================================================
//Base Globals.
extern int gGoldBaseID=-1;
extern float gMaximumBaseResourceDistance=100.0;

//==============================================================================
//Age Progression Plan IDs.
extern int gAge2ProgressionPlanID = -1;
extern int gAge3ProgressionPlanID = -1;
extern int gAge4ProgressionPlanID = -1;

//==============================================================================
//Forward declarations.
//==============================================================================
mutable void age2Handler(int age=1) { }
mutable void age3Handler(int age=2) { }
mutable void age4Handler(int age=3) { }
mutable void towerInBase( string planName="BUG", bool los = true, int numTowers = 6, int escrowID=-1 ) { }
mutable int createSimpleMaintainPlan(int puid=-1, int number=1, bool economy=true, int baseID=-1) { }
mutable bool createSimpleBuildPlan(int puid=-1, int number=1, int pri=100,
   bool military=false, bool economy=true, int escrowID=-1, int baseID=-1, int numberBuilders=1) { }
mutable void buildHandler(int protoID=-1) { }
mutable void gpHandler(int powerID=-1)    { }
mutable void wonderDeathHandler(int playerID=-1) { }
mutable void retreatHandler(int planID=-1) {}
mutable void relicHandler(int relicID=-1) {}
mutable int createBuildSettlementGoal(string name="BUG", int minAge=-1, int maxAge=-1, int baseID=-1, int numberUnits=1, int builderUnitTypeID=-1, bool autoUpdate=true, int pri=90) { }


//==============================================================================
//Economy Include.
//-- The Econ module needs to define these things:
// void econAge2Handler( int age = 0 )
// void econAge3Handler( int age = 0 )
// void econAge4Handler( int age = 0 )
// void initEcon()
include "AOMDefaultAIEconomy.xs";

//==============================================================================
//Progress Include.
//-- The Progress module needs to define these things:
// void progressAge2Handler( int age = 0 )
// void progressAge3Handler( int age = 0 )
// void progressAge4Handler( int age = 0 )
// void initProgress()
include "AOMDefaultAIProgress.xs";

//==============================================================================
//Military Include.
include "AOMDefaultAIMilitary.xs";

//==============================================================================
//God Powers Include.
//-- The GP module needs to define these things:
// void gpAge2Handler( int age = 0 )
// void gpAge3Handler( int age = 0 )
// void gpAge4Handler( int age = 0 )
// void initGodPowers()
include "AOMDefaultAIGodPowers.xs";



//==============================================================================
// RULE: updatePlayerToAttack.  Updates the player we should be attacking.
//==============================================================================
rule updatePlayerToAttack
   minInterval 27
   group AttackRules
   active
   runImmediately
{
   //Determine a random start index for our hate loop.
   static int startIndex=-1;
   if (startIndex < 0)
      startIndex=aiRandInt(cNumberPlayers);

   //Find the "first" enemy player that's still in the game.  This will be the
   //script's recommendation for who we should attack.
   int comparePlayerID=-1;
   for (i=0; < cNumberPlayers)
   {
      //If we're past the end of our players, go back to the start.
      int actualIndex=i+startIndex;
      if (actualIndex >= cNumberPlayers)
         actualIndex=actualIndex-cNumberPlayers;
      if (actualIndex <= 0)
         continue;
      if ((kbIsPlayerEnemy(actualIndex) == true) &&
         (kbIsPlayerResigned(actualIndex) == false) &&
         (kbHasPlayerLost(actualIndex) == false))
      {
         comparePlayerID=actualIndex;
         break;
      }
   }

   //Pass the comparePlayerID into the AI to see what he thinks.  He'll take care
   //of modifying the player in the event of wonders, etc.
   int actualPlayerID=aiCalculateMostHatedPlayerID(comparePlayerID);

   //Default us off.
   aiSetMostHatedPlayerID(actualPlayerID);
}

//==============================================================================
// setTownLocation
//==============================================================================
void setTownLocation(void)
{
   static int tcQueryID=-1;
   //If we don't have a query ID, create it.
   if (tcQueryID < 0)
   {
      tcQueryID=kbUnitQueryCreate("TownLocationQuery");
      //If we still don't have one, bail.
      if (tcQueryID < 0)
         return;
      //Else, setup the query data.
      kbUnitQuerySetPlayerID(tcQueryID, cMyID);
      kbUnitQuerySetUnitType(tcQueryID, cUnitTypeAbstractSettlement);
      kbUnitQuerySetState(tcQueryID, cUnitStateAlive);
   }

   //Reset the results.
   kbUnitQueryResetResults(tcQueryID);
   //Run the query.  Be dumb and just take the first TC for now.
   if (kbUnitQueryExecute(tcQueryID) > 0)
   {
      int tcID=kbUnitQueryGetResult(tcQueryID, 0);
      kbSetTownLocation(kbUnitGetPosition(tcID));
   }
}

//==============================================================================
//createSimpleMaintainPlan
//==============================================================================
int createSimpleMaintainPlan(int puid=-1, int number=1, bool economy=true, int baseID=-1)
{
   //Create a the plan name.
   string planName="Military";
   if (economy == true)
      planName="Economy";
   planName=planName+kbGetProtoUnitName(puid)+"Maintain";
   int planID=aiPlanCreate(planName, cPlanTrain);
   if (planID < 0)
      return(-1);

   //Economy or Military.
   if (economy == true)
      aiPlanSetEconomy(planID, true);
   else
      aiPlanSetMilitary(planID, true);
   //Unit type.
   aiPlanSetVariableInt(planID, cTrainPlanUnitType, 0, puid);
   //Number.
   aiPlanSetVariableInt(planID, cTrainPlanNumberToMaintain, 0, number);

   //If we have a base ID, use it.
   if (baseID >= 0)
   {
      aiPlanSetBaseID(planID, baseID);
      if  (economy == false)
         aiPlanSetVariableVector(planID, cTrainPlanGatherPoint, 0, kbBaseGetMilitaryGatherPoint(cMyID, baseID));
   }

   aiPlanSetActive(planID);

   //Done.
   return(planID);
}

//==============================================================================
//createSimpleBuildPlan
//==============================================================================
bool createSimpleBuildPlan(int puid=-1, int number=1, int pri=100,
   bool military=false, bool economy=true, int escrowID=-1, int baseID=-1, int numberBuilders=1)
{
   //Create the right number of plans.
   for (i=0; < number)
   {
      int planID=aiPlanCreate("SimpleBuild"+kbGetUnitTypeName(puid)+" "+number, cPlanBuild);
      if (planID < 0)
         return(false);
      //Puid.
      aiPlanSetVariableInt(planID, cBuildPlanBuildingTypeID, 0, puid);
      //Border layers.
      aiPlanSetVariableInt(planID, cBuildPlanNumAreaBorderLayers, 2, kbAreaGetIDByPosition(kbBaseGetLocation(cMyID, baseID)) );
      //Priority.
      aiPlanSetDesiredPriority(planID, pri);
      //Mil vs. Econ.
      aiPlanSetMilitary(planID, military);
      aiPlanSetEconomy(planID, economy);
      //Escrow.
      aiPlanSetEscrowID(planID, escrowID);
      //Builders.
      aiPlanAddUnitType(planID, kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionBuilder, 0),
         numberBuilders, numberBuilders, numberBuilders);
      //Base ID.
      aiPlanSetBaseID(planID, baseID);
      //Go.
      aiPlanSetActive(planID);
   }
}

//==============================================================================
// updateEM
//==============================================================================
void updateEM(int econPop=-1, int milPop=-1, float econPercentage=0.5,
   float rootEscrow=0.2, float econFoodEscrow=0.5, float econWoodEscrow=0.5,
   float econGoldEscrow=0.5, float econFavorEscrow=0.5)
{
   //Econ Pop (if we're allowed to change it).
   if ((gHardEconomyPopCap > 0) && (econPop > gHardEconomyPopCap))
      econPop=gHardEconomyPopCap;
   aiSetEconomyPop(econPop);
   aiSetMilitaryPop(milPop);

   //Percentages.
   aiSetEconomyPercentage(econPercentage);
   aiSetMilitaryPercentage(1.0-econPercentage);

   //Get the amount of the non-root pie.
   float nonRootEscrow=1.0-rootEscrow;
   //Track whether or not we need to redistribute the resources.
   bool redistResources=false;
   //Econ Food Escrow.
   float v=nonRootEscrow*econFoodEscrow;
   if (v != kbEscrowGetPercentage(cEconomyEscrowID, cResourceFood))
      redistResources=true;
   kbEscrowSetPercentage(cEconomyEscrowID, cResourceFood, v);
   //Econ Wood Escrow
   v=nonRootEscrow*econWoodEscrow;
   if (v != kbEscrowGetPercentage(cEconomyEscrowID, cResourceWood))
      redistResources=true;
   kbEscrowSetPercentage(cEconomyEscrowID, cResourceWood, v);
   //Econ Gold Escrow
   v=nonRootEscrow*econGoldEscrow;
   if (v != kbEscrowGetPercentage(cEconomyEscrowID, cResourceGold))
      redistResources=true;
   kbEscrowSetPercentage(cEconomyEscrowID, cResourceGold, v);
   //Econ Favor Escrow
   v=nonRootEscrow*econFavorEscrow;
   if (v != kbEscrowGetPercentage(cEconomyEscrowID, cResourceFavor))
      redistResources=true;
   kbEscrowSetPercentage(cEconomyEscrowID, cResourceFavor, v);
   //Military Escrow.
   kbEscrowSetPercentage(cMilitaryEscrowID, cResourceFood, nonRootEscrow*(1.0-econFoodEscrow));
   kbEscrowSetPercentage(cMilitaryEscrowID, cResourceWood, nonRootEscrow*(1.0-econWoodEscrow));
   kbEscrowSetPercentage(cMilitaryEscrowID, cResourceGold, nonRootEscrow*(1.0-econGoldEscrow));
   kbEscrowSetPercentage(cMilitaryEscrowID, cResourceFavor, nonRootEscrow*(1.0-econFavorEscrow));
   //Distribute the resources we have (if we need to because we've changed
   //the percentages).
   if (redistResources == true)
      kbEscrowAllocateCurrentResources();

   //Update the number of vils to maintain.
   aiPlanSetVariableInt(gCivPopPlanID, cTrainPlanNumberToMaintain, 0, aiGetEconomyPop());
}

//==============================================================================
// updateEMAge1
//==============================================================================
rule updateEMAge1
   minInterval 12
   active
{
   static int ePopAdd=-1;
   static int mPopAdd=-1;
   if (ePopAdd < 0)
   {
      if (aiGetWorldDifficulty() == cDifficultyEasy)
      {
         ePopAdd=aiRandInt(2);
         mPopAdd=0;
      }
      else if (aiGetWorldDifficulty() == cDifficultyModerate)
      {
         ePopAdd=aiRandInt(3);
         mPopAdd=aiRandInt(2);
      }
      else if (aiGetWorldDifficulty() == cDifficultyHard)
      {
         ePopAdd=aiRandInt(4);
         mPopAdd=aiRandInt(4);
      }
      else
      {
         ePopAdd=aiRandInt(5);
         mPopAdd=aiRandInt(10);
      }
   }

   //All econ in the first age.
   if (aiGetWorldDifficulty() == cDifficultyEasy)
      updateEM(12+ePopAdd, 7+mPopAdd, 1.0, 0.6, 1.0, 1.0, 1.0, 1.0);
   else if (aiGetWorldDifficulty() == cDifficultyModerate)
      updateEM(15+ePopAdd, 19+mPopAdd, 1.0, 0.6, 1.0, 1.0, 1.0, 1.0);
   else if (aiGetWorldDifficulty() == cDifficultyHard)
      updateEM(19+ePopAdd, 23+mPopAdd, 1.0, 0.6, 1.0, 1.0, 1.0, 1.0);
   else
      updateEM(13+ePopAdd, 25+mPopAdd, 1.0, 0.6, 1.0, 1.0, 1.0, 1.0);
}

//==============================================================================
// updateEMAge2
//==============================================================================
rule updateEMAge2
   minInterval 12
   inactive
{
   static int ePopAdd=-1;
   static int mPopAdd=-1;
   if (ePopAdd < 0)
   {
      if (aiGetWorldDifficulty() == cDifficultyEasy)
      {
         ePopAdd=aiRandInt(2);
         mPopAdd=0;
      }
      else if (aiGetWorldDifficulty() == cDifficultyModerate)
      {
         ePopAdd=aiRandInt(3);
         mPopAdd=aiRandInt(2);
      }
      else if (aiGetWorldDifficulty() == cDifficultyHard)
      {
         ePopAdd=aiRandInt(4);
         mPopAdd=aiRandInt(4);
      }
      else
      {
         ePopAdd=aiRandInt(5);
         mPopAdd=aiRandInt(10);
      }
   }

   //Figure out if we have any active attacks.
   int numberAttackGoals=aiGoalGetNumber(cGoalPlanGoalTypeAttack, cPlanStateWorking, true);
   //Setup the econ vs. military.
   if (numberAttackGoals > 0)
   {
      if (aiGetWorldDifficulty() == cDifficultyEasy)
         updateEM(9+ePopAdd, 22+mPopAdd, 0.5, 0.6, 0.4, 0.3, 0.4, 0.15);
      else if (aiGetWorldDifficulty() == cDifficultyModerate)
         updateEM(14+ePopAdd, 36+mPopAdd, 0.5, 0.6, 0.4, 0.3, 0.4, 0.15);
      else if (aiGetWorldDifficulty() == cDifficultyHard)
         updateEM(19+ePopAdd, 49+mPopAdd, 0.5, 0.6, 0.4, 0.3, 0.4, 0.15);
      else
         updateEM(15+ePopAdd, 52+mPopAdd, 0.5, 0.6, 0.4, 0.3, 0.4, 0.15);
   }
   else
   {
      if (aiGetWorldDifficulty() == cDifficultyEasy)
         updateEM(15+ePopAdd, 14+mPopAdd, 0.8, 0.6, 0.9, 0.5, 0.6, 0.2);
      else if (aiGetWorldDifficulty() == cDifficultyModerate)
         updateEM(20+ePopAdd, 28+mPopAdd, 0.8, 0.6, 0.9, 0.5, 0.6, 0.2);
      else if (aiGetWorldDifficulty() == cDifficultyHard)
         updateEM(32+ePopAdd, 36+mPopAdd, 0.8, 0.6, 0.9, 0.5, 0.6, 0.2);
      else
         updateEM(24+ePopAdd, 38+mPopAdd, 0.8, 0.6, 0.9, 0.5, 0.6, 0.2);
   }
}

//==============================================================================
// updateEMAge3
//==============================================================================
rule updateEMAge3
   minInterval 12
   inactive
{
   static int ePopAdd=-1;
   static int mPopAdd=-1;
   if (ePopAdd < 0)
   {
      if (aiGetWorldDifficulty() == cDifficultyEasy)
      {
         ePopAdd=aiRandInt(2);
         mPopAdd=0;
      }
      else if (aiGetWorldDifficulty() == cDifficultyModerate)
      {
         ePopAdd=aiRandInt(3);
         mPopAdd=aiRandInt(2);
      }
      else if (aiGetWorldDifficulty() == cDifficultyHard)
      {
         ePopAdd=aiRandInt(4);
         mPopAdd=aiRandInt(7);
      }
      else
      {
         ePopAdd=aiRandInt(5);
         mPopAdd=aiRandInt(10);
      }
   }

   //Figure out if we have any active attacks.
   int numberAttackGoals=aiGoalGetNumber(cGoalPlanGoalTypeAttack, cPlanStateWorking, true);
   //Setup the econ vs. military.
   if (numberAttackGoals > 0)
   {
      if (aiGetWorldDifficulty() == cDifficultyEasy)
         updateEM(11+ePopAdd, 29+mPopAdd, 0.3, 0.6, 0.3, 0.2, 0.3, 0.15);
      else if (aiGetWorldDifficulty() == cDifficultyModerate)
         updateEM(33+ePopAdd, 56+mPopAdd, 0.3, 0.6, 0.3, 0.2, 0.3, 0.15);
      else if (aiGetWorldDifficulty() == cDifficultyHard)
         updateEM(47+ePopAdd, 70+mPopAdd, 0.3, 0.6, 0.3, 0.2, 0.3, 0.15);
      else
         updateEM(30+ePopAdd, 72+mPopAdd, 0.3, 0.6, 0.3, 0.2, 0.3, 0.15);
   }
   else
   {
      if (aiGetWorldDifficulty() == cDifficultyEasy)
         updateEM(18+ePopAdd, 40+mPopAdd, 0.5, 0.6, 0.5, 0.5, 0.5, 0.2);
      else if (aiGetWorldDifficulty() == cDifficultyModerate)
         updateEM(38+ePopAdd, 64+mPopAdd, 0.5, 0.6, 0.5, 0.5, 0.5, 0.2);
      else if (aiGetWorldDifficulty() == cDifficultyHard)
         updateEM(47+ePopAdd, 85+mPopAdd, 0.5, 0.6, 0.5, 0.5, 0.5, 0.2);
      else
         updateEM(30+ePopAdd, 88+mPopAdd, 0.5, 0.6, 0.5, 0.5, 0.5, 0.2);
   }
}

//==============================================================================
// updateEMAge4
//==============================================================================
rule updateEMAge4
   minInterval 12
   inactive
{
   static int ePopAdd=-1;
   static int mPopAdd=-1;
   if (ePopAdd < 0)
   {
      if (aiGetWorldDifficulty() == cDifficultyEasy)
      {
         ePopAdd=aiRandInt(2);
         mPopAdd=0;
      }
      else if (aiGetWorldDifficulty() == cDifficultyModerate)
      {
         ePopAdd=aiRandInt(3);
         mPopAdd=aiRandInt(2);
      }
      else if (aiGetWorldDifficulty() == cDifficultyHard)
      {
         ePopAdd=aiRandInt(4);
         mPopAdd=aiRandInt(7);
      }
      else
      {
         ePopAdd=aiRandInt(5);
         mPopAdd=aiRandInt(10);
      }
   }

   //Setup the econ vs. military.
   if (aiGetWorldDifficulty() == cDifficultyEasy)
      updateEM(28+ePopAdd, 30+mPopAdd, 0.3, 0.4, 0.0, 0.0, 0.0, 0.0);
   else if (aiGetWorldDifficulty() == cDifficultyModerate)
      updateEM(37+ePopAdd, 100+mPopAdd, 0.3, 0.4, 0.0, 0.0, 0.0, 0.0);
   else if (aiGetWorldDifficulty() == cDifficultyHard)
      updateEM(57+ePopAdd, -1, 0.3, 0.4, 0.0, 0.0, 0.0, 0.0);
   else
      updateEM(34+ePopAdd, -1, 0.3, 0.4, 0.0, 0.0, 0.0, 0.0);
}

//==============================================================================
//initGreek
//==============================================================================
void initGreek(void)
{
   aiEcho("GREEK Init:");

   //Modify our favor need.  A pseudo-hack.
   aiSetFavorNeedModifier(10.0);

   //Greek scout types.
   gLandScout=cUnitTypeScout;
   gAirScout=cUnitTypePegasus;
   gWaterScout=cUnitTypeFishingShipGreek;
   //Create the Greek scout plan.
   int exploreID=aiPlanCreate("Explore_SpecialGreek", cPlanExplore);
   if (exploreID >= 0)
   {
      aiPlanAddUnitType(exploreID, cUnitTypeScout, 1, 1, 1);
      aiPlanSetActive(exploreID);
   }

   //Zeus.
   if (cMyCiv == cCivZeus)
   {
      //Create a simple plan to maintain 1 water scout.
      if (aiGetWaterMap())
         createSimpleMaintainPlan(gWaterScout, gMaintainNumberWaterScouts, true, -1);

      //Random Age2 God.
      gAge2MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge2);
      //Get Underworld Passage if we have a water map.  Else, random.
      if (aiGetWaterMap())
         gAge3MinorGod=cTechAge3Apollo;
      else
         gAge3MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge3);
      //Get Lightning if we're rushing.  Else, random.
      if (aiGetPersonality() == "defaultRush")
         gAge4MinorGod=cTechAge4Hera;
      else
         gAge4MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge4);
   }
   //Poseidon.
   else if (cMyCiv == cCivPoseidon)
   {
      //Give him the hippocampus as his water scout.
      gWaterScout=cUnitTypeHippocampus;
      aiEcho("Poseidon's water scout is the "+kbGetUnitTypeName(gWaterScout)+".");

      //Random Age2 God.
      gAge2MinorGod = kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge2);
      //Random Age3 God.
      gAge3MinorGod = kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge3);
      //Get EQ if we're rushing.  Else, random.
      if (aiGetPersonality() == "defaultRush")
         gAge4MinorGod=cTechAge4Artemis;
      else
         gAge4MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge4);
   }
   //Hades.
   else if (cMyCiv == cCivHades)
   {
      //Create a simple plan to maintain 1 water scout.
      if (aiGetWaterMap())
         createSimpleMaintainPlan(gWaterScout, gMaintainNumberWaterScouts, true, -1);

      //Random Age2 God.
      gAge2MinorGod = kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge2);
      //Get Underworld Passage if we have a water map.  Else, random.
      if (aiGetWaterMap())
         gAge3MinorGod=cTechAge3Apollo;
      else
         gAge3MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge3);
      //Get EQ if we're rushing.  Else, random.
      if (aiGetPersonality() == "defaultRush")
         gAge4MinorGod=cTechAge4Artemis;
      else
         gAge4MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge4);

      //Get VOE.
      int voePID=aiPlanCreate("HadesVaultsOfErebus", cPlanProgression);
      if (voePID != 0)
      {
         aiPlanSetVariableInt(voePID, cProgressionPlanGoalTechID, 0, cTechVaultsofErebus);
         aiPlanSetDesiredPriority(voePID, 25);
         aiPlanSetEscrowID(voePID, cEconomyEscrowID);
         aiPlanSetActive(voePID);
      }
   }
}

//==============================================================================
//initEgyptian
//==============================================================================
void initEgyptian(void)
{
   aiEcho("EGYPTIAN Init:");

   //Create a simple TC empower plan if we're not on Vinlandsaga.
   if ((cRandomMapName != "vinlandsaga") && (cRandomMapName != "team migration"))
   {
      gEmpowerPlanID=aiPlanCreate("Pharaoh Empower", cPlanEmpower);
      if (gEmpowerPlanID >= 0)
      {
         aiPlanSetEconomy(gEmpowerPlanID, true);
         aiPlanAddUnitType(gEmpowerPlanID, cUnitTypePharaoh, 1, 1, 1);
         aiPlanSetVariableInt(gEmpowerPlanID, cEmpowerPlanTargetTypeID, 0, cUnitTypeGranary);
         aiPlanSetActive(gEmpowerPlanID);
      }
   }

   //Egyptian scout types.
   gLandScout=cUnitTypePriest;
   gAirScout=-1;
   gWaterScout=cUnitTypeFishingShipEgyptian;
   //Create a simple plan to maintain Priests for land exploration.
   createSimpleMaintainPlan(cUnitTypePriest, gMaintainNumberLandScouts, true, kbBaseGetMainID(cMyID));
   //Create a simple plan to maintain 1 water scout.
   if (aiGetWaterMap())
      createSimpleMaintainPlan(gWaterScout, gMaintainNumberWaterScouts, true, -1);

   //Turn off auto favor gather.
   aiSetAutoFavorGather(false);

   //Set the build limit for Outposts.
   aiSetMaxLOSProtoUnitLimit(4);

   //Isis.
   if (cMyCiv == cCivIsis)
   {
      //Random Age2 God.
      gAge2MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge2);
      //Get X if we're rushing, else random.
      if (aiGetPersonality() == "defaultRush")
         gAge3MinorGod=cTechAge3Nephthys;
      else
         gAge3MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge3);
      //Random Age4 God.
      gAge4MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge4);
   }
   //Ra.
   else if (cMyCiv == cCivRa)
   {
      //Get X if we're rushing, else random.
      if (aiGetPersonality() == "defaultRush")
         gAge2MinorGod=cTechAge2Ptah;
      else
         gAge2MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge2);
      //Get X if we're rushing, else random.
      if (aiGetPersonality() == "defaultRush")
         gAge3MinorGod=cTechAge3Hathor;
      else
         gAge3MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge3);
      //Random Age4 God.
      gAge4MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge4);
   }
   //Set.
   else if (cMyCiv == cCivSet)
   {
      //Get X if we're rushing, else random.
      if (aiGetPersonality() == "defaultRush")
         gAge2MinorGod=cTechAge2Anubis;
      else
         gAge2MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge2);
      //Get X if we're rushing, else random.
      if (aiGetPersonality() == "defaultRush")
         gAge3MinorGod=cTechAge3Nephthys;
      else
         gAge3MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge3);
      //Random Age4 God.
      gAge4MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge4);
   }
}

//==============================================================================
//initNorse
//==============================================================================
void initNorse(void)
{
   aiEcho("NORSE Init:");

   //Set our trained dropsite PUID.
   aiSetTrainedDropsiteUnitTypeID(cUnitTypeOxCart);

   //Create a reserve plan for our main base for some Ulfsarks if we're not on VS, TM, or Nomad.
   if ((cRandomMapName != "nomad") && (cRandomMapName != "vinlandsaga") && (cRandomMapName != "team migration"))
   {
      int ulfsarkReservePlanID=aiPlanCreate("UlfsarkBuilderReserve", cPlanReserve);
      if (ulfsarkReservePlanID >= 0)
      {
         aiPlanSetDesiredPriority(ulfsarkReservePlanID, 49);
         aiPlanSetBaseID(ulfsarkReservePlanID, kbBaseGetMainID(cMyID));
         aiPlanAddUnitType(ulfsarkReservePlanID, cUnitTypeUlfsark, 1, 1, 1);
         aiPlanSetVariableInt(ulfsarkReservePlanID, cReservePlanPlanType, 0, cPlanBuild);
         aiPlanSetActive(ulfsarkReservePlanID);
      }

      //Create a simple plan to maintain X Ulfsarks.
      createSimpleMaintainPlan(cUnitTypeUlfsark, gMaintainNumberLandScouts+1, true, kbBaseGetMainID(cMyID));
   }

   //Turn off auto favor gather.
   aiSetAutoFavorGather(false);

   //Norse scout types.
   gLandScout=cUnitTypeUlfsark;
   gAirScout=-1;
   gWaterScout=cUnitTypeFishingShipNorse;
   //Create a simple plan to maintain 1 water scout.
   if (aiGetWaterMap())
      createSimpleMaintainPlan(gWaterScout, gMaintainNumberWaterScouts, true, -1);

   //Odin.
   if (cMyCiv == cCivOdin)
   {
      //Create air explore plans for the ravens.
      int explorePID=aiPlanCreate("Explore_SpecialOdinAir1", cPlanExplore);
      if (explorePID >= 0)
      {
         aiPlanAddUnitType(explorePID, cUnitTypeRaven, 1, 1, 1);
         aiPlanSetActive(explorePID);
      }
      explorePID=aiPlanCreate("Explore_SpecialOdinAir2", cPlanExplore);
      if (explorePID >= 0)
      {
         aiPlanAddUnitType(explorePID, cUnitTypeRaven, 1, 1, 1);
         aiPlanSetVariableBool(explorePID, cExplorePlanDoLoops, 0, false);
         aiPlanSetActive(explorePID);
      }

      //Get X if we're rushing, else random.
      if (aiGetPersonality() == "defaultRush")
         gAge2MinorGod=cTechAge2Heimdall;
      else
         gAge2MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge2);
      //Random Age3 God.
      gAge3MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge3);
      //Random Age4 God.
      gAge4MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge4);

   }
   //Thor.
   else if (cMyCiv == cCivThor)
   {
      //Random Age2 God.
      gAge2MinorGod = kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge2);
      //Get X if we're rushing, else random.
      if (aiGetPersonality() == "defaultRush")
         gAge3MinorGod=cTechAge3Bragi;
      else
         gAge3MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge3);
      //Random Age4 God.
      gAge4MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge4);

      //Thor likes dwarves.
      if (aiGetGameMode() != cGameModeLightning)
         gDwarfMaintainPlanID=createSimpleMaintainPlan(cUnitTypeDwarf, 2, true, -1);
   }
   //Loki.
   else if (cMyCiv == cCivLoki)
   {
      //Get X if we're rushing, else random.
      if (aiGetPersonality() == "defaultRush")
         gAge2MinorGod=cTechAge2Heimdall;
      else
         gAge2MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge2);
      //Get X if we're rushing, else random.
      if (aiGetPersonality() == "defaultRush")
         gAge3MinorGod=cTechAge3Bragi;
      else
         gAge3MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge3);
      //Random Age4 God.
      gAge4MinorGod=kbTechTreeGetMinorGodChoices(aiRandInt(2), cAge4);
   }

   //Enable our no-infantry check.
   xsEnableRule("norseInfantryCheck");
}

//==============================================================================
// norseInfantryCheck
//==============================================================================
rule norseInfantryCheck
   minInterval 10
   inactive
   group Norse
{
   //Get a count of our infantry.
   int infantryCount=kbUnitCount(cMyID, cUnitTypeAbstractInfantry, cUnitStateAlive);
   if (infantryCount > 0)
      return;

   //If we're out of infantry, make sure we have at least X pop slots free.
   int availablePopSlots=kbGetPopCap()-kbGetPop();
   if (availablePopSlots >= 2)
      return;

   //Else, find a villager to delete.
   //Create/get our query.
   static int vQID=-1;
   if (vQID < 0)
   {
      vQID=kbUnitQueryCreate("NorseInfantryCheckVillagers");
      if (vQID < 0)
      {
         xsDisableSelf();
         return;
      }
   }
   kbUnitQuerySetPlayerID(vQID, cMyID);
   kbUnitQuerySetUnitType(vQID, cUnitTypeAbstractVillager);
   kbUnitQuerySetState(vQID, cUnitStateAlive);
   kbUnitQueryResetResults(vQID);
   int numberVillagers=kbUnitQueryExecute(vQID);
   for (i=0; < numberVillagers)
   {
      int villagerID=kbUnitQueryGetResult(vQID, i);
      if (aiTaskUnitDelete(villagerID) == true)
         return;
   }
}

//==============================================================================
// initUnitPicker
//==============================================================================
int initUnitPicker(string name="BUG", int numberTypes=1, int minUnits=10,
   int maxUnits=20, int minPop=-1, int maxPop=-1, int numberBuildings=1,
   bool guessEnemyUnitType=false)
{
   //Create it.
   int upID=kbUnitPickCreate(name);
   if (upID < 0)
      return(-1);

   //Default init.
   kbUnitPickResetAll(upID);
   //1 Part Preference, 2 Parts CE, 2 Parts Cost.
   kbUnitPickSetPreferenceWeight(upID, 1.0);
   kbUnitPickSetCombatEfficiencyWeight(upID, 2.0);
   kbUnitPickSetCostWeight(upID, 2.0);
   //Desired number units types, buildings.
   kbUnitPickSetDesiredNumberUnitTypes(upID, numberTypes, numberBuildings, true);
   //Min/Max units and Min/Max pop.
   kbUnitPickSetMinimumNumberUnits(upID, minUnits);
   kbUnitPickSetMaximumNumberUnits(upID, maxUnits);
   kbUnitPickSetMinimumPop(upID, minPop);
   kbUnitPickSetMaximumPop(upID, maxPop);
   //Default to land units.
   kbUnitPickSetAttackUnitType(upID, cUnitTypeLogicalTypeLandMilitary);
   kbUnitPickSetGoalCombatEfficiencyType(upID, cUnitTypeLogicalTypeMilitaryUnitsAndBuildings);

   //Setup the military unit preferences.  These are just various strategies of unit
   //combos and what-not that are more or less setup to coincide with the bonuses
   //and mainline units of each civ.  We start with a random choice.  If we have
   //an enemy unit type to preference against, we override that random choice.
   //0:  Counter infantry (i.e. enemyUnitTypeID == cUnitTypeAbstractInfantry).
   //1:  Counter archer (i.e. enemyUnitTypeID == cUnitTypeAbstractArcher).
   //2:  Counter cavalry (i.e. enemyUnitTypeID == cUnitTypeAbstractCavalry).
   int upRand=aiRandInt(3);

   //Figure out what we're going to assume our opponent is building.
   int enemyUnitTypeID=-1;
   int mostHatedPlayerID=aiGetMostHatedPlayerID();
   if ((guessEnemyUnitType == true) && (mostHatedPlayerID > 0))
   {
      //If the enemy is Norse, assume infantry.
      //Zeus is infantry.
      if ((kbGetCultureForPlayer(mostHatedPlayerID) == cCultureNorse) ||
         (kbGetCivForPlayer(mostHatedPlayerID) == cCivZeus))
      {
         enemyUnitTypeID=cUnitTypeAbstractInfantry;
         upRand=0;
      }
      //Hades is archers.
      else if (kbGetCivForPlayer(mostHatedPlayerID) == cCivHades)
      {
         enemyUnitTypeID=cUnitTypeAbstractArcher;
         upRand=1;
      }
      //Poseidon is cavalry.
      else if (kbGetCivForPlayer(mostHatedPlayerID) == cCivPoseidon)
      {
         enemyUnitTypeID=cUnitTypeAbstractCavalry;
         upRand=2;
      }
   }

   //Do the preference actual work now.
   switch (cMyCiv)
   {
      //Zeus.
      case cCivZeus:
      {
         if (upRand == 0)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.3);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.4);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         else if (upRand == 1)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.8);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.2);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.4);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         else
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.3);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.1);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.4);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMedusa, 0.8);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         break;
      }
      //Poseidon.
      case cCivPoseidon:
      {
         if (upRand == 0)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.4);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.6);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.1);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         else if (upRand == 1)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.2);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.6);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         else
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.7);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.2);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.7);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         break;
      }
      //Hades.
      case cCivHades:
      {
         if (upRand == 0)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.2);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.2);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         else if (upRand == 1)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.4);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.4);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.1);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         else
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.6);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.6);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.2);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.7);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         break;
      }
      //Isis.
      case cCivIsis:
      {
         if (upRand == 0)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.6);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.6);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.4);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         else if (upRand == 1)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.4);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.4);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.4);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.8);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         else
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.2);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.2);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.7);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         break;
      }
      //Ra.
      case cCivRa:
      {
         if (upRand == 0)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.2);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.8);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.8);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         else if (upRand == 1)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.4);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.2);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         else
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.6);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         break;
      }
      //Set.
      case cCivSet:
      {
         if (upRand == 0)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.2);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.2);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.6);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         else if (upRand == 1)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.8);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.1);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         else
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.7);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractArcher, 0.6);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.3);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeMythUnit, 0.3);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         break;
      }
      //Loki.
      case cCivLoki:
      {
         if (upRand == 0)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.75);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeHeroNorse, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         else if (upRand == 1)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeHeroNorse, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.5);
         }
         else
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeHeroNorse, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.1);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.3);
         }
         break;
      }
      //Odin.
      case cCivOdin:
      {
         if (upRand == 0)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeHuskarl, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.1);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeJarl, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         else if (upRand == 1)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeHuskarl, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.8);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.8);
         }
         else
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.7);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.2);
         }
         break;
      }
      //Thor.
      case cCivThor:
      {
         if (upRand == 0)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeUlfsark, 0.6);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeThrowingAxeman, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.5);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.7);
         }
         else if (upRand == 1)
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.7);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.1);
         }
         else
         {
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractInfantry, 0.6);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeUlfsark, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeThrowingAxeman, 0.9);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractCavalry, 0.1);
            kbUnitPickSetPreferenceFactor(upID, cUnitTypeAbstractSiegeWeapon, 0.3);
         }
         break;
      }
   }

   //Done.
   return(upID);
}

//==============================================================================
// init( void )
//==============================================================================
void init(void)
{
   //We're in a random map.
   aiSetRandomMap(true);

   //Startup messages.
   aiEcho("AI Player Name: "+cMyName+".");
   aiEcho("AI Filename='"+cFilename+"'.");
   aiEcho("Map size is ("+kbGetMapXSize()+", "+kbGetMapZSize()+").");
   aiEcho("Loader Init, MapName="+cRandomMapName+".");
   aiEcho("FirstRand="+aiRandInt(10000000)+".");
   aiEcho("Civ="+kbGetCivName(cMyCiv)+".");
   aiEcho("Culture="+kbGetCultureName(cMyCulture)+".");
   aiEcho("DifficultyLevel="+aiGetWorldDifficultyName(aiGetWorldDifficulty())+".");
   aiEcho("Personality="+aiGetPersonality()+".");

   //Tell the AI what kind of map we are on.
   gWaterMap=true;
   aiSetWaterMap(gWaterMap);

   //Find someone to hate.
   updatePlayerToAttack();
   aiEcho("MostHatedPlayer is Player #"+aiGetMostHatedPlayerID()+".");

   //Bind our age handlers.
   aiSetAgeEventHandler(cAge2, "age2Handler");
   aiSetAgeEventHandler(cAge3, "age3Handler");
   aiSetAgeEventHandler(cAge4, "age4Handler");
   //Setup god power handler
   aiSetGodPowerEventHandler("gpHandler");
   //Setup build handler
   aiSetBuildEventHandler("buildHandler");
   //Setup the wonder handler
   aiSetWonderDeathEventHandler("wonderDeathHandler");
   //Setup the retreat handler
   aiSetRetreatEventHandler("retreatHandler");
   //Setup the relic handler
   aiSetRelicEventHandler("relicHandler");
    //Setup the resign handler
   aiSetResignEventHandler("resignHandler");

   //Calculate some areas.
   kbAreaCalculate();
   //Set our town location.
   setTownLocation();

   //Economy.
   initEcon();
   //Progress.
   initProgress();
   //God Powers
   initGodPowers();


   //Various map overrides.
   //Erebus and River Styx.
   if ((cRandomMapName == "erebus") || (cRandomMapName == "river styx"))
   {
      aiSetMinNumberNeedForGatheringAggressvies(2);
      kbBaseSetMaximumResourceDistance(cMyID, kbBaseGetMainID(cMyID), 200.0);
   }
   //Vinlandsaga.
   if (aiGetWaterMap())
   {
      //Enable the rule that looks for the mainland.
      xsEnableRule("findVinlandsagaBase");
      //Turn off auto dropsite building.
      aiSetAllowAutoDropsites(false);
      aiSetAllowBuildings(false);
      int transportID = findUnit(kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionWaterTransport, 0));
      vector nearCenter = kbGetMapCenter();
      nearCenter = (nearCenter + kbBaseGetLocation(cMyID, kbBaseGetMainID(cMyID))) / 2.0;    // Halfway between start and center
      nearCenter = (nearCenter + kbGetMapCenter()) / 2.0;   // 3/4 of the way to map center
      aiTaskUnitMove(transportID, nearCenter);
      //Make a plan to explore with the initial transport.
      gVinlandsagaTransportExplorePlanID=aiPlanCreate("Vinlandsaga Transport Explore", cPlanExplore);
      if (gVinlandsagaTransportExplorePlanID >= 0)
      {
         aiPlanAddUnitType(gVinlandsagaTransportExplorePlanID, kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionWaterTransport, 0), 1, 1, 1);
         aiPlanSetDesiredPriority(gVinlandsagaTransportExplorePlanID, 1);
         aiPlanSetVariableBool(gVinlandsagaTransportExplorePlanID, cExplorePlanDoLoops, 0, false);
         aiPlanSetActive(gVinlandsagaTransportExplorePlanID);
         aiPlanSetEscrowID(gVinlandsagaTransportExplorePlanID);
      }
      //Turn off fishing.
      xsDisableRule("fishing");
      //Pause the age upgrades.
      aiSetPauseAllAgeUpgrades(true);
   }
   //Nomad.
   else if (cRandomMapName == "nomad")
   {
      //Enable the rule that looks for a settlement.
      int nomadSettlementGoalID=createBuildSettlementGoal("BuildNomadSettlement", 0, -1, -1, 1,
         kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionBuilder,0), true, 100);
      if (nomadSettlementGoalID != -1)
      {
         //Create the callback goal.
         int nomadCallbackGID=createCallbackGoal("Nomad BuildSettlement Callback", "nomadBuildSettlementCallBack", 1, 0, -1, false);
         if (nomadCallbackGID >= 0)
            aiPlanSetVariableInt(nomadSettlementGoalID, cGoalPlanDoneGoal, 0, nomadCallbackGID);
      }

      //Make a plan to explore with the initial villager.
      gNomadExplorePlanID=aiPlanCreate("Nomad Explore", cPlanExplore);
      if (gNomadExplorePlanID >= 0)
      {
         aiPlanAddUnitType(gNomadExplorePlanID, kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionBuilder, 0), 1, 1, 1);
         aiPlanSetDesiredPriority(gNomadExplorePlanID, 1);
         aiPlanSetVariableBool(gNomadExplorePlanID, cExplorePlanDoLoops, 0, false);
         aiPlanSetActive(gNomadExplorePlanID);
         aiPlanSetEscrowID(gNomadExplorePlanID);
      }
      //Turn off fishing.
      xsDisableRule("fishing");
      //Turn off buildhouse.
      xsDisableRule("buildHouse");
      //Pause the age upgrades.
      aiSetPauseAllAgeUpgrades(true);
   }
   //Unknown.
   else if (cRandomMapName == "the unknown")
   {
      xsEnableRule("findFish");
   }
   //Make a scout plan to find the plenty vault/
   else if (cRandomMapName == "king of the hill")
   {
      aiEcho("looking for KOTH plenty Vault");
      int KOTHunitQueryID = kbUnitQueryCreate("findPlentyVault");
      kbUnitQuerySetPlayerRelation(KOTHunitQueryID, cPlayerRelationAny);
      kbUnitQuerySetUnitType(KOTHunitQueryID, cUnitTypePlentyVaultKOTH);
      kbUnitQuerySetState(KOTHunitQueryID, cUnitStateAny);
      kbUnitQueryResetResults(KOTHunitQueryID);
      int numberFound = kbUnitQueryExecute(KOTHunitQueryID);
      gKOTHPlentyUnitID = kbUnitQueryGetResult(KOTHunitQueryID, 0);
      kbSetForwardBasePosition(kbUnitGetPosition(gKOTHPlentyUnitID));

      xsEnableRule("findFish");
   }


   //Create bases for all of our settlements.  Ignore any that already have
   //bases set.  If we have an invalid main base, the first base we create
   //will be our main base.
   int settlementQueryID=kbUnitQueryCreate("MySettlements");
   if (settlementQueryID > -1)
   {
      kbUnitQuerySetPlayerID(settlementQueryID, cMyID);
      kbUnitQuerySetUnitType(settlementQueryID, cUnitTypeAbstractSettlement);
      kbUnitQuerySetState(settlementQueryID, cUnitStateAlive);
      kbUnitQueryResetResults(settlementQueryID);
      int numberSettlements=kbUnitQueryExecute(settlementQueryID);
      for(i=0; < numberSettlements)
      {
         int settlementID=kbUnitQueryGetResult(settlementQueryID, i);
         //Skip this settlement if it already has a base.
         if (kbUnitGetBaseID(settlementID) >= 0)
            continue;

         vector settlementPosition=kbUnitGetPosition(settlementID);
         //Create a new base.
         int newBaseID=kbBaseCreate(cMyID, "Base"+kbBaseGetNextID(), settlementPosition, 75.0);
         if (newBaseID > -1)
         {
            //Figure out the front vector.
            vector baseFront=xsVectorNormalize(kbGetMapCenter()-settlementPosition);
            kbBaseSetFrontVector(cMyID, newBaseID, baseFront);
            //Military gather point.
            vector militaryGatherPoint=settlementPosition+baseFront*40.0;
            kbBaseSetMilitaryGatherPoint(cMyID, newBaseID, militaryGatherPoint);
            //Set the other flags.
            kbBaseSetMilitary(cMyID, newBaseID, true);
            kbBaseSetEconomy(cMyID, newBaseID, true);
            //Set the resource distance limit.
            kbBaseSetMaximumResourceDistance(cMyID, newBaseID, gMaximumBaseResourceDistance);
            //Add the settlement to the base.
            kbBaseAddUnit(cMyID, newBaseID, settlementID);
            kbBaseSetSettlement(cMyID, newBaseID, true);
            //Set the main-ness of the base.
            kbBaseSetMain(cMyID, newBaseID, true);
         }
      }
   }


   //Culture setup.
   switch (cMyCulture)
   {
      case cCultureGreek:
      {
         initGreek();
         break;
      }
      case cCultureEgyptian:
      {
         initEgyptian();
         break;
      }
      case cCultureNorse:
      {
         initNorse();
         break;
      }
   }
   //Setup the progression to follow these minor gods.
   kbTechTreeAddMinorGodPref(gAge2MinorGod);
   kbTechTreeAddMinorGodPref(gAge3MinorGod);
   kbTechTreeAddMinorGodPref(gAge4MinorGod);


   //Set the Explore Danger Threshold.
   aiSetExploreDangerThreshold(300.0);
   //Auto gather our military units.
   aiSetAutoGatherMilitaryUnits(true);

   //Get our house build limit.
   gHouseBuildLimit=kbGetBuildLimit(cMyID, cUnitTypeHouse);
   //Set the housing rebuild bound to 4 for the first age.
   gHouseAvailablePopRebuild=4;

   //Set the hard pop caps.
   if (aiGetGameMode() == cGameModeLightning)
   {
      gHardEconomyPopCap=25;
      //If we're Norse, get our 5 dwarfs.
      if (cMyCulture == cCultureNorse)
         createSimpleMaintainPlan(cUnitTypeDwarf, 5, true, -1);
   }
   else if (aiGetGameMode() == cGameModeDeathmatch)
      gHardEconomyPopCap=12;
   else
   {
      if (aiGetWorldDifficulty() == cDifficultyEasy)
         gHardEconomyPopCap=20;
      else if (aiGetWorldDifficulty() == cDifficultyModerate)
         gHardEconomyPopCap=40;
      else
         gHardEconomyPopCap=-1;
   }

   //Set the default attack response distance.
   if (aiGetWorldDifficulty() == cDifficultyEasy)
      aiSetAttackResponseDistance(1.0);
   else if (aiGetWorldDifficulty() == cDifficultyModerate)
      aiSetAttackResponseDistance(30.0);
   else
      aiSetAttackResponseDistance(65.0);

   //Walls and towers.
   if ( ((aiGetWorldDifficulty() == cDifficultyEasy) || (aiGetPersonality() == "defaultboom")) &&
      (cRandomMapName != "acropolis"))
   {
      int doWalls=aiRandInt(4);
      if (doWalls == 1)
      {
         gBuildWalls=true;
         gBuildTowers=true;
      }
      else
      {
         gBuildWalls=false;
         gBuildTowers=true;
      }
   }

   //If we're on easy, set our default stance to defensive.
   if (aiGetWorldDifficulty() == cDifficultyEasy)
      aiSetDefaultStance(cUnitStanceDefensive);


   //Decide whether or not we're doing a rush/raid.
   int rushCount=0;
   int forwardBaseGoalID=-1;
   if ( ((aiGetWorldDifficulty() != cDifficultyEasy) && (aiGetGameMode() != cGameModeDeathmatch)) ||
      (cRandomMapName == "king of the hill"))
   {
      if (aiGetWorldDifficulty() == cDifficultyModerate)
         rushCount=aiRandInt(1);
      else
         rushCount=aiRandInt(2);
      //If we're booming, no early raiding.
      if (aiGetPersonality() == "defaultboom")
         rushCount=0;
      else if (aiGetPersonality() == "defaultrush")
         rushCount=rushCount+1;
      //Specific maps prevent rushing.
      if ((cRandomMapName == "vinlandsaga") ||
         (cRandomMapName == "river nile") ||
         (cRandomMapName == "team migration") ||
         (cRandomMapName == "archipelago") ||
         (cRandomMapName == "black sea"))
         rushCount=0;
      //If we have no teammates, we shant be rushing.
      if (kbGetNumberMutualAllies() <= 0)
         rushCount=0;
      //Specific maps to make rushing happen.
      if (cRandomMapName == "king of the hill")
         rushCount=rushCount+1;

      //If we're rushing, decide if we want to build a forward base.
      if (rushCount > 0)
      {
         if ((aiGetPersonality() == "defaultrush") || ((aiGetPersonality() == "default") && (aiRandInt(5) == 0)) )
            forwardBaseGoalID=createBaseGoal("Forward Base", cGoalPlanGoalTypeForwardBase, -1, 1, 1, -1, kbBaseGetMainID(cMyID));
      }

      //Create our UP.
      int rushUPID=initUnitPicker("Rush", 2, 4, 8, -1, -1, 1, true);
      if (rushUPID >= 0)
      {
         //If we're on hard or titan, up the units.
         if (aiGetWorldDifficulty() != cDifficultyModerate)
         {
            kbUnitPickSetMinimumNumberUnits(rushUPID, 7);
            kbUnitPickSetMaximumNumberUnits(rushUPID, 20);
         }
         //No myth units in the second age.
         kbUnitPickSetPreferenceFactor(rushUPID, cUnitTypeMythUnit, 0.0);
         //Reset a few of the UP parms.
         kbUnitPickSetPreferenceWeight(rushUPID, 1.0);
         kbUnitPickSetCombatEfficiencyWeight(rushUPID, 0.0);
         kbUnitPickSetCostWeight(rushUPID, 1.0);
         //Setup the retreat to only be allowed on non-water maps.
         bool allowRetreat=true;
         if ((aiGetWaterMap()) || (cRandomMapName == "king of the hill"))
            allowRetreat=false;
         //Create the rush goal if we're rushing.
         if ((rushCount > 0) && (gBuildWalls == false) && (gBuildTowers == false))
         {
            //Create the attack.
            int rushGoalID = -1;
            if (forwardBaseGoalID < 0)
               rushGoalID=createSimpleAttackGoal("Rush Land Attack", -1, rushUPID, rushCount, 1, 1, kbBaseGetMainID(cMyID), allowRetreat);
            else
               rushGoalID=createSimpleAttackGoal("Rush Land Attack", -1, rushUPID, rushCount, 1, 1, -1, allowRetreat);
            //-- attach a callbackgoal to this rush goal
            if (rushGoalID > 0)
            {
               //Go for hitpoint upgrade first.
               aiPlanSetVariableInt(rushGoalID, cGoalPlanUpgradeFilterType, 0, cUpgradeTypeHitpoints);
               //Set the callback.
               int callbackGID=createCallbackGoal("Attack Callback", "attackChatCallback",1, 0, 2, false);
               if (callbackGID >= 0)
                  aiPlanSetVariableInt(rushGoalID, cGoalPlanExecuteGoal, 0, callbackGID);
               //Create an idle attack goal that will maintain our military until the next age after
               //we're done rushing.
               int idleAttackGID=createSimpleAttackGoal("Rush Idle", -1, rushUPID, -1, 1, 1, -1, allowRetreat);
               if (idleAttackGID >= 0)
               {
                  aiPlanSetVariableBool(idleAttackGID, cGoalPlanIdleAttack, 0, true);
                  aiPlanSetVariableBool(idleAttackGID, cGoalPlanAutoUpdateState, 0, false);
                  aiPlanSetVariableInt(rushGoalID, cGoalPlanDoneGoal, 0, idleAttackGID);
                  aiPlanSetVariableInt(idleAttackGID, cGoalPlanUpgradeFilterType, 0, cUpgradeTypeHitpoints);
               }
            }
         }
         //Else, if we're not on Moderate and we're not attacking, create some military anyway.
         else if (aiGetWorldDifficulty() != cDifficultyModerate)
         {
            //Create an idle attack goal that will maintain our military until the next age.
            int idleForceGID=createSimpleAttackGoal("Idle Force", -1, rushUPID, -1, 1, 1, -1, allowRetreat);
            if (idleForceGID >= 0)
            {
               aiPlanSetVariableBool(idleForceGID, cGoalPlanIdleAttack, 0, true);
               //Go for hitpoint upgrades.
               aiPlanSetVariableInt(idleForceGID, cGoalPlanUpgradeFilterType, 0, cUpgradeTypeHitpoints);
               //Reset the rushUPID down to 1 unit type and 1 building.
               kbUnitPickSetDesiredNumberUnitTypes(rushUPID, 1, 1, true);
            }
         }
      }

      //If our rush count is 0, enable the rule that monitors our main base
      //for being under attack before we're ready.
      if (rushCount <= 0)
         xsEnableRule("townDefense");
   }

   //Create our late age attack goal.
   int numberBuildings=3;
   if (cRandomMapName == "king of the hill")
      numberBuildings=1;
   if (aiGetWorldDifficulty() == cDifficultyEasy)
      gLateUPID=initUnitPicker("Late", 1, -1, -1, 8, 16, numberBuildings, false);
   else if (aiGetWorldDifficulty() == cDifficultyModerate)
   {
      int minPop=20+aiRandInt(14);
      int maxPop=minPop+16;
      //If we're on KOTH, make the attack groups smaller.
      if (cRandomMapName == "king of the hill")
      {
         minPop=minPop-10;
         maxPop=maxPop-10;
      }
      gLateUPID=initUnitPicker("Late", 2, -1, -1, minPop, maxPop, numberBuildings, false);
   }
   else
   {
      minPop=40+aiRandInt(20);
      maxPop=minPop+30+aiRandInt(10);
      //If we're on KOTH, make the attack groups smaller.
      if (cRandomMapName == "king of the hill")
      {
         minPop=minPop-16;
         maxPop=maxPop-16;
      }
      gLateUPID=initUnitPicker("Late", 3, -1, -1, minPop, maxPop, numberBuildings, true);
   }
   int lateAttackAge=2;
   if (gLateUPID >= 0)
   {
      if (aiGetGameMode() == cGameModeDeathmatch)
         lateAttackAge=3;

      int attackGoalID=-1;
      if (forwardBaseGoalID < 0)
         attackGoalID=createSimpleAttackGoal("Main Land Attack", -1, gLateUPID, -1, lateAttackAge, -1, kbBaseGetMainID(cMyID), false);
      else
         attackGoalID=createSimpleAttackGoal("Main Land Attack", -1, gLateUPID, -1, lateAttackAge, -1, -1, false);

      //-- attach a callbackgoal to this attack goal
      if (attackGoalID >= 0)
      {
         //If this is easy, this is an idle attack.
         if (aiGetWorldDifficulty() == cDifficultyEasy)
            aiPlanSetVariableBool(attackGoalID, cGoalPlanIdleAttack, 0, true);
         else
         {
            callbackGID=createCallbackGoal("Attack Callback", "attackChatCallback", 1, 0, lateAttackAge, false);
            if (callbackGID >= 0)
               aiPlanSetVariableInt(attackGoalID, cGoalPlanExecuteGoal, 0, callbackGID);
         }

         aiPlanSetVariableInt(attackGoalID, cGoalPlanUpgradeFilterType, 0, cUpgradeTypeHitpoints);
      }
   }

   //Create our naval attack starter if we're on a water map.
   if (aiGetWaterMap())
      xsEnableRule("NavalGoalMonitor");

   //If we're going to build walls and we're not rushing, we have a 50% chance to build a wonder.
   if ((aiGetGameMode() == cGameModeSupremacy) && (gBuildWalls == true) &&
      (rushCount == 0) && (aiRandInt(2) == 0))
   {
      //-- reserve some building space in the base for the wonder.
      int wonderBPID = kbBuildingPlacementCreate( "WonderBP" );
      if(wonderBPID != -1)
      {
         kbBuildingPlacementSetBuildingType( cUnitTypeWonder );
         kbBuildingPlacementSetBaseID( kbBaseGetMainID(cMyID), cBuildingPlacementPreferenceBack );
         kbBuildingPlacementStart();
      }

      createBuildBuildingGoal("Wonder Goal", cUnitTypeWonder, 1, 3, 4, kbBaseGetMainID(cMyID),
         50, cUnitTypeAbstractVillager, true, 100, wonderBPID);
   }


   //Create our econ goal (which is really just to store stuff together).
   gGatherGoalPlanID=aiPlanCreate("GatherGoals", cPlanGatherGoal);
   if (gGatherGoalPlanID >= 0)
   {
      //Overall percentages.
      aiPlanSetDesiredPriority(gGatherGoalPlanID, 90);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanScriptRPGPct, 0, 0.5);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanCostRPGPct, 0, 0.5);
      aiPlanSetNumberVariableValues(gGatherGoalPlanID, cGatherGoalPlanGathererPct, 4, true);
      //Egyptians like gold.
      if (cMyCulture == cCultureEgyptian)
      {
         aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceGold, 0.15);
         aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceWood, 0.0);
         aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceFood, 0.85);
         aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceFavor, 0.0);
         if (aiGetWaterMap())
         {
            aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceWood, 0.05);
            aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceGold, 0.1);
         }
      }
      else
      {
         aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceGold, 0.0);
         aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceWood, 0.2);
         aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceFood, 0.8);
         aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceFavor, 0.0);
      }

      //Standard RB setup.
      aiPlanSetNumberVariableValues(gGatherGoalPlanID, cGatherGoalPlanNumFoodPlans, 5, true);
      aiPlanSetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumFoodPlans, cAIResourceSubTypeEasy, 1);
      aiPlanSetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumFoodPlans, cAIResourceSubTypeHunt, 0);
      aiPlanSetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumFoodPlans, cAIResourceSubTypeHuntAggressive, 0);
      aiPlanSetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumFoodPlans, cAIResourceSubTypeFarm, 0);
      aiPlanSetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumFoodPlans, cAIResourceSubTypeFish, 0);
      aiPlanSetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumWoodPlans, 0, 1);
      aiPlanSetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumGoldPlans, 0, 1);
      aiPlanSetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumFavorPlans, 0, 0);
      //Hunt on Erebus and River Styx.
      if ((cRandomMapName == "erebus") || (cRandomMapName == "river styx"))
      {
         aiPlanSetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumFoodPlans, cAIResourceSubTypeEasy, 0);
         aiPlanSetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumFoodPlans, cAIResourceSubTypeHuntAggressive, 2);
      }

      //Min resource amounts.
      aiPlanSetNumberVariableValues(gGatherGoalPlanID, cGatherGoalPlanMinResourceAmt, 4, true);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanMinResourceAmt, cResourceGold, 500.0);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanMinResourceAmt, cResourceWood, 500.0);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanMinResourceAmt, cResourceFood, 500.0);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanMinResourceAmt, cResourceFavor, 50.0);
      //Resource skew.
      aiPlanSetNumberVariableValues(gGatherGoalPlanID, cGatherGoalPlanResourceSkew, 4, true);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanResourceSkew, cResourceGold, 1000.0);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanResourceSkew, cResourceWood, 1000.0);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanResourceSkew, cResourceFood, 1000.0);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanResourceSkew, cResourceFavor, 100.0);
      //Cost weights.
      aiPlanSetNumberVariableValues(gGatherGoalPlanID, cGatherGoalPlanResourceCostWeight, 4, true);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanResourceCostWeight, cResourceGold, 1.5);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanResourceCostWeight, cResourceWood, 1.0);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanResourceCostWeight, cResourceFood, 1.5);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanResourceCostWeight, cResourceFavor, 10.0);

      //Set our farm limits.
      aiPlanSetVariableInt(gGatherGoalPlanID, cGatherGoalPlanFarmLimitPerPlan, 0, 4);
      aiPlanSetVariableInt(gGatherGoalPlanID, cGatherGoalPlanMaxFarmLimit, 0, 24);
      aiSetFarmLimit(aiPlanGetVariableInt(gGatherGoalPlanID, cGatherGoalPlanFarmLimitPerPlan, 0));
      //Do our late econ init.
      postInitEcon();
      //Lastly, update our EM.
      updateEM(25, 0, 0.8, 0.6, 1.0, 1.0, 1.0, 1.0);
   }

   //If we're in deathmatch, immediately build a temple.
   if (aiGetGameMode() == cGameModeDeathmatch)
   {
      createSimpleBuildPlan(cUnitTypeTemple, 1, 100, false, false, cEconomyEscrowID, kbBaseGetMainID(cMyID), 5);
      createSimpleBuildPlan(cUnitTypeHouse, 3, 99, false, false, cEconomyEscrowID, kbBaseGetMainID(cMyID), 2);
   }
}

//==============================================================================
// Age 2 Handler
//==============================================================================
void age2Handler(int age=1)
{
   aiEcho("I'm now in Age "+age+".");
   //Econ.
   econAge2Handler(age);
   //Progress.
   progressAge2Handler(age);
   //GP.
   gpAge2Handler(age);
   aiEcho("  Done with misc handlers.");

   //Set the housing rebuild bound.
   gHouseAvailablePopRebuild=10;

   //Switch the EM rule.
   xsDisableRule("updateEMAge1");
   xsEnableRule("updateEMAge2");

   //Enable building repair.
   if (aiGetWorldDifficulty() != cDifficultyEasy)
      xsEnableRule("repairBuildings");

   //Misc Econ.
   if (gGatherGoalPlanID >= 0)
   {
      //Greeks need favor.
      if (cMyCulture == cCultureGreek)
      {
         aiPlanSetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumFavorPlans, 0, 1);
         aiSetResourceBreakdown(cResourceFavor, cAIResourceSubTypeEasy, 1, 40, 1.0, kbBaseGetMainID(cMyID));
      }

      //Resource percentages.
      int woodPriority=55;
      int goldPriority=50;
      float goldPct=0.3;
      float foodPct=0.5;
      float woodPct=0.2;
      float favorPct=0.0;
      if (cMyCulture == cCultureEgyptian)
      {
         woodPct=0.1;
         goldPct=0.4;
         goldPriority=55;
         woodPriority=50;
      }
      else if (cMyCulture == cCultureGreek)
      {
         favorPct=0.1;
         foodPct=0.4;
      }
      //Breakdowns.
      int numWoodPlans=aiPlanGetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumWoodPlans, 0);
      int numGoldPlans=aiPlanGetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumGoldPlans, 0);
      aiSetResourceBreakdown(cResourceWood, cAIResourceSubTypeEasy, numWoodPlans, woodPriority, 1.0, kbBaseGetMainID(cMyID));
      aiSetResourceBreakdown(cResourceGold, cAIResourceSubTypeEasy, numGoldPlans, goldPriority, 1.0, kbBaseGetMainID(cMyID));
      //Pct.
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceWood, woodPct);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceFavor, favorPct);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceFood, foodPct);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceGold, goldPct);
      //Set the RGP weights.
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanScriptRPGPct, 0, 0.4);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanCostRPGPct, 0, 0.6);
      aiSetResourceGathererPercentageWeight(cRGPScript, 0.4);
      aiSetResourceGathererPercentageWeight(cRGPCost, 0.6);
   }

   //Maintain a water transport, if this is a water map.
   if ((aiGetWaterMap()) && (gMaintainWaterXPortPlanID < 0))
      gMaintainWaterXPortPlanID=createSimpleMaintainPlan(kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionWaterTransport, 0), 1, false, -1);

   //If we're building walls and/or towers, start those up.
   if (gBuildWalls == true)
      xsEnableRule("wallUpgrade");
   if (gBuildTowers == true)
      xsEnableRule("towerUpgrade");

   //Store our relic gatherer type.
   int gatherRelicType=-1;
   //Greek.
   if (cMyCulture == cCultureGreek)
   {
      //Greeks gather with heros.
      gatherRelicType=cUnitTypeHero;

      //Always want 4 hoplites.
      createSimpleMaintainPlan(cUnitTypeHoplite, 4, false, kbBaseGetMainID(cMyID));

      //Create our hero maintain plans.  These do first and second age heroes.
      if (cMyCiv == cCivZeus)
      {
         createSimpleMaintainPlan(cUnitTypeHeroGreekJason, 1, false, kbBaseGetMainID(cMyID));
         createSimpleMaintainPlan(cUnitTypeHeroGreekOdysseus, 1, false, kbBaseGetMainID(cMyID));
      }
      else if (cMyCiv == cCivPoseidon)
      {
         createSimpleMaintainPlan(cUnitTypeHeroGreekTheseus, 1, false, kbBaseGetMainID(cMyID));
         createSimpleMaintainPlan(cUnitTypeHeroGreekHippolyta, 1, false, kbBaseGetMainID(cMyID));
      }
      else if (cMyCiv == cCivHades)
      {
         createSimpleMaintainPlan(cUnitTypeHeroGreekAjax, 1, false, kbBaseGetMainID(cMyID));
         createSimpleMaintainPlan(cUnitTypeHeroGreekChiron, 1, false, kbBaseGetMainID(cMyID));
      }
   }
   //Egyptian.
   else if (cMyCulture == cCultureEgyptian)
   {
      //Egyptians gather relics with their Pharaoh.
      gatherRelicType=cUnitTypePharaoh;

      //Move our pharaoh empower to a generic "dropsite"
      if (gEmpowerPlanID > -1)
         aiPlanSetVariableInt(gEmpowerPlanID, cEmpowerPlanTargetTypeID, 0, cUnitTypeDropsite);

      //Always want 4 axeman.
      createSimpleMaintainPlan(cUnitTypeAxeman, 4, false, kbBaseGetMainID(cMyID));

      //If we're Ra, create some more priests and empower with them.
      if (cMyCiv == cCivRa)
      {
         createSimpleMaintainPlan(cUnitTypePriest, 4, true, -1);
         int ePlanID=aiPlanCreate("Mining Camp Empower", cPlanEmpower);
         if (ePlanID >= 0)
         {
            aiPlanSetEconomy(ePlanID, true);
            aiPlanAddUnitType(ePlanID, cUnitTypePriest, 1, 1, 1);
            aiPlanSetVariableInt(ePlanID, cEmpowerPlanTargetTypeID, 0, cUnitTypeMiningCamp);
            aiPlanSetActive(ePlanID);
         }
         ePlanID=aiPlanCreate("Lumber Camp Empower", cPlanEmpower);
         if (ePlanID >= 0)
         {
            aiPlanSetEconomy(ePlanID, true);
            aiPlanAddUnitType(ePlanID, cUnitTypePriest, 1, 1, 1);
            aiPlanSetVariableInt(ePlanID, cEmpowerPlanTargetTypeID, 0, cUnitTypeLumberCamp);
            aiPlanSetActive(ePlanID);
         }
         ePlanID=aiPlanCreate("Monument Empower", cPlanEmpower);
         if (ePlanID >= 0)
         {
            aiPlanSetEconomy(ePlanID, true);
            aiPlanAddUnitType(ePlanID, cUnitTypePriest, 1, 1, 1);
            aiPlanSetVariableInt(ePlanID, cEmpowerPlanTargetTypeID, 0, cUnitTypeAbstractMonument);
            aiPlanSetActive(ePlanID);
         }
      }

      //Up the build limit for Outposts.
      aiSetMaxLOSProtoUnitLimit(6);
   }
   //Norse.
   else if (cMyCulture == cCultureNorse)
   {
      //Norse gather with their heros.
      gatherRelicType=cUnitTypeHeroNorse;

      //We always want 4 Norse heroes.
      createSimpleMaintainPlan(cUnitTypeHeroNorse, 4, false, kbBaseGetMainID(cMyID));

      //Force a long house to go down.
      int longhousePlanID=aiPlanCreate("NorseBuildLonghouse", cPlanBuild);
      if (longhousePlanID >= 0)
      {
         aiPlanSetVariableInt(longhousePlanID, cBuildPlanBuildingTypeID, 0, cUnitTypeLonghouse);
         aiPlanSetVariableInt(longhousePlanID, cBuildPlanNumAreaBorderLayers, 2, kbGetTownAreaID());
         aiPlanSetDesiredPriority(longhousePlanID, 100);
         aiPlanAddUnitType(longhousePlanID, kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionBuilder, 0),
            gBuildersPerHouse, gBuildersPerHouse, gBuildersPerHouse);
         aiPlanSetEscrowID(longhousePlanID, cMilitaryEscrowID);
         aiPlanSetBaseID(longhousePlanID, kbBaseGetMainID(cMyID));
         aiPlanSetActive(longhousePlanID);
      }

      //Up our Thor dwarf count.
      if (gDwarfMaintainPlanID > -1)
         aiPlanSetVariableInt(gDwarfMaintainPlanID, cTrainPlanNumberToMaintain, 0, 4);

      //Init our myth unit rule.
      xsEnableRule("trainNorseMythUnit");
   }

   //Relics:  Always on Hard or Nightmare, 50% of the time on Moderate, Never on Easy.
   bool gatherRelics=true;
   if ((aiGetWorldDifficulty() == cDifficultyEasy) ||
      ((aiGetWorldDifficulty() == cDifficultyModerate) && (aiRandInt(2) == 0)) )
      gatherRelics=false;
   //If we're going to gather relics, do it.
   if (gatherRelics == true)
   {
      gRelicGatherPlanID=aiPlanCreate("Relic Gather", cPlanGatherRelic);
      if (gRelicGatherPlanID >= 0)
      {
         aiPlanAddUnitType(gRelicGatherPlanID, gatherRelicType, 1, 1, 1);
         aiPlanSetVariableInt(gRelicGatherPlanID, cGatherRelicPlanTargetTypeID, 0, cUnitTypeRelic);
         aiPlanSetVariableInt(gRelicGatherPlanID, cGatherRelicPlanDropsiteTypeID, 0, cUnitTypeTemple);
         aiPlanSetBaseID(gRelicGatherPlanID, kbBaseGetMainID(cMyID));
         aiPlanSetDesiredPriority(gRelicGatherPlanID, 100);
         aiPlanSetActive(gRelicGatherPlanID);
      }
   }

   //Build walls if we should.
   if (gBuildWalls==true)
   {
      int wallPlanID=aiPlanCreate("WallInBase", cPlanBuildWall);
      if (wallPlanID != -1)
      {
         aiPlanSetVariableInt(wallPlanID, cBuildWallPlanWallType, 0, cBuildWallPlanWallTypeRing);
         aiPlanAddUnitType(wallPlanID, kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionBuilder, 0), 1, 3, 3);
         aiPlanSetVariableVector(wallPlanID, cBuildWallPlanWallRingCenterPoint, 0, kbBaseGetLocation(cMyID, kbBaseGetMainID(cMyID)));
         aiPlanSetVariableFloat(wallPlanID, cBuildWallPlanWallRingRadius, 0, 50.0);
         aiPlanSetVariableInt(wallPlanID, cBuildWallPlanNumberOfGates, 0, 5);
         aiPlanSetBaseID(wallPlanID, kbBaseGetMainID(cMyID));
         aiPlanSetEscrowID(wallPlanID, cEconomyEscrowID);
         aiPlanSetDesiredPriority(wallPlanID, 100);
         aiPlanSetActive(wallPlanID, true);
         //Enable our wall gap rule, too.
         xsEnableRule("fillInWallGaps");
      }
   }

   //If we're in deathmatch, immediately build our armory.
   if (aiGetGameMode() == cGameModeDeathmatch)
   {
      gHardEconomyPopCap=15;
      if (cMyCiv == cCivThor)
         createSimpleBuildPlan(cUnitTypeDwarfFoundry, 1, 100, false, false, cEconomyEscrowID, kbBaseGetMainID(cMyID), 5);
      else
         createSimpleBuildPlan(cUnitTypeArmory, 1, 100, false, false, cEconomyEscrowID, kbBaseGetMainID(cMyID), 5);
      createSimpleBuildPlan(cUnitTypeHouse, 3, 99, false, false, cEconomyEscrowID, kbBaseGetMainID(cMyID), 2);
   }
}

//==============================================================================
// RULE tradeWithCaravans
//==============================================================================
rule tradeWithCaravans
   minInterval 11
   inactive
{
   //Force build a market.
   static bool builtMarket=false;
   if (builtMarket == false)
   {
      string buildPlanName="BuildMarket";
      int buildPlanID=aiPlanCreate(buildPlanName, cPlanBuild);
      if (buildPlanID < 0)
         return;

      //Put it way in the back.
      vector backVector=kbBaseGetBackVector(cMyID, kbBaseGetMainID(cMyID));
      float x = xsVectorGetX(backVector);
      float z = xsVectorGetZ(backVector);
      x = x * 60.0;
      z = z * 60.0;
      backVector = xsVectorSetX(backVector, x);
      backVector = xsVectorSetZ(backVector, z);
      backVector = xsVectorSetY(backVector, 0.0);
      vector location = kbBaseGetLocation(cMyID, kbBaseGetMainID(cMyID));
      location = location + backVector;
      //Setup the build plan.
      aiPlanSetVariableInt(buildPlanID, cBuildPlanBuildingTypeID, 0, cUnitTypeMarket);
      aiPlanSetVariableVector(buildPlanID, cBuildPlanInfluencePosition, 0, location);
      aiPlanSetVariableFloat(buildPlanID, cBuildPlanInfluencePositionDistance, 0, 30.0);
      aiPlanSetVariableFloat(buildPlanID, cBuildPlanInfluencePositionValue, 0, 100.0);
      aiPlanSetDesiredPriority(buildPlanID, 100);
      aiPlanAddUnitType(buildPlanID, kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionBuilder, 0), 1, 1, 1);
      aiPlanSetEscrowID(buildPlanID, cEconomyEscrowID);
      aiPlanSetBaseID(buildPlanID, kbBaseGetMainID(cMyID));
      aiPlanSetActive(buildPlanID);
      //Don't build another one.
      builtMarket = true;
   }

   //If we don't have a query ID, create it.
   static int marketQueryID=-1;
   if (marketQueryID < 0)
   {
      marketQueryID=kbUnitQueryCreate("MarketQuery");
      //If we still don't have one, bail.
      if (marketQueryID < 0)
         return;
      //Else, setup the query data.
      kbUnitQuerySetPlayerID(marketQueryID, cMyID);
      kbUnitQuerySetUnitType(marketQueryID, cUnitTypeMarket);
      kbUnitQuerySetState(marketQueryID, cUnitStateAlive);
   }

   //Reset the results.
   kbUnitQueryResetResults(marketQueryID);
   //Run the query.  Be dumb and just take the first one for now.
   if (kbUnitQueryExecute(marketQueryID) <= 0)
      return;
   int marketUnitID=kbUnitQueryGetResult(marketQueryID, 0);
   if (marketUnitID == -1)
      return;

   //Create the market trade plan.
   string planName="MarketTrade";
   int planID=aiPlanCreate(planName, cPlanTrade);
   if (planID < 0)
      return;

   //Get our cart PUID.
   int tradeCartPUID=kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionTrade, 0);
   aiPlanSetVariableInt(planID, cTradePlanTargetUnitTypeID, 0, cUnitTypeAbstractSettlement);
   aiPlanSetDesiredPriority(planID, 100);
   aiPlanSetInitialPosition(planID, kbUnitGetPosition(marketUnitID));
   aiPlanSetVariableVector(planID, cTradePlanStartPosition, 0, kbUnitGetPosition(marketUnitID));
   aiPlanSetVariableInt(planID, cTradePlanTradeUnitType, 0, tradeCartPUID);
   aiPlanSetVariableInt(planID, cTradePlanTradeUnitTypeMax, 0, gMaxTradeCarts);
   aiPlanSetVariableInt(planID, cTradePlanMarketID, 0, marketUnitID);
   aiPlanAddUnitType(planID, tradeCartPUID, gMaxTradeCarts, gMaxTradeCarts, gMaxTradeCarts);
   aiPlanSetEconomy(planID, true);
   aiPlanSetActive(planID);

   //Go away.
   xsDisableSelf();
}

//==============================================================================
// Age 3 Handler
//==============================================================================
void age3Handler(int age=2)
{
   aiEcho("I'm now in Age "+age+".");
   //Econ.
   econAge3Handler(age);
   //Progress.
   progressAge3Handler(age);
   //GP.
   gpAge3Handler(age);
   aiEcho("  Done with misc handlers.");

   //Disable town defense (in case it's active).
   xsDisableRule("townDefense");

   //Switch the EM rule.
   xsDisableRule("updateEMAge2");
   xsEnableRule("updateEMAge3");
   //We can trade now.
   xsEnableRule("tradeWithCaravans");

   //Up the number of water transports to maintain.
   if (gMaintainWaterXPortPlanID >= 0)
      aiPlanSetVariableInt(gMaintainWaterXPortPlanID, cTrainPlanNumberToMaintain, 0, 2);

   //Econ.
   if (gGatherGoalPlanID >= 0)
   {
      //UP the number of gold gather plans (if we have more than one gold site in our main base).
      int numberGoldSites=kbGetNumberValidResources(kbBaseGetMainID(cMyID), cResourceGold, cAIResourceSubTypeEasy);
      if (numberGoldSites > 1)
      {
         int numGoldPlans = aiPlanGetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumGoldPlans, 0);
         aiSetResourceBreakdown(cResourceGold, cAIResourceSubTypeEasy, numGoldPlans+1, 50, 1.0, kbBaseGetMainID(cMyID));
         aiPlanSetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumGoldPlans, 0, numGoldPlans+1);
      }

      //UP the number of wood gather plans.
      int numWoodPlans = aiPlanGetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumWoodPlans, 0);
      aiSetResourceBreakdown(cResourceWood, cAIResourceSubTypeEasy, numWoodPlans+1, 55, 1.0, kbBaseGetMainID(cMyID));
      aiPlanSetVariableInt(gGatherGoalPlanID, cGatherGoalPlanNumWoodPlans, 0, numWoodPlans+1);
      //Egyptians like gold.  Greeks like favor.
      float goldPct=0.4;
      float foodPct=0.45;
      float woodPct = 0.15;
      float favorPct=0.0;
      if(cMyCulture == cCultureEgyptian)
      {
         woodPct=0.1;
         goldPct=0.45;
      }
      else if (cMyCulture == cCultureGreek)
      {
         favorPct=0.1;
         goldPct=0.35;
         woodPct=0.10;
      }
      //Modify percentages if we're building towers.
      if (gBuildTowers == true)
      {
         goldPct=goldPct-woodPct/2.0;
         foodPct=foodPct-woodPct/2.0;
         woodPct = woodPct * 2.0;
      }
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceWood, woodPct);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceFavor, favorPct);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceFood, foodPct);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceGold, goldPct);

      //Set the RGP weights.
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanScriptRPGPct, 0, 0.3);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanCostRPGPct, 0, 0.7);
      aiSetResourceGathererPercentageWeight(cRGPScript, 0.3);
      aiSetResourceGathererPercentageWeight(cRGPCost, 0.7);
   }

   //Create new greek hero maintain plans.
   if (cMyCulture == cCultureGreek)
   {
      if (cMyCiv == cCivZeus)
         createSimpleMaintainPlan(cUnitTypeHeroGreekHeracles, 1, false, kbBaseGetMainID(cMyID));
      else if (cMyCiv == cCivPoseidon)
         createSimpleMaintainPlan(cUnitTypeHeroGreekAtalanta, 1, false, kbBaseGetMainID(cMyID));
      else if (cMyCiv == cCivHades)
         createSimpleMaintainPlan(cUnitTypeHeroGreekAchilles, 1, false, kbBaseGetMainID(cMyID));

      //Build a fortress and train some catapults.
      if (aiGetWorldDifficulty() != cDifficultyEasy)
      {
         int fortressPlanID=aiPlanCreate("BuildFortress", cPlanBuild);
         if (fortressPlanID >= 0)
         {
            aiPlanSetVariableInt(fortressPlanID, cBuildPlanBuildingTypeID, 0, cUnitTypeFortress);
            aiPlanSetVariableInt(fortressPlanID, cBuildPlanNumAreaBorderLayers, 2, kbGetTownAreaID());
            aiPlanSetDesiredPriority(fortressPlanID, 100);
            aiPlanAddUnitType(fortressPlanID, kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionBuilder, 0), 1, 1, 1);
            aiPlanSetEscrowID(fortressPlanID, cMilitaryEscrowID);
            aiPlanSetBaseID(fortressPlanID, kbBaseGetMainID(cMyID));
            aiPlanSetActive(fortressPlanID);
         }
         createSimpleMaintainPlan(cUnitTypePetrobolos, 2, false, kbBaseGetMainID(cMyID));
      }
   }
   else if (cMyCulture == cCultureEgyptian)
   {
      //Build a siege workshop.
      if (aiGetWorldDifficulty() != cDifficultyEasy)
      {
         int siegeCampPlanID=aiPlanCreate("BuildSiegeCamp", cPlanBuild);
         if (siegeCampPlanID >= 0)
         {
            aiPlanSetVariableInt(siegeCampPlanID, cBuildPlanBuildingTypeID, 0, cUnitTypeSiegeCamp);
            aiPlanSetVariableInt(siegeCampPlanID, cBuildPlanNumAreaBorderLayers, 2, kbGetTownAreaID());
            aiPlanSetDesiredPriority(siegeCampPlanID, 100);
            aiPlanAddUnitType(siegeCampPlanID, kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionBuilder, 0), 1, 1, 1);
            aiPlanSetEscrowID(siegeCampPlanID, cMilitaryEscrowID);
            aiPlanSetBaseID(siegeCampPlanID, kbBaseGetMainID(cMyID));
            aiPlanSetActive(siegeCampPlanID);
         }
         //Maintain a couple of siege towers.
         createSimpleMaintainPlan(cUnitTypeSiegeTower, 2, false, kbBaseGetMainID(cMyID));
      }

      //Set the build limit for Outposts.
      aiSetMaxLOSProtoUnitLimit(9);
   }

   //Up our Thor dwarf count.
   if (gDwarfMaintainPlanID > -1)
      aiPlanSetVariableInt(gDwarfMaintainPlanID, cTrainPlanNumberToMaintain, 0, 6);

   //If we're building towers, do that.
   if (gBuildTowers == true)
      towerInBase("Age3TowerBuild", false, 6, cEconomyEscrowID);

   //If we're in deathmatch, immediately build some more houses.  Also, call tradeWithCaravans to
   //get our market put down ASAP.
   if (aiGetGameMode() == cGameModeDeathmatch)
   {
      gHardEconomyPopCap=20;
      createSimpleBuildPlan(cUnitTypeHouse, 2, 99, false, false, cEconomyEscrowID, kbBaseGetMainID(cMyID), 2);
      tradeWithCaravans();
   }
}

//==============================================================================
// Age 4 Handler
//==============================================================================
void age4Handler(int age=3)
{
   aiEcho("I'm now in Age "+age+".");
   //Econ.
   econAge4Handler(age);
   //Progress.
   progressAge4Handler(age);
   //GP.
   gpAge4Handler(age);
   aiEcho("  Done with misc handlers.");

   //Switch the EM rule.
   xsDisableRule("updateEMAge3");
   xsEnableRule("updateEMAge4");

   //Enable our siege rule.
   xsEnableRule("increaseSiegeWeaponUP");
   //Enable our degrade unit preference rule.
   xsEnableRule("degradeUnitPreference");
   //Enable our omniscience rule.
   xsEnableRule("getOmniscience");

   //Econ.
   if(gGatherGoalPlanID >= 0)
   {
      //Set the RGP weights.  Cost in charge now.
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanScriptRPGPct, 0, 0.15);
      aiPlanSetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanCostRPGPct, 0, 0.85);
      aiSetResourceGathererPercentageWeight(cRGPScript, 0.15);
      aiSetResourceGathererPercentageWeight(cRGPCost, 0.85);
   }

   //Create new greek hero maintain plans.
   if (cMyCulture == cCultureGreek)
   {
      if (cMyCiv == cCivZeus)
      {
         createSimpleMaintainPlan(cUnitTypeHeroGreekBellerophon, 1, false, kbBaseGetMainID(cMyID));
      }
      else if (cMyCiv == cCivPoseidon)
         createSimpleMaintainPlan(cUnitTypeHeroGreekPolyphemus, 1, false, kbBaseGetMainID(cMyID));
      else if (cMyCiv == cCivHades)
         createSimpleMaintainPlan(cUnitTypeHeroGreekPerseus, 1, false, kbBaseGetMainID(cMyID));
      if (aiGetWorldDifficulty() != cDifficultyEasy)
         createSimpleMaintainPlan(cUnitTypeHelepolis, 1, false, kbBaseGetMainID(cMyID));


   }
   else if (cMyCulture == cCultureEgyptian)
   {
      //Catapults.
      if (aiGetWorldDifficulty() != cDifficultyEasy)
         createSimpleMaintainPlan(cUnitTypeCatapult, 2, false, kbBaseGetMainID(cMyID));
      //Set the build limit for Outposts.
      aiSetMaxLOSProtoUnitLimit(11);

      if(gAge4MinorGod == cTechAge4Thoth)
      {
         int botPID=aiPlanCreate("GetBookOfThoth", cPlanProgression);
         if (botPID != 0)
         {
            aiPlanSetVariableInt(botPID, cProgressionPlanGoalTechID, 0, cTechBookofThoth);
            aiPlanSetDesiredPriority(botPID, 25);
            aiPlanSetEscrowID(botPID, cMilitaryEscrowID);
            aiPlanSetActive(botPID);
         }
      }
      else if(gAge4MinorGod == cTechAge4Osiris)
      {
         int nkPID=aiPlanCreate("GetnewKingdom", cPlanProgression);
         if (nkPID != 0)
         {
            aiPlanSetVariableInt(nkPID, cProgressionPlanGoalTechID, 0, cTechNewKingdom);
            aiPlanSetDesiredPriority(nkPID, 25);
            aiPlanSetEscrowID(nkPID, cMilitaryEscrowID);
            aiPlanSetActive(nkPID);
         }
      }
   }

   //If we're in deathmatch, no more hard pop cap.
   if (aiGetGameMode() == cGameModeDeathmatch)
   {
      gHardEconomyPopCap=-1;
      createSimpleBuildPlan(cUnitTypeHouse, 2, 99, false, false, cEconomyEscrowID, kbBaseGetMainID(cMyID), 2);
   }
}

//==============================================================================
// degradeUnitPreference
//==============================================================================
rule degradeUnitPreference
   minInterval 119
   inactive
{
   //If we're not 4th age, skip.
   if (kbGetAge() < 3)
      return;
   float newPreferenceWeight=kbUnitPickGetPreferenceWeight(gLateUPID);
   if (newPreferenceWeight <= 0.0)
      return;
   newPreferenceWeight=newPreferenceWeight*0.9;
   kbUnitPickSetPreferenceWeight(gLateUPID, newPreferenceWeight);
}

//==============================================================================
// towerUpgrade
//==============================================================================
rule towerUpgrade
   minInterval 31
   inactive
   runImmediately
{
   //Must be setup for wood before we do any of this.
   if (kbSetupForResource(kbBaseGetMainID(cMyID), cResourceWood, 25.0, 400) == false)
      return;

   //Start upgrading my defenses.
   int pid=aiPlanCreate("towerUpgrade", cPlanProgression);
   if (pid >= 0)
   {
      aiPlanSetVariableBool(pid, cProgressionPlanRunInParallel, 0, true);
      aiPlanSetDesiredPriority(pid, 30);
      aiPlanSetEscrowID(pid, gTowerEscrowID);
      aiPlanSetBaseID(pid, kbBaseGetMainID(cMyID));

      if(cMyCulture == cCultureGreek)
      {
         aiPlanSetNumberVariableValues(pid, cProgressionPlanGoalTechID, 5, true);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 0, cTechSignalFires);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 1, cTechCarrierPigeons);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 2, cTechBoilingOil);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 3, cTechWatchTower);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 4, cTechGuardTower);
         aiPlanSetActive(pid);
      }
      else if(cMyCulture == cCultureEgyptian)
      {
         aiPlanSetNumberVariableValues(pid, cProgressionPlanGoalTechID, 5, true);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 0, cTechSignalFires);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 1, cTechCarrierPigeons);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 2, cTechBoilingOil);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 3, cTechGuardTower);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 4, cTechBallistaTower);
         aiPlanSetActive(pid);
      }
      else if(cMyCulture == cCultureNorse)
      {
         aiPlanSetNumberVariableValues(pid, cProgressionPlanGoalTechID, 4, true);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 0, cTechSignalFires);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 1, cTechCarrierPigeons);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 2, cTechBoilingOil);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 3, cTechWatchTower);
         aiPlanSetActive(pid);
      }
      else
         aiPlanDestroy(pid);

      xsDisableSelf();
   }
}

//==============================================================================
// wallUpgrade
//==============================================================================
rule wallUpgrade
   minInterval 30
   inactive
   runImmediately
{
   //Must be setup for wood first.
   if (kbSetupForResource(kbBaseGetMainID(cMyID), cResourceWood, 25.0, 600) == false)
      return;

   //Start upgrading my defenses.
   int pid=aiPlanCreate("wallUpgrade", cPlanProgression);
   if (pid >= 0)
   {
      aiPlanSetVariableBool(pid, cProgressionPlanRunInParallel, 0, true);
      aiPlanSetDesiredPriority(pid, 30);
      aiPlanSetEscrowID(pid, cMilitaryEscrowID);
      aiPlanSetBaseID(pid, kbBaseGetMainID(cMyID));
      if( cMyCulture == cCultureNorse )
      {
         aiPlanSetNumberVariableValues(pid, cProgressionPlanGoalTechID, 1, true);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 0, cTechStoneWall);
      }
      else
      {
         aiPlanSetNumberVariableValues(pid, cProgressionPlanGoalTechID, 2, true);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 0, cTechStoneWall);
         aiPlanSetVariableInt(pid, cProgressionPlanGoalTechID, 1, cTechFortifiedWall);
      }
      aiPlanSetActive(pid);
      xsDisableSelf();
   }
   xsDisableSelf();
}

//==============================================================================
// periodicSaveGames
//==============================================================================
rule periodicSaveGames
   minInterval 5
   active
{
   //Dont save if we are told not to.
   if (aiGetAutosaveOn() == false)
   {
      xsDisableSelf();
      return;
   }

   int firstCPPlayerID = -1;
   for(i=0; < cNumberPlayers)
   {
      if(kbIsPlayerHuman(i) == true)
         continue;

      firstCPPlayerID = i;
   }
   if (cMyID != firstCPPlayerID)
      return;

   //Create the savegame name.
   static int psCount=0;
   //Save it.
   aiQueueAutoSavegame(psCount);
   //Inc our count.
   psCount=psCount+1;

   //After the first time, set it to every five minutes.
   xsSetRuleMinIntervalSelf(180);
}


//==============================================================================
// towerInBase
//==============================================================================
void towerInBase(string planName="BUG", bool los = true, int numTowers = 6, int escrowID=-1)
{
   int planID=aiPlanCreate(planName, cPlanTower);
   if (planID >= 0)
   {
      //Save the escrow ID.
      gTowerEscrowID=escrowID;

      aiPlanSetVariableFloat(planID, cTowerPlanDistanceFromCenter, 0, 75.0);
      aiPlanSetVariableBool(planID, cTowerPlanMaximizeLOS, 0, los);
      if(los)
         aiPlanSetVariableFloat(planID, cTowerPlanLOSModifier, 0, 1.0);
      else
         aiPlanSetVariableFloat(planID, cTowerPlanAttackLOSModifier, 0, 0.75);

      aiPlanSetVariableInt(planID, cTowerPlanNumberToBuild, 0, numTowers);
      aiPlanSetVariableInt(planID, cTowerPlanProtoIDToBuild, 0, cUnitTypeTower);

      aiPlanSetDesiredPriority(planID, 100);
      aiPlanSetEscrowID(planID, gTowerEscrowID);
      aiPlanSetBaseID(planID, kbBaseGetMainID(cMyID));
      aiPlanSetActive(planID);
   }
}

//==============================================================================
// RULE: updateEconGathererPercentCaps
//
// updates the GathererPerecnt if they are completely out of whack(tm).
//==============================================================================
rule updateEconGathererPercentCaps
   minInterval 7
   active
{
   if(gGatherGoalPlanID < 0)
      return;

   float foodGPct = aiPlanGetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceFood);
   float woodGPct = aiPlanGetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceWood);
   float goldGPct = aiPlanGetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceGold);
   float favorGPct = aiPlanGetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanGathererPct, cResourceFavor);

   //-- get current resource amounts
   float currentFood  = kbResourceGet(cResourceFood);
   float currentWood  = kbResourceGet(cResourceWood);
   float currentGold  = kbResourceGet(cResourceGold);
   float currentFavor = kbResourceGet(cResourceFavor);

   //-- get current resource needs.
   float currentFoodNeed = aiGetCurrentResourceNeed(cResourceFood);
   float currentWoodNeed = aiGetCurrentResourceNeed(cResourceWood);
   float currentGoldNeed = aiGetCurrentResourceNeed(cResourceGold);
   float currentFavorNeed = aiGetCurrentResourceNeed(cResourceFavor);

   //-- get the script specified need minimums.
   float minFood = aiPlanGetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanMinResourceAmt, cResourceFood);
   float minWood = aiPlanGetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanMinResourceAmt, cResourceWood);
   float minGold = aiPlanGetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanMinResourceAmt, cResourceGold);

   //-- make sure our need is at least the specified minimum.
   if(currentFoodNeed < minFood)
      currentFoodNeed = minFood;
   if(currentWoodNeed < minWood)
      currentWoodNeed = minWood;
   if(currentGoldNeed < minGold)
      currentGoldNeed = minGold;

   //-- get our gold to ratios.
   float goldToFood = currentGold-currentFood;
   float goldToWood = currentGold-currentWood;

   //-- calc the resource to need ratios.  anything greater than 1, means that we have more of that resource than we need.
   float foodToNeedRatio = 100000.0;
   if(currentFoodNeed > 0.0)
      foodToNeedRatio = currentFood / currentFoodNeed;
   float woodToNeedRatio = 100000.0;
   if(currentWoodNeed > 0.0)
      woodToNeedRatio = currentWood / currentWoodNeed;
   float goldToNeedRatio = 100000.0;
   if(currentGoldNeed > 0.0)
      goldToNeedRatio = currentGold / currentGoldNeed;

   //-- get the script specified buffer amounts per resource.
   float foodBuffer = aiPlanGetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanResourceSkew, cResourceFood);
   float woodBuffer = aiPlanGetVariableFloat(gGatherGoalPlanID, cGatherGoalPlanResourceSkew, cResourceWood);

   int numMarkets = kbUnitCount(cMyID, cUnitTypeMarket, cUnitStateAlive);
   int resource = -1;

   if(goldToNeedRatio > 1.0)
   {
      //-- sell gold if
      // 0. we have a market.
      // 1. we have more gold than we need
      // 2. we have more food than the min we want to keep.
      // 3. we have more food or wood than gold.

      //-- we will buy food if
      // 1, we have more gold than food.
      // 2. we need more food than wood.

      //-- otherwise, we will buy wood.

      //-- if we have we have the min amount of gold AND we have more gold than we need,
      //-- buy which ever resource we have the most, as long as one of them is larger than gold.
      if(numMarkets > 0)
      {
         if((foodToNeedRatio<woodToNeedRatio) && (foodToNeedRatio<1.0))
         {
            aiBuyResourceOnMarket(cResourceFood);
            return;
         }
         else if(woodToNeedRatio<1.0)
         {
            aiBuyResourceOnMarket(cResourceWood);
            return;
         }
      }
      else
      {
         //-- Turn down gold
         //goldGPct = 0.1;
      }
   }

   if(foodToNeedRatio > woodToNeedRatio)
   {
      //-- sell food if
      // 0. we have a market.
      // 1. we have more food than we need
      // 2. we have more food than the min we want to keep.
      // 3. we have more fo0d than gold by the skew amount.
      if((currentFood > minFood) && (numMarkets > 0) && ((currentFood-currentGold) > foodBuffer))
      {
         aiSellResourceOnMarket(cResourceFood);
         return;
      }
      else
      {
         //-- Turn down food
         //foodGPct = 0.1;
      }

   }

   //-- sell wood if
   // 0. we have a market.
   // 1. we have more wood than we need
   // 2. we have more wood than the min we want to keep.
   // 3. we have more wood than gold by the skew amount.
   if((currentWood > minWood) && (numMarkets > 0) && ((currentWood-currentGold) > woodBuffer))
   {
      aiSellResourceOnMarket(cResourceWood);
      return;
   }
   else
   {
      //-- Turn down food
      //woodGPct = 0.1;
   }

   aiSetResourceGathererPercentage(cResourceFood, foodGPct, false, cRGPScript);
   aiSetResourceGathererPercentage(cResourceWood, woodGPct, false, cRGPScript);
   aiSetResourceGathererPercentage(cResourceGold, goldGPct, false, cRGPScript);
   aiSetResourceGathererPercentage(cResourceFavor, favorGPct, false, cRGPScript);
   aiNormalizeResourceGathererPercentages(cRGPScript);
}

//==============================================================================
// ShouldIResign
//==============================================================================
rule ShouldIResign
   minInterval 7
   active
{
   //Don't resign in MP games.
   if(aiIsMultiplayer() == true)
   {
      xsDisableSelf();
      return;
   }

   //Don't resign if you're teamed with a human.
   static bool checkTeamedWithHuman=true;
   if (checkTeamedWithHuman == true)
   {
      for (i=1; < cNumberPlayers)
      {
         if (i == cMyID)
            continue;
         //Skip if not human.
         if (kbIsPlayerHuman(i) == false)
            continue;
         //If this is a mutually allied human, go away.
         if (kbIsPlayerMutualAlly(i) == true)
         {
            xsDisableSelf();
            return;
         }
      }
      //Don't check again.
      checkTeamedWithHuman=false;
   }

   //Don't resign too soon.
   if (xsGetTime() < 1200000)
     return;

   int numSettlements=kbUnitCount(cMyID, cUnitTypeAbstractSettlement, cUnitStateAliveOrBuilding);
   //If on easy, don't only resign if you have no settlements.
   if (aiGetWorldDifficulty() == cDifficultyEasy)
   {
      if (numSettlements <= 0)
      {
         aiEcho("Resign: Easy numSettlements("+numSettlements+")");
         gResignType = cResignSettlements;
         aiAttemptResign(cAICommPromptResignQuestion);
         xsDisableSelf();
         return;
      }
      return;
   }

   //Don't resign if we have over 30 active pop slots.
   if (kbGetPop() >= 30)
      return;

   //If we don't have any builders, we're not Norse, and we cannot afford anymore, try to resign.
   int builderUnitID=kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionBuilder, 0);
   int numBuilders=kbUnitCount(cMyID, builderUnitID, cUnitStateAliveOrBuilding);
   if ((numBuilders <= 0) && (cMyCulture != cCultureNorse))
   {
      if (kbCanAffordUnit(builderUnitID, cEconomyEscrowID) == false)
      {
        aiEcho("Resign: numBuilders("+numBuilders+")");
        gResignType=cResignGatherers;
        //aiCommsSendStatement(aiGetMostHatedPlayerID(), cAICommPromptAIResignGatherers, -1);
        aiAttemptResign(cAICommPromptResignQuestion);
        xsDisableSelf();
        return;
      }
   }

   if ((numSettlements <= 0) && (numBuilders <= 10))
   {
      if ((kbCanAffordUnit(cUnitTypeSettlementLevel1, cEconomyEscrowID) == false) || (numBuilders <= 0))
      {
         aiEcho("Resign: numSettlements("+numSettlements+"): numBuilders("+numBuilders+")");
         gResignType = cResignSettlements;
         //aiCommsSendStatement(aiGetMostHatedPlayerID(), cAICommPromptAIResignSettlements, -1);
         aiAttemptResign(cAICommPromptResignQuestion);
         xsDisableSelf();
         return;
      }
   }
   //Don't quit if we have more than one settlement.
   if (numSettlements > 1)
      return;

   //3. if all of my teammates have left the game.
   int activeEnemies=0;
   int activeTeammates=0;
   int deadTeammates=0;
   float currentEnemyMilPop=0.0;
   float currentMilPop=0.0;
   for (i=1; < cNumberPlayers)
   {
      if (i == cMyID)
      {
         currentMilPop=currentMilPop+kbUnitCount(i, cUnitTypeMilitary, cUnitStateAlive);
         continue;
      }

      if (kbIsPlayerAlly(i) == false)
      {
         //Increment the active number of enemies there currently are.
         if (kbIsPlayerResigned(i) == false)
         {
            activeEnemies=activeEnemies+1;
            currentEnemyMilPop=currentEnemyMilPop+kbUnitCount(i, cUnitTypeMilitary, cUnitStateAlive);
         }
         continue;
      }

      //If I still have an active teammate, don't resign.
      if (kbIsPlayerResigned(i) == true)
         deadTeammates=deadTeammates+1;
      else
         activeTeammates=activeTeammates+1;
   }

   //3a. if at least one player from my team has left the game and I am the only player left on my team,
   //    and the other team(s) have 2 or more players in the game.
   if ((activeEnemies >= 2) && (activeTeammates <= 0) && (deadTeammates>0))
   {
      aiEcho("Resign: activeEnemies ("+activeEnemies +"): activeTeammates ("+activeTeammates +"), deadTeammates ("+deadTeammates +")");
      gResignType=cResignTeammates;
      //aiCommsSendStatement(aiGetMostHatedPlayerID(), cAICommPromptAIResignActiveEnemies, -1);
      aiAttemptResign(cAICommPromptResignQuestion);
      xsDisableSelf();
      return;
   }

   //4. my mil pop is low and the enemy's mil pop is high,
   //Don't do this eval until 4th age and at least 30 min. into the game.
   if ((xsGetTime() < 1800000) || (kbGetAge() < 3))
     return;

   static float enemyMilPopTotal=0.0;
   static float myMilPopTotal=0.0;
   static float count=0.0;
   count=count+1.0;
   enemyMilPopTotal=enemyMilPopTotal+currentEnemyMilPop;
   myMilPopTotal=myMilPopTotal+currentMilPop;
   if (count >= 10.0)
   {
      if ((enemyMilPopTotal > (7.0*myMilPopTotal)) || (myMilPopTotal <= count))
      {
         aiEcho("Resign: Count("+count+"): EMP Total("+enemyMilPopTotal+"), MMP Total("+myMilPopTotal+")");
         aiEcho("Resign: EMP Current("+currentEnemyMilPop+"), MMP Current("+currentMilPop+")");

         gResignType=cResignMilitaryPop;
         //aiCommsSendStatement(aiGetMostHatedPlayerID(), cAICommPromptAIResignActiveEnemies, -1);
         aiAttemptResign(cAICommPromptResignQuestion);
         xsDisableSelf();
         return;
      }

      count=0.0;
      enemyMilPopTotal=0.0;
      myMilPopTotal=0.0;
   }
}


//==============================================================================
// resignTimer
//==============================================================================
rule resignTimer
   minInterval 60
   inactive
{
   //This rule turns the resign rule back on after a bit of time.
   //Used when the human player refuses to allow quarter

   static bool bFirstUpdate=false;
   if (bFirstUpdate == false)
   {
      bFirstUpdate=true;
      return;
   }
   xsEnableRule("ShouldIResign");
}


//==============================================================================
// findVinlandsagaBase
//==============================================================================
rule findVinlandsagaBase
   minInterval 10
   inactive
{
   //Save our initial base ID.
   gVinlandsagaInitialBaseID=kbBaseGetMainID(cMyID);

   //Get our initial location.
   vector location=kbBaseGetLocation(cMyID, kbBaseGetMainID(cMyID));
   //Find the mainland area group.
   int mainlandGroupID=-1;
   mainlandGroupID=kbFindAreaGroup(cAreaGroupTypeLand, 3.0, kbAreaGetIDByPosition(location));
   if (mainlandGroupID < 0) mainlandGroupID=kbFindAreaGroupByLocation(cAreaGroupTypeLand, 0.5, 0.5);

   if (mainlandGroupID < 0) return;
   aiEcho("findVinlandsagaBase: Found the mainland, AGID="+mainlandGroupID+".");

   //Create the mainland base.
   int mainlandBaseGID=createBaseGoal("Mainland Base", cGoalPlanGoalTypeMainBase,
      -1, 1, 0, -1, kbBaseGetMainID(cMyID));
   if (mainlandBaseGID >= 0)
   {
      //Set the area ID.
      aiPlanSetVariableInt(mainlandBaseGID, cGoalPlanAreaGroupID, 0, mainlandGroupID);
      //Create the callback goal.
      int callbackGID=createCallbackGoal("Vinlandsaga Base Callback", "vinlandsagaBaseCallback",
         1, 0, -1, false);
      if (callbackGID >= 0)
         aiPlanSetVariableInt(mainlandBaseGID, cGoalPlanDoneGoal, 0, callbackGID);
   }

   //Done.
   xsDisableSelf();
}

//==============================================================================
// vindlandsagaEnableFishing
//==============================================================================
rule vindlandsagaEnableFishing
   minInterval 10
   inactive
{
   //See how many wood dropsites we have.
   static int wdQueryID=-1;
   //If we don't have a query ID, create it.
   if (wdQueryID < 0)
   {
      wdQueryID=kbUnitQueryCreate("Wood Dropsite Query");
      //If we still don't have one, bail.
      if (wdQueryID < 0)
         return;
      //Else, setup the query data.
      kbUnitQuerySetPlayerID(wdQueryID, cMyID);
      if (cMyCulture == cCultureGreek)
         kbUnitQuerySetUnitType(wdQueryID, cUnitTypeStorehouse);
      else if (cMyCulture == cCultureEgyptian)
         kbUnitQuerySetUnitType(wdQueryID, cUnitTypeLumberCamp);
      else if (cMyCulture == cCultureNorse)
         kbUnitQuerySetUnitType(wdQueryID, cUnitTypeLogicalTypeLandMilitary);
      kbUnitQuerySetAreaGroupID(wdQueryID, kbAreaGroupGetIDByPosition(kbBaseGetLocation(cMyID, kbBaseGetMainID(cMyID))) );
      kbUnitQuerySetState(wdQueryID, cUnitStateAlive);
   }
   //Reset the results.
   kbUnitQueryResetResults(wdQueryID);
   //Run the query.  If we don't have anything, skip.
   if (kbUnitQueryExecute(wdQueryID) <= 0)
      return;

   //Enable the rule.
   xsEnableRule("fishing");
   //Unpause the age upgrades.
   aiSetPauseAllAgeUpgrades(false);
   //Unpause the pause kicker.
   xsEnableRule("unPauseAge2");
   xsSetRuleMinInterval("unPauseAge2", 15);

   //Create a simple plan to maintain X Ulfsarks (since we didn't do this as part of initNorse).
   createSimpleMaintainPlan(cUnitTypeUlfsark, gMaintainNumberLandScouts+1, true, kbBaseGetMainID(cMyID));

   //Disable us.
   xsDisableSelf();
}

//==============================================================================
// vinlandsagaBaseCallback
//==============================================================================
void vinlandsagaBaseCallback(int parm1=-1)
{
   aiEcho("VinlandsagaBaseCallback:");

   //Get our water transport type.
   int transportPUID=kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionWaterTransport, 0);
   if (transportPUID < 0)
      return;
   //Get our main base.  This needs to be different than our initial base.
   if (kbBaseGetMainID(cMyID) == gVinlandsagaInitialBaseID)
      return;

   //Kill the transport explore plan.
   aiPlanDestroy(gVinlandsagaTransportExplorePlanID);
   //Kill the land scout explore.
   aiPlanDestroy(gLandExplorePlanID);
   //Create a new land based explore plan for the mainland.
   gLandExplorePlanID=aiPlanCreate("Explore_Land_VS", cPlanExplore);
   if (gLandExplorePlanID >= 0)
   {
      aiPlanAddUnitType(gLandExplorePlanID, gLandScout, 1, 1, 1);
      aiPlanSetActive(gLandExplorePlanID);
      aiPlanSetEscrowID(gLandExplorePlanID, cEconomyEscrowID);
      aiPlanSetBaseID(gLandExplorePlanID, kbBaseGetMainID(cMyID));
      //Don't loop as egyptian.
      if (cMyCulture == cCultureEgyptian)
         aiPlanSetVariableBool(gLandExplorePlanID, cExplorePlanDoLoops, 0, false);
   }

   //Get our start area ID.
   int startAreaID=kbAreaGetIDByPosition(kbBaseGetLocation(cMyID, gVinlandsagaInitialBaseID));
   //Get our goal area ID.
   int goalAreaID=kbAreaGetIDByPosition(kbBaseGetLocation(cMyID, kbBaseGetMainID(cMyID)));

   //Create the scout xport plan.  If it works, add the unit type(s).
   int planID=createTransportPlan("Scout Transport", startAreaID, goalAreaID,
      false, transportPUID, 100, gVinlandsagaInitialBaseID);
   if (planID >= 0)
   {
      aiPlanAddUnitType(planID, gLandScout, 1, 1, 1);
      if (cMyCulture == cCultureNorse)
         aiPlanAddUnitType(planID, cUnitTypeOxCart, 1, 1, 1);
      //We require all need units on this one.
      aiPlanSetRequiresAllNeedUnits(planID, true);
   }

   //Create the villager xport plan.  If it works, add the unit type(s).
   planID=createTransportPlan("Villager Transport", startAreaID, goalAreaID,
      true, transportPUID, 75, gVinlandsagaInitialBaseID);
   if (planID >= 0)
   {
      aiPlanAddUnitType(planID, cUnitTypeAbstractVillager, 1, 5, 5);
      aiPlanAddUnitType(planID, cUnitTypeLogicalTypeLandMilitary, 0, 1, 1);
      if (cMyCulture == cCultureNorse)
         aiPlanAddUnitType(planID, cUnitTypeOxCart, 0, 1, 4);
   }

   //change the farming baseID
   gFarmBaseID=kbBaseGetMainID(cMyID);

   //Allow auto dropsites again.
   aiSetAllowAutoDropsites(true);
   aiSetAllowBuildings(true);

   //Enable the rule that will eventually enable fishing and other stuff.
   xsEnableRule("vindlandsagaEnableFishing");
}

//==============================================================================
// nomadBuildSettlementCallBack
//==============================================================================
void nomadBuildSettlementCallBack(int parm1=-1)
{
   aiEcho("nomadBuildSettlementCallBack:");

   //Find our one settlement.and make it the main base.
   int settlementID=findUnit(cMyID, cUnitStateAliveOrBuilding, cUnitTypeAbstractSettlement);
   if (settlementID < 0)
   {
      //Enable the rule that looks for a settlement.
      int nomadSettlementGoalID=createBuildSettlementGoal("BuildNomadSettlement", 0, -1, -1, 1, kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionBuilder,0), true, 100);
      if (nomadSettlementGoalID != -1)
      {
         //Create the callback goal.
         int nomadCallbackGID=createCallbackGoal("Nomad BuildSettlement Callback", "nomadBuildSettlementCallBack", 1, 0, -1, false);
         if (nomadCallbackGID >= 0)
            aiPlanSetVariableInt(nomadSettlementGoalID, cGoalPlanDoneGoal, 0, nomadCallbackGID);
      }
      return;
   }

   //Kill the villie explore plan.
   aiPlanDestroy(gNomadExplorePlanID);

   //Find our one settlement and make it the main base.
   int newBaseID=kbUnitGetBaseID(findUnit(cMyID, cUnitStateAliveOrBuilding, cUnitTypeAbstractSettlement));
   aiSwitchMainBase(newBaseID, true);
   kbBaseSetMain(cMyID, newBaseID, true);

   //Unpause the age upgrades.
   aiSetPauseAllAgeUpgrades(false);
   //Unpause the pause kicker.
   xsEnableRule("unPauseAge2");
   xsSetRuleMinInterval("unPauseAge2", 15);

   //Turn on buildhouse.
   xsEnableRule("buildHouse");
}

//==============================================================================
// build handler
//==============================================================================
void buildHandler(int protoID=-1)
{
   if (protoID == cUnitTypeSettlement)
   {
      for (i=1; < cNumberPlayers)
      {
         if (i == cMyID)
            continue;
         if (kbIsPlayerAlly(i) == true)
            continue;
         aiCommsSendStatement(i, cAICommPromptAIBuildSettlement, -1);
      }
   }
}

//==============================================================================
// god power handler
//==============================================================================
void gpHandler(int powerProtoID=-1)
{
   if (powerProtoID == -1)
      return;
   if (powerProtoID == cPowerSpy)
      return;

   //Most hated player chats.
   if ((powerProtoID == cPowerPlagueofSerpents) ||
      (powerProtoID == cPowerEarthquake)        ||
      (powerProtoID == cPowerCurse)             ||
      (powerProtoID == cPowerFlamingWeapons)    ||
      (powerProtoID == cPowerForestFire)        ||
      (powerProtoID == cPowerFrost)             ||
      (powerProtoID == cPowerLightningStorm)    ||
      (powerProtoID == cPowerLocustSwarm)       ||
      (powerProtoID == cPowerMeteor)            ||
      (powerProtoID == cPowerAncestors)         ||
      (powerProtoID == cPowerFimbulwinter)      ||
      (powerProtoID == cPowerTornado)           ||
      (powerProtoID == cPowerBolt))
   {
      aiCommsSendStatement(aiGetMostHatedPlayerID(), cAICommPromptOffensiveGodPower, -1);
      return;
   }

   //Any player chats.
   int type=cAICommPromptGenericGodPower;
   if ((powerProtoID == cPowerProsperity) ||
      (powerProtoID == cPowerPlenty)      ||
      (powerProtoID == cPowerLure)        ||
      (powerProtoID == cPowerDwarvenMine) ||
      (powerProtoID == cPowerGreatHunt)   ||
      (powerProtoID == cPowerRain))
   {
      type=cAICommPromptEconomicGodPower;
   }

   //Tell all the enemy players
   for (i=1; < cNumberPlayers)
   {
      if (i == cMyID)
         continue;
      if (kbIsPlayerAlly(i) == true)
         continue;
      aiCommsSendStatement(i, type, -1);
   }
}

//==============================================================================
// wonder death handler
//==============================================================================
void wonderDeathHandler(int playerID = -1)
{
   if (playerID == cMyID)
   {
      aiCommsSendStatement(aiGetMostHatedPlayerID(), cAICommPromptAIWonderDestroyed, -1);
      return;
   }
   if (playerID == aiGetMostHatedPlayerID())
      aiCommsSendStatement(playerID, cAICommPromptPlayerWonderDestroyed, -1);
}


//==============================================================================
// retreat handler
//==============================================================================
void retreatHandler(int planID = -1)
{
   aiCommsSendStatement(aiGetMostHatedPlayerID(), cAICommPromptAIRetreat, -1);
}

//==============================================================================
// relic handler
//==============================================================================
void relicHandler(int relicID = -1)
{
   if (aiRandInt(3) != 0)
      return;

   for (i=1; < cNumberPlayers)
   {
      if (i == cMyID)
         continue;

      //Only a 33% chance for either of these chats
      if (kbIsPlayerAlly(i) == true)
      {
         if (relicID != -1)
         {
            vector position = kbUnitGetPosition(relicID);
            aiCommsSendStatementWithVector(i, cAICommPromptTakingAllyRelic, -1, position);
         }
         else
            aiCommsSendStatement(i, cAICommPromptTakingAllyRelic, -1);
      }
      else
         aiCommsSendStatement(i, cAICommPromptTakingEnemyRelic, -1);
   }
}

//==============================================================================
// relic handler
//==============================================================================
void resignHandler(int result =-1)
{
   if (result == 0)
   {
      //xsEnableRule("resignTimer");
      return;
   }

   if (gResignType == cResignGatherers)
   {
      aiResign();
      return;
   }
   if (gResignType == cResignSettlements)
   {
      aiResign();
      return;
   }
   if (gResignType == cResignTeammates)
   {
      aiResign();
      return;
   }
   if (gResignType == cResignMilitaryPop)
   {
     aiResign();
     return;
   }
}

//==============================================================================
// attackChatCallback
//==============================================================================
void attackChatCallback(int parm1=-1)
{
    aiCommsSendStatement(aiGetMostHatedPlayerID(), cAICommPromptAIAttack, -1);
}

//==============================================================================
// findTownDefenseGP
//==============================================================================
void findTownDefenseGP(int baseID=-1)
{

   if (gTownDefenseGodPowerPlanID != -1)
      return;
   gTownDefenseGodPowerPlanID=aiFindBestTownDefenseGodPowerPlan();
   if (gTownDefenseGodPowerPlanID == -1)
      return;

   //Change the evaluation model (and remember it).
   gTownDefenseEvalModel=aiPlanGetVariableInt(gTownDefenseGodPowerPlanID, cGodPowerPlanEvaluationModel, 0);
   aiPlanSetVariableInt(gTownDefenseGodPowerPlanID, cGodPowerPlanEvaluationModel, 0, cGodPowerEvaluationModelCombatDistancePosition);
   //Change the player (and remember it).
   gTownDefensePlayerID=aiPlanGetVariableInt(gTownDefenseGodPowerPlanID, cGodPowerPlanQueryPlayerID, 0);
   //Set the location.
   aiPlanSetVariableVector(gTownDefenseGodPowerPlanID, cGodPowerPlanQueryLocation, 0, kbBaseGetLocation(cMyID, kbBaseGetMainID(cMyID)) );
}

//==============================================================================
// releaseTownDefenseGP
//==============================================================================
void releaseTownDefenseGP()
{
   if (gTownDefenseGodPowerPlanID == -1)
      return;
   //Change the evaluation model back.
   aiPlanSetVariableInt(gTownDefenseGodPowerPlanID, cGodPowerPlanEvaluationModel, 0, gTownDefenseEvalModel);
   //Reset the player.
   aiPlanSetVariableInt(gTownDefenseGodPowerPlanID, cGodPowerPlanQueryPlayerID, 0, gTownDefensePlayerID);
   //Release the plan.
   gTownDefenseGodPowerPlanID=-1;
   gTownDefenseEvalModel=-1;
   gTownDefensePlayerID=-1;
}

//==============================================================================
// RULE introChat
//==============================================================================
rule introChat
   minInterval 15
   active
{
   if (aiGetWorldDifficulty() != cDifficultyEasy)
   {
      for (i=1; < cNumberPlayers)
      {
         if (i == cMyID)
            continue;
         if (kbIsPlayerAlly(i) == true)
            continue;
         if (kbIsPlayerHuman(i) == true)
            aiCommsSendStatement(i, cAICommPromptIntro, -1);
      }
   }

   xsDisableSelf();
}

//==============================================================================
// RULE myAgeTracker
//==============================================================================
rule myAgeTracker
   minInterval 60
   active
{
   static bool bMessage=false;
   static int messageAge=-1;

   //Disable this in deathmatch.
   if (aiGetGameMode() == cGameModeDeathmatch)
   {
      xsDisableSelf();
      return;
   }

   //Only the captain does this.
   if (aiGetCaptainPlayerID(cMyID) != cMyID)
      return;

   //Are we greater age than our most hated enemy?
   int myAge=kbGetAge();
   int hatedPlayerAge=kbGetAgeForPlayer(aiGetMostHatedPlayerID());

   //Reset the message counter if we have changed ages.
   if (bMessage == true)
   {
      if (messageAge == myAge)
         return;
      bMessage=false;
   }

   //Make a message??
   if ((myAge > hatedPlayerAge) && (bMessage == false))
   {
      bMessage=true;
      messageAge=myAge;
      aiCommsSendStatement(aiGetMostHatedPlayerID(), cAICommPromptAIWinningAgeRace, -1);
   }
   if ((hatedPlayerAge > myAge) && (bMessage == false))
   {
      bMessage=true;
      messageAge=myAge;
      aiCommsSendStatement(aiGetMostHatedPlayerID(), cAICommPromptAILosingAgeRace, -1);
   }

   //Stop when we reach the finish line.
   if (myAge == cAge4)
      xsDisableSelf();
}

//==============================================================================
// RULE mySettlementTracker
//==============================================================================
rule mySettlementTracker
   minInterval 11
   active
{
   static int tcCountQueryID=-1;
   //Only the captain does this
   if (aiGetCaptainPlayerID(cMyID) != cMyID)
      return;

   //If we don't have a query ID, create it.
   if (tcCountQueryID < 0)
   {
      tcCountQueryID=kbUnitQueryCreate("SettlementCount");
      //If we still don't have one, bail.
      if (tcCountQueryID < 0)
         return;
   }

   //Else, setup the query data.
   kbUnitQuerySetPlayerID(tcCountQueryID, cMyID);
   kbUnitQuerySetUnitType(tcCountQueryID, cUnitTypeAbstractSettlement);
   kbUnitQuerySetState(tcCountQueryID, cUnitStateAlive);

   //Reset the results.
   kbUnitQueryResetResults(tcCountQueryID);
   //Run the query.  Be dumb and just take the first TC for now.
   int count=kbUnitQueryExecute(tcCountQueryID);

   if ((count < gNumberMySettlements) && (gNumberMySettlements != -1))
   {
      if (count == 0)
         aiCommsSendStatement(aiGetMostHatedPlayerID(), cAICommPromptAILostLastSettlement, -1);
      else
         aiCommsSendStatement(aiGetMostHatedPlayerID(), cAICommPromptAILostSettlement, -1);
   }

   //Set the number.
   gNumberMySettlements=count;
}

//==============================================================================
// RULE earlySettlementTracker
//==============================================================================
rule earlySettlementTracker
   minInterval 7
   active
{
   //If this is 3rd age, go away.
   if (kbGetAge() >= 2)
   {
      xsDisableSelf();
      return;
   }

   //If we have no alive or building settlements, return.
   if (kbUnitCount(cMyID, cUnitTypeAbstractSettlement, cUnitStateAliveOrBuilding) > 0)
      return;
   //If we have a plan to build a settlement, return.
   if (aiPlanGetIDByTypeAndVariableType(cPlanBuild, cBuildPlanBuildingTypeID, cUnitTypeSettlementLevel1) > -1)
      return;

   xsEnableRule("buildSettlements");
}

//==============================================================================
// RULE enemySettlementTracker
//==============================================================================
rule enemySettlementTracker
   minInterval 9
   active
{
  //Only the captain does this.
   if (aiGetCaptainPlayerID(cMyID) != cMyID)
      return;

   if (gTrackingPlayer == -1)
      gTrackingPlayer = aiGetMostHatedPlayerID();

   bool reset=false;
   if (aiGetMostHatedPlayerID() != gTrackingPlayer)
   {
      gTrackingPlayer = aiGetMostHatedPlayerID();
      gNumberTrackedPlayerSettlements = -1;
      reset = true;
   }

   if (gTrackingPlayer == -1)
      return;

   static int tcCountQueryID=-1;
   //If we don't have a query ID, create it.
   if (tcCountQueryID < 0)
   {
      tcCountQueryID=kbUnitQueryCreate("SettlementCount");
      //If we still don't have one, bail.
      if (tcCountQueryID < 0)
         return;
   }

   //Else, setup the query data.
   kbUnitQuerySetPlayerID(tcCountQueryID, gTrackingPlayer);
   kbUnitQuerySetUnitType(tcCountQueryID, cUnitTypeAbstractSettlement);
   kbUnitQuerySetState(tcCountQueryID, cUnitStateAlive);

   //Reset the results.
   kbUnitQueryResetResults(tcCountQueryID);
   //Run the query.  Be dumb and just take the first TC for now.
   int count=kbUnitQueryExecute(tcCountQueryID);

   //If we are doing a reset, then just get out after storing the count.
   if (reset == true)
   {
      gNumberTrackedPlayerSettlements=count;
      return;
   }

   //If the number of settlements is greater than 1, and we have not sent a message.
   if ((count > 1) && (gNumberTrackedPlayerSettlements == -1))
   {
      aiCommsSendStatement(aiGetMostHatedPlayerID(), cAICommPromptEnemyBuildSettlement, -1);
      gNumberTrackedPlayerSettlements=count;
   }

   //If the number of settlements is equal to one and we have sent a message
   //about them growing, then send one about the loss of territory
   if ((count == 1) && (gNumberTrackedPlayerSettlements > 1))
   {
      aiCommsSendStatement(aiGetMostHatedPlayerID(), cAICommPromptEnemyLostSettlement, -1);
      gNumberTrackedPlayerSettlements=1;
   }

   //The count is = 0, and we think they have nothing left, and we have already sent a message
   if ((count == 0) && (gNumberTrackedPlayerSettlements != -1))
   {
      aiCommsSendStatement(aiGetMostHatedPlayerID(), cAICommPromptEnemyLostSettlement, -1);
      gNumberTrackedPlayerSettlements=-1;
   }
}

//==============================================================================
// RULE enemyWallTracker
//==============================================================================
rule enemyWallTracker
   minInterval 61
   active
{
   static int wallCountQueryID=-1;
   //Only the captain does this.
   if (aiGetCaptainPlayerID(cMyID) != cMyID)
      return;

   //If we don't have a query ID, create it.
   if (wallCountQueryID < 0)
   {
      wallCountQueryID=kbUnitQueryCreate("WallCount");
      //If we still don't have one, bail.
      if (wallCountQueryID < 0)
         return;
   }

   //Else, setup the query data.
   kbUnitQuerySetPlayerID(wallCountQueryID, aiGetMostHatedPlayerID());
   kbUnitQuerySetUnitType(wallCountQueryID, cUnitTypeAbstractWall);
   kbUnitQuerySetState(wallCountQueryID, cUnitStateAlive);

   //Reset the results.
   kbUnitQueryResetResults(wallCountQueryID);
   //Run the query.
   int count=kbUnitQueryExecute(wallCountQueryID);

   //Do we have enough knowledge of walls to send a message?
   if (count > 10)
   {
      aiCommsSendStatement(aiGetMostHatedPlayerID(), cAICommPromptPlayerBuildingWalls, -1);
      //Kill this rule.
      xsDisableSelf();
   }
}

//==============================================================================
// RULE baseAttackTracker
//==============================================================================
rule baseAttackTracker
   minInterval 23
   active
{
   static bool messageSent=false;
   //Set our min interval back to 23 if it has been changed.
   if (messageSent == true)
   {
      xsSetRuleMinIntervalSelf(23);
      messageSent=false;
   }

   //Get our main base.
   int mainBaseID=kbBaseGetMainID(cMyID);
   if (mainBaseID < 0)
      return;

   //Get the time under attack.
   int secondsUnderAttack=kbBaseGetTimeUnderAttack(cMyID, mainBaseID);
   if (secondsUnderAttack < 30)
         return;

   vector location=kbBaseGetLastKnownDamageLocation(cMyID, kbBaseGetMainID(cMyID));
   for (i=1; < cNumberPlayers)
   {
      if (i == cMyID)
         continue;
      if(kbIsPlayerAlly(i) == true)
         aiCommsSendStatementWithVector(i, cAICommPromptHelpHere, -1, location);
   }

   //Try to use a god power to help us.
   findTownDefenseGP(kbBaseGetMainID(cMyID));

   //Keep the books
   messageSent=true;
   xsSetRuleMinIntervalSelf(600);
}

//==============================================================================
// RULE repairBuildings
//==============================================================================
rule repairBuildings
   minInterval 12
   inactive
{
   int buildingID=kbFindBestBuildingToRepair(kbBaseGetLocation(cMyID, kbBaseGetMainID(cMyID)), 50.0, 1.0, cUnitTypeBuildingsThatShoot);
   if (buildingID >= 0)
   {
      //Don't create another plan for the same building.
      if (aiPlanGetIDByTypeAndVariableType(cPlanRepair, cRepairPlanTargetID, buildingID, true) >= 0)
         return;

      //Create the plan.
      static int num=0;
      num=num+1;
      string planName="Repair_"+num;
      int planID=aiPlanCreate(planName, cPlanRepair);
      if (planID < 0)
         return;

      aiPlanSetDesiredPriority(planID, 100);
      aiPlanSetBaseID(planID, kbBaseGetMainID(cMyID));
      aiPlanSetVariableInt(planID, cRepairPlanTargetID, 0, buildingID);
      aiPlanSetInitialPosition(planID, kbBaseGetLocation(cMyID, kbBaseGetMainID(cMyID)));
      aiPlanAddUnitType(planID, kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionBuilder, 0), 1, 1, 5);
      aiPlanSetActive(planID);
   }
}

//==============================================================================
// RULE townDefense
//==============================================================================
rule townDefense
   minInterval 11
   inactive
{
   //Get our main base ID.
   int mainBaseID=kbBaseGetMainID(cMyID);
   if (mainBaseID < 0)
      return;
   //Get the time under attack.
   int secondsUnderAttack=kbBaseGetTimeUnderAttack(cMyID, mainBaseID);

   //Factor in a dulled Moderate response for the rest of this.
   if (aiGetWorldDifficulty() == cDifficultyModerate)
   {
      if (secondsUnderAttack < 30)
         return;
   }
   else
   {
      if (secondsUnderAttack < 10)
         return;
   }

   //If the enemy has > 4 military units that we've seen and we've been attacked in our town,
   //tower up.
   if (gBuildTowers == false)
   {
      int numHatedUnits=kbUnitCount(aiGetMostHatedPlayerID(), cUnitTypeMilitary, cUnitStateAlive);
      if (numHatedUnits > 4)
      {
         aiEcho("townDefense:  Player "+aiGetMostHatedPlayerID()+" has "+numHatedUnits+" units, building towers.");
         gBuildTowers=true;
         towerInBase("Defensive Towers", false, 2, cMilitaryEscrowID);
         xsEnableRule("towerUpgrade");
      }
   }

   //If we've been under siege for long enough, see if we have enough stuff to
   //be worried.
   int numberEnemyUnits=kbBaseGetNumberUnits(cMyID, mainBaseID, cPlayerRelationEnemy, cUnitTypeUnit);
   int numberEnemyMilitaryBuildings=kbBaseGetNumberUnits(cMyID, mainBaseID, cPlayerRelationEnemy, cUnitTypeMilitaryBuilding);
   if ((numberEnemyUnits < 2) && (numberEnemyMilitaryBuildings <= 0))
      return;

   //We're worried.  If we're in the first age, ensure that we go up fast.  If
   //we're not in the first age, ensure that we have an attack goal setup for
   //the current age. If not, create one.
   switch (kbGetAge())
   {
      //First age.
      case 0:
      {
         //Go attack econ with minimal villagers.
         updateEM(50, 12, 0.5, 0.75, 0.5, 0.5, 0.5, 0.0);
         //Turn off the standard rule.
         xsDisableRule("updateEMAge1");
         break;
      }

      //Second age.
      case 1:
      {
         //Go attack econ with minimal villagers.
         updateEM(75, 22, 0.5, 0.75, 0.0, 0.0, 0.0, 0.0);
         //Turn off the standard rule.
         xsDisableRule("updateEMAge2");
         break;
      }

      //Don't do anything else in 3rd or 4th.
   }
}

//==============================================================================
// RULE fillInWallGaps
//==============================================================================
rule fillInWallGaps
   minInterval 31
   inactive
{
   //If we're not building walls, go away.
   if (gBuildWalls == false)
   {
      xsDisableSelf();
      return;
   }

   //If we already have a build wall plan, don't make another one.
   if(aiPlanGetIDByTypeAndVariableType(cPlanBuildWall, cBuildWallPlanWallType, cBuildWallPlanWallTypeRing, true) >= 0)
      return;

   int wallPlanID=aiPlanCreate("FillInWallGaps", cPlanBuildWall);
   if (wallPlanID != -1)
   {
      aiPlanSetVariableInt(wallPlanID, cBuildWallPlanWallType, 0, cBuildWallPlanWallTypeRing);
      aiPlanAddUnitType(wallPlanID, kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionBuilder, 0), 1, 3, 3);
      aiPlanSetVariableVector(wallPlanID, cBuildWallPlanWallRingCenterPoint, 0, kbBaseGetLocation(cMyID, kbBaseGetMainID(cMyID)));
      aiPlanSetVariableFloat(wallPlanID, cBuildWallPlanWallRingRadius, 0, 50.0);
      aiPlanSetVariableInt(wallPlanID, cBuildWallPlanNumberOfGates, 0, 5);
      aiPlanSetBaseID(wallPlanID, kbBaseGetMainID(cMyID));
      aiPlanSetEscrowID(wallPlanID, cEconomyEscrowID);
      aiPlanSetDesiredPriority(wallPlanID, 100);
      aiPlanSetActive(wallPlanID, true);
   }
}

//==============================================================================
// RULE findFish
//==============================================================================
rule findFish
   minInterval 11
   inactive
{
   //Create the fish query.
   static int unitQueryID=-1;
   if(unitQueryID < 0)
      unitQueryID = kbUnitQueryCreate("findFish");
   //Define a query to get all matching units
   if (unitQueryID == -1)
      return;

   //Run it.
   kbUnitQuerySetPlayerID(unitQueryID, 0);
   kbUnitQuerySetUnitType(unitQueryID, cUnitTypeFish);
   kbUnitQuerySetState(unitQueryID, cUnitStateAny);
   kbUnitQueryResetResults(unitQueryID);
   int numberFound=kbUnitQueryExecute(unitQueryID);
   if (numberFound > 0)
   {
      xsEnableRule("fishing");

      if (cMyCiv != cCivPoseidon)
         createSimpleMaintainPlan(gWaterScout, gMaintainNumberWaterScouts, true, -1);

      //Enable our naval attack goal starter.
      xsEnableRule("NavalGoalMonitor");

      //Fire up.
      if (gMaintainWaterXPortPlanID < 0)
         gMaintainWaterXPortPlanID=createSimpleMaintainPlan(kbTechTreeGetUnitIDTypeByFunctionIndex(cUnitFunctionWaterTransport, 0), 1, false, -1);

      xsDisableSelf();
   }
}

//==============================================================================
// RULE getKingOfTheHillVault
//==============================================================================
rule getKingOfTheHillVault
   minInterval 17
   runImmediately
   active
{
   //If we're not on KOTH, go away.
   if ((cRandomMapName != "king of the hill") || (gKOTHPlentyUnitID == -1))
   {
      xsDisableSelf();
      return;
   }

   //If we already have a attack goals, then quit.
   if (aiPlanGetIDByTypeAndVariableType(cPlanGoal, cGoalPlanGoalType, cGoalPlanGoalTypeAttack, true) >= 0)
      return;
   //If we already have a scout plan for this, bail.
   if (aiPlanGetIDByTypeAndVariableType(cPlanExplore, cExplorePlanNumberOfLoops, -1, true) >= 0)
      return;

   //Create an explore plan to go there.
   vector unitLocation=kbUnitGetPosition(gKOTHPlentyUnitID);
   int exploreID=aiPlanCreate("getPlenty", cPlanExplore);
   if (exploreID >= 0)
   {
      aiPlanAddUnitType(exploreID, cUnitTypeLogicalTypeLandMilitary, 5, 5, 5);
      aiPlanAddWaypoint(exploreID, unitLocation);
      aiPlanSetVariableBool(exploreID, cExplorePlanDoLoops, 0, false);
      aiPlanSetVariableBool(exploreID, cExplorePlanQuitWhenPointIsVisible, 0, true);
      aiPlanSetVariableBool(exploreID, cExplorePlanAvoidingAttackedAreas, 0, false);
      aiPlanSetVariableInt(exploreID, cExplorePlanNumberOfLoops, 0, -1);
      aiPlanSetRequiresAllNeedUnits(exploreID, true);
      aiPlanSetVariableVector(exploreID, cExplorePlanQuitWhenPointIsVisiblePt, 0, unitLocation);
      aiPlanSetDesiredPriority(exploreID, 100);
      aiPlanSetActive(exploreID);
   }
}

//==============================================================================
// RULE trainNorseMythUnit
//==============================================================================
rule trainNorseMythUnit
   minInterval 18
   inactive
{
   //Get the PUID of a myth unit that we can train right now.
   int puid=kbGetRandomEnabledPUID(cUnitTypeMythUnit, cMilitaryEscrowID);
   if (puid < 0)
      return;

   //Create the plan.
   string planName="Norse Train "+kbGetProtoUnitName(puid);
   int planID=aiPlanCreate(planName, cPlanTrain);
   if (planID < 0)
      return;
   //Military.
   aiPlanSetMilitary(planID, true);
   //Unit type.
   aiPlanSetVariableInt(planID, cTrainPlanUnitType, 0, puid);
   //Number.
   aiPlanSetVariableInt(planID, cTrainPlanNumberToTrain, 0, 1);
   //Train at main base.
   int mainBaseID=kbBaseGetMainID(cMyID);
   if (mainBaseID >= 0)
   {
      aiPlanSetBaseID(planID, mainBaseID);
      aiPlanSetVariableVector(planID, cTrainPlanGatherPoint, 0, kbBaseGetMilitaryGatherPoint(cMyID, mainBaseID));
   }

   aiPlanSetActive(planID);
}

//==============================================================================
// RULE increaseSiegeWeaponUP
//==============================================================================
rule increaseSiegeWeaponUP
   minInterval 21
   inactive
{
   //See how many walls our enemies have built.  Create our query if
   //we don't already have one.
   static int wallQID=-1;
   if (wallQID < 0)
   {
      wallQID=kbUnitQueryCreate("wallQuery");
      kbUnitQuerySetPlayerRelation(wallQID, cPlayerRelationEnemy);
      kbUnitQuerySetUnitType(wallQID, cUnitTypeAbstractWall);
      kbUnitQuerySetState(wallQID, cUnitStateAlive);
   }
   //Reset the results.
   kbUnitQueryResetResults(wallQID);

   //If we find a "lot" of walls, bump our siege weapon percentage and go away.
   int numberWalls=kbUnitQueryExecute(wallQID);
   if (numberWalls > 20)
   {
      kbUnitPickSetPreferenceFactor(gLateUPID, cUnitTypeAbstractSiegeWeapon, 1.0);
      kbUnitPickSetCostWeight(gLateUPID, 0.25);
      xsDisableSelf();
   }
}

//==============================================================================
// RULE NavalGoalMonitor
//==============================================================================
rule NavalGoalMonitor
   minInterval 13
   inactive
{
   //Don't do anything in the first age.
   if ((kbGetAge() < 1) || (aiGetMostHatedPlayerID() < 0))
      return;

   //See if we have any enemy warships running around.
   int numberEnemyWarships=0;
   //Find the largest warship count for any of our enemies.
   for (i=0; < cNumberPlayers)
   {
      if ((kbIsPlayerEnemy(i) == true) &&
         (kbIsPlayerResigned(i) == false) &&
         (kbHasPlayerLost(i) == false))
      {
         int tempNumberEnemyWarships=kbUnitCount(i, cUnitTypeLogicalTypeNavalMilitary, cUnitStateAlive);
         //int tempNumberEnemyDocks=kbUnitCount(i, cUnitTypeDock, cUnitStateAlive);
         if (tempNumberEnemyWarships > numberEnemyWarships)
            numberEnemyWarships=tempNumberEnemyWarships;
      }
   }
   //Figure out the min/max number of warships we want.
   int minShips=0;
   int maxShips=0;
   if (numberEnemyWarships > 0)
   {
      //Build at most 2 ships on easy.
      if (aiGetWorldDifficulty() == cDifficultyEasy)
      {
         minShips=1;
         maxShips=2;
      }
      //Build at most "6" ships on moderate.
      else if (aiGetWorldDifficulty() == cDifficultyModerate)
      {
         minShips=numberEnemyWarships/2;
         maxShips=numberEnemyWarships*3/4;
         if (minShips < 1)
            minShips=1;
         if (maxShips < 1)
            maxShips=1;
         if (minShips > 3)
            minShips=3;
         if (maxShips > 6)
            maxShips=6;
      }
      //Build the "same" number (within reason) on Hard/Titan.
      else
      {
         minShips=numberEnemyWarships*3/4;
         maxShips=numberEnemyWarships;
         if (minShips < 1)
            minShips=1;
         if (maxShips < 1)
            maxShips=1;
         if (minShips > 5)
            minShips=5;
         if (maxShips > 8)
            maxShips=8;
      }
   }

   //If this is enabled on KOTH, that means we have the water version.  Pretend the enemy
   //has lots of boats so that we will have lots, too.
   if (aiGetWaterMap()) {
      minShips=6;
      maxShips=12;
   }

   //If we already have a Naval UP, just set the numbers and be done.  If we don't
   //want anything, just set 1 since we've already done it before.
   if (gNavalUPID >= 0)
   {
      if (maxShips <= 0)
      {
         kbUnitPickSetMinimumNumberUnits(gNavalUPID, 1);
         kbUnitPickSetMaximumNumberUnits(gNavalUPID, 1);
      }
      else
      {
         kbUnitPickSetMinimumNumberUnits(gNavalUPID, minShips);
         kbUnitPickSetMaximumNumberUnits(gNavalUPID, maxShips);
      }
      return;
   }

   //Else, we don't have a Naval attack goal yet.  If we don't want any ships,
   //just return.
   if (maxShips <= 0)
      return;

   //Else, create the Naval attack goal.
   aiEcho("Creating NavalAttackGoal for "+maxShips+" ships since I've seen "+numberEnemyWarships+" for Player "+aiGetMostHatedPlayerID()+".");
   gNavalUPID=kbUnitPickCreate("Naval");
   if (gNavalUPID < 0)
   {
      xsDisableSelf();
      return;
   }
   //Fill in the UP.
   kbUnitPickResetAll(gNavalUPID);
   kbUnitPickSetPreferenceWeight(gNavalUPID, 1.0);
   kbUnitPickSetCombatEfficiencyWeight(gNavalUPID, 2.0);
   kbUnitPickSetCostWeight(gNavalUPID, 2.0);
   kbUnitPickSetDesiredNumberUnitTypes(gNavalUPID, 3, 2, true);
   kbUnitPickSetMinimumNumberUnits(gNavalUPID, minShips);
   kbUnitPickSetMaximumNumberUnits(gNavalUPID, maxShips);
   kbUnitPickSetAttackUnitType(gNavalUPID, cUnitTypeLogicalTypeNavalMilitary);
   kbUnitPickSetGoalCombatEfficiencyType(gNavalUPID, cUnitTypeLogicalTypeNavalMilitary);
   kbUnitPickSetPreferenceFactor(gNavalUPID, cUnitTypeLogicalTypeNavalMilitary, 1.0);
   kbUnitPickSetMovementType(gNavalUPID, cMovementTypeWater);
   //Create the attack goal.
   gNavalAttackGoalID=createSimpleAttackGoal("Naval Attack", -1, gNavalUPID, -1, kbGetAge(), -1, -1, false);
   if (gNavalAttackGoalID < 0)
   {
      xsDisableSelf();
      return;
   }
   aiPlanSetVariableBool(gNavalAttackGoalID, cGoalPlanAutoUpdateBase, 0, false);
   aiPlanSetVariableBool(gNavalAttackGoalID, cGoalPlanSetAreaGroups, 0, false);
}

//==============================================================================
// RULE getOmniscience
//==============================================================================
rule getOmniscience
   minInterval 24
   inactive
{
   //If we can afford it twice over, then get it.
   float goldCost=kbTechCostPerResource(cTechOmniscience, cResourceGold) * 2.0;
   float currentGold=kbResourceGet(cResourceGold);
   if(goldCost>currentGold)
      return;

   //Get Omniscience
   int voePID=aiPlanCreate("GetOmniscience", cPlanProgression);
   if (voePID != 0)
   {
      aiPlanSetVariableInt(voePID, cProgressionPlanGoalTechID, 0, cTechOmniscience);
      aiPlanSetDesiredPriority(voePID, 25);
      aiPlanSetEscrowID(voePID, cMilitaryEscrowID);
      aiPlanSetActive(voePID);
   }
   xsDisableSelf();
}

//==============================================================================
// RULE getOlympicParentage
//==============================================================================
rule getOlympicParentage
   minInterval 16
   active
{
   //If we're not Zeus, go away.
   if (cMyCiv != cCivZeus)
   {
      xsDisableSelf();
      return;
   }
   //Skip if in 1st or 2nd age.
   if (kbGetAge() < 2)
      return;
   //If in 3rd, make sure we have enough food.
   if (kbGetAge() == 2)
   {
      if(kbResourceGet(cResourceFood) < 600)
         return;
   }

   //Get Olympic Parentage.
   int opPID=aiPlanCreate("GetOlympicParentage", cPlanProgression);
   if (opPID != 0)
   {
      aiPlanSetVariableInt(opPID, cProgressionPlanGoalTechID, 0, cTechOlympicParentage);
      aiPlanSetDesiredPriority(opPID, 25);
      aiPlanSetEscrowID(opPID, cMilitaryEscrowID);
      aiPlanSetActive(opPID);
   }

   xsDisableSelf();
}

//==============================================================================
// MAIN.
//==============================================================================
void main(void)
{
   //Set our random seed.  "-1" is a random init.
   aiRandSetSeed(-1);

   //If we have the "defaultrandom" personality, pick one of the others and
   //stuff it.  We handle all of this here so that none of the rest of the script
   //is polluted by this stuff.
   if (aiGetPersonality() == "defaultrandom")
   {
      int personalityRand=aiRandInt(2);
      if (personalityRand == 0)
         aiSetPersonality("default");
      else
         aiSetPersonality("defaultrush");
   }

   //We always rush on KOTH.
   if ((cRandomMapName == "king of the hill") && (aiGetWorldDifficulty() != cDifficultyEasy))
      aiSetPersonality("defaultrush");

   //Go.
   init();
}
