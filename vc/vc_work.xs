int cMapSize = 1;
string gPlayers = "TwentyOneScore|Too|Free|Four|Jive|Six|Devon|Aight|Nein|Tent||Leven|Twelf";

float gArenaRadius = 0;
float gPlayerRadius = 30;
float gMinTeamCnt = 1.0;
int gArena = 0;
int gBattleSong = 1;
int gBuildEnds = 0;
int gBuildSong = 1;
int gBuildTime = 15;
int gFavInc = 5;
int gFavRound = 50;
int gFavStart = 50;
int gGameWins = 7;
int gInstr = 1;
int gNumberTeams = 2;
int gRelicID = 0;
int gRelicTech = 0;
int gResInc = 50;
int gResRound = 1200;
int gResStart = 1200;
int gRound = 0;
string gActiveBIDs = "";
string gArenaBIDs = "";
string gArenaXZ = "";
string gArenasInit = "";
string gMsg = "";
string gPlayerBIDs = "";
string gPlayerXZ = "";

const int cCivDataGodPowers = 0;
const int cCivDataBuildings = 1;
const float PI = 3.141592;

const int cCultureGreek = 0;
const int cCultureEgyptian = 1;
const int cCultureNorse = 2;
const int cCultureAtlantean = 3;
const int cCultureChinese = 4;
const int cCivThor = 7;
const int cMovementTypeAir = 4;
const int cAge1 = 0;
const int cAge2 = 1;
const int cAge3 = 2;
const int cAge4 = 3;
const int cAge5 = 4;
const int cTechAge3Aphrodite = 97;
const int cTechAge4Artemis = 99;
const int cTechOdinsFirstRavens = 335;
const int cTechOdinsRavenRespawn = 171;
const int cTechStartingUnitsAtlantean = 394;
const int cTechStartingUnitsEgyptian = 145;
const int cTechStartingUnitsGreek = 144;
const int cTechStartingUnitsNorse = 143;
const int cTechStartingUnitsThor = 379;
const int cTechSecretsoftheTitans = 443;
const int cTechStartingUnitsChinese = 510;
const int cTechPharaohRespawn = 142;
const int cTechSetAge1Critter = 380;

const int cTechStatusUnobtainable = 0;
const int cTechStatusObtainable = 1;
const int cTechStatusAvailable = 2;
const int cTechStatusActive = 4;

const int cUnitStatHP = 0;
const int cUnitStatLOS = 2;

const int cUnitTypeMilitary = 951;
const int cUnitTypeUnit = 935;
const int cUnitTypeBuilding = 937;

const int cUnitStateAlive = 2;
const int cUnitStateBuilding = 1;
const int cUnitStateAny = 255;

const int cUnitTypeRevealer = 14;
const int cUnitTypeRevealerPlayer = 100;
const int cUnitTypeRelic = 559;
const int cUnitTypeTartarianGate = 737;
const int cUnitTypeBerryBush = 526;
const int cUnitTypeJadeMineTiny = 871;
const int cUnitTypeInfernoFlame = 99;
const int cUnitTypeCinematicBlock = 52;

const int cTechRelicEyeofHorus = 194;
const int cTechRelicNoseoftheSphinx = 205;
const int cTechRelicPeltofArgus = 369;
const int cTechRelicBowofArtemis = 203;
const int cTechRelicWedjatEye = 204;
const int cTechRelicToothedArrows = 209;
const int cTechRelicWandofGambantein = 210;
const int cTechRelicEyeofOrnlu = 264;
const int cTechRelicTuskoftheIronBoar = 265;
const int cTechRelicPandorasBox = 293;
const int cTechRelicCanopicJarofImsety = 331;
const int cTechRelicGirdleofHippolyta = 352;
const int cTechRelicBootsofKickEverything = 367;
const int cTechRelicAnvilofHephaestus = 368;
const int cTechRelicCatoblepasScales = 372;
const int cTechRelicOdinsSpear = 200;
const int cTechRelicMithrilHorseshoes = 202;
const int cTechRelicTriosBow = 250;
const int cTechRelicArmorofAchilles = 252;
const int cTechRelicHerasThundercloudShawl = 294;
const int cTechRelicTailoftheCerberus = 373;
const int cTechRelicKhopeshofHorus = 375;
const int cTechFlamingWeaponsActive = 224;
const int cTechJourneyActive = 549;
const int cTechEclipseActive = 377;

// STRING CONSTANTS
const string c0 = "0";
const string cAT = "@";
const string cCL = ":";
const string cCO = ",";
const string cES = "";
const string cEX = "!";
const string cLB = "#";
const string cN1 = "1";
const string cPI = "|";
const string cPS = "%";
const string cSL = "/";
const string cSP = " ";

// STRINGS USED INTERNALLY
const string gClr1 = "<color={playerColor(";
const string gClr2 = ")}>";
const string gClr3 = "</color>";

const string gArenaHB = "_arenaHB";
const string gArmy = "Army";
const string gArmy0 = "0,0";
const string gBattleCry = "battlecry4.wav";
const string gBattleSky = "Dawn|Dusk|Default|Dusk2|Hades2|fimbulwinter|Night2";
const string gBattling = "_battling";
const string gBuildCry = "sentinelbirth.wav";
const string gBuildSky = "Anatolia";
const string gBuilding = "_building";
const string gCackle = "/dialog/en/skul062.mp3";
const string gCenters = "Centers";
const string gConvert = "find.wav";
const string gDefault = "default";
const string gEnemy = "enemy";
const string gFavor = "favor";
const string gFood = "food";
const string gGameID = "bloodsport";
const string gHealString = "Healing Spring";
const string gMP3 = ".mp3";
const string gMusicEvent = "gameMusicBattle";
const string gResAll = "food|wood|gold|favor";
const string gResFWG = "food|wood|gold";
const string gSlash = " / ";
const string gUnit = "Unit";
const string gYoink = "repeaton.wav";

const string gCivTemple = "Temple";
const string gCivMarket = "Market";
const string gCivArmy1 = "Academy|Barracks|LongHouse|Barracks Atlantean|Barracks Chinese";
const string gCivArmy2 = "Archery Range|Barracks|LongHouse|Barracks Atlantean|Barracks Chinese";
const string gCivArmy3 = "Stable|Barracks|LongHouse|Counter Building|Stable Chinese";
const string gCivArmory = "Armory|Dwarf Foundry";
const string gCivKeep = "Fortress|Migdol Stronghold|Hill Fort|Palace|Castle";
const string gAgeUpPowers = "Bolt|Restoration|Flaming Weapons|Lightning Storm|Lightning Storm";
const string gAge3CivPowers = "Bronze|Skeleton Power|Flaming Weapons|Bronze|Geyser";
const string gRelicsArena = "368#203#331#293#210#204|0|202#250#209#294|0|264#200#352#265#252|0|373#375#367";
const string gBlockUnits = "Shade of Hades|Shade|Oracle Scout|Scout|Scout Chinese|Mercenary|Mercenary Cavalry";
const string gBlockGarrison = "Helepolis|Siege Tower";
const string gBlockFlying = "Pegasus|Roc|flying medic|Stymphalian Bird|Vermilion Bird";

// LANGUAGE STRINGS
const string csAnd = " and ";
const string csAvgHPs = "** Unit Average: @ HPs";
const string csCongrats = "Congratulations @!";
const string csEgg = "**** Bloodsport Version 4.0 by TwentyOneScore ****";
const string csForRound = "for Round #@.";
const string csForSurviving = "for @ units surviving.";
const string csGranted = "You have been granted";
const string csNowPlaying = "Now playing @";
const string csRemovedGame = "Removed Team @ from the game.";
const string csRemovedTeam = "Removed @ from Team @.";
const string csRoundControlFood = "Control the Bush for food!";
const string csRoundControlHeal = "Control the Spring for health!";
const string csRoundControlRelic = "Control the Relic for power!";
const string csRoundControlSpeed = "Control the Jade for speed!";
const string csRoundStarts = "Round #@ starts in";
const string csRoundWinRelic = "Win the Round to win the Relic!";
const string csRules1 = "You have @ seconds to build an army of up to 30 units to do battle in the Arenas.";
const string csRules2 = "Units are moved to an Arena at the start of each match. The last team standing wins the match.";
const string csRules3 = "Each round you'll receive @ Food/Gold, @ Wood and @ Favor. This increases by @/@ each round.";
const string csRules4 = "Players start with 1 Bolt and gets additional God Powers with each age.";
const string csRules5 = "The game ends when a team wins @ rounds.";
const string csSumHPs = "** HPs: Created: @ / Survived: @ (@) / Avg Per Round @";
const string csSumPop = "** Units: Created: @ / Survived: @ (@) / Avg Per Round @";
const string csTeamWonRounds = "Team @ won @ rounds.";
const string csThanks = "Thanks for playing Bloodsport!";
const string csWins = "Wins";

string tracks(int mode=0, int track=0) {
  if (mode==1 && track==0)  return("music/fight/li'l drips");
  if (mode==1 && track==1)  return("music/fight/oi, that pops!!!");
  if (mode==1 && track==2)  return("music/fight/meatier shower");
  if (mode==1 && track==3)  return("music/interface/gank sneakin'");
  if (mode==1 && track==4)  return("music/interface/a cat named mittens");
  if (mode==1 && track==5)  return("music/interface/ma'am...some other sunset");
  if (mode==1 && track==6)  return("music/standard/the ballad of ace lebaron");
  if (mode==1 && track==7)  return("music/standard/(fine layers of) slaysenflite");
  if (mode==1 && track==8)  return("music/standard/adult swim");
  if (mode==1 && track==9)  return("music/standard/chocolate outline");
  if (mode==1 && track==10) return("music/standard/eat your potatoes");
  if (mode==1 && track==11) return("music/standard/flavor cats (in the comfort zone)");
  if (mode==1 && track==12) return("music/standard/hoping for real betterness");
  if (mode==1 && track==13) return("music/standard/in a pile of its own good");
  if (mode==1 && track==14) return("music/standard/never mind the slacks and bashers");
  if (mode==1 && track==15) return("music/standard/suture self");
  if (mode==1 && track==16) return("music/standard/behold the great science fi");
  if (mode==2 && track==0)  return("music/culture/greek to me");
  if (mode==2 && track==1)  return("music/culture/n. d. nile");
  if (mode==2 && track==2)  return("music/fight/i wish i could throw shapes");
  if (mode==2 && track==3)  return("music/fight/rot loaf");
  if (mode==2 && track==4)  return("music/fight/the fire brigade");
  if (mode==2 && track==5)  return("music/interface/if you can use a doorknob");
  if (mode==2 && track==6)  return("music/culture/of norse not!");
  if (mode==2 && track==7)  return("xpack/xmusic/hotlantis");
  if (mode==2 && track==8)  return("xpack/xcinematics/tutorial/music");
  if (mode==2 && track==9)  return("xpack/xcinematics/8_in/music");
  return("music/culture/chinese");
}

int gKbPlayer = 0;
void kbPlayerStore() { gKbPlayer = xsGetContextPlayer(); }
void kbPlayerRestore() { xsSetContextPlayer(gKbPlayer); }
string kbPU(int id=0) { return(kbGetUnitTypeName(id)); }

string iif(bool c=true, string t="", string f="") {
  if (c) return(t); return(f);
}

float iifF(bool c=true, float t=0, float f=0) {
  if (c) return(t); return(f);
}

int pct(int i=0, int d=0) {
  if (d==0) return(0.0);
  int v = (0.0+i)/(0.0+d) * 100.0;
  return(v);
}

string percent(int i=0, int d=0) {
  if (d==0) return(cPS + cPS);
  return(pct(i,d) + cPS);
}

int round(float v = 0.0) {
  int x = v + 0.5;
  return(x);
}

string str(int v=0) {
  return(cES + v);
}

float radians(float angle=0) {
  float rads = (angle%360.0)/180.0 * PI;
  return(rads);
}

float circleAtX(float angle=0, float radius=0, float ptX=1) {
  float atX = (radius * xsCos(radians(angle)) + ptX);
   atX = iifF(atX<0, 0, atX);
   atX = iifF(atX>kbGetMapXSize(), kbGetMapXSize(), atX);
   return(atX);
}

float circleAtZ(float angle=0, float radius=0, float ptZ=1) {
   float atZ = (radius * xsSin(radians(angle)) + ptZ);
   atZ = iifF(atZ<0, 0, atZ);
   atZ = iifF(atZ>kbGetMapZSize(), kbGetMapZSize(), atZ);
   return(atZ);
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

string listRandom(string list="", string delim="|") {
  int pos = aiRandInt(listLen(list, delim));
  return(listGet(list, pos+1, delim));
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

int intRandom(string list="", string delim="#") {
  return(xsStringToInt(listRandom(list, delim)));
}

string intSet(string list="", int at=1, int value=0, string delim="#") {
  return(listSet(list, at, cES + value, delim));
}

string print(string data="", string list="") {
  int len = xsStringLength(data) - 1;
  int cnt = listLen(list);
  string out = cES;
  for (pos=len;>=0) {
    string chr = xsSubString(data, 1, pos);
    if (chr==cAT) {
      chr = listGet(list, cnt);
      cnt--;
    }
    out = chr + out;
  }
  return(out);
}

string playerColor(int p=0, string msg="") { return(gClr1 + p + gClr2 + msg + gClr3); }
void   alert(string msg="", int len=5000) { trMessageSetText(msg, len); }
string alertf(string data="", string list="", int len=5000) { alert(print(data, list), len); }
void   chat(string msg="") { trChatSend(0, msg); }
string chatf(string data="", string list="") { chat(print(data, list)); }
string chatColor(string msg="", int p=0) { chat(playerColor(p, msg)); }
string chatColorf(string data="", string list="", int p=0) { chatColor(print(data, list), p); }

// PUESDO DB - 2 TABLES WITH 12 ROWS OF 127 CHARS
const int dbTab1 = 1; const int dbTab2 = 2; const int dbTab3 = 3;
string dbT11=""; string dbT12=""; string dbT13=""; string dbT14="";
string dbT15=""; string dbT16=""; string dbT17=""; string dbT18="";
string dbT19=""; string dbT10=""; string dbT1A=""; string dbT1B="";
string dbT21=""; string dbT22=""; string dbT23=""; string dbT24="";
string dbT25=""; string dbT26=""; string dbT27=""; string dbT28="";
string dbT29=""; string dbT20=""; string dbT2A=""; string dbT2B="";

string dbGetT1(int r=0) {
  if (r==1) return(dbT11); if (r==2) return(dbT12); if (r==3) return(dbT13);
  if (r==4) return(dbT14); if (r==5) return(dbT15); if (r==6) return(dbT16);
  if (r==7) return(dbT17); if (r==8) return(dbT18); if (r==9) return(dbT19);
  if (r==10) return(dbT10); if (r==11) return(dbT1A); return(dbT1B);
}

void dbSetT1(int r=0, string v="") {
  if      (r==1) dbT11=v; else if (r==2) dbT12=v; else if (r==3) dbT13=v;
  else if (r==4) dbT14=v; else if (r==5) dbT15=v; else if (r==6) dbT16=v;
  else if (r==7) dbT17=v; else if (r==8) dbT18=v; else if (r==9) dbT19=v;
  else if (r==10) dbT10=v; else if (r==11) dbT1A=v; else dbT1B=v;
}

string dbGetT2(int r=0) {
  if (r==1) return(dbT21); if (r==2) return(dbT22); if (r==3) return(dbT23);
  if (r==4) return(dbT24); if (r==5) return(dbT25); if (r==6) return(dbT26);
  if (r==7) return(dbT27); if (r==8) return(dbT28); if (r==9) return(dbT29);
  if (r==10) return(dbT20); if (r==11) return(dbT2A); return(dbT2B);
}

void dbSetT2(int r=0, string v="") {
  if      (r==1) dbT21=v; else if (r==2) dbT22=v; else if (r==3) dbT23=v;
  else if (r==4) dbT24=v; else if (r==5) dbT25=v; else if (r==6) dbT26=v;
  else if (r==7) dbT27=v; else if (r==8) dbT28=v; else if (r==9) dbT29=v;
  else if (r==10) dbT20=v; else if (r==11) dbT2A=v; else dbT2B=v;
}

string dbGetRow(int t=0, int r=0) {
  if (t==dbTab1) return(dbGetT1(r)); return(dbGetT2(r));
}

void dbSetRow(int t=0, int r=0, string v="") {
  if (t==dbTab1) dbSetT1(r, v); else dbSetT2(r, v);
}

string dbGetStr(int t=0, int r=0, int c=0) {
  string data = dbGetRow(t, r);
  return(listGet(data, c));
}

string dbSetStr(int t=0, int r=0, int c=0, string v="") {
  string data = dbGetRow(t, r);
  data = listSet(data, c, v);
  dbSetRow(t, r, data);
}

int dbGetInt(int t=0, int r=0, int c=0) {
  return(xsStringToInt(dbGetStr(t, r, c)));
}

void dbSetInt(int t=0, int r=0, int c=0, int v=0) {
  dbSetStr(t, r, c, cES+v);
}

int dbAccum(int t=0, int r=0, int c=0, int v=1) {
  v = v + dbGetInt(t, r, c);
  dbSetInt(t, r, c, v);
  return(v);
}

string dbAdd2d(int t=0, int r=0, int c=0, int v=0) {
  string ints = dbGetStr(t, r, c);
  ints = intAdd(ints, v);
  dbSetStr(t, r, c, ints);
  return(ints);
}

// RESOURCE HELPERS
string resInts(int f=0, int w=0, int g=0, int v=0) {
  return(f + cLB + w + cLB + g + cLB + v);
}

void resAward(int p=0, string why="", int f=0, int w=0, int g=0, int v=0, float r=1.0) {
  string ints = resInts(f*r, w*r, g*r, v*r);
  gMsg = cES;
  for (pos=1;<=4) {
    string t = listGet(gResAll, pos);
    int i = intGet(ints, pos);
    if (i>0) {
      gMsg = listAdd(gMsg, cES + i + cSP + t, cSL);
      trPlayerGrantResources(p, t, i);
    }
  }
  trChatSendToPlayer(0, p, csGranted + cSP + gMsg + cSP + why);
}

void resBulk(int p=0, string list="", string ints="") {
  int len = listLen(list);
  for (pos=1;<=len) {
    string t = listGet(list, pos);
    int v = intGet(ints, pos);
    trPlayerGrantResources(p, t, v);
  }
}

void resGive(int p=0, int f=0, int w=0, int g=0, int v=0) {
  resBulk(p, gResAll, resInts(f, w, g, v));
}

void resInc(int p=0, string list="", int v=0) {
  int len = listLen(list);
  for (pos=1;<=len) trPlayerGrantResources(p, listGet(list, pos), v);
}

void resSet(int p=0, string list="", int v=0) {
  int len = listLen(list);
  for (pos=1;<=len) {
    string t = listGet(list, pos);
    int i = v - trPlayerResourceCount(p, t);
    trPlayerGrantResources(p, t, i);
  }
}

vector playerVec(int p=1) {
  string block = listGet(gPlayerBIDs, p);
  return(kbGetBlockPosition(block));
}

vector arenaVec(int a=1) {
  string block = listGet(gArenaBIDs, a);
  return(kbGetBlockPosition(block));
}

// GAME SPECIFIC CODE
string cultureData(int p=0, int type=0) {
  int cul = kbGetCultureForPlayer(p);
  int civ = kbGetCivForPlayer(p);
  string data = cES;
  if (type==cCivDataGodPowers) {
    data = listSet(gAgeUpPowers, 3, listGet(gAge3CivPowers, cul+1));
  } else if (type==cCivDataBuildings) {
    int armory = 1;
    if (civ==cCivThor) armory++;
    data = listGet(gCivArmory, armory);
    data = listAdd(data, gCivTemple);
    data = listAdd(data, listGet(gCivArmy1, cul+1));
    data = listAdd(data, listGet(gCivKeep, cul+1));
    data = listAdd(data, listGet(gCivArmy2, cul+1));
    data = listAdd(data, listGet(gCivArmy3, cul+1));
    data = listAdd(data, gCivMarket);
  }
  return (data);
}

// TEAM SCHEMA
const int dbTeam     = dbTab1;
const int dbtPlayers = 1;
const int dbtPop     = 2;
const int dbtHPs     = 3;
const int dbtWins    = 4;
const int dbtCurHPs  = 5;
// TEAM DATA ACCESS
int    teamGetHPs(int r=1) { return(dbGetInt(dbTeam, r, dbtHPs)); }
int    teamGetPop(int r=1) { return(dbGetInt(dbTeam, r, dbtPop)); }
int    teamGetWins(int r=1) { return(dbGetInt(dbTeam, r, dbtWins)); }
string teamGetPlayers(int r=1) { return(dbGetStr(dbTeam, r, dbtPlayers)); }
void   teamSetPlayers(int r=1, string v="") { dbSetStr(dbTeam, r, dbtPlayers, v); }
string teamAddPlayer(int r=1, int p=0) { return(dbAdd2d(dbTeam, r, dbtPlayers, p)); }
int    teamIncHPs(int r=1, int v=0) { return(dbAccum(dbTeam, r, dbtHPs, v)); }
int    teamIncPop(int r=1, int v=0) { return(dbAccum(dbTeam, r, dbtPop, v)); }
int    teamIncWins(int r=1) { return(dbAccum(dbTeam, r, dbtWins)); }
void   teamSetHPs(int r=1, int v=0) { dbSetInt(dbTeam, r, dbtHPs, v); }
void   teamSetCurHPs(int r=1, int v=0) { dbSetInt(dbTeam, r, dbtCurHPs, v); }
void   teamSetPop(int r=1, int v=0) { dbSetInt(dbTeam, r, dbtPop, v); }
int    teamGetCurHPs(int r=1) { return(dbGetInt(dbTeam, r, dbtCurHPs)); }
int    teamIncCurHPs(int r=1, int v=0) { return(dbAccum(dbTeam, r, dbtCurHPs, v)); }
// PLAYER SCHEMA
const int dbPlayer  = dbTab2;
const int dbpAge    = 1;
const int dbpPop    = 2;
const int dbpHPs    = 3;
const int dbpHPsTot = 4;
const int dbpPopTot = 5;
const int dbpHPsSrv = 6;
const int dbpPopSrv = 7;
const int dbpBank   = 8;
// PLAYER DATA ACCESS
int    playerGetAge(int r=1) { return(dbGetInt(dbPlayer, r, dbpAge)); }
int    playerGetHPs(int r=1) { return(dbGetInt(dbPlayer, r, dbpHPs)); }
int    playerGetPop(int r=1) { return(dbGetInt(dbPlayer, r, dbpPop)); }
void   playerSetAge(int r=1, int v=0) { dbSetInt(dbPlayer, r, dbpAge, v); }
void   playerSetHPs(int r=1, int v=0) { dbSetInt(dbPlayer, r, dbpHPs, v); }
void   playerSetPop(int r=1, int v=0) { dbSetInt(dbPlayer, r, dbpPop, v); }
int    playerGetHPsTot(int r=1) { return(dbGetInt(dbPlayer, r, dbpHPsTot)); }
int    playerIncHPsTot(int r=1, int v=0) { return(dbAccum(dbPlayer, r, dbpHPsTot, v)); }
int    playerGetPopTot(int r=1) { return(dbGetInt(dbPlayer, r, dbpPopTot)); }
int    playerIncPopTot(int r=1, int v=0) { return(dbAccum(dbPlayer, r, dbpPopTot, v)); }
int    playerGetHPsSrv(int r=1) { return(dbGetInt(dbPlayer, r, dbpHPsSrv)); }
int    playerIncHPsSrv(int r=1, int v=0) { return(dbAccum(dbPlayer, r, dbpHPsSrv, v)); }
int    playerGetPopSrv(int r=1) { return(dbGetInt(dbPlayer, r, dbpPopSrv)); }
int    playerIncPopSrv(int r=1, int v=0) { return(dbAccum(dbPlayer, r, dbpPopSrv, v)); }
string playerGetBank(int r=1) { return(dbGetStr(dbPlayer, r, dbpBank)); }
void   playerSetBank(int r=1, string v="") { dbSetStr(dbPlayer, r, dbpBank, v); }

string playerAgePower(int p=0, int age=0) {
  return(listGet(gAgeUpPowers, age+1));
}

bool playerJustQuit(int p=0) {
  return(playerGetAge(p)!=-1);
}

void playerGameOver(int p=0) {
  trPlayerKillAllUnits(p);
  trPlayerKillAllBuildings(p);
  trSetPlayerDefeated(p);
  playerSetAge(p, -1);
}

string playerGrantPower(int p=0, int age=0, int uses=0) {
  string power = playerAgePower(p, age);
  if (uses>0) trChatSendToPlayer(0, p, csGranted + cSP + power);
  trTechGodPowerAtPosition(p, playerAgePower(p, age), uses, age+1);
}

string playerName(int p=0) {
  return(listGet(gPlayers, p));
}

void playerResPop() {
  for (p=1;<cNumberPlayers) {
    resSet(p, gFavor, 0);
    resBulk(p, gResAll, playerGetBank(p));
  }
}

void playerResPush() {
  for (p=1;<cNumberPlayers) {
    string ints = cES;
    for (pos=1;<=4) {
      string t = listGet(gResAll, pos);
      int v = trPlayerResourceCount(p, t);
      ints = intAdd(ints, v);
      trPlayerGrantResources(p, t, 0-v);
    }
    playerSetBank(p, ints);
  }
}

void playerAgedUp(int p=0, int age=0) {
  playerSetAge(p, age);
  playerGrantPower(p, cAge1, 1);
  playerGrantPower(p, age, 1);
}

bool gameBlockUnits(string list="") {
  int len = listLen(list);
  for (pos=1;<=len) {
    string t = listGet(list, pos);
    for (p=1;<cNumberPlayers) trForbidProtounit(p, t);
  }
}

int gameTimerLeft() {
  return (gBuildEnds-trTime());
}

void gameMusic(int mode=0, int track=0) {
  int event = -1;
  if (mode==1) event = 420;
  string file = tracks(mode, track);
  chatf(csNowPlaying, file);
  trSoundPlayDialog(file + gMP3, cN1, event, true, cES, cES);
}

void gameSound(string file="") {
  trSoundPlayFN(file, cN1, -1, cES, cES);
}

void gameMusicBattle() {
  gameMusic(1, gBattleSong);
  gBattleSong = (gBattleSong + aiRandInt(3)) % 17;
}

void gameMusicBuild() {
  trMusicStop();
  gameMusic(2, gBuildSong);
  gBuildSong = (gBuildSong + aiRandInt(3)) % 10;
}

void gameOver(int winner=0) {
  for (t=1;<=gNumberTeams) {
    string players = teamGetPlayers(t);
    int pCnt = intLen(players);
    if (pCnt==0) continue;
    string data = t + cPI + teamGetWins(t);
    chatf(csTeamWonRounds, data);
    for (pos=1;<=pCnt) {
      int p = intGet(players, pos);
      int totHPs = playerGetHPsTot(p);
      int totPop = playerGetPopTot(p);
      int srvHPs = playerGetHPsSrv(p);
      int srvPop = playerGetPopSrv(p);
      string pctPop = percent(srvPop, totPop);
      string pctHPs = percent(srvHPs, totHPs);
      int avgPop = round((totPop+0.0)/gRound);
      int avgHPs = round((totHPs+0.0)/gRound);
      int avgUnitHPs = totHPs/totPop;
      chatColor(playerName(p) + cCL, p);
      data = totPop + cPI + srvPop + cPI + pctPop + cPI + avgPop;
      chatColorf(csSumPop, data, p);
      data = totHPs + cPI + srvHPs + cPI + pctHPs + cPI + avgHPs;
      chatColorf(csSumHPs, data, p);
      chatColorf(csAvgHPs, str(avgUnitHPs), p);
    }
  }
  chat(csThanks);
  alert(csEgg);
  trMusicStop();
  gameSound(gCackle);
  gameMusic(0);

  for (p=1;<cNumberPlayers) {
    if (kbGetPlayerTeam(p)==winner) {
      trSetPlayerWon(p);
    } else {
      playerGameOver(p);
    }
  }
  xsDisableRule(gBattling);
}

int armyCnt(int p=0) {
  kbPlayerStore();
  xsSetContextPlayer(p);
  int aCnt = kbArmyGetNumberUnits(kbArmyGetID(gArmy));
  kbPlayerRestore();
  return(aCnt);
}

int teamLast(int t=0) {
  int alive = 0;
  int last = 0;
  for (p=1;<cNumberPlayers) {
    if (kbGetPlayerTeam(p)!=t) continue;
    if (armyCnt(p)==0) continue;
    alive++;
    last = p;
  }
  if (alive==1) return(last);
  return(0);
}

string teamName(int t=0) {
  string name = cES;
  for (p=1;<cNumberPlayers) {
    if (kbGetPlayerTeam(p)!=t) continue;
    if (armyCnt(p)==0) continue;
    name = name + xsSubString(playerName(p), 3, 0);
  }
  return(name);
}

string gameStatLine(int thp=0, int chp=0, int pop=0) {
  return(percent(chp, thp) + cPI + chp + cPI + pop);
}

void gameStatsShow(bool health = false) {
  int timeout = gameTimerLeft();
  if (health) timeout = 9;
  trChatHistoryClear();
  for (t=1;<=gNumberTeams) {
    int curHPs = teamGetCurHPs(t);
    if (curHPs==0) continue;
    string players = teamGetPlayers(t);
    int pCnt = intLen(players);
    if (pCnt==0) continue;
    int p = intGet(players, 1);
    int alive = p;
    if (pCnt>1) alive = teamLast(t);
    string roster = cES;
    string data = cES;
    string name = cES;
    string stats = gameStatLine(teamGetHPs(t), curHPs, teamGetPop(t));
    stats = stats + cPI + teamGetWins(t) + cSP + csWins;
    if (alive!=0) {
      name = playerName(alive);
    } else {
      for (pos=1;<=pCnt) {
        p = intGet(players, pos);
        int pop = playerGetPop(p);
        if (pop==0) continue;
        name = name + xsSubString(playerName(p), 3, 0);
        data = gameStatLine(teamGetHPs(t), playerGetHPs(p), pop);
        roster = listSet(roster, pos, data, cLB);
      }
    }
    data = stats + cPI + name;
    if (alive!=0) data = playerColor(alive, data);
    chat(data);
    for (pos=1;<=pCnt) {
      data = listGet(roster, pos, cLB);
      p = intGet(players, pos);
      if (data==cES) continue;
      data = cSP + cSP + cSP + listAdd(data, playerName(p));
      chatColor(data, p);
    }
  }
}

void setupRevealer(int t=0, int p=0, int los=0) {
  trModifyProtounit(kbPU(t), p, cUnitStatLOS, 9999999999999999999.0);
  trModifyProtounit(kbPU(t), p, cUnitStatLOS, -9999999999999999999.0);
  trModifyProtounit(kbPU(t), p, cUnitStatHP, 999999999999.0);
  trModifyProtounit(kbPU(t), p, cUnitStatLOS, los);
}

bool unitBlocked(int uid=0) {
  if (kbUnitIsType(uid, cUnitTypeMilitary)==false) return(true);
  int ubt = kbGetUnitBaseTypeID(uid);
  if (kbUnitGetMovementType(ubt)==cMovementTypeAir) return(true);
  return(false);
}

void unitKill(int uid=0, int p=0) {
  if (p>0) resInc(p, gResFWG, kbUnitGetCurrentAICost(uid)/3);
  trUnitSelectClear();
  trUnitSelectByID(uid);
  trUnitDelete(true);
}

void unitMove(int p=1, int aid=1, int pos=1, int x=0, int z=0) {
  int uid = kbArmyGetUnitID(aid, pos);
  string PUN = kbGetProtoUnitName(kbGetUnitBaseTypeID(uid));
  kbArmyRemoveUnit(aid, uid);
  unitKill(uid);
  trArmyDispatch(p + cCO + aid, PUN, 1, x, 0, z, 1, false);
}

int unitQryRow(int qid=0, int r=0) {
  return(kbUnitQueryGetResult(qid, r));
}

int unitQryRun(int qid=0, int p=0, int uid=0, int us=2) {
  kbUnitQueryResetData(qid);
  kbUnitQuerySetPlayerID(qid, p);
  kbUnitQuerySetUnitType(qid, uid);
  kbUnitQuerySetState(qid, us);
  kbUnitQueryResetResults(qid);
  return(kbUnitQueryExecute(qid));
}

int armyClearDead(int aid = 0) {
  kbLookAtAllUnitsOnMap();
  int aCnt = kbArmyGetNumberUnits(aid);
  int aHPs = 0;
  int uHPs = 0;
  for (j=1;<=aCnt) {
    int uid = kbArmyGetUnitID(aid, aCnt-j);
    uHPs = kbUnitGetCurrentHitpoints(uid);
    if (kbUnitGetHealth(uid)==0) kbArmyRemoveUnit(aid, uid);
    aHPs = aHPs + uHPs;
  }
  return(aHPs);
}

void armyRefund() {
  kbPlayerStore();
  for (p=1;<cNumberPlayers) {
    xsSetContextPlayer(p);
    int aid = kbArmyGetID(gArmy);
    int aHPs = armyClearDead(aid);
    int aCnt = kbArmyGetNumberUnits(aid);
    playerIncHPsSrv(p, aHPs);
    playerIncPopSrv(p, aCnt);
    int bonus = 0;
    for (j=1;<=aCnt) {
      int uid = kbArmyGetUnitID(aid, aCnt-j);
      bonus = bonus + kbUnitGetCurrentAICost(uid)/5;
      kbArmyRemoveUnit(aid, uid);
      unitKill(uid);
    }
    if (aCnt>0) {
      gMsg = print(csForSurviving, str(aCnt));
      resAward(p, gMsg, bonus, bonus, bonus, aCnt);
    }
  }
  kbPlayerRestore();
}

string unitDispatch(int tid=0, vector v=vector(0,0,0)) {
  string bid = cES+trGetNextUnitScenarioNameNumber();
  trArmyDispatch(gArmy0, kbPU(tid), 1, xsVectorGetX(v), 0, xsVectorGetZ(v), 0, false);
  trUnitSelectClear();
  trUnitSelect(bid);
  trUnitTeleport(xsVectorGetX(v), 0, xsVectorGetZ(v));
  return(bid);
}

void arenaRelicSet() {
  string techs = listGet(gRelicsArena, gArena);
  if (techs==c0) return;
  gRelicTech = intRandom(techs);
  string bid = listGet(gActiveBIDs, gArena);
  vector v = arenaVec(gArena);
  trUnitSelectClear();
  trUnitSelect(bid);
  trUnitConvert(0);
  trSetRelicType(gRelicTech);
  trUnitTeleport(xsVectorGetX(v), 0, xsVectorGetZ(v));
}

void arenaRelicCreate() {
  string bid = unitDispatch(cUnitTypeRelic, arenaVec(gArena));
  if (gArena!=1) trSetSelectedScale(2,4,2);
  gActiveBIDs = listSet(gActiveBIDs, gArena, bid);
}

void arenaRelicAward(int team=0) {
  if (gArena!=1) return;
  for (p=1;<cNumberPlayers) {
    if (kbGetPlayerTeam(p)==team) {
      string bid = unitDispatch(cUnitTypeRelic, playerVec(p));
      trSetRelicType(gRelicTech);
    }
  }
}

void arenaEnd() {
  xsDisableRule(gArenaHB+gArena);
  for (p=1;<cNumberPlayers) setupRevealer(cUnitTypeRevealerPlayer, p, gPlayerRadius);
  for (p=1;<cNumberPlayers) {
    if (trTechStatusActive(p, gRelicTech)) trTechSetStatus(p, gRelicTech, cTechStatusUnobtainable);
    if (trTechStatusActive(p, cTechEclipseActive)) trTechSetStatus(p, cTechEclipseActive, cTechStatusUnobtainable);
    if (trTechStatusActive(p, cTechJourneyActive)) trTechSetStatus(p, cTechJourneyActive, cTechStatusUnobtainable);
  }
  arenaRelicSet();
}

void arenaBegin() {
  for (p=1;<cNumberPlayers) setupRevealer(cUnitTypeRevealerPlayer, p, gArenaRadius);
  xsEnableRule(gArenaHB+gArena);
}

void battleWon(int team=0) {
  int wins = teamGetWins(team);
  string names = cES;
  for (p=1;<cNumberPlayers) {
    if (kbGetPlayerTeam(p)==team) names = listAdd(names, playerName(p), csAnd);
  }
  alertf(csCongrats, names);
  arenaRelicAward(team);
}

bool checkVictory(int winner=0) {
  if (teamIncWins(winner)==gGameWins) {
    gameOver(winner);
    return(true);
  }
  battleWon(winner);
  return(false);
}

void battleCowards(int aid=0) {
  int aCnt = kbArmyGetNumberUnits(aid);
  for (j=1;<=aCnt) {
    int uid = kbArmyGetUnitID(aid, aCnt-j);
    if (kbUnitGetHealth(uid)==0) continue;
    vector v = arenaVec(gArena);
    trUnitSelectClear();
    trUnitSelectByID(uid);
    float dist = trUnitDistanceToPoint(xsVectorGetX(v), 0, xsVectorGetZ(v));
    if (dist > gArenaRadius) {
      trUnitMoveToPoint(xsVectorGetX(v), 0, xsVectorGetZ(v));
      int amt = 3 + (dist - gArenaRadius);
      vector up = kbUnitGetPosition(uid);
      trDamageUnit(amt);
      trUnitHighlight(2);
      trUnitCreate(kbPU(cUnitTypeInfernoFlame), gDefault, xsVectorGetX(up), 0, xsVectorGetZ(up), 0, 1);
    }
  }
}

int battleUpdate() {
  int teams = 0;
  int winner = 0;
  kbPlayerStore();
  for (t=1;<=gNumberTeams) {
    teamSetCurHPs(t, 0);
    teamSetPop(t, 0);
    string players = teamGetPlayers(t);
    int pCnt = intLen(players);
    if (pCnt==0) continue;
    for (pos=1;<=pCnt) {
      int p = intGet(players, pos);
      if (trPlayerActive(p)) {
        xsSetContextPlayer(p);
        int aid = kbArmyGetID(gArmy);
        int aHPs = armyClearDead(aid);
        int aCnt = kbArmyGetNumberUnits(aid);
        playerSetPop(p, aCnt);
        playerSetHPs(p, aHPs);
        teamIncPop(t, aCnt);
        teamIncCurHPs(t, aHPs);
        battleCowards(aid);
      }
    }
    if (teamGetPop(t)>0 && teamGetCurHPs(t)>0) {
      teams++;
      winner = t;
    }
  }
  kbPlayerRestore();
  gameStatsShow(true);
  if (teams>1) return(0);
  return(winner);
}

void emptyBuildings(int p=0) {
  for (pos=0;<8) {
    int aid = kbArmyGetID(gArmy + pos);
    int uid = kbArmyGetUnitID(aid, 0);
    trUnitSelectClear();
    trUnitSelectByID(uid);
    trUnitEjectContained();
  }
}

void revealArea(int tid=0, int p=0, vector v=vector(0,0,0)) {
  trUnitCreate(kbPU(tid), gDefault, xsVectorGetX(v), 0, xsVectorGetZ(v), 0, p);
}

void castHealingSpring() {
  trUnitSelectClear();
  trUnitSelect(gDefault);
  trTechInvokeGodPower(0, gHealString, arenaVec(gArena), vector(0, 0, 0));
}

bool initArena() {
  if (intGet(gArenasInit, gArena)==1) return(false);
  for (p=1;<cNumberPlayers) revealArea(cUnitTypeRevealerPlayer, p, arenaVec(gArena));
  gArenasInit = intSet(gArenasInit, gArena, 1);
  return(true);
}

void initArenaWinRelic() {
  if (initArena()) {
    alert(csRoundWinRelic);
    arenaRelicCreate();
    arenaRelicSet();
  }
}

void initArenaLava() {
  if (initArena()) {
    alert(csRoundControlRelic);
    unitDispatch(cUnitTypeTartarianGate, arenaVec(gArena));
    trSetSelectedScale(1, .5, 1);
    arenaRelicCreate();
    arenaRelicSet();
  }
}

void initArenaHealing() {
  if (initArena()) {
    alert(csRoundControlHeal);
    castHealingSpring();
  }
}

void initArenaResources() {
  if (initArena()) {
    alert(csRoundControlFood);
    string bid = unitDispatch(cUnitTypeBerryBush, arenaVec(gArena));
    trSetSelectedScale(1.5, 2.5, 1.5);
    gActiveBIDs = listSet(gActiveBIDs, gArena, bid);
  }
}

void initArenaMystic() {
  for (p=1;<cNumberPlayers) {
    if (trTechStatusActive(p, cTechEclipseActive)) continue;
    trTechSetStatus(p, cTechEclipseActive, cTechStatusActive);
  }
}

void initArenaSpeed() {
  if (initArena()) {
    alert(csRoundControlSpeed);
    string bid = unitDispatch(cUnitTypeJadeMineTiny, arenaVec(gArena));
    trSetSelectedScale(.5, 3, .5);
    gActiveBIDs = listSet(gActiveBIDs, gArena, bid);
  }
}

void initArenaRelic() {
  if (initArena()) {
    alert(csRoundControlRelic);
    arenaRelicCreate();
    arenaRelicSet();
  }
}

string unitConvertTeam() {
  string bid = listGet(gActiveBIDs, gArena);
  trUnitSelectClear();
  trUnitSelect(bid);
  string pcnts = cES;
  int max = 0;
  int twin = 0;
  int owner = 0;
  for (t=1;<=gNumberTeams) {
    int tcnt = 0;
    string players = teamGetPlayers(t);
    int pcnt = intLen(players);
    for (pos=1;<=pcnt) {
      int p = intGet(players, pos);
      if (trUnitIsOwnedBy(p)) owner = p;
      int ucnt = trCountUnitsInArea(bid, p, gUnit, gArenaRadius * .5);
      pcnts = intSet(pcnts, p, ucnt);
      tcnt = tcnt + ucnt;
    }
    if (tcnt > max) {
      twin = t;
      max = tcnt;
    }
  }
  players = teamGetPlayers(twin);
  pcnt = intLen(players);
  int pmax = 0;
  int pwin = 0;
  for (pos=1;<=pcnt) {
    p = intGet(players, pos);
    ucnt = intGet(pcnts, p);
    if (ucnt > pmax) {
      pwin = p;
      pmax = ucnt;
    }
  }
  if (kbGetPlayerTeam(owner)!=kbGetPlayerTeam(pwin)) {
    trUnitConvert(pwin);
    gameSound(gConvert);
  } else if (pwin!=owner) {
    trUnitConvert(pwin);
    gameSound(gYoink);
  }

  string rtn = intAdd(cES + twin, pwin);
  rtn = intAdd(rtn, owner);
  rtn = listAdd(rtn, pcnts);
  return(rtn);
}

void arenaSpeedHB() {
  string data = unitConvertTeam();
  string wins = listGet(data, 1);
  string pcnts = listGet(data, 2);
  int pwin = intGet(wins, 2);
  int cnt = intGet(pcnts, pwin);
  for (p=1;<cNumberPlayers) {
    bool hasTech = trTechStatusActive(p, cTechJourneyActive);
    if (kbGetPlayerTeam(p)==kbGetPlayerTeam(pwin)) {
      if (hasTech==false) trTechSetStatus(p, cTechJourneyActive, cTechStatusActive);
    } else if (hasTech==true) {
      trTechSetStatus(p, cTechJourneyActive, cTechStatusUnobtainable);
    }
  }
}

void arenaResourcesHB() {
  string data = unitConvertTeam();
  string wins = listGet(data, 1);
  string pcnts = listGet(data, 2);
  int twin = intGet(wins, 1);
  int pwin = intGet(wins, 2);
  string players = teamGetPlayers(twin);
  int pcnt = intLen(players);
  for (pos=1;<=pcnt) {
    int p = intGet(players, pos);
    int cnt = intGet(pcnts, p);
    trPlayerGrantResources(p, gFood, cnt);
  }
}

void arenaRelicHB() {
  initArenaRelic();
  string data = unitConvertTeam();
  string wins = listGet(data, 1);
  int twin = intGet(wins, 1);
  int pwin = intGet(wins, 2);
  for (p=1;<cNumberPlayers) {
    bool hasTech = trTechStatusActive(p, gRelicTech);
    if (kbGetPlayerTeam(p)==kbGetPlayerTeam(pwin)) {
      if (hasTech==false) trTechSetStatus(p, gRelicTech, cTechStatusActive);
    } else if (hasTech==true) {
      trTechSetStatus(p, gRelicTech, cTechStatusUnobtainable);
    }
  }
}

void battleBegin() {
  trSetLighting(listGet(gBattleSky, gArena), 3.0);
  gameSound(gBattleCry);
  playerResPush();
  emptyBuildings();
  gArena = (gRound-1)%7 + 1;
 //gArena = 6;
  arenaBegin();
  vector v = arenaVec(gArena);
  float ptX = xsVectorGetX(v);
  float ptZ = xsVectorGetZ(v);
  float angle = 360/gNumberTeams;
  float start = aiRandInt(360);
  kbPlayerStore();
  for (t=1;<=gNumberTeams) {
    angle = start + 360/gNumberTeams * t;
    teamSetHPs(t, 0);
    string players = teamGetPlayers(t);
    int pCnt = intLen(players);
    if (pCnt==0) continue;
    for (pos=1;<=pCnt) {
      int p = intGet(players, pos);
      int tCnt = 0;
      if (trPlayerActive(p)) {
        xsSetContextPlayer(p);
        emptyBuildings(p);
        int aid = kbArmyGetID(gArmy);
        int aHPs = armyClearDead(aid);
        int aCnt = kbArmyGetNumberUnits(aid);
        tCnt = tCnt + aCnt;
        playerIncPopTot(p, aCnt);
        playerIncHPsTot(p, aHPs);
        teamIncHPs(t, aHPs);
        float row = 0;
        for (j=(aCnt-1);>=0) {
          float cell = (j%6) * 3.0;
          if (cell==0) row = row + 3.0;
          int atX = circleAtX(angle+cell, gArenaRadius-row, ptX);
          int atZ = circleAtZ(angle+cell, gArenaRadius-row, ptZ);
          unitMove(p, aid, j, atX, atZ);
        }
        atX = circleAtX(angle + 25, 10, ptX);
        atZ = circleAtZ(angle + 25, 10, ptZ);
        trUnitSelectClear();
        trArmySelect(p + cCO + aid);
        trUnitMoveToPoint(atX, 0, atZ);
      }
      angle = angle + aCnt + 5;
    }
  }
  kbPlayerRestore();
}

void buildArmy() {
  for (t=1;<=gNumberTeams) {
    teamSetPop(t);
    teamSetHPs(t);
  }
  kbPlayerStore();
  static int qid = -1;
  if (qid==-1) qid = kbUnitQueryCreate("build");
  for (p=1;<cNumberPlayers) {
    if (trPlayerActive(p)) {
      xsSetContextPlayer(p);
      int team = kbGetPlayerTeam(p);
      int pCnt = intLen(teamGetPlayers(team));
      float ratio = gMinTeamCnt / pCnt;
      int MaxUnits = 30 * ratio;
      int aid = kbArmyGetID(gArmy);
      int aHPs = armyClearDead(aid);
      int aCnt = kbArmyGetNumberUnits(aid);
      if (aCnt<MaxUnits) {
        int myCnt = unitQryRun(qid, p, cUnitTypeUnit, cUnitStateAlive);
        for (j=0;<myCnt) {
          int uid = unitQryRow(qid, j);
          if (unitBlocked(uid)) {
            unitKill(uid, p);
          } else if (aCnt<MaxUnits) {
            kbArmyAddUnit(aid, uid);
            aCnt = kbArmyGetNumberUnits(aid);
          }
        }
      }
      aCnt = kbArmyGetNumberUnits(aid);
      playerSetPop(p, aCnt);
      playerSetHPs(p, aHPs);
      teamIncPop(team, aCnt);
      teamIncHPs(team, aHPs);
      int secs = gameTimerLeft();
      if (secs%15==5) {
        vector v = playerVec(p);
        trUnitSelectClear();
        trArmySelect(p + cCO + aid);
        trUnitMoveToPoint(xsVectorGetX(v), 0, xsVectorGetZ(v));
      }
    }
  }
  for (t=1;<=gNumberTeams) teamSetCurHPs(t, teamGetHPs(t));
  kbPlayerRestore();
}

void buildTeams() {
  int min = 12;
  for (t=1;<=gNumberTeams) {
    string players = teamGetPlayers(t);
    int pCnt = intLen(players);
    if (pCnt==0) continue;
    string alive = cES;
    for (pos=1;<=pCnt) {
      int p = intGet(players, pos);
      if (trPlayerActive(p)) {
        alive = intAdd(alive, p);
      } else if (playerJustQuit(p)) {
        playerGameOver(p);
        gMsg = listAdd(playerName(p), str(t));
        chatf(csRemovedTeam, gMsg);
      }
    }
    teamSetPlayers(t, alive);
    pCnt = intLen(alive);
    if (pCnt==0) {
      chatf(csRemovedGame, str(t));
    } else {
      min = xsMin(min, pCnt);
    }
  }
  gMinTeamCnt = min;
}

void buildResources() {
  for (t=1;<=gNumberTeams) {
    string players = teamGetPlayers(t);
    int pCnt = intLen(players);
    float ratio = gMinTeamCnt / pCnt;
    for (pos=1;<=pCnt) {
      int p = intGet(players, pos);
      gMsg = print(csForRound, str(gRound));
      resAward(p, gMsg, gResRound, gResRound * 1.25, gResRound, gFavRound, ratio);
    }
  }
  gResRound = gResRound + gResInc;
  gFavRound = gFavRound + gFavInc;
}

void buildTechUpdate() {
  for (p=1;<cNumberPlayers) {
    if (gRound==3) trTechSetStatus(p, cTechAge3Aphrodite, cTechStatusAvailable);
    if (gRound==5) trTechSetStatus(p, cTechAge4Artemis, cTechStatusAvailable);
    if ((gRound % 6)==0) playerGrantPower(p, cAge1, 1);
    if ((gRound % 8)==0) playerGrantPower(p, cAge2, 1);
  }
}

void buildBegin() {
  gBuildEnds = trTime() + gBuildTime;
  gRound++;
  buildTeams();
  buildResources();
  buildTechUpdate();
  gameSound(gBuildCry);
  trSetLighting(gBuildSky, 5.0);
  gameMusicBuild();
  gMsg = print(csRoundStarts, str(gRound));
  trCounterAddTime(gGameID, gameTimerLeft(), 1, gMsg, -1);
}

void setupOptions() {
  gGameWins = 7 + cMapSize * 4;
  int speed = 7;
  gBuildTime = 55;
  if (vcGetGameplayMode()==cGameModeLightning) {
    speed = 10;
    gBuildTime = 45;
  }
  // gBuildTime= 15;
  if (vcGetGameplayMode()==cGameModeDeathmatch) gResRound = 1000;
  gResStart = gResRound;
  trRateResearch(speed);
  trRateTrain(speed);
}

void setupVectors() {
  gArenaXZ = cES;
  gPlayerXZ = cES;
  kbPlayerStore();
  xsSetContextPlayer(0);
  int aid = kbArmyGetID(gCenters);
  int aCnt = kbArmyGetNumberUnits(aid);
  int uid = kbArmyGetUnitID(aid, 0);
  trUnitSelectClear();
  trUnitSelectByID(uid);
  uid = kbArmyGetUnitID(aid, 1);
  float dist = trUnitDistanceToUnitID(uid);
  gArenaRadius = dist / 2;
  for(j=0;<aCnt) {
    uid = kbArmyGetUnitID(aid, j);
    int bid = trGetUnitScenarioNameNumber(uid);
    if (j<7) {
      gArenaBIDs = listAdd(gArenaBIDs, cES+bid);
    } else {
      gPlayerBIDs = listAdd(gPlayerBIDs, cES+bid);
    }
    trUnitSelectByID(uid);
  }
  trUnitChangeProtoUnit(kbPU(cUnitTypeCinematicBlock));
  kbPlayerRestore();
}

void setupTeams() {
  gNumberTeams = 0;
  for (p=1;<cNumberPlayers) {
    int team = kbGetPlayerTeam(p);
    gNumberTeams = xsMax(gNumberTeams, team);
    teamAddPlayer(team, p);
    resSet(p, gResAll, 0);
    playerSetAge(p, cAge1);
  }
}

void setupTechTree() {
  for (p=1;<cNumberPlayers) {
    trPlayerTechTreeEnabledGodPowers(p, false);
    trTechSetStatus(p, cTechRelicPeltofArgus, cTechStatusActive);
    for (j = 0;<=41) trTechSetStatus(p, cTechRelicEyeofHorus, cTechStatusActive);
    for (j = 0;<=10) trTechSetStatus(p, cTechRelicNoseoftheSphinx, cTechStatusActive);
    trTechSetStatus(p, cTechAge3Aphrodite, cTechStatusUnobtainable);
    trTechSetStatus(p, cTechAge4Artemis, cTechStatusUnobtainable);
    trTechSetStatus(p, cTechOdinsFirstRavens, cTechStatusUnobtainable);
    trTechSetStatus(p, cTechOdinsRavenRespawn, cTechStatusUnobtainable);
    trTechSetStatus(p, cTechStartingUnitsAtlantean, cTechStatusUnobtainable);
    trTechSetStatus(p, cTechStartingUnitsEgyptian, cTechStatusUnobtainable);
    trTechSetStatus(p, cTechStartingUnitsGreek, cTechStatusUnobtainable);
    trTechSetStatus(p, cTechStartingUnitsNorse, cTechStatusUnobtainable);
    trTechSetStatus(p, cTechStartingUnitsThor, cTechStatusUnobtainable);
    trTechSetStatus(p, cTechStartingUnitsChinese, cTechStatusUnobtainable);
    trTechSetStatus(p, cTechPharaohRespawn, cTechStatusUnobtainable);
    trTechSetStatus(p, cTechSetAge1Critter, cTechStatusUnobtainable);
  }
}

void setupProtoUnits() {
  gameBlockUnits(gBlockUnits);
  gameBlockUnits(gBlockGarrison);
  gameBlockUnits(gBlockFlying);
  setupRevealer(cUnitTypeRevealerPlayer, 0, 999);
  for (p=1;<cNumberPlayers) setupRevealer(cUnitTypeRevealerPlayer, p, gPlayerRadius);
}

void setupGodPowers() {
  trSetDisableGPBlocking(true);
  for (p=1;<cNumberPlayers) {
    trPlayerSetDiplomacy(p, 0, gEnemy);
    trPlayerSetDiplomacy(0, p, gEnemy);
    if (trPlayerActive(p)) {
      trPlayerKillAllGodPowers(p);
      for (age=cAge1;<=cAge4) playerGrantPower(p, age, 0);
      playerGrantPower(p, cAge1, 1);
    }
  }
}

void setupBuildings() {
  kbPlayerStore();
  for (p=1;<cNumberPlayers) {
    xsSetContextPlayer(p);
    string buildings = cultureData(p, cCivDataBuildings);
    int aid = kbArmyGetID(gArmy);
    for (pos=0;<=6) {
      int uid = kbArmyGetUnitID(aid, pos);
      trUnitSelectClear();
      trUnitSelectByID(uid);
      string building = listGet(buildings, pos+1);
      trUnitChangeProtoUnit(building);
    }
    int aCnt = kbArmyGetNumberUnits(aid);
    for (j=1;<=aCnt) kbArmyRemoveUnit(aid, kbArmyGetUnitID(aid, aCnt-j));
  }
  kbPlayerRestore();
}

void setupMap() {
  alert(csEgg);
  trEventSetHandler(420, gMusicEvent);
  gBattleSong = aiRandInt(17);
  setupBuildings();
}

bool notYet(int when=0, float start=0.0) {
  return((trTime()-start) < when);
}

rule _setup highFrequency active {
  setupOptions();
  setupVectors();
  setupTeams();
  setupTechTree();
  setupProtoUnits();
  setupGodPowers();
  setupMap();
  buildBegin();
  xsDisableSelf();
  xsEnableRule(gBuilding);
}

rule _building minInterval 2 inactive {
  if (notYet(2, cActivationTime)) return;
  kbLookAtAllUnitsOnMap();
  buildArmy();
  if (gameTimerLeft()>0) {
    gameStatsShow();
    return;
  }
  battleBegin();
  xsDisableSelf();
  xsEnableRule(gBattling);
}

rule _battling minInterval 2 inactive {
  if (notYet(2, cActivationTime)) return;
  kbLookAtAllUnitsOnMap();
  int winner = battleUpdate();
  if (winner==0) return;
  playerResPop();
  armyRefund();
  if (checkVictory(winner)) return;
  arenaEnd();
  buildBegin();
  xsDisableSelf();
  xsEnableRule(gBuilding);
}

rule _prevent_building minInterval 3 active {
  if (notYet(3, cActivationTime)) return;
  kbPlayerStore();
  static int qid = -1;
  if (qid==-1) qid = kbUnitQueryCreate("prevent");
  string bid = listGet(gActiveBIDs, gArena);
  int exception = kbGetBlockID(cES+bid);
  for (p=1;<cNumberPlayers) {
    if (trPlayerActive(p)) {
      xsSetContextPlayer(p);
      int myCnt = unitQryRun(qid, p, cUnitTypeBuilding, cUnitStateBuilding);
      for (j=0;<myCnt) {
        int uid = unitQryRow(qid, j);
        if (uid==exception) continue;
        unitKill(uid);
      }
    }
  }
  kbPlayerRestore();
}

rule _instructions minInterval 6 active {
  if (notYet(6, cActivationTime)) return;
  if (gInstr==1) {
    alertf(csRules1, str(gBuildTime));
  } else if (gInstr==2) {
    alert(csRules2);
  } else if (gInstr==3) {
    gMsg = listAdd(str(gResStart), str(gResStart*1.25));
    gMsg = listAdd(gMsg, str(gFavStart));
    gMsg = listAdd(gMsg, str(gResInc));
    gMsg = listAdd(gMsg, str(gFavInc));
    alertf(csRules3, gMsg);
  } else if (gInstr==4) {
    alert(csRules4);
  } else {
    alertf(csRules5, str(gGameWins));
    xsDisableSelf();
  }
  gInstr++;
}

rule _ageup minInterval 1 active {
  if (notYet(1, cActivationTime)) return;
  for (p=1;<cNumberPlayers) {
    int age = playerGetAge(p);
    int cur = kbGetAgeForPlayer(p);
    if (age!=cur) playerAgedUp(p, cur);
  }
}

rule _arenaHB1 minInterval 3 inactive {
  initArenaWinRelic();
  xsDisableSelf();
}

rule _arenaHB2 minInterval 3 inactive {
  initArenaHealing();
  xsDisableSelf();
}

rule _arenaHB3 minInterval 3 inactive {
  arenaRelicHB();
}

rule _arenaHB4 minInterval 3 inactive {
  initArenaSpeed();
  arenaSpeedHB();
}

rule _arenaHB5 minInterval 3 inactive {
  initArenaLava();
  arenaRelicHB();
}

rule _arenaHB6 minInterval 3 inactive {
  initArenaResources();
  arenaResourcesHB();
}

rule _arenaHB7 minInterval 3 inactive {
  initArenaMystic();
  arenaRelicHB();
}

rule _test minInterval 1 active {
   xsDisableSelf();
  //trRevealEntireMap();
}
