#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scriptbundle_shared;
#using scripts/shared/scene_debug_shared;
#using scripts/shared/player_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#using_animtree("all_player");
#using_animtree("generic");

#namespace scene;

// Namespace scene
// Method(s) 5 Total 70
class class_63342bfd : cscene, cscriptbundlebase {

    // Namespace namespace_63342bfd
    // Params 1, eflags: 0x1 linked
    // Checksum 0x9881489a, Offset: 0xf660
    // Size: 0x1c4
    function play(var_9157bfa6) {
        if (!isdefined(var_9157bfa6)) {
            var_9157bfa6 = "low_alert";
        }
        self notify(#"new_state");
        self endon(#"new_state");
        if (cscene::get_valid_objects().size > 0) {
            foreach (o_obj in self._a_objects) {
                thread [[ o_obj ]]->play(var_9157bfa6);
            }
            level flagsys::set(self._str_name + "_playing");
            self._str_state = "play";
            cscene::function_2f376105();
            thread cscene::_call_state_funcs(var_9157bfa6);
            array::flagsys_wait_any_flag(self._a_objects, "done", "main_done");
            if (cscene::is_looping()) {
                if (cscene::has_init_state()) {
                }
            } else {
                thread cscene::stop();
            }
            return;
        }
        thread cscene::stop(0, 1);
    }

    // Namespace namespace_63342bfd
    // Params 5, eflags: 0x1 linked
    // Checksum 0x919e126f, Offset: 0xf600
    // Size: 0x54
    function init(str_scenedef, s_scenedef, e_align, a_ents, b_test_run) {
        cscene::init(str_scenedef, s_scenedef, e_align, a_ents, b_test_run);
    }

    // Namespace namespace_63342bfd
    // Params 0, eflags: 0x1 linked
    // Checksum 0x327f8b3e, Offset: 0xf5e0
    // Size: 0x14
    function new_object() {
        return new class_c0992da4();
    }

}

// Namespace scene
// Method(s) 50 Total 55
class csceneobject : cscriptbundleobjectbase {

    var current_playing_anim;

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0xbd185af2, Offset: 0xc60
    // Size: 0x38
    function constructor() {
        self._is_valid = 1;
        self._b_spawnonce_used = 0;
        self._b_set_goal = 1;
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x1 linked
    // Checksum 0x74ab899, Offset: 0x71e8
    // Size: 0x54
    function skip_scene(b_wait_one_frame) {
        if (isdefined(b_wait_one_frame)) {
            wait(0.05);
        }
        if (function_2f52c963()) {
            wait(0.05);
        }
        function_390406f();
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3d743f93, Offset: 0x7090
    // Size: 0x14c
    function function_390406f() {
        if (isdefined(self.current_playing_anim)) {
            /#
                if (getdvarint("Align target '") > 0) {
                    printtoprightln("Align target '" + self._s.mainanim + "Align target '" + gettime(), (1, 1, 1));
                }
            #/
            if (is_shared_player()) {
                foreach (player in level.players) {
                    skip_anim_on_server(player, self.current_playing_anim[player getentitynumber()]);
                }
                return;
            }
            skip_anim_on_server(self._e, self.current_playing_anim);
        }
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc8d00c1c, Offset: 0x6f28
    // Size: 0x15c
    function function_2f52c963() {
        if (isdefined(self.current_playing_anim)) {
            /#
                if (getdvarint("Align target '") > 0) {
                    printtoprightln("Align target '" + self._s.mainanim + "Align target '" + gettime(), (0.8, 0.8, 0.8));
                }
            #/
            if (is_shared_player()) {
                foreach (player in level.players) {
                    skip_anim_on_client(player, self.current_playing_anim[player getentitynumber()]);
                }
            } else {
                skip_anim_on_client(self._e, self.current_playing_anim);
            }
            return true;
        }
        return false;
    }

    // Namespace csceneobject
    // Params 2, eflags: 0x5 linked
    // Checksum 0xa770363a, Offset: 0x6e60
    // Size: 0xbc
    function private skip_anim_on_server(entity, anim_name) {
        if (!isdefined(anim_name)) {
            return;
        }
        if (!isdefined(entity)) {
            return;
        }
        if (!entity isplayinganimscripted()) {
            return;
        }
        is_looping = isanimlooping(anim_name);
        if (is_looping) {
            entity animation::stop();
        } else {
            entity setanimtimebyname(anim_name, 1);
        }
        entity stopsounds();
    }

    // Namespace csceneobject
    // Params 2, eflags: 0x5 linked
    // Checksum 0x507b2946, Offset: 0x6dc8
    // Size: 0x8c
    function private skip_anim_on_client(entity, anim_name) {
        if (!isdefined(anim_name)) {
            return;
        }
        if (!isdefined(entity)) {
            return;
        }
        if (!entity isplayinganimscripted()) {
            return;
        }
        is_looping = isanimlooping(anim_name);
        if (is_looping) {
            return;
        }
        entity clientfield::increment("player_scene_animation_skip");
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb07eb728, Offset: 0x6ba8
    // Size: 0x216
    function function_682b419d() {
        if (isdefined(self._s.deletewhenfinished) && isdefined([[ self.var_190b1ea2 ]]->is_skipping_scene()) && !(isdefined(self._s.player) && self._s.player) && !(isdefined(self._s.sharedigc) && self._s.sharedigc) && !(isdefined(self._s.keepwhileskipping) && self._s.keepwhileskipping) && [[ self.var_190b1ea2 ]]->is_skipping_scene() && self._s.deletewhenfinished) {
            if (isdefined(self._s.initanim) && animhasimportantnotifies(self._s.initanim)) {
                return false;
            }
            if (isdefined(self._s.mainanim) && animhasimportantnotifies(self._s.mainanim)) {
                return false;
            }
            if (isdefined(self._s.endanim) && animhasimportantnotifies(self._s.endanim)) {
                return false;
            }
            if (!isspawner(self._e)) {
                b_allows_multiple = [[ scene() ]]->allows_multiple();
                e = scene::get_existing_ent(self._str_name, b_allows_multiple);
                if (isdefined(e)) {
                    return false;
                }
            }
            return true;
        }
        return false;
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x1 linked
    // Checksum 0x857799c5, Offset: 0x6a28
    // Size: 0x176
    function _should_skip_anim(animation) {
        if (isdefined(self._s.deletewhenfinished) && isdefined([[ self.var_190b1ea2 ]]->is_skipping_scene()) && !(isdefined(self._s.player) && self._s.player) && !(isdefined(self._s.sharedigc) && self._s.sharedigc) && !(isdefined(self._s.keepwhileskipping) && self._s.keepwhileskipping) && [[ self.var_190b1ea2 ]]->is_skipping_scene() && self._s.deletewhenfinished) {
            if (!animhasimportantnotifies(animation)) {
                if (!isspawner(self._e)) {
                    b_allows_multiple = [[ scene() ]]->allows_multiple();
                    e = scene::get_existing_ent(self._str_name, b_allows_multiple);
                    if (isdefined(e)) {
                        return false;
                    }
                }
                return true;
            }
        }
        return false;
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0x16d8f436, Offset: 0x69d8
    // Size: 0x44
    function in_a_different_scene() {
        return isdefined(self._e) && isdefined(self._e.current_scene) && self._e.current_scene != self.var_190b1ea2._str_name;
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5b09655e, Offset: 0x6990
    // Size: 0x3a
    function is_shared_player() {
        return isdefined(self._s.sharedigc) && isdefined(self._s.player) && self._s.sharedigc;
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0x732f0216, Offset: 0x6968
    // Size: 0x1c
    function is_player_model() {
        return self._s.type === "player model";
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc429227b, Offset: 0x6948
    // Size: 0x14
    function is_player() {
        return isdefined(self._s.player);
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4efaba94, Offset: 0x6900
    // Size: 0x3c
    function is_alive() {
        return self._e.health > 0 || isdefined(self._e) && self._s.ignorealivecheck === 1;
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb1bd7db9, Offset: 0x68d8
    // Size: 0x1a
    function has_init_state() {
        return self._s scene::_has_init_state();
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0xeb7e7615, Offset: 0x6838
    // Size: 0x94
    function reset_player() {
        level flag::wait_till("all_players_spawned");
        player = self._player;
        player enableusability();
        player enableoffhandweapons();
        player enableweapons();
        player show();
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0x81f5c579, Offset: 0x6490
    // Size: 0x39c
    function function_1b4ec02b() {
        self endon(#"done");
        level flag::wait_till("all_players_spawned");
        player = self._player;
        player hide();
        var_f4f2d282 = player getlinkedent();
        if (isdefined(var_f4f2d282) && var_f4f2d282 == self._e) {
            if (isdefined(self._s.lockview) && self._s.lockview) {
                player playerlinktoabsolute(self._e, "tag_player");
                return;
            }
            player lerpviewangleclamp(0.2, 0.1, 0.1, isdefined(self._s.viewclampright) ? self._s.viewclampright : 0, isdefined(self._s.viewclampleft) ? self._s.viewclampleft : 0, isdefined(self._s.viewclamptop) ? self._s.viewclamptop : 0, isdefined(self._s.viewclampbottom) ? self._s.viewclampbottom : 0);
            return;
        }
        player disableusability();
        player disableoffhandweapons();
        player disableweapons();
        util::wait_network_frame();
        if (self._s.cameratween > 0) {
        }
        player notify(#"hash_f53cf1ea");
        waittillframeend();
        if (isdefined(self._s.lockview) && self._s.lockview) {
            player playerlinktoabsolute(self._e, "tag_player");
        } else {
            player playerlinktodelta(self._e, "tag_player", 1, isdefined(self._s.viewclampright) ? self._s.viewclampright : 0, isdefined(self._s.viewclampleft) ? self._s.viewclampleft : 0, isdefined(self._s.viewclamptop) ? self._s.viewclamptop : 0, isdefined(self._s.viewclampbottom) ? self._s.viewclampbottom : 0, 1, 1);
        }
        wait(self._s.cameratween > 0.2 ? self._s.cameratween : 0.2);
        self._e show();
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0xdf496d71, Offset: 0x6458
    // Size: 0x2c
    function get_camera_tween_out() {
        return isdefined(self._s.cameratweenout) ? self._s.cameratweenout : 0;
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2b82b344, Offset: 0x6420
    // Size: 0x2c
    function get_camera_tween() {
        return isdefined(self._s.cameratween) ? self._s.cameratween : 0;
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0x162e8ab9, Offset: 0x6398
    // Size: 0x7a
    function get_lerp_time() {
        if (isplayer(self._e)) {
            return (isdefined(self._s.lerptime) ? self._s.lerptime : 0);
        }
        return isdefined(self._s.entitylerptime) ? self._s.entitylerptime : 0;
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x1 linked
    // Checksum 0xeab1aa8d, Offset: 0x6310
    // Size: 0x7a
    function regroup_invulnerability(e_player) {
        e_player endon(#"disconnect");
        e_player.ignoreme = 1;
        e_player.b_teleport_invulnerability = 1;
        e_player util::streamer_wait(undefined, 0, 7);
        e_player.ignoreme = 0;
        e_player.b_teleport_invulnerability = undefined;
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x1 linked
    // Checksum 0x79bf1223, Offset: 0x6118
    // Size: 0x1ec
    function play_regroup_fx_for_scene(e_player) {
        align = get_align_ent();
        v_origin = align.origin;
        v_angles = align.angles;
        tag = get_align_tag();
        if (isdefined(tag)) {
            v_origin = align gettagorigin(tag);
            v_angles = align gettagangles(tag);
        }
        v_start = getstartorigin(v_origin, v_angles, self._s.mainanim);
        n_dist_sq = distancesquared(e_player.origin, v_start);
        if ((n_dist_sq > 250000 || isdefined(e_player.hijacked_vehicle_entity)) && !(isdefined(e_player.force_short_scene_transition_effect) && e_player.force_short_scene_transition_effect)) {
            self thread regroup_invulnerability(e_player);
            e_player clientfield::increment_to_player("postfx_igc", 1);
        } else {
            e_player clientfield::increment_to_player("postfx_igc", 3);
        }
        util::wait_network_frame();
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x1 linked
    // Checksum 0x6dd40827, Offset: 0x5980
    // Size: 0x78c
    function _play_shared_player_anim_for_player(player) {
        player endon(#"death");
        /#
        #/
        /#
            if (getdvarint("Align target '") > 0) {
                printtoprightln("Align target '" + self.player_animation);
            }
        #/
        if (!isdefined(self.var_190b1ea2)) {
            return;
        }
        player flagsys::set("shared_igc");
        if (player flagsys::get(self.player_animation_notify)) {
            player flagsys::set(self.player_animation_notify + "_skip_init_clear");
        }
        player flagsys::set(self.player_animation_notify);
        if (isdefined(player getlinkedent())) {
            player unlink();
        }
        if (!(isdefined(self._s.disabletransitionin) && self._s.disabletransitionin)) {
            if (player != self._player || getdvarint("scr_player1_postfx", 0)) {
                if (!isdefined(player.screen_fade_menus)) {
                    if (!(isdefined(level.chyron_text_active) && level.chyron_text_active)) {
                        if (!(isdefined(player.var_6c56bb) && player.var_6c56bb)) {
                            player.play_scene_transition_effect = 1;
                        }
                    }
                }
            }
        }
        player show();
        player setinvisibletoall();
        _prepare_player(player);
        n_time_passed = (gettime() - self.player_start_time) / 1000;
        n_start_time = self.player_time_frac * self.player_animation_length;
        n_time_left = self.player_animation_length - n_time_passed - n_start_time;
        n_time_frac = 1 - n_time_left / self.player_animation_length;
        if (isdefined(self._e) && player != self._e) {
            player dontinterpolate();
            player setorigin(self._e.origin);
            player setplayerangles(self._e getplayerangles());
        }
        n_lerp = get_lerp_time();
        if (!self.var_190b1ea2._s scene::is_igc()) {
            n_camera_tween = get_camera_tween();
            if (n_camera_tween > 0) {
                player startcameratween(n_camera_tween);
            }
        }
        if (n_time_frac < 1) {
            /#
                if (getdvarint("Align target '") > 0) {
                    player hide();
                }
                if (getdvarint("Align target '") > 0) {
                    printtoprightln("Align target '" + self._s.name + "Align target '" + self.player_animation);
                }
            #/
            str_animation = self.player_animation;
            if (player util::is_female()) {
                if (isdefined(self.var_190b1ea2._s.s_female_bundle)) {
                    s_bundle = self.var_190b1ea2._s.s_female_bundle;
                }
            } else if (isdefined(self.var_190b1ea2._s.s_male_bundle)) {
                s_bundle = self.var_190b1ea2._s.s_male_bundle;
            }
            if (isdefined(s_bundle)) {
                foreach (s_object in s_bundle.objects) {
                    if (isdefined(s_object) && s_object.type === "player") {
                        str_animation = s_object.mainanim;
                        break;
                    }
                }
            }
            player_num = player getentitynumber();
            if (!isdefined(self.current_playing_anim)) {
                self.current_playing_anim = [];
            }
            self.current_playing_anim[player_num] = str_animation;
            if (isdefined([[ self.var_190b1ea2 ]]->is_skipping_scene()) && [[ self.var_190b1ea2 ]]->is_skipping_scene()) {
                thread skip_scene(1);
            }
            player animation::play(str_animation, self.player_align, self.player_tag, self.player_rate, 0, 0, n_lerp, n_time_frac, self._s.showweaponinfirstperson);
            if (!player flagsys::get(self.player_animation_notify + "_skip_init_clear")) {
                player flagsys::clear(self.player_animation_notify);
            } else {
                player flagsys::clear(self.player_animation_notify + "_skip_init_clear");
            }
            if (!player isplayinganimscripted()) {
                self.current_playing_anim[player_num] = undefined;
            }
            /#
                if (getdvarint("Align target '") > 0) {
                    printtoprightln("Align target '" + self._s.name + "Align target '" + self.player_animation);
                }
            #/
        }
    }

    // Namespace csceneobject
    // Params 5, eflags: 0x1 linked
    // Checksum 0x1ca0bc2d, Offset: 0x5628
    // Size: 0x350
    function function_d1e0bafa(animation, align, tag, n_rate, n_time) {
        /#
            if (getdvarint("Align target '") > 0) {
                printtoprightln("Align target '" + animation);
            }
        #/
        self.player_animation = animation;
        self.player_animation_notify = animation + "_notify";
        self.player_animation_length = getanimlength(animation);
        self.player_align = align;
        self.player_tag = tag;
        self.player_rate = n_rate;
        self.player_time_frac = n_time;
        self.player_start_time = gettime();
        callback::on_loadout(&_play_shared_player_anim_for_player, self);
        foreach (player in level.players) {
            if (player flagsys::get("loadout_given") && player.sessionstate !== "spectator") {
                self thread _play_shared_player_anim_for_player(player);
                continue;
            }
            if (isdefined(player.initialloadoutgiven) && player.initialloadoutgiven) {
                revive_player(player);
            }
        }
        waittillframeend();
        do {
            b_playing = 0;
            a_players = arraycopy(level.activeplayers);
            foreach (player in a_players) {
                if (isdefined(player) && player flagsys::get(self.player_animation_notify)) {
                    b_playing = 1;
                    player flagsys::wait_till_clear(self.player_animation_notify);
                    break;
                }
            }
        } while (b_playing);
        callback::remove_on_loadout(&_play_shared_player_anim_for_player, self);
        thread [[ self.var_190b1ea2 ]]->_call_state_funcs("players_done");
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2799129b, Offset: 0x5390
    // Size: 0x28e
    function spawn_ent(e) {
        b_disable_throttle = isdefined(self.var_190b1ea2._s.dontthrottle) && (self.var_190b1ea2._s scene::is_igc() || self.var_190b1ea2._s.dontthrottle);
        if (is_player() && !(isdefined(self._s.newplayermethod) && self._s.newplayermethod)) {
            system::wait_till("loadout");
            var_a6193f7e = util::spawn_anim_model(level.var_a2b79791);
            return var_a6193f7e;
        }
        if (isdefined(e)) {
            if (isspawner(e)) {
                /#
                    if (self.var_190b1ea2._testing) {
                        e.count++;
                    }
                #/
                if (!cscriptbundleobjectbase::error(e.count < 1, "Trying to spawn AI for scene with spawner count < 1")) {
                    return e spawner::spawn(1, undefined, undefined, undefined, b_disable_throttle);
                }
            }
            return;
        }
        if (isdefined(self._s.model)) {
            var_2e7c4967 = undefined;
            if (is_player_model()) {
                var_2e7c4967 = util::spawn_anim_player_model(self._s.model, self.var_190b1ea2._e_root.origin, self.var_190b1ea2._e_root.angles);
            } else {
                var_2e7c4967 = util::spawn_anim_model(self._s.model, self.var_190b1ea2._e_root.origin, self.var_190b1ea2._e_root.angles, undefined, !b_disable_throttle);
            }
            return var_2e7c4967;
        }
    }

    // Namespace csceneobject
    // Params 6, eflags: 0x1 linked
    // Checksum 0x78721ee, Offset: 0x4818
    // Size: 0xb6c
    function _play_anim(animation, n_delay_min, n_delay_max, n_rate, n_blend, n_time) {
        if (!isdefined(n_delay_min)) {
            n_delay_min = 0;
        }
        if (!isdefined(n_delay_max)) {
            n_delay_max = 0;
        }
        if (!isdefined(n_rate)) {
            n_rate = 1;
        }
        if (!isdefined(n_blend)) {
            n_blend = 0.2;
        }
        if (!isdefined(n_time)) {
            n_time = 0;
        }
        /#
            if (getdvarint("Align target '") > 0) {
                if (isdefined(self._s.name)) {
                    printtoprightln("Align target '" + self._s.name);
                } else {
                    printtoprightln("Align target '" + self._s.model);
                }
            }
        #/
        if (_should_skip_anim(animation)) {
            return;
        }
        if (n_time != 0) {
            n_time = [[ self.var_190b1ea2 ]]->get_anim_relative_start_time(animation, n_time);
        }
        n_delay = n_delay_min;
        if (n_delay_max > n_delay_min) {
            n_delay = randomfloatrange(n_delay_min, n_delay_max);
        }
        var_60629dda = !(isdefined(self.var_190b1ea2._testing) && self.var_190b1ea2._testing) || isdefined(self._s.doreach) && self._s.doreach && n_time == 0 && getdvarint("scene_test_with_reach", 0);
        _spawn(undefined, !var_60629dda, !var_60629dda);
        if (!isactor(self._e)) {
            var_60629dda = 0;
        }
        if (n_delay > 0) {
            if (n_delay > 0) {
                wait(n_delay);
            }
        }
        if (var_60629dda) {
            [[ scene() ]]->function_2f376105(self);
            if (isdefined(self._s.disablearrivalinreach) && self._s.disablearrivalinreach) {
                self._e animation::reach(animation, get_align_ent(), get_align_tag(), 1);
            } else {
                self._e animation::reach(animation, get_align_ent(), get_align_tag());
            }
            flagsys::set("ready");
        } else if (n_rate > 0) {
            [[ scene() ]]->function_2f376105();
        } else if (isdefined(self._s.aligntarget)) {
            foreach (o_obj in self.var_190b1ea2._a_objects) {
                if (o_obj._str_name == self._s.aligntarget) {
                    o_obj flagsys::wait_till("ready");
                    break;
                }
            }
        }
        if (is_alive()) {
            align = get_align_ent();
            tag = get_align_tag();
            if (align == level) {
                align = (0, 0, 0);
                tag = (0, 0, 0);
            }
            if (is_shared_player()) {
                function_d1e0bafa(animation, align, tag, n_rate, n_time);
            } else {
                if (is_player() && !(isdefined(self._s.newplayermethod) && self._s.newplayermethod)) {
                    thread function_1b4ec02b();
                }
                if (self.var_190b1ea2._s scene::is_igc() || self._e.scene_spawned === self.var_190b1ea2._s.name) {
                    self._e dontinterpolate();
                    self._e show();
                }
                n_lerp = get_lerp_time();
                if (isplayer(self._e) && !self.var_190b1ea2._s scene::is_igc()) {
                    n_camera_tween = get_camera_tween();
                    if (n_camera_tween > 0) {
                        self._e startcameratween(n_camera_tween);
                    }
                }
                if (![[ self.var_190b1ea2 ]]->function_cc8737c()) {
                    n_blend_out = isai(self._e) ? 0.2 : 0;
                } else {
                    n_blend_out = 0;
                }
                if (isdefined(self._s.diewhenfinished) && self._s.diewhenfinished) {
                    n_blend_out = 0;
                }
                /#
                    if (getdvarint("Align target '") > 0) {
                        printtoprightln("Align target '" + (isdefined(self._s.name) ? self._s.name : self._s.model) + "Align target '" + animation);
                    }
                #/
                /#
                    if (getdvarint("Align target '") > 0) {
                        if (!isdefined(level.animation_played)) {
                            level.animation_played = [];
                            animation_played_name = (isdefined(self._s.name) ? self._s.name : self._s.model) + "Align target '" + animation;
                            if (!isdefined(level.animation_played)) {
                                level.animation_played = [];
                            } else if (!isarray(level.animation_played)) {
                                level.animation_played = array(level.animation_played);
                            }
                            level.animation_played[level.animation_played.size] = animation_played_name;
                        }
                    }
                #/
                self.current_playing_anim = animation;
                if (isdefined([[ self.var_190b1ea2 ]]->is_skipping_scene()) && [[ self.var_190b1ea2 ]]->is_skipping_scene() && n_rate != 0) {
                    thread skip_scene(1);
                }
                self._e animation::play(animation, align, tag, n_rate, n_blend, n_blend_out, n_lerp, n_time, self._s.showweaponinfirstperson);
                if (!isdefined(self._e) || !self._e isplayinganimscripted()) {
                    current_playing_anim = undefined;
                }
                /#
                    if (getdvarint("Align target '") > 0) {
                        if (isdefined(level.animation_played)) {
                            for (i = 0; i < level.animation_played.size; i++) {
                                animation_played_name = (isdefined(self._s.name) ? self._s.name : self._s.model) + "Align target '" + animation;
                                if (level.animation_played[i] == animation_played_name) {
                                    arrayremovevalue(level.animation_played, animation_played_name);
                                    i--;
                                }
                            }
                        }
                    }
                #/
                /#
                    if (getdvarint("Align target '") > 0) {
                        printtoprightln("Align target '" + (isdefined(self._s.name) ? self._s.name : self._s.model) + "Align target '" + animation);
                    }
                #/
            }
        } else {
            /#
                cscriptbundleobjectbase::log("Align target '" + animation + "Align target '");
            #/
        }
        self._is_valid = is_alive() && !in_a_different_scene();
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8940e196, Offset: 0x47d0
    // Size: 0x3c
    function function_f79b4451() {
        self endon(#"cleanup");
        self._e endon(#"death");
        self._e waittill(#"goal_changed");
        self._b_set_goal = 0;
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0x543f0381, Offset: 0x46c0
    // Size: 0x104
    function function_c051c7da() {
        if (!(self._e.scene_spawned === self.var_190b1ea2._s.name && isdefined(self._e.target))) {
            if (!isdefined(self._e.script_forcecolor)) {
                if (!self._e flagsys::get("anim_reach")) {
                    if (isdefined(self._e.scenegoal)) {
                        self._e setgoal(self._e.scenegoal);
                        self._e.scenegoal = undefined;
                        return;
                    }
                    if (self._b_set_goal) {
                        self._e setgoal(self._e.origin);
                    }
                }
            }
        }
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa1fc53c2, Offset: 0x44e0
    // Size: 0x1d8
    function _cleanup() {
        if (isdefined(self._e) && isdefined(self._e.current_scene)) {
            self._e flagsys::clear(self.var_190b1ea2._str_name);
            if (self._e.current_scene == self.var_190b1ea2._str_name) {
                self._e flagsys::clear("scene");
                self._e.finished_scene = self.var_190b1ea2._str_name;
                self._e.current_scene = undefined;
                self._e._o_scene = undefined;
                if (is_player()) {
                    if (!(isdefined(self._s.newplayermethod) && self._s.newplayermethod)) {
                        self._e delete();
                        thread reset_player();
                    }
                    self._e.animname = undefined;
                }
            }
        }
        self notify(#"death");
        self endon(#"new_state");
        waittillframeend();
        self notify(#"cleanup");
        if (isai(self._e)) {
            function_c051c7da();
        }
        if (isdefined(self.var_190b1ea2.scene_stopping) && isdefined(self.var_190b1ea2) && self.var_190b1ea2.scene_stopping) {
            self.var_190b1ea2 = undefined;
        }
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc132012f, Offset: 0x43a8
    // Size: 0x12c
    function do_death_anims() {
        ent = self._e;
        if (isai(ent) && !isdefined(self.var_2b1650fa) && !isdefined(self.var_8b281b93)) {
            ent stopanimscripted();
            if (isactor(ent)) {
                ent startragdoll();
            }
        }
        if (isdefined(self.var_2b1650fa)) {
            ent.skipdeath = 1;
            ent animation::play(self.var_2b1650fa, ent, undefined, 1, 0.2, 0);
        }
        if (isdefined(self.var_8b281b93)) {
            ent.skipdeath = 1;
            ent animation::play(self.var_8b281b93, ent, undefined, 1, 0, 0);
        }
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa654074c, Offset: 0x4330
    // Size: 0x6c
    function function_a5418e00() {
        self endon(#"cleanup");
        self._e waittill(#"death");
        if (isdefined(self._e) && !(isdefined(self._e.skipscenedeath) && self._e.skipscenedeath)) {
            self thread do_death_anims();
        }
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0x75bed9a1, Offset: 0x4280
    // Size: 0xa4
    function set_objective() {
        if (!isdefined(self._e.script_objective)) {
            if (isdefined(self.var_190b1ea2._e_root.script_objective)) {
                self._e.script_objective = self.var_190b1ea2._e_root.script_objective;
                return;
            }
            if (isdefined(self.var_190b1ea2._s.script_objective)) {
                self._e.script_objective = self.var_190b1ea2._s.script_objective;
            }
        }
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x1 linked
    // Checksum 0xeb413b55, Offset: 0x3f98
    // Size: 0x2dc
    function function_fc54390f(player) {
        /#
            if (getdvarint("Align target '") > 0) {
                printtoprightln("Align target '");
            }
        #/
        player.scene_set_visible_time = level.time;
        player setvisibletoall();
        player flagsys::clear("shared_igc");
        if (!(isdefined(player.magic_bullet_shield) && player.magic_bullet_shield)) {
            player.allowdeath = 1;
        }
        player.var_dd686719 = undefined;
        player.scene_takedamage = undefined;
        player._scene_old_gun_removed = undefined;
        player thread scene::scene_enable_player_stuff(!(isdefined(self._s.showhud) && self._s.showhud));
        if (![[ self.var_190b1ea2 ]]->function_cc8737c()) {
            if ([[ self.var_190b1ea2 ]]->function_7731633d()) {
                if (![[ self.var_190b1ea2 ]]->is_skipping_scene() && [[ self.var_190b1ea2 ]]->function_e308028()) {
                    [[ self.var_190b1ea2 ]]->function_5a3cff18(0);
                }
                self.var_190b1ea2 thread cscene::_stop_camera_anim_on_player(player);
            } else if (self.var_190b1ea2._s scene::is_igc()) {
                self.var_190b1ea2 thread cscene::_stop_camera_anim_on_player(player);
            }
        }
        n_camera_tween_out = get_camera_tween_out();
        if (n_camera_tween_out > 0) {
            player startcameratween(n_camera_tween_out);
        }
        if (!(isdefined(self._s.dontreloadammo) && self._s.dontreloadammo)) {
            player player::fill_current_clip();
        }
        player allowstand(1);
        player allowcrouch(1);
        player allowprone(1);
        player sethighdetail(0);
    }

    // Namespace csceneobject
    // Params 2, eflags: 0x1 linked
    // Checksum 0xf9181d76, Offset: 0x3888
    // Size: 0x704
    function finish(b_clear, var_f8601b9) {
        if (!isdefined(b_clear)) {
            b_clear = 0;
        }
        if (!isdefined(var_f8601b9)) {
            var_f8601b9 = 0;
        }
        /#
            if (getdvarint("Align target '") > 0) {
                printtoprightln("Align target '" + (isdefined(self._s.name) ? self._s.name : self._s.model));
            }
        #/
        if (isdefined(self._str_state)) {
            self._str_state = undefined;
            self notify(#"new_state");
            if (!is_shared_player() && !is_alive()) {
                _cleanup();
                self._e = undefined;
                self._is_valid = 0;
            } else {
                if (!is_player()) {
                    if (isdefined(self._e.var_9d5136eb)) {
                        self._e.takedamage = self._e.var_9d5136eb;
                    }
                    if (!(isdefined(self._e.magic_bullet_shield) && self._e.magic_bullet_shield)) {
                        self._e.allowdeath = 1;
                    }
                    self._e.var_9d5136eb = undefined;
                    self._e._scene_old_gun_removed = undefined;
                } else if (is_shared_player()) {
                    foreach (player in level.players) {
                        if (player flagsys::get("shared_igc")) {
                            function_fc54390f(player);
                        }
                    }
                } else {
                    player = isplayer(self._player) ? self._player : self._e;
                    function_fc54390f(player);
                }
                if (isdefined(self._s.removeweapon) && self._s.removeweapon && !(isdefined(self._e._scene_old_gun_removed) && self._e._scene_old_gun_removed)) {
                    if (isplayer(self._e)) {
                        /#
                            if (getdvarint("Align target '") > 0) {
                                printtoprightln("Align target '" + (isdefined(self._s.name) ? self._s.name : self._s.model));
                            }
                        #/
                        self._e player::give_back_weapons();
                    } else {
                        /#
                            if (getdvarint("Align target '") > 0) {
                                printtoprightln("Align target '" + (isdefined(self._s.name) ? self._s.name : self._s.model));
                            }
                        #/
                        self._e animation::attach_weapon();
                    }
                }
                if (!isplayer(self._e)) {
                    if (isdefined(self._e)) {
                        self._e sethighdetail(0);
                    }
                }
            }
            flagsys::set("ready");
            flagsys::set("done");
            if (isdefined(self._e)) {
                if (!is_player()) {
                    if (isdefined(self._s.deletewhenfinished) && self._s.deletewhenfinished || is_alive() && b_clear) {
                        self._e thread scene::synced_delete();
                    } else if (isdefined(self._s.diewhenfinished) && is_alive() && self._s.diewhenfinished && !var_f8601b9) {
                        self._e.skipdeath = 1;
                        self._e.allowdeath = 1;
                        self._e.skipscenedeath = 1;
                        self._e kill();
                    }
                }
                if (isactor(self._e) && isalive(self._e)) {
                    if (isdefined(self._s.delaymovementatend) && self._s.delaymovementatend) {
                        self._e pathmode("move delayed", 1, randomfloatrange(2, 3));
                    } else {
                        self._e pathmode("move allowed");
                    }
                    if (isdefined(self._s.lookatplayer) && self._s.lookatplayer) {
                        self._e lookatentity();
                    }
                }
            }
            _cleanup();
        }
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x1 linked
    // Checksum 0xdeccd62e, Offset: 0x3750
    // Size: 0x12c
    function set_player_stance(player) {
        if (self._s.playerstance === "crouch") {
            player allowstand(0);
            player allowcrouch(1);
            player allowprone(0);
            return;
        }
        if (self._s.playerstance === "prone") {
            player allowstand(0);
            player allowcrouch(0);
            player allowprone(1);
            return;
        }
        player allowstand(1);
        player allowcrouch(0);
        player allowprone(0);
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe0ce13f3, Offset: 0x36e0
    // Size: 0x64
    function revive_player(player) {
        if (player.sessionstate === "spectator") {
            player thread [[ level.spawnplayer ]]();
            return;
        }
        if (player laststand::player_is_in_laststand()) {
            player notify(#"auto_revive");
        }
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8e965a82, Offset: 0x3140
    // Size: 0x594
    function _prepare_player(player) {
        /#
            if (getdvarint("Align target '") > 0) {
                printtoprightln("Align target '");
            }
        #/
        if (isdefined(player.play_scene_transition_effect) && player.play_scene_transition_effect) {
            player.play_scene_transition_effect = undefined;
            play_regroup_fx_for_scene(player);
        }
        if (player.var_dd686719 === self.var_190b1ea2._str_name) {
            [[ self.var_190b1ea2 ]]->function_a2014270(self, player);
            return 0;
        }
        player sethighdetail(1);
        if (player flagsys::get("mobile_armory_in_use")) {
            player flagsys::set("cancel_mobile_armory");
            player closemenu("ChooseClass_InGame");
            player notify(#"menuresponse", "ChooseClass_InGame", "cancel");
        }
        if (player flagsys::get("mobile_armory_begin_use")) {
            player util::function_ee182f5d();
            player flagsys::clear("mobile_armory_begin_use");
        }
        if (getdvarint("scene_hide_player") > 0) {
            player hide();
        }
        player.var_dd686719 = self.var_190b1ea2._str_name;
        if (!(isdefined(player.magic_bullet_shield) && player.magic_bullet_shield)) {
            player.allowdeath = isdefined(self._s.allowdeath) && self._s.allowdeath;
        }
        player.scene_takedamage = isdefined(self._s.takedamage) && self._s.takedamage;
        if (isdefined(player.hijacked_vehicle_entity)) {
            player.hijacked_vehicle_entity delete();
        } else if (player isinvehicle()) {
            vh_occupied = player getvehicleoccupied();
            n_seat = vh_occupied getoccupantseat(player);
            vh_occupied usevehicle(player, n_seat);
        }
        revive_player(player);
        player thread scene::scene_disable_player_stuff(!(isdefined(self._s.showhud) && self._s.showhud));
        if (isdefined(self._s.var_4c0453af) && self._s.var_4c0453af) {
        }
        player.player_anim_look_enabled = !(isdefined(self._s.lockview) && self._s.lockview);
        player.player_anim_clamp_right = isdefined(self._s.viewclampright) ? self._s.viewclampright : 0;
        player.player_anim_clamp_left = isdefined(self._s.viewclampleft) ? self._s.viewclampleft : 0;
        player.player_anim_clamp_top = isdefined(self._s.viewclampbottom) ? self._s.viewclampbottom : 0;
        player.player_anim_clamp_bottom = isdefined(self._s.viewclampbottom) ? self._s.viewclampbottom : 0;
        if (isdefined(self._s.showweaponinfirstperson) && (!(isdefined(self._s.removeweapon) && self._s.removeweapon) || self._s.showweaponinfirstperson) && !(isdefined(self._s.disableprimaryweaponswitch) && self._s.disableprimaryweaponswitch)) {
            player player::switch_to_primary_weapon(1);
        }
        set_player_stance(player);
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0xdf620025, Offset: 0x2810
    // Size: 0x928
    function _prepare() {
        if (isdefined(self._s.dynamicpaths) && self._s.dynamicpaths && self._str_state == "play") {
            self._e.scene_orig_origin = self._e.origin;
            self._e connectpaths();
        }
        if (self._e.current_scene === self.var_190b1ea2._str_name) {
            [[ self.var_190b1ea2 ]]->function_a2014270(self, self._e);
            return 0;
        }
        self._e endon(#"death");
        if (!(isdefined(self._s.ignorealivecheck) && self._s.ignorealivecheck) && cscriptbundleobjectbase::error(isai(self._e) && !isalive(self._e), "Trying to play a scene on a dead AI.")) {
            return;
        }
        if (isdefined(self._e._o_scene)) {
            foreach (obj in self._e._o_scene._a_objects) {
                if (obj._e === self._e) {
                    [[ obj ]]->finish();
                    break;
                }
            }
        }
        if (!isai(self._e) && !isplayer(self._e)) {
            if (!is_player() || !(isdefined(self._s.newplayermethod) && self._s.newplayermethod)) {
                if (is_player_model()) {
                    scene::prepare_player_model_anim(self._e);
                } else {
                    scene::prepare_generic_model_anim(self._e);
                }
            }
        }
        if (!is_player()) {
            if (!isdefined(self._e.var_9d5136eb)) {
                self._e.var_9d5136eb = self._e.takedamage;
            }
            if (issentient(self._e)) {
                self._e.takedamage = isdefined(self._s.takedamage) && isdefined(self._e.takedamage) && self._e.takedamage && self._s.takedamage;
                if (!(isdefined(self._e.magic_bullet_shield) && self._e.magic_bullet_shield)) {
                    self._e.allowdeath = isdefined(self._s.allowdeath) && self._s.allowdeath;
                }
                if (isdefined(self._s.overrideaicharacter) && self._s.overrideaicharacter) {
                    self._e detachall();
                    self._e setmodel(self._s.model);
                }
            } else {
                self._e.health = self._e.health > 0 ? self._e.health : 1;
                if (self._s.type === "actor") {
                    self._e makefakeai();
                    if (!(isdefined(self._s.removeweapon) && self._s.removeweapon)) {
                        self._e animation::attach_weapon(getweapon("ar_standard"));
                    }
                }
                self._e.takedamage = isdefined(self._s.takedamage) && self._s.takedamage;
                self._e.allowdeath = isdefined(self._s.allowdeath) && self._s.allowdeath;
            }
            set_objective();
            if (isdefined(self._s.dynamicpaths) && self._s.dynamicpaths) {
                self._e disconnectpaths(2, 0);
            }
        } else if (!is_shared_player()) {
            player = isplayer(self._player) ? self._player : self._e;
            _prepare_player(player);
        }
        if (isdefined(self._s.removeweapon) && self._s.removeweapon) {
            if (!(isdefined(self._e.gun_removed) && self._e.gun_removed)) {
                if (isplayer(self._e)) {
                    self._e player::take_weapons();
                } else {
                    self._e animation::detach_weapon();
                }
            } else {
                self._e._scene_old_gun_removed = 1;
            }
        }
        self._e.animname = self._str_name;
        self._e.anim_debug_name = self._s.name;
        self._e flagsys::set("scene");
        self._e flagsys::set(self.var_190b1ea2._str_name);
        self._e.current_scene = self.var_190b1ea2._str_name;
        self._e.finished_scene = undefined;
        self._e._o_scene = scene();
        [[ self.var_190b1ea2 ]]->function_a2014270(self, self._e);
        if (isdefined(self._e.takedamage) && self._e.takedamage) {
            thread function_6bfe1ac1();
            thread function_a5418e00();
        }
        if (isactor(self._e)) {
            thread function_f79b4451();
            if (isdefined(self._s.lookatplayer) && self._s.lookatplayer) {
                self._e lookatentity(level.activeplayers[0]);
            }
        }
        if (self.var_190b1ea2._s scene::is_igc() || [[ self.var_190b1ea2 ]]->has_player()) {
            if (!isplayer(self._e)) {
                self._e sethighdetail(1);
            }
        }
        return 1;
    }

    // Namespace csceneobject
    // Params 3, eflags: 0x1 linked
    // Checksum 0x8f747061, Offset: 0x20b0
    // Size: 0x754
    function _spawn(e_spawner, b_hide, var_338df934) {
        if (!isdefined(b_hide)) {
            b_hide = 1;
        }
        if (!isdefined(var_338df934)) {
            var_338df934 = 1;
        }
        if (isdefined(e_spawner)) {
            self._e = e_spawner;
        }
        if (isdefined(self._e.isdying) && isdefined(self._e) && self._e.isdying) {
            self._e delete();
        }
        if (is_player()) {
            if (isplayer(self._e)) {
                self._player = self._e;
            } else {
                n_player = getdvarint("scene_debug_player", 0);
                if (n_player > 0) {
                    n_player--;
                    if (n_player == self._s.player) {
                        self._player = level.activeplayers[0];
                    }
                } else {
                    self._player = level.activeplayers[self._s.player];
                }
            }
        }
        b_skip = self._s.type === "actor" && issubstr(self.var_190b1ea2._str_mode, "noai");
        b_skip = self._s.type === "player" && (b_skip || issubstr(self.var_190b1ea2._str_mode, "noplayers"));
        if (!b_skip && function_682b419d()) {
            b_skip = 1;
        }
        if (!b_skip) {
            if (isdefined(self._s.newplayermethod) && !isdefined(self._e) && is_player() && self._s.newplayermethod) {
                self._e = self._player;
            } else if (!isdefined(self._e) || isspawner(self._e)) {
                b_allows_multiple = [[ scene() ]]->allows_multiple();
                if (cscriptbundleobjectbase::error(isdefined(self._s.nospawn) && b_allows_multiple && self._s.nospawn, "Scene that allow multiple instances must be allowed to spawn (uncheck 'Do Not Spawn').")) {
                    return;
                }
                if (!isspawner(self._e)) {
                    e = scene::get_existing_ent(self._str_name, b_allows_multiple);
                    if (!isdefined(e) && isdefined(self._s.name)) {
                        e = scene::get_existing_ent(self._s.name, b_allows_multiple);
                    }
                    if (isplayer(e)) {
                        if (!(isdefined(self._s.newplayermethod) && self._s.newplayermethod)) {
                            e = undefined;
                        }
                    }
                    if (!(isdefined(self._s.nospawn) && self._s.nospawn) && !self._b_spawnonce_used || (!isdefined(e) || isspawner(e)) && self.var_190b1ea2._testing) {
                        e_spawned = spawn_ent(e);
                    }
                } else {
                    e_spawned = spawn_ent(self._e);
                }
                if (isdefined(e_spawned)) {
                    if (b_hide && !self.var_190b1ea2._s scene::is_igc()) {
                        e_spawned hide();
                    }
                    e_spawned dontinterpolate();
                    e_spawned.scene_spawned = self.var_190b1ea2._s.name;
                    if (!isdefined(e_spawned.targetname)) {
                        e_spawned.targetname = self._s.name;
                    }
                    if (is_player()) {
                        e_spawned hide();
                    }
                }
                self._e = isdefined(e_spawned) ? e_spawned : e;
                if (isdefined(self._s.var_884f63ad) && self._s.var_884f63ad && self._b_spawnonce_used) {
                    return;
                }
            }
            cscriptbundleobjectbase::error(!isdefined(self._e) || !is_player() && !(isdefined(self._s.nospawn) && self._s.nospawn) && isspawner(self._e), "Object failed to spawn or doesn't exist.");
        }
        if (isdefined(self._e) && !isspawner(self._e)) {
            _prepare();
            if (var_338df934) {
                flagsys::set("ready");
            }
            if (isdefined(self._s.var_884f63ad) && self._s.var_884f63ad) {
                self._b_spawnonce_used = 1;
            }
            return;
        }
        flagsys::set("ready");
        flagsys::set("done");
        finish();
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2068c712, Offset: 0x2090
    // Size: 0x12
    function get_orig_name() {
        return self._s.name;
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe03fa585, Offset: 0x2078
    // Size: 0xa
    function get_name() {
        return self._str_name;
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd934056b, Offset: 0x1f10
    // Size: 0x15c
    function _assign_unique_name() {
        if (is_player()) {
            self._str_name = "player " + self._s.player;
            return;
        }
        if ([[ scene() ]]->allows_multiple()) {
            if (isdefined(self._s.name)) {
                self._str_name = self._s.name + "_gen" + level.var_7e438819;
            } else {
                self._str_name = [[ scene() ]]->get_name() + "_noname" + level.var_7e438819;
            }
            level.var_7e438819++;
            return;
        }
        if (isdefined(self._s.name)) {
            self._str_name = self._s.name;
            return;
        }
        self._str_name = [[ scene() ]]->get_name() + "_noname" + [[ scene() ]]->get_object_id();
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0x823860c5, Offset: 0x1b70
    // Size: 0x394
    function function_6bfe1ac1() {
        self endon(#"play");
        self endon(#"done");
        str_damage_types = (!isdefined(self._s.runsceneondmg0) || self._s.runsceneondmg0 == "none" ? "" : self._s.runsceneondmg0) + (!isdefined(self._s.runsceneondmg1) || self._s.runsceneondmg1 == "none" ? "" : self._s.runsceneondmg1) + (!isdefined(self._s.runsceneondmg2) || self._s.runsceneondmg2 == "none" ? "" : self._s.runsceneondmg2) + (!isdefined(self._s.runsceneondmg3) || self._s.runsceneondmg3 == "none" ? "" : self._s.runsceneondmg3) + (!isdefined(self._s.runsceneondmg4) || self._s.runsceneondmg4 == "none" ? "" : self._s.runsceneondmg4);
        if (str_damage_types != "") {
            var_81c6c482 = 0;
            while (!var_81c6c482) {
                n_amount, e_attacker, v_org, v_dir, str_mod = self._e waittill(#"damage");
                switch (str_mod) {
                case 23:
                case 26:
                    if (issubstr(str_damage_types, "bullet")) {
                        var_81c6c482 = 1;
                    }
                    break;
                case 19:
                case 20:
                case 21:
                    if (issubstr(str_damage_types, "explosive")) {
                        var_81c6c482 = 1;
                    }
                    break;
                case 24:
                case 25:
                    if (issubstr(str_damage_types, "projectile")) {
                        var_81c6c482 = 1;
                    }
                    break;
                case 22:
                    if (issubstr(str_damage_types, "melee")) {
                        var_81c6c482 = 1;
                    }
                    break;
                default:
                    if (issubstr(str_damage_types, "all")) {
                        var_81c6c482 = 1;
                    }
                    break;
                }
            }
            thread [[ scene() ]]->play();
        }
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0x707ff5e8, Offset: 0x1b58
    // Size: 0xa
    function scene() {
        return self.var_190b1ea2;
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0x96e156ce, Offset: 0x1ae0
    // Size: 0x6c
    function get_align_tag() {
        if (isdefined(self._s.aligntargettag)) {
            return self._s.aligntargettag;
        }
        if (isdefined(self.var_190b1ea2._e_root.e_scene_link)) {
            return "tag_origin";
        }
        return self.var_190b1ea2._s.aligntargettag;
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0x589e4bdd, Offset: 0x1910
    // Size: 0x1c4
    function get_align_ent() {
        e_align = undefined;
        if (isdefined(self._s.aligntarget) && !(self._s.aligntarget === self.var_190b1ea2._s.aligntarget)) {
            a_scene_ents = [[ self.var_190b1ea2 ]]->get_ents();
            if (isdefined(a_scene_ents[self._s.aligntarget])) {
                e_align = a_scene_ents[self._s.aligntarget];
            } else {
                e_align = scene::get_existing_ent(self._s.aligntarget, 0, 1);
            }
            if (!isdefined(e_align)) {
                str_msg = "Align target '" + (isdefined(self._s.aligntarget) ? "" + self._s.aligntarget : "") + "' doesn't exist for scene object.";
                if (!cscriptbundleobjectbase::warning(self.var_190b1ea2._testing, str_msg)) {
                    cscriptbundleobjectbase::error(getdvarint("scene_align_errors", 1), str_msg);
                }
            }
        }
        if (!isdefined(e_align)) {
            e_align = [[ scene() ]]->get_align_ent();
        }
        return e_align;
    }

    // Namespace csceneobject
    // Params 3, eflags: 0x1 linked
    // Checksum 0x12ff2a84, Offset: 0x16e8
    // Size: 0x21c
    function stop(b_clear, b_dont_clear_anim, b_finished) {
        if (!isdefined(b_clear)) {
            b_clear = 0;
        }
        if (!isdefined(b_dont_clear_anim)) {
            b_dont_clear_anim = 0;
        }
        if (!isdefined(b_finished)) {
            b_finished = 0;
        }
        /#
            if (getdvarint("Align target '") > 0) {
                printtoprightln("Align target '" + (isdefined(self._s.name) ? self._s.name : self._s.model));
            }
        #/
        if (isalive(self._e)) {
            if (is_shared_player()) {
                foreach (player in level.players) {
                    player stopanimscripted(0.2);
                }
            } else if (!(isdefined(self._s.diewhenfinished) && self._s.diewhenfinished) || !b_finished) {
                if (!b_dont_clear_anim || isplayer(self._e)) {
                    self._e stopanimscripted(0.2);
                }
            }
        }
        finish(b_clear, !b_finished);
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf71b55e7, Offset: 0x1168
    // Size: 0x574
    function play() {
        /#
            if (getdvarint("Align target '") > 0) {
                if (isdefined(self._s.name)) {
                    printtoprightln("Align target '" + self._s.name);
                } else {
                    printtoprightln("Align target '" + self._s.model);
                }
            }
        #/
        flagsys::clear("ready");
        flagsys::clear("done");
        flagsys::clear("main_done");
        self._str_state = "play";
        self notify(#"new_state");
        self endon(#"new_state");
        self notify(#"play");
        cscriptbundleobjectbase::log("play");
        waittillframeend();
        if (isdefined(self._s.hide) && self._s.hide && self._is_valid) {
            _spawn(undefined, 0, 0);
            self._e hide();
        } else if (isdefined(self._s.mainanim) && self._is_valid) {
            self.var_2b1650fa = self._s.var_61fa8991;
            self.var_8b281b93 = self._s.var_fb5e2bab;
            if (!(isdefined(self._s.iscutscene) && self._s.iscutscene)) {
                if (!isdefined(self._s.mainblend) || self._s.mainblend == 0) {
                    self._s.mainblend = 0.2;
                } else if (self._s.mainblend == 0.001) {
                    self._s.mainblend = 0;
                }
            }
            _play_anim(self._s.mainanim, self._s.maindelaymin, self._s.maindelaymax, 1, self._s.mainblend, self.var_190b1ea2.n_start_time);
            flagsys::set("main_done");
            if (isdefined(self._s.dynamicpaths) && isdefined(self._e) && self._s.dynamicpaths) {
                if (distance2dsquared(self._e.origin, self._e.scene_orig_origin) > 4) {
                    self._e disconnectpaths(2, 0);
                }
            }
            if (is_alive()) {
                if (!isdefined(self._s.endblend) || self._s.endblend == 0) {
                    self._s.endblend = 0.2;
                }
                if (isdefined(self._s.endanim)) {
                    self.var_2b1650fa = self._s.var_c3cf2d4b;
                    self.var_8b281b93 = self._s.var_49955765;
                    _play_anim(self._s.endanim, 0, 0, 1, self._s.endblend);
                    if (is_alive()) {
                        if (isdefined(self._s.endanimloop)) {
                            self.var_2b1650fa = self._s.var_f4e2d359;
                            self.var_8b281b93 = self._s.var_ade63ea3;
                            _play_anim(self._s.endanimloop, 0, 0, 1);
                        }
                    }
                } else if (isdefined(self._s.endanimloop)) {
                    self.var_2b1650fa = self._s.var_f4e2d359;
                    self.var_8b281b93 = self._s.var_ade63ea3;
                    _play_anim(self._s.endanimloop, 0, 0, 1);
                }
            }
        }
        thread finish();
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x1 linked
    // Checksum 0x49d97a04, Offset: 0xd18
    // Size: 0x444
    function initialize(var_ef81b034) {
        if (!isdefined(var_ef81b034)) {
            var_ef81b034 = 0;
        }
        if (has_init_state() || var_ef81b034) {
            flagsys::clear("ready");
            flagsys::clear("done");
            flagsys::clear("main_done");
            self._str_state = "init";
            self notify(#"new_state");
            self endon(#"new_state");
            self notify(#"init");
            cscriptbundleobjectbase::log("init");
            waittillframeend();
            if (isdefined(self._s.spawnoninit) && !(isdefined(self._s.sharedigc) && self._s.sharedigc) && !(isdefined(self._s.player) && self._s.player) && self._s.spawnoninit || var_ef81b034) {
                _spawn(undefined, isdefined(self._s.firstframe) && self._s.firstframe || isdefined(self._s.initanim) || isdefined(self._s.initanimloop));
            }
            if (isdefined(self._s.firstframe) && self._s.firstframe || var_ef81b034) {
                if (!cscriptbundleobjectbase::error(!isdefined(self._s.mainanim), "No animation defined for first frame.")) {
                    self.var_2b1650fa = self._s.var_61fa8991;
                    self.var_8b281b93 = self._s.var_fb5e2bab;
                    _play_anim(self._s.mainanim, 0, 0, 0);
                }
            } else if (isdefined(self._s.initanim)) {
                self.var_2b1650fa = self._s.var_3a287d22;
                self.var_8b281b93 = self._s.var_7f7feb44;
                _play_anim(self._s.initanim, self._s.initdelaymin, self._s.initdelaymax, 1);
                if (is_alive()) {
                    if (isdefined(self._s.initanimloop)) {
                        self.var_2b1650fa = self._s.var_a5e2fe8;
                        self.var_8b281b93 = self._s.var_2a207c52;
                        _play_anim(self._s.initanimloop, 0, 0, 1);
                    }
                }
            } else if (isdefined(self._s.initanimloop)) {
                self.var_2b1650fa = self._s.var_a5e2fe8;
                self.var_8b281b93 = self._s.var_2a207c52;
                _play_anim(self._s.initanimloop, self._s.initdelaymin, self._s.initdelaymax, 1);
            }
        } else {
            flagsys::set("ready");
        }
        if (!self._is_valid) {
            flagsys::set("done");
        }
    }

    // Namespace csceneobject
    // Params 3, eflags: 0x1 linked
    // Checksum 0x67f8a621, Offset: 0xcc0
    // Size: 0x4e
    function first_init(s_objdef, o_scene, e_ent) {
        cscriptbundleobjectbase::init(s_objdef, o_scene, e_ent);
        _assign_unique_name();
        return self;
    }

}

// Namespace scene
// Method(s) 61 Total 70
class cscene : cscriptbundlebase {

    var b_player_scene;
    var skipping_scene;

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xdf0f1158, Offset: 0x7d28
    // Size: 0x3c
    function constructor() {
        self._n_object_id = 0;
        self._str_mode = "";
        self._n_streamer_req = -1;
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x7a740448, Offset: 0xd728
    // Size: 0x9e
    function has_player() {
        foreach (obj in self._a_objects) {
            if (obj._s.type === "player") {
                return true;
            }
        }
        return false;
    }

    // Namespace cscene
    // Params 2, eflags: 0x5 linked
    // Checksum 0x3873c558, Offset: 0xd5e0
    // Size: 0x13c
    function private function_a2014270(var_ac574b2f, entity) {
        if (self === var_ac574b2f) {
            if (!is_skipping_scene()) {
                function_5a3cff18(1);
            }
            return;
        }
        if (isplayer(entity)) {
            if (!(isdefined(self._s.disablesceneskipping) && self._s.disablesceneskipping) && !is_skipping_scene()) {
                if ([[ var_ac574b2f ]]->is_shared_player() || self._s scene::is_igc()) {
                    if (isdefined(var_ac574b2f._s.initanim) || self._str_state != "init" || isdefined(var_ac574b2f._s.initanimloop)) {
                        function_5a3cff18(1);
                    }
                }
            }
        }
    }

    // Namespace cscene
    // Params 1, eflags: 0x5 linked
    // Checksum 0x662b861f, Offset: 0xd3b0
    // Size: 0x222
    function private function_5a3cff18(b_started) {
        if (isdefined(b_started) && b_started) {
            scene::function_f69c7a83();
            if (isdefined(level.var_a1d36213)) {
                return;
            }
            self._s.var_ab895d81 = 1;
            if (isdefined(self._s.s_female_bundle)) {
                self._s.s_female_bundle.var_ab895d81 = self._s.var_ab895d81;
            }
            if (isstring(self._s.nextscenebundle)) {
                var_701c98e6 = scene::get_scenedef(self._s.nextscenebundle);
                while (true) {
                    var_701c98e6.var_ab895d81 = self._s.var_ab895d81;
                    if (isdefined(var_701c98e6.s_female_bundle)) {
                        var_701c98e6.s_female_bundle.var_ab895d81 = self._s.var_ab895d81;
                    }
                    if (isstring(var_701c98e6.nextscenebundle)) {
                        var_701c98e6 = scene::get_scenedef(var_701c98e6.nextscenebundle);
                        continue;
                    }
                    break;
                }
            }
            level.var_a1d36213 = 1;
            function_c54dbcf9();
            level notify(#"hash_1c353a4f");
            return;
        }
        if (!isdefined(level.var_a1d36213)) {
            return;
        }
        if (isdefined(self._s.var_ab895d81)) {
            level.var_a1d36213 = undefined;
            function_c54dbcf9();
            level notify(#"hash_14c06c0c", self._s.name);
        }
    }

    // Namespace cscene
    // Params 0, eflags: 0x5 linked
    // Checksum 0x53ff8296, Offset: 0xd358
    // Size: 0x4a
    function private function_c54dbcf9() {
        if (isdefined(self._s.var_ab895d81)) {
            if (isdefined(level.var_a1d36213)) {
                level.var_9d7e58c5 = self._s.name;
                return;
            }
            level.var_9d7e58c5 = undefined;
        }
    }

    // Namespace cscene
    // Params 0, eflags: 0x5 linked
    // Checksum 0x96435e5a, Offset: 0xd330
    // Size: 0x20
    function private function_e308028() {
        return isdefined(level.var_a1d36213) && isdefined(self._s.var_ab895d81);
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xbccc6f8d, Offset: 0xd2b8
    // Size: 0x6e
    function function_76654644() {
        if (isdefined(level.var_cd66d9d1) && !(isdefined(self._s.disablesceneskipping) && self._s.disablesceneskipping) && array::contains(level.var_109c74a6, self._s.name)) {
            return true;
        }
        return false;
    }

    // Namespace cscene
    // Params 0, eflags: 0x5 linked
    // Checksum 0x69921a04, Offset: 0xd160
    // Size: 0x14a
    function private _skip_scene() {
        self endon(#"stopped");
        wait(0.05);
        foreach (o_scene_object in self._a_objects) {
            if (o_scene_object._is_valid) {
                [[ o_scene_object ]]->function_2f52c963();
            }
        }
        wait(0.05);
        foreach (o_scene_object in self._a_objects) {
            if (o_scene_object._is_valid) {
                [[ o_scene_object ]]->function_390406f();
            }
        }
        self notify(#"skip_camera_anims");
    }

    // Namespace cscene
    // Params 0, eflags: 0x5 linked
    // Checksum 0xab0ff12, Offset: 0xcf00
    // Size: 0x254
    function private function_6fb6722f() {
        /#
            if (getdvarint("Align target '") > 0) {
                printtoprightln("Align target '" + gettime(), (1, 0, 0));
            }
        #/
        if (isdefined(level.var_cd66d9d1)) {
            foreach (player in level.players) {
                player clientfield::increment_to_player("player_scene_skip_completed");
                player freezecontrols(0);
                player stopsounds();
            }
            b_player_scene = undefined;
            skipping_scene = undefined;
            level.var_cd66d9d1 = undefined;
            level.var_109c74a6 = undefined;
            function_5a3cff18(0);
            level notify(#"hash_e14d7c6c");
            if (isdefined(level.var_e032f90d)) {
                level thread [[ level.var_e032f90d ]](self._s.name);
            }
            /#
                if (getdvarint("Align target '") > 0) {
                    printtoprightln("Align target '" + gettime());
                }
            #/
            /#
                if (getdvarint("Align target '") == 0) {
                    b_skip_fading = 0;
                } else {
                    b_skip_fading = 1;
                }
            #/
            if (!(isdefined(b_skip_fading) && b_skip_fading)) {
                if (!(isdefined(level.level_ending) && level.level_ending)) {
                    level thread lui::screen_fade(1, 0, 1, "black", 0, "scene_system");
                }
            }
        }
    }

    // Namespace cscene
    // Params 1, eflags: 0x1 linked
    // Checksum 0xfa5ec6bc, Offset: 0xc7d0
    // Size: 0x722
    function skip_scene(var_6b34ddbf) {
        if (isdefined(self._s.disablesceneskipping) && isdefined(var_6b34ddbf) && var_6b34ddbf && self._s.disablesceneskipping) {
            /#
                if (getdvarint("Align target '") > 0) {
                    printtoprightln("Align target '" + self._s.name + "Align target '" + gettime(), (1, 0, 0));
                }
            #/
            function_6fb6722f();
            return;
        }
        /#
            if (getdvarint("Align target '") > 0) {
                printtoprightln("Align target '" + self._s.name + "Align target '" + gettime(), (0, 1, 0));
            }
        #/
        if (!(isdefined(var_6b34ddbf) && var_6b34ddbf)) {
            if (self._str_state == "init") {
                while (self._str_state == "init") {
                    wait(0.05);
                }
            }
            if (is_skipping_player_scene()) {
                /#
                    if (getdvarint("Align target '") > 0) {
                        printtoprightln("Align target '" + gettime());
                    }
                #/
                /#
                    if (getdvarint("Align target '") == 0) {
                        b_skip_fading = 0;
                    } else {
                        b_skip_fading = 1;
                    }
                #/
                if (!(isdefined(b_skip_fading) && b_skip_fading)) {
                    foreach (player in level.players) {
                        player freezecontrols(1);
                    }
                    level.var_840fdf22 = 1;
                    level thread lui::screen_fade(1, 1, 0, "black", 0, "scene_system");
                    wait(1);
                    level.var_840fdf22 = undefined;
                }
                setpauseworld(0);
            }
            while (isdefined(level.var_840fdf22) && level.var_840fdf22) {
                wait(0.05);
            }
        }
        if (isdefined(self._s.nextscenebundle)) {
            var_eb2cccdb = 1;
        } else {
            var_eb2cccdb = 0;
        }
        function_2f376105();
        wait(0.05);
        /#
            if (getdvarint("Align target '") > 0) {
                printtoprightln("Align target '" + self._s.name + "Align target '" + gettime(), (0, 0, 1));
            }
        #/
        _call_state_funcs("skip_started");
        thread _skip_scene();
        /#
            if (getdvarint("Align target '") > 0) {
                printtoprightln("Align target '" + gettime(), (0, 1, 0));
            }
        #/
        /#
            if (getdvarint("Align target '") > 0) {
                if (isdefined(level.animation_played)) {
                    for (i = 0; i < level.animation_played.size; i++) {
                        printtoprightln("Align target '" + level.animation_played[i], (1, 0, 0), -1);
                    }
                }
            }
        #/
        var_aa786a73 = gettime() + 4000;
        while (!(isdefined(self.scene_stopped) && self.scene_stopped) && gettime() < var_aa786a73) {
            wait(0.05);
        }
        /#
            if (getdvarint("Align target '") > 0) {
                printtoprightln("Align target '" + self._s.name + "Align target '" + gettime(), (1, 0.5, 0));
            }
        #/
        _call_state_funcs("skip_completed");
        self notify(#"scene_skip_completed");
        if (!var_eb2cccdb) {
            if (is_skipping_player_scene()) {
                if (isdefined(level.var_109c74a6)) {
                    var_84f532ce = gettime() + 4000;
                    while (level.var_109c74a6.size > 0 && gettime() < var_84f532ce) {
                        wait(0.05);
                    }
                }
                function_6fb6722f();
            } else if (isdefined(self.skipping_scene) && self.skipping_scene) {
                skipping_scene = undefined;
                if (isdefined(level.var_109c74a6)) {
                    arrayremovevalue(level.var_109c74a6, self._s.name);
                }
            }
            return;
        }
        if (is_skipping_player_scene()) {
            if (self._s scene::is_igc()) {
                foreach (player in level.players) {
                    player stopsounds();
                }
            }
        }
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd10977b7, Offset: 0xc670
    // Size: 0x152
    function is_scene_shared() {
        if (!(isdefined(self._s.skip_scene) && self._s.skip_scene) && !self._s scene::is_igc()) {
            foreach (o_scene_object in self._a_objects) {
                if (o_scene_object._is_valid && [[ o_scene_object ]]->is_shared_player()) {
                    var_ce0c77d5 = 1;
                }
            }
            if (!isdefined(var_ce0c77d5)) {
                /#
                    if (getdvarint("Align target '") > 0) {
                        printtoprightln("Align target '" + gettime(), (1, 0, 0));
                    }
                #/
                self notify(#"scene_skip_completed");
                return false;
            }
        }
        return true;
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xbbeafeb1, Offset: 0xc658
    // Size: 0xa
    function get_state() {
        return self._str_state;
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf8f81798, Offset: 0xc638
    // Size: 0x14
    function on_error() {
        stop();
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x7a0bc075, Offset: 0xc538
    // Size: 0xf4
    function get_valid_objects() {
        a_obj = [];
        foreach (obj in self._a_objects) {
            if (obj._is_valid) {
                if (!isdefined(a_obj)) {
                    a_obj = [];
                } else if (!isarray(a_obj)) {
                    a_obj = array(a_obj);
                }
                a_obj[a_obj.size] = obj;
            }
        }
        return a_obj;
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x35d433c4, Offset: 0xc4a8
    // Size: 0x84
    function sync_with_other_scenes() {
        if (!(isdefined(self._s.dontsync) && self._s.dontsync) && isdefined(level.scene_sync_list) && isarray(level.scene_sync_list[self.var_51963144])) {
            wait_till_objects_ready(level.scene_sync_list[self.var_51963144]);
        }
    }

    // Namespace cscene
    // Params 1, eflags: 0x1 linked
    // Checksum 0xf09a4fe0, Offset: 0xc3b0
    // Size: 0xf0
    function wait_till_objects_ready(&array) {
        do {
            var_51b0e732 = 0;
            foreach (ent in array) {
                if (isdefined(ent) && !ent flagsys::get("ready")) {
                    ent util::waittill_either("death", "ready");
                    var_51b0e732 = 1;
                    break;
                }
            }
        } while (var_51b0e732);
    }

    // Namespace cscene
    // Params 2, eflags: 0x1 linked
    // Checksum 0x5f04ba51, Offset: 0xc268
    // Size: 0x13c
    function function_2f376105(o_exclude, var_7c7991dc) {
        if (!isdefined(var_7c7991dc)) {
            var_7c7991dc = 0;
        }
        a_objects = [];
        if (isdefined(o_exclude)) {
            a_objects = array::exclude(self._a_objects, o_exclude);
        } else {
            a_objects = self._a_objects;
        }
        wait_till_objects_ready(a_objects);
        if (self._n_streamer_req != -1) {
            if (!var_7c7991dc) {
                if (isdefined(level.wait_for_streamer_hint_scenes)) {
                    if (isinarray(level.wait_for_streamer_hint_scenes, self._s.name)) {
                        if (!is_skipping_scene()) {
                            level util::streamer_wait(self._n_streamer_req, 0, 5);
                        }
                    }
                }
            }
        }
        flagsys::set("ready");
        sync_with_other_scenes();
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x22f3e629, Offset: 0xc238
    // Size: 0x26
    function is_looping() {
        return isdefined(self._s.looping) && self._s.looping;
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x41a897ec, Offset: 0xc208
    // Size: 0x26
    function allows_multiple() {
        return isdefined(self._s.var_b575b604) && self._s.var_b575b604;
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4a167f39, Offset: 0xc0a0
    // Size: 0x15c
    function get_align_ent() {
        e_align = self._e_root;
        if (isdefined(self._s.aligntarget)) {
            e_gdt_align = scene::get_existing_ent(self._s.aligntarget, 0, 1);
            if (isdefined(e_gdt_align)) {
                e_align = e_gdt_align;
            }
            if (!isdefined(e_gdt_align)) {
                str_msg = "Align target '" + (isdefined(self._s.aligntarget) ? "" + self._s.aligntarget : "") + "' doesn't exist for scene.";
                if (!cscriptbundlebase::warning(self._testing, str_msg)) {
                    cscriptbundlebase::error(getdvarint("scene_align_errors", 1), str_msg);
                }
            }
        } else if (isdefined(self._e_root.e_scene_link)) {
            e_align = self._e_root.e_scene_link;
        }
        return e_align;
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x15c68fcf, Offset: 0xc088
    // Size: 0xa
    function get_root() {
        return self._e_root;
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6f1ab8a6, Offset: 0xbf38
    // Size: 0x144
    function get_ents() {
        a_ents = [];
        foreach (o_obj in self._a_objects) {
            ent = [[ o_obj ]]->get_ent();
            if (isdefined(o_obj._s.name)) {
                a_ents[o_obj._s.name] = ent;
                continue;
            }
            if (!isdefined(a_ents)) {
                a_ents = [];
            } else if (!isarray(a_ents)) {
                a_ents = array(a_ents);
            }
            a_ents[a_ents.size] = ent;
        }
        return a_ents;
    }

    // Namespace cscene
    // Params 1, eflags: 0x1 linked
    // Checksum 0x448415b4, Offset: 0xbbd0
    // Size: 0x360
    function _call_state_funcs(str_state) {
        self endon(#"stopped");
        function_2f376105(undefined, 1);
        if (str_state == "play") {
            waittillframeend();
        }
        level notify(self._str_notify_name + "_" + str_state);
        if (isdefined(level.scene_funcs) && isdefined(level.scene_funcs[self._str_notify_name]) && isdefined(level.scene_funcs[self._str_notify_name][str_state])) {
            a_ents = get_ents();
            foreach (handler in level.scene_funcs[self._str_notify_name][str_state]) {
                func = handler[0];
                args = handler[1];
                switch (args.size) {
                case 6:
                    self._e_root thread [[ func ]](a_ents, args[0], args[1], args[2], args[3], args[4], args[5]);
                    break;
                case 5:
                    self._e_root thread [[ func ]](a_ents, args[0], args[1], args[2], args[3], args[4]);
                    break;
                case 4:
                    self._e_root thread [[ func ]](a_ents, args[0], args[1], args[2], args[3]);
                    break;
                case 3:
                    self._e_root thread [[ func ]](a_ents, args[0], args[1], args[2]);
                    break;
                case 2:
                    self._e_root thread [[ func ]](a_ents, args[0], args[1]);
                    break;
                case 1:
                    self._e_root thread [[ func ]](a_ents, args[0]);
                    break;
                case 0:
                    self._e_root thread [[ func ]](a_ents);
                    break;
                default:
                    /#
                        assertmsg("Align target '");
                    #/
                    break;
                }
            }
        }
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe2f8f6d5, Offset: 0xbb18
    // Size: 0xaa
    function has_init_state() {
        b_has_init_state = 0;
        foreach (o_scene_object in self._a_objects) {
            if ([[ o_scene_object ]]->has_init_state()) {
                b_has_init_state = 1;
                break;
            }
        }
        return b_has_init_state;
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x78e38572, Offset: 0xba88
    // Size: 0x88
    function function_e28db46f() {
        wait(0.05);
        foreach (o_obj in self._a_objects) {
            o_obj.var_190b1ea2 = undefined;
        }
    }

    // Namespace cscene
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb9dfba90, Offset: 0xb588
    // Size: 0x4f4
    function stop(b_clear, b_finished) {
        if (!isdefined(b_clear)) {
            b_clear = 0;
        }
        if (!isdefined(b_finished)) {
            b_finished = 0;
        }
        /#
            if (getdvarint("Align target '") > 0) {
                printtoprightln("Align target '" + self._s.name);
            }
        #/
        if (isdefined(self._str_state)) {
            /#
                if (getdvarint("Align target '") > 0) {
                    printtoprightln("Align target '" + self._s.name + "Align target '" + self._str_state);
                }
            #/
            /#
                if (strstartswith(self._str_mode, "Align target '")) {
                    adddebugcommand("Align target '");
                }
            #/
            if (!b_finished) {
                function_e504d0dc();
            }
            if (!is_skipping_scene()) {
                if (!isdefined(self._s.nextscenebundle) && function_e308028()) {
                    function_5a3cff18(0);
                }
            }
            self thread sync_with_client_scene("stop", b_clear);
            self._str_state = undefined;
            self notify(#"new_state");
            self notify(#"death");
            level flagsys::clear(self._str_name + "_playing");
            level flagsys::clear(self._str_name + "_initialized");
            thread _call_state_funcs("stop");
            self.scene_stopping = 1;
            if (isdefined(self._a_objects) && !b_finished) {
                foreach (o_obj in self._a_objects) {
                    if (isdefined(o_obj) && ![[ o_obj ]]->in_a_different_scene()) {
                        thread [[ o_obj ]]->stop(b_clear);
                    }
                }
            }
            self thread _stop_camera_anims();
            /#
                if (!isdefined(self._s.nextscenebundle) || !b_finished) {
                    destroy_dev_info();
                }
            #/
            /#
                if (getdvarint("Align target '") > 0) {
                    printtoprightln("Align target '" + self._s.name);
                }
            #/
            self.scene_stopped = 1;
            self notify(#"stopped", b_finished);
            remove_from_sync_list();
            arrayremovevalue(level.active_scenes[self._str_name], self._e_root);
            if (level.active_scenes[self._str_name].size == 0) {
                level.active_scenes[self._str_name] = undefined;
            }
            if (isdefined(self._e_root)) {
                arrayremovevalue(self._e_root.scenes, self);
                if (self._e_root.scenes.size == 0) {
                    self._e_root.scenes = undefined;
                }
                self._e_root notify(#"scene_done", self._str_notify_name);
                self._e_root.scene_played = 1;
            }
        }
        if (isdefined(self._s.spectateonjoin) && self._s.spectateonjoin) {
            level.scene_should_spectate_on_hot_join = undefined;
        }
        self thread function_e28db46f();
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x398810e3, Offset: 0xb488
    // Size: 0xf4
    function function_e504d0dc() {
        if (isstring(self._s.var_b8c6ec69)) {
            if (getdvarint("scene_hide_player") > 0) {
                foreach (player in level.players) {
                    player show();
                }
            }
            streamerrequest("clear", self._s.var_b8c6ec69);
        }
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4110a62, Offset: 0xb050
    // Size: 0x42c
    function run_next() {
        /#
            if (getdvarint("Align target '") > 0) {
                printtoprightln("Align target '" + gettime());
            }
        #/
        b_run_next_scene = 0;
        if (isdefined(self._s.nextscenebundle)) {
            b_finished = self waittill(#"stopped");
            if (b_finished) {
                b_skip_scene = is_skipping_scene();
                if (b_skip_scene) {
                    self util::waittill_any_timeout(5, "scene_skip_completed");
                    /#
                        if (getdvarint("Align target '") > 0) {
                            printtoprightln("Align target '" + self._s.nextscenebundle + "Align target '" + gettime(), (1, 1, 0));
                        }
                    #/
                }
                /#
                    if (getdvarint("Align target '") > 0) {
                        printtoprightln("Align target '" + self._s.nextscenebundle + "Align target '" + gettime(), (1, 0, 0));
                    }
                #/
                if (self._s.scenetype == "fxanim" && self._s.nextscenemode === "init") {
                    if (!cscriptbundlebase::error(!has_init_state(), "Scene can't init next scene '" + self._s.nextscenebundle + "' because it doesn't have an init state.")) {
                        if (allows_multiple()) {
                            self._e_root thread scene::init(self._s.nextscenebundle, get_ents());
                        } else {
                            self._e_root thread scene::init(self._s.nextscenebundle);
                        }
                    }
                } else {
                    if (b_skip_scene) {
                        if (is_skipping_player_scene()) {
                            self._str_mode = "skip_scene_player";
                        } else {
                            self._str_mode = "skip_scene";
                        }
                    } else {
                        b_run_next_scene = 1;
                    }
                    if (allows_multiple()) {
                        self._e_root thread scene::play(self._s.nextscenebundle, get_ents(), undefined, undefined, undefined, self._str_mode);
                    } else {
                        self._e_root thread scene::play(self._s.nextscenebundle, undefined, undefined, undefined, undefined, self._str_mode);
                    }
                }
            }
        }
        if (!(isdefined(b_run_next_scene) && b_run_next_scene)) {
            if (!is_skipping_scene()) {
                if (function_e308028()) {
                    function_5a3cff18(0);
                }
            } else if (isdefined(level.var_109c74a6)) {
                arrayremovevalue(level.var_109c74a6, self._s.name);
            }
            function_e504d0dc();
        }
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x24d7ac82, Offset: 0xb030
    // Size: 0x14
    function function_cc8737c() {
        return isdefined(self._s.nextscenebundle);
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6f2e75ae, Offset: 0xafc8
    // Size: 0x5c
    function is_skipping_player_scene() {
        return (isdefined(self.b_player_scene) && self.b_player_scene || self._str_mode == "skip_scene_player") && !array::contains(level.var_109c74a6, self._s.name);
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5cf91db8, Offset: 0xaf60
    // Size: 0x60
    function is_skipping_scene() {
        if (self._s.name == "cin_ram_02_04_interview_part04") {
            return false;
        }
        return isdefined(self.skipping_scene) && self.skipping_scene || self._str_mode == "skip_scene" || self._str_mode == "skip_scene_player";
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5bb01553, Offset: 0xaed8
    // Size: 0x7c
    function destroy_dev_info() {
        if (isdefined(level.hud_scene_dev_info1)) {
            level.hud_scene_dev_info1 destroy();
        }
        if (isdefined(level.hud_scene_dev_info2)) {
            level.hud_scene_dev_info2 destroy();
        }
        if (isdefined(level.hud_scene_dev_info3)) {
            level.hud_scene_dev_info3 destroy();
        }
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x19f69593, Offset: 0xab58
    // Size: 0x374
    function display_dev_info() {
        if (isstring(self._s.devstate) && getdvarint("scr_show_shot_info_for_igcs", 0)) {
            if (!isdefined(level.hud_scene_dev_info1)) {
                level.hud_scene_dev_info1 = newhudelem();
                level.hud_scene_dev_info1.alignx = "right";
                level.hud_scene_dev_info1.aligny = "bottom";
                level.hud_scene_dev_info1.horzalign = "user_right";
                level.hud_scene_dev_info1.y = 400;
                level.hud_scene_dev_info1.fontscale = 1.3;
                level.hud_scene_dev_info1.color = (0.439216, 0.501961, 0.564706);
                level.hud_scene_dev_info1 settext("SCENE: " + toupper(self._s.name));
            }
            if (!isdefined(level.hud_scene_dev_info2)) {
                level.hud_scene_dev_info2 = newhudelem();
                level.hud_scene_dev_info2.alignx = "right";
                level.hud_scene_dev_info2.aligny = "bottom";
                level.hud_scene_dev_info2.horzalign = "user_right";
                level.hud_scene_dev_info2.y = 420;
                level.hud_scene_dev_info2.fontscale = 1.3;
                level.hud_scene_dev_info2.color = (0.439216, 0.501961, 0.564706);
            }
            level.hud_scene_dev_info2 settext("SHOT: " + toupper(self._s.name));
            if (!isdefined(level.hud_scene_dev_info3)) {
                level.hud_scene_dev_info3 = newhudelem();
                level.hud_scene_dev_info3.alignx = "right";
                level.hud_scene_dev_info3.aligny = "bottom";
                level.hud_scene_dev_info3.horzalign = "user_right";
                level.hud_scene_dev_info3.y = 440;
                level.hud_scene_dev_info3.fontscale = 1.3;
                level.hud_scene_dev_info3.color = (0.439216, 0.501961, 0.564706);
                level.hud_scene_dev_info3 settext("STATE: " + toupper(self._s.devstate));
            }
            return;
        }
        destroy_dev_info();
    }

    // Namespace cscene
    // Params 1, eflags: 0x1 linked
    // Checksum 0xfc66b766, Offset: 0xa978
    // Size: 0x1d4
    function _stop_camera_anim_on_player(player) {
        player endon(#"disconnect");
        if (isstring(self._s.cameraswitcher)) {
            player endon(#"new_camera_switcher");
            player dontinterpolate();
            endcamanimscripted(player);
            player thread scene::scene_enable_player_stuff();
            if (!(isdefined(self._s.var_9ad1643e) && self._s.var_9ad1643e)) {
                callback::remove_on_loadout(&_play_camera_anim_on_player_callback, self);
            }
        }
        if (isstring(self._s.extracamswitcher1)) {
            endextracamanimscripted(player, 0);
        }
        if (isstring(self._s.extracamswitcher2)) {
            endextracamanimscripted(player, 1);
        }
        if (isstring(self._s.extracamswitcher3)) {
            endextracamanimscripted(player, 2);
        }
        if (isstring(self._s.extracamswitcher4)) {
            endextracamanimscripted(player, 3);
        }
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1d1a0185, Offset: 0xa868
    // Size: 0x102
    function _stop_camera_anims() {
        if (!(isdefined(self.played_camera_anims) && self.played_camera_anims)) {
            return;
        }
        level notify(#"stop_camera_anims");
        var_10d363af = [];
        if (isdefined(self.var_da698d8f)) {
            var_10d363af = self.var_da698d8f;
        } else {
            var_10d363af = getplayers();
        }
        foreach (player in var_10d363af) {
            if (isdefined(player)) {
                self thread _stop_camera_anim_on_player(player);
            }
        }
    }

    // Namespace cscene
    // Params 5, eflags: 0x1 linked
    // Checksum 0xcc122e63, Offset: 0xa7f8
    // Size: 0x64
    function function_db4c202(player, n_index, var_907b78ac, v_origin, v_angles) {
        self.played_camera_anims = 1;
        extracamanimscripted(player, n_index, var_907b78ac, gettime(), v_origin, v_angles);
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xdaa6866e, Offset: 0xa7a0
    // Size: 0x50
    function loop_camera_anim_to_set_up_for_capture() {
        level endon(#"stop_camera_anims");
        while (true) {
            _play_camera_anims();
            _wait_for_camera_animation(self._s.cameraswitcher);
        }
    }

    // Namespace cscene
    // Params 4, eflags: 0x1 linked
    // Checksum 0x86172340, Offset: 0xa678
    // Size: 0x11c
    function _play_camera_anim_on_player(player, v_origin, v_angles, ignore_initial_notetracks) {
        player notify(#"new_camera_switcher");
        player dontinterpolate();
        player thread scene::scene_disable_player_stuff();
        self.played_camera_anims = 1;
        n_start_time = self.camera_start_time;
        if (!isdefined(self._s.cameraswitchergraphiccontents) || ismature(player)) {
            camanimscripted(player, self._s.cameraswitcher, n_start_time, v_origin, v_angles);
            return;
        }
        camanimscripted(player, self._s.cameraswitchergraphiccontents, n_start_time, v_origin, v_angles);
    }

    // Namespace cscene
    // Params 1, eflags: 0x1 linked
    // Checksum 0x6350baae, Offset: 0xa630
    // Size: 0x3c
    function _play_camera_anim_on_player_callback(player) {
        self thread _play_camera_anim_on_player(player, self.camera_v_origin, self.camera_v_angles, 1);
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8b1484db, Offset: 0xa1b8
    // Size: 0x46c
    function _play_camera_anims() {
        level endon(#"stop_camera_anims");
        waittillframeend();
        e_align = get_align_ent();
        v_origin = isdefined(e_align.origin) ? e_align.origin : (0, 0, 0);
        v_angles = isdefined(e_align.angles) ? e_align.angles : (0, 0, 0);
        var_10d363af = [];
        if (isdefined(self._s.var_9ad1643e) && self._s.var_9ad1643e) {
            foreach (o_obj in self._a_objects) {
                if (isdefined(o_obj) && [[ o_obj ]]->is_player() && ![[ o_obj ]]->is_shared_player()) {
                    if (!isdefined(var_10d363af)) {
                        var_10d363af = [];
                    } else if (!isarray(var_10d363af)) {
                        var_10d363af = array(var_10d363af);
                    }
                    var_10d363af[var_10d363af.size] = o_obj._player;
                }
            }
            if (var_10d363af.size == 0) {
                var_10d363af = level.players;
            } else {
                self.var_da698d8f = var_10d363af;
            }
        } else {
            var_10d363af = level.players;
        }
        if (isstring(self._s.cameraswitcher)) {
            if (!(isdefined(self._s.var_9ad1643e) && self._s.var_9ad1643e)) {
                callback::on_loadout(&_play_camera_anim_on_player_callback, self);
            }
            self.camera_v_origin = v_origin;
            self.camera_v_angles = v_angles;
            self.camera_start_time = gettime();
            array::thread_all_ents(var_10d363af, &_play_camera_anim_on_player, v_origin, v_angles, 0);
            /#
                display_dev_info();
            #/
        }
        if (isstring(self._s.extracamswitcher1)) {
            array::thread_all_ents(var_10d363af, &function_db4c202, 0, self._s.extracamswitcher1, v_origin, v_angles);
        }
        if (isstring(self._s.extracamswitcher2)) {
            array::thread_all_ents(var_10d363af, &function_db4c202, 1, self._s.extracamswitcher2, v_origin, v_angles);
        }
        if (isstring(self._s.extracamswitcher3)) {
            array::thread_all_ents(var_10d363af, &function_db4c202, 2, self._s.extracamswitcher3, v_origin, v_angles);
        }
        if (isstring(self._s.extracamswitcher4)) {
            array::thread_all_ents(var_10d363af, &function_db4c202, 3, self._s.extracamswitcher4, v_origin, v_angles);
        }
    }

    // Namespace cscene
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7a2fe463, Offset: 0xa130
    // Size: 0x7c
    function _wait_for_camera_animation(str_cam, n_start_time) {
        self endon(#"skip_camera_anims");
        if (iscamanimlooping(str_cam)) {
            level waittill(#"forever");
            return;
        }
        function_a2ba9e8d(getcamanimtime(str_cam) / 1000, n_start_time);
    }

    // Namespace cscene
    // Params 2, eflags: 0x1 linked
    // Checksum 0xf9ddb393, Offset: 0xa068
    // Size: 0xc0
    function function_a2ba9e8d(n_time, n_start_time) {
        if (!isdefined(n_start_time)) {
            n_start_time = 0;
        }
        n_len = n_time - n_time * n_start_time;
        n_len /= 0.05;
        n_len_int = int(n_len);
        if (n_len_int != n_len) {
            n_len = floor(n_len);
        }
        n_server_length = n_len * 0.05;
        wait(n_server_length);
    }

    // Namespace cscene
    // Params 4, eflags: 0x1 linked
    // Checksum 0x7b93e10e, Offset: 0x92d8
    // Size: 0xd84
    function play(str_state, a_ents, b_testing, str_mode) {
        if (!isdefined(str_state)) {
            str_state = "play";
        }
        if (!isdefined(b_testing)) {
            b_testing = 0;
        }
        if (!isdefined(str_mode)) {
            str_mode = "";
        }
        /#
            if (getdvarint("Align target '") > 0) {
                printtoprightln("Align target '" + self._s.name);
            }
        #/
        self notify(#"new_state");
        self endon(#"new_state");
        if (str_mode == "skip_scene") {
            thread skip_scene(1);
        } else if (str_mode == "skip_scene_player") {
            self.b_player_scene = 1;
            thread skip_scene(1);
        } else if (!is_skipping_scene() && function_e308028() && !is_scene_shared()) {
            function_5a3cff18(0);
        }
        function_c54dbcf9();
        self._testing = b_testing;
        self._str_mode = str_mode;
        if (isdefined(self._s.spectateonjoin) && self._s.spectateonjoin) {
            level.scene_should_spectate_on_hot_join = 1;
        }
        assign_ents(a_ents);
        if (strstartswith(self._str_mode, "capture")) {
            if (get_valid_objects().size) {
                foreach (o_obj in self._a_objects) {
                    thread [[ o_obj ]]->initialize(1);
                }
            }
            thread loop_camera_anim_to_set_up_for_capture();
            var_25ac9a87 = level.players[0];
            v_origin = get_align_ent().origin;
            if (!isdefined(var_25ac9a87.var_5de38e4)) {
                var_25ac9a87.var_5de38e4 = util::spawn_model("tag_origin", v_origin);
                var_25ac9a87 setorigin(v_origin);
                var_25ac9a87 linkto(level.players[0].var_5de38e4);
            } else {
                var_25ac9a87.var_5de38e4.origin = v_origin;
            }
            wait(15);
            thread _stop_camera_anims();
        }
        self thread sync_with_client_scene("play", b_testing);
        self.n_start_time = 0;
        if (issubstr(str_mode, "skipto")) {
            args = strtok(str_mode, ":");
            if (isdefined(args[1])) {
                self.n_start_time = float(args[1]);
            } else {
                self.n_start_time = 0.95;
            }
            self.var_24424892 = 0;
            foreach (s_obj in self._a_objects) {
                if (isdefined(s_obj._s.mainanim)) {
                    anim_length = getanimlength(s_obj._s.mainanim);
                    if (anim_length > self.var_24424892) {
                        self.var_24424892 = anim_length;
                    }
                }
            }
        }
        if (get_valid_objects().size || self._s scene::is_igc()) {
            level flagsys::set(self._str_name + "_playing");
            self._str_state = "play";
            foreach (o_obj in self._a_objects) {
                thread [[ o_obj ]]->play();
            }
            function_2f376105();
            level flagsys::set(self._str_notify_name + "_ready");
            if (strstartswith(self._str_mode, "capture")) {
                /#
                    adddebugcommand("Align target '" + self._str_name + "Align target '" + self._str_name);
                #/
            }
            if (self.n_start_time == 0) {
                self thread _play_camera_anims();
            }
            /#
                if (is_scene_shared()) {
                    display_dev_info();
                }
            #/
            if (self._n_streamer_req != -1 && !is_skipping_scene()) {
                streamerrequest("play", self._s.streamerhint);
            }
            thread _call_state_funcs("play");
            if (self._s scene::is_igc()) {
                if (!(isdefined(self._s.disablesceneskipping) && self._s.disablesceneskipping) && self._str_state != "init") {
                    function_a2014270(self);
                }
                if (isstring(self._s.cameraswitcher)) {
                    _wait_for_camera_animation(self._s.cameraswitcher, self.n_start_time);
                } else if (isstring(self._s.extracamswitcher1)) {
                    _wait_for_camera_animation(self._s.extracamswitcher1, self.n_start_time);
                } else if (isstring(self._s.extracamswitcher2)) {
                    _wait_for_camera_animation(self._s.extracamswitcher2, self.n_start_time);
                } else if (isstring(self._s.extracamswitcher3)) {
                    _wait_for_camera_animation(self._s.extracamswitcher3, self.n_start_time);
                } else if (isstring(self._s.extracamswitcher4)) {
                    _wait_for_camera_animation(self._s.extracamswitcher4, self.n_start_time);
                }
                foreach (o_obj in self._a_objects) {
                    thread [[ o_obj ]]->stop(0, isdefined(o_obj._s.var_323df155) && o_obj._s.var_323df155, 1);
                }
                self._e_root notify(#"scene_done", self._str_notify_name);
                thread _call_state_funcs("done");
                if (isdefined(self._s.spectateonjoin) && self._s.spectateonjoin) {
                    level.scene_should_spectate_on_hot_join = undefined;
                }
            } else {
                array::flagsys_wait_any_flag(self._a_objects, "done", "main_done");
                if (isdefined(self._e_root)) {
                    self._e_root notify(#"scene_done", self._str_notify_name);
                }
                thread _call_state_funcs("done");
                if (isdefined(self._s.spectateonjoin) && self._s.spectateonjoin) {
                    level.scene_should_spectate_on_hot_join = undefined;
                }
                array::flagsys_wait(self._a_objects, "done");
            }
            if (is_looping() || strendswith(self._str_mode, "loop")) {
                if (has_init_state()) {
                    level flagsys::clear(self._str_name + "_playing");
                    thread initialize();
                } else {
                    level flagsys::clear(self._str_name + "_initialized");
                    thread play(str_state, undefined, b_testing, str_mode);
                }
            } else {
                if (!strendswith(self._str_mode, "single")) {
                    thread run_next();
                } else {
                    if (!is_skipping_scene()) {
                        if (function_e308028()) {
                            function_5a3cff18(0);
                        }
                    } else if (isdefined(level.var_109c74a6)) {
                        arrayremovevalue(level.var_109c74a6, self._s.name);
                    }
                    function_e504d0dc();
                }
                if (!self._s scene::is_igc() || !(isdefined(self._s.var_ea1477ee) && self._s.var_ea1477ee)) {
                    thread stop(0, 1);
                }
            }
            return;
        }
        thread stop(0, 1);
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x580c2457, Offset: 0x9198
    // Size: 0x136
    function function_7731633d() {
        var_a9b98bb6 = -1;
        var_4d27ae8d = -1;
        foreach (obj in self._a_objects) {
            if (isdefined(obj._s.mainanim)) {
                anim_length = getanimlength(obj._s.mainanim);
            }
            if (obj._s.type === "player") {
                var_4d27ae8d = anim_length;
            }
            if (anim_length > var_a9b98bb6) {
                var_a9b98bb6 = anim_length;
            }
        }
        return var_4d27ae8d < var_a9b98bb6;
    }

    // Namespace cscene
    // Params 2, eflags: 0x1 linked
    // Checksum 0x196ede29, Offset: 0x9098
    // Size: 0xf8
    function get_anim_relative_start_time(animation, n_time) {
        if (!isdefined(self.n_start_time) || self.n_start_time == 0 || !isdefined(self.var_24424892) || self.var_24424892 == 0) {
            return n_time;
        }
        anim_length = getanimlength(animation);
        is_looping = isanimlooping(animation);
        n_time = self.var_24424892 / anim_length * n_time;
        if (is_looping) {
            if (n_time > 0.95) {
                n_time = 0.95;
            }
        } else if (n_time > 0.99) {
            n_time = 0.99;
        }
        return n_time;
    }

    // Namespace cscene
    // Params 1, eflags: 0x1 linked
    // Checksum 0x45ddeaeb, Offset: 0x8f80
    // Size: 0x10c
    function get_objects(str_type) {
        a_ret = [];
        foreach (obj in self._a_objects) {
            if (obj._s.type == str_type) {
                if (!isdefined(a_ret)) {
                    a_ret = [];
                } else if (!isarray(a_ret)) {
                    a_ret = array(a_ret);
                }
                a_ret[a_ret.size] = obj;
            }
        }
        return a_ret;
    }

    // Namespace cscene
    // Params 1, eflags: 0x1 linked
    // Checksum 0x6d65a597, Offset: 0x8f38
    // Size: 0x3a
    function _is_ent_vehicle(ent) {
        return isvehicle(ent) || isvehiclespawner(ent);
    }

    // Namespace cscene
    // Params 1, eflags: 0x1 linked
    // Checksum 0x643ea8a6, Offset: 0x8ef0
    // Size: 0x3a
    function _is_ent_actor(ent) {
        return isactor(ent) || isactorspawner(ent);
    }

    // Namespace cscene
    // Params 1, eflags: 0x1 linked
    // Checksum 0x741af0f0, Offset: 0x8ec0
    // Size: 0x22
    function _is_ent_player(ent) {
        return isplayer(ent);
    }

    // Namespace cscene
    // Params 4, eflags: 0x1 linked
    // Checksum 0x2b723095, Offset: 0x8d38
    // Size: 0x180
    function _assign_ents_by_type(&a_objects, &a_ents, str_type, func_test) {
        if (a_ents.size) {
            a_objects_of_type = get_objects(str_type);
            if (a_objects_of_type.size) {
                foreach (ent in arraycopy(a_ents)) {
                    if (isdefined(func_test) && [[ func_test ]](ent)) {
                        obj = array::pop_front(a_objects_of_type);
                        if (isdefined(obj)) {
                            obj._e = ent;
                            arrayremovevalue(a_ents, ent, 1);
                            arrayremovevalue(a_objects, obj);
                            continue;
                        }
                        break;
                    }
                }
            }
        }
        return a_ents.size;
    }

    // Namespace cscene
    // Params 2, eflags: 0x1 linked
    // Checksum 0x6ab56b48, Offset: 0x8a90
    // Size: 0x2a0
    function _assign_ents_by_name(&a_objects, &a_ents) {
        if (a_ents.size) {
            foreach (str_name, e_ent in arraycopy(a_ents)) {
                foreach (i, o_obj in arraycopy(a_objects)) {
                    if (isdefined(o_obj._s.name) && (isdefined(o_obj._s.name) ? "" + o_obj._s.name : "") == tolower(isdefined(str_name) ? "" + str_name : "")) {
                        o_obj._e = e_ent;
                        arrayremoveindex(a_ents, str_name, 1);
                        arrayremoveindex(a_objects, i);
                        break;
                    }
                }
            }
            /#
                foreach (i, ent in a_ents) {
                    cscriptbundlebase::error(isstring(i), "Align target '" + i + "Align target '");
                }
            #/
        }
        return a_ents.size;
    }

    // Namespace cscene
    // Params 1, eflags: 0x1 linked
    // Checksum 0x1fa40692, Offset: 0x8870
    // Size: 0x216
    function assign_ents(a_ents) {
        if (!isdefined(a_ents)) {
            a_ents = [];
        } else if (!isarray(a_ents)) {
            a_ents = array(a_ents);
        }
        a_objects = arraycopy(self._a_objects);
        if (_assign_ents_by_name(a_objects, a_ents)) {
            if (_assign_ents_by_type(a_objects, a_ents, "player", &_is_ent_player)) {
                if (_assign_ents_by_type(a_objects, a_ents, "actor", &_is_ent_actor)) {
                    if (_assign_ents_by_type(a_objects, a_ents, "vehicle", &_is_ent_vehicle)) {
                        if (_assign_ents_by_type(a_objects, a_ents, "prop")) {
                            foreach (ent in a_ents) {
                                obj = array::pop(a_objects);
                                if (!cscriptbundlebase::error(!isdefined(obj), "No scene object to assign entity too.  You might have passed in more than the scene supports.")) {
                                    obj._e = ent;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Namespace cscene
    // Params 2, eflags: 0x1 linked
    // Checksum 0x5de58e10, Offset: 0x8700
    // Size: 0x164
    function sync_with_client_scene(str_state, b_test_run) {
        if (!isdefined(b_test_run)) {
            b_test_run = 0;
        }
        if (self._s.vmtype == "both" && !self._s scene::is_igc()) {
            self endon(#"new_state");
            function_2f376105();
            n_val = undefined;
            if (b_test_run) {
                switch (str_state) {
                case 72:
                    n_val = 3;
                    break;
                case 5:
                    n_val = 4;
                    break;
                case 7:
                    n_val = 5;
                    break;
                }
            } else {
                switch (str_state) {
                case 72:
                    n_val = 0;
                    break;
                case 5:
                    n_val = 1;
                    break;
                case 7:
                    n_val = 2;
                    break;
                }
            }
            level clientfield::set(self._s.name, n_val);
        }
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf449872a, Offset: 0x86e0
    // Size: 0x12
    function get_object_id() {
        self._n_object_id++;
        return self._n_object_id;
    }

    // Namespace cscene
    // Params 2, eflags: 0x1 linked
    // Checksum 0x920c9a5b, Offset: 0x8500
    // Size: 0x1d4
    function initialize(a_ents, b_playing) {
        if (!isdefined(b_playing)) {
            b_playing = 0;
        }
        self notify(#"new_state");
        self endon(#"new_state");
        self thread sync_with_client_scene("init", self._testing);
        assign_ents(a_ents);
        if (get_valid_objects().size > 0) {
            level flagsys::set(self._str_name + "_initialized");
            self._str_state = "init";
            foreach (o_obj in self._a_objects) {
                thread [[ o_obj ]]->initialize();
            }
        }
        if (!b_playing) {
            thread _call_state_funcs("init");
        }
        function_2f376105();
        level flagsys::set(self._str_notify_name + "_ready");
        array::flagsys_wait(self._a_objects, "done");
        thread stop();
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf324064d, Offset: 0x8358
    // Size: 0x19c
    function get_valid_object_defs() {
        a_obj_defs = [];
        foreach (s_obj in self._s.objects) {
            if (self._s.vmtype == "server" || s_obj.vmtype == "server") {
                if (isdefined(s_obj.name) || isdefined(s_obj.model) || isdefined(s_obj.initanim) || isdefined(s_obj.mainanim)) {
                    if (!(isdefined(s_obj.disabled) && s_obj.disabled)) {
                        if (!isdefined(a_obj_defs)) {
                            a_obj_defs = [];
                        } else if (!isarray(a_obj_defs)) {
                            a_obj_defs = array(a_obj_defs);
                        }
                        a_obj_defs[a_obj_defs.size] = s_obj;
                    }
                }
            }
        }
        return a_obj_defs;
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb65273d4, Offset: 0x8338
    // Size: 0x14
    function new_object() {
        return new csceneobject();
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4f49ce4f, Offset: 0x82b8
    // Size: 0x74
    function remove_from_sync_list() {
        if (isdefined(level.scene_sync_list) && isdefined(level.scene_sync_list[self.var_51963144])) {
            arrayremovevalue(level.scene_sync_list[self.var_51963144], self);
            if (!level.scene_sync_list[self.var_51963144].size) {
                level.scene_sync_list[self.var_51963144] = undefined;
            }
        }
    }

    // Namespace cscene
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf34fe90, Offset: 0x8240
    // Size: 0x6c
    function add_to_sync_list() {
        if (!isdefined(level.scene_sync_list)) {
            level.scene_sync_list = [];
        }
        if (!isdefined(level.scene_sync_list[self.var_51963144])) {
            level.scene_sync_list[self.var_51963144] = [];
        }
        array::add(level.scene_sync_list[self.var_51963144], self, 0);
    }

    // Namespace cscene
    // Params 5, eflags: 0x1 linked
    // Checksum 0x563fcb33, Offset: 0x7d90
    // Size: 0x4a4
    function init(str_scenedef, s_scenedef, e_align, a_ents, b_test_run) {
        /#
            if (getdvarint("Align target '") > 0) {
                printtoprightln("Align target '" + str_scenedef);
            }
            if (isdefined(level.var_3f831f3b["Align target '"][s_scenedef.name])) {
                level.var_3f831f3b["Align target '"][s_scenedef.name].used = 1;
            }
        #/
        cscriptbundlebase::init(str_scenedef, s_scenedef, b_test_run);
        if (isdefined(s_scenedef.streamerhint) && s_scenedef.streamerhint != "" && !is_skipping_scene()) {
            self._n_streamer_req = streamerrequest("set", s_scenedef.streamerhint);
        }
        self._str_notify_name = isstring(self._s.malebundle) ? self._s.malebundle : self._str_name;
        if (!isdefined(a_ents)) {
            a_ents = [];
        } else if (!isarray(a_ents)) {
            a_ents = array(a_ents);
        }
        if (!cscriptbundlebase::error(a_ents.size > self._s.objects.size, "Trying to use more entities than scene supports.")) {
            self._e_root = e_align;
            if (!isdefined(level.active_scenes[self._str_name])) {
                level.active_scenes[self._str_name] = [];
            } else if (!isarray(level.active_scenes[self._str_name])) {
                level.active_scenes[self._str_name] = array(level.active_scenes[self._str_name]);
            }
            level.active_scenes[self._str_name][level.active_scenes[self._str_name].size] = self._e_root;
            if (!isdefined(self._e_root.scenes)) {
                self._e_root.scenes = [];
            } else if (!isarray(self._e_root.scenes)) {
                self._e_root.scenes = array(self._e_root.scenes);
            }
            self._e_root.scenes[self._e_root.scenes.size] = self;
            a_objs = get_valid_object_defs();
            foreach (s_obj in a_objs) {
                cscriptbundlebase::add_object([[ new_object() ]]->first_init(s_obj, self));
            }
            self.var_51963144 = gettime();
            if (!(isdefined(self._s.dontsync) && self._s.dontsync)) {
                add_to_sync_list();
            }
            self thread initialize(a_ents);
        }
    }

}

// Namespace scene
// Method(s) 5 Total 56
class class_c0992da4 : cscriptbundleobjectbase, csceneobject {

    // Namespace namespace_c0992da4
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf822e1fb, Offset: 0xe908
    // Size: 0xbc
    function function_208f989e() {
        self endon(#"play");
        self endon(#"done");
        var_48cfed9f = self._e waittill(#"alert");
        /#
            if (getdvarint("Align target '", 0)) {
                print3d(self._e.origin, "Align target '", (1, 0, 0), 1, 0.5, 20);
            }
        #/
        thread [[ csceneobject::scene() ]]->play(var_48cfed9f);
    }

    // Namespace namespace_c0992da4
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8e41c8c0, Offset: 0xe8b8
    // Size: 0x44
    function _prepare() {
        if (csceneobject::_prepare()) {
            if (isai(self._e)) {
                thread function_208f989e();
            }
        }
    }

    // Namespace namespace_c0992da4
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb31ac001, Offset: 0xe610
    // Size: 0x29c
    function play(var_48cfed9f) {
        flagsys::clear("ready");
        flagsys::clear("done");
        flagsys::clear("main_done");
        self._str_state = "play";
        self notify(#"new_state");
        self endon(#"new_state");
        self notify(#"play");
        cscriptbundleobjectbase::log("play");
        waittillframeend();
        switch (var_48cfed9f) {
        case 111:
            cscriptbundleobjectbase::log("LOW ALERT");
            if (isdefined(self._s.var_a7fbafbe)) {
                self.var_2b1650fa = self._s.var_bded27a8;
                self.var_8b281b93 = self._s.var_b8f17412;
                csceneobject::_play_anim(self._s.var_a7fbafbe);
            }
            break;
        case 110:
            cscriptbundleobjectbase::log("HIGH ALERT");
            if (isdefined(self._s.var_f024885a)) {
                self.var_2b1650fa = self._s.var_95122da4;
                self.var_8b281b93 = self._s.var_366413f6;
                csceneobject::_play_anim(self._s.var_f024885a);
            }
            break;
        case 109:
            cscriptbundleobjectbase::log("COMBAT ALERT");
            if (isdefined(self._s.var_41fa8106)) {
                self.var_2b1650fa = self._s.var_6c542070;
                self.var_8b281b93 = self._s.var_fd0f79ea;
                csceneobject::_play_anim(self._s.var_41fa8106);
            }
            break;
        default:
            cscriptbundleobjectbase::error(1, "Unsupported alert state");
            break;
        }
        thread csceneobject::finish();
    }

}

// Namespace scene
// Params 1, eflags: 0x5 linked
// Checksum 0xcc50c126, Offset: 0xba0
// Size: 0x58
function private prepare_player_model_anim(ent) {
    if (!(ent.animtree === "all_player")) {
        ent useanimtree(#all_player);
        ent.animtree = "all_player";
    }
}

// Namespace scene
// Params 1, eflags: 0x5 linked
// Checksum 0x60e80e8a, Offset: 0xc00
// Size: 0x58
function private prepare_generic_model_anim(ent) {
    if (!(ent.animtree === "generic")) {
        ent useanimtree(#generic);
        ent.animtree = "generic";
    }
}

// Namespace scene
// Params 3, eflags: 0x1 linked
// Checksum 0x3478fc9d, Offset: 0x107a0
// Size: 0x362
function get_existing_ent(str_name, b_spawner_only, b_nodes_and_structs) {
    if (!isdefined(b_spawner_only)) {
        b_spawner_only = 0;
    }
    if (!isdefined(b_nodes_and_structs)) {
        b_nodes_and_structs = 0;
    }
    e = undefined;
    if (b_spawner_only) {
        e_array = getspawnerarray(str_name, "script_animname");
        if (e_array.size == 0) {
            e_array = getspawnerarray(str_name, "targetname");
        }
        /#
            assert(e_array.size <= 1, "Align target '");
        #/
        foreach (ent in e_array) {
            if (!isdefined(ent.isdying)) {
                e = ent;
                break;
            }
        }
    } else {
        e = getent(str_name, "animname", 0);
        if (!is_valid_ent(e)) {
            e = getent(str_name, "script_animname");
            if (!is_valid_ent(e)) {
                e = getent(str_name + "_ai", "targetname", 1);
                if (!is_valid_ent(e)) {
                    e = getent(str_name + "_vh", "targetname", 1);
                    if (!is_valid_ent(e)) {
                        e = getent(str_name, "targetname", 1);
                        if (!is_valid_ent(e)) {
                            e = getent(str_name, "targetname");
                            if (!is_valid_ent(e) && b_nodes_and_structs) {
                                e = getnode(str_name, "targetname");
                                if (!is_valid_ent(e)) {
                                    e = struct::get(str_name, "targetname");
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if (!is_valid_ent(e)) {
        e = undefined;
    }
    return e;
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0x27c29796, Offset: 0x10b10
// Size: 0x5c
function is_valid_ent(ent) {
    return !isdefined(ent.isdying) && !ent ai::is_dead_sentient() || isdefined(ent) && self._s.ignorealivecheck === 1;
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0x1b69815, Offset: 0x10b78
// Size: 0x194
function synced_delete() {
    self endon(#"death");
    self.isdying = 1;
    if (isdefined(self.targetname)) {
        self.targetname += "_sync_deleting";
    }
    if (isdefined(self.animname)) {
        self.animname += "_sync_deleting";
    }
    if (isdefined(self.script_animname)) {
        self.script_animname += "_sync_deleting";
    }
    if (!isplayer(self)) {
        sethideonclientwhenscriptedanimcompleted(self);
        self stopanimscripted();
    } else {
        wait(0.05);
        self ghost();
    }
    self notsolid();
    if (isalive(self)) {
        if (issentient(self)) {
            self.ignoreall = 1;
        }
        if (isactor(self)) {
            self pathmode("dont move");
        }
    }
    wait(1);
    self delete();
}

// Namespace scene
// Params 0, eflags: 0x2
// Checksum 0xeffeee90, Offset: 0x10d18
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("scene", &__init__, &__main__, undefined);
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0x2d9ebb0a, Offset: 0x10d60
// Size: 0x83c
function __init__() {
    level.var_7e438819 = 0;
    level.active_scenes = [];
    level.sceneskippedcount = 0;
    level.wait_for_streamer_hint_scenes = [];
    streamerrequest("clear");
    foreach (s_scenedef in struct::get_script_bundles("scene")) {
        s_scenedef.editaction = undefined;
        s_scenedef.newobject = undefined;
        if (isstring(s_scenedef.femalebundle)) {
            s_female_bundle = struct::get_script_bundle("scene", s_scenedef.femalebundle);
            s_female_bundle.malebundle = s_scenedef.name;
            s_scenedef.s_female_bundle = s_female_bundle;
            s_female_bundle.s_male_bundle = s_scenedef;
        }
        if (isstring(s_scenedef.nextscenebundle)) {
            foreach (i, s_object in s_scenedef.objects) {
                if (s_object.type === "player") {
                    s_object.disabletransitionout = 1;
                }
            }
            s_next_bundle = struct::get_script_bundle("scene", s_scenedef.nextscenebundle);
            s_next_bundle.dontsync = 1;
            foreach (i, s_object in s_next_bundle.objects) {
                if (s_object.type === "player") {
                    s_object.disabletransitionin = 1;
                }
                s_object.iscutscene = 1;
            }
            if (isdefined(s_next_bundle.femalebundle)) {
                s_next_female_bundle = struct::get_script_bundle("scene", s_next_bundle.femalebundle);
                if (isdefined(s_next_female_bundle)) {
                    s_next_female_bundle.dontsync = 1;
                    foreach (i, s_object in s_next_female_bundle.objects) {
                        if (s_object.type === "player") {
                            s_object.disabletransitionin = 1;
                        }
                        s_object.iscutscene = 1;
                    }
                }
            }
        }
        if (isstring(s_scenedef.streamerhint)) {
            var_701c98e6 = s_scenedef;
            while (true) {
                var_701c98e6.var_b8c6ec69 = s_scenedef.streamerhint;
                if (isstring(var_701c98e6.nextscenebundle)) {
                    var_701c98e6 = struct::get_script_bundle("scene", var_701c98e6.nextscenebundle);
                    continue;
                }
                break;
            }
        }
        foreach (s_object in s_scenedef.objects) {
            if (s_object.type === "player") {
                if (!isdefined(s_object.cameratween)) {
                    s_object.cameratween = 0;
                }
                if (isdefined(s_object.player)) {
                    s_object.player--;
                } else {
                    s_object.player = 0;
                }
                s_object.name = "player " + s_object.player + 1;
                s_object.newplayermethod = 1;
                continue;
            }
            s_object.player = undefined;
        }
        if (s_scenedef.vmtype == "both" && !s_scenedef is_igc()) {
            n_clientbits = getminbitcountfornum(3);
            /#
                n_clientbits = getminbitcountfornum(6);
            #/
            clientfield::register("world", s_scenedef.name, 1, n_clientbits, "int");
        }
    }
    clientfield::register("toplayer", "postfx_igc", 1, 2, "counter");
    clientfield::register("world", "in_igc", 1, 4, "int");
    clientfield::register("toplayer", "player_scene_skip_completed", 1, 2, "counter");
    clientfield::register("allplayers", "player_scene_animation_skip", 1, 2, "counter");
    clientfield::register("actor", "player_scene_animation_skip", 1, 2, "counter");
    clientfield::register("vehicle", "player_scene_animation_skip", 1, 2, "counter");
    clientfield::register("scriptmover", "player_scene_animation_skip", 1, 2, "counter");
    callback::on_connect(&on_player_connect);
    callback::on_disconnect(&on_player_disconnect);
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0xe695983f, Offset: 0x115a8
// Size: 0x182
function remove_invalid_scene_objects(s_scenedef) {
    a_invalid_object_indexes = [];
    foreach (i, s_object in s_scenedef.objects) {
        if (!isdefined(s_object.name) && !isdefined(s_object.model) && !(s_object.type === "player")) {
            if (!isdefined(a_invalid_object_indexes)) {
                a_invalid_object_indexes = [];
            } else if (!isarray(a_invalid_object_indexes)) {
                a_invalid_object_indexes = array(a_invalid_object_indexes);
            }
            a_invalid_object_indexes[a_invalid_object_indexes.size] = i;
        }
    }
    for (i = a_invalid_object_indexes.size - 1; i >= 0; i--) {
        arrayremoveindex(s_scenedef.objects, a_invalid_object_indexes[i]);
    }
    return s_scenedef;
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0x9e97626d, Offset: 0x11738
// Size: 0x394
function __main__() {
    a_instances = arraycombine(struct::get_array("scriptbundle_scene", "classname"), struct::get_array("scriptbundle_fxanim", "classname"), 0, 0);
    foreach (s_instance in a_instances) {
        if (isdefined(s_instance.linkto)) {
            s_instance thread _scene_link();
        }
        if (isdefined(s_instance.script_flag_set)) {
            level flag::init(s_instance.script_flag_set);
        }
        if (isdefined(s_instance.scriptgroup_initscenes)) {
            foreach (trig in getentarray(s_instance.scriptgroup_initscenes, "scriptgroup_initscenes")) {
                s_instance thread _trigger_init(trig);
            }
        }
        if (isdefined(s_instance.scriptgroup_playscenes)) {
            foreach (trig in getentarray(s_instance.scriptgroup_playscenes, "scriptgroup_playscenes")) {
                s_instance thread _trigger_play(trig);
            }
        }
        if (isdefined(s_instance.scriptgroup_stopscenes)) {
            foreach (trig in getentarray(s_instance.scriptgroup_stopscenes, "scriptgroup_stopscenes")) {
                s_instance thread _trigger_stop(trig);
            }
        }
    }
    level thread on_load_wait();
    level thread run_instances();
}

// Namespace scene
// Params 0, eflags: 0x5 linked
// Checksum 0x6284ffd, Offset: 0x11ad8
// Size: 0xbc
function private _scene_link() {
    self.e_scene_link = util::spawn_model("tag_origin", self.origin, self.angles);
    e_linkto = getent(self.linkto, "linkname");
    self.e_scene_link linkto(e_linkto);
    util::waittill_any_ents_two(self, "death", e_linkto, "death");
    self.e_scene_link delete();
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0x28242682, Offset: 0x11ba0
// Size: 0x44
function on_load_wait() {
    util::wait_network_frame();
    util::wait_network_frame();
    level flagsys::set("scene_on_load_wait");
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0x6ed72079, Offset: 0x11bf0
// Size: 0x11a
function run_instances() {
    foreach (s_instance in struct::get_script_bundle_instances("scene")) {
        if (isdefined(s_instance.spawnflags) && (s_instance.spawnflags & 2) == 2) {
            s_instance thread play();
            continue;
        }
        if (isdefined(s_instance.spawnflags) && (s_instance.spawnflags & 1) == 1) {
            s_instance thread init();
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0x1c41b7fe, Offset: 0x11d18
// Size: 0xac
function _trigger_init(trig) {
    trig endon(#"death");
    trig trigger::wait_till();
    a_ents = [];
    if (get_player_count(self.scriptbundlename) > 0) {
        if (isplayer(trig.who)) {
            a_ents[0] = trig.who;
        }
    }
    self thread _init_instance(undefined, a_ents);
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0xc091bc64, Offset: 0x11dd0
// Size: 0xf6
function _trigger_play(trig) {
    trig endon(#"death");
    do {
        trig trigger::wait_till();
        a_ents = [];
        if (get_player_count(self.scriptbundlename) > 0) {
            if (isplayer(trig.who)) {
                a_ents[0] = trig.who;
            }
        }
        self thread play(a_ents);
    } while (isdefined(get_scenedef(self.scriptbundlename).looping) && get_scenedef(self.scriptbundlename).looping);
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0xbf9f1dc, Offset: 0x11ed0
// Size: 0x44
function _trigger_stop(trig) {
    trig endon(#"death");
    trig trigger::wait_till();
    self thread stop();
}

// Namespace scene
// Params 4, eflags: 0x21 linked
// Checksum 0x9fab0840, Offset: 0x11f20
// Size: 0x12c
function add_scene_func(str_scenedef, func, str_state, ...) {
    if (!isdefined(str_state)) {
        str_state = "play";
    }
    /#
        /#
            assert(isdefined(get_scenedef(str_scenedef)), "Align target '" + str_scenedef + "Align target '");
        #/
    #/
    if (!isdefined(level.scene_funcs)) {
        level.scene_funcs = [];
    }
    if (!isdefined(level.scene_funcs[str_scenedef])) {
        level.scene_funcs[str_scenedef] = [];
    }
    if (!isdefined(level.scene_funcs[str_scenedef][str_state])) {
        level.scene_funcs[str_scenedef][str_state] = [];
    }
    array::add(level.scene_funcs[str_scenedef][str_state], array(func, vararg), 0);
}

// Namespace scene
// Params 3, eflags: 0x1 linked
// Checksum 0xa5c585e7, Offset: 0x12058
// Size: 0x14e
function remove_scene_func(str_scenedef, func, str_state) {
    if (!isdefined(str_state)) {
        str_state = "play";
    }
    /#
        /#
            assert(isdefined(get_scenedef(str_scenedef)), "Align target '" + str_scenedef + "Align target '");
        #/
    #/
    if (!isdefined(level.scene_funcs)) {
        level.scene_funcs = [];
    }
    if (isdefined(level.scene_funcs[str_scenedef]) && isdefined(level.scene_funcs[str_scenedef][str_state])) {
        for (i = level.scene_funcs[str_scenedef][str_state].size - 1; i >= 0; i--) {
            if (level.scene_funcs[str_scenedef][str_state][i][0] == func) {
                arrayremoveindex(level.scene_funcs[str_scenedef][str_state], i);
            }
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0xac6af666, Offset: 0x121b0
// Size: 0x2a
function get_scenedef(str_scenedef) {
    return struct::get_script_bundle("scene", str_scenedef);
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0x66474ac7, Offset: 0x121e8
// Size: 0x12c
function get_scenedefs(str_type) {
    if (!isdefined(str_type)) {
        str_type = "scene";
    }
    a_scenedefs = [];
    foreach (s_scenedef in struct::get_script_bundles("scene")) {
        if (s_scenedef.scenetype == str_type) {
            if (!isdefined(a_scenedefs)) {
                a_scenedefs = [];
            } else if (!isarray(a_scenedefs)) {
                a_scenedefs = array(a_scenedefs);
            }
            a_scenedefs[a_scenedefs.size] = s_scenedef;
        }
    }
    return a_scenedefs;
}

// Namespace scene
// Params 5, eflags: 0x0
// Checksum 0x8221b8e4, Offset: 0x12320
// Size: 0x1a8
function spawn(arg1, arg2, arg3, arg4, b_test_run) {
    str_scenedef = arg1;
    /#
        assert(isdefined(str_scenedef), "Align target '");
    #/
    if (isvec(arg2)) {
        v_origin = arg2;
        v_angles = arg3;
        a_ents = arg4;
    } else {
        a_ents = arg2;
        v_origin = arg3;
        v_angles = arg4;
    }
    s_instance = spawnstruct();
    s_instance.origin = isdefined(v_origin) ? v_origin : (0, 0, 0);
    s_instance.angles = isdefined(v_angles) ? v_angles : (0, 0, 0);
    s_instance.classname = "scriptbundle_scene";
    s_instance.scriptbundlename = str_scenedef;
    s_instance struct::init();
    s_instance init(str_scenedef, a_ents, undefined, b_test_run);
    return s_instance;
}

// Namespace scene
// Params 4, eflags: 0x1 linked
// Checksum 0x21414476, Offset: 0x124d0
// Size: 0x298
function init(arg1, arg2, arg3, b_test_run) {
    if (self == level) {
        if (isstring(arg1)) {
            if (isstring(arg2)) {
                str_value = arg1;
                str_key = arg2;
                a_ents = arg3;
            } else {
                str_value = arg1;
                a_ents = arg2;
            }
            if (isdefined(str_key)) {
                a_instances = struct::get_array(str_value, str_key);
                /#
                    /#
                        assert(a_instances.size, "Align target '" + str_key + "Align target '" + str_value + "Align target '");
                    #/
                #/
            } else {
                a_instances = struct::get_array(str_value, "targetname");
                if (!a_instances.size) {
                    a_instances = struct::get_array(str_value, "scriptbundlename");
                }
            }
            if (!a_instances.size) {
                _init_instance(str_value, a_ents, b_test_run);
            } else {
                foreach (s_instance in a_instances) {
                    if (isdefined(s_instance)) {
                        s_instance thread _init_instance(undefined, a_ents, b_test_run);
                    }
                }
            }
        }
        return;
    }
    if (isstring(arg1)) {
        _init_instance(arg1, arg2, b_test_run);
    } else {
        _init_instance(arg2, arg1, b_test_run);
    }
    return self;
}

// Namespace scene
// Params 3, eflags: 0x1 linked
// Checksum 0xe4b34c7c, Offset: 0x12770
// Size: 0x274
function _init_instance(str_scenedef, a_ents, b_test_run) {
    if (!isdefined(b_test_run)) {
        b_test_run = 0;
    }
    level flagsys::wait_till("scene_on_load_wait");
    if (!isdefined(str_scenedef)) {
        str_scenedef = self.scriptbundlename;
    }
    /#
        if (array().size && !isinarray(array(), str_scenedef)) {
            return;
        }
    #/
    s_bundle = get_scenedef(str_scenedef);
    /#
        /#
            assert(isdefined(str_scenedef), "Align target '" + (isdefined(self.origin) ? self.origin : "Align target '") + "Align target '");
        #/
        /#
            assert(isdefined(s_bundle), "Align target '" + (isdefined(self.origin) ? self.origin : "Align target '") + "Align target '" + str_scenedef + "Align target '");
        #/
    #/
    o_scene = get_active_scene(str_scenedef);
    if (!isdefined(o_scene)) {
        if (s_bundle.scenetype == "awareness") {
            o_scene = new class_63342bfd();
        } else {
            o_scene = new cscene();
        }
        s_bundle = _load_female_scene(s_bundle, a_ents);
        [[ o_scene ]]->init(s_bundle.name, s_bundle, self, a_ents, b_test_run);
    } else {
        thread [[ o_scene ]]->initialize(a_ents, 1);
    }
    return o_scene;
}

// Namespace scene
// Params 2, eflags: 0x5 linked
// Checksum 0xcae68714, Offset: 0x129f0
// Size: 0x264
function private _load_female_scene(s_bundle, a_ents) {
    b_has_player = 0;
    foreach (s_object in s_bundle.objects) {
        if (!isdefined(s_object)) {
            continue;
        }
        if (s_object.type === "player") {
            b_has_player = 1;
            break;
        }
    }
    if (b_has_player) {
        e_player = undefined;
        if (isplayer(a_ents)) {
            e_player = a_ents;
        } else if (isarray(a_ents)) {
            foreach (ent in a_ents) {
                if (isplayer(ent)) {
                    e_player = ent;
                    break;
                }
            }
        }
        if (!isdefined(e_player)) {
            e_player = level.activeplayers[0];
        }
        if (isplayer(e_player) && e_player util::is_female()) {
            if (isdefined(s_bundle.femalebundle)) {
                s_female_bundle = struct::get_script_bundle("scene", s_bundle.femalebundle);
                if (isdefined(s_female_bundle)) {
                    return s_female_bundle;
                }
            }
        }
    }
    return s_bundle;
}

// Namespace scene
// Params 6, eflags: 0x1 linked
// Checksum 0x88dfd8f8, Offset: 0x12c60
// Size: 0x4bc
function play(arg1, arg2, arg3, b_test_run, str_state, str_mode) {
    if (!isdefined(b_test_run)) {
        b_test_run = 0;
    }
    if (!isdefined(str_mode)) {
        str_mode = "";
    }
    /#
        if (getdvarint("Align target '") > 0) {
            if (isdefined(arg1) && isstring(arg1)) {
                printtoprightln("Align target '" + arg1);
            } else {
                printtoprightln("Align target '");
            }
        }
    #/
    if (isdefined(arg1) && isstring(arg1) && arg1 == "p7_fxanim_zm_castle_rocket_bell_tower_bundle") {
        arg1 = arg1;
    }
    s_tracker = spawnstruct();
    s_tracker.n_scene_count = 1;
    if (self == level) {
        if (isstring(arg1)) {
            if (isstring(arg2)) {
                str_value = arg1;
                str_key = arg2;
                a_ents = arg3;
            } else {
                str_value = arg1;
                a_ents = arg2;
            }
            str_scenedef = str_value;
            if (isdefined(str_key)) {
                a_instances = struct::get_array(str_value, str_key);
                str_scenedef = undefined;
                /#
                    /#
                        assert(a_instances.size, "Align target '" + str_key + "Align target '" + str_value + "Align target '");
                    #/
                #/
            } else {
                a_instances = struct::get_array(str_value, "targetname");
                if (!a_instances.size) {
                    a_instances = struct::get_array(str_value, "scriptbundlename");
                } else {
                    str_scenedef = undefined;
                }
            }
            if (isdefined(str_scenedef)) {
                a_active_instances = get_active_scenes(str_scenedef);
                a_instances = arraycombine(a_active_instances, a_instances, 0, 0);
            }
            if (!a_instances.size) {
                self thread _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, undefined, str_mode);
            } else {
                s_tracker.n_scene_count = a_instances.size;
                foreach (s_instance in a_instances) {
                    if (isdefined(s_instance)) {
                        s_instance thread _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, str_state, str_mode);
                    }
                }
            }
        }
    } else if (isstring(arg1)) {
        self thread _play_instance(s_tracker, arg1, arg2, b_test_run, str_state, str_mode);
    } else {
        self thread _play_instance(s_tracker, arg2, arg1, b_test_run, str_state, str_mode);
    }
    for (i = 0; i < s_tracker.n_scene_count; i++) {
        s_tracker waittill(#"scene_done");
    }
}

// Namespace scene
// Params 6, eflags: 0x1 linked
// Checksum 0x3269b728, Offset: 0x13128
// Size: 0x2ac
function _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, str_state, str_mode) {
    if (!isdefined(b_test_run)) {
        b_test_run = 0;
    }
    /#
        if (array().size && !isinarray(array(), str_scenedef)) {
            return;
        }
    #/
    if (!isdefined(str_scenedef)) {
        str_scenedef = self.scriptbundlename;
    }
    if (self.scriptbundlename === str_scenedef) {
        if (!(isdefined(self.script_play_multiple) && self.script_play_multiple)) {
            if (isdefined(self.scene_played) && self.scene_played && !b_test_run) {
                waittillframeend();
                while (is_playing(str_scenedef)) {
                    wait(0.05);
                }
                s_tracker notify(#"scene_done");
                return;
            }
        }
        self.scene_played = 1;
    }
    o_scene = _init_instance(str_scenedef, a_ents, b_test_run);
    if (isdefined(o_scene)) {
        if ((!isdefined(str_mode) || str_mode == "") && [[ o_scene ]]->function_76654644()) {
            skip_scene(o_scene._s.name, 0, 0, 1);
        }
        thread [[ o_scene ]]->play(str_state, a_ents, b_test_run, str_mode);
    }
    self waittillmatch(#"scene_done", str_scenedef);
    if (isdefined(self)) {
        if (isdefined(get_scenedef(self.scriptbundlename).looping) && isdefined(self.scriptbundlename) && get_scenedef(self.scriptbundlename).looping) {
            self.scene_played = 0;
        }
        if (isdefined(self.script_flag_set)) {
            level flag::set(self.script_flag_set);
        }
    }
    s_tracker notify(#"scene_done");
}

// Namespace scene
// Params 5, eflags: 0x1 linked
// Checksum 0xe570ddd0, Offset: 0x133e0
// Size: 0xb4
function skipto_end(arg1, arg2, arg3, n_time, b_include_players) {
    if (!isdefined(b_include_players)) {
        b_include_players = 0;
    }
    str_mode = "skipto";
    if (!b_include_players) {
        str_mode += "_noplayers";
    }
    if (isdefined(n_time)) {
        str_mode += ":" + n_time;
    }
    play(arg1, arg2, arg3, 0, undefined, str_mode);
}

// Namespace scene
// Params 4, eflags: 0x0
// Checksum 0xe2dd1db6, Offset: 0x134a0
// Size: 0x84
function skipto_end_noai(arg1, arg2, arg3, n_time) {
    str_mode = "skipto_noai_noplayers";
    if (isdefined(n_time)) {
        str_mode += ":" + n_time;
    }
    play(arg1, arg2, arg3, 0, undefined, str_mode);
}

// Namespace scene
// Params 3, eflags: 0x1 linked
// Checksum 0xf46b53fd, Offset: 0x13530
// Size: 0x274
function stop(arg1, arg2, arg3) {
    if (self == level) {
        if (isstring(arg1)) {
            if (isstring(arg2)) {
                str_value = arg1;
                str_key = arg2;
                b_clear = arg3;
            } else {
                str_value = arg1;
                b_clear = arg2;
            }
            if (isdefined(str_key)) {
                a_instances = struct::get_array(str_value, str_key);
                /#
                    /#
                        assert(a_instances.size, "Align target '" + str_key + "Align target '" + str_value + "Align target '");
                    #/
                #/
                str_value = undefined;
            } else {
                a_instances = struct::get_array(str_value, "targetname");
                if (!a_instances.size) {
                    a_instances = get_active_scenes(str_value);
                } else {
                    str_value = undefined;
                }
            }
            foreach (s_instance in arraycopy(a_instances)) {
                if (isdefined(s_instance)) {
                    s_instance _stop_instance(b_clear, str_value);
                }
            }
        }
        return;
    }
    if (isstring(arg1)) {
        _stop_instance(arg2, arg1);
        return;
    }
    _stop_instance(arg1);
}

// Namespace scene
// Params 2, eflags: 0x1 linked
// Checksum 0xf0bb6473, Offset: 0x137b0
// Size: 0x102
function _stop_instance(b_clear, str_scenedef) {
    if (!isdefined(b_clear)) {
        b_clear = 0;
    }
    if (isdefined(self.scenes)) {
        foreach (o_scene in arraycopy(self.scenes)) {
            str_scene_name = [[ o_scene ]]->get_name();
            if (!isdefined(str_scenedef) || str_scene_name == str_scenedef) {
                thread [[ o_scene ]]->stop(b_clear);
            }
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0x1ecac53a, Offset: 0x138c0
// Size: 0xec
function has_init_state(str_scenedef) {
    s_scenedef = get_scenedef(str_scenedef);
    foreach (s_obj in s_scenedef.objects) {
        if (!(isdefined(s_obj.disabled) && s_obj.disabled) && s_obj _has_init_state()) {
            return true;
        }
    }
    return false;
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0xe8d56c37, Offset: 0x139b8
// Size: 0x46
function _has_init_state() {
    return isdefined(self.firstframe) && (isdefined(self.spawnoninit) && self.spawnoninit || isdefined(self.initanim) || isdefined(self.initanimloop) || self.firstframe);
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0xf4950fbf, Offset: 0x13a08
// Size: 0x2a
function get_prop_count(str_scenedef) {
    return _get_type_count("prop", str_scenedef);
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0xd92c0e78, Offset: 0x13a40
// Size: 0x2a
function get_vehicle_count(str_scenedef) {
    return _get_type_count("vehicle", str_scenedef);
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0x17aaa7b0, Offset: 0x13a78
// Size: 0x2a
function get_actor_count(str_scenedef) {
    return _get_type_count("actor", str_scenedef);
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0x96a17cca, Offset: 0x13ab0
// Size: 0x2a
function get_player_count(str_scenedef) {
    return _get_type_count("player", str_scenedef);
}

// Namespace scene
// Params 2, eflags: 0x1 linked
// Checksum 0xcdebba46, Offset: 0x13ae8
// Size: 0x138
function _get_type_count(str_type, str_scenedef) {
    s_scenedef = isdefined(str_scenedef) ? get_scenedef(str_scenedef) : get_scenedef(self.scriptbundlename);
    n_count = 0;
    foreach (s_obj in s_scenedef.objects) {
        if (isdefined(s_obj.type)) {
            if (tolower(s_obj.type) == tolower(str_type)) {
                n_count++;
            }
        }
    }
    return n_count;
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0xfd4d73a3, Offset: 0x13c28
// Size: 0x4e
function is_active(str_scenedef) {
    if (self == level) {
        return (get_active_scenes(str_scenedef).size > 0);
    }
    return isdefined(get_active_scene(str_scenedef));
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0x1463e1b6, Offset: 0x13c80
// Size: 0x94
function is_playing(str_scenedef) {
    if (self == level) {
        return level flagsys::get(str_scenedef + "_playing");
    } else {
        if (!isdefined(str_scenedef)) {
            str_scenedef = self.scriptbundlename;
        }
        o_scene = get_active_scene(str_scenedef);
        if (isdefined(o_scene)) {
            return (o_scene._str_state === "play");
        }
    }
    return 0;
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0xd5333108, Offset: 0x13d20
// Size: 0x96
function is_ready(str_scenedef) {
    if (self == level) {
        return level flagsys::get(str_scenedef + "_ready");
    } else {
        if (!isdefined(str_scenedef)) {
            str_scenedef = self.scriptbundlename;
        }
        o_scene = get_active_scene(str_scenedef);
        if (isdefined(o_scene)) {
            return o_scene flagsys::get("ready");
        }
    }
    return 0;
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0x2f9bc371, Offset: 0x13dc0
// Size: 0x104
function get_active_scenes(str_scenedef) {
    if (!isdefined(level.active_scenes)) {
        level.active_scenes = [];
    }
    if (isdefined(str_scenedef)) {
        return (isdefined(level.active_scenes[str_scenedef]) ? level.active_scenes[str_scenedef] : []);
    }
    a_active_scenes = [];
    foreach (str_scenedef, _ in level.active_scenes) {
        a_active_scenes = arraycombine(a_active_scenes, level.active_scenes[str_scenedef], 0, 0);
    }
    return a_active_scenes;
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0x9c0eb389, Offset: 0x13ed0
// Size: 0xb4
function get_active_scene(str_scenedef) {
    if (isdefined(str_scenedef) && isdefined(self.scenes)) {
        foreach (o_scene in self.scenes) {
            if ([[ o_scene ]]->get_name() == str_scenedef) {
                return o_scene;
            }
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0xda0f40b2, Offset: 0x13f90
// Size: 0x3e
function delete_scene_data(str_scenename) {
    if (isdefined(level.var_3f831f3b["scene"][str_scenename])) {
        level.var_3f831f3b["scene"][str_scenename] = undefined;
    }
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0x66834a82, Offset: 0x13fd8
// Size: 0x7a
function is_igc() {
    return isstring(self.cameraswitcher) || isstring(self.extracamswitcher1) || isstring(self.extracamswitcher2) || isstring(self.extracamswitcher3) || isstring(self.extracamswitcher4);
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0xf05ce6b5, Offset: 0x14060
// Size: 0xf2
function scene_disable_player_stuff(b_hide_hud) {
    if (!isdefined(b_hide_hud)) {
        b_hide_hud = 1;
    }
    /#
        if (getdvarint("Align target '") > 0) {
            printtoprightln("Align target '");
        }
    #/
    self notify(#"scene_disable_player_stuff");
    self notify(#"kill_hint_text");
    self disableoffhandweapons();
    if (b_hide_hud) {
        set_igc_active(1);
        level notify(#"disable_cybercom", self, 1);
        self util::show_hud(0);
        util::wait_network_frame();
        self notify(#"delete_weapon_objects");
    }
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0xc1b4962f, Offset: 0x14160
// Size: 0xe4
function scene_enable_player_stuff(b_hide_hud) {
    if (!isdefined(b_hide_hud)) {
        b_hide_hud = 1;
    }
    /#
        if (getdvarint("Align target '") > 0) {
            printtoprightln("Align target '");
        }
    #/
    self endon(#"scene_disable_player_stuff");
    self endon(#"disconnect");
    wait(0.5);
    self enableoffhandweapons();
    if (b_hide_hud) {
        set_igc_active(0);
        level notify(#"enable_cybercom", self);
        self notify(#"scene_enable_cybercom");
        self util::show_hud(1);
    }
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0xc9ffc8f8, Offset: 0x14250
// Size: 0x13a
function updateigcviewtime(b_in_igc) {
    if (b_in_igc && !isdefined(level.igcstarttime)) {
        level.igcstarttime = gettime();
        return;
    }
    if (!b_in_igc && isdefined(level.igcstarttime)) {
        igcviewtimesec = gettime() - level.igcstarttime;
        level.igcstarttime = undefined;
        foreach (player in level.players) {
            if (!isdefined(player.totaligcviewtime)) {
                player.totaligcviewtime = 0;
            }
            player.totaligcviewtime += int(igcviewtimesec / 1000);
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x1 linked
// Checksum 0x384b066f, Offset: 0x14398
// Size: 0xd0
function set_igc_active(b_in_igc) {
    n_ent_num = self getentitynumber();
    n_players_in_igc_field = level clientfield::get("in_igc");
    if (b_in_igc) {
        n_players_in_igc_field |= 1 << n_ent_num;
    } else {
        n_players_in_igc_field &= ~(1 << n_ent_num);
    }
    updateigcviewtime(b_in_igc);
    level clientfield::set("in_igc", n_players_in_igc_field);
    /#
    #/
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0x7493d96f, Offset: 0x14470
// Size: 0x60
function is_igc_active() {
    n_players_in_igc = level clientfield::get("in_igc");
    n_entnum = self getentitynumber();
    return n_players_in_igc & 1 << n_entnum;
}

// Namespace scene
// Params 0, eflags: 0x0
// Checksum 0x1ddc7420, Offset: 0x144d8
// Size: 0x5c
function is_capture_mode() {
    str_mode = getdvarstring("scene_menu_mode", "default");
    if (issubstr(str_mode, "capture")) {
        return 1;
    }
    return 0;
}

// Namespace scene
// Params 0, eflags: 0x0
// Checksum 0xc92ebef5, Offset: 0x14540
// Size: 0x16
function should_spectate_on_join() {
    return isdefined(level.scene_should_spectate_on_hot_join) && level.scene_should_spectate_on_hot_join;
}

// Namespace scene
// Params 0, eflags: 0x0
// Checksum 0x8edb56a3, Offset: 0x14560
// Size: 0x28
function wait_until_spectate_on_join_completes() {
    while (isdefined(level.scene_should_spectate_on_hot_join) && level.scene_should_spectate_on_hot_join) {
        wait(0.05);
    }
}

// Namespace scene
// Params 4, eflags: 0x1 linked
// Checksum 0xaf9e4ffa, Offset: 0x14590
// Size: 0x5a2
function skip_scene(scene_name, var_6b34ddbf, b_player_scene, var_48ef9f9) {
    if (!isdefined(scene_name)) {
        if (isdefined(level.var_9d7e58c5)) {
            scene_name = level.var_9d7e58c5;
        }
        if (!isdefined(scene_name)) {
            if (isdefined(level.players) && isdefined(level.players[0].current_scene)) {
                scene_name = level.players[0].current_scene;
            }
            if (!isdefined(scene_name)) {
                foreach (player in level.players) {
                    if (isdefined(player.current_scene)) {
                        scene_name = player.current_scene;
                        break;
                    }
                }
            }
        }
    }
    /#
        if (getdvarint("Align target '") > 0) {
            if (isdefined(scene_name)) {
                printtoprightln("Align target '" + scene_name + "Align target '" + gettime(), (1, 0.5, 0));
            } else {
                printtoprightln("Align target '" + gettime(), (1, 0.5, 0));
            }
        }
    #/
    if (!(isdefined(var_6b34ddbf) && var_6b34ddbf) && !isdefined(b_player_scene)) {
        foreach (player in level.players) {
            if (isdefined(player.current_scene) && player.current_scene == scene_name) {
                b_player_scene = 1;
                break;
            }
        }
    }
    if (isdefined(b_player_scene) && !(isdefined(var_6b34ddbf) && var_6b34ddbf) && b_player_scene) {
        a_instances = get_active_scenes(scene_name);
        var_cb82c545 = 0;
        foreach (s_instance in arraycopy(a_instances)) {
            if (isdefined(s_instance)) {
                var_7aef94aa = s_instance _skip_scene(scene_name, var_6b34ddbf, 1, 0);
                if (var_7aef94aa == 2) {
                    break;
                }
                if (var_7aef94aa == 1) {
                    var_cb82c545 = 1;
                    break;
                }
            }
        }
        if (isdefined(var_cb82c545) && var_cb82c545) {
            a_instances = get_active_scenes();
            foreach (s_instance in arraycopy(a_instances)) {
                if (isdefined(s_instance)) {
                    s_instance _skip_scene(scene_name, var_6b34ddbf, 0, 1);
                }
            }
            return;
        }
        level.var_a1d36213 = undefined;
        level.var_9d7e58c5 = undefined;
        return;
    }
    a_instances = struct::get_array(scene_name, "targetname");
    if (!a_instances.size) {
        a_instances = get_active_scenes(scene_name);
    }
    foreach (s_instance in arraycopy(a_instances)) {
        if (isdefined(s_instance)) {
            s_instance _skip_scene(scene_name, var_6b34ddbf, b_player_scene, var_48ef9f9);
        }
    }
}

// Namespace scene
// Params 4, eflags: 0x1 linked
// Checksum 0xe6c62634, Offset: 0x14b40
// Size: 0x456
function _skip_scene(var_7265d040, var_6b34ddbf, b_player_scene, var_48ef9f9) {
    var_7aef94aa = 0;
    if (isdefined(self.scenes)) {
        foreach (o_scene in arraycopy(self.scenes)) {
            if (isdefined(o_scene.skipping_scene) && o_scene.skipping_scene) {
                continue;
            }
            if (isdefined(b_player_scene) && !(isdefined(var_6b34ddbf) && var_6b34ddbf) && b_player_scene && !(isdefined(var_48ef9f9) && var_48ef9f9)) {
                if (o_scene._s.name === var_7265d040) {
                    if (isdefined(o_scene._s.disablesceneskipping) && o_scene._s.disablesceneskipping) {
                        return 2;
                    } else {
                        if (o_scene._str_state === "init") {
                            continue;
                        }
                        var_7aef94aa = 1;
                    }
                } else if (!isdefined(var_7265d040)) {
                    if ([[ o_scene ]]->is_scene_shared()) {
                        if (isdefined(o_scene._s.disablesceneskipping) && o_scene._s.disablesceneskipping) {
                            return 2;
                        } else {
                            if (o_scene._str_state === "init") {
                                continue;
                            }
                            var_7aef94aa = 1;
                        }
                    } else {
                        continue;
                    }
                } else {
                    continue;
                }
            }
            str_scene_name = [[ o_scene ]]->get_name();
            if (!(isdefined(var_6b34ddbf) && var_6b34ddbf)) {
                var_c36badf6 = array::contains(level.var_109c74a6, str_scene_name);
                if (isdefined(o_scene._s.disablesceneskipping) && (!var_c36badf6 || isdefined(var_48ef9f9) && var_48ef9f9 && o_scene._s.disablesceneskipping)) {
                    continue;
                }
                if (!var_c36badf6 && o_scene._str_state === "init") {
                    continue;
                }
                if (var_c36badf6 && (!isdefined(var_7265d040) || str_scene_name == var_7265d040 || !(isdefined(o_scene._s.disablesceneskipping) && o_scene._s.disablesceneskipping))) {
                    if (isdefined(b_player_scene) && (!isdefined(var_7265d040) || str_scene_name == var_7265d040) && b_player_scene && !(isdefined(var_48ef9f9) && var_48ef9f9) && !var_c36badf6) {
                        var_7aef94aa = 1;
                        o_scene.b_player_scene = 1;
                        level.var_cd66d9d1 = str_scene_name;
                    }
                    o_scene.skipping_scene = 1;
                    thread [[ o_scene ]]->skip_scene(var_6b34ddbf);
                }
                continue;
            }
            o_scene.b_player_scene = b_player_scene;
            o_scene.skipping_scene = 1;
            thread [[ o_scene ]]->skip_scene(var_6b34ddbf);
        }
    }
    return var_7aef94aa;
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0xf5887147, Offset: 0x14fa0
// Size: 0x44
function function_9e5b8cdb(var_68612a53) {
    if (!isdefined(level.var_109c74a6)) {
        level.var_109c74a6 = [];
    }
    array::add(level.var_109c74a6, var_68612a53);
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0x41df380f, Offset: 0x14ff0
// Size: 0x34
function function_bac0d34c(var_68612a53) {
    if (isdefined(level.var_109c74a6)) {
        arrayremovevalue(level.var_109c74a6, var_68612a53);
    }
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0xfdb78dd2, Offset: 0x15030
// Size: 0x1c
function function_f69c7a83() {
    while (isdefined(level.var_cd66d9d1)) {
        wait(0.05);
    }
}

// Namespace scene
// Params 0, eflags: 0x0
// Checksum 0xc457ce2f, Offset: 0x15058
// Size: 0xc
function function_b1f75ee9() {
    return isdefined(level.var_cd66d9d1);
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0xa473c31a, Offset: 0x15070
// Size: 0x7c
function function_557b98ac() {
    self endon(#"disconnect");
    while (true) {
        level waittill(#"hash_1c353a4f");
        self thread function_b5cb230();
        self thread function_b76e09b();
        self thread function_e79b5797();
        level waittill(#"hash_14c06c0c");
    }
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0xc8ed6d1d, Offset: 0x150f8
// Size: 0xf0
function clear_scene_skipping_ui() {
    level endon(#"hash_1c353a4f");
    if (isdefined(self.scene_skip_timer)) {
        self.scene_skip_timer = undefined;
    }
    if (isdefined(self.scene_skip_start_time)) {
        self.scene_skip_start_time = undefined;
    }
    foreach (player in level.players) {
        if (isdefined(player.skip_scene_menu_handle)) {
            player closeluimenu(player.skip_scene_menu_handle);
            player.skip_scene_menu_handle = undefined;
        }
    }
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0x7c82604b, Offset: 0x151f0
// Size: 0x3c
function function_b76e09b() {
    self endon(#"disconnect");
    self endon(#"scene_being_skipped");
    level waittill(#"hash_14c06c0c");
    clear_scene_skipping_ui();
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0x7c3f72a8, Offset: 0x15238
// Size: 0x44
function function_e79b5797() {
    self endon(#"disconnect");
    level endon(#"hash_14c06c0c");
    self waittill(#"scene_being_skipped");
    level.sceneskippedcount++;
    clear_scene_skipping_ui();
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0xb09721b6, Offset: 0x15288
// Size: 0x58c
function function_b5cb230() {
    self endon(#"disconnect");
    level endon(#"hash_14c06c0c");
    b_skip_scene = 0;
    clear_scene_skipping_ui();
    wait(0.05);
    foreach (player in level.players) {
        if (isdefined(player.skip_scene_menu_handle)) {
            player closeluimenu(player.skip_scene_menu_handle);
            wait(0.05);
        }
        player.skip_scene_menu_handle = player openluimenu("CPSkipSceneMenu");
        player setluimenudata(player.skip_scene_menu_handle, "showSkipButton", 0);
        player setluimenudata(player.skip_scene_menu_handle, "hostIsSkipping", 0);
        player setluimenudata(player.skip_scene_menu_handle, "sceneSkipEndTime", 0);
    }
    while (true) {
        if (self any_button_pressed() && !(isdefined(level.chyron_text_active) && level.chyron_text_active)) {
            if (!isdefined(self.scene_skip_timer)) {
                self setluimenudata(self.skip_scene_menu_handle, "showSkipButton", 1);
            }
            self.scene_skip_timer = gettime();
        } else if (isdefined(self.scene_skip_timer)) {
            if (gettime() - self.scene_skip_timer > 3000) {
                self setluimenudata(self.skip_scene_menu_handle, "showSkipButton", 2);
                self.scene_skip_timer = undefined;
            }
        }
        if (self primarybuttonpressedlocal() && !(isdefined(level.chyron_text_active) && level.chyron_text_active)) {
            if (!isdefined(self.scene_skip_start_time)) {
                foreach (player in level.players) {
                    if (player ishost()) {
                        player setluimenudata(player.skip_scene_menu_handle, "sceneSkipEndTime", gettime() + 2500);
                        continue;
                    }
                    if (isdefined(player.skip_scene_menu_handle)) {
                        player setluimenudata(player.skip_scene_menu_handle, "hostIsSkipping", 1);
                    }
                }
                self.scene_skip_start_time = gettime();
            } else if (gettime() - self.scene_skip_start_time > 2500) {
                b_skip_scene = 1;
                break;
            }
        } else if (isdefined(self.scene_skip_start_time)) {
            foreach (player in level.players) {
                if (player ishost()) {
                    player setluimenudata(player.skip_scene_menu_handle, "sceneSkipEndTime", 0);
                    continue;
                }
                if (isdefined(player.skip_scene_menu_handle)) {
                    player setluimenudata(player.skip_scene_menu_handle, "hostIsSkipping", 2);
                }
            }
            self.scene_skip_start_time = undefined;
        }
        if (isdefined(level.chyron_text_active) && level.chyron_text_active) {
            while (isdefined(level.chyron_text_active) && level.chyron_text_active) {
                wait(0.05);
            }
            wait(3);
        }
        wait(0.05);
    }
    if (b_skip_scene) {
        self playsound("uin_igc_skip");
        self notify(#"scene_being_skipped");
        level notify(#"hash_cdfdddaf");
        skip_scene(level.var_9d7e58c5, 0, 1);
    }
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0x57e68db3, Offset: 0x15820
// Size: 0x1a6
function any_button_pressed() {
    if (self actionslotonebuttonpressed()) {
        return true;
    } else if (self actionslottwobuttonpressed()) {
        return true;
    } else if (self actionslotthreebuttonpressed()) {
        return true;
    } else if (self actionslotfourbuttonpressed()) {
        return true;
    } else if (self jumpbuttonpressed()) {
        return true;
    } else if (self stancebuttonpressed()) {
        return true;
    } else if (self weaponswitchbuttonpressed()) {
        return true;
    } else if (self reloadbuttonpressed()) {
        return true;
    } else if (self fragbuttonpressed()) {
        return true;
    } else if (self throwbuttonpressed()) {
        return true;
    } else if (self attackbuttonpressed()) {
        return true;
    } else if (self secondaryoffhandbuttonpressed()) {
        return true;
    } else if (self meleebuttonpressed()) {
        return true;
    }
    return false;
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0x4d0e085f, Offset: 0x159d0
// Size: 0x34
function on_player_connect() {
    if (self ishost()) {
        self thread function_557b98ac();
    }
}

// Namespace scene
// Params 0, eflags: 0x1 linked
// Checksum 0x5a791fe8, Offset: 0x15a10
// Size: 0x1c
function on_player_disconnect() {
    self set_igc_active(0);
}

// Namespace scene
// Params 2, eflags: 0x0
// Checksum 0xa3a9cb6b, Offset: 0x15a38
// Size: 0xdc
function add_scene_ordered_notetrack(group_name, str_note) {
    if (!isdefined(level.scene_ordered_notetracks)) {
        level.scene_ordered_notetracks = [];
    }
    group_obj = level.scene_ordered_notetracks[group_name];
    if (!isdefined(group_obj)) {
        group_obj = spawnstruct();
        group_obj.count = 0;
        group_obj.current_count = 0;
        level.scene_ordered_notetracks[group_name] = group_obj;
    }
    group_obj.count++;
    self thread _wait_for_ordered_notify(group_obj.count - 1, group_obj, group_name, str_note);
}

// Namespace scene
// Params 4, eflags: 0x5 linked
// Checksum 0xf9e3e899, Offset: 0x15b20
// Size: 0x254
function private _wait_for_ordered_notify(id, group_obj, group_name, str_note) {
    self waittill(str_note);
    if (group_obj.current_count == id) {
        group_obj.current_count++;
        self notify("scene_" + str_note);
        wait(0.05);
        if (group_obj.current_count == group_obj.count) {
            group_obj.pending_notifies = undefined;
            level.scene_ordered_notetracks[group_name] = undefined;
        } else if (isdefined(group_obj.pending_notifies) && group_obj.current_count + group_obj.pending_notifies.size == group_obj.count) {
            self thread _fire_ordered_notitifes(group_obj, group_name);
        }
        return;
    }
    if (!isdefined(group_obj.pending_notifies)) {
        group_obj.pending_notifies = [];
    }
    notetrack = spawnstruct();
    notetrack.id = id;
    notetrack.str_note = str_note;
    for (i = 0; i < group_obj.pending_notifies.size && group_obj.pending_notifies[i].id < id; i++) {
    }
    arrayinsert(group_obj.pending_notifies, notetrack, i);
    if (group_obj.current_count + group_obj.pending_notifies.size == group_obj.count) {
        self thread _fire_ordered_notitifes(group_obj, group_name);
    }
}

// Namespace scene
// Params 2, eflags: 0x5 linked
// Checksum 0xeff68b87, Offset: 0x15d80
// Size: 0xb4
function private _fire_ordered_notitifes(group_obj, group_name) {
    if (isdefined(group_obj.pending_notifies)) {
        while (group_obj.pending_notifies.size > 0) {
            self notify("scene_" + group_obj.pending_notifies[0].str_note);
            arrayremoveindex(group_obj.pending_notifies, 0);
            wait(0.05);
        }
    }
    group_obj.pending_notifies = undefined;
    level.scene_ordered_notetracks[group_name] = undefined;
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0x6e33476f, Offset: 0x15e40
// Size: 0x44
function add_wait_for_streamer_hint_scene(str_scene_name) {
    if (!isdefined(level.wait_for_streamer_hint_scenes)) {
        level.wait_for_streamer_hint_scenes = [];
    }
    array::add(level.wait_for_streamer_hint_scenes, str_scene_name);
}

