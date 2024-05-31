#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_e59f4632;

// Namespace namespace_e59f4632
// Params 0, eflags: 0x2
// Checksum 0x4381e234, Offset: 0x778
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_factory_fx", &__init__, undefined, undefined);
}

// Namespace namespace_e59f4632
// Params 0, eflags: 0x1 linked
// Checksum 0xb670329, Offset: 0x7b8
// Size: 0xec
function __init__() {
    level thread function_b273df73("enter_outside_east", "fxanim_outside_east_door_snow", "door_snow_a_open");
    level thread function_b273df73("enter_outside_west", "fxanim_outside_west_door_snow", "door_snow_b_open");
    level thread function_b273df73("enter_tp_south", "fxanim_south_courtyard_door_lft_snow", "door_snow_c_open");
    level thread function_b273df73("enter_tp_south", "fxanim_south_courtyard_door_rt_snow");
    clientfield::register("clientuimodel", "player_lives", 1, 2, "int");
}

// Namespace namespace_e59f4632
// Params 0, eflags: 0x1 linked
// Checksum 0x1e1e29b3, Offset: 0x8b0
// Size: 0x24
function main() {
    function_f45953c();
    function_e6258024();
}

// Namespace namespace_e59f4632
// Params 3, eflags: 0x1 linked
// Checksum 0xf2abef00, Offset: 0x8e0
// Size: 0x8c
function function_b273df73(str_flag, str_scene, str_exploder) {
    level waittill(#"start_zombie_round_logic");
    level flag::wait_till(str_flag);
    if (isdefined(str_scene)) {
        level thread scene::play(str_scene, "targetname");
    }
    if (isdefined(str_exploder)) {
        level thread exploder::exploder(str_exploder);
    }
}

// Namespace namespace_e59f4632
// Params 0, eflags: 0x1 linked
// Checksum 0xab3a9274, Offset: 0x978
// Size: 0x216
function function_f45953c() {
    level._effect["large_ceiling_dust"] = "_t6/maps/zombie/fx_dust_ceiling_impact_lg_mdbrown";
    level._effect["poltergeist"] = "zombie/fx_barrier_buy_zmb";
    level._effect["gasfire"] = "destructibles/fx_dest_fire_vert";
    level._effect["switch_sparks"] = "electric/fx_elec_sparks_directional_orange";
    level._effect["wire_sparks_oneshot"] = "electrical/fx_elec_wire_spark_dl_oneshot";
    level._effect["lght_marker"] = "zombie/fx_weapon_box_marker_zmb";
    level._effect["lght_marker_flare"] = "zombie/fx_weapon_box_marker_fl_zmb";
    level._effect["betty_explode"] = "weapon/fx_betty_exp";
    level._effect["betty_trail"] = "weapon/fx_betty_launch_dust";
    level._effect["zapper"] = "dlc0/factory/fx_elec_trap_factory";
    level._effect["zapper_light_ready"] = "maps/zombie/fx_zombie_light_glow_green";
    level._effect["zapper_light_notready"] = "maps/zombie/fx_zombie_light_glow_red";
    level._effect["elec_room_on"] = "fx_zombie_light_elec_room_on";
    level._effect["elec_md"] = "zombie/fx_elec_player_md_zmb";
    level._effect["elec_sm"] = "zombie/fx_elec_player_sm_zmb";
    level._effect["elec_torso"] = "zombie/fx_elec_player_torso_zmb";
    level._effect["elec_trail_one_shot"] = "electric/fx_elec_sparks_burst_sm_circuit_os";
    level._effect["wire_spark"] = "electric/fx_elec_sparks_burst_sm_circuit_os";
    level._effect["powerup_on"] = "zombie/fx_powerup_on_green_zmb";
}

// Namespace namespace_e59f4632
// Params 0, eflags: 0x1 linked
// Checksum 0x65b34d3b, Offset: 0xb98
// Size: 0xfe
function function_e6258024() {
    level._effect["a_embers_falling_sm"] = "env/fire/fx_embers_falling_sm";
    level._effect["mp_smoke_stack"] = "zombie/fx_smk_stack_burning_zmb";
    level._effect["mp_elec_spark_fast_random"] = "electric/fx_elec_sparks_burst_sm_circuit_os";
    level._effect["zombie_elec_gen_idle"] = "zombie/fx_elec_gen_idle_zmb";
    level._effect["zombie_moon_eclipse"] = "zombie/fx_moon_eclipse_zmb";
    level._effect["zombie_clock_hand"] = "zombie/fx_clock_hand_zmb";
    level._effect["zombie_elec_pole_terminal"] = "zombie/fx_elec_pole_terminal_zmb";
    level._effect["mp_elec_broken_light_1shot"] = "electric/fx_elec_sparks_burst_sm_circuit_os";
    level._effect["electric_short_oneshot"] = "electric/fx_elec_sparks_burst_sm_circuit_os";
}

