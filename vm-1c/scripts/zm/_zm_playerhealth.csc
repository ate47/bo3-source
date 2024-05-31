#using scripts/shared/clientfield_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/codescripts/struct;
#using scripts/shared/system_shared;

#namespace namespace_2547ab20;

// Namespace namespace_2547ab20
// Params 0, eflags: 0x2
// namespace_2547ab20<file_0>::function_2dc19561
// Checksum 0xee20fc50, Offset: 0x190
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_playerhealth", &__init__, undefined, undefined);
}

// Namespace namespace_2547ab20
// Params 0, eflags: 0x1 linked
// namespace_2547ab20<file_0>::function_8c87d8eb
// Checksum 0x2f6ae073, Offset: 0x1d0
// Size: 0x94
function __init__() {
    clientfield::register("toplayer", "sndZombieHealth", 21000, 1, "int", &function_6f9498f6, 0, 1);
    visionset_mgr::register_overlay_info_style_speed_blur("zm_health_blur", 1, 1, 0.1, 0.5, 0.75, 0, 0, 500, 500, 0);
}

// Namespace namespace_2547ab20
// Params 7, eflags: 0x1 linked
// namespace_2547ab20<file_0>::function_6f9498f6
// Checksum 0x38b51bf0, Offset: 0x270
// Size: 0x114
function function_6f9498f6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!isdefined(self.var_c354db6d)) {
            playsound(0, "zmb_health_lowhealth_enter", self.origin);
            self.var_c354db6d = self playloopsound("zmb_health_lowhealth_loop");
        }
        return;
    }
    if (isdefined(self.var_c354db6d)) {
        self stoploopsound(self.var_c354db6d);
        self.var_c354db6d = undefined;
        if (!(isdefined(self.inlaststand) && self.inlaststand)) {
            playsound(0, "zmb_health_lowhealth_exit", self.origin);
        }
    }
}

