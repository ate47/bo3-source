#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_amb;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weap_staff_fire;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_e6d36abe;

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_c35e6aab
// Checksum 0x42435215, Offset: 0xa50
// Size: 0xe4
function init() {
    clientfield::register("vehicle", "tank_tread_fx", 21000, 1, "int");
    clientfield::register("vehicle", "tank_flamethrower_fx", 21000, 2, "int");
    clientfield::register("vehicle", "tank_cooldown_fx", 21000, 2, "int");
    callback::on_spawned(&onplayerspawned);
    level.enemy_location_override_func = &function_ec0a572;
    level.var_cd651797 = &function_cd651797;
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_d290ebfa
// Checksum 0xed70b033, Offset: 0xb40
// Size: 0xec
function main() {
    level.var_f793f80e = getent("tank", "targetname");
    level.var_f793f80e function_1b39cea3();
    level.var_f793f80e thread function_b5589fb0();
    level thread namespace_ad52727b::function_f45a2e2c("tank", "tank_flame_zombie", "vo_tank_flame_zombie");
    level thread namespace_ad52727b::function_f45a2e2c("tank", "tank_leave", "vo_tank_leave");
    level thread namespace_ad52727b::function_f45a2e2c("tank", "tank_cooling", "vo_tank_cooling");
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_be02cc45
// Checksum 0x4db0abfb, Offset: 0xc38
// Size: 0x1c
function onplayerspawned() {
    self.var_d9cb04f7 = 0;
    self.var_32857832 = 0;
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_b5589fb0
// Checksum 0x5aca20d2, Offset: 0xc60
// Size: 0x1c8
function function_b5589fb0() {
    max_dist_sq = 640000;
    level flag::wait_till("activate_zone_village_0");
    while (true) {
        a_players = getplayers();
        foreach (e_player in a_players) {
            dist_sq = distance2dsquared(level.var_f793f80e.origin, e_player.origin);
            height_diff = abs(level.var_f793f80e.origin[2] - e_player.origin[2]);
            if (dist_sq < max_dist_sq && height_diff < -106 && !(isdefined(e_player.isspeaking) && e_player.isspeaking)) {
                e_player zm_audio::create_and_play_dialog("tank", "discover_tank");
                return;
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_f1e1f205
// Checksum 0x40d9feec, Offset: 0xe30
// Size: 0x340
function function_f1e1f205() {
    level flag::wait_till("start_zombie_round_logic");
    var_9c82a708 = [];
    for (i = 0; i < 3; i++) {
        var_3e5000b = i + 1;
        var_9c82a708[i] = getvehiclenode("tank_powerup_drop_" + var_3e5000b, "script_noteworthy");
        var_9c82a708[i].var_2757c2c7 = level.round_number + i;
        s_drop = struct::get("tank_powerup_drop_" + var_3e5000b, "targetname");
        var_9c82a708[i].drop_pos = s_drop.origin;
    }
    var_d5b49dcc = array("nuke", "full_ammo", "zombie_blood", "insta_kill", "fire_sale", "double_points");
    while (true) {
        self flag::wait_till("tank_moving");
        foreach (node in var_9c82a708) {
            dist_sq = distance2dsquared(node.origin, self.origin);
            if (dist_sq < 40000) {
                a_players = function_6e2be6b3(1);
                if (a_players.size > 0) {
                    if (level.var_6b14ee9b["elemental_staff_lightning"] == 0 && level.round_number >= node.var_2757c2c7) {
                        str_powerup = array::random(var_d5b49dcc);
                        level thread zm_powerups::specific_powerup_drop(str_powerup, node.drop_pos);
                        node.var_2757c2c7 = level.round_number + randomintrange(8, 12);
                        continue;
                    }
                    level notify(#"hash_2ddba539", self);
                }
            }
        }
        wait(2);
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_cd651797
// Checksum 0x6498439c, Offset: 0x1178
// Size: 0x86
function function_cd651797() {
    var_383b30ed = "barrier_walk";
    switch (self.zombie_move_speed) {
    case 28:
        var_383b30ed = "barrier_sprint";
        break;
    default:
        assertmsg("tank_flame_zombie" + self.zombie_move_speed + "tank_flame_zombie");
        break;
    }
    return var_383b30ed;
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x0
// namespace_e6d36abe<file_0>::function_8412f495
// Checksum 0xaf6d91fa, Offset: 0x1208
// Size: 0x24
function function_8412f495() {
    self useanimtree(#generic);
}

/#

    // Namespace namespace_e6d36abe
    // Params 2, eflags: 0x1 linked
    // namespace_e6d36abe<file_0>::function_3670931
    // Checksum 0xb0fa175c, Offset: 0x1238
    // Size: 0xb4
    function drawtag(tag, opcolor) {
        org = self gettagorigin(tag);
        ang = self gettagangles(tag);
        box(org, (-8, -8, 0), (8, 8, 8), ang[1], opcolor, 1, 0, 1);
    }

    // Namespace namespace_e6d36abe
    // Params 2, eflags: 0x1 linked
    // namespace_e6d36abe<file_0>::function_555487f3
    // Checksum 0xa4d79dfc, Offset: 0x12f8
    // Size: 0xa8
    function function_555487f3(tag, opcolor) {
        self endon(#"death");
        for (;;) {
            if (self function_c8b1de2c(tag)) {
                drawtag(tag.str_tag, (0, 255, 0));
            } else {
                drawtag(tag.str_tag, (255, 0, 0));
            }
            wait(0.05);
        }
    }

    // Namespace namespace_e6d36abe
    // Params 0, eflags: 0x1 linked
    // namespace_e6d36abe<file_0>::function_827a387
    // Checksum 0x895752b9, Offset: 0x13a8
    // Size: 0x368
    function function_827a387() {
        setdvar("tank_flame_zombie", "tank_flame_zombie");
        adddebugcommand("tank_flame_zombie");
        level flag::wait_till("tank_flame_zombie");
        a_spots = struct::get_array("tank_flame_zombie", "tank_flame_zombie");
        while (true) {
            if (getdvarstring("tank_flame_zombie") == "tank_flame_zombie") {
                if (!(isdefined(self.var_825b8f41) && self.var_825b8f41)) {
                    foreach (var_dcf46be5 in self.var_6e2951f7) {
                        self thread function_555487f3(var_dcf46be5);
                    }
                    self.var_825b8f41 = 1;
                }
                ang = self.angles;
                foreach (s_spot in a_spots) {
                    org = self function_6fb42d68(s_spot);
                    box(org, (-4, -4, 0), (4, 4, 4), ang[1], (128, 128, 0), 1, 0, 1);
                }
                a_zombies = zombie_utility::get_round_enemy_array();
                foreach (e_zombie in a_zombies) {
                    if (isdefined(e_zombie.var_d571251b)) {
                        print3d(e_zombie.origin + (0, 0, 60), e_zombie.var_d571251b, (255, 0, 0), 1);
                    }
                }
            }
            wait(0.05);
        }
    }

#/

// Namespace namespace_e6d36abe
// Params 1, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_a4c84b21
// Checksum 0xe418d3f8, Offset: 0x1718
// Size: 0x104
function function_a4c84b21(s_pos) {
    v_up = anglestoup(self.angles);
    v_right = anglestoright(self.angles);
    v_fwd = anglestoforward(self.angles);
    offset = s_pos.origin - self.origin;
    s_pos.var_a0ef11ed = (vectordot(v_fwd, offset), vectordot(v_right, offset), vectordot(v_up, offset));
}

// Namespace namespace_e6d36abe
// Params 1, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_6fb42d68
// Checksum 0x73325f26, Offset: 0x1828
// Size: 0xd6
function function_6fb42d68(s_pos) {
    v_up = anglestoup(self.angles);
    v_right = anglestoright(self.angles);
    v_fwd = anglestoforward(self.angles);
    v_offset = s_pos.var_a0ef11ed;
    return self.origin + v_offset[0] * v_fwd + v_offset[1] * v_right + v_offset[2] * v_up;
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_1b39cea3
// Checksum 0x31a4d091, Offset: 0x1908
// Size: 0x714
function function_1b39cea3() {
    self flag::init("tank_moving");
    self flag::init("tank_activated");
    self flag::init("tank_cooldown");
    level.var_3b74e3e5 = 0;
    self.var_cad9541a = [];
    self.health = 1000;
    self.var_dc8e0f0a = 0;
    self.var_e7f37e6e = 0;
    self hidepart("tag_flamethrower");
    self setmovingplatformenabled(1);
    self.var_c2ce8fff = getent("vol_on_tank_watch", "targetname");
    self.var_c2ce8fff enablelinkto();
    self.var_c2ce8fff linkto(self);
    self.var_4da798ac = spawn("trigger_box", (-8192, -3955.5, -112), 0, 96, 41.5, 52.5);
    self.var_4da798ac enablelinkto();
    self.var_4da798ac linkto(self);
    self.t_use = getent("trig_use_tank", "targetname");
    self.t_use enablelinkto();
    self.t_use linkto(self);
    self.t_use sethintstring(%ZM_TOMB_X2AT, 500);
    self.t_use setcursorhint("HINT_NOICON");
    self.var_5c499e37 = getent("tank_navmesh_cutter", "targetname");
    self.var_5c499e37 enablelinkto();
    self.var_5c499e37 linkto(self);
    self.var_5c499e37 notsolid();
    self.t_hurt = getent("trig_hurt_tank", "targetname");
    self.t_hurt enablelinkto();
    self.t_hurt linkto(self);
    self.var_66ee586a = spawn("trigger_box", (-8192, -4300, 36), 0, -56, -106, 80);
    self.var_66ee586a enablelinkto();
    self.var_66ee586a linkto(self);
    self.var_e444d47d[0] = spawn("trigger_box", (-8280, -3960, 112), 0, 64, 60, 96);
    self.var_e444d47d[0].angles = (0, 90, 0);
    self.var_e444d47d[0] enablelinkto();
    self.var_e444d47d[0] linkto(self);
    self.var_e444d47d[1] = spawn("trigger_box", (-8104, -3960, 112), 0, 64, 60, 96);
    self.var_e444d47d[1].angles = (0, 90, 0);
    self.var_e444d47d[1] enablelinkto();
    self.var_e444d47d[1] linkto(self);
    self.w_flamethrower = getweapon("zombie_markiv_flamethrower");
    var_63d78536 = getent("tank_path_blocker", "targetname");
    var_63d78536 delete();
    var_7d2fab3d = struct::get_array("tank_jump_down_spots", "script_noteworthy");
    foreach (s_spot in var_7d2fab3d) {
        self function_a4c84b21(s_spot);
    }
    self thread function_40621d42();
    self thread function_f464a665();
    self thread function_c9714eb4();
    self thread function_617c74cb();
    self thread function_3b3f9c38();
    self thread function_3636ae3f();
    self thread function_cb8ffe75();
    self thread function_c0bd714b();
    self thread function_118e38b5();
    self thread function_f1e1f205();
    /#
        self thread function_827a387();
    #/
    self playloopsound("zmb_tank_idle", 0.5);
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_c9714eb4
// Checksum 0x44384f02, Offset: 0x2028
// Size: 0x144
function function_c9714eb4() {
    self endon(#"death");
    level flag::wait_till("start_zombie_round_logic");
    do {
        for (tag_index = 0; tag_index < self.var_6e2951f7.size; tag_index++) {
            tag_origin = self gettagorigin(self.var_6e2951f7[tag_index].str_tag);
            queryresult = positionquery_source_navigation(tag_origin, 0, 32, -128, 4);
            if (queryresult.data.size) {
                result = queryresult.data[0];
                self.var_6e2951f7[tag_index].var_a6e72e82 = result.origin;
            }
        }
        self flag::wait_till("tank_moving");
        wait(0.05);
    } while (true);
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_617c74cb
// Checksum 0x5999e775, Offset: 0x2178
// Size: 0x15c
function function_617c74cb() {
    self endon(#"death");
    level flag::wait_till("start_zombie_round_logic");
    do {
        for (tag_index = 0; tag_index < self.var_64ba8680.size; tag_index++) {
            tag_origin = self gettagorigin(self.var_64ba8680[tag_index].str_tag);
            queryresult = positionquery_source_navigation(tag_origin, 0, 32, -128, 4);
            if (queryresult.data.size) {
                result = queryresult.data[0];
                self.var_64ba8680[tag_index].var_a6e72e82 = result.origin;
            }
        }
        self flag::wait_till("tank_moving");
        self flag::wait_till_clear("tank_moving");
    } while (true);
}

// Namespace namespace_e6d36abe
// Params 1, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_1db98f69
// Checksum 0x9ca331f6, Offset: 0x22e0
// Size: 0xa4
function function_1db98f69(tag_name) {
    foreach (tag_struct in self.var_6e2951f7) {
        if (tag_struct.str_tag == tag_name) {
            return tag_struct.var_a6e72e82;
        }
    }
    return undefined;
}

// Namespace namespace_e6d36abe
// Params 1, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_21d81b2c
// Checksum 0xc045d631, Offset: 0x2390
// Size: 0xa4
function function_21d81b2c(tag_name) {
    foreach (tag_struct in self.var_64ba8680) {
        if (tag_struct.str_tag == tag_name) {
            return tag_struct.var_a6e72e82;
        }
    }
    return undefined;
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_c0bd714b
// Checksum 0x7434dae9, Offset: 0x2440
// Size: 0xf8
function function_c0bd714b() {
    self endon(#"death");
    level flag::wait_till("start_zombie_round_logic");
    while (true) {
        self clientfield::set("tank_cooldown_fx", 2);
        self flag::wait_till("tank_moving");
        self clientfield::set("tank_cooldown_fx", 0);
        self flag::wait_till("tank_cooldown");
        self clientfield::set("tank_cooldown_fx", 1);
        self flag::wait_till_clear("tank_cooldown");
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_cb8ffe75
// Checksum 0x8f1a1ced, Offset: 0x2540
// Size: 0x98
function function_cb8ffe75() {
    self endon(#"death");
    while (true) {
        self flag::wait_till("tank_moving");
        self clientfield::set("tank_tread_fx", 1);
        self flag::wait_till_clear("tank_moving");
        self clientfield::set("tank_tread_fx", 0);
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_118e38b5
// Checksum 0x977ee6f4, Offset: 0x25e0
// Size: 0xa0
function function_118e38b5() {
    self endon(#"death");
    self vehicle::lights_off();
    while (true) {
        self flag::wait_till("tank_moving");
        self vehicle::lights_on();
        self flag::wait_till_clear("tank_moving");
        self vehicle::lights_off();
    }
}

// Namespace namespace_e6d36abe
// Params 1, eflags: 0x0
// namespace_e6d36abe<file_0>::function_1a4e96ac
// Checksum 0xada032f4, Offset: 0x2688
// Size: 0x88
function function_1a4e96ac(var_f793f80e) {
    self endon(#"death");
    while (true) {
        self disconnectpaths();
        wait(1);
        while (var_f793f80e getspeedmph() < 1) {
            wait(0.05);
        }
        self connectpaths();
        wait(0.5);
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_ca9fc4e1
// Checksum 0x649f6b6d, Offset: 0x2718
// Size: 0x94
function function_ca9fc4e1() {
    while (self.var_d9cb04f7) {
        if (level.var_f793f80e flag::get("tank_moving")) {
            self clientfield::set_to_player("player_rumble_and_shake", 6);
        } else {
            self clientfield::set_to_player("player_rumble_and_shake", 0);
        }
        wait(1);
    }
    self clientfield::set_to_player("player_rumble_and_shake", 0);
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_40621d42
// Checksum 0x996d8f02, Offset: 0x27b8
// Size: 0x330
function function_40621d42() {
    level flag::wait_till("start_zombie_round_logic");
    self thread function_e70ea25f();
    while (true) {
        a_players = getplayers();
        foreach (e_player in a_players) {
            if (zombie_utility::is_player_valid(e_player)) {
                if (isdefined(e_player.var_d9cb04f7) && !e_player.var_d9cb04f7 && e_player function_45560bd3()) {
                    e_player.var_d9cb04f7 = 1;
                    self.var_dc8e0f0a++;
                    if (self flag::get("tank_cooldown")) {
                        level notify(#"hash_9983eddf", e_player);
                    }
                    e_player thread function_ca9fc4e1();
                    e_player thread function_70820281();
                    e_player thread function_9b7647b2();
                    foreach (trig in self.var_e444d47d) {
                        e_player thread function_de2a4a6e(trig);
                    }
                    e_player allowcrouch(1);
                    e_player allowprone(0);
                    continue;
                }
                if (isdefined(e_player.var_d9cb04f7) && e_player.var_d9cb04f7 && !e_player function_45560bd3()) {
                    e_player.var_d9cb04f7 = 0;
                    self.var_dc8e0f0a--;
                    level notify(#"hash_bce4d0df", e_player);
                    e_player notify(#"hash_94496f13");
                    e_player clientfield::set_to_player("player_rumble_and_shake", 0);
                    e_player allowprone(1);
                }
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_9b7647b2
// Checksum 0x72ad89cd, Offset: 0x2af0
// Size: 0x5c
function function_9b7647b2() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    wait(1);
    if ("prone" == self getstance()) {
        self setstance("crouch");
    }
}

// Namespace namespace_e6d36abe
// Params 1, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_de2a4a6e
// Checksum 0x3b4fdc7b, Offset: 0x2b58
// Size: 0xb0
function function_de2a4a6e(trig) {
    self endon(#"hash_94496f13");
    while (self.var_d9cb04f7) {
        player = trig waittill(#"trigger");
        if (player == self && self isonground()) {
            var_26e0d148 = anglestoforward(trig.angles) * -106;
            self setvelocity(var_26e0d148);
        }
        wait(0.05);
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_70820281
// Checksum 0xc68f00da, Offset: 0x2c10
// Size: 0xe2
function function_70820281() {
    self endon(#"hash_3f7b661c");
    self endon(#"hash_94496f13");
    if (level.var_f793f80e flag::get("tank_moving")) {
        level.var_f793f80e flag::wait_till_clear("tank_moving");
    }
    var_c8e3d0bd = level.var_f793f80e.var_7b2c69d2;
    do {
        level.var_f793f80e flag::wait_till("tank_moving");
        level.var_f793f80e flag::wait_till_clear("tank_moving");
    } while (var_c8e3d0bd != level.var_f793f80e.var_7b2c69d2);
    self notify(#"hash_e0809b23");
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_45560bd3
// Checksum 0x8fcf0e4b, Offset: 0x2d00
// Size: 0xa0
function function_45560bd3() {
    if (self istouching(level.var_f793f80e.var_c2ce8fff) || !self isonground() && self istouching(level.var_f793f80e.var_4da798ac)) {
        return true;
    }
    if (self getgroundent() === level.var_f793f80e) {
        return true;
    }
    return false;
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_3b3f9c38
// Checksum 0x22a3643f, Offset: 0x2da8
// Size: 0x104
function function_3b3f9c38() {
    self thread function_bcaa0e31();
    self thread function_ca9f131b();
    var_54477b4f = getentarray("trig_tank_station_call", "targetname");
    foreach (var_6ab5703c in var_54477b4f) {
        var_6ab5703c thread function_533f65ea();
    }
    self.t_use waittill(#"trigger");
    level.var_3b74e3e5 = 1;
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_df7c40b6
// Checksum 0x390023b2, Offset: 0x2eb8
// Size: 0x2a4
function function_df7c40b6() {
    wait(4);
    var_953c5f4c = 1000000;
    var_24d7985e = function_6e2be6b3(1);
    if (var_24d7985e.size == 0) {
        return;
    }
    var_eb2993cb = array::random(var_24d7985e);
    a_players = getplayers();
    var_1f1eb09c = [];
    var_4ad2403a = anglestoforward(self.angles);
    foreach (e_player in a_players) {
        if (isdefined(e_player.var_d9cb04f7) && e_player.var_d9cb04f7) {
            continue;
        }
        if (distance2dsquared(e_player.origin, self.origin) > var_953c5f4c) {
            continue;
        }
        var_d0160572 = self.origin - e_player.origin;
        var_d0160572 = vectornormalize(var_d0160572);
        if (vectordot(var_d0160572, var_4ad2403a) < 0) {
            continue;
        }
        var_46ff2245 = anglestoforward(e_player.angles);
        if (vectordot(var_46ff2245, var_d0160572) < 0) {
            continue;
        }
        var_1f1eb09c[var_1f1eb09c.size] = e_player;
    }
    if (var_1f1eb09c.size == 0) {
        return;
    }
    e_victim = array::random(var_1f1eb09c);
    namespace_ad52727b::function_51722ebc(e_victim, var_eb2993cb);
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_bcaa0e31
// Checksum 0x4ada75e, Offset: 0x3168
// Size: 0x1a0
function function_bcaa0e31() {
    while (true) {
        e_player = self.t_use waittill(#"trigger");
        cooling_down = self flag::get("tank_cooldown");
        if (zombie_utility::is_player_valid(e_player) && e_player.score >= 500 && !cooling_down) {
            self flag::set("tank_activated");
            self flag::set("tank_moving");
            e_player thread zm_audio::create_and_play_dialog("tank", "tank_buy");
            self thread function_df7c40b6();
            e_player zm_score::minus_to_player_score(500);
            self waittill(#"hash_2e1a3004");
            self playsound("zmb_tank_stop");
            self stoploopsound(1.5);
            if (isdefined(self.var_b38be96a) && self.var_b38be96a) {
                self.var_b38be96a = 0;
                self function_25e62cfc();
            }
        }
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_25e62cfc
// Checksum 0xb057ceb3, Offset: 0x3310
// Size: 0xa8
function function_25e62cfc() {
    self endon(#"hash_78fa5bd9");
    self.var_2c441a07 = 1;
    wait(0.05);
    self flag::wait_till_clear("tank_cooldown");
    e_player = self.t_use waittill(#"trigger");
    self flag::set("tank_activated");
    self flag::set("tank_moving");
    self.var_2c441a07 = 0;
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_533f65ea
// Checksum 0x22e77461, Offset: 0x33c0
// Size: 0x19a
function function_533f65ea() {
    while (true) {
        e_player = self waittill(#"trigger");
        cooling_down = level.var_f793f80e flag::get("tank_cooldown");
        if (!level.var_f793f80e flag::get("tank_activated") && e_player.score >= 500 && !cooling_down) {
            level.var_f793f80e notify(#"hash_78fa5bd9");
            level.var_f793f80e.var_b38be96a = 1;
            e_switch = getent(self.target, "targetname");
            self setinvisibletoall();
            wait(0.05);
            e_switch rotatepitch(-180, 0.5);
            e_switch waittill(#"rotatedone");
            e_switch rotatepitch(-76, 0.5);
            level.var_f793f80e.t_use useby(e_player);
            level.var_f793f80e waittill(#"hash_2e1a3004");
        }
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_f39f954e
// Checksum 0x31bea109, Offset: 0x3568
// Size: 0x252
function function_f39f954e() {
    str_loc = level.var_f793f80e.var_7b2c69d2;
    a_trigs = getentarray("trig_tank_station_call", "targetname");
    moving = level.var_f793f80e flag::get("tank_moving");
    var_fc4e273a = level.var_f793f80e flag::get("tank_cooldown");
    foreach (trig in a_trigs) {
        var_5fd33dc4 = trig.script_noteworthy == "call_box_" + str_loc;
        trig setcursorhint("HINT_NOICON");
        if (moving) {
            trig setvisibletoall();
            trig sethintstring(%ZM_TOMB_TNKM);
            continue;
        }
        if (!level.var_3b74e3e5 || var_5fd33dc4) {
            trig setinvisibletoall();
            continue;
        }
        if (var_fc4e273a) {
            trig setvisibletoall();
            trig sethintstring(%ZM_TOMB_TNKC);
            continue;
        }
        trig setvisibletoall();
        trig sethintstring(%ZM_TOMB_X2CT, 500);
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_ca9f131b
// Checksum 0xce6a130e, Offset: 0x37c8
// Size: 0x420
function function_ca9f131b() {
    n_path_start = getvehiclenode("tank_start", "targetname");
    self.origin = n_path_start.origin;
    self.angles = n_path_start.angles;
    self.var_78665041 = 0;
    self.a_locations = array("village", "bunkers");
    var_93c52a20 = 0;
    self.var_7b2c69d2 = self.a_locations[var_93c52a20];
    function_f39f954e();
    while (true) {
        self flag::wait_till("tank_activated");
        if (!self.var_78665041) {
            self.var_78665041 = 1;
            self attachpath(n_path_start);
            self startpath();
            self thread follow_path(n_path_start);
            self setspeedimmediate(0);
        }
        /#
            iprintln("tank_flame_zombie");
        #/
        self thread function_770e9a03();
        self playsound("evt_tank_call");
        self setspeedimmediate(8);
        self.t_use setinvisibletoall();
        function_f39f954e();
        self thread function_65714b87();
        self thread function_8056205();
        self waittill(#"hash_2e1a3004");
        self flag::set("tank_cooldown");
        self.t_use setvisibletoall();
        self.t_use sethintstring(%ZM_TOMB_TNKC);
        self flag::clear("tank_moving");
        self thread function_e70ea25f();
        self setspeedimmediate(0);
        var_93c52a20++;
        if (var_93c52a20 == self.a_locations.size) {
            var_93c52a20 = 0;
        }
        self.var_7b2c69d2 = self.a_locations[var_93c52a20];
        function_f39f954e();
        self function_511bf02b();
        self flag::clear("tank_cooldown");
        if (isdefined(self.var_2c441a07) && self.var_2c441a07) {
            self.t_use sethintstring(%ZM_TOMB_X2ATF);
        } else {
            self.t_use sethintstring(%ZM_TOMB_X2AT, 500);
        }
        self.t_use setcursorhint("HINT_NOICON");
        self flag::clear("tank_activated");
        function_f39f954e();
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_e70ea25f
// Checksum 0x96d977eb, Offset: 0x3bf0
// Size: 0x54
function function_e70ea25f() {
    self endon(#"death");
    while (self getspeedmph() > 0) {
        wait(0.05);
    }
    self.var_5c499e37 disconnectpaths();
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_770e9a03
// Checksum 0x2a167201, Offset: 0x3c50
// Size: 0x24
function function_770e9a03() {
    self endon(#"death");
    self.var_5c499e37 connectpaths();
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_65714b87
// Checksum 0x1693591a, Offset: 0x3c80
// Size: 0x134
function function_65714b87() {
    self endon(#"hash_4dd55e77");
    foreach (player in level.players) {
        player.var_32857832 = 0;
    }
    while (true) {
        player = self.var_66ee586a waittill(#"trigger");
        if (!(isdefined(player.var_d9cb04f7) && player.var_d9cb04f7) && !(isdefined(player.var_d0cd73ec) && player.var_d0cd73ec)) {
            player thread function_839ecd19();
            wait(0.05);
            continue;
        }
        player.var_32857832 = 0;
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_839ecd19
// Checksum 0x4129078, Offset: 0x3dc0
// Size: 0x2fe
function function_839ecd19() {
    self.var_32857832++;
    if (self.var_32857832 < 20) {
        self dodamage(5, self.origin);
        return;
    }
    self.var_d0cd73ec = 1;
    self disableinvulnerability();
    self dodamage(self.health + 1000, self.origin);
    a_nodes = getnodesinradiussorted(self.origin, 256, 0, 72, "path", 15);
    foreach (node in a_nodes) {
        str_zone = zm_zonemgr::get_zone_from_position(node.origin);
        if (!isdefined(str_zone)) {
            continue;
        }
        if (!(isdefined(node.var_8b915eba) && node.var_8b915eba)) {
            var_bd0b4e79 = 0;
            var_b43c0f4b = 4;
            fade_in_time = 0.01;
            fade_out_time = 0.2;
            self thread hud::fade_to_black_for_x_sec(var_bd0b4e79, var_b43c0f4b, fade_in_time, fade_out_time, "black");
            node.var_8b915eba = 1;
            var_e0d020c4 = spawn("script_origin", self.origin);
            self playerlinkto(var_e0d020c4);
            var_e0d020c4 moveto(node.origin + (0, 0, 8), 1);
            var_e0d020c4 function_c21df674(self);
            node.var_8b915eba = undefined;
            var_e0d020c4 delete();
            self.var_d0cd73ec = undefined;
            return;
        }
    }
    self.var_d0cd73ec = undefined;
}

// Namespace namespace_e6d36abe
// Params 1, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_c21df674
// Checksum 0x859f9844, Offset: 0x40c8
// Size: 0x34
function function_c21df674(player) {
    player endon(#"disconnect");
    wait(4);
    self unlink();
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_8056205
// Checksum 0x8e40fcf7, Offset: 0x4108
// Size: 0xcc
function function_8056205() {
    self.n_cooldown_timer = 0;
    var_63412232 = self.var_7b2c69d2;
    self playsound("zmb_tank_start");
    self stoploopsound(0.4);
    wait(0.4);
    self playloopsound("zmb_tank_loop", 1);
    while (var_63412232 == self.var_7b2c69d2) {
        self.n_cooldown_timer += self.var_dc8e0f0a * 0.05;
        wait(0.05);
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_511bf02b
// Checksum 0x66fb1fe3, Offset: 0x41e0
// Size: 0xbc
function function_511bf02b() {
    self thread function_3abecc05();
    if (self.n_cooldown_timer < 2) {
        self.n_cooldown_timer = 2;
    } else if (self.n_cooldown_timer > 120) {
        self.n_cooldown_timer = 120;
    }
    wait(self.n_cooldown_timer);
    level notify(#"hash_cf7d3cce");
    self playsound("zmb_tank_ready");
    self playloopsound("zmb_tank_idle");
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_3abecc05
// Checksum 0x99d2cf5e, Offset: 0x42a8
// Size: 0xfc
function function_3abecc05() {
    var_281398a = spawn("script_origin", self.origin);
    var_281398a linkto(self);
    wait(4);
    var_281398a playsound("zmb_tank_fuel_start");
    wait(0.5);
    var_281398a playloopsound("zmb_tank_fuel_loop");
    level waittill(#"hash_cf7d3cce");
    var_281398a stoploopsound(0.5);
    var_281398a playsound("zmb_tank_fuel_end");
    wait(2);
    var_281398a delete();
}

// Namespace namespace_e6d36abe
// Params 1, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_3831a720
// Checksum 0x6a064331, Offset: 0x43b0
// Size: 0x16c
function follow_path(n_path_start) {
    self endon(#"death");
    assert(isdefined(n_path_start), "tank_flame_zombie");
    self notify(#"newpath");
    self endon(#"newpath");
    var_69af9c08 = n_path_start;
    while (isdefined(var_69af9c08)) {
        self.var_8d7245f6 = getvehiclenode(var_69af9c08.target, "targetname");
        var_69af9c08 = self waittill(#"reached_node");
        if (isdefined(var_69af9c08.script_noteworthy) && issubstr(var_69af9c08.script_noteworthy, "fxexp")) {
            exploder::exploder(var_69af9c08.script_noteworthy);
        }
        self.n_current = var_69af9c08;
        var_69af9c08 notify(#"trigger", self);
        if (isdefined(var_69af9c08.script_noteworthy)) {
            self notify(var_69af9c08.script_noteworthy);
            self notify(#"noteworthy", var_69af9c08.script_noteworthy, var_69af9c08);
        }
        waittillframeend();
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_28852598
// Checksum 0x18a250b9, Offset: 0x4528
// Size: 0x448
function function_28852598() {
    var_6e2951f7 = [];
    var_6e2951f7[0] = spawnstruct();
    var_6e2951f7[0].str_tag = "window_left_1_jmp_jnt";
    var_6e2951f7[0].var_4edfd5b9 = 1;
    var_6e2951f7[0].var_87346297 = 1;
    var_6e2951f7[0].side = "left";
    var_6e2951f7[0].var_bd6a9142 = "_markiv_leftfront";
    var_6e2951f7[1] = spawnstruct();
    var_6e2951f7[1].str_tag = "window_left_2_jmp_jnt";
    var_6e2951f7[1].var_4edfd5b9 = 1;
    var_6e2951f7[1].var_87346297 = 1;
    var_6e2951f7[1].side = "left";
    var_6e2951f7[1].var_bd6a9142 = "_markiv_leftmid";
    var_6e2951f7[2] = spawnstruct();
    var_6e2951f7[2].str_tag = "window_left_3_jmp_jnt";
    var_6e2951f7[2].var_4edfd5b9 = 1;
    var_6e2951f7[2].var_87346297 = 1;
    var_6e2951f7[2].side = "left";
    var_6e2951f7[2].var_bd6a9142 = "_markiv_leftrear";
    var_6e2951f7[3] = spawnstruct();
    var_6e2951f7[3].str_tag = "window_right_front_jmp_jnt";
    var_6e2951f7[3].side = "front";
    var_6e2951f7[3].var_bd6a9142 = "_markiv_front";
    var_6e2951f7[4] = spawnstruct();
    var_6e2951f7[4].str_tag = "window_right_1_jmp_jnt";
    var_6e2951f7[4].side = "right";
    var_6e2951f7[4].var_bd6a9142 = "_markiv_rightfront";
    var_6e2951f7[5] = spawnstruct();
    var_6e2951f7[5].str_tag = "window_right_2_jmp_jnt";
    var_6e2951f7[5].var_87346297 = 1;
    var_6e2951f7[5].side = "right";
    var_6e2951f7[5].var_bd6a9142 = "_markiv_rightmid";
    var_6e2951f7[6] = spawnstruct();
    var_6e2951f7[6].str_tag = "window_right_3_jmp_jnt";
    var_6e2951f7[6].var_87346297 = 1;
    var_6e2951f7[6].side = "right";
    var_6e2951f7[6].var_bd6a9142 = "_markiv_rightrear";
    var_6e2951f7[7] = spawnstruct();
    var_6e2951f7[7].str_tag = "window_left_rear_jmp_jnt";
    var_6e2951f7[7].side = "rear";
    var_6e2951f7[7].var_bd6a9142 = "_markiv_rear";
    return var_6e2951f7;
}

// Namespace namespace_e6d36abe
// Params 1, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_6e2be6b3
// Checksum 0xddf7fc78, Offset: 0x4978
// Size: 0x1a4
function function_6e2be6b3(var_543e79db) {
    if (!isdefined(var_543e79db)) {
        var_543e79db = 0;
    }
    var_aa1b6986 = [];
    a_players = getplayers();
    foreach (e_player in a_players) {
        if (isdefined(e_player.var_d9cb04f7) && zombie_utility::is_player_valid(e_player) && e_player.var_d9cb04f7) {
            if (!(isdefined(e_player.ignoreme) && e_player.ignoreme) && (!var_543e79db || zombie_utility::is_player_valid(e_player))) {
                if (!isdefined(var_aa1b6986)) {
                    var_aa1b6986 = [];
                } else if (!isarray(var_aa1b6986)) {
                    var_aa1b6986 = array(var_aa1b6986);
                }
                var_aa1b6986[var_aa1b6986.size] = e_player;
            }
        }
    }
    return var_aa1b6986;
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_3658b28d
// Checksum 0x20ad0f7d, Offset: 0x4b28
// Size: 0x1a2
function function_3658b28d() {
    var_64ba8680 = [];
    var_64ba8680[0] = spawnstruct();
    var_64ba8680[0].str_tag = "tag_mechz_1";
    var_64ba8680[0].in_use = 0;
    var_64ba8680[0].var_f348861c = undefined;
    var_64ba8680[1] = spawnstruct();
    var_64ba8680[1].str_tag = "tag_mechz_2";
    var_64ba8680[1].in_use = 0;
    var_64ba8680[1].var_f348861c = undefined;
    var_64ba8680[2] = spawnstruct();
    var_64ba8680[2].str_tag = "tag_mechz_3";
    var_64ba8680[2].in_use = 0;
    var_64ba8680[2].var_f348861c = undefined;
    var_64ba8680[3] = spawnstruct();
    var_64ba8680[3].str_tag = "tag_mechz_4";
    var_64ba8680[3].in_use = 0;
    var_64ba8680[3].var_f348861c = undefined;
    return var_64ba8680;
}

// Namespace namespace_e6d36abe
// Params 2, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_9a1c451c
// Checksum 0xf421959, Offset: 0x4cd8
// Size: 0x8e
function function_9a1c451c(mechz, var_f8ded078) {
    mechz notify(#"hash_5dfa1c25");
    mechz util::waittill_any_timeout(30, "death", "kill_ft", "tank_flamethrower_attack_complete", "kill_mechz_tag_in_use_cleanup");
    self.var_64ba8680[var_f8ded078].in_use = 0;
    self.var_64ba8680[var_f8ded078].var_f348861c = undefined;
}

// Namespace namespace_e6d36abe
// Params 2, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_c4c3061f
// Checksum 0xbba25d5f, Offset: 0x4d70
// Size: 0x256
function function_c4c3061f(mechz, target_org) {
    best_dist = -1;
    var_4dcee627 = undefined;
    for (i = 0; i < self.var_64ba8680.size; i++) {
        if (self.var_64ba8680[i].in_use && self.var_64ba8680[i].var_f348861c != mechz) {
            continue;
        }
        var_dcf46be5 = self.var_64ba8680[i];
        var_fcf83d34 = self gettagorigin(var_dcf46be5.str_tag);
        dist = distancesquared(var_fcf83d34, target_org);
        if (dist < best_dist || best_dist < 0) {
            best_dist = dist;
            var_4dcee627 = i;
        }
    }
    if (isdefined(var_4dcee627)) {
        for (i = 0; i < self.var_64ba8680.size; i++) {
            if (self.var_64ba8680[i].in_use && self.var_64ba8680[i].var_f348861c == mechz) {
                self.var_64ba8680[i].in_use = 0;
                self.var_64ba8680[i].var_f348861c = undefined;
            }
        }
        self.var_64ba8680[var_4dcee627].in_use = 1;
        self.var_64ba8680[var_4dcee627].var_f348861c = mechz;
        self thread function_9a1c451c(mechz, var_4dcee627);
        return self.var_64ba8680[var_4dcee627].str_tag;
    }
    return undefined;
}

// Namespace namespace_e6d36abe
// Params 2, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_c8b1de2c
// Checksum 0x4539bd2, Offset: 0x4fd0
// Size: 0x1b2
function function_c8b1de2c(var_dcf46be5, var_4fbaa8da) {
    if (!isdefined(var_4fbaa8da)) {
        var_4fbaa8da = 0;
    }
    if (var_4fbaa8da) {
        if (var_dcf46be5.side == "right" || var_dcf46be5.side == "left") {
            return false;
        }
    }
    if (self flag::get("tank_moving")) {
        if (var_dcf46be5.side == "front") {
            return false;
        }
        if (!isdefined(self.var_8d7245f6)) {
            return true;
        }
        if (!isdefined(self.var_8d7245f6.script_string)) {
            return true;
        }
        if (issubstr(self.var_8d7245f6.script_string, "disable_" + var_dcf46be5.side)) {
            return false;
        } else {
            return true;
        }
    }
    var_90807f8 = self.var_7b2c69d2 == "village";
    var_71411f6 = self.var_7b2c69d2 == "bunkers";
    if (var_90807f8) {
        return !(isdefined(var_dcf46be5.var_87346297) && var_dcf46be5.var_87346297);
    } else if (var_71411f6) {
        return !(isdefined(var_dcf46be5.var_4edfd5b9) && var_dcf46be5.var_4edfd5b9);
    }
    return true;
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_f464a665
// Checksum 0xe6e8d67d, Offset: 0x5190
// Size: 0x128
function function_f464a665() {
    var_6e2951f7 = function_28852598();
    self.var_6e2951f7 = var_6e2951f7;
    var_64ba8680 = function_3658b28d();
    self.var_64ba8680 = var_64ba8680;
    while (true) {
        a_zombies = zombie_utility::get_round_enemy_array();
        foreach (e_zombie in a_zombies) {
            if (!isdefined(e_zombie.var_d571251b)) {
                e_zombie thread function_35098f9f();
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_6aa99524
// Checksum 0x84933793, Offset: 0x52c0
// Size: 0x14
function function_6aa99524() {
    self.var_d571251b = "tank_chase";
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_b9521456
// Checksum 0xa3ffb19a, Offset: 0x52e0
// Size: 0x7c
function function_b9521456() {
    self.var_d571251b = "none";
    self.var_6989fa90 = undefined;
    self.var_69140779 = undefined;
    self.var_6dec0164 = undefined;
    self.var_326bf116 = 0;
    self.var_b6541c64 = undefined;
    self notify(#"hash_37c67885");
    if (isdefined(self.var_ad16df15)) {
        self zombie_utility::set_zombie_run_cycle(self.var_ad16df15);
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_e834a922
// Checksum 0x9836ca53, Offset: 0x5368
// Size: 0x88
function function_e834a922() {
    var_dcf46be5 = self function_8e2136ba();
    if (isdefined(var_dcf46be5)) {
        self.var_6989fa90 = var_dcf46be5.str_tag;
        self.var_69140779 = var_dcf46be5.var_bd6a9142;
        self.var_6dec0164 = var_dcf46be5;
        self.var_d571251b = "tag_chase";
        return;
    }
    wait(1);
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_407dee83
// Checksum 0xccc98fd7, Offset: 0x53f8
// Size: 0xf8
function function_407dee83() {
    var_dcf46be5 = self function_8e2136ba(1);
    if (isdefined(var_dcf46be5)) {
        self.var_6989fa90 = var_dcf46be5.str_tag;
        self.var_69140779 = var_dcf46be5.var_bd6a9142;
        self.var_6dec0164 = struct::get(var_dcf46be5.str_tag + "_down_start", "targetname");
        self.var_d571251b = "exit_tank";
        self zombie_utility::set_zombie_run_cycle("walk");
        assert(isdefined(self.var_6dec0164));
        return;
    }
    wait(1);
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_be0c2249
// Checksum 0xa91d041d, Offset: 0x54f8
// Size: 0x204
function function_be0c2249() {
    self endon(#"death");
    self.var_d571251b = "climbing";
    self.var_326bf116 = 1;
    str_tag = self.var_6989fa90;
    var_b788969e = self.var_69140779;
    self linkto(level.var_f793f80e, str_tag);
    v_tag_origin = level.var_f793f80e gettagorigin(str_tag);
    v_tag_angles = level.var_f793f80e gettagangles(str_tag);
    var_b3dee3e3 = "_jump_up" + var_b788969e;
    if (level.var_f793f80e flag::get("tank_moving") && str_tag == "window_left_rear_jmp_jnt") {
        var_b3dee3e3 = "_jump_up_onto_markiv_rear";
    }
    if (self.missinglegs) {
        var_b3dee3e3 = "_crawl" + var_b3dee3e3;
    }
    self.var_27ea7da4 = 1;
    self animscripted("climb_up_tank_anim", v_tag_origin, v_tag_angles, "ai_zm_dlc5_zombie" + var_b3dee3e3);
    self zombie_shared::donotetracks("climb_up_tank_anim");
    self unlink();
    self.var_27ea7da4 = 0;
    level.var_f793f80e function_9a160ef1(str_tag, self, 0);
    self function_be6f5af7();
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_be6f5af7
// Checksum 0x735fbcbc, Offset: 0x5708
// Size: 0x34
function function_be6f5af7() {
    self setgoalpos(self.origin);
    self.var_d571251b = "on_tank";
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_e42c4609
// Checksum 0x156f5f48, Offset: 0x5748
// Size: 0x1dc
function function_e42c4609() {
    self endon(#"death");
    self.var_d571251b = "jumping_down";
    str_tag = self.var_6989fa90;
    var_b788969e = self.var_69140779;
    self linkto(level.var_f793f80e, str_tag);
    v_tag_origin = level.var_f793f80e gettagorigin(str_tag);
    v_tag_angles = level.var_f793f80e gettagangles(str_tag);
    self setgoalpos(v_tag_origin);
    var_b3dee3e3 = "_jump_down" + var_b788969e;
    if (self.missinglegs) {
        var_b3dee3e3 = "_crawl" + var_b3dee3e3;
    }
    self.var_27ea7da4 = 1;
    self animscripted("climb_down_tank_anim", v_tag_origin, v_tag_angles, "ai_zm_dlc5_zombie" + var_b3dee3e3);
    self zombie_shared::donotetracks("climb_down_tank_anim");
    self unlink();
    self.var_27ea7da4 = 0;
    level.var_f793f80e function_9a160ef1(str_tag, self, 0);
    self.var_ec99c074 = 0;
    function_b9521456();
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_c089a07a
// Checksum 0xb22019ab, Offset: 0x5930
// Size: 0xd8
function function_c089a07a() {
    self endon(#"death");
    while (true) {
        if (self.var_d571251b == "on_tank" || self.var_d571251b == "exit_tank") {
            if (!self function_45560bd3()) {
                function_b9521456();
            }
            wait(0.5);
        } else if (self.var_d571251b == "none") {
            if (self function_45560bd3()) {
                self function_be6f5af7();
            }
            wait(5);
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_e6d36abe
// Params 4, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_abec9ef
// Checksum 0x193bac97, Offset: 0x5a10
// Size: 0x7e
function function_abec9ef(v1, v2, range, var_5eef24ab) {
    if (abs(v1[2] - v2[2]) > var_5eef24ab) {
        return false;
    }
    return distance2dsquared(v1, v2) < range * range;
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_35098f9f
// Checksum 0x3cd77fcd, Offset: 0x5a98
// Size: 0x7f0
function function_35098f9f() {
    self endon(#"death");
    self.var_d571251b = "none";
    self thread function_c089a07a();
    var_32403719 = 0.5;
    while (true) {
        var_aa1b6986 = function_6e2be6b3(1);
        var_e9812a1 = 32;
        if (level.var_f793f80e flag::get("tank_moving")) {
            var_e9812a1 = 64;
        }
        switch (self.var_d571251b) {
        case 98:
            if (!isdefined(self.ai_state) || self.ai_state != "find_flesh") {
                break;
            }
            if (var_aa1b6986.size == 0) {
                break;
            }
            if (zombie_utility::is_player_valid(self.favoriteenemy)) {
                if (isdefined(self.favoriteenemy.var_d9cb04f7) && self.favoriteenemy.var_d9cb04f7) {
                    self function_6aa99524();
                }
            } else {
                a_players = getplayers();
                var_30485495 = [];
                foreach (e_player in a_players) {
                    if (!(isdefined(e_player.ignoreme) && e_player.ignoreme) && zombie_utility::is_player_valid(e_player)) {
                        var_30485495[var_30485495.size] = e_player;
                    }
                }
                if (var_30485495.size > 0) {
                    if (var_aa1b6986.size == a_players.size) {
                        self.favoriteenemy = array::random(var_30485495);
                    } else if (self.var_13ed8adf === level.time) {
                        self.favoriteenemy = namespace_d7c0ce12::function_e046126e(self.origin, var_30485495);
                    } else {
                        self.favoriteenemy = self.var_85a4d178;
                    }
                }
            }
            break;
        case 97:
            if (var_aa1b6986.size == 0) {
                self function_b9521456();
                break;
            }
            var_dddf3fdf = distancesquared(self.origin, level.var_f793f80e.origin);
            if (var_dddf3fdf < 250000) {
                self function_e834a922();
            }
            if (!self.missinglegs && self.zombie_move_speed != "super_sprint" && !(isdefined(self.is_traversing) && self.is_traversing) && self.ai_state == "find_flesh") {
                if (level.var_f793f80e flag::get("tank_moving")) {
                    self zombie_utility::set_zombie_run_cycle("super_sprint");
                    self thread function_cdd7f5a3();
                }
            }
            break;
        case 99:
            if (!isdefined(self.var_b6541c64)) {
                self.var_b6541c64 = 6;
            } else if (self.var_b6541c64 <= 0) {
                if (self function_45560bd3()) {
                    self function_be6f5af7();
                } else {
                    self function_b9521456();
                }
                break;
            }
            self notify(#"hash_5c9b657e");
            if (var_aa1b6986.size == 0) {
                self function_b9521456();
                break;
            }
            var_dddf3fdf = distancesquared(self.origin, level.var_f793f80e.origin);
            if (var_dddf3fdf > 1000000 || var_aa1b6986.size == 0) {
                function_6aa99524();
                break;
            }
            v_tag = level.var_f793f80e gettagorigin(self.var_6989fa90);
            if (self.var_6989fa90 == "window_right_front_jmp_jnt") {
                v_tag = getstartorigin(v_tag, level.var_f793f80e gettagangles(self.var_6989fa90), "ai_zm_dlc5_zombie_jump_up_markiv_front");
            }
            if (function_abec9ef(v_tag, self.origin, var_e9812a1, var_e9812a1)) {
                var_6abcf8f9 = level.var_f793f80e function_9a160ef1(self.var_6989fa90, self, 1);
                if (var_6abcf8f9) {
                    self thread function_be0c2249();
                }
            } else {
                self.var_b6541c64 -= var_32403719;
            }
            break;
        case 103:
            break;
        case 109:
            if (var_aa1b6986.size == 0) {
                function_407dee83();
            } else if (!isdefined(self.favoriteenemy) || !zombie_utility::is_player_valid(self.favoriteenemy, 1)) {
                self.favoriteenemy = array::random(var_aa1b6986);
            }
            break;
        case 101:
            self notify(#"hash_d10ab6fb");
            if (var_aa1b6986.size > 0) {
                self function_be6f5af7();
                break;
            }
            v_tag_pos = level.var_f793f80e function_6fb42d68(self.var_6dec0164);
            if (function_abec9ef(v_tag_pos, self.origin, var_e9812a1, var_e9812a1)) {
                var_6abcf8f9 = level.var_f793f80e function_9a160ef1(self.var_6989fa90, self, 1);
                if (var_6abcf8f9) {
                    self thread function_e42c4609();
                }
            } else {
                wait(1);
            }
            break;
        case 110:
            break;
        }
        wait(var_32403719);
    }
}

// Namespace namespace_e6d36abe
// Params 2, eflags: 0x0
// namespace_e6d36abe<file_0>::function_7c9957ac
// Checksum 0xad068010, Offset: 0x6290
// Size: 0x178
function function_7c9957ac(str_position, stop_notify) {
    self notify(#"hash_37c67885");
    self endon(#"death");
    self endon(#"goal");
    self endon(#"near_goal");
    self endon(#"hash_37c67885");
    if (isdefined(stop_notify)) {
        self endon(stop_notify);
    }
    var_505e4807 = struct::get(str_position, "targetname");
    while (self.var_d571251b != "none") {
        if (isdefined(var_505e4807)) {
            v_origin = level.var_f793f80e function_6fb42d68(var_505e4807);
            /#
                if (getdvarstring("tank_flame_zombie") == "tank_flame_zombie") {
                    line(self.origin + (0, 0, 30), v_origin);
                }
            #/
        } else {
            v_origin = level.var_f793f80e gettagorigin(str_position);
        }
        self setgoalpos(v_origin);
        wait(0.05);
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_cdd7f5a3
// Checksum 0x1bb8d74f, Offset: 0x6410
// Size: 0x64
function function_cdd7f5a3() {
    self notify(#"hash_cd9d6ba0");
    self endon(#"hash_cd9d6ba0");
    self endon(#"death");
    while (!self.missinglegs) {
        wait(0.05);
    }
    self zombie_utility::set_zombie_run_cycle(self.var_ad16df15);
}

// Namespace namespace_e6d36abe
// Params 3, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_9a160ef1
// Checksum 0xa97db503, Offset: 0x6480
// Size: 0x14e
function function_9a160ef1(str_tag, var_c49f4360, var_6fc542ea) {
    var_56745d45 = self.var_cad9541a[str_tag];
    var_d3c4feba = 1024;
    if (var_6fc542ea) {
        if (!isdefined(var_56745d45)) {
            self.var_cad9541a[str_tag] = var_c49f4360;
            return 1;
        } else if (var_c49f4360 == var_56745d45 || !isalive(var_56745d45)) {
            var_751dd4b5 = distance2dsquared(var_c49f4360.origin, self gettagorigin(str_tag));
            if (var_751dd4b5 < var_d3c4feba) {
                self.var_cad9541a[str_tag] = var_c49f4360;
                return 1;
            }
        }
        return 0;
    }
    if (!isdefined(var_56745d45)) {
        return 1;
    }
    if (var_56745d45 != var_c49f4360) {
        return 0;
    }
    self.var_cad9541a[str_tag] = undefined;
    return 1;
}

// Namespace namespace_e6d36abe
// Params 1, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_47897989
// Checksum 0x464d48d9, Offset: 0x65d8
// Size: 0x1aa
function function_47897989(str_tag) {
    v_tag = self gettagorigin(str_tag);
    a_zombies = getaiteamarray(level.zombie_team);
    var_6d256c19 = 0;
    foreach (e_zombie in a_zombies) {
        dist_sq = distancesquared(v_tag, e_zombie.origin);
        if (dist_sq < 4096) {
            if (isdefined(e_zombie.var_d571251b)) {
                if (e_zombie.var_d571251b != "tank_chase" && e_zombie.var_d571251b != "tag_chase" && e_zombie.var_d571251b != "none") {
                    continue;
                }
            }
            var_6d256c19++;
            if (var_6d256c19 >= 4) {
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_e6d36abe
// Params 1, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_8e2136ba
// Checksum 0x2a115e7b, Offset: 0x6790
// Size: 0x1cc
function function_8e2136ba(var_50e2f8a) {
    if (!isdefined(var_50e2f8a)) {
        var_50e2f8a = 0;
    }
    closest_dist_sq = 100000000;
    var_9e9e1807 = undefined;
    var_4fbaa8da = 0;
    if (var_50e2f8a && level.var_f793f80e flag::get("tank_moving")) {
        var_4fbaa8da = 1;
    }
    foreach (var_dcf46be5 in level.var_f793f80e.var_6e2951f7) {
        if (level.var_f793f80e function_c8b1de2c(var_dcf46be5, var_4fbaa8da)) {
            v_tag = level.var_f793f80e gettagorigin(var_dcf46be5.str_tag);
            dist_sq = distancesquared(self.origin, v_tag);
            if (dist_sq < closest_dist_sq) {
                if (!level.var_f793f80e function_47897989(var_dcf46be5.str_tag)) {
                    var_9e9e1807 = var_dcf46be5;
                    closest_dist_sq = dist_sq;
                }
            }
        }
    }
    return var_9e9e1807;
}

// Namespace namespace_e6d36abe
// Params 3, eflags: 0x0
// namespace_e6d36abe<file_0>::function_d58bd8ef
// Checksum 0x7d639831, Offset: 0x6968
// Size: 0x5a
function function_d58bd8ef(var_cd0936e2, chunk, node) {
    self endon(#"death");
    while (true) {
        str_notetrack = self waittill(var_cd0936e2);
        if (str_notetrack == "end") {
            return;
        }
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_3636ae3f
// Checksum 0xe87fbd97, Offset: 0x69d0
// Size: 0x74
function function_3636ae3f() {
    self thread function_1a3d4e6e("tag_flash", 1);
    wait(0.25);
    self thread function_1a3d4e6e("tag_flash_gunner1", 2);
    wait(0.25);
    self thread function_1a3d4e6e("tag_flash_gunner2", 3);
}

// Namespace namespace_e6d36abe
// Params 2, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_7f3b24e0
// Checksum 0xc49077d4, Offset: 0x6a50
// Size: 0x2cc
function function_7f3b24e0(str_tag, var_b9e732f6) {
    a_zombies = getaiteamarray(level.zombie_team);
    a_targets = [];
    v_tag_pos = self gettagorigin(str_tag);
    v_tag_angles = self gettagangles(str_tag);
    var_ffa0cf22 = anglestoforward(v_tag_angles);
    var_61dd0ed7 = v_tag_pos + var_ffa0cf22 * 80;
    foreach (ai_zombie in a_zombies) {
        dist_sq = distance2dsquared(ai_zombie.origin, var_61dd0ed7);
        if (dist_sq > 80 * 80) {
            continue;
        }
        if (isdefined(ai_zombie.var_d571251b)) {
            if (ai_zombie.var_d571251b == "climbing" || ai_zombie.var_d571251b == "jumping_down") {
                continue;
            }
        }
        var_18dd3fc = vectornormalize(ai_zombie.origin - v_tag_pos);
        n_dot = vectordot(var_ffa0cf22, ai_zombie.origin);
        if (n_dot < 0.95) {
            continue;
        }
        if (!isdefined(a_targets)) {
            a_targets = [];
        } else if (!isarray(a_targets)) {
            a_targets = array(a_targets);
        }
        a_targets[a_targets.size] = ai_zombie;
    }
    return a_targets;
}

// Namespace namespace_e6d36abe
// Params 2, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_5b16da3a
// Checksum 0x6932a37d, Offset: 0x6d28
// Size: 0x100
function function_5b16da3a(str_tag, var_b9e732f6) {
    self endon("flamethrower_stop_" + var_b9e732f6);
    while (true) {
        a_targets = function_7f3b24e0(str_tag, var_b9e732f6);
        foreach (ai in a_targets) {
            if (isalive(ai)) {
                self setturrettargetent(ai);
                wait(1);
            }
        }
        wait(1);
    }
}

// Namespace namespace_e6d36abe
// Params 2, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_1a3d4e6e
// Checksum 0x50742b8d, Offset: 0x6e30
// Size: 0x20e
function function_1a3d4e6e(str_tag, var_b9e732f6) {
    var_b2f8099b = 0;
    var_6aedc0fa = randomfloatrange(3, 6);
    while (true) {
        wait(1);
        if (var_b9e732f6 == 1) {
            self setturrettargetvec(self.origin + anglestoforward(self.angles) * 1000);
        }
        self flag::wait_till("tank_moving");
        a_targets = function_7f3b24e0(str_tag, var_b9e732f6);
        if (a_targets.size > 0 || var_b2f8099b > var_6aedc0fa) {
            self clientfield::set("tank_flamethrower_fx", var_b9e732f6);
            self thread function_1d54dbad(var_b9e732f6, str_tag);
            if (var_b9e732f6 == 1) {
                self thread function_5b16da3a(str_tag, var_b9e732f6);
            }
            if (a_targets.size > 0) {
                wait(6);
            } else {
                wait(3);
            }
            self clientfield::set("tank_flamethrower_fx", 0);
            self notify("flamethrower_stop_" + var_b9e732f6);
            var_b2f8099b = 0;
            var_6aedc0fa = randomfloatrange(3, 6);
            continue;
        }
        var_b2f8099b++;
    }
}

// Namespace namespace_e6d36abe
// Params 2, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_1d54dbad
// Checksum 0xd3a6d7ef, Offset: 0x7048
// Size: 0x1c0
function function_1d54dbad(var_b9e732f6, str_tag) {
    self endon("flamethrower_stop_" + var_b9e732f6);
    while (true) {
        a_targets = function_7f3b24e0(str_tag, var_b9e732f6);
        foreach (ai_zombie in a_targets) {
            if (isalive(ai_zombie)) {
                a_players = function_6e2be6b3(1);
                if (a_players.size > 0) {
                    level notify(#"hash_d2cb3040", array::random(a_players));
                }
                if (str_tag == "tag_flash") {
                    ai_zombie namespace_d7c0ce12::function_2f31684b(self, ai_zombie.health, self.w_flamethrower, "MOD_BURNED");
                    ai_zombie thread namespace_d7c0ce12::function_cc964a18();
                } else {
                    ai_zombie thread namespace_ecdcc148::function_e571e237(self.w_flamethrower, self);
                }
                wait(0.05);
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_ec0a572
// Checksum 0x8f92b7c0, Offset: 0x7210
// Size: 0x690
function function_ec0a572() {
    enemy = self.favoriteenemy;
    location = enemy.origin;
    tank = level.var_f793f80e;
    if (isdefined(self.is_mechz) && self.is_mechz) {
        if (isdefined(self.var_afe67307)) {
            return self.var_afe67307;
        }
        if (isdefined(self.var_6b20a6a2)) {
            return self.var_6b20a6a2.origin;
        }
        return undefined;
    }
    if (isdefined(self.attackable)) {
        return self.origin;
    }
    if (isdefined(self.var_e5a5110d) && self.var_e5a5110d) {
        if (isdefined(self.var_6bd4e6)) {
            location = self.var_6bd4e6;
        }
    }
    if (isdefined(self.var_d571251b)) {
        if (self.var_d571251b == "tank_chase") {
            self.goalradius = -128;
        } else if (self.var_d571251b == "tag_chase") {
            self.goalradius = 16;
        } else {
            self.goalradius = 32;
        }
        if (isdefined(enemy.var_d9cb04f7) && self.var_d571251b == "none" && (self.var_d571251b == "tank_chase" || enemy.var_d9cb04f7)) {
            var_32cb19f9 = tank function_1db98f69("window_right_front_jmp_jnt");
            var_6564233d = tank function_1db98f69("window_left_rear_jmp_jnt");
            if (tank flag::get("tank_moving")) {
                self.ignoreall = 1;
                if (!(isdefined(self.var_38ab35cc) && self.var_38ab35cc)) {
                    if (gettime() != tank.var_e7f37e6e) {
                        tank.var_e7f37e6e = gettime();
                        tank.var_f004aabb = 0;
                        var_d0b0f6b = vectornormalize(anglestoforward(level.var_f793f80e.angles));
                        var_f1fd5f5a = vectornormalize(anglestoright(level.var_f793f80e.angles));
                        tank.chase_pos = [];
                        tank.chase_pos[0] = level.var_f793f80e.origin + vectorscale(var_d0b0f6b, -164);
                        tank.chase_pos[1] = var_32cb19f9;
                        tank.chase_pos[2] = var_6564233d;
                    }
                    location = tank.chase_pos[tank.var_f004aabb];
                    tank.var_f004aabb++;
                    if (tank.var_f004aabb >= 3) {
                        tank.var_f004aabb = 0;
                    }
                    dist_sq = distancesquared(self.origin, location);
                    if (dist_sq < 4096) {
                        self.var_38ab35cc = 1;
                    }
                }
            } else {
                self.var_38ab35cc = 0;
                var_32cb19f9 = getstartorigin(var_32cb19f9, tank gettagangles("window_right_front_jmp_jnt"), "ai_zm_dlc5_zombie_jump_up_markiv_front");
                var_491e48e1 = distance2dsquared(enemy.origin, var_32cb19f9);
                var_991232fb = distance2dsquared(enemy.origin, var_6564233d);
                if (var_491e48e1 < var_991232fb) {
                    location = var_32cb19f9;
                } else {
                    location = var_6564233d;
                }
                self.ignoreall = 0;
            }
        } else if (self.var_d571251b == "tag_chase") {
            if (self.var_6989fa90 === "window_right_front_jmp_jnt") {
                location = getstartorigin(tank gettagorigin("window_right_front_jmp_jnt"), tank gettagangles("window_right_front_jmp_jnt"), "ai_zm_dlc5_zombie_jump_up_markiv_front");
            } else {
                location = level.var_f793f80e function_1db98f69(self.var_6989fa90);
            }
        } else if (self.var_d571251b == "exit_tank") {
            location = level.var_f793f80e function_6fb42d68(self.var_6dec0164);
        }
    }
    if (self.var_13ed8adf === level.time && isdefined(location)) {
        if (isplayer(enemy) && location == enemy.origin) {
            self zm_utility::approximate_path_dist(enemy);
        } else {
            pathdistance(self.origin, location, 1, self, level.var_1ace2307);
        }
    } else if (isplayer(enemy) && isdefined(enemy.last_valid_position) && location === enemy.origin) {
        location = enemy.last_valid_position;
    }
    return location;
}

// Namespace namespace_e6d36abe
// Params 2, eflags: 0x0
// namespace_e6d36abe<file_0>::function_1af0699d
// Checksum 0x69b93968, Offset: 0x78a8
// Size: 0xa8
function function_1af0699d(origin, players) {
    if (isdefined(level.var_f793f80e) && level.var_f793f80e.var_dc8e0f0a > 0 || !(isdefined(level.calc_closest_player_using_paths) && level.calc_closest_player_using_paths)) {
        player = arraygetclosest(origin, players);
    } else {
        player = namespace_d7c0ce12::function_e046126e(origin, players);
    }
    if (isdefined(player)) {
        return player;
    }
}

// Namespace namespace_e6d36abe
// Params 15, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_1f659c12
// Checksum 0x270ac629, Offset: 0x7958
// Size: 0x114
function function_1f659c12(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
    if (isdefined(self.exploding) && self.exploding) {
        self notify(#"killanimscript");
        self zombie_utility::reset_attack_spot();
        return true;
    }
    if (isdefined(self)) {
        level zm_spawner::zombie_death_points(self.origin, smeansofdeath, shitloc, eattacker, self);
        self notify(#"killanimscript");
        self zombie_utility::reset_attack_spot();
        return true;
    }
    return false;
}

// Namespace namespace_e6d36abe
// Params 0, eflags: 0x1 linked
// namespace_e6d36abe<file_0>::function_23ff23ec
// Checksum 0xd5f7b2e1, Offset: 0x7a78
// Size: 0x14a
function function_23ff23ec() {
    var_32cb19f9 = level.var_f793f80e function_1db98f69("window_right_front_jmp_jnt");
    var_6564233d = level.var_f793f80e function_1db98f69("window_left_rear_jmp_jnt");
    var_de96dbf7 = pathdistance(self.origin, var_32cb19f9, 1, self, level.var_1ace2307);
    var_6c8f6cbc = pathdistance(self.origin, var_6564233d, 1, self, level.var_1ace2307);
    if (!isdefined(var_de96dbf7) && isdefined(var_6c8f6cbc)) {
        return var_6c8f6cbc;
    } else if (isdefined(var_de96dbf7) && !isdefined(var_6c8f6cbc)) {
        return var_de96dbf7;
    } else if (!isdefined(var_de96dbf7) && !isdefined(var_6c8f6cbc)) {
        return undefined;
    }
    if (var_de96dbf7 < var_6c8f6cbc) {
        return var_de96dbf7;
    }
    return var_6c8f6cbc;
}

