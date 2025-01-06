#using scripts/codescripts/struct;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/system_shared;

#namespace _gadget_clone_render;

// Namespace _gadget_clone_render
// Params 0, eflags: 0x2
// Checksum 0x59a3dd01, Offset: 0x218
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_clone_render", &__init__, undefined, undefined);
}

// Namespace _gadget_clone_render
// Params 0, eflags: 0x0
// Checksum 0x71194902, Offset: 0x258
// Size: 0xd4
function __init__() {
    duplicate_render::set_dr_filter_framebuffer("clone_ally", 90, "clone_ally_on", "clone_damage", 0, "mc/ability_clone_ally", 0);
    duplicate_render::set_dr_filter_framebuffer("clone_enemy", 90, "clone_enemy_on", "clone_damage", 0, "mc/ability_clone_enemy", 0);
    duplicate_render::set_dr_filter_framebuffer("clone_damage_ally", 90, "clone_ally_on,clone_damage", undefined, 0, "mc/ability_clone_ally_damage", 0);
    duplicate_render::set_dr_filter_framebuffer("clone_damage_enemy", 90, "clone_enemy_on,clone_damage", undefined, 0, "mc/ability_clone_enemy_damage", 0);
}

#namespace gadget_clone_render;

// Namespace gadget_clone_render
// Params 1, eflags: 0x0
// Checksum 0x4609929, Offset: 0x338
// Size: 0xa4
function function_9bad5680(localclientnum) {
    self endon(#"entityshutdown");
    self endon(#"hash_b8916aca");
    var_c4612ef7 = 0;
    while (var_c4612ef7 < 1) {
        if (isdefined(self)) {
            self mapshaderconstant(localclientnum, 0, "scriptVector3", 1, var_c4612ef7, 0, 0.04);
        }
        var_c4612ef7 += 0.04;
        wait 0.016;
    }
}

