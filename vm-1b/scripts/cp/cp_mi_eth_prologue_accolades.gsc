#using scripts/cp/_accolades;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_61c634f2;

// Namespace namespace_61c634f2
// Params 0, eflags: 0x0
// Checksum 0xa2114a18, Offset: 0x3f0
// Size: 0x222
function function_4d39a2af() {
    accolades::register("MISSION_PROLOGUE_CHALLENGE5", "interrogation_room_challenge");
    accolades::register("MISSION_PROLOGUE_CHALLENGE6", "kill_4_guys_challenge");
    accolades::register("MISSION_PROLOGUE_CHALLENGE7", "crush_enemy_challenge");
    accolades::register("MISSION_PROLOGUE_CHALLENGE8", "wildfire_challenge");
    accolades::register("MISSION_PROLOGUE_CHALLENGE9", "robot_explode_challenge");
    accolades::register("MISSION_PROLOGUE_CHALLENGE10", "vtol_challenge");
    accolades::register("MISSION_PROLOGUE_CHALLENGE11", "truck_challenge");
    accolades::register("MISSION_PROLOGUE_CHALLENGE12", "pistol_challenge");
    accolades::register("MISSION_PROLOGUE_CHALLENGE13", "dark_battle_melee_challenge");
    accolades::register("MISSION_PROLOGUE_CHALLENGE14", "dark_battle_damage_challenge");
    accolades::register("MISSION_PROLOGUE_CHALLENGE15", "firefly_killer_challenge");
    accolades::register("MISSION_PROLOGUE_CHALLENGE16", "bridge_truck_challenge");
    accolades::register("MISSION_PROLOGUE_CHALLENGE17", "vtol_grenade_challenge");
    callback::on_ai_killed(&function_ba997bef);
    callback::on_spawned(&function_285f06dc);
    callback::on_ai_killed(&function_ff0cfb44);
    callback::on_ai_killed(&function_f85f1ba7);
}

// Namespace namespace_61c634f2
// Params 1, eflags: 0x0
// Checksum 0x6e208ff, Offset: 0x620
// Size: 0x5a
function function_c58a9e36(params) {
    if (self.var_c54411a6 === 1 && isdefined(params.eattacker) && isplayer(params.eattacker)) {
        level accolades::increment("MISSION_PROLOGUE_CHALLENGE5");
    }
}

// Namespace namespace_61c634f2
// Params 1, eflags: 0x0
// Checksum 0xfcb0d89d, Offset: 0x688
// Size: 0x9a
function function_cbaf37cd(params) {
    if (self.var_37b94263 === 1 && isdefined(params.eattacker) && isplayer(params.eattacker)) {
        e_volume = getent("t_lift_interior", "targetname");
        if (self istouching(e_volume)) {
            level accolades::increment("MISSION_PROLOGUE_CHALLENGE6");
        }
    }
}

// Namespace namespace_61c634f2
// Params 1, eflags: 0x0
// Checksum 0xbe90df95, Offset: 0x730
// Size: 0x14
function function_d248b92b(e_player) {
    e_player notify(#"crush_enemy_challenge");
}

// Namespace namespace_61c634f2
// Params 1, eflags: 0x0
// Checksum 0x17a47d36, Offset: 0x750
// Size: 0xd2
function function_ba997bef(params) {
    if (params.smeansofdeath == "MOD_BURNED" && isplayer(params.eattacker) && params.eattacker.var_b27a2766 < 9) {
        params.eattacker.var_b27a2766++;
        params.eattacker.var_323af011++;
        if (params.eattacker.var_b27a2766 == 1) {
            params.eattacker thread function_f4e80c1e();
            return;
        }
        if (params.eattacker.var_b27a2766 >= 9) {
            params.eattacker notify(#"hash_ba63aab6");
        }
    }
}

// Namespace namespace_61c634f2
// Params 0, eflags: 0x0
// Checksum 0x69022b21, Offset: 0x830
// Size: 0x46
function function_f4e80c1e() {
    self endon(#"hash_ba63aab6");
    wait 7;
    if (self.var_b27a2766 < 9) {
        if (self.var_b27a2766 > self.var_871eaf7b) {
            self.var_871eaf7b = self.var_b27a2766;
        }
        self.var_b27a2766 = 0;
    }
}

// Namespace namespace_61c634f2
// Params 0, eflags: 0x0
// Checksum 0x2ac0d982, Offset: 0x880
// Size: 0x4a
function function_285f06dc() {
    self endon(#"disconnect");
    self endon(#"death");
    self.var_b27a2766 = 0;
    self.var_871eaf7b = 0;
    self.var_323af011 = 0;
    self waittill(#"hash_ba63aab6");
    self accolades::increment("MISSION_PROLOGUE_CHALLENGE8");
}

// Namespace namespace_61c634f2
// Params 1, eflags: 0x0
// Checksum 0x22cc4b9e, Offset: 0x8d8
// Size: 0x11e
function function_ff0cfb44(params) {
    if (self.archetype === "robot") {
        if (isplayer(params.eattacker) && !isdefined(params.eattacker.var_433bc73a)) {
            var_c9311d67 = function_5315f085(params.smeansofdeath);
            if (var_c9311d67) {
                if (params.eattacker.var_743ae5cb !== params.einflictor) {
                    params.eattacker.var_743ae5cb = params.einflictor;
                    params.eattacker.var_85ebf6c3 = 1;
                    return;
                }
                params.eattacker.var_85ebf6c3++;
                if (params.eattacker.var_85ebf6c3 >= 5) {
                    params.eattacker accolades::increment("MISSION_PROLOGUE_CHALLENGE9");
                    params.eattacker.var_433bc73a = 1;
                }
            }
        }
    }
}

// Namespace namespace_61c634f2
// Params 1, eflags: 0x0
// Checksum 0xb70cdbf1, Offset: 0xa00
// Size: 0x4e
function function_5315f085(str_mod) {
    return str_mod === "MOD_EXPLOSIVE" || str_mod === "MOD_EXPLOSIVE_SPLASH" || str_mod === "MOD_GRENADE" || str_mod === "MOD_GRENADE_SPLASH" || str_mod == "MOD_BURNED" || str_mod == "MOD_ELECTROCUTED";
}

// Namespace namespace_61c634f2
// Params 0, eflags: 0x0
// Checksum 0xaabe4212, Offset: 0xa58
// Size: 0x1a
function function_51213eb7() {
    level accolades::increment("MISSION_PROLOGUE_CHALLENGE10");
}

// Namespace namespace_61c634f2
// Params 0, eflags: 0x0
// Checksum 0xeb7a994c, Offset: 0xa80
// Size: 0x1a
function function_2b1ec44e() {
    level accolades::increment("MISSION_PROLOGUE_CHALLENGE11");
}

// Namespace namespace_61c634f2
// Params 1, eflags: 0x0
// Checksum 0x7aea6426, Offset: 0xaa8
// Size: 0x14
function function_51c49e5(e_player) {
    e_player notify(#"pistol_challenge");
}

// Namespace namespace_61c634f2
// Params 1, eflags: 0x0
// Checksum 0x26c7db7b, Offset: 0xac8
// Size: 0x14
function function_df19cf7c(e_player) {
    e_player notify(#"dark_battle_melee_challenge");
}

// Namespace namespace_61c634f2
// Params 1, eflags: 0x0
// Checksum 0xed6ee51f, Offset: 0xae8
// Size: 0x14
function function_b9175513(e_player) {
    e_player notify(#"dark_battle_damage_challenge");
}

// Namespace namespace_61c634f2
// Params 1, eflags: 0x0
// Checksum 0x631a7571, Offset: 0xb08
// Size: 0xc5
function function_f85f1ba7(params) {
    if (isdefined(params.eattacker) && isplayer(params.eattacker) && isdefined(level.var_95790224)) {
        foreach (var_1bd4f3ac in level.var_95790224) {
            if (isdefined(var_1bd4f3ac) && var_1bd4f3ac.targetent === self) {
                params.eattacker accolades::increment("MISSION_PROLOGUE_CHALLENGE15");
                return 1;
            }
        }
    }
}

// Namespace namespace_61c634f2
// Params 1, eflags: 0x0
// Checksum 0x3a4e98ce, Offset: 0xbd8
// Size: 0x5a
function function_3d89871d(params) {
    if (isdefined(params.eattacker) && isplayer(params.eattacker) && self.var_52c5472d === 1) {
        level accolades::increment("MISSION_PROLOGUE_CHALLENGE16");
    }
}

// Namespace namespace_61c634f2
// Params 1, eflags: 0x0
// Checksum 0x44532136, Offset: 0xc40
// Size: 0x22
function function_470fe5d8(e_player) {
    e_player accolades::increment("MISSION_PROLOGUE_CHALLENGE17");
}

