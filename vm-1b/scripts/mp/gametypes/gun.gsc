#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/persistence_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/weapons/_weapon_utils;

#namespace gun;

// Namespace gun
// Params 0, eflags: 0x0
// Checksum 0x12fa89bf, Offset: 0x5e8
// Size: 0x9da
function main() {
    globallogic::init();
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onplayerkilled = &onplayerkilled;
    level.onendgame = &onendgame;
    globallogic_audio::set_leader_gametype_dialog("startGunGame", "hcSstartGunGame", "", "");
    level.givecustomloadout = &givecustomloadout;
    level.setbacksperdemotion = getgametypesetting("setbacks");
    gameobjects::register_allowed_gameobject(level.gametype);
    level.gunprogression = [];
    gunlist = getgametypesetting("gunSelection");
    if (gunlist == 3) {
        gunlist = randomintrange(0, 3);
    }
    switch (gunlist) {
    case 0:
        addguntoprogression("pistol_standard", "fastreload", "steadyaim");
        addguntoprogression("pistol_burst_dw");
        addguntoprogression("pistol_fullauto", "reflex");
        addguntoprogression("shotgun_pump", "extbarrel", "suppressed");
        addguntoprogression("shotgun_precision", "qucikdraw", "holo");
        addguntoprogression("shotgun_fullauto", "extclip");
        addguntoprogression("smg_versatile", "grip", "extbarrel");
        addguntoprogression("smg_burst", "suppressed");
        addguntoprogression("smg_longrange", "reflex");
        addguntoprogression("ar_cqb", "rf", "fastreload");
        addguntoprogression("ar_standard", "fmj", "damage");
        addguntoprogression("ar_longburst", "acog");
        addguntoprogression("ar_marksman", "ir");
        addguntoprogression("lmg_slowfire", "extclip");
        addguntoprogression("lmg_cqb", "quickdraw", "steadyaim");
        addguntoprogression("sniper_fastbolt", "swayreduc");
        addguntoprogression("sniper_powerbolt", "reddot");
        addguntoprogression("launcher_standard");
        addguntoprogression("knife_loadout");
        addguntoprogression("bare_hands");
        break;
    case 1:
        addguntoprogression("pistol_standard", "reddot");
        addguntoprogression("pistol_fullauto_dw", "reflex");
        addguntoprogression("pistol_standard_dw");
        addguntoprogression("pistol_burst_dw");
        addguntoprogression("pistol_fullauto_dw");
        addguntoprogression("shotgun_semiauto", "steadyaim");
        addguntoprogression("shotgun_fullauto", "suppressed");
        addguntoprogression("shotgun_pump", "quickdraw");
        addguntoprogression("shotgun_precision", "reddot");
        addguntoprogression("smg_fastfire", "holo");
        addguntoprogression("smg_standard", "quickdraw");
        addguntoprogression("smg_versatile", "suppressed");
        addguntoprogression("smg_capacity", "stalker");
        addguntoprogression("smg_longrange", "rf");
        addguntoprogression("smg_burst", "reddot");
        addguntoprogression("lmg_cqb", "quickdraw");
        addguntoprogression("launcher_standard");
        addguntoprogression("sniper_powerbolt", "reddot");
        addguntoprogression("knife_loadout");
        addguntoprogression("bare_hands");
        break;
    case 2:
        addguntoprogression("smg_capacity", "holo", "quickdraw");
        addguntoprogression("smg_longrange", "acog", "extclip");
        addguntoprogression("ar_cqb", "acog");
        addguntoprogression("ar_standard", "reflex");
        addguntoprogression("ar_longburst", "extbarrel");
        addguntoprogression("ar_fastburst", "holo");
        addguntoprogression("ar_marksman", "acog");
        addguntoprogression("ar_damage", "reddot");
        addguntoprogression("ar_accurate", "ir", "extbarrel");
        addguntoprogression("lmg_light", "ir");
        addguntoprogression("lmg_cqb", "reflex");
        addguntoprogression("lmg_heavy", "acog");
        addguntoprogression("lmg_slowfire", "ir", "extclip");
        addguntoprogression("sniper_fastsemi", "swayreduc", "stalker");
        addguntoprogression("sniper_fastbolt", "acog", "rf");
        addguntoprogression("sniper_chargeshot", "swayreduc", "ir");
        addguntoprogression("sniper_powerbolt", "stalker", "fastreload");
        addguntoprogression("launcher_standard");
        addguntoprogression("knife_loadout");
        addguntoprogression("bare_hands");
        break;
    }
    util::registertimelimit(0, 1440);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    if (!sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen()) {
        globallogic::setvisiblescoreboardcolumns("pointstowin", "kills", "stabs", "humiliated", "deaths");
        return;
    }
    globallogic::setvisiblescoreboardcolumns("pointstowin", "kills", "deaths", "stabs", "humiliated");
}

// Namespace gun
// Params 0, eflags: 0x0
// Checksum 0xad455ad4, Offset: 0xfd0
// Size: 0x1da
function onstartgametype() {
    level.gungamekillscore = rank::getscoreinfovalue("kill_gun");
    util::registerscorelimit(level.gunprogression.size * level.gungamekillscore, level.gunprogression.size * level.gungamekillscore);
    setdvar("scr_xpscale", 0);
    setdvar("ui_weapon_tiers", level.gunprogression.size);
    setclientnamemode("auto_change");
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    foreach (team in level.teams) {
        setupteam(team);
    }
    level.usestartspawns = 1;
    level.spawn_start = spawnlogic::get_spawnpoint_array("mp_dm_spawn_start");
    spawning::create_map_placed_influencers();
    spawning::updateallspawnpoints();
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    level.displayroundendtext = 0;
}

// Namespace gun
// Params 1, eflags: 0x0
// Checksum 0xb1377e19, Offset: 0x11b8
// Size: 0x2a
function onspawnplayer(predictedspawn) {
    spawning::onspawnplayer(predictedspawn);
    self thread infiniteammo();
}

// Namespace gun
// Params 9, eflags: 0x0
// Checksum 0xa551cc16, Offset: 0x11f0
// Size: 0x14a
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    level.usestartspawns = 0;
    if (smeansofdeath == "MOD_SUICIDE" || smeansofdeath == "MOD_TRIGGER_HURT") {
        self thread demoteplayer();
        return;
    }
    if (isdefined(attacker) && isplayer(attacker)) {
        if (attacker == self) {
            self thread demoteplayer();
            return;
        }
        if (isdefined(attacker.lastpromotiontime) && attacker.lastpromotiontime + 3000 > gettime()) {
            scoreevents::processscoreevent("kill_in_3_seconds_gun", attacker, self, weapon);
        }
        if (weapon_utils::ismeleemod(smeansofdeath)) {
            scoreevents::processscoreevent("humiliation_gun", attacker, self, weapon);
            self thread demoteplayer();
        }
        if (smeansofdeath != "MOD_MELEE_WEAPON_BUTT") {
            attacker thread promoteplayer(weapon);
        }
    }
}

// Namespace gun
// Params 1, eflags: 0x0
// Checksum 0x221a8fa5, Offset: 0x1348
// Size: 0x44
function onendgame(winningplayer) {
    if (isdefined(winningplayer) && isplayer(winningplayer)) {
        [[ level._setplayerscore ]](winningplayer, [[ level._getplayerscore ]](winningplayer) + level.gungamekillscore);
    }
}

// Namespace gun
// Params 9, eflags: 0x0
// Checksum 0xff8ed77e, Offset: 0x1398
// Size: 0x107
function addguntoprogression(weaponname, attachment1, attachment2, attachment3, attachment4, attachment5, attachment6, attachment7, attachment8) {
    attachments = [];
    if (isdefined(attachment1)) {
        attachments[attachments.size] = attachment1;
    }
    if (isdefined(attachment2)) {
        attachments[attachments.size] = attachment2;
    }
    if (isdefined(attachment3)) {
        attachments[attachments.size] = attachment3;
    }
    if (isdefined(attachment4)) {
        attachments[attachments.size] = attachment4;
    }
    if (isdefined(attachment5)) {
        attachments[attachments.size] = attachment5;
    }
    if (isdefined(attachment6)) {
        attachments[attachments.size] = attachment6;
    }
    if (isdefined(attachment7)) {
        attachments[attachments.size] = attachment7;
    }
    if (isdefined(attachment8)) {
        attachments[attachments.size] = attachment8;
    }
    weapon = getweapon(weaponname, attachments);
    level.gunprogression[level.gunprogression.size] = weapon;
}

// Namespace gun
// Params 1, eflags: 0x0
// Checksum 0xd0276ea3, Offset: 0x14a8
// Size: 0xa2
function setupteam(team) {
    util::setobjectivetext(team, %OBJECTIVES_GUN);
    if (level.splitscreen) {
        util::setobjectivescoretext(team, %OBJECTIVES_GUN);
    } else {
        util::setobjectivescoretext(team, %OBJECTIVES_GUN_SCORE);
    }
    util::setobjectivehinttext(team, %OBJECTIVES_GUN_HINT);
    spawnlogic::add_spawn_points(team, "mp_dm_spawn");
    spawnlogic::place_spawn_points("mp_dm_spawn_start");
}

// Namespace gun
// Params 1, eflags: 0x0
// Checksum 0xed300770, Offset: 0x1558
// Size: 0x32
function takeoldweapon(oldweapon) {
    self endon(#"death");
    self endon(#"disconnect");
    wait 1;
    self takeweapon(oldweapon);
}

// Namespace gun
// Params 1, eflags: 0x0
// Checksum 0x5397c166, Offset: 0x1598
// Size: 0x15c
function givecustomloadout(takeoldweapon) {
    if (!isdefined(takeoldweapon)) {
        takeoldweapon = 0;
    }
    self loadout::function_79d05183(!takeoldweapon);
    if (takeoldweapon) {
        oldweapon = self getcurrentweapon();
        weapons = self getweaponslist();
        foreach (weapon in weapons) {
            if (weapon != oldweapon) {
                self takeweapon(weapon);
            }
        }
        self thread takeoldweapon(oldweapon);
    }
    if (!isdefined(self.gunprogress)) {
        self.gunprogress = 0;
    }
    currentweapon = level.gunprogression[self.gunprogress];
    self giveweapon(currentweapon);
    self switchtoweapon(currentweapon);
    self disableweaponcycling();
    if (self.firstspawn !== 0) {
        self setspawnweapon(currentweapon);
    }
    return currentweapon;
}

// Namespace gun
// Params 1, eflags: 0x0
// Checksum 0x3c008b87, Offset: 0x1700
// Size: 0x142
function promoteplayer(weaponused) {
    self endon(#"disconnect");
    self endon(#"cancel_promotion");
    level endon(#"game_ended");
    wait 0.05;
    if (isdefined(level.gunprogression[self.gunprogress].dualwieldweapon) && (weaponused.rootweapon == level.gunprogression[self.gunprogress].rootweapon || level.gunprogression[self.gunprogress].dualwieldweapon.rootweapon == weaponused.rootweapon)) {
        if (self.gunprogress < level.gunprogression.size - 1) {
            self.gunprogress++;
            if (isalive(self)) {
                self thread givecustomloadout(1);
            }
        }
        pointstowin = self.pers["pointstowin"];
        if (pointstowin < level.scorelimit) {
            self globallogic_score::givepointstowin(level.gungamekillscore);
            scoreevents::processscoreevent("kill_gun", self);
        }
        self.lastpromotiontime = gettime();
    }
}

// Namespace gun
// Params 0, eflags: 0x0
// Checksum 0xe2537fd, Offset: 0x1850
// Size: 0x102
function demoteplayer() {
    self endon(#"disconnect");
    self notify(#"cancel_promotion");
    currentgunprogress = self.gunprogress;
    for (i = 0; i < level.setbacksperdemotion; i++) {
        if (self.gunprogress <= 0) {
            break;
        }
        self globallogic_score::givepointstowin(level.gungamekillscore * -1);
        self.gunprogress--;
    }
    if (currentgunprogress != self.gunprogress && isalive(self)) {
        self thread givecustomloadout(1);
    }
    self.pers["humiliated"]++;
    self.humiliated = self.pers["humiliated"];
    self playlocalsound("mpl_wager_humiliate");
    self globallogic_audio::leader_dialog_on_player("humiliated");
}

// Namespace gun
// Params 0, eflags: 0x0
// Checksum 0x340d866a, Offset: 0x1960
// Size: 0x55
function infiniteammo() {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        wait 0.1;
        weapon = self getcurrentweapon();
        self givemaxammo(weapon);
    }
}

