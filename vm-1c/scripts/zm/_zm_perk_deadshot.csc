#using scripts/zm/_zm_perks;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_perk_deadshot;

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x2
// namespace_56d7a026<file_0>::function_2dc19561
// Checksum 0x4447cfaa, Offset: 0x1b0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_perk_deadshot", &__init__, undefined, undefined);
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x1 linked
// namespace_56d7a026<file_0>::function_8c87d8eb
// Checksum 0x9af53617, Offset: 0x1f0
// Size: 0x14
function __init__() {
    enable_deadshot_perk_for_level();
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x1 linked
// namespace_56d7a026<file_0>::function_4928f643
// Checksum 0xd75acce3, Offset: 0x210
// Size: 0x84
function enable_deadshot_perk_for_level() {
    zm_perks::register_perk_clientfields("specialty_deadshot", &deadshot_client_field_func, &deadshot_code_callback_func);
    zm_perks::register_perk_effects("specialty_deadshot", "deadshot_light");
    zm_perks::register_perk_init_thread("specialty_deadshot", &init_deadshot);
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x1 linked
// namespace_56d7a026<file_0>::function_b3926cf8
// Checksum 0x5ed23d72, Offset: 0x2a0
// Size: 0x36
function init_deadshot() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect["deadshot_light"] = "_t6/misc/fx_zombie_cola_dtap_on";
    }
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x1 linked
// namespace_56d7a026<file_0>::function_74fb388b
// Checksum 0xba20a7d4, Offset: 0x2e0
// Size: 0x84
function deadshot_client_field_func() {
    clientfield::register("toplayer", "deadshot_perk", 1, 1, "int", &player_deadshot_perk_handler, 0, 1);
    clientfield::register("clientuimodel", "hudItems.perks.dead_shot", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x1 linked
// namespace_56d7a026<file_0>::function_fffbd7e
// Checksum 0x99ec1590, Offset: 0x370
// Size: 0x4
function deadshot_code_callback_func() {
    
}

// Namespace zm_perk_deadshot
// Params 7, eflags: 0x1 linked
// namespace_56d7a026<file_0>::function_ac593263
// Checksum 0x8e1dc9fb, Offset: 0x380
// Size: 0xf4
function player_deadshot_perk_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.localplayers[localclientnum]) && (!self islocalplayer() || isspectating(localclientnum, 0) || self getentitynumber() != level.localplayers[localclientnum] getentitynumber())) {
        return;
    }
    if (newval) {
        self usealternateaimparams();
        return;
    }
    self clearalternateaimparams();
}

