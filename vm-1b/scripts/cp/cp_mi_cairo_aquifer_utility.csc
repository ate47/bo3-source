#using scripts/shared/postfx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/enemy_highlight;
#using scripts/shared/array_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/cp/_load;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace aquifer_util;

// Namespace aquifer_util
// Params 0, eflags: 0x2
// Checksum 0x70fc0dec, Offset: 0xd80
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("aquifer_util", &__init__, undefined, undefined);
}

// Namespace aquifer_util
// Params 0, eflags: 0x0
// Checksum 0x90310184, Offset: 0xdb8
// Size: 0xd2
function __init__() {
    vehicle::add_vehicletype_callback("veh_bo3_mil_vtol_fighter_player_agile", &function_14bb5165);
    vehicle::add_vehicletype_callback("veh_bo3_mil_vtol_fighter_dogfight_enemy", &function_d996daca);
    callback::on_spawned(&on_player_spawned);
    init_clientfields();
    duplicate_render::set_dr_filter_offscreen("weakpoint_keyline", 100, "weakpoint_keyline_show_z", "weakpoint_keyline_hide_z", 2, "mc/hud_outline_model_z_orange", 1);
    thread function_3e82b262();
    thread function_8f62f317();
}

// Namespace aquifer_util
// Params 0, eflags: 0x0
// Checksum 0x446c3be3, Offset: 0xe98
// Size: 0x4d2
function init_clientfields() {
    clientfield::register("toplayer", "play_body_loop", 1, 1, "int", &play_body_loop, 0, 0);
    clientfield::register("toplayer", "player_snow_fx", 1, 1, "int", &function_e9ccaf60, 0, 0);
    clientfield::register("toplayer", "player_bubbles_fx", 1, 1, "int", &function_a0fd353d, 0, 0);
    clientfield::register("toplayer", "player_dust_fx", 1, 1, "int", &function_779fd2e3, 0, 0);
    clientfield::register("toplayer", "water_motes", 1, 1, "int", &function_5c9a971, 0, 0);
    clientfield::register("toplayer", "frost_post_fx", 1, 1, "int", &frost_post_fx, 0, 0);
    clientfield::register("toplayer", "splash_post_fx", 1, 1, "int", &splash_post_fx, 0, 0);
    clientfield::register("toplayer", "highlight_ai", 1, 1, "int", &function_cd1f36a6, 0, 0);
    clientfield::register("actor", "robot_bubbles_fx", 1, 1, "int", &function_a57705db, 0, 0);
    clientfield::register("actor", "kane_bubbles_fx", 1, 1, "int", &function_a57705db, 0, 0);
    clientfield::register("vehicle", "vtol_dogfighting", 1, 1, "int", &function_1f92134d, 0, 0);
    clientfield::register("vehicle", "vtol_show_damage_stages", 1, 1, "int", &function_ae9fc4ae, 0, 0);
    clientfield::register("vehicle", "vtol_canopy_state", 1, 1, "int", &function_4aa99a51, 0, 0);
    clientfield::register("vehicle", "vtol_engines_state", 1, 1, "int", &function_c289f3ee, 0, 0);
    clientfield::register("vehicle", "vtol_enable_wash_fx", 1, 1, "int", &function_efde18b9, 0, 0);
    clientfield::register("vehicle", "vtol_damage_state", 1, 2, "int", &function_31d10546, 0, 0);
    clientfield::register("vehicle", "vtol_set_active_landing_zone_num", 1, 4, "int", &function_791c5d3e, 0, 0);
    clientfield::register("vehicle", "vtol_set_missile_lock_percent", 1, 8, "float", &function_58e7b684, 0, 0);
    clientfield::register("vehicle", "vtol_show_missile_lock", 1, 1, "int", &function_ec8280b9, 0, 0);
    clientfield::register("vehicle", "vtol_screen_shake", 1, 1, "int", &function_51990240, 0, 0);
    clientfield::register("world", "toggle_fog_banks", 1, 1, "int", &function_34474782, 0, 0);
    clientfield::register("world", "toggle_pbg_banks", 1, 1, "int", &function_5240a6bb, 0, 0);
}

// Namespace aquifer_util
// Params 1, eflags: 0x0
// Checksum 0x2e5bb641, Offset: 0x1378
// Size: 0x1cd
function on_player_spawned(localclientnum) {
    self endon(#"disconnect");
    if (!self islocalplayer()) {
        return;
    }
    if (!isdefined(self getlocalclientnumber())) {
        return;
    }
    if (self getlocalclientnumber() != localclientnum) {
        return;
    }
    self thread watch_player_death();
    while (isdefined(self) && isalive(self)) {
        veh = getplayervehicle(self);
        if (!isdefined(veh)) {
            umbra_setdistancescale(localclientnum, 1);
            umbra_setminimumcontributionthreshold(localclientnum, 0);
            veh = self waittill(#"enter_vehicle");
            if (!isdefined(veh)) {
                continue;
            }
        }
        self.vehicle = veh;
        self thread function_1a818d12(localclientnum);
        self thread function_63bf76ee(localclientnum);
        umbra_setdistancescale(localclientnum, 6);
        umbra_setminimumcontributionthreshold(localclientnum, 8);
        setsoundcontext("aquifer_cockpit", "active");
        self waittill(#"exit_vehicle");
        self.vehicle = undefined;
        umbra_setdistancescale(localclientnum, 1);
        umbra_setminimumcontributionthreshold(localclientnum, 0);
        setsoundcontext("aquifer_cockpit", "");
        if (isdefined(self.var_ae2d4705)) {
            self stoploopsound(self.var_ae2d4705);
            self.var_ae2d4705 = undefined;
        }
    }
}

// Namespace aquifer_util
// Params 0, eflags: 0x0
// Checksum 0x3f2f9761, Offset: 0x1550
// Size: 0xf7
function function_8f62f317() {
    while (true) {
        level waittill(#"save_restore");
        while (getlocalplayers().size == 0) {
            wait 0.016;
        }
        foreach (player in getlocalplayers()) {
            veh = getplayervehicle(player);
            if (isdefined(veh)) {
                localclientnum = player getlocalclientnumber();
                player.vehicle = veh;
                player thread function_1a818d12(localclientnum);
                player thread function_63bf76ee(localclientnum);
            }
        }
    }
}

// Namespace aquifer_util
// Params 0, eflags: 0x0
// Checksum 0xc76faee0, Offset: 0x1650
// Size: 0x51
function watch_player_death() {
    self notify(#"watch_player_death");
    self endon(#"watch_player_death");
    self endon(#"disconnect");
    self waittill(#"death");
    if (isdefined(self) && isdefined(self.var_ae2d4705)) {
        self stoploopsound(self.var_ae2d4705);
        self.var_ae2d4705 = undefined;
    }
}

// Namespace aquifer_util
// Params 5, eflags: 0x0
// Checksum 0xe8af275b, Offset: 0x16b0
// Size: 0x73
function function_b69b9863(localclientnum, oldval, newval, bnewent, binitialsnap) {
    if (!self islocalplayer()) {
        return false;
    }
    if (!isdefined(self getlocalclientnumber())) {
        return false;
    }
    if (self getlocalclientnumber() != localclientnum) {
        return false;
    }
    return true;
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x5264b8c8, Offset: 0x1730
// Size: 0x82
function play_body_loop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (binitialsnap) {
        return;
    }
    struct = getent(localclientnum, "igc_kane_khalil_1", "targetname");
    struct thread scene::play("cin_aqu_03_20_water_room_body_loop");
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x4672deb3, Offset: 0x17c0
// Size: 0xfd
function function_cd1f36a6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval == newval && !binitialsnap) {
        return;
    }
    if (!self islocalplayer()) {
        return;
    }
    if (!isdefined(self getlocalclientnumber())) {
        return;
    }
    if (self getlocalclientnumber() != localclientnum) {
        return;
    }
    switch (newval) {
    case 0:
        self thread enemy_highlight::function_5f9074e0(localclientnum);
        break;
    case 1:
        self thread enemy_highlight::function_a2489af5(localclientnum, "compassping_enemysatellite_diamond", 64, 1, 2, 1, "compassping_friendly");
        break;
    }
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x13ef3a6b, Offset: 0x18c8
// Size: 0xd2
function function_5c9a971(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!self islocalplayer()) {
        return;
    }
    if (!isdefined(self getlocalclientnumber())) {
        return;
    }
    if (self getlocalclientnumber() != localclientnum) {
        return;
    }
    if (newval != 0) {
        self.var_8e8c7340 = playfxoncamera(localclientnum, "water/fx_underwater_debris_player_loop", (0, 0, 0), (1, 0, 0), (0, 0, 1));
        return;
    }
    if (isdefined(self.var_8e8c7340)) {
        deletefx(localclientnum, self.var_8e8c7340, 1);
    }
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x3dd8f96f, Offset: 0x19a8
// Size: 0x109
function function_779fd2e3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!self islocalplayer()) {
        return;
    }
    if (!isdefined(self getlocalclientnumber())) {
        return;
    }
    if (self getlocalclientnumber() != localclientnum) {
        return;
    }
    if (newval == 1) {
        if (isdefined(self.var_766e336e)) {
            deletefx(localclientnum, self.var_766e336e, 1);
        }
        self.var_766e336e = playfxoncamera(localclientnum, "dirt/fx_dust_sand_aquifer_player_loop", (0, 0, 0), (1, 0, 0), (0, 0, 1));
        return;
    }
    self notify(#"hash_1f63111d");
    if (isdefined(self.var_766e336e)) {
        deletefx(localclientnum, self.var_766e336e, 1);
        self.var_766e336e = undefined;
    }
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0xa649cddb, Offset: 0x1ac0
// Size: 0x62
function frost_post_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread postfx::playpostfxbundle("pstfx_frost_loop");
        return;
    }
    self thread postfx::exitpostfxbundle();
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x454576ae, Offset: 0x1b30
// Size: 0x62
function splash_post_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread postfx::playpostfxbundle("pstfx_water_t_out");
        return;
    }
    self thread postfx::exitpostfxbundle();
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x554d5657, Offset: 0x1ba0
// Size: 0x129
function function_e9ccaf60(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!self islocalplayer()) {
        return;
    }
    if (!isdefined(self getlocalclientnumber())) {
        return;
    }
    if (self getlocalclientnumber() != localclientnum) {
        return;
    }
    if (newval == 1) {
        if (isdefined(self.var_28791de7)) {
            deletefx(localclientnum, self.var_28791de7, 1);
        }
        setpbgactivebank(localclientnum, 2);
        self.var_28791de7 = playfxontag(localclientnum, "snow/fx_snow_player_aqu_loop", self, "tag_origin");
        return;
    }
    setpbgactivebank(localclientnum, 1);
    self notify(#"hash_822eb8e8");
    if (isdefined(self.var_28791de7)) {
        deletefx(localclientnum, self.var_28791de7, 1);
        self.var_28791de7 = undefined;
    }
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x180941f9, Offset: 0x1cd8
// Size: 0x109
function function_a0fd353d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!self islocalplayer()) {
        return;
    }
    if (!isdefined(self getlocalclientnumber())) {
        return;
    }
    if (self getlocalclientnumber() != localclientnum) {
        return;
    }
    if (newval == 1) {
        if (isdefined(self.var_8f4881d8)) {
            deletefx(localclientnum, self.var_8f4881d8, 1);
        }
        self.var_8f4881d8 = playfxoncamera(localclientnum, "player/fx_plyr_swim_bubbles_body", (0, 0, 0), (1, 0, 0), (0, 0, 1));
        return;
    }
    self notify(#"hash_6b998eb7");
    if (isdefined(self.var_8f4881d8)) {
        deletefx(localclientnum, self.var_8f4881d8, 1);
        self.var_8f4881d8 = undefined;
    }
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x6474f822, Offset: 0x1df0
// Size: 0x102
function function_a57705db(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!self islocalplayer()) {
        return;
    }
    if (!isdefined(self getlocalclientnumber())) {
        return;
    }
    if (self getlocalclientnumber() != localclientnum) {
        return;
    }
    if (newval == 1) {
        if (isdefined(self.var_8f4881d8)) {
            stopfx(localclientnum, self.var_8f4881d8);
        }
        self.n_fx_id = playfxontag(localclientnum, "player/fx_plyr_swim_bubbles_body", self, "tag_aim");
        return;
    }
    self notify(#"hash_fcaf4326");
    if (isdefined(self.var_8f4881d8)) {
        stopfx(localclientnum, self.var_8f4881d8);
    }
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0xa6c43c5f, Offset: 0x1f00
// Size: 0xd5
function function_48637c84(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!self islocalplayer()) {
        return;
    }
    if (!isdefined(self getlocalclientnumber())) {
        return;
    }
    if (self getlocalclientnumber() != localclientnum) {
        return;
    }
    switch (newval) {
    case 0:
        setsaveddvar("r_dof_aperture_override", 1);
        break;
    case 1:
        setsaveddvar("r_dof_aperture_override", 50);
        break;
    }
}

/#

    // Namespace aquifer_util
    // Params 7, eflags: 0x0
    // Checksum 0xcb6dbd7, Offset: 0x1fe0
    // Size: 0x135
    function function_1122caac(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
        if (!self islocalplayer()) {
            return;
        }
        if (!isdefined(self getlocalclientnumber())) {
            return;
        }
        if (self getlocalclientnumber() != localclientnum) {
            return;
        }
        switch (newval) {
        case 0:
            setsaveddvar("<dev string:x28>", 40);
            setsaveddvar("<dev string:x49>", 50);
            setsaveddvar("<dev string:x6a>", 6000);
            setsaveddvar("<dev string:x88>", 10000);
            break;
        case 1:
            setsaveddvar("<dev string:x28>", 50);
            setsaveddvar("<dev string:x49>", -106);
            break;
        }
    }

#/

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x63a73bac, Offset: 0x2120
// Size: 0xf8
function function_31d10546(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_31d10546");
    self endon(#"hash_31d10546");
    local_player = getlocalplayer(localclientnum);
    for (player_vehicle = getplayervehicle(local_player); !isdefined(player_vehicle) && isdefined(local_player) && isalive(local_player); player_vehicle = getplayervehicle(local_player)) {
        wait 0.05;
        if (isdefined(local_player)) {
        }
    }
    if (!isdefined(player_vehicle) || !isdefined(local_player) || self != player_vehicle) {
        return;
    }
    local_player.vtol_damage_state = newval;
    local_player notify(#"hash_751c841");
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0xbd0d52f1, Offset: 0x2220
// Size: 0x205
function function_1f92134d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player_vehicle = getplayervehicle(getlocalplayer(localclientnum));
    if (!bnewent && !binitialsnap && oldval == newval) {
        return;
    }
    switch (newval) {
    case 0:
        self.dogfighting = 0;
        if (isdefined(player_vehicle) && player_vehicle == self) {
            playsound(localclientnum, "veh_bullshark_dogfight_exit");
            if (isdefined(self.var_163163d4)) {
                self stoploopsound(self.var_163163d4);
                self.var_163163d4 = undefined;
            }
            if (isdefined(self.var_144b2dd7)) {
                self stoploopsound(self.var_144b2dd7);
                self.var_144b2dd7 = undefined;
            }
            self notify(#"hash_71c3f064");
        } else {
            self.var_58f8ead2 = 0;
        }
        break;
    case 1:
        self.dogfighting = 1;
        if (isdefined(player_vehicle) && player_vehicle == self) {
            playsound(localclientnum, "veh_bullshark_dogfight_enter");
            self.var_163163d4 = self playloopsound("veh_bullshark_dogfight_maneuvers");
            self.var_144b2dd7 = self playloopsound("veh_bullshark_dogfight_turbulence");
            self setloopstate("veh_bullshark_dogfight_maneuvers", 0.5, 1);
            self setloopstate("veh_bullshark_dogfight_turbulence", 0, 1);
        } else {
            self thread function_5e259b76(localclientnum);
        }
        break;
    }
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x8ae46d69, Offset: 0x2430
// Size: 0x9d
function function_ae9fc4ae(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 0:
        self flagsys::clear("show_damage_stages");
        break;
    case 1:
        self flagsys::set("show_damage_stages");
        self thread vtol_show_damage_stages(localclientnum);
        break;
    }
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x93faaee2, Offset: 0x24d8
// Size: 0xea
function function_4aa99a51(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval == newval && !(binitialsnap || bnewent)) {
        return;
    }
    self useanimtree(#generic);
    anims = [];
    anims[0] = generic%v_aqu_vtol_cockpit_close;
    anims[1] = generic%v_aqu_vtol_cockpit_open;
    assert(newval >= 0 && newval <= 1);
    self setanim(anims[newval], 1, 0, 1);
    self setanim(anims[!newval], 0, 0, 1);
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x32258de, Offset: 0x25d0
// Size: 0x13a
function function_c289f3ee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval == newval && !(binitialsnap || bnewent)) {
        return;
    }
    self useanimtree(#generic);
    anims = [];
    anims[0] = generic%v_aqu_vtol_engine_hover;
    anims[1] = generic%v_aqu_vtol_engine_fly;
    assert(newval >= 0 && newval <= 1);
    self setanim(anims[newval], 1, 0, 1);
    self setanim(anims[!newval], 0, 0, 1);
    if (newval == 0) {
        self setanim(generic%v_aqu_vtol_engine_idle, 1, 0, 1);
        return;
    }
    self setanim(generic%v_aqu_vtol_engine_idle, 0, 0, 1);
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x822298, Offset: 0x2718
// Size: 0x8a
function function_7c706c83(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!self islocalplayer()) {
        return;
    }
    if (!isdefined(self getlocalclientnumber())) {
        return;
    }
    if (self getlocalclientnumber() != localclientnum) {
        return;
    }
    self.var_443f7e14 = newval;
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x7234dc99, Offset: 0x27b0
// Size: 0x31d
function function_791c5d3e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_791c5d3e");
    self endon(#"hash_791c5d3e");
    local_player = getlocalplayer(localclientnum);
    for (player_vehicle = getplayervehicle(local_player); !isdefined(player_vehicle) && isdefined(local_player) && isalive(local_player); player_vehicle = getplayervehicle(local_player)) {
        wait 0.05;
        if (isdefined(local_player)) {
        }
    }
    if (!isdefined(player_vehicle) || !isdefined(local_player) || self != player_vehicle) {
        return;
    }
    if (!isdefined(local_player.var_4c67c5eb)) {
        local_player.var_4c67c5eb = [];
    }
    foreach (landing_zone in local_player.var_4c67c5eb) {
        landing_zone function_400e6e82(localclientnum, "vtol_landing_zone");
    }
    local_player.var_4c67c5eb = [];
    indices = [];
    for (i = 3; i >= 0; i--) {
        var_8e34c2ec = pow(2, i);
        if (newval >= var_8e34c2ec) {
            indices[indices.size] = i + 1;
            newval -= var_8e34c2ec;
        }
    }
    var_dda84f1a = getentarray(localclientnum, "landing_zone", "targetname");
    foreach (landing_zone in var_dda84f1a) {
        foreach (index in indices) {
            if (isdefined(landing_zone.script_noteworthy) && int(landing_zone.script_noteworthy) == index) {
                array::add(local_player.var_4c67c5eb, landing_zone, 0);
                landing_zone function_ea0e7704(localclientnum, "vtol_landing_zone", "light/fx_beam_vtol_landing_zone", landing_zone.origin, anglestoforward(landing_zone.angles), (0, 0, 1));
                break;
            }
        }
    }
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x73aa609b, Offset: 0x2ad8
// Size: 0x1ae
function function_58e7b684(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_58e7b684");
    self endon(#"hash_58e7b684");
    local_player = getlocalplayer(localclientnum);
    for (player_vehicle = getplayervehicle(local_player); !isdefined(player_vehicle) && isdefined(local_player) && isalive(local_player); player_vehicle = getplayervehicle(local_player)) {
        wait 0.05;
        if (isdefined(local_player)) {
        }
    }
    if (!isdefined(player_vehicle) || !isdefined(local_player) || self != player_vehicle) {
        return;
    }
    if (!isdefined(local_player.var_14351725)) {
        local_player.var_14351725 = newval;
        local_player thread function_4c53e7bf(localclientnum);
    }
    if (newval < 1 && local_player.var_14351725 >= 1) {
        if (isdefined(local_player.var_ae2d4705)) {
            local_player stoploopsound(local_player.var_ae2d4705);
            local_player.var_ae2d4705 = undefined;
        }
    } else if (newval >= 1 && local_player.var_14351725 < 1) {
        local_player.var_ae2d4705 = local_player playloopsound("veh_bullshark_missile_locked");
    }
    local_player.var_14351725 = newval;
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0xaa7ffd03, Offset: 0x2c90
// Size: 0xee
function function_ec8280b9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_ec8280b9");
    self endon(#"hash_ec8280b9");
    local_player = getlocalplayer(localclientnum);
    for (player_vehicle = getplayervehicle(local_player); !isdefined(player_vehicle) && isdefined(local_player) && isalive(local_player); player_vehicle = getplayervehicle(local_player)) {
        wait 0.05;
        if (isdefined(local_player)) {
        }
    }
    if (!isdefined(player_vehicle) || !isdefined(local_player) || self != player_vehicle) {
        return;
    }
    local_player.var_b83262c7 = newval;
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x43ef6ae9, Offset: 0x2d88
// Size: 0x1c1
function function_51990240(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_51990240");
    self endon(#"hash_51990240");
    local_player = getlocalplayer(localclientnum);
    for (player_vehicle = getplayervehicle(local_player); !isdefined(player_vehicle) && isdefined(local_player) && isalive(local_player); player_vehicle = getplayervehicle(local_player)) {
        wait 0.05;
        if (isdefined(local_player)) {
        }
    }
    if (!isdefined(player_vehicle) || !isdefined(local_player) || self != player_vehicle) {
        return;
    }
    scale = 0.1;
    if (newval) {
        while (isdefined(self) && isdefined(local_player) && !(isdefined(self.dogfighting) && self.dogfighting)) {
            local_player earthquake(scale, 0.05, local_player.origin, 1000);
            wait 0.05;
        }
        return;
    }
    while (isdefined(self) && scale >= 0.01 && isdefined(local_player) && !(isdefined(self.dogfighting) && self.dogfighting)) {
        local_player earthquake(scale, 0.05, local_player.origin, 1000);
        wait 0.05;
        scale *= 0.99;
    }
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x777d8e33, Offset: 0x2f58
// Size: 0xaa
function function_efde18b9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        self notify(#"hash_72fd2c6a");
        if (isdefined(self.var_594d1ec6)) {
            self.var_594d1ec6 function_400e6e82(localclientnum, "wash", 0);
            self.var_594d1ec6 delete();
            self.var_594d1ec6 = undefined;
        }
        return;
    }
    self thread function_7946d98(localclientnum);
}

// Namespace aquifer_util
// Params 1, eflags: 0x0
// Checksum 0x51837c1, Offset: 0x3010
// Size: 0x1a5
function function_7946d98(localclientnum) {
    self endon(#"death");
    self endon(#"hash_72fd2c6a");
    self notify(#"hash_7946d98");
    self endon(#"hash_7946d98");
    if (!isdefined(self.var_594d1ec6)) {
        self.var_594d1ec6 = util::spawn_model(localclientnum, "tag_origin", self.origin);
    }
    while (isdefined(self)) {
        start = self gettagorigin("tag_driver");
        trace = bullettrace(start, start - (0, 0, 300), 0, self);
        if (trace["fraction"] == 1 && isdefined(self.var_594d1ec6)) {
            self.var_594d1ec6 function_400e6e82(localclientnum, "wash", 0);
        } else if (trace["fraction"] < 1) {
            self.var_594d1ec6.origin = trace["position"];
            var_7788a7d = vectortoangles(trace["normal"]);
            self.var_594d1ec6.angles = (0, var_7788a7d[0], 0);
            if (!self.var_594d1ec6 function_766878c8(localclientnum, "wash")) {
                self.var_594d1ec6 function_88a10e85(localclientnum, "wash", "dirt/fx_dust_rotorwash_vtol_loop", "tag_origin");
            }
        }
        wait 0.016;
    }
}

// Namespace aquifer_util
// Params 1, eflags: 0x0
// Checksum 0xd8a207d9, Offset: 0x31c0
// Size: 0x2e6
function function_3b907fc(localclientnum) {
    menuname = "VehicleHUD_VTOL_Target";
    var_535afdd7 = getluimenu(localclientnum, menuname);
    if (!isdefined(var_535afdd7)) {
        self.var_58eaeac1 = createluimenu(localclientnum, menuname);
        setluimenudata(localclientnum, self.var_58eaeac1, "newTarget", 0);
        setluimenudata(localclientnum, self.var_58eaeac1, "targetWidth", 1280);
        setluimenudata(localclientnum, self.var_58eaeac1, "targetHeight", 720);
        setluimenudata(localclientnum, self.var_58eaeac1, "targetX", 0);
        setluimenudata(localclientnum, self.var_58eaeac1, "targetY", 0);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetAlpha", 0);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetScale", 0);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRotZ", 0);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetWidth", -64);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetHeight", -64);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetX", 0);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetY", 0);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetLerpTime", 50);
        setluimenudata(localclientnum, self.var_58eaeac1, "material", "uie_t7_cp_hud_vehicle_vtol_lockoncircle");
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRed", 1);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetGreen", 1);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetBlue", 1);
        setluimenudata(localclientnum, self.var_58eaeac1, "close_current_menu", 0);
        openluimenu(localclientnum, self.var_58eaeac1);
        return;
    }
    self.var_58eaeac1 = var_535afdd7;
}

// Namespace aquifer_util
// Params 1, eflags: 0x0
// Checksum 0x9dd03ac8, Offset: 0x34b0
// Size: 0xf2
function function_1a818d12(localclientnum) {
    self notify(#"hash_1a818d12");
    self endon(#"hash_1a818d12");
    self endon(#"disconnect");
    self function_3b907fc(localclientnum);
    self thread function_d2243c73(localclientnum);
    self thread function_21e63f39(localclientnum);
    self thread function_11381ece(localclientnum);
    self util::waittill_any("exit_vehicle", "enter_vehicle", "death");
    self function_3b907fc(localclientnum);
    setluimenudata(localclientnum, self.var_58eaeac1, "close_current_menu", 1);
    wait 0.75;
    if (isdefined(self)) {
        self function_3b907fc(localclientnum);
        closeluimenu(localclientnum, self.var_58eaeac1);
    }
}

// Namespace aquifer_util
// Params 1, eflags: 0x0
// Checksum 0xc56b3dee, Offset: 0x35b0
// Size: 0xd9
function function_11381ece(localclientnum) {
    self notify(#"hash_11381ece");
    self endon(#"hash_11381ece");
    self endon(#"enter_vehicle");
    self endon(#"exit_vehicle");
    self endon(#"death");
    self endon(#"disconnect");
    while (isdefined(self) && isalive(self)) {
        var_d87d3f09 = self gettargetlockentityarray();
        if (!isdefined(self.missile_target) || var_d87d3f09.size > 0 && var_d87d3f09[0] != self.missile_target) {
            self.missile_target = var_d87d3f09[0];
            self notify(#"hash_6c567715");
        } else if (var_d87d3f09.size == 0 && isdefined(self.missile_target)) {
            self.missile_target = undefined;
            self notify(#"hash_6c567715");
        }
        wait 0.016;
    }
}

// Namespace aquifer_util
// Params 1, eflags: 0x0
// Checksum 0xf5a633e, Offset: 0x3698
// Size: 0x3aa
function function_d2243c73(localclientnum) {
    self notify(#"hash_d2243c73");
    self endon(#"hash_d2243c73");
    self endon(#"enter_vehicle");
    self endon(#"exit_vehicle");
    self endon(#"death");
    self endon(#"disconnect");
    while (isdefined(self) && isalive(self)) {
        self waittill(#"hash_6c567715");
        if (!isdefined(self)) {
            return;
        }
        if (isdefined(self.missile_target)) {
            entpos = self.missile_target gettagorigin("tag_body");
            if (!isdefined(entpos)) {
                entpos = self.missile_target.origin;
            }
            self.missile_target.var_e7323f20 = project3dto2d(localclientnum, entpos);
        }
        while (self.missile_target.var_e7323f20[0] < -128 || self.missile_target.var_e7323f20[0] > 1152 || self.missile_target.var_e7323f20[1] < 72 || isdefined(self) && isdefined(self.missile_target) && isalive(self.missile_target) && self.missile_target.var_e7323f20[2] > 648) {
            entpos = self.missile_target gettagorigin("tag_body");
            if (!isdefined(entpos)) {
                entpos = self.missile_target.origin;
            }
            self.missile_target.var_e7323f20 = project3dto2d(localclientnum, entpos);
            wait 0.016;
        }
        if (!isdefined(self)) {
            return;
        }
        self function_3b907fc(localclientnum);
        setluimenudata(localclientnum, self.var_58eaeac1, "newTarget", 1);
        while (isdefined(self) && isdefined(self.missile_target) && isdefined(self.missile_target.var_e7323f20) && isalive(self.missile_target) && !self.missile_target ishidden()) {
            entpos = self.missile_target gettagorigin("tag_body");
            if (!isdefined(entpos)) {
                entpos = self.missile_target.origin;
            }
            self.missile_target.var_e7323f20 = project3dto2d(localclientnum, entpos);
            self function_3b907fc(localclientnum);
            setluimenudata(localclientnum, self.var_58eaeac1, "targetX", self.missile_target.var_e7323f20[0]);
            setluimenudata(localclientnum, self.var_58eaeac1, "targetY", self.missile_target.var_e7323f20[1]);
            wait 0.016;
        }
        if (!isdefined(self)) {
            return;
        }
        self function_3b907fc(localclientnum);
        setluimenudata(localclientnum, self.var_58eaeac1, "newTarget", 0);
    }
    self function_3b907fc(localclientnum);
    setluimenudata(localclientnum, self.var_58eaeac1, "newTarget", 0);
}

// Namespace aquifer_util
// Params 1, eflags: 0x0
// Checksum 0x7803b6f6, Offset: 0x3a50
// Size: 0x845
function function_21e63f39(localclientnum) {
    self notify(#"hash_29a67729");
    self endon(#"hash_29a67729");
    self endon(#"enter_vehicle");
    self endon(#"exit_vehicle");
    self endon(#"death");
    self endon(#"disconnect");
    max_radius = 162.5;
    locked = 0;
    var_beb0eb1e = 0.6;
    var_e64062c8 = 0.3;
    var_bcd414e9 = 540;
    var_428be7c0 = -64;
    var_9f14e241 = viewaspect(localclientnum);
    height = 360;
    width = height * var_9f14e241;
    while (isdefined(self) && isalive(self)) {
        self waittill(#"hash_6c567715");
        while (isdefined(self) && !(isdefined(self.var_b83262c7) && self.var_b83262c7)) {
            wait 0.016;
        }
        while (isdefined(self) && isdefined(self.missile_target) && isalive(self.missile_target) && !self.missile_target ishidden()) {
            self function_3b907fc(localclientnum);
            if (isdefined(self.var_14351725)) {
                entpos = self.missile_target gettagorigin("tag_body");
                if (!isdefined(entpos)) {
                    entpos = self.missile_target.origin;
                }
                self.missile_target.var_e7323f20 = project3dto2d(localclientnum, entpos);
                scale = var_e64062c8 + (var_beb0eb1e - var_e64062c8) * (1 - self.var_14351725);
                offset = (self.missile_target.var_e7323f20[0] - width, self.missile_target.var_e7323f20[1] - height, 0);
                dist = length(offset);
                if (dist > max_radius - var_428be7c0 * 0.5 * scale) {
                    dir = vectornormalize(offset);
                    offset = dir * (max_radius - var_428be7c0 * 0.5 * scale);
                }
                setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetLerpTime", 50);
                setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetX", width + offset[0]);
                setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetY", height + offset[1]);
                if (self.var_14351725 >= 1) {
                    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRotZ", self getclienttime() % 1000 / 1000 * var_bcd414e9);
                    setluimenudata(localclientnum, self.var_58eaeac1, "material", "uie_t7_cp_hud_vehicle_vtol_lockoncircle");
                    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetAlpha", 1);
                    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetScale", var_e64062c8);
                    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRed", 1);
                    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetGreen", 0);
                    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetBlue", 0);
                } else {
                    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRotZ", self.var_14351725 * var_bcd414e9);
                    setluimenudata(localclientnum, self.var_58eaeac1, "material", "uie_t7_cp_hud_vehicle_vtol_lockoncircle");
                    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetAlpha", 0.33);
                    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetScale", scale);
                    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRed", 1);
                    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetGreen", 1);
                    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetBlue", 1);
                }
            } else {
                setluimenudata(localclientnum, self.var_58eaeac1, "material", "uie_t7_cp_hud_vehicle_vtol_lockoncircle");
                setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetAlpha", 0.33);
                setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetScale", var_beb0eb1e);
                setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetLerpTime", -6);
                setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetX", width);
                setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetY", height);
                setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRed", 1);
                setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetGreen", 1);
                setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetBlue", 1);
            }
            wait 0.016;
        }
        if (!isdefined(self)) {
            return;
        }
        self function_3b907fc(localclientnum);
        setluimenudata(localclientnum, self.var_58eaeac1, "material", "uie_t7_cp_hud_vehicle_vtol_lockoncircle");
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetAlpha", 0);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetScale", var_beb0eb1e);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRotZ", 0);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetLerpTime", -6);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetX", width);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetY", height);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRed", 1);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetGreen", 1);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetBlue", 1);
    }
}

// Namespace aquifer_util
// Params 0, eflags: 0x0
// Checksum 0x46131fc3, Offset: 0x42a0
// Size: 0x71
function function_458ed430() {
    var_50e4abf2 = [];
    var_50e4abf2[var_50e4abf2.size] = "tag_fx_cockpit_1";
    var_50e4abf2[var_50e4abf2.size] = "tag_fx_cockpit_2";
    var_50e4abf2[var_50e4abf2.size] = "tag_fx_cockpit_3";
    var_50e4abf2[var_50e4abf2.size] = "tag_fx_cockpit_4";
    var_50e4abf2[var_50e4abf2.size] = "tag_fx_cockpit_5";
    var_50e4abf2[var_50e4abf2.size] = "tag_fx_cockpit_6";
    var_50e4abf2[var_50e4abf2.size] = "tag_fx_cockpit_7";
    return array::randomize(var_50e4abf2);
}

// Namespace aquifer_util
// Params 1, eflags: 0x0
// Checksum 0x55cc6f6b, Offset: 0x4320
// Size: 0x2cf
function function_63bf76ee(localclientnum) {
    self notify(#"hash_63bf76ee");
    self endon(#"hash_63bf76ee");
    self endon(#"disconnect");
    var_7276535a = 2;
    self.vtol_damage_state = 0;
    var_614619a5 = [];
    for (i = 0; i < var_7276535a; i++) {
        var_614619a5[i] = [];
    }
    var_50e4abf2 = function_458ed430();
    var_59fc256 = [];
    var_59fc256[var_59fc256.size] = 3;
    var_59fc256[var_59fc256.size] = 3;
    while (isdefined(self) && isdefined(self.vehicle)) {
        self waittill(#"hash_751c841");
        if (!isdefined(self) || !isdefined(self.vehicle) || !isdefined(self.vtol_damage_state)) {
            break;
        }
        if (self.vtol_damage_state == 0) {
            foreach (damage_state in var_614619a5) {
                foreach (damage_fx in damage_state) {
                    killfx(localclientnum, damage_fx);
                }
                damage_state = [];
            }
            var_50e4abf2 = function_458ed430();
            continue;
        }
        index = self.vtol_damage_state - 1;
        damage_fx = "electric/fx_elec_vtol_dmg_runner";
        if (self.vtol_damage_state > 1) {
            damage_fx = "electric/fx_elec_vtol_dmg_runner";
        }
        for (i = 0; i < var_59fc256[index]; i++) {
            var_614619a5[index][var_614619a5[index].size] = playfxontag(localclientnum, damage_fx, self.vehicle, array::pop(var_50e4abf2));
        }
    }
    foreach (damage_state in var_614619a5) {
        foreach (damage_fx in damage_state) {
            killfx(localclientnum, damage_fx);
        }
        damage_state = [];
    }
}

// Namespace aquifer_util
// Params 1, eflags: 0x0
// Checksum 0xeadd4e77, Offset: 0x45f8
// Size: 0x1f9
function vtol_show_damage_stages(localclientnum) {
    if (isdefined(self.vtol_show_damage_stages) && self.vtol_show_damage_stages) {
        return;
    }
    self.vtol_show_damage_stages = 1;
    damage_fx = [];
    var_b1e0b5bc = -1;
    ent = self;
    while (isdefined(self) && isalive(self) && flagsys::get("show_damage_stages")) {
        if (isdefined(var_b1e0b5bc) && var_b1e0b5bc != self gethelidamagestate()) {
            var_b1e0b5bc = self gethelidamagestate();
            switch (var_b1e0b5bc) {
            case 1:
                damage_fx[damage_fx.size] = playfxontag(localclientnum, "vehicle/fx_vtol_dmg_trail_01", self, "tag_body");
                break;
            case 2:
                damage_fx[damage_fx.size] = playfxontag(localclientnum, "vehicle/fx_vtol_dmg_trail_02", self, "tag_body");
                break;
            case 3:
                playfx(localclientnum, "vehicle/fx_vtol_dmg_trail_03", self gettagorigin("tag_body"), anglestoforward(self gettagangles("tag_body")));
                break;
            }
            if (var_b1e0b5bc == 3) {
                break;
            }
        }
        level waittill(#"damage_stage_changed");
    }
    foreach (fx in damage_fx) {
        killfx(localclientnum, fx);
    }
    if (isdefined(self)) {
        self.vtol_show_damage_stages = undefined;
    }
}

// Namespace aquifer_util
// Params 1, eflags: 0x0
// Checksum 0x2c5cfef5, Offset: 0x4800
// Size: 0xa1
function function_4c53e7bf(localclientnum) {
    self endon(#"disconnect");
    while (isdefined(self) && isdefined(self.var_14351725) && isalive(self)) {
        if (self.var_14351725 > 0 && self.var_14351725 < 1) {
            self playsound(localclientnum, "veh_bullshark_missile_locking");
            wait (1 - self.var_14351725) * 0.5;
            continue;
        }
        wait 0.016;
    }
}

// Namespace aquifer_util
// Params 1, eflags: 0x0
// Checksum 0x217496d9, Offset: 0x48b0
// Size: 0x82
function function_14bb5165(localclientnum) {
    self.dogfighting = 0;
    self.var_dad0e5c1 = 1;
    self thread function_c0623e13(localclientnum);
    self useanimtree(#generic);
    self setanim(generic%v_aqu_vtol_engine_hover, 1, 0, 1);
    self setanim(generic%v_aqu_vtol_engine_idle, 1, 0, 1);
}

// Namespace aquifer_util
// Params 1, eflags: 0x0
// Checksum 0x91d61e13, Offset: 0x4940
// Size: 0x12
function function_d996daca(localclientnum) {
    self.var_dad0e5c1 = 1;
}

// Namespace aquifer_util
// Params 1, eflags: 0x0
// Checksum 0xdc95cf5, Offset: 0x4960
// Size: 0xbda
function function_c0623e13(localclientnum) {
    self endon(#"death");
    var_a2c58ba3 = "off";
    var_14386bda = "off";
    var_80cad4ec = "off";
    var_2cdec570 = "off";
    var_bd5365a3 = "off";
    var_20282599 = "off";
    var_594f1b7d = self.angles;
    var_48ca4678 = self getvelocity() / 17.6;
    self function_88a10e85(localclientnum, "running_lights", "vehicle/fx_vtol_formation_lights", "tag_body_animate", 0, 0);
    self function_88a10e85(localclientnum, "running_lights", "vehicle/fx_vtol_taileron_lights_l", "tag_taileron_l_animate", 0, 0);
    self function_88a10e85(localclientnum, "running_lights", "vehicle/fx_vtol_taileron_lights_r", "tag_taileron_r_animate", 0, 0);
    while (isdefined(self) && isalive(self) && self hasdobj(localclientnum)) {
        velocity = self getvelocity() / 17.6;
        var_27f6615e = velocity - var_48ca4678;
        accel = var_27f6615e / 0.016;
        angle_diff = self.angles - var_594f1b7d;
        angle_diff = (angleclamp180(angle_diff[0]), angleclamp180(angle_diff[1]), angleclamp180(angle_diff[2]));
        var_d13d119c = angle_diff / 0.016;
        if (self.dogfighting) {
            if (var_2cdec570 != "off") {
                self function_400e6e82(localclientnum, "vtol_hover_thrust");
                var_2cdec570 = "off";
            }
            if (var_bd5365a3 != "off") {
                self function_400e6e82(localclientnum, "vtol_roll_thrust");
                var_bd5365a3 = "off";
            }
            if (var_20282599 != "off") {
                self function_400e6e82(localclientnum, "vtol_brake_thrust");
                var_20282599 = "off";
            }
            if (abs(angle_diff[0]) <= 5 && var_a2c58ba3 != "off") {
                self function_400e6e82(localclientnum, "vtol_pitch_fx");
                var_a2c58ba3 = "off";
            } else if (abs(angle_diff[0]) > 5 && abs(angle_diff[0]) <= 10 && var_a2c58ba3 != "low") {
                self function_400e6e82(localclientnum, "vtol_pitch_fx");
                self function_88a10e85(localclientnum, "vtol_pitch_fx", "vehicle/fx_vtol_vapor_light", "tag_body_animate");
                var_a2c58ba3 = "low";
            } else if (abs(angle_diff[0]) > 10 && var_a2c58ba3 != "high") {
                self function_400e6e82(localclientnum, "vtol_pitch_fx");
                self function_88a10e85(localclientnum, "vtol_pitch_fx", "vehicle/fx_vtol_vapor_extreme", "tag_body_animate");
                var_a2c58ba3 = "high";
            }
            if (absangleclamp180(self.angles[2]) < 30 && var_14386bda != "off") {
                self function_400e6e82(localclientnum, "vtol_roll_fx");
                var_14386bda = "off";
            } else if (absangleclamp180(self.angles[2]) >= 30 && var_14386bda != "on") {
                self function_88a10e85(localclientnum, "vtol_roll_fx", "vehicle/fx_vtol_contrail", "tag_body_animate");
                var_14386bda = "on";
            }
            var_6c17606c = var_80cad4ec;
            if (self getspeed() <= 400 && var_80cad4ec != "off") {
                self function_400e6e82(localclientnum, "vtol_afterburn_fx");
                var_80cad4ec = "off";
            } else if (self getspeed() > 400 && var_80cad4ec != "on") {
                self function_88a10e85(localclientnum, "vtol_afterburn_fx", "vehicle/fx_vtol_thruster_afterburn", "tag_fx_engine_left", 0, 0);
                self function_88a10e85(localclientnum, "vtol_afterburn_fx", "vehicle/fx_vtol_thruster_afterburn", "tag_fx_engine_right", 0, 0);
                var_80cad4ec = "on";
            }
            player_vehicle = getplayervehicle(getlocalplayer(localclientnum));
            if (isdefined(player_vehicle) && player_vehicle == self) {
                self setloopstate("veh_bullshark_dogfight_turbulence", abs(self.angles[2]) / 90, 1);
                self setloopstate("veh_bullshark_dogfight_maneuvers", 1 - abs(self.angles[2]) / 90, 1);
                if (var_6c17606c != var_80cad4ec) {
                    if (var_80cad4ec == "on") {
                        self playsound(localclientnum, "veh_bullshark_boost");
                        self.var_cb5468ff = self playloopsound("veh_bullshark_sprint_lp");
                    } else {
                        self playsound(localclientnum, "veh_bullshark_sprint_exit");
                        if (isdefined(self.var_cb5468ff)) {
                            self stoploopsound(self.var_cb5468ff);
                            self.var_cb5468ff = undefined;
                        }
                    }
                }
            }
        } else {
            if (var_a2c58ba3 != "off") {
                self function_400e6e82(localclientnum, "vtol_pitch_fx");
                var_a2c58ba3 = "off";
            }
            if (var_14386bda != "off") {
                self function_400e6e82(localclientnum, "vtol_roll_fx");
                var_14386bda = "off";
            }
            if (var_2cdec570 == "off") {
                self function_88a10e85(localclientnum, "vtol_hover_thrust", "vehicle/fx_vtol_thruster_wing_aquifer", "tag_fx_roll_nozzle_l_2", 0, 0);
                self function_88a10e85(localclientnum, "vtol_hover_thrust", "vehicle/fx_vtol_thruster_wing_aquifer", "tag_fx_roll_nozzle_r_2", 0, 0);
                var_2cdec570 = "on";
            }
            if (var_80cad4ec != "off") {
                self function_400e6e82(localclientnum, "vtol_afterburn_fx");
                var_80cad4ec = "off";
                player_vehicle = getplayervehicle(getlocalplayer(localclientnum));
                if (isdefined(player_vehicle) && player_vehicle == self) {
                    self playsound(localclientnum, "veh_bullshark_sprint_exit");
                    if (isdefined(self.var_cb5468ff)) {
                        self stoploopsound(self.var_cb5468ff);
                        self.var_cb5468ff = undefined;
                    }
                }
            }
            if (abs(var_d13d119c[2]) <= 5 && absangleclamp180(self.angles[2] <= 5) && var_bd5365a3 != "off") {
                self function_400e6e82(localclientnum, "vtol_roll_thrust");
                var_bd5365a3 = "off";
            } else if (var_d13d119c[2] > 5 && var_bd5365a3 != "left") {
                self function_88a10e85(localclientnum, "vtol_roll_thrust", "vehicle/fx_vtol_thruster_wing_aquifer_brake", "tag_fx_roll_nozzle_l_2");
                var_bd5365a3 = "left";
            } else if (var_d13d119c[2] < -5 && var_bd5365a3 != "right") {
                self function_88a10e85(localclientnum, "vtol_roll_thrust", "vehicle/fx_vtol_thruster_wing_aquifer_brake", "tag_fx_roll_nozzle_r_2");
                var_bd5365a3 = "right";
            }
            if (accel[2] <= 50 && velocity[2] <= 25 && var_20282599 != "off") {
                self function_400e6e82(localclientnum, "vtol_brake_thrust");
                var_20282599 = "off";
            } else if ((accel[2] > 50 || velocity[2] > 25) && var_20282599 != "on") {
                self function_88a10e85(localclientnum, "vtol_brake_thrust", "vehicle/fx_vtol_thruster_wing_aquifer_brake", "tag_fx_roll_nozzle_l_2", 0, 0);
                self function_88a10e85(localclientnum, "vtol_brake_thrust", "vehicle/fx_vtol_thruster_wing_aquifer_brake", "tag_fx_roll_nozzle_r_2", 0, 0);
                var_20282599 = "on";
            }
        }
        var_594f1b7d = self.angles;
        var_48ca4678 = velocity;
        wait 0.016;
    }
    if (isdefined(self)) {
        if (var_2cdec570 != "off") {
            self function_400e6e82(localclientnum, "vtol_hover_thrust");
            var_2cdec570 = "off";
        }
        if (var_bd5365a3 != "off") {
            self function_400e6e82(localclientnum, "vtol_roll_thrust");
            var_bd5365a3 = "off";
        }
        if (var_20282599 != "off") {
            self function_400e6e82(localclientnum, "vtol_brake_thrust");
            var_20282599 = "off";
        }
        if (var_a2c58ba3 != "off") {
            self function_400e6e82(localclientnum, "vtol_pitch_fx");
            var_a2c58ba3 = "off";
        }
        if (var_14386bda != "off") {
            self function_400e6e82(localclientnum, "vtol_roll_fx");
            var_14386bda = "off";
        }
        if (var_80cad4ec != "off") {
            self function_400e6e82(localclientnum, "vtol_afterburn_fx");
            var_80cad4ec = "off";
        }
        if (isdefined(self.var_cb5468ff)) {
            self stoploopsound(self.var_cb5468ff);
            self.var_cb5468ff = undefined;
        }
        self function_400e6e82(localclientnum, "running_lights");
    }
}

// Namespace aquifer_util
// Params 1, eflags: 0x0
// Checksum 0xda7088ac, Offset: 0x5548
// Size: 0x582
function function_5e259b76(localclientnum) {
    self endon(#"death");
    if (isdefined(self.var_58f8ead2) && self.var_58f8ead2) {
        return;
    }
    var_a2c58ba3 = "off";
    var_14386bda = "off";
    var_80cad4ec = "off";
    self function_88a10e85(localclientnum, "running_lights", "vehicle/fx_vtol_formation_lights", "tag_body_animate", 0, 0);
    self function_88a10e85(localclientnum, "running_lights", "vehicle/fx_vtol_taileron_lights_l", "tag_taileron_l_animate", 0, 0);
    self function_88a10e85(localclientnum, "running_lights", "vehicle/fx_vtol_taileron_lights_r", "tag_taileron_r_animate", 0, 0);
    self.var_58f8ead2 = 1;
    var_f9fab1b1 = self gettagangles("tag_body_animate");
    var_80d8531 = var_f9fab1b1;
    while (isdefined(self.var_58f8ead2) && isdefined(self) && isalive(self) && self.var_58f8ead2) {
        var_f9fab1b1 = self gettagangles("tag_body_animate");
        self.var_786fcc03 = (var_f9fab1b1 - var_80d8531) / 0.016;
        if (abs(self.var_786fcc03[0]) <= 5 && var_a2c58ba3 != "off") {
            self function_400e6e82(localclientnum, "vtol_pitch_fx");
            var_a2c58ba3 = "off";
        } else if (abs(self.var_786fcc03[0]) > 5 && abs(self.var_786fcc03[0]) <= 10 && var_a2c58ba3 != "low") {
            self function_400e6e82(localclientnum, "vtol_pitch_fx");
            self function_88a10e85(localclientnum, "vtol_pitch_fx", "vehicle/fx_vtol_vapor_light", "tag_body_animate");
            var_a2c58ba3 = "low";
        } else if (abs(self.var_786fcc03[0]) > 10 && var_a2c58ba3 != "high") {
            self function_400e6e82(localclientnum, "vtol_pitch_fx");
            self function_88a10e85(localclientnum, "vtol_pitch_fx", "vehicle/fx_vtol_vapor_extreme", "tag_body_animate");
            var_a2c58ba3 = "high";
        }
        if (absangleclamp180(var_f9fab1b1[2]) < 30 && var_14386bda != "off") {
            self function_400e6e82(localclientnum, "vtol_roll_fx");
            var_14386bda = "off";
        } else if (absangleclamp180(var_f9fab1b1[2]) >= 30 && var_14386bda != "on") {
            self function_88a10e85(localclientnum, "vtol_roll_fx", "vehicle/fx_vtol_contrail", "tag_body_animate");
            var_14386bda = "on";
        }
        var_6c17606c = var_80cad4ec;
        if (self getspeed() <= self getmaxspeed() * 0.75 && var_80cad4ec != "off") {
            self function_400e6e82(localclientnum, "vtol_afterburn_fx");
            var_80cad4ec = "off";
        } else if (self getspeed() > self getmaxspeed() * 0.75 && var_80cad4ec != "on") {
            self function_88a10e85(localclientnum, "vtol_afterburn_fx", "vehicle/fx_vtol_thruster_afterburn", "tag_fx_engine_left", 0, 0);
            self function_88a10e85(localclientnum, "vtol_afterburn_fx", "vehicle/fx_vtol_thruster_afterburn", "tag_fx_engine_right", 0, 0);
            var_80cad4ec = "on";
        }
        var_80d8531 = var_f9fab1b1;
        wait 0.016;
    }
    if (isdefined(self)) {
        if (var_a2c58ba3 != "off") {
            self function_400e6e82(localclientnum, "vtol_pitch_fx");
            var_a2c58ba3 = "off";
        }
        if (var_14386bda != "off") {
            self function_400e6e82(localclientnum, "vtol_roll_fx");
            var_14386bda = "off";
        }
        if (var_80cad4ec != "off") {
            self function_400e6e82(localclientnum, "vtol_afterburn_fx");
            var_80cad4ec = "off";
        }
        self function_400e6e82(localclientnum, "running_lights");
    }
}

// Namespace aquifer_util
// Params 1, eflags: 0x0
// Checksum 0x247fc10d, Offset: 0x5ad8
// Size: 0x22
function function_863ee84(vel) {
    return length(vel) / 17.6;
}

// Namespace aquifer_util
// Params 2, eflags: 0x0
// Checksum 0x1894ee65, Offset: 0x5b08
// Size: 0x6d
function function_766878c8(localclientnum, str_type) {
    if (isdefined(self.var_62bb476b) && isdefined(self.var_62bb476b[localclientnum]) && isdefined(self.var_62bb476b[localclientnum][str_type]) && isarray(self.var_62bb476b[localclientnum][str_type]) && self.var_62bb476b[localclientnum][str_type].size > 0) {
        return true;
    }
    return false;
}

// Namespace aquifer_util
// Params 4, eflags: 0x0
// Checksum 0x5c4cfee4, Offset: 0x5b80
// Size: 0x145
function function_835cb7d(localclientnum, str_type, str_fx, clear) {
    if (!isdefined(clear)) {
        clear = 1;
    }
    if (!isdefined(self.var_62bb476b)) {
        self.var_62bb476b = [];
    }
    if (!isdefined(self.var_62bb476b[localclientnum])) {
        self.var_62bb476b[localclientnum] = [];
    }
    if (!isdefined(self.var_62bb476b[localclientnum][str_type])) {
        self.var_62bb476b[localclientnum][str_type] = [];
    }
    if (isdefined(str_fx)) {
        if (isdefined(self.var_62bb476b[localclientnum][str_type][str_fx]) && clear) {
            foreach (n_fx_id in self.var_62bb476b[localclientnum][str_type][str_fx]) {
                deletefx(localclientnum, n_fx_id, 0);
            }
            self.var_62bb476b[localclientnum][str_type][str_fx] = [];
            return;
        }
        if (!isdefined(self.var_62bb476b[localclientnum][str_type][str_fx])) {
            self.var_62bb476b[localclientnum][str_type][str_fx] = [];
        }
    }
}

// Namespace aquifer_util
// Params 3, eflags: 0x0
// Checksum 0x592e95ac, Offset: 0x5cd0
// Size: 0x117
function function_400e6e82(localclientnum, str_type, var_91599cfb) {
    if (!isdefined(var_91599cfb)) {
        var_91599cfb = 1;
    }
    if (isdefined(self.var_62bb476b) && isdefined(self.var_62bb476b[localclientnum]) && isdefined(self.var_62bb476b[localclientnum][str_type])) {
        a_keys = getarraykeys(self.var_62bb476b[localclientnum][str_type]);
        for (i = 0; i < a_keys.size; i++) {
            foreach (n_fx_id in self.var_62bb476b[localclientnum][str_type][a_keys[i]]) {
                deletefx(localclientnum, n_fx_id, var_91599cfb);
            }
            self.var_62bb476b[localclientnum][str_type][a_keys[i]] = [];
        }
    }
}

// Namespace aquifer_util
// Params 6, eflags: 0x0
// Checksum 0x8f6c401b, Offset: 0x5df0
// Size: 0xde
function function_88a10e85(localclientnum, str_type, str_fx, str_tag, var_cffd17f8, var_de656156) {
    if (!isdefined(str_tag)) {
        str_tag = "tag_origin";
    }
    if (!isdefined(var_cffd17f8)) {
        var_cffd17f8 = 1;
    }
    if (!isdefined(var_de656156)) {
        var_de656156 = 1;
    }
    self function_835cb7d(localclientnum, str_type, str_fx, var_de656156);
    if (var_cffd17f8) {
        self function_400e6e82(localclientnum, str_type, 0);
    }
    n_fx_id = playfxontag(localclientnum, str_fx, self, str_tag);
    array_size = self.var_62bb476b[localclientnum][str_type][str_fx].size;
    self.var_62bb476b[localclientnum][str_type][str_fx][array_size] = n_fx_id;
}

// Namespace aquifer_util
// Params 8, eflags: 0x0
// Checksum 0x822b9e8d, Offset: 0x5ed8
// Size: 0x126
function function_ea0e7704(localclientnum, str_type, str_fx, v_pos, v_forward, v_up, var_cffd17f8, var_de656156) {
    if (!isdefined(var_cffd17f8)) {
        var_cffd17f8 = 1;
    }
    if (!isdefined(var_de656156)) {
        var_de656156 = 1;
    }
    self function_835cb7d(localclientnum, str_type, str_fx, var_de656156);
    if (var_cffd17f8) {
        self function_400e6e82(localclientnum, str_type, 0);
    }
    if (isdefined(v_forward) && isdefined(v_up)) {
        n_fx_id = playfx(localclientnum, str_fx, v_pos, v_forward, v_up);
    } else if (isdefined(v_forward)) {
        n_fx_id = playfx(localclientnum, str_fx, v_pos, v_forward);
    } else {
        n_fx_id = playfx(localclientnum, str_fx, v_pos);
    }
    array_size = self.var_62bb476b[localclientnum][str_type][str_fx].size;
    self.var_62bb476b[localclientnum][str_type][str_fx][array_size] = n_fx_id;
}

// Namespace aquifer_util
// Params 0, eflags: 0x0
// Checksum 0xbcc46112, Offset: 0x6008
// Size: 0x10a
function function_3e82b262() {
    self endon(#"disconnect");
    smodelanimcmd("boss_tree", "pause", "unloop", "goto_start");
    smodelanimcmd("boss_hallucinate_glass", "pause", "unloop", "goto_start");
    smodelanimcmd("boss_room_glass", "pause", "unloop", "goto_start");
    level waittill(#"hash_4fd5d268");
    smodelanimcmd("boss_tree", "unpause");
    smodelanimcmd("boss_hallucinate_glass", "unpause");
    level waittill(#"hash_e830ddcf");
    smodelanimcmd("boss_room_glass", "unpause");
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x89828d79, Offset: 0x6120
// Size: 0x6a
function function_34474782(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4780a11e = 1;
    if (newval == 1) {
        var_4780a11e = 2;
    }
    setworldfogactivebank(localclientnum, var_4780a11e);
}

// Namespace aquifer_util
// Params 7, eflags: 0x0
// Checksum 0x79753c64, Offset: 0x6198
// Size: 0x6a
function function_5240a6bb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4780a11e = 1;
    if (newval == 1) {
        var_4780a11e = 2;
    }
    setpbgactivebank(localclientnum, var_4780a11e);
}

