#using scripts/codescripts/struct;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;
#using scripts/zm/craftables/_zm_craftables;

#using_animtree("generic");

#namespace zm_island_takeo_fight;

// Namespace zm_island_takeo_fight
// Params 0, eflags: 0x2
// Checksum 0x67f9af91, Offset: 0x320
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_island_takeo_fight", &__init__, undefined, undefined);
}

// Namespace zm_island_takeo_fight
// Params 0, eflags: 0x0
// Checksum 0x73e17f9e, Offset: 0x360
// Size: 0x94
function __init__() {
    clientfield::register("toplayer", "takeofight_teleport_fx", 9000, 1, "int", &takeofight_teleport_fx, 0, 0);
    clientfield::register("scriptmover", "takeo_arm_hit_fx", 1, 3, "int", &takeo_arm_hit_fx, 0, 0);
}

// Namespace zm_island_takeo_fight
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x400
// Size: 0x4
function main() {
    
}

// Namespace zm_island_takeo_fight
// Params 7, eflags: 0x0
// Checksum 0xfb816274, Offset: 0x410
// Size: 0x3c
function takeofight_teleport_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace zm_island_takeo_fight
// Params 7, eflags: 0x0
// Checksum 0xfc0251c8, Offset: 0x458
// Size: 0xa4
function takeo_arm_hit_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval > 0) {
        str_tag = "tag_fx_eye" + newval + "_jnt";
        self.var_2c75d806 = playfxontag(localclientnum, level._effect["takeofight_postule_burst"], self, str_tag);
    }
}

