#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_54a425fe;

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x670b28c1, Offset: 0x700
// Size: 0x174
function main() {
    audio::snd_set_snapshot("cmn_fade_in");
    level.var_3e9ce4b5 = undefined;
    level thread function_af7b8418("water");
    level thread function_af7b8418("fire");
    level thread function_af7b8418("air");
    level thread function_af7b8418("lightning");
    setsoundcontext("train", "tunnel");
    level.var_da1a3c87 = &function_da1a3c87;
    function_6cc11add();
    level thread function_714746a6();
    thread function_3f26c2a4();
    level thread function_ee449b54();
    level thread function_c9207335();
    level thread function_c052f9b8();
    level thread startzmbspawnersoundloops();
}

// Namespace namespace_54a425fe
// Params 1, eflags: 0x1 linked
// Checksum 0x93928687, Offset: 0x880
// Size: 0xb0
function function_af7b8418(str_name) {
    if (!isdefined(level.var_c27b47a)) {
        level.var_c27b47a = [];
    }
    if (!isdefined(level.var_c27b47a[str_name])) {
        level.var_c27b47a[str_name] = 1;
    }
    level waittill("snd" + str_name);
    level.var_c27b47a[str_name] = 0;
    if (isdefined(level.var_8f027e99[str_name])) {
        stopfx(0, level.var_8f027e99[str_name]);
        level.var_8f027e99[str_name] = undefined;
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x18477a54, Offset: 0x938
// Size: 0x74
function function_c9207335() {
    wait(3);
    level thread function_d667714e();
    var_13a52dfe = getentarray(0, "sndMusicTrig", "targetname");
    array::thread_all(var_13a52dfe, &function_60a32834);
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x3c7f9978, Offset: 0x9b8
// Size: 0xb4
function function_60a32834() {
    while (true) {
        trigplayer = self waittill(#"trigger");
        if (trigplayer islocalplayer()) {
            level notify(#"hash_51d7bc7c", self.script_sound);
            self thread function_89793e8f();
            while (isdefined(trigplayer) && trigplayer istouching(self)) {
                wait(0.016);
            }
            self notify(#"hash_ae459976");
            continue;
        }
        wait(0.016);
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x2c09ab09, Offset: 0xa78
// Size: 0xf8
function function_d667714e() {
    level.var_b6342abd = "mus_tomb_underscore_null";
    level.var_6d9d81aa = "mus_tomb_underscore_null";
    level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
    level.var_9433cf5a = level.var_eb526c90 playloopsound(level.var_b6342abd, 2);
    while (true) {
        location = level waittill(#"hash_51d7bc7c");
        level.var_6d9d81aa = "mus_tomb_underscore_" + location;
        if (level.var_6d9d81aa != level.var_b6342abd) {
            level thread function_b234849(level.var_6d9d81aa);
            level.var_b6342abd = level.var_6d9d81aa;
        }
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x4b699896, Offset: 0xb78
// Size: 0x56
function function_89793e8f() {
    self notify(#"hash_6c4e5e2e");
    self endon(#"hash_6c4e5e2e");
    level endon(#"hash_51d7bc7c");
    self waittill(#"hash_ae459976");
    wait(0.1);
    level notify(#"hash_51d7bc7c", "null");
}

// Namespace namespace_54a425fe
// Params 1, eflags: 0x1 linked
// Checksum 0x6c78fcb3, Offset: 0xbd8
// Size: 0x64
function function_b234849(var_6d9d81aa) {
    level endon(#"hash_51d7bc7c");
    level.var_eb526c90 stopallloopsounds(2);
    wait(1);
    level.var_9433cf5a = level.var_eb526c90 playloopsound(var_6d9d81aa, 2);
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x3468e135, Offset: 0xc48
// Size: 0xd0
function function_c052f9b8() {
    while (true) {
        level waittill(#"hash_f099c69d");
        if (isdefined(level.var_1c69bb12.var_b13d6dfb) && level.var_1c69bb12.var_b13d6dfb) {
            setsoundcontext("train", "country");
            continue;
        }
        if (isdefined(level.var_1c69bb12.var_308c43c8) && level.var_1c69bb12.var_308c43c8) {
            setsoundcontext("train", "city");
            continue;
        }
        setsoundcontext("train", "tunnel");
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x4ad49724, Offset: 0xd20
// Size: 0x44
function function_33be1969() {
    level.var_1c69bb12 = spawnstruct();
    level.var_1c69bb12.var_b13d6dfb = 0;
    level.var_1c69bb12.var_308c43c8 = 0;
}

// Namespace namespace_54a425fe
// Params 2, eflags: 0x1 linked
// Checksum 0xde974e92, Offset: 0xd70
// Size: 0x96
function function_da1a3c87(room, player) {
    switch (room) {
    case 19:
    case 20:
    case 21:
    case 22:
        setsoundcontext("grass", "in_grass");
        break;
    default:
        setsoundcontext("grass", "no_grass");
        break;
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x0
// Checksum 0xbea9063c, Offset: 0xe10
// Size: 0xea
function function_6fae68d7() {
    trigs = getentarray(0, "sndCaptureZone", "targetname");
    if (isdefined(trigs)) {
        foreach (trig in trigs) {
            trig.players = 0;
            trig.active = 0;
            trig thread function_6576aaa4();
        }
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0xb35220d4, Offset: 0xf08
// Size: 0xf0
function function_6576aaa4() {
    self thread function_74c85975();
    while (true) {
        who = self waittill(#"trigger");
        if (who isplayer() && !(isdefined(who.var_c7721e47) && who.var_c7721e47)) {
            self.players++;
            who.var_c7721e47 = 1;
            self thread function_8e8fcdfc(who);
            if (!self.active) {
                self.active = 1;
                self thread function_3abd927c();
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_54a425fe
// Params 1, eflags: 0x1 linked
// Checksum 0x14170cf6, Offset: 0x1000
// Size: 0x76
function function_8e8fcdfc(player) {
    while (isdefined(self) && isdefined(player) && player istouching(self)) {
        wait(0.1);
    }
    self.players--;
    if (isdefined(player)) {
        player.var_c7721e47 = 0;
    }
    self notify(#"hash_961b140e");
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x26cd2e68, Offset: 0x1080
// Size: 0xb4
function function_3abd927c() {
    playsound(0, "zmb_zone_plate_down", self.origin);
    self.var_5ad6cc0c = self playloopsound("zmb_zone_plate_loop", 2);
    self waittill(#"hash_8cd1836c");
    self.active = 0;
    self stoploopsound(self.var_5ad6cc0c);
    playsound(0, "zmb_zone_plate_up", self.origin);
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0xa2cc9afd, Offset: 0x1140
// Size: 0x42
function function_74c85975() {
    while (true) {
        self waittill(#"hash_961b140e");
        if (self.players <= 0) {
            self.players = 0;
            self notify(#"hash_8cd1836c");
        }
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x4bac2fd1, Offset: 0x1190
// Size: 0x7c
function function_6cc11add() {
    level.var_8f027e99 = array();
    clientfield::register("toplayer", "sndEggElements", 21000, 1, "int", &function_3599b48b, 0, 0);
    level.sndchargeshot_func = &function_6442a8c2;
}

// Namespace namespace_54a425fe
// Params 7, eflags: 0x1 linked
// Checksum 0xc0c165a3, Offset: 0x1218
// Size: 0x7c
function function_ec990408(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        audio::playloopat(fieldname, (0, 0, 0));
        return;
    }
    audio::stoploopat(fieldname, (0, 0, 0));
}

// Namespace namespace_54a425fe
// Params 7, eflags: 0x1 linked
// Checksum 0x5f53cfe8, Offset: 0x12a0
// Size: 0x2da
function function_3599b48b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    var_92c47b0e = struct::get_array("s_zhdegg_elements", "targetname");
    if (!isdefined(level.var_8f027e99)) {
        level.var_8f027e99 = array();
    }
    if (newval) {
        foreach (s_struct in var_92c47b0e) {
            str_element = s_struct.script_string;
            if (s_struct.script_string == "lightning") {
                str_element = "elec";
            }
            if (s_struct.script_string == "water") {
                str_element = "ice";
            }
            if (isdefined(level.var_c27b47a[s_struct.script_string]) && level.var_c27b47a[s_struct.script_string]) {
                if (isdefined(level.var_8f027e99[s_struct.script_string])) {
                    stopfx(localclientnum, level.var_8f027e99[s_struct.script_string]);
                }
                level.var_8f027e99[s_struct.script_string] = playfx(localclientnum, level._effect[str_element + "_glow"], s_struct.origin);
            }
        }
        return;
    }
    foreach (fxid in level.var_8f027e99) {
        stopfx(localclientnum, fxid);
        fxid = undefined;
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x7c01cae4, Offset: 0x1588
// Size: 0x34
function function_714746a6() {
    thread function_113b7a0a();
    thread function_81bedf7d();
    thread function_57a479e1();
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x23d0890e, Offset: 0x15c8
// Size: 0xf4
function function_113b7a0a() {
    audio::snd_play_auto_fx("fx_tomb_fire_sm", "amb_fire_sm", 0, 0, 0, 0);
    audio::snd_play_auto_fx("fx_tomb_fire_lg", "amb_fire_lg", 0, 0, 0, 0);
    audio::snd_play_auto_fx("fx_tomb_steam_md", "amb_pipe_steam_md", 0, 0, 0, 0);
    audio::snd_play_auto_fx("fx_tomb_light_expensive", "amb_main_light", 0, 0, 0, 0);
    audio::snd_play_auto_fx("fx_tomb_light_lg", "amb_light_lrg", 0, 0, 0, 0);
    audio::snd_play_auto_fx("fx_tomb_light_md", "amb_light_md", 0, 0, 0, 0);
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0xd3f6e262, Offset: 0x16c8
// Size: 0x50
function function_81bedf7d() {
    while (true) {
        playsound(0, "amb_flyover", (1310, 859, 3064));
        wait(randomintrange(2, 8));
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x6660265f, Offset: 0x1720
// Size: 0x54
function function_57a479e1() {
    audio::playloopat("amb_dist_battle_front", (-2492, 1263, 691));
    audio::playloopat("amb_dist_battle_back", (4190, -1050, 910));
}

// Namespace namespace_54a425fe
// Params 7, eflags: 0x1 linked
// Checksum 0xce72d353, Offset: 0x1780
// Size: 0x94
function function_8189f66f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (!isspectating(localclientnum, 0)) {
        if (newval == 1) {
            self thread function_c85630a7();
            return;
        }
        self thread function_555b3a00();
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0xcd801760, Offset: 0x1820
// Size: 0x160
function function_c85630a7() {
    self endon(#"hash_ed11651a");
    self endon(#"entityshutdown");
    if (!isdefined(self.var_29fe0572)) {
        self.var_29fe0572 = spawn(0, self.origin, "script_origin");
        self.var_29fe0572 linkto(self, "tag_origin");
    }
    self.var_29fe0572.var_8d8259d3 = self.var_29fe0572 playloopsound("zmb_tomb_slowed_movement_loop", 1);
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        var_3ec2ad89 = abs(self getspeed());
        var_fef3a6cb = audio::scale_speed(21, 285, 0.01, 1, var_3ec2ad89);
        self.var_29fe0572 setloopstate("zmb_tomb_slowed_movement_loop", var_fef3a6cb, 1);
        wait(0.1);
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0xc12ee60, Offset: 0x1988
// Size: 0x52
function function_555b3a00() {
    self notify(#"hash_ed11651a");
    self.var_29fe0572 stoploopsound(self.var_29fe0572.var_8d8259d3, 1.5);
    self.var_29fe0572.var_8d8259d3 = undefined;
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0xb07b2d44, Offset: 0x19e8
// Size: 0x15c
function init() {
    level._entityshutdowncbfunc = &heli_linkto_sound_ents_delete;
    level.helisoundvalues = [];
    init_heli_sound_values("qrdrone", "turbine_idle", 30, 0.8, 0, 16, 0.9, 1.1);
    init_heli_sound_values("qrdrone", "turbine_moving", 30, 0, 0.9, 20, 0.9, 1.1);
    init_heli_sound_values("qrdrone", "turn", 5, 0, 1, 1, 1, 1);
    /#
        if (getdvarstring("targetname") == "targetname") {
            setdvar("targetname", "targetname");
        }
        level thread command_parser();
    #/
}

// Namespace namespace_54a425fe
// Params 8, eflags: 0x1 linked
// Checksum 0x71bc7015, Offset: 0x1b50
// Size: 0x28c
function init_heli_sound_values(heli_type, part_type, max_speed_vol, min_vol, max_vol, max_speed_pitch, min_pitch, max_pitch) {
    if (!isdefined(level.helisoundvalues[heli_type])) {
        level.helisoundvalues[heli_type] = [];
    }
    if (!isdefined(level.helisoundvalues[heli_type][part_type])) {
        level.helisoundvalues[heli_type][part_type] = spawnstruct();
    }
    level.helisoundvalues[heli_type][part_type].speedvolumemax = max_speed_vol;
    level.helisoundvalues[heli_type][part_type].speedpitchmax = max_speed_pitch;
    level.helisoundvalues[heli_type][part_type].volumemin = min_vol;
    level.helisoundvalues[heli_type][part_type].volumemax = max_vol;
    level.helisoundvalues[heli_type][part_type].pitchmin = min_pitch;
    level.helisoundvalues[heli_type][part_type].pitchmax = max_pitch;
    /#
        if (getdvarint("targetname") > 0) {
            println("targetname" + heli_type);
            println("targetname" + part_type);
            println("targetname" + max_speed_vol);
            println("targetname" + min_vol);
            println("targetname" + max_vol);
            println("targetname" + max_speed_pitch);
            println("targetname" + min_pitch);
            println("targetname" + max_pitch);
        }
    #/
}

/#

    // Namespace namespace_54a425fe
    // Params 0, eflags: 0x1 linked
    // Checksum 0x859507f9, Offset: 0x1de8
    // Size: 0x558
    function command_parser() {
        while (true) {
            command = getdvarstring("targetname");
            if (command != "targetname") {
                success = 1;
                tokens = strtok(command, "targetname");
                if (!isdefined(tokens[0]) || !isdefined(level.helisoundvalues[tokens[0]])) {
                    if (isdefined(tokens[0])) {
                        println("targetname" + tokens[0]);
                    } else {
                        println("targetname");
                    }
                    println("targetname");
                    success = 0;
                } else if (!isdefined(tokens[1])) {
                    if (isdefined(tokens[1])) {
                        println("targetname" + tokens[0] + "targetname" + tokens[1]);
                    } else {
                        println("targetname" + tokens[0]);
                    }
                    println("targetname");
                    success = 0;
                } else if (!isdefined(tokens[2])) {
                    println("targetname" + tokens[0] + "targetname" + tokens[1]);
                    println("targetname");
                    success = 0;
                } else if (!isdefined(tokens[3])) {
                    println("targetname" + tokens[0] + "targetname" + tokens[1]);
                    println("targetname");
                    success = 0;
                }
                if (success) {
                    heli_type = tokens[0];
                    heli_part = tokens[1];
                    value_name = tokens[2];
                    value = float(tokens[3]);
                    switch (value_name) {
                    case 8:
                        level.helisoundvalues[heli_type][heli_part].volumemin = value;
                        println("targetname" + value);
                        break;
                    case 8:
                        level.helisoundvalues[heli_type][heli_part].volumemax = value;
                        println("targetname" + value);
                        break;
                    case 8:
                        level.helisoundvalues[heli_type][heli_part].pitchmin = value;
                        println("targetname" + value);
                        break;
                    case 8:
                        level.helisoundvalues[heli_type][heli_part].pitchmax = value;
                        println("targetname" + value);
                        break;
                    case 8:
                        level.helisoundvalues[heli_type][heli_part].speedvolumemax = value;
                        println("targetname" + value);
                        break;
                    case 8:
                        level.helisoundvalues[heli_type][heli_part].speedpitchmax = value;
                        println("targetname" + value);
                        break;
                    default:
                        println("targetname");
                        break;
                    }
                }
                setdvar("targetname", "targetname");
            }
            wait(0.1);
        }
    }

#/

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0xcab746f0, Offset: 0x2348
// Size: 0x9e
function init_heli_sounds_player_drone() {
    setup_heli_sounds("turbine_idle", "engine", "tag_body", "veh_qrdrone_turbine_idle");
    setup_heli_sounds("turbine_moving", "engine", "tag_body", "veh_qrdrone_turbine_moving");
    setup_heli_sounds("turn", "engine", "tag_body", "veh_qrdrone_idle_rotate");
    self.warning_tag = undefined;
}

// Namespace namespace_54a425fe
// Params 2, eflags: 0x1 linked
// Checksum 0xfaa1fc99, Offset: 0x23f0
// Size: 0x64
function sound_linkto(parent, tag) {
    if (isdefined(tag)) {
        self linkto(parent, tag);
        return;
    }
    self linkto(parent, "tag_body");
}

// Namespace namespace_54a425fe
// Params 7, eflags: 0x1 linked
// Checksum 0x3043b00d, Offset: 0x2460
// Size: 0x38c
function setup_heli_sounds(bone_location, type, tag, run, dmg1, dmg2, dmg3) {
    self.heli[bone_location] = spawnstruct();
    self.heli[bone_location].sound_type = type;
    self.heli[bone_location].run = spawn(0, self.origin, "script_origin");
    self.heli[bone_location].run sound_linkto(self, tag);
    self.heli[bone_location].run.alias = run;
    self thread heli_loop_sound_delete(self.heli[bone_location].run);
    if (isdefined(dmg1)) {
        self.heli[bone_location].idle = spawn(0, self.origin, "script_origin");
        self.heli[bone_location].idle sound_linkto(self, tag);
        self.heli[bone_location].idle.alias = dmg1;
        self thread heli_loop_sound_delete(self.heli[bone_location].dmg1);
    }
    if (isdefined(dmg2)) {
        self.heli[bone_location].idle = spawn(0, self.origin, "script_origin");
        self.heli[bone_location].idle sound_linkto(self, tag);
        self.heli[bone_location].idle.alias = dmg2;
        self thread heli_loop_sound_delete(self.heli[bone_location].dmg2);
    }
    if (isdefined(dmg3)) {
        self.heli[bone_location].idle = spawn(0, self.origin, "script_origin");
        self.heli[bone_location].idle sound_linkto(self, tag);
        self.heli[bone_location].idle.alias = dmg3;
        self thread heli_loop_sound_delete(self.heli[bone_location].dmg3);
    }
}

// Namespace namespace_54a425fe
// Params 1, eflags: 0x1 linked
// Checksum 0x91a39c03, Offset: 0x27f8
// Size: 0x9c
function start_helicopter_sounds(localclientnum) {
    if (isdefined(self.vehicletype)) {
        self.heli = [];
        self.terrain = [];
        self.sound_ents = [];
        self.cur_speed = 0;
        self.mph_to_inches_per_sec = 17.6;
        self.speed_of_wind = 20;
        self.idle_run_trans_speed = 5;
        self init_heli_sounds_player_drone();
        self play_player_drone_sounds();
    }
}

// Namespace namespace_54a425fe
// Params 1, eflags: 0x1 linked
// Checksum 0xee5e2368, Offset: 0x28a0
// Size: 0x5c
function heli_loop_sound_delete(real_ent) {
    self waittill(#"entityshutdown");
    real_ent unlink();
    real_ent stoploopsound(4);
    real_ent delete();
}

// Namespace namespace_54a425fe
// Params 2, eflags: 0x1 linked
// Checksum 0xe774fae6, Offset: 0x2908
// Size: 0x24
function heli_linkto_sound_ents_delete(localclientnum, entity) {
    entity notify(#"entityshutdown");
}

// Namespace namespace_54a425fe
// Params 1, eflags: 0x0
// Checksum 0x1d828fd9, Offset: 0x2938
// Size: 0xbe
function heli_sound_play(heli_bone) {
    switch (heli_bone.sound_type) {
    case 57:
        heli_bone.run playloopsound(heli_bone.run.alias, 2);
        break;
    case 60:
        break;
    default:
        println("targetname" + heli_bone.type + "targetname");
        break;
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x72ce6f4a, Offset: 0x2a00
// Size: 0xa4
function play_player_drone_sounds() {
    self thread heli_idle_run_transition("qrdrone", "turbine_idle", 0.1, 1);
    self thread heli_idle_run_transition("qrdrone", "turbine_moving", 0.1, 1);
    self thread drone_up_down_transition();
    self thread drone_rotate_angle("qrdrone", "turn");
}

// Namespace namespace_54a425fe
// Params 4, eflags: 0x1 linked
// Checksum 0xfa93c1e9, Offset: 0x2ab0
// Size: 0x45e
function heli_idle_run_transition(heli_type, heli_part, wait_time, updown) {
    self endon(#"entityshutdown");
    heli_bone = self.heli[heli_part];
    run_id = heli_bone.run playloopsound(heli_bone.run.alias, 0.5);
    if (!isdefined(wait_time)) {
        wait_time = 0.5;
    }
    while (isdefined(self)) {
        if (!isdefined(level.helisoundvalues[heli_type]) || !isdefined(level.helisoundvalues[heli_type][heli_part])) {
            println("targetname");
            return;
        }
        max_speed_vol = level.helisoundvalues[heli_type][heli_part].speedvolumemax;
        min_vol = level.helisoundvalues[heli_type][heli_part].volumemin;
        max_vol = level.helisoundvalues[heli_type][heli_part].volumemax;
        max_speed_pitch = level.helisoundvalues[heli_type][heli_part].speedpitchmax;
        min_pitch = level.helisoundvalues[heli_type][heli_part].pitchmin;
        max_pitch = level.helisoundvalues[heli_type][heli_part].pitchmax;
        plr_vel = self getvelocity();
        self.cur_speed = abs(sqrt(vectordot(plr_vel, plr_vel))) / self.mph_to_inches_per_sec;
        run_volume = audio::scale_speed(self.idle_run_trans_speed, max_speed_vol, min_vol, max_vol, self.cur_speed);
        run_pitch = audio::scale_speed(self.idle_run_trans_speed, max_speed_pitch, min_pitch, max_pitch, self.cur_speed);
        if (isdefined(updown)) {
            if (!isdefined(self.qrdrone_z_difference)) {
                self.qrdrone_z_difference = 0;
            }
            run_volume_vertical = audio::scale_speed(5, 50, 0, 1, abs(self.qrdrone_z_difference));
            run_volume -= run_volume_vertical;
        }
        if (isdefined(run_volume) && isdefined(run_pitch)) {
            heli_bone.run setloopstate(heli_bone.run.alias, run_volume, run_pitch, 1, 0.15);
            /#
                if (getdvarint("targetname") > 0) {
                    println("targetname" + self.cur_speed);
                    println("targetname" + run_pitch);
                    println("targetname" + self.cur_speed);
                    println("targetname" + run_volume);
                }
            #/
        }
        wait(wait_time);
    }
}

// Namespace namespace_54a425fe
// Params 1, eflags: 0x1 linked
// Checksum 0x52705573, Offset: 0x2f18
// Size: 0xb0
function get_heli_sound_ent(sound_ent) {
    if (!isdefined(sound_ent)) {
        tag = "tag_origin";
        if (isdefined(self.warning_tag)) {
            tag = self.warning_tag;
        }
        sound_ent = spawn(0, self gettagorigin(tag), "script_origin");
        sound_ent linkto(self, tag);
        self thread heli_sound_ent_delete(sound_ent);
    }
    return sound_ent;
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x0
// Checksum 0x86ee9b2c, Offset: 0x2fd0
// Size: 0x2a
function get_lock_sound_ent() {
    self.lock_sound_ent = get_heli_sound_ent(self.lock_sound_ent);
    return self.lock_sound_ent;
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x0
// Checksum 0x5bab6901, Offset: 0x3008
// Size: 0x2a
function get_leaving_sound_ent() {
    self.leaving_sound_ent = get_heli_sound_ent(self.leaving_sound_ent);
    return self.leaving_sound_ent;
}

// Namespace namespace_54a425fe
// Params 1, eflags: 0x1 linked
// Checksum 0x89d568e7, Offset: 0x3040
// Size: 0x4c
function heli_sound_ent_delete(real_ent) {
    self waittill(#"entityshutdown");
    real_ent stoploopsound(0.1);
    real_ent delete();
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0xf4bdb435, Offset: 0x3098
// Size: 0x528
function drone_up_down_transition() {
    self endon(#"entityshutdown");
    volumerate = 1;
    qr_ent_up = spawn(0, self.origin, "script_origin");
    qr_ent_down = spawn(0, self.origin, "script_origin");
    qr_ent_either = spawn(0, self.origin, "script_origin");
    qr_ent_up thread qr_ent_cleanup(self);
    qr_ent_down thread qr_ent_cleanup(self);
    qr_ent_either thread qr_ent_cleanup(self);
    self.qrdrone_z_difference = 0;
    down = qr_ent_down playloopsound("veh_qrdrone_move_down");
    qr_ent_down setloopstate("veh_qrdrone_move_down", 0, 0);
    up = qr_ent_up playloopsound("veh_qrdrone_move_up");
    qr_ent_up setloopstate("veh_qrdrone_move_up", 0, 0);
    either = qr_ent_either playloopsound("veh_qrdrone_vertical");
    qr_ent_either setloopstate("veh_qrdrone_vertical", 0, 0);
    tag = "tag_body";
    qr_ent_up linkto(self, tag);
    qr_ent_down linkto(self, tag);
    qr_ent_either linkto(self, tag);
    self thread drone_button_watch();
    while (true) {
        last_pos = self.origin[2];
        wait(0.1);
        self.qrdrone_z_difference = last_pos - self.origin[2];
        if (self.qrdrone_z_difference < 0) {
            up_difference = self.qrdrone_z_difference * -1;
            run_volume_up = audio::scale_speed(5, 40, 0, 1, up_difference);
            run_pitch_up = audio::scale_speed(5, 40, 0.9, 1.1, up_difference);
            run_volume_either = audio::scale_speed(5, 50, 0, 1, up_difference);
            run_pitch_either = audio::scale_speed(5, 50, 0.9, 1.1, up_difference);
        } else {
            run_volume_up = 0;
            run_pitch_up = 1;
            run_volume_either = audio::scale_speed(5, 50, 0, 1, self.qrdrone_z_difference);
            run_pitch_either = audio::scale_speed(5, 50, 0.95, 0.8, self.qrdrone_z_difference);
        }
        run_volume_down = audio::scale_speed(5, 50, 0, 1, self.qrdrone_z_difference);
        run_pitch_down = audio::scale_speed(5, 50, 1, 0.8, self.qrdrone_z_difference);
        qr_ent_down setloopstate("veh_qrdrone_move_down", run_volume_down, run_pitch_down, volumerate);
        qr_ent_up setloopstate("veh_qrdrone_move_up", run_volume_up, run_pitch_up, volumerate);
        qr_ent_either setloopstate("veh_qrdrone_vertical", run_volume_either, run_pitch_either, volumerate);
    }
}

// Namespace namespace_54a425fe
// Params 1, eflags: 0x1 linked
// Checksum 0x6100c9d0, Offset: 0x35c8
// Size: 0x2c
function qr_ent_cleanup(veh_ent) {
    veh_ent waittill(#"entityshutdown");
    self delete();
}

// Namespace namespace_54a425fe
// Params 2, eflags: 0x1 linked
// Checksum 0xf0b8915e, Offset: 0x3600
// Size: 0x230
function drone_rotate_angle(heli_type, heli_part) {
    self endon(#"entityshutdown");
    level endon(#"save_restore");
    volumerate = 2.5;
    qr_ent_angle = spawn(0, self.origin, "script_origin");
    qr_ent_angle thread qr_ent_cleanup(self);
    angle = qr_ent_angle playloopsound("veh_qrdrone_idle_rotate");
    setsoundvolume(angle, 0);
    tag = "tag_body";
    qr_ent_angle linkto(self, tag);
    while (true) {
        last_angle = abs(self.angles[1]);
        wait(0.1);
        turning_speed = last_angle - abs(self.angles[1]);
        abs_turning_speed = abs(turning_speed);
        jet_stick_vol = audio::scale_speed(0, 5, 0, 0.4, abs_turning_speed);
        jet_stick_pitch = audio::scale_speed(0, 4, 0.9, 1.05, abs_turning_speed);
        qr_ent_angle setloopstate("veh_qrdrone_idle_rotate", jet_stick_vol, jet_stick_pitch, volumerate);
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x951ed9fd, Offset: 0x3838
// Size: 0xe4
function drone_button_watch() {
    self endon(#"entityshutdown");
    player = getlocalplayers()[0];
    return_to_zero = 1;
    while (true) {
        if (abs(self.qrdrone_z_difference) > 5 && return_to_zero) {
            self playsound(0, "veh_qrdrone_move_start");
            return_to_zero = 0;
        } else if (abs(self.qrdrone_z_difference) < 5 && !return_to_zero) {
            return_to_zero = 1;
        }
        wait(0.05);
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x18f96593, Offset: 0x3928
// Size: 0x694
function function_3f26c2a4() {
    audio::playloopat("amb_cave_enter", (2352, 4138, -278));
    audio::playloopat("amb_cave_enter", (2176, 807, 107));
    audio::playloopat("amb_cave_enter", (-2433, 494, -36));
    audio::playloopat("amb_elemental_corner_air", (11279, -8683, -271));
    audio::playloopat("amb_elemental_corner_fire", (9459, -8564, -283));
    audio::playloopat("amb_elemental_corner_fire_lava", (9904, -8612, -405));
    audio::playloopat("amb_elemental_corner_lightning", (9616, -6973, -252));
    audio::playloopat("amb_elemental_corner_ice", (11252, -7040, -215));
    audio::playloopat("amb_plane_dist_loop", (636, 5382, 453));
    audio::playloopat("amb_plane_dist_loop", (2515, 2411, 377));
    audio::playloopat("amb_plane_dist_loop", (-76, 58, 1035));
    audio::playloopat("amb_plane_dist_loop", (-2452, -690, 818));
    audio::playloopat("amb_plane_dist_loop", (886, -4399, 1051));
    audio::playloopat("amb_plane_dist_loop", (1078, 2266, 744));
    audio::playloopat("amb_spawn_rays", (9514, -8741, -335));
    audio::playloopat("amb_spawn_rays", (9319, -8519, -295));
    audio::playloopat("amb_spawn_rays", (9391, -7986, -258));
    audio::playloopat("amb_spawn_rays", (9322, -7608, -165));
    audio::playloopat("amb_spawn_rays", (9322, -7608, -165));
    audio::playloopat("amb_spawn_rays", (9369, -7021, -269));
    audio::playloopat("amb_spawn_rays", (9730, -6749, -175));
    audio::playloopat("amb_spawn_rays", (9997, -7007, -200));
    audio::playloopat("amb_spawn_rays", (10262, -7362, -341));
    audio::playloopat("amb_spawn_rays", (10985, -6684, -3));
    audio::playloopat("amb_spawn_rays", (11542, -7255, -291));
    audio::playloopat("amb_spawn_rays", (11291, -7653, -235));
    audio::playloopat("amb_spawn_rays", (11327, -8091, -203));
    audio::playloopat("amb_spawn_rays", (11596, -8545, -222));
    audio::playloopat("amb_spawn_rays", (11102, -889, -305));
    audio::playloopat("amb_spawn_rays", (10586, -8794, -225));
    audio::playloopat("amb_spawn_rays", (10117, -8888, -264));
    audio::playloopat("amb_spawn_rays", (10048, -8431, -321));
    audio::playloopat("amb_spawn_rays", (11104, -8896, -300));
    audio::playloopat("amb_spawn_rays", (10416, -7055, -337));
    audio::playloopat("amb_spawn_rays", (11100, -8894, -303));
    audio::playloopat("zmb_sq_electric_pillar", (10091, -7663, -372));
    audio::playloopat("zmb_sq_ice_pillar", (10567, -7657, -372));
    audio::playloopat("zmb_sq_air_pillar", (10581, -8142, -377));
    audio::playloopat("zmb_sq_fire_pillar", (10106, -8147, -382));
    audio::playloopat("amb_robot_fans", (-6252, -6534, 398));
    audio::playloopat("amb_robot_fans", (-6767, -6543, 361));
    audio::playloopat("amb_robot_fans", (-5677, -6501, 405));
}

// Namespace namespace_54a425fe
// Params 3, eflags: 0x1 linked
// Checksum 0x46d7a96c, Offset: 0x3fc8
// Size: 0x194
function function_6442a8c2(localclientnum, weapon, chargeshotlevel) {
    weaponname = weapon.name;
    self.var_4dde9ce5 = chargeshotlevel;
    if (!isdefined(self.var_d159d52b)) {
        self.var_d159d52b = spawn(0, (0, 0, 0), "script_origin");
    }
    self thread function_6ee5be43();
    if (!isdefined(self.var_276de066) || self.var_4dde9ce5 != self.var_276de066) {
        alias = "wpn_firestaff_charge_";
        if (weaponname == "staff_water_upgraded") {
            alias = "wpn_waterstaff_charge_";
        } else if (weaponname == "staff_lightning_upgraded") {
            alias = "wpn_lightningstaff_charge_";
        } else if (weaponname == "staff_air_upgraded") {
            alias = "wpn_airstaff_charge_";
        }
        self.var_710dd188 = self.var_d159d52b playloopsound(alias + "loop", 1.5);
        playsound(localclientnum, alias + self.var_4dde9ce5, (0, 0, 0));
        self.var_276de066 = self.var_4dde9ce5;
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0xf309f496, Offset: 0x4168
// Size: 0x60
function function_6ee5be43() {
    level notify(#"hash_df9ed1b6");
    level endon(#"hash_df9ed1b6");
    wait(0.5);
    self.var_d159d52b stoploopsound(self.var_710dd188, 0.1);
    self.var_4dde9ce5 = 0;
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x41d0
// Size: 0x4
function function_ee449b54() {
    
}

// Namespace namespace_54a425fe
// Params 1, eflags: 0x0
// Checksum 0x74ef3744, Offset: 0x41e0
// Size: 0xc6
function function_8b8dd551(localclientnum) {
    self endon(#"disconnect");
    self.sndent = spawn(0, (0, 0, 0), "script_origin");
    self.var_c5cda021 = "mus_underscore_default";
    self.var_a15dcd51 = "null";
    while (true) {
        if (self.var_a15dcd51 != self.var_c5cda021) {
            self.var_a15dcd51 = self.var_c5cda021;
            self.sndent notify(#"hash_9d70babf");
            self.sndent thread function_bca19b62(self.var_c5cda021);
        }
        wait(2);
    }
}

// Namespace namespace_54a425fe
// Params 1, eflags: 0x0
// Checksum 0x108f668f, Offset: 0x42b0
// Size: 0xd8
function function_4ff80996(localclientnum) {
    self endon(#"disconnect");
    self endon(#"death");
    while (true) {
        who = self waittill(#"trigger");
        if (isdefined(who) && who islocalplayer()) {
            if (isdefined(level.var_3e9ce4b5) && self.script_sound == "mus_underscore_chamber") {
                who.var_c5cda021 = level.var_3e9ce4b5;
            } else {
                who.var_c5cda021 = self.script_sound;
            }
            who thread function_bc0edf8b();
        }
        wait(0.5);
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x1c157040, Offset: 0x4390
// Size: 0x60
function function_bc0edf8b() {
    self notify(#"hash_11d444cc");
    self endon(#"disconnect");
    self endon(#"hash_11d444cc");
    wait(4);
    if (isdefined(self) && self islocalplayer()) {
        self.var_c5cda021 = "mus_underscore_default";
    }
}

// Namespace namespace_54a425fe
// Params 1, eflags: 0x1 linked
// Checksum 0x12c80bc0, Offset: 0x43f8
// Size: 0x5c
function function_bca19b62(alias) {
    self endon(#"hash_9d70babf");
    self endon(#"death");
    self stoploopsound(2);
    wait(2);
    self playloopsound(alias, 2);
}

// Namespace namespace_54a425fe
// Params 7, eflags: 0x1 linked
// Checksum 0x10546557, Offset: 0x4460
// Size: 0xd6
function function_e33eeb14(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    level thread function_572d945d();
    if (newval == 1) {
        if (!isdefined(self.var_e33eeb14)) {
            self.var_e33eeb14 = self playloopsound("amb_maelstrom", 3);
        }
        return;
    }
    if (isdefined(self.var_e33eeb14)) {
        self stoploopsound(self.var_e33eeb14);
        self.var_e33eeb14 = undefined;
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0x9694f800, Offset: 0x4540
// Size: 0x68
function function_572d945d() {
    if (!isdefined(level.var_ca141ce8)) {
        level.var_ca141ce8 = 1;
    }
    while (level.var_ca141ce8 == 1) {
        wait(randomintrange(5, 15));
        playsound(0, "amb_distant_explosion", (0, 0, 0));
    }
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0xecb7f1ef, Offset: 0x45b0
// Size: 0x15c
function startzmbspawnersoundloops() {
    loopers = struct::get_array("exterior_goal", "targetname");
    if (isdefined(loopers) && loopers.size > 0) {
        delay = 0;
        /#
            if (getdvarint("targetname") > 0) {
                println("targetname" + loopers.size + "targetname");
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
        if (getdvarint("targetname") > 0) {
            println("targetname");
        }
    #/
}

// Namespace namespace_54a425fe
// Params 0, eflags: 0x1 linked
// Checksum 0xf4b7bf50, Offset: 0x4718
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

