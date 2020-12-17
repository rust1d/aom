// GLOBALS PASSED FROM RM
int cMapSize = 1;
string gPlayers = "TwentyOneScore|Kastor|three|four|five|six|seven|eight|nine|ten";

// GLOBALS
int gQueryID = -1;
int gNumberTeams = 2;
int gBuildEnds = 0;
int gBuildTime = 15;
int gRound = 0;
int gGameWins = 7;
int gTrackBuild = 1;
int gTrackBattle = 1;
int gBuildRes = 1200;
int gBuildFav = 50;
float gMinTeamCnt = 1.0;
bool RoundFlag = false;

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
const string cSP = " ";
const string cDI = "#";
const string cDS = "|";
const string cSL = "/";
// LIST CONSTANTS
const string gResAll = "food|wood|gold|favor";
const string gResFWG = "food|wood|gold";

int gKbPlayer = 0;
void kbPlayerStore() { gKbPlayer = xsGetContextPlayer(); }
void kbPlayerRestore() { xsSetContextPlayer(gKbPlayer); }

void debug(string msg="") { trChatSend(0, msg); }

int pct(int i=0, int d=0) {
  if (d==0) return(0.0);
  int v = (0.0+i)/(0.0+d) * 100.0;
  return(v);
}

string percent(int i=0, int d=0) {
  if (d==0) return("!%");
  return(pct(i,d) + "%");
}

int round(float v = 0.0) {
  int x = v + 0.5;
  return(x);
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
  return(listAdd(list, value+"", delim));
}

int intGet(string list="", int at=1, string delim="#") {
  return(xsStringToInt(listGet(list, at, delim)));
}

int intLen(string list="", string delim="#") {
  return(listLen(list, delim));
}

string intSet(string list="", int at=1, int value=0, string delim="#") {
  return(listSet(list, at, value+"", delim));
}

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
  dbSetStr(t, r, c, ""+v);
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
  return(f + cDI + w + cDI + g + cDI + v);
}

void resAward(int p=0, string why="", int f=0, int w=0, int g=0, int v=0, float r=1.0) {
  string ints = resInts(f*r, w*r, g*r, v*r);
  string msg = cES;
  for (pos=1;<=4) {
    string t = listGet(gResAll, pos);
    int i = intGet(ints, pos);
    if (i>0) {
      msg = listAdd(msg, cES + i + cSP + t, cSL);
      trPlayerGrantResources(p, t, i);
    }
  }
  trChatSendToPlayer(0, p, "You were awarded" + cSP + msg + cSP + why);
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
  if (type==cCivDataGodPowers) {
    string all = "Bolt|Restoration|Bronze|Lightning Storm";
    if (cul==cCultureGreek) return(listSet(all, 3, "Bronze"));
    if (cul==cCultureEgyptian) return(listSet(all, 3, "Skeleton Power"));
    if (cul==cCultureNorse) return(listSet(all, 3, "Flaming Weapons"));
    if (cul==cCultureAtlantean) return(listSet(all, 3, "Geyser"));
    if (cul==cCultureChinese) return(listSet(all, 3, "Geyser"));
  } else if (type==cCivDataBuildings) {
    if (cul==cCultureGreek) return("Temple|Market|Academy|Archery Range|Stable|Armory|Fortress");
    if (cul==cCultureEgyptian) return("Temple|Market|Barracks|Barracks|Barracks|Armory|Migdol Stronghold");
    if (civ==cCivThor) return("Temple|Market|LongHouse|LongHouse|LongHouse|Dwarf Foundry|Hill Fort");
    if (cul==cCultureNorse) return("Temple|Market|LongHouse|LongHouse|LongHouse|Armory|Hill Fort");
    if (cul==cCultureAtlantean) return("Temple|Market|Barracks Atlantean|Barracks Atlantean|Counter Building|Armory|Palace");
  }
  return (cES);
}

string powerForAge(int p=0, int age=0) {
  return(listGet(cultureData(p, cCivDataGodPowers), age+1));
}

// LOCAL DB DEFINITION
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
const int dbPlayer   = dbTab2;
const int dbpAge     = 1;
const int dbpPop     = 2;
const int dbpHPs     = 3;
const int dbpHPsTot  = 4;
const int dbpPopTot  = 5;
const int dbpHPsSrv  = 6;
const int dbpPopSrv  = 7;
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

// PLAYER HELPERS
string playerColor(int p=0, string msg="") {
  return("<color={playerColor("+p+")}>"+msg+"</color>");
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
  string power = powerForAge(p, age);
  if (uses>0) trChatSendToPlayer(0, p, "You have been granted" + cSP + power);
  trTechGodPower(p, powerForAge(p, age), uses);
}

string playerName(int p=0) {
  return(listGet(gPlayers, p));
}

void playerResPop() {
  for (p=1;<cNumberPlayers) {
    resSet(p, "Favor", 0);
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

int buildTimeLeft() {
  return (gBuildEnds-trTime());
}

void statsHide() {
  for (t=1;<=gNumberTeams) {
    trCounterAbort("Team" + t);
    trCounterAbort("Roster" + t);
  }
}

void statsShow(bool health = false) {
  statsHide();
  for (i=1;<=gNumberTeams) {
    int curHPs = teamGetCurHPs(i);
    if (curHPs==0) continue;
    string players = teamGetPlayers(i);
    int teamsize = intLen(players);
    if (teamsize==0) continue;
    string team = curHPs + cSL + teamGetPop(i);
    string play = cES;
    string stats = cES;
    string name = "T-" + players;
    int timeout = 9;
    int color = 0;
    int alive = teamsize;
    if (teamsize==1) {
      color = intGet(players, 1);
    } else {
      for (pos=1;<=teamsize) {
        int p = intGet(players, pos);
        int pop = playerGetPop(p);
        if (pop==0) {
          alive--;
          continue;
        }
        string data = playerGetHPs(p) + cSL + pop;
        stats = listAdd(stats, p + ":" + data, cSP);
        play = listAdd(play, playerColor(p, data));
      }
      if (alive==1) color = p;
    }
    if (alive==1) name = playerName(color);
    if (health) {
      name = listAdd(name, percent(curHPs, teamGetHPs(i)));
    } else {
      timeout = buildTimeLeft();
      name = listAdd(name, teamGetWins(i) + cSP + "Wins");
    }
    team = playerColor(color, team);
    team = listAdd(stats, team + cDS + name);
    trCounterAddTime("Team" + i, timeout, 1, team, -1);
    if (alive>1) trCounterAddTime("Roster" + i, timeout, 1, play, -1);
  }
}

void unitKill(int uid=0, int p=0) {
  if (p>0) resInc(p, gResFWG, kbUnitGetCurrentAICost(uid)/3);
  trUnitSelectClear();
  trUnitSelectByID(uid);
  trUnitDelete(true);
}

int unitQryRun(int p=0, int uid=0, int us=2) {
  if (gQueryID==-1) gQueryID = kbUnitQueryCreate("gQueryID");
  if (gQueryID==-1) return(-1);
  kbUnitQueryResetData(gQueryID);
  kbUnitQuerySetPlayerID(gQueryID, p);
  kbUnitQuerySetUnitType(gQueryID, uid);
  kbUnitQuerySetState(gQueryID, us);
  return(kbUnitQueryExecute(gQueryID));
}

int unitQryRow(int r=0) {
  return(kbUnitQueryGetResult(gQueryID, r));
}

bool forbidProtounits(string list="") {
  int len = listLen(list);
  for (pos=1;<=len) {
    string t = listGet(list, pos);
    for (p=1;<cNumberPlayers) trForbidProtounit(p, t);
  }
}

void mp3(string file="", int event=420) {
  file = file + ".mp3";
  //trChatSend(0, "Now Playing " + listGet(file, 3, "/"));
  trSoundPlayDialog(file, "1", event, true, cES, cES);
}

void PlayBattleTrack(int eventID = -1) {
  gTrackBattle = (gTrackBattle + aiRandInt(3)) % 17;
  if      (gTrackBattle==0)  mp3("music/fight/li'l drips");
  else if (gTrackBattle==1)  mp3("music/fight/oi, that pops!!!");
  else if (gTrackBattle==2)  mp3("music/fight/meatier shower");
  else if (gTrackBattle==3)  mp3("music/interface/gank sneakin'");
  else if (gTrackBattle==4)  mp3("music/interface/a cat named mittens");
  else if (gTrackBattle==5)  mp3("music/interface/ma'am...some other sunset");
  else if (gTrackBattle==6)  mp3("music/standard/the ballad of ace lebaron");
  else if (gTrackBattle==7)  mp3("music/standard/(fine layers of) slaysenflite");
  else if (gTrackBattle==8)  mp3("music/standard/adult swim");
  else if (gTrackBattle==9)  mp3("music/standard/chocolate outline");
  else if (gTrackBattle==10) mp3("music/standard/eat your potatoes");
  else if (gTrackBattle==11) mp3("music/standard/flavor cats (in the comfort zone)");
  else if (gTrackBattle==12) mp3("music/standard/hoping for real betterness");
  else if (gTrackBattle==13) mp3("music/standard/in a pile of its own good");
  else if (gTrackBattle==14) mp3("music/standard/never mind the slacks and bashers");
  else if (gTrackBattle==15) mp3("music/standard/suture self");
  else if (gTrackBattle==16) mp3("music/standard/behold the great science fi");
}

void PlayBuildTrack() {
  trMusicStop();
  if      (gTrackBuild==0) mp3("music/culture/greek to me", -1);
  else if (gTrackBuild==1) mp3("music/culture/n. d. nile", -1);
  else if (gTrackBuild==2) mp3("music/fight/i wish i could throw shapes", -1);
  else if (gTrackBuild==3) mp3("music/fight/rot loaf", -1);
  else if (gTrackBuild==4) mp3("music/fight/the fire brigade", -1);
  else if (gTrackBuild==5) mp3("music/interface/if you can use a doorknob", -1);
  else if (gTrackBuild==6) mp3("music/culture/of norse not!", -1);
  else if (gTrackBuild==7) mp3("xpack/xmusic/hotlantis", -1);
  else if (gTrackBuild==8) mp3("xpack/xcinematics/tutorial/music", -1);
  else if (gTrackBuild==9) mp3("xpack/xcinematics/8_in/music", -1);
  gTrackBuild = (gTrackBuild + aiRandInt(3)) % 10;
}

void teamResize() {
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
        debug("Removed " + playerName(p) + " from team " + t);
      }
    }
    teamSetPlayers(t, alive);
    teamsize = intLen(alive);
    if (teamsize==0) {
      debug("Removed team " + t + " from the game.");
    } else {
      min = xsMin(min, teamsize);
    }
  }
  gMinTeamCnt = min;
}

void winGame(int winner=0) {
  trMusicStop();
  for (i=1;<cNumberPlayers) {
    trChatSend(0, playerColor(i,playerName(i) + ": "));
    int totHPs = playerGetHPsTot(i);
    int totPop = playerGetPopTot(i);
    int srvHPs = playerGetHPsSrv(i);
    int srvPop = playerGetPopSrv(i);
    string pctPop = percent(srvPop, totPop);
    string pctHPs = percent(srvHPs, totHPs);
    int avgPop = round((totPop+0.0)/gRound);
    int avgHPs = round((totHPs+0.0)/gRound);
    int avgUnitHPs = totHPs/totPop;
    string msg = "** Units: " + totPop + " Created / " + srvPop + " Survived (" + pctPop;
    msg = msg + ") / " + avgPop + " Avg Per Round ";
    trChatSend(0, playerColor(i,msg));
    msg = "** Hitpoints: " + totHPs + " Created / " + srvHPs + " Survived (" + pctHPs;
    msg = msg + ") / " + avgHPs + " Avg Per Round ";
    trChatSend(0, playerColor(i, msg));
    msg = "** Unit Average: " + avgUnitHPs + " hitpoints ";
    trChatSend(0, playerColor(i, msg));
  }
  trChatSendSpoofed(0, "Thanks for playing BloodSport!");
  for (i = 1;<=gNumberTeams) {
    string players = teamGetPlayers(i);
    msg = "Team " + i + " (" + players + ") won " + teamGetWins(i) + " rounds";
    trChatSendSpoofed(i, msg);
  }

  trMessageSetText("****** BloodSport by TwentyOneScore ****** ", 6000);
  trSoundPlayFN("/dialog/en/skul062.mp3", "1", -1, "", "");
  mp3("/music/standard/behold the great science fi", -1);

  for (i=1;<cNumberPlayers) {
    if (kbGetPlayerTeam(i)==winner) {
      trSetPlayerWon(i);
    } else {
      playerGameOver(i);
    }
  }
  xsDisableRule("_battling");
  //trEndGame();
}

void winRound(int team=0) {
  int wins = teamGetWins(team);
  string players = teamGetPlayers(team);
  string msg = "Team" + cSP + players + " has won " + wins + " round";
  if (wins>1) msg = msg + "s";
  trChatSend(0, msg);
  msg = "";
  for (i=1;<cNumberPlayers) {
    if (kbGetPlayerTeam(i)==team) msg = listAdd(msg, playerName(i), " and ");
  }
  trMessageSetText("Congratulations " + msg + "!", 6000);
}

int armyClearDead(int aid = 0) {
  int aCnt = kbArmyGetNumberUnits(aid);
  int aHPs = 0;
  int uHPs = 0;
  for (j=1;<=aCnt) {
    int uid = kbArmyGetUnitID(aid, aCnt-j);
    uHPs = kbUnitGetCurrentHitpoints(uid);
    if (uHPs==0) kbArmyRemoveUnit(aid, uid);
    aHPs = aHPs + uHPs;
  }
  return(aHPs);
}

void refundSurvivors() {
  kbPlayerStore();
  for (p=1;<cNumberPlayers) {
    xsSetContextPlayer(p);
    int aid = kbArmyGetID("armyIn" + p);
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
      string msg = "for" + cSP + aCnt + cSP + "units surviving.";
      resAward(p, msg, bonus, bonus, bonus, aCnt);
    }
  }
  kbPlayerRestore();
}

void updateResources() {
  for (t=1;<=gNumberTeams) {
    string players = teamGetPlayers(t);
    int teamsize = intLen(players);
    float ratio = gMinTeamCnt / teamsize;
    for (pos=1;<=teamsize) {
      int p = intGet(players, pos);
      resAward(p, "for round #" + gRound, gBuildRes, gBuildRes * 1.5, gBuildRes, gBuildFav);
    }
  }
  gBuildRes = gBuildRes + 50;
  gBuildFav = gBuildFav + 5;
}

void updateTech() {
  for (p=1;<cNumberPlayers) {
    if (gRound==3) trTechSetStatus(p, cTechAge3Aphrodite, cTechStatusAvailable);
    if (gRound==5) trTechSetStatus(p, cTechAge4Artemis, cTechStatusAvailable);
    if ((gRound % 6)==0) playerGrantPower(p, cAge1, 1);
    if ((gRound % 8)==0) playerGrantPower(p, cAge2, 1);
  }
}

bool checkVictory(int winner=0) {
  if (teamIncWins(winner)==gGameWins) {
    winGame(winner);
    return(true);
  }
  winRound(winner);
  return(false);
}

void battleFinish() {
  statsHide();
  playerResPop();
  refundSurvivors();
}

int battleUpdate() {
  int teams = 0;
  int winner = 0;
  kbPlayerStore();
  for (i=1;<=gNumberTeams) {
    teamSetCurHPs(i, 0);
    teamSetPop(i, 0);
    if (RoundFlag) teamSetHPs(i, 0);
    string players = teamGetPlayers(i);
    int teamsize = intLen(players);
    if (teamsize==0) continue;
    for (pos=1;<=teamsize) {
      int p = intGet(players, pos);
      if (trPlayerActive(p)) {
        xsSetContextPlayer(p);
        int aid = kbArmyGetID("armyIn" + p);
        int aHPs = armyClearDead(aid);
        int aCnt = kbArmyGetNumberUnits(aid);
        playerSetPop(p, aCnt);
        playerSetHPs(p, aHPs);
        if (aCnt>0) {
          if (RoundFlag) {
            playerIncPopTot(p, aCnt);
            playerIncHPsTot(p, aHPs);
            teamIncHPs(i, aHPs);
          }
          teamIncPop(i, aCnt);
          teamIncCurHPs(i, aHPs);
        }
      }
    }
    if (teamGetPop(i)>0) {
      teams++;
      winner = i;
    }
  }
  kbPlayerRestore();
  statsShow(true);
  RoundFlag = false;
  if (teams>1) return(0);

  return(winner);
}

void moveSolider(int p=1, int aid=1, int pos=1, int x=0, int z=0) {
  int uid = kbArmyGetUnitID(aid, pos);
  string PUN = kbGetProtoUnitName(kbGetUnitBaseTypeID(uid));
  kbArmyRemoveUnit(aid, uid);
  unitKill(uid);
  trArmyDispatch(p + "," + aid, PUN, 1, x, 0, z, 1, false);
}

void emptyBuildings(int p=0) {
  for (pos=0;<8) {
    int aid = kbArmyGetID("Bldg" + pos);
    int uid = kbArmyGetUnitID(aid, 0);
    trUnitSelectClear();
    trUnitSelectByID(uid);
    trUnitEjectContained();
  }
}

void battleBegin() {
  trSetLighting("Default", 3.0);
  trSoundPlayFN("battlecry4.wav", "1", 420, "", "");
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
  for (i=1;<=gNumberTeams) {
    string players = teamGetPlayers(i);
    int teamsize = intLen(players);
    if (teamsize==0) continue;
    for (pos=1;<=teamsize) {
      slot = slot + 1 + spacing;
      int p = intGet(players, pos);
      if (trPlayerActive(p)) {
        xsSetContextPlayer(p);
        emptyBuildings(p);
        if (slot>12) slot = (slot % 12) + 1;
        int aid = kbArmyGetID("armyIn" + p);
        int aCnt = kbArmyGetNumberUnits(aid)-1;
        RoundFlag = true;
        for (j=aCnt;>=0) {
          if (gNumberTeams==2) {
            if (kbGetPlayerTeam(p)==1)
              moveSolider(p, aid, j, field + 25, 170);
            else if (kbGetPlayerTeam(p)==2)
              moveSolider(p, aid, j, field + 65, 80);
          } else {
            if (slot >= 1 && slot <= 3) {
              offset = slot-1;
              moveSolider(p, aid, j, field + 25 + (offset*20), 170);
            } else if (slot >= 4 && slot <= 6) {
              offset = 6-slot;
              moveSolider(p, aid, j, field + 70, 110 + (offset*20));
            } else if (slot >= 7 && slot <= 9) {
              offset = 9-slot;
              moveSolider(p, aid, j, field + 25 + (offset*20), 80);
            } else if (slot >= 10 && slot <= 12) {
              offset = slot-10;
              moveSolider(p, aid, j, field + 20, 110 + (offset*20));
            }
          }
        }
        trUnitSelectClear();
        trArmySelect(p + "," + aid);
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
      float ratio = teamsize;
      ratio = gMinTeamCnt / ratio;
      int MaxUnits = 30 * ratio;
      int aid = kbArmyGetID("armyIn" + p);
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
  for (t=1;<=gNumberTeams) teamSetCurHPs(t, teamGetHPs(team));
  kbPlayerRestore();
  statsShow();
}

void buildBegin() {
  gBuildEnds = trTime() + gBuildTime;
  gRound++;
  teamResize();
  updateResources();
  updateTech();
  trSoundPlayFN("sentinelbirth.wav", "1", -1, cES, cES);
  trSetLighting("Anatolia", 5.0);
  PlayBuildTrack();
  trCounterAddTime("countdown", buildTimeLeft(), 1, "Round #" + gRound + " Starts In", -1);
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
  if (vcGetGameplayMode()==cGameModeDeathmatch) gBuildRes = 1000;
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
  for (i=1;<cNumberPlayers) {
    trPlayerTechTreeEnabledGodPowers(i, false);
    for (j = 0;<=41) trTechSetStatus(i, cTechRelicEyeofHorus, cTechStatusActive);
    for (j = 0;<=10) trTechSetStatus(i, cTechRelicNoseoftheSphinx, cTechStatusActive);
    trTechSetStatus(i, cTechAge3Aphrodite, cTechStatusUnobtainable);
    trTechSetStatus(i, cTechAge4Artemis, cTechStatusUnobtainable);
    trTechSetStatus(i, cTechOdinsFirstRavens, cTechStatusUnobtainable);
    trTechSetStatus(i, cTechOdinsRavenRespawn, cTechStatusUnobtainable);
    trTechSetStatus(i, cTechStartingUnitsAtlantean, cTechStatusUnobtainable);
    trTechSetStatus(i, cTechStartingUnitsEgyptian, cTechStatusUnobtainable);
    trTechSetStatus(i, cTechStartingUnitsGreek, cTechStatusUnobtainable);
    trTechSetStatus(i, cTechStartingUnitsNorse, cTechStatusUnobtainable);
    trTechSetStatus(i, cTechStartingUnitsThor, cTechStatusUnobtainable);
  }
}

void setupProtoUnits() {
  forbidProtounits("Shade of Hades|Shade");
  forbidProtounits("Helepolis|Siege Tower");
  forbidProtounits("Pegasus|Roc|flying medic|Stymphalian Bird|Vermilion Bird");
}

void setupGodPowers() {
  for (p=1;<cNumberPlayers) {
    trPlayerSetDiplomacy(p, 0, "enemy");
    trPlayerSetDiplomacy(0, p, "enemy");
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
      trArmySelect(p + "," + kbArmyGetID("Bldg" + pos));
      trUnitChangeProtoUnit(listGet(buildings, pos));
    }
  }
  kbPlayerRestore();
}

void setupMap() {
  trMessageSetText("**** BloodSport Version 4.0 by TwentyOneScore ****", 4000);
  trEventSetHandler(420, "PlayBattleTrack");
  gTrackBattle = (gTrackBattle + aiRandInt(17)) % 15;
  setupBuildings();
  trTechGodPower(0, "Healing Spring", 1);
  trUnitSelectClear();
  trUnitSelect("default");
  trTechInvokeGodPower(0, "Healing Spring", vector(45, 0, 122.5), vector(0, 0, 0));
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
  xsEnableRule("_building");
}

rule _building minInterval 2 inactive {
  if (notYet(2, cActivationTime)) return;
  kbLookAtAllUnitsOnMap(); // TESTING FOR AI
  buildArmy();
  if (buildTimeLeft()>0) return;
  battleBegin();
  xsDisableSelf();
  xsEnableRule("_battling");
}

rule _battling minInterval 2 inactive {
  if (notYet(2, cActivationTime)) return;
  kbLookAtAllUnitsOnMap(); // TESTING FOR AI
  int winner = battleUpdate();
  if (winner==0) return;
  battleFinish();
  if (checkVictory(winner)) return;
  buildBegin();
  xsDisableSelf();
  xsEnableRule("_building");
}

rule _prevent_building minInterval 3 active {
  if (notYet(3, cActivationTime)) return;
  kbPlayerStore();
  for (i=1;<cNumberPlayers) {
    if (trPlayerActive(i)) {
      xsSetContextPlayer(i);
      int myCnt = unitQryRun(i, cUnitTypeBuilding, cUnitStateBuilding);
      for (j=0;<myCnt) unitKill(unitQryRow(j));
    }
  }
  kbPlayerRestore();
}

rule _instructions minInterval 6 active {
  int x = trTime()-cActivationTime;
  if (x<6) return;
  if (x/6==1)
    trMessageSetText("You have " + gBuildTime + " seconds to build a team of up to 30 units to do " + "battle in the Arenas.", 5000);
  else if (x/6==2)
    trMessageSetText("Units are moved to an Arena at the start of each match. " + "The last team standing wins the match.", 6000);
  else if (x/6==3)
    trMessageSetText("Each round you'll receive " + gBuildRes + " Food & Wood/" + gBuildRes*1.5 + " Gold/" + gBuildFav + " Favor. This increases by 50/5 each round.", 6000);
  else if (x/6==4)
    trMessageSetText("Players start with 1 Bolt and gets another and an additional God Power for each age.", 5000);
  else {
    trMessageSetText("The game ends when a team wins " + gGameWins + " rounds.", 5000);
    xsDisableSelf();
  }
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
