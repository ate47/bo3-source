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

#namespace namespace_786319bb;

// Namespace namespace_786319bb
// Params 0, eflags: 0x2
// Checksum 0xa2f97bb6, Offset: 0xd80
// Size: 0x34
function function_2dc19561() {
    system::register("aquifer_util", &__init__, undefined, undefined);
}

// Namespace namespace_786319bb
// Params 0, eflags: 0x0
// Checksum 0xc30be9cf, Offset: 0xdc0
// Size: 0xe4
function __init__() {
    vehicle::add_vehicletype_callback("veh_bo3_mil_vtol_fighter_player_agile", &function_14bb5165);
    vehicle::add_vehicletype_callback("veh_bo3_mil_vtol_fighter_dogfight_enemy", &function_d996daca);
    callback::on_spawned(&on_player_spawned);
    init_clientfields();
    duplicate_render::set_dr_filter_offscreen("weakpoint_keyline", 100, "weakpoint_keyline_show_z", "weakpoint_keyline_hide_z", 2, "mc/hud_outline_model_z_orange", 1);
    thread function_3e82b262();
    thread function_8f62f317();
}

// Namespace namespace_786319bb
// Params 0, eflags: 0x0
// Checksum 0xeb7a95fd, Offset: 0xeb0
// Size: 0x67c
function init_clientfields() {
    clientfield::register("toplayer", "play_body_loop", 1, 1, "int", &function_d00289ef, 0, 0);
    clientfield::register("toplayer", "player_snow_fx", 1, 1, "int", &function_e9ccaf60, 0, 0);
    clientfield::register("toplayer", "player_bubbles_fx", 1, 1, "int", &function_a0fd353d, 0, 0);
    clientfield::register("toplayer", "player_dust_fx", 1, 1, "int", &function_779fd2e3, 0, 0);
    clientfield::register("toplayer", "water_motes", 1, 1, "int", &function_5c9a971, 0, 0);
    clientfield::register("toplayer", "frost_post_fx", 1, 1, "int", &function_d823aea7, 0, 0);
    clientfield::register("toplayer", "splash_post_fx", 1, 1, "int", &function_90020e42, 0, 0);
    clientfield::register("toplayer", "highlight_ai", 1, 1, "int", &function_cd1f36a6, 0, 0);
    clientfield::register("actor", "robot_bubbles_fx", 1, 1, "int", &function_a57705db, 0, 0);
    clientfield::register("actor", "kane_bubbles_fx", 1, 1, "int", &function_a57705db, 0, 0);
    clientfield::register("actor", "toggle_enemy_highlight", 1, 1, "int", &function_af7432f, 0, 0);
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

// Namespace namespace_786319bb
// Params 1, eflags: 0x0
// Checksum 0x8157cc63, Offset: 0x1538
// Size: 0x21a
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
            level thread function_256950b0(localclientnum);
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
        level thread function_256950b0(localclientnum);
        setsoundcontext("aquifer_cockpit", "");
        if (isdefined(self.var_ae2d4705)) {
            self stoploopsound(self.var_ae2d4705);
            self.var_ae2d4705 = undefined;
        }
    }
}

// Namespace namespace_786319bb
// Params 1, eflags: 0x0
// Checksum 0x59f0ff7d, Offset: 0x1760
// Size: 0x3c
function function_256950b0(localclientnum) {
    umbra_setdistancescale(localclientnum, 1);
    umbra_setminimumcontributionthreshold(localclientnum, 0);
}

// Namespace namespace_786319bb
// Params 0, eflags: 0x0
// Checksum 0xaf702099, Offset: 0x17a8
// Size: 0x126
function function_8f62f317() {
    while (true) {
        level waittill(#"save_restore");
        while (getlocalplayers().size == 0) {
            wait(0.016);
        }
        foreach (player in getlocalplayers()) {
            veh = getplayervehicle(player);
            if (isdefined(veh)) {
                localclientnum = player getlocalclientnumber();
                player.vehicle = veh;
            }
        }
    }
}

// Namespace namespace_786319bb
// Params 0, eflags: 0x0
// Checksum 0x101c99ee, Offset: 0x18d8
// Size: 0x76
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

// Namespace namespace_786319bb
// Params 5, eflags: 0x0
// Checksum 0xabd13a8c, Offset: 0x1958
// Size: 0x8c
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

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0x90376db4, Offset: 0x19f0
// Size: 0x94
function function_d00289ef(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (binitialsnap) {
        return;
    }
    struct = getent(localclientnum, "igc_kane_khalil_1", "targetname");
    struct thread scene::play("cin_aqu_03_20_water_room_body_loop");
}

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0x6d6c7cd8, Offset: 0x1a90
// Size: 0x12e
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
        self thread namespace_68dfcbbe::function_5f9074e0(localclientnum);
        break;
    case 1:
        self thread namespace_68dfcbbe::function_a2489af5(localclientnum, "compassping_enemysatellite_diamond", 64, 1, 2, 1, "compassping_friendly");
        break;
    }
}

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0x1788d9d1, Offset: 0x1bc8
// Size: 0xfc
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

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0x2f6a810f, Offset: 0x1cd0
// Size: 0x146
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

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0x88805bdd, Offset: 0x1e20
// Size: 0x7c
function function_d823aea7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread postfx::playpostfxbundle("pstfx_frost_loop");
        return;
    }
    self thread postfx::exitpostfxbundle();
}

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0xd0a80379, Offset: 0x1ea8
// Size: 0x7c
function function_90020e42(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread postfx::playpostfxbundle("pstfx_water_t_out");
        return;
    }
    self thread postfx::exitpostfxbundle();
}

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0x8efddaeb, Offset: 0x1f30
// Size: 0x17e
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

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0x2167820d, Offset: 0x20b8
// Size: 0x146
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

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0xd2b22413, Offset: 0x2208
// Size: 0x134
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

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0x41a167e, Offset: 0x2348
// Size: 0xee
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

    // Namespace namespace_786319bb
    // Params 7, eflags: 0x0
    // Checksum 0xa601ec69, Offset: 0x2440
    // Size: 0x16e
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
            setsaveddvar("igc_kane_khalil_1", 40);
            setsaveddvar("targetY", 50);
            setsaveddvar("tag_taileron_l_animate", 6000);
            setsaveddvar("pause", 10000);
            break;
        case 1:
            setsaveddvar("igc_kane_khalil_1", 50);
            setsaveddvar("targetY", -106);
            break;
        }
    }

#/

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0x7d5b6160, Offset: 0x25b8
// Size: 0x144
function function_31d10546(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_31d10546");
    self endon(#"hash_31d10546");
    local_player = getlocalplayer(localclientnum);
    for (player_vehicle = getplayervehicle(local_player); !isdefined(player_vehicle) && isdefined(local_player) && isalive(local_player); player_vehicle = getplayervehicle(local_player)) {
        wait(0.05);
        if (isdefined(local_player)) {
        }
    }
    if (!isdefined(player_vehicle) || !isdefined(local_player) || self != player_vehicle) {
        return;
    }
    local_player.var_d7bfa708 = newval;
    local_player notify(#"hash_751c841");
}

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0xe2bbb9f4, Offset: 0x2708
// Size: 0x286
function function_1f92134d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player_vehicle = getplayervehicle(getlocalplayer(localclientnum));
    if (!bnewent && !binitialsnap && oldval == newval) {
        return;
    }
    switch (newval) {
    case 0:
        self.var_3b4d6693 = 0;
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
        self.var_3b4d6693 = 1;
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

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0xadf67f29, Offset: 0x2998
// Size: 0xb6
function function_ae9fc4ae(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 0:
        self flagsys::clear("show_damage_stages");
        break;
    case 1:
        self flagsys::set("show_damage_stages");
        self thread function_38f84ce8(localclientnum);
        break;
    }
}

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0x674d9f02, Offset: 0x2a58
// Size: 0x13c
function function_4aa99a51(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval == newval && !(binitialsnap || bnewent)) {
        return;
    }
    self useanimtree(#generic);
    anims = [];
    anims[0] = generic%v_aqu_vtol_cockpit_close;
    anims[1] = generic%v_aqu_vtol_cockpit_open;
    /#
        assert(newval >= 0 && newval <= 1);
    #/
    self setanim(anims[newval], 1, 0, 1);
    self setanim(anims[!newval], 0, 0, 1);
}

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0x1ae75320, Offset: 0x2ba0
// Size: 0x1a4
function function_c289f3ee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval == newval && !(binitialsnap || bnewent)) {
        return;
    }
    self useanimtree(#generic);
    anims = [];
    anims[0] = generic%v_aqu_vtol_engine_hover;
    anims[1] = generic%v_aqu_vtol_engine_fly;
    /#
        assert(newval >= 0 && newval <= 1);
    #/
    self setanim(anims[newval], 1, 0, 1);
    self setanim(anims[!newval], 0, 0, 1);
    if (newval == 0) {
        self setanim(generic%v_aqu_vtol_engine_idle, 1, 0, 1);
        return;
    }
    self setanim(generic%v_aqu_vtol_engine_idle, 0, 0, 1);
}

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0x89b43415, Offset: 0x2d50
// Size: 0x9c
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

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0xd80822ce, Offset: 0x2df8
// Size: 0x444
function function_791c5d3e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_791c5d3e");
    self endon(#"hash_791c5d3e");
    local_player = getlocalplayer(localclientnum);
    for (player_vehicle = getplayervehicle(local_player); !isdefined(player_vehicle) && isdefined(local_player) && isalive(local_player); player_vehicle = getplayervehicle(local_player)) {
        wait(0.05);
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

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0x28635bf9, Offset: 0x3248
// Size: 0x244
function function_58e7b684(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_58e7b684");
    self endon(#"hash_58e7b684");
    local_player = getlocalplayer(localclientnum);
    for (player_vehicle = getplayervehicle(local_player); !isdefined(player_vehicle) && isdefined(local_player) && isalive(local_player); player_vehicle = getplayervehicle(local_player)) {
        wait(0.05);
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

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0x834f1b46, Offset: 0x3498
// Size: 0x134
function function_ec8280b9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_ec8280b9");
    self endon(#"hash_ec8280b9");
    local_player = getlocalplayer(localclientnum);
    for (player_vehicle = getplayervehicle(local_player); !isdefined(player_vehicle) && isdefined(local_player) && isalive(local_player); player_vehicle = getplayervehicle(local_player)) {
        wait(0.05);
        if (isdefined(local_player)) {
        }
    }
    if (!isdefined(player_vehicle) || !isdefined(local_player) || self != player_vehicle) {
        return;
    }
    local_player.var_b83262c7 = newval;
}

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0x3e3b061a, Offset: 0x35d8
// Size: 0x23a
function function_51990240(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_51990240");
    self endon(#"hash_51990240");
    local_player = getlocalplayer(localclientnum);
    for (player_vehicle = getplayervehicle(local_player); !isdefined(player_vehicle) && isdefined(local_player) && isalive(local_player); player_vehicle = getplayervehicle(local_player)) {
        wait(0.05);
        if (isdefined(local_player)) {
        }
    }
    if (!isdefined(player_vehicle) || !isdefined(local_player) || self != player_vehicle) {
        return;
    }
    scale = 0.1;
    if (newval) {
        while (isdefined(self) && isdefined(local_player) && !(isdefined(self.var_3b4d6693) && self.var_3b4d6693)) {
            local_player earthquake(scale, 0.05, local_player.origin, 1000);
            wait(0.05);
        }
        return;
    }
    while (isdefined(self) && scale >= 0.01 && isdefined(local_player) && !(isdefined(self.var_3b4d6693) && self.var_3b4d6693)) {
        local_player earthquake(scale, 0.05, local_player.origin, 1000);
        wait(0.05);
        scale *= 0.99;
    }
}

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0xe3feca1f, Offset: 0x3820
// Size: 0xcc
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

// Namespace namespace_786319bb
// Params 1, eflags: 0x0
// Checksum 0x6058bc5e, Offset: 0x38f8
// Size: 0x218
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
        wait(0.016);
    }
}

// Namespace namespace_786319bb
// Params 1, eflags: 0x0
// Checksum 0xeda452a4, Offset: 0x3b18
// Size: 0x394
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

// Namespace namespace_786319bb
// Params 1, eflags: 0x0
// Checksum 0xc2520e6b, Offset: 0x3eb8
// Size: 0x14c
function function_1a818d12(localclientnum) {
    self notify(#"hash_1a818d12");
    self endon(#"hash_1a818d12");
    self endon(#"death");
    self function_3b907fc(localclientnum);
    self thread function_d2243c73(localclientnum);
    self thread function_21e63f39(localclientnum);
    self thread function_11381ece(localclientnum);
    str_return = self util::waittill_any_return("exit_vehicle");
    if (isdefined(self)) {
        self function_3b907fc(localclientnum);
        setluimenudata(localclientnum, self.var_58eaeac1, "close_current_menu", 1);
        wait(0.75);
        self function_3b907fc(localclientnum);
        closeluimenu(localclientnum, self.var_58eaeac1);
    }
}

// Namespace namespace_786319bb
// Params 1, eflags: 0x0
// Checksum 0x61b38aa1, Offset: 0x4010
// Size: 0x114
function function_11381ece(localclientnum) {
    self notify(#"hash_11381ece");
    self endon(#"hash_11381ece");
    self endon(#"exit_vehicle");
    self endon(#"death");
    while (isdefined(self) && isalive(self)) {
        var_d87d3f09 = self gettargetlockentityarray();
        if (!isdefined(self.missile_target) || var_d87d3f09.size > 0 && var_d87d3f09[0] != self.missile_target) {
            self.missile_target = var_d87d3f09[0];
            self notify(#"hash_6c567715");
        } else if (var_d87d3f09.size == 0 && isdefined(self.missile_target)) {
            self.missile_target = undefined;
            self notify(#"hash_6c567715");
        }
        wait(0.016);
    }
}

// Namespace namespace_786319bb
// Params 1, eflags: 0x0
// Checksum 0xb32ef818, Offset: 0x4130
// Size: 0x464
function function_d2243c73(localclientnum) {
    self notify(#"hash_d2243c73");
    self endon(#"hash_d2243c73");
    self endon(#"exit_vehicle");
    self endon(#"death");
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
            wait(0.016);
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
            wait(0.016);
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

// Namespace namespace_786319bb
// Params 1, eflags: 0x0
// Checksum 0x55d07b42, Offset: 0x45a0
// Size: 0xa30
function function_21e63f39(localclientnum) {
    self notify(#"hash_29a67729");
    self endon(#"hash_29a67729");
    self endon(#"exit_vehicle");
    self endon(#"death");
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
            wait(0.016);
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
            wait(0.016);
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

// Namespace namespace_786319bb
// Params 0, eflags: 0x0
// Checksum 0x2b83ccdd, Offset: 0x4fd8
// Size: 0xb2
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

// Namespace namespace_786319bb
// Params 1, eflags: 0x0
// Checksum 0xd1ad0251, Offset: 0x5098
// Size: 0x410
function function_63bf76ee(localclientnum) {
    self notify(#"hash_63bf76ee");
    self endon(#"hash_63bf76ee");
    self endon(#"disconnect");
    var_7276535a = 2;
    self.var_d7bfa708 = 0;
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
        if (!isdefined(self) || !isdefined(self.vehicle) || !isdefined(self.var_d7bfa708)) {
            break;
        }
        if (self.var_d7bfa708 == 0) {
            foreach (damage_state in var_614619a5) {
                foreach (damage_fx in damage_state) {
                    killfx(localclientnum, damage_fx);
                }
                damage_state = [];
            }
            var_50e4abf2 = function_458ed430();
            continue;
        }
        index = self.var_d7bfa708 - 1;
        damage_fx = "electric/fx_elec_vtol_dmg_runner";
        if (self.var_d7bfa708 > 1) {
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

// Namespace namespace_786319bb
// Params 1, eflags: 0x0
// Checksum 0x506dcace, Offset: 0x54b0
// Size: 0x28a
function function_38f84ce8(localclientnum) {
    if (isdefined(self.var_38f84ce8) && self.var_38f84ce8) {
        return;
    }
    self.var_38f84ce8 = 1;
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
        level waittill(#"hash_fb60a9dc");
    }
    foreach (fx in damage_fx) {
        killfx(localclientnum, fx);
    }
    if (isdefined(self)) {
        self.var_38f84ce8 = undefined;
    }
}

// Namespace namespace_786319bb
// Params 1, eflags: 0x0
// Checksum 0x4cf8d9fa, Offset: 0x5748
// Size: 0xc0
function function_4c53e7bf(localclientnum) {
    self endon(#"disconnect");
    while (isdefined(self) && isdefined(self.var_14351725) && isalive(self)) {
        if (self.var_14351725 > 0 && self.var_14351725 < 1) {
            self playsound(localclientnum, "veh_bullshark_missile_locking");
            wait((1 - self.var_14351725) * 0.5);
            continue;
        }
        wait(0.016);
    }
}

// Namespace namespace_786319bb
// Params 1, eflags: 0x0
// Checksum 0x2b73a533, Offset: 0x5810
// Size: 0xac
function function_14bb5165(localclientnum) {
    self.var_3b4d6693 = 0;
    self.var_dad0e5c1 = 1;
    self thread function_c0623e13(localclientnum);
    self useanimtree(#generic);
    self setanim(generic%v_aqu_vtol_engine_hover, 1, 0, 1);
    self setanim(generic%v_aqu_vtol_engine_idle, 1, 0, 1);
}

// Namespace namespace_786319bb
// Params 1, eflags: 0x0
// Checksum 0xf3792d7, Offset: 0x58c8
// Size: 0x18
function function_d996daca(localclientnum) {
    self.var_dad0e5c1 = 1;
}

// Namespace namespace_786319bb
// Params 1, eflags: 0x0
// Checksum 0x88242485, Offset: 0x58e8
// Size: 0xf14
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
        if (self.var_3b4d6693) {
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
        wait(0.016);
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

// Namespace namespace_786319bb
// Params 1, eflags: 0x0
// Checksum 0x4a30e53, Offset: 0x6808
// Size: 0x6ac
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
        wait(0.016);
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

// Namespace namespace_786319bb
// Params 1, eflags: 0x0
// Checksum 0x5ec62894, Offset: 0x6ec0
// Size: 0x2c
function function_863ee84(vel) {
    return length(vel) / 17.6;
}

// Namespace namespace_786319bb
// Params 2, eflags: 0x0
// Checksum 0xab33cdf8, Offset: 0x6ef8
// Size: 0x9c
function function_766878c8(localclientnum, str_type) {
    if (isdefined(self.var_62bb476b) && isdefined(self.var_62bb476b[localclientnum]) && isdefined(self.var_62bb476b[localclientnum][str_type]) && isarray(self.var_62bb476b[localclientnum][str_type]) && self.var_62bb476b[localclientnum][str_type].size > 0) {
        return true;
    }
    return false;
}

// Namespace namespace_786319bb
// Params 4, eflags: 0x0
// Checksum 0x433b498d, Offset: 0x6fa0
// Size: 0x1d6
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

// Namespace namespace_786319bb
// Params 3, eflags: 0x0
// Checksum 0x7d17e200, Offset: 0x7180
// Size: 0x190
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

// Namespace namespace_786319bb
// Params 6, eflags: 0x0
// Checksum 0xf150cb8, Offset: 0x7318
// Size: 0x13c
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

// Namespace namespace_786319bb
// Params 8, eflags: 0x0
// Checksum 0xd4fb2ec3, Offset: 0x7460
// Size: 0x1ac
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

// Namespace namespace_786319bb
// Params 0, eflags: 0x0
// Checksum 0x9e05c5, Offset: 0x7618
// Size: 0x11c
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

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0x5a9c2ae5, Offset: 0x7740
// Size: 0x5e
function function_af7432f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_dad0e5c1 = 1;
        return;
    }
    self.var_dad0e5c1 = undefined;
}

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0xede5de48, Offset: 0x77a8
// Size: 0x84
function function_34474782(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4780a11e = 1;
    if (newval == 1) {
        var_4780a11e = 2;
    }
    setworldfogactivebank(localclientnum, var_4780a11e);
}

// Namespace namespace_786319bb
// Params 7, eflags: 0x0
// Checksum 0xc41761ea, Offset: 0x7838
// Size: 0x84
function function_5240a6bb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4780a11e = 1;
    if (newval == 1) {
        var_4780a11e = 2;
    }
    setpbgactivebank(localclientnum, var_4780a11e);
}

