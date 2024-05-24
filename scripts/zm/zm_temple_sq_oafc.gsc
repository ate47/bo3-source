#using scripts/zm/zm_temple_sq_skits;
#using scripts/zm/zm_temple_sq_brock;
#using scripts/zm/zm_temple_sq;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_d0f39865;

// Namespace namespace_d0f39865
// Params 0, eflags: 0x1 linked
// Checksum 0x5daff6e, Offset: 0x4e8
// Size: 0x184
function init() {
    namespace_6e97c459::function_5a90ed82("sq", "OaFC", &init_stage, &function_7747c56, &function_cc3f3f6a);
    namespace_6e97c459::function_b9676730("sq", "OaFC", 300);
    namespace_6e97c459::function_9a85e396("sq", "OaFC", "sq_oafc_switch", &function_110b5bd7);
    namespace_6e97c459::function_9a85e396("sq", "OaFC", "sq_oafc_tileset1", &function_34a397d8, &namespace_6e97c459::function_6def6f41);
    namespace_6e97c459::function_9a85e396("sq", "OaFC", "sq_oafc_tileset2", &function_a6ab0713, &namespace_6e97c459::function_6def6f41);
    level flag::init("oafc_switch_pressed");
    level flag::init("oafc_plot_vo_done");
}

// Namespace namespace_d0f39865
// Params 0, eflags: 0x1 linked
// Checksum 0x46cd9b37, Offset: 0x678
// Size: 0xa6
function function_7747c56() {
    /#
        level flag::wait_till("targetname");
        if (getplayers().size == 1) {
            wait(20);
            level notify(#"hash_15ab69d8", 1);
            level waittill(#"hash_64e9e78e");
            wait(5);
            iprintlnbold("targetname");
            namespace_6e97c459::function_2f3ced1f("targetname", "targetname");
            return;
        }
    #/
}

// Namespace namespace_d0f39865
// Params 0, eflags: 0x1 linked
// Checksum 0x1347cd25, Offset: 0x728
// Size: 0x13c
function function_110b5bd7() {
    level endon(#"hash_21dcd34e");
    level thread function_2b71bd26();
    self.var_bbf92e7d = self.origin;
    self.var_eaa97957 = self.var_bbf92e7d - anglestoup(self.angles) * 5.5;
    self.trigger triggerignoreteam();
    who = self waittill(#"triggered");
    if (isdefined(who)) {
        level.var_200dc0e8 = who;
    }
    self playsound("evt_sq_gen_button");
    self moveto(self.var_eaa97957, 0.25);
    self waittill(#"movedone");
    level flag::set("oafc_switch_pressed");
    level thread function_f7d6a150();
}

// Namespace namespace_d0f39865
// Params 0, eflags: 0x1 linked
// Checksum 0x7115cb3a, Offset: 0x870
// Size: 0xb0
function function_2b71bd26() {
    level endon(#"hash_21dcd34e");
    struct = struct::get("sq_location_oafc", "targetname");
    if (!isdefined(struct)) {
        return;
    }
    while (!level flag::get("oafc_switch_pressed")) {
        playsoundatposition("evt_sq_oafc_knock", struct.origin);
        wait(randomfloatrange(1.5, 4));
    }
}

// Namespace namespace_d0f39865
// Params 0, eflags: 0x1 linked
// Checksum 0x1010d11, Offset: 0x928
// Size: 0x20
function function_34a397d8() {
    self.set = 1;
    self.original_origin = self.origin;
}

// Namespace namespace_d0f39865
// Params 0, eflags: 0x1 linked
// Checksum 0x78682d73, Offset: 0x950
// Size: 0x20
function function_a6ab0713() {
    self.set = 2;
    self.original_origin = self.origin;
}

/#

    // Namespace namespace_d0f39865
    // Params 0, eflags: 0x1 linked
    // Checksum 0xcb70cda8, Offset: 0x978
    // Size: 0x70
    function function_7269a501() {
        level endon(#"hash_3ae7c694");
        level endon(#"hash_21dcd34e");
        while (isdefined(self.var_d8c127bb) && !self.var_d8c127bb) {
            print3d(self.origin, self.tile, (0, 255, 0));
            wait(0.1);
        }
    }

    // Namespace namespace_d0f39865
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9b45c8d8, Offset: 0x9f0
    // Size: 0x7c0
    function function_cc0fce1() {
        level endon(#"hash_21dcd34e");
        if (!isdefined(level.var_7d341977)) {
            level.var_7d341977 = 1;
            level.var_e38ebc06 = newdebughudelem();
            level.var_e38ebc06.location = 0;
            level.var_e38ebc06.alignx = "targetname";
            level.var_e38ebc06.aligny = "targetname";
            level.var_e38ebc06.foreground = 1;
            level.var_e38ebc06.fontscale = 1.3;
            level.var_e38ebc06.sort = 20;
            level.var_e38ebc06.x = 10;
            level.var_e38ebc06.y = -16;
            level.var_e38ebc06.og_scale = 1;
            level.var_e38ebc06.color = (255, 255, 255);
            level.var_e38ebc06.alpha = 1;
            level.var_1fee3600 = newdebughudelem();
            level.var_1fee3600.location = 0;
            level.var_1fee3600.alignx = "targetname";
            level.var_1fee3600.aligny = "targetname";
            level.var_1fee3600.foreground = 1;
            level.var_1fee3600.fontscale = 1.3;
            level.var_1fee3600.sort = 20;
            level.var_1fee3600.x = 0;
            level.var_1fee3600.y = -16;
            level.var_1fee3600.og_scale = 1;
            level.var_1fee3600.color = (255, 255, 255);
            level.var_1fee3600.alpha = 1;
            level.var_1fee3600 settext("targetname");
            level.var_bd8c419d = newdebughudelem();
            level.var_bd8c419d.location = 0;
            level.var_bd8c419d.alignx = "targetname";
            level.var_bd8c419d.aligny = "targetname";
            level.var_bd8c419d.foreground = 1;
            level.var_bd8c419d.fontscale = 1.3;
            level.var_bd8c419d.sort = 20;
            level.var_bd8c419d.x = 10;
            level.var_bd8c419d.y = 270;
            level.var_bd8c419d.og_scale = 1;
            level.var_bd8c419d.color = (255, 255, 255);
            level.var_bd8c419d.alpha = 1;
            level.var_1780e445 = newdebughudelem();
            level.var_1780e445.location = 0;
            level.var_1780e445.alignx = "targetname";
            level.var_1780e445.aligny = "targetname";
            level.var_1780e445.foreground = 1;
            level.var_1780e445.fontscale = 1.3;
            level.var_1780e445.sort = 20;
            level.var_1780e445.x = 0;
            level.var_1780e445.y = 270;
            level.var_1780e445.og_scale = 1;
            level.var_1780e445.color = (255, 255, 255);
            level.var_1780e445.alpha = 1;
            level.var_1780e445 settext("targetname");
            level.var_74774b9a = newdebughudelem();
            level.var_74774b9a.location = 0;
            level.var_74774b9a.alignx = "targetname";
            level.var_74774b9a.aligny = "targetname";
            level.var_74774b9a.foreground = 1;
            level.var_74774b9a.fontscale = 1.3;
            level.var_74774b9a.sort = 20;
            level.var_74774b9a.x = 10;
            level.var_74774b9a.y = 300;
            level.var_74774b9a.og_scale = 1;
            level.var_74774b9a.color = (255, 255, 255);
            level.var_74774b9a.alpha = 1;
            level.var_2fb9871c = newdebughudelem();
            level.var_2fb9871c.location = 0;
            level.var_2fb9871c.alignx = "targetname";
            level.var_2fb9871c.aligny = "targetname";
            level.var_2fb9871c.foreground = 1;
            level.var_2fb9871c.fontscale = 1.3;
            level.var_2fb9871c.sort = 20;
            level.var_2fb9871c.x = 0;
            level.var_2fb9871c.y = 300;
            level.var_2fb9871c.og_scale = 1;
            level.var_2fb9871c.color = (255, 255, 255);
            level.var_2fb9871c.alpha = 1;
            level.var_2fb9871c settext("targetname");
        }
        while (true) {
            if (isdefined(level.var_66c77de0)) {
                level.var_e38ebc06 settext(level.var_66c77de0.tile);
            } else {
                level.var_e38ebc06 settext("targetname");
            }
            if (isdefined(level.var_d8ceed1b)) {
                level.var_bd8c419d settext(level.var_d8ceed1b.tile);
            } else {
                level.var_bd8c419d settext("targetname");
            }
            if (isdefined(level.var_fd4714bf)) {
                level.var_74774b9a settext(level.var_fd4714bf);
            }
            wait(0.05);
        }
    }

#/

// Namespace namespace_d0f39865
// Params 0, eflags: 0x0
// Checksum 0x86a88a22, Offset: 0x11b8
// Size: 0x54
function function_c42677e6() {
    level endon(#"hash_21dcd34e");
    self endon(#"hash_5ac1645b");
    level endon(#"hash_3ae7c694");
    self.origin = self.original_origin;
    /#
        self thread function_7269a501();
    #/
}

// Namespace namespace_d0f39865
// Params 0, eflags: 0x1 linked
// Checksum 0xc4bab787, Offset: 0x1218
// Size: 0x94
function init_stage() {
    /#
        level thread function_cc0fce1();
    #/
    level flag::clear("oafc_switch_pressed");
    level flag::clear("oafc_plot_vo_done");
    function_3ae7c694();
    namespace_abd6a8a5::function_ac4ad5b0();
    level thread function_9873f186();
}

// Namespace namespace_d0f39865
// Params 0, eflags: 0x1 linked
// Checksum 0xaa203d4c, Offset: 0x12b8
// Size: 0x2c
function function_9873f186() {
    wait(0.5);
    level thread namespace_435c2400::function_acc79afb("tt1");
}

// Namespace namespace_d0f39865
// Params 1, eflags: 0x1 linked
// Checksum 0x3a581c66, Offset: 0x12f0
// Size: 0x94
function function_3b50db2(delay) {
    level endon(#"hash_21dcd34e");
    level flag::wait_till("oafc_switch_pressed");
    for (i = 0; i < delay; i++) {
        util::wait_network_frame();
    }
    self moveto(self.original_origin, 0.25);
}

// Namespace namespace_d0f39865
// Params 2, eflags: 0x1 linked
// Checksum 0xac4e7c54, Offset: 0x1390
// Size: 0xfe
function function_70fbf567(tiles, models) {
    for (i = 0; i < tiles.size; i++) {
        tiles[i] setmodel("p7_zm_sha_glyph_stone_blank");
        tiles[i].tile = models[i];
        tiles[i].var_d8c127bb = 0;
        tiles[i].origin = tiles[i].original_origin - (0, 0, 24);
        tiles[i] thread function_3b50db2(i % 4);
    }
}

// Namespace namespace_d0f39865
// Params 0, eflags: 0x1 linked
// Checksum 0xe4e3cf9d, Offset: 0x1498
// Size: 0x96
function player_in_trigger() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i].sessionstate != "spectator" && self istouching(players[i])) {
            return players[i];
        }
    }
    return undefined;
}

// Namespace namespace_d0f39865
// Params 1, eflags: 0x1 linked
// Checksum 0x5690e6c5, Offset: 0x1538
// Size: 0x1d0
function function_1667d8eb(tile) {
    level endon(#"hash_2687e434");
    var_b7081a33 = [];
    if (tile.targetname == "sq_oafc_tileset1") {
        var_b7081a33 = getentarray("sq_oafc_tileset2", "targetname");
        level notify(#"hash_e177c495");
        level endon(#"hash_e177c495");
    } else {
        var_b7081a33 = getentarray("sq_oafc_tileset1", "targetname");
        level notify(#"hash_77a3efe");
        level endon(#"hash_77a3efe");
    }
    var_ad717133 = undefined;
    foreach (var_8bf17d58 in var_b7081a33) {
        if (tile.tile == var_8bf17d58.tile) {
            var_ad717133 = var_8bf17d58;
        }
    }
    while (isdefined(var_ad717133)) {
        /#
            print3d(var_ad717133.origin + (0, 0, 32), "targetname", (255, 0, 0), 1);
        #/
        util::wait_network_frame();
    }
}

// Namespace namespace_d0f39865
// Params 2, eflags: 0x1 linked
// Checksum 0x233cb61, Offset: 0x1710
// Size: 0x84c
function function_145e3b98(tiles, set) {
    self endon(#"death");
    level endon(#"hash_3ae7c694");
    self triggerenable(0);
    level flag::wait_till("oafc_switch_pressed");
    self triggerenable(1);
    while (true) {
        for (i = 0; i < tiles.size; i++) {
            tile = tiles[i];
            if (isdefined(tile) && !tile.var_d8c127bb) {
                self.origin = tiles[i].origin;
                var_95d1fa7 = self player_in_trigger();
                if (isdefined(var_95d1fa7)) {
                    /#
                        if (set == 1) {
                            println("targetname" + i);
                        }
                    #/
                    tile setmodel(tile.tile);
                    tile playsound("evt_sq_oafc_glyph_activate");
                    /#
                        level thread function_1667d8eb(tile);
                    #/
                    var_d8c127bb = 0;
                    if (set == 1) {
                        level.var_66c77de0 = tile;
                    } else {
                        level.var_d8ceed1b = tile;
                    }
                    while (isdefined(var_95d1fa7) && self istouching(var_95d1fa7) && var_95d1fa7.sessionstate != "spectator" && !tile.var_d8c127bb) {
                        self.var_95d1fa7 = var_95d1fa7;
                        if (set == 1) {
                            if (isdefined(level.var_66c77de0) && isdefined(level.var_d8ceed1b)) {
                                if (level.var_66c77de0.tile == level.var_d8ceed1b.tile) {
                                    level.var_66c77de0 playsound("evt_sq_oafc_glyph_correct");
                                    level.var_d8ceed1b playsound("evt_sq_oafc_glyph_correct");
                                    /#
                                        level notify(#"hash_2687e434");
                                    #/
                                    var_d8c127bb = 1;
                                    level.var_66c77de0.var_d8c127bb = 1;
                                    level.var_d8ceed1b.var_d8c127bb = 1;
                                    level.var_66c77de0 moveto(level.var_66c77de0.origin - (0, 0, 24), 0.5);
                                    level.var_d8ceed1b moveto(level.var_d8ceed1b.origin - (0, 0, 24), 0.5);
                                    level.var_66c77de0 waittill(#"movedone");
                                    level.var_66c77de0 = undefined;
                                    level.var_d8ceed1b = undefined;
                                    level.var_fd4714bf++;
                                    if (level.var_fd4714bf < level.var_1aea7d74) {
                                        rand = randomintrange(0, 2);
                                        if (isdefined(var_95d1fa7) && rand == 0) {
                                            var_95d1fa7 thread zm_audio::create_and_play_dialog("eggs", "quest1", randomintrange(5, 8));
                                        } else if (isdefined(level.var_ca8e74be.var_95d1fa7)) {
                                            level.var_ca8e74be.var_95d1fa7 thread zm_audio::create_and_play_dialog("eggs", "quest1", randomintrange(5, 8));
                                        }
                                    }
                                    if (level.var_fd4714bf == level.var_1aea7d74) {
                                        /#
                                            println("targetname");
                                        #/
                                        struct = struct::get("sq_location_oafc", "targetname");
                                        if (isdefined(struct)) {
                                            playsoundatposition("evt_sq_oafc_glyph_complete", struct.origin);
                                            playsoundatposition("evt_sq_oafc_kachunk", struct.origin);
                                        }
                                        level notify(#"hash_bd6f486d");
                                        level notify(#"hash_15ab69d8", 1);
                                        level waittill(#"hash_64e9e78e");
                                        level flag::wait_till("oafc_plot_vo_done");
                                        wait(5);
                                        namespace_6e97c459::function_2f3ced1f("sq", "OaFC");
                                        return;
                                    }
                                    /#
                                        println("targetname");
                                    #/
                                    break;
                                } else {
                                    level.var_66c77de0 playsound("evt_sq_oafc_glyph_wrong");
                                    level.var_d8ceed1b playsound("evt_sq_oafc_glyph_wrong");
                                    rand = randomintrange(0, 2);
                                    if (isdefined(var_95d1fa7) && rand == 0) {
                                        var_95d1fa7 thread zm_audio::create_and_play_dialog("eggs", "quest1", randomintrange(2, 5));
                                    } else if (isdefined(level.var_ca8e74be.var_95d1fa7)) {
                                        level.var_ca8e74be.var_95d1fa7 thread zm_audio::create_and_play_dialog("eggs", "quest1", randomintrange(2, 5));
                                    }
                                    while (isdefined(var_95d1fa7) && self istouching(var_95d1fa7) && isdefined(level.var_d8ceed1b)) {
                                        wait(0.05);
                                    }
                                    /#
                                        println("targetname");
                                    #/
                                    level thread function_3ae7c694();
                                    break;
                                }
                            }
                        }
                        wait(0.05);
                    }
                    tile playsound("evt_sq_oafc_glyph_clear");
                    if (set == 1) {
                        level.var_66c77de0 = undefined;
                    } else {
                        level.var_d8ceed1b = undefined;
                    }
                    tile setmodel("p7_zm_sha_glyph_stone_blank");
                }
            }
        }
        wait(0.05);
    }
    /#
        if (set == 1) {
            println("targetname");
        }
    #/
}

// Namespace namespace_d0f39865
// Params 0, eflags: 0x1 linked
// Checksum 0xb1227b31, Offset: 0x1f68
// Size: 0x26c
function function_3ae7c694() {
    var_b6e112da = array("p7_zm_sha_glyph_stone_01", "p7_zm_sha_glyph_stone_02", "p7_zm_sha_glyph_stone_03", "p7_zm_sha_glyph_stone_04", "p7_zm_sha_glyph_stone_05", "p7_zm_sha_glyph_stone_06", "p7_zm_sha_glyph_stone_07", "p7_zm_sha_glyph_stone_08", "p7_zm_sha_glyph_stone_09", "p7_zm_sha_glyph_stone_10", "p7_zm_sha_glyph_stone_11", "p7_zm_sha_glyph_stone_12");
    level notify(#"hash_3ae7c694");
    if (!isdefined(level.var_a48bfa55)) {
        level.var_a48bfa55 = spawn("trigger_radius", (0, 0, 0), 0, 22, 72);
        level.var_ca8e74be = spawn("trigger_radius", (0, 0, 0), 0, 22, 72);
        level.var_a48bfa55 thread function_cdf129a9();
        level.var_ca8e74be thread function_cdf129a9();
    }
    level.var_fd4714bf = 0;
    level.var_66c77de0 = undefined;
    level.var_d8ceed1b = undefined;
    var_b6e112da = array::randomize(var_b6e112da);
    var_34a397d8 = getentarray("sq_oafc_tileset1", "targetname");
    level.var_1aea7d74 = var_34a397d8.size;
    function_70fbf567(var_34a397d8, var_b6e112da);
    level.var_a48bfa55 thread function_145e3b98(var_34a397d8, 1);
    var_b6e112da = array::randomize(var_b6e112da);
    var_a6ab0713 = getentarray("sq_oafc_tileset2", "targetname");
    function_70fbf567(var_a6ab0713, var_b6e112da);
    level.var_ca8e74be thread function_145e3b98(var_a6ab0713, 2);
}

// Namespace namespace_d0f39865
// Params 0, eflags: 0x1 linked
// Checksum 0xf4b864df, Offset: 0x21e0
// Size: 0x9a
function function_cdf129a9() {
    self endon(#"death");
    level endon(#"hash_be6d0796");
    while (true) {
        who = self waittill(#"trigger");
        if (isdefined(who) && isplayer(who)) {
            who thread zm_audio::create_and_play_dialog("eggs", "quest1", 1);
            break;
        }
    }
    level notify(#"hash_be6d0796");
}

// Namespace namespace_d0f39865
// Params 1, eflags: 0x1 linked
// Checksum 0x8b4cdb49, Offset: 0x2288
// Size: 0x1b0
function function_cc3f3f6a(success) {
    if (isdefined(level.var_7d341977)) {
        level.var_7d341977 = undefined;
        level.var_e38ebc06 destroy();
        level.var_e38ebc06 = undefined;
        level.var_1fee3600 destroy();
        level.var_1fee3600 = undefined;
        level.var_bd8c419d destroy();
        level.var_bd8c419d = undefined;
        level.var_1780e445 destroy();
        level.var_1780e445 = undefined;
        level.var_74774b9a destroy();
        level.var_74774b9a.location = undefined;
        level.var_2fb9871c destroy();
        level.var_2fb9871c = undefined;
    }
    if (success) {
        namespace_abd6a8a5::function_67e052f1(2, &namespace_abd6a8a5::function_942b1627);
    } else {
        namespace_abd6a8a5::function_67e052f1(1);
        level thread namespace_435c2400::function_b6268f3d(1);
    }
    level.var_a48bfa55 delete();
    level.var_ca8e74be delete();
    if (isdefined(level.var_b88253bf)) {
        level.var_b88253bf delete();
        level.var_b88253bf = undefined;
    }
    level.var_c502e691 = 0;
}

// Namespace namespace_d0f39865
// Params 0, eflags: 0x1 linked
// Checksum 0x49c4e88a, Offset: 0x2440
// Size: 0x366
function function_f7d6a150() {
    level endon(#"hash_21dcd34e");
    struct = struct::get("sq_location_oafc", "targetname");
    if (!isdefined(struct)) {
        return;
    }
    level.var_b88253bf = spawn("script_origin", struct.origin);
    level.var_b88253bf playsoundwithnotify("vox_egg_story_1_0", "sounddone");
    level.var_b88253bf waittill(#"sounddone");
    if (isdefined(level.var_200dc0e8)) {
        who = level.var_200dc0e8;
        level.var_c502e691 = 1;
        who playsoundwithnotify("vox_egg_story_1_1" + namespace_1e4bbaa5::function_26186755(who.characterindex), "vox_egg_sounddone");
        who waittill(#"hash_a1f549aa");
        level.var_c502e691 = 0;
    }
    level.var_b88253bf playsoundwithnotify("vox_egg_story_1_2", "sounddone");
    level.var_b88253bf waittill(#"sounddone");
    while (level.var_fd4714bf < 1) {
        wait(0.1);
    }
    level.var_b88253bf playsoundwithnotify("vox_egg_story_1_3", "sounddone");
    level.var_b88253bf waittill(#"sounddone");
    while (level.var_fd4714bf != level.var_1aea7d74) {
        wait(0.1);
    }
    level.var_b88253bf playsoundwithnotify("vox_egg_story_1_4", "sounddone");
    level.var_b88253bf waittill(#"sounddone");
    if (isdefined(level.var_200dc0e8)) {
        who = level.var_200dc0e8;
        level.var_c502e691 = 1;
        who playsoundwithnotify("vox_egg_story_1_5" + namespace_1e4bbaa5::function_26186755(who.characterindex), "vox_egg_sounddone");
        who waittill(#"hash_a1f549aa");
        level.var_c502e691 = 0;
    }
    level.var_b88253bf playsoundwithnotify("vox_egg_story_1_6", "sounddone");
    level.var_b88253bf waittill(#"sounddone");
    level.var_b88253bf playsoundwithnotify("vox_egg_story_1_7", "sounddone");
    level.var_b88253bf waittill(#"sounddone");
    level flag::set("oafc_plot_vo_done");
    level.var_b88253bf delete();
    level.var_b88253bf = undefined;
}

