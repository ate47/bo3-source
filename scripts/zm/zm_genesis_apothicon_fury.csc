#using scripts/shared/system_shared;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/ai/archetype_apothicon_fury;
#using scripts/shared/ai/zombie;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_c21dfba4;

// Namespace namespace_c21dfba4
// Params 0, eflags: 0x2
// Checksum 0x9a29205b, Offset: 0x320
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_genesis_apothicon_fury", &__init__, undefined, undefined);
}

// Namespace namespace_c21dfba4
// Params 0, eflags: 0x0
// Checksum 0xe9ab9c79, Offset: 0x360
// Size: 0x9a
function __init__() {
    if (ai::shouldregisterclientfieldforarchetype("apothicon_fury")) {
        clientfield::register("scriptmover", "apothicon_fury_spawn_meteor", 15000, 2, "int", &function_87fb20f7, 0, 0);
    }
    level._effect["apothicon_fury_meteor_fx"] = "dlc4/genesis/fx_apothicon_fury_spawn_in";
    level._effect["apothicon_fury_meteor_exp"] = "dlc4/genesis/fx_apothicon_fury_spawn_in_exp";
}

// Namespace namespace_c21dfba4
// Params 7, eflags: 0x0
// Checksum 0x41dcbda8, Offset: 0x408
// Size: 0x14c
function function_87fb20f7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval === 0) {
        if (isdefined(self.var_7b71ef61)) {
            stopfx(localclientnum, self.var_7b71ef61);
        }
    }
    if (newval === 1) {
        self.var_7b71ef61 = playfxontag(localclientnum, level._effect["apothicon_fury_meteor_fx"], self, "tag_origin");
    }
    if (newval == 2) {
        playfxontag(localclientnum, level._effect["apothicon_fury_meteor_exp"], self, "tag_origin");
        self earthquake(0.1, 1, self.origin, 100);
        self playrumbleonentity(localclientnum, "damage_heavy");
    }
}

