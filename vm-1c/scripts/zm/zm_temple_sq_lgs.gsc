#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_weap_shrink_ray;
#using scripts/zm/zm_temple_sq;
#using scripts/zm/zm_temple_sq_brock;
#using scripts/zm/zm_temple_sq_skits;

#using_animtree("generic");

#namespace zm_temple_sq_lgs;

// Namespace zm_temple_sq_lgs
// Params 0, eflags: 0x0
// Checksum 0x80503b50, Offset: 0x530
// Size: 0xd4
function init() {
    level flag::init("meteor_impact");
    namespace_6e97c459::function_5a90ed82("sq", "LGS", &init_stage, &function_7747c56, &function_cc3f3f6a);
    namespace_6e97c459::function_b9676730("sq", "LGS", 300);
    namespace_6e97c459::function_9a85e396("sq", "LGS", "sq_lgs_crystal", &function_39419a22);
}

// Namespace zm_temple_sq_lgs
// Params 0, eflags: 0x0
// Checksum 0xce6e87ef, Offset: 0x610
// Size: 0x9c
function init_stage() {
    zm_temple_sq_brock::function_ac4ad5b0();
    level flag::clear("meteor_impact");
    level thread function_d57cb4aa();
    /#
        if (getplayers().size == 1) {
            getplayers()[0] giveweapon(level.var_953f69a0);
        }
    #/
}

// Namespace zm_temple_sq_lgs
// Params 0, eflags: 0x0
// Checksum 0x10a7c695, Offset: 0x6b8
// Size: 0x104
function function_d57cb4aa() {
    exploder::exploder("fxexp_600");
    wait 4;
    level thread function_94d550c3();
    exploder::exploder("fxexp_601");
    level thread zm_temple_sq_skits::function_acc79afb("tt3");
    level thread function_3b28aa09();
    wait 2;
    wait 1.5;
    earthquake(1, 0.8, getplayers()[0].origin, -56);
    wait 1;
    level flag::set("meteor_impact");
}

// Namespace zm_temple_sq_lgs
// Params 0, eflags: 0x0
// Checksum 0x92d0f2e8, Offset: 0x7c8
// Size: 0xa0
function function_3b28aa09() {
    level endon(#"sq_lgs_over");
    wait 2;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i].characterindex == 1) {
            players[i] playsound("evt_sq_lgs_fart");
            return;
        }
    }
}

// Namespace zm_temple_sq_lgs
// Params 0, eflags: 0x0
// Checksum 0xd339e6de, Offset: 0x870
// Size: 0x5c
function function_94d550c3() {
    playsoundatposition("evt_sq_lgs_meteor_incoming", (-1680, -780, -109));
    wait 3.3;
    playsoundatposition("evt_sq_lgs_meteor_impact", (-1229, -1642, -58));
}

// Namespace zm_temple_sq_lgs
// Params 0, eflags: 0x0
// Checksum 0x7880c66d, Offset: 0x8d8
// Size: 0x180
function function_77cc2727() {
    self endon(#"death");
    self endon(#"hash_5aa8f0ca");
    while (true) {
        self waittill(#"damage", amount, attacker, direction, point, var_e5f012d6, modelname, tagname);
        if (var_e5f012d6 == "MOD_PROJECTILE" || var_e5f012d6 == "MOD_PROJECTILE_SPLASH" || var_e5f012d6 == "MOD_EXPLOSIVE" || var_e5f012d6 == "MOD_EXPLOSIVE_SPLASH" || var_e5f012d6 == "MOD_GRENADE" || isplayer(attacker) && var_e5f012d6 == "MOD_GRENADE_SPLASH") {
            self.var_bbca234 notify(#"triggered");
            attacker thread zm_audio::create_and_play_dialog("eggs", "quest3", 1);
            return;
        }
        if (isplayer(attacker)) {
            attacker thread zm_audio::create_and_play_dialog("eggs", "quest3", 2);
        }
    }
}

// Namespace zm_temple_sq_lgs
// Params 0, eflags: 0x0
// Checksum 0xe0a5bdc8, Offset: 0xa60
// Size: 0xdc
function function_2cd963a2() {
    self endon(#"death");
    self endon(#"hash_5aa8f0ca");
    while (true) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (distancesquared(self.origin, players[i].origin) <= 250000) {
                players[i] thread zm_audio::create_and_play_dialog("eggs", "quest3", 0);
                return;
            }
        }
        wait 0.1;
    }
}

// Namespace zm_temple_sq_lgs
// Params 0, eflags: 0x0
// Checksum 0x42980918, Offset: 0xb48
// Size: 0xe8
function function_5738e992() {
    self endon(#"death");
    self endon(#"shrunk");
    while (true) {
        self waittill(#"damage", amount, attacker, direction, point, var_e5f012d6, modelname, tagname);
        if (isplayer(attacker) && var_e5f012d6 == "MOD_MELEE") {
            attacker thread zm_audio::create_and_play_dialog("eggs", "quest3", 3);
            wait 5;
        }
    }
}

// Namespace zm_temple_sq_lgs
// Params 0, eflags: 0x0
// Checksum 0x6f99d187, Offset: 0xc38
// Size: 0xe2
function function_8c4afc8f() {
    self endon(#"death");
    while (true) {
        self waittill(#"damage", amount, attacker, direction, point, var_e5f012d6, modelname, tagname);
        if (isplayer(attacker) && var_e5f012d6 == "MOD_MELEE") {
            self.var_bbca234 notify(#"triggered");
            attacker thread zm_audio::create_and_play_dialog("eggs", "quest3", 6);
            return;
        }
    }
}

// Namespace zm_temple_sq_lgs
// Params 1, eflags: 0x0
// Checksum 0x3c212c22, Offset: 0xd28
// Size: 0x23a
function function_d34f877c(ent) {
    if (!level flag::get("waterslide_open")) {
        self endon(#"death");
        self endon(#"reached_end_node");
        while (true) {
            self waittill(#"reached_node", node);
            if (isdefined(node.script_noteworthy) && node.script_noteworthy == "pre_gate") {
                if (!level flag::get("waterslide_open")) {
                    players = getplayers();
                    for (i = 0; i < players.size; i++) {
                        if (distancesquared(self.origin, players[i].origin) <= 250000) {
                            players[i] thread zm_audio::create_and_play_dialog("eggs", "quest3", 7);
                        }
                    }
                    self.var_154ff036 stopanimscripted();
                    while (!level flag::get("waterslide_open")) {
                        self setspeedimmediate(0);
                        wait 0.05;
                    }
                    wait 0.5;
                    self.var_154ff036 animscripted("spin", self.var_154ff036.origin, self.var_154ff036.angles, "p7_fxanim_zm_sha_crystal_sml_anim");
                    self resumespeed(12);
                    return;
                }
            }
        }
    }
}

// Namespace zm_temple_sq_lgs
// Params 1, eflags: 0x0
// Checksum 0x6d34d502, Offset: 0xf70
// Size: 0xc0
function function_2447395b(ent) {
    self endon(#"death");
    while (true) {
        self waittill(#"reached_node", node);
        if (isdefined(node.script_int)) {
            if (node.script_int == 1) {
                ent clientfield::set("watertrail", 1);
                continue;
            }
            if (node.script_int == 0) {
                ent clientfield::set("watertrail", 0);
            }
        }
    }
}

// Namespace zm_temple_sq_lgs
// Params 0, eflags: 0x0
// Checksum 0x3672c023, Offset: 0x1038
// Size: 0x74
function function_c7e74d12() {
    self endon(#"triggered");
    level endon(#"end_game");
    exploder::exploder("fxexp_602");
    level util::waittill_any("sq_lgs_over", "sq_lgs_failed");
    exploder::stop_exploder("fxexp_602");
}

// Namespace zm_temple_sq_lgs
// Params 0, eflags: 0x0
// Checksum 0x4e25620, Offset: 0x10b8
// Size: 0xb0c
function function_39419a22() {
    self endon(#"death");
    self ghost();
    self.trigger = getent("sq_lgs_crystal_trig", "targetname");
    self.trigger.var_b82c7478 = 1;
    self.trigger.origin = self.origin;
    self.trigger.var_d5784b10 = self.trigger.origin;
    self.trigger.var_bbca234 = self;
    self.trigger notsolid();
    self.trigger.takedamage = 0;
    level flag::wait_till("meteor_impact");
    self show();
    self.trigger solid();
    self.trigger.takedamage = 1;
    self.trigger thread function_77cc2727();
    self.trigger thread function_2cd963a2();
    self thread function_c7e74d12();
    self waittill(#"triggered");
    self.trigger notify(#"hash_5aa8f0ca");
    exploder::stop_exploder("fxexp_602");
    self playsound("evt_sq_lgs_crystal_pry");
    for (target = self.target; isdefined(target); target = struct.target) {
        struct = struct::get(target, "targetname");
        if (isdefined(struct.script_parameters)) {
            time = float(struct.script_parameters);
        } else {
            time = 1;
        }
        self moveto(struct.origin, time, time / 10);
        self waittill(#"movedone");
        self playsound("evt_sq_lgs_crystal_hit1");
    }
    self playsound("evt_sq_lgs_crystal_land");
    self.trigger.origin = self.origin;
    self.trigger thread function_5738e992();
    zm_weap_shrink_ray::function_80738220(self);
    self waittill(#"shrunk");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        currentweapon = players[i] getcurrentweapon();
        if (currentweapon == level.var_f812085 || currentweapon == level.var_953f69a0) {
            players[i] thread zm_audio::create_and_play_dialog("eggs", "quest3", 4);
        }
    }
    self playsound("evt_sq_lgs_crystal_shrink");
    self setmodel("p7_fxanim_zm_sha_crystal_sml_mod");
    var_b377b7fd = getvehiclenode("sq_lgs_node_start", "targetname");
    self.origin = var_b377b7fd.origin;
    self.trigger notify(#"shrunk");
    zm_weap_shrink_ray::function_d705d94f(self);
    self.trigger thread function_8c4afc8f();
    self waittill(#"triggered");
    self playsound("evt_sq_lgs_crystal_knife");
    self playloopsound("evt_sq_lgs_crystal_roll", 2);
    self.trigger.origin = self.trigger.var_d5784b10;
    self.trigger notsolid();
    self.trigger.takedamage = 0;
    self notsolid();
    self useanimtree(#generic);
    self.animname = "crystal";
    vehicle = getent("crystal_mover", "targetname");
    vehicle.origin = self.origin;
    vehicle.angles = self.angles;
    vehicle.var_154ff036 = self;
    level.var_2c1526e6 = vehicle;
    util::wait_network_frame();
    origin_animate = util::spawn_model("tag_origin_animate", vehicle.origin);
    self linkto(origin_animate, "origin_animate_jnt", (0, 0, 0), (90, 0, 0));
    origin_animate linkto(vehicle);
    self animscripted("spin", self.origin, self.angles, "p7_fxanim_zm_sha_crystal_sml_anim");
    vehicle vehicle::get_on_and_go_path("sq_lgs_node_start");
    vehicle.var_82ce4d7e = origin_animate;
    vehicle thread function_2447395b(self);
    vehicle thread function_d34f877c(self);
    vehicle waittill(#"reached_end_node");
    self stopanimscripted();
    self unlink();
    self stoploopsound();
    self playsound("evt_sq_lgs_crystal_land_2");
    vehicle delete();
    origin_animate delete();
    self thread function_261167c();
    level flag::wait_till("minecart_geyser_active");
    self notify(#"hash_9a6903c0");
    self clientfield::set("watertrail", 1);
    self moveto(self.origin + (0, 0, 4000), 2, 0.1);
    level notify(#"hash_bd6f486d");
    level notify(#"hash_15ab69d8");
    level notify(#"hash_87b2d913");
    level notify(#"hash_61b05eaa", 1);
    level waittill(#"hash_18e4f2bc");
    self clientfield::set("watertrail", 0);
    wait 2;
    holder = getent("empty_holder", "script_noteworthy");
    self.origin = (holder.origin[0], holder.origin[1], self.origin[2]);
    self setmodel("p7_zm_sha_crystal");
    playsoundatposition("evt_sq_lgs_crystal_incoming", (holder.origin[0], holder.origin[1], holder.origin[2] + -122));
    self moveto((holder.origin[0], holder.origin[1], holder.origin[2] + -122), 2);
    self waittill(#"movedone");
    self playsound("evt_sq_lgs_crystal_landinholder");
    players = getplayers();
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("eggs", "quest3", 8);
    level notify(#"hash_93d9795e");
    self ghost();
    wait 5;
    namespace_6e97c459::function_2f3ced1f("sq", "LGS");
}

// Namespace zm_temple_sq_lgs
// Params 0, eflags: 0x0
// Checksum 0x9486057b, Offset: 0x1bd0
// Size: 0xc6
function function_c11e3494() {
    self endon(#"death");
    self endon(#"hash_9a6903c0");
    while (true) {
        t = randomfloatrange(0.2, 0.8);
        self rotateto((-76 + randomfloat(-76), 300 + randomfloat(60), -76 + randomfloat(-76)), t);
        wait t;
    }
}

// Namespace zm_temple_sq_lgs
// Params 0, eflags: 0x0
// Checksum 0x43e7b0c7, Offset: 0x1ca0
// Size: 0x17c
function function_261167c() {
    self endon(#"death");
    self endon(#"hash_9a6903c0");
    self thread function_c11e3494();
    node = getvehiclenode("crystal_end", "script_noteworthy");
    var_c918aff3 = node.origin + (0, 0, 4);
    var_40872fa9 = var_c918aff3 + (0, 0, 3);
    while (true) {
        self moveto(var_40872fa9 + (0, 0, randomfloat(3)), 0.2 + randomfloat(0.1), 0.1);
        self waittill(#"movedone");
        self moveto(var_c918aff3 + (0, 0, randomfloat(5)), 0.05 + randomfloat(0.07), 0, 0.03);
        self waittill(#"movedone");
    }
}

// Namespace zm_temple_sq_lgs
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1e28
// Size: 0x4
function function_7747c56() {
    
}

// Namespace zm_temple_sq_lgs
// Params 1, eflags: 0x0
// Checksum 0xf59f6b2f, Offset: 0x1e38
// Size: 0xc4
function function_cc3f3f6a(success) {
    if (isdefined(level.var_2c1526e6)) {
        if (isdefined(level.var_2c1526e6.var_82ce4d7e)) {
            level.var_2c1526e6.var_82ce4d7e delete();
        }
        level.var_2c1526e6 delete();
    }
    level.var_2c1526e6 = undefined;
    if (success) {
        zm_temple_sq_brock::function_67e052f1(4, &zm_temple_sq_brock::function_4b89aecd);
        return;
    }
    zm_temple_sq_brock::function_67e052f1(3);
    level thread zm_temple_sq_skits::function_b6268f3d();
}

