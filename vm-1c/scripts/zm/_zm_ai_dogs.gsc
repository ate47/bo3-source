#using scripts/codescripts/struct;
#using scripts/shared/aat_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_ai_dogs;

// Namespace zm_ai_dogs
// Params 0, eflags: 0x2
// Checksum 0x81aa3c41, Offset: 0x678
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_ai_dogs", &__init__, undefined, "aat");
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0x779f1efb, Offset: 0x6b8
// Size: 0x54
function __init__() {
    clientfield::register("actor", "dog_fx", 1, 1, "int");
    init_dog_fx();
    init();
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0x2267e41, Offset: 0x718
// Size: 0x2c4
function init() {
    level.var_61c54e76 = 1;
    level.var_459c76d = 0;
    level.dog_round_count = 1;
    level.dog_spawners = [];
    level flag::init("dog_clips");
    if (getdvarstring("zombie_dog_animset") == "") {
        setdvar("zombie_dog_animset", "zombie");
    }
    if (getdvarstring("scr_dog_health_walk_multiplier") == "") {
        setdvar("scr_dog_health_walk_multiplier", "4.0");
    }
    if (getdvarstring("scr_dog_run_distance") == "") {
        setdvar("scr_dog_run_distance", "500");
    }
    level.var_8c0eb6e6 = getdvarstring("ai_meleeRange");
    level.var_75dc7ed5 = getdvarstring("ai_meleeWidth");
    level.var_be453360 = getdvarstring("ai_meleeHeight");
    zombie_utility::set_zombie_var("dog_fire_trail_percent", 50);
    level thread aat::register_immunity("zm_aat_blast_furnace", "zombie_dog", 0, 1, 1);
    level thread aat::register_immunity("zm_aat_dead_wire", "zombie_dog", 0, 1, 1);
    level thread aat::register_immunity("zm_aat_fire_works", "zombie_dog", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_thunder_wall", "zombie_dog", 0, 0, 1);
    level thread aat::register_immunity("zm_aat_turned", "zombie_dog", 1, 1, 1);
    dog_spawner_init();
    level thread dog_clip_monitor();
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0x8f236e8a, Offset: 0x9e8
// Size: 0x72
function init_dog_fx() {
    level._effect["lightning_dog_spawn"] = "zombie/fx_dog_lightning_buildup_zmb";
    level._effect["dog_eye_glow"] = "zombie/fx_dog_eyes_zmb";
    level._effect["dog_gib"] = "zombie/fx_dog_explosion_zmb";
    level._effect["dog_trail_fire"] = "zombie/fx_dog_fire_trail_zmb";
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0x9665787c, Offset: 0xa68
// Size: 0x44
function enable_dog_rounds() {
    level.var_459c76d = 1;
    if (!isdefined(level.dog_round_track_override)) {
        level.dog_round_track_override = &dog_round_tracker;
    }
    level thread [[ level.dog_round_track_override ]]();
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0x91a8f7eb, Offset: 0xab8
// Size: 0x1ac
function dog_spawner_init() {
    level.dog_spawners = getentarray("zombie_dog_spawner", "script_noteworthy");
    later_dogs = getentarray("later_round_dog_spawners", "script_noteworthy");
    level.dog_spawners = arraycombine(level.dog_spawners, later_dogs, 1, 0);
    if (level.dog_spawners.size == 0) {
        return;
    }
    for (i = 0; i < level.dog_spawners.size; i++) {
        if (zm_spawner::is_spawner_targeted_by_blocker(level.dog_spawners[i])) {
            level.dog_spawners[i].is_enabled = 0;
            continue;
        }
        level.dog_spawners[i].is_enabled = 1;
        level.dog_spawners[i].script_forcespawn = 1;
    }
    assert(level.dog_spawners.size > 0);
    level.dog_health = 100;
    array::thread_all(level.dog_spawners, &spawner::add_spawn_function, &dog_init);
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0x49c5d0db, Offset: 0xc70
// Size: 0x4a8
function function_843b73a8() {
    level endon(#"intermission");
    level endon(#"end_of_round");
    level endon(#"restart_round");
    level.dog_targets = getplayers();
    for (i = 0; i < level.dog_targets.size; i++) {
        level.dog_targets[i].hunted_by = 0;
    }
    level endon(#"kill_round");
    /#
        if (getdvarint("<dev string:x28>") == 2 || getdvarint("<dev string:x28>") >= 4) {
            return;
        }
    #/
    if (level.intermission) {
        return;
    }
    level.dog_intermission = 1;
    level thread function_55736391();
    players = getplayers();
    array::thread_all(players, &play_dog_round);
    wait 1;
    level thread zm_audio::sndannouncerplayvox("dogstart");
    wait 6;
    if (level.dog_round_count < 3) {
        max = players.size * 6;
    } else {
        max = players.size * 8;
    }
    /#
        if (getdvarstring("<dev string:x35>") != "<dev string:x40>") {
            max = getdvarint("<dev string:x35>");
        }
    #/
    level.zombie_total = max;
    dog_health_increase();
    count = 0;
    while (true) {
        level flag::wait_till("spawn_zombies");
        while (zombie_utility::get_current_zombie_count() >= level.zombie_ai_limit || level.zombie_total <= 0) {
            wait 0.1;
        }
        for (num_player_valid = zm_utility::get_number_of_valid_players(); zombie_utility::get_current_zombie_count() >= num_player_valid * 2; num_player_valid = zm_utility::get_number_of_valid_players()) {
            wait 2;
        }
        players = getplayers();
        favorite_enemy = get_favorite_enemy();
        if (isdefined(level.dog_spawn_func)) {
            spawn_loc = [[ level.dog_spawn_func ]](level.dog_spawners, favorite_enemy);
            ai = zombie_utility::spawn_zombie(level.dog_spawners[0]);
            if (isdefined(ai)) {
                ai.favoriteenemy = favorite_enemy;
                spawn_loc thread dog_spawn_fx(ai, spawn_loc);
                level.zombie_total--;
                count++;
                level flag::set("dog_clips");
            }
        } else {
            spawn_point = dog_spawn_factory_logic(favorite_enemy);
            ai = zombie_utility::spawn_zombie(level.dog_spawners[0]);
            if (isdefined(ai)) {
                ai.favoriteenemy = favorite_enemy;
                spawn_point thread dog_spawn_fx(ai, spawn_point);
                level.zombie_total--;
                count++;
                level flag::set("dog_clips");
            }
        }
        waiting_for_next_dog_spawn(count, max);
    }
}

// Namespace zm_ai_dogs
// Params 2, eflags: 0x0
// Checksum 0xf607a242, Offset: 0x1120
// Size: 0xce
function waiting_for_next_dog_spawn(count, max) {
    default_wait = 1.5;
    if (level.dog_round_count == 1) {
        default_wait = 3;
    } else if (level.dog_round_count == 2) {
        default_wait = 2.5;
    } else if (level.dog_round_count == 3) {
        default_wait = 2;
    } else {
        default_wait = 1.5;
    }
    default_wait -= count / max;
    default_wait = max(default_wait, 0.05);
    wait default_wait;
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0xe6932b08, Offset: 0x11f8
// Size: 0xc4
function function_55736391() {
    level waittill(#"last_ai_down", var_30af5449);
    level thread zm_audio::sndmusicsystem_playstate("dog_end");
    var_f1aa36cd = level.var_ad1233d3;
    if (isdefined(var_30af5449)) {
        var_f1aa36cd = var_30af5449.origin;
    }
    if (isdefined(var_f1aa36cd)) {
        level thread zm_powerups::specific_powerup_drop("full_ammo", var_f1aa36cd);
    }
    wait 2;
    util::clientnotify("dog_stop");
    wait 6;
    level.dog_intermission = 0;
}

// Namespace zm_ai_dogs
// Params 2, eflags: 0x0
// Checksum 0xb5db6735, Offset: 0x12c8
// Size: 0x334
function dog_spawn_fx(ai, ent) {
    ai endon(#"death");
    ai setfreecameralockonallowed(0);
    playfx(level._effect["lightning_dog_spawn"], ent.origin);
    playsoundatposition("zmb_hellhound_prespawn", ent.origin);
    wait 1.5;
    playsoundatposition("zmb_hellhound_bolt", ent.origin);
    earthquake(0.5, 0.75, ent.origin, 1000);
    playsoundatposition("zmb_hellhound_spawn", ent.origin);
    if (isdefined(ai.favoriteenemy)) {
        angle = vectortoangles(ai.favoriteenemy.origin - ent.origin);
        angles = (ai.angles[0], angle[1], ai.angles[2]);
    } else {
        angles = ent.angles;
    }
    ai forceteleport(ent.origin, angles);
    assert(isdefined(ai), "<dev string:x41>");
    assert(isalive(ai), "<dev string:x54>");
    assert(ai.isdog, "<dev string:x61>");
    assert(zm_utility::is_magic_bullet_shield_enabled(ai), "<dev string:x72>");
    ai zombie_setup_attack_properties_dog();
    ai util::stop_magic_bullet_shield();
    wait 0.1;
    ai show();
    ai setfreecameralockonallowed(1);
    ai.ignoreme = 0;
    ai notify(#"visible");
}

// Namespace zm_ai_dogs
// Params 1, eflags: 0x0
// Checksum 0x2ea8a0d0, Offset: 0x1608
// Size: 0x122
function dog_spawn_factory_logic(favorite_enemy) {
    dog_locs = array::randomize(level.zm_loc_types["dog_location"]);
    for (i = 0; i < dog_locs.size; i++) {
        if (isdefined(level.old_dog_spawn) && level.old_dog_spawn == dog_locs[i]) {
            continue;
        }
        if (!isdefined(favorite_enemy)) {
            continue;
        }
        dist_squared = distancesquared(dog_locs[i].origin, favorite_enemy.origin);
        if (dist_squared > 160000 && dist_squared < 1000000) {
            level.old_dog_spawn = dog_locs[i];
            return dog_locs[i];
        }
    }
    return dog_locs[0];
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0x6bbb253c, Offset: 0x1738
// Size: 0x15e
function get_favorite_enemy() {
    dog_targets = getplayers();
    least_hunted = dog_targets[0];
    for (i = 0; i < dog_targets.size; i++) {
        if (!isdefined(dog_targets[i].hunted_by)) {
            dog_targets[i].hunted_by = 0;
        }
        if (!zm_utility::is_player_valid(dog_targets[i])) {
            continue;
        }
        if (!zm_utility::is_player_valid(least_hunted)) {
            least_hunted = dog_targets[i];
        }
        if (dog_targets[i].hunted_by < least_hunted.hunted_by) {
            least_hunted = dog_targets[i];
        }
    }
    if (!zm_utility::is_player_valid(least_hunted)) {
        return undefined;
    }
    least_hunted.hunted_by += 1;
    return least_hunted;
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0x9957b674, Offset: 0x18a0
// Size: 0xb8
function dog_health_increase() {
    players = getplayers();
    if (level.dog_round_count == 1) {
        level.dog_health = 400;
    } else if (level.dog_round_count == 2) {
        level.dog_health = 900;
    } else if (level.dog_round_count == 3) {
        level.dog_health = 1300;
    } else if (level.dog_round_count == 4) {
        level.dog_health = 1600;
    }
    if (level.dog_health > 1600) {
        level.dog_health = 1600;
    }
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0xf1af3227, Offset: 0x1960
// Size: 0x68
function function_4ee7d855() {
    if (level flag::get("dog_round")) {
        wait 7;
        while (level.dog_intermission) {
            wait 0.5;
        }
        zm::increment_dog_round_stat("finished");
    }
    level.var_1b7d7bb8 = 0;
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0x6f501481, Offset: 0x19d0
// Size: 0x1f4
function dog_round_tracker() {
    level.dog_round_count = 1;
    level.next_dog_round = level.round_number + randomintrange(4, 7);
    old_spawn_func = level.round_spawn_func;
    old_wait_func = level.round_wait_func;
    while (true) {
        level waittill(#"between_round_over");
        /#
            if (getdvarint("<dev string:x35>") > 0) {
                level.next_dog_round = level.round_number;
            }
        #/
        if (level.round_number == level.next_dog_round) {
            level.var_1b7d7bb8 = 1;
            old_spawn_func = level.round_spawn_func;
            old_wait_func = level.round_wait_func;
            dog_round_start();
            level.round_spawn_func = &function_843b73a8;
            level.round_wait_func = &function_4ee7d855;
            level.next_dog_round = level.round_number + randomintrange(4, 6);
            /#
                getplayers()[0] iprintln("<dev string:x9a>" + level.next_dog_round);
            #/
            continue;
        }
        if (level flag::get("dog_round")) {
            dog_round_stop();
            level.round_spawn_func = old_spawn_func;
            level.round_wait_func = old_wait_func;
            level.dog_round_count += 1;
        }
    }
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0x8c15bb2e, Offset: 0x1bd0
// Size: 0xf4
function dog_round_start() {
    level flag::set("dog_round");
    level flag::set("special_round");
    level flag::set("dog_clips");
    level notify(#"hash_8b27d5e3");
    level thread zm_audio::sndmusicsystem_playstate("dog_start");
    util::clientnotify("dog_start");
    if (isdefined(level.var_75926bba)) {
        setdvar("ai_meleeRange", level.var_75926bba);
        return;
    }
    setdvar("ai_meleeRange", 100);
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0xb099dd97, Offset: 0x1cd0
// Size: 0xec
function dog_round_stop() {
    level flag::clear("dog_round");
    level flag::clear("special_round");
    level flag::clear("dog_clips");
    level notify(#"hash_d7c2375a");
    util::clientnotify("dog_stop");
    setdvar("ai_meleeRange", level.var_8c0eb6e6);
    setdvar("ai_meleeWidth", level.var_75dc7ed5);
    setdvar("ai_meleeHeight", level.var_be453360);
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0xeac47a28, Offset: 0x1dc8
// Size: 0xb4
function play_dog_round() {
    self playlocalsound("zmb_dog_round_start");
    variation_count = 5;
    wait 4.5;
    players = getplayers();
    num = randomintrange(0, players.size);
    players[num] zm_audio::create_and_play_dialog("general", "dog_spawn");
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0x2acd8e95, Offset: 0x1e88
// Size: 0x410
function dog_init() {
    self.targetname = "zombie_dog";
    self.script_noteworthy = undefined;
    self.animname = "zombie_dog";
    self.ignoreall = 1;
    self.ignoreme = 1;
    self.allowdeath = 1;
    self.allowpain = 0;
    self.force_gib = 1;
    self.is_zombie = 1;
    self.gibbed = 0;
    self.head_gibbed = 0;
    self.default_goalheight = 40;
    self.ignore_inert = 1;
    self.holdfire = 1;
    self.grenadeawareness = 0;
    self.badplaceawareness = 0;
    self.ignoresuppression = 1;
    self.suppressionthreshold = 1;
    self.nododgemove = 1;
    self.dontshootwhilemoving = 1;
    self.pathenemylookahead = 0;
    self.badplaceawareness = 0;
    self.chatinitialized = 0;
    self.team = level.zombie_team;
    self.heroweapon_kill_power = 2;
    self allowpitchangle(1);
    self setpitchorient();
    self setavoidancemask("avoid none");
    self function_1762804b(1);
    health_multiplier = 1;
    if (getdvarstring("scr_dog_health_walk_multiplier") != "") {
        health_multiplier = getdvarfloat("scr_dog_health_walk_multiplier");
    }
    self.maxhealth = int(level.dog_health * health_multiplier);
    self.health = int(level.dog_health * health_multiplier);
    self.freezegun_damage = 0;
    self.zombie_move_speed = "sprint";
    self.a.nodeath = 1;
    self thread dog_run_think();
    self thread dog_stalk_audio();
    self thread zombie_utility::round_spawn_failsafe();
    self ghost();
    self thread util::magic_bullet_shield();
    self thread dog_death();
    level thread zm_spawner::zombie_death_event(self);
    self thread zm_spawner::function_1612a0b8();
    self thread zm_audio::zmbaivox_notifyconvert();
    self.a.disablepain = 1;
    self zm_utility::disable_react();
    self cleargoalvolume();
    self.flame_damage_time = 0;
    self.meleedamage = 40;
    self.thundergun_knockdown_func = &dog_thundergun_knockdown;
    self zm_spawner::zombie_history("zombie_dog_spawn_init -> Spawned = " + self.origin);
    if (isdefined(level.var_9aca36e2)) {
        self [[ level.var_9aca36e2 ]]();
    }
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0x3cfaa7ab, Offset: 0x22a0
// Size: 0x34e
function dog_death() {
    self waittill(#"death");
    if (zombie_utility::get_current_zombie_count() == 0 && level.zombie_total == 0) {
        level.var_ad1233d3 = self.origin;
        level notify(#"last_ai_down", self);
    }
    if (isplayer(self.attacker)) {
        event = "death";
        if (self.damageweapon.isballisticknife) {
            event = "ballistic_knife_death";
        }
        if (!(isdefined(self.deathpoints_already_given) && self.deathpoints_already_given)) {
            self.attacker zm_score::player_add_points(event, self.damagemod, self.damagelocation, 1);
        }
        if (isdefined(level.hero_power_update)) {
            [[ level.hero_power_update ]](self.attacker, self);
        }
        if (randomintrange(0, 100) >= 80) {
            self.attacker zm_audio::create_and_play_dialog("kill", "hellhound");
        }
        self.attacker zm_stats::increment_client_stat("zdogs_killed");
        self.attacker zm_stats::increment_player_stat("zdogs_killed");
    }
    if (isdefined(self.attacker) && isai(self.attacker)) {
        self.attacker notify(#"killed", self);
    }
    self stoploopsound();
    if (!(isdefined(self.a.nodeath) && self.a.nodeath)) {
        trace = groundtrace(self.origin + (0, 0, 10), self.origin - (0, 0, 30), 0, self);
        if (trace["fraction"] < 1) {
            pitch = acos(vectordot(trace["normal"], (0, 0, 1)));
            if (pitch > 10) {
                self.a.nodeath = 1;
            }
        }
    }
    if (isdefined(self.a.nodeath)) {
        level thread dog_explode_fx(self.origin);
        self delete();
        return;
    }
    self notify(#"bhtn_action_notify", "death");
}

// Namespace zm_ai_dogs
// Params 1, eflags: 0x0
// Checksum 0xb8e41cfb, Offset: 0x25f8
// Size: 0x54
function dog_explode_fx(origin) {
    playfx(level._effect["dog_gib"], origin);
    playsoundatposition("zmb_hellhound_explode", origin);
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0x2512cd3c, Offset: 0x2658
// Size: 0x88
function zombie_setup_attack_properties_dog() {
    self zm_spawner::zombie_history("zombie_setup_attack_properties()");
    self thread dog_behind_audio();
    self.ignoreall = 0;
    self.meleeattackdist = 64;
    self.disablearrivals = 1;
    self.disableexits = 1;
    if (isdefined(level.var_3565ea48)) {
        self [[ level.var_3565ea48 ]]();
    }
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0x87ca10c9, Offset: 0x26e8
// Size: 0x24
function stop_dog_sound_on_death() {
    self waittill(#"death");
    self stopsounds();
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0xc913c961, Offset: 0x2718
// Size: 0x1e0
function dog_behind_audio() {
    self thread stop_dog_sound_on_death();
    self endon(#"death");
    self util::waittill_any("dog_running", "dog_combat");
    self notify(#"bhtn_action_notify", "close");
    wait 3;
    while (true) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            dogangle = angleclamp180(vectortoangles(self.origin - players[i].origin)[1] - players[i].angles[1]);
            if (isalive(players[i]) && !isdefined(players[i].revivetrigger)) {
                if (abs(dogangle) > 90 && distance2d(self.origin, players[i].origin) > 100) {
                    self notify(#"bhtn_action_notify", "close");
                    wait 3;
                }
            }
        }
        wait 0.75;
    }
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0x6b0fabf0, Offset: 0x2900
// Size: 0x206
function dog_clip_monitor() {
    clips_on = 0;
    level.dog_clips = getentarray("dog_clips", "targetname");
    while (true) {
        for (i = 0; i < level.dog_clips.size; i++) {
            level.dog_clips[i] connectpaths();
        }
        level flag::wait_till("dog_clips");
        if (isdefined(level.var_c7e50b48) && level.var_c7e50b48 == 1) {
            return;
        }
        for (i = 0; i < level.dog_clips.size; i++) {
            level.dog_clips[i] disconnectpaths();
            util::wait_network_frame();
        }
        dog_is_alive = 1;
        while (dog_is_alive || level flag::get("dog_round")) {
            dog_is_alive = 0;
            dogs = getentarray("zombie_dog", "targetname");
            for (i = 0; i < dogs.size; i++) {
                if (isalive(dogs[i])) {
                    dog_is_alive = 1;
                }
            }
            wait 1;
        }
        level flag::clear("dog_clips");
        wait 1;
    }
}

// Namespace zm_ai_dogs
// Params 3, eflags: 0x0
// Checksum 0xd715d269, Offset: 0x2b10
// Size: 0x2fc
function function_6fafe689(num_to_spawn, spawners, spawn_point) {
    dogs = getaispeciesarray("all", "zombie_dog");
    if (isdefined(dogs) && dogs.size >= 9) {
        return false;
    }
    if (!isdefined(num_to_spawn)) {
        num_to_spawn = 1;
    }
    spawn_point = undefined;
    count = 0;
    while (count < num_to_spawn) {
        players = getplayers();
        favorite_enemy = get_favorite_enemy();
        if (isdefined(spawners)) {
            if (!isdefined(spawn_point)) {
                spawn_point = spawners[randomint(spawners.size)];
            }
            ai = zombie_utility::spawn_zombie(spawn_point);
            if (isdefined(ai)) {
                ai.favoriteenemy = favorite_enemy;
                spawn_point thread dog_spawn_fx(ai);
                count++;
                level flag::set("dog_clips");
            }
        } else if (isdefined(level.dog_spawn_func)) {
            spawn_loc = [[ level.dog_spawn_func ]](level.dog_spawners, favorite_enemy);
            ai = zombie_utility::spawn_zombie(level.dog_spawners[0]);
            if (isdefined(ai)) {
                ai.favoriteenemy = favorite_enemy;
                spawn_loc thread dog_spawn_fx(ai, spawn_loc);
                count++;
                level flag::set("dog_clips");
            }
        } else {
            spawn_point = dog_spawn_factory_logic(favorite_enemy);
            ai = zombie_utility::spawn_zombie(level.dog_spawners[0]);
            if (isdefined(ai)) {
                ai.favoriteenemy = favorite_enemy;
                spawn_point thread dog_spawn_fx(ai, spawn_point);
                count++;
                level flag::set("dog_clips");
            }
        }
        waiting_for_next_dog_spawn(count, num_to_spawn);
    }
    return true;
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0xd17d149e, Offset: 0x2e18
// Size: 0xfc
function dog_run_think() {
    self endon(#"death");
    self waittill(#"visible");
    if (self.health > level.dog_health) {
        self.maxhealth = level.dog_health;
        self.health = level.dog_health;
    }
    self clientfield::set("dog_fx", 1);
    self playloopsound("zmb_hellhound_loop_fire");
    while (true) {
        if (!zm_utility::is_player_valid(self.favoriteenemy)) {
            self.favoriteenemy = get_favorite_enemy();
        }
        if (isdefined(level.custom_dog_target_validity_check)) {
            self [[ level.custom_dog_target_validity_check ]]();
        }
        wait 0.2;
    }
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x0
// Checksum 0x609cc320, Offset: 0x2f20
// Size: 0x60
function dog_stalk_audio() {
    self endon(#"death");
    self endon(#"dog_running");
    self endon(#"dog_combat");
    while (true) {
        self notify(#"bhtn_action_notify", "ambient");
        wait randomfloatrange(2, 4);
    }
}

// Namespace zm_ai_dogs
// Params 2, eflags: 0x0
// Checksum 0x1b76a9f0, Offset: 0x2f88
// Size: 0x7c
function dog_thundergun_knockdown(player, gib) {
    self endon(#"death");
    damage = int(self.maxhealth * 0.5);
    self dodamage(damage, player.origin, player);
}

