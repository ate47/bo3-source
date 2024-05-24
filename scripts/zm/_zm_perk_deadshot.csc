#using scripts/zm/_zm_perks;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_perk_deadshot;

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x2
// Checksum 0xcd332ac3, Offset: 0x1b0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_perk_deadshot", &__init__, undefined, undefined);
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0xb9771f2d, Offset: 0x1f0
// Size: 0x14
function __init__() {
    enable_deadshot_perk_for_level();
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0x5cbc2b07, Offset: 0x210
// Size: 0x84
function enable_deadshot_perk_for_level() {
    zm_perks::register_perk_clientfields("specialty_deadshot", &deadshot_client_field_func, &deadshot_code_callback_func);
    zm_perks::register_perk_effects("specialty_deadshot", "deadshot_light");
    zm_perks::register_perk_init_thread("specialty_deadshot", &init_deadshot);
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0xe9c53df, Offset: 0x2a0
// Size: 0x36
function init_deadshot() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect["deadshot_light"] = "_t6/misc/fx_zombie_cola_dtap_on";
    }
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0xc1e1c523, Offset: 0x2e0
// Size: 0x84
function deadshot_client_field_func() {
    clientfield::register("toplayer", "deadshot_perk", 1, 1, "int", &player_deadshot_perk_handler, 0, 1);
    clientfield::register("clientuimodel", "hudItems.perks.dead_shot", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x370
// Size: 0x4
function deadshot_code_callback_func() {
    
}

// Namespace zm_perk_deadshot
// Params 7, eflags: 0x0
// Checksum 0x3e7b9f7, Offset: 0x380
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

