// GLOBALS PASSED FROM RM
int cMapSize = 1;
string gPlayers = "TwentyOneScore|Kastor|three|four|five|six|seven|eight|nine|ten";

// GLOBALS
int gBattleSong = 1;
int gBuildEnds = 0;
int gBuildSong = 1;
int gBuildTime = 15;
int gFavInc = 5;
int gFavRound = 50;
int gGameWins = 7;
int gInstr = 1;
int gNumberTeams = 2;
int gQueryID = -1;
int gResInc = 50;
int gResRound = 1200;
int gRound = 0;
float gMinTeamCnt = 1.0;
string gMsg = "";

const int cCivDataGodPowers = 0;
const int cCivDataBuildings = 1;

// AOM XML CONSTANTS
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
const int cTechRelicEyeofHorus = 194;
const int cTechRelicNoseoftheSphinx = 205;
const int cTechStartingUnitsAtlantean = 394;
const int cTechStartingUnitsEgyptian = 145;
const int cTechStartingUnitsGreek = 144;
const int cTechStartingUnitsNorse = 143;
const int cTechStartingUnitsThor = 379;
const int cTechStatusActive = 4;
const int cTechStatusAvailable=2;
const int cTechStatusUnobtainable = 0;
const int cUnitTypeHelepolis = 510;
const int cUnitTypeMilitary = 951;
const int cUnitTypeShade = 574;
const int cUnitTypeShadeofHades = 597;
const int cUnitTypeSiegeTower = 380;
const int cUnitTypeUnit = 935;
const int cUnitTypeBuilding = 937;
const int cUnitStateBuilding = 1;
const int cUnitStateAlive = 2;

// STRING CONSTANTS
const string cES = "";
const string cAT = "@";
const string cCO = ",";
const string cEX = "!";
const string cLB = "#";
const string cN1 = "1";
const string cPI = "|";
const string cPS = "%";
const string cSL = "/";
const string cSP = " ";
const string cCL = ":";

// STRINGS USED INTERNALLY
const string gClr1 = "<color={playerColor(";
const string gClr2 = ")}>";
const string gClr3 = "</color>";


const string gGameID = "bloodsport";
const string gSlash = " / ";
const string gArmy = "Army";
const string gBuilding = "_building";
const string gBattling = "_battling";
const string gResAll = "food|wood|gold|favor";
const string gResFWG = "food|wood|gold";
const string gFavor = "favor";
const string gMP3 = ".mp3";
const string gBattleSky = "Default";
const string gBattleCry = "battlecry4.wav";
const string gBuildCry = "sentinelbirth.wav";
const string gBuildSky = "Anatolia";
const string gEnemy = "enemy";
const string gMusicEvent = "gameMusicBattle";
const string gGaiaUnit = "default";
const string gHealString = "Healing Spring";
const string gCackle = "/dialog/en/skul062.mp3";

const string gCivTemple = "Temple";
const string gCivMarket = "Market";
const string gCivArmy1 = "Academy|Barracks|LongHouse|Barracks Atlantean|Barracks Chinese";
const string gCivArmy2 = "Archery Range|Barracks|LongHouse|Barracks Atlantean|Barracks Chinese";
const string gCivArmy3 = "Stable|Barracks|LongHouse|Counter Building|Stable Chinese";
const string gCivArmory = "Armory|Dwarf Foundry";
const string gCivKeep = "Fortress|Migdol Stronghold|Hill Fort|Palace|Castle";
const string gAgeUpPowers = "Bolt|Restoration|Bolt|Lightning Storm";
const string gAge3CivPowers = "Bronze|Skeleton Power|Flaming Weapons|Bronze|Geyser";

const string gBlockUnits = "Shade of Hades|Shade|Oracle Scout";
const string gBlockGarrison = "Helepolis|Siege Tower";
const string gBlockFlying = "Pegasus|Roc|flying medic|Stymphalian Bird|Vermilion Bird";

// LANGUAGE STRINGS
const string csWins = "Wins";
const string csGranted = "You have been granted";
const string csAnd = " and ";
const string csEgg = "**** Bloodsport Version 4.0 by TwentyOneScore ****";
const string csThanks = "Thanks for playing Bloodsport!";
const string csRemovedGame = "Removed Team @ from the game.";
const string csRoundStarts = "Round #@ starts in";
const string csTeamWonRounds = "Team @ won @ rounds.";
const string csCongrats = "Congratulations @!";
const string csForSurviving = "for @ units surviving.";
const string csForRound = "for Round #@.";
const string csRemovedTeam = "Removed @ from Team @.";
const string csNowPlaying = "Now playing @";
const string csRules1 = "You have @ seconds to build an army of up to 30 units to do battle in the Arenas.";
const string csRules2 = "Units are moved to an Arena at the start of each match. The last team standing wins the match.";
const string csRules3 = "Each round you'll receive @ Food/Wood, @ Gold and @ Favor. This increases by @/@ each round.";
const string csRules4 = "Players start with 1 Bolt and gets additional God Powers with each age.";
const string csRules5 = "The game ends when a team wins @ rounds.";

const string csSumPop = "** Units: Created: @ / Survived: @ (@) / Avg Per Round @";
const string csSumHPs = "** HPs: Created: @ / Survived: @ (@) / Avg Per Round @";
const string csAvgHPs = "** Unit Average: @ HPs";

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

// LIST CONSTANTS

int gKbPlayer = 0;
void kbPlayerStore() { gKbPlayer = xsGetContextPlayer(); }
void kbPlayerRestore() { xsSetContextPlayer(gKbPlayer); }

string iif(bool c=true, string t="", string f="") {
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

// PUESDO DB - 3 TABLES WITH 12 ROWS OF 127 CHARS
const int dbTab1 = 1; const int dbTab2 = 2; const int dbTab3 = 3;
string dbT11=""; string dbT12=""; string dbT13=""; string dbT14="";
string dbT15=""; string dbT16=""; string dbT17=""; string dbT18="";
string dbT19=""; string dbT10=""; string dbT1A=""; string dbT1B="";
string dbT21=""; string dbT22=""; string dbT23=""; string dbT24="";
string dbT25=""; string dbT26=""; string dbT27=""; string dbT28="";
string dbT29=""; string dbT20=""; string dbT2A=""; string dbT2B="";
string dbT31=""; string dbT32=""; string dbT33=""; string dbT34="";
string dbT35=""; string dbT36=""; string dbT37=""; string dbT38="";
string dbT39=""; string dbT30=""; string dbT3A=""; string dbT3B="";

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

string dbGetT3(int r=0) {
  if (r==1) return(dbT31); if (r==2) return(dbT32); if (r==3) return(dbT33);
  if (r==4) return(dbT34); if (r==5) return(dbT35); if (r==6) return(dbT36);
  if (r==7) return(dbT37); if (r==8) return(dbT38); if (r==9) return(dbT39);
  if (r==10) return(dbT30); if (r==11) return(dbT3A); return(dbT3B);
}

void dbSetT3(int r=0, string v="") {
  if      (r==1) dbT31=v; else if (r==2) dbT32=v; else if (r==3) dbT33=v;
  else if (r==4) dbT34=v; else if (r==5) dbT35=v; else if (r==6) dbT36=v;
  else if (r==7) dbT37=v; else if (r==8) dbT38=v; else if (r==9) dbT39=v;
  else if (r==10) dbT30=v; else if (r==11) dbT3A=v; else dbT3B=v;
}

string dbGetRow(int t=0, int r=0) {
  if (t==dbTab1) return(dbGetT1(r)); if (t==dbTab2) return(dbGetT2(r)); return(dbGetT3(r));
}

void dbSetRow(int t=0, int r=0, string v="") {
  if (t==dbTab1) dbSetT1(r, v); else if (t==dbTab2) dbSetT2(r, v); else dbSetT3(r, v);
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

int dbGet2d(int t=0, int r=0, int c=0, int p=0) {
  string ints = dbGetStr(t, r, c);
  return(intGet(ints, p));
}

void dbSet2d(int t=0, int r=0, int c=0, int p=0, int v=0) {
  string ints = dbGetStr(t, r, c);
  ints = intSet(ints, p, v);
  dbSetStr(t, r, c, ints);
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
    data = gCivTemple;
    data = listAdd(data, gCivMarket);
    data = listAdd(data, listGet(gCivArmy1, cul+1));
    data = listAdd(data, listGet(gCivArmy2, cul+1));
    data = listAdd(data, listGet(gCivArmy3, cul+1));
    data = listAdd(data, listGet(gCivArmory, armory));
    data = listAdd(data, listGet(gCivKeep, cul+1));
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
  return(listGet(cultureData(p, cCivDataGodPowers), age+1));
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
  trTechGodPower(p, playerAgePower(p, age), uses);
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
    int teamsize = intLen(players);
    if (teamsize==0) continue;
    string data = t + cPI + teamGetWins(t);
    chatf(csTeamWonRounds, data);
    for (pos=1;<=teamsize) {
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
  //trEndGame();
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
    int teamsize = intLen(players);
    if (teamsize==0) continue;
    int p = intGet(players, 1);
    int alive = p;
    if (teamsize>1) alive = teamLast(t);
    string roster = cES;
    string data = cES;
    string name = cES;
    string stats = gameStatLine(teamGetHPs(t), curHPs, teamGetPop(t));
    stats = stats + cPI + teamGetWins(t) + cSP + csWins;
    if (alive!=0) { // 1 player team
      name = playerName(alive);
    } else { // 2 or more
      for (pos=1;<=teamsize) {
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
    for (pos=1;<=teamsize) {
      data = listGet(roster, pos, cLB);
      p = intGet(players, pos);
      if (data==cES) continue;
      data = cSP + cSP + cSP + listAdd(data, playerName(p));
      chatColor(data, p);
    }
  }
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

int unitQryRow(int r=0) {
  return(kbUnitQueryGetResult(gQueryID, r));
}

int unitQryRun(int p=0, int uid=0, int us=2) {
  if (gQueryID==-1) gQueryID = kbUnitQueryCreate(gGameID);
  if (gQueryID==-1) return(-1);
  kbUnitQueryResetData(gQueryID);
  kbUnitQuerySetPlayerID(gQueryID, p);
  kbUnitQuerySetUnitType(gQueryID, uid);
  kbUnitQuerySetState(gQueryID, us);
  return(kbUnitQueryExecute(gQueryID));
}

int armyClearDead(int aid = 0) {
  int aCnt = kbArmyGetNumberUnits(aid);
  int aHPs = 0;
  int uHPs = 0;
  for (j=1;<=aCnt) {
    int uid = kbArmyGetUnitID(aid, aCnt-j);
    uHPs = kbUnitGetCurrentHitpoints(uid);
    if (uHPs<1) kbArmyRemoveUnit(aid, uid);
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
    for (j = 1;<=aCnt) {
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

void battleOver(int team=0) {
  int wins = teamGetWins(team);
  string players = teamGetPlayers(team);
  string names = cES;
  for (p=1;<cNumberPlayers) {
    if (kbGetPlayerTeam(p)==team) names = listAdd(names, playerName(p), csAnd);
  }
  alertf(csCongrats, names);
}

bool checkVictory(int winner=0) {
  if (teamIncWins(winner)==gGameWins) {
    gameOver(winner);
    return(true);
  }
  battleOver(winner);
  return(false);
}

void battleFinish() {
  playerResPop();
  armyRefund();
}

int battleUpdate() {
  int teams = 0;
  int winner = 0;
  kbPlayerStore();
  for (t=1;<=gNumberTeams) {
    teamSetCurHPs(t, 0);
    teamSetPop(t, 0);
    string players = teamGetPlayers(t);
    int teamsize = intLen(players);
    if (teamsize==0) continue;
    for (pos=1;<=teamsize) {
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
      }
    }
    if (teamGetPop(t)>0) {
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

void battleBegin() {
  trSetLighting(gBattleSky, 3.0);
  gameSound(gBattleCry);
  playerResPush();
  emptyBuildings();
  int PlacedTop = 0;
  int PlacedBot = 2;
  int field = ((gRound-1) % 3) * 80;
  int prevteam = 0;
  int slot = aiRandInt(17);
  int offset = 0;
  int spacing = 0;
  if (gNumberTeams >= 4) spacing = 1; else spacing = 2;
  kbPlayerStore();
  for (t=1;<=gNumberTeams) {
    teamSetHPs(t, 0);
    string players = teamGetPlayers(t);
    int teamsize = intLen(players);
    if (teamsize==0) continue;
    for (pos=1;<=teamsize) {
      slot = slot + 1 + spacing;
      int p = intGet(players, pos);
      if (trPlayerActive(p)) {
        xsSetContextPlayer(p);
        emptyBuildings(p);
        int aid = kbArmyGetID(gArmy);
        int aHPs = armyClearDead(aid);
        int aCnt = kbArmyGetNumberUnits(aid);
        playerIncPopTot(p, aCnt);
        playerIncHPsTot(p, aHPs);
        teamIncHPs(t, aHPs);
        if (slot>12) slot = (slot % 12) + 1;
        for (j=(aCnt-1);>=0) {
          if (gNumberTeams==2) {
            if (kbGetPlayerTeam(p)==1)
              unitMove(p, aid, j, field + 25, 170);
            else if (kbGetPlayerTeam(p)==2)
              unitMove(p, aid, j, field + 65, 80);
          } else {
            if (slot >= 1 && slot <= 3) {
              offset = slot-1;
              unitMove(p, aid, j, field + 25 + (offset*20), 170);
            } else if (slot >= 4 && slot <= 6) {
              offset = 6-slot;
              unitMove(p, aid, j, field + 70, 110 + (offset*20));
            } else if (slot >= 7 && slot <= 9) {
              offset = 9-slot;
              unitMove(p, aid, j, field + 25 + (offset*20), 80);
            } else if (slot >= 10 && slot <= 12) {
              offset = slot-10;
              unitMove(p, aid, j, field + 20, 110 + (offset*20));
            }
          }
        }
        trUnitSelectClear();
        trArmySelect(p + cCO + aid);
        trUnitMoveToPoint(field + 45, 0, 122.5);
      }
      slot++;
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
  for (p=1;<cNumberPlayers) {
    if (trPlayerActive(p)) {
      xsSetContextPlayer(p);
      int team = kbGetPlayerTeam(p);
      int teamsize = intLen(teamGetPlayers(team));
      float ratio = gMinTeamCnt / teamsize;
      int MaxUnits = 30 * ratio;
      int aid = kbArmyGetID(gArmy);
      int aHPs = armyClearDead(aid);
      int aCnt = kbArmyGetNumberUnits(aid);
      if (aCnt<MaxUnits) {
        int myCnt = unitQryRun(p, cUnitTypeUnit, cUnitStateAlive);
        for (j=0;<myCnt) {
          int uid = unitQryRow(j);
          if (kbUnitIsType(uid, cUnitTypeMilitary)==false) {
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
    }
  }
  for (t=1;<=gNumberTeams) teamSetCurHPs(t, teamGetHPs(t));
  kbPlayerRestore();
}

void buildTeams() {
  int min = 12;
  for (t=1;<=gNumberTeams) {
    string players = teamGetPlayers(t);
    int teamsize = intLen(players);
    if (teamsize==0) continue;
    string alive = cES;
    for (pos=1;<=teamsize) {
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
    teamsize = intLen(alive);
    if (teamsize==0) {
      chatf(csRemovedGame, str(t));
    } else {
      min = xsMin(min, teamsize);
    }
  }
  gMinTeamCnt = min;
}

void buildResources() {
  for (t=1;<=gNumberTeams) {
    string players = teamGetPlayers(t);
    int teamsize = intLen(players);
    float ratio = gMinTeamCnt / teamsize;
    for (pos=1;<=teamsize) {
      int p = intGet(players, pos);
      gMsg = print(csForRound, str(gRound));
      resAward(p, gMsg, gResRound, gResRound * 1.5, gResRound, gFavRound, ratio);
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
  gGameWins = 7;
  if (cMapSize==1) gGameWins = 11;
  int speed = 7;
  gBuildTime = 55;
  if (vcGetGameplayMode()==cGameModeLightning) {
    speed = 10;
    gBuildTime = 45;
  }
  if (vcGetGameplayMode()==cGameModeDeathmatch) gResRound = 1000;
  trRateResearch(speed);
  trRateTrain(speed);
  gGameWins = 2;
  gBuildTime = 17;
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
  }
}

void setupProtoUnits() {
  gameBlockUnits(gBlockUnits);
  gameBlockUnits(gBlockGarrison);
  gameBlockUnits(gBlockFlying);
}

void setupGodPowers() {
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
    for (pos=1;<=7) {
      trArmySelect(p + cCO + kbArmyGetID(gArmy + pos));
      trUnitChangeProtoUnit(listGet(buildings, pos));
    }
  }
  kbPlayerRestore();
}

void setupHealingString() {
  trTechGodPower(0, gHealString, 1);
  trUnitSelectClear();
  trUnitSelect(gGaiaUnit);
  trTechInvokeGodPower(0, gHealString, vector(45, 0, 122.5), vector(0, 0, 0));
}

void setupMap() {
  alert(csEgg);
  trEventSetHandler(420, gMusicEvent);
  gBattleSong = aiRandInt(17);
  setupBuildings();
  setupHealingString();
}

bool notYet(int when=0, float start=0.0) {
  return((trTime()-start) < when);
}

rule _setup highFrequency active {
  setupOptions();
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
  battleFinish();
  if (checkVictory(winner)) return;
  buildBegin();
  xsDisableSelf();
  xsEnableRule(gBuilding);
}

rule _prevent_building minInterval 3 active {
  if (notYet(3, cActivationTime)) return;
  kbPlayerStore();
  for (p=1;<cNumberPlayers) {
    if (trPlayerActive(p)) {
      xsSetContextPlayer(p);
      int myCnt = unitQryRun(p, cUnitTypeBuilding, cUnitStateBuilding);
      for (j=0;<myCnt) unitKill(unitQryRow(j));
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
    gMsg = listAdd(str(gResRound), str(gResRound*1.5));
    gMsg = listAdd(gMsg, str(gFavRound));
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

rule _test minInterval 1 active {
  xsDisableSelf();
}
