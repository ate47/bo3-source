#using scripts/shared/ai/zombie_death;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_audio;
#using scripts/zm/zm_zod_quest;
#using scripts/zm/_bb;
#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;

#namespace namespace_d8d03071;

// Namespace namespace_d8d03071
// Method(s) 23 Total 23
class class_a32cae3d {

    // Namespace namespace_a32cae3d
    // Params 1, eflags: 0x1 linked
    // Checksum 0x98782565, Offset: 0x1d58
    // Size: 0x50e
    function function_7e393675(n_time) {
        switch (self.var_5fd95ddf) {
        case 1:
            foreach (var_5404ad23 in self.var_7d0ff937) {
                var_5404ad23 thread scene::play("p7_fxanim_zm_zod_chain_trap_heart_low_bundle", var_5404ad23);
            }
            break;
        case 2:
            foreach (var_5404ad23 in self.var_7d0ff937) {
                var_5404ad23 scene::stop("p7_fxanim_zm_zod_chain_trap_heart_low_bundle");
            }
            for (i = 0; i < self.var_7d0ff937.size; i++) {
                var_5404ad23 = self.var_7d0ff937[i];
                if (i + 1 == self.var_7d0ff937.size) {
                    var_5404ad23 scene::play("p7_fxanim_zm_zod_chain_trap_heart_pull_bundle", var_5404ad23);
                    continue;
                }
                var_5404ad23 thread scene::play("p7_fxanim_zm_zod_chain_trap_heart_pull_bundle", var_5404ad23);
            }
            n_wait = n_time / 3;
            foreach (var_5404ad23 in self.var_7d0ff937) {
                var_5404ad23 thread scene::play("p7_fxanim_zm_zod_chain_trap_heart_low_bundle", var_5404ad23);
            }
            wait(n_wait);
            foreach (var_5404ad23 in self.var_7d0ff937) {
                var_5404ad23 scene::stop("p7_fxanim_zm_zod_chain_trap_heart_low_bundle");
                var_5404ad23 thread scene::play("p7_fxanim_zm_zod_chain_trap_heart_med_bundle", var_5404ad23);
            }
            wait(n_wait);
            foreach (var_5404ad23 in self.var_7d0ff937) {
                var_5404ad23 scene::stop("p7_fxanim_zm_zod_chain_trap_heart_med_bundle");
                var_5404ad23 thread scene::play("p7_fxanim_zm_zod_chain_trap_heart_fast_bundle", var_5404ad23);
            }
            wait(n_wait);
            foreach (var_5404ad23 in self.var_7d0ff937) {
                var_5404ad23 scene::stop("p7_fxanim_zm_zod_chain_trap_heart_fast_bundle");
            }
            foreach (var_5404ad23 in self.var_7d0ff937) {
                var_5404ad23 thread scene::play("p7_fxanim_zm_zod_chain_trap_heart_low_bundle", var_5404ad23);
            }
            break;
        case 3:
            break;
        case 0:
            break;
        }
    }

    // Namespace namespace_a32cae3d
    // Params 2, eflags: 0x1 linked
    // Checksum 0x2fbb851f, Offset: 0x1cd0
    // Size: 0x7c
    function hint_string(string, cost) {
        if (isdefined(cost)) {
            self sethintstring(string, cost);
        } else {
            self sethintstring(string);
        }
        self setcursorhint("HINT_NOICON");
    }

    // Namespace namespace_a32cae3d
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd20afd6, Offset: 0x1c90
    // Size: 0x34
    function function_8e2169c7() {
        self.var_7d0ff937[0] clientfield::set("trap_chain_state", self.var_5fd95ddf);
    }

    // Namespace namespace_a32cae3d
    // Params 1, eflags: 0x1 linked
    // Checksum 0x1c926487, Offset: 0x1ba0
    // Size: 0xe4
    function function_a99cc5f4(ent) {
        if (!isvehicle(ent) && ent.team != "allies") {
            ent.a.gib_ref = array::random(array("guts", "right_arm", "left_arm", "head"));
            ent thread zombie_death::do_gib();
            if (isplayer(self.var_a24b1717)) {
                self.var_a24b1717 zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_TRAP");
            }
        }
    }

    // Namespace namespace_a32cae3d
    // Params 1, eflags: 0x1 linked
    // Checksum 0xa86c9c3b, Offset: 0x19c0
    // Size: 0x1d2
    function function_35a5835b(ent) {
        ent endon(#"death");
        if (isdefined(ent.trap_damage_cooldown)) {
            return;
        }
        ent.trap_damage_cooldown = 1;
        if (isdefined(ent.maxhealth) && self.var_12a7c9a2 >= ent.maxhealth && !isvehicle(ent)) {
            function_a99cc5f4(ent);
            ent dodamage(ent.maxhealth * 0.5, ent.origin, self.var_faf8139, self.var_faf8139, "MOD_GRENADE");
            wait(self.var_8bfee5e9);
            function_a99cc5f4(ent);
            ent dodamage(ent.maxhealth, ent.origin, self.var_faf8139, self.var_faf8139, "MOD_GRENADE");
            ent.trap_damage_cooldown = undefined;
            return;
        }
        function_a99cc5f4(ent);
        ent dodamage(self.var_12a7c9a2, ent.origin, self.var_faf8139, self.var_faf8139, "MOD_GRENADE");
        wait(self.var_8bfee5e9);
        ent.trap_damage_cooldown = undefined;
    }

    // Namespace namespace_a32cae3d
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3c64bfa, Offset: 0x1880
    // Size: 0x132
    function function_60ac5038(ent) {
        ent endon(#"death");
        ent endon(#"disconnect");
        if (ent laststand::player_is_in_laststand()) {
            return;
        }
        if (isdefined(ent.trap_damage_cooldown)) {
            return;
        }
        ent.trap_damage_cooldown = 1;
        if (!ent hasperk("specialty_armorvest") || ent.health - 100 < 1) {
            ent dodamage(self.var_820db121, ent.origin);
            ent.trap_damage_cooldown = undefined;
            return;
        }
        ent dodamage(self.var_820db121 / 2, ent.origin);
        wait(self.var_1e59abc0);
        ent.trap_damage_cooldown = undefined;
    }

    // Namespace namespace_a32cae3d
    // Params 0, eflags: 0x1 linked
    // Checksum 0x10350fc0, Offset: 0x1710
    // Size: 0x168
    function trap_damage() {
        self endon(#"trap_done");
        self.var_faf8139._trap_type = "chain";
        while (true) {
            ent = self.var_faf8139 waittill(#"trigger");
            self.var_faf8139.activated_by_player = self.var_a24b1717;
            if (isplayer(ent)) {
                if (ent getstance() == "prone" || ent isonslide()) {
                    continue;
                }
                thread function_60ac5038(ent);
                continue;
            }
            if (isdefined(ent.marked_for_death)) {
                continue;
            }
            if (isdefined(ent.missinglegs) && ent.missinglegs) {
                continue;
            }
            if (isdefined(ent.var_de36fc8)) {
                ent [[ ent.var_de36fc8 ]](self);
                continue;
            }
            thread function_35a5835b(ent);
        }
    }

    // Namespace namespace_a32cae3d
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9f6a23c4, Offset: 0x16d0
    // Size: 0x34
    function function_6b0a262b() {
        self.var_faf8139 setinvisibletoall();
        self.var_faf8139 triggerenable(0);
    }

    // Namespace namespace_a32cae3d
    // Params 0, eflags: 0x1 linked
    // Checksum 0xce326d45, Offset: 0x1690
    // Size: 0x34
    function trap_cooldown() {
        self.var_faf8139 setinvisibletoall();
        self.var_faf8139 triggerenable(0);
    }

    // Namespace namespace_a32cae3d
    // Params 0, eflags: 0x1 linked
    // Checksum 0x46d92123, Offset: 0x1618
    // Size: 0x6c
    function function_d8823dfd() {
        /#
            println("pap");
        #/
        self.var_faf8139 setvisibletoall();
        self.var_faf8139 triggerenable(1);
        thread trap_damage();
    }

    // Namespace namespace_a32cae3d
    // Params 0, eflags: 0x1 linked
    // Checksum 0x944afdaa, Offset: 0x15d8
    // Size: 0x34
    function function_cafd3848() {
        self.var_faf8139 setinvisibletoall();
        self.var_faf8139 triggerenable(0);
    }

    // Namespace namespace_a32cae3d
    // Params 0, eflags: 0x1 linked
    // Checksum 0x17a3aa36, Offset: 0x1520
    // Size: 0xae
    function function_8aa04a46() {
        switch (self.var_5fd95ddf) {
        case 1:
            function_cafd3848();
            break;
        case 2:
            function_d8823dfd();
            self notify(#"trap_start");
            break;
        case 3:
            trap_cooldown();
            self notify(#"trap_done");
            break;
        case 0:
            function_6b0a262b();
            self notify(#"trap_done");
            break;
        }
    }

    // Namespace namespace_a32cae3d
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3fe25a4e, Offset: 0x14e0
    // Size: 0x34
    function function_b099e8e(t_use) {
        if (self.var_54d81d07 != 1) {
        }
        self thread function_8e2169c7();
    }

    // Namespace namespace_a32cae3d
    // Params 1, eflags: 0x1 linked
    // Checksum 0xfabc8336, Offset: 0x13d8
    // Size: 0xfc
    function function_f24ddcd3(t_use) {
        function_7e393675(undefined);
        if (self.var_54d81d07 != 1) {
        }
        foreach (var_5404ad23 in self.var_7d0ff937) {
            var_5404ad23 moveto(var_5404ad23.origin - (0, 0, -32), 0.25);
        }
        wait(0.25);
        self thread function_8e2169c7();
    }

    // Namespace namespace_a32cae3d
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3eaf304f, Offset: 0x1320
    // Size: 0xac
    function function_53e7782e(t_use) {
        if (!self.var_7a01aaae) {
            level thread zm_audio::sndmusicsystem_playstate("trap");
            self.var_7a01aaae = 1;
        }
        var_74a8cf96 = 30;
        self thread function_7e393675(var_74a8cf96);
        wait(0.25);
        self.var_faf8139 playsound("zmb_trap_activate");
        self thread function_8e2169c7();
    }

    // Namespace namespace_a32cae3d
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8bcd29b7, Offset: 0x12c8
    // Size: 0x4c
    function function_cfeaece1(t_use) {
        function_7e393675(undefined);
        if (self.var_54d81d07 != 1) {
        }
        self thread function_8e2169c7();
    }

    // Namespace namespace_a32cae3d
    // Params 1, eflags: 0x1 linked
    // Checksum 0xeff06ca4, Offset: 0x1220
    // Size: 0x9e
    function function_d84562ad(t_use) {
        switch (self.var_5fd95ddf) {
        case 1:
            function_cfeaece1(t_use);
            break;
        case 2:
            function_53e7782e(t_use);
            break;
        case 3:
            function_f24ddcd3(t_use);
            break;
        case 0:
            function_b099e8e(t_use);
            break;
        }
    }

    // Namespace namespace_a32cae3d
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5f2465e1, Offset: 0x10f8
    // Size: 0x11e
    function function_e95944e1() {
        switch (self.var_5fd95ddf) {
        case 1:
            array::thread_all(self.var_2fbb8bbb, &hint_string, self.var_42b9bb70, self.var_159266ff);
            break;
        case 2:
            array::thread_all(self.var_2fbb8bbb, &hint_string, self.var_9f1e30f5);
            break;
        case 3:
            array::thread_all(self.var_2fbb8bbb, &hint_string, self.var_9082d410);
            break;
        case 0:
            array::thread_all(self.var_2fbb8bbb, &hint_string, self.var_cec4c4e3);
            break;
        }
    }

    // Namespace namespace_a32cae3d
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb6d7f878, Offset: 0xe98
    // Size: 0x258
    function function_10b03792(var_1f29d07e) {
        while (true) {
            who = self waittill(#"trigger");
            if (who zm_utility::in_revive_trigger()) {
                continue;
            }
            if (who.is_drinking > 0) {
                continue;
            }
            if (!zm_utility::is_player_valid(who)) {
                continue;
            }
            if (!who zm_score::can_player_purchase(var_1f29d07e.var_159266ff)) {
                continue;
            }
            if (var_1f29d07e.var_5fd95ddf != 1) {
                continue;
            }
            var_1f29d07e.var_5fd95ddf = 2;
            var_1f29d07e.var_a24b1717 = who;
            bb::logpurchaseevent(who, self, var_1f29d07e.var_159266ff, self.targetname, 0, "_trap", "_purchased");
            who zm_score::minus_to_player_score(var_1f29d07e.var_159266ff);
            [[ var_1f29d07e ]]->function_e95944e1();
            [[ var_1f29d07e ]]->function_d84562ad(self);
            [[ var_1f29d07e ]]->function_8aa04a46();
            who thread zm_audio::create_and_play_dialog("trap", "start");
            wait(var_1f29d07e.var_2ac38075);
            var_1f29d07e.var_5fd95ddf = 3;
            [[ var_1f29d07e ]]->function_8aa04a46();
            [[ var_1f29d07e ]]->function_d84562ad(self);
            [[ var_1f29d07e ]]->function_e95944e1();
            wait(var_1f29d07e.var_3e336f90);
            var_1f29d07e.var_5fd95ddf = 1;
            [[ var_1f29d07e ]]->function_e95944e1();
            [[ var_1f29d07e ]]->function_d84562ad(self);
            [[ var_1f29d07e ]]->function_8aa04a46();
        }
    }

    // Namespace namespace_a32cae3d
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7e4fb803, Offset: 0xe58
    // Size: 0x34
    function function_1bfbfa4c(e_entity, var_6b6cc590) {
        if (e_entity.prefabname !== var_6b6cc590) {
            return false;
        }
        return true;
    }

    // Namespace namespace_a32cae3d
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8e2e5e79, Offset: 0x9b0
    // Size: 0x49c
    function function_f46f1aeb(var_6b6cc590) {
        self.var_5fd95ddf = 1;
        self.var_7a01aaae = 0;
        self.var_54d81d07 = 0;
        self.var_159266ff = 1000;
        self.var_2ac38075 = 25;
        self.var_3e336f90 = 25;
        self.var_1e59abc0 = 1;
        self.var_8bfee5e9 = 0.25;
        self.var_820db121 = 25;
        self.var_12a7c9a2 = 6500;
        self.var_cec4c4e3 = %ZM_ZOD_TRAP_CHAIN_UNAVAILABLE;
        self.var_42b9bb70 = %ZM_ZOD_TRAP_CHAIN_AVAILABLE;
        self.var_9f1e30f5 = %ZM_ZOD_TRAP_CHAIN_ACTIVE;
        self.var_9082d410 = %ZM_ZOD_TRAP_CHAIN_COOLDOWN;
        var_69299131 = getentarray("trap_chain_damage", "targetname");
        var_69299131 = array::filter(var_69299131, 0, &function_1bfbfa4c, var_6b6cc590);
        var_f0bc3cc1 = getentarray("trap_chain_rumble", "targetname");
        var_f0bc3cc1 = array::filter(var_69299131, 0, &function_1bfbfa4c, var_6b6cc590);
        self.var_7d0ff937 = getentarray("trap_chain_heart", "targetname");
        self.var_7d0ff937 = array::filter(self.var_7d0ff937, 0, &function_1bfbfa4c, var_6b6cc590);
        self.var_2fbb8bbb = getentarray("use_trap_chain", "targetname");
        self.var_2fbb8bbb = array::filter(self.var_2fbb8bbb, 0, &function_1bfbfa4c, var_6b6cc590);
        function_e95944e1();
        array::thread_all(self.var_2fbb8bbb, &function_10b03792, self);
        var_d186b130 = [];
        var_d186b130[0] = "theater";
        var_d186b130[1] = "slums";
        var_d186b130[2] = "canals";
        var_d186b130[3] = "pap";
        foreach (var_740f8e9f in self.var_7d0ff937) {
            for (i = 0; i < var_d186b130.size; i++) {
                if (var_d186b130[i] == var_740f8e9f.prefabname) {
                    var_740f8e9f clientfield::set("trap_chain_location", i);
                }
            }
        }
        self.var_faf8139 = var_69299131[0];
        self.var_723e9919 = var_f0bc3cc1[0];
        var_29a9b54e = struct::get_array("trap_chain_audio_loc", "targetname");
        var_29a9b54e = array::filter(var_29a9b54e, 0, &function_1bfbfa4c, var_6b6cc590);
        self.var_366b1f63 = var_29a9b54e[0];
        self.var_366b1f63 = spawn("script_origin", self.var_366b1f63.origin);
        self.var_99b965df = 0;
        self thread function_8e2169c7();
    }

}

// Namespace namespace_d8d03071
// Params 0, eflags: 0x2
// Checksum 0xb414e397, Offset: 0x528
// Size: 0x34
function function_2dc19561() {
    system::register("zm_zod_traps", &__init__, undefined, undefined);
}

// Namespace namespace_d8d03071
// Params 0, eflags: 0x1 linked
// Checksum 0x1b9ab328, Offset: 0x568
// Size: 0x64
function __init__() {
    clientfield::register("scriptmover", "trap_chain_state", 1, 2, "int");
    clientfield::register("scriptmover", "trap_chain_location", 1, 2, "int");
}

// Namespace namespace_d8d03071
// Params 0, eflags: 0x1 linked
// Checksum 0x87fff9bd, Offset: 0x5d8
// Size: 0xac
function init_traps() {
    if (!isdefined(level.var_bd9e44cc)) {
        level.var_bd9e44cc = [];
        function_f46f1aeb("theater");
        function_f46f1aeb("slums");
        function_f46f1aeb("canals");
        function_f46f1aeb("pap");
    }
    flag::wait_till("all_players_spawned");
    function_89303c72(undefined);
}

// Namespace namespace_d8d03071
// Params 1, eflags: 0x1 linked
// Checksum 0x69ac3fef, Offset: 0x690
// Size: 0x5c
function function_f46f1aeb(var_6b6cc590) {
    if (!isdefined(level.var_bd9e44cc[var_6b6cc590])) {
        level.var_bd9e44cc[var_6b6cc590] = new class_a32cae3d();
        [[ level.var_bd9e44cc[var_6b6cc590] ]]->function_f46f1aeb(var_6b6cc590);
    }
}

// Namespace namespace_d8d03071
// Params 1, eflags: 0x1 linked
// Checksum 0xa031d45b, Offset: 0x6f8
// Size: 0x1e4
function function_89303c72(var_f6caa7fd) {
    var_cdd779bd = getarraykeys(level.var_bd9e44cc);
    foreach (str_index in var_cdd779bd) {
        if (str_index != "pap") {
            level.var_bd9e44cc[str_index].var_5fd95ddf = 1;
            [[ level.var_bd9e44cc[str_index] ]]->function_8aa04a46();
            [[ level.var_bd9e44cc[str_index] ]]->function_d84562ad(level.var_bd9e44cc[str_index].var_7d0ff937[0]);
            [[ level.var_bd9e44cc[str_index] ]]->function_e95944e1();
        }
    }
    level.var_bd9e44cc["pap"].var_5fd95ddf = 0;
    [[ level.var_bd9e44cc["pap"] ]]->function_8aa04a46();
    [[ level.var_bd9e44cc["pap"] ]]->function_d84562ad(level.var_bd9e44cc["pap"].var_7d0ff937[0]);
    [[ level.var_bd9e44cc["pap"] ]]->function_e95944e1();
    level thread function_8144bbbe();
}

// Namespace namespace_d8d03071
// Params 0, eflags: 0x1 linked
// Checksum 0x887fccef, Offset: 0x8e8
// Size: 0xc0
function function_8144bbbe() {
    level flag::wait_till("pap_door_open");
    level.var_bd9e44cc["pap"].var_5fd95ddf = 1;
    [[ level.var_bd9e44cc["pap"] ]]->function_8aa04a46();
    [[ level.var_bd9e44cc["pap"] ]]->function_d84562ad(level.var_bd9e44cc["pap"].var_7d0ff937[0]);
    [[ level.var_bd9e44cc["pap"] ]]->function_e95944e1();
}

