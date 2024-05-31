#using scripts/zm/zm_asylum_fx;
#using scripts/zm/zm_asylum_ffotd;
#using scripts/zm/_zm_trap_electric;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_perk_random;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/_zm_weap_tesla;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_radio;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/music_shared;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_f69b3b38;

// Namespace namespace_f69b3b38
// Params 0, eflags: 0x2
// namespace_f69b3b38<file_0>::function_d9af860b
// Checksum 0x19709fff, Offset: 0x6d0
// Size: 0x1c
function autoexec function_d9af860b() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
}

// Namespace namespace_f69b3b38
// Params 0, eflags: 0x1 linked
// namespace_f69b3b38<file_0>::function_d290ebfa
// Checksum 0x2eaa74fd, Offset: 0x6f8
// Size: 0x1bc
function main() {
    namespace_1e5daa72::main_start();
    level.default_game_mode = "zclassic";
    level.default_start_location = "default";
    function_b211e563();
    namespace_bf71ff59::main();
    visionset_mgr::register_visionset_info("zm_showerhead", 21000, 31, undefined, "zm_bloodwash_red");
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_showerhead_postfx", 21000, 32, "pstfx_blood_wash", 3);
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_waterfall_postfx", 21000, 32, "pstfx_shower_wash", 3);
    level._uses_sticky_grenades = 1;
    init_clientfields();
    load::main();
    namespace_570c8452::init();
    namespace_40b4687d::init();
    util::waitforclient(0);
    level thread function_d87a7dcc();
    level thread function_c9207335();
    level thread startzmbspawnersoundloops();
    println("int");
    namespace_1e5daa72::main_end();
}

// Namespace namespace_f69b3b38
// Params 0, eflags: 0x1 linked
// namespace_f69b3b38<file_0>::function_2ea898a8
// Checksum 0x217b1330, Offset: 0x8c0
// Size: 0xdc
function init_clientfields() {
    clientfield::register("world", "asylum_trap_fx_north", 21000, 1, "int", &namespace_bf71ff59::function_93f91575, 0, 0);
    clientfield::register("world", "asylum_trap_fx_south", 21000, 1, "int", &namespace_bf71ff59::function_4c17ba1b, 0, 0);
    clientfield::register("world", "asylum_generator_state", 21000, 1, "int", &function_d56a2c4b, 0, 0);
}

// Namespace namespace_f69b3b38
// Params 0, eflags: 0x1 linked
// namespace_f69b3b38<file_0>::function_b211e563
// Checksum 0x7fd86da, Offset: 0x9a8
// Size: 0x24
function function_b211e563() {
    include_weapons();
    namespace_570c8452::init();
}

// Namespace namespace_f69b3b38
// Params 0, eflags: 0x1 linked
// namespace_f69b3b38<file_0>::function_6e1af22d
// Checksum 0xa780ea69, Offset: 0x9d8
// Size: 0x24
function include_weapons() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_asylum_weapons.csv", 1);
}

// Namespace namespace_f69b3b38
// Params 0, eflags: 0x1 linked
// namespace_f69b3b38<file_0>::function_d87a7dcc
// Checksum 0xbae1fc32, Offset: 0xa08
// Size: 0xca
function function_d87a7dcc() {
    for (var_bd7ba30 = 0; true; var_bd7ba30 = 1) {
        if (!level clientfield::get("zombie_power_on")) {
            level.power_on = 0;
            if (var_bd7ba30) {
                level notify(#"hash_dc853f6c");
            }
            level util::waittill_any("power_on", "pwr", "ZPO");
        }
        level notify(#"hash_dc853f6c");
        level util::waittill_any("pwo", "ZPOff");
    }
}

// Namespace namespace_f69b3b38
// Params 7, eflags: 0x1 linked
// namespace_f69b3b38<file_0>::function_d56a2c4b
// Checksum 0x61fe4a2c, Offset: 0xae0
// Size: 0x88
function function_d56a2c4b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        level.var_c4ea7bb2 = 1;
        level thread function_21212316();
        return;
    }
    if (isdefined(level.var_c4ea7bb2) && level.var_c4ea7bb2) {
        level.var_c4ea7bb2 = 0;
    }
}

// Namespace namespace_f69b3b38
// Params 0, eflags: 0x1 linked
// namespace_f69b3b38<file_0>::function_21212316
// Checksum 0x43d15260, Offset: 0xb70
// Size: 0x58
function function_21212316() {
    while (level.var_c4ea7bb2) {
        wait(randomfloatrange(0.45, 0.85));
        playsound(0, "amb_elec_arc_generator", (-672, -264, 296));
    }
}

// Namespace namespace_f69b3b38
// Params 0, eflags: 0x1 linked
// namespace_f69b3b38<file_0>::function_c9207335
// Checksum 0x697cab3f, Offset: 0xbd0
// Size: 0x74
function function_c9207335() {
    wait(3);
    level thread function_d667714e();
    var_13a52dfe = getentarray(0, "sndMusicTrig", "targetname");
    array::thread_all(var_13a52dfe, &function_60a32834);
}

// Namespace namespace_f69b3b38
// Params 0, eflags: 0x1 linked
// namespace_f69b3b38<file_0>::function_60a32834
// Checksum 0xdab0934b, Offset: 0xc50
// Size: 0x94
function function_60a32834() {
    while (true) {
        trigplayer = self waittill(#"trigger");
        if (trigplayer islocalplayer()) {
            level notify(#"hash_51d7bc7c", self.script_sound);
            while (isdefined(trigplayer) && trigplayer istouching(self)) {
                wait(0.016);
            }
            continue;
        }
        wait(0.016);
    }
}

// Namespace namespace_f69b3b38
// Params 0, eflags: 0x1 linked
// namespace_f69b3b38<file_0>::function_d667714e
// Checksum 0x84694b1b, Offset: 0xcf0
// Size: 0xf8
function function_d667714e() {
    level.var_b6342abd = "mus_asylum_underscore_default";
    level.var_6d9d81aa = "mus_asylum_underscore_default";
    level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
    level.var_9433cf5a = level.var_eb526c90 playloopsound(level.var_b6342abd, 2);
    while (true) {
        location = level waittill(#"hash_51d7bc7c");
        level.var_6d9d81aa = "mus_asylum_underscore_" + location;
        if (level.var_6d9d81aa != level.var_b6342abd) {
            level thread function_b234849(level.var_6d9d81aa);
            level.var_b6342abd = level.var_6d9d81aa;
        }
    }
}

// Namespace namespace_f69b3b38
// Params 1, eflags: 0x1 linked
// namespace_f69b3b38<file_0>::function_b234849
// Checksum 0x3a920e5b, Offset: 0xdf0
// Size: 0x64
function function_b234849(var_6d9d81aa) {
    level endon(#"hash_51d7bc7c");
    level.var_eb526c90 stopallloopsounds(2);
    wait(1);
    level.var_9433cf5a = level.var_eb526c90 playloopsound(var_6d9d81aa, 2);
}

// Namespace namespace_f69b3b38
// Params 0, eflags: 0x1 linked
// namespace_f69b3b38<file_0>::function_d19cb2f8
// Checksum 0xcc7c49f1, Offset: 0xe60
// Size: 0x15c
function startzmbspawnersoundloops() {
    loopers = struct::get_array("exterior_goal", "targetname");
    if (isdefined(loopers) && loopers.size > 0) {
        delay = 0;
        /#
            if (getdvarint("int") > 0) {
                println("int" + loopers.size + "int");
            }
        #/
        for (i = 0; i < loopers.size; i++) {
            loopers[i] thread soundloopthink();
            delay += 1;
            if (delay % 20 == 0) {
                wait(0.016);
            }
        }
        return;
    }
    /#
        if (getdvarint("int") > 0) {
            println("int");
        }
    #/
}

// Namespace namespace_f69b3b38
// Params 0, eflags: 0x1 linked
// namespace_f69b3b38<file_0>::function_1f01c4b4
// Checksum 0x1d058adc, Offset: 0xfc8
// Size: 0x16c
function soundloopthink() {
    if (!isdefined(self.origin)) {
        return;
    }
    if (!isdefined(self.script_sound)) {
        self.script_sound = "zmb_spawn_walla";
    }
    notifyname = "";
    assert(isdefined(notifyname));
    if (isdefined(self.script_string)) {
        notifyname = self.script_string;
    }
    assert(isdefined(notifyname));
    started = 1;
    if (isdefined(self.script_int)) {
        started = self.script_int != 0;
    }
    if (started) {
        soundloopemitter(self.script_sound, self.origin);
    }
    if (notifyname != "") {
        for (;;) {
            level waittill(notifyname);
            if (started) {
                soundstoploopemitter(self.script_sound, self.origin);
            } else {
                soundloopemitter(self.script_sound, self.origin);
            }
            started = !started;
        }
    }
}

