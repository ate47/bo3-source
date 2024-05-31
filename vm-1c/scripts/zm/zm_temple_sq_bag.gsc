#using scripts/zm/zm_temple_sq_skits;
#using scripts/zm/zm_temple_sq_brock;
#using scripts/zm/zm_temple_sq;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_6d88ee3a;

// Namespace namespace_6d88ee3a
// Params 0, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_c35e6aab
// Checksum 0x8c12cd1a, Offset: 0x400
// Size: 0xbc
function init() {
    level flag::init("given_dynamite");
    level flag::init("dynamite_chat");
    namespace_6e97c459::function_5a90ed82("sq", "BaG", &init_stage, &function_7747c56, &function_cc3f3f6a);
    namespace_6e97c459::function_b9676730("sq", "BaG", 300);
}

/#

    // Namespace namespace_6d88ee3a
    // Params 0, eflags: 0x0
    // namespace_6d88ee3a<file_0>::function_38592a25
    // Checksum 0xacedd3e1, Offset: 0x4c8
    // Size: 0x878
    function function_38592a25() {
        if (isdefined(level.var_c16cbca)) {
            return;
        }
        if (!isdefined(level.var_c16cbca)) {
            level.var_c16cbca = 1;
            level.var_d05fb424 = newdebughudelem();
            level.var_d05fb424.location = 0;
            level.var_d05fb424.alignx = "quest8";
            level.var_d05fb424.aligny = "quest8";
            level.var_d05fb424.foreground = 1;
            level.var_d05fb424.fontscale = 1.3;
            level.var_d05fb424.sort = 20;
            level.var_d05fb424.x = 10;
            level.var_d05fb424.y = -16;
            level.var_d05fb424.og_scale = 1;
            level.var_d05fb424.color = (255, 255, 255);
            level.var_d05fb424.alpha = 1;
            level.var_5b0b9093 = newdebughudelem();
            level.var_5b0b9093.location = 0;
            level.var_5b0b9093.alignx = "quest8";
            level.var_5b0b9093.aligny = "quest8";
            level.var_5b0b9093.foreground = 1;
            level.var_5b0b9093.fontscale = 1.3;
            level.var_5b0b9093.sort = 20;
            level.var_5b0b9093.x = 0;
            level.var_5b0b9093.y = -16;
            level.var_5b0b9093.og_scale = 1;
            level.var_5b0b9093.color = (255, 255, 255);
            level.var_5b0b9093.alpha = 1;
            level.var_5b0b9093 settext("quest8");
            level.var_a2fc2b82 = newdebughudelem();
            level.var_a2fc2b82.location = 0;
            level.var_a2fc2b82.alignx = "quest8";
            level.var_a2fc2b82.aligny = "quest8";
            level.var_a2fc2b82.foreground = 1;
            level.var_a2fc2b82.fontscale = 1.3;
            level.var_a2fc2b82.sort = 20;
            level.var_a2fc2b82.x = 10;
            level.var_a2fc2b82.y = 270;
            level.var_a2fc2b82.og_scale = 1;
            level.var_a2fc2b82.color = (255, 255, 255);
            level.var_a2fc2b82.alpha = 1;
            level.var_22924059 = newdebughudelem();
            level.var_22924059.location = 0;
            level.var_22924059.alignx = "quest8";
            level.var_22924059.aligny = "quest8";
            level.var_22924059.foreground = 1;
            level.var_22924059.fontscale = 1.3;
            level.var_22924059.sort = 20;
            level.var_22924059.x = 0;
            level.var_22924059.y = 270;
            level.var_22924059.og_scale = 1;
            level.var_22924059.color = (255, 255, 255);
            level.var_22924059.alpha = 1;
            level.var_22924059 settext("quest8");
            level.var_13adef5a = newdebughudelem();
            level.var_13adef5a.location = 0;
            level.var_13adef5a.alignx = "quest8";
            level.var_13adef5a.aligny = "quest8";
            level.var_13adef5a.foreground = 1;
            level.var_13adef5a.fontscale = 1.3;
            level.var_13adef5a.sort = 20;
            level.var_13adef5a.x = 10;
            level.var_13adef5a.y = 300;
            level.var_13adef5a.og_scale = 1;
            level.var_13adef5a.color = (255, 255, 255);
            level.var_13adef5a.alpha = 1;
            level.var_edaac3a1 = newdebughudelem();
            level.var_edaac3a1.location = 0;
            level.var_edaac3a1.alignx = "quest8";
            level.var_edaac3a1.aligny = "quest8";
            level.var_edaac3a1.foreground = 1;
            level.var_edaac3a1.fontscale = 1.3;
            level.var_edaac3a1.sort = 20;
            level.var_edaac3a1.x = 0;
            level.var_edaac3a1.y = 300;
            level.var_edaac3a1.og_scale = 1;
            level.var_edaac3a1.color = (255, 255, 255);
            level.var_edaac3a1.alpha = 1;
            level.var_edaac3a1 settext("quest8");
        }
        var_6c1012a9 = getentarray("quest8", "quest8");
        while (true) {
            if (isdefined(level.var_c5defb4b)) {
                level.var_d05fb424 setvalue(level.var_c5defb4b);
            } else {
                level.var_e38ebc06 setvalue("quest8");
            }
            var_63989b10 = "quest8";
            for (i = 0; i < var_6c1012a9.size; i++) {
                if (isdefined(var_6c1012a9[i].ringing) && var_6c1012a9[i].ringing) {
                    var_63989b10 += "quest8";
                    continue;
                }
                var_63989b10 += "quest8";
            }
            level.var_a2fc2b82 settext(var_63989b10);
            if (level flag::get("quest8")) {
                level.var_edaac3a1 settext("quest8");
            } else {
                level.var_edaac3a1 settext("quest8");
            }
            wait(0.05);
        }
    }

#/

// Namespace namespace_6d88ee3a
// Params 0, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_bf888e64
// Checksum 0xdfef6274, Offset: 0xd48
// Size: 0x1ac
function init_stage() {
    namespace_abd6a8a5::function_ac4ad5b0();
    level notify(#"hash_c43e46b4");
    /#
        if (getplayers().size == 1 || getdvarint("quest8") == 2) {
            getplayers()[0] giveweapon(level.var_953f69a0);
            level notify(#"hash_15ab69d8");
            level notify(#"hash_87b2d913");
            level notify(#"hash_61b05eaa");
            level notify(#"hash_d3b7cde5");
            level notify(#"hash_adb5537c");
            level notify(#"hash_1fbcc2b7");
        }
    #/
    level flag::clear("given_dynamite");
    level flag::clear("dynamite_chat");
    var_6c1012a9 = getentarray("sq_gong", "targetname");
    array::thread_all(var_6c1012a9, &function_b4c87a43);
    level thread function_5b66185a();
    namespace_1e4bbaa5::function_ccf3d988();
    level thread function_9873f186();
}

// Namespace namespace_6d88ee3a
// Params 0, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_9873f186
// Checksum 0x11d11e7f, Offset: 0xf00
// Size: 0x2c
function function_9873f186() {
    wait(0.5);
    level thread namespace_435c2400::function_acc79afb("tt8");
}

/#

    // Namespace namespace_6d88ee3a
    // Params 0, eflags: 0x1 linked
    // namespace_6d88ee3a<file_0>::function_43060cc
    // Checksum 0x96e64ba5, Offset: 0xf38
    // Size: 0x68
    function function_43060cc() {
        self endon(#"hash_f3fb20a5");
        while (!(isdefined(level.disable_print3d_ent) && level.disable_print3d_ent)) {
            print3d(self.origin, "quest8", (0, 255, 0), 2);
            wait(0.1);
        }
    }

#/

// Namespace namespace_6d88ee3a
// Params 0, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_ee5cccb6
// Checksum 0xfeeb9a85, Offset: 0xfa8
// Size: 0x24c
function function_ee5cccb6() {
    self endon(#"hash_f3fb20a5");
    self.dropped = 1;
    self unlink();
    dest = struct::get(self.target, "targetname");
    level.var_6dc7946f = spawn("trigger_radius", self.origin, 0, 24, 10);
    level.var_6dc7946f enablelinkto();
    level.var_6dc7946f linkto(self);
    level.var_6dc7946f.var_bbca234 = self;
    level.var_6dc7946f thread function_a87aa210();
    /#
        self thread function_43060cc();
    #/
    self notsolid();
    self moveto(dest.origin, 1.4, 0.2, 0);
    self waittill(#"movedone");
    players = getplayers();
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("eggs", "quest8", 5);
    playsoundatposition("evt_sq_bag_dynamite_explosion", dest.origin);
    level.var_6dc7946f notify(#"boom");
    level.var_6dc7946f delete();
    level.var_6dc7946f = undefined;
    namespace_6e97c459::function_7332e9d3("sq", "BaG");
}

// Namespace namespace_6d88ee3a
// Params 0, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_a87aa210
// Checksum 0x18dfc7ea, Offset: 0x1200
// Size: 0x12c
function function_a87aa210() {
    self endon(#"boom");
    self endon(#"death");
    while (true) {
        who = self waittill(#"trigger");
        if (isdefined(who) && zombie_utility::is_player_valid(who)) {
            who thread zm_audio::create_and_play_dialog("eggs", "quest8", 6);
            who playsound("evt_sq_bag_dynamite_catch");
            who.var_4088da72 = 1;
            self.var_bbca234 notify(#"hash_f3fb20a5");
            self.var_bbca234 ghost();
            who namespace_6e97c459::function_f72f765e("sq", "dynamite");
            self delete();
            break;
        }
    }
}

// Namespace namespace_6d88ee3a
// Params 0, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_5b66185a
// Checksum 0x1e5f3989, Offset: 0x1338
// Size: 0x40c
function function_5b66185a() {
    level endon(#"hash_36d53f0b");
    wall = getent("sq_wall", "targetname");
    wall solid();
    level flag::wait_till("meteorite_shrunk");
    player_close = 0;
    player = undefined;
    while (!player_close) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (distance2dsquared(players[i].origin, wall.origin) < 57600) {
                player_close = 1;
                player = players[i];
                break;
            }
        }
        wait(0.1);
    }
    level function_43e26f4d(player);
    level flag::set("dynamite_chat");
    level.var_56963dec = spawn("trigger_radius_use", wall.origin, 0, 56, 72);
    level.var_56963dec triggerignoreteam();
    level.var_56963dec setcursorhint("HINT_NOICON");
    level.var_56963dec.radius = 48;
    level.var_56963dec.height = 72;
    for (var_6d71b4aa = 1; var_6d71b4aa; var_6d71b4aa = 0) {
        who = level.var_56963dec waittill(#"trigger");
        if (isplayer(who) && zombie_utility::is_player_valid(who) && isdefined(who.var_4088da72) && who.var_4088da72) {
            who.var_4088da72 = undefined;
            who namespace_6e97c459::function_9f2411a3("sq", "dynamite");
        }
    }
    level notify(#"hash_bd6f486d");
    level.var_56963dec delete();
    level.var_56963dec = undefined;
    level function_69e4e9b6();
    var_9ff55c5b = 0;
    for (players = getplayers(); var_9ff55c5b < players.size; players = getplayers()) {
        var_9ff55c5b = 0;
        for (i = 0; i < players.size; i++) {
            if (distance2dsquared(players[i].origin, wall.origin) > 129600) {
                var_9ff55c5b++;
            }
        }
        wait(0.1);
    }
    level flag::set("given_dynamite");
}

// Namespace namespace_6d88ee3a
// Params 0, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_7747c56
// Checksum 0xcb9e0df2, Offset: 0x1750
// Size: 0xac
function function_7747c56() {
    level flag::wait_till("meteorite_shrunk");
    level flag::set("pap_override");
    level flag::wait_till("dynamite_chat");
    level flag::wait_till("given_dynamite");
    wait(5);
    namespace_6e97c459::function_2f3ced1f("sq", "BaG");
}

// Namespace namespace_6d88ee3a
// Params 1, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_cc3f3f6a
// Checksum 0x89180fce, Offset: 0x1808
// Size: 0x2c8
function function_cc3f3f6a(success) {
    if (success) {
        namespace_abd6a8a5::function_67e052f1(9, &namespace_abd6a8a5::function_f38875fe);
        level.var_305d1f14 = 0;
    } else {
        namespace_abd6a8a5::function_67e052f1(8);
        level flag::clear("meteorite_shrunk");
        ent = getent("sq_meteorite", "targetname");
        ent.origin = ent.original_origin;
        ent.angles = ent.original_angles;
        ent setmodel("p7_zm_sha_meteorite");
        namespace_1e4bbaa5::function_ccf3d988();
        level flag::clear("pap_override");
        level thread namespace_435c2400::function_b6268f3d();
    }
    if (isdefined(level.var_6dc7946f)) {
        level.var_6dc7946f delete();
        level.var_6dc7946f = undefined;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i].var_4088da72)) {
            players[i].var_4088da72 = undefined;
            players[i] namespace_6e97c459::function_9f2411a3("sq", "dynamite");
        }
    }
    if (isdefined(level.var_56963dec)) {
        level.var_56963dec delete();
    }
    var_6c1012a9 = getentarray("sq_gong", "targetname");
    array::thread_all(var_6c1012a9, &function_8cadb8d9);
    if (isdefined(level.var_8e1fd3d4)) {
        level.var_8e1fd3d4 delete();
        level.var_8e1fd3d4 = undefined;
    }
    level.var_c502e691 = 0;
}

// Namespace namespace_6d88ee3a
// Params 0, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_f702c96b
// Checksum 0x52e9654a, Offset: 0x1ad8
// Size: 0xb4
function function_f702c96b() {
    if (!isdefined(level.var_4389e8e5) || level.var_4389e8e5 == 0) {
        level.var_4389e8e5 = 60;
    } else {
        level.var_4389e8e5 += 60;
        return;
    }
    level endon(#"hash_e2cfa6d0");
    level flag::set("gongs_resonating");
    while (level.var_4389e8e5) {
        level.var_4389e8e5--;
        wait(1);
    }
    level flag::clear("gongs_resonating");
}

// Namespace namespace_6d88ee3a
// Params 1, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_88b98782
// Checksum 0xd9acb58, Offset: 0x1b98
// Size: 0x2fc
function function_88b98782(player) {
    level endon(#"hash_6a46050f");
    self.ringing = 1;
    if (isdefined(self.var_4a3ea713) && self.var_4a3ea713) {
        self playloopsound("mus_sq_bag_gong_correct_loop_" + level.var_c5defb4b, 5);
    } else {
        self playsound("evt_sq_bag_gong_incorrect");
    }
    if (level.var_c5defb4b == 4) {
        level thread function_f702c96b();
    }
    if (isdefined(player) && isplayer(player)) {
        if (self.var_4a3ea713 && level.var_c5defb4b == 1) {
            player thread zm_audio::create_and_play_dialog("eggs", "quest8", 1);
        } else if (self.var_4a3ea713 && level flag::get("gongs_resonating")) {
            player thread zm_audio::create_and_play_dialog("eggs", "quest8", 2);
        } else if (!self.var_4a3ea713) {
            player thread zm_audio::create_and_play_dialog("eggs", "quest8", 0);
        }
    }
    if (self.var_4a3ea713 == 0) {
        level notify(#"hash_e2cfa6d0");
        level.var_4389e8e5 = 0;
        var_6c1012a9 = getentarray("sq_gong", "targetname");
        for (i = 0; i < var_6c1012a9.size; i++) {
            if (var_6c1012a9[i].var_4a3ea713) {
                if (var_6c1012a9[i].ringing) {
                    if (level.var_c5defb4b >= 0) {
                        level.var_c5defb4b--;
                    }
                    var_6c1012a9[i] stoploopsound(5);
                }
            }
            var_6c1012a9[i].ringing = 0;
        }
        level notify(#"hash_6a46050f");
    }
    wait(60);
    if (self.var_4a3ea713 && level.var_c5defb4b >= 0) {
        level.var_c5defb4b--;
    }
    self.ringing = 0;
    self stoploopsound(5);
}

// Namespace namespace_6d88ee3a
// Params 2, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_287b9cb6
// Checksum 0x1bc2e94e, Offset: 0x1ea0
// Size: 0x54
function function_287b9cb6(var_f75f842b, player) {
    if (self.var_4a3ea713 && level.var_c5defb4b < 4) {
        level.var_c5defb4b++;
    }
    self thread function_88b98782(player);
}

// Namespace namespace_6d88ee3a
// Params 0, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_b4c87a43
// Checksum 0x5bead011, Offset: 0x1f00
// Size: 0x88
function function_b4c87a43() {
    level endon(#"hash_36d53f0b");
    if (!isdefined(self.ringing)) {
        self.ringing = 0;
    }
    self thread function_2e874442();
    while (true) {
        who = self waittill(#"triggered");
        if (!self.ringing) {
            self function_287b9cb6(1, who);
        }
    }
}

// Namespace namespace_6d88ee3a
// Params 0, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_2e874442
// Checksum 0x550969fe, Offset: 0x1f90
// Size: 0x98
function function_2e874442() {
    /#
        level endon(#"hash_c43e46b4");
        level endon(#"hash_36d53f0b");
        while (!(isdefined(level.disable_print3d_ent) && level.disable_print3d_ent)) {
            if (!self.ringing && self.var_4a3ea713) {
                print3d(self.origin + (0, 0, 64), "quest8", (0, 255, 0), 1);
            }
            wait(0.1);
        }
    #/
}

// Namespace namespace_6d88ee3a
// Params 0, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_39927c36
// Checksum 0xfb366661, Offset: 0x2030
// Size: 0x98
function function_39927c36() {
    if (isdefined(self.var_8088fd7a)) {
        return;
    }
    self.var_8088fd7a = 1;
    self useanimtree(#generic);
    while (true) {
        self waittill(#"triggered");
        self animation::stop();
        self thread animation::play("p7_fxanim_zm_sha_gong_anim", self.origin, self.angles);
    }
}

// Namespace namespace_6d88ee3a
// Params 0, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_8cadb8d9
// Checksum 0xc9333940, Offset: 0x20d0
// Size: 0x90
function function_8cadb8d9() {
    level endon(#"hash_c43e46b4");
    self thread function_39927c36();
    if (!isdefined(self.ringing)) {
        self.ringing = 0;
    }
    self thread function_2e874442();
    while (true) {
        self waittill(#"triggered");
        if (!self.ringing) {
            self function_287b9cb6(0);
        }
    }
}

// Namespace namespace_6d88ee3a
// Params 1, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_43e26f4d
// Checksum 0xb0ee2d33, Offset: 0x2168
// Size: 0x22e
function function_43e26f4d(player) {
    level endon(#"hash_c511c0c0");
    struct = struct::get("sq_location_bag", "targetname");
    if (!isdefined(struct)) {
        return;
    }
    level.var_8e1fd3d4 = spawn("script_origin", struct.origin);
    level.var_8e1fd3d4 playsoundwithnotify("vox_egg_story_5_0", "sounddone");
    level.var_8e1fd3d4 waittill(#"sounddone");
    level.var_8e1fd3d4 playsoundwithnotify("vox_egg_story_5_1", "sounddone");
    level.var_8e1fd3d4 waittill(#"sounddone");
    level.var_8e1fd3d4 playsoundwithnotify("vox_egg_story_5_2", "sounddone");
    level.var_8e1fd3d4 waittill(#"sounddone");
    if (isdefined(player)) {
        level.var_c502e691 = 1;
        player playsoundwithnotify("vox_egg_story_5_3" + namespace_1e4bbaa5::function_26186755(player.characterindex), "vox_egg_sounddone");
        player waittill(#"hash_a1f549aa");
        level.var_c502e691 = 0;
    }
    level.var_8e1fd3d4 playsoundwithnotify("vox_egg_story_5_4", "sounddone");
    level.var_8e1fd3d4 waittill(#"sounddone");
    level.var_8e1fd3d4 playsoundwithnotify("vox_egg_story_5_5", "sounddone");
    level.var_8e1fd3d4 waittill(#"sounddone");
    level.var_8e1fd3d4 delete();
    level.var_8e1fd3d4 = undefined;
}

// Namespace namespace_6d88ee3a
// Params 0, eflags: 0x1 linked
// namespace_6d88ee3a<file_0>::function_69e4e9b6
// Checksum 0x98ffb7e, Offset: 0x23a0
// Size: 0x106
function function_69e4e9b6() {
    level endon(#"hash_c511c0c0");
    struct = struct::get("sq_location_bag", "targetname");
    if (!isdefined(struct)) {
        return;
    }
    level.var_8e1fd3d4 = spawn("script_origin", struct.origin);
    level.var_8e1fd3d4 playsoundwithnotify("vox_egg_story_5_7", "sounddone");
    level.var_8e1fd3d4 waittill(#"sounddone");
    level.var_8e1fd3d4 playsoundwithnotify("vox_egg_story_5_8", "sounddone");
    level.var_8e1fd3d4 waittill(#"sounddone");
    level.var_8e1fd3d4 delete();
    level.var_8e1fd3d4 = undefined;
}

