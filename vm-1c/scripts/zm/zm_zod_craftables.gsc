#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/zm_zod_util;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_audio;
#using scripts/zm/zm_zod_vo;
#using scripts/zm/zm_zod_quest;
#using scripts/shared/util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;

#namespace namespace_4624f91a;

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xb48
// Size: 0x4
function function_cdc13aec() {
    
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0x1f7879f7, Offset: 0xb58
// Size: 0x12ec
function function_3ebec56b() {
    level.var_29ae0891 = 0;
    var_2a7833c8 = getnumexpectedplayers() == 1;
    var_16b36a95 = 1;
    var_9967ff1 = "police_box";
    var_c157a58b = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "fuse_01", 32, 64, 0, undefined, &function_27ef9857, undefined, &function_6c41d7f2, undefined, undefined, undefined, "police_box" + "_" + "fuse_01", 1, undefined, undefined, %ZM_ZOD_POLICE_BOX_PICKUP_FUSE, 4);
    var_4f503650 = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "fuse_02", 32, 64, 0, undefined, &function_27ef9857, undefined, &function_6c41d7f2, undefined, undefined, undefined, "police_box" + "_" + "fuse_02", 1, undefined, undefined, %ZM_ZOD_POLICE_BOX_PICKUP_FUSE, 4);
    var_7552b0b9 = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "fuse_03", 32, 64, 0, undefined, &function_27ef9857, undefined, &function_6c41d7f2, undefined, undefined, undefined, "police_box" + "_" + "fuse_03", 1, undefined, undefined, %ZM_ZOD_POLICE_BOX_PICKUP_FUSE, 4);
    if (var_2a7833c8) {
        var_c157a58b.var_6dd4b013 = 1;
        var_4f503650.var_6dd4b013 = 1;
        var_7552b0b9.var_6dd4b013 = 1;
        var_c157a58b.var_dcc30f2f = undefined;
        var_4f503650.var_dcc30f2f = undefined;
        var_7552b0b9.var_dcc30f2f = undefined;
    }
    var_ab257b31 = spawnstruct();
    var_ab257b31.name = var_9967ff1;
    var_ab257b31 namespace_f37770c8::function_b0deb4e6(var_c157a58b, "j_fuse_01");
    var_ab257b31 namespace_f37770c8::function_b0deb4e6(var_4f503650, "j_fuse_02");
    var_ab257b31 namespace_f37770c8::function_b0deb4e6(var_7552b0b9, "j_fuse_03");
    var_ab257b31.var_41f0f8cd = &function_141a8c6e;
    var_ab257b31.var_78f38827 = 1;
    level flag::init("fuse_01" + "_found");
    level flag::init("fuse_02" + "_found");
    level flag::init("fuse_03" + "_found");
    level flag::init("police_box_fuse_place");
    namespace_f37770c8::function_ac4e44a7(var_ab257b31);
    var_9967ff1 = "idgun";
    var_23fa21ad = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "part_heart", 32, 64, 0, undefined, &function_d5cdb383, undefined, undefined, undefined, undefined, undefined, "idgun" + "_" + "part_heart", 1, undefined, undefined, %ZM_ZOD_IDGUN_PART_HEART, 2);
    var_def64f56 = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "part_skeleton", 32, 64, 0, undefined, &function_d5cdb383, undefined, undefined, undefined, undefined, undefined, "idgun" + "_" + "part_skeleton", 1, undefined, undefined, %ZM_ZOD_IDGUN_PART_SKELETON, 2);
    var_7d85245c = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "part_xenomatter", 32, 64, 0, undefined, &function_d5cdb383, undefined, undefined, undefined, undefined, undefined, "idgun" + "_" + "part_xenomatter", 1, undefined, undefined, %ZM_ZOD_IDGUN_PART_XENOMATTER, 2);
    var_23fa21ad.var_dcc30f2f = undefined;
    var_def64f56.var_dcc30f2f = undefined;
    var_7d85245c.var_dcc30f2f = undefined;
    var_42517170 = spawnstruct();
    var_42517170.name = var_9967ff1;
    var_42517170 namespace_f37770c8::function_b0deb4e6(var_23fa21ad);
    var_42517170 namespace_f37770c8::function_b0deb4e6(var_def64f56);
    var_42517170 namespace_f37770c8::function_b0deb4e6(var_7d85245c);
    var_42517170.var_71a0cc1e = &function_57f30dec;
    var_42517170.var_41f0f8cd = &function_7a49123b;
    namespace_f37770c8::function_ac4e44a7(var_42517170);
    level flag::init("part_heart" + "_found");
    level flag::init("part_skeleton" + "_found");
    level flag::init("part_xenomatter" + "_found");
    var_9967ff1 = "second_idgun";
    var_62ffc1ec = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "part_heart", 32, 64, 0, undefined, &function_d5cdb383, undefined, undefined, undefined, undefined, undefined, "second_idgun" + "_" + "part_heart", 1, undefined, undefined, %ZM_ZOD_IDGUN_PART_HEART, 3);
    var_50a8320d = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "part_skeleton", 32, 64, 0, undefined, &function_d5cdb383, undefined, undefined, undefined, undefined, undefined, "second_idgun" + "_" + "part_skeleton", 1, undefined, undefined, %ZM_ZOD_IDGUN_PART_SKELETON, 3);
    var_fa9ad3bb = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "part_xenomatter", 32, 64, 0, undefined, &function_d5cdb383, undefined, undefined, undefined, undefined, undefined, "second_idgun" + "_" + "part_xenomatter", 1, undefined, undefined, %ZM_ZOD_IDGUN_PART_XENOMATTER, 3);
    var_62ffc1ec.var_dcc30f2f = undefined;
    var_50a8320d.var_dcc30f2f = undefined;
    var_fa9ad3bb.var_dcc30f2f = undefined;
    var_4220199f = spawnstruct();
    var_4220199f.name = var_9967ff1;
    var_4220199f namespace_f37770c8::function_b0deb4e6(var_62ffc1ec);
    var_4220199f namespace_f37770c8::function_b0deb4e6(var_50a8320d);
    var_4220199f namespace_f37770c8::function_b0deb4e6(var_fa9ad3bb);
    var_4220199f.var_41f0f8cd = &function_ee72d458;
    namespace_f37770c8::function_ac4e44a7(var_4220199f);
    level flag::init("part_heart" + "_found");
    level flag::init("part_skeleton" + "_found");
    level flag::init("part_xenomatter" + "_found");
    var_9967ff1 = "ritual_boxer";
    var_82bbd61f = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "memento_boxer", 32, 64, 0, undefined, &function_145636eb, undefined, &function_eaf7ab24, undefined, undefined, undefined, 1, undefined, undefined, undefined, %ZM_ZOD_QUEST_RITUAL_PICKUP_ITEM_BOXER, 0);
    if (var_16b36a95) {
        var_82bbd61f.var_6dd4b013 = 1;
        var_82bbd61f.var_dcc30f2f = undefined;
    }
    var_364b172f = spawnstruct();
    var_364b172f.name = var_9967ff1;
    var_364b172f namespace_f37770c8::function_b0deb4e6(var_82bbd61f);
    var_364b172f.var_41f0f8cd = &function_22d06508;
    var_364b172f.var_78f38827 = 1;
    namespace_f37770c8::function_ac4e44a7(var_364b172f);
    level flag::init("memento_boxer" + "_found");
    var_9967ff1 = "ritual_detective";
    var_4d0fe4ac = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "memento_detective", 32, 64, 0, undefined, &function_145636eb, undefined, &function_eaf7ab24, undefined, undefined, undefined, 2, undefined, undefined, undefined, %ZM_ZOD_QUEST_RITUAL_PICKUP_ITEM_DETECTIVE, 0);
    if (var_16b36a95) {
        var_4d0fe4ac.var_6dd4b013 = 1;
        var_4d0fe4ac.var_dcc30f2f = undefined;
    }
    var_75566ac0 = spawnstruct();
    var_75566ac0.name = var_9967ff1;
    var_75566ac0 namespace_f37770c8::function_b0deb4e6(var_4d0fe4ac);
    var_75566ac0.var_41f0f8cd = &function_8d3b0a6b;
    var_75566ac0.var_78f38827 = 1;
    namespace_f37770c8::function_ac4e44a7(var_75566ac0);
    level flag::init("memento_detective" + "_found");
    var_9967ff1 = "ritual_femme";
    var_9676733f = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "memento_femme", 32, 64, 0, undefined, &function_145636eb, undefined, &function_eaf7ab24, undefined, undefined, undefined, 3, undefined, undefined, undefined, %ZM_ZOD_QUEST_RITUAL_PICKUP_ITEM_FEMME, 0);
    if (var_16b36a95) {
        var_9676733f.var_6dd4b013 = 1;
        var_9676733f.var_dcc30f2f = undefined;
    }
    var_d9c7dc8f = spawnstruct();
    var_d9c7dc8f.name = var_9967ff1;
    var_d9c7dc8f namespace_f37770c8::function_b0deb4e6(var_9676733f);
    var_d9c7dc8f.var_41f0f8cd = &function_5c92a428;
    var_d9c7dc8f.var_78f38827 = 1;
    namespace_f37770c8::function_ac4e44a7(var_d9c7dc8f);
    level flag::init("memento_femme" + "_found");
    var_9967ff1 = "ritual_magician";
    var_7330e760 = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "memento_magician", 32, 64, 0, undefined, &function_145636eb, undefined, &function_eaf7ab24, undefined, undefined, undefined, 4, undefined, undefined, undefined, %ZM_ZOD_QUEST_RITUAL_PICKUP_ITEM_MAGICIAN, 0);
    if (var_16b36a95) {
        var_7330e760.var_6dd4b013 = 1;
        var_7330e760.var_dcc30f2f = undefined;
    }
    var_3d961ca4 = spawnstruct();
    var_3d961ca4.name = var_9967ff1;
    var_3d961ca4 namespace_f37770c8::function_b0deb4e6(var_7330e760);
    var_3d961ca4.var_41f0f8cd = &function_a7cee407;
    var_3d961ca4.var_78f38827 = 1;
    namespace_f37770c8::function_ac4e44a7(var_3d961ca4);
    level flag::init("memento_magician" + "_found");
    var_9967ff1 = "ritual_pap";
    var_74e95d7d = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "relic_boxer", 32, 64, 0, undefined, &function_145636eb, undefined, &function_eaf7ab24, undefined, undefined, undefined, 1, undefined, undefined, undefined, %ZM_ZOD_QUEST_RITUAL_PICKUP_RELIC, 1);
    var_b31fe12 = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "relic_detective", 32, 64, 0, undefined, &function_145636eb, undefined, &function_eaf7ab24, undefined, undefined, undefined, 2, undefined, undefined, undefined, %ZM_ZOD_QUEST_RITUAL_PICKUP_RELIC, 1);
    var_fc4796bd = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "relic_femme", 32, 64, 0, undefined, &function_145636eb, undefined, &function_eaf7ab24, undefined, undefined, undefined, 3, undefined, undefined, undefined, %ZM_ZOD_QUEST_RITUAL_PICKUP_RELIC, 1);
    var_5c02f4ae = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "relic_magician", 32, 64, 0, undefined, &function_145636eb, undefined, &function_eaf7ab24, undefined, undefined, undefined, 4, undefined, undefined, undefined, %ZM_ZOD_QUEST_RITUAL_PICKUP_RELIC, 1);
    if (var_16b36a95) {
        var_74e95d7d.var_6dd4b013 = 1;
        var_b31fe12.var_6dd4b013 = 1;
        var_fc4796bd.var_6dd4b013 = 1;
        var_5c02f4ae.var_6dd4b013 = 1;
        var_74e95d7d.var_dcc30f2f = undefined;
        var_b31fe12.var_dcc30f2f = undefined;
        var_fc4796bd.var_dcc30f2f = undefined;
        var_5c02f4ae.var_dcc30f2f = undefined;
    }
    var_18d1ed5a = spawnstruct();
    var_18d1ed5a.name = var_9967ff1;
    var_18d1ed5a namespace_f37770c8::function_b0deb4e6(var_74e95d7d);
    var_18d1ed5a namespace_f37770c8::function_b0deb4e6(var_b31fe12);
    var_18d1ed5a namespace_f37770c8::function_b0deb4e6(var_fc4796bd);
    var_18d1ed5a namespace_f37770c8::function_b0deb4e6(var_5c02f4ae);
    var_18d1ed5a.var_41f0f8cd = &function_215ab729;
    var_18d1ed5a.var_78f38827 = 1;
    namespace_f37770c8::function_ac4e44a7(var_18d1ed5a);
    level flag::init("relic_boxer" + "_found");
    level flag::init("relic_detective" + "_found");
    level flag::init("relic_femme" + "_found");
    level flag::init("relic_magician" + "_found");
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0x7e82c3f1, Offset: 0x1e50
// Size: 0x32c
function function_95743e9f() {
    level.var_93b7659f = &function_a7fe5efc;
    register_clientfields();
    namespace_f37770c8::function_8421d708("police_box", %ZM_ZOD_POLICE_BOX_PLACE_FUSE, %ZM_ZOD_POLICE_BOX_PLACE_FUSE, %ZM_ZOD_POLICE_BOX_POWER_ON, &function_c6c55eb6);
    namespace_f37770c8::function_8421d708("idgun", %ZM_ZOD_CRAFT_IDGUN, "", %ZM_ZOD_PICKUP_IDGUN, &function_8564e4f9, 1);
    namespace_f37770c8::function_c86d092("idgun", "", (0, -90, 0), (0, 0, 0));
    namespace_f37770c8::function_8421d708("second_idgun", %ZM_ZOD_CRAFT_IDGUN, "", %ZM_ZOD_PICKUP_IDGUN, &function_d80876ac, 1);
    namespace_f37770c8::function_c86d092("second_idgun", "", (0, -90, 0), (0, 0, 0));
    namespace_f37770c8::function_8421d708("ritual_boxer", %ZM_ZOD_QUEST_RITUAL_PLACE_ITEM_BOXER, %ZM_ZOD_QUEST_RITUAL_PLACE_ITEM_BOXER, %ZM_ZOD_QUEST_RITUAL_INITIATE, &function_469080d7);
    namespace_f37770c8::function_8421d708("ritual_detective", %ZM_ZOD_QUEST_RITUAL_PLACE_ITEM_DETECTIVE, %ZM_ZOD_QUEST_RITUAL_PLACE_ITEM_DETECTIVE, %ZM_ZOD_QUEST_RITUAL_INITIATE, &function_469080d7);
    namespace_f37770c8::function_8421d708("ritual_femme", %ZM_ZOD_QUEST_RITUAL_PLACE_ITEM_FEMME, %ZM_ZOD_QUEST_RITUAL_PLACE_ITEM_FEMME, %ZM_ZOD_QUEST_RITUAL_INITIATE, &function_469080d7);
    namespace_f37770c8::function_8421d708("ritual_magician", %ZM_ZOD_QUEST_RITUAL_PLACE_ITEM_MAGICIAN, %ZM_ZOD_QUEST_RITUAL_PLACE_ITEM_MAGICIAN, %ZM_ZOD_QUEST_RITUAL_INITIATE, &function_469080d7);
    namespace_f37770c8::function_8421d708("ritual_pap", %ZM_ZOD_QUEST_RITUAL_PLACE_RELIC, %ZM_ZOD_QUEST_RITUAL_PLACE_RELIC, %ZM_ZOD_QUEST_RITUAL_INITIATE, &function_469080d7);
    namespace_f37770c8::function_a44e7016("police_box", 0);
    namespace_f37770c8::function_a44e7016("ritual_boxer", 0);
    namespace_f37770c8::function_a44e7016("ritual_detective", 0);
    namespace_f37770c8::function_a44e7016("ritual_femme", 0);
    namespace_f37770c8::function_a44e7016("ritual_magician", 0);
    namespace_f37770c8::function_a44e7016("ritual_pap", 0);
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0x643fd861, Offset: 0x2188
// Size: 0x624
function register_clientfields() {
    var_a0199abd = 1;
    registerclientfield("world", "police_box" + "_" + "fuse_01", 1, var_a0199abd, "int", undefined, 0);
    registerclientfield("world", "police_box" + "_" + "fuse_02", 1, var_a0199abd, "int", undefined, 0);
    registerclientfield("world", "police_box" + "_" + "fuse_03", 1, var_a0199abd, "int", undefined, 0);
    registerclientfield("world", "idgun" + "_" + "part_heart", 1, var_a0199abd, "int", undefined, 0);
    registerclientfield("world", "idgun" + "_" + "part_skeleton", 1, var_a0199abd, "int", undefined, 0);
    registerclientfield("world", "idgun" + "_" + "part_xenomatter", 1, var_a0199abd, "int", undefined, 0);
    registerclientfield("world", "second_idgun" + "_" + "part_heart", 1, var_a0199abd, "int", undefined, 0);
    registerclientfield("world", "second_idgun" + "_" + "part_skeleton", 1, var_a0199abd, "int", undefined, 0);
    registerclientfield("world", "second_idgun" + "_" + "part_xenomatter", 1, var_a0199abd, "int", undefined, 0);
    foreach (var_f7af1630 in level.var_6f8e5f09) {
        registerclientfield("world", "holder_of_" + var_f7af1630, 1, 3, "int", undefined, 0);
    }
    foreach (var_f7af1630 in level.var_6f8e5f09) {
        registerclientfield("world", "quest_state_" + var_f7af1630, 1, 3, "int", undefined, 0);
    }
    clientfield::register("toplayer", "ZM_ZOD_UI_FUSE_PICKUP", 1, 1, "int");
    clientfield::register("toplayer", "ZM_ZOD_UI_FUSE_PLACED", 1, 1, "int");
    clientfield::register("toplayer", "ZM_ZOD_UI_FUSE_CRAFTED", 1, 1, "int");
    clientfield::register("toplayer", "ZM_ZOD_UI_IDGUN_HEART_PICKUP", 1, 1, "int");
    clientfield::register("toplayer", "ZM_ZOD_UI_IDGUN_TENTACLE_PICKUP", 1, 1, "int");
    clientfield::register("toplayer", "ZM_ZOD_UI_IDGUN_XENOMATTER_PICKUP", 1, 1, "int");
    clientfield::register("toplayer", "ZM_ZOD_UI_IDGUN_CRAFTED", 1, 1, "int");
    clientfield::register("toplayer", "ZM_ZOD_UI_MEMENTO_BOXER_PICKUP", 1, 1, "int");
    clientfield::register("toplayer", "ZM_ZOD_UI_MEMENTO_DETECTIVE_PICKUP", 1, 1, "int");
    clientfield::register("toplayer", "ZM_ZOD_UI_MEMENTO_FEMME_PICKUP", 1, 1, "int");
    clientfield::register("toplayer", "ZM_ZOD_UI_MEMENTO_MAGICIAN_PICKUP", 1, 1, "int");
    clientfield::register("toplayer", "ZM_ZOD_UI_GATEWORM_PICKUP", 1, 1, "int");
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x0
// Checksum 0xfbb6af44, Offset: 0x27b8
// Size: 0x120
function function_1bf61c98() {
    level flag::wait_till("start_zombie_round_logic");
    foreach (var_3111271f in level.var_b09bbe80) {
        foreach (var_b1028d0b in var_3111271f.var_7a5f63bc) {
            var_b1028d0b function_c3207981();
        }
    }
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0xd4f99449, Offset: 0x28e0
// Size: 0x28
function function_c3207981() {
    while (!isdefined(self.var_5b55e566)) {
        util::wait_network_frame();
    }
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x0
// Checksum 0x9d8cd50c, Offset: 0x2910
// Size: 0x16
function function_31edd14b(player) {
    self.var_77a0498d = undefined;
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x0
// Checksum 0x7eb1cd68, Offset: 0x2930
// Size: 0x38
function function_66a9cb86(player) {
    player thread function_9708cb71(self.piecename);
    self.var_77a0498d = player;
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0x97777bd, Offset: 0x2970
// Size: 0x254
function function_38173e90(player) {
    level endon("crafted_" + self.piecename);
    level endon("dropped_" + self.piecename);
    player waittill(#"disconnect");
    if (self.var_6dd4b013) {
        return;
    }
    var_c0262163 = level clientfield::get("quest_state_" + function_836451f4(self.piecename));
    if (function_5d5371da(self.piecename) && var_c0262163 < 3) {
        level clientfield::set("quest_state_" + function_836451f4(self.piecename), 0);
        self.model clientfield::set("set_fade_material", 1);
        self.model clientfield::set("item_glow_fx", 3);
        level clientfield::set("holder_of_" + function_836451f4(self.piecename), 0);
        return;
    }
    if (function_f47faf9a(self.piecename) && !level flag::get("ritual_pap_complete")) {
        level clientfield::set("quest_state_" + function_836451f4(self.piecename), 3);
        self.model setvisibletoall();
        self.model clientfield::set("item_glow_fx", 2);
        level clientfield::set("holder_of_" + function_836451f4(self.piecename), 0);
    }
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0xac1b939b, Offset: 0x2bd0
// Size: 0x112
function function_27ef9857(player) {
    level flag::set(self.piecename + "_found");
    player thread function_9708cb71(self.piecename);
    foreach (e_player in level.players) {
        e_player thread namespace_f37770c8::function_97be99b3("zmInventory.player_crafted_fusebox", "zmInventory.widget_fuses", 0);
        e_player thread namespace_8e578893::function_69e0fb83("ZM_ZOD_UI_FUSE_PICKUP", 3.5);
    }
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0xf8cfc1c0, Offset: 0x2cf0
// Size: 0x11a
function function_6c41d7f2(player) {
    var_6f73bd35 = getent("police_box", "targetname");
    if (isdefined(var_6f73bd35)) {
        var_6f73bd35 playsound("zmb_zod_fuse_place");
    }
    foreach (e_player in level.players) {
        e_player thread namespace_f37770c8::function_97be99b3("zmInventory.player_crafted_fusebox", "zmInventory.widget_fuses", 0);
        e_player thread namespace_8e578893::function_69e0fb83("ZM_ZOD_UI_FUSE_PLACED", 3.5);
    }
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x0
// Checksum 0x50ae9a8a, Offset: 0x2e18
// Size: 0x1fc
function function_1fb591f6(player) {
    println("j_fuse_03");
    level notify("dropped_" + self.piecename);
    self function_be206d34(player);
    self.var_77a0498d = undefined;
    if (function_5d5371da(self.piecename)) {
        level.var_bb596164--;
        level clientfield::set("quest_state_" + function_836451f4(self.piecename), 0);
        self.model clientfield::set("set_fade_material", 1);
        self.model clientfield::set("item_glow_fx", 3);
    } else if (function_f47faf9a(self.piecename)) {
        level.var_5e457a7c--;
        level clientfield::set("quest_state_" + function_836451f4(self.piecename), 3);
        self.model clientfield::set("item_glow_fx", 2);
    }
    self.model.origin = player.origin;
    self.model setvisibletoall();
    level clientfield::set("holder_of_" + function_836451f4(self.piecename), 0);
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0xf138cf8c, Offset: 0x3020
// Size: 0x474
function function_145636eb(player) {
    println("j_fuse_03");
    if (!isdefined(level.var_bb596164)) {
        level.var_bb596164 = 0;
        level.var_5e457a7c = 0;
        level.var_e879bcb = 1;
    }
    if (!(isdefined(self.var_34db6ce0) && self.var_34db6ce0)) {
        self.var_34db6ce0 = 1;
        self.start_origin = self.model.origin;
        self.start_angles = self.model.angles;
    }
    self function_832dcda8();
    self.var_77a0498d = player;
    level flag::set(self.piecename + "_found");
    if (function_5d5371da(self.piecename)) {
        level.var_bb596164++;
        level clientfield::set("quest_state_" + function_836451f4(self.piecename), 1);
        player thread namespace_b8707f8e::function_32c9e1d9(self.piecename);
    } else if (function_f47faf9a(self.piecename)) {
        level.var_5e457a7c++;
        level clientfield::set("quest_state_" + function_836451f4(self.piecename), 4);
        str_name = function_836451f4(self.piecename);
        level clientfield::set("ritual_state_" + str_name, 4);
        level thread exploder::stop_exploder("ritual_light_" + str_name + "_fin");
        player thread namespace_b8707f8e::function_2e3f1a98();
    }
    switch (self.piecename) {
    case 21:
        var_55ce4248 = "ZM_ZOD_UI_MEMENTO_BOXER_PICKUP";
        break;
    case 24:
        var_55ce4248 = "ZM_ZOD_UI_MEMENTO_DETECTIVE_PICKUP";
        break;
    case 27:
        var_55ce4248 = "ZM_ZOD_UI_MEMENTO_FEMME_PICKUP";
        break;
    case 30:
        var_55ce4248 = "ZM_ZOD_UI_MEMENTO_MAGICIAN_PICKUP";
        break;
    case 33:
    case 34:
    case 35:
    case 36:
        var_55ce4248 = "ZM_ZOD_UI_GATEWORM_PICKUP";
        break;
    }
    var_e85b4e8 = 0;
    switch (player.characterindex) {
    case 0:
        var_e85b4e8 = 1;
        break;
    case 1:
        var_e85b4e8 = 2;
        break;
    case 2:
        var_e85b4e8 = 3;
        break;
    case 3:
        var_e85b4e8 = 4;
        break;
    }
    level clientfield::set("holder_of_" + function_836451f4(self.piecename), var_e85b4e8);
    if (level.var_e879bcb == level.var_bb596164) {
        level thread zm_audio::sndmusicsystem_playstate("piece_" + level.var_e879bcb);
        level.var_e879bcb++;
    }
    player thread function_9708cb71(self.piecename);
    player thread namespace_f37770c8::function_97be99b3(undefined, "zmInventory.widget_quest_items", 0);
    player thread namespace_8e578893::function_69e0fb83(var_55ce4248, 3.5);
    self thread function_38173e90(player);
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0xb8f441f2, Offset: 0x34a0
// Size: 0x17a
function function_d5cdb383(player) {
    level flag::set(self.piecename + "_found");
    level notify(#"hash_14edc619");
    player thread function_9708cb71(self.piecename);
    switch (self.piecename) {
    case 13:
        str_part = "ZM_ZOD_UI_IDGUN_HEART_PICKUP";
        break;
    case 15:
        str_part = "ZM_ZOD_UI_IDGUN_TENTACLE_PICKUP";
        break;
    case 17:
        str_part = "ZM_ZOD_UI_IDGUN_XENOMATTER_PICKUP";
        break;
    }
    foreach (e_player in level.players) {
        e_player thread namespace_f37770c8::function_97be99b3("zmInventory.player_crafted_idgun", "zmInventory.widget_idgun_parts", 0);
        e_player thread namespace_8e578893::function_69e0fb83(str_part, 3.5);
    }
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0x80de0767, Offset: 0x3628
// Size: 0x12c
function function_9708cb71(piecename) {
    var_983a0e9b = "zmb_zod_craftable_pickup";
    switch (piecename) {
    case 21:
    case 24:
    case 27:
    case 30:
        var_983a0e9b = "zmb_zod_memento_pickup";
        break;
    case 33:
    case 34:
    case 35:
    case 36:
        var_983a0e9b = "zmb_zod_ritual_worm_pickup";
        break;
    case 13:
    case 13:
    case 15:
    case 15:
    case 17:
    case 17:
        var_983a0e9b = "zmb_zod_idgunpiece_pickup";
        break;
    case 3:
    case 4:
    case 5:
        var_983a0e9b = "zmb_zod_fuse_pickup";
        break;
    default:
        var_983a0e9b = "zmb_zod_craftable_pickup";
        break;
    }
    self playsound(var_983a0e9b);
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0xc8d7d462, Offset: 0x3760
// Size: 0xee
function function_c6c55eb6(e_player) {
    level notify(#"hash_5b9acfd8");
    foreach (e_player in level.players) {
        if (zm_utility::is_player_valid(e_player)) {
            e_player thread namespace_f37770c8::function_97be99b3("zmInventory.player_crafted_fusebox", "zmInventory.widget_fuses", 1);
            e_player thread namespace_8e578893::function_69e0fb83("ZM_ZOD_UI_FUSE_CRAFTED", 3.5);
        }
    }
    return true;
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0x7fc7a923, Offset: 0x3858
// Size: 0x13c
function function_eaf7ab24(player) {
    if (function_5d5371da(self.piecename)) {
        level clientfield::set("quest_state_" + function_836451f4(self.piecename), 2);
        player namespace_b8707f8e::function_c41d3e2e(self.piecename);
    } else {
        level clientfield::set("quest_state_" + function_836451f4(self.piecename), 5);
        var_2e58527b = getent("quest_ritual_relic_placed_" + function_836451f4(self.piecename), "targetname");
        var_2e58527b show();
    }
    level clientfield::set("holder_of_" + function_836451f4(self.piecename), 0);
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0x8b0f08d9, Offset: 0x39a0
// Size: 0xe0
function function_469080d7(player) {
    if (self.equipname != "ritual_pap") {
        var_88064c84 = function_836451f4(self.equipname);
        function_f8bb3971(var_88064c84);
        [[ level.var_c0091dc4[var_88064c84] ]]->start();
    } else {
        level flag::set("ritual_pap_ready");
        level clientfield::set("ritual_state_pap", 1);
        [[ level.var_c0091dc4["pap"] ]]->start();
    }
    return true;
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0xe92fb643, Offset: 0x3a88
// Size: 0x84
function function_f8bb3971(name) {
    level flag::set("ritual_" + name + "_ready");
    level clientfield::set("ritual_state_" + name, 1);
    level clientfield::set("quest_state_" + name, 2);
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0xbf0435a4, Offset: 0x3b18
// Size: 0x1d8
function function_8564e4f9(player) {
    if (!(isdefined(self.var_5449dda7) && self.var_5449dda7)) {
        self.var_5449dda7 = 1;
        players = level.players;
        foreach (e_player in players) {
            if (zm_utility::is_player_valid(e_player)) {
                e_player thread namespace_8e578893::function_69e0fb83("ZM_ZOD_UI_IDGUN_CRAFTED", 3.5);
                e_player thread namespace_f37770c8::function_97be99b3("zmInventory.player_crafted_idgun", "zmInventory.widget_idgun_parts", 1);
            }
        }
        self.model.origin = self.origin;
        self.model.angles = self.angles + (0, -90, 0);
        self.model setmodel("wpn_t7_zmb_zod_idg_world");
        self.var_356fbd8b = level.var_42517170[0].var_356fbd8b;
        self.weaponname = getweapon(level.var_42517170[self.var_356fbd8b].var_e4be281f);
    }
    return true;
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0xe7bd476a, Offset: 0x3cf8
// Size: 0xc4
function function_57f30dec(player) {
    level.var_42517170[self.stub.var_356fbd8b].owner = player;
    level clientfield::set("add_idgun_to_box", level.var_42517170[self.stub.var_356fbd8b].var_e787e99a);
    level.zombie_weapons[self.stub.weaponname].is_in_box = 1;
    player namespace_b8707f8e::function_aca1bc0c(self.stub.var_356fbd8b);
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0xa2e588af, Offset: 0x3dc8
// Size: 0x130
function function_d80876ac(player) {
    players = level.players;
    foreach (e_player in players) {
        if (zm_utility::is_player_valid(e_player)) {
            e_player thread namespace_8e578893::function_69e0fb83("ZM_ZOD_UI_IDGUN_CRAFTED", 3.5);
            e_player thread namespace_f37770c8::function_97be99b3("zmInventory.player_crafted_idgun", "zmInventory.widget_idgun_parts", 1);
        }
    }
    function_a0e4fb00(self.origin, self.origin, level.var_42517170[1].var_356fbd8b);
    return true;
}

// Namespace namespace_4624f91a
// Params 3, eflags: 0x1 linked
// Checksum 0xbd189b4d, Offset: 0x3f00
// Size: 0x1ac
function function_a0e4fb00(v_origin, v_angles, var_356fbd8b) {
    width = -128;
    height = -128;
    length = -128;
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = v_origin;
    unitrigger_stub.angles = v_angles;
    unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.script_width = width;
    unitrigger_stub.script_height = height;
    unitrigger_stub.script_length = length;
    unitrigger_stub.require_look_at = 0;
    unitrigger_stub.var_356fbd8b = var_356fbd8b;
    unitrigger_stub.var_193180cc = spawn("script_model", v_origin);
    unitrigger_stub.var_193180cc setmodel("wpn_t7_zmb_zod_idg_world");
    unitrigger_stub.prompt_and_visibility_func = &function_e983d2a0;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_bae02fd4);
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0x8ada4811, Offset: 0x40b8
// Size: 0x9a
function function_e983d2a0(player) {
    var_356fbd8b = self.stub.var_356fbd8b;
    self sethintstring(%ZM_ZOD_PICKUP_IDGUN);
    b_is_invis = isdefined(player.beastmode) && player.beastmode;
    self setinvisibletoplayer(player, b_is_invis);
    return !b_is_invis;
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0xbef0210b, Offset: 0x4160
// Size: 0xa4
function function_bae02fd4() {
    while (true) {
        player = self waittill(#"trigger");
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        level thread function_3071ed77(self.stub, player);
        break;
    }
}

// Namespace namespace_4624f91a
// Params 2, eflags: 0x1 linked
// Checksum 0x575a1adb, Offset: 0x4210
// Size: 0x104
function function_3071ed77(var_91089b66, player) {
    level.var_42517170[var_91089b66.var_356fbd8b].owner = player;
    var_91089b66.var_193180cc setinvisibletoall();
    var_566556d8 = getweapon(level.var_42517170[var_91089b66.var_356fbd8b].var_e4be281f);
    player zm_weapons::weapon_give(var_566556d8, 0, 0);
    player switchtoweapon(var_566556d8);
    player namespace_b8707f8e::function_aca1bc0c(var_91089b66.var_356fbd8b);
    zm_unitrigger::unregister_unitrigger(var_91089b66);
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0x4752e9f9, Offset: 0x4320
// Size: 0x3c
function function_f89bb811() {
    level.var_f72b0650 = 0;
    while (true) {
        util::wait_network_frame();
        level.var_f72b0650 = 0;
    }
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0x4322f490, Offset: 0x4368
// Size: 0x58
function function_e1832857() {
    if (!isdefined(level.var_f72b0650)) {
        level thread function_f89bb811();
    }
    while (level.var_f72b0650 >= 2) {
        util::wait_network_frame();
    }
    level.var_f72b0650++;
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0x6a596135, Offset: 0x43c8
// Size: 0x3a
function function_a7fe5efc(player) {
    if (isdefined(player.beastmode) && player.beastmode) {
        return false;
    }
    return true;
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0xed6d56ec, Offset: 0x4410
// Size: 0x4c
function function_141a8c6e() {
    function_e1832857();
    namespace_f37770c8::function_4f91b11d("police_box_usetrigger", "police_box", "police_box", "", 1, 0);
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0xd6929ed7, Offset: 0x4468
// Size: 0x4c
function function_22d06508() {
    function_e1832857();
    namespace_f37770c8::function_4f91b11d("quest_ritual_usetrigger_boxer", "ritual_boxer", "ritual_boxer", "", 1, 0);
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0x23a1dfeb, Offset: 0x44c0
// Size: 0x4c
function function_8d3b0a6b() {
    function_e1832857();
    namespace_f37770c8::function_4f91b11d("quest_ritual_usetrigger_detective", "ritual_detective", "ritual_detective", "", 1, 0);
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0xfecad039, Offset: 0x4518
// Size: 0x4c
function function_5c92a428() {
    function_e1832857();
    namespace_f37770c8::function_4f91b11d("quest_ritual_usetrigger_femme", "ritual_femme", "ritual_femme", "", 1, 0);
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0x8b32e041, Offset: 0x4570
// Size: 0x4c
function function_a7cee407() {
    function_e1832857();
    namespace_f37770c8::function_4f91b11d("quest_ritual_usetrigger_magician", "ritual_magician", "ritual_magician", "", 1, 0);
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0x2ebed938, Offset: 0x45c8
// Size: 0x4c
function function_215ab729() {
    function_e1832857();
    namespace_f37770c8::function_4f91b11d("quest_ritual_usetrigger_pap", "ritual_pap", "ritual_pap", "", 1, 0);
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0xdceb045, Offset: 0x4620
// Size: 0x4c
function function_7a49123b() {
    function_e1832857();
    namespace_f37770c8::function_4f91b11d("idgun_zm_craftable_trigger", "idgun", "idgun", %ZM_ZOD_PICKUP_IDGUN, 1, 2);
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0x38abf079, Offset: 0x4678
// Size: 0x4c
function function_ee72d458() {
    function_e1832857();
    namespace_f37770c8::function_4f91b11d("second_idgun_zm_craftable_trigger", "second_idgun", "second_idgun", "", 1, 0);
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0x397d315d, Offset: 0x46d0
// Size: 0xda
function function_836451f4(name) {
    var_a0d1067b = array("boxer", "detective", "femme", "magician");
    foreach (var_f7af1630 in var_a0d1067b) {
        if (issubstr(name, var_f7af1630)) {
            return var_f7af1630;
        }
    }
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0xb7194709, Offset: 0x47b8
// Size: 0x6e
function function_5d5371da(name) {
    var_3e023e17 = array("memento_boxer", "memento_detective", "memento_femme", "memento_magician");
    if (isinarray(var_3e023e17, name)) {
        return true;
    }
    return false;
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0x2199fba1, Offset: 0x4830
// Size: 0x5a
function function_f47faf9a(name) {
    if (name == "relic_boxer" || name == "relic_detective" || name == "relic_femme" || name == "relic_magician") {
        return 1;
    }
    return 0;
}

// Namespace namespace_4624f91a
// Params 1, eflags: 0x1 linked
// Checksum 0xec3c1f8d, Offset: 0x4898
// Size: 0xc
function function_be206d34(player) {
    
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x48b0
// Size: 0x4
function function_832dcda8() {
    
}

