#using scripts/zm/_zm_weap_staff_common;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;

#namespace namespace_db493cf;

// Namespace namespace_db493cf
// Params 0, eflags: 0x2
// namespace_db493cf<file_0>::function_2dc19561
// Checksum 0x266fe419, Offset: 0x260
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_staff_revive", &__init__, undefined, undefined);
}

// Namespace namespace_db493cf
// Params 0, eflags: 0x1 linked
// namespace_db493cf<file_0>::function_8c87d8eb
// Checksum 0xb5506179, Offset: 0x2a0
// Size: 0x24
function __init__() {
    callback::on_spawned(&onplayerspawned);
}

// Namespace namespace_db493cf
// Params 0, eflags: 0x1 linked
// namespace_db493cf<file_0>::function_be02cc45
// Checksum 0x30301e9a, Offset: 0x2d0
// Size: 0x24
function onplayerspawned() {
    self endon(#"disconnect");
    self thread function_bd596582();
}

// Namespace namespace_db493cf
// Params 0, eflags: 0x1 linked
// namespace_db493cf<file_0>::function_bd596582
// Checksum 0x631868f, Offset: 0x300
// Size: 0xc0
function function_bd596582() {
    self endon(#"disconnect");
    while (true) {
        e_projectile, str_weapon = self waittill(#"missile_fire");
        if (!(str_weapon.name == "staff_revive")) {
            continue;
        }
        e_ent, var_836ef144, n_radius, str_name, var_94351942 = self waittill(#"projectile_impact");
        self thread function_e94d3934(var_836ef144);
    }
}

// Namespace namespace_db493cf
// Params 1, eflags: 0x1 linked
// namespace_db493cf<file_0>::function_e94d3934
// Checksum 0xdaf0c075, Offset: 0x3c8
// Size: 0x19a
function function_e94d3934(var_836ef144) {
    self endon(#"disconnect");
    e_closest_player = undefined;
    var_1d0de873 = 1024;
    playsoundatposition("wpn_revivestaff_proj_impact", var_836ef144);
    a_e_players = getplayers();
    foreach (e_player in a_e_players) {
        if (e_player == self || !e_player laststand::player_is_in_laststand()) {
            continue;
        }
        n_dist_sq = distancesquared(var_836ef144, e_player.origin);
        if (n_dist_sq < var_1d0de873) {
            e_closest_player = e_player;
        }
    }
    if (isdefined(e_closest_player)) {
        e_closest_player notify(#"remote_revive", self);
        e_closest_player playsoundtoplayer("wpn_revivestaff_revive_plr", e_player);
        self notify(#"hash_981f818b");
    }
}

