#using scripts/zm/zm_zod_cleanup_mgr;
#using scripts/zm/zm_zod_util;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai/zombie_shared;
#using scripts/codescripts/struct;

#namespace namespace_835aa2f1;

// Namespace namespace_835aa2f1
// Method(s) 64 Total 64
class class_df2b89fb {

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1aa5265d, Offset: 0x1ce0
    // Size: 0x226
    function constructor() {
        self.var_36e768e4 = undefined;
        self.var_d621a979 = undefined;
        self.var_d461052a = undefined;
        self.var_6732a75b = undefined;
        self.var_ece46550 = 1;
        self.var_65323906 = 0;
        self.var_597ffbe8 = 0;
        self.var_c2e30cf8 = [];
        self.m_a_mdl_doors = [];
        self.var_5d231abf = undefined;
        self.var_aced8be7 = undefined;
        self.var_27e5d923 = [];
        self.var_a677da96 = 0;
        self.var_9f3b63f6 = [];
        self.var_9e0dc993 = 1;
        a_names = array("tag_enter_back_top", "tag_enter_front_top", "tag_enter_left_top", "tag_enter_right_top");
        var_7ef7c12d = array("ai_zombie_zod_train_win_trav_from_roof_b", "ai_zombie_zod_train_win_trav_from_roof_f", "ai_zombie_zod_train_win_trav_from_roof_l", "ai_zombie_zod_train_win_trav_from_roof_r");
        /#
            assert(a_names.size == var_7ef7c12d.size);
        #/
        for (i = 0; i < a_names.size; i++) {
            str_name = a_names[i];
            str_anim = var_7ef7c12d[i];
            self.var_9f3b63f6[str_name] = spawnstruct();
            s_entrance = self.var_9f3b63f6[str_name];
            s_entrance.str_tag = str_name;
            s_entrance.str_anim = str_anim;
            s_entrance.occupied = 0;
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9bc27727, Offset: 0x7dd0
    // Size: 0x200
    function function_876255() {
        var_6609d101 = getentarray("map_train", "targetname");
        while (true) {
            var_c7d3f5b3 = function_ae26c4a8();
            switch (var_c7d3f5b3) {
            case 48:
                var_112666d8 = 1;
                break;
            case 50:
                var_112666d8 = 2;
                break;
            case 57:
                var_112666d8 = 3;
                break;
            }
            foreach (var_19166ffe in var_6609d101) {
                var_19166ffe clientfield::set("train_map_light", var_112666d8);
            }
            self flag::wait_till("moving");
            foreach (var_19166ffe in var_6609d101) {
                var_19166ffe clientfield::set("train_map_light", 0);
            }
            self flag::wait_till_clear("moving");
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x94a2a997, Offset: 0x7db0
    // Size: 0x12
    function get_origin() {
        return self.var_36e768e4.origin;
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa8d9047b, Offset: 0x7b00
    // Size: 0x2a4
    function function_fc1944ae() {
        var_507be64f = [];
        foreach (tag in self.var_9f3b63f6) {
            if (tag.occupied) {
                continue;
            }
            if (!isdefined(var_507be64f)) {
                var_507be64f = [];
            } else if (!isarray(var_507be64f)) {
                var_507be64f = array(var_507be64f);
            }
            var_507be64f[var_507be64f.size] = tag;
        }
        var_507be64f = array::randomize(var_507be64f);
        var_9dda59ac = [];
        a_players = function_be4c98a3(0);
        n_roll = randomint(100);
        if (n_roll < 80 && a_players.size > 0) {
            foreach (var_dcf46be5 in var_507be64f) {
                if (function_7d433c31(var_dcf46be5.str_tag)) {
                    if (!isdefined(var_9dda59ac)) {
                        var_9dda59ac = [];
                    } else if (!isarray(var_9dda59ac)) {
                        var_9dda59ac = array(var_9dda59ac);
                    }
                    var_9dda59ac[var_9dda59ac.size] = var_dcf46be5;
                }
            }
        }
        if (var_9dda59ac.size > 2) {
            var_507be64f = var_9dda59ac;
        }
        if (var_507be64f.size == 0) {
            return undefined;
        }
        return array::random(var_507be64f);
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x5 linked
    // Checksum 0x89fc4974, Offset: 0x79d0
    // Size: 0x128
    function function_7d433c31(str_tag) {
        foreach (e_player in level.players) {
            v_pos = self.var_36e768e4 gettagorigin(str_tag);
            v_fwd = anglestoforward(e_player.angles);
            var_f3512a4a = vectornormalize(v_pos - e_player.origin);
            if (vectordot(v_fwd, var_f3512a4a) > 0) {
                return true;
            }
        }
        return false;
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x58b6ac15, Offset: 0x79a0
    // Size: 0x22
    function function_e7a31329() {
        return self flag::get("offline");
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x73c29708, Offset: 0x7970
    // Size: 0x22
    function function_b55b4180() {
        return self flag::get("cooldown");
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x55bb8013, Offset: 0x7958
    // Size: 0xa
    function function_3e62f527() {
        return self.var_9e0dc993;
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4db9e472, Offset: 0x7928
    // Size: 0x22
    function is_moving() {
        return self flag::get("moving");
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xcf2a6f09, Offset: 0x7848
    // Size: 0xd6
    function function_e321055b() {
        v_origin = (0, 0, 0);
        foreach (var_43240065 in self.var_c2e30cf8) {
            v_origin += var_43240065.var_db628370.origin;
        }
        v_origin /= float(self.var_c2e30cf8.size);
        return v_origin;
    }

    // Namespace namespace_df2b89fb
    // Params 2, eflags: 0x1 linked
    // Checksum 0x1c2ac7c1, Offset: 0x76b0
    // Size: 0x18c
    function function_fc6b1519(ai, str_tag) {
        self endon(#"death");
        var_dcf46be5 = self.var_9f3b63f6[str_tag];
        var_dcf46be5.occupied = 1;
        v_tag_pos = self.var_36e768e4 gettagorigin(str_tag);
        v_tag_angles = self.var_36e768e4 gettagangles(str_tag);
        ai teleport(v_tag_pos, v_tag_angles);
        util::wait_network_frame();
        ai linkto(self.var_36e768e4, str_tag);
        ai animscripted("entered_train", v_tag_pos, v_tag_angles, var_dcf46be5.str_anim);
        ai zombie_shared::donotetracks("entered_train");
        ai unlink();
        var_dcf46be5.occupied = 0;
        if (is_moving()) {
            function_2f57e7c2(ai);
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6857928c, Offset: 0x7698
    // Size: 0x10
    function function_c02d34bc() {
        self.var_a677da96 = gettime();
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4f33d043, Offset: 0x7660
    // Size: 0x2c
    function function_c925ac0d() {
        return float(gettime() - self.var_a677da96) / 1000;
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4e3cc587, Offset: 0x7648
    // Size: 0xa
    function function_f037cd6() {
        return self.var_27e5d923;
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2855851e, Offset: 0x7618
    // Size: 0x24
    function function_997bcca8() {
        self.var_27e5d923 = array::remove_undefined(self.var_27e5d923);
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x1 linked
    // Checksum 0x1a0ccca2, Offset: 0x75c0
    // Size: 0x4c
    function function_cc4166eb(ai_zombie) {
        ai_zombie.var_e0d198e4 = 0;
        arrayremovevalue(self.var_27e5d923, ai_zombie);
        ai_zombie notify(#"hash_894172f4");
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7d5f2f11, Offset: 0x7560
    // Size: 0x54
    function function_2f57e7c2(ai_zombie) {
        ai_zombie.var_e0d198e4 = 1;
        array::add(self.var_27e5d923, ai_zombie, 0);
        thread function_fb77d587(ai_zombie);
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb9a1fcb3, Offset: 0x7408
    // Size: 0x14c
    function function_be4c98a3(var_593a263a) {
        if (!isdefined(var_593a263a)) {
            var_593a263a = 0;
        }
        a_players = [];
        foreach (e_player in level.players) {
            if (e_player.ignoreme || var_593a263a && !zm_utility::is_player_valid(e_player)) {
                continue;
            }
            if (e_player.var_65f06b5) {
                if (!isdefined(a_players)) {
                    a_players = [];
                } else if (!isarray(a_players)) {
                    a_players = array(a_players);
                }
                a_players[a_players.size] = e_player;
            }
        }
        return a_players;
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x1 linked
    // Checksum 0x78aae0b6, Offset: 0x73d0
    // Size: 0x2a
    function function_406e4ba9(ent) {
        return ent istouching(self.var_6732a75b);
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x1 linked
    // Checksum 0xcd16708f, Offset: 0x7328
    // Size: 0x9c
    function function_fb77d587(ai) {
        ai endon(#"death");
        ai endon(#"hash_894172f4");
        zm_net::network_safe_init("train_fall_check", 1);
        while (self zm_net::network_choke_action("train_fall_check", &function_e8e6e4b4, ai)) {
            wait(2);
        }
        function_cc4166eb(ai);
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x1 linked
    // Checksum 0xdf58df76, Offset: 0x72f0
    // Size: 0x2a
    function function_e8e6e4b4(e_ent) {
        return e_ent istouching(self.var_6732a75b);
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x16d9c3ed, Offset: 0x71a0
    // Size: 0x144
    function function_971a908c() {
        /#
            foreach (e_player in level.players) {
                /#
                    assert(isdefined(e_player.var_65f06b5));
                #/
            }
        #/
        while (true) {
            foreach (e_player in level.players) {
                e_player.var_65f06b5 = function_e8e6e4b4(e_player);
            }
            wait(0.5);
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x669ab6c6, Offset: 0x7100
    // Size: 0x94
    function function_ccd778ab() {
        foreach (e_player in level.players) {
            if (function_e8e6e4b4(e_player)) {
                return false;
            }
        }
        return true;
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x82ef5413, Offset: 0x6f10
    // Size: 0x1e4
    function function_ca899bfc() {
        if (self.var_aced8be7 == "slums") {
            self.var_36e768e4 hidepart("tag_sign_footlight");
            self.var_36e768e4 hidepart("tag_sign_canals");
            self.var_36e768e4 showpart("tag_sign_waterfront");
            playsoundatposition("evt_train_switch_track_hit", self.var_d461052a.origin);
            return;
        }
        if (self.var_aced8be7 == "theater") {
            self.var_36e768e4 hidepart("tag_sign_canals");
            self.var_36e768e4 hidepart("tag_sign_waterfront");
            self.var_36e768e4 showpart("tag_sign_footlight");
            playsoundatposition("evt_train_switch_track_hit", self.var_d461052a.origin);
            return;
        }
        if (self.var_aced8be7 == "canal") {
            self.var_36e768e4 hidepart("tag_sign_footlight");
            self.var_36e768e4 hidepart("tag_sign_waterfront");
            self.var_36e768e4 showpart("tag_sign_canals");
            playsoundatposition("evt_train_switch_track_hit", self.var_d461052a.origin);
        }
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x1 linked
    // Checksum 0x56f3a46, Offset: 0x6e88
    // Size: 0x7c
    function function_de6e1f4f(var_d461052a) {
        self.var_36e768e4 endon(#"hash_51689c0f");
        if (!flag::get("switches_enabled")) {
            flag::wait_till("switches_enabled");
        }
        var_d461052a.player_used = 0;
        var_d461052a waittill(#"trigger");
        var_d461052a.player_used = 1;
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc6967eb0, Offset: 0x6c60
    // Size: 0x21e
    function function_d2e12d33() {
        while (true) {
            function_de6e1f4f(self.var_d461052a);
            var_79623a1d = self.var_aced8be7;
            if (self.var_d461052a.player_used) {
                self.var_c2e30cf8[self.var_5d231abf].var_bd2282e4 = !self.var_c2e30cf8[self.var_5d231abf].var_bd2282e4;
                self.var_aced8be7 = function_d44a15ec();
            }
            if (self.var_aced8be7 != var_79623a1d) {
                function_ca899bfc();
                if (is_moving() && !level flag::get("callbox")) {
                    var_56d74922 = self.var_c2e30cf8[self.var_aced8be7].var_1866b220;
                    level clientfield::set("sndTrainVox", var_56d74922);
                    self.var_36e768e4 playsoundontag(level.var_98f27ad[var_56d74922 - 1], "tag_support_arm_01");
                }
                if (level flag::get("callbox")) {
                    level flag::clear("callbox");
                }
                self.var_d461052a sethintstring(%ZM_ZOD_SWITCHING_PROGRESS);
                wait(1);
                if (flag::get("switches_enabled")) {
                    self.var_d461052a sethintstring(%ZM_ZOD_SWITCH_ENABLE);
                }
            }
            level notify(#"hash_8939bd21");
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb2e91fb7, Offset: 0x6c28
    // Size: 0x30
    function function_2632b810() {
        if (isdefined(self.var_d621a979)) {
            self.var_65323906 = 1;
            self.var_d621a979 notify(#"trigger");
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x169b5f65, Offset: 0x6b48
    // Size: 0xd4
    function function_712ddcb() {
        if (!isdefined(self.var_d621a979)) {
            return;
        }
        if (self.var_65323906) {
            self.var_d621a979 namespace_8e578893::function_d73e42e0(%ZM_ZOD_TRAIN_USE_FREE);
            return;
        }
        if (function_e7a31329()) {
            self.var_d621a979 namespace_8e578893::function_d73e42e0(%ZM_ZOD_TRAIN_OFFLINE);
            return;
        }
        if (function_b55b4180()) {
            self.var_d621a979 namespace_8e578893::function_d73e42e0(%ZM_ZOD_TRAIN_COOLDOWN);
            return;
        }
        self.var_d621a979 namespace_8e578893::function_d73e42e0(%ZM_ZOD_TRAIN_USE, 500);
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe99250e8, Offset: 0x6a10
    // Size: 0x12a
    function function_a3291a93() {
        zombies = getaiteamarray(level.zombie_team);
        n_counter = 0;
        foreach (zombie in zombies) {
            if (!isdefined(zombie) || !isalive(zombie)) {
                continue;
            }
            if (function_406e4ba9(zombie)) {
                function_2f57e7c2(zombie);
            }
            n_counter++;
            if (n_counter % 3 == 0) {
                util::wait_network_frame();
            }
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xadd75752, Offset: 0x6998
    // Size: 0x70
    function function_285f0f0b() {
        if (self.var_901503d0) {
            self scene::play("p7_fxanim_zm_zod_train_door_rt_close_bundle", self);
            self.var_901503d0 = 0;
        }
        if (self.var_619deb2d) {
            self scene::play("p7_fxanim_zm_zod_train_door_lft_close_bundle", self);
            self.var_619deb2d = 0;
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x870caa11, Offset: 0x6738
    // Size: 0x252
    function function_9211290c() {
        foreach (e_door in self.m_a_mdl_doors) {
            v_pos = function_93ea71d6(e_door);
            e_door unlink();
            e_door moveto(v_pos, 0.3);
            e_door.e_clip unlink();
            e_door.e_clip moveto(e_door.e_clip.var_b620e1b1.origin, 0.3);
        }
        self.m_a_mdl_doors[0] waittill(#"movedone");
        util::wait_network_frame();
        foreach (e_door in self.m_a_mdl_doors) {
            v_pos = function_93ea71d6(e_door);
            e_door.origin = v_pos;
            e_door.angles = e_door.script_origin.angles;
            e_door linkto(self.var_36e768e4);
            e_door.e_clip linkto(self.var_36e768e4);
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2a64a2cd, Offset: 0x64b0
    // Size: 0x27c
    function close_doors() {
        self.var_36e768e4 function_285f0f0b();
        foreach (e_door in self.m_a_mdl_doors) {
            v_pos = function_93ea71d6(e_door);
            e_door unlink();
            e_door moveto(v_pos, 0.3);
            e_door.e_clip unlink();
            e_door.e_clip moveto(e_door.e_clip.var_b620e1b1.origin, 0.3);
        }
        self.m_a_mdl_doors[0] waittill(#"movedone");
        util::wait_network_frame();
        foreach (e_door in self.m_a_mdl_doors) {
            v_pos = function_93ea71d6(e_door);
            e_door.origin = v_pos;
            e_door.angles = e_door.script_origin.angles;
            e_door linkto(self.var_36e768e4);
            e_door.e_clip linkto(self.var_36e768e4);
        }
        thread function_a3291a93();
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x1 linked
    // Checksum 0x6ea4b71e, Offset: 0x6420
    // Size: 0x88
    function function_59722edc(str_side) {
        if (str_side == "right") {
            if (!self.var_901503d0) {
                self thread scene::play("p7_fxanim_zm_zod_train_door_rt_open_bundle", self);
                self.var_901503d0 = 1;
            }
            return;
        }
        if (!self.var_619deb2d) {
            self thread scene::play("p7_fxanim_zm_zod_train_door_lft_open_bundle", self);
            self.var_619deb2d = 1;
        }
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x1 linked
    // Checksum 0x16f263c8, Offset: 0x6000
    // Size: 0x418
    function open_doors(str_side) {
        if (!isdefined(str_side)) {
            str_side = function_6a48e3bc();
        }
        self.var_36e768e4 function_59722edc(str_side);
        var_7631d55c = (0, 0, 300);
        var_cfdb047c = [];
        foreach (e_door in self.m_a_mdl_doors) {
            if (str_side == "right" && (str_side == "left" && (!isdefined(str_side) || e_door.script_string == "train_rear_door") || e_door.script_string == "train_front_door")) {
                v_pos = function_f573c4ae(e_door);
                e_door unlink();
                e_door moveto(v_pos, 0.3);
                if (!isdefined(var_cfdb047c)) {
                    var_cfdb047c = [];
                } else if (!isarray(var_cfdb047c)) {
                    var_cfdb047c = array(var_cfdb047c);
                }
                var_cfdb047c[var_cfdb047c.size] = e_door;
                e_door.e_clip unlink();
                e_door.e_clip moveto(e_door.e_clip.origin + var_7631d55c, 0.3);
            }
        }
        if (var_cfdb047c.size > 0) {
            var_cfdb047c[0] waittill(#"movedone");
            util::wait_network_frame();
        }
        util::wait_network_frame();
        foreach (e_door in var_cfdb047c) {
            v_pos = function_f573c4ae(e_door);
            e_door.origin = v_pos;
            e_door.angles = e_door.script_origin.angles;
            e_door linkto(self.var_36e768e4);
            e_door.e_clip linkto(self.var_36e768e4);
        }
        for (i = self.var_27e5d923.size - 1; i >= 0; i--) {
            ai = self.var_27e5d923[i];
            if (isdefined(ai)) {
                function_cc4166eb(ai);
            }
        }
        self.var_27e5d923 = [];
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x1 linked
    // Checksum 0x34141d98, Offset: 0x5f68
    // Size: 0x8a
    function function_39fb130f(e_door) {
        str_side = function_6a48e3bc();
        if (str_side == "right" && (str_side == "left" && e_door.script_string == "train_rear_door" || e_door.script_string == "train_front_door")) {
            return self.var_9e0dc993;
        }
        return 0;
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd2c82c3a, Offset: 0x5ef0
    // Size: 0x70
    function function_6a48e3bc() {
        str_side = self.var_c2e30cf8[self.var_5d231abf].var_54db6999;
        if (!self.var_ece46550) {
            if (str_side == "left") {
                return "right";
            } else if (str_side == "right") {
                return "left";
            }
        }
        return str_side;
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x1 linked
    // Checksum 0xd4d64f94, Offset: 0x5ec0
    // Size: 0x22
    function function_93ea71d6(e_door) {
        return e_door.script_origin.origin;
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x1 linked
    // Checksum 0x6ed9e238, Offset: 0x5df8
    // Size: 0xc0
    function function_f573c4ae(e_door) {
        if (e_door.script_string == "front_door") {
            return (e_door.script_origin.origin - anglestoforward(e_door.script_origin.angles) * 100);
        }
        return e_door.script_origin.origin + anglestoforward(e_door.script_origin.angles) * 100;
    }

    // Namespace namespace_df2b89fb
    // Params 2, eflags: 0x1 linked
    // Checksum 0xf14137d4, Offset: 0x5aa0
    // Size: 0x350
    function function_805316e6(e_gate, var_cdaa2ef3) {
        nd_start = self.var_c2e30cf8[e_gate.script_string].start_node;
        var_ee4758e4 = e_gate.origin;
        var_92bda14 = var_ee4758e4 + anglestoforward(nd_start.angles) * 96;
        if (self.var_c2e30cf8[e_gate.script_string].var_54db6999 == "right") {
            var_92bda14 = var_ee4758e4 - anglestoforward(nd_start.angles) * 96;
        }
        b_open = 1;
        while (true) {
            if (b_open) {
                self.var_9e0dc993 = 0;
                e_gate moveto(var_92bda14, 1);
                b_open = 0;
                foreach (nd in var_cdaa2ef3) {
                    unlinktraversal(nd);
                }
            }
            self flag::wait_till_clear("moving");
            if (self.var_5d231abf == e_gate.script_string) {
                e_gate moveto(var_ee4758e4, 1);
                b_open = 1;
                e_gate waittill(#"movedone");
                foreach (nd in var_cdaa2ef3) {
                    var_147257fa = nd.script_string === "forward";
                    if (!self.var_ece46550 && (self.var_ece46550 && var_147257fa || !var_147257fa)) {
                        linktraversal(nd);
                    }
                }
                self.var_9e0dc993 = 1;
            }
            self flag::wait_till("moving");
            wait(1);
        }
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x1 linked
    // Checksum 0x83a1c33e, Offset: 0x5838
    // Size: 0x260
    function function_265cb762(var_2ac060e4) {
        /#
            assert(isdefined(self.var_5d231abf));
        #/
        var_8305c467 = self.var_c2e30cf8[var_2ac060e4].var_1e52120;
        t_use = namespace_8e578893::function_d095318(var_8305c467.origin, 60, 1);
        thread function_4a9e53d9(var_2ac060e4, t_use, getent(var_8305c467.target, "targetname"));
        while (true) {
            e_who = t_use waittill(#"trigger");
            if (!e_who zm_score::can_player_purchase(500)) {
                e_who zm_audio::create_and_play_dialog("general", "transport_deny");
                continue;
            }
            if (self.var_5d231abf != var_2ac060e4 && isdefined(self.var_d621a979)) {
                self.var_65323906 = 0;
                if (var_2ac060e4 != self.var_aced8be7) {
                    level flag::set("callbox");
                    self.var_d461052a notify(#"trigger");
                    level waittill(#"hash_8939bd21");
                }
                self.var_d621a979 notify(#"trigger", e_who);
                util::wait_network_frame();
                self.var_65323906 = 1;
                var_8305c467 rotatepitch(-76, 0.5);
                self flag::wait_till("moving");
                self flag::wait_till_clear("moving");
                var_8305c467 rotatepitch(-180, 0.5);
            }
        }
    }

    // Namespace namespace_df2b89fb
    // Params 3, eflags: 0x1 linked
    // Checksum 0x47fc1c3e, Offset: 0x55d8
    // Size: 0x258
    function function_4a9e53d9(var_2ac060e4, t_use, e_light) {
        while (true) {
            if (self.var_5d231abf == var_2ac060e4) {
                e_light clientfield::set("train_callbox_light", 0);
                t_use namespace_8e578893::function_d73e42e0(%);
            } else {
                e_light clientfield::set("train_callbox_light", 1);
                t_use namespace_8e578893::function_d73e42e0(%ZM_ZOD_TRAIN_CALL, 500);
            }
            self flag::wait_till("moving");
            e_light clientfield::set("train_callbox_light", 0);
            t_use namespace_8e578893::function_d73e42e0(%ZM_ZOD_TRAIN_MOVING);
            self flag::wait_till_clear("moving");
            wait(0.05);
            if (self flag::get("offline")) {
                t_use namespace_8e578893::function_d73e42e0(%ZM_ZOD_TRAIN_OFFLINE);
                e_light clientfield::set("train_callbox_light", 2);
                self flag::wait_till_clear("offline");
                continue;
            }
            if (self.var_5d231abf == var_2ac060e4) {
                t_use namespace_8e578893::function_d73e42e0(%);
                self flag::wait_till_clear("cooldown");
                continue;
            }
            t_use namespace_8e578893::function_d73e42e0(%ZM_ZOD_TRAIN_COOLDOWN);
            self flag::wait_till_clear("cooldown");
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6d6efd06, Offset: 0x55a0
    // Size: 0x30
    function function_b0af9dac() {
        while (true) {
            level waittill(#"between_round_over");
            level.var_33c4ee76 = 0;
            wait(0.05);
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb2896446, Offset: 0x5538
    // Size: 0x5c
    function function_955e57a7() {
        level flag::wait_till("ee_boss_defeated");
        level notify(#"hash_12be7dbb");
        self flag::clear("offline");
        function_712ddcb();
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xfd33d9e3, Offset: 0x5440
    // Size: 0xec
    function function_312bb6e1() {
        level endon(#"hash_12be7dbb");
        if (level flag::get("ee_boss_defeated") && !level flag::get("ee_final_boss_defeated")) {
            return;
        }
        if (level.var_33c4ee76 < 5) {
            return;
        }
        self flag::set("offline");
        self.var_36e768e4 clientfield::set("train_switch_light", 2);
        function_712ddcb();
        level waittill(#"between_round_over");
        self flag::clear("offline");
        wait(0.05);
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x722c5a18, Offset: 0x5330
    // Size: 0x104
    function function_a377ba46() {
        if (flag::get("moving")) {
            var_38c97a3b = function_d44a15ec();
        } else {
            var_38c97a3b = self.var_5d231abf;
        }
        switch (var_38c97a3b) {
        case 48:
            var_bddb9113 = "lgt_exp_train_slums_debug";
            break;
        case 57:
            var_bddb9113 = "lgt_exp_train_canals_debug";
            break;
        case 50:
            var_bddb9113 = "lgt_exp_train_theater_debug";
            break;
        }
        if (flag::get("moving")) {
            exploder::exploder(var_bddb9113);
            return;
        }
        wait(2);
        exploder::exploder_stop(var_bddb9113);
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc784593d, Offset: 0x4b78
    // Size: 0x7b0
    function main() {
        var_8518d16d = getarraykeys(self.var_c2e30cf8);
        var_8518d16d = array::randomize(var_8518d16d);
        self.var_5d231abf = var_8518d16d[0];
        self.var_97fef807 = self.var_5d231abf;
        self.var_c2e30cf8[self.var_5d231abf].var_bd2282e4 = randomint(2);
        self.var_aced8be7 = function_d44a15ec();
        self.var_36e768e4 attachpath(self.var_c2e30cf8[self.var_5d231abf].start_node);
        var_4a4de7b4 = 1;
        self thread function_876255();
        self thread function_971a908c();
        self thread function_955e57a7();
        wait(1);
        var_74ff4121 = self.var_36e768e4 gettagorigin("tag_button_front");
        self.var_d621a979 = namespace_8e578893::function_d095318(var_74ff4121, 60, 1);
        self.var_36e768e4 playloopsound("evt_train_idle_loop", 4);
        open_doors();
        thread function_d2e12d33();
        while (true) {
            function_712ddcb();
            function_8c4965de(1);
            level thread function_b0af9dac();
            while (true) {
                self.var_36e768e4 clientfield::set("train_switch_light", 1);
                e_who = self.var_d621a979 waittill(#"trigger");
                self.var_36e768e4 clientfield::set("train_switch_light", 0);
                if (self.var_65323906) {
                    self.var_65323906 = 0;
                    break;
                }
                if (!e_who zm_score::can_player_purchase(500)) {
                    e_who zm_audio::create_and_play_dialog("general", "transport_deny");
                    continue;
                }
                e_who zm_score::minus_to_player_score(500);
                e_who zm_audio::create_and_play_dialog("train", "start");
                break;
            }
            level.var_33c4ee76++;
            thread function_a377ba46();
            wait(0.05);
            self flag::set("moving");
            zm_unitrigger::unregister_unitrigger(self.var_d621a979);
            self.var_d621a979 = undefined;
            close_doors();
            self.var_36e768e4 playsound("evt_train_start");
            self.var_36e768e4 playloopsound("evt_train_loop", 4);
            var_8d722bd4 = function_ccd778ab();
            if (var_8d722bd4 || var_4a4de7b4) {
                self.var_36e768e4 setspeed(32);
            } else {
                level.b_host_migration_force_player_respawn = 1;
                thread function_a9acf9e2();
            }
            move();
            self.var_36e768e4 playloopsound("evt_train_idle_loop", 4);
            var_24d7985e = function_be4c98a3(0);
            if (var_24d7985e.size > 0) {
                level flag::set(self.var_c2e30cf8[self.var_5d231abf].var_6ac14e0c);
                level flag::set("train_rode_to_" + self.var_5d231abf);
            }
            if (var_8d722bd4 || var_4a4de7b4) {
                self.var_36e768e4 resumespeed();
            }
            if (var_4a4de7b4) {
                var_4a4de7b4 = 0;
            }
            open_doors();
            var_24d7985e = function_be4c98a3(0);
            if (var_24d7985e.size > 0) {
                var_3a349c58 = var_24d7985e[randomint(var_24d7985e.size)];
                var_3a349c58 zm_audio::create_and_play_dialog("train", "stop");
            }
            var_a56d6832 = (0, 0, 0);
            if (!self.var_ece46550) {
                var_a56d6832 = self.var_36e768e4 gettagorigin("tag_button_back");
            } else {
                var_a56d6832 = self.var_36e768e4 gettagorigin("tag_button_front");
            }
            self flag::clear("moving");
            level.b_host_migration_force_player_respawn = 0;
            self function_312bb6e1();
            if (!self.var_65323906 && level.var_33c4ee76 > 0) {
                self flag::set("cooldown");
                function_712ddcb();
                n_wait = 40;
                /#
                    if (getdvarint("sndTrainVox") > 0) {
                        n_wait = 5;
                    }
                #/
                wait(n_wait);
                self.var_d621a979 = namespace_8e578893::function_d095318(var_a56d6832, 60, 1);
                self flag::clear("cooldown");
                continue;
            }
            self.var_d621a979 = namespace_8e578893::function_d095318(var_a56d6832, 60, 1);
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3a33b794, Offset: 0x49c0
    // Size: 0x1aa
    function function_6f6ab7a4() {
        for (i = 0; i < self.m_a_mdl_doors.size; i++) {
            e_door = self.m_a_mdl_doors[i];
            e_door hide();
            if (e_door.script_string == "train_front_door") {
                e_door.e_clip = getent("train_front_clip", "script_string");
            } else if (e_door.script_string == "train_rear_door") {
                e_door.e_clip = getent("train_rear_clip", "script_string");
            }
            if (isdefined(e_door.e_clip)) {
                e_origin = spawn("script_origin", e_door.e_clip.origin);
                e_origin.angles = self.var_36e768e4.angles;
                e_origin linkto(self.var_36e768e4);
                e_door.e_clip.var_b620e1b1 = e_origin;
            }
        }
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5caa134c, Offset: 0x4100
    // Size: 0x8b2
    function initialize(var_fcd89369) {
        /#
            assert(isdefined(var_fcd89369));
        #/
        self.var_36e768e4 = var_fcd89369;
        self.var_36e768e4.var_619deb2d = 0;
        self.var_36e768e4.var_901503d0 = 0;
        if (!self flag::exists("moving")) {
            self flag::init("moving", 0);
        }
        if (!self flag::exists("cooldown")) {
            self flag::init("cooldown", 0);
        }
        if (!self flag::exists("offline")) {
            self flag::init("offline", 0);
        }
        if (!self flag::exists("switches_enabled")) {
            self flag::init("switches_enabled", 1);
        }
        if (!level flag::exists("callbox")) {
            level flag::init("callbox");
        }
        self.var_36e768e4.team = "spectator";
        function_aaacaec9();
        /#
            thread function_11c8bd7a();
            thread function_35ac589d();
        #/
        var_3712c214 = getentarray(self.var_36e768e4.target, "targetname");
        foreach (e_ent in var_3712c214) {
            if (isdefined(e_ent.script_string)) {
                if (e_ent.script_string == "train_volume") {
                    if (!isdefined(self.var_6732a75b)) {
                        /#
                            assert(!isdefined(self.var_6732a75b));
                        #/
                        e_ent enablelinkto();
                        self.var_6732a75b = e_ent;
                    }
                } else if (e_ent.script_string == "train_rear_door" || e_ent.script_string == "train_front_door") {
                    if (!isdefined(e_ent.script_origin)) {
                        e_ent.script_origin = spawn("script_origin", e_ent.origin);
                        e_ent.script_origin.angles = self.var_36e768e4.angles;
                        e_ent.script_origin linkto(self.var_36e768e4);
                    }
                    if (!isdefined(self.m_a_mdl_doors)) {
                        self.m_a_mdl_doors = [];
                    } else if (!isarray(self.m_a_mdl_doors)) {
                        self.m_a_mdl_doors = array(self.m_a_mdl_doors);
                    }
                    self.m_a_mdl_doors[self.m_a_mdl_doors.size] = e_ent;
                }
                e_ent linkto(self.var_36e768e4);
                continue;
            }
            /#
                iprintlnbold("sndTrainVox" + namespace_8e578893::function_f7f2ffed(e_ent.origin) + "sndTrainVox");
            #/
        }
        function_6f6ab7a4();
        /#
            if (!isdefined(self.var_6732a75b)) {
                /#
                    assertmsg("sndTrainVox" + namespace_8e578893::function_f7f2ffed(self.var_36e768e4.origin) + "sndTrainVox");
                #/
            }
        #/
        self.var_36e768e4 function_a8e2d7ff();
        self.var_d461052a = getent("m_s_switch_trigger", "targetname");
        self.var_d461052a triggerignoreteam();
        self.var_d461052a setteamfortrigger("none");
        self.var_d461052a sethintstring(%ZM_ZOD_SWITCH_DISABLE);
        self.var_d461052a setcursorhint("HINT_NOICON");
        self.var_d461052a enablelinkto();
        self.var_d461052a linkto(self.var_36e768e4);
        self.var_d461052a.player_used = 0;
        thread main();
        var_8b82fd2c = getentarray("train_call_lever", "targetname");
        foreach (var_ab09630c in var_8b82fd2c) {
            thread function_265cb762(var_ab09630c.script_string);
        }
        var_b6cf5773 = getentarray("train_gate", "targetname");
        foreach (gate in var_b6cf5773) {
            station = self.var_c2e30cf8[gate.script_string];
            if (!isdefined(station.gates)) {
                station.gates = [];
            }
            if (!isdefined(station.gates)) {
                station.gates = [];
            } else if (!isarray(station.gates)) {
                station.gates = array(station.gates);
            }
            station.gates[station.gates.size] = gate;
            var_38cb7b13 = getnodearray(station.path_node.target, "targetname");
            self thread function_805316e6(gate, var_38cb7b13);
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x7762de6c, Offset: 0x37d0
    // Size: 0x922
    function function_aaacaec9() {
        self.var_c2e30cf8 = [];
        var_162fdabe = getnodearray("train_pathnode", "targetname");
        foreach (nd in var_162fdabe) {
            var_c7d3f5b3 = nd.script_string;
            self.var_c2e30cf8[var_c7d3f5b3] = spawnstruct();
            self.var_c2e30cf8[var_c7d3f5b3].path_node = nd;
            self.var_c2e30cf8[var_c7d3f5b3].origin = nd.origin;
            self.var_c2e30cf8[var_c7d3f5b3].angles = nd.angles;
            self.var_c2e30cf8[var_c7d3f5b3].var_19ec4f11 = var_c7d3f5b3;
            self.var_c2e30cf8[var_c7d3f5b3].var_54db6999 = nd.script_parameters;
        }
        self.var_c2e30cf8["slums"].var_6794c924 = "canal";
        self.var_c2e30cf8["slums"].var_13ba8371 = "theater";
        self.var_c2e30cf8["slums"].var_bd2282e4 = 0;
        self.var_c2e30cf8["slums"].var_6ac14e0c = "activate_slums_waterfront";
        self.var_c2e30cf8["slums"].var_1866b220 = 8;
        self.var_c2e30cf8["slums"].var_e9a2f13e = 5;
        self.var_c2e30cf8["slums"].var_b2be6a39 = 1;
        self.var_c2e30cf8["slums"].start_node = getvehiclenode("a1", "targetname");
        self.var_c2e30cf8["theater"].var_6794c924 = "slums";
        self.var_c2e30cf8["theater"].var_13ba8371 = "canal";
        self.var_c2e30cf8["theater"].var_bd2282e4 = 0;
        self.var_c2e30cf8["theater"].var_6ac14e0c = "activate_theater_square";
        self.var_c2e30cf8["theater"].var_1866b220 = 9;
        self.var_c2e30cf8["theater"].var_e9a2f13e = 6;
        self.var_c2e30cf8["theater"].var_b2be6a39 = 2;
        self.var_c2e30cf8["theater"].start_node = getvehiclenode("b1", "targetname");
        self.var_c2e30cf8["canal"].var_6794c924 = "theater";
        self.var_c2e30cf8["canal"].var_13ba8371 = "slums";
        self.var_c2e30cf8["canal"].var_bd2282e4 = 0;
        self.var_c2e30cf8["canal"].var_6ac14e0c = "activate_brothel_street";
        self.var_c2e30cf8["canal"].var_1866b220 = 7;
        self.var_c2e30cf8["canal"].var_e9a2f13e = 4;
        self.var_c2e30cf8["canal"].var_b2be6a39 = 3;
        self.var_c2e30cf8["canal"].start_node = getvehiclenode("c1", "targetname");
        level.var_98f27ad = array("vox_tanc_board_canal_0", "vox_tanc_board_slums_0", "vox_tanc_board_theater_0", "vox_tanc_depart_canal_0", "vox_tanc_depart_slums_0", "vox_tanc_depart_theater_0", "vox_tanc_divert_canal_0", "vox_tanc_divert_slums_0", "vox_tanc_divert_theater_0");
        a_keys = getarraykeys(self.var_c2e30cf8);
        for (i = 0; i < a_keys.size; i++) {
            str_key = a_keys[i];
            nd_next = self.var_c2e30cf8[str_key].start_node;
            var_22436c69 = undefined;
            self.var_c2e30cf8[str_key].nodes = [];
            while (isdefined(nd_next)) {
                if (isdefined(var_22436c69)) {
                    nd_next.target2 = var_22436c69.targetname;
                }
                if (!isdefined(self.var_c2e30cf8[str_key].nodes)) {
                    self.var_c2e30cf8[str_key].nodes = [];
                } else if (!isarray(self.var_c2e30cf8[str_key].nodes)) {
                    self.var_c2e30cf8[str_key].nodes = array(self.var_c2e30cf8[str_key].nodes);
                }
                self.var_c2e30cf8[str_key].nodes[self.var_c2e30cf8[str_key].nodes.size] = nd_next;
                var_22436c69 = nd_next;
                if (!isdefined(nd_next.target)) {
                    break;
                }
                nd_next = getvehiclenode(nd_next.target, "targetname");
            }
            var_82d4f919 = self.var_c2e30cf8[str_key].nodes.size;
            self.var_c2e30cf8[str_key].var_db628370 = self.var_c2e30cf8[str_key].nodes[var_82d4f919 - 1];
            self.var_c2e30cf8[str_key].var_a7b7d6cd = 1;
        }
        var_8b82fd2c = getentarray("train_call_lever", "targetname");
        foreach (var_ab09630c in var_8b82fd2c) {
            var_374d0b9b = arraygetclosest(var_ab09630c.origin, self.var_c2e30cf8);
            /#
                assert(isdefined(var_374d0b9b));
            #/
            var_ab09630c.script_string = var_374d0b9b.var_19ec4f11;
            var_374d0b9b.var_1e52120 = var_ab09630c;
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4fa3acd0, Offset: 0x37b0
    // Size: 0x14
    function function_dda9a9d2() {
        self.var_ece46550 = !self.var_ece46550;
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xdbc35e55, Offset: 0x33a0
    // Size: 0x402
    function function_a9acf9e2() {
        var_e19f73fe = [];
        foreach (e_player in level.players) {
            if (function_e8e6e4b4(e_player)) {
                /#
                    if (e_player isinmovemode("sndTrainVox", "sndTrainVox")) {
                        continue;
                    }
                #/
                if (!zm_utility::is_player_valid(e_player, 1, 0)) {
                    continue;
                }
                e_player.var_e51032ec = gettime();
                if (!isdefined(var_e19f73fe)) {
                    var_e19f73fe = [];
                } else if (!isarray(var_e19f73fe)) {
                    var_e19f73fe = array(var_e19f73fe);
                }
                var_e19f73fe[var_e19f73fe.size] = e_player;
            }
        }
        self.var_36e768e4 waittill(#"hash_4e05ac46");
        train_center = self.var_36e768e4 getcentroid();
        var_10b9b744 = 0;
        foreach (e_player in var_e19f73fe) {
            /#
                if (e_player isinmovemode("sndTrainVox", "sndTrainVox")) {
                    continue;
                }
            #/
            if (!zm_utility::is_player_valid(e_player, 1, 0)) {
                continue;
            }
            if (!isdefined(e_player.var_e51032ec)) {
                continue;
            }
            if (isdefined(e_player.last_bleed_out_time) && e_player.last_bleed_out_time > e_player.var_e51032ec) {
                continue;
            }
            if (!function_e8e6e4b4(e_player)) {
                fatal = 0;
                do {
                    spawnpos = train_center;
                    switch (var_10b9b744) {
                    case 0:
                        spawnpos += (36, 36, 0);
                        break;
                    case 1:
                        spawnpos += (-36, -36, 0);
                        break;
                    case 2:
                        spawnpos += (36, -36, 0);
                        break;
                    case 3:
                        spawnpos += (-36, 36, 0);
                        break;
                    case 4:
                        e_player dodamage(1000, (0, 0, 0));
                        fatal = 1;
                        continue;
                    }
                    var_10b9b744++;
                LOC_000003ae:
                } while (!fatal && !function_eb9ee200(spawnpos));
                e_player setorigin(spawnpos);
            }
        }
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x1 linked
    // Checksum 0x275c672c, Offset: 0x3258
    // Size: 0x13e
    function function_eb9ee200(spawnpos) {
        foreach (e_player in level.players) {
            if (!zm_utility::is_player_valid(e_player, 0, 0)) {
                continue;
            }
            porigin = e_player.origin;
            if (abs(porigin[2] - spawnpos[2]) > 60) {
                continue;
            }
            distance_apart = distance2d(porigin, spawnpos);
            if (abs(distance_apart) > 18) {
                continue;
            }
            return false;
        }
        return true;
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x47b4e91, Offset: 0x2c48
    // Size: 0x604
    function move() {
        self.var_597ffbe8 = 0;
        str_start = self.var_5d231abf;
        var_f2b1b376 = self.var_c2e30cf8[str_start].var_6794c924;
        var_a4cd63cd = self.var_c2e30cf8[str_start].var_13ba8371;
        if (self.var_c2e30cf8[str_start].var_a7b7d6cd == 0) {
            self.var_36e768e4 flip180();
            self.var_c2e30cf8[str_start].var_a7b7d6cd = function_f4580b(self.var_c2e30cf8[str_start].nodes, self.var_c2e30cf8[str_start].var_a7b7d6cd);
            self.var_36e768e4 switchstartnode(self.var_c2e30cf8[str_start].start_node, self.var_c2e30cf8[str_start].var_db628370);
        }
        if (self.var_c2e30cf8[var_f2b1b376].var_a7b7d6cd == 1) {
            self.var_c2e30cf8[var_f2b1b376].var_a7b7d6cd = function_f4580b(self.var_c2e30cf8[var_f2b1b376].nodes, self.var_c2e30cf8[var_f2b1b376].var_a7b7d6cd);
            self.var_36e768e4 switchstartnode(self.var_c2e30cf8[var_f2b1b376].start_node, self.var_c2e30cf8[var_f2b1b376].var_db628370);
        }
        if (self.var_c2e30cf8[var_a4cd63cd].var_a7b7d6cd == 1) {
            self.var_c2e30cf8[var_a4cd63cd].var_a7b7d6cd = function_f4580b(self.var_c2e30cf8[var_a4cd63cd].nodes, self.var_c2e30cf8[var_a4cd63cd].var_a7b7d6cd);
            self.var_36e768e4 switchstartnode(self.var_c2e30cf8[var_a4cd63cd].start_node, self.var_c2e30cf8[var_a4cd63cd].var_db628370);
        }
        var_56d74922 = self.var_c2e30cf8[self.var_aced8be7].var_e9a2f13e;
        level clientfield::set("sndTrainVox", var_56d74922);
        self.var_36e768e4 playsoundontag(level.var_98f27ad[var_56d74922 - 1], "tag_support_arm_01");
        thread function_4bf9e430();
        self.var_36e768e4 recalcsplinepaths();
        self.var_36e768e4 attachpath(self.var_c2e30cf8[str_start].start_node);
        self.var_36e768e4 startpath();
        while (distance2dsquared(self.var_36e768e4.origin, self.var_c2e30cf8[str_start].var_db628370.origin) > 122500) {
            util::wait_network_frame();
        }
        function_8c4965de(0);
        thread function_a377ba46();
        var_7cf5ddc3 = var_f2b1b376;
        if (!self.var_c2e30cf8[str_start].var_bd2282e4) {
            var_7cf5ddc3 = var_a4cd63cd;
        }
        var_aad144f4 = self.var_c2e30cf8[var_7cf5ddc3].var_db628370;
        self.var_36e768e4 setswitchnode(self.var_c2e30cf8[str_start].var_db628370, self.var_c2e30cf8[var_7cf5ddc3].var_db628370);
        self.var_597ffbe8 = 1;
        self.var_97fef807 = var_7cf5ddc3;
        level flag::set(self.var_c2e30cf8[var_7cf5ddc3].var_6ac14e0c);
        self.var_36e768e4 waittill(#"reached_end_node");
        self.var_ece46550 = !self.var_ece46550;
        self.var_5d231abf = var_7cf5ddc3;
        self.var_aced8be7 = function_d44a15ec();
        self.var_36e768e4 notify(#"hash_4e05ac46", self.var_5d231abf);
        var_56d74922 = self.var_c2e30cf8[self.var_5d231abf].var_b2be6a39;
        level clientfield::set("sndTrainVox", var_56d74922);
        self.var_36e768e4 playsoundontag(level.var_98f27ad[var_56d74922 - 1], "tag_support_arm_01");
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8836593c, Offset: 0x2be8
    // Size: 0x58
    function function_7eb2583b() {
        timeout = 15;
        while (timeout > 0 && self flag::get("moving")) {
            timeout -= 1;
            wait(1);
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x320f6ebf, Offset: 0x2a80
    // Size: 0x15a
    function function_4bf9e430() {
        self.var_36e768e4 endon(#"hash_4e05ac46");
        while (true) {
            nd = self.var_36e768e4 waittill(#"reached_node");
            if (isdefined(nd.script_parameters)) {
                switch (nd.script_parameters) {
                case 54:
                    if (self.var_597ffbe8) {
                        self.var_36e768e4 playsound("evt_train_stop");
                        self.var_36e768e4 stoploopsound(3);
                    }
                    break;
                case 53:
                    if (self.var_597ffbe8) {
                        var_ab09630c = self.var_c2e30cf8[self.var_aced8be7].var_1e52120;
                        var_ab09630c playsound("evt_train_station_bell");
                    }
                    break;
                default:
                    /#
                        assertmsg("sndTrainVox" + nd.script_parameters);
                    #/
                    break;
                }
            }
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb5995f60, Offset: 0x2a18
    // Size: 0x60
    function function_d44a15ec() {
        if (self.var_c2e30cf8[self.var_5d231abf].var_bd2282e4) {
            return self.var_c2e30cf8[self.var_5d231abf].var_6794c924;
        }
        return self.var_c2e30cf8[self.var_5d231abf].var_13ba8371;
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x82585757, Offset: 0x2a00
    // Size: 0xa
    function function_ae26c4a8() {
        return self.var_5d231abf;
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x99dab385, Offset: 0x27d0
    // Size: 0x228
    function function_a8e2d7ff() {
        var_aed9540e = [];
        var_aed9540e["moving"] = getentarray("lgt_train_lightrig_veh_placement", "targetname");
        var_aed9540e["canals"] = getentarray("lgt_train_lightrig_canals_debug", "targetname");
        var_aed9540e["slums"] = getentarray("lgt_train_lightrig_slums_debug", "targetname");
        var_aed9540e["theater"] = getentarray("lgt_train_lightrig_theater_debug", "targetname");
        var_105cc375 = (0, 45, 0);
        self enablelinkto();
        foreach (var_83e6406e in var_aed9540e) {
            foreach (var_66fccd7 in var_83e6406e) {
                var_66fccd7.origin = self.origin;
                var_66fccd7.angles = self.angles + var_105cc375;
                var_66fccd7 linkto(self);
            }
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4b6cc725, Offset: 0x27b8
    // Size: 0xa
    function function_8cf8e3a5() {
        return self.var_36e768e4;
    }

    // Namespace namespace_df2b89fb
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb675e256, Offset: 0x26f8
    // Size: 0xb8
    function function_8c4965de(b_enabled) {
        if (b_enabled) {
            self flag::set("switches_enabled");
            self.var_d461052a sethintstring(%ZM_ZOD_SWITCH_ENABLE);
            function_ca899bfc();
            return;
        }
        self flag::clear("switches_enabled");
        self.var_d461052a sethintstring(%ZM_ZOD_SWITCH_DISABLE);
        self.var_36e768e4 notify(#"hash_51689c0f");
    }

    // Namespace namespace_df2b89fb
    // Params 2, eflags: 0x1 linked
    // Checksum 0x8b0f3deb, Offset: 0x2648
    // Size: 0xa4
    function function_f4580b(all_nodes, direction) {
        for (i = 0; i < all_nodes.size; i++) {
            var_9f0a4f36 = all_nodes[i].target;
            all_nodes[i].target = all_nodes[i].target2;
            all_nodes[i].target2 = var_9f0a4f36;
        }
        return !direction;
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xbbcbf00e, Offset: 0x2328
    // Size: 0x318
    function function_35ac589d() {
        do {
            var_228edad9 = getdvarint("train_debug_doors");
            wait(1);
        } while (!isdefined(var_228edad9) || var_228edad9 <= 0);
        while (true) {
            duration = 1;
            var_6ffe9d93 = -16;
            var_4dc5a359 = 12;
            origin = self.var_36e768e4.origin;
            origin += (0, 0, -90);
            forward = anglestoforward(self.var_36e768e4.angles);
            right = anglestoright(self.var_36e768e4.angles);
            if (!self.var_ece46550) {
                forward = -1 * forward;
            }
            var_bba032ca = origin + var_6ffe9d93 * forward;
            /#
                line(origin, var_bba032ca, (1, 0, 0), 1, 1, duration);
            #/
            /#
                line(var_bba032ca, var_bba032ca - var_4dc5a359 * forward - var_4dc5a359 * right, (1, 0, 0), 1, 1, duration);
            #/
            /#
                line(var_bba032ca, var_bba032ca - var_4dc5a359 * forward + var_4dc5a359 * right, (1, 0, 0), 1, 1, duration);
            #/
            foreach (e_door in self.m_a_mdl_doors) {
                var_d4280494 = e_door.origin;
                open = function_39fb130f(e_door);
                str_state = "closed";
                if (open) {
                    str_state = "open";
                }
                /#
                    print3d(var_d4280494, str_state, (0, 0, 1), 1, 1, duration);
                #/
            }
            wait(0.05);
        }
    }

    // Namespace namespace_df2b89fb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb1e15503, Offset: 0x1f10
    // Size: 0x410
    function function_11c8bd7a() {
        /#
            do {
                var_228edad9 = getdvarint("sndTrainVox");
                wait(1);
            } while (!isdefined(var_228edad9) || var_228edad9 <= 0);
            while (true) {
                a_keys = getarraykeys(self.var_c2e30cf8);
                for (var_6983dc4b = 0; var_6983dc4b < self.var_c2e30cf8.size; var_6983dc4b++) {
                    j = a_keys[var_6983dc4b];
                    node_set = self.var_c2e30cf8[j].nodes;
                    for (i = 0; i < node_set.size; i++) {
                        node = node_set[i];
                        var_dc73cd3e = node.origin + (0, 0, -95);
                        debugstar(var_dc73cd3e, 1, (1, 0, 0));
                        if (isdefined(node.target)) {
                            node_target = getvehiclenode(node.target, "sndTrainVox");
                            var_4f71418 = node_target.origin + (0, 0, -70);
                            line(var_dc73cd3e, var_4f71418, (0, 1, 0), 0, 1);
                            debugstar(var_4f71418, 1, (0, 1, 0));
                        }
                        if (isdefined(node.target2)) {
                            var_dc338423 = getvehiclenode(node.target2, "sndTrainVox");
                            var_e9bd3ba0 = var_dc338423.origin + (0, 0, -120);
                            line(var_dc73cd3e, var_e9bd3ba0, (0, 0, 1), 0, 1);
                            debugstar(var_e9bd3ba0, 1, (0, 0, 1));
                        }
                    }
                }
                a_zombies = getaiteamarray(level.zombie_team);
                foreach (ai in a_zombies) {
                    if (isdefined(ai.var_e0d198e4) && ai.var_e0d198e4) {
                        print3d(ai.origin + (0, 0, 100), "sndTrainVox" + self.var_27e5d923.size + "sndTrainVox", (0, 255, 0), 1);
                    }
                }
                wait(0.05);
            }
        #/
    }

}

// Namespace namespace_835aa2f1
// Params 0, eflags: 0x2
// Checksum 0xbdd9c4ef, Offset: 0xce0
// Size: 0x34
function function_2dc19561() {
    system::register("zm_train", &__init__, undefined, undefined);
}

// Namespace namespace_835aa2f1
// Params 0, eflags: 0x1 linked
// Checksum 0x3fa43a3f, Offset: 0xd20
// Size: 0x10
function onplayerconnect() {
    self.var_65f06b5 = 0;
}

// Namespace namespace_835aa2f1
// Params 0, eflags: 0x1 linked
// Checksum 0x43133229, Offset: 0xd38
// Size: 0x1c4
function __init__() {
    callback::on_connect(&onplayerconnect);
    callback::on_spawned(&player_on_spawned);
    namespace_8e578893::function_2d5dfb29(&function_a4a1ecff);
    namespace_8e578893::function_6681ab86(&zombie_init);
    clientfield::register("vehicle", "train_switch_light", 1, 2, "int");
    clientfield::register("scriptmover", "train_callbox_light", 1, 2, "int");
    clientfield::register("scriptmover", "train_map_light", 1, 2, "int");
    clientfield::register("vehicle", "train_rain_fx_occluder", 1, 1, "int");
    clientfield::register("world", "sndTrainVox", 1, 4, "int");
    level.player_intemission_spawn_callback = &player_intemission_spawn_callback;
    thread function_b8c85e5c();
    thread function_eb0db7bc();
    /#
        thread function_6353976e();
    #/
}

// Namespace namespace_835aa2f1
// Params 0, eflags: 0x1 linked
// Checksum 0x68ea01f1, Offset: 0xf08
// Size: 0xac
function function_eb0db7bc() {
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("zones_initialized");
    while (true) {
        level waittill(#"host_migration_end");
        [[ level.var_292a0ac9 ]]->function_aaacaec9();
        [[ level.var_292a0ac9 ]]->function_7eb2583b();
        [[ level.var_292a0ac9 ]]->function_dda9a9d2();
        [[ level.var_292a0ac9 ]]->function_2632b810();
    }
}

// Namespace namespace_835aa2f1
// Params 2, eflags: 0x1 linked
// Checksum 0x49391276, Offset: 0xfc0
// Size: 0xbc
function player_intemission_spawn_callback(origin, angles) {
    var_e97bad1e = undefined;
    self.ground_ent = self getgroundent();
    if (isdefined(self.ground_ent)) {
        if (isvehicle(self.ground_ent) && !(level.zombie_team === self.ground_ent)) {
            var_e97bad1e = self.ground_ent;
        }
    }
    if (isdefined(var_e97bad1e)) {
        self spawn(origin, angles);
    }
}

// Namespace namespace_835aa2f1
// Params 0, eflags: 0x1 linked
// Checksum 0xd73d9d57, Offset: 0x1088
// Size: 0x108
function function_b8c85e5c() {
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("zones_initialized");
    var_fcd89369 = getent("zod_train", "targetname");
    var_fcd89369 function_7465f87();
    var_fcd89369.takedamage = 0;
    var_fcd89369 clientfield::set("train_rain_fx_occluder", 1);
    level.var_292a0ac9 = new class_df2b89fb();
    [[ level.var_292a0ac9 ]]->initialize(var_fcd89369);
    level thread function_da8f624d();
    level.var_33c4ee76 = 0;
}

// Namespace namespace_835aa2f1
// Params 1, eflags: 0x0
// Checksum 0xec474585, Offset: 0x1198
// Size: 0xb6
function function_f37aa349(sn) {
    ents = getentarray();
    foreach (ent in ents) {
        if (ent.script_noteworthy === sn) {
            return ent;
        }
    }
    return undefined;
}

// Namespace namespace_835aa2f1
// Params 0, eflags: 0x1 linked
// Checksum 0xf99bfce4, Offset: 0x1258
// Size: 0x33a
function function_7465f87() {
    trigs = getentarray("train_buyable_weapon", "script_noteworthy");
    foreach (trig in trigs) {
        trig enablelinkto();
        trig linkto(self, "", self worldtolocalcoords(trig.origin), (0, 0, 0));
        trig.weapon = getweapon(trig.zombie_weapon_upgrade);
        trig setcursorhint("HINT_WEAPON", trig.weapon);
        trig.cost = zm_weapons::get_weapon_cost(trig.weapon);
        trig.hint_string = zm_weapons::get_weapon_hint(trig.weapon);
        if (isdefined(level.var_dc23b46e) && level.var_dc23b46e) {
            trig sethintstring(trig.hint_string);
        } else {
            trig.hint_parm1 = trig.cost;
            trig sethintstring(trig.hint_string, trig.hint_parm1);
        }
        self.buyable_weapon = trig;
        level._spawned_wallbuys[level._spawned_wallbuys.size] = trig;
        weapon_model = getent(trig.target, "targetname");
        weapon_model linkto(self, "", self worldtolocalcoords(weapon_model.origin), weapon_model.angles + self.angles);
        weapon_model setmovingplatformenabled(1);
        weapon_model._linked_ent = trig;
        weapon_model show();
        weapon_model thread function_d7993b3d(trig);
    }
}

// Namespace namespace_835aa2f1
// Params 0, eflags: 0x1 linked
// Checksum 0xaa3fe45e, Offset: 0x15a0
// Size: 0x1c
function player_on_spawned() {
    self thread function_69c89e00();
}

// Namespace namespace_835aa2f1
// Params 0, eflags: 0x1 linked
// Checksum 0x64908cd3, Offset: 0x15c8
// Size: 0x142
function function_69c89e00() {
    self endon(#"disconnect");
    self notify(#"hash_69c89e00");
    self endon(#"hash_69c89e00");
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("zones_initialized");
    wait(1);
    wallbuy = level.var_292a0ac9.var_36e768e4.buyable_weapon;
    self notify(#"zm_bgb_secret_shopper", wallbuy);
    self.var_316060b3 = 0;
    while (isdefined(self)) {
        if (isdefined(self.var_65f06b5) && self.var_65f06b5) {
            if (!self.var_316060b3) {
                self notify(#"zm_bgb_secret_shopper", wallbuy);
            }
            wallbuy function_2e9b7fc1(self, wallbuy.weapon);
        } else if (self.var_316060b3) {
            self notify(#"hash_a09e2c64");
        }
        self.var_316060b3 = self.var_65f06b5;
        wait(1);
    }
}

// Namespace namespace_835aa2f1
// Params 2, eflags: 0x1 linked
// Checksum 0x539a5ebf, Offset: 0x1718
// Size: 0x4f8
function function_2e9b7fc1(player, weapon) {
    if (!isdefined(weapon)) {
        weapon = self.weapon;
    }
    player_has_weapon = player zm_weapons::has_weapon_or_upgrade(weapon);
    if (isdefined(level.weapons_using_ammo_sharing) && !player_has_weapon && level.weapons_using_ammo_sharing) {
        shared_ammo_weapon = player zm_weapons::get_shared_ammo_weapon(self.zombie_weapon_upgrade);
        if (isdefined(shared_ammo_weapon)) {
            weapon = shared_ammo_weapon;
            player_has_weapon = 1;
        }
    }
    if (!player_has_weapon) {
        cursor_hint = "HINT_WEAPON";
        cost = zm_weapons::get_weapon_cost(weapon);
        if (isdefined(level.var_dc23b46e) && level.var_dc23b46e) {
            if (player bgb::is_enabled("zm_bgb_secret_shopper") && !zm_weapons::is_wonder_weapon(player.currentweapon)) {
                hint_string = %ZOMBIE_WEAPONCOSTONLY_CFILL_BGB_SECRET_SHOPPER;
                self sethintstringforplayer(player, hint_string);
            } else {
                hint_string = %ZOMBIE_WEAPONCOSTONLY_CFILL;
                self sethintstringforplayer(player, hint_string);
            }
        } else if (player bgb::is_enabled("zm_bgb_secret_shopper") && !zm_weapons::is_wonder_weapon(player.currentweapon)) {
            hint_string = %ZOMBIE_WEAPONCOSTONLYFILL_BGB_SECRET_SHOPPER;
            var_7e03d6a7 = player zm_weapons::get_ammo_cost_for_weapon(player.currentweapon);
            self sethintstringforplayer(player, hint_string, cost, var_7e03d6a7);
        } else {
            hint_string = %ZOMBIE_WEAPONCOSTONLYFILL;
            self sethintstringforplayer(player, hint_string, cost);
        }
    } else {
        if (player bgb::is_enabled("zm_bgb_secret_shopper") && !zm_weapons::is_wonder_weapon(weapon)) {
            ammo_cost = player zm_weapons::get_ammo_cost_for_weapon(weapon);
        } else if (player zm_weapons::has_upgrade(weapon)) {
            ammo_cost = zm_weapons::get_upgraded_ammo_cost(weapon);
        } else {
            ammo_cost = zm_weapons::get_ammo_cost(weapon);
        }
        if (isdefined(level.var_dc23b46e) && level.var_dc23b46e) {
            if (player bgb::is_enabled("zm_bgb_secret_shopper") && !zm_weapons::is_wonder_weapon(player.currentweapon)) {
                hint_string = %ZOMBIE_WEAPONAMMOONLY_CFILL_BGB_SECRET_SHOPPER;
                self sethintstringforplayer(player, hint_string);
            } else {
                hint_string = %ZOMBIE_WEAPONAMMOONLY_CFILL;
                self sethintstringforplayer(player, hint_string);
            }
        } else if (player bgb::is_enabled("zm_bgb_secret_shopper") && !zm_weapons::is_wonder_weapon(player.currentweapon)) {
            hint_string = %ZOMBIE_WEAPONAMMOONLY_BGB_SECRET_SHOPPER;
            var_7e03d6a7 = player zm_weapons::get_ammo_cost_for_weapon(player.currentweapon);
            self sethintstringforplayer(player, hint_string, ammo_cost, var_7e03d6a7);
        } else {
            hint_string = %ZOMBIE_WEAPONAMMOONLY;
            self sethintstringforplayer(player, hint_string, ammo_cost);
        }
    }
    cursor_hint = "HINT_WEAPON";
    cursor_hint_weapon = weapon;
    self setcursorhint(cursor_hint, cursor_hint_weapon);
    return true;
}

// Namespace namespace_835aa2f1
// Params 1, eflags: 0x1 linked
// Checksum 0x619407b6, Offset: 0x1c18
// Size: 0x64
function function_d7993b3d(trigger) {
    self.orgmodel = self.model;
    self setmodel("wpn_t7_none_world");
    trigger waittill(#"trigger");
    self setmodel(self.orgmodel);
}

// Namespace namespace_835aa2f1
// Params 0, eflags: 0x1 linked
// Checksum 0x11518fa2, Offset: 0x1c88
// Size: 0x10
function zombie_init() {
    self.var_e0d198e4 = 0;
}

// Namespace namespace_835aa2f1
// Params 0, eflags: 0x1 linked
// Checksum 0xdd56e2fa, Offset: 0x1ca0
// Size: 0x38
function function_da8f624d() {
    level flag::wait_till("connect_start_to_junction");
    [[ level.var_292a0ac9 ]]->function_2632b810();
}

// Namespace namespace_835aa2f1
// Params 4, eflags: 0x0
// Checksum 0x6822fd88, Offset: 0x8c18
// Size: 0x7e
function function_abec9ef(v1, v2, range, var_5eef24ab) {
    if (abs(v1[2] - v2[2]) > var_5eef24ab) {
        return false;
    }
    return distance2dsquared(v1, v2) < range * range;
}

// Namespace namespace_835aa2f1
// Params 1, eflags: 0x1 linked
// Checksum 0x7b70a744, Offset: 0x8ca0
// Size: 0x32
function function_be4c98a3(var_593a263a) {
    if (!isdefined(var_593a263a)) {
        var_593a263a = 0;
    }
    return [[ level.var_292a0ac9 ]]->function_be4c98a3(1);
}

// Namespace namespace_835aa2f1
// Params 0, eflags: 0x1 linked
// Checksum 0x9c7b626a, Offset: 0x8ce0
// Size: 0x26
function is_moving() {
    if (!isdefined(level.var_292a0ac9)) {
        return 0;
    }
    return [[ level.var_292a0ac9 ]]->is_moving();
}

// Namespace namespace_835aa2f1
// Params 1, eflags: 0x1 linked
// Checksum 0x95c19e39, Offset: 0x8d10
// Size: 0x88
function function_26fcc525(ai) {
    [[ level.var_292a0ac9 ]]->function_c02d34bc();
    spot = [[ level.var_292a0ac9 ]]->function_fc1944ae();
    if (isdefined(spot)) {
        ai.var_3b08716c = spot.str_tag;
        [[ level.var_292a0ac9 ]]->function_fc6b1519(ai, spot.str_tag);
    }
}

// Namespace namespace_835aa2f1
// Params 3, eflags: 0x1 linked
// Checksum 0x514bec09, Offset: 0x8da0
// Size: 0xe8
function function_a4a1ecff(e_attacker, str_means_of_death, weapon) {
    if (isdefined(self)) {
        var_41227048 = 0;
        if (is_moving()) {
            if (self.var_e0d198e4) {
                var_41227048 = 1;
            }
        }
        if (var_41227048) {
            self clientfield::set("zombie_gut_explosion", 1);
            self ghost();
        }
    }
    if (isdefined(level.var_292a0ac9)) {
        if (isdefined(self) && self.var_e0d198e4) {
            [[ level.var_292a0ac9 ]]->function_cc4166eb(self);
            return;
        }
        [[ level.var_292a0ac9 ]]->function_997bcca8();
    }
}

// Namespace namespace_835aa2f1
// Params 0, eflags: 0x1 linked
// Checksum 0xde13bfa5, Offset: 0x8e90
// Size: 0x2a
function function_2fd24d1f() {
    a_zombies = [[ level.var_292a0ac9 ]]->function_f037cd6();
    return a_zombies.size;
}

// Namespace namespace_835aa2f1
// Params 0, eflags: 0x1 linked
// Checksum 0xdaf9ed5d, Offset: 0x8ec8
// Size: 0x18
function function_42f8a1ab() {
    return function_2fd24d1f() >= 6;
}

// Namespace namespace_835aa2f1
// Params 0, eflags: 0x1 linked
// Checksum 0xc4210679, Offset: 0x8ee8
// Size: 0x20
function function_c3bc2ffd() {
    return [[ level.var_292a0ac9 ]]->function_c925ac0d() > 10;
}

/#

    // Namespace namespace_835aa2f1
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9185acab, Offset: 0x8f10
    // Size: 0xdc
    function function_1450b47e() {
        train = getent("sndTrainVox", "sndTrainVox");
        if (isdefined(train)) {
            var_f5aa22ce = train getorigin();
            player = level.players[0];
            if (isdefined(player) && isdefined(var_f5aa22ce)) {
                var_f5aa22ce = (var_f5aa22ce[0], var_f5aa22ce[1], var_f5aa22ce[2] - 100);
                player setorigin(var_f5aa22ce);
            }
        }
    }

    // Namespace namespace_835aa2f1
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5577b68c, Offset: 0x8ff8
    // Size: 0x1f0
    function function_6353976e() {
        setdvar("sndTrainVox", "sndTrainVox");
        adddebugcommand("sndTrainVox");
        adddebugcommand("sndTrainVox");
        adddebugcommand("sndTrainVox");
        adddebugcommand("sndTrainVox");
        adddebugcommand("sndTrainVox");
        adddebugcommand("sndTrainVox");
        adddebugcommand("sndTrainVox");
        adddebugcommand("sndTrainVox");
        while (true) {
            cmd = getdvarstring("sndTrainVox");
            if (cmd != "sndTrainVox") {
                switch (cmd) {
                case 8:
                case 8:
                case 8:
                    break;
                case 8:
                    [[ level.var_292a0ac9 ]]->open_doors();
                    break;
                case 8:
                    [[ level.var_292a0ac9 ]]->close_doors();
                    break;
                case 8:
                    function_1450b47e();
                    break;
                default:
                    break;
                }
                setdvar("sndTrainVox", "sndTrainVox");
            }
            util::wait_network_frame();
        }
    }

#/
