#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/killstreaks/_supplydrop;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace hun;

// Namespace hun
// Params 0, eflags: 0x0
// Checksum 0x25f9db73, Offset: 0x378
// Size: 0x121
function main() {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 50000);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 0, 0, 1440);
    level.scoreroundwinbased = 1;
    level.resetplayerscoreeveryround = 1;
    level.onstartgametype = &onstartgametype;
    level.givecustomloadout = &givecustomloadout;
    level.var_6af67392 = getgametypesetting("objectiveSpawnTime");
    gameobjects::register_allowed_gameobject("dm");
    InvalidOpCode(0xc8, "dialog", "gametype", "ffa_start");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace hun
// Params 0, eflags: 0x0
// Checksum 0x16b627ef, Offset: 0x538
// Size: 0x29a
function onstartgametype() {
    setclientnamemode("auto_change");
    util::setobjectivetext("allies", %OBJECTIVES_DM);
    util::setobjectivetext("axis", %OBJECTIVES_DM);
    if (level.splitscreen) {
        util::setobjectivescoretext("allies", %OBJECTIVES_DM);
        util::setobjectivescoretext("axis", %OBJECTIVES_DM);
    } else {
        util::setobjectivescoretext("allies", %OBJECTIVES_DM_SCORE);
        util::setobjectivescoretext("axis", %OBJECTIVES_DM_SCORE);
    }
    util::setobjectivehinttext("allies", %OBJECTIVES_DM_HINT);
    util::setobjectivehinttext("axis", %OBJECTIVES_DM_HINT);
    spawning::create_map_placed_influencers();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    spawnlogic::add_spawn_points("allies", "mp_dm_spawn");
    spawnlogic::add_spawn_points("axis", "mp_dm_spawn");
    spawning::updateallspawnpoints();
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    level.usestartspawns = 0;
    level.displayroundendtext = 0;
    level thread onscoreclosemusic();
    if (!util::isoneround()) {
        level.displayroundendtext = 1;
    }
    level.var_64e95656 = spawn("script_origin", (0, 0, 0));
    initdroplocations();
    function_ca6c069a();
    thread function_d67100ee();
}

// Namespace hun
// Params 1, eflags: 0x0
// Checksum 0x2c932698, Offset: 0x7e0
// Size: 0x40
function onendgame(winningplayer) {
    if (isdefined(winningplayer) && isplayer(winningplayer)) {
        [[ level._setplayerscore ]](winningplayer, winningplayer [[ level._getplayerscore ]]() + 1);
    }
}

// Namespace hun
// Params 0, eflags: 0x0
// Checksum 0xd2bc468, Offset: 0x828
// Size: 0x114
function givecustomloadout() {
    self takeallweapons();
    self clearperks();
    weapon = getweapon("pistol_standard");
    self.primaryweapon = weapon;
    self.var_803c4dd7 = getweapon("hatchet");
    self.var_91a5eb04 = undefined;
    self giveweapon(weapon);
    self giveweapon(level.weaponbasemelee);
    self giveweapon(level.weaponbasemeleeheld);
    self giveweapon(self.var_803c4dd7);
    self setweaponammostock(weapon, 0);
    self setweaponammoclip(weapon, 5);
    self switchtoweapon(weapon);
    self setspawnweapon(weapon);
    return weapon;
}

// Namespace hun
// Params 0, eflags: 0x0
// Checksum 0x53106a5c, Offset: 0x948
// Size: 0x9d
function onscoreclosemusic() {
    while (!level.gameended) {
        scorelimit = level.scorelimit;
        scorethreshold = scorelimit * 0.9;
        for (i = 0; i < level.players.size; i++) {
            scorecheck = [[ level._getplayerscore ]](level.players[i]);
            if (scorecheck >= scorethreshold) {
                thread globallogic_audio::set_music_on_team("timeOut");
                return;
            }
        }
        wait 0.5;
    }
}

// Namespace hun
// Params 2, eflags: 0x0
// Checksum 0xd9745599, Offset: 0x9f0
// Size: 0x79
function function_9ff676f3(node_origin, bounds) {
    mins = level.mapcenter - bounds;
    maxs = level.mapcenter + bounds;
    if (node_origin[0] > maxs[0]) {
        return false;
    }
    if (node_origin[0] < mins[0]) {
        return false;
    }
    if (node_origin[1] > maxs[1]) {
        return false;
    }
    if (node_origin[1] < mins[1]) {
        return false;
    }
    return true;
}

// Namespace hun
// Params 0, eflags: 0x0
// Checksum 0xc682332b, Offset: 0xa78
// Size: 0xe2
function initdroplocations() {
    scalar = 0.8;
    bound = (level.spawnmaxs - level.mapcenter) * scalar;
    var_50f11a0a = getallnodes();
    nodes = [];
    count = 0;
    foreach (node in var_50f11a0a) {
        if (function_9ff676f3(node.origin, bound)) {
            nodes[nodes.size] = node;
            count++;
        }
    }
    level.var_6f7acf19 = nodes;
}

// Namespace hun
// Params 0, eflags: 0x0
// Checksum 0x2643b5df, Offset: 0xb68
// Size: 0x1ea
function function_ca6c069a() {
    supplydrop::function_56447f63("hunted", "weapon", "smg_standard", 1, %WEAPON_SMG_STANDARD, undefined, &function_df09c95a, &function_d8bb4921);
    supplydrop::function_56447f63("hunted", "weapon", "ar_standard", 1, %WEAPON_AR_STANDARD, undefined, &function_df09c95a, &function_d8bb4921);
    supplydrop::function_56447f63("hunted", "weapon", "lmg_light", 1, %WEAPON_LMG_LIGHT, undefined, &function_df09c95a, &function_d8bb4921);
    supplydrop::function_56447f63("hunted", "weapon", "shotgun_pump", 1, %WEAPON_SHOTGUN_PUMP, undefined, &function_df09c95a, &function_d8bb4921);
    supplydrop::function_56447f63("hunted", "weapon", "pistol_standard", 1, %WEAPON_PISTOL_STANDARD, undefined, &function_df09c95a, &function_d8bb4921);
    supplydrop::setcategorytypeweight("hunted", "weapon", 4);
    supplydrop::setcategorytypeweight("hunted", "killstreak", 1);
    supplydrop::function_ce670156("hunted");
}

// Namespace hun
// Params 1, eflags: 0x0
// Checksum 0x3d9ee471, Offset: 0xd60
// Size: 0x62
function function_df09c95a(weapon) {
    if (isdefined(self.primaryweapon)) {
        self takeweapon(self.primaryweapon);
    }
    self.primaryweapon = weapon;
    self giveweapon(weapon);
    self switchtoweapon(weapon);
    self setweaponammostock(weapon, 0);
}

// Namespace hun
// Params 1, eflags: 0x0
// Checksum 0xdae3e1eb, Offset: 0xdd0
// Size: 0x92
function function_deb51712(weapon) {
    if (self.var_803c4dd7 == weapon) {
        var_93a433cd = self getammocount(weapon);
        self setweaponammostock(weapon, var_93a433cd + 1);
        return;
    }
    if (isdefined(self.var_803c4dd7)) {
        self takeweapon(self.var_803c4dd7);
    }
    self.var_803c4dd7 = weapon;
    self giveweapon(weapon);
    self setoffhandprimaryclass(weapon);
}

// Namespace hun
// Params 1, eflags: 0x0
// Checksum 0xfa172912, Offset: 0xe70
// Size: 0x92
function function_c62032e9(weapon) {
    if (self.var_91a5eb04 == weapon) {
        var_93a433cd = self getammocount(weapon);
        self setweaponammostock(weapon, var_93a433cd + 1);
        return;
    }
    if (isdefined(self.var_91a5eb04)) {
        self takeweapon(self.var_91a5eb04);
    }
    self.var_91a5eb04 = weapon;
    self giveweapon(weapon);
    self setoffhandsecondaryclass(weapon);
}

// Namespace hun
// Params 4, eflags: 0x0
// Checksum 0xe77b91f9, Offset: 0xf10
// Size: 0x7a
function function_d8bb4921(crate, category, owner, team) {
    crate.visibletoall = 1;
    crate supplydrop::crateactivate();
    crate thread supplydrop::crateusethink();
    crate thread supplydrop::crateusethinkowner();
    supplydrop::default_land_function(crate, category, owner, team);
}

// Namespace hun
// Params 0, eflags: 0x0
// Checksum 0x6a532460, Offset: 0xf98
// Size: 0xbd
function function_390f311() {
    node = undefined;
    time = 10000;
    while (!isdefined(node)) {
        random_index = randomint(level.var_6f7acf19.size);
        if (!isdefined(level.var_6f7acf19[random_index])) {
            continue;
        }
        node_origin = level.var_6f7acf19[random_index].origin;
        if (!bullettracepassed(node_origin + (0, 0, 1000), node_origin, 0, undefined)) {
            level.var_6f7acf19[random_index] = undefined;
            continue;
        }
        node = level.var_6f7acf19[random_index];
        break;
    }
    return node.origin;
}

// Namespace hun
// Params 0, eflags: 0x0
// Checksum 0x5648c83, Offset: 0x1060
// Size: 0x75
function function_d67100ee() {
    wait_time = level.var_6af67392;
    time = 10000;
    while (true) {
        wait wait_time;
        origin = function_390f311();
        self thread supplydrop::helidelivercrate(origin, "hunted", level.var_64e95656, "free", 0, 0);
    }
}

