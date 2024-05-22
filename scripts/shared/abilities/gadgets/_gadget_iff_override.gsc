#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_20d60703;

// Namespace namespace_20d60703
// Params 0, eflags: 0x2
// Checksum 0xaa3ebfbf, Offset: 0x200
// Size: 0x34
function function_2dc19561() {
    system::register("gadget_iff_override", &__init__, undefined, undefined);
}

// Namespace namespace_20d60703
// Params 0, eflags: 0x1 linked
// Checksum 0x8e026f0f, Offset: 0x240
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(24, &function_3e1f85fc, &function_4377752a);
    ability_player::register_gadget_possession_callbacks(24, &function_2b859620, &function_bdd75256);
    ability_player::register_gadget_flicker_callbacks(24, &function_4c6c9561);
    ability_player::register_gadget_is_inuse_callbacks(24, &function_dd752664);
    ability_player::register_gadget_is_flickering_callbacks(24, &function_5dda9d3a);
    ability_player::register_gadget_primed_callbacks(24, &function_54113655);
    callback::on_connect(&function_96787fdf);
}

// Namespace namespace_20d60703
// Params 1, eflags: 0x1 linked
// Checksum 0xc7e626e1, Offset: 0x350
// Size: 0x2a
function function_dd752664(slot) {
    return self flagsys::get("gadget_iff_override_on");
}

// Namespace namespace_20d60703
// Params 1, eflags: 0x1 linked
// Checksum 0xa0c72c4, Offset: 0x388
// Size: 0x52
function function_5dda9d3a(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        return self [[ level.cybercom.iff_override.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace namespace_20d60703
// Params 2, eflags: 0x1 linked
// Checksum 0xc8b79216, Offset: 0x3e8
// Size: 0x5c
function function_4c6c9561(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_20d60703
// Params 2, eflags: 0x1 linked
// Checksum 0x3c891c08, Offset: 0x450
// Size: 0x5c
function function_2b859620(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_20d60703
// Params 2, eflags: 0x1 linked
// Checksum 0x851aadbb, Offset: 0x4b8
// Size: 0x5c
function function_bdd75256(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_20d60703
// Params 0, eflags: 0x1 linked
// Checksum 0x4c291b07, Offset: 0x520
// Size: 0x44
function function_96787fdf() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override.var_5d2fec30 ]]();
    }
}

// Namespace namespace_20d60703
// Params 2, eflags: 0x1 linked
// Checksum 0xebd41df2, Offset: 0x570
// Size: 0x7c
function function_3e1f85fc(slot, weapon) {
    self flagsys::set("gadget_iff_override_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override._on ]](slot, weapon);
    }
}

// Namespace namespace_20d60703
// Params 2, eflags: 0x1 linked
// Checksum 0x91eb604, Offset: 0x5f8
// Size: 0x7c
function function_4377752a(slot, weapon) {
    self flagsys::clear("gadget_iff_override_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override._off ]](slot, weapon);
    }
}

// Namespace namespace_20d60703
// Params 2, eflags: 0x1 linked
// Checksum 0xf8cad14c, Offset: 0x680
// Size: 0x5c
function function_54113655(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override.var_4135a1c4 ]](slot, weapon);
    }
}

