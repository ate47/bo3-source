#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_chamber;
#using scripts/zm/_zm_utility;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_90429ef7;

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0x618f4c36, Offset: 0x4a0
// Size: 0x264
function main() {
    level flag::init("fire_puzzle_1_complete");
    level flag::init("fire_puzzle_2_complete");
    level flag::init("fire_upgrade_available");
    callback::on_connect(&onplayerconnect);
    function_badc3cb5();
    function_4c0b94bc();
    namespace_ad52727b::function_446b06b3(1, "vox_sam_fire_puz_solve_0");
    namespace_ad52727b::function_446b06b3(1, "vox_sam_fire_puz_solve_1");
    namespace_ad52727b::function_446b06b3(1, "vox_sam_fire_puz_solve_2");
    level thread namespace_ad52727b::function_d22bb7("puzzle", "try_puzzle", "vo_try_puzzle_fire1");
    level thread namespace_ad52727b::function_d22bb7("puzzle", "try_puzzle", "vo_try_puzzle_fire2");
    level thread function_8487a3a2();
    level flag::wait_till("fire_puzzle_1_complete");
    playsoundatposition("zmb_squest_step1_finished", (0, 0, 0));
    level thread namespace_d7c0ce12::function_d0dc88b2(5, 3);
    level thread function_bcadff2d();
    level thread function_5b72f9c5();
    level flag::wait_till("fire_puzzle_2_complete");
    level thread function_5cf6e84a();
    level flag::wait_till("staff_fire_upgrade_unlocked");
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0x92a0e9bb, Offset: 0x710
// Size: 0x1c
function onplayerconnect() {
    self thread function_c1e34803();
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x738
// Size: 0x4
function function_badc3cb5() {
    
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0xadc536f8, Offset: 0x748
// Size: 0x1bc
function function_8487a3a2() {
    level.var_286a5424 = getentarray("fire_sacrifice_volume", "targetname");
    level.var_5e66e5af = [];
    level thread function_9467783d();
    array::thread_all(level.var_286a5424, &function_272fbe7a);
    var_54dfbe0e = 1;
    while (var_54dfbe0e) {
        level waittill(#"hash_ebec68a1");
        var_54dfbe0e = 0;
        foreach (e_volume in level.var_286a5424) {
            if (!e_volume.var_4e7c813a) {
                var_54dfbe0e = 1;
            }
        }
    }
    /#
        iprintlnbold("puzzle");
    #/
    e_player = zm_utility::get_closest_player(level.var_286a5424[0].origin);
    e_player thread namespace_ad52727b::function_2af394fb(1);
    level flag::set("fire_puzzle_1_complete");
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0xb7525111, Offset: 0x910
// Size: 0x50
function function_bcadff2d() {
    array::delete_all(level.var_286a5424);
    level.var_286a5424 = [];
    array::delete_all(level.var_5e66e5af);
    level.var_5e66e5af = [];
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0x9d61cae8, Offset: 0x968
// Size: 0x6c
function function_9467783d() {
    level endon(#"hash_94fa4882");
    while (true) {
        wait(1);
        if (level.var_5e66e5af.size > 0) {
            if (!namespace_435339fc::function_55f62409()) {
                array::delete_all(level.var_5e66e5af);
                level.var_5e66e5af = [];
            }
        }
    }
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0x8a4fcae7, Offset: 0x9e0
// Size: 0x6c
function function_272fbe7a() {
    self.var_4e7c813a = 0;
    self.var_df5d5c2a = 0;
    self.var_95c5ef8b = 0;
    self.var_1750372f = struct::get(self.target, "targetname");
    self.var_1750372f thread function_cbc73b4c(self);
}

// Namespace namespace_90429ef7
// Params 1, eflags: 0x1 linked
// Checksum 0x16ebac00, Offset: 0xa58
// Size: 0x9c
function function_fd8c0680(e_volume) {
    while (true) {
        if (level flag::get("fire_puzzle_1_complete")) {
            break;
        } else if (isdefined(e_volume)) {
            if (e_volume.var_95c5ef8b > self.script_float || e_volume.var_4e7c813a) {
                break;
            }
        }
        wait(0.5);
    }
    function_7cda1e4f();
}

// Namespace namespace_90429ef7
// Params 1, eflags: 0x1 linked
// Checksum 0x9da2a6c7, Offset: 0xb00
// Size: 0x266
function function_cbc73b4c(e_volume) {
    e_volume flag::init("flame_on");
    if (level flag::get("fire_puzzle_1_complete")) {
        return;
    }
    level endon(#"hash_94fa4882");
    var_ffdecb62 = struct::get_array(self.target, "targetname");
    array::thread_all(var_ffdecb62, &function_fd8c0680, e_volume);
    sndorigin = var_ffdecb62[0].origin;
    if (!isdefined(self.angles)) {
        self.angles = (0, 0, 0);
    }
    var_7831da4e = 10000;
    while (!e_volume.var_4e7c813a) {
        e_volume flag::clear("flame_on");
        v_point, e_projectile = level waittill(#"hash_d85b0552");
        if (!namespace_435339fc::function_55f62409()) {
            continue;
        }
        if (!e_projectile istouching(e_volume)) {
            continue;
        }
        self.e_fx = spawn("script_model", self.origin);
        self.e_fx.angles = (-90, 0, 0);
        self.e_fx setmodel("tag_origin");
        self.e_fx clientfield::set("barbecue_fx", 1);
        e_volume flag::set("flame_on");
        wait(6);
        self.e_fx delete();
    }
    level notify(#"hash_ebec68a1");
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0xa4f2987e, Offset: 0xd70
// Size: 0x17c
function function_7cda1e4f() {
    e_fx = spawn("script_model", self.origin);
    e_fx setmodel("tag_origin");
    var_a58a7b24 = "lgtexp_fire_charge_0" + self.script_int;
    exploder::exploder(var_a58a7b24);
    e_fx.angles = (-90, 0, 0);
    e_fx playsound("zmb_squest_fire_torch_ignite");
    e_fx playloopsound("zmb_squest_fire_torch_loop", 0.6);
    level flag::wait_till("fire_puzzle_1_complete");
    wait(30);
    e_fx stoploopsound(0.1);
    e_fx playsound("zmb_squest_fire_torch_out");
    e_fx delete();
    exploder::kill_exploder(var_a58a7b24);
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0x34d262a5, Offset: 0xef8
// Size: 0x8
function function_8aada0a4() {
    return true;
}

// Namespace namespace_90429ef7
// Params 8, eflags: 0x1 linked
// Checksum 0xc4009e1a, Offset: 0xf08
// Size: 0x194
function function_6cc4ff94(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime) {
    if (!(isdefined(level.var_84ae2a3c["elemental_staff_fire"]) && level.var_84ae2a3c["elemental_staff_fire"]) && getdvarint("zombie_cheat") <= 0) {
        return;
    }
    if (isdefined(self.is_mechz) && self.is_mechz) {
        return;
    }
    if (!isdefined(level.var_286a5424)) {
        return;
    }
    if (!namespace_435339fc::function_55f62409()) {
        return;
    }
    foreach (e_volume in level.var_286a5424) {
        if (e_volume.var_4e7c813a) {
            continue;
        }
        if (self istouching(e_volume)) {
            level notify(#"hash_ce9cd53d", attacker);
            self thread function_dceec692(e_volume);
            return;
        }
    }
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0x354bc1f2, Offset: 0x10a8
// Size: 0x64
function function_c2d0bf44() {
    if (level.var_5e66e5af.size == 0) {
        return;
    }
    clone = level.var_5e66e5af[0];
    arrayremoveindex(level.var_5e66e5af, 0, 0);
    clone delete();
}

// Namespace namespace_90429ef7
// Params 1, eflags: 0x1 linked
// Checksum 0x4b35ecf2, Offset: 0x1118
// Size: 0x30c
function function_dceec692(var_34868759) {
    if (level.var_5e66e5af.size >= 15) {
        level function_c2d0bf44();
    }
    self ghost();
    clone = self function_31040961();
    level.var_5e66e5af[level.var_5e66e5af.size] = clone;
    clone endon(#"death");
    if (isdefined(self.missinglegs) && self.missinglegs) {
        clone scene::play("cin_zmhd_zombie_death_crawl", clone);
    } else {
        clone scene::play("cin_zmhd_zombie_death", clone);
    }
    var_34868759 flag::wait_till("flame_on");
    var_32bc7eba = level.var_b0d8f1fe["staff_fire"].w_weapon;
    a_players = getplayers();
    foreach (e_player in a_players) {
        if (e_player hasweapon(var_32bc7eba)) {
            level notify(#"hash_94845a1", e_player);
        }
    }
    playfx(level._effect["fire_ash_explosion"], clone.origin, anglestoforward(clone.angles), anglestoup(clone.angles));
    var_34868759.var_df5d5c2a++;
    var_34868759.var_95c5ef8b = var_34868759.var_df5d5c2a / 32;
    if (var_34868759.var_df5d5c2a >= 32) {
        var_34868759.var_4e7c813a = 1;
    }
    var_34868759 notify(#"hash_4dc9502e");
    arrayremovevalue(level.var_5e66e5af, clone);
    clone delete();
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0xfa11a0d0, Offset: 0x1430
// Size: 0xa8
function function_31040961() {
    clone = util::spawn_model(self.model, self.origin, self.angles);
    if (isdefined(self.headmodel)) {
        clone.headmodel = self.headmodel;
        clone attach(clone.headmodel, "", 1);
    }
    clone useanimtree(#generic);
    return clone;
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0x888037d9, Offset: 0x14e0
// Size: 0x15c
function function_4c0b94bc() {
    for (i = 1; i <= 4; i++) {
        var_9c6204c6 = getentarray("fire_torch_ternary_group_0" + i, "targetname");
        if (var_9c6204c6.size > 1) {
            var_19e0d343 = randomintrange(0, var_9c6204c6.size);
            var_9c6204c6[var_19e0d343] ghost();
            arrayremoveindex(var_9c6204c6, var_19e0d343, 0);
            array::delete_all(var_9c6204c6);
            continue;
        }
        var_9c6204c6[0] ghost();
    }
    var_8740dc71 = struct::get_array("church_torch_target", "script_noteworthy");
    array::thread_all(var_8740dc71, &function_98b7d4b1);
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0x4d4ba2cb, Offset: 0x1648
// Size: 0x13a
function function_5b72f9c5() {
    var_9c6204c6 = getentarray("fire_torch_ternary", "script_noteworthy");
    assert(var_9c6204c6.size == 4);
    foreach (var_27b8ef56 in var_9c6204c6) {
        var_27b8ef56 show();
        var_8ccc3a0d = struct::get(var_27b8ef56.target, "targetname");
        var_8ccc3a0d.var_cca3173d = 1;
        var_8ccc3a0d thread namespace_d7c0ce12::function_5de0d079();
    }
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0x27221a97, Offset: 0x1790
// Size: 0x17a
function function_5cf6e84a() {
    var_8740dc71 = struct::get_array("church_torch_target", "script_noteworthy");
    foreach (var_7029104f in var_8740dc71) {
        if (!isdefined(var_7029104f.e_fx)) {
            var_7029104f thread function_6fe3d250();
            wait(0.25);
        }
    }
    wait(30);
    foreach (var_7029104f in var_8740dc71) {
        if (isdefined(var_7029104f.e_fx)) {
            var_7029104f.e_fx delete();
            wait(0.25);
        }
    }
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0x37e02513, Offset: 0x1918
// Size: 0x2f0
function function_601c220c() {
    var_8740dc71 = struct::get_array("church_torch_target", "script_noteworthy");
    var_4c7352db = 0;
    var_f71cc0cc = 0;
    foreach (var_cca34455 in var_8740dc71) {
        if (isdefined(var_cca34455.e_fx) && !var_cca34455.var_cca3173d) {
            var_4c7352db = 1;
        }
        if (!isdefined(var_cca34455.e_fx) && var_cca34455.var_cca3173d) {
            var_f71cc0cc = 1;
        }
    }
    if (!isdefined(level.var_a1451cf8)) {
        level.var_a1451cf8 = 0;
    }
    if (!isdefined(level.var_eb3f2eb8)) {
        level.var_eb3f2eb8 = 0;
    }
    level.var_a1451cf8++;
    a_players = getplayers();
    foreach (e_player in a_players) {
        if (e_player hasweapon(level.var_b0d8f1fe["staff_fire"].w_weapon)) {
            if (level.var_a1451cf8 % 12 == 0 && !level flag::get("fire_puzzle_2_complete")) {
                level notify(#"hash_772f0d7", e_player);
                continue;
            }
            if (var_4c7352db && !level flag::get("fire_puzzle_2_complete")) {
                level.var_eb3f2eb8++;
                if (level.var_eb3f2eb8 % 5 == 0) {
                    level notify(#"hash_bac0d9ff", e_player);
                }
                continue;
            }
            if (var_f71cc0cc) {
                level notify(#"hash_94845a1", e_player);
            }
        }
    }
    return !var_4c7352db && !var_f71cc0cc;
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0xcee9de5f, Offset: 0x1c10
// Size: 0x9e
function function_c1e34803() {
    self endon(#"disconnect");
    while (true) {
        weapon, var_836ef144, n_radius, e_projectile, var_94351942 = self waittill(#"projectile_impact");
        if (weapon == level.var_b0d8f1fe["staff_fire"].w_weapon) {
            level notify(#"hash_d85b0552", var_836ef144, e_projectile);
        }
    }
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0x868c1ae8, Offset: 0x1cb8
// Size: 0x24c
function function_6fe3d250() {
    if (isdefined(self.e_fx)) {
        self.e_fx delete();
    }
    self.e_fx = spawn("script_model", self.origin);
    self.e_fx.angles = (-90, 0, 0);
    self.e_fx setmodel("tag_origin");
    playfxontag(level._effect["fire_torch"], self.e_fx, "tag_origin");
    self.e_fx playsound("zmb_squest_fire_torch_ignite");
    self.e_fx playloopsound("zmb_squest_fire_torch_loop", 0.6);
    namespace_d7c0ce12::rumble_nearby_players(self.origin, 1500, 2);
    self.e_fx endon(#"death");
    if (function_601c220c() && !level flag::get("fire_puzzle_2_complete")) {
        self.e_fx thread namespace_ad52727b::function_2af394fb(1);
        level thread namespace_d7c0ce12::function_95f226b8();
        level flag::set("fire_puzzle_2_complete");
    }
    wait(15);
    self.e_fx stoploopsound(0.1);
    self.e_fx playsound("zmb_squest_fire_torch_out");
    if (!level flag::get("fire_puzzle_2_complete")) {
        self.e_fx delete();
    }
}

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// Checksum 0x26fcb8bd, Offset: 0x1f10
// Size: 0x1a0
function function_98b7d4b1() {
    level endon(#"hash_501871cf");
    self.var_cca3173d = 0;
    var_7831da4e = 4096;
    var_32bc7eba = level.var_b0d8f1fe["staff_fire"].w_weapon;
    while (true) {
        v_point = level waittill(#"hash_d85b0552");
        if (!function_8aada0a4()) {
            continue;
        }
        dist_sq = distancesquared(v_point, self.origin);
        if (dist_sq > var_7831da4e) {
            continue;
        }
        a_players = getplayers();
        foreach (e_player in a_players) {
            if (e_player hasweapon(var_32bc7eba)) {
                level notify(#"hash_f49f4fa6", e_player);
            }
        }
        self thread function_6fe3d250();
        wait(2);
    }
}

