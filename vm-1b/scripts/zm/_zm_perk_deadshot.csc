#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_perks;

#namespace zm_perk_deadshot;

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x2
// Checksum 0xd5d7679d, Offset: 0x1b0
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("zm_perk_deadshot", &__init__, undefined, undefined);
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0xf84f9c1e, Offset: 0x1e8
// Size: 0x12
function __init__() {
    enable_deadshot_perk_for_level();
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0xed18d4a9, Offset: 0x208
// Size: 0x82
function enable_deadshot_perk_for_level() {
    zm_perks::register_perk_clientfields("specialty_deadshot", &deadshot_client_field_func, &deadshot_code_callback_func);
    zm_perks::register_perk_effects("specialty_deadshot", "deadshot_light");
    zm_perks::register_perk_init_thread("specialty_deadshot", &init_deadshot);
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0x4af485f4, Offset: 0x298
// Size: 0x33
function init_deadshot() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect["deadshot_light"] = "_t6/misc/fx_zombie_cola_dtap_on";
    }
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0x5eefef6d, Offset: 0x2d8
// Size: 0x6a
function deadshot_client_field_func() {
    clientfield::register("toplayer", "deadshot_perk", 1, 1, "int", &player_deadshot_perk_handler, 0, 1);
    clientfield::register("clientuimodel", "hudItems.perks.dead_shot", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x350
// Size: 0x2
function deadshot_code_callback_func() {
    
}

// Namespace zm_perk_deadshot
// Params 7, eflags: 0x0
// Checksum 0x6fb0f229, Offset: 0x360
// Size: 0xc2
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

