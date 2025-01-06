#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_ai_dogs;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_trap_electric;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_tesla;
#using scripts/zm/_zm_weapons;
#using scripts/zm/zm_factory_amb;
#using scripts/zm/zm_factory_ffotd;
#using scripts/zm/zm_factory_fx;
#using scripts/zm/zm_factory_teleporter;

#namespace zm_factory;

// Namespace zm_factory
// Params 0, eflags: 0x2
// Checksum 0xebeac76e, Offset: 0x1060
// Size: 0x27c
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
    level._effect["zm_bgb_machine_available"] = "zombie/fx_bgb_machine_available_factory_zmb";
    level._effect["zm_bgb_machine_bulb_away"] = "zombie/fx_bgb_machine_bulb_away_factory_zmb";
    level._effect["zm_bgb_machine_bulb_available"] = "zombie/fx_bgb_machine_bulb_available_factory_zmb";
    level._effect["zm_bgb_machine_bulb_activated"] = "zombie/fx_bgb_machine_bulb_activated_factory_zmb";
    level._effect["zm_bgb_machine_bulb_event"] = "zombie/fx_bgb_machine_bulb_event_factory_zmb";
    level._effect["zm_bgb_machine_bulb_rounds"] = "zombie/fx_bgb_machine_bulb_rounds_factory_zmb";
    level._effect["zm_bgb_machine_bulb_time"] = "zombie/fx_bgb_machine_bulb_time_factory_zmb";
    level._effect["zm_bgb_machine_light_interior"] = "zombie/fx_bgb_machine_light_interior_factory_zmb";
    level._effect["zm_bgb_machine_light_interior_away"] = "zombie/fx_bgb_machine_light_interior_away_factory_zmb";
    clientfield::register("world", "console_blue", 1, 1, "int", &console_blue, 0, 0);
    clientfield::register("world", "console_green", 1, 1, "int", &console_green, 0, 0);
    clientfield::register("world", "console_red", 1, 1, "int", &console_red, 0, 0);
    clientfield::register("world", "console_start", 1, 1, "int", &console_start, 0, 0);
    clientfield::register("toplayer", "lightning_strike", 1, 1, "counter", &lightning_strike, 0, 0);
}

// Namespace zm_factory
// Params 0, eflags: 0x0
// Checksum 0xfa7111d3, Offset: 0x12e8
// Size: 0x254
function main() {
    zm_factory_ffotd::main_start();
    zm_factory_fx::main();
    level.setupcustomcharacterexerts = &setup_personality_character_exerts;
    level.legacy_cymbal_monkey = 1;
    level._effect["eye_glow"] = "zombie/fx_glow_eye_orange";
    level._effect["headshot"] = "zombie/fx_bul_flesh_head_fatal_zmb";
    level._effect["headshot_nochunks"] = "zombie/fx_bul_flesh_head_nochunks_zmb";
    level._effect["bloodspurt"] = "zombie/fx_bul_flesh_neck_spurt_zmb";
    level._effect["animscript_gib_fx"] = "zombie/fx_blood_torso_explo_zmb";
    level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
    level._effect["player_snow"] = "dlc0/factory/fx_snow_player_os_factory";
    level._uses_sticky_grenades = 1;
    level._uses_taser_knuckles = 1;
    level.debug_keyline_zombies = 0;
    include_weapons();
    function_50a4ff91();
    load::main();
    _zm_weap_cymbal_monkey::init();
    _zm_weap_tesla::init();
    level thread zm_factory_amb::main();
    level thread function_dba1e8f1();
    callback::on_localclient_connect(&on_player_connected);
    callback::on_spawned(&on_player_spawned);
    level thread function_e0500062();
    zm_factory_ffotd::main_end();
    util::waitforclient(0);
    println("<dev string:x28>");
}

// Namespace zm_factory
// Params 1, eflags: 0x0
// Checksum 0xd0255da8, Offset: 0x1548
// Size: 0xd6
function on_player_connected(localclientnum) {
    if (1 != getdvarint("movie_intro")) {
        return;
    }
    wait 0.05;
    keys = getarraykeys(level._active_wallbuys);
    for (i = 0; i < keys.size; i++) {
        wallbuy = level._active_wallbuys[keys[i]];
        stopfx(localclientnum, wallbuy.fx[localclientnum]);
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x0
// Checksum 0xa66efad, Offset: 0x1628
// Size: 0x24
function include_weapons() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_factory_weapons.csv", 1);
}

// Namespace zm_factory
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1658
// Size: 0x4
function function_50a4ff91() {
    
}

// Namespace zm_factory
// Params 1, eflags: 0x0
// Checksum 0x8474b4c7, Offset: 0x1668
// Size: 0x24
function on_player_spawned(localclientnum) {
    self thread function_9788e0f3(localclientnum);
}

// Namespace zm_factory
// Params 1, eflags: 0x0
// Checksum 0xe38efa3c, Offset: 0x1698
// Size: 0x108
function function_9788e0f3(localclientnum) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    if (1 == getdvarint("movie_intro")) {
        return;
    }
    if (!self islocalplayer() || !isdefined(self getlocalclientnumber()) || localclientnum != self getlocalclientnumber()) {
        return;
    }
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        fxid = playfx(localclientnum, level._effect["player_snow"], self.origin);
        setfxoutdoor(localclientnum, fxid);
        wait 0.25;
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x0
// Checksum 0x69a14ff, Offset: 0x17a8
// Size: 0x2c
function function_dba1e8f1() {
    level waittill(#"power_on");
    level thread scene::play("p7_fxanim_gp_wire_sparking_ground_01_bundle");
}

// Namespace zm_factory
// Params 0, eflags: 0x0
// Checksum 0x52d9862f, Offset: 0x17e0
// Size: 0x622
function setup_personality_character_exerts() {
    level.exert_sounds[1]["falldamage"][0] = "vox_plr_0_exert_pain_0";
    level.exert_sounds[1]["falldamage"][1] = "vox_plr_0_exert_pain_1";
    level.exert_sounds[1]["falldamage"][2] = "vox_plr_0_exert_pain_2";
    level.exert_sounds[1]["falldamage"][3] = "vox_plr_0_exert_pain_3";
    level.exert_sounds[1]["falldamage"][4] = "vox_plr_0_exert_pain_4";
    level.exert_sounds[2]["falldamage"][0] = "vox_plr_1_exert_pain_0";
    level.exert_sounds[2]["falldamage"][1] = "vox_plr_1_exert_pain_1";
    level.exert_sounds[2]["falldamage"][2] = "vox_plr_1_exert_pain_2";
    level.exert_sounds[2]["falldamage"][3] = "vox_plr_1_exert_pain_3";
    level.exert_sounds[2]["falldamage"][4] = "vox_plr_1_exert_pain_4";
    level.exert_sounds[3]["falldamage"][0] = "vox_plr_2_exert_pain_0";
    level.exert_sounds[3]["falldamage"][1] = "vox_plr_2_exert_pain_1";
    level.exert_sounds[3]["falldamage"][2] = "vox_plr_2_exert_pain_2";
    level.exert_sounds[3]["falldamage"][3] = "vox_plr_2_exert_pain_3";
    level.exert_sounds[3]["falldamage"][4] = "vox_plr_2_exert_pain_4";
    level.exert_sounds[4]["falldamage"][0] = "vox_plr_3_exert_pain_0";
    level.exert_sounds[4]["falldamage"][1] = "vox_plr_3_exert_pain_1";
    level.exert_sounds[4]["falldamage"][2] = "vox_plr_3_exert_pain_2";
    level.exert_sounds[4]["falldamage"][3] = "vox_plr_3_exert_pain_3";
    level.exert_sounds[4]["falldamage"][4] = "vox_plr_3_exert_pain_4";
    level.exert_sounds[1]["meleeswipesoundplayer"][0] = "vox_plr_0_exert_melee_0";
    level.exert_sounds[1]["meleeswipesoundplayer"][1] = "vox_plr_0_exert_melee_1";
    level.exert_sounds[1]["meleeswipesoundplayer"][2] = "vox_plr_0_exert_melee_2";
    level.exert_sounds[1]["meleeswipesoundplayer"][3] = "vox_plr_0_exert_melee_3";
    level.exert_sounds[1]["meleeswipesoundplayer"][4] = "vox_plr_0_exert_melee_4";
    level.exert_sounds[2]["meleeswipesoundplayer"][0] = "vox_plr_1_exert_melee_0";
    level.exert_sounds[2]["meleeswipesoundplayer"][1] = "vox_plr_1_exert_melee_1";
    level.exert_sounds[2]["meleeswipesoundplayer"][2] = "vox_plr_1_exert_melee_2";
    level.exert_sounds[2]["meleeswipesoundplayer"][3] = "vox_plr_1_exert_melee_3";
    level.exert_sounds[2]["meleeswipesoundplayer"][4] = "vox_plr_1_exert_melee_4";
    level.exert_sounds[3]["meleeswipesoundplayer"][0] = "vox_plr_2_exert_melee_0";
    level.exert_sounds[3]["meleeswipesoundplayer"][1] = "vox_plr_2_exert_melee_1";
    level.exert_sounds[3]["meleeswipesoundplayer"][2] = "vox_plr_2_exert_melee_2";
    level.exert_sounds[3]["meleeswipesoundplayer"][3] = "vox_plr_2_exert_melee_3";
    level.exert_sounds[3]["meleeswipesoundplayer"][4] = "vox_plr_2_exert_melee_4";
    level.exert_sounds[4]["meleeswipesoundplayer"][0] = "vox_plr_3_exert_melee_0";
    level.exert_sounds[4]["meleeswipesoundplayer"][1] = "vox_plr_3_exert_melee_1";
    level.exert_sounds[4]["meleeswipesoundplayer"][2] = "vox_plr_3_exert_melee_2";
    level.exert_sounds[4]["meleeswipesoundplayer"][3] = "vox_plr_3_exert_melee_3";
    level.exert_sounds[4]["meleeswipesoundplayer"][4] = "vox_plr_3_exert_melee_4";
}

// Namespace zm_factory
// Params 0, eflags: 0x0
// Checksum 0x1c2be500, Offset: 0x1e10
// Size: 0xc6
function function_f205a5f1() {
    level._effect["jugger_light"] = "zombie/fx_perk_juggernaut_factory_zmb";
    level._effect["revive_light"] = "zombie/fx_perk_quick_revive_factory_zmb";
    level._effect["sleight_light"] = "zombie/fx_perk_sleight_of_hand_factory_zmb";
    level._effect["doubletap2_light"] = "zombie/fx_perk_doubletap2_factory_zmb";
    level._effect["deadshot_light"] = "zombie/fx_perk_daiquiri_factory_zmb";
    level._effect["marathon_light"] = "zombie/fx_perk_stamin_up_factory_zmb";
    level._effect["additionalprimaryweapon_light"] = "zombie/fx_perk_mule_kick_factory_zmb";
}

// Namespace zm_factory
// Params 0, eflags: 0x0
// Checksum 0x24030f8f, Offset: 0x1ee0
// Size: 0x64
function function_e0500062() {
    level waittill(#"sndSB");
    playsound(0, "zmb_robothead_laser", (-434, 706, 439));
    playsound(0, "zmb_robothead_reflection_laser", (-451, -397, 294));
}

// Namespace zm_factory
// Params 7, eflags: 0x0
// Checksum 0x757639e8, Offset: 0x1f50
// Size: 0x104
function console_blue(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    s_scene = struct::get("top_dial");
    if (newval) {
        exploder::kill_exploder("teleporter_controller_red_light_1");
        exploder::exploder("teleporter_controller_light_1");
        s_scene thread scene::play();
        return;
    }
    exploder::kill_exploder("teleporter_controller_light_1");
    s_scene scene::stop(1);
    s_scene scene::init();
}

// Namespace zm_factory
// Params 7, eflags: 0x0
// Checksum 0x2d090ec0, Offset: 0x2060
// Size: 0x104
function console_green(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    s_scene = struct::get("middle_dial");
    if (newval) {
        exploder::kill_exploder("teleporter_controller_red_light_2");
        exploder::exploder("teleporter_controller_light_2");
        s_scene thread scene::play();
        return;
    }
    exploder::kill_exploder("teleporter_controller_light_2");
    s_scene scene::stop(1);
    s_scene scene::init();
}

// Namespace zm_factory
// Params 7, eflags: 0x0
// Checksum 0xcfb23f84, Offset: 0x2170
// Size: 0x104
function console_red(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    s_scene = struct::get("bottom_dial");
    if (newval) {
        exploder::kill_exploder("teleporter_controller_red_light_3");
        exploder::exploder("teleporter_controller_light_3");
        s_scene thread scene::play();
        return;
    }
    exploder::kill_exploder("teleporter_controller_light_3");
    s_scene scene::stop(1);
    s_scene scene::init();
}

// Namespace zm_factory
// Params 7, eflags: 0x0
// Checksum 0xd687f83d, Offset: 0x2280
// Size: 0x8c
function console_start(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("teleporter_controller_red_light_1");
        exploder::exploder("teleporter_controller_red_light_2");
        exploder::exploder("teleporter_controller_red_light_3");
    }
}

// Namespace zm_factory
// Params 7, eflags: 0x0
// Checksum 0x1b21d663, Offset: 0x2318
// Size: 0x194
function lightning_strike(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setukkoscriptindex(localclientnum, 1, 1);
    playsound(0, "amb_lightning_dist_low", (0, 0, 0));
    wait 0.02;
    setukkoscriptindex(localclientnum, 3, 1);
    wait 0.15;
    setukkoscriptindex(localclientnum, 1, 1);
    wait 0.1;
    setukkoscriptindex(localclientnum, 4, 1);
    wait 0.1;
    setukkoscriptindex(localclientnum, 3, 1);
    wait 0.25;
    setukkoscriptindex(localclientnum, 1, 1);
    wait 0.15;
    setukkoscriptindex(localclientnum, 3, 1);
    wait 0.15;
    setukkoscriptindex(localclientnum, 1, 1);
}

