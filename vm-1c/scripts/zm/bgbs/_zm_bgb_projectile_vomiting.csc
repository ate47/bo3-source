#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_a5a0319c;

// Namespace namespace_a5a0319c
// Params 0, eflags: 0x2
// Checksum 0x6dce8d5f, Offset: 0x248
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_projectile_vomiting", &__init__, undefined, undefined);
}

// Namespace namespace_a5a0319c
// Params 0, eflags: 0x1 linked
// Checksum 0xcc0eaea8, Offset: 0x288
// Size: 0xc4
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    clientfield::register("actor", "projectile_vomit", 12000, 1, "counter", &function_6ac13208, 0, 0);
    bgb::register("zm_bgb_projectile_vomiting", "rounds");
    level._effect["bgb_puke_reaction"] = "zombie/fx_liquid_vomit_stream_zmb";
    level._effect["bgb_puke_reaction_no_head"] = "zombie/fx_liquid_vomit_stream_neck_zmb";
    level.var_e0154011 = 0;
}

// Namespace namespace_a5a0319c
// Params 7, eflags: 0x1 linked
// Checksum 0xb59a22ba, Offset: 0x358
// Size: 0x10c
function function_6ac13208(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (level.var_e0154011 < 10) {
        if (gibclientutils::isgibbed(localclientnum, self, 8)) {
            playfxontag(localclientnum, level._effect["bgb_puke_reaction_no_head"], self, "j_neck");
        } else {
            playfxontag(localclientnum, level._effect["bgb_puke_reaction"], self, "j_neck");
        }
        self playsound(0, "zmb_bgb_vomit_vox");
        level thread function_6d325051();
    }
}

// Namespace namespace_a5a0319c
// Params 0, eflags: 0x1 linked
// Checksum 0x3d371b8d, Offset: 0x470
// Size: 0x1c
function function_6d325051() {
    level.var_e0154011++;
    wait(1);
    level.var_e0154011--;
}

