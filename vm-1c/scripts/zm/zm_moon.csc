#using scripts/zm/zm_moon_ffotd;
#using scripts/zm/zm_moon_sq;
#using scripts/zm/zm_moon_gravity;
#using scripts/zm/zm_moon_fx;
#using scripts/zm/zm_moon_digger;
#using scripts/zm/zm_moon_amb;
#using scripts/zm/zm_moon;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_weap_quantum_bomb;
#using scripts/zm/_zm_weap_microwavegun;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_weap_black_hole_bomb;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_equip_gasmask;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_ai_quad;
#using scripts/zm/_zm_ai_dogs;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_3dc929b6;

// Namespace namespace_3dc929b6
// Params 0, eflags: 0x2
// Checksum 0xe5baea7e, Offset: 0x1970
// Size: 0x1c
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
}

// Namespace namespace_3dc929b6
// Params 0, eflags: 0x1 linked
// Checksum 0x9a028ac1, Offset: 0x1998
// Size: 0x294
function main() {
    level thread namespace_186add48::main_start();
    level.default_game_mode = "zclassic";
    level.default_start_location = "default";
    level._no_water_risers = 1;
    level.riser_fx_on_client = 1;
    level.var_73e65144 = 1;
    level.use_clientside_board_fx = 1;
    level.use_low_gravity_risers = 1;
    function_b211e563();
    function_20c21740();
    namespace_36389e13::main();
    level.var_c7aaf2b0 = "evt_vent_slat_repair";
    level.var_caed70fb = "evt_vent_slat_remove";
    level.var_606e6080 = &function_36f98292;
    level thread namespace_fd83f37::main();
    register_clientfields();
    namespace_fa702a65::init_clientfields();
    level.var_ff11ae70 = "zombie_moon_black_hole";
    level.setupcustomcharacterexerts = &setup_personality_character_exerts;
    callback::on_localclient_connect(&function_26f93f31);
    load::main();
    util::waitforclient(0);
    level thread namespace_98c95ca3::main();
    namespace_a9e990ad::init();
    level thread function_c4880303();
    level thread namespace_fa702a65::function_1975569c();
    level thread function_614979a8();
    level thread function_ff34e9f3();
    level thread function_d87a7dcc();
    level thread function_6ac83719();
    level thread function_73cc64f1(0);
    setdvar("dlc5_get_client_weapon_from_entitystate", 1);
    level thread namespace_186add48::main_end();
}

// Namespace namespace_3dc929b6
// Params 1, eflags: 0x1 linked
// Checksum 0x56fda7d8, Offset: 0x1c38
// Size: 0x14c
function function_73cc64f1(localclientnum) {
    level.var_98cd8f08 = [];
    level.var_98cd8f08[1] = "c_t7_zm_dlchd_moon_pressuresuit_dempsey_mpc";
    level.var_98cd8f08[2] = "c_t7_zm_dlchd_moon_pressuresuit_nikolai_mpc";
    level.var_98cd8f08[3] = "c_t7_zm_dlchd_moon_pressuresuit_richtofen_mpc";
    level.var_98cd8f08[4] = "c_t7_zm_dlchd_moon_pressuresuit_takeo_mpc";
    lock_model("c_t7_zm_dlchd_moon_pressuresuit_body_mpc");
    foreach (player in getplayers(localclientnum)) {
        player thread function_c06d0a4e(localclientnum);
    }
    callback::on_spawned(&function_c06d0a4e);
}

// Namespace namespace_3dc929b6
// Params 1, eflags: 0x1 linked
// Checksum 0xa9d234e6, Offset: 0x1d90
// Size: 0x8c
function function_c06d0a4e(localclientnum) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    while (isdefined(self) && !isdefined(self.player_exert_id)) {
        wait(1);
    }
    if (isdefined(self) && isdefined(self.player_exert_id)) {
        lock_model(level.var_98cd8f08[self.player_exert_id]);
    }
}

// Namespace namespace_3dc929b6
// Params 1, eflags: 0x1 linked
// Checksum 0x15ca7f1, Offset: 0x1e28
// Size: 0x92
function lock_model(model) {
    if (isdefined(model)) {
        if (!isdefined(level.model_locks)) {
            level.model_locks = [];
        }
        if (!isdefined(level.model_locks[model])) {
            level.model_locks[model] = 0;
        }
        if (level.model_locks[model] < 1) {
            forcestreamxmodel(model);
        }
        level.model_locks[model]++;
    }
}

// Namespace namespace_3dc929b6
// Params 1, eflags: 0x0
// Checksum 0x3369b572, Offset: 0x1ec8
// Size: 0x94
function unlock_model(model) {
    if (isdefined(model)) {
        if (!isdefined(level.model_locks)) {
            level.model_locks = [];
        }
        if (!isdefined(level.model_locks[model])) {
            level.model_locks[model] = 0;
        }
        level.model_locks[model]--;
        if (level.model_locks[model] < 1) {
            stopforcestreamingxmodel(model);
        }
    }
}

// Namespace namespace_3dc929b6
// Params 0, eflags: 0x1 linked
// Checksum 0xbe08ff66, Offset: 0x1f68
// Size: 0x14
function function_b211e563() {
    include_weapons();
}

// Namespace namespace_3dc929b6
// Params 0, eflags: 0x1 linked
// Checksum 0x4c528e2d, Offset: 0x1f88
// Size: 0x24
function include_weapons() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_moon_weapons.csv", 1);
}

// Namespace namespace_3dc929b6
// Params 0, eflags: 0x1 linked
// Checksum 0xb91c0843, Offset: 0x1fb8
// Size: 0x696
function register_clientfields() {
    clientfield::register("scriptmover", "digger_moving", 21000, 1, "int", &namespace_98c95ca3::function_4ec92a54, 0, 0);
    clientfield::register("scriptmover", "digger_digging", 21000, 1, "int", &namespace_98c95ca3::function_f0b2bcb7, 0, 0);
    clientfield::register("scriptmover", "digger_arm_fx", 21000, 1, "int", &namespace_98c95ca3::function_5567a905, 0, 0);
    clientfield::register("scriptmover", "dome_malfunction_pad", 21000, 1, "int", &function_caae511, 0, 0);
    clientfield::register("toplayer", "player_sky_transition", 21000, 1, "int", &function_16c2a574, 0, 0);
    clientfield::register("toplayer", "soul_swap", 21000, 1, "int", &namespace_fa702a65::function_538468b2, 0, 0);
    clientfield::register("toplayer", "gasp_rumble", 21000, 1, "int", &function_53c62160, 0, 0);
    clientfield::register("toplayer", "biodome_exploder", 21000, 1, "int", &function_947f06dd, 0, 0);
    clientfield::register("toplayer", "snd_lowgravity", 21000, 1, "int", &namespace_a9e990ad::function_20286238, 0, 0);
    clientfield::register("actor", "low_gravity", 21000, 1, "int", &namespace_a9e990ad::function_642dc173, 0, 0);
    clientfield::register("actor", "ctt", 21000, 1, "int", &namespace_fa702a65::function_86a718a9, 0, 0);
    clientfield::register("actor", "sd", 21000, 1, "int", &namespace_fa702a65::function_38a2773c, 0, 0);
    clientfield::register("world", "jump_pad_pulse", 21000, 3, "counter", &function_1cd5e7c6, 0, 0);
    clientfield::register("toplayer", "gas_mask_buy", 21000, 1, "counter", &function_7c00de2d, 0, 0);
    clientfield::register("toplayer", "gas_mask_on", 21000, 1, "counter", &function_29c0676c, 0, 0);
    clientfield::register("world", "show_earth", 21000, 1, "counter", &function_430ca813, 0, 0);
    clientfield::register("world", "show_destroyed_earth", 21000, 1, "counter", &function_fb238707, 0, 0);
    clientfield::register("world", "hide_earth", 21000, 1, "counter", &function_b1b35d8c, 0, 0);
    var_6225e4bb = tablelookuprowcount("gamedata/tables/zm/zm_astro_names.csv");
    if (isdefined(var_6225e4bb) && var_6225e4bb > 0) {
        clientfield::register("actor", "astro_name_index", 21000, getminbitcountfornum(var_6225e4bb + 1), "int", &function_ff7d3b7, 0, 0);
    }
    clientfield::register("scriptmover", "zombie_has_eyes", 21000, 1, "int", &zm::zombie_eyes_clientfield_cb, 0, 0);
    clientfield::register("clientuimodel", "hudItems.showDpadDown_HackTool", 21000, 1, "int", undefined, 0, 0);
    for (i = 0; i < 4; i++) {
        registerclientfield("world", "player" + i + "wearableItem", 21000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0);
    }
}

// Namespace namespace_3dc929b6
// Params 0, eflags: 0x1 linked
// Checksum 0x63ce4650, Offset: 0x2658
// Size: 0x3f4
function function_20c21740() {
    clientfield::register("world", "BIO", 21000, 1, "int", &namespace_98c95ca3::function_a0cf54a0, 0, 0);
    clientfield::register("world", "DH", 21000, 1, "int", &namespace_98c95ca3::function_245b13ce, 0, 0);
    clientfield::register("world", "TCA", 21000, 1, "int", &namespace_98c95ca3::function_774edb15, 0, 0);
    clientfield::register("world", "HCA", 21000, 1, "int", &namespace_98c95ca3::function_774edb15, 0, 0);
    clientfield::register("world", "BCA", 21000, 1, "int", &namespace_98c95ca3::function_774edb15, 0, 0);
    clientfield::register("world", "Az1", 21000, 1, "counter", &namespace_fd83f37::function_6ce4d731, 0, 0);
    clientfield::register("world", "Az2a", 21000, 1, "counter", &namespace_fd83f37::function_6ce4d731, 0, 0);
    clientfield::register("world", "Az2b", 21000, 1, "counter", &namespace_fd83f37::function_6ce4d731, 0, 0);
    clientfield::register("world", "Az3a", 21000, 1, "counter", &namespace_fd83f37::function_6ce4d731, 0, 0);
    clientfield::register("world", "Az3b", 21000, 1, "counter", &namespace_fd83f37::function_6ce4d731, 0, 0);
    clientfield::register("world", "Az3c", 21000, 1, "counter", &namespace_fd83f37::function_6ce4d731, 0, 0);
    clientfield::register("world", "Az4a", 21000, 1, "counter", &namespace_fd83f37::function_6ce4d731, 0, 0);
    clientfield::register("world", "Az4b", 21000, 1, "counter", &namespace_fd83f37::function_6ce4d731, 0, 0);
    clientfield::register("world", "Az5", 21000, 1, "counter", &namespace_fd83f37::function_6ce4d731, 0, 0);
}

// Namespace namespace_3dc929b6
// Params 1, eflags: 0x0
// Checksum 0xcc6fdd93, Offset: 0x2a58
// Size: 0x9e
function function_e80f1a40(var_cb15dba5) {
    while (!self hasdobj(var_cb15dba5)) {
        wait(0.05);
    }
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        if (self == players[i]) {
            self clearalternateaimparams();
        }
    }
}

// Namespace namespace_3dc929b6
// Params 0, eflags: 0x1 linked
// Checksum 0xc42e6bc8, Offset: 0x2b00
// Size: 0x86
function function_c4880303() {
    var_63463246 = getentarray(0, "zombie_cosmodrome_radar_dish", "targetname");
    if (isdefined(var_63463246)) {
        for (i = 0; i < var_63463246.size; i++) {
            var_63463246[i] thread function_6f89184c();
        }
    }
}

// Namespace namespace_3dc929b6
// Params 0, eflags: 0x1 linked
// Checksum 0x24bd4498, Offset: 0x2b90
// Size: 0x5c
function function_6f89184c() {
    wait(0.1);
    while (true) {
        self rotateyaw(360, randomfloatrange(60, 120));
        self waittill(#"rotatedone");
    }
}

// Namespace namespace_3dc929b6
// Params 0, eflags: 0x1 linked
// Checksum 0x88f9fbcf, Offset: 0x2bf8
// Size: 0x9e
function function_ff34e9f3() {
    util::waitforallclients();
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        players[i] thread function_da3bb356(i);
        players[i] thread function_8ba4cdc6(i);
    }
}

// Namespace namespace_3dc929b6
// Params 1, eflags: 0x1 linked
// Checksum 0xf3f48142, Offset: 0x2ca0
// Size: 0x146
function function_da3bb356(localclientnum) {
    level waittill(#"power_on");
    doors = getentarray(localclientnum, "receiving_bay_doors", "targetname");
    for (i = 0; i < doors.size; i++) {
        if (isdefined(doors[i].script_vector)) {
            doors[i] playsound(0, "evt_loading_door_start");
            doors[i] playloopsound("evt_loading_door_loop", 0.5);
            doors[i] moveto(doors[i].origin + doors[i].script_vector, 3);
            doors[i] thread function_3aefc455();
        }
    }
}

// Namespace namespace_3dc929b6
// Params 0, eflags: 0x1 linked
// Checksum 0x2a4ad90c, Offset: 0x2df0
// Size: 0x4c
function function_3aefc455() {
    wait(2.6);
    self stoploopsound(0.5);
    self playsound(0, "evt_loading_door_end");
}

// Namespace namespace_3dc929b6
// Params 1, eflags: 0x1 linked
// Checksum 0x85f74c7b, Offset: 0x2e48
// Size: 0xd6
function function_8ba4cdc6(localclientnum) {
    screens = getentarray(localclientnum, "moon_comp_screens", "targetname");
    for (i = 0; i < screens.size; i++) {
        screens[i] hide();
    }
    level waittill(#"power_on");
    for (i = 0; i < screens.size; i++) {
        screens[i] show();
    }
}

// Namespace namespace_3dc929b6
// Params 1, eflags: 0x1 linked
// Checksum 0xdfa830c, Offset: 0x2f28
// Size: 0x94
function function_26f93f31(clientnum) {
    level function_c00b8efb(clientnum);
    wait(0.016);
    if (!level clientfield::get("zombie_power_on")) {
        level util::waittill_any("power_on", "pwr", "ZPO");
    }
    function_9cb39753(clientnum);
}

// Namespace namespace_3dc929b6
// Params 1, eflags: 0x1 linked
// Checksum 0xee57f24b, Offset: 0x2fc8
// Size: 0x16a
function function_c00b8efb(clientnum) {
    player = getlocalplayers()[clientnum];
    if (!isdefined(player)) {
        return;
    }
    var_e3a2cc12 = getentarray(clientnum, "jump_pads", "targetname");
    foreach (var_f5f4e9cc in var_e3a2cc12) {
        if (isdefined(var_f5f4e9cc.script_noteworthy)) {
            var_f5f4e9cc util::waittill_dobj(clientnum);
            var_f5f4e9cc useanimtree(#generic);
            var_f5f4e9cc animscripted("jump_pad", var_f5f4e9cc.origin, var_f5f4e9cc.angles, "p7_fxanim_zmhd_moon_jump_pad_lrg_anim");
        }
    }
}

// Namespace namespace_3dc929b6
// Params 7, eflags: 0x1 linked
// Checksum 0xf8701513, Offset: 0x3140
// Size: 0x14a
function function_1cd5e7c6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    var_e3a2cc12 = getentarray(localclientnum, "jump_pads", "targetname");
    foreach (var_f5f4e9cc in var_e3a2cc12) {
        if (var_f5f4e9cc.script_int == newval) {
            var_f5f4e9cc util::waittill_dobj(localclientnum);
            playfxontag(localclientnum, level._effect["jump_pad_jump"], var_f5f4e9cc, "tag_origin");
        }
    }
}

// Namespace namespace_3dc929b6
// Params 7, eflags: 0x1 linked
// Checksum 0x65e75cca, Offset: 0x3298
// Size: 0x64
function function_7c00de2d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    playsound(localclientnum, "evt_gasmask_suit_on", self.origin);
}

// Namespace namespace_3dc929b6
// Params 7, eflags: 0x1 linked
// Checksum 0x39d4ae0e, Offset: 0x3308
// Size: 0x64
function function_29c0676c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    playsound(localclientnum, "evt_gasmask_on_v2", self.origin);
}

// Namespace namespace_3dc929b6
// Params 1, eflags: 0x1 linked
// Checksum 0xe27ef74b, Offset: 0x3378
// Size: 0x102
function function_9cb39753(var_4717c7a9) {
    player = getlocalplayers()[var_4717c7a9];
    if (!isdefined(player)) {
        return;
    }
    var_a383038e = getentarray(var_4717c7a9, "jump_pads", "targetname");
    if (isdefined(var_a383038e) && var_a383038e.size > 0) {
        for (i = 0; i < var_a383038e.size; i++) {
            var_a383038e[i]._glow = playfxontag(var_4717c7a9, level._effect["jump_pad_active"], var_a383038e[i], "tag_origin");
        }
    }
}

// Namespace namespace_3dc929b6
// Params 7, eflags: 0x1 linked
// Checksum 0x74e26108, Offset: 0x3488
// Size: 0x55a
function function_caae511(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (localclientnum != 0) {
        return;
    }
    if (newval) {
        player = getlocalplayers()[localclientnum];
        if (!isdefined(player)) {
            return;
        }
        for (x = 0; x < level.localplayers.size; x++) {
            var_8726aeb3 = undefined;
            closest = 999999;
            var_4338dcb2 = getentarray(x, "jump_pads", "targetname");
            for (i = 0; i < var_4338dcb2.size; i++) {
                pad = var_4338dcb2[i];
                dist = distance2d(self.origin, pad.origin);
                if (dist < closest) {
                    var_8726aeb3 = pad;
                    closest = dist;
                }
            }
            if (isdefined(var_8726aeb3._glow)) {
                rand = randomintrange(4, 7);
                for (i = 0; i < rand; i++) {
                    stopfx(x, var_8726aeb3._glow);
                    wait(randomfloatrange(0.05, 0.15));
                    var_8726aeb3 playsound(0, "evt_electrical_surge");
                    var_8726aeb3._glow = playfxontag(x, level._effect["jump_pad_active"], var_8726aeb3, "tag_origin");
                    wait(randomfloatrange(0.05, 0.15));
                }
                stopfx(x, var_8726aeb3._glow);
            }
        }
        return;
    }
    player = getlocalplayers()[localclientnum];
    if (!isdefined(player)) {
        return;
    }
    for (x = 0; x < level.localplayers.size; x++) {
        var_8726aeb3 = undefined;
        closest = 999999;
        var_4338dcb2 = getentarray(x, "jump_pads", "targetname");
        for (i = 0; i < var_4338dcb2.size; i++) {
            pad = var_4338dcb2[i];
            dist = distance2d(self.origin, pad.origin);
            if (dist < closest) {
                var_8726aeb3 = pad;
                closest = dist;
            }
        }
        if (isdefined(var_8726aeb3._glow)) {
            rand = randomintrange(4, 7);
            for (i = 0; i < rand; i++) {
                var_8726aeb3 playsound(0, "evt_electrical_surge");
                var_8726aeb3._glow = playfxontag(x, level._effect["jump_pad_active"], var_8726aeb3, "tag_origin");
                wait(randomfloatrange(0.05, 0.15));
                stopfx(x, var_8726aeb3._glow);
                wait(randomfloatrange(0.05, 0.15));
            }
            var_8726aeb3._glow = playfxontag(x, level._effect["jump_pad_active"], var_8726aeb3, "tag_origin");
        }
    }
}

// Namespace namespace_3dc929b6
// Params 7, eflags: 0x1 linked
// Checksum 0xb508f66d, Offset: 0x39f0
// Size: 0xe4
function function_53c62160(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (!self islocalplayer()) {
        return;
    }
    if (!isdefined(self getlocalclientnumber())) {
        return;
    }
    if (newval) {
        if (randomint(100) > 70) {
            self playrumbleonentity(localclientnum, "damage_light");
            return;
        }
        self playrumbleonentity(localclientnum, "damage_heavy");
    }
}

// Namespace namespace_3dc929b6
// Params 7, eflags: 0x1 linked
// Checksum 0x9f5a3dfe, Offset: 0x3ae0
// Size: 0x166
function function_430ca813(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    for (i = 0; i < level.localplayers.size; i++) {
        player = getlocalplayers()[i];
        if (!isdefined(player)) {
            continue;
        }
        if (!isdefined(player._earth)) {
            player._earth = spawn(i, (-22060.8, -121800, 34463.4), "script_model", 1);
            player._earth.angles = (18, 78, 22);
            player._earth setmodel("p7_zm_moo_earth");
        }
        player._earth show();
    }
}

// Namespace namespace_3dc929b6
// Params 7, eflags: 0x1 linked
// Checksum 0xc12c7cd, Offset: 0x3c50
// Size: 0xce
function function_b1b35d8c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    for (i = 0; i < level.localplayers.size; i++) {
        player = getlocalplayers()[i];
        if (!isdefined(player)) {
            continue;
        }
        if (isdefined(player._earth)) {
            player._earth hide();
        }
    }
}

// Namespace namespace_3dc929b6
// Params 7, eflags: 0x1 linked
// Checksum 0x383ef2d6, Offset: 0x3d28
// Size: 0xd6
function function_fb238707(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    for (i = 0; i < level.localplayers.size; i++) {
        player = getlocalplayers()[i];
        if (!isdefined(player)) {
            continue;
        }
        if (isdefined(player._earth)) {
            player._earth setmodel("p7_zm_moo_earth_dest");
        }
    }
}

// Namespace namespace_3dc929b6
// Params 0, eflags: 0x1 linked
// Checksum 0xa2d3ff63, Offset: 0x3e08
// Size: 0x30
function function_614979a8() {
    while (true) {
        level waittill(#"hash_1ae77d06");
        level thread function_ea07a038();
    }
}

// Namespace namespace_3dc929b6
// Params 0, eflags: 0x1 linked
// Checksum 0x584f8757, Offset: 0x3e40
// Size: 0x96
function function_ea07a038() {
    for (i = 0; i < level.localplayers.size; i++) {
        player = getlocalplayers()[i];
        if (!isdefined(player)) {
            continue;
        }
        if (isdefined(player._earth)) {
            player._earth delete();
        }
    }
}

// Namespace namespace_3dc929b6
// Params 0, eflags: 0x1 linked
// Checksum 0x62ed1fd7, Offset: 0x3ee0
// Size: 0xba
function function_d87a7dcc() {
    for (var_bd7ba30 = 0; true; var_bd7ba30 = 1) {
        if (!level clientfield::get("zombie_power_on")) {
            if (var_bd7ba30) {
                level notify(#"hash_dc853f6c");
            }
            level util::waittill_any("power_on", "pwr", "ZPO");
        }
        level notify(#"hash_dc853f6c");
        level util::waittill_any("pwo", "ZPOff");
    }
}

// Namespace namespace_3dc929b6
// Params 7, eflags: 0x1 linked
// Checksum 0x3c686302, Offset: 0x3fa8
// Size: 0x7c
function function_947f06dd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        exploder::exploder("lgt_dome_int");
        return;
    }
    exploder::stop_exploder("lgt_dome_int");
}

// Namespace namespace_3dc929b6
// Params 7, eflags: 0x1 linked
// Checksum 0x3d7c0261, Offset: 0x4030
// Size: 0x12c
function function_16c2a574(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (!self islocalplayer()) {
        return;
    }
    if (!isdefined(self getlocalclientnumber())) {
        return;
    }
    if (newval) {
        if (isdefined(level.var_abc92c08)) {
            visionset_mgr::function_a95252c1("_on");
            level thread function_fbf77a74(localclientnum);
        } else {
            visionset_mgr::function_a95252c1("_off");
        }
        return;
    }
    visionset_mgr::function_a95252c1("");
    level notify(#"hash_d2b77ba2");
    setukkoscriptindex(localclientnum, 1, 1);
}

// Namespace namespace_3dc929b6
// Params 1, eflags: 0x1 linked
// Checksum 0x777ce4ff, Offset: 0x4168
// Size: 0x99a
function function_fbf77a74(localclientnum) {
    self endon(#"hash_d2b77ba2");
    while (true) {
        var_f4570d42 = randomint(5);
        switch (var_f4570d42) {
        case 0:
            setukkoscriptindex(localclientnum, 2, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 3, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 4, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 5, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 4, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 3, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 4, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 3, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 4, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 6, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 4, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 5, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 6, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 7, 1);
            wait(0.05);
            break;
        case 1:
            setukkoscriptindex(localclientnum, 8, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 9, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 10, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 11, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 10, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 11, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 12, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 13, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 14, 1);
            wait(0.1);
            break;
        case 2:
            setukkoscriptindex(localclientnum, 15, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 16, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 17, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 18, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 19, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 20, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 21, 1);
            wait(0.1);
            break;
        case 3:
            setukkoscriptindex(localclientnum, 22, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 23, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 24, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 25, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 26, 1);
            wait(0.1);
            break;
        case 4:
            setukkoscriptindex(localclientnum, 29, 1);
            wait(0.15);
            setukkoscriptindex(localclientnum, 30, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 29, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 31, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 30, 1);
            wait(0.15);
            setukkoscriptindex(localclientnum, 29, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 30, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 29, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 31, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 27, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 28, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 29, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 30, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 29, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 31, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 30, 1);
            wait(0.15);
            setukkoscriptindex(localclientnum, 29, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 30, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 29, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 31, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 32, 1);
            wait(0.05);
            break;
        default:
            break;
        }
        setukkoscriptindex(localclientnum, 1, 1);
        n_wait_time = randomintrange(2, 4);
        wait(n_wait_time);
    }
}

// Namespace namespace_3dc929b6
// Params 0, eflags: 0x1 linked
// Checksum 0xff0302a0, Offset: 0x4b10
// Size: 0x24
function function_36f98292() {
    self rotateroll(-76, 0.5);
}

// Namespace namespace_3dc929b6
// Params 7, eflags: 0x1 linked
// Checksum 0x1eb83d6e, Offset: 0x4b40
// Size: 0x8c
function function_ff7d3b7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    var_28a1ce70 = tablelookup("gamedata/tables/zm/zm_astro_names.csv", 0, newval - 1, 1);
    self setdrawname(var_28a1ce70);
}

// Namespace namespace_3dc929b6
// Params 0, eflags: 0x1 linked
// Checksum 0x49beebd, Offset: 0x4bd8
// Size: 0xdc
function function_6ac83719() {
    visionset_mgr::function_980ca37e("zombie_moonHanger18", 2);
    visionset_mgr::function_a95252c1("_off");
    visionset_mgr::function_3aea3c1a(1, "zombie_moonHanger18");
    visionset_mgr::function_3aea3c1a(2, "zombie_moonExterior");
    visionset_mgr::function_3aea3c1a(3, "zombie_moonTunnels");
    visionset_mgr::function_3aea3c1a(4, "zombie_moonInterior");
    visionset_mgr::function_3aea3c1a(5, "zombie_moonBioDome");
}

// Namespace namespace_3dc929b6
// Params 0, eflags: 0x1 linked
// Checksum 0x257eb70, Offset: 0x4cc0
// Size: 0x1482
function setup_personality_character_exerts() {
    level.exert_sounds[1]["playerbreathinsound"][0] = "vox_plr_0_exert_inhale_0";
    level.exert_sounds[1]["playerbreathinsound"][1] = "vox_plr_0_exert_inhale_1";
    level.exert_sounds[1]["playerbreathinsound"][2] = "vox_plr_0_exert_inhale_2";
    level.exert_sounds[2]["playerbreathinsound"][0] = "vox_plr_1_exert_inhale_0";
    level.exert_sounds[2]["playerbreathinsound"][1] = "vox_plr_1_exert_inhale_1";
    level.exert_sounds[2]["playerbreathinsound"][2] = "vox_plr_1_exert_inhale_2";
    level.exert_sounds[3]["playerbreathinsound"][0] = "vox_plr_2_exert_inhale_0";
    level.exert_sounds[3]["playerbreathinsound"][1] = "vox_plr_2_exert_inhale_1";
    level.exert_sounds[3]["playerbreathinsound"][2] = "vox_plr_2_exert_inhale_2";
    level.exert_sounds[4]["playerbreathinsound"][0] = "vox_plr_3_exert_inhale_0";
    level.exert_sounds[4]["playerbreathinsound"][1] = "vox_plr_3_exert_inhale_1";
    level.exert_sounds[4]["playerbreathinsound"][2] = "vox_plr_3_exert_inhale_2";
    level.exert_sounds[1]["playerbreathoutsound"][0] = "vox_plr_0_exert_exhale_0";
    level.exert_sounds[1]["playerbreathoutsound"][1] = "vox_plr_0_exert_exhale_1";
    level.exert_sounds[1]["playerbreathoutsound"][2] = "vox_plr_0_exert_exhale_2";
    level.exert_sounds[2]["playerbreathoutsound"][0] = "vox_plr_1_exert_exhale_0";
    level.exert_sounds[2]["playerbreathoutsound"][1] = "vox_plr_1_exert_exhale_1";
    level.exert_sounds[2]["playerbreathoutsound"][2] = "vox_plr_1_exert_exhale_2";
    level.exert_sounds[3]["playerbreathoutsound"][0] = "vox_plr_2_exert_exhale_0";
    level.exert_sounds[3]["playerbreathoutsound"][1] = "vox_plr_2_exert_exhale_1";
    level.exert_sounds[3]["playerbreathoutsound"][2] = "vox_plr_2_exert_exhale_2";
    level.exert_sounds[4]["playerbreathoutsound"][0] = "vox_plr_3_exert_exhale_0";
    level.exert_sounds[4]["playerbreathoutsound"][1] = "vox_plr_3_exert_exhale_1";
    level.exert_sounds[4]["playerbreathoutsound"][2] = "vox_plr_3_exert_exhale_2";
    level.exert_sounds[1]["playerbreathgaspsound"][0] = "vox_plr_0_exert_exhale_0";
    level.exert_sounds[1]["playerbreathgaspsound"][1] = "vox_plr_0_exert_exhale_1";
    level.exert_sounds[1]["playerbreathgaspsound"][2] = "vox_plr_0_exert_exhale_2";
    level.exert_sounds[2]["playerbreathgaspsound"][0] = "vox_plr_1_exert_exhale_0";
    level.exert_sounds[2]["playerbreathgaspsound"][1] = "vox_plr_1_exert_exhale_1";
    level.exert_sounds[2]["playerbreathgaspsound"][2] = "vox_plr_1_exert_exhale_2";
    level.exert_sounds[3]["playerbreathgaspsound"][0] = "vox_plr_2_exert_exhale_0";
    level.exert_sounds[3]["playerbreathgaspsound"][1] = "vox_plr_2_exert_exhale_1";
    level.exert_sounds[3]["playerbreathgaspsound"][2] = "vox_plr_2_exert_exhale_2";
    level.exert_sounds[4]["playerbreathgaspsound"][0] = "vox_plr_3_exert_exhale_0";
    level.exert_sounds[4]["playerbreathgaspsound"][1] = "vox_plr_3_exert_exhale_1";
    level.exert_sounds[4]["playerbreathgaspsound"][2] = "vox_plr_3_exert_exhale_2";
    level.exert_sounds[1]["falldamage"][0] = "vox_plr_0_exert_pain_low_0";
    level.exert_sounds[1]["falldamage"][1] = "vox_plr_0_exert_pain_low_1";
    level.exert_sounds[1]["falldamage"][2] = "vox_plr_0_exert_pain_low_2";
    level.exert_sounds[1]["falldamage"][3] = "vox_plr_0_exert_pain_low_3";
    level.exert_sounds[1]["falldamage"][4] = "vox_plr_0_exert_pain_low_4";
    level.exert_sounds[1]["falldamage"][5] = "vox_plr_0_exert_pain_low_5";
    level.exert_sounds[1]["falldamage"][6] = "vox_plr_0_exert_pain_low_6";
    level.exert_sounds[1]["falldamage"][7] = "vox_plr_0_exert_pain_low_7";
    level.exert_sounds[2]["falldamage"][0] = "vox_plr_1_exert_pain_low_0";
    level.exert_sounds[2]["falldamage"][1] = "vox_plr_1_exert_pain_low_1";
    level.exert_sounds[2]["falldamage"][2] = "vox_plr_1_exert_pain_low_2";
    level.exert_sounds[2]["falldamage"][3] = "vox_plr_1_exert_pain_low_3";
    level.exert_sounds[2]["falldamage"][4] = "vox_plr_1_exert_pain_low_4";
    level.exert_sounds[2]["falldamage"][5] = "vox_plr_1_exert_pain_low_5";
    level.exert_sounds[2]["falldamage"][6] = "vox_plr_1_exert_pain_low_6";
    level.exert_sounds[2]["falldamage"][7] = "vox_plr_1_exert_pain_low_7";
    level.exert_sounds[3]["falldamage"][0] = "vox_plr_2_exert_pain_low_0";
    level.exert_sounds[3]["falldamage"][1] = "vox_plr_2_exert_pain_low_1";
    level.exert_sounds[3]["falldamage"][2] = "vox_plr_2_exert_pain_low_2";
    level.exert_sounds[3]["falldamage"][3] = "vox_plr_2_exert_pain_low_3";
    level.exert_sounds[3]["falldamage"][4] = "vox_plr_2_exert_pain_low_4";
    level.exert_sounds[3]["falldamage"][5] = "vox_plr_2_exert_pain_low_5";
    level.exert_sounds[3]["falldamage"][6] = "vox_plr_2_exert_pain_low_6";
    level.exert_sounds[3]["falldamage"][7] = "vox_plr_2_exert_pain_low_7";
    level.exert_sounds[4]["falldamage"][0] = "vox_plr_3_exert_pain_low_0";
    level.exert_sounds[4]["falldamage"][1] = "vox_plr_3_exert_pain_low_1";
    level.exert_sounds[4]["falldamage"][2] = "vox_plr_3_exert_pain_low_2";
    level.exert_sounds[4]["falldamage"][3] = "vox_plr_3_exert_pain_low_3";
    level.exert_sounds[4]["falldamage"][4] = "vox_plr_3_exert_pain_low_4";
    level.exert_sounds[4]["falldamage"][5] = "vox_plr_3_exert_pain_low_5";
    level.exert_sounds[4]["falldamage"][6] = "vox_plr_3_exert_pain_low_6";
    level.exert_sounds[4]["falldamage"][7] = "vox_plr_3_exert_pain_low_7";
    level.exert_sounds[1]["mantlesoundplayer"][0] = "vox_plr_0_exert_grunt_0";
    level.exert_sounds[1]["mantlesoundplayer"][1] = "vox_plr_0_exert_grunt_1";
    level.exert_sounds[1]["mantlesoundplayer"][2] = "vox_plr_0_exert_grunt_2";
    level.exert_sounds[1]["mantlesoundplayer"][3] = "vox_plr_0_exert_grunt_3";
    level.exert_sounds[1]["mantlesoundplayer"][4] = "vox_plr_0_exert_grunt_4";
    level.exert_sounds[1]["mantlesoundplayer"][5] = "vox_plr_0_exert_grunt_5";
    level.exert_sounds[1]["mantlesoundplayer"][6] = "vox_plr_0_exert_grunt_6";
    level.exert_sounds[2]["mantlesoundplayer"][0] = "vox_plr_1_exert_grunt_0";
    level.exert_sounds[2]["mantlesoundplayer"][1] = "vox_plr_1_exert_grunt_1";
    level.exert_sounds[2]["mantlesoundplayer"][2] = "vox_plr_1_exert_grunt_2";
    level.exert_sounds[2]["mantlesoundplayer"][3] = "vox_plr_1_exert_grunt_3";
    level.exert_sounds[2]["mantlesoundplayer"][4] = "vox_plr_1_exert_grunt_4";
    level.exert_sounds[2]["mantlesoundplayer"][5] = "vox_plr_1_exert_grunt_5";
    level.exert_sounds[3]["mantlesoundplayer"][0] = "vox_plr_2_exert_grunt_0";
    level.exert_sounds[3]["mantlesoundplayer"][1] = "vox_plr_2_exert_grunt_1";
    level.exert_sounds[3]["mantlesoundplayer"][2] = "vox_plr_2_exert_grunt_2";
    level.exert_sounds[3]["mantlesoundplayer"][3] = "vox_plr_2_exert_grunt_3";
    level.exert_sounds[3]["mantlesoundplayer"][4] = "vox_plr_2_exert_grunt_4";
    level.exert_sounds[3]["mantlesoundplayer"][5] = "vox_plr_2_exert_grunt_5";
    level.exert_sounds[3]["mantlesoundplayer"][6] = "vox_plr_2_exert_grunt_6";
    level.exert_sounds[4]["mantlesoundplayer"][0] = "vox_plr_3_exert_grunt_0";
    level.exert_sounds[4]["mantlesoundplayer"][1] = "vox_plr_3_exert_grunt_1";
    level.exert_sounds[4]["mantlesoundplayer"][2] = "vox_plr_3_exert_grunt_2";
    level.exert_sounds[4]["mantlesoundplayer"][3] = "vox_plr_3_exert_grunt_4";
    level.exert_sounds[4]["mantlesoundplayer"][4] = "vox_plr_3_exert_grunt_5";
    level.exert_sounds[4]["mantlesoundplayer"][5] = "vox_plr_3_exert_grunt_6";
    level.exert_sounds[1]["meleeswipesoundplayer"][0] = "vox_plr_0_exert_knife_swipe_0";
    level.exert_sounds[1]["meleeswipesoundplayer"][1] = "vox_plr_0_exert_knife_swipe_1";
    level.exert_sounds[1]["meleeswipesoundplayer"][2] = "vox_plr_0_exert_knife_swipe_2";
    level.exert_sounds[1]["meleeswipesoundplayer"][3] = "vox_plr_0_exert_knife_swipe_3";
    level.exert_sounds[1]["meleeswipesoundplayer"][4] = "vox_plr_0_exert_knife_swipe_4";
    level.exert_sounds[1]["meleeswipesoundplayer"][5] = "vox_plr_0_exert_knife_swipe_5";
    level.exert_sounds[2]["meleeswipesoundplayer"][0] = "vox_plr_1_exert_knife_swipe_0";
    level.exert_sounds[2]["meleeswipesoundplayer"][1] = "vox_plr_1_exert_knife_swipe_1";
    level.exert_sounds[2]["meleeswipesoundplayer"][2] = "vox_plr_1_exert_knife_swipe_2";
    level.exert_sounds[2]["meleeswipesoundplayer"][3] = "vox_plr_1_exert_knife_swipe_3";
    level.exert_sounds[2]["meleeswipesoundplayer"][4] = "vox_plr_1_exert_knife_swipe_4";
    level.exert_sounds[2]["meleeswipesoundplayer"][5] = "vox_plr_1_exert_knife_swipe_5";
    level.exert_sounds[3]["meleeswipesoundplayer"][0] = "vox_plr_2_exert_knife_swipe_0";
    level.exert_sounds[3]["meleeswipesoundplayer"][1] = "vox_plr_2_exert_knife_swipe_1";
    level.exert_sounds[3]["meleeswipesoundplayer"][2] = "vox_plr_2_exert_knife_swipe_2";
    level.exert_sounds[3]["meleeswipesoundplayer"][3] = "vox_plr_2_exert_knife_swipe_3";
    level.exert_sounds[3]["meleeswipesoundplayer"][4] = "vox_plr_2_exert_knife_swipe_4";
    level.exert_sounds[3]["meleeswipesoundplayer"][5] = "vox_plr_2_exert_knife_swipe_5";
    level.exert_sounds[4]["meleeswipesoundplayer"][0] = "vox_plr_3_exert_knife_swipe_0";
    level.exert_sounds[4]["meleeswipesoundplayer"][1] = "vox_plr_3_exert_knife_swipe_1";
    level.exert_sounds[4]["meleeswipesoundplayer"][2] = "vox_plr_3_exert_knife_swipe_2";
    level.exert_sounds[4]["meleeswipesoundplayer"][3] = "vox_plr_3_exert_knife_swipe_3";
    level.exert_sounds[4]["meleeswipesoundplayer"][4] = "vox_plr_3_exert_knife_swipe_4";
    level.exert_sounds[4]["meleeswipesoundplayer"][5] = "vox_plr_3_exert_knife_swipe_5";
    level.exert_sounds[1]["dtplandsoundplayer"][0] = "vox_plr_0_exert_pain_medium_0";
    level.exert_sounds[1]["dtplandsoundplayer"][1] = "vox_plr_0_exert_pain_medium_1";
    level.exert_sounds[1]["dtplandsoundplayer"][2] = "vox_plr_0_exert_pain_medium_2";
    level.exert_sounds[1]["dtplandsoundplayer"][3] = "vox_plr_0_exert_pain_medium_3";
    level.exert_sounds[2]["dtplandsoundplayer"][0] = "vox_plr_1_exert_pain_medium_0";
    level.exert_sounds[2]["dtplandsoundplayer"][1] = "vox_plr_1_exert_pain_medium_1";
    level.exert_sounds[2]["dtplandsoundplayer"][2] = "vox_plr_1_exert_pain_medium_2";
    level.exert_sounds[2]["dtplandsoundplayer"][3] = "vox_plr_1_exert_pain_medium_3";
    level.exert_sounds[3]["dtplandsoundplayer"][0] = "vox_plr_2_exert_pain_medium_0";
    level.exert_sounds[3]["dtplandsoundplayer"][1] = "vox_plr_2_exert_pain_medium_1";
    level.exert_sounds[3]["dtplandsoundplayer"][2] = "vox_plr_2_exert_pain_medium_2";
    level.exert_sounds[3]["dtplandsoundplayer"][3] = "vox_plr_2_exert_pain_medium_3";
    level.exert_sounds[4]["dtplandsoundplayer"][0] = "vox_plr_3_exert_pain_medium_0";
    level.exert_sounds[4]["dtplandsoundplayer"][1] = "vox_plr_3_exert_pain_medium_1";
    level.exert_sounds[4]["dtplandsoundplayer"][2] = "vox_plr_3_exert_pain_medium_2";
    level.exert_sounds[4]["dtplandsoundplayer"][3] = "vox_plr_3_exert_pain_medium_3";
}

