#using scripts/shared/system_shared;
#using scripts/shared/abilities/gadgets/_gadget_camo_render;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_411f3e3f;

// Namespace namespace_411f3e3f
// Params 0, eflags: 0x2
// Checksum 0xd3687de0, Offset: 0x2c0
// Size: 0x34
function function_2dc19561() {
    system::register("gadget_camo", &__init__, undefined, undefined);
}

// Namespace namespace_411f3e3f
// Params 0, eflags: 0x1 linked
// Checksum 0x6c915674, Offset: 0x300
// Size: 0x4c
function __init__() {
    clientfield::register("allplayers", "camo_shader", 1, 3, "int", &function_f532bd65, 0, 1);
}

// Namespace namespace_411f3e3f
// Params 7, eflags: 0x1 linked
// Checksum 0x689d464d, Offset: 0x358
// Size: 0x274
function function_f532bd65(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval == newval && oldval == 0 && !bwastimejump) {
        return;
    }
    flags_changed = self duplicate_render::set_dr_flag_not_array("gadget_camo_friend", util::function_f36b8920(local_client_num, 1));
    flags_changed |= self duplicate_render::set_dr_flag_not_array("gadget_camo_flicker", newval == 2);
    flags_changed |= self duplicate_render::set_dr_flag_not_array("gadget_camo_break", newval == 3);
    flags_changed |= self duplicate_render::set_dr_flag_not_array("gadget_camo_reveal", newval != oldval);
    flags_changed |= self duplicate_render::set_dr_flag_not_array("gadget_camo_on", newval != 0);
    flags_changed |= self duplicate_render::set_dr_flag_not_array("hide_model", newval == 0);
    flags_changed |= bnewent;
    if (flags_changed) {
        self duplicate_render::update_dr_filters(local_client_num);
    }
    self notify(#"endtest");
    if (bwastimejump || newval && bnewent) {
        self thread gadget_camo_render::forceon(local_client_num);
    } else if (newval != oldval) {
        self thread gadget_camo_render::doreveal(local_client_num, newval != 0);
    }
    if (bwastimejump || newval && (newval && !oldval || bnewent)) {
        self gadgetpulseresetreveal();
    }
}

