#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/beam_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_utility;
#using scripts/zm/craftables/_zm_craftables;

#namespace zm_stalingrad_pap;

// Namespace zm_stalingrad_pap
// Params 0, eflags: 0x2
// Checksum 0x3b47f26a, Offset: 0x3b0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_stalingrad_pap", &__init__, undefined, undefined);
}

// Namespace zm_stalingrad_pap
// Params 0, eflags: 0x0
// Checksum 0x2654e314, Offset: 0x3f0
// Size: 0xdc
function __init__() {
    clientfield::register("world", "lockdown_lights_west", 12000, 1, "int", &lockdown_lights_west, 0, 0);
    clientfield::register("world", "lockdown_lights_north", 12000, 1, "int", &lockdown_lights_north, 0, 0);
    clientfield::register("world", "lockdown_lights_east", 12000, 1, "int", &lockdown_lights_east, 0, 0);
}

// Namespace zm_stalingrad_pap
// Params 7, eflags: 0x0
// Checksum 0xfae82931, Offset: 0x4d8
// Size: 0x94
function lockdown_lights_west(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_ff3f0000)) {
        level.var_ff3f0000 = struct::get_array("lockdown_lights_west");
    }
    level thread function_4ec66a83(localclientnum, newval, level.var_ff3f0000);
}

// Namespace zm_stalingrad_pap
// Params 7, eflags: 0x0
// Checksum 0x1e28a8f4, Offset: 0x578
// Size: 0x94
function lockdown_lights_north(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_80d95152)) {
        level.var_80d95152 = struct::get_array("lockdown_lights_north");
    }
    level thread function_4ec66a83(localclientnum, newval, level.var_80d95152);
}

// Namespace zm_stalingrad_pap
// Params 7, eflags: 0x0
// Checksum 0x6fe00291, Offset: 0x618
// Size: 0x94
function lockdown_lights_east(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_4f41d366)) {
        level.var_4f41d366 = struct::get_array("lockdown_lights_east");
    }
    level thread function_4ec66a83(localclientnum, newval, level.var_4f41d366);
}

// Namespace zm_stalingrad_pap
// Params 3, eflags: 0x0
// Checksum 0x91a87783, Offset: 0x6b8
// Size: 0x180
function function_4ec66a83(localclientnum, newval, var_c6d3da8) {
    if (newval) {
        foreach (s_light in var_c6d3da8) {
            s_light.fx_light = playfx(localclientnum, level._effect["pavlov_lockdown_light"], s_light.origin);
        }
        return;
    }
    foreach (s_light in var_c6d3da8) {
        if (isdefined(s_light.fx_light)) {
            stopfx(localclientnum, s_light.fx_light);
            s_light.fx_light = undefined;
        }
    }
}

// Namespace zm_stalingrad_pap
// Params 7, eflags: 0x0
// Checksum 0x55e864de, Offset: 0x840
// Size: 0xdc
function drop_pod_streaming(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        forcestreamxmodel("p7_fxanim_zm_stal_pack_a_punch_base_mod");
        forcestreamxmodel("p7_fxanim_zm_stal_pack_a_punch_pod_mod");
        forcestreamxmodel("p7_fxanim_zm_stal_pack_a_punch_umbrella_mod");
        return;
    }
    stopforcestreamingxmodel("p7_fxanim_zm_stal_pack_a_punch_base_mod");
    stopforcestreamingxmodel("p7_fxanim_zm_stal_pack_a_punch_pod_mod");
    stopforcestreamingxmodel("p7_fxanim_zm_stal_pack_a_punch_umbrella_mod");
}

// Namespace zm_stalingrad_pap
// Params 7, eflags: 0x0
// Checksum 0x84a61ccf, Offset: 0x928
// Size: 0x64
function function_5858bdaf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.var_f6abb894[localclientnum] = self;
    self thread function_ca87037d(localclientnum);
}

// Namespace zm_stalingrad_pap
// Params 1, eflags: 0x0
// Checksum 0xb45e610f, Offset: 0x998
// Size: 0x48
function function_ca87037d(localclientnum) {
    self endon(#"entity_shutdown");
    while (isdefined(self)) {
        self playrumbleonentity(localclientnum, "zm_stalingrad_drop_pod_ambient");
        wait 1.1;
    }
}

// Namespace zm_stalingrad_pap
// Params 7, eflags: 0x0
// Checksum 0x7f702726, Offset: 0x9e8
// Size: 0x10c
function function_c86c0cdd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_f64bb476 = level.var_f6abb894[localclientnum];
    mdl_target = util::spawn_model(localclientnum, "tag_origin", var_f64bb476 gettagorigin("tag_fx"));
    var_e43465f2 = util::spawn_model(localclientnum, "tag_origin", self gettagorigin("j_spine4"), self gettagangles("j_spine4"));
    var_e43465f2 thread function_1d3ab9dd(mdl_target);
}

// Namespace zm_stalingrad_pap
// Params 1, eflags: 0x0
// Checksum 0x1469ccc5, Offset: 0xb00
// Size: 0xe4
function function_1d3ab9dd(mdl_target) {
    level beam::launch(self, "tag_origin", mdl_target, "tag_origin", "electric_arc_zombie_to_drop_pod");
    mdl_target playsound(0, "zmb_pod_electrocute");
    wait 0.2;
    self playsound(0, "zmb_pod_electrocute_zmb");
    level beam::kill(self, "tag_origin", mdl_target, "tag_origin", "electric_arc_zombie_to_drop_pod");
    mdl_target delete();
    self delete();
}

// Namespace zm_stalingrad_pap
// Params 7, eflags: 0x0
// Checksum 0x2500bc66, Offset: 0xbf0
// Size: 0x1ce
function function_5e369bd2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    mdl_pod = level.var_f6abb894[localclientnum];
    switch (newval) {
    case 1:
        mdl_pod.var_888bfca3 = playfxontag(localclientnum, level._effect["drop_pod_hp_light_green"], mdl_pod, "tag_health_green");
        break;
    case 2:
        if (isdefined(mdl_pod.var_888bfca3)) {
            stopfx(localclientnum, mdl_pod.var_888bfca3);
        }
        mdl_pod.var_888bfca3 = playfxontag(localclientnum, level._effect["drop_pod_hp_light_yellow"], mdl_pod, "tag_health_yellow");
        break;
    case 3:
        if (isdefined(mdl_pod.var_888bfca3)) {
            stopfx(localclientnum, mdl_pod.var_888bfca3);
        }
        mdl_pod.var_888bfca3 = playfxontag(localclientnum, level._effect["drop_pod_hp_light_red"], mdl_pod, "tag_health_red");
        break;
    default:
        break;
    }
}

