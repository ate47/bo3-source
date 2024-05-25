#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_4e4a096c;

// Namespace namespace_4e4a096c
// Params 0, eflags: 0x2
// Checksum 0x67f9af91, Offset: 0x320
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_island_takeo_fight", &__init__, undefined, undefined);
}

// Namespace namespace_4e4a096c
// Params 0, eflags: 0x1 linked
// Checksum 0x73e17f9e, Offset: 0x360
// Size: 0x94
function __init__() {
    clientfield::register("toplayer", "takeofight_teleport_fx", 9000, 1, "int", &function_c0e76be4, 0, 0);
    clientfield::register("scriptmover", "takeo_arm_hit_fx", 1, 3, "int", &function_863420f7, 0, 0);
}

// Namespace namespace_4e4a096c
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x400
// Size: 0x4
function main() {
    
}

// Namespace namespace_4e4a096c
// Params 7, eflags: 0x1 linked
// Checksum 0xfb816274, Offset: 0x410
// Size: 0x3c
function function_c0e76be4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace namespace_4e4a096c
// Params 7, eflags: 0x1 linked
// Checksum 0xfc0251c8, Offset: 0x458
// Size: 0xa4
function function_863420f7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval > 0) {
        str_tag = "tag_fx_eye" + newval + "_jnt";
        self.var_2c75d806 = playfxontag(localclientnum, level._effect["takeofight_postule_burst"], self, str_tag);
    }
}

