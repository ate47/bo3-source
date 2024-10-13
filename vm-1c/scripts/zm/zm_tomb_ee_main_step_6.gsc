#using scripts/zm/_zm_weap_one_inch_punch;
#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_ee_main;
#using scripts/zm/zm_tomb_chamber;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_sidequests;
#using scripts/shared/util_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;

#namespace zm_tomb_ee_main_step_6;

// Namespace zm_tomb_ee_main_step_6
// Params 0, eflags: 0x1 linked
// Checksum 0x371b8720, Offset: 0x2f8
// Size: 0x54
function init() {
    namespace_6e97c459::function_5a90ed82("little_girl_lost", "step_6", &init_stage, &function_7747c56, &function_cc3f3f6a);
}

// Namespace zm_tomb_ee_main_step_6
// Params 0, eflags: 0x1 linked
// Checksum 0x6bd11303, Offset: 0x358
// Size: 0x34
function init_stage() {
    level.var_ca733eed = "step_6";
    zm_spawner::add_custom_zombie_spawn_logic(&function_4aee6e96);
}

// Namespace zm_tomb_ee_main_step_6
// Params 0, eflags: 0x1 linked
// Checksum 0xcbee04c9, Offset: 0x398
// Size: 0x7c
function function_7747c56() {
    /#
        iprintln(level.var_ca733eed + "<dev string:x28>");
    #/
    level flag::wait_till("ee_all_players_upgraded_punch");
    util::wait_network_frame();
    namespace_6e97c459::function_2f3ced1f("little_girl_lost", level.var_ca733eed);
}

// Namespace zm_tomb_ee_main_step_6
// Params 1, eflags: 0x1 linked
// Checksum 0x4f9359c8, Offset: 0x420
// Size: 0x1a
function function_cc3f3f6a(success) {
    level notify(#"hash_ee01811f");
}

// Namespace zm_tomb_ee_main_step_6
// Params 0, eflags: 0x1 linked
// Checksum 0xc8cf38d2, Offset: 0x448
// Size: 0x240
function function_4aee6e96() {
    if (level flag::get("ee_all_players_upgraded_punch")) {
        return;
    }
    if (isdefined(self.zone_name) && self.zone_name == "ug_bottom_zone") {
        wait 0.1;
        self clientfield::set("ee_zombie_fist_fx", 1);
        self.var_1c6bd2ab = 1;
        while (isalive(self)) {
            amount, inflictor, direction, point, type, tagname, modelname, partname, weapon, idflags = self waittill(#"damage");
            if (!isdefined(inflictor.var_1d9d8a6e)) {
                inflictor.var_1d9d8a6e = 0;
                inflictor.var_21412003 = 0;
            }
            if (isdefined(self.completed_emerging_into_playable_area) && self.var_1c6bd2ab && inflictor.var_1d9d8a6e < 20 && isdefined(weapon) && weapon == level.var_653c9585 && self.completed_emerging_into_playable_area) {
                self clientfield::set("ee_zombie_fist_fx", 0);
                self.var_1c6bd2ab = 0;
                playsoundatposition("zmb_squest_punchtime_punched", self.origin);
                inflictor.var_1d9d8a6e++;
                if (inflictor.var_1d9d8a6e == 20) {
                    level thread function_3bcfc005(self.origin, inflictor);
                }
            }
        }
    }
}

// Namespace zm_tomb_ee_main_step_6
// Params 2, eflags: 0x1 linked
// Checksum 0x73dbbd53, Offset: 0x690
// Size: 0x5ec
function function_3bcfc005(v_origin, e_player) {
    var_8365f931 = spawn("script_model", v_origin + (0, 0, 50));
    var_8365f931 setmodel("p7_zm_ori_tablet_stone");
    m_fx = spawn("script_model", var_8365f931.origin);
    m_fx setmodel("tag_origin");
    m_fx setinvisibletoall();
    m_fx setvisibletoplayer(e_player);
    var_8365f931 linkto(m_fx);
    playfxontag(level._effect["special_glow"], m_fx, "tag_origin");
    m_fx thread function_9507beaf();
    var_8365f931 playloopsound("zmb_squest_punchtime_tablet_loop", 0.5);
    var_8365f931 setinvisibletoall();
    var_8365f931 setvisibletoplayer(e_player);
    while (isdefined(e_player) && !e_player istouching(var_8365f931)) {
        wait 0.05;
    }
    var_8365f931 delete();
    m_fx delete();
    e_player playsound("zmb_squest_punchtime_tablet_pickup");
    if (isdefined(e_player)) {
        e_player thread hud::fade_to_black_for_x_sec(0, 0.3, 0.5, 0.5, "white");
        a_zombies = getaispeciesarray(level.zombie_team, "all");
        foreach (zombie in a_zombies) {
            if (isdefined(zombie.completed_emerging_into_playable_area) && distance2dsquared(e_player.origin, zombie.origin) < 65536 && !(isdefined(zombie.is_mechz) && zombie.is_mechz) && !(isdefined(zombie.missinglegs) && zombie.missinglegs) && zombie.completed_emerging_into_playable_area) {
                zombie.var_36a949c6 = e_player.origin;
                zombie animcustom(&_zm_weap_one_inch_punch::function_60897a18);
            }
        }
        wait 1;
        e_player.var_21412003 = 1;
        foreach (mdl_staff in level.var_66561721) {
            if (e_player hasweapon(mdl_staff.w_weapon)) {
                e_player.var_b37dabd2 = mdl_staff.w_weapon.element;
            }
        }
        if (!isdefined(e_player.var_b37dabd2)) {
            e_player.var_b37dabd2 = "upgraded";
        }
        e_player thread _zm_weap_one_inch_punch::function_3898d995();
        e_player thread _zm_weap_one_inch_punch::function_3898d995();
        a_players = getplayers();
        foreach (player in a_players) {
            if (!isdefined(player.var_21412003) || !player.var_21412003) {
                return;
            }
        }
        level flag::set("ee_all_players_upgraded_punch");
    }
}

// Namespace zm_tomb_ee_main_step_6
// Params 0, eflags: 0x1 linked
// Checksum 0x5af0206f, Offset: 0xc88
// Size: 0x44
function function_9507beaf() {
    self endon(#"death");
    while (true) {
        self rotateyaw(360, 5);
        self waittill(#"rotatedone");
    }
}

