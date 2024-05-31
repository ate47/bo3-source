#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_eb45cc76;

// Namespace namespace_eb45cc76
// Params 0, eflags: 0x2
// namespace_eb45cc76<file_0>::function_2dc19561
// Checksum 0x16894bc6, Offset: 0x260
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_shock_field", &__init__, undefined, undefined);
}

// Namespace namespace_eb45cc76
// Params 0, eflags: 0x1 linked
// namespace_eb45cc76<file_0>::function_8c87d8eb
// Checksum 0x552495a1, Offset: 0x2a0
// Size: 0x114
function __init__() {
    clientfield::register("allplayers", "shock_field", 1, 1, "int");
    ability_player::register_gadget_activation_callbacks(39, &function_be1dbd79, &function_44bc8785);
    ability_player::register_gadget_possession_callbacks(39, &function_87ef79df, &function_7a6e5295);
    ability_player::register_gadget_flicker_callbacks(39, &function_6ee8cd88);
    ability_player::register_gadget_is_inuse_callbacks(39, &function_c51245b9);
    ability_player::register_gadget_is_flickering_callbacks(39, &function_578640dd);
    callback::on_connect(&function_8baeb8be);
}

// Namespace namespace_eb45cc76
// Params 1, eflags: 0x1 linked
// namespace_eb45cc76<file_0>::function_c51245b9
// Checksum 0x5bae1465, Offset: 0x3c0
// Size: 0x22
function function_c51245b9(slot) {
    return self gadgetisactive(slot);
}

// Namespace namespace_eb45cc76
// Params 1, eflags: 0x1 linked
// namespace_eb45cc76<file_0>::function_578640dd
// Checksum 0x295742d3, Offset: 0x3f0
// Size: 0xc
function function_578640dd(slot) {
    
}

// Namespace namespace_eb45cc76
// Params 2, eflags: 0x1 linked
// namespace_eb45cc76<file_0>::function_6ee8cd88
// Checksum 0x388f0484, Offset: 0x408
// Size: 0x14
function function_6ee8cd88(slot, weapon) {
    
}

// Namespace namespace_eb45cc76
// Params 2, eflags: 0x1 linked
// namespace_eb45cc76<file_0>::function_87ef79df
// Checksum 0x61bf7317, Offset: 0x428
// Size: 0x34
function function_87ef79df(slot, weapon) {
    self clientfield::set("shock_field", 0);
}

// Namespace namespace_eb45cc76
// Params 2, eflags: 0x1 linked
// namespace_eb45cc76<file_0>::function_7a6e5295
// Checksum 0x8c45e4c6, Offset: 0x468
// Size: 0x34
function function_7a6e5295(slot, weapon) {
    self clientfield::set("shock_field", 0);
}

// Namespace namespace_eb45cc76
// Params 0, eflags: 0x1 linked
// namespace_eb45cc76<file_0>::function_8baeb8be
// Checksum 0x99ec1590, Offset: 0x4a8
// Size: 0x4
function function_8baeb8be() {
    
}

// Namespace namespace_eb45cc76
// Params 2, eflags: 0x1 linked
// namespace_eb45cc76<file_0>::function_be1dbd79
// Checksum 0x78865025, Offset: 0x4b8
// Size: 0x6c
function function_be1dbd79(slot, weapon) {
    self gadgetsetactivatetime(slot, gettime());
    self thread function_b7cb65ad(slot, weapon);
    self clientfield::set("shock_field", 1);
}

// Namespace namespace_eb45cc76
// Params 2, eflags: 0x1 linked
// namespace_eb45cc76<file_0>::function_44bc8785
// Checksum 0x3f54a044, Offset: 0x530
// Size: 0x44
function function_44bc8785(slot, weapon) {
    self notify(#"hash_1cfd23e2");
    self clientfield::set("shock_field", 0);
}

// Namespace namespace_eb45cc76
// Params 2, eflags: 0x1 linked
// namespace_eb45cc76<file_0>::function_b7cb65ad
// Checksum 0x3647e524, Offset: 0x580
// Size: 0x2de
function function_b7cb65ad(slot, weapon) {
    self endon(#"hash_1cfd23e2");
    self notify(#"hash_a47188d4");
    self endon(#"hash_a47188d4");
    while (true) {
        wait(0.25);
        if (!self function_c51245b9(slot)) {
            return;
        }
        entities = getdamageableentarray(self.origin, weapon.gadget_shockfield_radius);
        foreach (entity in entities) {
            if (isplayer(entity)) {
                if (self getentitynumber() == entity getentitynumber()) {
                    continue;
                }
                if (self.team == entity.team) {
                    continue;
                }
                if (!isalive(entity)) {
                    continue;
                }
                if (bullettracepassed(self.origin + (0, 0, 30), entity.origin + (0, 0, 30), 1, self, undefined, 0, 1)) {
                    entity dodamage(weapon.gadget_shockfield_damage, self.origin + (0, 0, 30), self, self, 0, "MOD_GRENADE_SPLASH");
                    entity setdoublejumpenergy(0);
                    entity resetdoublejumprechargetime();
                    entity thread function_6fed7bc4(weapon);
                    self thread function_9144a83();
                    var_2b155dcc = 0.25;
                    if (entity util::mayapplyscreeneffect()) {
                        var_2b155dcc = 0.5;
                        entity shellshock("proximity_grenade", var_2b155dcc, 0);
                    }
                }
            }
        }
    }
}

// Namespace namespace_eb45cc76
// Params 1, eflags: 0x1 linked
// namespace_eb45cc76<file_0>::function_6fed7bc4
// Checksum 0x852d1fa3, Offset: 0x868
// Size: 0x68
function function_6fed7bc4(weapon) {
    if (isdefined(self.var_6fed7bc4) && self.var_6fed7bc4) {
        return;
    }
    self.var_6fed7bc4 = 1;
    self playsound("wpn_taser_mine_zap");
    wait(1);
    if (isdefined(self)) {
        self.var_6fed7bc4 = 0;
    }
}

// Namespace namespace_eb45cc76
// Params 0, eflags: 0x1 linked
// namespace_eb45cc76<file_0>::function_9144a83
// Checksum 0x3b5b5e28, Offset: 0x8d8
// Size: 0x8c
function function_9144a83() {
    self endon(#"hash_1cfd23e2");
    self notify(#"hash_9144a83");
    self endon(#"hash_9144a83");
    self clientfield::set("shock_field", 0);
    wait(randomfloatrange(0.03, 0.23));
    if (isdefined(self)) {
        self clientfield::set("shock_field", 1);
    }
}

