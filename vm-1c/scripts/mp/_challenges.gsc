#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/killstreaks/_counteruav;
#using scripts/mp/killstreaks/_emp;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_satellite;
#using scripts/mp/killstreaks/_uav;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/drown;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weapon_utils;

#namespace challenges;

// Namespace challenges
// Params 0, eflags: 0x2
// Checksum 0xb294abc0, Offset: 0x1580
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("challenges", &__init__, undefined, undefined);
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x6ecf4f5a, Offset: 0x15c0
// Size: 0x8c
function __init__() {
    callback::on_start_gametype(&start_gametype);
    callback::on_spawned(&on_player_spawn);
    level.heroabilityactivateneardeath = &heroabilityactivateneardeath;
    level.var_3b36608e = &function_3b36608e;
    level.capturedobjectivefunction = &capturedobjectivefunction;
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x46577074, Offset: 0x1658
// Size: 0xcc
function start_gametype() {
    if (!isdefined(level.challengescallbacks)) {
        level.challengescallbacks = [];
    }
    waittillframeend();
    if (isdefined(level.scoreeventgameendcallback)) {
        registerchallengescallback("gameEnd", level.scoreeventgameendcallback);
    }
    if (canprocesschallenges()) {
        registerchallengescallback("playerKilled", &challengekills);
        registerchallengescallback("gameEnd", &challengegameendmp);
    }
    callback::on_connect(&on_player_connect);
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x455c871f, Offset: 0x1730
// Size: 0x74
function on_player_connect() {
    initchallengedata();
    self function_99029c8b();
    self thread spawnwatcher();
    self thread monitorreloads();
    self thread monitorgrenadefire();
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x63a30897, Offset: 0x17b0
// Size: 0xe2
function initchallengedata() {
    self.pers["bulletStreak"] = 0;
    self.pers["lastBulletKillTime"] = 0;
    self.pers["stickExplosiveKill"] = 0;
    self.pers["carepackagesCalled"] = 0;
    self.pers["challenge_destroyed_air"] = 0;
    self.pers["challenge_destroyed_ground"] = 0;
    self.pers["challenge_anteup_earn"] = 0;
    self.pers["specialistStatAbilityUsage"] = 0;
    self.pers["canSetSpecialistStat"] = self isspecialistunlocked();
    self.pers["activeKillstreaks"] = [];
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0xd62a0c08, Offset: 0x18a0
// Size: 0xf2
function function_99029c8b() {
    if (!isdefined(self.pers["challenge_heroweaponkills"])) {
        var_86a740f0 = self getloadoutitemref(0, "heroWeapon");
        heroweapon = getweapon(var_86a740f0);
        if (heroweapon == level.weaponnone) {
            heroabilityname = self getheroabilityname();
            heroweapon = getweapon(heroabilityname);
        }
        if (heroweapon != level.weaponnone) {
            self addweaponstat(heroweapon, "used", 1);
        }
        self.pers["challenge_heroweaponkills"] = 0;
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0xf1cddd98, Offset: 0x19a0
// Size: 0x218
function spawnwatcher() {
    self endon(#"disconnect");
    self.pers["killNemesis"] = 0;
    self.pers["killsFastMagExt"] = 0;
    self.pers["longshotsPerLife"] = 0;
    self.pers["specialistStatAbilityUsage"] = 0;
    self.challenge_defenderkillcount = 0;
    self.challenge_offenderkillcount = 0;
    self.challenge_offenderprojectilemultikillcount = 0;
    self.challenge_offendercomlinkkillcount = 0;
    self.challenge_offendersentryturretkillcount = 0;
    self.challenge_objectivedefensivekillcount = 0;
    self.challenge_objectiveoffensivekillcount = 0;
    self.challenge_scavengedcount = 0;
    self.challenge_resuppliednamekills = 0;
    self.challenge_objectivedefensive = undefined;
    self.challenge_objectiveoffensive = undefined;
    self.challenge_lastsurvivewithflakfrom = undefined;
    self.explosiveinfo = [];
    for (;;) {
        self waittill(#"spawned_player");
        self.weaponkillsthisspawn = [];
        self.attachmentkillsthisspawn = [];
        self.challenge_hatchettosscount = 0;
        self.challenge_hatchetkills = 0;
        self.retreivedblades = 0;
        self.challenge_combatrobotattackclientid = [];
        self thread function_92823005();
        self thread watchjump();
        self thread watchswimming();
        self thread function_7f4a227d();
        self thread watchslide();
        self thread watchsprint();
        self thread watchscavengelethal();
        self thread function_de32795d();
        self thread watchweaponchangecomplete();
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0xc01921de, Offset: 0x1bc0
// Size: 0x3c
function watchscavengelethal() {
    self endon(#"death");
    self endon(#"disconnect");
    self.challenge_scavengedcount = 0;
    for (;;) {
        self waittill(#"scavenged_primary_grenade");
        self.challenge_scavengedcount++;
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x70d6de95, Offset: 0x1c08
// Size: 0xaa
function function_92823005() {
    self endon(#"death");
    self endon(#"disconnect");
    self.var_150f7cf6 = 0;
    self.var_fdd0883a = 0;
    for (;;) {
        ret = util::waittill_any_return("doublejump_begin", "doublejump_end", "disconnect");
        switch (ret) {
        case "doublejump_begin":
            self.var_150f7cf6 = gettime();
            break;
        case "doublejump_end":
            self.var_fdd0883a = gettime();
            break;
        }
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x9fe93fd1, Offset: 0x1cc0
// Size: 0xaa
function watchjump() {
    self endon(#"death");
    self endon(#"disconnect");
    self.challenge_jump_begin = 0;
    self.challenge_jump_end = 0;
    for (;;) {
        ret = util::waittill_any_return("jump_begin", "jump_end", "disconnect");
        switch (ret) {
        case "jump_begin":
            self.challenge_jump_begin = gettime();
            break;
        case "jump_end":
            self.challenge_jump_end = gettime();
            break;
        }
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0xf7c06195, Offset: 0x1d78
// Size: 0xaa
function watchswimming() {
    self endon(#"death");
    self endon(#"disconnect");
    self.challenge_swimming_begin = 0;
    self.challenge_swimming_end = 0;
    for (;;) {
        ret = util::waittill_any_return("swimming_begin", "swimming_end", "disconnect");
        switch (ret) {
        case "swimming_begin":
            self.challenge_swimming_begin = gettime();
            break;
        case "swimming_end":
            self.challenge_swimming_end = gettime();
            break;
        }
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0xb31cc6c, Offset: 0x1e30
// Size: 0xaa
function function_7f4a227d() {
    self endon(#"death");
    self endon(#"disconnect");
    self.var_da3759c8 = 0;
    self.var_77c2a8fc = 0;
    for (;;) {
        ret = util::waittill_any_return("wallrun_begin", "wallrun_end", "disconnect");
        switch (ret) {
        case "wallrun_begin":
            self.var_da3759c8 = gettime();
            break;
        case "wallrun_end":
            self.var_77c2a8fc = gettime();
            break;
        }
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x9bebde7b, Offset: 0x1ee8
// Size: 0xaa
function watchslide() {
    self endon(#"death");
    self endon(#"disconnect");
    self.challenge_slide_begin = 0;
    self.challenge_slide_end = 0;
    for (;;) {
        ret = util::waittill_any_return("slide_begin", "slide_end", "disconnect");
        switch (ret) {
        case "slide_begin":
            self.challenge_slide_begin = gettime();
            break;
        case "slide_end":
            self.challenge_slide_end = gettime();
            break;
        }
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x3f95195b, Offset: 0x1fa0
// Size: 0xaa
function watchsprint() {
    self endon(#"death");
    self endon(#"disconnect");
    self.challenge_sprint_begin = 0;
    self.challenge_sprint_end = 0;
    for (;;) {
        ret = util::waittill_any_return("sprint_begin", "sprint_end", "disconnect");
        switch (ret) {
        case "sprint_begin":
            self.challenge_sprint_begin = gettime();
            break;
        case "sprint_end":
            self.challenge_sprint_end = gettime();
            break;
        }
    }
}

// Namespace challenges
// Params 1, eflags: 0x0
// Checksum 0x352c9d1b, Offset: 0x2058
// Size: 0x37ac
function challengekills(data) {
    victim = data.victim;
    attacker = data.attacker;
    time = data.time;
    level.numkills++;
    attacker.lastkilledplayer = victim;
    var_3828b415 = data.var_3828b415;
    var_dc7e5b14 = data.var_dc7e5b14;
    attackerheroability = data.attackerheroability;
    attackerheroabilityactive = data.attackerheroabilityactive;
    attackersliding = data.attackersliding;
    attackerspeedburst = data.attackerspeedburst;
    attackertraversing = data.attackertraversing;
    attackervisionpulseactivatetime = data.attackervisionpulseactivatetime;
    attackervisionpulsearray = data.attackervisionpulsearray;
    attackervisionpulseorigin = data.attackervisionpulseorigin;
    attackervisionpulseoriginarray = data.attackervisionpulseoriginarray;
    var_e4763e35 = data.var_e4763e35;
    attackerwasconcussed = data.attackerwasconcussed;
    attackerwasflashed = data.attackerwasflashed;
    attackerwasheatwavestunned = data.attackerwasheatwavestunned;
    attackerwasonground = data.attackeronground;
    attackerwasunderwater = data.attackerwasunderwater;
    attackerlastfastreloadtime = data.attackerlastfastreloadtime;
    lastweaponbeforetoss = data.lastweaponbeforetoss;
    meansofdeath = data.smeansofdeath;
    ownerweaponatlaunch = data.ownerweaponatlaunch;
    victimbedout = data.bledout;
    victimorigin = data.victimorigin;
    victimcombatefficiencylastontime = data.victimcombatefficiencylastontime;
    victimcombatefficieny = data.victimcombatefficieny;
    victimelectrifiedby = data.victimelectrifiedby;
    var_8eff9c3 = data.var_8eff9c3;
    victimheroability = data.victimheroability;
    victimheroabilityactive = data.victimheroabilityactive;
    victimspeedburst = data.victimspeedburst;
    victimspeedburstlastontime = data.victimspeedburstlastontime;
    victimvisionpulseactivatetime = data.victimvisionpulseactivatetime;
    victimvisionpulseactivatetime = data.victimvisionpulseactivatetime;
    victimvisionpulsearray = data.victimvisionpulsearray;
    victimvisionpulseorigin = data.victimvisionpulseorigin;
    victimvisionpulseoriginarray = data.victimvisionpulseoriginarray;
    victimattackersthisspawn = data.victimattackersthisspawn;
    var_b9995fb9 = data.var_b9995fb9;
    victimwasinslamstate = data.victimwasinslamstate;
    victimwaslungingwitharmblades = data.victimwaslungingwitharmblades;
    victimwasonground = data.victimonground;
    victimwasunderwater = data.wasunderwater;
    var_f67ec791 = data.var_f67ec791;
    victimlaststunnedby = data.victimlaststunnedby;
    victimactiveproximitygrenades = data.victim.activeproximitygrenades;
    victimactivebouncingbetties = data.victim.activebouncingbetties;
    attackerlastflashedby = data.attackerlastflashedby;
    attackerlaststunnedby = data.attackerlaststunnedby;
    attackerlaststunnedtime = data.attackerlaststunnedtime;
    attackerwassliding = data.attackerwassliding;
    attackerwassprinting = data.attackerwassprinting;
    wasdefusing = data.wasdefusing;
    wasplanting = data.wasplanting;
    inflictorownerwassprinting = data.inflictorownerwassprinting;
    player = data.attacker;
    playerorigin = data.attackerorigin;
    weapon = data.weapon;
    var_5bd9ee89 = data.var_5bd9ee89;
    var_82701a51 = data.var_82701a51;
    victim_jump_begin = data.victim_jump_begin;
    victim_jump_end = data.victim_jump_end;
    victim_swimming_begin = data.victim_swimming_begin;
    victim_swimming_end = data.victim_swimming_end;
    victim_slide_begin = data.victim_slide_begin;
    victim_slide_end = data.victim_slide_end;
    var_5d1971dd = data.var_5d1971dd;
    var_d4842f85 = data.var_d4842f85;
    var_6a9f8d24 = data.var_6a9f8d24;
    var_f4b4b342 = data.var_f4b4b342;
    var_3e129f16 = data.var_3e129f16;
    attacker_jump_begin = data.attacker_jump_begin;
    attacker_jump_end = data.attacker_jump_end;
    attacker_swimming_begin = data.attacker_swimming_begin;
    attacker_swimming_end = data.attacker_swimming_end;
    attacker_slide_begin = data.attacker_slide_begin;
    attacker_slide_end = data.attacker_slide_end;
    var_519c883c = data.var_519c883c;
    var_80924500 = data.var_80924500;
    var_f7f92f13 = data.var_f7f92f13;
    attacker_sprint_end = data.attacker_sprint_end;
    attacker_sprint_begin = data.attacker_sprint_begin;
    var_b041219e = data.var_b041219e;
    inflictoriscooked = data.inflictoriscooked;
    inflictorchallenge_hatchettosscount = data.inflictorchallenge_hatchettosscount;
    inflictorownerwassprinting = data.inflictorownerwassprinting;
    inflictorplayerhasengineerperk = data.inflictorplayerhasengineerperk;
    inflictor = data.einflictor;
    if (!isdefined(data.weapon)) {
        return;
    }
    if (!isdefined(player) || !isplayer(player) || weapon == level.weaponnone) {
        return;
    }
    weaponclass = util::getweaponclass(weapon);
    baseweapon = getbaseweapon(weapon);
    baseweaponitemindex = getbaseweaponitemindex(baseweapon);
    weaponpurchased = player isitempurchased(baseweaponitemindex);
    victimsupportindex = victim.team;
    playersupportindex = player.team;
    if (!level.teambased) {
        playersupportindex = player.entnum;
        victimsupportindex = victim.entnum;
    }
    if (meansofdeath == "MOD_HEAD_SHOT" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET") {
        bulletkill = 1;
    } else {
        bulletkill = 0;
    }
    if (level.teambased) {
        if (player.team == victim.team) {
            return;
        }
    } else if (player == victim) {
        return;
    }
    killstreak = killstreaks::get_from_weapon(data.weapon);
    if (!isdefined(killstreak)) {
        player processspecialistchallenge("kills");
        if (weapon.isheroweapon == 1) {
            player processspecialistchallenge("kills_weapon");
            player.var_39c0d0ac++;
            player.pers["challenge_heroweaponkills"]++;
            if (player.pers["challenge_heroweaponkills"] >= 6) {
                player processspecialistchallenge("kill_one_game_weapon");
                player.pers["challenge_heroweaponkills"] = 0;
            }
        }
    }
    if (bulletkill) {
        if (weaponpurchased) {
            if (weaponclass == "weapon_sniper") {
                if (isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time) {
                    player addplayerstat("kill_enemy_one_bullet_sniper", 1);
                    player addweaponstat(weapon, "kill_enemy_one_bullet_sniper", 1);
                }
            } else if (weaponclass == "weapon_cqb") {
                if (isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time) {
                    player addplayerstat("kill_enemy_one_bullet_shotgun", 1);
                    player addweaponstat(weapon, "kill_enemy_one_bullet_shotgun", 1);
                }
            }
        }
        if (getdvarint("ui_enablePromoTracking", 0) && meansofdeath == "MOD_HEAD_SHOT") {
            util::function_522d8c7d(1);
        }
        if (time - data.attacker_swimming_end <= 2000 && time - data.var_f4b4b342 <= 2000) {
            player addplayerstat("kill_after_doublejump_out_of_water", 1);
        }
        if (attackerwassliding) {
            if (var_3e129f16 == attacker_slide_begin) {
                player addplayerstat("kill_while_sliding_from_doublejump", 1);
            }
        }
        if (player isbonuscardactive(2, player.class_num) && player isitempurchased(getitemindexfromref("bonuscard_primary_gunfighter_3"))) {
            if (isdefined(weapon.attachments) && weapon.attachments.size == 6) {
                player addplayerstat("kill_with_gunfighter", 1);
            }
        }
        checkkillstreak5(baseweapon, player);
        if (weapon.isdualwield && weaponpurchased) {
            checkdualwield(baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end);
        }
        if (isdefined(weapon.attachments) && weapon.attachments.size > 0) {
            attachmentname = player getweaponoptic(weapon);
            if (isdefined(attachmentname) && attachmentname != "" && player weaponhasattachmentandunlocked(weapon, attachmentname)) {
                if (weapon.attachments.size > 5 && player allweaponattachmentsunlocked(weapon) && !isdefined(attacker.tookweaponfrom[weapon])) {
                    player addplayerstat("kill_optic_5_attachments", 1);
                }
                if (isdefined(player.attachmentkillsthisspawn[attachmentname])) {
                    player.attachmentkillsthisspawn[attachmentname]++;
                    if (player.attachmentkillsthisspawn[attachmentname] == 5) {
                        player addweaponstat(weapon, "killstreak_5_attachment", 1);
                    }
                } else {
                    player.attachmentkillsthisspawn[attachmentname] = 1;
                }
                if (weapon_utils::ispistol(weapon.rootweapon)) {
                    if (player weaponhasattachmentandunlocked(weapon, "suppressed", "extbarrel")) {
                        player addplayerstat("kills_pistol_lasersight_suppressor_longbarrel", 1);
                    }
                }
            }
            if (player weaponhasattachmentandunlocked(weapon, "suppressed")) {
                if (attacker util::has_hard_wired_perk_purchased_and_equipped() && attacker util::has_ghost_perk_purchased_and_equipped() && attacker util::has_jetquiet_perk_purchased_and_equipped()) {
                    player addplayerstat("kills_suppressor_ghost_hardwired_blastsuppressor", 1);
                }
            }
            if (player playerads() == 1) {
                if (isdefined(player.smokegrenadetime) && isdefined(player.smokegrenadeposition)) {
                    if (player.smokegrenadetime + 14000 > time) {
                        if (player util::is_looking_at(player.smokegrenadeposition) || distancesquared(player.origin, player.smokegrenadeposition) < 40000) {
                            if (player weaponhasattachmentandunlocked(weapon, "ir")) {
                                player addplayerstat("kill_with_thermal_and_smoke_ads", 1);
                                player addweaponstat(weapon, "kill_thermal_through_smoke", 1);
                            }
                        }
                    }
                }
            }
            if (weapon.attachments.size > 1) {
                if (player playerads() == 1) {
                    if (player weaponhasattachmentandunlocked(weapon, "grip", "quickdraw")) {
                        player addplayerstat("kills_ads_quickdraw_and_grip", 1);
                    }
                    if (player weaponhasattachmentandunlocked(weapon, "swayreduc", "stalker")) {
                        player addplayerstat("kills_ads_stock_and_cpu", 1);
                    }
                } else if (player weaponhasattachmentandunlocked(weapon, "rf", "steadyaim")) {
                    if (attacker util::has_fast_hands_perk_purchased_and_equipped()) {
                        player addplayerstat("kills_hipfire_rapidfire_lasersights_fasthands", 1);
                    }
                }
                if (player weaponhasattachmentandunlocked(weapon, "fastreload", "extclip")) {
                    player.pers["killsFastMagExt"]++;
                    if (player.pers["killsFastMagExt"] > 4) {
                        player addplayerstat("kills_one_life_fastmags_and_extclip", 1);
                        player.pers["killsFastMagExt"] = 0;
                    }
                }
            }
            if (weapon.attachments.size > 2) {
                if (meansofdeath == "MOD_HEAD_SHOT") {
                    if (player weaponhasattachmentandunlocked(weapon, "fmj", "damage", "extbarrel")) {
                        player addplayerstat("headshot_fmj_highcaliber_longbarrel", 1);
                    }
                }
            }
            if (weapon.attachments.size > 4) {
                if (player weaponhasattachmentandunlocked(weapon, "extclip", "grip", "fastreload", "quickdraw", "stalker")) {
                    player addplayerstat("kills_extclip_grip_fastmag_quickdraw_stock", 1);
                }
            }
        }
        if (var_6a9f8d24 && var_f7f92f13) {
            player addplayerstat("dr_lung", 1);
        }
        if (isdefined(attackerlastfastreloadtime) && time - attackerlastfastreloadtime <= 5000 && player weaponhasattachmentandunlocked(weapon, "fastreload")) {
            player addplayerstat("kills_after_reload_fastreload", 1);
        }
        if (victim.idflagstime == time) {
            if (victim.idflags & 8) {
                player addplayerstat("kill_enemy_through_wall", 1);
                if (player weaponhasattachmentandunlocked(weapon, "fmj")) {
                    player addplayerstat("kill_enemy_through_wall_with_fmj", 1);
                }
            }
        }
        if (var_b041219e === 1) {
            player addplayerstat("kill_while_wallrunning_2_walls", 1);
        }
    } else if (weapon_utils::ismeleemod(meansofdeath) && !isdefined(killstreak)) {
        player addplayerstat("melee", 1);
        if (weapon_utils::ispunch(weapon)) {
            player addplayerstat("kill_enemy_with_fists", 1);
        }
        checkkillstreak5(baseweapon, player);
    } else {
        if (weaponpurchased) {
            if (weapon == player.grenadetypeprimary) {
                if (player.challenge_scavengedcount > 0) {
                    player.challenge_resuppliednamekills++;
                    if (player.challenge_resuppliednamekills >= 3) {
                        player addplayerstat("kills_3_resupplied_nade_one_life", 1);
                        player.challenge_resuppliednamekills = 0;
                    }
                    player.challenge_scavengedcount--;
                }
            }
            if (isdefined(inflictoriscooked)) {
                if (inflictoriscooked == 1 && weapon.rootweapon.name != "hatchet") {
                    player addplayerstat("kill_with_cooked_grenade", 1);
                }
            }
            if (victimlaststunnedby === player) {
                if (weaponclass == "weapon_grenade") {
                    player addplayerstat("kill_stun_lethal", 1);
                }
            }
            if (baseweapon == level.weaponspecialcrossbow) {
                if (weapon.isdualwield) {
                    checkdualwield(baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end);
                }
            }
            if (baseweapon == level.weaponshotgunenergy) {
                if (isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time) {
                    player addplayerstat("kill_enemy_one_bullet_shotgun", 1);
                    player addweaponstat(weapon, "kill_enemy_one_bullet_shotgun", 1);
                }
            }
        }
        if (baseweapon.forcedamagehitlocation || baseweapon == level.weaponspecialcrossbow || baseweapon == level.weaponshotgunenergy || baseweapon == level.var_a0d4ce4d || baseweapon == level.weaponballisticknife || baseweapon == level.var_75c8bd53) {
            checkkillstreak5(baseweapon, player);
        }
    }
    if (isdefined(attacker.tookweaponfrom[weapon]) && isdefined(attacker.tookweaponfrom[weapon].previousowner)) {
        if (!isdefined(attacker.tookweaponfrom[weapon].previousowner.team) || attacker.tookweaponfrom[weapon].previousowner.team != player.team) {
            player addplayerstat("kill_with_pickup", 1);
        }
    }
    awarded_kill_enemy_that_blinded_you = 0;
    playerhastacticalmask = loadout::function_bb61b344(player);
    if (attackerwasflashed) {
        if (attackerlastflashedby === victim && !playerhastacticalmask) {
            player addplayerstat("kill_enemy_that_blinded_you", 1);
            awarded_kill_enemy_that_blinded_you = 1;
        }
    }
    if (!awarded_kill_enemy_that_blinded_you && isdefined(attackerlaststunnedtime) && attackerlaststunnedtime + 5000 > time) {
        if (attackerlaststunnedby === victim && !playerhastacticalmask) {
            player addplayerstat("kill_enemy_that_blinded_you", 1);
            awarded_kill_enemy_that_blinded_you = 1;
        }
    }
    killedstunnedvictim = 0;
    if (isdefined(victim.lastconcussedby) && victim.lastconcussedby == attacker) {
        if (victim.concussionendtime > time) {
            if (player util::is_item_purchased("concussion_grenade")) {
                player addplayerstat("kill_concussed_enemy", 1);
            }
            killedstunnedvictim = 1;
            player addweaponstat(getweapon("concussion_grenade"), "CombatRecordStat", 1);
        }
    }
    if (isdefined(victim.lastshockedby) && victim.lastshockedby == attacker) {
        if (victim.shockendtime > time) {
            if (player util::is_item_purchased("proximity_grenade")) {
                player addplayerstat("kill_shocked_enemy", 1);
            }
            player addweaponstat(getweapon("proximity_grenade"), "CombatRecordStat", 1);
            killedstunnedvictim = 1;
            if (weapon.rootweapon.name == "bouncingbetty") {
                player addplayerstat("kill_trip_mine_shocked", 1);
            }
        }
    }
    if (victim util::isflashbanged()) {
        if (isdefined(victim.lastflashedby) && victim.lastflashedby == player) {
            killedstunnedvictim = 1;
            if (player util::is_item_purchased("flash_grenade")) {
                player addplayerstat("kill_flashed_enemy", 1);
            }
            player addweaponstat(getweapon("flash_grenade"), "CombatRecordStat", 1);
        }
    }
    if (level.teambased) {
        if (level.playercount[victim.pers["team"]] > 3 && !isdefined(player.pers["kill_every_enemy_with_specialist"]) && player.pers["killed_players_with_specialist"].size >= level.playercount[victim.pers["team"]]) {
            player addplayerstat("kill_every_enemy", 1);
            player.pers["kill_every_enemy_with_specialist"] = 1;
        }
        if (isdefined(victimattackersthisspawn) && isarray(victimattackersthisspawn)) {
            if (victimattackersthisspawn.size > 5) {
                attackercount = 0;
                foreach (attacking_player in victimattackersthisspawn) {
                    if (!isdefined(attacking_player)) {
                        continue;
                    }
                    if (attacking_player == attacker) {
                        continue;
                    }
                    if (attacking_player.team != attacker.team) {
                        continue;
                    }
                    attackercount++;
                }
                if (attackercount > 4) {
                    player addplayerstat("kill_enemy_5_teammates_assists", 1);
                }
            }
        }
    }
    if (isdefined(killstreak)) {
        if (killstreak == "rcbomb" || killstreak == "inventory_rcbomb") {
            if (!victimwasonground || var_f67ec791) {
                player addplayerstat("kill_wallrunner_or_air_with_rcbomb", 1);
            }
        }
        if (killstreak == "autoturret" || killstreak == "inventory_autoturret") {
            if (isdefined(inflictor) && player util::is_item_purchased("killstreak_auto_turret")) {
                if (!isdefined(inflictor.challenge_killcount)) {
                    inflictor.challenge_killcount = 0;
                }
                inflictor.challenge_killcount++;
                if (inflictor.challenge_killcount == 5) {
                    player addplayerstat("kills_auto_turret_5", 1);
                }
            }
        }
    }
    if (isdefined(victim.challenge_combatrobotattackclientid[player.clientid])) {
        if (!isdefined(inflictor) || !isdefined(inflictor.killstreaktype) || !isstring(inflictor.killstreaktype) || inflictor.killstreaktype != "combat_robot") {
            player addplayerstat("kill_enemy_who_damaged_robot", 1);
        }
    }
    if (player isbonuscardactive(8, player.class_num) && player util::is_item_purchased("bonuscard_danger_close")) {
        if (weaponclass == "weapon_grenade") {
            player addbonuscardstat(8, "kills", 1, player.class_num);
        }
        if (weapon.rootweapon.name == "hatchet" && inflictorchallenge_hatchettosscount <= 2) {
            player.challenge_hatchetkills++;
            if (player.challenge_hatchetkills == 2) {
                player addplayerstat("kills_first_throw_both_hatchets", 1);
            }
        }
    }
    player trackkillstreaksupportkills(victim);
    if (!isdefined(killstreak)) {
        if (attackerwasunderwater) {
            player addplayerstat("kill_while_underwater", 1);
        }
        if (player util::has_purchased_perk_equipped("specialty_jetcharger")) {
            if (attacker_slide_begin > attacker_slide_end || var_f4b4b342 > var_3e129f16 || var_3e129f16 + 3000 > time || attacker_slide_end + 3000 > time) {
                player addplayerstat("kills_after_jumping_or_sliding", 1);
                if (player util::has_purchased_perk_equipped("specialty_overcharge")) {
                    player addplayerstat("kill_overclock_afterburner_specialist_weapon_after_thrust", 1);
                }
            }
        }
        trackedplayer = 0;
        if (player util::has_purchased_perk_equipped("specialty_tracker")) {
            if (!victim hasperk("specialty_trackerjammer")) {
                player addplayerstat("kill_detect_tracker", 1);
                trackedplayer = 1;
            }
        }
        if (player util::has_purchased_perk_equipped("specialty_detectnearbyenemies")) {
            if (!victim hasperk("specialty_sixthsensejammer")) {
                player addplayerstat("kill_enemy_sixth_sense", 1);
                if (player util::has_purchased_perk_equipped("specialty_loudenemies")) {
                    if (!victim hasperk("specialty_quieter")) {
                        player addplayerstat("kill_sixthsense_awareness", 1);
                    }
                }
            }
            if (trackedplayer) {
                player addplayerstat("kill_tracker_sixthsense", 1);
            }
        }
        if (weapon.isheroweapon == 1 || attackerheroabilityactive) {
            if (player util::has_purchased_perk_equipped("specialty_overcharge")) {
                player addplayerstat("kill_with_specialist_overclock", 1);
            }
        }
        if (player util::has_purchased_perk_equipped("specialty_gpsjammer")) {
            if (uav::hasuav(victimsupportindex)) {
                player addplayerstat("kill_uav_enemy_with_ghost", 1);
            }
            if (player util::has_blind_eye_perk_purchased_and_equipped()) {
                activekillstreaks = victim killstreaks::getactivekillstreaks();
                awarded_kill_blindeye_ghost_aircraft = 0;
                foreach (activestreak in activekillstreaks) {
                    if (awarded_kill_blindeye_ghost_aircraft) {
                        continue;
                    }
                    switch (activestreak.killstreaktype) {
                    case "drone_striked":
                    case "helicopter_comlink":
                    case "sentinel":
                    case "uav":
                        player addplayerstat("kill_blindeye_ghost_aircraft", 1);
                        awarded_kill_blindeye_ghost_aircraft = 1;
                        break;
                    }
                }
            }
        }
        if (player util::has_purchased_perk_equipped("specialty_flakjacket")) {
            if (isdefined(player.challenge_lastsurvivewithflakfrom) && player.challenge_lastsurvivewithflakfrom == victim) {
                player addplayerstat("kill_enemy_survive_flak", 1);
            }
            if (player util::has_tactical_mask_purchased_and_equipped()) {
                var_7488049d = 0;
                if (isdefined(player.challenge_lastsurvivewithflaktime)) {
                    if (player.challenge_lastsurvivewithflaktime + 3000 > time) {
                        var_7488049d = 1;
                    }
                }
                var_186c1d3e = 0;
                if (isdefined(player.laststunnedtime)) {
                    if (player.laststunnedtime + 2000 > time) {
                        var_186c1d3e = 1;
                    }
                }
                if (var_7488049d || player util::isflashbanged() || var_186c1d3e) {
                    player addplayerstat("kill_flak_tac_while_stunned", 1);
                }
            }
        }
        if (player util::has_hard_wired_perk_purchased_and_equipped()) {
            if (victim counteruav::hasindexactivecounteruav(victimsupportindex) || victim emp::hasactiveemp()) {
                player addplayerstat("kills_counteruav_emp_hardline", 1);
            }
        }
        if (player util::has_scavenger_perk_purchased_and_equipped()) {
            if (player.scavenged) {
                player addplayerstat("kill_after_resupply", 1);
                if (trackedplayer) {
                    player addplayerstat("kill_scavenger_tracker_resupply", 1);
                }
            }
        }
        if (player util::has_fast_hands_perk_purchased_and_equipped()) {
            if (bulletkill) {
                if (attackerwassprinting || attacker_sprint_end + 3000 > time) {
                    player addplayerstat("kills_after_sprint_fasthands", 1);
                    if (player util::has_gung_ho_perk_purchased_and_equipped()) {
                        player addplayerstat("kill_fasthands_gungho_sprint", 1);
                    }
                }
            }
        }
        if (player util::has_hard_wired_perk_purchased_and_equipped()) {
            if (player util::has_cold_blooded_perk_purchased_and_equipped()) {
                player addplayerstat("kill_hardwired_coldblooded", 1);
            }
        }
        killedplayerwithgungho = 0;
        if (player util::has_gung_ho_perk_purchased_and_equipped()) {
            if (bulletkill) {
                killedplayerwithgungho = 1;
                if (attackerwassprinting && player playerads() != 1) {
                    player addplayerstat("kill_hip_gung_ho", 1);
                }
            }
            if (weaponclass == "weapon_grenade") {
                if (isdefined(inflictorownerwassprinting) && inflictorownerwassprinting == 1) {
                    killedplayerwithgungho = 1;
                    player addplayerstat("kill_hip_gung_ho", 1);
                }
            }
        }
        if (player util::has_jetquiet_perk_purchased_and_equipped()) {
            if (var_3828b415 || var_3e129f16 + 3000 > time) {
                player addplayerstat("kill_blast_doublejump", 1);
                if (player util::has_ghost_perk_purchased_and_equipped()) {
                    if (uav::hasuav(victimsupportindex)) {
                        player addplayerstat("kill_doublejump_uav_engineer_hardwired", 1);
                    }
                }
            }
        }
        if (player util::has_awareness_perk_purchased_and_equipped()) {
            player addplayerstat("kill_awareness", 1);
        }
        if (killedstunnedvictim) {
            if (player util::has_tactical_mask_purchased_and_equipped()) {
                player addplayerstat("kill_stunned_tacmask", 1);
                if (killedplayerwithgungho == 1) {
                    player addplayerstat("kill_sprint_stunned_gungho_tac", 1);
                }
            }
        }
        if (player util::has_ninja_perk_purchased_and_equipped()) {
            player addplayerstat("kill_dead_silence", 1);
            if (distancesquared(playerorigin, victimorigin) < 14400) {
                if (player util::has_awareness_perk_purchased_and_equipped()) {
                    player addplayerstat("kill_close_deadsilence_awareness", 1);
                }
                if (player util::has_jetquiet_perk_purchased_and_equipped()) {
                    player addplayerstat("kill_close_blast_deadsilence", 1);
                }
            }
        }
        var_bf8b5f73 = 0;
        if (player isbonuscardactive(5, player.class_num) && player util::is_item_purchased("bonuscard_perk_1_greed")) {
            var_bf8b5f73++;
        }
        if (player isbonuscardactive(6, player.class_num) && player util::is_item_purchased("bonuscard_perk_2_greed")) {
            var_bf8b5f73++;
        }
        if (player isbonuscardactive(7, player.class_num) && player util::is_item_purchased("bonuscard_perk_3_greed")) {
            var_bf8b5f73++;
        }
        if (var_bf8b5f73 >= 2) {
            player addplayerstat("kill_2_greed_2_perks_each", 1);
        }
        if (player bonuscardactivecount(player.class_num) >= 2) {
            player addplayerstat("kill_2_wildcards", 1);
        }
        var_e6f45db0 = 0;
        if (player isbonuscardactive(4, player.class_num) && player util::is_item_purchased("bonuscard_overkill")) {
            var_49c719b1 = 0;
            if (isdefined(player.primaryloadoutweapon)) {
                var_49c719b1 = player.primaryloadoutweapon.attachments.size;
            }
            var_384b1055 = 0;
            if (isdefined(player.secondaryloadoutweapon)) {
                var_384b1055 = player.secondaryloadoutweapon.attachments.size;
            }
            if (var_49c719b1 + var_384b1055 >= 5) {
                var_e6f45db0 = 1;
            }
        }
        if (isdefined(player.var_367ea154) && (isdefined(player.primaryloadoutweapon) && weapon == player.primaryloadoutweapon || weapon == player.var_367ea154)) {
            if (player isbonuscardactive(0, player.class_num) && player util::is_item_purchased("bonuscard_primary_gunfighter")) {
                player addbonuscardstat(0, "kills", 1, player.class_num);
                player addplayerstat("kill_with_loadout_weapon_with_3_attachments", 1);
            }
            if (isdefined(player.var_779cc3c1) && player.var_779cc3c1 == 1) {
                player.var_bf3e36ed = 0;
                player.var_779cc3c1 = 0;
                if (player isbonuscardactive(4, player.class_num) && player util::is_item_purchased("bonuscard_overkill")) {
                    player addbonuscardstat(4, "kills", 1, player.class_num);
                    player addplayerstat("kill_with_both_primary_weapons", 1);
                    if (var_e6f45db0) {
                        player addplayerstat("kill_overkill_gunfighter_5_attachments", 1);
                    }
                }
            } else {
                player.var_bf3e36ed = 1;
            }
        } else if (isdefined(player.var_f8a642e8) && (isdefined(player.secondaryloadoutweapon) && weapon == player.secondaryloadoutweapon || weapon == player.var_f8a642e8)) {
            if (player isbonuscardactive(3, player.class_num) && player util::is_item_purchased("bonuscard_secondary_gunfighter")) {
                player addbonuscardstat(3, "kills", 1, player.class_num);
            }
            if (isdefined(player.var_bf3e36ed) && player.var_bf3e36ed == 1) {
                player.var_bf3e36ed = 0;
                player.var_779cc3c1 = 0;
                if (player isbonuscardactive(4, player.class_num) && player util::is_item_purchased("bonuscard_overkill")) {
                    player addbonuscardstat(4, "kills", 1, player.class_num);
                    player addplayerstat("kill_with_both_primary_weapons", 1);
                    if (var_e6f45db0) {
                        player addplayerstat("kill_overkill_gunfighter_5_attachments", 1);
                    }
                }
            } else {
                player.var_779cc3c1 = 1;
            }
        }
        if (player util::has_hacker_perk_purchased_and_equipped() && player util::has_hard_wired_perk_purchased_and_equipped()) {
            should_award_kill_near_plant_engineer_hardwired = 0;
            if (isdefined(victimactivebouncingbetties)) {
                foreach (bouncingbettyinfo in victimactivebouncingbetties) {
                    if (!isdefined(bouncingbettyinfo) || !isdefined(bouncingbettyinfo.origin)) {
                        continue;
                    }
                    if (distancesquared(bouncingbettyinfo.origin, victimorigin) < 400 * 400) {
                        should_award_kill_near_plant_engineer_hardwired = 1;
                        break;
                    }
                }
            }
            if (isdefined(victimactiveproximitygrenades) && should_award_kill_near_plant_engineer_hardwired == 0) {
                foreach (proximitygrenadeinfo in victimactiveproximitygrenades) {
                    if (!isdefined(proximitygrenadeinfo) || !isdefined(proximitygrenadeinfo.origin)) {
                        continue;
                    }
                    if (distancesquared(proximitygrenadeinfo.origin, victimorigin) < 400 * 400) {
                        should_award_kill_near_plant_engineer_hardwired = 1;
                        break;
                    }
                }
            }
            if (should_award_kill_near_plant_engineer_hardwired) {
                player addplayerstat("kill_near_plant_engineer_hardwired", 1);
            }
        }
    } else if (weapon.name == "supplydrop") {
        if (isdefined(inflictorplayerhasengineerperk)) {
            player addplayerstat("kill_booby_trap_engineer", 1);
        }
    }
    if (weapon.isheroweapon == 1 || attackerheroabilityactive || isdefined(killstreak)) {
        if (player util::has_purchased_perk_equipped("specialty_overcharge") && player util::has_purchased_perk_equipped("specialty_anteup")) {
            player addplayerstat("kill_anteup_overclock_scorestreak_specialist", 1);
        }
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x7dacb297, Offset: 0x5810
// Size: 0x2c
function on_player_spawn() {
    if (canprocesschallenges()) {
        self fix_challenge_stats_on_spawn();
    }
}

// Namespace challenges
// Params 1, eflags: 0x0
// Checksum 0x2d265ee8, Offset: 0x5848
// Size: 0x32
function get_challenge_stat(stat_name) {
    return self getdstat("playerstatslist", stat_name, "challengevalue");
}

// Namespace challenges
// Params 2, eflags: 0x0
// Checksum 0x7381d41d, Offset: 0x5888
// Size: 0x74
function force_challenge_stat(stat_name, stat_value) {
    self setdstat("playerstatslist", stat_name, "statvalue", stat_value);
    self setdstat("playerstatslist", stat_name, "challengevalue", stat_value);
}

// Namespace challenges
// Params 2, eflags: 0x0
// Checksum 0x121f5208, Offset: 0x5908
// Size: 0x4a
function get_challenge_group_stat(group_name, stat_name) {
    return self getdstat("groupstats", group_name, "stats", stat_name, "challengevalue");
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x19b34ab9, Offset: 0x5960
// Size: 0xf0
function fix_challenge_stats_on_spawn() {
    player = self;
    if (!isdefined(player)) {
        return;
    }
    if (player.var_77333b5 === 1) {
        return;
    }
    player fix_tu6_weapon_for_diamond("special_crossbow_for_diamond");
    player fix_tu6_weapon_for_diamond("melee_crowbar_for_diamond");
    player fix_tu6_weapon_for_diamond("melee_sword_for_diamond");
    player fix_tu6_ar_garand();
    player fix_tu6_pistol_shotgun();
    player tu7_fix_100_percenter();
    player.var_77333b5 = 1;
}

// Namespace challenges
// Params 1, eflags: 0x0
// Checksum 0xf48beba3, Offset: 0x5a58
// Size: 0xc4
function fix_tu6_weapon_for_diamond(stat_name) {
    player = self;
    wepaon_for_diamond = player get_challenge_stat(stat_name);
    if (wepaon_for_diamond == 1) {
        secondary_mastery = player get_challenge_stat("secondary_mastery");
        if (secondary_mastery == 3) {
            player force_challenge_stat(stat_name, 2);
            return;
        }
        player force_challenge_stat(stat_name, 0);
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x3c661325, Offset: 0x5b28
// Size: 0xcc
function fix_tu6_ar_garand() {
    player = self;
    group_weapon_assault = player get_challenge_group_stat("weapon_assault", "challenges");
    weapons_mastery_assault = player get_challenge_stat("weapons_mastery_assault");
    if (group_weapon_assault >= 49 && weapons_mastery_assault < 1) {
        player force_challenge_stat("weapons_mastery_assault", 1);
        player addplayerstat("ar_garand_for_diamond", 1);
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x9f93f500, Offset: 0x5c00
// Size: 0xcc
function fix_tu6_pistol_shotgun() {
    player = self;
    group_weapon_pistol = player get_challenge_group_stat("weapon_pistol", "challenges");
    secondary_mastery_pistol = player get_challenge_stat("secondary_mastery_pistol");
    if (group_weapon_pistol >= 21 && secondary_mastery_pistol < 1) {
        player force_challenge_stat("secondary_mastery_pistol", 1);
        player addplayerstat("pistol_shotgun_for_diamond", 1);
    }
}

// Namespace challenges
// Params 2, eflags: 0x0
// Checksum 0xb118ab6b, Offset: 0x5cd8
// Size: 0x42
function completed_specific_challenge(target_value, challenge_name) {
    challenge_count = self get_challenge_stat(challenge_name);
    return challenge_count >= target_value;
}

// Namespace challenges
// Params 2, eflags: 0x0
// Checksum 0x6f3a227b, Offset: 0x5d28
// Size: 0x40
function tally_completed_challenge(target_value, challenge_name) {
    return self completed_specific_challenge(target_value, challenge_name) ? 1 : 0;
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0xa7da23a8, Offset: 0x5d70
// Size: 0x1c
function tu7_fix_100_percenter() {
    self tu7_fix_mastery_perk_2();
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x6fe9208f, Offset: 0x5d98
// Size: 0x27c
function tu7_fix_mastery_perk_2() {
    player = self;
    mastery_perk_2 = player get_challenge_stat("mastery_perk_2");
    if (mastery_perk_2 >= 12) {
        return;
    }
    if (player completed_specific_challenge(-56, "earn_scorestreak_anteup") == 0) {
        return;
    }
    perk_2_tally = 1;
    perk_2_tally += player tally_completed_challenge(100, "destroy_ai_scorestreak_coldblooded");
    perk_2_tally += player tally_completed_challenge(100, "kills_counteruav_emp_hardline");
    perk_2_tally += player tally_completed_challenge(-56, "kill_after_resupply");
    perk_2_tally += player tally_completed_challenge(100, "kills_after_sprint_fasthands");
    perk_2_tally += player tally_completed_challenge(-56, "kill_detect_tracker");
    perk_2_tally += player tally_completed_challenge(10, "earn_5_scorestreaks_anteup");
    perk_2_tally += player tally_completed_challenge(25, "kill_scavenger_tracker_resupply");
    perk_2_tally += player tally_completed_challenge(25, "kill_hardwired_coldblooded");
    perk_2_tally += player tally_completed_challenge(25, "kill_anteup_overclock_scorestreak_specialist");
    perk_2_tally += player tally_completed_challenge(50, "kill_fasthands_gungho_sprint");
    perk_2_tally += player tally_completed_challenge(50, "kill_tracker_sixthsense");
    if (mastery_perk_2 < perk_2_tally) {
        player addplayerstat("mastery_perk_2", 1);
    }
}

// Namespace challenges
// Params 1, eflags: 0x0
// Checksum 0x18f0a014, Offset: 0x6020
// Size: 0xba
function getbaseweapon(weapon) {
    var_fc8a08ab = [[ level.var_2453cf4a ]](weapon);
    var_b811740b = function_a8809770(var_fc8a08ab.name);
    var_b811740b = function_a6d0d9ee(var_b811740b);
    return getweapon(getreffromitemindex(getbaseweaponitemindex(getweapon(var_b811740b))));
}

// Namespace challenges
// Params 1, eflags: 0x0
// Checksum 0xbed5f390, Offset: 0x60e8
// Size: 0x58
function function_a6d0d9ee(str) {
    if (strendswith(str, "crossbowlh")) {
        return getsubstr(str, 0, str.size - 2);
    }
    return str;
}

// Namespace challenges
// Params 1, eflags: 0x0
// Checksum 0xe54bb5dc, Offset: 0x6148
// Size: 0x78
function function_a8809770(str) {
    if (strendswith(str, "_lh") || strendswith(str, "_dw")) {
        return getsubstr(str, 0, str.size - 3);
    }
    return str;
}

// Namespace challenges
// Params 2, eflags: 0x0
// Checksum 0x71c83174, Offset: 0x61c8
// Size: 0xa2
function checkkillstreak5(baseweapon, player) {
    if (isdefined(player.weaponkillsthisspawn[baseweapon])) {
        player.weaponkillsthisspawn[baseweapon]++;
        if (player.weaponkillsthisspawn[baseweapon] % 5 == 0) {
            player addweaponstat(baseweapon, "killstreak_5", 1);
        }
        return;
    }
    player.weaponkillsthisspawn[baseweapon] = 1;
}

// Namespace challenges
// Params 6, eflags: 0x0
// Checksum 0x6fcd8da6, Offset: 0x6278
// Size: 0x84
function checkdualwield(baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end) {
    if (attackerwassprinting || attacker_sprint_end + 1000 > time) {
        if (attacker util::has_gung_ho_perk_purchased_and_equipped()) {
            player addplayerstat("kills_sprinting_dual_wield_and_gung_ho", 1);
        }
    }
}

// Namespace challenges
// Params 1, eflags: 0x0
// Checksum 0x25a3929d, Offset: 0x6308
// Size: 0x264
function challengegameendmp(data) {
    player = data.player;
    winner = data.winner;
    if (!isdefined(player)) {
        return;
    }
    if (endedearly(winner)) {
        return;
    }
    if (level.teambased) {
        winnerscore = game["teamScores"][winner];
        loserscore = getlosersteamscores(winner);
    }
    var_d2d122ff = 1;
    for (index = 0; index < level.placement["all"].size; index++) {
        if (level.placement["all"][index].deaths < player.deaths) {
            var_d2d122ff = 0;
        }
        if (level.placement["all"][index].kills > player.kills) {
            var_d2d122ff = 0;
        }
    }
    if (var_d2d122ff && player.kills > 0 && level.placement["all"].size > 3) {
        if (level.teambased) {
            playeriswinner = player.team === winner;
        } else {
            playeriswinner = level.placement["all"][0] === winner || level.placement["all"][1] === winner || level.placement["all"][2] === winner;
        }
        if (playeriswinner) {
            player addplayerstat("most_kills_least_deaths", 1);
        }
    }
}

// Namespace challenges
// Params 2, eflags: 0x0
// Checksum 0x99901f21, Offset: 0x6578
// Size: 0x300
function killedbaseoffender(objective, weapon) {
    self endon(#"disconnect");
    self addplayerstatwithgametype("defends", 1);
    self.challenge_offenderkillcount++;
    if (!isdefined(self.challenge_objectiveoffensive) || self.challenge_objectiveoffensive != objective) {
        self.challenge_objectiveoffensivekillcount = 0;
    }
    self.challenge_objectiveoffensivekillcount++;
    self.challenge_objectiveoffensive = objective;
    killstreak = killstreaks::get_from_weapon(weapon);
    if (isdefined(killstreak)) {
        switch (killstreak) {
        case "drone_strike":
        case "inventory_drone_strike":
        case "inventory_planemortar":
        case "inventory_remote_missile":
        case "planemortar":
        case "remote_missile":
            self.challenge_offenderprojectilemultikillcount++;
            break;
        case "helicopter_comlink":
        case "inventory_helicopter_comlink":
            self.challenge_offendercomlinkkillcount++;
            break;
        case "combat_robot":
        case "inventory_combat_robot":
            self addplayerstat("kill_attacker_with_robot_or_tank", 1);
            break;
        case "autoturret":
        case "inventory_autoturret":
            self.challenge_offendersentryturretkillcount++;
            self addplayerstat("kill_attacker_with_robot_or_tank", 1);
            break;
        }
    }
    if (self.challenge_offendercomlinkkillcount == 2) {
        self addplayerstat("kill_2_attackers_with_comlink", 1);
    }
    if (self.challenge_objectiveoffensivekillcount > 4) {
        self addplayerstatwithgametype("multikill_5_attackers", 1);
        self.challenge_objectiveoffensivekillcount = 0;
    }
    if (self.challenge_offendersentryturretkillcount > 2) {
        self addplayerstat("multikill_3_attackers_ai_tank", 1);
        self.challenge_offendersentryturretkillcount = 0;
    }
    self util::player_contract_event("offender_kill");
    self waittilltimeoutordeath(4);
    if (self.challenge_offenderkillcount > 1) {
        self addplayerstat("double_kill_attackers", 1);
    }
    self.challenge_offenderkillcount = 0;
    if (self.challenge_offenderprojectilemultikillcount >= 2) {
        self addplayerstat("multikill_2_objective_scorestreak_projectile", 1);
    }
    self.challenge_offenderprojectilemultikillcount = 0;
}

// Namespace challenges
// Params 1, eflags: 0x0
// Checksum 0x758c450e, Offset: 0x6880
// Size: 0xf8
function killedbasedefender(objective) {
    self endon(#"disconnect");
    self addplayerstatwithgametype("offends", 1);
    if (!isdefined(self.challenge_objectivedefensive) || self.challenge_objectivedefensive != objective) {
        self.challenge_objectivedefensivekillcount = 0;
    }
    self.challenge_objectivedefensivekillcount++;
    self.challenge_objectivedefensive = objective;
    self.challenge_defenderkillcount++;
    self util::player_contract_event("defender_kill");
    self waittilltimeoutordeath(4);
    if (self.challenge_defenderkillcount > 1) {
        self addplayerstat("double_kill_defenders", 1);
    }
    self.challenge_defenderkillcount = 0;
}

// Namespace challenges
// Params 1, eflags: 0x0
// Checksum 0xee2ca000, Offset: 0x6980
// Size: 0x1c
function waittilltimeoutordeath(timeout) {
    self endon(#"death");
    wait timeout;
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x3bb76455, Offset: 0x69a8
// Size: 0x3c
function killstreak_30_noscorestreaks() {
    if (level.gametype == "dm") {
        self addplayerstat("killstreak_30_no_scorestreaks", 1);
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0xceee2665, Offset: 0x69f0
// Size: 0x8e
function heroabilityactivateneardeath() {
    if (isdefined(self.heroability) && self.pers["canSetSpecialistStat"]) {
        switch (self.heroability.name) {
        case "gadget_armor":
        case "gadget_camo":
        case "gadget_clone":
        case "gadget_flashback":
        case "gadget_heat_wave":
        case "gadget_speed_burst":
        case "gadget_vision_pulse":
            self thread checkforherosurvival();
            break;
        }
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x4832b424, Offset: 0x6a88
// Size: 0x64
function checkforherosurvival() {
    self endon(#"death");
    self endon(#"disconnect");
    self util::waittill_any_timeout(8, "challenge_survived_from_death", "disconnect");
    self addplayerstat("death_dodger", 1);
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x5db3264, Offset: 0x6af8
// Size: 0xde
function function_3b36608e() {
    var_841da7da = self emp::enemyempowner();
    if (isdefined(var_841da7da) && isplayer(var_841da7da)) {
        var_841da7da addplayerstat("end_enemy_specialist_ability_with_emp", 1);
        return;
    }
    if (isdefined(self.empstarttime) && self.empstarttime > gettime() - 100) {
        if (isdefined(self.empedby) && isplayer(self.empedby)) {
            self.empedby addplayerstat("end_enemy_specialist_ability_with_emp", 1);
            return;
        }
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0xc5f696bf, Offset: 0x6be0
// Size: 0x10
function calledincomlinkchopper() {
    self.challenge_offendercomlinkkillcount = 0;
}

// Namespace challenges
// Params 2, eflags: 0x0
// Checksum 0xe0c1a882, Offset: 0x6bf8
// Size: 0x66
function combat_robot_damage(eattacker, combatrobotowner) {
    if (!isdefined(eattacker.challenge_combatrobotattackclientid[combatrobotowner.clientid])) {
        eattacker.challenge_combatrobotattackclientid[combatrobotowner.clientid] = spawnstruct();
    }
}

// Namespace challenges
// Params 1, eflags: 0x0
// Checksum 0xa4e41562, Offset: 0x6c68
// Size: 0x1c4
function trackkillstreaksupportkills(victim) {
    if (level.activeplayeremps[self.entnum] > 0) {
        self addweaponstat(getweapon("emp"), "kills_while_active", 1);
    }
    if (!isdefined(level.forceradar) || level.activeplayeruavs[self.entnum] > 0 && level.forceradar == 0) {
        self addweaponstat(getweapon("uav"), "kills_while_active", 1);
    }
    if (level.activeplayersatellites[self.entnum] > 0) {
        self addweaponstat(getweapon("satellite"), "kills_while_active", 1);
    }
    if (level.activeplayercounteruavs[self.entnum] > 0) {
        self addweaponstat(getweapon("counteruav"), "kills_while_active", 1);
    }
    if (isdefined(victim.lastmicrowavedby) && victim.lastmicrowavedby == self) {
        self addweaponstat(getweapon("microwave_turret"), "kills_while_active", 1);
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0xf92e150, Offset: 0x6e38
// Size: 0xb0
function monitorreloads() {
    self endon(#"disconnect");
    self endon(#"killmonitorreloads");
    while (true) {
        self waittill(#"reload");
        currentweapon = self getcurrentweapon();
        if (currentweapon == level.weaponnone) {
            continue;
        }
        time = gettime();
        self.lastreloadtime = time;
        if (weaponhasattachment(currentweapon, "fastreload")) {
            self.lastfastreloadtime = time;
        }
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x7d4dcc56, Offset: 0x6ef0
// Size: 0xcc
function monitorgrenadefire() {
    self notify(#"grenadetrackingstart");
    self endon(#"grenadetrackingstart");
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"grenade_fire", grenade, weapon);
        if (!isdefined(grenade)) {
            continue;
        }
        if (weapon.rootweapon.name == "hatchet") {
            self.challenge_hatchettosscount++;
            grenade.challenge_hatchettosscount = self.challenge_hatchettosscount;
        }
        if (self issprinting()) {
            grenade.ownerwassprinting = 1;
        }
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0xa3bd7dd6, Offset: 0x6fc8
// Size: 0x54
function watchweaponchangecomplete() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"joined_team");
    self endon(#"joined_spectators");
    while (true) {
        self.var_39c0d0ac = 0;
        self waittill(#"weapon_change_complete");
    }
}

// Namespace challenges
// Params 1, eflags: 0x0
// Checksum 0x22c41a53, Offset: 0x7028
// Size: 0xa4
function longdistancekillmp(weapon) {
    self addweaponstat(weapon, "longshot_kill", 1);
    if (self weaponhasattachmentandunlocked(weapon, "extbarrel", "suppressed")) {
        if (self getweaponoptic(weapon) != "") {
            self addplayerstat("long_shot_longbarrel_suppressor_optic", 1);
        }
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x66c97c71, Offset: 0x70d8
// Size: 0x64
function capturedobjectivefunction() {
    if (self isbonuscardactive(9, self.class_num) && self util::is_item_purchased("bonuscard_two_tacticals")) {
        self addplayerstat("capture_objective_tactician", 1);
    }
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x57eee850, Offset: 0x7148
// Size: 0x250
function function_de32795d() {
    player = self;
    player endon(#"death");
    player endon(#"disconnect");
    player endon(#"joined_team");
    player endon(#"joined_spectators");
    self.var_37509fac = 0;
    while (true) {
        if (!player iswallrunning()) {
            self.var_37509fac = 0;
            player waittill(#"wallrun_begin");
        }
        ret = player util::waittill_any_return("jump_begin", "wallrun_end", "disconnect", "joined_team", "joined_spectators");
        if (ret == "wallrun_end") {
            continue;
        }
        wall_normal = player getwallrunwallnormal();
        player waittill(#"jump_end");
        if (!player iswallrunning()) {
            continue;
        }
        var_731104ea = wall_normal;
        wall_normal = player getwallrunwallnormal();
        var_5fcaadc = vectordot(wall_normal, var_731104ea) < -0.5;
        if (!var_5fcaadc) {
            continue;
        }
        player.var_37509fac = 1;
        while (player iswallrunning()) {
            ret = player util::waittill_any_return("jump_end", "wallrun_end", "disconnect", "joined_team", "joined_spectators");
            if (ret == "wallrun_end") {
                break;
            }
        }
        wait 0.05;
        while (!player isonground()) {
            wait 0.05;
        }
    }
}

// Namespace challenges
// Params 1, eflags: 0x0
// Checksum 0x3860b749, Offset: 0x73a0
// Size: 0x3c
function processspecialistchallenge(statname) {
    if (self.pers["canSetSpecialistStat"]) {
        self addspecialiststat(statname, 1);
    }
}

// Namespace challenges
// Params 2, eflags: 0x0
// Checksum 0xed3da4e0, Offset: 0x73e8
// Size: 0x84
function flakjacketprotectedmp(weapon, attacker) {
    if (weapon.name == "claymore") {
        self.flakjacketclaymore[attacker.clientid] = 1;
    }
    self addplayerstat("survive_with_flak", 1);
    self.challenge_lastsurvivewithflakfrom = attacker;
    self.challenge_lastsurvivewithflaktime = gettime();
}

