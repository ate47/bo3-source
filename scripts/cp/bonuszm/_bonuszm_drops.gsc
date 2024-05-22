#using scripts/cp/bonuszm/_bonuszm_prologue;
#using scripts/cp/bonuszm/_bonuszm_biodomes1;
#using scripts/cp/bonuszm/_bonuszm_sgen;
#using scripts/cp/bonuszm/_bonuszm_weapons;
#using scripts/cp/bonuszm/_bonuszm_magicbox;
#using scripts/cp/bonuszm/_bonuszm_spawner_shared;
#using scripts/cp/bonuszm/_bonuszm_data;
#using scripts/cp/bonuszm/_bonuszm_util;
#using scripts/cp/bonuszm/_bonuszm_sound;
#using scripts/cp/bonuszm/_bonuszm_dev;
#using scripts/cp/_util;
#using scripts/cp/_oed;
#using scripts/cp/_load;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/gametypes/_globallogic_player;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/weapons_shared;
#using scripts/shared/util_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/serverfaceanim_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/_oob;
#using scripts/shared/music_shared;
#using scripts/shared/math_shared;
#using scripts/shared/load_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/containers_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/clientids_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ammo_shared;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/archetype_shared/archetype_shared;
#using scripts/codescripts/struct;

#namespace namespace_fdfaa57d;

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x2
// Checksum 0x883da939, Offset: 0xb18
// Size: 0x6c
function main() {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    level.var_26432505 = &function_26432505;
    function_94c35cf8();
    level.var_61c4b2a6 = 0;
    level.var_c85f5b9b = [];
    level thread function_2a5eb705();
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0xb90
// Size: 0x4
function init() {
    
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0xbf20c473, Offset: 0xba0
// Size: 0xac4
function function_b67e03f7() {
    if (level.var_61c4b2a6 >= 8) {
        return;
    }
    if (isdefined(self.var_4f1bf25e) && self.var_4f1bf25e) {
        return;
    }
    var_7c911129 = level.var_a9e78bf7["powerupdropsenabled"];
    var_978f1b32 = level.var_a9e78bf7["powerdropchance"] * level.var_a9e78bf7["powerdropsscalar"];
    /#
        if (getdvarstring("cybercoreupgradeddropchance") != "cybercoreupgradeddropchance") {
            var_7c911129 = 1;
            var_978f1b32 = 100;
        }
    #/
    if (!var_7c911129) {
        return;
    }
    forcedrop = 0;
    if (isdefined(self.var_6ad7f3f8) && self.var_6ad7f3f8) {
        forcedrop = 1;
    }
    var_e269fb69 = randomint(100);
    if (var_e269fb69 > var_978f1b32 && !forcedrop) {
        return;
    }
    randomchance = randomint(int(var_978f1b32));
    var_2f14c279 = undefined;
    var_bf55d8d2 = [];
    if (isdefined(forcedrop) && forcedrop) {
        var_bf55d8d2[var_bf55d8d2.size] = "instakill";
    } else {
        if (randomchance < int(level.var_a9e78bf7["weapondropchance"] * level.var_a9e78bf7["powerdropsscalar"])) {
            var_bf55d8d2[var_bf55d8d2.size] = "random_weapon";
        }
        if (randomchance < int(level.var_a9e78bf7["cybercoredropchance"] * level.var_a9e78bf7["powerdropsscalar"])) {
            var_bf55d8d2[var_bf55d8d2.size] = "cybercom";
        }
        if (randomchance < int(level.var_a9e78bf7["cybercoreupgradeddropchance"] * level.var_a9e78bf7["powerdropsscalar"])) {
            var_bf55d8d2[var_bf55d8d2.size] = "cybercom_upgraded";
        }
        var_7a2764e8 = getactorteamarray("axis");
        var_d55df350 = isdefined(var_7a2764e8) && var_7a2764e8.size && var_7a2764e8.size >= 3;
        if (randomchance < int(level.var_a9e78bf7["instakilldropchance"] * level.var_a9e78bf7["powerdropsscalar"]) && !function_9c4468cc() && !function_5fcda3a0()) {
            var_bf55d8d2[var_bf55d8d2.size] = "instakill";
        }
        if (randomchance < int(level.var_a9e78bf7["maxdropammochance"] * level.var_a9e78bf7["powerdropsscalar"])) {
            var_bf55d8d2[var_bf55d8d2.size] = "max_ammo";
        }
        if (randomchance < int(level.var_a9e78bf7["maxdropammoupgradedchance"] * level.var_a9e78bf7["powerdropsscalar"])) {
            var_bf55d8d2[var_bf55d8d2.size] = "max_ammo_upgraded";
        }
        if (var_d55df350 && randomchance < int(level.var_a9e78bf7["instakillupgradeddropchance"] * level.var_a9e78bf7["powerdropsscalar"]) && !function_9c4468cc() && !function_5fcda3a0()) {
            var_b37cc8bd = 0;
            foreach (player in level.players) {
                if (player hasweapon(level.var_45cae8b1, 1)) {
                    var_b37cc8bd = 1;
                }
            }
            if (!var_b37cc8bd) {
                var_bf55d8d2[var_bf55d8d2.size] = "instakill_upgraded";
            } else {
                var_bf55d8d2[var_bf55d8d2.size] = "instakill";
            }
        }
        if (var_d55df350 && randomchance < int(level.var_a9e78bf7["rapsdropchance"] * level.var_a9e78bf7["powerdropsscalar"]) && !(isdefined(level.var_5a1513c4) && level.var_5a1513c4)) {
            var_bf55d8d2[var_bf55d8d2.size] = "raps";
        }
    }
    if (var_bf55d8d2.size) {
        var_2f14c279 = var_bf55d8d2[randomint(var_bf55d8d2.size)];
    }
    /#
        if (getdvarstring("cybercoreupgradeddropchance") != "cybercoreupgradeddropchance") {
            var_2f14c279 = getdvarstring("cybercoreupgradeddropchance");
        }
    #/
    if (!isdefined(var_2f14c279)) {
        return;
    }
    players = getplayers();
    closestplayer = arraygetclosest(self.origin, players, 100);
    origin = self.origin;
    if (isdefined(closestplayer)) {
        direction = vectornormalize(self.origin - closestplayer.origin);
        origin = self.origin + vectorscale(direction, -106);
    }
    switch (var_2f14c279) {
    case 5:
        weaponinfo = function_1e2e0936(0);
        if (!isdefined(weaponinfo)) {
            return;
        }
        if (weaponinfo[0] == level.weaponnone) {
            return;
        }
        str_identifier = "random_weapon";
        var_663ac88a = "random_weapon";
        str_model = weaponinfo[0].worldmodel;
        var_638b7f73 = self function_95409c5(str_model, origin, (0, 0, 30), weaponinfo, 0);
        break;
    case 7:
        str_identifier = "cybercom";
        var_663ac88a = "cybercom";
        var_638b7f73 = self function_95409c5("p7_zm_power_up_cyber_core", origin, (0, 0, 30), undefined, 0);
        break;
    case 9:
        str_identifier = "cybercom_upgraded";
        var_663ac88a = "cybercom_upgraded";
        var_638b7f73 = self function_95409c5("p7_zm_power_up_cyber_core", origin, (0, 0, 30), undefined, 1, 1);
        break;
    case 13:
        str_identifier = "max_ammo";
        var_663ac88a = "max_ammo";
        var_638b7f73 = self function_95409c5("p7_zm_power_up_max_ammo", origin, (0, 0, 30), undefined, 0);
        break;
    case 15:
        str_identifier = "max_ammo_upgraded";
        var_663ac88a = "max_ammo_upgraded";
        var_638b7f73 = self function_95409c5("p7_zm_power_up_max_ammo", origin, (0, 0, 30), undefined, 1, 1);
        break;
    case 3:
        str_identifier = "instakill";
        var_663ac88a = "instakill";
        var_638b7f73 = self function_95409c5("p7_zm_power_up_insta_kill", origin, (0, 0, 30), undefined, 0);
        break;
    case 17:
        str_identifier = "instakill_upgraded";
        var_663ac88a = "instakill_upgraded";
        var_638b7f73 = self function_95409c5("p7_zm_power_up_insta_kill", origin, (0, 0, 30), undefined, 1, 1);
        break;
    case 19:
        str_identifier = "raps";
        var_663ac88a = "raps";
        var_638b7f73 = self function_95409c5("veh_t7_drone_raps", origin, (0, 0, 30), undefined, 0);
        break;
    default:
        /#
            assertmsg("cybercoreupgradeddropchance");
        #/
        break;
    }
    level.var_61c4b2a6++;
    self thread function_6b3c34cc(var_638b7f73, str_identifier, var_663ac88a);
}

// Namespace namespace_fdfaa57d
// Params 6, eflags: 0x1 linked
// Checksum 0x9b0a1083, Offset: 0x1670
// Size: 0x220
function function_95409c5(str_model, var_86aa369c, v_offset, weaponinfo, upgraded, var_b8419776) {
    if (!isdefined(v_offset)) {
        v_offset = (0, 0, 0);
    }
    if (!isdefined(var_b8419776)) {
        var_b8419776 = 0;
    }
    if (!isdefined(self.var_e6daaaf2)) {
        self.var_e6daaaf2 = [];
    }
    if (!mayspawnentity()) {
        /#
            iprintln("cybercoreupgradeddropchance");
        #/
        return;
    }
    var_638b7f73 = spawn("script_model", (0, 0, 0));
    var_638b7f73 setmodel("tag_origin");
    var_638b7f73 notsolid();
    if (!isdefined(weaponinfo)) {
        if (isdefined(upgraded) && upgraded) {
            var_638b7f73 setscale(0.7);
        } else {
            var_638b7f73 setscale(0.6);
        }
        if (str_model == "veh_t7_drone_raps") {
            var_638b7f73 setscale(0.4);
        }
    }
    var_638b7f73.weaponinfo = weaponinfo;
    var_638b7f73.upgraded = upgraded;
    var_638b7f73 thread function_fe2b609e(var_86aa369c + v_offset, str_model, upgraded, var_b8419776);
    var_638b7f73 thread function_13d6da78();
    array::add(level.var_c85f5b9b, var_638b7f73);
    return var_638b7f73;
}

// Namespace namespace_fdfaa57d
// Params 4, eflags: 0x1 linked
// Checksum 0x1ece3c49, Offset: 0x1898
// Size: 0x194
function function_fe2b609e(var_cf527d3b, str_model, upgraded, var_b8419776) {
    if (!isdefined(var_b8419776)) {
        var_b8419776 = 0;
    }
    self endon(#"death");
    self.var_92fc0506 = gettime();
    self.origin = var_cf527d3b;
    if (isdefined(str_model)) {
        if (isdefined(self.weaponinfo)) {
            self useweaponmodel(self.weaponinfo[0], self.weaponinfo[0].worldmodel);
            self setweaponrenderoptions(self.weaponinfo[2], 0, 0, 0, 0);
        } else {
            self setmodel(str_model);
        }
        if (isdefined(var_b8419776) && var_b8419776) {
            self clientfield::set("powerup_on_fx", 3);
        } else if (isdefined(upgraded) && upgraded) {
            self clientfield::set("powerup_on_fx", 2);
        } else {
            self clientfield::set("powerup_on_fx", 1);
        }
    }
    self show();
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0xa3d9b648, Offset: 0x1a38
// Size: 0x34
function function_58f94c40() {
    self thread function_b050d188();
    self thread function_8036f40b();
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0xcd0fcad6, Offset: 0x1a78
// Size: 0x8e
function function_8036f40b() {
    self endon(#"death");
    upgraded = isdefined(self.upgraded) && self.upgraded;
    if (upgraded) {
        rotatetime = 0.3;
    } else {
        rotatetime = 0.7;
    }
    while (true) {
        self rotateyaw(-180, rotatetime);
        wait(rotatetime);
    }
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0x4b0f56cb, Offset: 0x1b10
// Size: 0x1be
function function_b050d188() {
    self endon(#"death");
    self endon(#"hash_56f6579a");
    var_b57f6680 = 18;
    n_frames = var_b57f6680 * 20;
    n_section = int(n_frames / 6);
    var_66bc469e = n_section * 3;
    var_e915e81c = n_section * 4;
    var_6e8f42af = n_section * 5;
    b_show = 1;
    i = 0;
    while (i < n_frames) {
        if (i < var_66bc469e) {
            n_multiplier = var_66bc469e;
        } else if (i < var_e915e81c) {
            n_multiplier = 10;
        } else if (i < var_6e8f42af) {
            n_multiplier = 5;
        } else {
            n_multiplier = 2;
        }
        if (b_show) {
            self show();
        } else {
            self ghost();
        }
        b_show = !b_show;
        i += n_multiplier;
        wait(0.05 * n_multiplier);
    }
    self notify(#"hash_56f6579a");
}

// Namespace namespace_fdfaa57d
// Params 1, eflags: 0x1 linked
// Checksum 0x2071f10a, Offset: 0x1cd8
// Size: 0x14a
function function_d7f5b3c2(facee) {
    requireddot = 0.5;
    orientation = self getplayerangles();
    forwardvec = anglestoforward(orientation);
    forwardvec2d = (forwardvec[0], forwardvec[1], 0);
    unitforwardvec2d = vectornormalize(forwardvec2d);
    tofaceevec = facee.origin - self.origin;
    tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
    unittofaceevec2d = vectornormalize(tofaceevec2d);
    dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
    return dotproduct > requireddot;
}

// Namespace namespace_fdfaa57d
// Params 3, eflags: 0x1 linked
// Checksum 0x498f8ce2, Offset: 0x1e30
// Size: 0x256
function function_6b3c34cc(var_638b7f73, str_identifier, var_663ac88a) {
    if (!isdefined(var_638b7f73)) {
        return;
    }
    var_638b7f73 endon(#"death");
    var_638b7f73 endon(#"hash_56f6579a");
    util::wait_network_frame();
    var_e484e9fb = int(180);
    for (i = 0; i < var_e484e9fb; i++) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            var_fb9f4f9f = distance2dsquared(var_638b7f73.origin, players[i].origin) < 2025;
            var_e33aadf8 = abs(var_638b7f73.origin[2] - players[i].origin[2]) < 50;
            if (var_fb9f4f9f && var_e33aadf8) {
                player = players[i];
                if (!player isplayinganimscripted() && player function_d7f5b3c2(var_638b7f73)) {
                    var_638b7f73.picked_up = 1;
                    players[i] notify(#"hash_b5d20c7d");
                    players[i] notify(str_identifier);
                    players[i] function_da35c458(var_663ac88a, var_638b7f73);
                    var_638b7f73 notify(#"hash_56f6579a");
                    break;
                }
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_fdfaa57d
// Params 1, eflags: 0x1 linked
// Checksum 0x7120f25d, Offset: 0x2090
// Size: 0x9c
function function_cf8cea5f(n_delay) {
    if (!isdefined(n_delay)) {
        n_delay = 0.1;
    }
    if (level.var_61c4b2a6 <= 0) {
        return;
    }
    level.var_61c4b2a6--;
    if (n_delay > 0) {
        self clientfield::set("powerup_on_fx", 0);
        self ghost();
        wait(n_delay);
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0xe14f88f5, Offset: 0x2138
// Size: 0xac
function function_13d6da78() {
    self thread function_58f94c40();
    self util::waittill_any("death_or_disconnect", "stopbzmdrop_behavior");
    var_cfbd1e2d = 0.1;
    if (isdefined(self.picked_up) && self.picked_up) {
        self clientfield::set("powerup_grabbed_fx", 1);
        var_cfbd1e2d = 1;
    }
    self function_cf8cea5f(var_cfbd1e2d);
}

// Namespace namespace_fdfaa57d
// Params 2, eflags: 0x1 linked
// Checksum 0xd2a54c73, Offset: 0x21f0
// Size: 0x16e
function function_da35c458(var_663ac88a, var_638b7f73) {
    switch (var_663ac88a) {
    case 7:
        self function_2beeb3b3(0);
        break;
    case 9:
        self function_2beeb3b3(1);
        break;
    case 13:
        self give_max_ammo();
        break;
    case 15:
        self function_4827a249();
        break;
    case 5:
        self function_4035ce17(var_638b7f73);
        break;
    case 3:
        self function_f3239cd2();
        break;
    case 17:
        self function_c54347ed();
        break;
    case 19:
        self thread function_be188509();
        break;
    default:
        /#
            assert("cybercoreupgradeddropchance" + var_663ac88a + "cybercoreupgradeddropchance");
        #/
        break;
    }
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x5 linked
// Checksum 0xb82755b2, Offset: 0x2368
// Size: 0x258
function function_be188509() {
    level.var_5a1513c4 = 1;
    closestplayer = arraygetclosest(self.origin, level.players);
    playerforward = anglestoforward(closestplayer.angles);
    var_2d1236a = closestplayer.origin + vectorscale(playerforward, 100);
    var_2d1236a = getclosestpointonnavmesh(var_2d1236a, 300);
    if (!isdefined(var_2d1236a)) {
        return;
    }
    level.var_f011cb7c = spawnvehicle("spawner_enemy_54i_vehicle_raps_suicide", var_2d1236a, closestplayer.angles, "raps_drop");
    level.var_f011cb7c setignorepauseworld(1);
    if (isdefined(level.var_f011cb7c)) {
        level.var_f011cb7c.team = "allies";
        level.var_f011cb7c.ignoreme = 1;
        level.var_f011cb7c.disableautodetonation = 1;
        level.var_f011cb7c setavoidancemask("avoid none");
        wait(40);
        if (isdefined(level.var_f011cb7c) && isalive(level.var_f011cb7c)) {
            attacker = level.var_f011cb7c;
            level.var_f011cb7c stopsounds();
            level.var_f011cb7c dodamage(level.var_f011cb7c.health + 1000, level.var_f011cb7c.origin, attacker, level.var_f011cb7c, "none", "MOD_EXPLOSIVE", 0, level.var_f011cb7c.turretweapon);
        }
    }
    level.var_5a1513c4 = 0;
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0xeea78996, Offset: 0x25c8
// Size: 0x94
function function_94c35cf8() {
    level.var_6412066 = [];
    array::add(level.var_6412066, "cybercom_overdrive");
    array::add(level.var_6412066, "cybercom_concussive");
    array::add(level.var_6412066, "cybercom_unstoppableforce");
    array::add(level.var_6412066, "cybercom_fireflyswarm");
}

// Namespace namespace_fdfaa57d
// Params 1, eflags: 0x1 linked
// Checksum 0x7cfe6e45, Offset: 0x2668
// Size: 0x284
function function_2beeb3b3(upgraded) {
    /#
        assert(isdefined(level.var_6412066) && level.var_6412066.size);
    #/
    abilities = arraycopy(level.var_6412066);
    foreach (ability in level.var_6412066) {
        if (self function_1a9006bd(ability) > 0) {
            arrayremovevalue(abilities, ability);
        }
    }
    if (!isdefined(abilities) || !isarray(abilities) || !abilities.size) {
        abilities = arraycopy(level.var_6412066);
    }
    var_b5725157 = array::random(abilities);
    /#
        if (getdvarstring("cybercoreupgradeddropchance", "cybercoreupgradeddropchance") != "cybercoreupgradeddropchance") {
            var_b5725157 = getdvarstring("cybercoreupgradeddropchance");
        }
    #/
    self cybercom::function_e60e89fe();
    self namespace_d00ec32::function_c219b381();
    if (isdefined(upgraded) && upgraded) {
        self namespace_d00ec32::function_a724d44(var_b5725157, 1);
    } else {
        self namespace_d00ec32::function_a724d44(var_b5725157, 0);
    }
    self namespace_d00ec32::function_eb512967(var_b5725157, 1);
    self thread function_8435cfdc(var_b5725157, upgraded);
}

// Namespace namespace_fdfaa57d
// Params 2, eflags: 0x5 linked
// Checksum 0xf4a6af22, Offset: 0x28f8
// Size: 0xb6
function function_8435cfdc(var_b5725157, upgraded) {
    self endon(#"death");
    self notify(#"hash_8435cfdc");
    self.var_cc7a6101 = 0;
    self.var_db92ee58 = gettime();
    switch (var_b5725157) {
    case 40:
    case 37:
    case 39:
    case 36:
        self thread function_2d73d3d9(upgraded);
        break;
    case 38:
        self thread function_1c087aac(upgraded);
        break;
    }
}

// Namespace namespace_fdfaa57d
// Params 1, eflags: 0x5 linked
// Checksum 0x71515410, Offset: 0x29b8
// Size: 0x172
function function_1c087aac(upgraded) {
    self endon(#"death");
    self endon(#"hash_8435cfdc");
    self notify(#"hash_1c087aac");
    self endon(#"hash_1c087aac");
    /#
        assert(self.var_db92ee58 > 0);
    #/
    if (isdefined(upgraded) && upgraded) {
        var_3c351aaf = self.var_db92ee58 + 60000;
    } else {
        var_3c351aaf = self.var_db92ee58 + 30000;
    }
    while (gettime() < var_3c351aaf) {
        wait(0.1);
    }
    foreach (ability in level.cybercom.abilities) {
        self function_d8df9418(ability.name);
        self namespace_d00ec32::function_1364f13e(ability);
    }
}

// Namespace namespace_fdfaa57d
// Params 1, eflags: 0x5 linked
// Checksum 0x8709eab1, Offset: 0x2b38
// Size: 0x16a
function function_2d73d3d9(upgraded) {
    self endon(#"death");
    self endon(#"hash_8435cfdc");
    self notify(#"hash_2d73d3d9");
    self endon(#"hash_2d73d3d9");
    /#
        assert(self.var_cc7a6101 == 0);
    #/
    if (isdefined(upgraded) && upgraded) {
        var_686e9a14 = 5;
    } else {
        var_686e9a14 = 3;
    }
    while (self.var_cc7a6101 < 3) {
        wait(0.1);
    }
    wait(5);
    foreach (ability in level.cybercom.abilities) {
        self function_d8df9418(ability.name);
        self namespace_d00ec32::function_1364f13e(ability);
    }
}

// Namespace namespace_fdfaa57d
// Params 1, eflags: 0x5 linked
// Checksum 0xce4ea774, Offset: 0x2cb0
// Size: 0x60
function function_26432505(player) {
    /#
        assert(isplayer(player));
    #/
    if (!isdefined(player.var_cc7a6101)) {
        return;
    }
    player.var_cc7a6101++;
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0xd1a15789, Offset: 0x2d18
// Size: 0xda
function give_max_ammo() {
    a_w_weapons = self getweaponslist();
    foreach (w_weapon in a_w_weapons) {
        self givemaxammo(w_weapon);
        self setweaponammoclip(w_weapon, w_weapon.clipsize);
    }
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0x420157fa, Offset: 0x2e00
// Size: 0x148
function function_4827a249() {
    foreach (player in level.activeplayers) {
        a_w_weapons = player getweaponslist();
        foreach (w_weapon in a_w_weapons) {
            player givemaxammo(w_weapon);
            player setweaponammoclip(w_weapon, w_weapon.clipsize);
        }
    }
}

// Namespace namespace_fdfaa57d
// Params 1, eflags: 0x1 linked
// Checksum 0xaf1fe8b0, Offset: 0x2f50
// Size: 0x54
function function_4035ce17(var_638b7f73) {
    /#
        assert(isdefined(var_638b7f73.weaponinfo));
    #/
    self function_43128d49(var_638b7f73.weaponinfo);
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0x20094b06, Offset: 0x2fb0
// Size: 0x1c
function function_f3239cd2() {
    self thread function_4759fbcb();
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0xceacb534, Offset: 0x2fd8
// Size: 0xa0
function function_4759fbcb() {
    self endon(#"hash_19ae9989");
    self endon(#"disconnect");
    self notify(#"hash_2559e9cc");
    self endon(#"hash_2559e9cc");
    self thread function_ac97a368();
    self clientfield::set_to_player("bonuszm_player_instakill_active_fx", 1);
    self.forceanhilateondeath = 1;
    wait(15);
    self clientfield::set_to_player("bonuszm_player_instakill_active_fx", 0);
    self.forceanhilateondeath = 0;
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0x5d74205c, Offset: 0x3080
// Size: 0x76
function function_ac97a368() {
    self endon(#"disconnect");
    self endon(#"hash_2559e9cc");
    self waittill(#"death");
    if (isdefined(self.forceanhilateondeath) && self.forceanhilateondeath) {
        self clientfield::set_to_player("bonuszm_player_instakill_active_fx", 0);
        self.forceanhilateondeath = 0;
        self notify(#"hash_19ae9989");
    }
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0x7b4b67b9, Offset: 0x3100
// Size: 0x8a
function function_9c4468cc() {
    foreach (player in level.players) {
        if (isdefined(self.forceanhilateondeath)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0x5e7797fd, Offset: 0x3198
// Size: 0x22
function function_5fcda3a0() {
    if (isdefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
        return true;
    }
    return false;
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0x420eeffa, Offset: 0x31c8
// Size: 0x2c
function function_c54347ed() {
    if (function_5fcda3a0()) {
        return;
    }
    self thread function_eb0b4e74();
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0xeb69098c, Offset: 0x3200
// Size: 0x6c
function function_eb0b4e74() {
    /#
        assert(!(isdefined(level.bzm_worldpaused) && level.bzm_worldpaused));
    #/
    level endon(#"hash_d864b21a");
    function_3dce4e74();
    wait(8);
    level thread function_1dfabdfa();
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0x3229d65c, Offset: 0x3278
// Size: 0x302
function function_3dce4e74() {
    level.bzm_worldpaused = 1;
    foreach (player in level.activeplayers) {
        player clientfield::set_to_player("bonuszm_player_instakill_active_fx", 1);
        player.forceanhilateondeath = 1;
        player playrumbleonentity("tank_rumble");
    }
    level.var_5860b0ee = spawn("script_origin", (0, 0, 0));
    level.var_5860b0ee playsound("zmb_instakill_upgraded_activate");
    level.var_5860b0ee playloopsound("zmb_instakill_upgraded_loop", 2);
    setslowmotion(1, 1.2, 2);
    wait(2);
    setpauseworld(1);
    if (isdefined(level.heroes) && level.heroes.size) {
        foreach (hero in level.heroes) {
            hero setignorepauseworld(1);
        }
    }
    ais = getaiteamarray("allies");
    if (isdefined(ais) && ais.size) {
        foreach (ai in ais) {
            if (isvehicle(ai)) {
                ai setignorepauseworld(1);
            }
        }
    }
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0x906413b4, Offset: 0x3588
// Size: 0x1b0
function function_1dfabdfa() {
    if (!(isdefined(level.bzm_worldpaused) && level.bzm_worldpaused)) {
        return;
    }
    /#
        assert(isdefined(level.var_5860b0ee));
    #/
    level notify(#"hash_d864b21a");
    level.var_5860b0ee stoploopsound(2);
    level.var_5860b0ee playsound("zmb_instakill_upgraded_deactivate");
    setslowmotion(1.2, 1, 2);
    wait(1);
    setpauseworld(0);
    foreach (player in level.activeplayers) {
        player clientfield::set_to_player("bonuszm_player_instakill_active_fx", 0);
        player.forceanhilateondeath = 0;
        player playrumbleonentity("tank_rumble");
    }
    if (isdefined(level.var_5860b0ee)) {
        level.var_5860b0ee delete();
    }
    level.bzm_worldpaused = 0;
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0x85ea0738, Offset: 0x3740
// Size: 0x136
function function_2a5eb705() {
    while (true) {
        level waittill(#"hash_1c353a4f");
        function_1dfabdfa();
        if (isdefined(level.var_f011cb7c) && isalive(level.var_f011cb7c)) {
            level.var_f011cb7c delete();
        }
        foreach (drop in level.var_c85f5b9b) {
            if (isdefined(drop)) {
                drop thread function_cf8cea5f(0);
            }
        }
        level.var_c85f5b9b = array::remove_undefined(level.var_c85f5b9b);
        level notify(#"hash_cf7497c1");
    }
}

