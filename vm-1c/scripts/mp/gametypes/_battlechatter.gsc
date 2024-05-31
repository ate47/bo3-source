#using scripts/mp/_util;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_dev;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/abilities/gadgets/_gadget_camo;
#using scripts/codescripts/struct;

#namespace battlechatter;

// Namespace battlechatter
// Params 0, eflags: 0x2
// namespace_76d95162<file_0>::function_2dc19561
// Checksum 0x988120eb, Offset: 0xfe0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("battlechatter", &__init__, undefined, undefined);
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_8c87d8eb
// Checksum 0x5d18b264, Offset: 0x1020
// Size: 0x7a0
function __init__() {
    /#
        level thread devgui_think();
    #/
    callback::on_joined_team(&on_joined_team);
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    level.heroplaydialog = &play_dialog;
    level.playgadgetready = &play_gadget_ready;
    level.playgadgetactivate = &play_gadget_activate;
    level.playgadgetsuccess = &play_gadget_success;
    level.playpromotionreaction = &play_promotion_reaction;
    level.playthrowhatchet = &play_throw_hatchet;
    level.bcsounds = [];
    level.bcsounds["incoming_alert"] = [];
    level.bcsounds["incoming_alert"]["frag_grenade"] = "incomingFrag";
    level.bcsounds["incoming_alert"]["incendiary_grenade"] = "incomingIncendiary";
    level.bcsounds["incoming_alert"]["sticky_grenade"] = "incomingSemtex";
    level.bcsounds["incoming_alert"]["launcher_standard"] = "threatRpg";
    level.bcsounds["incoming_delay"] = [];
    level.bcsounds["incoming_delay"]["frag_grenade"] = "fragGrenadeDelay";
    level.bcsounds["incoming_delay"]["incendiary_grenade"] = "incendiaryGrenadeDelay";
    level.bcsounds["incoming_alert"]["sticky_grenade"] = "semtexDelay";
    level.bcsounds["incoming_delay"]["launcher_standard"] = "missileDelay";
    level.bcsounds["kill_dialog"] = [];
    level.bcsounds["kill_dialog"]["assassin"] = "killSpectre";
    level.bcsounds["kill_dialog"]["grenadier"] = "killGrenadier";
    level.bcsounds["kill_dialog"]["outrider"] = "killOutrider";
    level.bcsounds["kill_dialog"]["prophet"] = "killTechnomancer";
    level.bcsounds["kill_dialog"]["pyro"] = "killFirebreak";
    level.bcsounds["kill_dialog"]["reaper"] = "killReaper";
    level.bcsounds["kill_dialog"]["ruin"] = "killMercenary";
    level.bcsounds["kill_dialog"]["seraph"] = "killEnforcer";
    level.bcsounds["kill_dialog"]["trapper"] = "killTrapper";
    level.bcsounds["kill_dialog"]["blackjack"] = "killBlackjack";
    if (level.teambased && !isdefined(game["boostPlayersPicked"])) {
        game["boostPlayersPicked"] = [];
        foreach (team in level.teams) {
            game["boostPlayersPicked"][team] = 0;
        }
    }
    level.allowbattlechatter = getgametypesetting("allowBattleChatter");
    clientfield::register("world", "boost_number", 1, 2, "int");
    clientfield::register("allplayers", "play_boost", 1, 2, "int");
    level thread pick_boost_number();
    playerdialogbundles = struct::get_script_bundles("mpdialog_player");
    foreach (bundle in playerdialogbundles) {
        count_keys(bundle, "killGeneric");
        count_keys(bundle, "killSniper");
        count_keys(bundle, "killSpectre");
        count_keys(bundle, "killGrenadier");
        count_keys(bundle, "killOutrider");
        count_keys(bundle, "killTechnomancer");
        count_keys(bundle, "killFirebreak");
        count_keys(bundle, "killReaper");
        count_keys(bundle, "killMercenary");
        count_keys(bundle, "killEnforcer");
        count_keys(bundle, "killTrapper");
        count_keys(bundle, "killBlackjack");
    }
    level.allowspecialistdialog = mpdialog_value("enableHeroDialog", 0) && level.allowbattlechatter;
    level.playstartconversation = mpdialog_value("enableConversation", 0) && level.allowbattlechatter;
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_a111614a
// Checksum 0x7aa0497c, Offset: 0x17c8
// Size: 0x3c
function pick_boost_number() {
    wait(5);
    level clientfield::set("boost_number", randomint(4));
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_f6076bfe
// Checksum 0x9a09dd22, Offset: 0x1810
// Size: 0x1aa
function on_joined_team() {
    self endon(#"disconnect");
    if (level.teambased) {
        if (self.team == "allies") {
            self set_blops_dialog();
        } else {
            self set_cdp_dialog();
        }
    } else if (randomintrange(0, 2)) {
        self set_blops_dialog();
    } else {
        self set_cdp_dialog();
    }
    self globallogic_audio::flush_dialog();
    if (level.var_29d9f951 === 1) {
        return;
    }
    if (isdefined(level.inprematchperiod) && level.inprematchperiod && !(isdefined(self.pers["playedGameMode"]) && self.pers["playedGameMode"]) && isdefined(level.leaderdialog)) {
        if (level.hardcoremode) {
            self globallogic_audio::leader_dialog_on_player(level.leaderdialog.starthcgamedialog, undefined, undefined, undefined, 1);
        } else {
            self globallogic_audio::leader_dialog_on_player(level.leaderdialog.startgamedialog, undefined, undefined, undefined, 1);
        }
        self.pers["playedGameMode"] = 1;
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_68fc346f
// Checksum 0x7c290948, Offset: 0x19c8
// Size: 0x3a
function set_blops_dialog() {
    self.pers["mptaacom"] = "blops_taacom";
    self.pers["mpcommander"] = "blops_commander";
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_d2930434
// Checksum 0xd11d16d8, Offset: 0x1a10
// Size: 0x3a
function set_cdp_dialog() {
    self.pers["mptaacom"] = "cdp_taacom";
    self.pers["mpcommander"] = "cdp_commander";
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_fb4f96b5
// Checksum 0x7e21c9ba, Offset: 0x1a58
// Size: 0x1c
function on_player_connect() {
    self function_c6008b7();
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_aebcf025
// Checksum 0xbe5cdefa, Offset: 0x1a80
// Size: 0xbc
function on_player_spawned() {
    self function_c6008b7();
    if (level.splitscreen) {
        return;
    }
    self thread water_vox();
    self thread grenade_tracking();
    self thread missile_tracking();
    self thread sticky_grenade_tracking();
    if (level.teambased) {
        self thread enemy_threat();
        self thread check_boost_start_conversation();
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_c6008b7
// Checksum 0xc6d64470, Offset: 0x1b48
// Size: 0x80
function function_c6008b7() {
    self.enemythreattime = 0;
    self.heartbeatsnd = 0;
    self.soundmod = "player";
    self.voxunderwatertime = 0;
    self.voxemergebreath = 0;
    self.voxdrowning = 0;
    self.pilotisspeaking = 0;
    self.playingdialog = 0;
    self.playinggadgetreadydialog = 0;
    self.playedgadgetsuccess = 1;
}

// Namespace battlechatter
// Params 1, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_a1063238
// Checksum 0x143e7ac, Offset: 0x1bd0
// Size: 0x80
function dialog_chance(chancekey) {
    dialogchance = mpdialog_value(chancekey);
    if (!isdefined(dialogchance) || dialogchance <= 0) {
        return false;
    } else if (dialogchance >= 100) {
        return true;
    }
    return randomint(100) < dialogchance;
}

// Namespace battlechatter
// Params 2, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_fc14d9f4
// Checksum 0xca07b64b, Offset: 0x1c58
// Size: 0x9c
function mpdialog_value(mpdialogkey, defaultvalue) {
    if (!isdefined(mpdialogkey)) {
        return defaultvalue;
    }
    mpdialog = struct::get_script_bundle("mpdialog", "mpdialog_default");
    if (!isdefined(mpdialog)) {
        return defaultvalue;
    }
    structvalue = function_e8ef6cb0(mpdialog, mpdialogkey);
    if (!isdefined(structvalue)) {
        return defaultvalue;
    }
    return structvalue;
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_d2304b48
// Checksum 0x740fc1c2, Offset: 0x1d00
// Size: 0x21c
function water_vox() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        interval = mpdialog_value("underwaterInterval", 0.05);
        if (interval <= 0) {
            assert(interval > 0, "threatRpg");
            return;
        }
        wait(interval);
        if (util::isprophuntgametype() && self util::isprop()) {
            continue;
        }
        if (self isplayerunderwater()) {
            if (!self.voxunderwatertime && !self.voxemergebreath) {
                self stopsounds();
                self.voxunderwatertime = gettime();
            } else if (self.voxunderwatertime) {
                if (gettime() > self.voxunderwatertime + mpdialog_value("underwaterBreathTime", 0) * 1000) {
                    self.voxunderwatertime = 0;
                    self.voxemergebreath = 1;
                }
            }
            continue;
        }
        if (self.voxdrowning) {
            self thread play_dialog("exertEmergeGasp", 20, mpdialog_value("playerExertBuffer", 0));
            self.voxdrowning = 0;
            self.voxemergebreath = 0;
            continue;
        }
        if (self.voxemergebreath) {
            self thread play_dialog("exertEmergeBreath", 20, mpdialog_value("playerExertBuffer", 0));
            self.voxemergebreath = 0;
        }
    }
}

// Namespace battlechatter
// Params 1, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_ff55a1a3
// Checksum 0x43531411, Offset: 0x1f28
// Size: 0xfc
function pain_vox(meansofdeath) {
    if (dialog_chance("smallPainChance")) {
        if (meansofdeath == "MOD_DROWN") {
            dialogkey = "exertPainDrowning";
            self.voxdrowning = 1;
        } else if (meansofdeath == "MOD_FALLING") {
            dialogkey = "exertPainFalling";
        } else if (self isplayerunderwater()) {
            dialogkey = "exertPainUnderwater";
        } else {
            dialogkey = "exertPain";
        }
        exertbuffer = mpdialog_value("playerExertBuffer", 0);
        self thread play_dialog(dialogkey, 30, exertbuffer);
    }
}

// Namespace battlechatter
// Params 2, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_7a194d5a
// Checksum 0xf58220fd, Offset: 0x2030
// Size: 0x38
function on_player_suicide_or_team_kill(player, type) {
    self endon(#"death");
    level endon(#"game_ended");
    waittillframeend();
    if (!level.teambased) {
        return;
    }
}

// Namespace battlechatter
// Params 2, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_654ce454
// Checksum 0x1cad6f47, Offset: 0x2070
// Size: 0x2a
function on_player_near_explodable(object, type) {
    self endon(#"death");
    level endon(#"game_ended");
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_d7768dc6
// Checksum 0x8ebd3d23, Offset: 0x20a8
// Size: 0x298
function enemy_threat() {
    self endon(#"death");
    level endon(#"game_ended");
    if (util::isprophuntgametype()) {
        return;
    }
    while (true) {
        self waittill(#"weapon_ads");
        if (self hasperk("specialty_quieter")) {
            continue;
        }
        if (self.enemythreattime + mpdialog_value("enemyContactInterval", 0) * 1000 >= gettime()) {
            continue;
        }
        closest_ally = self get_closest_player_ally(1);
        if (!isdefined(closest_ally)) {
            continue;
        }
        allyradius = mpdialog_value("enemyContactAllyRadius", 0);
        if (distancesquared(self.origin, closest_ally.origin) < allyradius * allyradius) {
            eyepoint = self geteye();
            dir = anglestoforward(self getplayerangles());
            dir *= mpdialog_value("enemyContactDistance", 0);
            endpoint = eyepoint + dir;
            traceresult = bullettrace(eyepoint, endpoint, 1, self);
            if (isdefined(traceresult["entity"]) && traceresult["entity"].classname == "player" && traceresult["entity"].team != self.team) {
                if (dialog_chance("enemyContactChance")) {
                    self thread play_dialog("threatInfantry", 1);
                    level notify(#"level_enemy_spotted", self.team);
                    self.enemythreattime = gettime();
                }
            }
        }
    }
}

// Namespace battlechatter
// Params 1, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_1fd8eea8
// Checksum 0x4892d87b, Offset: 0x2348
// Size: 0x290
function killed_by_sniper(sniper) {
    self endon(#"disconnect");
    sniper endon(#"disconnect");
    level endon(#"game_ended");
    if (!level.teambased) {
        return 0;
    }
    if (util::isprophuntgametype()) {
        return 0;
    }
    waittillframeend();
    if (dialog_chance("sniperKillChance")) {
        closest_ally = self get_closest_player_ally();
        allyradius = mpdialog_value("sniperKillAllyRadius", 0);
        if (isdefined(closest_ally) && distancesquared(self.origin, closest_ally.origin) < allyradius * allyradius) {
            closest_ally thread play_dialog("threatSniper", 1);
            sniper.spottedtime = gettime();
            sniper.spottedby = [];
            players = self get_friendly_players();
            players = arraysort(players, self.origin);
            voiceradius = mpdialog_value("playerVoiceRadius", 0);
            voiceradiussq = voiceradius * voiceradius;
            foreach (player in players) {
                if (distancesquared(closest_ally.origin, player.origin) <= voiceradiussq) {
                    sniper.spottedby[sniper.spottedby.size] = player;
                }
            }
        }
    }
}

// Namespace battlechatter
// Params 2, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_1c575e66
// Checksum 0x528b26c8, Offset: 0x25e0
// Size: 0x154
function player_killed(attacker, killstreaktype) {
    if (!level.teambased) {
        return;
    }
    if (self === attacker) {
        return;
    }
    waittillframeend();
    if (isdefined(killstreaktype)) {
        if (!isdefined(level.killstreaks[killstreaktype]) || !isdefined(level.killstreaks[killstreaktype].threatonkill) || !level.killstreaks[killstreaktype].threatonkill || !dialog_chance("killstreakKillChance")) {
            return;
        }
        ally = get_closest_player_ally(1);
        allyradius = mpdialog_value("killstreakKillAllyRadius", 0);
        if (isdefined(ally) && distancesquared(self.origin, ally.origin) < allyradius * allyradius) {
            ally play_killstreak_threat(killstreaktype);
        }
    }
}

// Namespace battlechatter
// Params 4, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_89eb644
// Checksum 0x8adead5d, Offset: 0x2740
// Size: 0x574
function say_kill_battle_chatter(attacker, weapon, victim, inflictor) {
    if (weapon.skipbattlechatterkill || !isdefined(attacker) || !isplayer(attacker) || !isalive(attacker) || attacker isremotecontrolling() || attacker isinvehicle() || attacker isweaponviewonlylinked() || !isdefined(victim) || !isplayer(victim) || util::isprophuntgametype()) {
        return;
    }
    if (isdefined(inflictor) && !isplayer(inflictor) && inflictor.birthtime < attacker.spawntime) {
        return;
    }
    if (weapon.inventorytype == "hero") {
        if (!isdefined(attacker.heroweaponkillcount)) {
            attacker.heroweaponkillcount = 0;
        }
        attacker.heroweaponkillcount++;
        if (!(isdefined(attacker.playedgadgetsuccess) && attacker.playedgadgetsuccess) && attacker.heroweaponkillcount === mpdialog_value("heroWeaponKillCount", 0)) {
            attacker thread play_gadget_success(weapon, "enemyKillDelay", victim);
            attacker thread function_98b960de();
        }
    } else if (isdefined(attacker.speedburston) && attacker.speedburston) {
        if (!(isdefined(attacker.speedburstkill) && attacker.speedburstkill)) {
            speedburstkilldist = mpdialog_value("speedBurstKillDistance", 0);
            if (distancesquared(attacker.origin, victim.origin) < speedburstkilldist * speedburstkilldist) {
                attacker.speedburstkill = 1;
            }
        }
    } else if (isdefined(attacker.var_9b8eaff2) && (attacker namespace_411f3e3f::function_6b246a0f() || attacker.var_9b8eaff2 + mpdialog_value("camoKillTime", 0) * 1000 >= gettime())) {
        if (!(isdefined(attacker.playedgadgetsuccess) && attacker.playedgadgetsuccess)) {
            attacker thread play_gadget_success(getweapon("gadget_camo"), "enemyKillDelay", victim);
        }
    } else if (dialog_chance("enemyKillChance")) {
        if (isdefined(victim.spottedtime) && victim.spottedtime + mpdialog_value("enemySniperKillTime", 0) >= gettime() && array::contains(victim.spottedby, attacker) && dialog_chance("enemySniperKillChance")) {
            killdialog = attacker get_random_key("killSniper");
        } else if (dialog_chance("enemyHeroKillChance")) {
            victimdialogname = victim getmpdialogname();
            killdialog = attacker get_random_key(level.bcsounds["kill_dialog"][victimdialogname]);
        } else {
            killdialog = attacker get_random_key("killGeneric");
        }
    }
    victim.spottedtime = undefined;
    victim.spottedby = undefined;
    if (!isdefined(killdialog)) {
        return;
    }
    attacker thread wait_play_dialog(mpdialog_value("enemyKillDelay", 0), killdialog, 1, undefined, victim, "cancel_kill_dialog");
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_b1fdb613
// Checksum 0x74d9c28c, Offset: 0x2cc0
// Size: 0x160
function grenade_tracking() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        grenade, weapon = self waittill(#"grenade_fire");
        if (!isdefined(grenade.weapon) || !isdefined(grenade.weapon.rootweapon) || !dialog_chance("incomingProjectileChance")) {
            continue;
        }
        dialogkey = level.bcsounds["incoming_alert"][grenade.weapon.rootweapon.name];
        if (isdefined(dialogkey)) {
            waittime = mpdialog_value(level.bcsounds["incoming_delay"][grenade.weapon.rootweapon.name], 0.05);
            level thread incoming_projectile_alert(self, grenade, dialogkey, waittime);
        }
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_cc6a2e65
// Checksum 0x81b38420, Offset: 0x2e28
// Size: 0x160
function missile_tracking() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        missile, weapon = self waittill(#"missile_fire");
        if (!isdefined(missile.item) || !isdefined(missile.item.rootweapon) || !dialog_chance("incomingProjectileChance")) {
            continue;
        }
        dialogkey = level.bcsounds["incoming_alert"][missile.item.rootweapon.name];
        if (isdefined(dialogkey)) {
            waittime = mpdialog_value(level.bcsounds["incoming_delay"][missile.item.rootweapon.name], 0.05);
            level thread incoming_projectile_alert(self, missile, dialogkey, waittime);
        }
    }
}

// Namespace battlechatter
// Params 4, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_8c2360ca
// Checksum 0x4a9707, Offset: 0x2f90
// Size: 0x1aa
function incoming_projectile_alert(thrower, projectile, dialogkey, waittime) {
    level endon(#"game_ended");
    if (waittime <= 0) {
        assert(waittime > 0, "threatRpg");
        return;
    }
    if (util::isprophuntgametype()) {
        return;
    }
    while (true) {
        wait(waittime);
        if (waittime > 0.2) {
            waittime /= 2;
        }
        if (!isdefined(projectile)) {
            return;
        }
        if (!isdefined(thrower) || thrower.team == "spectator") {
            return;
        }
        if (level.players.size) {
            closest_enemy = thrower get_closest_player_enemy(projectile.origin);
            incomingprojectileradius = mpdialog_value("incomingProjectileRadius", 0);
            if (isdefined(closest_enemy) && distancesquared(projectile.origin, closest_enemy.origin) < incomingprojectileradius * incomingprojectileradius) {
                closest_enemy thread play_dialog(dialogkey, 6);
                return;
            }
        }
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_d30fd7e9
// Checksum 0x1851ee5, Offset: 0x3148
// Size: 0xc8
function sticky_grenade_tracking() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        grenade = self waittill(#"grenade_stuck");
        if (isalive(self) && isdefined(grenade) && isdefined(grenade.weapon)) {
            if (grenade.weapon.rootweapon.name == "sticky_grenade") {
                self thread play_dialog("stuckSticky", 6);
            }
        }
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_98b960de
// Checksum 0x90b26441, Offset: 0x3218
// Size: 0x38e
function function_98b960de() {
    self endon(#"death");
    level endon(#"game_ended");
    if (!level.teambased) {
        return;
    }
    if (util::isprophuntgametype()) {
        return;
    }
    allies = [];
    allyradiussq = mpdialog_value("playerVoiceRadius", 0);
    allyradiussq *= allyradiussq;
    foreach (player in level.players) {
        if (!isdefined(player) || !isalive(player) || player.sessionstate != "playing" || player == self || player.team != self.team) {
            continue;
        }
        distsq = distancesquared(self.origin, player.origin);
        if (distsq > allyradiussq) {
            continue;
        }
        allies[allies.size] = player;
    }
    wait(mpdialog_value("enemyKillDelay", 0) + 0.1);
    while (self.playingdialog) {
        wait(0.5);
    }
    allies = arraysort(allies, self.origin);
    foreach (player in allies) {
        if (!isalive(player) || player.sessionstate != "playing" || player.playingdialog || player isplayerunderwater() || player isremotecontrolling() || player isinvehicle() || player isweaponviewonlylinked()) {
            continue;
        }
        distsq = distancesquared(self.origin, player.origin);
        if (distsq > allyradiussq) {
            break;
        }
        player play_dialog("heroWeaponSuccessReaction", 1);
        break;
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_1bb4a951
// Checksum 0xa9ce52d7, Offset: 0x35b0
// Size: 0x294
function play_promotion_reaction() {
    self endon(#"death");
    level endon(#"game_ended");
    if (!level.teambased) {
        return;
    }
    if (util::isprophuntgametype() && self util::isprop()) {
        return;
    }
    wait(9);
    players = self get_friendly_players();
    players = arraysort(players, self.origin);
    selfdialog = self getmpdialogname();
    voiceradius = mpdialog_value("playerVoiceRadius", 0);
    voiceradiussq = voiceradius * voiceradius;
    foreach (player in players) {
        if (player == self || player getmpdialogname() == selfdialog || !player can_play_dialog(1) || distancesquared(self.origin, player.origin) >= voiceradiussq) {
            continue;
        }
        dialogalias = player get_player_dialog_alias("promotionReaction");
        if (!isdefined(dialogalias)) {
            continue;
        }
        ally = player;
        break;
    }
    if (isdefined(ally)) {
        ally playsoundontag(dialogalias, "J_Head", undefined, self);
        ally thread wait_dialog_buffer(mpdialog_value("playerDialogBuffer", 0));
    }
}

// Namespace battlechatter
// Params 2, eflags: 0x0
// namespace_76d95162<file_0>::function_d94c2cf5
// Checksum 0x8bdc17ea, Offset: 0x3850
// Size: 0x2a
function gametype_specific_battle_chatter(event, team) {
    self endon(#"death");
    level endon(#"game_ended");
}

// Namespace battlechatter
// Params 4, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_c42d97d6
// Checksum 0x9ab9b6e5, Offset: 0x3888
// Size: 0xa4
function play_death_vox(body, attacker, weapon, meansofdeath) {
    dialogkey = self get_death_vox(weapon, meansofdeath);
    dialogalias = self get_player_dialog_alias(dialogkey);
    if (isdefined(dialogalias)) {
        body playsoundontag(dialogalias, "J_Head");
    }
}

// Namespace battlechatter
// Params 2, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_1f219452
// Checksum 0x7d35bb1d, Offset: 0x3938
// Size: 0xfe
function get_death_vox(weapon, meansofdeath) {
    if (self isplayerunderwater()) {
        return "exertDeathDrowned";
    }
    if (isdefined(meansofdeath)) {
        switch (meansofdeath) {
        case 106:
            return "exertDeathBurned";
        case 65:
            return "exertDeathDrowned";
        }
    }
    if (isdefined(weapon) && meansofdeath !== "MOD_MELEE_WEAPON_BUTT") {
        switch (weapon.rootweapon.name) {
        case 110:
        case 111:
        case 114:
            return "exertDeathStabbed";
        case 112:
            return "exertDeathBurned";
        case 113:
            return "exertDeathElectrocuted";
        }
    }
    return "exertDeath";
}

// Namespace battlechatter
// Params 1, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_97264e7b
// Checksum 0xcfcc7ca8, Offset: 0x3a40
// Size: 0x5c
function play_killstreak_threat(killstreaktype) {
    if (!isdefined(killstreaktype) || !isdefined(level.killstreaks[killstreaktype])) {
        return;
    }
    self thread play_dialog(level.killstreaks[killstreaktype].threatdialogkey, 1);
}

// Namespace battlechatter
// Params 6, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_62af34de
// Checksum 0x40d0bc94, Offset: 0x3aa8
// Size: 0x9c
function wait_play_dialog(waittime, dialogkey, dialogflags, dialogbuffer, enemy, endnotify) {
    self endon(#"death");
    level endon(#"game_ended");
    if (isdefined(waittime) && waittime > 0) {
        if (isdefined(endnotify)) {
            self endon(endnotify);
        }
        wait(waittime);
    }
    self thread play_dialog(dialogkey, dialogflags, dialogbuffer, enemy);
}

// Namespace battlechatter
// Params 4, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_3001a972
// Checksum 0x3f7d6454, Offset: 0x3b50
// Size: 0x2dc
function play_dialog(dialogkey, dialogflags, dialogbuffer, enemy) {
    self endon(#"death");
    level endon(#"game_ended");
    if (!isdefined(dialogkey) || !isplayer(self) || !isalive(self) || level.gameended) {
        return;
    }
    if (!isdefined(dialogflags)) {
        dialogflags = 0;
    }
    if (!level.allowspecialistdialog && (dialogflags & 16) == 0) {
        return;
    }
    if (!isdefined(dialogbuffer)) {
        dialogbuffer = mpdialog_value("playerDialogBuffer", 0);
    }
    dialogalias = self get_player_dialog_alias(dialogkey);
    if (!isdefined(dialogalias)) {
        return;
    }
    if (self isplayerunderwater() && !(dialogflags & 8)) {
        return;
    }
    if (self.playingdialog) {
        if (!(dialogflags & 4)) {
            return;
        }
        self stopsounds();
        wait(0.05);
    }
    if (dialogflags & 32) {
        self.playinggadgetreadydialog = 1;
    }
    if (dialogflags & 64) {
        if (!isdefined(self.stolendialogindex)) {
            self.stolendialogindex = 0;
        }
        dialogalias = dialogalias + "_0" + self.stolendialogindex;
        self.stolendialogindex++;
        self.stolendialogindex %= 4;
    }
    if (dialogflags & 2) {
        self playsoundontag(dialogalias, "J_Head");
    } else if (dialogflags & 1) {
        if (isdefined(enemy)) {
            self playsoundontag(dialogalias, "J_Head", self.team, enemy);
        } else {
            self playsoundontag(dialogalias, "J_Head", self.team);
        }
    } else {
        self playlocalsound(dialogalias);
    }
    self notify(#"played_dialog");
    self thread wait_dialog_buffer(dialogbuffer);
}

// Namespace battlechatter
// Params 1, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_813f1ac6
// Checksum 0xa876a7ce, Offset: 0x3e38
// Size: 0x7c
function wait_dialog_buffer(dialogbuffer) {
    self endon(#"death");
    self endon(#"played_dialog");
    self endon(#"stop_dialog");
    level endon(#"game_ended");
    self.playingdialog = 1;
    if (isdefined(dialogbuffer) && dialogbuffer > 0) {
        wait(dialogbuffer);
    }
    self.playingdialog = 0;
    self.playinggadgetreadydialog = 0;
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_89dbc928
// Checksum 0xb222ce59, Offset: 0x3ec0
// Size: 0x3c
function stop_dialog() {
    self notify(#"stop_dialog");
    self stopsounds();
    self.playingdialog = 0;
    self.playinggadgetreadydialog = 0;
}

// Namespace battlechatter
// Params 1, eflags: 0x0
// namespace_76d95162<file_0>::function_54ecefee
// Checksum 0x5d0e1b41, Offset: 0x3f08
// Size: 0xc
function wait_playback_time(soundalias) {
    
}

// Namespace battlechatter
// Params 1, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_502e5701
// Checksum 0x77ac6d9c, Offset: 0x3f20
// Size: 0xaa
function get_player_dialog_alias(dialogkey) {
    if (!isplayer(self)) {
        return undefined;
    }
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return undefined;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return undefined;
    }
    return globallogic_audio::get_dialog_bundle_alias(playerbundle, dialogkey);
}

// Namespace battlechatter
// Params 2, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_d10408e9
// Checksum 0x4e2d63c7, Offset: 0x3fd8
// Size: 0xfa
function count_keys(bundle, dialogkey) {
    i = 0;
    field = dialogkey + i;
    for (fieldvalue = function_e8ef6cb0(bundle, field); isdefined(fieldvalue); fieldvalue = function_e8ef6cb0(bundle, field)) {
        aliasarray[i] = fieldvalue;
        i++;
        field = dialogkey + i;
    }
    if (!isdefined(bundle.keycounts)) {
        bundle.keycounts = [];
    }
    bundle.keycounts[dialogkey] = i;
}

// Namespace battlechatter
// Params 1, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_73d1e677
// Checksum 0xb131a971, Offset: 0x40e0
// Size: 0xd4
function get_random_key(dialogkey) {
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return undefined;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle) || !isdefined(playerbundle.keycounts) || !isdefined(playerbundle.keycounts[dialogkey])) {
        return dialogkey;
    }
    return dialogkey + randomint(playerbundle.keycounts[dialogkey]);
}

// Namespace battlechatter
// Params 2, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_4e06c732
// Checksum 0xb1f3ebb9, Offset: 0x41c0
// Size: 0x50c
function play_gadget_ready(weapon, userflip) {
    if (!isdefined(userflip)) {
        userflip = 0;
    }
    if (!isdefined(weapon)) {
        return;
    }
    dialogkey = undefined;
    switch (weapon.name) {
    case 150:
        dialogkey = "gravspikesWeaponReady";
        break;
    case 141:
        dialogkey = "overdriveAbilityReady";
        break;
    case 144:
    case 145:
    case 146:
    case 147:
        dialogkey = "sparrowWeaponReady";
        break;
    case 142:
        dialogkey = "visionpulseAbilityReady";
        break;
    case 151:
    case 113:
        dialogkey = "tempestWeaponReady";
        break;
    case 138:
        dialogkey = "glitchAbilityReady";
        break;
    case 154:
        dialogkey = "warmachineWeaponREady";
        break;
    case 135:
        dialogkey = "kineticArmorAbilityReady";
        break;
    case 143:
        dialogkey = "annihilatorWeaponReady";
        break;
    case 137:
        dialogkey = "combatfocusAbilityReady";
        break;
    case 148:
        dialogkey = "hiveWeaponReady";
        break;
    case 140:
        dialogkey = "rejackAbilityReady";
        break;
    case 152:
    case 153:
        dialogkey = "scytheWeaponReady";
        break;
    case 136:
        dialogkey = "psychosisAbilityReady";
        break;
    case 111:
        dialogkey = "ripperWeaponReady";
        break;
    case 89:
        dialogkey = "activeCamoAbilityReady";
        break;
    case 149:
        dialogkey = "purifierWeaponReady";
        break;
    case 139:
        dialogkey = "heatwaveAbilityReady";
        break;
    default:
        return;
    }
    if (!(isdefined(self.isthief) && self.isthief) && !(isdefined(self.isroulette) && self.isroulette)) {
        self thread play_dialog(dialogkey);
        return;
    }
    waittime = 0;
    dialogflags = 32;
    if (userflip) {
        minwaittime = 0;
        if (self.playinggadgetreadydialog) {
            self stop_dialog();
            minwaittime = 0.05;
        }
        if (isdefined(self.isthief) && self.isthief) {
            delaykey = "thiefFlipDelay";
        } else {
            delaykey = "rouletteFlipDelay";
        }
        waittime = mpdialog_value(delaykey, minwaittime);
        dialogflags += 64;
    } else {
        if (isdefined(self.isthief) && self.isthief) {
            generickey = "thiefWeaponReady";
            repeatkey = "thiefWeaponRepeat";
            repeatthresholdkey = "thiefRepeatThreshold";
            chancekey = "thiefReadyChance";
            delaykey = "thiefRevealDelay";
        } else {
            generickey = "rouletteAbilityReady";
            repeatkey = "rouletteAbilityRepeat";
            repeatthresholdkey = "rouletteRepeatThreshold";
            chancekey = "rouletteReadyChance";
            delaykey = "rouletteRevealDelay";
        }
        if (randomint(100) < mpdialog_value(chancekey, 0)) {
            dialogkey = generickey;
        } else {
            waittime = mpdialog_value(delaykey, 0);
            if (self.laststolengadget === weapon && self.laststolengadgettime + mpdialog_value(repeatthresholdkey, 0) * 1000 > gettime()) {
                dialogkey = repeatkey;
            } else {
                dialogflags += 64;
            }
        }
    }
    self.laststolengadget = weapon;
    self.laststolengadgettime = gettime();
    if (waittime) {
        self notify(#"cancel_kill_dialog");
    }
    self thread wait_play_dialog(waittime, dialogkey, dialogflags);
}

// Namespace battlechatter
// Params 1, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_628a3486
// Checksum 0x49f2113d, Offset: 0x46d8
// Size: 0x274
function play_gadget_activate(weapon) {
    if (!isdefined(weapon)) {
        return;
    }
    dialogkey = undefined;
    switch (weapon.name) {
    case 150:
        dialogkey = "gravspikesWeaponUse";
        dialogflags = 22;
        dialogbuffer = 0.05;
        break;
    case 141:
        dialogkey = "overdriveAbilityUse";
        break;
    case 144:
    case 145:
    case 146:
    case 147:
        dialogkey = "sparrowWeaponUse";
        break;
    case 142:
        dialogkey = "visionpulseAbilityUse";
        break;
    case 151:
    case 113:
        dialogkey = "tempestWeaponUse";
        break;
    case 138:
        dialogkey = "glitchAbilityUse";
        break;
    case 154:
        dialogkey = "warmachineWeaponUse";
        break;
    case 135:
        dialogkey = "kineticArmorAbilityUse";
        break;
    case 143:
        dialogkey = "annihilatorWeaponUse";
        break;
    case 137:
        dialogkey = "combatfocusAbilityUse";
        break;
    case 148:
        dialogkey = "hiveWeaponUse";
        break;
    case 140:
        dialogkey = "rejackAbilityUse";
        break;
    case 152:
    case 153:
        dialogkey = "scytheWeaponUse";
        break;
    case 136:
        dialogkey = "psychosisAbilityUse";
        break;
    case 111:
        dialogkey = "ripperWeaponUse";
        break;
    case 89:
        dialogkey = "activeCamoAbilityUse";
        break;
    case 149:
        dialogkey = "purifierWeaponUse";
        break;
    case 139:
        dialogkey = "heatwaveAbilityUse";
        break;
    default:
        return;
    }
    self thread play_dialog(dialogkey, dialogflags, dialogbuffer);
}

// Namespace battlechatter
// Params 3, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_419d3de
// Checksum 0x33b26e8d, Offset: 0x4958
// Size: 0x2ac
function play_gadget_success(weapon, waitkey, victim) {
    if (!isdefined(weapon)) {
        return;
    }
    dialogkey = undefined;
    switch (weapon.name) {
    case 150:
        dialogkey = "gravspikesWeaponSuccess";
        break;
    case 141:
        dialogkey = "overdriveAbilitySuccess";
        break;
    case 144:
    case 145:
    case 146:
    case 147:
        dialogkey = "sparrowWeaponSuccess";
        break;
    case 142:
        dialogkey = "visionpulseAbilitySuccess";
        break;
    case 151:
    case 113:
        dialogkey = "tempestWeaponSuccess";
        break;
    case 138:
        dialogkey = "glitchAbilitySuccess";
        break;
    case 154:
        dialogkey = "warmachineWeaponSuccess";
        break;
    case 135:
        dialogkey = "kineticArmorAbilitySuccess";
        break;
    case 143:
        dialogkey = "annihilatorWeaponSuccess";
        break;
    case 137:
        dialogkey = "combatfocusAbilitySuccess";
        break;
    case 148:
        dialogkey = "hiveWeaponSuccess";
        break;
    case 140:
        dialogkey = "rejackAbilitySuccess";
        break;
    case 152:
    case 153:
        dialogkey = "scytheWeaponSuccess";
        break;
    case 136:
        dialogkey = "psychosisAbilitySuccess";
        break;
    case 111:
        dialogkey = "ripperWeaponSuccess";
        break;
    case 89:
        dialogkey = "activeCamoAbilitySuccess";
        break;
    case 149:
        dialogkey = "purifierWeaponSuccess";
        break;
    case 139:
        dialogkey = "heatwaveAbilitySuccess";
        break;
    default:
        return;
    }
    if (isdefined(waitkey)) {
        waittime = mpdialog_value(waitkey, 0);
    }
    dialogkey += "0";
    self.playedgadgetsuccess = 1;
    self thread wait_play_dialog(waittime, dialogkey, 1, undefined, victim);
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_b23cdd12
// Checksum 0x7afaf9e6, Offset: 0x4c10
// Size: 0x44
function play_throw_hatchet() {
    self thread play_dialog("exertAxeThrow", 21, mpdialog_value("playerExertBuffer", 0));
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_efbae489
// Checksum 0x6a98e8ee, Offset: 0x4c60
// Size: 0x1be
function get_enemy_players() {
    players = [];
    if (level.teambased) {
        foreach (team in level.teams) {
            if (team == self.team) {
                continue;
            }
            foreach (player in level.aliveplayers[team]) {
                players[players.size] = player;
            }
        }
    } else {
        foreach (player in level.activeplayers) {
            if (player != self) {
                players[players.size] = player;
            }
        }
    }
    return players;
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_633d1b8c
// Checksum 0xbec860b1, Offset: 0x4e28
// Size: 0xc0
function get_friendly_players() {
    players = [];
    if (level.teambased) {
        foreach (player in level.aliveplayers[self.team]) {
            players[players.size] = player;
        }
    } else {
        players[0] = self;
    }
    return players;
}

// Namespace battlechatter
// Params 1, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_811527ed
// Checksum 0x9a57e6bf, Offset: 0x4ef0
// Size: 0xee
function can_play_dialog(teamonly) {
    if (!isplayer(self) || !isalive(self) || self.playingdialog === 1 || self isplayerunderwater() || self isremotecontrolling() || self isinvehicle() || self isweaponviewonlylinked()) {
        return false;
    }
    if (isdefined(teamonly) && !teamonly && self hasperk("specialty_quieter")) {
        return false;
    }
    return true;
}

// Namespace battlechatter
// Params 2, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_d8006cf0
// Checksum 0x89654807, Offset: 0x4fe8
// Size: 0x108
function get_closest_player_enemy(origin, teamonly) {
    if (!isdefined(origin)) {
        origin = self.origin;
    }
    players = self get_enemy_players();
    players = arraysort(players, origin);
    foreach (player in players) {
        if (!player can_play_dialog(teamonly)) {
            continue;
        }
        return player;
    }
    return undefined;
}

// Namespace battlechatter
// Params 1, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_d7332a0e
// Checksum 0xa5cdec1e, Offset: 0x50f8
// Size: 0xfa
function get_closest_player_ally(teamonly) {
    if (!level.teambased) {
        return undefined;
    }
    players = self get_friendly_players();
    players = arraysort(players, self.origin);
    foreach (player in players) {
        if (player == self || !player can_play_dialog(teamonly)) {
            continue;
        }
        return player;
    }
    return undefined;
}

// Namespace battlechatter
// Params 0, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_52949700
// Checksum 0x111c94b8, Offset: 0x5200
// Size: 0x1c4
function check_boost_start_conversation() {
    if (!level.playstartconversation) {
        return;
    }
    if (!level.inprematchperiod || !level.teambased || game["boostPlayersPicked"][self.team]) {
        return;
    }
    players = self get_friendly_players();
    array::add(players, self, 0);
    players = array::randomize(players);
    playerindex = 1;
    foreach (player in players) {
        playerdialog = player getmpdialogname();
        for (i = playerindex; i < players.size; i++) {
            playeri = players[i];
            if (playerdialog != playeri getmpdialogname()) {
                pick_boost_players(player, playeri);
                return;
            }
        }
        playerindex++;
    }
}

// Namespace battlechatter
// Params 2, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_5eb511a5
// Checksum 0xc83824de, Offset: 0x53d0
// Size: 0x76
function pick_boost_players(player1, player2) {
    player1 clientfield::set("play_boost", 1);
    player2 clientfield::set("play_boost", 2);
    game["boostPlayersPicked"][player1.team] = 1;
}

// Namespace battlechatter
// Params 1, eflags: 0x1 linked
// namespace_76d95162<file_0>::function_7c2866d3
// Checksum 0xb2749565, Offset: 0x5450
// Size: 0x1ba
function game_end_vox(winner) {
    if (!level.allowspecialistdialog) {
        return;
    }
    var_71859219 = level.teambased && (!isdefined(winner) || winner == "tie");
    foreach (player in level.players) {
        if (player issplitscreen()) {
            continue;
        }
        if (var_71859219) {
            dialogkey = "boostDraw";
        } else if (!level.teambased && (level.teambased && isdefined(level.teams[winner]) && player.pers["team"] == winner || player == winner)) {
            dialogkey = "boostWin";
        } else {
            dialogkey = "boostLoss";
        }
        dialogalias = player get_player_dialog_alias(dialogkey);
        if (isdefined(dialogalias)) {
            player playlocalsound(dialogalias);
        }
    }
}

/#

    // Namespace battlechatter
    // Params 0, eflags: 0x1 linked
    // namespace_76d95162<file_0>::function_88dafe6a
    // Checksum 0x58db8a52, Offset: 0x5618
    // Size: 0x380
    function devgui_think() {
        setdvar("threatRpg", "threatRpg");
        setdvar("threatRpg", "threatRpg");
        setdvar("threatRpg", "threatRpg");
        setdvar("threatRpg", "threatRpg");
        while (true) {
            wait(1);
            player = util::gethostplayer();
            if (!isdefined(player)) {
                continue;
            }
            spacing = getdvarfloat("threatRpg", 0.25);
            switch (getdvarstring("threatRpg", "threatRpg")) {
            case 8:
                player thread test_player_dialog(0);
                player thread test_taacom_dialog(spacing);
                player thread test_commander_dialog(2 * spacing);
                break;
            case 8:
                player thread test_player_dialog(0);
                player thread test_commander_dialog(spacing);
                break;
            case 8:
                player thread test_other_dialog(0);
                player thread test_commander_dialog(spacing);
                break;
            case 8:
                player thread test_taacom_dialog(0);
                player thread test_commander_dialog(spacing);
                break;
            case 8:
                player thread test_player_dialog(0);
                player thread test_taacom_dialog(spacing);
                break;
            case 8:
                player thread test_other_dialog(0);
                player thread test_taacom_dialog(spacing);
                break;
            case 8:
                player thread test_other_dialog(0);
                player thread test_player_dialog(spacing);
                break;
            case 8:
                player thread play_conv_self_other();
                break;
            case 8:
                player thread play_conv_other_self();
                break;
            case 8:
                player thread play_conv_other_other();
                break;
            }
            setdvar("threatRpg", "threatRpg");
        }
    }

    // Namespace battlechatter
    // Params 1, eflags: 0x1 linked
    // namespace_76d95162<file_0>::function_a2bcc9cd
    // Checksum 0xfa7736bb, Offset: 0x59a0
    // Size: 0xf4
    function test_other_dialog(delay) {
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player thread test_player_dialog(delay);
                return;
            }
        }
    }

    // Namespace battlechatter
    // Params 1, eflags: 0x1 linked
    // namespace_76d95162<file_0>::function_ddada93e
    // Checksum 0xee7a2d00, Offset: 0x5aa0
    // Size: 0x64
    function test_player_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait(delay);
        self playsoundontag(getdvarstring("threatRpg", "threatRpg"), "threatRpg");
    }

    // Namespace battlechatter
    // Params 1, eflags: 0x1 linked
    // namespace_76d95162<file_0>::function_1e6b5d80
    // Checksum 0xc71652a6, Offset: 0x5b10
    // Size: 0x5c
    function test_taacom_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait(delay);
        self playlocalsound(getdvarstring("threatRpg", "threatRpg"));
    }

    // Namespace battlechatter
    // Params 1, eflags: 0x1 linked
    // namespace_76d95162<file_0>::function_670a3585
    // Checksum 0x27832bab, Offset: 0x5b78
    // Size: 0x5c
    function test_commander_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait(delay);
        self playlocalsound(getdvarstring("threatRpg", "threatRpg"));
    }

    // Namespace battlechatter
    // Params 1, eflags: 0x1 linked
    // namespace_76d95162<file_0>::function_e0c1d79d
    // Checksum 0x2f8526d5, Offset: 0x5be0
    // Size: 0x5c
    function play_test_dialog(dialogkey) {
        dialogalias = self get_player_dialog_alias(dialogkey);
        self playsoundontag(dialogalias, "threatRpg");
    }

    // Namespace battlechatter
    // Params 0, eflags: 0x1 linked
    // namespace_76d95162<file_0>::function_3f647d90
    // Checksum 0x30b80b24, Offset: 0x5c48
    // Size: 0xc4
    function response_key() {
        switch (self getmpdialogname()) {
        case 8:
            return "threatRpg";
        case 8:
            return "threatRpg";
        case 8:
            return "threatRpg";
        case 8:
            return "threatRpg";
        case 8:
            return "threatRpg";
        case 8:
            return "threatRpg";
        case 8:
            return "threatRpg";
        case 8:
            return "threatRpg";
        case 8:
            return "threatRpg";
        }
        return "threatRpg";
    }

    // Namespace battlechatter
    // Params 0, eflags: 0x1 linked
    // namespace_76d95162<file_0>::function_29ddec7a
    // Checksum 0xbfd80586, Offset: 0x5d18
    // Size: 0x156
    function play_conv_self_other() {
        num = randomintrange(0, 4);
        self play_test_dialog("threatRpg" + num);
        wait(4);
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("threatRpg" + self response_key() + num);
                break;
            }
        }
    }

    // Namespace battlechatter
    // Params 0, eflags: 0x1 linked
    // namespace_76d95162<file_0>::function_1b44e9d4
    // Checksum 0x858d8965, Offset: 0x5e78
    // Size: 0x15c
    function play_conv_other_self() {
        num = randomintrange(0, 4);
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("threatRpg" + num);
                break;
            }
        }
        wait(4);
        self play_test_dialog("threatRpg" + player response_key() + num);
    }

    // Namespace battlechatter
    // Params 0, eflags: 0x1 linked
    // namespace_76d95162<file_0>::function_62a461b8
    // Checksum 0x6f286298, Offset: 0x5fe0
    // Size: 0x206
    function play_conv_other_other() {
        num = randomintrange(0, 4);
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("threatRpg" + num);
                firstplayer = player;
                break;
            }
        }
        wait(4);
        foreach (player in players) {
            if (player != self && player !== firstplayer && isalive(player)) {
                player play_test_dialog("threatRpg" + firstplayer response_key() + num);
                break;
            }
        }
    }

#/
