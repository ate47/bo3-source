#using scripts/codescripts/struct;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#using_animtree("generic");

#namespace vehicle;

// Namespace vehicle
// Params 0, eflags: 0x2
// Checksum 0xf638fccb, Offset: 0x1f0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("vehicleriders", &__init__, undefined, undefined);
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xea50b9d, Offset: 0x230
// Size: 0x2a2
function __init__() {
    a_registered_fields = [];
    foreach (bundle in struct::get_script_bundles("vehicleriders")) {
        foreach (object in bundle.objects) {
            if (isstring(object.vehicleenteranim)) {
                array::add(a_registered_fields, object.position + "_enter", 0);
            }
            if (isstring(object.vehicleexitanim)) {
                array::add(a_registered_fields, object.position + "_exit", 0);
            }
            if (isstring(object.vehicleriderdeathanim)) {
                array::add(a_registered_fields, object.position + "_death", 0);
            }
        }
    }
    foreach (str_clientfield in a_registered_fields) {
        clientfield::register("vehicle", str_clientfield, 1, 1, "counter", &play_vehicle_anim, 0, 0);
    }
}

// Namespace vehicle
// Params 7, eflags: 0x0
// Checksum 0x57afddaf, Offset: 0x4e0
// Size: 0x2c4
function play_vehicle_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    s_bundle = struct::get_script_bundle("vehicleriders", self.vehicleridersbundle);
    str_pos = "";
    str_action = "";
    if (strendswith(fieldname, "_enter")) {
        str_pos = getsubstr(fieldname, 0, fieldname.size - 6);
        str_action = "enter";
    } else if (strendswith(fieldname, "_exit")) {
        str_pos = getsubstr(fieldname, 0, fieldname.size - 5);
        str_action = "exit";
    } else if (strendswith(fieldname, "_death")) {
        str_pos = getsubstr(fieldname, 0, fieldname.size - 6);
        str_action = "death";
    }
    str_vh_anim = undefined;
    foreach (s_rider in s_bundle.objects) {
        if (s_rider.position == str_pos) {
            switch (str_action) {
            case "enter":
                str_vh_anim = s_rider.vehicleenteranim;
                break;
            case "exit":
                str_vh_anim = s_rider.vehicleexitanim;
                break;
            case "death":
                str_vh_anim = s_rider.vehicleriderdeathanim;
                break;
            }
            break;
        }
    }
    if (isdefined(str_vh_anim)) {
        self setanimrestart(str_vh_anim);
    }
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0x8e840b01, Offset: 0x7b0
// Size: 0x34
function set_vehicleriders_bundle(str_bundlename) {
    self.vehicleriders = struct::get_script_bundle("vehicleriders", str_bundlename);
}

