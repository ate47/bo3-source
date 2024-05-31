#using scripts/zm/zm_challenges_tomb;
#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_teleporter;
#using scripts/zm/zm_tomb_quest_ice;
#using scripts/zm/zm_tomb_quest_fire;
#using scripts/zm/zm_tomb_quest_elec;
#using scripts/zm/zm_tomb_quest_crypt;
#using scripts/zm/zm_tomb_quest_air;
#using scripts/zm/zm_tomb_ee_main_step_7;
#using scripts/zm/zm_tomb_craftables;
#using scripts/zm/zm_tomb_chamber;
#using scripts/zm/zm_tomb_challenges;
#using scripts/zm/zm_tomb_amb;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_73b257ea;

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_d0ef4f2
// Checksum 0x22948c8c, Offset: 0x1038
// Size: 0x100c
function function_d0ef4f2() {
    level flag::init("dug");
    level flag::init("air_open");
    level flag::init("fire_open");
    level flag::init("lightning_open");
    level flag::init("ice_open");
    level flag::init("panels_solved");
    level flag::init("fire_solved");
    level flag::init("ice_solved");
    level flag::init("chamber_puzzle_cheat");
    level flag::init("activate_zone_crypt");
    level flag::init("staff_air_upgrade_unlocked");
    level flag::init("staff_water_upgrade_unlocked");
    level flag::init("staff_fire_upgrade_unlocked");
    level flag::init("staff_lightning_upgrade_unlocked");
    level.callbackvehicledamage = &function_cfa46a29;
    level.var_7e94ca68 = &function_274675ef;
    callback::on_connect(&onplayerconnect);
    var_4cfc1418 = getent("prop_staff_air", "targetname");
    var_86d6dfd0 = getent("prop_staff_fire", "targetname");
    var_42cec962 = getent("prop_staff_lightning", "targetname");
    var_50f83521 = getent("prop_staff_water", "targetname");
    var_4cfc1418.weapname = "staff_air";
    var_86d6dfd0.weapname = "staff_fire";
    var_42cec962.weapname = "staff_lightning";
    var_50f83521.weapname = "staff_water";
    var_4cfc1418.w_weapon = getweapon("staff_air");
    var_86d6dfd0.w_weapon = getweapon("staff_fire");
    var_42cec962.w_weapon = getweapon("staff_lightning");
    var_50f83521.w_weapon = getweapon("staff_water");
    var_4cfc1418.element = "air";
    var_86d6dfd0.element = "fire";
    var_42cec962.element = "lightning";
    var_50f83521.element = "water";
    var_4cfc1418.var_9967ff1 = "elemental_staff_air";
    var_86d6dfd0.var_9967ff1 = "elemental_staff_fire";
    var_42cec962.var_9967ff1 = "elemental_staff_lightning";
    var_50f83521.var_9967ff1 = "elemental_staff_water";
    var_4cfc1418.var_43f3f5e5 = struct::get("staff_air_charger", "script_noteworthy");
    var_86d6dfd0.var_43f3f5e5 = struct::get("staff_fire_charger", "script_noteworthy");
    var_42cec962.var_43f3f5e5 = struct::get("zone_bolt_chamber", "script_noteworthy");
    var_50f83521.var_43f3f5e5 = struct::get("staff_ice_charger", "script_noteworthy");
    var_86d6dfd0.var_e1950593 = "fire_staff.quest_state";
    var_4cfc1418.var_e1950593 = "air_staff.quest_state";
    var_42cec962.var_e1950593 = "lightning_staff.quest_state";
    var_50f83521.var_e1950593 = "water_staff.quest_state";
    var_86d6dfd0.enum = 1;
    var_4cfc1418.enum = 2;
    var_42cec962.enum = 3;
    var_50f83521.enum = 4;
    level.var_b0d8f1fe = [];
    level.var_b0d8f1fe["staff_air"] = var_4cfc1418;
    level.var_b0d8f1fe["staff_fire"] = var_86d6dfd0;
    level.var_b0d8f1fe["staff_lightning"] = var_42cec962;
    level.var_b0d8f1fe["staff_water"] = var_50f83521;
    foreach (var_d16491f1 in level.var_b0d8f1fe) {
        var_d16491f1.var_43f3f5e5.var_9a544ea2 = 0;
        var_d16491f1.var_43f3f5e5.var_2d46dee8 = 0;
        var_d16491f1 thread function_bfed2be();
        var_d16491f1 thread function_74205b8f();
        var_d16491f1 ghost();
    }
    var_2b121b3b = getent("prop_staff_air_upgraded", "targetname");
    var_9eb44c13 = getent("prop_staff_fire_upgraded", "targetname");
    var_3967159d = getent("prop_staff_lightning_upgraded", "targetname");
    var_eff42184 = getent("prop_staff_water_upgraded", "targetname");
    var_2b121b3b.weapname = "staff_air_upgraded";
    var_9eb44c13.weapname = "staff_fire_upgraded";
    var_3967159d.weapname = "staff_lightning_upgraded";
    var_eff42184.weapname = "staff_water_upgraded";
    var_2b121b3b.w_weapon = getweapon("staff_air_upgraded");
    var_9eb44c13.w_weapon = getweapon("staff_fire_upgraded");
    var_3967159d.w_weapon = getweapon("staff_lightning_upgraded");
    var_eff42184.w_weapon = getweapon("staff_water_upgraded");
    var_2b121b3b.var_ae1f4067 = "staff_air";
    var_9eb44c13.var_ae1f4067 = "staff_fire";
    var_3967159d.var_ae1f4067 = "staff_lightning";
    var_eff42184.var_ae1f4067 = "staff_water";
    var_2b121b3b.element = "air";
    var_9eb44c13.element = "fire";
    var_3967159d.element = "lightning";
    var_eff42184.element = "water";
    var_2b121b3b.var_43f3f5e5 = var_4cfc1418.var_43f3f5e5;
    var_9eb44c13.var_43f3f5e5 = var_86d6dfd0.var_43f3f5e5;
    var_3967159d.var_43f3f5e5 = var_42cec962.var_43f3f5e5;
    var_eff42184.var_43f3f5e5 = var_50f83521.var_43f3f5e5;
    var_9eb44c13.enum = 1;
    var_2b121b3b.enum = 2;
    var_3967159d.enum = 3;
    var_eff42184.enum = 4;
    var_4cfc1418.upgrade = var_2b121b3b;
    var_86d6dfd0.upgrade = var_9eb44c13;
    var_50f83521.upgrade = var_eff42184;
    var_42cec962.upgrade = var_3967159d;
    level.var_66561721 = [];
    level.var_66561721["staff_air_upgraded"] = var_2b121b3b;
    level.var_66561721["staff_fire_upgraded"] = var_9eb44c13;
    level.var_66561721["staff_lightning_upgraded"] = var_3967159d;
    level.var_66561721["staff_water_upgraded"] = var_eff42184;
    foreach (var_78f716b4 in level.var_66561721) {
        var_78f716b4.var_43f3f5e5.var_9a544ea2 = 0;
        var_78f716b4.var_43f3f5e5.var_2d46dee8 = 0;
        var_78f716b4.var_43f3f5e5.is_charged = 0;
        var_78f716b4.var_960d7618 = var_78f716b4.w_weapon.clipsize;
        var_78f716b4.var_e1678378 = var_78f716b4.w_weapon.startammo;
        var_78f716b4 thread function_bfed2be();
        var_78f716b4 ghost();
    }
    foreach (var_d16491f1 in level.var_b0d8f1fe) {
        var_d16491f1.var_960d7618 = var_d16491f1.w_weapon.clipsize;
        var_d16491f1.var_e1678378 = var_d16491f1.w_weapon.startammo;
        var_d16491f1.upgrade.var_4c6fbb02 = var_d16491f1;
    }
    level.var_2b2f83e5 = getweapon("staff_revive");
    level.var_3a4c542d = 0;
    array::thread_all(level.zombie_spawners, &spawner::add_spawn_function, &function_162da110);
    level thread function_72036347();
    level thread function_2dae9719();
    level thread namespace_dc8f4c29::main();
    level thread namespace_90429ef7::main();
    level thread namespace_c020b26c::main();
    level thread namespace_c9fb2a74::main();
    level thread namespace_acbbd1f9::main();
    level thread namespace_435339fc::main();
    level thread namespace_ad52727b::function_f45a2e2c("puzzle", "puzzle_confused", "vo_puzzle_confused");
    level thread namespace_ad52727b::function_f45a2e2c("puzzle", "puzzle_good", "vo_puzzle_good");
    level thread namespace_ad52727b::function_f45a2e2c("puzzle", "puzzle_bad", "vo_puzzle_bad");
    level thread namespace_ad52727b::function_69744aec("vox_sam_ice_staff_clue_0", "sam_clue_dig", "elemental_staff_water_all_pieces_found");
    level thread namespace_ad52727b::function_69744aec("vox_sam_fire_staff_clue_0", "sam_clue_mechz", "mechz_killed");
    level thread namespace_ad52727b::function_69744aec("vox_sam_fire_staff_clue_1", "sam_clue_biplane", "biplane_down");
    level thread namespace_ad52727b::function_69744aec("vox_sam_fire_staff_clue_2", "sam_clue_zonecap", "staff_piece_capture_complete");
    level thread namespace_ad52727b::function_69744aec("vox_sam_lightning_staff_clue_0", "sam_clue_tank", "elemental_staff_lightning_all_pieces_found");
    level thread namespace_ad52727b::function_69744aec("vox_sam_wind_staff_clue_0", "sam_clue_giant", "elemental_staff_air_all_pieces_found");
    level.var_55b27a6d = getentarray("zombie_spawner_dig", "script_noteworthy");
    array::thread_all(level.var_55b27a6d, &spawner::add_spawn_function, &namespace_d7c0ce12::function_3b0e9b9);
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_603848d5
// Checksum 0x99ec1590, Offset: 0x2050
// Size: 0x4
function onplayerconnect() {
    
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_274675ef
// Checksum 0xa33fd48c, Offset: 0x2060
// Size: 0x5c
function function_274675ef(player) {
    var_d95a0cf3 = player.characterindex + 1;
    level util::delay(0.5, undefined, &namespace_f7a613cf::function_fca8537d, var_d95a0cf3);
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_bfed2be
// Checksum 0x9a70d657, Offset: 0x20c8
// Size: 0x34
function function_bfed2be() {
    self.origin = self.var_43f3f5e5.origin;
    self.angles = self.var_43f3f5e5.angles;
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_2dae9719
// Checksum 0x120f94c1, Offset: 0x2108
// Size: 0x1d4
function function_2dae9719() {
    level flag::init("gramophone_placed");
    array::thread_all(getentarray("trigger_death_floor", "targetname"), &function_28f123ad);
    var_994713ee = struct::get_array("stargate_gramophone_pos", "targetname");
    array::thread_all(var_994713ee, &function_c9afeca);
    var_78667a9f = getentarray("chamber_entrance", "targetname");
    foreach (e_door in var_78667a9f) {
        if (e_door.classname == "script_brushmodel") {
            e_door connectpaths();
        }
    }
    var_78667a9f[0] linkto(var_78667a9f[1]);
    var_78667a9f[1] thread function_9a635b02("vinyl_master", var_78667a9f[0]);
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_28f123ad
// Checksum 0x73f0adc, Offset: 0x22e8
// Size: 0x90
function function_28f123ad() {
    while (true) {
        ent = self waittill(#"trigger");
        if (isplayer(ent)) {
            ent.bleedout_time = 0;
        }
        ent dodamage(ent.health + 666, ent.origin);
        wait(0.05);
    }
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_29d21fcb
// Checksum 0x65880ef9, Offset: 0x2380
// Size: 0xd0
function function_29d21fcb() {
    var_c8bbf115 = "vinyl_main";
    switch (self.script_int) {
    case 1:
        var_c8bbf115 = "vinyl_fire";
        break;
    case 2:
        var_c8bbf115 = "vinyl_air";
        break;
    case 3:
        var_c8bbf115 = "vinyl_elec";
        break;
    case 4:
        var_c8bbf115 = "vinyl_ice";
        break;
    default:
        var_c8bbf115 = "vinyl_master";
        break;
    }
    level waittill("gramophone_" + var_c8bbf115 + "_picked_up");
    self.var_4bdcc96e = 1;
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_dd37a0f6
// Checksum 0x48496f82, Offset: 0x2458
// Size: 0x7e
function function_dd37a0f6() {
    switch (self.script_int) {
    case 1:
        return "mus_gramophone_fire";
    case 2:
        return "mus_gramophone_air";
    case 3:
        return "mus_gramophone_electric";
    case 4:
        return "mus_gramophone_ice";
    default:
        return "mus_gramophone_electric";
    }
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_c9afeca
// Checksum 0xf4e569d6, Offset: 0x24e0
// Size: 0x3f0
function function_c9afeca(var_c8bbf115) {
    self.var_4bdcc96e = 0;
    self.var_3b3e77ef = undefined;
    self thread function_29d21fcb();
    var_df264b8a = namespace_d7c0ce12::function_52854313(self.origin, 60, 1);
    var_df264b8a namespace_d7c0ce12::function_d73e42e0(%ZOMBIE_BUILD_PIECE_MORE);
    level waittill(#"hash_8ffa2305");
    var_f1b804b0 = "gramophone";
    var_df264b8a namespace_d7c0ce12::function_d73e42e0(%ZM_TOMB_RU);
    while (!self.var_4bdcc96e) {
        wait(0.05);
    }
    var_df264b8a namespace_d7c0ce12::function_d73e42e0(%ZM_TOMB_PLGR);
    while (true) {
        player = var_df264b8a waittill(#"trigger");
        if (!isdefined(self.var_3b3e77ef)) {
            if (!level flag::get("gramophone_placed")) {
                self.var_3b3e77ef = spawn("script_model", self.origin);
                self.var_3b3e77ef.angles = self.angles;
                self.var_3b3e77ef setmodel("p7_spl_gramophone");
                level clientfield::set("piece_record_zm_player", 0);
                level flag::set("gramophone_placed");
                var_df264b8a namespace_d7c0ce12::function_d73e42e0("");
                var_a12ba5e = self function_dd37a0f6();
                self.var_3b3e77ef playsound(var_a12ba5e);
                player thread namespace_ad52727b::function_62377910();
                namespace_97bec092::function_b67726d8(self.script_int);
                level flag::wait_till("teleporter_building_" + self.script_int);
                level flag::wait_till_clear("teleporter_building_" + self.script_int);
                var_df264b8a namespace_d7c0ce12::function_d73e42e0(%ZM_TOMB_PUGR);
                if (isdefined(self.script_flag)) {
                    level flag::set(self.script_flag);
                }
            } else {
                player namespace_d7c0ce12::function_837cc95f();
            }
            continue;
        }
        self.var_3b3e77ef delete();
        self.var_3b3e77ef = undefined;
        player playsound("zmb_craftable_pickup");
        level flag::clear("gramophone_placed");
        level clientfield::set("piece_record_zm_player", 1);
        namespace_97bec092::function_2e709a83(self.script_int);
        var_df264b8a namespace_d7c0ce12::function_d73e42e0(%ZM_TOMB_PLGR);
    }
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_dbdab83d
// Checksum 0xdaa01df2, Offset: 0x28d8
// Size: 0x7c
function function_dbdab83d() {
    /#
        level util::waittill_any("chamber_puzzle_cheat", "chamber_puzzle_cheat");
        self.var_4bdcc96e = 1;
        level.var_5b298609 = 1;
        wait(0.5);
        if (isdefined(self.trigger)) {
            self.trigger notify(#"trigger", getplayers()[0]);
        }
    #/
}

// Namespace namespace_73b257ea
// Params 2, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_9a635b02
// Checksum 0xc8b5b83a, Offset: 0x2960
// Size: 0x5fa
function function_9a635b02(var_c8bbf115, var_ac769486) {
    level flag::init(self.targetname + "_opened");
    level flag::init("crypt_opened");
    var_93400c0b = struct::get(self.targetname + "_position", "targetname");
    var_93400c0b.var_4bdcc96e = 0;
    var_93400c0b.var_3b3e77ef = undefined;
    var_93400c0b thread function_29d21fcb();
    var_93400c0b thread function_dbdab83d();
    t_door = namespace_d7c0ce12::function_52854313(var_93400c0b.origin, 60, 1, undefined, &function_ed81ffaa);
    t_door namespace_d7c0ce12::function_d73e42e0(%ZOMBIE_BUILD_PIECE_MORE);
    level util::waittill_any("gramophone_vinyl_player_picked_up", "open_sesame", "open_all_gramophone_doors");
    var_f1b804b0 = "gramophone";
    t_door namespace_d7c0ce12::function_d73e42e0(%ZM_TOMB_RU);
    var_93400c0b.trigger = t_door;
    while (!var_93400c0b.var_4bdcc96e) {
        wait(0.05);
    }
    t_door namespace_d7c0ce12::function_d73e42e0(%ZM_TOMB_PLGR);
    while (true) {
        player = t_door waittill(#"trigger");
        if (!isdefined(var_93400c0b.var_3b3e77ef)) {
            if (isdefined(level.var_5b298609) && (!level flag::get("gramophone_placed") || level.var_5b298609)) {
                if (!(isdefined(level.var_5b298609) && level.var_5b298609)) {
                    var_93400c0b.var_3b3e77ef = spawn("script_model", var_93400c0b.origin);
                    var_93400c0b.var_3b3e77ef.angles = var_93400c0b.angles;
                    var_93400c0b.var_3b3e77ef setmodel("p7_spl_gramophone");
                    level flag::set("gramophone_placed");
                    level clientfield::set("piece_record_zm_player", 0);
                }
                var_75fd9166 = var_93400c0b function_dd37a0f6();
                playsoundatposition(var_75fd9166, self.origin);
                t_door namespace_d7c0ce12::function_d73e42e0("");
                self playsound("zmb_crypt_stairs");
                wait(6);
                function_89084792();
                level flag::set(self.targetname + "_opened");
                if (isdefined(var_93400c0b.script_flag)) {
                    level flag::set(var_93400c0b.script_flag);
                }
                level clientfield::set("crypt_open_exploder", 1);
                self movez(-260, 10, 1, 1);
                self waittill(#"movedone");
                var_ac769486 connectpaths();
                var_ac769486 delete();
                self delete();
                t_door namespace_d7c0ce12::function_d73e42e0(%ZM_TOMB_PUGR);
                if (isdefined(level.var_5b298609) && level.var_5b298609) {
                    break;
                }
            } else {
                player namespace_d7c0ce12::function_837cc95f();
            }
            continue;
        }
        var_93400c0b.var_3b3e77ef delete();
        var_93400c0b.var_3b3e77ef = undefined;
        level flag::clear("gramophone_placed");
        level flag::set("crypt_opened");
        player playsound("zmb_craftable_pickup");
        level clientfield::set("piece_record_zm_player", 1);
        break;
    }
    t_door namespace_d7c0ce12::function_bd611266();
    var_93400c0b.trigger = undefined;
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_ed81ffaa
// Checksum 0xa5391fa2, Offset: 0x2f68
// Size: 0x54
function function_ed81ffaa(player) {
    if (isdefined(level.var_5b298609) && (level flag::get("crypt_opened") || level.var_5b298609)) {
        return 0;
    }
    return 1;
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_89084792
// Checksum 0xcfa8c41f, Offset: 0x2fc8
// Size: 0x114
function function_89084792() {
    a_blockers = getentarray("junk_nml_chamber", "targetname");
    var_89580319 = getent("junk_nml_chamber", "targetname");
    var_38fcfb15 = struct::get(var_89580319.script_linkto, "script_linkname");
    var_89580319 thread zm_blockers::debris_move(var_38fcfb15);
    var_c24595b6 = getent("junk_nml_chamber_clip", "targetname");
    var_c24595b6 connectpaths();
    var_89580319 waittill(#"movedone");
    var_c24595b6 delete();
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_72036347
// Checksum 0x6c651e2e, Offset: 0x30e8
// Size: 0x8a
function function_72036347() {
    foreach (var_d16491f1 in level.var_b0d8f1fe) {
        var_d16491f1 thread function_87f105a0();
    }
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_87f105a0
// Checksum 0x340f4482, Offset: 0x3180
// Size: 0x44
function function_87f105a0() {
    level flag::wait_till(self.weapname + "_upgrade_unlocked");
    self thread function_4c21d2de();
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_59ee7527
// Checksum 0xaeca00d5, Offset: 0x31d0
// Size: 0x6c
function function_59ee7527() {
    if (self.element == "air") {
        return %ZM_TOMB_PUAS;
    }
    if (self.element == "fire") {
        return %ZM_TOMB_PUFS;
    }
    if (self.element == "lightning") {
        return %ZM_TOMB_PULS;
    }
    return %ZM_TOMB_PUIS;
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_e425716c
// Checksum 0xf38cd378, Offset: 0x3248
// Size: 0x6c
function function_e425716c() {
    if (self.element == "air") {
        return %ZM_TOMB_INAS;
    }
    if (self.element == "fire") {
        return %ZM_TOMB_INFS;
    }
    if (self.element == "lightning") {
        return %ZM_TOMB_INLS;
    }
    return %ZM_TOMB_INWS;
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_ceb44f18
// Checksum 0x43711f16, Offset: 0x32c0
// Size: 0xc4
function function_ceb44f18() {
    a_weapons = self getweaponslistprimaries();
    foreach (weapon in a_weapons) {
        if (issubstr(weapon.name, "staff")) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_d19c6953
// Checksum 0x60a8bc88, Offset: 0x3390
// Size: 0xaa
function function_d19c6953() {
    var_a140be3b = self function_ceb44f18();
    w_current = self getcurrentweapon();
    var_d2b3e3b2 = issubstr(w_current.name, "staff");
    if (var_a140be3b && !var_d2b3e3b2) {
        self thread namespace_d7c0ce12::function_85bdbb35();
    }
    return !var_a140be3b || var_d2b3e3b2;
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_5700f562
// Checksum 0x1db904fc, Offset: 0x3448
// Size: 0x388
function function_5700f562() {
    var_ea0a2c74 = 0;
    pickup_message = self function_59ee7527();
    self.trigger namespace_d7c0ce12::function_d73e42e0(pickup_message);
    self show();
    while (!var_ea0a2c74) {
        player = self.trigger waittill(#"trigger");
        self notify(#"hash_a222c18b", player);
        if (player function_d19c6953() && !player bgb::is_enabled("zm_bgb_disorderly_combat")) {
            weapon_drop = player getcurrentweapon();
            a_weapons = player getweaponslistprimaries();
            var_69f11483 = zm_utility::get_player_weapon_limit(player) - 1;
            if (a_weapons.size > var_69f11483) {
                player takeweapon(weapon_drop);
            }
            foreach (weapon in a_weapons) {
                if (issubstr(weapon.name, "staff")) {
                    player takeweapon(weapon);
                }
            }
            player thread function_3da26606();
            self ghost();
            self setinvisibletoall();
            player giveweapon(self.w_weapon);
            player switchtoweapon(self.w_weapon);
            clip_size = self.w_weapon.clipsize;
            player setweaponammoclip(self.w_weapon, clip_size);
            self.owner = player;
            level notify(#"hash_68b2280e");
            self notify(#"hash_c26aea98");
            var_ea0a2c74 = 1;
            self.var_43f3f5e5.var_2d46dee8 = 0;
            self clientfield::set("staff_charger", 0);
            self.var_43f3f5e5.full = 1;
            namespace_f7a613cf::function_476c0e12(self.w_weapon, player);
        }
    }
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_3da26606
// Checksum 0x4f952be0, Offset: 0x37d8
// Size: 0x106
function function_3da26606() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"zmb_max_ammo");
        a_weapons = self getweaponslistprimaries();
        foreach (weapon in a_weapons) {
            if (issubstr(weapon.name, "staff")) {
                self setweaponammoclip(weapon, weapon.maxammo);
            }
        }
    }
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_980fb684
// Checksum 0x4e1dc48e, Offset: 0x38e8
// Size: 0x74
function rotate_forever(rotate_time) {
    if (!isdefined(rotate_time)) {
        rotate_time = 20;
    }
    self endon(#"death");
    while (true) {
        self rotateyaw(360, 20, 0, 0);
        self waittill(#"rotatedone");
    }
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_b15d5ee0
// Checksum 0x997c45de, Offset: 0x3968
// Size: 0x502
function function_b15d5ee0(var_5d35229c) {
    level flag::init("charger_ready_" + var_5d35229c);
    self namespace_f7a613cf::function_c3207981();
    self.origin = self.var_5b55e566.model.origin;
    self.var_5b55e566.model ghost();
    self.var_5b55e566.model movez(-1000, 0.05);
    var_f108c5a8 = getent("crystal_plinth" + var_5d35229c, "targetname");
    var_f108c5a8.v_start = var_f108c5a8.origin;
    var_f108c5a8.var_bba0d2d2 = var_f108c5a8.origin;
    var_f108c5a8.var_bba0d2d2 = (var_f108c5a8.var_bba0d2d2[0], var_f108c5a8.var_bba0d2d2[1], var_f108c5a8.origin[2] + 30);
    var_f108c5a8.var_3ad5964e = var_f108c5a8.origin;
    var_f108c5a8.var_3ad5964e = (var_f108c5a8.var_3ad5964e[0], var_f108c5a8.var_3ad5964e[1], var_f108c5a8.origin[2] + 110);
    var_f108c5a8 moveto(var_f108c5a8.v_start, 0.05);
    while (true) {
        e_player, var_e65e1347 = level waittill(#"hash_62857917");
        if (var_e65e1347 == var_5d35229c) {
            break;
        }
    }
    var_f108c5a8 moveto(var_f108c5a8.var_bba0d2d2, 6);
    var_f108c5a8 thread function_235199d0(6);
    var_78e773b3 = cos(90);
    dist_sq = 250000;
    for (var_a7f54861 = 0; var_a7f54861 < 1 && isdefined(self.var_5b55e566.model); var_a7f54861 = 0) {
        wait(0.1);
        if (!isdefined(self.var_5b55e566.model)) {
            break;
        }
        if (self.var_5b55e566.model namespace_d7c0ce12::function_7340f39f(var_78e773b3, dist_sq)) {
            var_a7f54861 += 0.1;
            continue;
        }
    }
    if (isdefined(self.var_5b55e566.model)) {
        self.var_5b55e566.model movez(985, 0.05);
        self.var_5b55e566.model waittill(#"movedone");
        self.var_5b55e566.model show();
        self.var_5b55e566.model thread rotate_forever();
        self.var_5b55e566.model movez(15, 2);
        self.var_5b55e566.model playloopsound("zmb_squest_crystal_loop", 4.25);
    }
    level flag::wait_till("charger_ready_" + var_5d35229c);
    while (!namespace_435339fc::function_55f62409()) {
        util::wait_network_frame();
    }
    var_f108c5a8 moveto(var_f108c5a8.var_3ad5964e, 3);
    var_f108c5a8 thread function_235199d0(3);
    var_f108c5a8 waittill(#"movedone");
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_235199d0
// Checksum 0x6874353b, Offset: 0x3e78
// Size: 0x8c
function function_235199d0(time) {
    self notify(#"hash_235199d0");
    self endon(#"hash_235199d0");
    self playloopsound("zmb_chamber_plinth_move", 0.25);
    wait(time);
    self stoploopsound(0.1);
    self playsound("zmb_chamber_plinth_stop");
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_4e6893a1
// Checksum 0xb5c8e6f2, Offset: 0x3f10
// Size: 0x1ec
function function_4e6893a1(var_b1028d0b) {
    var_b1028d0b namespace_f7a613cf::function_c3207981();
    var_b1028d0b.var_5b55e566.model ghost();
    for (i = 0; i < 1; i++) {
        origin = level waittill(#"hash_f3f6ac90");
    }
    var_b1028d0b.var_5b55e566.canmove = 1;
    zm_unitrigger::reregister_unitrigger_as_dynamic(var_b1028d0b.var_5b55e566.unitrigger);
    origin = zm_utility::groundpos_ignore_water_new(origin + (0, 0, 40));
    var_b1028d0b.var_5b55e566.model moveto(origin + (0, 0, 16), 0.05);
    var_b1028d0b.var_5b55e566.model waittill(#"movedone");
    if (isdefined(var_b1028d0b.var_5b55e566.model)) {
        var_b1028d0b.var_5b55e566.model show();
        var_b1028d0b.var_5b55e566.model notify(#"hash_cac472aa");
        var_b1028d0b.var_5b55e566.model thread function_800d8bd4();
    }
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_800d8bd4
// Checksum 0x1d327706, Offset: 0x4108
// Size: 0x1c4
function function_800d8bd4() {
    var_88f40f11 = 1000000;
    self endon(#"death");
    wait(120);
    while (true) {
        a_players = getplayers();
        var_f8655093 = 0;
        foreach (e_player in a_players) {
            dist_sq = distance2dsquared(e_player.origin, self.origin);
            if (dist_sq < var_88f40f11) {
                var_f8655093 = 1;
            }
        }
        if (!var_f8655093) {
            break;
        }
        wait(1);
    }
    a_locations = struct::get_array("mechz_location", "script_noteworthy");
    s_location = zm_utility::get_closest_2d(self.origin, a_locations);
    self moveto(s_location.origin + (0, 0, 32), 3);
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_be4d7d9c
// Checksum 0xabbe3861, Offset: 0x42d8
// Size: 0x114
function function_be4d7d9c() {
    self endon(#"death");
    level endon(#"hash_ff6127fb");
    while (true) {
        var_46084b6c = level.round_number;
        while (level.round_number == var_46084b6c) {
            wait(1);
        }
        wait(randomfloatrange(5, 15));
        a_players = getplayers();
        foreach (e_player in a_players) {
            level notify(#"hash_5c3cbf34", e_player);
        }
    }
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_bf15ae49
// Checksum 0xca270938, Offset: 0x43f8
// Size: 0x67a
function function_bf15ae49(var_dc2f4915) {
    foreach (var_65876ba in var_dc2f4915) {
        var_65876ba namespace_f7a613cf::function_c3207981();
        var_65876ba.origin = var_65876ba.var_5b55e566.model.origin;
        var_65876ba.var_5b55e566.model ghost();
        var_65876ba.var_5b55e566.model movez(-500, 0.05);
    }
    level flag::wait_till("activate_zone_village_0");
    var_46084b6c = level.round_number;
    while (level.round_number == var_46084b6c) {
        wait(1);
    }
    var_62bb4e65 = struct::get("air_crystal_biplane_pos", "targetname");
    var_843c3629 = spawnvehicle("biplane_zm", var_62bb4e65.origin, var_62bb4e65.angles, "air_crystal_biplane");
    var_843c3629 flag::init("biplane_down", 0);
    var_843c3629 thread function_be4d7d9c();
    var_51cc03ba = getent("air_crystal_biplane_tag", "targetname");
    var_51cc03ba moveto(var_843c3629.origin, 0.05);
    var_51cc03ba waittill(#"movedone");
    var_51cc03ba linkto(var_843c3629);
    var_843c3629.health = 10000;
    var_843c3629 setcandamage(1);
    var_843c3629 setforcenocull();
    var_843c3629 attachpath(getvehiclenode("biplane_start", "targetname"));
    var_843c3629 setspeed(75, 15, 5);
    var_843c3629 startpath();
    var_51cc03ba clientfield::set("plane_fx", 1);
    var_62bb4e65 struct::delete();
    var_843c3629 flag::wait_till("biplane_down");
    var_843c3629 playsound("zmb_zombieblood_3rd_plane_explode");
    var_843c3629 delete();
    var_51cc03ba clientfield::set("plane_fx", 0);
    playfx(level._effect["biplane_explode"], var_51cc03ba.origin);
    foreach (var_65876ba in var_dc2f4915) {
        var_65876ba.e_fx = spawn("script_model", var_51cc03ba.origin);
        var_65876ba.e_fx setmodel("tag_origin");
        var_65876ba.e_fx clientfield::set("glow_biplane_trail_fx", 1);
        var_65876ba.e_fx moveto(var_65876ba.origin, 5);
    }
    var_dc2f4915[0].e_fx waittill(#"movedone");
    var_51cc03ba delete();
    foreach (var_65876ba in var_dc2f4915) {
        var_65876ba.var_5b55e566.model movez(500, 0.05);
        var_65876ba.var_5b55e566.model waittill(#"movedone");
        var_65876ba.var_5b55e566.model show();
        var_65876ba.var_5b55e566.model notify(#"hash_cac472aa");
        var_65876ba.e_fx delete();
    }
}

// Namespace namespace_73b257ea
// Params 15, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_cfa46a29
// Checksum 0xa42a19c9, Offset: 0x4a80
// Size: 0xfe
function function_cfa46a29(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, vdamageorigin, psoffsettime, var_3bc96147, var_269779a, var_829b9480, vsurfacenormal) {
    if (isplayer(e_attacker) && self.vehicletype == "biplane_zm" && !self flag::get("biplane_down")) {
        self flag::set("biplane_down");
        level notify(#"hash_ff6127fb");
    }
    return n_damage;
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_1f798b24
// Checksum 0xcd0cfc36, Offset: 0x4b88
// Size: 0xf4
function function_1f798b24(str_zone) {
    level endon(#"hash_5fcb6c29");
    while (true) {
        wait(5);
        while (!level.zones[str_zone].is_occupied) {
            wait(1);
        }
        a_players = getplayers();
        foreach (e_player in a_players) {
            level notify(#"hash_709021c9", e_player);
        }
    }
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_ba3cc7f
// Checksum 0xc3f07113, Offset: 0x4c88
// Size: 0x1d4
function function_ba3cc7f(var_bcda0488) {
    var_bcda0488 namespace_f7a613cf::function_c3207981();
    str_zone = zm_zonemgr::get_zone_from_position(var_bcda0488.var_5b55e566.model.origin, 1);
    if (!isdefined(str_zone)) {
        assertmsg("chamber_puzzle_cheat");
        return;
    }
    level thread function_1f798b24(str_zone);
    var_bcda0488.var_5b55e566.model ghost();
    while (true) {
        var_a03adcb0 = level waittill(#"hash_b57b5e8c");
        if (var_a03adcb0 == str_zone) {
            break;
        }
    }
    level notify(#"hash_5fcb6c29");
    foreach (var_1af28ab3 in level.var_b578830d) {
        if (var_1af28ab3.str_location == "church_capture") {
            var_1af28ab3.var_bcda0488 = var_bcda0488;
            level thread namespace_a528e918::function_139222f7(undefined, var_1af28ab3, &function_7e3acd2c);
            return;
        }
    }
}

// Namespace namespace_73b257ea
// Params 2, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_7e3acd2c
// Checksum 0x58a40671, Offset: 0x4e68
// Size: 0x1c0
function function_7e3acd2c(player, var_4d6f50a9) {
    var_cc4603c1 = spawn("script_model", self.origin);
    var_cc4603c1.angles = self.angles + (0, 180, 0);
    var_cc4603c1 setmodel("wpn_t7_zmb_hd_staff_tip_fire_world");
    var_cc4603c1.origin = self.origin;
    var_cc4603c1.angles = self.angles + (0, 90, 0);
    var_cc4603c1 clientfield::set("element_glow_fx", 1);
    util::wait_network_frame();
    if (!namespace_a528e918::function_aeb6a22b(var_cc4603c1, 50, 2, 2, -1)) {
        return false;
    }
    n_dist = 9999;
    a_players = getplayers();
    a_players = util::get_array_of_closest(self.var_e32cd584.origin, a_players);
    if (isdefined(a_players[0])) {
        a_players[0] namespace_f37770c8::function_d1aff147(self.var_bcda0488.var_5b55e566);
    }
    var_cc4603c1 delete();
    return true;
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_56ba198b
// Checksum 0x283eb8c4, Offset: 0x5030
// Size: 0x198
function function_56ba198b(e_player) {
    level notify(#"hash_7f066517", e_player);
    str_zone = self.str_zone;
    foreach (s_staff in level.var_e435840d) {
        if (!isdefined(s_staff.var_882601fa)) {
            s_staff.var_882601fa = 0;
        }
        if (issubstr(str_zone, s_staff.var_1df7b389)) {
            var_cb7f6458 = 100 / (s_staff.var_882601fa + 1);
            if (level.var_c95eeed7 <= 0) {
                var_cb7f6458 = 101;
            }
            if (s_staff.var_882601fa > 3 && (randomint(100) > var_cb7f6458 || var_cb7f6458 < 100)) {
                return s_staff;
            }
            s_staff.var_882601fa++;
            break;
        }
    }
    return undefined;
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_906dacba
// Checksum 0x3e975ce, Offset: 0x51d0
// Size: 0x174
function function_906dacba(origin) {
    arrayremovevalue(level.var_e435840d, self);
    wait(0.5);
    self.var_5b55e566.canmove = 1;
    zm_unitrigger::reregister_unitrigger_as_dynamic(self.var_5b55e566.unitrigger);
    var_8a05fc5a = 32;
    self.var_5b55e566.model moveto(origin + (0, 0, var_8a05fc5a), 0.05);
    self.var_5b55e566.model waittill(#"movedone");
    self.var_5b55e566.model showindemo();
    self.var_5b55e566.model show();
    self.var_5b55e566.model notify(#"hash_cac472aa");
    self.var_5b55e566.model playsound("evt_staff_digup");
    self.var_5b55e566.model playloopsound("evt_staff_digup_lp");
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_ca57c87a
// Checksum 0x6173ffd1, Offset: 0x5350
// Size: 0x174
function function_ca57c87a(var_dc2f4915) {
    level flagsys::wait_till("start_zombie_round_logic");
    level.var_e435840d = arraycopy(var_dc2f4915);
    foreach (var_b1028d0b in level.var_e435840d) {
        var_b1028d0b namespace_f7a613cf::function_c3207981();
        var_b1028d0b.var_5b55e566.model ghost();
    }
    level.var_e435840d[0].var_1df7b389 = "bunker";
    level.var_e435840d[1].var_1df7b389 = "nml";
    level.var_e435840d[2].var_1df7b389 = "village";
    level.var_e435840d[2].var_882601fa = 2;
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_e2fa8947
// Checksum 0xc7f4d924, Offset: 0x54d0
// Size: 0xe6
function function_e2fa8947(var_30c2e117) {
    level flag::wait_till("start_zombie_round_logic");
    switch (var_30c2e117.modelname) {
    case 152:
        function_f0a2f36c(var_30c2e117, 2);
        break;
    case 154:
        function_f0a2f36c(var_30c2e117, 1);
        break;
    case 153:
        function_f0a2f36c(var_30c2e117, 3);
        break;
    case 155:
        function_f0a2f36c(var_30c2e117, 4);
        break;
    }
}

// Namespace namespace_73b257ea
// Params 2, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_f0a2f36c
// Checksum 0x91d14c66, Offset: 0x55c0
// Size: 0x7c
function function_f0a2f36c(var_30c2e117, var_abb52853) {
    var_30c2e117.var_5b55e566.model clientfield::set("element_glow_fx", var_abb52853);
    var_30c2e117.var_5b55e566 waittill(#"pickup");
    self playsound("evt_crystal");
    level.var_28c01b1f++;
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x0
// namespace_73b257ea<file_0>::function_93d9795e
// Checksum 0xb796b39d, Offset: 0x5648
// Size: 0x64
function function_93d9795e(var_30c2e117) {
    level flag::wait_till("start_zombie_round_logic");
    var_30c2e117.var_5b55e566 waittill(#"hash_964eede9");
    level.var_28c01b1f--;
    level thread function_e2fa8947(var_30c2e117);
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_fb40e753
// Checksum 0x5db8fa0d, Offset: 0x56b8
// Size: 0x154
function function_fb40e753(e_player) {
    var_ab94c521 = 1;
    var_1a3d5a65 = 0;
    if (self.stub.var_1b32c30c.var_43f3f5e5.var_2d46dee8) {
        if (self.stub.var_1b32c30c.var_43f3f5e5.is_charged) {
            var_1a3d5a65 = 1;
        }
    }
    if (e_player bgb::is_enabled("zm_bgb_disorderly_combat")) {
        return "";
    }
    if (e_player hasweapon(self.stub.var_1b32c30c.w_weapon)) {
        msg = self.stub.var_1b32c30c function_e425716c();
        return msg;
    }
    if (var_1a3d5a65) {
        msg = self.stub.var_1b32c30c function_59ee7527();
        return msg;
    }
    return "";
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_4c21d2de
// Checksum 0x3af9c46b, Offset: 0x5818
// Size: 0x104
function function_4c21d2de() {
    level flag::set("charger_ready_" + self.enum);
    var_d01c98b3 = self.var_43f3f5e5.origin;
    var_d01c98b3 = (var_d01c98b3[0], var_d01c98b3[1], var_d01c98b3[2] - 30);
    if (isdefined(self.var_624ad164)) {
        self.var_624ad164 namespace_d7c0ce12::function_bd611266();
    }
    self.var_624ad164 = namespace_d7c0ce12::function_52854313(var_d01c98b3, 120, 1, &function_fb40e753);
    self.var_624ad164.require_look_at = 1;
    self.var_624ad164.var_1b32c30c = self;
    function_a8ccaf9f();
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_17b21cc4
// Checksum 0xfe29e616, Offset: 0x5928
// Size: 0x128
function function_17b21cc4() {
    /#
        if (!isdefined(self.var_43f3f5e5.var_9a544ea2)) {
            self.var_43f3f5e5.var_9a544ea2 = 0;
        }
        while (self.var_43f3f5e5.var_2d46dee8) {
            if (self.var_43f3f5e5.is_charged) {
                maxammo = self.w_weapon.maxammo;
                if (!isdefined(self.var_e1678378)) {
                    self.var_e1678378 = maxammo;
                }
                print3d(self.origin, self.var_e1678378 + "chamber_puzzle_cheat" + maxammo, (255, 255, 255), 1);
            } else {
                print3d(self.origin, self.var_43f3f5e5.var_9a544ea2 + "chamber_puzzle_cheat" + 20, (255, 255, 255), 1);
            }
            wait(0.05);
        }
    #/
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_a8ccaf9f
// Checksum 0xffd520c6, Offset: 0x5a58
// Size: 0x1f2
function function_a8ccaf9f() {
    while (true) {
        player = self.var_624ad164 waittill(#"trigger");
        var_ab94c521 = 1;
        if (isdefined(player)) {
            var_ab94c521 = player hasweapon(self.w_weapon);
            if (var_ab94c521) {
                player takeweapon(self.w_weapon);
            }
        }
        if (var_ab94c521) {
            self.var_43f3f5e5.var_2d46dee8 = 1;
            self thread function_17b21cc4();
            namespace_f7a613cf::function_abd72df3(self.w_weapon);
            n_player = player getentitynumber();
            self.var_624ad164.playertrigger[n_player] namespace_d7c0ce12::function_f2a1902a(&function_fb40e753);
            self.angles = (270, 90, 0);
            self moveto(self.var_43f3f5e5.origin, 0.05);
            self waittill(#"movedone");
            self clientfield::set("staff_charger", self.enum);
            self.var_43f3f5e5.full = 0;
            self show();
            self playsound("zmb_squest_charge_place_staff");
            return;
        }
    }
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_162da110
// Checksum 0x5904faa5, Offset: 0x5c58
// Size: 0x1c
function function_162da110() {
    self.actor_killed_override = &function_b57a0484;
}

// Namespace namespace_73b257ea
// Params 8, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_b57a0484
// Checksum 0x3ce1416, Offset: 0x5c80
// Size: 0x364
function function_b57a0484(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime) {
    if (level flag::get("ee_sam_portal_active") && !level flag::get("ee_souls_absorbed")) {
        namespace_85688477::function_116238af(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime);
        return;
    }
    if (namespace_5d5ba750::function_a93cf9ad(attacker)) {
        return;
    }
    var_41666ff0 = 9000000;
    if (isplayer(attacker) || sweapon == level.var_653c9585) {
        if (!level flag::get("fire_puzzle_1_complete")) {
            namespace_90429ef7::function_6cc4ff94(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime);
        }
        var_8339d654 = undefined;
        var_b8f30f64 = var_41666ff0;
        foreach (var_d16491f1 in level.var_b0d8f1fe) {
            if (isdefined(var_d16491f1.var_43f3f5e5.full) && var_d16491f1.var_43f3f5e5.full) {
                continue;
            }
            if (var_d16491f1.var_43f3f5e5.var_2d46dee8 || var_d16491f1.upgrade.var_43f3f5e5.var_2d46dee8) {
                if (!(isdefined(var_d16491f1.var_43f3f5e5.is_charged) && var_d16491f1.var_43f3f5e5.is_charged)) {
                    dist_sq = distance2dsquared(self.origin, var_d16491f1.origin);
                    if (dist_sq <= var_b8f30f64) {
                        var_b8f30f64 = dist_sq;
                        var_8339d654 = var_d16491f1;
                    }
                }
            }
        }
        if (isdefined(var_8339d654)) {
            if (var_8339d654.var_43f3f5e5.is_charged) {
                return;
            }
            var_8339d654.var_43f3f5e5.var_9a544ea2++;
            var_8339d654.var_43f3f5e5 thread function_890bb67e(self, var_8339d654.enum);
        }
    }
}

// Namespace namespace_73b257ea
// Params 2, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_890bb67e
// Checksum 0x6e28727c, Offset: 0x5ff0
// Size: 0x4a
function function_890bb67e(ai_zombie, var_b5f6f4e4) {
    ai_zombie clientfield::set("zombie_soul", var_b5f6f4e4);
    wait(1.5);
    self notify(#"hash_790a726e");
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_74205b8f
// Checksum 0x5336b1f3, Offset: 0x6048
// Size: 0x282
function function_74205b8f() {
    self.var_43f3f5e5.is_charged = 0;
    level flag::wait_till(self.weapname + "_upgrade_unlocked");
    self showallparts();
    while (true) {
        if (getdvarint("zombie_cheat") >= 2 && (self.var_43f3f5e5.var_9a544ea2 >= 20 || self.var_43f3f5e5.var_2d46dee8)) {
            wait(0.5);
            self.var_43f3f5e5.is_charged = 1;
            e_player = zm_utility::get_closest_player(self.var_43f3f5e5.origin);
            e_player thread namespace_ad52727b::function_2af394fb(self.enum);
            self clientfield::set("staff_charger", 0);
            self.var_43f3f5e5.full = 1;
            level clientfield::set(self.var_e1950593, 4);
            foreach (player in level.players) {
                player thread namespace_f37770c8::function_97be99b3(undefined, "zmInventory." + self.element + "_staff.visible", 0);
            }
            level thread function_cda9a682(self.enum);
            level.var_3a4c542d++;
            if (level.var_3a4c542d == 4) {
                level flag::set("ee_all_staffs_upgraded");
            }
            self thread function_ad3f999();
            break;
        }
        wait(1);
    }
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_ad3f999
// Checksum 0x8e427c4a, Offset: 0x62d8
// Size: 0x8c
function function_ad3f999() {
    self thread function_2d5701a2();
    self playsound("zmb_squest_charge_soul_full");
    self playloopsound("zmb_squest_charge_soul_full_loop", 0.1);
    level waittill(#"hash_68b2280e");
    self stoploopsound(0.1);
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_2d5701a2
// Checksum 0x2fb9fb4e, Offset: 0x6370
// Size: 0xfc
function function_2d5701a2() {
    if (level.var_3a4c542d == 4) {
        level thread namespace_54a425fe::function_5f9c184e("staff_all_upgraded");
        return;
    }
    if (self.weapname == "staff_air") {
        level thread namespace_54a425fe::function_5f9c184e("staff_air_upgraded");
    }
    if (self.weapname == "staff_fire") {
        level thread namespace_54a425fe::function_5f9c184e("staff_fire_upgraded");
    }
    if (self.weapname == "staff_lightning") {
        level thread namespace_54a425fe::function_5f9c184e("staff_lightning_upgraded");
    }
    if (self.weapname == "staff_water") {
        level thread namespace_54a425fe::function_5f9c184e("staff_ice_upgraded");
    }
}

// Namespace namespace_73b257ea
// Params 1, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_cda9a682
// Checksum 0xad89e048, Offset: 0x6478
// Size: 0x278
function function_cda9a682(n_index) {
    var_b3aaba8f = namespace_f7a613cf::function_9cc411fa(n_index);
    var_7ce2424a = var_b3aaba8f.upgrade;
    var_b3aaba8f.var_624ad164.require_look_at = 1;
    pickup_message = var_b3aaba8f function_59ee7527();
    var_b3aaba8f.var_624ad164 namespace_d7c0ce12::function_d73e42e0(pickup_message);
    var_b3aaba8f ghost();
    var_7ce2424a.trigger = var_b3aaba8f.var_624ad164;
    var_7ce2424a.angles = (270, 90, 0);
    var_7ce2424a moveto(var_b3aaba8f.origin, 0.1);
    var_7ce2424a waittill(#"movedone");
    var_7ce2424a show();
    e_fx = spawn("script_model", var_7ce2424a.origin + (0, 0, 12));
    e_fx setmodel("tag_origin");
    wait(0.6);
    e_fx clientfield::set("element_glow_fx", var_b3aaba8f.enum);
    var_7ce2424a function_5700f562();
    player = var_7ce2424a.owner;
    e_fx delete();
    while (true) {
        if (var_b3aaba8f.var_43f3f5e5.is_charged) {
            var_7ce2424a thread function_9519c1b3();
            break;
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_9519c1b3
// Checksum 0xc220c56c, Offset: 0x66f8
// Size: 0x168
function function_9519c1b3() {
    self.weaponname = self.weapname;
    self thread namespace_f7a613cf::function_53ad8621(self.owner);
    while (true) {
        function_4c21d2de();
        self thread function_b806760();
        self function_5700f562();
        self.var_43f3f5e5.var_2d46dee8 = 0;
        maxammo = self.w_weapon.maxammo;
        n_ammo = int(min(maxammo, self.var_e1678378));
        if (isdefined(self.owner)) {
            self.owner setweaponammostock(self.w_weapon, n_ammo);
            self.owner setweaponammoclip(self.w_weapon, self.var_960d7618);
            self thread namespace_f7a613cf::function_53ad8621(self.owner);
        }
    }
}

// Namespace namespace_73b257ea
// Params 0, eflags: 0x1 linked
// namespace_73b257ea<file_0>::function_b806760
// Checksum 0xae28b4d2, Offset: 0x6868
// Size: 0xec
function function_b806760() {
    self endon(#"hash_c26aea98");
    max_ammo = self.w_weapon.maxammo;
    n_count = int(max_ammo / 20);
    var_6bbc432c = 0;
    while (true) {
        self.var_43f3f5e5 waittill(#"hash_790a726e");
        self.var_e1678378 += n_count;
        if (self.var_e1678378 > max_ammo) {
            self.var_e1678378 = max_ammo;
            self clientfield::set("staff_charger", 0);
            self.var_43f3f5e5.full = 1;
        }
    }
}

