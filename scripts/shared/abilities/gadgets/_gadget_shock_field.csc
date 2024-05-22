#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_eb45cc76;

// Namespace namespace_eb45cc76
// Params 0, eflags: 0x2
// Checksum 0xed55d009, Offset: 0x2a0
// Size: 0x34
function function_2dc19561() {
    system::register("gadget_shock_field", &__init__, undefined, undefined);
}

// Namespace namespace_eb45cc76
// Params 0, eflags: 0x1 linked
// Checksum 0xf1c73c81, Offset: 0x2e0
// Size: 0x58
function __init__() {
    clientfield::register("allplayers", "shock_field", 1, 1, "int", &function_281e2b38, 0, 1);
    level.var_a01dacf5 = [];
}

// Namespace namespace_eb45cc76
// Params 1, eflags: 0x1 linked
// Checksum 0x73cf8c00, Offset: 0x340
// Size: 0x58
function is_local_player(localclientnum) {
    player_view = getlocalplayer(localclientnum);
    if (!isdefined(player_view)) {
        return 0;
    }
    var_2389f10a = self == player_view;
    return var_2389f10a;
}

// Namespace namespace_eb45cc76
// Params 7, eflags: 0x1 linked
// Checksum 0x1f156b61, Offset: 0x3a0
// Size: 0x150
function function_281e2b38(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    entid = getlocalplayer(localclientnum) getentitynumber();
    if (newval) {
        if (!isdefined(level.var_a01dacf5[entid])) {
            fx = "player/fx_plyr_shock_field";
            if (is_local_player(localclientnum)) {
                fx = "player/fx_plyr_shock_field_1p";
            }
            tag = "j_spinelower";
            level.var_a01dacf5[entid] = playfxontag(localclientnum, fx, self, tag);
        }
        return;
    }
    if (isdefined(level.var_a01dacf5[entid])) {
        stopfx(localclientnum, level.var_a01dacf5[entid]);
        level.var_a01dacf5[entid] = undefined;
    }
}

