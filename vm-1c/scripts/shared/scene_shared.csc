#using scripts/codescripts/struct;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/scene_debug_shared;
#using scripts/shared/scriptbundle_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#using_animtree("generic");

#namespace scene;

// Namespace scene
// Method(s) 23 Total 27
class csceneobject : cscriptbundleobjectbase {

    // Namespace csceneobject
    // Params 0, eflags: 0x0
    // Checksum 0xeaf1916d, Offset: 0x800
    // Size: 0x2c
    function constructor() {
        self._b_spawnonce_used = 0;
        self._is_valid = 1;
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x0
    // Checksum 0xe43a5b4d, Offset: 0x2078
    // Size: 0xe0
    function in_a_different_scene() {
        if (isdefined(self._n_clientnum)) {
            if (isdefined(self._e_array[self._n_clientnum]) && isdefined(self._e_array[self._n_clientnum].current_scene) && self._e_array[self._n_clientnum].current_scene != self.var_190b1ea2._str_name) {
                return true;
            }
        } else if (isdefined(self._e_array[0]) && isdefined(self._e_array[0].current_scene) && self._e_array[0].current_scene != self.var_190b1ea2._str_name) {
            return true;
        }
        return false;
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x0
    // Checksum 0x2a65885d, Offset: 0x2050
    // Size: 0x1a
    function is_alive(clientnum) {
        return isdefined(self._e_array[clientnum]);
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x0
    // Checksum 0xfaecc5a3, Offset: 0x2028
    // Size: 0x1a
    function has_init_state() {
        return self._s scene::_has_init_state();
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x0
    // Checksum 0x40202f70, Offset: 0x1ff8
    // Size: 0x24
    function function_2f376105() {
        [[ scene() ]]->function_2f376105();
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x0
    // Checksum 0xa8dfed11, Offset: 0x1fa8
    // Size: 0x44
    function get_align_tag() {
        if (isdefined(self._s.aligntargettag)) {
            return self._s.aligntargettag;
        }
        return self.var_190b1ea2._s.aligntargettag;
    }

    // Namespace csceneobject
    // Params 8, eflags: 0x0
    // Checksum 0xc6944af9, Offset: 0x1cf8
    // Size: 0x2a4
    function _play_anim(clientnum, animation, n_delay_min, n_delay_max, n_rate, n_blend, str_siege_shot, loop) {
        if (!isdefined(n_delay_min)) {
            n_delay_min = 0;
        }
        if (!isdefined(n_delay_max)) {
            n_delay_max = 0;
        }
        if (!isdefined(n_rate)) {
            n_rate = 1;
        }
        n_delay = n_delay_min;
        if (n_delay_max > n_delay_min) {
            n_delay = randomfloatrange(n_delay_min, n_delay_max);
        }
        if (n_delay > 0) {
            flagsys::set("ready");
            wait n_delay;
            _spawn(clientnum);
        } else {
            _spawn(clientnum);
        }
        if (is_alive(clientnum)) {
            self._e_array[clientnum] show();
            if (isdefined(self._s.issiege) && self._s.issiege) {
                self._e_array[clientnum] notify(#"end");
                self._e_array[clientnum] animation::play_siege(animation, str_siege_shot, n_rate, loop);
            } else {
                align = get_align_ent(clientnum);
                tag = get_align_tag();
                if (align == level) {
                    align = (0, 0, 0);
                    tag = (0, 0, 0);
                }
                self._e_array[clientnum] animation::play(animation, align, tag, n_rate, n_blend);
            }
        } else {
            /#
                cscriptbundleobjectbase::log("<dev string:x5b>" + animation + "<dev string:x75>");
            #/
        }
        self._is_valid = is_alive(clientnum);
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x0
    // Checksum 0xaf66c5ea, Offset: 0x1b90
    // Size: 0x15c
    function _cleanup(clientnum) {
        if (isdefined(self._e_array[clientnum]) && isdefined(self._e_array[clientnum].current_scene)) {
            self._e_array[clientnum] flagsys::clear(self.var_190b1ea2._str_name);
            if (self._e_array[clientnum].current_scene == self.var_190b1ea2._str_name) {
                self._e_array[clientnum] flagsys::clear("scene");
                self._e_array[clientnum].finished_scene = self.var_190b1ea2._str_name;
                self._e_array[clientnum].current_scene = undefined;
            }
        }
        if (clientnum === self._n_clientnum || clientnum == 0) {
            if (isdefined(self.var_190b1ea2.scene_stopped) && isdefined(self.var_190b1ea2) && self.var_190b1ea2.scene_stopped) {
                self.var_190b1ea2 = undefined;
            }
        }
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x0
    // Checksum 0x5ed05f14, Offset: 0x1a28
    // Size: 0x15a
    function _prepare(clientnum) {
        if (!(isdefined(self._s.issiege) && self._s.issiege)) {
            if (!self._e_array[clientnum] hasanimtree()) {
                self._e_array[clientnum] useanimtree(#generic);
            }
        }
        self._e_array[clientnum].animname = self._str_name;
        self._e_array[clientnum].anim_debug_name = self._s.name;
        self._e_array[clientnum] flagsys::set("scene");
        self._e_array[clientnum] flagsys::set(self.var_190b1ea2._str_name);
        self._e_array[clientnum].current_scene = self.var_190b1ea2._str_name;
        self._e_array[clientnum].finished_scene = undefined;
    }

    // Namespace csceneobject
    // Params 2, eflags: 0x0
    // Checksum 0x83c31024, Offset: 0x1658
    // Size: 0x3c8
    function _spawn(clientnum, b_hide) {
        if (!isdefined(b_hide)) {
            b_hide = 1;
        }
        if (!isdefined(self._e_array[clientnum])) {
            b_allows_multiple = [[ scene() ]]->allows_multiple();
            if (cscriptbundleobjectbase::error(isdefined(self._s.nospawn) && b_allows_multiple && self._s.nospawn, "Scene that allow multiple instances must be allowed to spawn (uncheck 'Do Not Spawn').")) {
                return;
            }
            self._e_array[clientnum] = scene::get_existing_ent(clientnum, self._str_name);
            if (!isdefined(self._e_array[clientnum]) && isdefined(self._s.name) && !b_allows_multiple) {
                self._e_array[clientnum] = scene::get_existing_ent(clientnum, self._s.name);
            }
            if (!isdefined(self._e_array[clientnum]) && !(isdefined(self._s.nospawn) && self._s.nospawn) && !self._b_spawnonce_used) {
                _e_align = get_align_ent(clientnum);
                self._e_array[clientnum] = util::spawn_model(clientnum, self._s.model, _e_align.origin, _e_align.angles);
                if (isdefined(self._e_array[clientnum])) {
                    if (b_hide) {
                        self._e_array[clientnum] hide();
                    }
                    self._e_array[clientnum].scene_spawned = self.var_190b1ea2._s.name;
                    self._e_array[clientnum].targetname = self._s.name;
                } else {
                    cscriptbundleobjectbase::error(!(isdefined(self._s.nospawn) && self._s.nospawn), "No entity exists with matching name of scene object.");
                }
            }
            if (isdefined(self._s.var_884f63ad) && self._s.var_884f63ad && self._b_spawnonce_used) {
                return;
            }
            if (!cscriptbundleobjectbase::error(!(isdefined(self._s.nospawn) && self._s.nospawn) && !isdefined(self._e_array[clientnum]), "No entity exists with matching name of scene object. Make sure a model is specified if you want to spawn it.")) {
                _prepare(clientnum);
            }
        }
        if (isdefined(self._e_array[clientnum])) {
            flagsys::set("ready");
            if (isdefined(self._s.var_884f63ad) && self._s.var_884f63ad) {
                self._b_spawnonce_used = 1;
            }
        }
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x0
    // Checksum 0x563cc1a3, Offset: 0x1638
    // Size: 0x12
    function get_orig_name() {
        return self._s.name;
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x0
    // Checksum 0x76170705, Offset: 0x1620
    // Size: 0xa
    function get_name() {
        return self._str_name;
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x0
    // Checksum 0x78723f65, Offset: 0x14f0
    // Size: 0x124
    function _assign_unique_name() {
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
    // Params 0, eflags: 0x0
    // Checksum 0xd376b57b, Offset: 0x14d8
    // Size: 0xa
    function scene() {
        return self.var_190b1ea2;
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x0
    // Checksum 0x8801c705, Offset: 0x1378
    // Size: 0x154
    function get_align_ent(clientnum) {
        e_align = undefined;
        if (isdefined(self._s.aligntarget)) {
            a_scene_ents = [[ self.var_190b1ea2 ]]->get_ents();
            if (isdefined(a_scene_ents[clientnum][self._s.aligntarget])) {
                e_align = a_scene_ents[clientnum][self._s.aligntarget];
            } else {
                e_align = scene::get_existing_ent(clientnum, self._s.aligntarget);
            }
            cscriptbundleobjectbase::error(!isdefined(e_align), "Align target '" + (isdefined(self._s.aligntarget) ? "" + self._s.aligntarget : "") + "' doesn't exist for scene object.");
        }
        if (!isdefined(e_align)) {
            e_align = [[ scene() ]]->get_align_ent(clientnum);
        }
        return e_align;
    }

    // Namespace csceneobject
    // Params 2, eflags: 0x0
    // Checksum 0x877b71d, Offset: 0x1240
    // Size: 0x12c
    function finish_per_client(clientnum, b_clear) {
        if (!isdefined(b_clear)) {
            b_clear = 0;
        }
        if (!is_alive(clientnum)) {
            _cleanup(clientnum);
            self._e_array[clientnum] = undefined;
            self._is_valid = 0;
        }
        flagsys::set("ready");
        flagsys::set("done");
        if (isdefined(self._e_array[clientnum])) {
            if (isdefined(self._s.deletewhenfinished) && self._s.deletewhenfinished || is_alive(clientnum) && b_clear) {
                self._e_array[clientnum] delete();
            }
        }
        _cleanup(clientnum);
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x0
    // Checksum 0xf5354c11, Offset: 0x1158
    // Size: 0xdc
    function finish(b_clear) {
        if (!isdefined(b_clear)) {
            b_clear = 0;
        }
        self notify(#"new_state");
        if (isdefined(self._n_clientnum)) {
            finish_per_client(self._n_clientnum, b_clear);
            return;
        }
        for (clientnum = 1; clientnum < getmaxlocalclients(); clientnum++) {
            if (isdefined(getlocalplayer(clientnum))) {
                finish_per_client(clientnum, b_clear);
            }
        }
        finish_per_client(0, b_clear);
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x0
    // Checksum 0x6c84bac0, Offset: 0xf50
    // Size: 0x1fc
    function play_per_client(clientnum) {
        self endon(#"new_state");
        if (isdefined(self._s.mainanim)) {
            _play_anim(clientnum, self._s.mainanim, self._s.maindelaymin, self._s.maindelaymax, 1, self._s.mainblend, self._s.mainshot);
            flagsys::set("main_done");
            if (is_alive(clientnum)) {
                if (isdefined(self._s.endanim)) {
                    _play_anim(clientnum, self._s.endanim, 0, 0, 1, undefined, self._s.var_e78d2b94, 1);
                    if (is_alive(clientnum)) {
                        if (isdefined(self._s.endanimloop)) {
                            _play_anim(clientnum, self._s.endanimloop, 0, 0, 1, undefined, self._s.var_ffa32106, 1);
                        }
                    }
                } else if (isdefined(self._s.endanimloop)) {
                    _play_anim(clientnum, self._s.endanimloop, 0, 0, 1, undefined, self._s.var_ffa32106, 1);
                }
            }
        }
        thread finish_per_client(clientnum);
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x0
    // Checksum 0xb5328d40, Offset: 0xe28
    // Size: 0x11c
    function play() {
        flagsys::clear("ready");
        flagsys::clear("done");
        flagsys::clear("main_done");
        self notify(#"new_state");
        self endon(#"new_state");
        self notify(#"play");
        waittillframeend();
        if (isdefined(self._n_clientnum)) {
            play_per_client(self._n_clientnum);
            return;
        }
        for (clientnum = 1; clientnum < getmaxlocalclients(); clientnum++) {
            if (isdefined(getlocalplayer(clientnum))) {
                thread play_per_client(clientnum);
            }
        }
        play_per_client(0);
    }

    // Namespace csceneobject
    // Params 1, eflags: 0x0
    // Checksum 0xa4de13e7, Offset: 0xbd8
    // Size: 0x244
    function initialize_per_client(clientnum) {
        self endon(#"new_state");
        if (isdefined(self._s.firstframe) && self._s.firstframe) {
            if (!cscriptbundleobjectbase::error(!isdefined(self._s.mainanim), "No animation defined for first frame.")) {
                _play_anim(clientnum, self._s.mainanim, 0, 0, 0, undefined, self._s.mainshot);
            }
        } else if (isdefined(self._s.initanim)) {
            _play_anim(clientnum, self._s.initanim, self._s.initdelaymin, self._s.initdelaymax, 1, undefined, self._s.var_c30e56b);
            if (is_alive(clientnum)) {
                if (isdefined(self._s.initanimloop)) {
                    _play_anim(clientnum, self._s.initanimloop, 0, 0, 1, undefined, self._s.var_d25c4885, 1);
                }
            }
        } else if (isdefined(self._s.initanimloop)) {
            _play_anim(clientnum, self._s.initanimloop, self._s.initdelaymin, self._s.initdelaymax, 1, undefined, self._s.var_d25c4885, 1);
        } else {
            flagsys::set("ready");
        }
        if (!self._is_valid) {
            flagsys::set("done");
        }
    }

    // Namespace csceneobject
    // Params 0, eflags: 0x0
    // Checksum 0x2f9c8f4c, Offset: 0x8e0
    // Size: 0x2ec
    function initialize() {
        if (isdefined(self._s.spawnoninit) && self._s.spawnoninit) {
            if (isdefined(self._n_clientnum)) {
                _spawn(self._n_clientnum, isdefined(self._s.firstframe) && self._s.firstframe || isdefined(self._s.initanim) || isdefined(self._s.initanimloop));
            } else {
                _spawn(0, isdefined(self._s.firstframe) && self._s.firstframe || isdefined(self._s.initanim) || isdefined(self._s.initanimloop));
                for (clientnum = 1; clientnum < getmaxlocalclients(); clientnum++) {
                    if (isdefined(getlocalplayer(clientnum))) {
                        if (isdefined(self._s.spawnoninit) && self._s.spawnoninit) {
                            _spawn(clientnum, isdefined(self._s.firstframe) && self._s.firstframe || isdefined(self._s.initanim) || isdefined(self._s.initanimloop));
                        }
                    }
                }
            }
        }
        flagsys::clear("ready");
        flagsys::clear("done");
        flagsys::clear("main_done");
        self notify(#"new_state");
        self endon(#"new_state");
        self notify(#"init");
        waittillframeend();
        if (isdefined(self._n_clientnum)) {
            thread initialize_per_client(self._n_clientnum);
            return;
        }
        for (clientnum = 1; clientnum < getmaxlocalclients(); clientnum++) {
            if (isdefined(getlocalplayer(clientnum))) {
                thread initialize_per_client(clientnum);
            }
        }
        initialize_per_client(0);
    }

    // Namespace csceneobject
    // Params 4, eflags: 0x0
    // Checksum 0x45dc0719, Offset: 0x858
    // Size: 0x7e
    function first_init(s_objdef, o_scene, e_ent, localclientnum) {
        cscriptbundleobjectbase::init(s_objdef, o_scene, e_ent, localclientnum);
        _assign_unique_name();
        if (self._e_array.size) {
            _prepare(self._n_clientnum);
        }
        return self;
    }

}

// Namespace scene
// Method(s) 21 Total 30
class cscene : cscriptbundlebase {

    // Namespace cscene
    // Params 0, eflags: 0x0
    // Checksum 0x2beff95f, Offset: 0x2700
    // Size: 0x30
    function constructor() {
        self._n_object_id = 0;
        self._str_state = "";
    }

    // Namespace cscene
    // Params 0, eflags: 0x0
    // Checksum 0xdb7643be, Offset: 0x3fd0
    // Size: 0xa
    function get_state() {
        return self._str_state;
    }

    // Namespace cscene
    // Params 0, eflags: 0x0
    // Checksum 0x30d4688a, Offset: 0x3fb0
    // Size: 0x14
    function on_error() {
        stop();
    }

    // Namespace cscene
    // Params 0, eflags: 0x0
    // Checksum 0xfa5ad4c4, Offset: 0x3e98
    // Size: 0x10c
    function get_valid_objects() {
        a_obj = [];
        foreach (obj in self._a_objects) {
            if (obj._is_valid && ![[ obj ]]->in_a_different_scene()) {
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
    // Params 0, eflags: 0x0
    // Checksum 0x543bfc11, Offset: 0x3e68
    // Size: 0x24
    function function_e8335960() {
        array::flagsys_wait(self._a_objects, "done");
    }

    // Namespace cscene
    // Params 0, eflags: 0x0
    // Checksum 0x69dc4dd6, Offset: 0x3e28
    // Size: 0x34
    function function_2f376105() {
        if (isdefined(self._a_objects)) {
            array::flagsys_wait(self._a_objects, "ready");
        }
    }

    // Namespace cscene
    // Params 0, eflags: 0x0
    // Checksum 0xf318e046, Offset: 0x3df8
    // Size: 0x26
    function is_looping() {
        return isdefined(self._s.looping) && self._s.looping;
    }

    // Namespace cscene
    // Params 0, eflags: 0x0
    // Checksum 0xb376d501, Offset: 0x3dc8
    // Size: 0x26
    function allows_multiple() {
        return isdefined(self._s.var_b575b604) && self._s.var_b575b604;
    }

    // Namespace cscene
    // Params 1, eflags: 0x0
    // Checksum 0x34ba963d, Offset: 0x3d40
    // Size: 0x80
    function get_align_ent(clientnum) {
        e_align = self._e_root;
        if (isdefined(self._s.aligntarget)) {
            e_gdt_align = scene::get_existing_ent(clientnum, self._s.aligntarget);
            if (isdefined(e_gdt_align)) {
                e_align = e_gdt_align;
            }
        }
        return e_align;
    }

    // Namespace cscene
    // Params 0, eflags: 0x0
    // Checksum 0xe82bcb26, Offset: 0x3d28
    // Size: 0xa
    function get_root() {
        return self._e_root;
    }

    // Namespace cscene
    // Params 0, eflags: 0x0
    // Checksum 0xa7af3fe1, Offset: 0x3b70
    // Size: 0x1ae
    function get_ents() {
        a_ents = [];
        for (clientnum = 0; clientnum < getmaxlocalclients(); clientnum++) {
            if (isdefined(getlocalplayer(clientnum))) {
                a_ents[clientnum] = [];
                foreach (o_obj in self._a_objects) {
                    ent = [[ o_obj ]]->get_ent(clientnum);
                    if (isdefined(o_obj._s.name)) {
                        a_ents[clientnum][o_obj._s.name] = ent;
                        continue;
                    }
                    if (!isdefined(a_ents)) {
                        a_ents = [];
                    } else if (!isarray(a_ents)) {
                        a_ents = array(a_ents);
                    }
                    a_ents[a_ents.size] = ent;
                }
            }
        }
        return a_ents;
    }

    // Namespace cscene
    // Params 1, eflags: 0x0
    // Checksum 0x24e99d13, Offset: 0x3798
    // Size: 0x3ce
    function _call_state_funcs(str_state) {
        self endon(#"stopped");
        function_2f376105();
        if (str_state == "play") {
            waittillframeend();
        }
        level notify(self._str_name + "_" + str_state);
        if (isdefined(level.scene_funcs) && isdefined(level.scene_funcs[self._str_name]) && isdefined(level.scene_funcs[self._str_name][str_state])) {
            a_all_ents = get_ents();
            foreach (a_ents in a_all_ents) {
                foreach (handler in level.scene_funcs[self._str_name][str_state]) {
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
                        assertmsg("<dev string:x8a>");
                        break;
                    }
                }
            }
        }
    }

    // Namespace cscene
    // Params 0, eflags: 0x0
    // Checksum 0x3d90f786, Offset: 0x36e0
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
    // Params 2, eflags: 0x0
    // Checksum 0xdbeffb09, Offset: 0x3458
    // Size: 0x280
    function stop(b_clear, b_finished) {
        if (!isdefined(b_clear)) {
            b_clear = 0;
        }
        if (!isdefined(b_finished)) {
            b_finished = 0;
        }
        self notify(#"new_state");
        level flagsys::clear(self._str_name + "_playing");
        level flagsys::clear(self._str_name + "_initialized");
        self._str_state = "";
        thread _call_state_funcs("stop");
        self.scene_stopped = 1;
        foreach (o_obj in self._a_objects) {
            if (isdefined(o_obj) && ![[ o_obj ]]->in_a_different_scene()) {
                thread [[ o_obj ]]->finish(b_clear);
            }
        }
        self notify(#"stopped", b_finished);
        if (isdefined(level.active_scenes[self._str_name])) {
            arrayremovevalue(level.active_scenes[self._str_name], self._e_root);
            if (level.active_scenes[self._str_name].size == 0) {
                level.active_scenes[self._str_name] = undefined;
            }
        }
        if (isdefined(self._e_root) && isdefined(self._e_root.scenes)) {
            arrayremovevalue(self._e_root.scenes, self);
            if (self._e_root.scenes.size == 0) {
                self._e_root.scenes = undefined;
            }
            self._e_root notify(#"scene_done", self._str_name);
            self._e_root.scene_played = 1;
        }
    }

    // Namespace cscene
    // Params 0, eflags: 0x0
    // Checksum 0xaa417818, Offset: 0x3268
    // Size: 0x1e4
    function run_next() {
        if (isdefined(self._s.nextscenebundle) && self._s.vmtype != "both") {
            self waittill(#"stopped", b_finished);
            if (b_finished) {
                if (self._s.scenetype == "fxanim" && self._s.nextscenemode === "init") {
                    if (!cscriptbundlebase::error(!has_init_state(), "Scene can't init next scene '" + self._s.nextscenebundle + "' because it doesn't have an init state.")) {
                        if (allows_multiple()) {
                            self._e_root thread scene::init(self._s.nextscenebundle, get_ents());
                        } else {
                            self._e_root thread scene::init(self._s.nextscenebundle);
                        }
                    }
                    return;
                }
                if (allows_multiple()) {
                    self._e_root thread scene::play(self._s.nextscenebundle, get_ents());
                    return;
                }
                self._e_root thread scene::play(self._s.nextscenebundle);
            }
        }
    }

    // Namespace cscene
    // Params 2, eflags: 0x0
    // Checksum 0xb43c8a89, Offset: 0x2f50
    // Size: 0x30c
    function play(b_testing, str_mode) {
        if (!isdefined(b_testing)) {
            b_testing = 0;
        }
        if (!isdefined(str_mode)) {
            str_mode = "";
        }
        level endon(#"demo_jump");
        self notify(#"new_state");
        self endon(#"new_state");
        self._testing = b_testing;
        self._str_mode = str_mode;
        if (get_valid_objects().size > 0) {
            foreach (o_obj in self._a_objects) {
                thread [[ o_obj ]]->play();
            }
            level flagsys::set(self._str_name + "_playing");
            self._str_state = "play";
            function_2f376105();
            thread _call_state_funcs("play");
            function_e8335960();
            array::flagsys_wait_any_flag(self._a_objects, "done", "main_done");
            if (isdefined(self._e_root)) {
                self._e_root notify(#"scene_done", self._str_name);
                thread _call_state_funcs("done");
            }
            array::flagsys_wait(self._a_objects, "done");
            if (is_looping() || self._str_mode == "loop") {
                if (has_init_state()) {
                    level flagsys::clear(self._str_name + "_playing");
                    thread initialize();
                } else {
                    level flagsys::clear(self._str_name + "_initialized");
                    thread play(b_testing, str_mode);
                }
            } else {
                thread run_next();
                thread stop(0, 1);
            }
            return;
        }
        thread stop(0, 1);
    }

    // Namespace cscene
    // Params 0, eflags: 0x0
    // Checksum 0xc389d09b, Offset: 0x2f30
    // Size: 0x12
    function get_object_id() {
        self._n_object_id++;
        return self._n_object_id;
    }

    // Namespace cscene
    // Params 1, eflags: 0x0
    // Checksum 0xc2eb031f, Offset: 0x2dd8
    // Size: 0x14c
    function initialize(b_playing) {
        if (!isdefined(b_playing)) {
            b_playing = 0;
        }
        self notify(#"new_state");
        self endon(#"new_state");
        if (get_valid_objects().size > 0) {
            level flagsys::set(self._str_name + "_initialized");
            self._str_state = "init";
            foreach (o_obj in self._a_objects) {
                thread [[ o_obj ]]->initialize();
            }
            if (!b_playing) {
                thread _call_state_funcs("init");
            }
        }
        function_e8335960();
        thread stop();
    }

    // Namespace cscene
    // Params 0, eflags: 0x0
    // Checksum 0x335e1c45, Offset: 0x2c30
    // Size: 0x19c
    function get_valid_object_defs() {
        a_obj_defs = [];
        foreach (s_obj in self._s.objects) {
            if (self._s.vmtype == "client" || s_obj.vmtype == "client") {
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
    // Params 5, eflags: 0x0
    // Checksum 0xa85f5853, Offset: 0x2758
    // Size: 0x4cc
    function init(str_scenedef, s_scenedef, e_align, a_ents, b_test_run) {
        cscriptbundlebase::init(str_scenedef, s_scenedef, b_test_run);
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
            foreach (str_name, e_ent in arraycopy(a_ents)) {
                foreach (i, s_obj in arraycopy(a_objs)) {
                    if (s_obj.name === (isdefined(str_name) ? "" + str_name : "")) {
                        cscriptbundlebase::add_object([[ new csceneobject() ]]->first_init(s_obj, self, e_ent, self._e_root.localclientnum));
                        arrayremoveindex(a_ents, str_name);
                        arrayremoveindex(a_objs, i);
                        break;
                    }
                }
            }
            foreach (s_obj in a_objs) {
                cscriptbundlebase::add_object([[ new csceneobject() ]]->first_init(s_obj, self, array::pop(a_ents), self._e_root.localclientnum));
            }
            self thread initialize();
        }
    }

}

// Namespace scene
// Params 7, eflags: 0x0
// Checksum 0xd4a1ed75, Offset: 0x640
// Size: 0x124
function player_scene_animation_skip(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    anim_name = self getcurrentanimscriptedname();
    if (isdefined(anim_name) && anim_name != "") {
        is_looping = isanimlooping(localclientnum, anim_name);
        if (!is_looping) {
            /#
                if (getdvarint("<dev string:x28>") > 0) {
                    printtoprightln("<dev string:x39>" + anim_name + "<dev string:x57>" + gettime(), (0.6, 0.6, 0.6));
                }
            #/
            self setanimtimebyname(anim_name, 1, 1);
        }
    }
}

// Namespace scene
// Params 7, eflags: 0x0
// Checksum 0xd3017f8, Offset: 0x770
// Size: 0x84
function player_scene_skip_completed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    flushsubtitles(localclientnum);
    setdvar("r_graphicContentBlur", 0);
    setdvar("r_makeDark_enable", 0);
}

// Namespace scene
// Params 2, eflags: 0x0
// Checksum 0xf3679ca8, Offset: 0x4678
// Size: 0xcc
function get_existing_ent(clientnum, str_name) {
    e = getent(clientnum, str_name, "animname");
    if (!isdefined(e)) {
        e = getent(clientnum, str_name, "script_animname");
        if (!isdefined(e)) {
            e = getent(clientnum, str_name, "targetname");
            if (!isdefined(e)) {
                e = struct::get(str_name, "targetname");
            }
        }
    }
    return e;
}

// Namespace scene
// Params 0, eflags: 0x2
// Checksum 0xce6a6039, Offset: 0x4750
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("scene", &__init__, &__main__, undefined);
}

// Namespace scene
// Params 0, eflags: 0x0
// Checksum 0xf6f1967e, Offset: 0x4798
// Size: 0x3bc
function __init__() {
    a_scenedefs = struct::get_script_bundles("scene");
    level.server_scenes = [];
    foreach (s_scenedef in a_scenedefs) {
        s_scenedef.editaction = undefined;
        s_scenedef.newobject = undefined;
        if (s_scenedef is_igc()) {
            level.server_scenes[s_scenedef.name] = s_scenedef;
            continue;
        }
        if (s_scenedef.vmtype == "both") {
            n_clientbits = getminbitcountfornum(3);
            /#
                n_clientbits = getminbitcountfornum(6);
            #/
            clientfield::register("world", s_scenedef.name, 1, n_clientbits, "int", &cf_server_sync, 0, 0);
        }
    }
    clientfield::register("toplayer", "postfx_igc", 1, 2, "counter", &postfx_igc, 0, 0);
    clientfield::register("world", "in_igc", 1, 4, "int", &in_igc, 0, 0);
    clientfield::register("toplayer", "player_scene_skip_completed", 1, 2, "counter", &player_scene_skip_completed, 0, 0);
    clientfield::register("allplayers", "player_scene_animation_skip", 1, 2, "counter", &player_scene_animation_skip, 0, 0);
    clientfield::register("actor", "player_scene_animation_skip", 1, 2, "counter", &player_scene_animation_skip, 0, 0);
    clientfield::register("vehicle", "player_scene_animation_skip", 1, 2, "counter", &player_scene_animation_skip, 0, 0);
    clientfield::register("scriptmover", "player_scene_animation_skip", 1, 2, "counter", &player_scene_animation_skip, 0, 0);
    level.var_7e438819 = 0;
    level.active_scenes = [];
    callback::on_localclient_shutdown(&on_localplayer_shutdown);
}

// Namespace scene
// Params 7, eflags: 0x0
// Checksum 0xa99e32, Offset: 0x4b60
// Size: 0xd0
function in_igc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    n_entnum = player getentitynumber();
    b_igc_active = 0;
    if (newval & 1 << n_entnum) {
        b_igc_active = 1;
    }
    igcactive(localclientnum, b_igc_active);
    /#
    #/
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x8bd9bb9b, Offset: 0x4c38
// Size: 0xdc
function private on_localplayer_shutdown(localclientnum) {
    localplayer = self;
    codelocalplayer = getlocalplayer(localclientnum);
    if (isdefined(localplayer) && isdefined(localplayer.localclientnum) && isdefined(codelocalplayer) && localplayer == codelocalplayer) {
        filter::disable_filter_base_frame_transition(localplayer, 5);
        filter::disable_filter_sprite_transition(localplayer, 5);
        filter::disable_filter_frame_transition(localplayer, 5);
        localplayer.postfx_igc_on = undefined;
        localplayer.pstfx_world_construction = 0;
    }
}

// Namespace scene
// Params 7, eflags: 0x0
// Checksum 0xe77c235b, Offset: 0x4d20
// Size: 0x1096
function postfx_igc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    if (isdefined(self.postfx_igc_on) && self.postfx_igc_on) {
        return;
    }
    if (sessionmodeiszombiesgame()) {
        postfx_igc_zombies(localclientnum);
        return;
    }
    if (newval == 3) {
        self thread postfx_igc_short(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
        return;
    }
    self.postfx_igc_on = 1;
    codeimagename = "postfx_igc_image" + localclientnum;
    createscenecodeimage(localclientnum, codeimagename);
    captureframe(localclientnum, codeimagename);
    filter::init_filter_base_frame_transition(self);
    filter::init_filter_sprite_transition(self);
    filter::init_filter_frame_transition(self);
    setfilterpasscodetexture(localclientnum, 5, 0, 0, codeimagename);
    setfilterpasscodetexture(localclientnum, 5, 1, 0, codeimagename);
    setfilterpasscodetexture(localclientnum, 5, 2, 0, codeimagename);
    filter::enable_filter_base_frame_transition(self, 5);
    filter::enable_filter_sprite_transition(self, 5);
    filter::enable_filter_frame_transition(self, 5);
    filter::set_filter_base_frame_transition_warp(self, 5, 1);
    filter::set_filter_base_frame_transition_boost(self, 5, 0.5);
    filter::set_filter_base_frame_transition_durden(self, 5, 1);
    filter::set_filter_base_frame_transition_durden_blur(self, 5, 1);
    filter::set_filter_sprite_transition_elapsed(self, 5, 0);
    filter::set_filter_sprite_transition_octogons(self, 5, 1);
    filter::set_filter_sprite_transition_blur(self, 5, 0);
    filter::set_filter_sprite_transition_boost(self, 5, 0);
    filter::set_filter_frame_transition_light_hexagons(self, 5, 0);
    filter::set_filter_frame_transition_heavy_hexagons(self, 5, 0);
    filter::set_filter_frame_transition_flare(self, 5, 0);
    filter::set_filter_frame_transition_blur(self, 5, 0);
    filter::set_filter_frame_transition_iris(self, 5, 0);
    filter::set_filter_frame_transition_saved_frame_reveal(self, 5, 0);
    filter::set_filter_frame_transition_warp(self, 5, 0);
    filter::set_filter_sprite_transition_move_radii(self, 5, 0, 0);
    filter::set_filter_base_frame_transition_warp(self, 5, 1);
    filter::set_filter_base_frame_transition_boost(self, 5, 1);
    n_hex = 0;
    b_streamer_wait = 1;
    for (i = 0; i < 2000; i += 16) {
        st = i / 1000;
        if (b_streamer_wait && st >= 0.65) {
            for (n_streamer_time_total = 0; !isstreamerready() && n_streamer_time_total < 5000; n_streamer_time_total += gettime() - n_streamer_time) {
                n_streamer_time = gettime();
                for (j = 650; j < 1150; j += 16) {
                    jt = j / 1000;
                    filter::set_filter_frame_transition_heavy_hexagons(self, 5, mapfloat(0.65, 1.15, 0, 1, jt));
                    wait 0.016;
                }
                for (j = 1150; j < 650; j -= 16) {
                    jt = j / 1000;
                    filter::set_filter_frame_transition_heavy_hexagons(self, 5, mapfloat(0.65, 1.15, 0, 1, jt));
                    wait 0.016;
                }
            }
            b_streamer_wait = 0;
        }
        if (st <= 0.5) {
            filter::set_filter_frame_transition_iris(self, 5, mapfloat(0, 0.5, 0, 1, st));
        } else if (st > 0.5 && st <= 0.85) {
            filter::set_filter_frame_transition_iris(self, 5, 1 - mapfloat(0.5, 0.85, 0, 1, st));
        } else {
            filter::set_filter_frame_transition_iris(self, 5, 0);
        }
        if (newval == 2) {
            if (st > 1 && !(isdefined(self.pstfx_world_construction) && self.pstfx_world_construction)) {
                self thread postfx::playpostfxbundle("pstfx_world_construction");
                self.pstfx_world_construction = 1;
            }
        }
        if (st > 0.5 && st <= 1) {
            n_hex = mapfloat(0.5, 1, 0, 1, st);
            filter::set_filter_frame_transition_light_hexagons(self, 5, n_hex);
            if (st >= 0.8) {
                filter::set_filter_frame_transition_flare(self, 5, mapfloat(0.8, 1, 0, 1, st));
            }
        } else if (st > 1 && st < 1.5) {
            filter::set_filter_frame_transition_light_hexagons(self, 5, 1);
            filter::set_filter_frame_transition_flare(self, 5, 1);
        } else {
            filter::set_filter_frame_transition_light_hexagons(self, 5, 0);
            filter::set_filter_frame_transition_flare(self, 5, 0);
        }
        if (st > 0.65 && st <= 1.15) {
            filter::set_filter_frame_transition_heavy_hexagons(self, 5, mapfloat(0.65, 1.15, 0, 1, st));
        } else if (st > 1.21 && st < 1.5) {
            filter::set_filter_frame_transition_heavy_hexagons(self, 5, 1);
        } else {
            filter::set_filter_frame_transition_heavy_hexagons(self, 5, 0);
        }
        if (st > 1.21 && st <= 1.5) {
            filter::set_filter_frame_transition_blur(self, 5, mapfloat(1, 1.5, 0, 1, st));
            filter::set_filter_sprite_transition_boost(self, 5, mapfloat(1, 1.5, 0, 1, st));
            filter::set_filter_frame_transition_saved_frame_reveal(self, 5, mapfloat(1, 1.5, 0, 1, st));
            filter::set_filter_base_frame_transition_durden_blur(self, 5, 1 - mapfloat(1, 1.5, 0, 1, st));
            filter::set_filter_sprite_transition_blur(self, 5, mapfloat(1, 1.5, 0, 0.1, st));
        } else if (st > 1.5) {
            filter::set_filter_frame_transition_blur(self, 5, 1);
            filter::set_filter_sprite_transition_boost(self, 5, 1);
            filter::set_filter_frame_transition_saved_frame_reveal(self, 5, 1);
            filter::set_filter_base_frame_transition_durden_blur(self, 5, 0);
            filter::set_filter_sprite_transition_blur(self, 5, 0.1);
        }
        if (st > 1 && st <= 1.45) {
            filter::set_filter_base_frame_transition_boost(self, 5, mapfloat(1, 1.45, 0.5, 1, st));
        } else if (st > 1.45 && st < 1.75) {
            filter::set_filter_base_frame_transition_boost(self, 5, 1);
        } else if (st >= 1.75) {
            filter::set_filter_base_frame_transition_boost(self, 5, 1 - mapfloat(1.75, 2, 0, 1, st));
        }
        if (st >= 1.75) {
            val = 1 - mapfloat(1.75, 2, 0, 1, st);
            filter::set_filter_frame_transition_blur(self, 5, val);
            filter::set_filter_base_frame_transition_warp(self, 5, val);
        }
        if (st >= 1.25) {
            val = 1 - mapfloat(1.25, 1.75, 0, 1, st);
            filter::set_filter_sprite_transition_octogons(self, 5, val);
        }
        if (st >= 1.75 && st < 2) {
            filter::set_filter_base_frame_transition_durden(self, 5, 1 - mapfloat(1.75, 2, 0, 1, st));
        }
        if (st > 1) {
            filter::set_filter_sprite_transition_elapsed(self, 5, i - 1000);
            outer_radii = mapfloat(1, 1.5, 0, 2000, st);
            filter::set_filter_sprite_transition_move_radii(self, 5, outer_radii - 256, outer_radii);
        }
        if (st > 1.15 && st < 1.85) {
            filter::set_filter_frame_transition_warp(self, 5, -1 * mapfloat(1.15, 1.85, 0, 1, st));
        } else if (st >= 1.85) {
            filter::set_filter_frame_transition_warp(self, 5, -1 * (1 - mapfloat(1.85, 2, 0, 1, st)));
        }
        wait 0.016;
    }
    filter::disable_filter_base_frame_transition(self, 5);
    filter::disable_filter_sprite_transition(self, 5);
    filter::disable_filter_frame_transition(self, 5);
    self.pstfx_world_construction = 0;
    freecodeimage(localclientnum, codeimagename);
    self.postfx_igc_on = undefined;
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0x75fbb1f6, Offset: 0x5dc0
// Size: 0x56
function postfx_igc_zombies(localclientnum) {
    lui::screen_fade_out(0, "black");
    wait 0.016;
    lui::screen_fade_in(0.3);
    self.postfx_igc_on = undefined;
}

// Namespace scene
// Params 7, eflags: 0x0
// Checksum 0xaac913f6, Offset: 0x5e20
// Size: 0x386
function postfx_igc_short(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self.postfx_igc_on = 1;
    codeimagename = "postfx_igc_image" + localclientnum;
    createscenecodeimage(localclientnum, codeimagename);
    captureframe(localclientnum, codeimagename);
    filter::init_filter_base_frame_transition(self);
    filter::init_filter_sprite_transition(self);
    filter::init_filter_frame_transition(self);
    setfilterpasscodetexture(localclientnum, 5, 0, 0, codeimagename);
    setfilterpasscodetexture(localclientnum, 5, 1, 0, codeimagename);
    setfilterpasscodetexture(localclientnum, 5, 2, 0, codeimagename);
    filter::enable_filter_base_frame_transition(self, 5);
    filter::enable_filter_sprite_transition(self, 5);
    filter::enable_filter_frame_transition(self, 5);
    filter::set_filter_frame_transition_iris(self, 5, 0);
    b_streamer_wait = 1;
    for (i = 0; i < 850; i += 16) {
        st = i / 1000;
        if (st <= 0.5) {
            filter::set_filter_frame_transition_iris(self, 5, mapfloat(0, 0.5, 0, 1, st));
        } else if (st > 0.5 && st <= 0.85) {
            filter::set_filter_frame_transition_iris(self, 5, 1 - mapfloat(0.5, 0.85, 0, 1, st));
        } else {
            filter::set_filter_frame_transition_iris(self, 5, 0);
        }
        wait 0.016;
    }
    filter::disable_filter_base_frame_transition(self, 5);
    filter::disable_filter_sprite_transition(self, 5);
    filter::disable_filter_frame_transition(self, 5);
    freecodeimage(localclientnum, codeimagename);
    self.postfx_igc_on = undefined;
}

// Namespace scene
// Params 7, eflags: 0x0
// Checksum 0xf8235b94, Offset: 0x61b0
// Size: 0x196
function cf_server_sync(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 0:
        if (is_active(fieldname)) {
            level thread stop(fieldname);
        }
        break;
    case 1:
        level thread init(fieldname);
        break;
    case 2:
        level thread play(fieldname);
        break;
    }
    /#
        switch (newval) {
        case 3:
            if (is_active(fieldname)) {
                level thread stop(fieldname, 1, undefined, undefined, 1);
            }
            break;
        case 4:
            level thread init(fieldname, undefined, undefined, 1);
            break;
        case 5:
            level thread play(fieldname, undefined, undefined, 1);
            break;
        }
    #/
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0xac0ec652, Offset: 0x6350
// Size: 0x16a
function remove_invalid_scene_objects(s_scenedef) {
    a_invalid_object_indexes = [];
    foreach (i, s_object in s_scenedef.objects) {
        if (!isdefined(s_object.name) && !isdefined(s_object.model)) {
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
// Params 0, eflags: 0x0
// Checksum 0x259fb470, Offset: 0x64c8
// Size: 0x7a
function is_igc() {
    return isstring(self.cameraswitcher) || isstring(self.extracamswitcher1) || isstring(self.extracamswitcher2) || isstring(self.extracamswitcher3) || isstring(self.extracamswitcher4);
}

// Namespace scene
// Params 0, eflags: 0x0
// Checksum 0x6b8262b2, Offset: 0x6550
// Size: 0x2da
function __main__() {
    wait 0.05;
    if (isdefined(level.disablefxaniminsplitscreencount)) {
        if (isdefined(level.localplayers)) {
            if (level.localplayers.size >= level.disablefxaniminsplitscreencount) {
                return;
            }
        }
    }
    a_instances = arraycombine(struct::get_array("scriptbundle_scene", "classname"), struct::get_array("scriptbundle_fxanim", "classname"), 0, 0);
    foreach (s_instance in a_instances) {
    }
    foreach (s_instance in a_instances) {
        s_scenedef = struct::get_script_bundle("scene", s_instance.scriptbundlename);
        assert(isdefined(s_scenedef), "<dev string:xae>" + s_instance.origin + "<dev string:xbe>" + s_instance.scriptbundlename + "<dev string:xd3>");
        if (s_scenedef.vmtype == "client") {
            if (isdefined(level.var_283122e6) && [[ level.var_283122e6 ]](s_instance.scriptbundlename)) {
                continue;
            }
            if (isdefined(s_instance.spawnflags) && (s_instance.spawnflags & 2) == 2) {
                s_instance thread play();
                continue;
            }
            if (isdefined(s_instance.spawnflags) && (s_instance.spawnflags & 1) == 1) {
                s_instance thread init();
            }
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0xd2fb4dff, Offset: 0x6838
// Size: 0x3c
function _trigger_init(trig) {
    trig endon(#"entityshutdown");
    trig waittill(#"trigger");
    _init_instance();
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0x314cd7b2, Offset: 0x6880
// Size: 0x86
function _trigger_play(trig) {
    trig endon(#"entityshutdown");
    do {
        trig waittill(#"trigger");
        _play_instance();
    } while (isdefined(get_scenedef(self.scriptbundlename).looping) && get_scenedef(self.scriptbundlename).looping);
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0xdc027431, Offset: 0x6910
// Size: 0x3c
function _trigger_stop(trig) {
    trig endon(#"entityshutdown");
    trig waittill(#"trigger");
    _stop_instance();
}

// Namespace scene
// Params 4, eflags: 0x20 variadic
// Checksum 0xca6922f0, Offset: 0x6958
// Size: 0x19e
function add_scene_func(str_scenedef, func, str_state, ...) {
    if (!isdefined(str_state)) {
        str_state = "play";
    }
    assert(isdefined(get_scenedef(str_scenedef)), "<dev string:xe9>" + str_scenedef + "<dev string:xd3>");
    if (!isdefined(level.scene_funcs)) {
        level.scene_funcs = [];
    }
    if (!isdefined(level.scene_funcs[str_scenedef])) {
        level.scene_funcs[str_scenedef] = [];
    }
    if (!isdefined(level.scene_funcs[str_scenedef][str_state])) {
        level.scene_funcs[str_scenedef][str_state] = [];
    } else if (!isarray(level.scene_funcs[str_scenedef][str_state])) {
        level.scene_funcs[str_scenedef][str_state] = array(level.scene_funcs[str_scenedef][str_state]);
    }
    level.scene_funcs[str_scenedef][str_state][level.scene_funcs[str_scenedef][str_state].size] = array(func, vararg);
}

// Namespace scene
// Params 3, eflags: 0x0
// Checksum 0x3f26a687, Offset: 0x6b00
// Size: 0x14e
function remove_scene_func(str_scenedef, func, str_state) {
    if (!isdefined(str_state)) {
        str_state = "play";
    }
    assert(isdefined(get_scenedef(str_scenedef)), "<dev string:x114>" + str_scenedef + "<dev string:xd3>");
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
// Params 5, eflags: 0x0
// Checksum 0x5750d335, Offset: 0x6c58
// Size: 0x1a8
function spawn(arg1, arg2, arg3, arg4, b_test_run) {
    str_scenedef = arg1;
    assert(isdefined(str_scenedef), "<dev string:x142>");
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
// Params 4, eflags: 0x0
// Checksum 0xcba0d410, Offset: 0x6e08
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
                assert(a_instances.size, "<dev string:x16d>" + str_key + "<dev string:x18b>" + str_value + "<dev string:x18f>");
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
// Params 1, eflags: 0x0
// Checksum 0xc44ff642, Offset: 0x70a8
// Size: 0x2a
function get_scenedef(str_scenedef) {
    return struct::get_script_bundle("scene", str_scenedef);
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0x6c5f10da, Offset: 0x70e0
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
// Params 3, eflags: 0x0
// Checksum 0x31f219ca, Offset: 0x7218
// Size: 0x1bc
function _init_instance(str_scenedef, a_ents, b_test_run) {
    if (!isdefined(b_test_run)) {
        b_test_run = 0;
    }
    if (!isdefined(str_scenedef)) {
        str_scenedef = self.scriptbundlename;
    }
    s_bundle = get_scenedef(str_scenedef);
    /#
        assert(isdefined(str_scenedef), "<dev string:x192>" + (isdefined(self.origin) ? self.origin : "<dev string:x19d>") + "<dev string:x1a3>");
        assert(isdefined(s_bundle), "<dev string:x192>" + (isdefined(self.origin) ? self.origin : "<dev string:x19d>") + "<dev string:x1bf>" + str_scenedef + "<dev string:xd3>");
    #/
    o_scene = get_active_scene(str_scenedef);
    if (isdefined(o_scene)) {
        if (isdefined(self.scriptbundlename) && !b_test_run) {
            return o_scene;
        }
        thread [[ o_scene ]]->initialize(1);
    } else {
        o_scene = new cscene();
        [[ o_scene ]]->init(str_scenedef, s_bundle, self, a_ents, b_test_run);
    }
    return o_scene;
}

// Namespace scene
// Params 5, eflags: 0x0
// Checksum 0x9da0cd6a, Offset: 0x73e0
// Size: 0x3bc
function play(arg1, arg2, arg3, b_test_run, str_mode) {
    if (!isdefined(b_test_run)) {
        b_test_run = 0;
    }
    if (!isdefined(str_mode)) {
        str_mode = "";
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
                assert(a_instances.size, "<dev string:x16d>" + str_key + "<dev string:x18b>" + str_value + "<dev string:x18f>");
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
                self thread _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, str_mode);
            } else {
                s_tracker.n_scene_count = a_instances.size;
                foreach (s_instance in a_instances) {
                    if (isdefined(s_instance)) {
                        s_instance thread _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, str_mode);
                    }
                }
            }
        }
    } else if (isstring(arg1)) {
        self thread _play_instance(s_tracker, arg1, arg2, b_test_run, str_mode);
    } else {
        self thread _play_instance(s_tracker, arg2, arg1, b_test_run, str_mode);
    }
    function_e420df65(s_tracker);
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x43cd7ea2, Offset: 0x77a8
// Size: 0x54
function private function_e420df65(s_tracker) {
    level endon(#"demo_jump");
    for (i = 0; i < s_tracker.n_scene_count; i++) {
        s_tracker waittill(#"scene_done");
    }
}

// Namespace scene
// Params 5, eflags: 0x0
// Checksum 0xf0b42825, Offset: 0x7808
// Size: 0x150
function _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, str_mode) {
    if (!isdefined(str_scenedef)) {
        str_scenedef = self.scriptbundlename;
    }
    if (self.scriptbundlename === str_scenedef) {
        str_scenedef = self.scriptbundlename;
        self.scene_played = 1;
    }
    o_scene = _init_instance(str_scenedef, a_ents, b_test_run);
    if (isdefined(o_scene)) {
        thread [[ o_scene ]]->play(b_test_run, str_mode);
    }
    self waittill_instance_scene_done(str_scenedef);
    if (isdefined(self)) {
        if (isdefined(get_scenedef(self.scriptbundlename).looping) && isdefined(self.scriptbundlename) && get_scenedef(self.scriptbundlename).looping) {
            self.scene_played = 0;
        }
    }
    s_tracker notify(#"scene_done");
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x6867a7da, Offset: 0x7960
// Size: 0x2a
function private waittill_instance_scene_done(str_scenedef) {
    level endon(#"demo_jump");
    self waittillmatch(#"scene_done", str_scenedef);
}

// Namespace scene
// Params 5, eflags: 0x0
// Checksum 0xe6f7d47b, Offset: 0x7998
// Size: 0x2ac
function stop(arg1, arg2, arg3, b_cancel, b_no_assert) {
    if (!isdefined(b_no_assert)) {
        b_no_assert = 0;
    }
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
                assert(b_no_assert || a_instances.size, "<dev string:x16d>" + str_key + "<dev string:x18b>" + str_value + "<dev string:x18f>");
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
                    s_instance _stop_instance(b_clear, str_value, b_cancel);
                }
            }
        }
        return;
    }
    if (isstring(arg1)) {
        _stop_instance(arg2, arg1, b_cancel);
        return;
    }
    _stop_instance(arg1, arg2, b_cancel);
}

// Namespace scene
// Params 3, eflags: 0x0
// Checksum 0xbb55ae47, Offset: 0x7c50
// Size: 0x11e
function _stop_instance(b_clear, str_scenedef, b_cancel) {
    if (!isdefined(b_clear)) {
        b_clear = 0;
    }
    if (!isdefined(b_cancel)) {
        b_cancel = 0;
    }
    if (isdefined(self.scenes)) {
        foreach (o_scene in arraycopy(self.scenes)) {
            str_scene_name = [[ o_scene ]]->get_name();
            if (!isdefined(str_scenedef) || str_scene_name == str_scenedef) {
                thread [[ o_scene ]]->stop(b_clear, b_cancel);
            }
        }
    }
}

// Namespace scene
// Params 3, eflags: 0x0
// Checksum 0xf50f7a1a, Offset: 0x7d78
// Size: 0x3c
function cancel(arg1, arg2, arg3) {
    stop(arg1, arg2, arg3, 1);
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0x65a90505, Offset: 0x7dc0
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
// Params 0, eflags: 0x0
// Checksum 0xf51e0c3b, Offset: 0x7eb8
// Size: 0x46
function _has_init_state() {
    return isdefined(self.firstframe) && (isdefined(self.spawnoninit) && self.spawnoninit || isdefined(self.initanim) || isdefined(self.initanimloop) || self.firstframe);
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0x33d116ef, Offset: 0x7f08
// Size: 0x2a
function get_prop_count(str_scenedef) {
    return _get_type_count("prop", str_scenedef);
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0x2a373b43, Offset: 0x7f40
// Size: 0x2a
function get_vehicle_count(str_scenedef) {
    return _get_type_count("vehicle", str_scenedef);
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0x28ce90af, Offset: 0x7f78
// Size: 0x2a
function get_actor_count(str_scenedef) {
    return _get_type_count("actor", str_scenedef);
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0x24ee00f3, Offset: 0x7fb0
// Size: 0x2a
function get_player_count(str_scenedef) {
    return _get_type_count("player", str_scenedef);
}

// Namespace scene
// Params 2, eflags: 0x0
// Checksum 0xb865b883, Offset: 0x7fe8
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
// Params 1, eflags: 0x0
// Checksum 0x53ae60e5, Offset: 0x8128
// Size: 0x4e
function is_active(str_scenedef) {
    if (self == level) {
        return (get_active_scenes(str_scenedef).size > 0);
    }
    return isdefined(get_active_scene(str_scenedef));
}

// Namespace scene
// Params 1, eflags: 0x0
// Checksum 0xf9a181b8, Offset: 0x8180
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
// Params 1, eflags: 0x0
// Checksum 0x97ac7ee9, Offset: 0x8220
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
// Params 1, eflags: 0x0
// Checksum 0xf7f21354, Offset: 0x8330
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
// Params 0, eflags: 0x0
// Checksum 0x7eda69ac, Offset: 0x83f0
// Size: 0x5c
function is_capture_mode() {
    str_mode = getdvarstring("scene_menu_mode", "default");
    if (issubstr(str_mode, "capture")) {
        return 1;
    }
    return 0;
}

