const float PI = 3.141592;
const string cES = "";
const int cWinter = 1;
const int cSpring = 2;
const int cSummer = 3;
const int cAutumn = 4;
const int cMordor = 5;

float gSeaLevel = 0;
int _uuid = 0;
int gSeason = 1;
string debug = "awesome";
string playersAt = "";
string pitchesAt = "";
string hexEdge = "";
string hexCenter = "";

float iifF(bool cond=true, float val1=0, float val2=0) {
  if (cond==true) return(val1); return(val2);
}

string iif(bool cond=true, string t="", string f="") {
  if (cond==true) return(t); return(f);
}

string uuid(string tag="") {
  _uuid++;
  return("UID" + tag + _uuid);
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

/* MATH FUNCTIONS  ************************************/
float GetXPointOnCircle(float angle=0, float radius=0, float ptX=.5) {
   float atX = (radius * xsCos(rmDegreesToRadians(angle)) + ptX); // FIND X AT CIRCLES EDGE
   atX = iifF(atX<0,0,atX);
   atX = iifF(atX>1,1,atX);
   return (atX);
}

float GetZPointOnCircle(float angle=0, float radius=0, float ptZ=.5) {
   float atZ = (radius * xsSin(rmDegreesToRadians(angle)) + ptZ); // FIND Z AT CIRCLES EDGE
   atZ = iifF(atZ<0,0,atZ);
   atZ = iifF(atZ>1,1,atZ);
   return (atZ);
}

string GetSeaType(int pick=0) {
   if (pick==0) pick = gSeason;
   if (pick==0) pick = rmRandInt(1,5);
   string list = "Norse River|savannah water hole|Norwegian Sea|Greek River|Styx River";
   return(listGet(list, pick));
}

string GetLand(int pick=0) {
   if (pick==0) pick = gSeason;
   if (pick==0) pick = rmRandInt(1,5);
   if (pick==cWinter) return(listRandom("SnowA|SnowGrass50|SnowGrass25|CliffNorseB"));
   if (pick==cSpring) return(listRandom("SavannahB|SavannahC|SavannahD|SavannahA"));
   if (pick==cSummer) return(listRandom("GrassDirt25|CliffGreekB|GrassDirt50|GrassA"));
   if (pick==cAutumn) return(listRandom("CliffNorseB|SnowGrass50|SnowGrass25"));
   if (pick==cMordor) return(listRandom("UnderWaterRockA|HadesBuildable2|ForestFloorDeadPine"));
}

string GetCourt1Type(int pick=0) {
   if (pick==0) pick = gSeason;
   if (pick==0) pick = rmRandInt(1,5);
   if (pick==cWinter) return(listRandom("UnderWaterIceA|UnderWaterIceB"));
   if (pick==cSpring) return(listRandom("MiningGround|CliffEgyptianB"));
   if (pick==cSummer) return(listRandom("RiverGrassyC|CoralC"));
   if (pick==cAutumn) return(listRandom("UnderWaterRockD|UnderWaterRockE|UnderWaterRockF"));
   if (pick==cMordor) return(listRandom("Hades1|Hades8"));
}

string GetCourt2Type(int pick=0) {
   if (pick==0) pick = gSeason;
   if (pick==0) pick = rmRandInt(1,5);
   if (pick==cWinter) return(listRandom("ShoreLineAtlanticA|ShoreLineAtlanticB"));
   if (pick==cSpring) return(listRandom("SandA|SandB|RiverSandyShallowA"));
   if (pick==cSummer) return(listRandom("GrassA|GrassB"));
   if (pick==cAutumn) return(listRandom("UnderWaterRockB|UnderWaterRockC"));
   if (pick==cMordor) return(listRandom("HadesBuildable1|HadesBuildable2"));
}

string GetBlackType(int pick=0) {
   if (pick==0) pick = gSeason;
   if (pick==0) pick = rmRandInt(1,5);
   if (pick==cWinter) return("Hades6");
   if (pick==cSpring) return("Dam");
   if (pick==cSummer) return("CliffPlainA");
   if (pick==cAutumn) return("HadesCliff");
   if (pick==cMordor) return(listRandom("Hades3|Hades4|Hades5|Hades7"));
}

string GetCliffType(int pick=0) {
   if (pick==0) pick = gSeason;
   if (pick==0) pick = rmRandInt(1,5);
   if (pick==cWinter) return("Norse");
   if (pick==cSpring) return("Egyptian");
   if (pick==cSummer) return("Greek");
   if (pick==cAutumn) return("Norse");
   if (pick==cMordor) return("Hades");
}

string GetCliffType2(int pick=0) {
   if (pick==0) pick = gSeason;
   if (pick==0) pick = rmRandInt(1,5);
   if (pick==cWinter) return("CliffNorseA");
   if (pick==cSpring) return("CliffEgyptianA");
   if (pick==cSummer) return("CliffGreekA");
   if (pick==cAutumn) return("CliffGreekB");
   if (pick==cMordor) return("HadesCliff");
}

string GetRoadType(int pick=0) {
   if (pick==0) pick = gSeason;
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

int areaCreateAt(float ptX=.5, float ptZ=.5, float area=0) {
  int id = rmCreateArea(uuid());
  rmSetAreaLocation(id, ptX, ptZ);
  rmSetAreaSize(id, area, area);
  return(id);
}

int areaCreateOnCircle(float ptX=0, float ptZ=0, float area=0, float angle=0, float radius=0) {
  float frX = GetXPointOnCircle(angle, radius, ptX);
  float frZ = GetZPointOnCircle(angle, radius, ptZ);
  return(areaCreateAt(frX, frZ, area));
}

int areaCreateOnCircleInf(float ptX=0, float ptZ=0, float area=0, float angle=0, float radius=0, float tangle=0, float tradius=0) {
  float frX = GetXPointOnCircle(angle, radius, ptX);
  float frZ = GetZPointOnCircle(angle, radius, ptZ);
  float toX = GetXPointOnCircle(tangle, tradius, ptX);
  float toZ = GetZPointOnCircle(tangle, tradius, ptZ);
  int id = areaCreateAt(frX, frZ, area);
  rmAddAreaInfluenceSegment(id, frX, frZ, toX, toZ);
  return(id);
}

void areaBlendCoherence(int id=0, int heightblend=2, float coherence=1) {
  rmSetAreaHeightBlend(id, heightblend);
  rmSetAreaCoherence(id, coherence);
}

void areaWaterBlendCoherence(int id=0, string type="", int heightblend=2, float coherence=1) {
  rmSetAreaWaterType(id, type);
  rmSetAreaHeightBlend(id, heightblend);
  rmSetAreaCoherence(id, coherence);
}

void areaLandBlendCoherence(int id=0, string type="", int heightblend=2, float coherence=1) {
  rmSetAreaTerrainType(id, type);
  rmSetAreaHeightBlend(id, heightblend);
  rmSetAreaCoherence(id, coherence);
}

void areaCliff(int id=0, string type="", int height=0, int heightblend=2, float coherence=1) {
  rmSetAreaCliffType(id, type);
  rmSetAreaCliffPainting(id, true, true, true, 3, true);
  rmSetAreaCliffHeight(id, height, 0.0, 0.5);
  rmSetAreaHeightBlend(id, heightblend);
  rmSetAreaCoherence(id, coherence);
}

float mpct = 1.0;
void statusText() {
  rmSetStatusText("", mpct);
  mpct = mpct - 0.1;
}

float wiggle(float in=0, float min=0, float max=1) {
  return(in+rmRandFloat(min, max));
}

string ptAt(float ptX=0, float ptZ=0) {
  int mX = rmXFractionToMeters(ptX) + 0.01;
  int mZ = rmZFractionToMeters(ptZ) + 0.01;
  return(cES+mX+"#"+mZ);
}

void houseAt(int p=0, int aid=0, string type="", float ptX=0, float ptZ=0) {
  int id = rmCreateObjectDef(uuid());
  rmAddObjectDefItem(id, type, 1, 0.0);
  rmPlaceObjectDefAtLoc(id, p, ptX, ptZ, 1);
  rmAddUnitsToArmy(p, aid, id);
}

void playerAt(int p=0, float ptX=0, float ptZ=0) {
  playersAt = listSet(playersAt, p, ptAt(ptX, ptZ));
  rmPlacePlayer(p, ptX, ptZ);
  int aid = rmCreateArmy(p, "Army");
  float radius = rmXTilesToFraction(12);
  string type = "house";
  for(j=1;<=8) {
    float angle = 360/8 * j;
    float atX = GetXPointOnCircle(angle, radius, ptX);
    float atZ = GetZPointOnCircle(angle, radius, ptZ);
    houseAt(p, aid, type, atX, atZ);
    if (j==7) type = "Settlement Level 1";
  }
}

int hexAt(float ptX=0, float ptZ=0, float radius=0, float rotate=0) {
  float area = radius * radius * PI;
  int id = areaCreateAt(ptX, ptZ, area);
  areaLandBlendCoherence(id, hexCenter, 0, 1);
  rmBuildArea(id);
  area = radius * radius/2;
  for(j=1;<=6) {
    float angle = (60 * j) + rotate;
    float tangle = angle + 60;
    int eid = areaCreateOnCircleInf(ptX, ptZ, area, angle, radius, tangle, radius);
    areaLandBlendCoherence(eid, hexEdge, 0, 1);
    rmBuildArea(eid);
  }
  return(id);
}

int pitchAt(float ptX=0, float ptZ=0, float radius=0) {
  pitchesAt = listAdd(pitchesAt, ptAt(ptX, ptZ));
  return(hexAt(ptX, ptZ, radius));
}

void postAt(float ptX=0, float ptZ=0, int aid=0) {
  int id = rmCreateObjectDef(uuid());
  rmAddObjectDefItem(id, "Outpost", 1, 0.0);
  rmPlaceObjectDefAtLoc(id, 0, ptX, ptZ, 1);
  rmAddUnitsToArmy(0, aid, id);
}

void pitch_icypeaks(float ptX=0, float ptZ=0, float radius=0) {
  hexCenter = "MiningGround";//GetLand(cWinter);
  hexEdge = GetLand(cWinter);
  string water = "Mediterranean Sea"; //GetSeaType(cSummer);
  string cliff = GetCliffType(cWinter);
  int aid = pitchAt(ptX, ptZ, radius);
  float cradius = radius * .5;
  float area = rmXMetersToFraction(1);
  for(i=1;<=12) {
    float angle = 360/12 * i;
    int id = areaCreateOnCircle(ptX, ptZ, area, angle, cradius);
    areaWaterBlendCoherence(id, water, 1, .75);
    rmBuildArea(id);
  }
  cradius = radius * .4;
  area = cradius * cradius * PI;
  int blend = 2; //rmRandInt(1,2);
  float sides = rmRandInt(2,3) * 2;
  float steps = 360 / sides;
  for(i=1;<=sides) {
    angle = i * steps;
    float height = 6;
    float fdist = cradius * rmRandFloat(1.1, 1.2);
    float tdist = fdist * .2;
    float size = area * rmRandFloat(0.15, 0.25);
    id = areaCreateOnCircleInf(ptX, ptZ, size, angle, fdist, angle, tdist);
    areaCliff(id, cliff, height, 2, 1);
    rmSetAreaCliffEdge(id, 1, 1, 0, 0, 2);
    rmBuildArea(id);
    size = size / 2;
    height = 3 + blend + rmRandInt(1, 2);
    id = areaCreateOnCircle(ptX, ptZ, size, angle, fdist);
    areaCliff(id, cliff, height, blend, 1);
    rmSetAreaCliffEdge(id, 1, 1, 0, 0, 2);
    rmBuildArea(id);
  }
  for(i=1;<=sides/2) {
    angle = i * steps;
    float tangle = angle + 180;
    size = area * 0.23 * rmRandFloat(1.0, 1.2);
    cradius = radius * .4 * rmRandFloat(1.0, 1.2);
    id = areaCreateOnCircleInf(ptX, ptZ, size, angle, cradius, tangle, cradius);
    areaLandBlendCoherence(id, hexCenter, 0, 1);
    rmBuildArea(id);
    angle = i * steps + steps/2;
    tangle = angle + 180;
    size = size * rmRandFloat(0.6, 1.1);
    id = areaCreateOnCircleInf(ptX, ptZ, size, angle, cradius, tangle, cradius);
    areaLandBlendCoherence(id, hexCenter, 0, 1);
    rmBuildArea(id);
  }
  size = area * rmRandFloat(.025, .035);
  id = areaCreateAt(ptX, ptZ, size);
  areaLandBlendCoherence(id, hexEdge, 1, .5);
  rmSetAreaBaseHeight(id, gSeaLevel);
  rmBuildArea(id);

  int oid = rmCreateObjectDef(uuid());
  rmAddObjectDefItem(oid, "rock river icy", 2, 2.0);
  rmAddObjectDefItem(oid, "rock granite small", 1, 5.0);
  rmAddObjectDefItem(oid, "rock limestone sprite", 3, 5.0);
  rmPlaceObjectDefInArea(oid, 0, aid, 5);
}

void pitch_oasis(float ptX=0, float ptZ=0, float radius=0) {
  hexCenter = listRandom("SandA|SandB|SandC|SandD");
  hexEdge = listRandom("RiverSandyA|RiverSandyB|RiverSandyC|RiverSandyShallowA");
  string water = "Watering Hole";
  int aid = pitchAt(ptX, ptZ, radius);
  for(j=1;<=6) {
    float angle = 60 * j;
    float tangle = angle + 60;
    float cradius = radius * .66;
    float tradius = cradius * rmRandFloat(0.7, 1.0);
    float area = cradius * cradius * rmRandFloat(0.9, 1.15);
    int id = areaCreateOnCircleInf(ptX, ptZ, area, angle, cradius, tangle, tradius);
    areaWaterBlendCoherence(id, water, 1, .5);
  }
  area = rmXTilesToFraction(1) * .5;
  id = areaCreateAt(ptX, ptZ, area);
  areaLandBlendCoherence(id, hexCenter, 1, .5);
  rmSetAreaBaseHeight(id, 4);
  rmBuildAllAreas();

  int oid = rmCreateObjectDef(uuid());
  rmAddObjectDefItem(oid, "Dust Devil", 2, 3.0);
  rmAddObjectDefItem(oid, "Sand Drift Patch", 1, 1.0);
  rmPlaceObjectDefAtLoc(oid, 0, ptX, ptZ, 1);
}

void pitch_cliffs(float ptX=0, float ptZ=0, float radius=0) {
  int pick = rmRandInt(1,3);
  hexCenter = listGet("CliffGreekB|CliffJungleB|CliffPlainB", pick);
  hexEdge = listRandom(listGet("GreekRoadA#GrassDirt25#GrassDirt50|JungleRoadA#JungleDirt25#JungleDirt50|PlainRoadA#PlainDirt25#PlainDirt50", pick), "#");
  string cliff = listRandom(listGet("Greek#Greek Rock|Jungle#Jungle Rock|Plain#Plain Rock", pick), "#");
  int aid = pitchAt(ptX, ptZ, radius);
  float area = radius * radius * PI * .35;
  int height = 5 + rmRandInt(1,3);
  int cliffs = xsMax(4, 0+cNumberTeams);
  float pct = 1.0/(cliffs+1);
  int id = areaCreateAt(ptX, ptZ, area);
  areaCliff(id, cliff, height, 1, 0);
  rmSetAreaCliffEdge(id, cliffs, pct, 0.1, .7, 0);
  rmSetAreaCliffPainting(id, false, true, true, 1.5, true);
  rmBuildArea(id);

  area = rmXMetersToFraction(1);
  id = areaCreateAt(ptX, ptZ, area);
  areaLandBlendCoherence(id, hexCenter, 0, 1);
  rmBuildArea(id);


  int oid = rmCreateObjectDef(uuid());
  rmAddObjectDefItem(oid, "Mist Olympus", 1, 1.0);
  rmPlaceObjectDefAtLoc(oid, 0, ptX, ptZ, 1);
  oid=rmCreateObjectDef(uuid());
  rmAddObjectDefItem(oid, "rock limestone small", 1, 1.0);
  rmAddObjectDefItem(oid, "rock limestone sprite", 3, 3.0);
  rmAddObjectDefItem(oid, "grass", 2, 3.0);
  rmPlaceObjectDefInArea(oid, 0, aid, 20);
}

void pitch_mystic(float ptX=0, float ptZ=0, float radius=0) {
  string options = "CoralA|CoralB|CoralC2|MarshC|UnderwaterIceB|UnderwaterIceC";
  hexEdge = listRandom(options);
  hexCenter = listRandom("CoralC|CoralD|CoralE|CoralF|CityTileWaterPool");
  string pit = listRandom(options);
  string bridge = listRandom(options);
  if (hexEdge==pit) hexEdge = "OlympusC";
  if (bridge==pit) bridge = "IceC";
  int aid = pitchAt(ptX, ptZ, radius);
  int dir = iifF(rmRandInt(1,3)==1, 1, -1);
  float cradius = radius * .55;
  float area = cradius * cradius * PI;
  int id = areaCreateAt(ptX, ptZ, area);
  areaLandBlendCoherence(id, pit, 3, 1);
  rmSetAreaBaseHeight(id, dir * 8);
  rmBuildArea(id);
  cradius = radius * .8;
  area = cradius * cradius * .5;
  int step = 360/3;
  for(j=1;<=3) {
    float angle = step * j;
    float tangle = angle + step;
    id = areaCreateOnCircleInf(ptX, ptZ, area, angle, cradius, tangle, cradius);
    areaLandBlendCoherence(id, bridge, 2, 1);
    rmSetAreaBaseHeight(id, dir * 2);
  }
  rmBuildAllAreas();
  int oid = rmCreateObjectDef(uuid());
  rmAddObjectDefItem(oid, "Vortex landing", 1, 0);
  rmPlaceObjectDefAtLoc(oid, 0, ptX, ptZ, 1);
}

void pitch_forest(float ptX=0, float ptZ=0, float radius=0) {
  int pick = rmRandInt(1,4);
  hexEdge = listGet("MarshC|SavannahB|RiverGrassyC|GrassA", pick);
  hexCenter = listGet("DirtC|SavannahA|SnowGrass75|GrassB", pick);
  string tree = listGet("Marsh Tree|Savannah Tree|Tundra Tree|Oak Tree", pick);
  string hill = listGet("MarshF|PlainDirt75|RiverIcyC|ShorelineJungleC", pick);
  string floor = listGet("ForestFloorMarsh|ForestFloorSavannah|ForestFloorTundra|ForestFloorOak", pick);
  int aid = pitchAt(ptX, ptZ, radius);
  float cradius = radius * .4;
  float area = cradius * cradius * PI;
  int id = areaCreateAt(ptX, ptZ, area);
  areaLandBlendCoherence(id, hill, 1, .25);
  rmSetAreaBaseHeight(id, pick);
  rmSetAreaMinBlobs(id, 1);
  rmSetAreaMaxBlobs(id, 8);
  rmSetAreaMinBlobDistance(id, 0.0);
  rmSetAreaMaxBlobDistance(id, rmXFractionToMeters(cradius));
  rmBuildArea(id);
  int tid = rmCreateObjectDef(uuid());
  rmAddObjectDefItem(tid, tree, 1, 1);
  float trees = cNumberPlayers * rmRandInt(10, 17);
  cradius = radius * .8;
  float steps = cradius / trees;
  area = rmXMetersToFraction(1) * .02;
  for(j=20;<=trees) {
    float angle = 13 * j;
    float tangle = angle + steps/2;
    float dist = steps * j;
    id = areaCreateOnCircleInf(ptX, ptZ, area, angle, dist, tangle, dist);
    areaLandBlendCoherence(id, floor, 1, .25);
    rmBuildArea(id);
    float frX = GetXPointOnCircle(angle, dist, ptX);
    float frZ = GetZPointOnCircle(angle, dist, ptZ);
    rmPlaceObjectDefAtLoc(tid, 0, frX, frZ, 1);
  }
  // int oid = rmCreateObjectDef(uuid());
  // rmAddObjectDefItem(oid, "rock granite small", 3, 3.0);
  // rmAddObjectDefItem(oid, "grass", 2, 3.0);
  // rmPlaceObjectDefInArea(oid, 0, aid, 15);
  // oid = rmCreateObjectDef(uuid());
  // rmAddObjectDefItem(oid, "rotting log", 1, 0.0);
  // rmPlaceObjectDefInArea(oid, 0, aid, 4);
}

void pitch_lava(float ptX=0, float ptZ=0, float radius=0) {
  hexEdge = listRandom("Hades1|Hades2|Hades8|Hades9|UnderWaterRockA|UnderWaterRockD|ForestFloorDeadPine");
  string land = listRandom("UnderWaterRockA|UnderWaterRockD|HadesBuildable1|HadesBuildable2");
  string lava = listRandom("Hades3|Hades4|Hades5|Hades7");
  hexCenter = lava;
  int aid = pitchAt(ptX, ptZ, radius);
  float area = radius * radius * PI * .55;
  int id = areaCreateAt(ptX, ptZ, area);
  areaLandBlendCoherence(id, land, 2, .25);
  rmSetAreaBaseHeight(id, 9);
  rmBuildArea(id);
  area = rmXMetersToFraction(1) * .2;
  float drips = rmRandInt(4,7);
  float step = 360/drips;
  for(j=1;<=drips) {
    float mod = rmRandFloat(.3, .4);
    float angle = step * j;
    float cradius = radius * mod;
    float tangle = angle + step * mod * iifF(rmRandInt(1,2)==1, 1, -1);
    float tradius = radius * .9;
    id = areaCreateOnCircleInf(ptX, ptZ, area, angle, cradius, tangle, tradius);
    areaLandBlendCoherence(id, lava, 0, 0);
    rmBuildArea(id);
  }
  area = radius * radius * PI * .05;
  id = areaCreateAt(ptX, ptZ, area);
  areaLandBlendCoherence(id, land, 0, 1);
  rmBuildArea(id);
  id = rmCreateObjectDef(uuid());
  rmAddObjectDefItem(id, "Hades Fire", 1, 1);
  step = 360/6;
  for(j=1;<=6) {
    angle = step * j;
    float frX = GetXPointOnCircle(angle, radius, ptX);
    float frZ = GetZPointOnCircle(angle, radius, ptZ);
    rmPlaceObjectDefAtLoc(id, 0, frX, frZ, 1);
  }
}

void pitch_flats(float ptX=0, float ptZ=0, float radius=0) {
  hexEdge = listRandom("Hades8|plainRoadA|EgyptianRoadA");
  hexCenter = listRandom("GaiaCreepA|GaiaCreepBorder|GrassA|GrassB|MarshD|MarshF");
  int aid = pitchAt(ptX, ptZ, radius);
  int oid = rmCreateObjectDef(uuid());
  rmAddObjectDefItem(oid, "Skeleton Giant", 1, 1);
  rmPlaceObjectDefInArea(oid, 0, aid, 50);
  oid = rmCreateObjectDef(uuid());
  rmAddObjectDefItem(oid, "Stalagmite", 1, 1);
  float cradius = radius * .9;
  float step = 360/12;
  float area = rmXMetersToFraction(1) * .04; // X on some
  for(j=1;<=12) {
    float angle = step * j;
    float frX = GetXPointOnCircle(angle, cradius, ptX);
    float frZ = GetZPointOnCircle(angle, cradius, ptZ);
    int id = areaCreateAt(frX, frZ, area);
    areaLandBlendCoherence(id, "OlympusC", 0, 1);
    rmBuildArea(id);
    rmPlaceObjectDefAtLoc(oid, 0, frX, frZ, 1);
  }
}

void main(void) {
  int sizeX = 375 + (cNumberNonGaiaPlayers-2) * 10;
  if (cNumberNonGaiaPlayers>3) sizeX = sizeX + 10;
  if (cNumberNonGaiaPlayers>4) sizeX = sizeX + 55;
  if (cNumberNonGaiaPlayers>6) sizeX = sizeX + 10;
  if (cNumberNonGaiaPlayers>7) sizeX = sizeX + 5;
  if (cNumberNonGaiaPlayers>10) sizeX = sizeX + 55;
  sizeX = sizeX + sizeX%2;
  debug = debug + " now = " + sizeX;
  rmSetMapSize(sizeX, sizeX);
  rmSetSeaLevel(0);
  rmTerrainInitialize(GetBlackType(), 0);
  statusText();
  gSeason = 0; //rmRandInt(1, 5);
  float ptX = 0;
  float ptZ = 0;
  float angle = 0;
  int id = 0;
  int aid = 0;
  float radius = 0;
  float offset = 0;

  // COURT
  string sea = GetSeaType();
  string land = GetCourt1Type();
  string road = GetRoadType();

  float radiusPitch = rmXTilesToFraction(20 + cNumberNonGaiaPlayers - 2);
  float radiusHome = rmXTilesToFraction(16);
  float spacer = rmXTilesToFraction(5);

  int rid = rmCreateObjectDef("Revealer");
  rmAddObjectDefItem(rid, "Revealer", 1, 0.0);

  // BATTLE PITCHES
  int paid = rmCreateArmy(0, "Centers");

  hexEdge = GetLand();
  hexCenter = GetRoadType();

  pitch_flats(.5, .5, radiusPitch);
  postAt(.5, .5, paid);
  radius = (radiusPitch+spacer) * 2;
  for(i=1;<=6) {
    angle = (60 * i) + 60/2;
    ptX = GetXPointOnCircle(angle, radius, .5);
    ptZ = GetZPointOnCircle(angle, radius, .5);

    if (i==1) pitch_icypeaks(ptX, ptZ, radiusPitch);
    else if (i==2) pitch_oasis(ptX, ptZ, radiusPitch);
    else if (i==3) pitch_cliffs(ptX, ptZ, radiusPitch);
    else if (i==4) pitch_mystic(ptX, ptZ, radiusPitch);
    else if (i==5) pitch_forest(ptX, ptZ, radiusPitch);
    else if (i==6) pitch_lava(ptX, ptZ, radiusPitch);
    else {
      pitch_flats(ptX, ptZ, radiusPitch);
    }
    postAt(ptX, ptZ, paid);
  }

  // PLAYERS
  radius = 82 + (cNumberNonGaiaPlayers - 2) * 2.5;
  radius = rmXTilesToFraction(radius);
  int tick = 1;
  offset = 60;
  for(i=1;<=2) {
    for (j=1;<=3) {
      if (tick>cNumberNonGaiaPlayers) continue;
      hexEdge = GetLand();
      hexCenter = GetRoadType();
      angle = (60 * tick) + offset;
      for (k=1;<=2) {
        ptX = GetXPointOnCircle(angle, radius, .5);
        ptZ = GetZPointOnCircle(angle, radius, .5);
        id = hexAt(ptX, ptZ, radiusHome, offset * 2);
        if (tick<=cNumberNonGaiaPlayers) {
          rmSetPlayerArea(tick, id);
          playerAt(tick, ptX, ptZ);
          postAt(ptX, ptZ, paid);
        }
        tick = tick + 1;
        angle = angle + 180;
      }
    }
    offset = 150;
    radius = radiusPitch*3 + spacer*4 + radiusHome;
  }

  statusText();

  int oid = rmCreateObjectDef(uuid());
  rmAddObjectDefItem(oid, "Slinger", 3, 2);
  rmAddObjectDefItem(oid, "Skraeling", 2, 2);
  rmAddObjectDefItem(oid, "Raiding Cavalry", 1, 2);
  rmPlaceObjectDefPerPlayer(oid, true);

//  InjectXS();

  rmCreateTrigger("egg");
  rmSwitchToTrigger(rmTriggerID("egg"));
  rmAddTriggerEffect("Send Spoofed Chat");
  rmSetTriggerEffectParam("Message", debug, false);
  rmSetTriggerEffectParamInt("PlayerID", 1, false);

  rmSetVCFile("vc_work");
}