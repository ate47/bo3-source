#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_7206ad77;

// Namespace namespace_7206ad77
// Method(s) 15 Total 15
class class_fa0d90fd {

    // Namespace namespace_fa0d90fd
    // Params 5, eflags: 0x1 linked
    // Checksum 0xee12698c, Offset: 0x14f0
    // Size: 0x118
    function function_f8655445(var_d5b66a0, direction, v_moveto, v_angles, n_time) {
        level endon(self.var_950bb2b2 + "_disabled");
        var_d5b66a0 linkto(self.var_86d0e1a0);
        while (true) {
            level waittill(direction + self.var_950bb2b2 + "_doors");
            var_d5b66a0 unlink();
            var_d5b66a0 moveto(var_d5b66a0.origin + v_moveto, n_time);
            var_d5b66a0 rotateto(var_d5b66a0.angles + v_angles, n_time);
            wait(n_time);
            var_d5b66a0 linkto(self.var_86d0e1a0);
        }
    }

    // Namespace namespace_fa0d90fd
    // Params 1, eflags: 0x1 linked
    // Checksum 0xf160328a, Offset: 0x11d0
    // Size: 0x314
    function function_9cdfa1cb(var_d5b66a0) {
        open_struct = struct::get(var_d5b66a0.target, "targetname");
        assert(isdefined(open_struct), "target" + var_d5b66a0.origin);
        assert(isdefined(open_struct.target), "target" + var_d5b66a0.origin);
        var_f0bc435f = struct::get(open_struct.target, "targetname");
        assert(isdefined(var_f0bc435f), "target" + var_d5b66a0.origin);
        var_73345118 = isdefined(open_struct.script_float) ? open_struct.script_float : 1;
        var_ef73127f = isdefined(var_f0bc435f.script_float) ? var_f0bc435f.script_float : 1;
        var_b1d2ef55 = 0;
        if (isdefined(var_f0bc435f.script_noteworthy) && var_f0bc435f.script_noteworthy == "stay_closed") {
            var_b1d2ef55 = 1;
        }
        var_d5b66a0.origin = open_struct.origin;
        var_d5b66a0.angles = open_struct.angles;
        var_26dfbb14 = var_f0bc435f.origin - var_d5b66a0.origin;
        var_ebf964d9 = var_f0bc435f.angles - var_d5b66a0.angles;
        var_9a35a990 = var_d5b66a0.origin - var_f0bc435f.origin;
        var_35a4cf2b = var_d5b66a0.angles - var_f0bc435f.angles;
        self thread function_f8655445(var_d5b66a0, "close_", var_26dfbb14, var_ebf964d9, var_ef73127f);
        if (!var_b1d2ef55) {
            self thread function_f8655445(var_d5b66a0, "open_", var_9a35a990, var_35a4cf2b, var_73345118);
        }
    }

    // Namespace namespace_fa0d90fd
    // Params 3, eflags: 0x1 linked
    // Checksum 0x96f885d, Offset: 0x1150
    // Size: 0x74
    function function_dbec37e0(var_228ae8b0, var_544bc7c7, notify_stop) {
        level waittill(var_544bc7c7);
        if (isdefined(var_228ae8b0.script_sound)) {
            var_228ae8b0 thread sound::loop_in_space(level.scr_sound[var_228ae8b0.script_sound], var_228ae8b0.origin, notify_stop);
        }
    }

    // Namespace namespace_fa0d90fd
    // Params 0, eflags: 0x1 linked
    // Checksum 0x69d678c4, Offset: 0xff0
    // Size: 0x158
    function function_c721cb49() {
        level notify("vehicle_platform_" + self.var_950bb2b2 + "_stop");
        level notify("stop_" + self.var_950bb2b2 + "_movement_sound");
        level notify("stop_" + self.var_950bb2b2 + "_klaxon");
        level notify("open_" + self.var_950bb2b2 + "_doors");
        if (isdefined(self.script_sound)) {
            self.var_bfd6a2f9 playsound(level.scr_sound[self.script_sound]);
        }
        if (isdefined(level.scr_sound) && isdefined(level.scr_sound["elevator_end"])) {
            self.var_bfd6a2f9 playsound(level.scr_sound["elevator_end"]);
        }
        if (isdefined(self.var_453a7636)) {
            if (isdefined(self.var_b94c1eb)) {
                self.var_86d0e1a0 thread [[ self.var_453a7636 ]](self.var_b94c1eb);
                return;
            }
            self.var_86d0e1a0 thread [[ self.var_453a7636 ]]();
        }
    }

    // Namespace namespace_fa0d90fd
    // Params 1, eflags: 0x1 linked
    // Checksum 0x424e6746, Offset: 0xf08
    // Size: 0xe0
    function function_d96bbc47(var_e00aef4b) {
        if (self.var_3a0cae84) {
            return;
        }
        if (isdefined(var_e00aef4b) && var_e00aef4b) {
            self.var_6c951b00 vehicle::get_on_and_go_path(self.var_e0473e16);
        } else {
            self.var_6c951b00 vehicle::go_path();
        }
        level notify("vehicle_platform_" + self.var_950bb2b2 + "_move");
        if (isdefined(self.m_func_start)) {
            if (isdefined(self.var_b94c1eb)) {
                self.var_86d0e1a0 thread [[ self.m_func_start ]](self.var_b94c1eb);
                return;
            }
            self.var_86d0e1a0 thread [[ self.m_func_start ]]();
        }
    }

    // Namespace namespace_fa0d90fd
    // Params 2, eflags: 0x1 linked
    // Checksum 0x8fa8a731, Offset: 0xec8
    // Size: 0x34
    function set_speed(var_43cb7e16, var_a1cc6c78) {
        self.var_6c951b00 vehicle::set_speed(var_43cb7e16, var_a1cc6c78);
    }

    // Namespace namespace_fa0d90fd
    // Params 1, eflags: 0x1 linked
    // Checksum 0x37294bc7, Offset: 0xe38
    // Size: 0x84
    function function_99848f4e(var_87b2bbe5) {
        self.var_e0473e16 = getvehiclenode(var_87b2bbe5, "targetname");
        assert(isdefined(self.var_e0473e16), "target" + var_87b2bbe5);
        self.var_6c951b00 vehicle::get_on_path(self.var_e0473e16);
    }

    // Namespace namespace_fa0d90fd
    // Params 1, eflags: 0x1 linked
    // Checksum 0x4e5e9f29, Offset: 0xc50
    // Size: 0x1e0
    function trigger_think(e_trigger) {
        e_trigger endon(#"death");
        level endon(self.var_950bb2b2 + "_disabled");
        var_2c96ba3c = self.var_e0473e16;
        while (true) {
            e_trigger trigger::wait_till();
            level notify("start_" + self.var_950bb2b2 + "_klaxon");
            level notify("close_" + self.var_950bb2b2 + "_doors");
            if (isdefined(e_trigger.script_wait)) {
                wait(e_trigger.script_wait);
            } else {
                wait(2);
            }
            if (self.var_e0473e16 != var_2c96ba3c) {
                var_e00aef4b = 1;
            }
            self.var_bfd6a2f9 playsound("veh_" + self.var_950bb2b2 + "_start");
            self.var_bfd6a2f9 playloopsound("veh_" + self.var_950bb2b2 + "_loop", 0.5);
            self thread function_d96bbc47(var_e00aef4b);
            self.var_6c951b00 waittill(#"reached_end_node");
            self.var_bfd6a2f9 playsound("veh_" + self.var_950bb2b2 + "_stop");
            self.var_bfd6a2f9 stoploopsound(0.5);
            function_c721cb49();
        }
    }

    // Namespace namespace_fa0d90fd
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe75eb1e3, Offset: 0xa90
    // Size: 0x1b4
    function damage_watcher() {
        self.var_6265e5b9 setcandamage(1);
        self.var_6265e5b9.health = 100;
        self.var_6265e5b9 waittill(#"death");
        self.var_3a0cae84 = 1;
        self thread fx::play("mobile_shop_fall_explosion", self.var_6c951b00.origin, (0, 0, 0));
        wait(0.3);
        self thread fx::play("mobile_shop_fall_explosion", self.var_6c951b00.origin - (0, 200, 0), (0, 0, 0));
        self.var_6265e5b9 hide();
        a_ai = getaiarray(self.var_950bb2b2, "groupname");
        foreach (ai in a_ai) {
            ai kill();
        }
        self.var_6c951b00 vehicle::pause_path();
    }

    // Namespace namespace_fa0d90fd
    // Params 1, eflags: 0x1 linked
    // Checksum 0x4f030cbd, Offset: 0xa18
    // Size: 0x70
    function function_845aae7f(var_87b2bbe5) {
        nd_start = getvehiclenode(var_87b2bbe5, "targetname");
        assert(isdefined(self.var_e0473e16), "target" + var_87b2bbe5);
        self.var_e0473e16 = nd_start;
    }

    // Namespace namespace_fa0d90fd
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2c2d801e, Offset: 0xa00
    // Size: 0xa
    function function_9bc3d62a() {
        return self.var_6c951b00;
    }

    // Namespace namespace_fa0d90fd
    // Params 3, eflags: 0x1 linked
    // Checksum 0xba14013c, Offset: 0x9b8
    // Size: 0x40
    function function_4cc0ffc1(func_start, var_8e84437a, arg) {
        self.m_func_start = func_start;
        self.var_453a7636 = var_8e84437a;
        self.var_b94c1eb = arg;
    }

    // Namespace namespace_fa0d90fd
    // Params 2, eflags: 0x1 linked
    // Checksum 0xaab35220, Offset: 0x2b0
    // Size: 0x6fc
    function init(var_e6d08de, var_87b2bbe5) {
        if (!level flag::get("first_player_spawned")) {
            wait(0.05);
        }
        self.var_950bb2b2 = var_e6d08de;
        self.var_3a0cae84 = 0;
        self.var_6c951b00 = getent(self.var_950bb2b2 + "_vehicle", "targetname");
        if (!isdefined(self.var_6c951b00)) {
            self.var_6c951b00 = getent(self.var_950bb2b2 + "_vehicle_vh", "targetname");
        }
        self.var_6c951b00.team = "spectator";
        self.var_6c951b00 setmovingplatformenabled(1);
        assert(isdefined(self.var_6c951b00), "target" + self.var_950bb2b2 + "target");
        self.var_1a144436 = getentarray(self.var_950bb2b2, "targetname");
        foreach (var_4efa37e7 in self.var_1a144436) {
            var_4efa37e7 enablelinkto();
            var_4efa37e7 linkto(self.var_6c951b00);
            if (var_4efa37e7.classname == "script_brushmodel") {
                assert(!isdefined(self.var_86d0e1a0), "target" + self.var_950bb2b2);
                self.var_86d0e1a0 = var_4efa37e7;
            }
        }
        assert(isdefined(self.var_86d0e1a0), "target" + self.var_950bb2b2);
        self.var_86d0e1a0 setmovingplatformenabled(1);
        self.var_bfd6a2f9 = spawn("script_origin", self.var_86d0e1a0.origin);
        self.var_bfd6a2f9 linkto(self.var_86d0e1a0);
        self.var_6265e5b9 = getent(self.var_950bb2b2 + "_weakpoint", "targetname");
        if (isdefined(self.var_6265e5b9)) {
            self.var_6265e5b9 enablelinkto();
            self.var_6265e5b9 linkto(self.var_86d0e1a0);
            self thread damage_watcher();
        }
        self function_99848f4e(var_87b2bbe5);
        var_6518a90a = getentarray(var_e6d08de, "target");
        foreach (var_6518a90a in var_6518a90a) {
            if (var_6518a90a.classname == "script_model" || var_6518a90a.classname == "script_brushmodel") {
                var_31353764 = getent(var_6518a90a.targetname, "target");
                self thread trigger_think(var_31353764);
                continue;
            }
            self thread trigger_think(var_6518a90a);
        }
        var_1ceefaa7 = getentarray(self.var_86d0e1a0.target, "targetname");
        var_2adc1705 = struct::get_array(self.var_86d0e1a0.target, "targetname");
        var_3823bc4b = arraycombine(var_1ceefaa7, var_2adc1705, 1, 0);
        foreach (var_d5b66a0 in var_3823bc4b) {
            if (!isdefined(var_d5b66a0.script_noteworthy)) {
                continue;
            }
            switch (var_d5b66a0.script_noteworthy) {
            case 16:
                self thread function_dbec37e0(var_d5b66a0, "start_" + self.var_950bb2b2 + "_klaxon", "stop_" + self.var_950bb2b2 + "_klaxon");
                break;
            case 17:
                self thread function_9cdfa1cb(var_d5b66a0);
                break;
            case 18:
                self thread function_dbec37e0(var_d5b66a0, "vehicle_platform_" + self.var_950bb2b2 + "_move", "stop_" + self.var_950bb2b2 + "_movement_sound");
                break;
            }
        }
    }

}

