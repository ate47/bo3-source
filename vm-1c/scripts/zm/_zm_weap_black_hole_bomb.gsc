#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weap_black_hole_bomb;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_behavior;
#using scripts/zm/_zm_audio;
#using scripts/zm/_util;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_vortex;
#using scripts/shared/weapons_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("zombie_cymbal_monkey");

#namespace namespace_d6b63386;

// Namespace namespace_d6b63386
// Params 0, eflags: 0x2
// namespace_d6b63386<file_0>::function_2dc19561
// Checksum 0x5a034a79, Offset: 0x7a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_black_hole_bomb", &__init__, undefined, undefined);
}

// Namespace namespace_d6b63386
// Params 0, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_8c87d8eb
// Checksum 0x2ce17ae1, Offset: 0x7e8
// Size: 0x2bc
function __init__() {
    visionset_mgr::register_info("visionset", "zombie_cosmodrome_blackhole", 21000, level.vsmgr_prio_visionset_zombie_vortex + 1, 30, 1, &function_bf9781f8, 1);
    clientfield::register("toplayer", "bhb_viewlights", 21000, 2, "int");
    clientfield::register("scriptmover", "toggle_black_hole_deployed", 21000, 1, "int");
    clientfield::register("actor", "toggle_black_hole_being_pulled", 21000, 1, "int");
    level._effect["black_hole_bomb_portal"] = "dlc5/cosmo/fx_zmb_blackhole_looping";
    level._effect["black_hole_bomb_portal_exit"] = "dlc5/cosmo/fx_zmb_blackhole_exit";
    level._effect["black_hole_bomb_zombie_soul"] = "dlc5/cosmo/fx_zmb_blackhole_zombie_death";
    level._effect["black_hole_bomb_zombie_destroy"] = "dlc5/cosmo/fx_zmb_blackhole_zombie_flare";
    level._effect["black_hole_bomb_zombie_gib"] = "dlc5/zmhd/fx_zombie_dog_explosion";
    level._effect["black_hole_bomb_event_horizon"] = "dlc5/cosmo/fx_zmb_blackhole_implode";
    level._effect["black_hole_samantha_steal"] = "dlc5/cosmo/fx_zmb_blackhole_trap_end";
    level._effect["black_hole_bomb_zombie_pull"] = "dlc5/cosmo/fx_blackhole_zombie_breakup";
    level._effect["black_hole_bomb_marker_flare"] = "dlc5/cosmo/fx_zmb_blackhole_flare_marker";
    /#
        level.var_ee99d38d = &function_5ed4fd4e;
    #/
    level.var_4af7fb42 = [];
    level.var_1d1dec86 = [];
    level flag::init("bhb_anim_change_allowed");
    level thread function_5061e719();
    level flag::set("bhb_anim_change_allowed");
    level.w_black_hole_bomb = getweapon("black_hole_bomb");
    level.black_hole_bomb_death_start_func = &function_11e82050;
    level.var_f17362f1 = &zm_behavior::zombiekilledbyblackholebombcondition;
}

// Namespace namespace_d6b63386
// Params 0, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_5ed4fd4e
// Checksum 0x13465c66, Offset: 0xab0
// Size: 0x74
function function_5ed4fd4e() {
    self giveweapon(level.w_black_hole_bomb);
    self zm_utility::set_player_tactical_grenade(level.w_black_hole_bomb);
    self thread function_ef1268c3();
    self thread function_e877695e();
}

// Namespace namespace_d6b63386
// Params 0, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_ef1268c3
// Checksum 0x92ba04ae, Offset: 0xb30
// Size: 0x560
function function_ef1268c3() {
    self notify(#"hash_9b250665");
    self endon(#"disconnect");
    self endon(#"hash_9b250665");
    attract_dist_diff = level.var_b52c1c52;
    if (!isdefined(attract_dist_diff)) {
        attract_dist_diff = 10;
    }
    num_attractors = level.var_dca24065;
    if (!isdefined(num_attractors)) {
        num_attractors = 15;
    }
    max_attract_dist = level.var_227de6ff;
    if (!isdefined(max_attract_dist)) {
        max_attract_dist = 2056;
    }
    while (true) {
        grenade = function_3c6aa7c();
        if (isdefined(grenade)) {
            if (isdefined(self.intermission) && (self laststand::player_is_in_laststand() || self.intermission)) {
                grenade delete();
                continue;
            }
            grenade hide();
            model = util::spawn_model("wpn_t7_zmb_hd_gersch_device_world", grenade.origin);
            model linkto(grenade);
            model.angles = grenade.angles;
            info = spawnstruct();
            info.sound_attractors = [];
            grenade thread monitor_zombie_groans(info);
            var_b7b39fb0 = 100000000;
            for (oldpos = grenade.origin; var_b7b39fb0 != 0; oldpos = grenade.origin) {
                wait(0.05);
                if (!isdefined(grenade)) {
                    break;
                }
                var_b7b39fb0 = distancesquared(grenade.origin, oldpos);
            }
            if (isdefined(grenade)) {
                self thread function_19ab2ffc(grenade);
                model unlink();
                model.origin = grenade.origin;
                model.angles = grenade.angles;
                model.var_9177e56b = self;
                model.targetname = "zm_bhb";
                model._new_ground_trace = 1;
                grenade resetmissiledetonationtime();
                if (isdefined(level.var_5fc80ad9)) {
                    if ([[ level.var_5fc80ad9 ]](grenade, model, info)) {
                        continue;
                    }
                }
                if (isdefined(level.var_605ba2da)) {
                    if ([[ level.var_605ba2da ]](grenade, model, self)) {
                        continue;
                    }
                }
                valid_poi = zm_utility::is_point_inside_enabled_zone(grenade.origin);
                valid_poi = valid_poi && grenade function_11c66679(valid_poi);
                if (valid_poi) {
                    level thread function_5c13772b(grenade, model);
                    if (isdefined(level.var_e6d722f)) {
                        model thread [[ level.var_e6d722f ]]();
                    }
                    duration = grenade.weapon.fusetime / 1000;
                    self thread zombie_vortex::start_timed_vortex(grenade.origin, 4227136, duration, undefined, undefined, self, level.w_black_hole_bomb, 0, undefined, 0, 0, 0, grenade);
                    model clientfield::set("toggle_black_hole_deployed", 1);
                    grenade thread function_1ff5cae1();
                    level thread function_ed095c69(grenade);
                    grenade.is_valid = 1;
                } else {
                    self.script_noteworthy = undefined;
                    level thread function_18844f2c(self, model);
                }
            } else {
                self.script_noteworthy = undefined;
                level thread function_18844f2c(self, model);
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_d6b63386
// Params 0, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_e877695e
// Checksum 0xaf52e53c, Offset: 0x1098
// Size: 0xc0
function function_e877695e() {
    self notify(#"hash_e877695e");
    self endon(#"disconnect");
    self endon(#"hash_e877695e");
    while (true) {
        w_new = self waittill(#"grenade_pullback");
        var_fe9168ca = 0.75;
        if (w_new == level.w_black_hole_bomb) {
            wait(var_fe9168ca);
            self clientfield::set_to_player("bhb_viewlights", 1);
            wait(3);
            self clientfield::set_to_player("bhb_viewlights", 0);
        }
    }
}

// Namespace namespace_d6b63386
// Params 0, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_1ff5cae1
// Checksum 0x9b1658d0, Offset: 0x1160
// Size: 0x16a
function function_1ff5cae1() {
    array::add(level.var_4af7fb42, self);
    foreach (player in level.players) {
        visionset_mgr::activate("visionset", "zombie_cosmodrome_blackhole", player);
    }
    self waittill(#"explode");
    arrayremovevalue(level.var_4af7fb42, self);
    foreach (player in level.players) {
        visionset_mgr::deactivate("visionset", "zombie_cosmodrome_blackhole", player);
    }
}

// Namespace namespace_d6b63386
// Params 1, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_bf9781f8
// Checksum 0xef37c409, Offset: 0x12d8
// Size: 0x138
function function_bf9781f8(player) {
    while (level.var_4af7fb42.size > 0) {
        var_a81ad02a = 2147483647;
        foreach (var_4478607 in level.var_4af7fb42) {
            curr_dist = distancesquared(player.origin, var_4478607.origin);
            if (curr_dist < var_a81ad02a) {
                var_a81ad02a = curr_dist;
            }
        }
        if (var_a81ad02a < 262144) {
            visionset_mgr::set_state_active(player, 1 - var_a81ad02a / 262144);
        }
        wait(0.05);
    }
}

// Namespace namespace_d6b63386
// Params 1, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_11c66679
// Checksum 0xcf6994aa, Offset: 0x1418
// Size: 0x1da
function function_11c66679(valid_poi) {
    if (!(isdefined(valid_poi) && valid_poi)) {
        return false;
    }
    if (ispointonnavmesh(self.origin)) {
        return true;
    }
    v_orig = self.origin;
    queryresult = positionquery_source_navigation(self.origin, 0, -56, 100, 2, 15);
    if (queryresult.data.size) {
        foreach (point in queryresult.data) {
            height_offset = abs(self.origin[2] - point.origin[2]);
            if (height_offset > 36) {
                continue;
            }
            if (bullettracepassed(point.origin + (0, 0, 20), v_orig + (0, 0, 20), 0, self, undefined, 0, 0)) {
                self.origin = point.origin;
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_d6b63386
// Params 0, eflags: 0x0
// namespace_d6b63386<file_0>::function_fdc23c50
// Checksum 0xb27fca16, Offset: 0x1600
// Size: 0x1c
function wait_for_attractor_positions_complete() {
    self waittill(#"attractor_positions_generated");
    self.attract_to_origin = 0;
}

// Namespace namespace_d6b63386
// Params 2, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_5c13772b
// Checksum 0x4058f69b, Offset: 0x1628
// Size: 0xa4
function function_5c13772b(parent, model) {
    model endon(#"hash_444e70b2");
    var_ad1b201a = parent.origin;
    while (true) {
        if (!isdefined(parent)) {
            if (isdefined(model)) {
                model delete();
                util::wait_network_frame();
            }
            break;
        }
        wait(0.05);
    }
    level thread function_2f9d4e1e(var_ad1b201a);
}

// Namespace namespace_d6b63386
// Params 1, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_2f9d4e1e
// Checksum 0x68af03aa, Offset: 0x16d8
// Size: 0xae
function function_2f9d4e1e(var_f0bff742) {
    wait(0.1);
    corpse_array = getcorpsearray();
    for (i = 0; i < corpse_array.size; i++) {
        if (distancesquared(corpse_array[i].origin, var_f0bff742) < 36864) {
            corpse_array[i] thread function_298289();
        }
    }
}

// Namespace namespace_d6b63386
// Params 0, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_298289
// Checksum 0x1efed13e, Offset: 0x1790
// Size: 0x1c
function function_298289() {
    self delete();
}

// Namespace namespace_d6b63386
// Params 0, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_3c6aa7c
// Checksum 0x1a2a9d62, Offset: 0x17b8
// Size: 0x80
function function_3c6aa7c() {
    self endon(#"disconnect");
    self endon(#"hash_9b250665");
    while (true) {
        grenade, weapon = self waittill(#"grenade_fire");
        if (weapon == level.w_black_hole_bomb) {
            grenade.weapon = weapon;
            return grenade;
        }
        wait(0.05);
    }
}

// Namespace namespace_d6b63386
// Params 1, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_5a68004b
// Checksum 0xc0ef8d94, Offset: 0x1840
// Size: 0x1cc
function monitor_zombie_groans(info) {
    self endon(#"explode");
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        if (!isdefined(self.attractor_array)) {
            wait(0.05);
            continue;
        }
        for (i = 0; i < self.attractor_array.size; i++) {
            if (!isinarray(info.sound_attractors, self.attractor_array[i])) {
                if (isdefined(self.origin) && isdefined(self.attractor_array[i].origin)) {
                    if (distancesquared(self.origin, self.attractor_array[i].origin) < 250000) {
                        if (!isdefined(info.sound_attractors)) {
                            info.sound_attractors = [];
                        } else if (!isarray(info.sound_attractors)) {
                            info.sound_attractors = array(info.sound_attractors);
                        }
                        info.sound_attractors[info.sound_attractors.size] = self.attractor_array[i];
                        self.attractor_array[i] thread play_zombie_groans();
                    }
                }
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_d6b63386
// Params 0, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_af474b1d
// Checksum 0x49fbfe76, Offset: 0x1a18
// Size: 0x66
function play_zombie_groans() {
    self endon(#"death");
    self endon(#"hash_e0cde323");
    while (true) {
        if (isdefined(self)) {
            self playsound("zmb_vox_zombie_groan");
            wait(randomfloatrange(2, 3));
            continue;
        }
        return;
    }
}

// Namespace namespace_d6b63386
// Params 0, eflags: 0x0
// namespace_d6b63386<file_0>::function_c5b223cd
// Checksum 0x635ecd9f, Offset: 0x1a88
// Size: 0x16
function function_c5b223cd() {
    return isdefined(level.zombie_weapons["black_hole_bomb"]);
}

// Namespace namespace_d6b63386
// Params 0, eflags: 0x0
// namespace_d6b63386<file_0>::function_860175b0
// Checksum 0x94ff47a0, Offset: 0x1aa8
// Size: 0xd4
function function_860175b0() {
    self endon(#"death");
    var_15fcfc38 = self.var_12d0f044;
    anim_keys = getarraykeys(level.scr_anim[self.animname]);
    for (j = 0; j < anim_keys.size; j++) {
        if (level.scr_anim[self.animname][anim_keys[j]] == var_15fcfc38) {
            return anim_keys[j];
        }
    }
    assertmsg("toggle_black_hole_being_pulled");
}

// Namespace namespace_d6b63386
// Params 0, eflags: 0x0
// namespace_d6b63386<file_0>::function_c6656a2c
// Checksum 0x779172d7, Offset: 0x1b88
// Size: 0x50
function function_c6656a2c() {
    self endon(#"death");
    util::wait_network_frame();
    self clientfield::set("toggle_black_hole_being_pulled", 1);
    self.var_80caa4dd = 1;
}

// Namespace namespace_d6b63386
// Params 2, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_11e82050
// Checksum 0x38e2282c, Offset: 0x1be0
// Size: 0x4c
function function_11e82050(var_e2e40379, grenade) {
    self zombie_utility::zombie_eye_glow_stop();
    self playsound("zmb_bhbomb_zombie_explode");
}

// Namespace namespace_d6b63386
// Params 0, eflags: 0x0
// namespace_d6b63386<file_0>::function_8c64a718
// Checksum 0x8a41ee47, Offset: 0x1c38
// Size: 0xa8
function function_8c64a718() {
    if (isdefined(self._black_hole_bomb_collapse_death) && self._black_hole_bomb_collapse_death == 1) {
        fxorigin = self gettagorigin("tag_origin");
        playfx(level._effect["black_hole_bomb_zombie_gib"], fxorigin);
        self hide();
    }
    if (isdefined(self.var_80caa4dd) && self.var_80caa4dd == 1) {
    }
}

// Namespace namespace_d6b63386
// Params 0, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_5061e719
// Checksum 0x128b9a80, Offset: 0x1ce8
// Size: 0x260
function function_5061e719() {
    if (!isdefined(level.var_1d1dec86)) {
        level.var_1d1dec86 = [];
    }
    var_444ffb38 = 7;
    var_c48b032a = [];
    while (isdefined(level.var_1d1dec86)) {
        if (level.var_1d1dec86.size == 0) {
            wait(0.1);
            continue;
        }
        var_c48b032a = level.var_1d1dec86;
        for (i = 0; i < var_c48b032a.size; i++) {
            if (isdefined(var_c48b032a[i]) && isalive(var_c48b032a[i])) {
                var_c48b032a[i] flag::set("bhb_anim_change");
            }
            if (i >= var_444ffb38) {
                break;
            }
        }
        level flag::clear("bhb_anim_change_allowed");
        for (i = 0; i < var_c48b032a.size; i++) {
            if (!isdefined(var_c48b032a[i].var_939d50a0)) {
                var_c48b032a[i] flag::init("bhb_anim_change");
                var_c48b032a[i].var_939d50a0 = 1;
            }
            if (var_c48b032a[i] flag::get("bhb_anim_change")) {
                arrayremovevalue(level.var_1d1dec86, var_c48b032a[i]);
            }
        }
        level.var_1d1dec86 = array::remove_dead(level.var_1d1dec86);
        arrayremovevalue(level.var_1d1dec86, undefined);
        level flag::set("bhb_anim_change_allowed");
        util::wait_network_frame();
        wait(0.1);
    }
}

// Namespace namespace_d6b63386
// Params 1, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_ed095c69
// Checksum 0x182d760e, Offset: 0x1f50
// Size: 0xac
function function_ed095c69(var_dbce19b3) {
    if (!isdefined(var_dbce19b3)) {
        return;
    }
    teleport_trigger = spawn("trigger_radius", var_dbce19b3.origin, 0, 64, 70);
    var_dbce19b3 thread function_773ea274(teleport_trigger);
    var_dbce19b3 waittill(#"explode");
    teleport_trigger notify(#"hash_6af08767");
    wait(0.1);
    teleport_trigger delete();
}

// Namespace namespace_d6b63386
// Params 1, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_773ea274
// Checksum 0xc52f52, Offset: 0x2008
// Size: 0xe0
function function_773ea274(var_d67fd3fd) {
    var_d67fd3fd endon(#"hash_6af08767");
    while (true) {
        ent_player = var_d67fd3fd waittill(#"trigger");
        if (isplayer(ent_player) && !ent_player isonground() && !(isdefined(ent_player.lander) && ent_player.lander)) {
            var_d67fd3fd thread function_21bc3f25(ent_player, &function_ef2aae65, &function_12b91af0);
        }
        wait(0.1);
    }
}

// Namespace namespace_d6b63386
// Params 2, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_ef2aae65
// Checksum 0x939ef92c, Offset: 0x20f0
// Size: 0x224
function function_ef2aae65(ent_player, str_endon) {
    ent_player endon(str_endon);
    if (!bullettracepassed(ent_player geteye(), self.origin + (0, 0, 65), 0, ent_player)) {
        return;
    }
    var_3bc48314 = struct::get_array("struct_black_hole_teleport", "targetname");
    var_b9ca37a = undefined;
    if (isdefined(level.var_c9271e19)) {
        var_3bc48314 = [[ level.var_c9271e19 ]]();
    }
    if (!isdefined(var_3bc48314) || var_3bc48314.size == 0) {
        return;
    }
    var_3bc48314 = array::randomize(var_3bc48314);
    if (isdefined(level.var_e608f920)) {
        var_b9ca37a = [[ level.var_e608f920 ]](var_3bc48314, ent_player);
    } else {
        for (i = 0; i < var_3bc48314.size; i++) {
            if (zm_utility::check_point_in_enabled_zone(var_3bc48314[i].origin) && ent_player zm_utility::get_current_zone() != var_3bc48314[i].script_string) {
                var_b9ca37a = var_3bc48314[i];
                break;
            }
        }
    }
    if (isdefined(var_b9ca37a)) {
        self playsound("zmb_gersh_teleporter_out");
        ent_player playsoundtoplayer("zmb_gersh_teleporter_out_plr", ent_player);
        ent_player thread function_9c0b0e0b(var_b9ca37a);
    }
}

// Namespace namespace_d6b63386
// Params 1, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_12b91af0
// Checksum 0xcc34ab80, Offset: 0x2320
// Size: 0xc
function function_12b91af0(ent_player) {
    
}

// Namespace namespace_d6b63386
// Params 1, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_9c0b0e0b
// Checksum 0x8c7dbdf1, Offset: 0x2338
// Size: 0x24c
function function_9c0b0e0b(var_ff042d85) {
    self endon(#"death");
    if (!isdefined(var_ff042d85)) {
        return;
    }
    prone_offset = (0, 0, 49);
    crouch_offset = (0, 0, 20);
    var_7cac5f2f = (0, 0, 0);
    destination = undefined;
    if (self getstance() == "prone") {
        destination = var_ff042d85.origin + prone_offset;
    } else if (self getstance() == "crouch") {
        destination = var_ff042d85.origin + crouch_offset;
    } else {
        destination = var_ff042d85.origin + var_7cac5f2f;
    }
    if (isdefined(level.var_563d5383)) {
        level [[ level.var_563d5383 ]](self);
    }
    function_587239f1(var_ff042d85.origin);
    self freezecontrols(1);
    self disableoffhandweapons();
    self disableweapons();
    self dontinterpolate();
    self setorigin(destination);
    self setplayerangles(var_ff042d85.angles);
    self enableoffhandweapons();
    self enableweapons();
    self freezecontrols(0);
    self thread function_28570bac();
}

// Namespace namespace_d6b63386
// Params 0, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_28570bac
// Checksum 0x29f3ae72, Offset: 0x2590
// Size: 0x2c
function function_28570bac() {
    wait(1);
    self zm_audio::create_and_play_dialog("general", "teleport_gersh");
}

// Namespace namespace_d6b63386
// Params 3, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_21bc3f25
// Checksum 0xf7b7645d, Offset: 0x25c8
// Size: 0x144
function function_21bc3f25(ent, on_enter_payload, on_exit_payload) {
    ent endon(#"death");
    self endon(#"hash_6af08767");
    if (ent function_a72303f3(self)) {
        return;
    }
    self function_ae7de6cc(ent);
    endon_condition = "leave_trigger_" + self getentitynumber();
    if (isdefined(on_enter_payload)) {
        self thread [[ on_enter_payload ]](ent, endon_condition);
    }
    while (isdefined(ent) && ent istouching(self) && isdefined(self)) {
        wait(0.01);
    }
    ent notify(endon_condition);
    if (isdefined(ent) && isdefined(on_exit_payload)) {
        self thread [[ on_exit_payload ]](ent);
    }
    if (isdefined(ent)) {
        self function_4421f0a4(ent);
    }
}

// Namespace namespace_d6b63386
// Params 1, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_ae7de6cc
// Checksum 0x561ca29a, Offset: 0x2718
// Size: 0x5a
function function_ae7de6cc(ent) {
    if (!isdefined(ent._triggers)) {
        ent._triggers = [];
    }
    ent._triggers[self getentitynumber()] = 1;
}

// Namespace namespace_d6b63386
// Params 1, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_4421f0a4
// Checksum 0x27000016, Offset: 0x2780
// Size: 0x6a
function function_4421f0a4(ent) {
    if (!isdefined(ent._triggers)) {
        return;
    }
    if (!isdefined(ent._triggers[self getentitynumber()])) {
        return;
    }
    ent._triggers[self getentitynumber()] = 0;
}

// Namespace namespace_d6b63386
// Params 1, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_a72303f3
// Checksum 0x68d0fbe4, Offset: 0x27f8
// Size: 0x70
function function_a72303f3(trig) {
    if (!isdefined(self._triggers)) {
        return false;
    }
    if (!isdefined(self._triggers[trig getentitynumber()])) {
        return false;
    }
    if (!self._triggers[trig getentitynumber()]) {
        return false;
    }
    return true;
}

// Namespace namespace_d6b63386
// Params 1, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_19ab2ffc
// Checksum 0x807f09e, Offset: 0x2870
// Size: 0x9a
function function_19ab2ffc(grenade) {
    self endon(#"death");
    grenade endon(#"death");
    kill_count = 0;
    for (;;) {
        grenade waittill(#"black_hole_bomb_kill");
        kill_count++;
        if (kill_count == 4) {
            self zm_audio::create_and_play_dialog("kill", "gersh_device");
        }
        if (5 <= kill_count) {
            self notify(#"hash_c0bd0a11");
        }
    }
}

// Namespace namespace_d6b63386
// Params 1, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_587239f1
// Checksum 0xf805f652, Offset: 0x2918
// Size: 0xe4
function function_587239f1(pos) {
    var_8f780822 = spawn("script_model", pos);
    var_8f780822 setmodel("tag_origin");
    playfxontag(level._effect["black_hole_bomb_portal_exit"], var_8f780822, "tag_origin");
    var_8f780822 thread function_37ab29dd();
    var_8f780822 playsound("wpn_bhbomb_portal_exit_start");
    var_8f780822 playloopsound("wpn_bhbomb_portal_exit_loop", 0.2);
}

// Namespace namespace_d6b63386
// Params 0, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_37ab29dd
// Checksum 0x6141e3c4, Offset: 0x2a08
// Size: 0x44
function function_37ab29dd() {
    wait(4);
    playsoundatposition("wpn_bhbomb_portal_exit_pop", self.origin);
    self delete();
}

// Namespace namespace_d6b63386
// Params 2, eflags: 0x1 linked
// namespace_d6b63386<file_0>::function_18844f2c
// Checksum 0x664a550b, Offset: 0x2a58
// Size: 0x224
function function_18844f2c(var_dbce19b3, ent_model) {
    if (!isdefined(ent_model)) {
        return;
    }
    direction = ent_model.origin;
    direction = (direction[1], direction[0], 0);
    if (direction[0] > 0 && (direction[1] < 0 || direction[1] > 0)) {
        direction = (direction[0], direction[1] * -1, 0);
    } else if (direction[0] < 0) {
        direction = (direction[0] * -1, direction[1], 0);
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isalive(players[i])) {
            players[i] playlocalsound(level.zmb_laugh_alias);
        }
    }
    playfxontag(level._effect["black_hole_samantha_steal"], ent_model, "tag_origin");
    ent_model movez(60, 1, 0.25, 0.25);
    ent_model vibrate(direction, 1.5, 2.5, 1);
    ent_model waittill(#"movedone");
    ent_model delete();
}

