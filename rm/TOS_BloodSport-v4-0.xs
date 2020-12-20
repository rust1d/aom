const string cES = "";
const int cWinter = 1;
const int cSpring = 2;
const int cSummer = 3;
const int cAutumn = 4;
const int cMordor = 5;

// GLOBALS ***************************************************
// WINTER|SPRING|SUMMER|FALL|MORDOR

int cSeason = 1;
float SeaLevel = 0;
int gNumPlayers = 0;
float gScale = 5;

float iifF(bool cond=true, float val1=0, float val2=0) {
   if (cond==true) return(val1);
   else return(val2);
}

// LIST
string listAdd(string list="", string item="", string delim="|") {
  if (xsStringLength(list)==0) return(item);
  return(list+delim+item);
}

string listGet(string list="", int at=1, string delim="|") {
  int end = xsStringLength(list) - 1;
  string item = cES;
  for (pos=0;<=end) {
    string chr = xsSubString(list, 1, pos);
    if (chr!=delim) item = item + chr;
    if (chr==delim || pos==end) {
      at--;
      if (at==0) return(item);
      item = cES;
    }
  }
  return(item);
}

int listLen(string list="", string delim="|") {
  int len = xsStringLength(list);
  int cnt = 1;
  for (pos=0;<len) if (xsSubString(list, 1, pos)==delim) cnt++;
  return(cnt);
}

string listSet(string list="", int at=1, string value="", string delim="|") {
  int end = xsStringLength(list) - 1;
  int lst = 0;
  string left = cES;
  string item = cES;
  for (pos=0;<=end) {
    string chr = xsSubString(list, 1, pos);
    if (chr!=delim) item = item + chr;
    if (chr==delim || pos==end) {
      if (lst>0) left = left + delim;
      lst++;
      at--;
      if (at==0) {
        left = left + value;
        if (end==pos) return(left);
        string right = xsSubString(list, end - pos, pos + 1);
        return(listAdd(left, right, delim));
      }
      left = left + item;
      item = cES;
    }
  }
  if (lst==0) at--;
  for (pos=0;<at) left = left + delim;
  return(left + value);
}

string listRandom(string list="", string delim="|") {
  int pos = rmRandInt(1, listLen(list, delim));
  return(listGet(list, pos, delim));
}

// INTEGER LIST
string intAdd(string list="", int value=0, string delim="#") {
  return(listAdd(list, cES + value, delim));
}

int intGet(string list="", int at=1, string delim="#") {
  return(xsStringToInt(listGet(list, at, delim)));
}

int intLen(string list="", string delim="#") {
  return(listLen(list, delim));
}

string intSet(string list="", int at=1, int value=0, string delim="#") {
  return(listSet(list, at, cES + value, delim));
}

string gSlots = "";
int getSlot(int p=1) { return(intGet(gSlots, p)); }
void setSlot(int p=1, int v=0) { gSlots = intSet(gSlots, p, v); }

// string gArmys = "";
// int getArmy(int p=1) { return(intGet(gArmys, p)); }
// void setArmy(int p=1, int v=0) { gArmys = intSet(gArmys, p, v); }

string RandomString(string s1="", string s2="", string s3="", string s4="", string s5="", string s6="") {
   int count = iifF(s1!="",1,0)+iifF(s2!="",1,0)+iifF(s3!="",1,0)+iifF(s4!="",1,0)+iifF(s5!="",1,0)+iifF(s6!="",1,0);
   int r = rmRandInt(1,count);
   if(r==1) {return(s1);} else if(r==2) {return(s2);} else if(r==3) {return(s3);} else if(r==4) {return(s4);} else if(r==5) {return(s5);} else {return(s6);}
}

/* MATH FUNCTIONS  ************************************/
float GetXPointOnCircle(float Angle=0, float Radius=0, float atX=.5) {
   float MyX = (Radius * xsCos(rmDegreesToRadians(Angle)) + atX); // FIND X AT CIRCLES EDGE
   MyX = iifF(MyX<0,0,MyX);
   MyX = iifF(MyX>1,1,MyX);
   return (MyX);
}

float GetZPointOnCircle(float Angle=0, float Radius=0, float atZ=.5) {
   float MyZ = (Radius * xsSin(rmDegreesToRadians(Angle)) + atZ); // FIND Z AT CIRCLES EDGE
   MyZ = iifF(MyZ<0,0,MyZ);
   MyZ = iifF(MyZ>1,1,MyZ);
   return (MyZ);
}

string GetSeaType(int pick=0) {
   if (pick==0) pick = cSeason;
   if (pick==0) pick = rmRandInt(1,5);
   string list = "Norse River|Watering Hole|Norwegian Sea|Greek River|Styx River";
   return(listGet(list, pick));
}

string GetLand(int pick=0) {
   if (pick==0) pick = cSeason;
   if (pick==0) pick = rmRandInt(1,5);
   if (pick==cWinter) return(listRandom("SnowA|SnowGrass50|SnowGrass25|CliffNorseB"));
   if (pick==cSpring) return(listRandom("SavannahB|SavannahC|SavannahD|SavannahA"));
   if (pick==cSummer) return(listRandom("GrassDirt25|CliffGreekB|GrassDirt50|GrassA"));
   if (pick==cAutumn) return(listRandom("CliffNorseB|SnowGrass50|SnowGrass25"));
   if (pick==cMordor) return(listRandom("UnderWaterRockA|HadesBuildable2|ForestFloorDeadPine"));
}

string GetCourt1Type(int pick=0) {
   if (pick==0) pick = cSeason;
   if (pick==0) pick = rmRandInt(1,5);
   if (pick==cWinter) return(listRandom("UnderWaterIceA|UnderWaterIceB"));
   if (pick==cSpring) return(listRandom("MiningGround|CliffEgyptianB"));
   if (pick==cSummer) return(listRandom("RiverGrassyC|CoralC"));
   if (pick==cAutumn) return(listRandom("UnderWaterRockD|UnderWaterRockE|UnderWaterRockF"));
   if (pick==cMordor) return(listRandom("Hades1|Hades8"));
}

string GetCourt2Type(int pick=0) {
   if (pick==0) pick = cSeason;
   if (pick==0) pick = rmRandInt(1,5);
   if (pick==cWinter) return(listRandom("ShoreLineAtlanticA|ShoreLineAtlanticB"));
   if (pick==cSpring) return(listRandom("SandA|SandB|RiverSandyShallowA"));
   if (pick==cSummer) return(listRandom("GrassA|GrassB"));
   if (pick==cAutumn) return(listRandom("UnderWaterRockB|UnderWaterRockC"));
   if (pick==cMordor) return(listRandom("HadesBuildable1|HadesBuildable2"));
}

string GetBlackType(int pick=0) {
   if (pick==0) pick = cSeason;
   if (pick==0) pick = rmRandInt(1,5);
   if (pick==cWinter) return("Hades6");
   if (pick==cSpring) return("Hades6");
   if (pick==cSummer) return("HadesCliff");
   if (pick==cAutumn) return("HadesCliff");
   if (pick==cMordor) return("Hades3");
}

string GetCliffType(int pick=0) {
   if (pick==0) pick = cSeason;
   if (pick==0) pick = rmRandInt(1,5);
   if (pick==cWinter) return("Norse");
   if (pick==cSpring) return("Egyptian");
   if (pick==cSummer) return("Greek");
   if (pick==cAutumn) return("Norse");
   if (pick==cMordor) return("Hades");
}

string GetCliffType2(int pick=0) {
   if (pick==0) pick = cSeason;
   if (pick==0) pick = rmRandInt(1,5);
   if (pick==cWinter) return("CliffNorseA");
   if (pick==cSpring) return("CliffEgyptianA");
   if (pick==cSummer) return("CliffGreekA");
   if (pick==cAutumn) return("CliffGreekB");
   if (pick==cMordor) return("HadesCliff");
}

string GetRoadType(int pick=0) {
   if (pick==0) pick = cSeason;
   if (pick==0) pick = rmRandInt(1,5);
   if (pick==cWinter) return(listRandom("NorseRoadA|UnderWaterRockC|ShorelineNorwegianC")); // WINTER
   if (pick==cSpring) return(listRandom("EgyptianRoadA|CityTileA|UnderWaterRockD|UnderWaterRockE|CoralE")); // SPRING
   if (pick==cSummer) return(listRandom("CityTileAtlantis|GreekRoadA|CityTileA|UnderWaterRockC"));
   if (pick==cAutumn) return(listRandom("GreekRoadA|UnderWaterRockB|UnderWaterRockE")); // FALL
   if (pick==cMordor) return(listRandom("UnderWaterRockD|CoralF|UnderWaterRockC")); // MORDOR
}

string randLava() {
  return(listRandom("Lava Bubbling|Lava Bubbling|Smoke Giant|Stalagmite|Stalagmite|Stalagmite"));
}

string randWaterPlant() {
  return(listRandom("Water Lilly|Seaweed|Papyrus"));
}

string randSnake() {
  return(listRandom("Sea Snake|Sea Snake|Sea Snake|Jormund Elver"));
}

string randWaterItem() {
  return(listRandom("Rotting Log|Grass|Bush|Crocodile|Water Reeds"));
}

string randGroundItem() {
  return(listRandom("Skeleton Giant|Rotting Log|Rock Symbols|RuneStone|Stalagmite|Skeleton"));
}

/* AREA FUNCTIONS  ************************************/
int CreateAreaAtXZ(string name="", float atX=.5, float atZ=.5, float WidthX=0, float HeightBlend=2, float Coherence=1, int ParentArea=-1) {
   int id = 0;
   if (ParentArea>-1) id = rmCreateArea(name, ParentArea);
   else id = rmCreateArea(name);
   rmSetAreaHeightBlend(id, HeightBlend);
   if (atX>-1 && atZ>-1) rmSetAreaLocation(id, atX, atZ);
   rmSetAreaSize(id, WidthX, WidthX);
   rmSetAreaCoherence(id,Coherence);
   return (id);
}

int DrawLine(string name="",float i=0,float j=0, float i2=0, float j2=0, float Area=0, int Height=0, string land="SnowA", int HeightBlend=2) {
   float atX = rmXMetersToFraction(i * gScale);
   float atZ = rmZMetersToFraction(j * gScale);
   float at2X = rmXMetersToFraction(i2 * gScale);
   float at2Z = rmZMetersToFraction(j2 * gScale);
   int id = CreateAreaAtXZ(name+"_"+i+"_"+j+"_"+i2+"_"+j2, atX, atZ, Area, HeightBlend, 1);
   rmAddAreaInfluenceSegment(id, atX, atZ, at2X, at2Z);
   rmSetAreaTerrainType(id, land);
   if (Height!=-1) rmSetAreaBaseHeight(id,Height);
   return (id);
}

int DrawWater(string name="",float i=0,float j=0, float i2=0, float j2=0, float Area=0, int Height=0, string WaterType="Savannah Water Hole", int HeightBlend=2) {
   float atX = rmXMetersToFraction(i * gScale);
   float atZ = rmZMetersToFraction(j * gScale);
   float at2X = rmXMetersToFraction(i2 * gScale);
   float at2Z = rmZMetersToFraction(j2 * gScale);
   int id = CreateAreaAtXZ(name+"_"+i+"_"+j+"_"+i2+"_"+j2, atX, atZ, Area, HeightBlend, 1);
   rmAddAreaInfluenceSegment(id, atX, atZ, at2X, at2Z);
   rmSetAreaWaterType(id, WaterType);
   if (Height!=-1) rmSetAreaBaseHeight(id,Height);
   //rmBuildArea(id);
   return (id);
}

int DrawCliff(string name="",float i=0,float j=0, float i2=0, float j2=0, float Area=0, int Height=0, string CliffType="Norse", int HeightBlend=2) {
   float atX = rmXMetersToFraction(i * gScale);
   float atZ = rmZMetersToFraction(j * gScale);
   float at2X = rmXMetersToFraction(i2 * gScale);
   float at2Z = rmZMetersToFraction(j2 * gScale);
   int id = CreateAreaAtXZ(name+"_"+i+"_"+j+"_"+i2+"_"+j2, atX, atZ, Area, HeightBlend, 1);
   rmAddAreaInfluenceSegment(id, atX, atZ, at2X, at2Z);
   rmSetAreaCliffType(id, CliffType);
   rmSetAreaCliffEdge(id, 1, 1, 0, 0, 0);
   rmSetAreaCliffPainting(id, true, true, true, 1.5, true);
   rmSetAreaCliffHeight(id, Height, 1.0, 1.0);
   return (id);
}

float mpct = 1.0;
void statusText() {
  rmSetStatusText("", mpct);
  mpct = mpct - 0.1;
}

float wiggle(float in=0, float min=0, float max=1) {
  return(in+rmRandFloat(min, max));
}

void main(void) {
  // ** CONSTANTS ************************************
  // set size
  int myTiles = 1200;
  int sizeX = 250;
  int sizeZ = 250;
  rmSetMapSize(sizeX, sizeZ);
  cSeason = 0; //rmRandInt(1, 5);
  float MyAtX = 0;
  float MyAtZ = 0;
  float MyInfX = 0;
  float MyInfZ = 0;
  float MyInf2X = 0;
  float MyInf2Z = 0;
  string RoadIs = "";
  RoadIs = GetRoadType();
  rmSetSeaLevel(SeaLevel);
  rmTerrainInitialize(GetBlackType(), SeaLevel);
  statusText();
  gNumPlayers = cNumberNonGaiaPlayers;
  if (gNumPlayers>6) gNumPlayers = 6;

  int id = 0;
  float moveout = .05;

  // COURT
  string sea = GetSeaType();
  string land = GetCourt1Type();
  string picks = land;
  for(i=15;<=35) DrawLine("Court1", 3, i, 15.0, i, rmXMetersToFraction(2.75), SeaLevel, land);
  land = GetCourt2Type();
  picks = listAdd(picks, land);
  for(i=15;<=35) DrawLine("Court2", 19, i, 31.0, i, rmXMetersToFraction(2.97), SeaLevel, land);
  land = GetCourt1Type(-1);
  picks = listAdd(land, picks);
  if (cSeason==cMordor) {
    for(i=15;<=35) DrawLine("Court3", 35.2, i, 47.0, i, rmXMetersToFraction(2.00), SeaLevel, land);
  } else {
    for(i=15;<=35) DrawWater("Court3", 35.5, i, 47.0, i, rmXMetersToFraction(2.00), -1, sea);
  }
  rmBuildAllAreas();
  // CHALK LINES
  for(i=0;<3) {
    land = listGet(picks, i+1);
    DrawLine("ChalkCourtT", 3+(i*16), 15, 15+(i*16), 15, rmXMetersToFraction(2.75), SeaLevel, land);
    DrawLine("ChalkCourtB", 3+(i*16), 35, 15+(i*16), 35, rmXMetersToFraction(2.75), SeaLevel, land);
    DrawLine("ChalkCourtL", 3+(i*16), 15, 3+(i*16), 35, rmXMetersToFraction(4.3), SeaLevel, land);
    DrawLine("ChalkCourtR", 15+(i*16), 15, 15+(i*16), 35, rmXMetersToFraction(4.3), SeaLevel, land);
  }
  rmBuildAllAreas();
  statusText();

  // PLAYER BASE
  land = GetRoadType();
  for(i=2;<=8) DrawLine("Slot1", 3, i, 11, i, rmXMetersToFraction(1.95), SeaLevel, land);
  land = GetRoadType();
  for(i=2;<=8) DrawLine("Slot2", 21, i, 29, i, rmXMetersToFraction(1.946), SeaLevel, land);
  land = GetRoadType();
  for(i=2;<=8) DrawLine("Slot3", 39, i, 47, i, rmXMetersToFraction(1.944), SeaLevel, land);
  land = GetRoadType();
  for(i=2;<=8) DrawLine("Slot4", 3, i+40, 11, i+40, rmXMetersToFraction(1.95), SeaLevel, land);
  land = GetRoadType();
  for(i=2;<=8) DrawLine("Slot5", 21, i+40, 29, i+40, rmXMetersToFraction(1.946), SeaLevel, land);
  land = GetRoadType();
  for(i=2;<=8) DrawLine("Slot6", 39, i+40, 47, i+40, rmXMetersToFraction(1.944), SeaLevel, land);
  rmBuildAllAreas();
  statusText();

  // COURT 1 - CENTER MOUND
  MyAtX = rmXMetersToFraction(45);
  MyAtZ = rmZMetersToFraction(122.5);
  id = CreateAreaAtXZ("F1Center", MyAtX, MyAtZ, rmXMetersToFraction(2), 1, 1);
  rmSetAreaTerrainType(id, GetCliffType2());
  rmSetAreaBaseHeight(id, SeaLevel+4);
  rmBuildAllAreas();
  // COURT 1 - 4 PILLARS
  DrawCliff("F1Post1", wiggle( 6.0), wiggle(21.5), wiggle( 6.0), wiggle(21.5), rmXMetersToFraction(wiggle(.25, .5, .75)), wiggle(SeaLevel, 4, 8), GetCliffType(), 1);
  DrawCliff("F1Post2", wiggle(11.0), wiggle(26.5), wiggle(11.0), wiggle(26.5), rmXMetersToFraction(wiggle(.25, .5, .75)), wiggle(SeaLevel, 4, 8), GetCliffType(), 1);
  DrawCliff("F1Post3", wiggle( 6.0), wiggle(26.5), wiggle( 6.0), wiggle(26.5), rmXMetersToFraction(wiggle(.25, .5, .75)), wiggle(SeaLevel, 4, 8), GetCliffType(), 1);
  DrawCliff("F1Post4", wiggle(11.0), wiggle(21.5), wiggle(11.0), wiggle(21.5), rmXMetersToFraction(wiggle(.25, .5, .75)), wiggle(SeaLevel, 4, 8), GetCliffType(), 1);
  //rmBuildAllAreas();

  id = CreateAreaAtXZ("F1Center2", MyAtX, MyAtZ, rmXMetersToFraction(.75), 1, 1);
  rmSetAreaTerrainType(id, GetLand());
  rmSetAreaBaseHeight(id, SeaLevel+4);
  rmBuildAllAreas();
  statusText();
  // COURT 1 - RAMPS BETWEEN PILLARS
  land = GetLand();
  DrawLine("F1Ramp1", 7, 22.5, 11, 26.5, rmXMetersToFraction(1), -1, land, 0);
  DrawLine("F1Ramp2", 7, 26.5, 11, 22.5, rmXMetersToFraction(1), -1, land, 0);
  rmBuildAllAreas();
  // COURT 1 - RAMPS UP TO MOUND
  land = GetRoadType();
  DrawLine("F1Ramp3", 9, 21, 9, 28, rmXMetersToFraction(1), -1, land, 0);
  DrawLine("F1Ramp4", 8, 24.5, 12, 24.5, rmXMetersToFraction(1), -1, land, 0);
  rmBuildAllAreas();
  statusText();


  // COURT 3 - UNWALKABLE CLIFF SIDES
  land = GetCliffType2();
  for(i=1;<4) {
    DrawLine("F3Ramp1", 38, 19+i*2, 38, (18+i*2), rmXMetersToFraction(.5), SeaLevel, land, 0);
    DrawLine("F3Ramp2", 44, 32-i*2, 44, 31-i*2, rmXMetersToFraction(.5), SeaLevel, land, 0);
  }
  rmBuildAllAreas();
  statusText();
  // COURT 3 - RAMP ROAD
  land = GetRoadType();
  for(i=0;<4) {
    DrawLine("F3Ramp3", 38, 19+i*2, 38, (18+i*2), rmXMetersToFraction(.2), SeaLevel+i*2, land, 0);
    DrawLine("F3Ramp4", 44, 32-i*2, 44, 31-i*2, rmXMetersToFraction(.2), SeaLevel+i*2, land, 0);
  }
  rmBuildAllAreas();
  statusText();

  for(i=0;<7) {
    MyAtX = rmXMetersToFraction(wiggle(41, -1, 1)) * gScale;
    MyAtZ = rmZMetersToFraction(wiggle(19+i*2, -1, 1)) * gScale;
    if (cSeason==5) {
        id = CreateAreaAtXZ("Divet"+i, MyAtX, MyAtZ, rmXMetersToFraction(rmRandFloat(.15, .30)), 0, 0);
        rmSetAreaTerrainType(id, "Hades7");
        rmBuildAllAreas();
        if (rmRandInt(1, 5)==1) {
          id = rmCreateObjectDef("bubble"+i);
          rmAddObjectDefItem(id, randLava(), 1, 0);
          rmSetObjectDefMinDistance(id, 1.0);
          rmSetObjectDefMaxDistance(id, 6.0);
          rmPlaceObjectDefAtLoc(id, 0, MyAtX, MyAtZ, 1);
        }
    } else {
        id = CreateAreaAtXZ("Divet"+i, MyAtX, MyAtZ, rmXMetersToFraction(rmRandFloat(.05, .10)), 1, 0);
        rmSetAreaBaseHeight(id, SeaLevel-3);
        rmBuildAllAreas();
        id = rmCreateObjectDef("plant1s"+i);
        rmAddObjectDefItem(id, randWaterPlant(), 1, 0);
        id = rmCreateObjectDef("plant2s"+i);
        rmAddObjectDefItem(id, randWaterPlant(), 1, 0);
        rmPlaceObjectDefAtLoc(id, 0, MyAtX, MyAtZ, 1);
        if (rmRandInt(1, 10)==1) {
          id = rmCreateObjectDef("snake"+i);
          rmAddObjectDefItem(id, randSnake(), 1, 0);
          rmPlaceObjectDefAtLoc(id, 0, MyAtX, MyAtZ, 1);
        }
        id = rmCreateObjectDef("stuff"+i);
        rmAddObjectDefItem(id, randWaterItem(), 1, 0);
        rmSetObjectDefMinDistance(id, 1.0);
        rmSetObjectDefMaxDistance(id, 4.0);
        rmPlaceObjectDefAtLoc(id, 0, MyAtX, MyAtZ, 1);
    }
  }
  statusText();

  if (cSeason==5) {
    for(i=0;<20) {
      id = rmCreateObjectDef("rock"+i);
      rmAddObjectDefItem(id, randGroundItem(), 1, 2.0);
      rmSetObjectDefMinDistance(id, 5.0);
      rmSetObjectDefMaxDistance(id, 15.0);
      rmPlaceObjectDefAtLoc(id, 0, .5, .5, 1);
    }
  }

  moveout = .085;
  land = GetCourt1Type();
  int angle = 0;
  for(i=1;<=4) {
    angle = (90 * (i-1));
    MyAtX = GetXPointOnCircle(angle, moveout, .5);
    MyAtZ = GetZPointOnCircle(angle, moveout, .5);
    angle = (90 * (i));
    MyInfX = GetXPointOnCircle(angle, moveout, .5);
    MyInfZ = GetZPointOnCircle(angle, moveout, .5);
    id = CreateAreaAtXZ("InnerDiamond"+i, MyAtX, MyAtZ, rmXMetersToFraction(1), 0.0, 1);
    rmSetAreaTerrainType(id, land);
    rmAddAreaInfluenceSegment(id, MyAtX, MyAtZ, MyInfX, MyInfZ);
    rmBuildArea(id);
  }
  statusText();

  // PLAYER OBJECTS
  int ThisPlayer = 0;
  for(i=0;<3) {
    for(j=0;<2) {
        ThisPlayer++;
        if (ThisPlayer<=gNumPlayers) {
          rmCreateArmy(ThisPlayer, "Army");
          int Bldg0Id = rmCreateObjectDef("Bldg0Id"+ThisPlayer);
          rmAddObjectDefItem(Bldg0Id, "Settlement Level 1", 1, 0.0);
          int Bldg1Id = rmCreateObjectDef("Bldg1Id"+ThisPlayer);
          rmAddObjectDefItem(Bldg1Id, "Temple", 1, 0.0);
          int Bldg2Id = rmCreateObjectDef("Bldg2Id"+ThisPlayer);
          rmAddObjectDefItem(Bldg2Id, "Market", 1, 0.0);
          int Bldg3Id = rmCreateObjectDef("Bldg3Id"+ThisPlayer);
          rmAddObjectDefItem(Bldg3Id, "Stable", 1, 0.0);
          int Bldg4Id = rmCreateObjectDef("Bldg4Id"+ThisPlayer);
          rmAddObjectDefItem(Bldg4Id, "Archery Range", 1, 0.0);
          int Bldg5Id = rmCreateObjectDef("Bldg5Id"+ThisPlayer);
          rmAddObjectDefItem(Bldg5Id, "Academy", 1, 0.0);
          int Bldg6Id = rmCreateObjectDef("Bldg6Id"+ThisPlayer);
          rmAddObjectDefItem(Bldg6Id, "Armory", 1, 0.0);
          int Bldg7Id = rmCreateObjectDef("Bldg7Id"+ThisPlayer);
          rmAddObjectDefItem(Bldg7Id, "Fortress", 1, 0.0);
          MyAtZ = rmXMetersToFraction(2.8+j*45) * gScale;
          MyAtX = rmXMetersToFraction(3.2+i*18.5) * gScale;
          rmPlaceObjectDefAtLoc(Bldg3Id, ThisPlayer, MyAtX, MyAtZ, 1);
          rmAddUnitsToArmy(ThisPlayer, rmCreateArmy(ThisPlayer, "Army3"), Bldg3Id);

          MyAtX = rmXMetersToFraction(6.4+i*18.5) * gScale;
          rmPlaceObjectDefAtLoc(Bldg7Id, ThisPlayer, MyAtX, MyAtZ, 1);
          rmAddUnitsToArmy(ThisPlayer, rmCreateArmy(ThisPlayer, "Army7"), Bldg7Id);

          MyAtX = rmXMetersToFraction(9.6+i*18.5) * gScale;
          rmPlaceObjectDefAtLoc(Bldg2Id, ThisPlayer, MyAtX, MyAtZ, 1);
          rmAddUnitsToArmy(ThisPlayer, rmCreateArmy(ThisPlayer, "Army2"), Bldg2Id);

          MyAtZ = rmXMetersToFraction(5.4+j*40) * gScale;
          MyAtX = rmXMetersToFraction(3.2+i*18.5) * gScale;
          rmPlaceObjectDefAtLoc(Bldg4Id, ThisPlayer, MyAtX, MyAtZ, 1);
          rmAddUnitsToArmy(ThisPlayer, rmCreateArmy(ThisPlayer, "Army4"), Bldg4Id);

          MyAtX = rmXMetersToFraction(6.4+i*18.5) * gScale;
          rmPlaceObjectDefAtLoc(Bldg0Id, ThisPlayer, MyAtX, MyAtZ, 1);
          rmAddUnitsToArmy(ThisPlayer, rmCreateArmy(ThisPlayer, "Army0"), Bldg0Id);

          MyAtX = rmXMetersToFraction(9.6+i*18.5) * gScale;
          rmPlaceObjectDefAtLoc(Bldg6Id, ThisPlayer, MyAtX, MyAtZ, 1);
          rmAddUnitsToArmy(ThisPlayer, rmCreateArmy(ThisPlayer, "Army6"), Bldg6Id);

          MyAtZ = rmXMetersToFraction(7.8+j*35) * gScale;
          MyAtX = rmXMetersToFraction(3.2+i*18.5) * gScale;
          rmPlaceObjectDefAtLoc(Bldg5Id, ThisPlayer, MyAtX, MyAtZ, 1);
          rmAddUnitsToArmy(ThisPlayer, rmCreateArmy(ThisPlayer, "Army5"), Bldg5Id);

          MyAtX = rmXMetersToFraction(9.6+i*18.5) * gScale;
          rmPlaceObjectDefAtLoc(Bldg1Id, ThisPlayer, MyAtX, MyAtZ, 1);
          rmAddUnitsToArmy(ThisPlayer, rmCreateArmy(ThisPlayer, "Army1"), Bldg1Id);
        }
    }
  }

  id = rmCreateObjectDef("Revealer");
  rmAddObjectDefItem(id, "Revealer", 1, 0.0);
  for(i=0;<=16) for(j=0;<=16) rmPlaceObjectDefAtLoc(id, 0, rmXMetersToFraction(i*15), rmXMetersToFraction(j*15), 1);
  statusText();

//  InjectXS();
  rmSetVCFile("bloodsport");
}