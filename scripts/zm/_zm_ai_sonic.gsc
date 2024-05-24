#using scripts/zm/_zm_weap_thundergun;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;

#namespace namespace_14744e42;

// Namespace namespace_14744e42
// Params 0, eflags: 0x2
// Checksum 0x78099771, Offset: 0x6a8
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_ai_sonic", &__init__, &__main__, undefined);
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x3cfb12fc, Offset: 0x6f0
// Size: 0x44
function __init__() {
    init_clientfields();
    function_e6d07763();
    function_c182ca75();
    registerbehaviorscriptfunctions();
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x9d17e027, Offset: 0x740
// Size: 0x234
function __main__() {
    level.var_7032897 = 1;
    level.var_fd5d06c2 = 1;
    level.var_d8b6e448 = 3;
    level.var_659abd48 = 4;
    level.var_c56da471 = level.var_659abd48 + randomintrange(0, level.var_d8b6e448 + 1);
    level.var_a9479acb = 10;
    level.var_d681dc29 = 300;
    level.var_d6bef252 = -16;
    level.var_81ce7e5f = 3;
    level.var_d7205621 = 9;
    level.var_61f63083 = 0;
    level.var_6f411974 = 2.5;
    level.var_76c4f430 = getentarray("sonic_zombie_spawner", "script_noteworthy");
    zombie_utility::set_zombie_var("thundergun_knockdown_damage", 15);
    level.thundergun_gib_refs = [];
    level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "guts";
    level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "right_arm";
    level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "left_arm";
    array::thread_all(level.var_76c4f430, &spawner::add_spawn_function, &function_d1ee93fc);
    array::thread_all(level.var_76c4f430, &spawner::add_spawn_function, &zombie_utility::round_spawn_failsafe);
    zm_spawner::register_zombie_damage_callback(&function_cb0c1b96);
    level thread function_1249f13c();
    /#
        println("sonicAttackTerminate" + level.var_c56da471);
    #/
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x2f8a1de7, Offset: 0x980
// Size: 0xa4
function registerbehaviorscriptfunctions() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("sonicAttackInitialize", &function_ff2f0081);
    behaviortreenetworkutility::registerbehaviortreescriptapi("sonicAttackTerminate", &function_fc31007c);
    behaviortreenetworkutility::registerbehaviortreescriptapi("sonicCanAttack", &function_1de55cef);
    animationstatenetwork::registernotetrackhandlerfunction("sonic_fire", &function_cd107cf);
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0xacabaa2f, Offset: 0xa30
// Size: 0x34
function init_clientfields() {
    clientfield::register("actor", "issonic", 21000, 1, "int");
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0xdb257ce4, Offset: 0xa70
// Size: 0x56
function function_e6d07763() {
    level._effect["sonic_explosion"] = "dlc5/temple/fx_ztem_sonic_zombie";
    level._effect["sonic_spawn"] = "dlc5/temple/fx_ztem_sonic_zombie_spawn";
    level._effect["sonic_attack"] = "dlc5/temple/fx_ztem_sonic_zombie_attack";
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x2452bb0d, Offset: 0xad0
// Size: 0xa
function function_8b9e6756() {
    return level.var_76c4f430;
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0xb4a667c9, Offset: 0xae8
// Size: 0x14
function function_1ebbce9b() {
    return level.zm_loc_types["napalm_location"];
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0xa336a26, Offset: 0xb08
// Size: 0x108
function function_1249f13c() {
    level waittill(#"start_of_round");
    while (true) {
        if (function_89ce0aca()) {
            var_1c80cf96 = function_8b9e6756();
            location_list = function_1ebbce9b();
            spawner = array::random(var_1c80cf96);
            location = array::random(location_list);
            ai = zombie_utility::spawn_zombie(spawner, spawner.targetname, location);
            if (isdefined(ai)) {
                ai.spawn_point_override = location;
            }
        }
        wait(3);
    }
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x417ecae8, Offset: 0xc18
// Size: 0xfc
function function_56fe13df() {
    self endon(#"death");
    spot = self.spawn_point_override;
    self.spawn_point = spot;
    if (isdefined(spot.target)) {
        self.target = spot.target;
    }
    if (isdefined(spot.zone_name)) {
        self.zone_name = spot.zone_name;
    }
    if (isdefined(spot.script_parameters)) {
        self.script_parameters = spot.script_parameters;
    }
    self thread zm_spawner::do_zombie_rise(spot);
    playsoundatposition("evt_sonic_spawn", self.origin);
    thread function_332b9adf();
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0xbd9e0475, Offset: 0xd20
// Size: 0x6c
function function_332b9adf() {
    wait(3);
    players = getplayers();
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("general", "sonic_spawn");
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x18cd50ea, Offset: 0xd98
// Size: 0x160
function function_c182ca75() {
    level.var_508bafce["sonic_zombie"] = [];
    level.var_508bafce["sonic_zombie"]["ambient"] = "sonic_ambient";
    level.var_508bafce["sonic_zombie"]["sprint"] = "sonic_ambient";
    level.var_508bafce["sonic_zombie"]["attack"] = "sonic_attack";
    level.var_508bafce["sonic_zombie"]["teardown"] = "sonic_attack";
    level.var_508bafce["sonic_zombie"]["taunt"] = "sonic_ambient";
    level.var_508bafce["sonic_zombie"]["behind"] = "sonic_ambient";
    level.var_508bafce["sonic_zombie"]["death"] = "sonic_explode";
    level.var_508bafce["sonic_zombie"]["crawler"] = "sonic_ambient";
    level.var_508bafce["sonic_zombie"]["scream"] = "sonic_scream";
}

// Namespace namespace_14744e42
// Params 1, eflags: 0x0
// Checksum 0xec98bf7a, Offset: 0xf00
// Size: 0x70
function function_4f171186(zone) {
    for (i = 0; i < zone.volumes.size; i++) {
        if (self istouching(zone.volumes[i])) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0xc0909cf6, Offset: 0xf78
// Size: 0xd4
function function_89ce0aca() {
    if (!isdefined(level.var_7032897) || level.var_7032897 == 0 || level.var_76c4f430.size == 0) {
        return false;
    }
    if (isdefined(level.var_1ddcecba) && level.var_1ddcecba > 0) {
        return false;
    }
    /#
        if (getdvarint("sonicAttackTerminate") != 0) {
            return true;
        }
    #/
    if (level.var_c56da471 > level.round_number) {
        return false;
    }
    if (level.var_57ecc1a3 >= level.round_number) {
        return false;
    }
    if (level.zombie_total == 0) {
        return false;
    }
    return level.zombie_total < level.var_2d260971;
}

// Namespace namespace_14744e42
// Params 1, eflags: 0x1 linked
// Checksum 0xf6f06fe5, Offset: 0x1058
// Size: 0x25c
function function_d1ee93fc(var_86a233b2) {
    self.custom_location = &function_56fe13df;
    zm_spawner::zombie_spawn_init(var_86a233b2);
    level.var_57ecc1a3 = level.round_number;
    /#
        println("sonicAttackTerminate");
        setdvar("sonicAttackTerminate", 0);
    #/
    self.animname = "sonic_zombie";
    self clientfield::set("issonic", 1);
    self.maxhealth = int(self.maxhealth * level.var_6f411974);
    self.health = self.maxhealth;
    self.ignore_enemy_count = 1;
    self.var_81ce7e5f = 6;
    self.var_d7205621 = 10;
    self.var_15c53a6a = 480;
    self.var_bd367580 = 360;
    self.var_6747144 = -16;
    self.var_39f60481 = 480;
    self function_afc27e4();
    self.deathfunction = &function_a00f7ac3;
    self.var_399caee8 = &function_6e933a4;
    self.var_c1d20f2f = &function_a2cec75;
    self.var_1b022f6c = &function_77d7387;
    self thread function_e9a4bd42();
    self thread function_febaad98();
    self thread function_64759b0d();
    self thread function_fba7f670();
    self.zombie_move_speed = "walk";
    self.zombie_arms_position = "up";
    self.variant_type = randomint(3);
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x290400b6, Offset: 0x12c0
// Size: 0x10
function function_febaad98() {
    self.var_ce31c8e8 = 1;
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x77d859dc, Offset: 0x12d8
// Size: 0x2c
function function_64759b0d() {
    self waittill(#"death");
    self clientfield::set("issonic", 0);
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x0
// Checksum 0xb2c73337, Offset: 0x1310
// Size: 0x1a
function function_2c1a1ca2() {
    self endon(#"death");
    while (true) {
    }
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x1b1319cd, Offset: 0x1338
// Size: 0x4c
function function_afc27e4() {
    self.var_61f63083 = gettime();
    self.var_61f63083 += randomintrange(self.var_81ce7e5f * 1000, self.var_d7205621 * 1000);
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x9468199b, Offset: 0x1390
// Size: 0x1c
function function_d3b39a9b() {
    if (gettime() > self.var_61f63083) {
        return true;
    }
    return false;
}

// Namespace namespace_14744e42
// Params 1, eflags: 0x5 linked
// Checksum 0xdae38123, Offset: 0x13b8
// Size: 0x190
function private function_1de55cef(entity) {
    if (entity.animname !== "sonic_zombie") {
        return false;
    }
    if (!isdefined(entity.favoriteenemy) || !isplayer(entity.favoriteenemy)) {
        return false;
    }
    var_a4da98a1 = !(isdefined(entity.head_gibbed) && entity.head_gibbed);
    var_20e7a8bd = !(isdefined(entity.var_42a5fd49) && entity.var_42a5fd49);
    var_99794fa1 = level function_d3b39a9b() && entity function_d3b39a9b();
    if (var_99794fa1 && !entity.ignoreall && !(isdefined(entity.is_traversing) && entity.is_traversing) && var_a4da98a1 && var_20e7a8bd) {
        var_7cc6d2d0 = entity function_a021748();
        if (var_7cc6d2d0) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_14744e42
// Params 2, eflags: 0x5 linked
// Checksum 0x4864a892, Offset: 0x1550
// Size: 0x44
function private function_ff2f0081(entity, asmstatename) {
    level function_afc27e4();
    entity function_afc27e4();
}

// Namespace namespace_14744e42
// Params 1, eflags: 0x5 linked
// Checksum 0x2a15cf98, Offset: 0x15a0
// Size: 0x44
function private function_cd107cf(entity) {
    if (entity.animname !== "sonic_zombie") {
        return;
    }
    entity function_fbcda91a();
}

// Namespace namespace_14744e42
// Params 2, eflags: 0x5 linked
// Checksum 0x5dbcc21, Offset: 0x15f0
// Size: 0x2c
function private function_fc31007c(entity, asmstatename) {
    entity function_85cb6870();
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x8e38ee17, Offset: 0x1628
// Size: 0x7c
function function_fbcda91a() {
    self playsound("zmb_vocals_sonic_scream");
    self thread function_65883e86();
    players = getplayers();
    array::thread_all(players, &function_5b90e4d6, self);
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0xb62e5555, Offset: 0x16b0
// Size: 0x6e
function function_85cb6870() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] notify(#"hash_6e9cda15");
    }
    self notify(#"scream_attack_done");
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0xa2f84c6e, Offset: 0x1728
// Size: 0x174
function function_65883e86() {
    if (isdefined(self.var_ce46188c)) {
        self.var_ce46188c delete();
    }
    tag = "tag_eye";
    origin = self gettagorigin(tag);
    self.var_ce46188c = spawn("script_model", origin);
    self.var_ce46188c setmodel("tag_origin");
    self.var_ce46188c.angles = self gettagangles(tag);
    self.var_ce46188c linkto(self, tag);
    playfxontag(level._effect["sonic_attack"], self.var_ce46188c, "tag_origin");
    self util::waittill_any("death", "scream_attack_done", "shrink");
    self.var_ce46188c delete();
}

// Namespace namespace_14744e42
// Params 1, eflags: 0x1 linked
// Checksum 0x5c0281ef, Offset: 0x18a8
// Size: 0xb4
function function_5b90e4d6(var_7be30dd4) {
    self endon(#"death");
    self endon(#"hash_6e9cda15");
    var_7be30dd4 endon(#"death");
    self.var_b35d9855 = 0;
    while (true) {
        if (self function_4b9c09a7(var_7be30dd4)) {
            break;
        }
        wait(0.1);
    }
    self thread function_93ae31f9(var_7be30dd4);
    self thread zm_audio::create_and_play_dialog("general", "sonic_hit");
}

// Namespace namespace_14744e42
// Params 1, eflags: 0x1 linked
// Checksum 0x1ff92c28, Offset: 0x1968
// Size: 0x148
function function_4b9c09a7(var_7be30dd4) {
    if (abs(self.origin[2] - var_7be30dd4.origin[2]) > 70) {
        return false;
    }
    radiussqr = level.var_d681dc29 * level.var_d681dc29;
    if (distance2dsquared(self.origin, var_7be30dd4.origin) > radiussqr) {
        return false;
    }
    dirtoplayer = self.origin - var_7be30dd4.origin;
    dirtoplayer = vectornormalize(dirtoplayer);
    var_1f4b1834 = anglestoforward(var_7be30dd4.angles);
    dot = vectordot(dirtoplayer, var_1f4b1834);
    if (dot < 0.4) {
        return false;
    }
    return true;
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0xece3b7f9, Offset: 0x1ab8
// Size: 0xb0
function function_a021748() {
    if (isdefined(level.intermission) && level.intermission) {
        return false;
    }
    players = level.players;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (zombie_utility::is_player_valid(player) && player function_4b9c09a7(self)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_14744e42
// Params 1, eflags: 0x1 linked
// Checksum 0xa371e3d3, Offset: 0x1b70
// Size: 0xf8
function function_93ae31f9(zombie) {
    self endon(#"disconnect");
    level endon(#"intermission");
    if (!self.var_b35d9855) {
        var_ec7bd060 = isdefined(zombie.var_42a5fd49) && isdefined(zombie) && zombie.var_42a5fd49;
        self.var_b35d9855 = 1;
        if (var_ec7bd060) {
            self function_fa0f2686(1, 2, 0.2, "damage_light", zombie);
        } else {
            self function_fa0f2686(4, 5, 0.2, "damage_heavy", zombie);
        }
        self.var_b35d9855 = 0;
    }
}

// Namespace namespace_14744e42
// Params 5, eflags: 0x1 linked
// Checksum 0x9e49146f, Offset: 0x1c70
// Size: 0x10c
function function_fa0f2686(time, var_ece87b60, earthquakescale, rumble, attacker) {
    self thread function_d8799962();
    earthquake(earthquakescale, 3, attacker.origin, level.var_d681dc29, self);
    visionset_mgr::activate("overlay", "zm_ai_screecher_blur", self);
    self playrumbleonentity(rumble);
    self function_9c3a5b0f(time);
    visionset_mgr::deactivate("overlay", "zm_ai_screecher_blur", self);
    self notify(#"hash_5608dd33");
    self stoprumble(rumble);
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x844824af, Offset: 0x1d88
// Size: 0x4c
function function_d8799962() {
    self endon(#"disconnect");
    self endon(#"hash_5608dd33");
    level waittill(#"intermission");
    visionset_mgr::deactivate("overlay", "zm_ai_screecher_blur", self);
}

// Namespace namespace_14744e42
// Params 1, eflags: 0x1 linked
// Checksum 0xcc1da95e, Offset: 0x1de0
// Size: 0x28
function function_9c3a5b0f(time) {
    self endon(#"disconnect");
    level endon(#"intermission");
    wait(time);
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1e10
// Size: 0x4
function function_7d617302() {
    
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x1e20
// Size: 0x4
function function_e9a4bd42() {
    
}

// Namespace namespace_14744e42
// Params 2, eflags: 0x0
// Checksum 0x96ddda01, Offset: 0x1e30
// Size: 0xf0
function function_ca29873(var_80afd72e, fxname) {
    origin = self gettagorigin(var_80afd72e);
    var_8d78a1c5 = spawn("script_model", origin);
    var_8d78a1c5 setmodel("tag_origin");
    var_8d78a1c5.angles = self gettagangles(var_80afd72e);
    var_8d78a1c5 linkto(self, var_80afd72e);
    playfxontag(level._effect[fxname], var_8d78a1c5, "tag_origin");
    return var_8d78a1c5;
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x0
// Checksum 0xca1ea914, Offset: 0x1f28
// Size: 0x12e
function function_bc9908bc() {
    nearbyplayers = [];
    radiussqr = level.var_d6bef252 * level.var_d6bef252;
    players = level.players;
    for (i = 0; i < players.size; i++) {
        if (!zombie_utility::is_player_valid(players[i])) {
            continue;
        }
        playerorigin = players[i].origin;
        if (abs(playerorigin[2] - self.origin[2]) > 70) {
            continue;
        }
        if (distance2dsquared(playerorigin, self.origin) > radiussqr) {
            continue;
        }
        nearbyplayers[nearbyplayers.size] = players[i];
    }
    return nearbyplayers;
}

// Namespace namespace_14744e42
// Params 8, eflags: 0x1 linked
// Checksum 0x60198ac8, Offset: 0x2060
// Size: 0x142
function function_a00f7ac3(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    self playsound("evt_sonic_explode");
    if (isdefined(level._effect["sonic_explosion"])) {
        playfxontag(level._effect["sonic_explosion"], self, "J_SpineLower");
    }
    if (isdefined(self.attacker) && isplayer(self.attacker)) {
        self.attacker thread zm_audio::create_and_play_dialog("kill", "sonic");
    }
    self thread function_d58c2bba(self.attacker);
    function_6c2220cc(self.attacker);
    return self zm_spawner::zombie_death_animscript();
}

// Namespace namespace_14744e42
// Params 1, eflags: 0x1 linked
// Checksum 0x7b976cbd, Offset: 0x21b0
// Size: 0xd4
function function_32f1648d(attacker) {
    self endon(#"death");
    randomwait = randomfloatrange(0, 1);
    wait(randomwait);
    self.no_powerups = 1;
    self zombie_utility::zombie_eye_glow_stop();
    self playsound("evt_zombies_head_explode");
    self zombie_utility::zombie_head_gib();
    self dodamage(self.health + 666, self.origin, attacker);
}

// Namespace namespace_14744e42
// Params 1, eflags: 0x1 linked
// Checksum 0xad3569af, Offset: 0x2290
// Size: 0xc6
function function_d58c2bba(attacker) {
    zombies = function_8a9a8911();
    for (i = 0; i < zombies.size; i++) {
        if (!isdefined(zombies[i])) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
            continue;
        }
        if (self.animname == "monkey_zombie") {
            continue;
        }
        zombies[i] thread function_32f1648d(attacker);
    }
}

// Namespace namespace_14744e42
// Params 1, eflags: 0x1 linked
// Checksum 0xcdaccf05, Offset: 0x2360
// Size: 0x174
function function_6c2220cc(attacker) {
    physicsexplosioncylinder(self.origin, 600, -16, 1);
    if (!isdefined(level.var_56458ac9)) {
        level.var_56458ac9 = [];
        level.var_5834c8cf = [];
        level.var_1f84acbf = [];
        level.var_87d50474 = [];
    }
    self function_79d2d55b();
    level.var_c9665ea = 0;
    for (i = 0; i < level.var_1f84acbf.size; i++) {
        level.var_1f84acbf[i] thread function_31ad476(attacker, level.var_87d50474[i], i);
    }
    for (i = 0; i < level.var_56458ac9.size; i++) {
        level.var_56458ac9[i] thread function_a14d7674(attacker, level.var_5834c8cf[i]);
    }
    level.var_56458ac9 = [];
    level.var_5834c8cf = [];
    level.var_1f84acbf = [];
    level.var_87d50474 = [];
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x0
// Checksum 0x287c7b38, Offset: 0x24e0
// Size: 0x4c
function function_97bd2abb() {
    level.var_c9665ea++;
    if (!(level.var_c9665ea % 10)) {
        util::wait_network_frame();
        util::wait_network_frame();
        util::wait_network_frame();
    }
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0xe17bf652, Offset: 0x2538
// Size: 0x158
function function_8a9a8911() {
    var_2a7039e7 = [];
    center = self getcentroid();
    zombies = array::get_all_closest(center, getaispeciesarray("axis", "all"), undefined, undefined, self.var_39f60481);
    if (isdefined(zombies)) {
        for (i = 0; i < zombies.size; i++) {
            if (!isdefined(zombies[i]) || !isalive(zombies[i])) {
                continue;
            }
            test_origin = zombies[i] getcentroid();
            if (!bullettracepassed(center, test_origin, 0, undefined)) {
                continue;
            }
            var_2a7039e7[var_2a7039e7.size] = zombies[i];
        }
    }
    return var_2a7039e7;
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x4b05b43e, Offset: 0x2698
// Size: 0x31c
function function_79d2d55b() {
    center = self getcentroid();
    zombies = array::get_all_closest(center, getaispeciesarray("axis", "all"), undefined, undefined, self.var_15c53a6a);
    if (!isdefined(zombies)) {
        return;
    }
    knockdown_range_squared = self.var_15c53a6a * self.var_15c53a6a;
    gib_range_squared = self.var_bd367580 * self.var_bd367580;
    fling_range_squared = self.var_6747144 * self.var_6747144;
    for (i = 0; i < zombies.size; i++) {
        if (!isdefined(zombies[i]) || !isalive(zombies[i])) {
            continue;
        }
        test_origin = zombies[i] getcentroid();
        test_range_squared = distancesquared(center, test_origin);
        if (test_range_squared > knockdown_range_squared) {
            return;
        }
        if (!bullettracepassed(center, test_origin, 0, undefined)) {
            continue;
        }
        if (test_range_squared < fling_range_squared) {
            level.var_1f84acbf[level.var_1f84acbf.size] = zombies[i];
            dist_mult = (fling_range_squared - test_range_squared) / fling_range_squared;
            fling_vec = vectornormalize(test_origin - center);
            fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
            fling_vec = vectorscale(fling_vec, 100 + 100 * dist_mult);
            level.var_87d50474[level.var_87d50474.size] = fling_vec;
            continue;
        }
        if (test_range_squared < gib_range_squared) {
            level.var_56458ac9[level.var_56458ac9.size] = zombies[i];
            level.var_5834c8cf[level.var_5834c8cf.size] = 1;
            continue;
        }
        level.var_56458ac9[level.var_56458ac9.size] = zombies[i];
        level.var_5834c8cf[level.var_5834c8cf.size] = 0;
    }
}

// Namespace namespace_14744e42
// Params 3, eflags: 0x1 linked
// Checksum 0xbfd33633, Offset: 0x29c0
// Size: 0x11c
function function_31ad476(player, fling_vec, index) {
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    self dodamage(self.health + 666, player.origin, player);
    if (self.health <= 0) {
        points = 10;
        if (!index) {
            points = zm_score::function_b2baf1b5();
        } else if (1 == index) {
            points = 30;
        }
        player zm_score::player_add_points("thundergun_fling", points);
        self startragdoll();
        self launchragdoll(fling_vec);
    }
}

// Namespace namespace_14744e42
// Params 2, eflags: 0x1 linked
// Checksum 0x2be2f860, Offset: 0x2ae8
// Size: 0x104
function function_a14d7674(player, gib) {
    self endon(#"death");
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (isdefined(self.thundergun_knockdown_func)) {
        self.var_1474da36 = 1;
        self [[ self.thundergun_knockdown_func ]](player, gib);
        return;
    }
    if (gib) {
        self.a.gib_ref = array::random(level.thundergun_gib_refs);
        self thread zombie_death::do_gib();
    }
    self.thundergun_handle_pain_notetracks = &zm_weap_thundergun::handle_thundergun_pain_notetracks;
    self dodamage(20, player.origin, player);
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x2bf8
// Size: 0x4
function function_6e933a4() {
    
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x2c08
// Size: 0x4
function function_a2cec75() {
    
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x1 linked
// Checksum 0x9fe60b79, Offset: 0x2c18
// Size: 0x130
function function_fba7f670() {
    if (!isdefined(level.var_1ddcecba)) {
        level.var_1ddcecba = 0;
    }
    level.var_1ddcecba++;
    self waittill(#"death");
    level.var_1ddcecba--;
    if (isdefined(self.var_42a5fd49) && self.var_42a5fd49) {
        level.var_c56da471 = level.round_number + 1;
    } else {
        level.var_c56da471 = level.round_number + randomintrange(level.var_fd5d06c2, level.var_d8b6e448 + 1);
    }
    /#
        println("sonicAttackTerminate" + level.var_c56da471);
    #/
    attacker = self.attacker;
    if (isdefined(attacker.var_b35d9855) && isdefined(attacker) && isplayer(attacker) && attacker.var_b35d9855) {
        attacker notify(#"hash_abbbecf2");
    }
}

// Namespace namespace_14744e42
// Params 13, eflags: 0x1 linked
// Checksum 0x75688dfb, Offset: 0x2d50
// Size: 0x14c
function function_cb0c1b96(str_mod, var_5afff096, var_7c5a4ee4, e_player, n_amount, w_weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
    if (isdefined(self.var_1474da36) && self.var_1474da36) {
        return false;
    }
    if (self.classname == "actor_spawner_zm_temple_sonic") {
        if (!isdefined(self.damagecount)) {
            self.damagecount = 0;
        }
        if (self.damagecount % int(getplayers().size * level.var_6f411974) == 0) {
            e_player zm_score::player_add_points("thundergun_fling", 10, var_5afff096, self.isdog);
        }
        self.damagecount++;
        self thread zm_powerups::function_3308d17f(e_player, str_mod, var_5afff096);
        return true;
    }
    return false;
}

// Namespace namespace_14744e42
// Params 1, eflags: 0x1 linked
// Checksum 0xc7b4810a, Offset: 0x2ea8
// Size: 0x1e
function function_77d7387(var_7e84184) {
    return isdefined(self.in_the_ground) && self.in_the_ground;
}

