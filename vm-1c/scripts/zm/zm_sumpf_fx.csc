#using scripts/codescripts/struct;

#namespace namespace_ca9187f5;

// Namespace namespace_ca9187f5
// Params 0, eflags: 0x1 linked
// namespace_ca9187f5<file_0>::function_d290ebfa
// Checksum 0xf1d6c74c, Offset: 0xdc8
// Size: 0xc4
function main() {
    function_f45953c();
    function_e6258024();
    level thread trap_fx_monitor("north_west_tgt", "north_west_elec_light");
    level thread trap_fx_monitor("south_west_tgt", "south_west_elec_light");
    level thread trap_fx_monitor("north_east_tgt", "north_east_elec_light");
    level thread trap_fx_monitor("south_east_tgt", "south_east_elec_light");
}

// Namespace namespace_ca9187f5
// Params 0, eflags: 0x1 linked
// namespace_ca9187f5<file_0>::function_f45953c
// Checksum 0x7f3d1f97, Offset: 0xe98
// Size: 0x232
function function_f45953c() {
    level._effect["eye_glow"] = "zombie/fx_glow_eye_orange";
    level._effect["zapper_fx"] = "maps/zombie/fx_zombie_zapper_powerbox_on";
    level._effect["zapper_wall"] = "maps/zombie/fx_zombie_zapper_wall_control_on";
    level._effect["elec_trail_one_shot"] = "maps/zombie/fx_zombie_elec_trail_oneshot";
    level._effect["zapper_light_ready"] = "maps/zombie/fx_zm_swamp_light_glow_green";
    level._effect["zapper_light_notready"] = "maps/zombie/fx_zm_swamp_light_glow_red";
    level._effect["wire_sparks_oneshot"] = "electrical/fx_elec_wire_spark_dl_oneshot";
    level._effect["headshot"] = "impacts/fx_flesh_hit";
    level._effect["headshot_nochunks"] = "misc/fx_zombie_bloodsplat";
    level._effect["bloodspurt"] = "misc/fx_zombie_bloodspurt";
    level._effect["animscript_gib_fx"] = "weapon/bullet/fx_flesh_gib_fatal_01";
    level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
    level._effect["rise_burst_water"] = "maps/zombie/fx_zombie_body_wtr_burst_smpf";
    level._effect["rise_billow_water"] = "maps/zombie/fx_zombie_body_wtr_billow_smpf";
    level._effect["rise_dust_water"] = "maps/zombie/fx_zombie_body_wtr_falling";
    level._effect["trap_log"] = "dlc5/sumpf/fx_log_trap";
    level._effect["chest_light_closed"] = "zombie/fx_weapon_box_closed_glow_hut1_zmb";
    level._effect["perk_machine_light_yellow"] = "dlc5/zmhd/fx_wonder_fizz_light_yellow";
    level._effect["perk_machine_light_red"] = "dlc5/zmhd/fx_wonder_fizz_light_red";
    level._effect["perk_machine_light_green"] = "dlc5/zmhd/fx_wonder_fizz_light_green";
}

// Namespace namespace_ca9187f5
// Params 0, eflags: 0x1 linked
// namespace_ca9187f5<file_0>::function_e6258024
// Checksum 0xf0a4e329, Offset: 0x10d8
// Size: 0x42a
function function_e6258024() {
    level._effect["mp_fire_medium"] = "fire/fx_fire_fuel_sm";
    level._effect["mp_fire_large"] = "maps/zombie/fx_zmb_tranzit_fire_lrg";
    level._effect["mp_smoke_ambiance_indoor"] = "maps/mp_maps/fx_mp_smoke_ambiance_indoor";
    level._effect["mp_smoke_ambiance_indoor_misty"] = "maps/mp_maps/fx_mp_smoke_ambiance_indoor_misty";
    level._effect["mp_smoke_ambiance_indoor_sm"] = "maps/mp_maps/fx_mp_smoke_ambiance_indoor_sm";
    level._effect["fx_fog_low_floor_sm"] = "env/smoke/fx_fog_low_floor_sm";
    level._effect["mp_smoke_column_tall"] = "maps/mp_maps/fx_mp_smoke_column_tall";
    level._effect["mp_smoke_column_short"] = "maps/mp_maps/fx_mp_smoke_column_short";
    level._effect["mp_fog_rolling_large"] = "maps/mp_maps/fx_mp_fog_rolling_thick_large_area";
    level._effect["mp_fog_rolling_small"] = "maps/mp_maps/fx_mp_fog_rolling_thick_small_area";
    level._effect["mp_flies_carcass"] = "maps/mp_maps/fx_mp_flies_carcass";
    level._effect["mp_insects_swarm"] = "maps/mp_maps/fx_mp_insect_swarm";
    level._effect["mp_insects_lantern"] = "maps/zombie_old/fx_mp_insects_lantern";
    level._effect["mp_firefly_ambient"] = "maps/mp_maps/fx_mp_firefly_ambient";
    level._effect["mp_firefly_swarm"] = "maps/mp_maps/fx_mp_firefly_swarm";
    level._effect["mp_maggots"] = "maps/mp_maps/fx_mp_maggots";
    level._effect["mp_falling_leaves_elm"] = "maps/mp_maps/fx_mp_falling_leaves_elm";
    level._effect["god_rays_dust_motes"] = "env/light/fx_light_god_rays_dust_motes";
    level._effect["light_ceiling_dspot"] = "env/light/fx_ray_ceiling_amber_dim_sm";
    level._effect["fx_bats_circling"] = "bio/animals/fx_bats_circling";
    level._effect["fx_bats_ambient"] = "maps/mp_maps/fx_bats_ambient";
    level._effect["mp_dragonflies"] = "bio/insects/fx_insects_dragonflies_ambient";
    level._effect["fx_mp_ray_moon_xsm_near"] = "maps/mp_maps/fx_mp_ray_moon_xsm_near";
    level._effect["fx_meteor_ambient"] = "maps/zombie/fx_meteor_ambient";
    level._effect["fx_meteor_flash"] = "maps/zombie/fx_meteor_flash";
    level._effect["fx_meteor_flash_spawn"] = "maps/zombie/fx_meteor_flash_spawn";
    level._effect["fx_meteor_hotspot"] = "maps/zombie/fx_meteor_hotspot";
    level._effect["fx_zm_swamp_fire_torch"] = "fire/fx_zm_swamp_fire_torch";
    level._effect["fx_zm_swamp_fire_detail"] = "fire/fx_zm_swamp_fire_detail";
    level._effect["fx_zm_swamp_glow_lantern"] = "maps/zombie/fx_zm_swamp_glow_lantern";
    level._effect["fx_zm_swamp_glow_lantern_sm"] = "maps/zombie/fx_zm_swamp_glow_lantern_sm";
    level._effect["fx_zm_swamp_glow_int_tinhat\t"] = "maps/zombie/fx_zm_swamp_glow_int_tinhat";
    level._effect["fx_zm_swamp_glow_beacon\t"] = "maps/zombie/fx_zm_swamp_glow_beacon";
    level._effect["zapper"] = "dlc0/factory/fx_elec_trap_factory";
    level._effect["switch_sparks"] = "env/electrical/fx_elec_wire_spark_burst";
    level._effect["betty_explode"] = "weapon/bouncing_betty/fx_explosion_betty_generic";
    level._effect["betty_trail"] = "weapon/bouncing_betty/fx_betty_trail";
    level._effect["fx_light_god_ray_sm_sumpf_warm_v1"] = "env/light/fx_light_god_ray_sm_sumpf_warm_v1";
}

// Namespace namespace_ca9187f5
// Params 2, eflags: 0x1 linked
// namespace_ca9187f5<file_0>::function_9b0b8f8e
// Checksum 0x9a367dc5, Offset: 0x1510
// Size: 0xa2
function trap_fx_monitor(name, side) {
    while (true) {
        level waittill(name);
        var_b0b39f79 = struct::get_array(name, "targetname");
        for (i = 0; i < var_b0b39f79.size; i++) {
            var_b0b39f79[i] thread function_1fc3f4ef(name, side);
        }
    }
}

// Namespace namespace_ca9187f5
// Params 2, eflags: 0x1 linked
// namespace_ca9187f5<file_0>::function_1fc3f4ef
// Checksum 0xb1f683a5, Offset: 0x15c0
// Size: 0x1f0
function function_1fc3f4ef(name, side) {
    ang = self.angles;
    forward = anglestoforward(ang);
    up = anglestoup(ang);
    if (isdefined(self.loopfx)) {
        for (i = 0; i < self.loopfx.size; i++) {
            self.loopfx[i] delete();
        }
        self.loopfx = [];
    }
    if (!isdefined(self.loopfx)) {
        self.loopfx = [];
    }
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        self.loopfx[i] = spawnfx(i, level._effect["zapper"], self.origin, 0, forward, up);
        triggerfx(self.loopfx[i]);
    }
    level waittill(side + "off");
    for (i = 0; i < self.loopfx.size; i++) {
        self.loopfx[i] delete();
    }
    self.loopfx = [];
}

// Namespace namespace_ca9187f5
// Params 1, eflags: 0x0
// namespace_ca9187f5<file_0>::function_965cd1af
// Checksum 0xc994532a, Offset: 0x17b8
// Size: 0x3ec
function function_965cd1af(ent) {
    var_519c4c0b = struct::get("zapper_switch_fx_" + ent, "targetname");
    var_81af7cd1 = struct::get("zapper_fx_" + ent, "targetname");
    var_ec2aa6a7 = anglestoforward(var_519c4c0b.angles);
    var_28414727 = anglestoup(var_519c4c0b.angles);
    var_6acb4c1 = anglestoforward(var_81af7cd1.angles);
    var_93aca931 = anglestoup(var_81af7cd1.angles);
    while (true) {
        level waittill(ent);
        if (isdefined(var_519c4c0b.loopfx)) {
            for (i = 0; i < var_519c4c0b.loopfx.size; i++) {
                var_519c4c0b.loopfx[i] delete();
                var_81af7cd1.loopfx[i] delete();
            }
            var_519c4c0b.loopfx = [];
            var_81af7cd1.loopfx = [];
        }
        if (!isdefined(var_519c4c0b.loopfx)) {
            var_519c4c0b.loopfx = [];
            var_81af7cd1.loopfx = [];
        }
        players = getlocalplayers();
        for (i = 0; i < players.size; i++) {
            var_519c4c0b.loopfx[i] = spawnfx(i, level._effect["zapper_wall"], var_519c4c0b.origin, 0, var_ec2aa6a7, var_28414727);
            triggerfx(var_519c4c0b.loopfx[i]);
            var_81af7cd1.loopfx[i] = spawnfx(i, level._effect["zapper_fx"], var_81af7cd1.origin, 0, var_6acb4c1, var_93aca931);
            triggerfx(var_81af7cd1.loopfx[i]);
        }
        wait(30);
        for (i = 0; i < var_519c4c0b.loopfx.size; i++) {
            var_519c4c0b.loopfx[i] delete();
            var_81af7cd1.loopfx[i] delete();
        }
        var_519c4c0b.loopfx = [];
        var_81af7cd1.loopfx = [];
    }
}

