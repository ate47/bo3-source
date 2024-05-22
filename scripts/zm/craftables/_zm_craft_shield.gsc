#using scripts/shared/ai/zombie_utility;
#using scripts/zm/_zm_powerup_shield_charge;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_weap_riotshield;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_devgui;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_abd96e8b;

// Namespace namespace_abd96e8b
// Params 0, eflags: 0x2
// Checksum 0xe545974f, Offset: 0x438
// Size: 0x3c
function function_2dc19561() {
    system::register("zm_craft_shield", &__init__, &__main__, undefined);
}

// Namespace namespace_abd96e8b
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x480
// Size: 0x4
function __init__() {
    
}

// Namespace namespace_abd96e8b
// Params 6, eflags: 0x1 linked
// Checksum 0x514d5de, Offset: 0x490
// Size: 0x47c
function init(var_fcfc23b7, var_4524a629, shield_model, var_d6fd6d9d, var_6cabc9d6, var_6dddeed3) {
    if (!isdefined(var_d6fd6d9d)) {
        var_d6fd6d9d = %ZOMBIE_CRAFT_RIOT;
    }
    if (!isdefined(var_6cabc9d6)) {
        var_6cabc9d6 = %ZOMBIE_BOUGHT_RIOT;
    }
    if (!isdefined(var_6dddeed3)) {
        var_6dddeed3 = %ZOMBIE_GRAB_RIOTSHIELD;
    }
    level.var_a081b24e = var_fcfc23b7;
    level.var_8a69e1e = var_4524a629;
    level.var_a2d03ee5 = shield_model;
    level.var_55d294f8 = var_6dddeed3;
    level.var_5ebd48c7 = 0;
    var_c5395759 = namespace_f37770c8::function_5cf75ff1(level.var_a081b24e, "dolly", 32, 64, 0, undefined, &function_314a523b, &function_5e1c958e, undefined, undefined, undefined, undefined, "piece_riotshield_dolly", 1, "build_zs");
    var_b2c078b7 = namespace_f37770c8::function_5cf75ff1(level.var_a081b24e, "door", 48, 15, 25, undefined, &function_314a523b, &function_5e1c958e, undefined, undefined, undefined, undefined, "piece_riotshield_door", 1, "build_zs");
    var_c6948090 = namespace_f37770c8::function_5cf75ff1(level.var_a081b24e, "clamp", 48, 15, 25, undefined, &function_314a523b, &function_5e1c958e, undefined, undefined, undefined, undefined, "piece_riotshield_clamp", 1, "build_zs");
    registerclientfield("world", "piece_riotshield_dolly", 1, 1, "int", undefined, 0);
    registerclientfield("world", "piece_riotshield_door", 1, 1, "int", undefined, 0);
    registerclientfield("world", "piece_riotshield_clamp", 1, 1, "int", undefined, 0);
    clientfield::register("toplayer", "ZMUI_SHIELD_PART_PICKUP", 1, 1, "int");
    clientfield::register("toplayer", "ZMUI_SHIELD_CRAFTED", 1, 1, "int");
    riotshield = spawnstruct();
    riotshield.name = level.var_a081b24e;
    riotshield.weaponname = level.var_8a69e1e;
    riotshield namespace_f37770c8::function_b0deb4e6(var_c5395759);
    riotshield namespace_f37770c8::function_b0deb4e6(var_b2c078b7);
    riotshield namespace_f37770c8::function_b0deb4e6(var_c6948090);
    riotshield.var_71a0cc1e = &function_3a4a378;
    riotshield.var_41f0f8cd = &function_70a15daf;
    namespace_f37770c8::function_ac4e44a7(riotshield);
    namespace_f37770c8::function_8421d708(level.var_a081b24e, var_d6fd6d9d, "ERROR", var_6cabc9d6, &function_a8c317e7, 1);
    namespace_f37770c8::function_b2caef35(level.var_a081b24e, "build_zs");
    namespace_f37770c8::function_c86d092(level.var_a081b24e, level.var_a2d03ee5, (0, -90, 0), (0, 0, 26));
}

// Namespace namespace_abd96e8b
// Params 0, eflags: 0x1 linked
// Checksum 0x9d2b83b5, Offset: 0x918
// Size: 0x1c
function __main__() {
    /#
        shield_devgui();
    #/
}

// Namespace namespace_abd96e8b
// Params 0, eflags: 0x1 linked
// Checksum 0x1030396, Offset: 0x940
// Size: 0x3c
function function_70a15daf() {
    namespace_f37770c8::function_4f91b11d("riotshield_zm_craftable_trigger", level.var_a081b24e, level.var_8a69e1e, level.var_55d294f8, 1, 1);
}

// Namespace namespace_abd96e8b
// Params 2, eflags: 0x1 linked
// Checksum 0xa53a73d6, Offset: 0x988
// Size: 0x54
function function_69e0fb83(var_55ce4248, n_duration) {
    self clientfield::set_to_player(var_55ce4248, 1);
    wait(n_duration);
    self clientfield::set_to_player(var_55ce4248, 0);
}

// Namespace namespace_abd96e8b
// Params 1, eflags: 0x1 linked
// Checksum 0xf4f30277, Offset: 0x9e8
// Size: 0x148
function function_314a523b(player) {
    /#
        println("door");
    #/
    player playsound("zmb_craftable_pickup");
    if (isdefined(level.var_fc2bdb4a)) {
        player thread [[ level.var_fc2bdb4a ]]();
    }
    foreach (e_player in level.players) {
        e_player thread namespace_f37770c8::function_97be99b3("zmInventory.player_crafted_shield", "zmInventory.widget_shield_parts", 0);
        e_player thread function_69e0fb83("ZMUI_SHIELD_PART_PICKUP", 3.5);
    }
    self function_15eb00ae();
    self.var_77a0498d = player;
}

// Namespace namespace_abd96e8b
// Params 1, eflags: 0x1 linked
// Checksum 0x98ffd3b3, Offset: 0xb38
// Size: 0x4e
function function_5e1c958e(player) {
    /#
        println("door");
    #/
    self function_b908e870(player);
    self.var_77a0498d = undefined;
}

// Namespace namespace_abd96e8b
// Params 0, eflags: 0x1 linked
// Checksum 0xb4375d44, Offset: 0xb90
// Size: 0x20
function function_15eb00ae() {
    if (isdefined(level.var_dcf785c5)) {
        [[ level.var_dcf785c5 ]]();
    }
}

// Namespace namespace_abd96e8b
// Params 0, eflags: 0x1 linked
// Checksum 0x3fc45da, Offset: 0xbb8
// Size: 0xee
function function_a8c317e7() {
    players = level.players;
    foreach (e_player in players) {
        if (zm_utility::is_player_valid(e_player)) {
            e_player thread namespace_f37770c8::function_97be99b3("zmInventory.player_crafted_shield", "zmInventory.widget_shield_parts", 1);
            e_player thread function_69e0fb83("ZMUI_SHIELD_CRAFTED", 3.5);
        }
    }
    return true;
}

// Namespace namespace_abd96e8b
// Params 1, eflags: 0x1 linked
// Checksum 0x47a111cf, Offset: 0xcb0
// Size: 0x28
function function_b908e870(player) {
    if (isdefined(level.var_a71b815c)) {
        [[ level.var_a71b815c ]]();
    }
}

// Namespace namespace_abd96e8b
// Params 1, eflags: 0x1 linked
// Checksum 0x6f63e23c, Offset: 0xce0
// Size: 0x96
function function_3a4a378(player) {
    if (isdefined(player.player_shield_reset_health)) {
        player [[ player.player_shield_reset_health ]]();
    }
    if (isdefined(player.var_af8ff2cc)) {
        player [[ player.var_af8ff2cc ]]();
    }
    player playsound("zmb_craftable_buy_shield");
    level notify(#"shield_built", player);
}

/#

    // Namespace namespace_abd96e8b
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa2cda087, Offset: 0xd80
    // Size: 0xf4
    function shield_devgui() {
        level flagsys::wait_till("door");
        wait(1);
        zm_devgui::add_custom_devgui_callback(&shield_devgui_callback);
        setdvar("door", 0);
        adddebugcommand("door" + level.var_a081b24e + "door");
        adddebugcommand("door" + level.var_a081b24e + "door");
        adddebugcommand("door" + level.var_a081b24e + "door");
    }

    // Namespace namespace_abd96e8b
    // Params 1, eflags: 0x1 linked
    // Checksum 0x46e3e8bd, Offset: 0xe80
    // Size: 0x1d0
    function shield_devgui_callback(cmd) {
        players = getplayers();
        retval = 0;
        switch (cmd) {
        case 8:
            array::thread_all(players, &function_2b0b208f);
            retval = 1;
            break;
        case 8:
            if (players.size >= 1) {
                players[0] thread function_2b0b208f();
            }
            retval = 1;
            break;
        case 8:
            if (players.size >= 2) {
                players[1] thread function_2b0b208f();
            }
            retval = 1;
            break;
        case 8:
            if (players.size >= 3) {
                players[2] thread function_2b0b208f();
            }
            retval = 1;
            break;
        case 8:
            if (players.size >= 4) {
                players[3] thread function_2b0b208f();
            }
            retval = 1;
            break;
        case 8:
            array::thread_all(level.players, &function_70d7908d);
            retval = 1;
            break;
        }
        return retval;
    }

    // Namespace namespace_abd96e8b
    // Params 0, eflags: 0x1 linked
    // Checksum 0x79ed3a4a, Offset: 0x1058
    // Size: 0x38
    function function_2449723c() {
        if (isdefined(self.var_9dc82bca)) {
            if (self.var_9dc82bca == gettime()) {
                return 1;
            }
        }
        self.var_9dc82bca = gettime();
        return 0;
    }

    // Namespace namespace_abd96e8b
    // Params 0, eflags: 0x1 linked
    // Checksum 0xac95a94a, Offset: 0x1098
    // Size: 0x198
    function function_2b0b208f() {
        if (self function_2449723c()) {
            return;
        }
        self notify(#"hash_2b0b208f");
        self endon(#"hash_2b0b208f");
        self.var_74469a7a = !(isdefined(self.var_74469a7a) && self.var_74469a7a);
        println("door" + self.name + "door" + (self.var_74469a7a ? "door" : "door"));
        iprintlnbold("door" + self.name + "door" + (self.var_74469a7a ? "door" : "door"));
        if (self.var_74469a7a) {
            while (isdefined(self)) {
                damagemax = level.weaponriotshield.weaponstarthitpoints;
                if (isdefined(self.weaponriotshield)) {
                    damagemax = self.weaponriotshield.weaponstarthitpoints;
                }
                shieldhealth = damagemax;
                shieldhealth = self damageriotshield(0);
                self damageriotshield(shieldhealth - damagemax);
                wait(0.05);
            }
        }
    }

    // Namespace namespace_abd96e8b
    // Params 0, eflags: 0x1 linked
    // Checksum 0xdea123c9, Offset: 0x1238
    // Size: 0x54
    function function_70d7908d() {
        if (self function_2449723c()) {
            return;
        }
        if (isdefined(self.hasriotshield) && self.hasriotshield) {
            self zm_equipment::change_ammo(self.weaponriotshield, 1);
        }
    }

#/
