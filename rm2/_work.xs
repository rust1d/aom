string names() {
  string data = "";
  int max = (127 - cNumberPlayers) / cNumberPlayers;
  for (i=1;<=cNumberPlayers) {
    data = data + xsSubString(rmGetPlayerName(i), max) + "|";
  }
  return(data);
}

void xs(string code="") {
  rmAddTriggerEffect("SetIdleProcessing");
  rmSetTriggerEffectParam("IdleProc",");*/"+code+"/*");
}

void InjectXS() {
  int id = rmCreateTrigger("tosInject");
  rmSwitchToTrigger(id);
  rmSetTriggerActive(false);
  rmAddTriggerEffect("SetIdleProcessing");
  rmSetTriggerEffectParam("IdleProc",");}}/*");
  xs("string gPlayers = \"" + names() + "\";");
  xs("int cMapSize = "+cMapSize+";");

  rmAddTriggerEffect("SetIdleProcessing");
  rmSetTriggerEffectParam("IdleProc",");*/rule _tosInjectEnd inactive { if (true) { //");
}


const float PI = 3.141592;
const string cES = "";

float gSeaLevel = 0;
int _uuid = 0;
string debug = "";
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
float circleAtX(float angle=0, float radius=0, float ptX=.5) {
   float atX = (radius * xsCos(rmDegreesToRadians(angle)) + ptX); // FIND X AT CIRCLES EDGE
   atX = iifF(atX<0,0,atX);
   atX = iifF(atX>1,1,atX);
   return (atX);
}

float circleAtZ(float angle=0, float radius=0, float ptZ=.5) {
   float atZ = (radius * xsSin(rmDegreesToRadians(angle)) + ptZ); // FIND Z AT CIRCLES EDGE
   atZ = iifF(atZ<0,0,atZ);
   atZ = iifF(atZ>1,1,atZ);
   return (atZ);
}

string GetEdge(int pick=0) {
  if (pick==0) pick = rmRandInt(1,4);
  if (pick%4==1) return(listRandom("ForestFloorPalm|DirtA|SandDirt50|SandDirt50b|SavannahC|SavannahD|UnderwaterRockF"));
  if (pick%4==2) return(listRandom("GaiaCreepB|MarshA|MarshB|MarshE|RiverMarshA|RiverMarshB|RiverMarshC|JungleA|JungleB|PlainA|PlainB"));
  if (pick%4==3) return(listRandom("TundraRockA|TundraRockB|DirtB|ForestFloorPine|GrassDirt75|JungleDirt75"));
  return(listRandom("SnowA|SnowB|SnowGrass25|SnowSand25|ForestFloorPineSnow"));
}

string GetBlackType(int pick=0) {
   return(listRandom("Hades6|Dam|HadesCliff|Hades3"));
}

string GetCenter(int pick=0) {
  if (pick==0) pick = rmRandInt(1,3);
  if (pick%3==1) return(listRandom("CityTileA|NorseRoadA|CityTileAtlantis|EgyptianRoadA|GreekRoadA"));
  if (pick%3==1) return(listRandom("CoralE|CoralF|UnderwaterRockB|UnderwaterRockC|UnderwaterRockD|UnderwaterRockE"));
  return(listRandom("RiverIcyA|RiverIcyB|RiverGrassyA|RiverGrassyB"));
}

/* AREA FUNCTIONS  ************************************/

int areaCreateAt(float ptX=.5, float ptZ=.5, float area=0) {
  int id = rmCreateArea(uuid());
  rmSetAreaLocation(id, ptX, ptZ);
  rmSetAreaSize(id, area, area);
  return(id);
}

int areaCreateOnCircle(float ptX=0, float ptZ=0, float area=0, float angle=0, float radius=0) {
  float frX = circleAtX(angle, radius, ptX);
  float frZ = circleAtZ(angle, radius, ptZ);
  return(areaCreateAt(frX, frZ, area));
}

int areaCreateOnCircleInf(float ptX=0, float ptZ=0, float area=0, float angle=0, float radius=0, float tangle=0, float tradius=0) {
  float frX = circleAtX(angle, radius, ptX);
  float frZ = circleAtZ(angle, radius, ptZ);
  float toX = circleAtX(tangle, tradius, ptX);
  float toZ = circleAtZ(tangle, tradius, ptZ);
  int id = areaCreateAt(frX, frZ, area);
  rmAddAreaInfluenceSegment(id, frX, frZ, toX, toZ);
  return(id);
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
  rmPlacePlayer(p, ptX, ptZ);
  int aid = rmCreateArmy(p, "Army");
  float radius = rmXTilesToFraction(12);
  string type = "house";
  for(j=1;<=8) {
    float angle = 360/8 * j;
    float atX = circleAtX(angle, radius, ptX);
    float atZ = circleAtZ(angle, radius, ptZ);
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

void postAt(float ptX=0, float ptZ=0, int aid=0) {
  int id = rmCreateObjectDef(uuid());
  rmAddObjectDefItem(id, "Outpost", 1, 0.0);
  rmPlaceObjectDefAtLoc(id, 0, ptX, ptZ, 1);
  rmAddUnitsToArmy(0, aid, id);
}

void pitch_spires(float ptX=0, float ptZ=0, float radius=0) {
  int pick = rmRandInt(1, 6);
  hexCenter = listGet("TundraRoadA|PlainRoadA|GreekRoadA|EgyptianRoadA|NorseRoadA|JungleRoadA", pick);
  hexEdge = listGet("ShorelineTundra|ShorelinePlain|ShorelineMediterranean|ShorelineRedSea|ShorelineNorwegian|ShorelineJungle", pick);
  int edge = rmRandInt(1, iifF(pick<=3, 4, 3));
  hexEdge = hexEdge + listGet("A|B|C|D", rmRandInt(1, iifF(pick<=3, 4, 3))); // FIRST 3 SHORELINES HAVE A "D" OPTION
  string seas = "Norwegian Sea|Yellow Sea|Aegean Sea|Red Sea|North Atlantic Ocean|South Sea";
  string oceans = "Tundra Pool|Yellow River|Greek River|Egyptian Nile|Norse River|Savannah Water Hole";
  string water = listGet(iif(rmRandInt(1,2)==1, seas, oceans), pick);
  string cliff = listGet("CliffGreekB|CliffPlainA|CliffGreekA|CliffEgyptianA|CliffNorseA|CliffJungleA", pick);
  int aid = hexAt(ptX, ptZ, radius);
  float blob = radius * radius * PI * 0.066;
  float sides = rmRandInt(2,3) * 2;
  float area = blob * 8 / sides;
  float steps = 360 / sides;
  float cradius = radius * .5;
  for(i=1;<=sides) {
    float angle = i * steps + steps/2;
    int id = areaCreateOnCircle(ptX, ptZ, area, angle, cradius);
    areaWaterBlendCoherence(id, water, 0, .5);
    rmBuildArea(id);
  }
  area = blob * 12 / sides;
  for(i=1;<=sides/2) {
    angle = i * steps;
    float tangle = angle + 180;
    id = areaCreateOnCircleInf(ptX, ptZ, area, angle, cradius, tangle, cradius);
    areaLandBlendCoherence(id, cliff, 1, 1);
    rmSetAreaBaseHeight(id, 2);
    rmBuildArea(id);
  }
  area = blob * 2 / sides;
  float height = 32 / sides;
  for(i=1;<=sides) {
    angle = i * steps;
    id = areaCreateOnCircleInf(ptX, ptZ, area, angle, radius*.55, angle, radius*.48);
    areaLandBlendCoherence(id, cliff, 1, 1);
    rmSetAreaBaseHeight(id, height);
    rmBuildArea(id);
    id = areaCreateOnCircleInf(ptX, ptZ, area*.5, angle, radius*.28, angle, radius*.14);
    areaLandBlendCoherence(id, cliff, 1, 1);
    rmSetAreaBaseHeight(id, height-2);
    rmBuildArea(id);
  }
  area = blob;
  for(i=1;<=sides/2) {
    angle = i * steps;
    tangle = angle + 180;
    cradius = radius * rmRandFloat(.5,.6);
    id = areaCreateOnCircleInf(ptX, ptZ, area, angle, cradius, tangle, cradius);
    areaLandBlendCoherence(id, hexCenter, 0, 1);
    rmBuildArea(id);
    angle = i * steps + steps/2;
    tangle = angle + 180;
    area = area * .75;
    cradius = cradius * .75;
    id = areaCreateOnCircleInf(ptX, ptZ, area, angle, cradius, tangle, cradius);
    areaLandBlendCoherence(id, hexCenter, 2, 1);
    rmSetAreaBaseHeight(id, 1);
    rmBuildArea(id);
  }
  area = blob * .1;
  id = areaCreateAt(ptX, ptZ, area);
  areaLandBlendCoherence(id, hexEdge, 1, .5);
  rmSetAreaBaseHeight(id, gSeaLevel);
  rmBuildArea(id);
}

void pitch_oasis(float ptX=0, float ptZ=0, float radius=0) {
  hexCenter = listRandom("SandA|SandB|SandC|SandD");
  hexEdge = listRandom("RiverSandyA|RiverSandyB|RiverSandyC|RiverSandyShallowA");
  string water = "Watering Hole";
  int aid = hexAt(ptX, ptZ, radius);
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
  int aid = hexAt(ptX, ptZ, radius);
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
  hexCenter = listRandom("CoralC|CoralD|CoralE|CoralF");
  string pit = listRandom(options);
  string bridge = listRandom(options);
  if (hexEdge==pit) hexEdge = "OlympusC";
  if (bridge==pit) bridge = "IceC";
  int aid = hexAt(ptX, ptZ, radius);
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
  int aid = hexAt(ptX, ptZ, radius);
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
  rmAddObjectDefItem(tid, tree, 1, 0);
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
    float frX = circleAtX(angle, dist, ptX);
    float frZ = circleAtZ(angle, dist, ptZ);
    rmPlaceObjectDefAtLoc(tid, 0, frX, frZ, 1);
  }
}

void pitch_lava(float ptX=0, float ptZ=0, float radius=0) {
  hexEdge = listRandom("Hades1|Hades2|Hades8|Hades9|UnderwaterRockA|UnderwaterRockD|ForestFloorDeadPine");
  string land = listRandom("UnderwaterRockA|UnderwaterRockD|HadesBuildable1|HadesBuildable2");
  string lava = listRandom("Hades3|Hades4|Hades5|Hades7");
  hexCenter = lava;
  int aid = hexAt(ptX, ptZ, radius);
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
  rmAddObjectDefItem(id, "Hades Fire", 1, 0);
  step = 360/6;
  for(j=1;<=6) {
    angle = step * j;
    float frX = circleAtX(angle, radius, ptX);
    float frZ = circleAtZ(angle, radius, ptZ);
    rmPlaceObjectDefAtLoc(id, 0, frX, frZ, 1);
  }
}

void pitch_flats(float ptX=0, float ptZ=0, float radius=0) {
  hexEdge = listRandom("Hades8|plainRoadA|EgyptianRoadA");
  hexCenter = listRandom("GaiaCreepA|GaiaCreepBorder|GrassA|GrassB|MarshD|MarshF");
  int aid = hexAt(ptX, ptZ, radius);
  int oid = rmCreateObjectDef(uuid());
  rmAddObjectDefItem(oid, "Skeleton Giant", 1, 1);
  rmPlaceObjectDefInArea(oid, 0, aid, 50);
  oid = rmCreateObjectDef(uuid());
  rmAddObjectDefItem(oid, "Stalagmite", 1, 0);
  float cradius = radius * .9;
  float step = 360/12;
  float area = rmXMetersToFraction(1) * .04;
  for(j=1;<=12) {
    float angle = step * j;
    float frX = circleAtX(angle, cradius, ptX);
    float frZ = circleAtZ(angle, cradius, ptZ);
    int id = areaCreateAt(frX, frZ, area);
    areaLandBlendCoherence(id, "OlympusC", 0, 1);
    rmBuildArea(id);
    rmPlaceObjectDefAtLoc(oid, 0, frX, frZ, 1);
  }
}

void main(void) {
  int growth = cNumberNonGaiaPlayers - 2 + cNumberNonGaiaPlayers%2;
  int sizeX = 383 + growth * 10;
  if (cNumberNonGaiaPlayers>4) sizeX = sizeX + 60;
  if (cNumberNonGaiaPlayers>6) sizeX = sizeX + 15;
  if (cNumberNonGaiaPlayers>10) sizeX = sizeX + 60;
  sizeX = sizeX + sizeX%2;
  rmSetMapSize(sizeX, sizeX);
  rmSetSeaLevel(0);
  rmTerrainInitialize(GetBlackType(), 0);
  float radiusPitch = rmXTilesToFraction(20 + growth);
  float radiusHome = rmXTilesToFraction(16);
  float spacer = rmXTilesToFraction(5);
  int paid = rmCreateArmy(0, "Centers");
  float radius = (radiusPitch+spacer) * 2;
  pitch_flats(.5, .5, radiusPitch);
  postAt(.5, .5, paid);
  for(i=1;<=6) {
    float angle = (60 * i) + 60/2;
    float ptX = circleAtX(angle, radius, .5);
    float ptZ = circleAtZ(angle, radius, .5);
    if (i==1) pitch_spires(ptX, ptZ, radiusPitch);
    else if (i==2) pitch_cliffs(ptX, ptZ, radiusPitch);
    else if (i==3) pitch_oasis(ptX, ptZ, radiusPitch);
    else if (i==4) pitch_lava(ptX, ptZ, radiusPitch);
    else if (i==5) pitch_forest(ptX, ptZ, radiusPitch);
    else if (i==6) pitch_mystic(ptX, ptZ, radiusPitch);
    postAt(ptX, ptZ, paid);
  }
  // PLAYERS
  radius = 90 + growth * 2.5;
  radius = rmXTilesToFraction(radius);
  int tick = 1;
  float offset = 60;
  for(i=1;<=2) {
    for (j=1;<=3) {
      if (tick>cNumberNonGaiaPlayers) continue;
      hexEdge = GetEdge(tick);
      hexCenter = GetCenter(tick);
      angle = (60 * tick) + offset;
      for (k=1;<=2) {
        ptX = circleAtX(angle, radius, .5);
        ptZ = circleAtZ(angle, radius, .5);
        int id = hexAt(ptX, ptZ, radiusHome, offset * 2);
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
    radius = radiusPitch*3 + spacer*6 + radiusHome;
  }
  int oid = rmCreateObjectDef(uuid());
  rmAddObjectDefItem(oid, "Slinger", 3, 2);
  rmAddObjectDefItem(oid, "Skraeling", 2, 2);
  rmAddObjectDefItem(oid, "Raiding Cavalry", 1, 2);
  rmPlaceObjectDefPerPlayer(oid, true);

 InjectXS();

  // rmCreateTrigger("egg");
  // rmSwitchToTrigger(rmTriggerID("egg"));
  // rmAddTriggerEffect("Send Spoofed Chat");
  // rmSetTriggerEffectParam("Message", debug, false);
  // rmSetTriggerEffectParamInt("PlayerID", 1, false);
   rmSetVCFile("vc_work");
}
