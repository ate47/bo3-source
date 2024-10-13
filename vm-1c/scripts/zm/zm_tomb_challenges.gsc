#using scripts/zm/zm_challenges_tomb;
#using scripts/zm/zm_tomb_vo;
#using scripts/zm/_zm_weap_one_inch_punch;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerup_zombie_blood;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_tomb_challenges;

// Namespace zm_tomb_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xc57866f3, Offset: 0x580
// Size: 0x1c
function challenges_init() {
    level.var_355dffb3 = &function_5abe71ac;
}

// Namespace zm_tomb_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x3145d99a, Offset: 0x5a8
// Size: 0x184
function function_5abe71ac() {
    n_kills = 115;
    var_2d0dc4a6 = 6;
    var_2e7c57c = 30000;
    var_d0ef9002 = 4;
    /#
        if (getdvarint("<dev string:x28>") > 0) {
            n_kills = 1;
            var_2d0dc4a6 = 2;
            var_2e7c57c = 500;
            var_d0ef9002 = 1;
        }
    #/
    zm_challenges_tomb::function_159cc09f("zc_headshots", 0, %ZM_TOMB_CH1, n_kills, undefined, &function_d1f64b7e);
    zm_challenges_tomb::function_159cc09f("zc_zone_captures", 0, %ZM_TOMB_CH2, var_2d0dc4a6, undefined, &function_702e0edf);
    zm_challenges_tomb::function_159cc09f("zc_points_spent", 0, %ZM_TOMB_CH3, var_2e7c57c, undefined, &function_7bd2fe26, &function_f0cd0d99);
    zm_challenges_tomb::function_159cc09f("zc_boxes_filled", 1, %ZM_TOMB_CHT, var_d0ef9002, undefined, &function_6fa5ca25, &function_23b9880);
}

// Namespace zm_tomb_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x60dc65b4, Offset: 0x738
// Size: 0x58
function function_f0cd0d99() {
    while (true) {
        player, points = level waittill(#"spent_points");
        player zm_challenges_tomb::function_6b433789("zc_points_spent", points);
    }
}

// Namespace zm_tomb_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xbccb72c0, Offset: 0x798
// Size: 0x9c
function function_23b9880() {
    level.var_814954e1 = 0;
    level flag::init("vo_soul_box_intro_played");
    level flag::init("vo_soul_box_continue_played");
    var_4bae9c = getentarray("foot_box", "script_noteworthy");
    array::thread_all(var_4bae9c, &function_6b2cf8b5);
}

// Namespace zm_tomb_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x47476cd2, Offset: 0x840
// Size: 0x724
function function_6b2cf8b5() {
    self.var_286a167f = 0;
    self disconnectpaths();
    n_souls_required = 30;
    /#
        if (getdvarint("<dev string:x28>") > 0) {
            n_souls_required = 10;
        }
    #/
    self thread function_232e28db();
    wait 1;
    self clientfield::set("foot_print_box_glow", 1);
    wait 1;
    self clientfield::set("foot_print_box_glow", 0);
    while (self.var_286a167f < n_souls_required) {
        player = self waittill(#"hash_6c130b53");
        self.var_286a167f++;
        if (self.var_286a167f == 1) {
            self thread scene::play("p7_fxanim_zm_ori_challenge_box_open_bundle", self);
            self util::delay(1, undefined, &clientfield::set, "foot_print_box_glow", 1);
            if (isdefined(player) && !level flag::get("vo_soul_box_intro_played")) {
                player util::delay(1.5, undefined, &zm_tomb_vo::function_92121c7d, "zm_box_start", 0, "vo_soul_box_intro_played");
            }
        }
        if (self.var_286a167f == floor(n_souls_required / 4)) {
            if (isdefined(player) && level flag::get("vo_soul_box_intro_played") && !level flag::get("vo_soul_box_continue_played")) {
                player thread zm_tomb_vo::function_92121c7d("zm_box_continue", 1, "vo_soul_box_continue_played");
            }
        }
        if (self.var_286a167f == floor(n_souls_required / 2) || self.var_286a167f == floor(n_souls_required / 1.3)) {
            if (isdefined(player)) {
                player zm_audio::create_and_play_dialog("soul_box", "zm_box_encourage");
            }
        }
        if (self.var_286a167f == n_souls_required) {
            wait 1;
            self scene::play("p7_fxanim_zm_ori_challenge_box_close_bundle", self);
        }
    }
    self notify(#"hash_d9c666c1");
    level.var_814954e1++;
    self scene::stop("p7_fxanim_zm_ori_challenge_box_close_bundle", self);
    e_volume = getent(self.target, "targetname");
    e_volume delete();
    self util::delay(0.5, undefined, &clientfield::set, "foot_print_box_glow", 0);
    wait 2;
    self stopanimscripted();
    v_start_angles = self.angles;
    self movez(30, 1, 1);
    self.angles = v_start_angles;
    playsoundatposition("zmb_footprintbox_disappear", self.origin);
    wait 0.5;
    var_5faddb59 = randomintrange(5, 7);
    for (i = 0; i < var_5faddb59; i++) {
        var_79f3a24 = v_start_angles + (randomfloatrange(-10, 10), randomfloatrange(-10, 10), randomfloatrange(-10, 10));
        var_b53c9eef = randomfloatrange(0.2, 0.4);
        self rotateto(var_79f3a24, var_b53c9eef);
        self waittill(#"rotatedone");
    }
    self rotateto(v_start_angles, 0.3);
    self movez(-60, 0.5, 0.5);
    self waittill(#"rotatedone");
    trace_start = self.origin + (0, 0, 200);
    trace_end = self.origin;
    var_316e81ed = bullettrace(trace_start, trace_end, 0, self);
    playfx(level._effect["mech_booster_landing"], var_316e81ed["position"], anglestoforward(self.angles), anglestoup(self.angles));
    self waittill(#"movedone");
    level zm_challenges_tomb::function_6b433789("zc_boxes_filled");
    if (isdefined(player)) {
        if (level.var_814954e1 == 1) {
            player thread zm_tomb_vo::function_92121c7d("zm_box_complete");
        } else if (level.var_814954e1 == 4) {
            player thread zm_tomb_vo::function_92121c7d("zm_box_final_complete", 1);
        }
    }
    self connectpaths();
    self delete();
}

// Namespace zm_tomb_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xc06ae652, Offset: 0xf70
// Size: 0x98
function function_232e28db() {
    self endon(#"hash_d9c666c1");
    while (true) {
        self waittill(#"hash_d1aaf42c");
        self scene::play("p7_fxanim_zm_ori_challenge_box_close_bundle", self);
        self clientfield::set("foot_print_box_glow", 0);
        self.var_286a167f = 0;
        wait 5;
        self scene::stop("p7_fxanim_zm_ori_challenge_box_close_bundle", self);
    }
}

// Namespace zm_tomb_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x843af902, Offset: 0x1010
// Size: 0x152
function function_a93cf9ad(attacker) {
    a_volumes = getentarray("foot_box_volume", "script_noteworthy");
    foreach (e_volume in a_volumes) {
        if (self istouching(e_volume) && isdefined(attacker) && isplayer(attacker)) {
            self clientfield::set("foot_print_box_fx", 1);
            var_e32cd584 = getent(e_volume.target, "targetname");
            var_e32cd584 notify(#"hash_6c130b53", attacker);
            return true;
        }
    }
    return false;
}

// Namespace zm_tomb_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x693573fd, Offset: 0x1170
// Size: 0x360
function function_d1f64b7e(player, var_4d6f50a9) {
    if (!isdefined(var_4d6f50a9.w_reward)) {
        a_weapons = array("smg_capacity", "smg_mp40_1940", "ar_accurate");
        var_7e5dd894 = getweapon(array::random(a_weapons));
        var_4d6f50a9.w_reward = zm_weapons::get_upgrade_weapon(var_7e5dd894);
    }
    m_weapon = spawn("script_model", self.origin);
    m_weapon.angles = self.angles + (0, 180, 0);
    m_weapon playsound("zmb_spawn_powerup");
    m_weapon playloopsound("zmb_spawn_powerup_loop", 0.5);
    str_model = getweaponmodel(var_4d6f50a9.w_reward);
    options = player zm_weapons::get_pack_a_punch_weapon_options(var_4d6f50a9.w_reward);
    m_weapon useweaponmodel(var_4d6f50a9.w_reward, str_model, options);
    util::wait_network_frame();
    if (!zm_challenges_tomb::function_aeb6a22b(m_weapon, 50, 2, 2, 10)) {
        return false;
    }
    weapon_limit = zm_utility::get_player_weapon_limit(player);
    primaries = player getweaponslistprimaries();
    if (isdefined(primaries) && primaries.size >= weapon_limit) {
        player zm_weapons::weapon_give(var_4d6f50a9.w_reward);
    } else {
        player zm_weapons::give_build_kit_weapon(var_4d6f50a9.w_reward);
        player givestartammo(var_4d6f50a9.w_reward);
    }
    player switchtoweapon(var_4d6f50a9.w_reward);
    m_weapon stoploopsound(0.1);
    player playsound("zmb_powerup_grabbed");
    m_weapon delete();
    return true;
}

// Namespace zm_tomb_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0xa8217238, Offset: 0x14d8
// Size: 0x32
function function_702e0edf(player, var_4d6f50a9) {
    return function_20d46fd1(player, "full_ammo");
}

// Namespace zm_tomb_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0xded5b6d2, Offset: 0x1518
// Size: 0x32
function function_51587ba7(player, n_timeout) {
    return function_20d46fd1(player, "double_points", n_timeout);
}

// Namespace zm_tomb_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x5da3c5b5, Offset: 0x1558
// Size: 0x32
function function_2bd3ec4f(player, n_timeout) {
    return function_20d46fd1(player, "zombie_blood", n_timeout);
}

// Namespace zm_tomb_challenges
// Params 3, eflags: 0x1 linked
// Checksum 0x88284733, Offset: 0x1598
// Size: 0x2b0
function function_20d46fd1(player, str_powerup, n_timeout) {
    if (!isdefined(n_timeout)) {
        n_timeout = 10;
    }
    if (!isdefined(level.zombie_powerups[str_powerup])) {
        return;
    }
    s_powerup = level.zombie_powerups[str_powerup];
    var_a003a924 = spawn("script_model", self.origin);
    var_a003a924.angles = self.angles + (0, 180, 0);
    var_a003a924 setmodel(s_powerup.model_name);
    var_a003a924 playsound("zmb_spawn_powerup");
    var_a003a924 playloopsound("zmb_spawn_powerup_loop", 0.5);
    util::wait_network_frame();
    if (!zm_challenges_tomb::function_aeb6a22b(var_a003a924, 50, 2, 2, n_timeout)) {
        return 0;
    }
    var_a003a924.hint = s_powerup.hint;
    if (!isdefined(player)) {
        player = self.player_using;
    }
    switch (str_powerup) {
    case "full_ammo":
        level thread zm_powerup_full_ammo::full_ammo_powerup(var_a003a924, player);
        player thread zm_powerups::powerup_vo("full_ammo");
        break;
    case "double_points":
        level thread zm_powerup_double_points::double_points_powerup(var_a003a924, player);
        player thread zm_powerups::powerup_vo("double_points");
        break;
    case "zombie_blood":
        level thread zm_powerup_zombie_blood::zombie_blood_powerup(var_a003a924, player);
        break;
    }
    wait 0.1;
    var_a003a924 stoploopsound(0.1);
    player playsound("zmb_powerup_grabbed");
    var_a003a924 delete();
    return 1;
}

// Namespace zm_tomb_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x3131f67f, Offset: 0x1850
// Size: 0x240
function function_7bd2fe26(player, var_4d6f50a9) {
    var_a003a924 = spawn("script_model", self.origin);
    var_a003a924.angles = self.angles + (0, 180, 0);
    str_model = getweaponmodel(getweapon("zombie_perk_bottle_doubletap"));
    var_a003a924 setmodel(str_model);
    var_a003a924 playsound("zmb_spawn_powerup");
    var_a003a924 playloopsound("zmb_spawn_powerup_loop", 0.5);
    util::wait_network_frame();
    if (!zm_challenges_tomb::function_aeb6a22b(var_a003a924, 50, 2, 2, 10)) {
        return false;
    }
    if (player hasperk("specialty_doubletap2") || player zm_perks::has_perk_paused("specialty_doubletap2")) {
        var_a003a924 thread function_49e55229(player);
        return false;
    }
    var_a003a924 stoploopsound(0.1);
    player playsound("zmb_powerup_grabbed");
    var_a003a924 thread zm_perks::vending_trigger_post_think(player, "specialty_doubletap2");
    var_a003a924 ghost();
    player waittill(#"burp");
    wait 1.2;
    var_a003a924 delete();
    return true;
}

// Namespace zm_tomb_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x9ba3b77e, Offset: 0x1a98
// Size: 0x74
function function_49e55229(player) {
    n_time = 1;
    player playlocalsound(level.zmb_laugh_alias);
    self thread zm_challenges_tomb::function_bfb87de6(0, 61, n_time);
    wait n_time;
    self delete();
}

// Namespace zm_tomb_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0xf644b7e0, Offset: 0x1b18
// Size: 0x1c8
function function_6fa5ca25(player, var_4d6f50a9) {
    var_a003a924 = spawn("script_model", self.origin);
    var_a003a924.angles = self.angles + (0, 180, 0);
    var_a003a924 setmodel("tag_origin");
    playfxontag(level._effect["staff_soul"], var_a003a924, "tag_origin");
    var_a003a924 playsound("zmb_spawn_powerup");
    var_a003a924 playloopsound("zmb_spawn_powerup_loop", 0.5);
    util::wait_network_frame();
    if (!zm_challenges_tomb::function_aeb6a22b(var_a003a924, 50, 2, 2, 10)) {
        return false;
    }
    player thread _zm_weap_one_inch_punch::function_3898d995();
    var_a003a924 stoploopsound(0.1);
    player playsound("zmb_powerup_grabbed");
    var_a003a924 delete();
    player thread function_f1627038(var_4d6f50a9);
    return true;
}

// Namespace zm_tomb_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x4d3c8b16, Offset: 0x1ce8
// Size: 0x62
function function_f1627038(var_4d6f50a9) {
    self endon(#"disconnect");
    self waittill(#"bled_out");
    if (var_4d6f50a9.var_c404f0e7) {
        var_4d6f50a9.var_c404f0e7 = 0;
    }
    var_4d6f50a9.var_a6058410[self.characterindex] = 0;
}

// Namespace zm_tomb_challenges
// Params 2, eflags: 0x0
// Checksum 0xab1b3491, Offset: 0x1d58
// Size: 0x200
function function_e506c54b(player, var_4d6f50a9) {
    var_a003a924 = spawn("script_model", self.origin);
    var_a003a924.angles = self.angles + (0, 180, 0);
    str_model = getweaponmodel(level.w_beacon);
    var_a003a924 setmodel(str_model);
    var_a003a924 playsound("zmb_spawn_powerup");
    var_a003a924 playloopsound("zmb_spawn_powerup_loop", 0.5);
    util::wait_network_frame();
    if (!zm_challenges_tomb::function_aeb6a22b(var_a003a924, 50, 2, 2, 10)) {
        return false;
    }
    player zm_weapons::weapon_give(level.w_beacon);
    if (isdefined(level.zombie_include_weapons[level.w_beacon]) & !level.zombie_include_weapons[level.w_beacon]) {
        level.zombie_include_weapons[level.w_beacon] = 1;
        level.zombie_weapons[level.w_beacon].is_in_box = 1;
    }
    var_a003a924 stoploopsound(0.1);
    player playsound("zmb_powerup_grabbed");
    var_a003a924 delete();
    return true;
}

// Namespace zm_tomb_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x319fb4e2, Offset: 0x1f60
// Size: 0x1a
function getweaponmodel(weapon) {
    return weapon.worldmodel;
}

