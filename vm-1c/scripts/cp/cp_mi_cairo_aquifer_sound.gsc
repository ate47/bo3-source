#using scripts/shared/music_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/cp/voice/voice_aquifer;
#using scripts/codescripts/struct;

#namespace namespace_1d1d22be;

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x37dbc884, Offset: 0xd28
// Size: 0x44
function main() {
    namespace_b9b93cab::init_voice();
    thread function_609d3ec();
    thread function_cd85d22a();
    thread function_4fb4bdc3();
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x63d158d1, Offset: 0xd78
// Size: 0xcc
function function_4fb4bdc3() {
    level.var_fc9a3509 = 0;
    level.var_b8fee04d = spawn("script_origin", (16832, 3276, 2268));
    level.var_df015ab6 = spawn("script_origin", (15869, 3965, 2281));
    level.var_554aefcd = spawn("script_origin", (15979, 3297, 2050));
    level.var_7b4d6a36 = spawn("script_origin", (16820, 3947, 2047));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0xe50
// Size: 0x4
function function_30ce85d2() {
    
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xe60
// Size: 0x4
function function_609d3ec() {
    
}

// Namespace namespace_1d1d22be
// Params 1, eflags: 0x1 linked
// Checksum 0x8f8c0b54, Offset: 0xe70
// Size: 0x4c
function function_77b5283a(player) {
    player playsoundtoplayer("veh_vtol_exit", player);
    player playsoundtoplayer("veh_vtol_exit_foley", player);
}

// Namespace namespace_1d1d22be
// Params 2, eflags: 0x1 linked
// Checksum 0x56425d29, Offset: 0xec8
// Size: 0x5c
function function_976c341d(player, zone) {
    player playsoundtoplayer("veh_vtol_open", player);
    playsoundatposition("veh_vtol_land", zone.origin);
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0xd53333be, Offset: 0xf30
// Size: 0xb2
function function_c800052a() {
    playerlist = getplayers();
    foreach (player in playerlist) {
        player playsoundtoplayer("amb_cockpit", player);
    }
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0xd3c8b28e, Offset: 0xff0
// Size: 0x24
function function_fc716128() {
    playsoundatposition("evt_water_vo_lyr_01", (0, 0, 0));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x4de9958e, Offset: 0x1020
// Size: 0x24
function function_6e78d063() {
    playsoundatposition("evt_water_vo_lyr_02", (0, 0, 0));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0xbacc479d, Offset: 0x1050
// Size: 0x24
function function_487655fa() {
    playsoundatposition("evt_water_vo_lyr_03", (0, 0, 0));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x2827020c, Offset: 0x1080
// Size: 0x24
function function_decbd389() {
    playsoundatposition("evt_drown_blink_01", (0, 0, 0));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x4b763bfc, Offset: 0x10b0
// Size: 0x24
function function_4ce4df2() {
    playsoundatposition("evt_drown_blink_02", (0, 0, 0));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x44cc556d, Offset: 0x10e0
// Size: 0x24
function function_2ad0c85b() {
    playsoundatposition("evt_drown_blink_03", (0, 0, 0));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0xe05d0b0e, Offset: 0x1110
// Size: 0x24
function function_69386a6b() {
    playsoundatposition("evt_drown", (0, 0, 0));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x6f9687d8, Offset: 0x1140
// Size: 0x2c
function function_ed6114d2() {
    playsoundatposition("evt_door_kick", (12620, 836, 2979));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0xb4fd81e6, Offset: 0x1178
// Size: 0x4c
function function_ceaeaa5a() {
    playsoundatposition("evt_door_bomb_exp", (12295, -721, 2971));
    level util::clientnotify("sndWR");
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0xdfcdefb3, Offset: 0x11d0
// Size: 0x34
function function_c3d203d6() {
    playsoundatposition("evt_lower_combat_exp_snap", (17220.8, -3074.75, 3528.5));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x5102b988, Offset: 0x1210
// Size: 0x34
function function_5dcd1d9() {
    playsoundatposition("evt_scripted_jet", (17220.8, -3074.75, 3528.5));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x16759b83, Offset: 0x1250
// Size: 0xdc
function function_4e875e0d() {
    playsoundatposition("evt_breach_gunfire", (0, 0, 0));
    wait(3.24);
    playsoundatposition("evt_breach_missile_zip", (15047, 13, 3121));
    wait(0.8);
    playsoundatposition("evt_breach_exp", (15088, 19, 2942));
    wait(1.2);
    playsoundatposition("evt_breach_debris_left", (15286, 391, 2913));
    playsoundatposition("evt_breach_debris_right", (15308, -453, 2914));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0xb0b3e6c6, Offset: 0x1338
// Size: 0x2c
function function_16a46955() {
    wait(4.1);
    playsoundatposition("evt_breach_slowmo", (0, 0, 0));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x3f5991d8, Offset: 0x1370
// Size: 0xb0
function function_ad15f6f5() {
    if (level.var_fc9a3509 == 1) {
        level.var_b8fee04d playloopsound("evt_generator_overload");
        level.var_554aefcd playloopsound("evt_generator_overload_panel");
        return;
    }
    if (level.var_fc9a3509 == 2) {
        level.var_df015ab6 playloopsound("evt_generator_overload");
        level.var_7b4d6a36 playloopsound("evt_generator_overload_panel");
    }
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x6b5a5320, Offset: 0x1428
// Size: 0x110
function function_1024da0a() {
    if (level.var_fc9a3509 == 1) {
        level.var_b8fee04d stoploopsound();
        level.var_b8fee04d playsound("evt_generator_release");
        level.var_554aefcd stoploopsound();
        level.var_554aefcd playsound("evt_generator_release_panel");
        return;
    }
    if (level.var_fc9a3509 == 2) {
        level.var_df015ab6 stoploopsound();
        level.var_df015ab6 playsound("evt_generator_release");
        level.var_7b4d6a36 stoploopsound();
        level.var_7b4d6a36 playsound("evt_generator_release_panel");
    }
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x79524140, Offset: 0x1540
// Size: 0x140
function function_e76f158() {
    if (level.var_fc9a3509 == 1) {
        level.var_b8fee04d stoploopsound();
        level.var_b8fee04d playsound("evt_boss_exp_01");
        thread function_30d6c739();
        level.var_554aefcd stoploopsound();
        level.var_554aefcd playsound("evt_generator_release_panel");
        wait(0.1);
        level.var_fc9a3509 = 2;
        return;
    }
    if (level.var_fc9a3509 == 2) {
        level.var_df015ab6 stoploopsound();
        level.var_df015ab6 playsound("evt_boss_exp_02");
        thread function_56d941a2();
        level.var_7b4d6a36 stoploopsound();
        level.var_7b4d6a36 playsound("evt_generator_release_panel");
    }
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0xc9bc37de, Offset: 0x1688
// Size: 0x34
function function_30d6c739() {
    wait(1.5);
    playsoundatposition("evt_boss_exp_elec", (16678, 2893, 2276));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x5f51dfc8, Offset: 0x16c8
// Size: 0x34
function function_56d941a2() {
    wait(1.5);
    playsoundatposition("evt_boss_exp_elec", (16126, 4352, 2279));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x6bf0cfc9, Offset: 0x1708
// Size: 0x24
function function_f8835fe9() {
    playsoundatposition("evt_escape_exp_sml", (0, 0, 0));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0xf90eeef8, Offset: 0x1738
// Size: 0x24
function function_5d0cee98() {
    playsoundatposition("evt_escape_exp_lrg", (0, 0, 0));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x2a5eea65, Offset: 0x1768
// Size: 0x32c
function function_b01c9f8() {
    playsoundatposition("evt_runout_first_exp", (0, 0, 0));
    wait(0.5);
    var_1d84d980 = spawn("script_origin", (16357, 1454, 2140));
    var_1d84d980 playloopsound("evt_runout_alarm_01");
    var_8f8c48bb = spawn("script_origin", (16548, 1041, 2561));
    var_8f8c48bb playloopsound("evt_runout_alarm_02");
    var_472c43c8 = spawn("script_origin", (15669, 1167, 2320));
    var_472c43c8 playloopsound("evt_runout_water_spray_01");
    var_b933b303 = spawn("script_origin", (16505, 918, 2519));
    var_b933b303 playloopsound("evt_runout_water_spray_01");
    var_8218f48c = spawn("script_origin", (15775, 1150, 2285));
    var_8218f48c playloopsound("evt_runout_water_splatter");
    var_f42063c7 = spawn("script_origin", (16500, 913, 2409));
    var_f42063c7 playloopsound("evt_runout_water_splatter");
    var_78abe30 = spawn("script_origin", (15643, 1158, 2442));
    var_78abe30 playloopsound("evt_runout_large_water");
    var_b77e0da = spawn("script_origin", (15883, 937, 2459));
    var_b77e0da playloopsound("evt_runout_wall_fire");
    var_6754449b = spawn("script_origin", (15755, 1298, 2164));
    var_6754449b playloopsound("evt_runout_large_fire");
    level waittill(#"hash_92f048cf");
    playsoundatposition("evt_runout_corridor_exp", (15862, 1444, 2090));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0xd5249e51, Offset: 0x1aa0
// Size: 0x1e4
function function_850c7ab7() {
    wait(0.5);
    playsoundatposition("evt_exfil_elec_exp", (15827, -117, 3144));
    wait(0.5);
    playsoundatposition("evt_exfil_exp_01", (15930, 978, 2815));
    wait(14.2);
    playsoundatposition("evt_exfil_exp_02", (15725, 56, 2889));
    wait(0.6);
    playsoundatposition("evt_exfil_exp_03", (15425, 287, 2846));
    wait(0.9);
    playsoundatposition("evt_exfil_exp_04", (15039, 820, 3270));
    wait(0.7);
    playsoundatposition("evt_exfil_exp_05", (14347, 2257, 2468));
    wait(1.3);
    playsoundatposition("evt_exfil_exp_06", (15038, 4150, 2915));
    wait(0.4);
    playsoundatposition("evt_exfil_exp_07", (15180, 2305, 3093));
    wait(2.2);
    playsoundatposition("evt_exfil_exp_08", (14142, 6656, 3856));
    wait(0.4);
    playsoundatposition("evt_exfil_exp_09", (15063, 6200, 3213));
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0xf771a109, Offset: 0x1c90
// Size: 0x768
function function_fbfb4dae() {
    level.var_7dc8a9bd[0][0] = "vox_aqui_130_10_001_esol";
    level.var_7dc8a9bd[0][1] = "vox_aqui_130_10_002_esol";
    level.var_7dc8a9bd[1][0] = "vox_aqui_130_20_001_esol";
    level.var_7dc8a9bd[1][1] = "vox_aqui_130_20_002_esol";
    level.var_7dc8a9bd[2][0] = "vox_aqui_130_30_001_esol";
    level.var_7dc8a9bd[2][1] = "vox_aqui_130_30_002_esol";
    level.var_7dc8a9bd[2][2] = "vox_aqui_130_30_003_esol";
    level.var_7dc8a9bd[2][3] = "vox_aqui_130_30_004_esol";
    level.var_7dc8a9bd[3][0] = "vox_aqui_130_40_001_esol";
    level.var_7dc8a9bd[3][1] = "vox_aqui_130_40_002_esol";
    level.var_7dc8a9bd[3][2] = "vox_aqui_130_40_003_esol";
    level.var_7dc8a9bd[4][0] = "vox_aqui_130_50_001_esol";
    level.var_7dc8a9bd[4][1] = "vox_aqui_130_50_002_esol";
    level.var_7dc8a9bd[4][2] = "vox_aqui_130_50_003_esol";
    level.var_7dc8a9bd[4][3] = "vox_aqui_130_50_004_esol";
    level.var_7dc8a9bd[4][4] = "vox_aqui_130_50_005_esol";
    level.var_7dc8a9bd[4][5] = "vox_aqui_130_50_006_esol";
    level.var_7dc8a9bd[5][0] = "vox_aqui_130_60_001_esol";
    level.var_7dc8a9bd[5][1] = "vox_aqui_130_60_002_esol";
    level.var_7dc8a9bd[5][2] = "vox_aqui_130_60_003_esol";
    level.var_7dc8a9bd[5][3] = "vox_aqui_130_60_004_esol";
    level.var_7dc8a9bd[5][4] = "vox_aqui_130_60_005_esol";
    level.var_7dc8a9bd[5][5] = "vox_aqui_130_60_006_esol";
    level.var_7dc8a9bd[6][0] = "vox_aqui_130_70_001_esol";
    level.var_7dc8a9bd[6][1] = "vox_aqui_130_70_002_esol";
    level.var_7dc8a9bd[6][2] = "vox_aqui_130_70_003_esol";
    level.var_7dc8a9bd[7][0] = "vox_aqui_130_80_001_esol";
    level.var_7dc8a9bd[7][1] = "vox_aqui_130_80_002_esol";
    level.var_7dc8a9bd[7][2] = "vox_aqui_130_80_003_esol";
    level.var_7dc8a9bd[7][3] = "vox_aqui_130_80_004_esol";
    level.var_7dc8a9bd[7][4] = "vox_aqui_130_80_005_esol";
    level.var_7dc8a9bd[8][0] = "vox_aqui_130_90_001_esol";
    level.var_7dc8a9bd[8][1] = "vox_aqui_130_90_002_esol";
    level.var_7dc8a9bd[8][2] = "vox_aqui_130_90_003_esol";
    level.var_7dc8a9bd[8][3] = "vox_aqui_130_90_004_esol";
    level.var_7dc8a9bd[8][4] = "vox_aqui_130_90_005_esol";
    level.var_7dc8a9bd[9][0] = "vox_aqui_130_100_001_esol";
    level.var_7dc8a9bd[9][1] = "vox_aqui_130_100_002_esol";
    level.var_7dc8a9bd[9][2] = "vox_aqui_130_100_003_esol";
    level.var_7dc8a9bd[9][4] = "vox_aqui_130_100_004_esol";
    level.var_7dc8a9bd[9][5] = "vox_aqui_130_100_005_esol";
    level.var_7dc8a9bd[9][6] = "vox_aqui_130_100_006_esol";
    level.var_7dc8a9bd[9][7] = "vox_aqui_130_100_007_esol";
    level.var_7dc8a9bd[10][0] = "vox_aqui_130_110_001_esol";
    level.var_7dc8a9bd[10][1] = "vox_aqui_130_110_002_esol";
    level.var_7dc8a9bd[10][2] = "vox_aqui_130_110_003_esol";
    level.var_7dc8a9bd[10][3] = "vox_aqui_130_110_004_esol";
    level.var_7dc8a9bd[11][0] = "vox_aqui_130_120_001_esol";
    level.var_7dc8a9bd[11][1] = "vox_aqui_130_120_002_esol";
    level.var_7dc8a9bd[11][2] = "vox_aqui_130_120_003_esol";
    level.var_7dc8a9bd[11][3] = "vox_aqui_130_120_004_esol";
    level.var_7dc8a9bd[12][0] = "vox_aqui_130_120_005_esol";
    level.var_7dc8a9bd[12][1] = "vox_aqui_130_120_006_esol";
    level.var_7dc8a9bd[12][2] = "vox_aqui_130_120_007_esol";
    level.var_7dc8a9bd[12][3] = "vox_aqui_130_120_008_esol";
    level.var_7dc8a9bd[13][0] = "vox_aqui_130_130_001_esol";
    level.var_7dc8a9bd[13][1] = "vox_aqui_130_130_002_esol";
    level.var_7dc8a9bd[13][2] = "vox_aqui_130_130_003_esol";
    level.var_7dc8a9bd[13][3] = "vox_aqui_130_130_004_esol";
    level.var_7dc8a9bd[13][4] = "vox_aqui_130_130_005_esol";
    level.var_7dc8a9bd[14][0] = "vox_aqui_130_140_001_esol";
    level.var_7dc8a9bd[14][1] = "vox_aqui_130_140_002_esol";
    level.var_7dc8a9bd[14][2] = "vox_aqui_130_140_003_esol";
    level.var_7dc8a9bd[14][3] = "vox_aqui_130_140_004_esol";
    level.var_7dc8a9bd[14][4] = "vox_aqui_130_140_005_esol";
    level.var_7dc8a9bd[15][0] = "vox_aqui_130_150_001_esol";
    level.var_7dc8a9bd[15][1] = "vox_aqui_130_150_002_esol";
    level.var_7dc8a9bd[15][2] = "vox_aqui_130_150_003_esol";
    level.var_7dc8a9bd[15][3] = "vox_aqui_130_150_004_esol";
    level.var_7dc8a9bd[15][4] = "vox_aqui_130_150_005_esol";
}

// Namespace namespace_1d1d22be
// Params 0, eflags: 0x1 linked
// Checksum 0x9380f2bf, Offset: 0x2400
// Size: 0x1f8
function function_cd85d22a() {
    wait(5);
    if (isdefined(level.var_cca43db2)) {
        return;
    }
    level.var_cca43db2 = spawn("script_origin", (0, 0, 0));
    level.var_7dc8a9bd = [];
    function_fbfb4dae();
    i = 0;
    t = 0;
    var_9999bbd7 = 0;
    while (true) {
        level flag::wait_till("background_chatter_active");
        var_9999bbd7 = randomint(level.var_7dc8a9bd.size);
        convo = level.var_7dc8a9bd[var_9999bbd7];
        foreach (alias in convo) {
            t = soundgetplaybacktime(alias);
            level.var_cca43db2 playsound(alias);
            if (t > 0) {
                wait(t / 1000);
            }
            wait(randomfloatrange(0.3, 1));
        }
        wait(randomfloatrange(1.5, 3.5));
    }
}

// Namespace namespace_1d1d22be
// Params 1, eflags: 0x1 linked
// Checksum 0x401ee5df, Offset: 0x2600
// Size: 0x64
function function_de37a122(b_active) {
    if (!isdefined(b_active)) {
        b_active = 1;
    }
    if (b_active) {
        level flag::set("background_chatter_active");
        return;
    }
    level flag::clear("background_chatter_active");
}

#namespace namespace_71a63eac;

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0x6242b7e3, Offset: 0x2670
// Size: 0x1c
function function_973b77f9() {
    music::setmusicstate("none");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x0
// Checksum 0xa01b03ba, Offset: 0x2698
// Size: 0x1c
function function_5712e4e2() {
    music::setmusicstate("intro_igc");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0xd4b9231, Offset: 0x26c0
// Size: 0x1c
function function_bdb99f05() {
    music::setmusicstate("destroy_asp");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x0
// Checksum 0xcc7b5971, Offset: 0x26e8
// Size: 0x1c
function function_48972636() {
    music::setmusicstate("dogfight");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0xe55f2ba4, Offset: 0x2710
// Size: 0x1c
function function_e703f818() {
    music::setmusicstate("comm_tower");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0xbc60da9e, Offset: 0x2738
// Size: 0x1c
function function_ca2c6d9f() {
    music::setmusicstate("water_room_objective");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0xb6159bea, Offset: 0x2760
// Size: 0x24
function function_bb8ce831() {
    wait(7);
    music::setmusicstate("tension_loop_1");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0xf3321b6d, Offset: 0x2790
// Size: 0x1c
function function_8210b658() {
    music::setmusicstate("igc_1_swim");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0x616cc581, Offset: 0x27b8
// Size: 0x1c
function function_e18f629a() {
    music::setmusicstate("tension_loop_2");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0xa832b5bb, Offset: 0x27e0
// Size: 0x1c
function function_a2d40521() {
    music::setmusicstate("battle_bots");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0x7fb6bfdf, Offset: 0x2808
// Size: 0x1c
function function_b1ee6c2d() {
    music::setmusicstate("dogfight_2");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x0
// Checksum 0x2c639473, Offset: 0x2830
// Size: 0x1c
function function_6860e122() {
    music::setmusicstate("interference");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0xc464ef76, Offset: 0x2858
// Size: 0x1c
function function_55376eeb() {
    music::setmusicstate("igc_2_reinforced_door");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0x27d86413, Offset: 0x2880
// Size: 0x1c
function function_36cd6ee8() {
    music::setmusicstate("ground_battle");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0xfde99485, Offset: 0x28a8
// Size: 0x1c
function function_5ac17e2c() {
    music::setmusicstate("just_breach_it");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0x73cfb806, Offset: 0x28d0
// Size: 0x1c
function function_4de42644() {
    music::setmusicstate("igc_3_chase");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x0
// Checksum 0x584b2efd, Offset: 0x28f8
// Size: 0x1c
function function_f819830b() {
    music::setmusicstate("chase_maretti");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0xa3eb6be, Offset: 0x2920
// Size: 0x1c
function function_1a168f0c() {
    music::setmusicstate("hendricks_fight");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0xa8dc39f3, Offset: 0x2948
// Size: 0x1c
function function_99caac9d() {
    music::setmusicstate("overload_battle");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0xdb0e9dd4, Offset: 0x2970
// Size: 0x1c
function function_e0e00797() {
    music::setmusicstate("igc_4_maretti");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0x4200a0b4, Offset: 0x2998
// Size: 0x1c
function function_a1e074db() {
    music::setmusicstate("escape");
}

// Namespace namespace_71a63eac
// Params 0, eflags: 0x1 linked
// Checksum 0x9c38ec14, Offset: 0x29c0
// Size: 0x1c
function function_ae6b41cd() {
    music::setmusicstate("igc_5_outro");
}

