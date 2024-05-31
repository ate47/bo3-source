#using scripts/zm/zm_zod_poweronswitch;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/scene_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_de48615;

// Namespace namespace_de48615
// Method(s) 12 Total 12
class class_3f5d3dd7 {

    // Namespace namespace_3f5d3dd7
    // Params 0, eflags: 0x1 linked
    // namespace_3f5d3dd7<file_0>::function_64c24459
    // Checksum 0x51e71b8a, Offset: 0xeb0
    // Size: 0x44
    function function_64c24459() {
        self moveto(self.origin - (0, 0, 10000), 0.05);
        wait(0.05);
    }

    // Namespace namespace_3f5d3dd7
    // Params 4, eflags: 0x1 linked
    // namespace_3f5d3dd7<file_0>::function_15ee241e
    // Checksum 0xdf28c6e0, Offset: 0xe58
    // Size: 0x4c
    function function_15ee241e(e_mover, v_angles, n_rotate, n_duration) {
        e_mover rotateto(v_angles + (0, n_rotate, 0), n_duration);
    }

    // Namespace namespace_3f5d3dd7
    // Params 4, eflags: 0x1 linked
    // namespace_3f5d3dd7<file_0>::function_fe51d425
    // Checksum 0x1d4685a5, Offset: 0xdb8
    // Size: 0x94
    function function_fe51d425(e_mover, var_ebe89e4d, var_b09b5614, n_duration) {
        if (!var_ebe89e4d) {
            var_b09b5614 *= -1;
        }
        v_offset = anglestoup((0, 0, 0)) * var_b09b5614;
        e_mover moveto(e_mover.origin + v_offset, n_duration);
    }

    // Namespace namespace_3f5d3dd7
    // Params 2, eflags: 0x1 linked
    // namespace_3f5d3dd7<file_0>::function_c59fb890
    // Checksum 0xf80d374f, Offset: 0x870
    // Size: 0x53c
    function function_c59fb890(var_ebe89e4d, var_4faef07e) {
        if (self.var_8ba3e653 != "underground" && self.var_8ba3e653 != "club" && var_ebe89e4d && !var_4faef07e) {
            self.var_f2f66550[0] scene::play("p7_fxanim_zm_zod_mechanical_stairs_bundle");
            foreach (e_gate in self.var_39624e3b) {
                e_gate thread scene::play("p7_fxanim_zm_zod_gate_scissor_short_bundle");
            }
            self.var_5fd95ddf = 2;
            self.var_f3446503[0] function_64c24459();
            self.var_f3446503[0] connectpaths();
            return;
        }
        if (var_4faef07e) {
            var_8cf4ae15 = 0.05;
            var_3bdcaf84 = 0.05;
        } else {
            var_8cf4ae15 = 0.5;
            var_3bdcaf84 = 0.25;
        }
        if (var_ebe89e4d) {
            self.var_5fd95ddf = 1;
        } else {
            self.var_5fd95ddf = 3;
        }
        if (!var_ebe89e4d) {
            foreach (e_blocker in self.var_1c98028c) {
                self thread function_fe51d425(e_blocker, !var_ebe89e4d, 64, var_3bdcaf84);
            }
        }
        foreach (var_6de2b083 in self.var_ae9b1946) {
            if (var_ebe89e4d && isdefined(var_6de2b083.script_noteworthy) && var_6de2b083.script_noteworthy == "swing_door" && isdefined(var_6de2b083.angles) && isdefined(var_6de2b083.script_float)) {
                self thread function_15ee241e(var_6de2b083, var_6de2b083.angles, var_6de2b083.script_float, 0.5);
            } else {
                self thread function_fe51d425(var_6de2b083, var_ebe89e4d, var_6de2b083.script_int, var_8cf4ae15);
            }
            if (isdefined(self.var_5db129b)) {
                wait(self.var_5db129b);
            }
        }
        wait(var_8cf4ae15);
        if (var_ebe89e4d) {
            foreach (e_blocker in self.var_1c98028c) {
                self thread function_fe51d425(e_blocker, !var_ebe89e4d, 64, var_3bdcaf84);
            }
        }
        if (var_ebe89e4d) {
            self.var_5fd95ddf = 2;
            self.var_f3446503[0] function_64c24459();
            self.var_f3446503[0] connectpaths();
        } else {
            self.var_5fd95ddf = 0;
            self.var_f3446503[0] setvisibletoall();
            self.var_f3446503[0] disconnectpaths();
        }
        if (var_ebe89e4d) {
            if (isdefined(self.var_ae9b1946[0].script_flag_set)) {
                level flag::set(self.var_ae9b1946[0].script_flag_set);
            }
        }
    }

    // Namespace namespace_3f5d3dd7
    // Params 0, eflags: 0x1 linked
    // namespace_3f5d3dd7<file_0>::function_d7d72e14
    // Checksum 0x73f11971, Offset: 0x838
    // Size: 0x2c
    function function_d7d72e14() {
        level flag::wait_till("power_on" + self.var_19295d02);
    }

    // Namespace namespace_3f5d3dd7
    // Params 0, eflags: 0x1 linked
    // namespace_3f5d3dd7<file_0>::function_713998cd
    // Checksum 0x4cc52059, Offset: 0x800
    // Size: 0x2c
    function function_713998cd() {
        function_d7d72e14();
        function_c59fb890(1, 0);
    }

    // Namespace namespace_3f5d3dd7
    // Params 0, eflags: 0x1 linked
    // namespace_3f5d3dd7<file_0>::function_e080d454
    // Checksum 0xc0dfd74f, Offset: 0x7e8
    // Size: 0x10
    function function_e080d454() {
        return self.var_1c98028c[0];
    }

    // Namespace namespace_3f5d3dd7
    // Params 2, eflags: 0x1 linked
    // namespace_3f5d3dd7<file_0>::function_1bfbfa4c
    // Checksum 0xdfc8a256, Offset: 0x798
    // Size: 0x48
    function function_1bfbfa4c(e_entity, var_d42f02cf) {
        if (!isdefined(e_entity.script_string) || e_entity.script_string != var_d42f02cf) {
            return false;
        }
        return true;
    }

    // Namespace namespace_3f5d3dd7
    // Params 0, eflags: 0x1 linked
    // namespace_3f5d3dd7<file_0>::function_128dbfb9
    // Checksum 0xe69f1baa, Offset: 0x758
    // Size: 0x34
    function function_128dbfb9() {
        function_c59fb890(0, 1);
        self thread function_713998cd();
    }

    // Namespace namespace_3f5d3dd7
    // Params 2, eflags: 0x1 linked
    // namespace_3f5d3dd7<file_0>::function_e83b9d25
    // Checksum 0x9cebafaf, Offset: 0x518
    // Size: 0x234
    function function_e83b9d25(var_d42f02cf, n_power_index) {
        self.var_5fd95ddf = 0;
        self.var_5db129b = 0.1;
        self.var_8ba3e653 = var_d42f02cf;
        self.var_ae9b1946 = getentarray("stair_step", "targetname");
        self.var_1c98028c = getentarray("stair_blocker", "targetname");
        self.var_f3446503 = getentarray("stair_clip", "targetname");
        self.var_f2f66550 = struct::get_array("stair_staircase", "targetname");
        self.var_39624e3b = struct::get_array("stair_gate", "targetname");
        self.var_ae9b1946 = array::filter(self.var_ae9b1946, 0, &function_1bfbfa4c, var_d42f02cf);
        self.var_1c98028c = array::filter(self.var_1c98028c, 0, &function_1bfbfa4c, var_d42f02cf);
        self.var_f3446503 = array::filter(self.var_f3446503, 0, &function_1bfbfa4c, var_d42f02cf);
        self.var_f2f66550 = array::filter(self.var_f2f66550, 0, &function_1bfbfa4c, var_d42f02cf);
        self.var_39624e3b = array::filter(self.var_39624e3b, 0, &function_1bfbfa4c, var_d42f02cf);
        self.var_19295d02 = n_power_index;
        self.var_7a01aaae = 0;
    }

}

// Namespace namespace_de48615
// Params 0, eflags: 0x2
// namespace_de48615<file_0>::function_2dc19561
// Checksum 0x40bb9f1f, Offset: 0x340
// Size: 0x2c
function autoexec function_2dc19561() {
    system::register("zm_zod_stairs", undefined, &__main__, undefined);
}

// Namespace namespace_de48615
// Params 0, eflags: 0x1 linked
// namespace_de48615<file_0>::function_5b6b9132
// Checksum 0x6057b528, Offset: 0x378
// Size: 0x1c
function __main__() {
    level thread function_680ab134();
}

// Namespace namespace_de48615
// Params 0, eflags: 0x1 linked
// namespace_de48615<file_0>::function_680ab134
// Checksum 0xc9fa6b54, Offset: 0x3a0
// Size: 0xdc
function function_680ab134() {
    if (!isdefined(level.var_7cf3398a)) {
        level.var_7cf3398a = [];
        function_e83b9d25("slums", 11);
        function_e83b9d25("canal", 12);
        function_e83b9d25("theater", 13);
        function_e83b9d25("start", 14);
        function_e83b9d25("brothel", 16);
        function_e83b9d25("underground", 15);
    }
}

// Namespace namespace_de48615
// Params 2, eflags: 0x1 linked
// namespace_de48615<file_0>::function_e83b9d25
// Checksum 0xef2aa094, Offset: 0x488
// Size: 0x84
function function_e83b9d25(var_d42f02cf, n_power_index) {
    if (!isdefined(level.var_7cf3398a[n_power_index])) {
        level.var_7cf3398a[n_power_index] = new class_3f5d3dd7();
        [[ level.var_7cf3398a[n_power_index] ]]->function_e83b9d25(var_d42f02cf, n_power_index);
        [[ level.var_7cf3398a[n_power_index] ]]->function_128dbfb9();
    }
}

