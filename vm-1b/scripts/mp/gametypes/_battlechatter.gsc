#using scripts/codescripts/struct;
#using scripts/mp/gametypes/_dev;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace battlechatter;

// Namespace battlechatter
// Params 0, eflags: 0x2
// Checksum 0xa7ec546d, Offset: 0x968
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("battlechatter", &__init__, undefined, undefined);
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0xebd464c4, Offset: 0x9a0
// Size: 0x722
function __init__() {
    /#
        level thread devgui_think();
    #/
    callback::on_joined_team(&on_joined_team);
    callback::on_spawned(&on_player_spawned);
    level.heroplaydialog = &play_dialog;
    level.var_c683774 = &function_34ac7886;
    level.var_9a636af8 = &function_822e9f2;
    level.var_8739d3ec = &function_6cb098a8;
    level.var_349f5fa0 = &function_6f5d7864;
    level.var_edff3d00 = &function_f99c509c;
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
    InvalidOpCode(0x54, "boostPlayersPicked");
    // Unknown operator (0x54, t7_1b, PC)
LOC_000003d0:
    if (level.teambased && level.teambased) {
        InvalidOpCode(0xc8, "boostPlayersPicked", []);
        // Unknown operator (0xc8, t7_1b, PC)
    }
    level.allowbattlechatter = getgametypesetting("allowBattleChatter");
    clientfield::register("world", "boost_number", 1, 2, "int");
    clientfield::register("allplayers", "play_boost", 1, 2, "int");
    level thread pick_boost_number();
    playerdialogbundles = struct::get_script_bundles("mpdialog_player");
    foreach (bundle in playerdialogbundles) {
        count_keys(bundle, "killGeneric");
        count_keys(bundle, "killSniper");
        count_keys(bundle, "heroWeaponSuccess");
        count_keys(bundle, "heroAbilitySuccess");
        count_keys(bundle, "killSpectre");
        count_keys(bundle, "killGrenadier");
        count_keys(bundle, "killOutrider");
        count_keys(bundle, "killTechnomancer");
        count_keys(bundle, "killFirebreak");
        count_keys(bundle, "killReaper");
        count_keys(bundle, "killMercenary");
        count_keys(bundle, "killEnforcer");
        count_keys(bundle, "killTrapper");
    }
    function_2412127f("tauntBoast", &function_53d12db2);
    function_2412127f("tauntGeneric", &function_8dd68236);
    function_2412127f("tauntGoodGame", &function_e0475326);
    function_2412127f("tauntThreaten", &function_b08a2a49);
    level.allowspecialistdialog = mpdialog_value("enableHeroDialog", 0) && level.allowbattlechatter;
    level.playstartconversation = mpdialog_value("enableConversation", 0) && level.allowbattlechatter;
    level.enableEndTaunt = mpdialog_value("enableEndTaunt", 0);
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0x597d0674, Offset: 0x10d0
// Size: 0x32
function pick_boost_number() {
    wait 5;
    level clientfield::set("boost_number", randomint(4));
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0xafefccbe, Offset: 0x1110
// Size: 0x157
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
    if (level.var_29d9f951 === 1 || self.pers["startGamePlayed"] === 1) {
        return;
    }
    if (self.pers["playedGameMode"] !== 1 && isdefined(level.leaderdialog) && level.inprematchperiod !== 0) {
        if (level.hardcoremode) {
            self globallogic_audio::leader_dialog_on_player(level.leaderdialog.starthcgamedialog);
        } else {
            self globallogic_audio::leader_dialog_on_player(level.leaderdialog.startgamedialog);
        }
        self.pers["playedGameMode"] = 1;
    }
    self.pers["startGamePlayed"] = 1;
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0x49f782ad, Offset: 0x1270
// Size: 0x33
function set_blops_dialog() {
    self.pers["mptaacom"] = "blops_taacom";
    self.pers["mpcommander"] = "blops_commander";
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0x8780ef32, Offset: 0x12b0
// Size: 0x33
function set_cdp_dialog() {
    self.pers["mptaacom"] = "cdp_taacom";
    self.pers["mpcommander"] = "cdp_commander";
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0xdaf80e37, Offset: 0x12f0
// Size: 0xca
function on_player_spawned() {
    self.enemythreattime = 0;
    self.heartbeatsnd = 0;
    self.soundmod = "player";
    self.voxunderwatertime = 0;
    self.voxemergebreath = 0;
    self.voxdrowning = 0;
    self.pilotisspeaking = 0;
    self.playingdialog = 0;
    self.var_6536f1db = 0;
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
// Params 1, eflags: 0x0
// Checksum 0x2c035841, Offset: 0x13c8
// Size: 0x54
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
// Params 2, eflags: 0x0
// Checksum 0xc0202a94, Offset: 0x1428
// Size: 0x78
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
// Params 0, eflags: 0x0
// Checksum 0x9deae9de, Offset: 0x14a8
// Size: 0x195
function water_vox() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        interval = mpdialog_value("underwaterInterval", 0.05);
        if (interval <= 0) {
            assert(interval > 0, "<dev string:x28>");
            return;
        }
        wait interval;
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
// Params 1, eflags: 0x0
// Checksum 0x3c87789, Offset: 0x1648
// Size: 0xca
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
// Params 2, eflags: 0x0
// Checksum 0x332df0aa, Offset: 0x1720
// Size: 0x2e
function on_player_suicide_or_team_kill(player, type) {
    self endon(#"death");
    level endon(#"game_ended");
    waittillframeend();
    if (!level.teambased) {
        return;
    }
}

// Namespace battlechatter
// Params 2, eflags: 0x0
// Checksum 0x3dd0bad9, Offset: 0x1758
// Size: 0x23
function on_player_near_explodable(object, type) {
    self endon(#"death");
    level endon(#"game_ended");
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0x4d769175, Offset: 0x1788
// Size: 0x205
function enemy_threat() {
    self endon(#"death");
    level endon(#"game_ended");
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
// Params 1, eflags: 0x0
// Checksum 0x87f38a14, Offset: 0x1998
// Size: 0x1cf
function killed_by_sniper(sniper) {
    self endon(#"disconnect");
    sniper endon(#"disconnect");
    level endon(#"game_ended");
    if (!level.teambased) {
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
// Params 2, eflags: 0x0
// Checksum 0x7530bbb4, Offset: 0x1b70
// Size: 0x10a
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
// Params 4, eflags: 0x0
// Checksum 0xb6e7aa35, Offset: 0x1c88
// Size: 0x3ea
function say_kill_battle_chatter(attacker, weapon, victim, inflictor) {
    if (weapon.skipbattlechatterkill || !isdefined(attacker) || !isplayer(attacker) || !isalive(attacker) || attacker isremotecontrolling() || attacker isinvehicle() || attacker isweaponviewonlylinked() || !isdefined(victim) || !isplayer(victim)) {
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
        if (attacker.heroweaponkillcount === mpdialog_value("heroWeaponKillCount", 0)) {
            killdialog = attacker get_random_key("heroWeaponSuccess");
            attacker thread function_98b960de();
        }
    } else if (isdefined(attacker.speedburston) && attacker.speedburston && !attacker.var_51a11dd9) {
        speedburstkilldist = mpdialog_value("speedBurstKillDistance", 0);
        if (distancesquared(attacker.origin, victim.origin) < speedburstkilldist * speedburstkilldist) {
            killdialog = attacker get_random_key("heroAbilitySuccess");
            attacker.var_51a11dd9 = 1;
        }
    } else if (!attacker.var_6536f1db && isdefined(attacker.var_9b8eaff2) && attacker.var_9b8eaff2 + mpdialog_value("camoKillTime", 0) * 1000 >= gettime()) {
        killdialog = attacker get_random_key("heroAbilitySuccess");
        attacker.var_6536f1db = 1;
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
    attacker thread wait_play_dialog(mpdialog_value("enemyKillDelay", 0), killdialog, 1, undefined, victim);
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0x27238668, Offset: 0x2080
// Size: 0x115
function grenade_tracking() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        self waittill(#"grenade_fire", grenade, weapon);
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
// Params 0, eflags: 0x0
// Checksum 0xbac1f7d0, Offset: 0x21a0
// Size: 0x115
function missile_tracking() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        self waittill(#"missile_fire", missile, weapon);
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
// Params 4, eflags: 0x0
// Checksum 0xb066e9e, Offset: 0x22c0
// Size: 0x12f
function incoming_projectile_alert(thrower, projectile, dialogkey, waittime) {
    level endon(#"game_ended");
    if (waittime <= 0) {
        assert(waittime > 0, "<dev string:x6e>");
        return;
    }
    while (true) {
        wait waittime;
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
// Params 0, eflags: 0x0
// Checksum 0xd9ac7ce3, Offset: 0x23f8
// Size: 0x8d
function sticky_grenade_tracking() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        self waittill(#"grenade_stuck", grenade);
        if (isalive(self) && isdefined(grenade)) {
            if (grenade.weapon.rootweapon.name == "sticky_grenade") {
                self thread play_dialog("stuckSticky", 6);
            }
        }
    }
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0x2c59786a, Offset: 0x2490
// Size: 0x2ad
function function_98b960de() {
    self endon(#"death");
    level endon(#"game_ended");
    if (!level.teambased) {
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
    wait mpdialog_value("enemyKillDelay", 0) + 0.1;
    while (self.playingdialog) {
        wait 0.5;
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
// Params 0, eflags: 0x0
// Checksum 0x3bc75881, Offset: 0x2748
// Size: 0x1d2
function play_promotion_reaction() {
    self endon(#"death");
    level endon(#"game_ended");
    if (!level.teambased) {
        return;
    }
    wait 9;
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
// Checksum 0xee034a91, Offset: 0x2928
// Size: 0x23
function gametype_specific_battle_chatter(event, team) {
    self endon(#"death");
    level endon(#"game_ended");
}

// Namespace battlechatter
// Params 4, eflags: 0x0
// Checksum 0x77c48ca7, Offset: 0x2958
// Size: 0x82
function play_death_vox(body, attacker, weapon, meansofdeath) {
    dialogkey = self get_death_vox(weapon, meansofdeath);
    dialogalias = self get_player_dialog_alias(dialogkey);
    if (isdefined(dialogalias)) {
        body playsoundontag(dialogalias, "J_Head");
    }
}

// Namespace battlechatter
// Params 2, eflags: 0x0
// Checksum 0xb827b098, Offset: 0x29e8
// Size: 0xe1
function get_death_vox(weapon, meansofdeath) {
    if (self isplayerunderwater()) {
        return "exertDeathDrowned";
    }
    if (isdefined(meansofdeath)) {
        switch (meansofdeath) {
        case "MOD_BURNED":
            return "exertDeathBurned";
        case "MOD_DROWN":
            return "exertDeathDrowned";
        }
    }
    if (isdefined(weapon) && meansofdeath !== "MOD_MELEE_WEAPON_BUTT") {
        switch (weapon.rootweapon.name) {
        case "hatchet":
        case "hero_armblade":
        case "knife_loadout":
            return "exertDeathStabbed";
        case "hero_firefly_swarm":
            return "exertDeathBurned";
        case "hero_lightninggun_arc":
            return "exertDeathElectrocuted";
        }
    }
    return "exertDeath";
}

// Namespace battlechatter
// Params 1, eflags: 0x0
// Checksum 0xee07b19e, Offset: 0x2ad8
// Size: 0x42
function play_killstreak_threat(killstreaktype) {
    if (!isdefined(killstreaktype) || !isdefined(level.killstreaks[killstreaktype])) {
        return;
    }
    self thread play_dialog(level.killstreaks[killstreaktype].threatdialogkey, 1);
}

// Namespace battlechatter
// Params 5, eflags: 0x0
// Checksum 0x224a38b4, Offset: 0x2b28
// Size: 0x62
function wait_play_dialog(waittime, dialogkey, dialogflags, dialogbuffer, enemy) {
    self endon(#"death");
    level endon(#"game_ended");
    if (isdefined(waittime) && waittime > 0) {
        wait waittime;
    }
    self thread play_dialog(dialogkey, dialogflags, dialogbuffer, enemy);
}

// Namespace battlechatter
// Params 4, eflags: 0x0
// Checksum 0xbf4f1f48, Offset: 0x2b98
// Size: 0x1ca
function play_dialog(dialogkey, dialogflags, dialogbuffer, enemy) {
    self endon(#"death");
    level endon(#"game_ended");
    if (!isdefined(dialogkey) || !isplayer(self) || !isalive(self) || level.gameended) {
        return;
    }
    if (!isdefined(dialogflags)) {
        dialogflags = 0;
    }
    if (!level.allowspecialistdialog && !true == 0) {
        return;
    }
    if (!isdefined(dialogbuffer)) {
        dialogbuffer = mpdialog_value("playerDialogBuffer", 0);
    }
    dialogalias = self get_player_dialog_alias(dialogkey);
    if (!isdefined(dialogalias)) {
        return;
    }
    if (self isplayerunderwater() && !!true) {
        return;
    }
    if (self.playingdialog) {
        if (!!true) {
            return;
        }
        self stopsounds();
        wait 0.05;
    }
    if (!true) {
        self playsoundontag(dialogalias, "J_Head");
    } else if (!true) {
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
// Params 1, eflags: 0x0
// Checksum 0xfa59d56d, Offset: 0x2d70
// Size: 0x4a
function wait_dialog_buffer(dialogbuffer) {
    self endon(#"death");
    self endon(#"played_dialog");
    level endon(#"game_ended");
    self.playingdialog = 1;
    if (isdefined(dialogbuffer) && dialogbuffer > 0) {
        wait dialogbuffer;
    }
    self.playingdialog = 0;
}

// Namespace battlechatter
// Params 1, eflags: 0x0
// Checksum 0x43e4faf2, Offset: 0x2dc8
// Size: 0xa
function wait_playback_time(soundalias) {
    
}

// Namespace battlechatter
// Params 1, eflags: 0x0
// Checksum 0xbc84309a, Offset: 0x2de0
// Size: 0x81
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
// Params 2, eflags: 0x0
// Checksum 0x68efc933, Offset: 0x2e70
// Size: 0xb3
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
// Params 1, eflags: 0x0
// Checksum 0x14ce228, Offset: 0x2f30
// Size: 0x92
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
// Params 0, eflags: 0x0
// Checksum 0x94406cba, Offset: 0x2fd0
// Size: 0x1a
function function_34ac7886() {
    self thread play_dialog("heroWeaponReady");
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0xa34f59e0, Offset: 0x2ff8
// Size: 0x22
function function_822e9f2() {
    self thread play_dialog("heroWeaponUse", 22, 0.05);
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0xebb497fc, Offset: 0x3028
// Size: 0x1a
function function_6cb098a8() {
    self thread play_dialog("heroAbilityReady");
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0x64102a8f, Offset: 0x3050
// Size: 0x1a
function function_6f5d7864() {
    self thread play_dialog("heroAbilityUse");
}

// Namespace battlechatter
// Params 1, eflags: 0x0
// Checksum 0x7f3ff16, Offset: 0x3078
// Size: 0x52
function function_f99c509c(waitkey) {
    if (isdefined(waitkey)) {
        waittime = mpdialog_value(waitkey, 0);
    }
    self thread wait_play_dialog(waittime, self get_random_key("heroAbilitySuccess"), 1);
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0xcd6c180a, Offset: 0x30d8
// Size: 0x32
function play_throw_hatchet() {
    self thread play_dialog("exertAxeThrow", 21, mpdialog_value("playerExertBuffer", 0));
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0xafeac259, Offset: 0x3118
// Size: 0x131
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
// Params 0, eflags: 0x0
// Checksum 0xc20695e2, Offset: 0x3258
// Size: 0x87
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
// Params 1, eflags: 0x0
// Checksum 0x48d8a36b, Offset: 0x32e8
// Size: 0xa9
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
// Params 2, eflags: 0x0
// Checksum 0x26b13a0d, Offset: 0x33a0
// Size: 0xbe
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
// Params 1, eflags: 0x0
// Checksum 0xf9920259, Offset: 0x3468
// Size: 0xbe
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
// Params 0, eflags: 0x0
// Checksum 0x57a80bca, Offset: 0x3530
// Size: 0x14d
function check_boost_start_conversation() {
    if (!level.playstartconversation) {
        return;
    }
    InvalidOpCode(0x54, "boostPlayersPicked", self.team);
    // Unknown operator (0x54, t7_1b, PC)
LOC_0000007f:
    if (!level.inprematchperiod || !level.teambased || !level.inprematchperiod || !level.teambased) {
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
// Params 2, eflags: 0x0
// Checksum 0x8ff35e6a, Offset: 0x3688
// Size: 0x55
function pick_boost_players(player1, player2) {
    player1 clientfield::set("play_boost", 1);
    player2 clientfield::set("play_boost", 2);
    InvalidOpCode(0xc8, "boostPlayersPicked", player1.team, 1);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace battlechatter
// Params 1, eflags: 0x0
// Checksum 0x9d2c9c5b, Offset: 0x36f0
// Size: 0xeb
function game_end_vox(winner) {
    if (!level.allowspecialistdialog) {
        return;
    }
    foreach (player in level.players) {
        if (isdefined(level.teams[winner])) {
            if (player.team == winner) {
                dialogkey = "boostWin";
            } else {
                dialogkey = "boostLoss";
            }
        } else {
            dialogkey = "boostDraw";
        }
        dialogalias = player get_player_dialog_alias(dialogkey);
        if (isdefined(dialogalias)) {
            player playlocalsound(dialogalias);
        }
    }
}

// Namespace battlechatter
// Params 1, eflags: 0x0
// Checksum 0x68b5ac3e, Offset: 0x37e8
// Size: 0xe5
function function_aca68a77(position) {
    if (!level.allowbattlechatter || !getdvarint("mpdialog_endtaunt", 0)) {
        return;
    }
    self endon(#"disconnect");
    self endon(#"hash_b986c14e");
    assert(isdefined(position));
    while (true) {
        for (i = 0; i < level.taunts.size; i++) {
            if (self [[ level.taunts[i].checkfunc ]]()) {
                dialogalias = self get_player_dialog_alias(level.taunts[i].dialogkey);
                if (isdefined(dialogalias)) {
                    playsoundatposition(dialogalias, position);
                    return;
                }
            }
        }
        wait 0.05;
    }
}

// Namespace battlechatter
// Params 2, eflags: 0x0
// Checksum 0x142a22ca, Offset: 0x38d8
// Size: 0x7a
function function_2412127f(dialogkey, checkfunc) {
    if (!isdefined(level.taunts)) {
        level.taunts = [];
    }
    index = level.taunts.size;
    level.taunts[index] = spawnstruct();
    level.taunts[index].dialogkey = dialogkey;
    level.taunts[index].checkfunc = checkfunc;
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0xb6914d32, Offset: 0x3960
// Size: 0x11
function function_8dd68236() {
    return self jumpbuttonpressed();
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0xb43690a7, Offset: 0x3980
// Size: 0x11
function function_b08a2a49() {
    return self reloadbuttonpressed();
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0xa404b34a, Offset: 0x39a0
// Size: 0x11
function function_53d12db2() {
    return self weaponswitchbuttonpressed();
}

// Namespace battlechatter
// Params 0, eflags: 0x0
// Checksum 0x170257f4, Offset: 0x39c0
// Size: 0x11
function function_e0475326() {
    return self stancebuttonpressed();
}

/#

    // Namespace battlechatter
    // Params 0, eflags: 0x0
    // Checksum 0xa246111f, Offset: 0x39e0
    // Size: 0x2e5
    function devgui_think() {
        setdvar("<dev string:xa8>", "<dev string:xb8>");
        setdvar("<dev string:xb9>", "<dev string:xca>");
        setdvar("<dev string:xe5>", "<dev string:xf6>");
        setdvar("<dev string:x110>", "<dev string:x124>");
        while (true) {
            wait 1;
            player = util::gethostplayer();
            if (!isdefined(player)) {
                continue;
            }
            spacing = getdvarfloat("<dev string:x145>", 0.25);
            switch (getdvarstring("<dev string:xa8>", "<dev string:xb8>")) {
            case "<dev string:x158>":
                player thread test_player_dialog(0);
                player thread test_taacom_dialog(spacing);
                player thread test_commander_dialog(2 * spacing);
                break;
            case "<dev string:x16e>":
                player thread test_player_dialog(0);
                player thread test_commander_dialog(spacing);
                break;
            case "<dev string:x17d>":
                player thread test_other_dialog(0);
                player thread test_commander_dialog(spacing);
                break;
            case "<dev string:x18d>":
                player thread test_taacom_dialog(0);
                player thread test_commander_dialog(spacing);
                break;
            case "<dev string:x19e>":
                player thread test_player_dialog(0);
                player thread test_taacom_dialog(spacing);
                break;
            case "<dev string:x1aa>":
                player thread test_other_dialog(0);
                player thread test_taacom_dialog(spacing);
                break;
            case "<dev string:x1b7>":
                player thread test_other_dialog(0);
                player thread test_player_dialog(spacing);
                break;
            case "<dev string:x1c2>":
                player thread play_conv_self_other();
                break;
            case "<dev string:x1d2>":
                player thread play_conv_other_self();
                break;
            case "<dev string:x1e2>":
                player thread play_conv_other_other();
                break;
            }
            setdvar("<dev string:xa8>", "<dev string:xb8>");
        }
    }

    // Namespace battlechatter
    // Params 1, eflags: 0x0
    // Checksum 0xf4f8bc38, Offset: 0x3cd0
    // Size: 0xb3
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
    // Params 1, eflags: 0x0
    // Checksum 0x4adb8d8d, Offset: 0x3d90
    // Size: 0x52
    function test_player_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait delay;
        self playsoundontag(getdvarstring("<dev string:xb9>", "<dev string:xb8>"), "<dev string:x1f3>");
    }

    // Namespace battlechatter
    // Params 1, eflags: 0x0
    // Checksum 0x3e4b49cc, Offset: 0x3df0
    // Size: 0x4a
    function test_taacom_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait delay;
        self playlocalsound(getdvarstring("<dev string:xe5>", "<dev string:xb8>"));
    }

    // Namespace battlechatter
    // Params 1, eflags: 0x0
    // Checksum 0x3d89c0ac, Offset: 0x3e48
    // Size: 0x4a
    function test_commander_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait delay;
        self playlocalsound(getdvarstring("<dev string:x110>", "<dev string:xb8>"));
    }

    // Namespace battlechatter
    // Params 1, eflags: 0x0
    // Checksum 0xae7141e3, Offset: 0x3ea0
    // Size: 0x4a
    function play_test_dialog(dialogkey) {
        dialogalias = self get_player_dialog_alias(dialogkey);
        self playsoundontag(dialogalias, "<dev string:x1f3>");
    }

    // Namespace battlechatter
    // Params 0, eflags: 0x0
    // Checksum 0xc35964d6, Offset: 0x3ef8
    // Size: 0xba
    function response_key() {
        switch (self getmpdialogname()) {
        case "<dev string:x1fa>":
            return "<dev string:x203>";
        case "<dev string:x20b>":
            return "<dev string:x215>";
        case "<dev string:x21f>":
            return "<dev string:x228>";
        case "<dev string:x231>":
            return "<dev string:x239>";
        case "<dev string:x246>":
            return "<dev string:x24b>";
        case "<dev string:x255>":
            return "<dev string:x25c>";
        case "<dev string:x263>":
            return "<dev string:x268>";
        case "<dev string:x272>":
            return "<dev string:x279>";
        case "<dev string:x282>":
            return "<dev string:x28a>";
        }
        return "<dev string:xb8>";
    }

    // Namespace battlechatter
    // Params 0, eflags: 0x0
    // Checksum 0x298ed2d7, Offset: 0x3fc0
    // Size: 0xfd
    function play_conv_self_other() {
        num = randomintrange(0, 4);
        self play_test_dialog("<dev string:x292>" + num);
        wait 4;
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("<dev string:x29d>" + self response_key() + num);
                break;
            }
        }
    }

    // Namespace battlechatter
    // Params 0, eflags: 0x0
    // Checksum 0x1279d399, Offset: 0x40c8
    // Size: 0x102
    function play_conv_other_self() {
        num = randomintrange(0, 4);
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("<dev string:x292>" + num);
                break;
            }
        }
        wait 4;
        self play_test_dialog("<dev string:x29d>" + player response_key() + num);
    }

    // Namespace battlechatter
    // Params 0, eflags: 0x0
    // Checksum 0xd400ef40, Offset: 0x41d8
    // Size: 0x17d
    function play_conv_other_other() {
        num = randomintrange(0, 4);
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("<dev string:x292>" + num);
                firstplayer = player;
                break;
            }
        }
        wait 4;
        foreach (player in players) {
            if (player != self && player !== firstplayer && isalive(player)) {
                player play_test_dialog("<dev string:x29d>" + firstplayer response_key() + num);
                break;
            }
        }
    }

#/
