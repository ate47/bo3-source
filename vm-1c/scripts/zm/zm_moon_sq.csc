#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/zm_moon_fx;

#namespace zm_moon_sq;

// Namespace zm_moon_sq
// Params 0, eflags: 0x0
// Checksum 0xb3ad3c70, Offset: 0x4b8
// Size: 0x44c
function init_clientfields() {
    level.var_d224bbf0 = [];
    namespace_6e97c459::function_225a92d6("vril", 21000);
    namespace_6e97c459::function_225a92d6("anti115", 21000);
    namespace_6e97c459::function_225a92d6("generator", 21000);
    namespace_6e97c459::function_225a92d6("cgenerator", 21000);
    namespace_6e97c459::function_225a92d6("wire", 21000);
    namespace_6e97c459::function_225a92d6("datalog", 21000);
    clientfield::register("world", "raise_rockets", 21000, 1, "counter", &raise_rockets, 0, 0);
    clientfield::register("world", "rocket_launch", 21000, 1, "counter", &rocket_launch, 0, 0);
    clientfield::register("world", "rocket_explode", 21000, 1, "counter", &rocket_explode, 0, 0);
    clientfield::register("world", "charge_tank_1", 21000, 1, "counter", &charge_tank_1, 0, 0);
    clientfield::register("world", "charge_tank_2", 21000, 1, "counter", &charge_tank_2, 0, 0);
    clientfield::register("world", "charge_tank_cleanup", 21000, 1, "counter", &charge_tank_cleanup, 0, 0);
    clientfield::register("world", "sam_vo_rumble", 21000, 1, "int", &sam_vo_rumble, 0, 0);
    clientfield::register("world", "charge_vril_init", 21000, 1, "int", &charge_vril_init, 0, 0);
    clientfield::register("world", "sq_wire_init", 21000, 1, "int", &sq_wire_init, 0, 0);
    clientfield::register("world", "sam_init", 21000, 1, "int", &sam_init, 0, 0);
    n_bits = getminbitcountfornum(4);
    clientfield::register("world", "vril_generator", 21000, n_bits, "int", &vril_generator, 0, 0);
    clientfield::register("world", "sam_end_rumble", 21000, 1, "int", &sam_end_rumble, 0, 0);
}

// Namespace zm_moon_sq
// Params 0, eflags: 0x0
// Checksum 0x1787f7b3, Offset: 0x910
// Size: 0x4
function rocket_test() {
    
}

// Namespace zm_moon_sq
// Params 7, eflags: 0x0
// Checksum 0x930e7d30, Offset: 0x920
// Size: 0x48
function charge_tank_cleanup(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    level.var_d224bbf0 = [];
}

// Namespace zm_moon_sq
// Params 1, eflags: 0x0
// Checksum 0x3586d40a, Offset: 0x970
// Size: 0x4e
function function_13789e51(dest) {
    while (true) {
        /#
            print3d(dest, "<dev string:x28>", (255, 0, 0), 30);
        #/
        wait 1;
    }
}

// Namespace zm_moon_sq
// Params 0, eflags: 0x0
// Checksum 0x8bb418f4, Offset: 0x9c8
// Size: 0x1ec
function function_62979c5b() {
    setdvar("r_poisonFX_debug_amount", 0);
    setdvar("r_poisonFX_debug_enable", 1);
    setdvar("r_poisonFX_pulse", 2);
    setdvar("r_poisonFX_warpX", -0.3);
    setdvar("r_poisonFX_warpY", 0.15);
    setdvar("r_poisonFX_dvisionA", 0);
    setdvar("r_poisonFX_dvisionX", 0);
    setdvar("r_poisonFX_dvisionY", 0);
    setdvar("r_poisonFX_blurMin", 0);
    setdvar("r_poisonFX_blurMax", 3);
    delta = 0.064;
    amount = 1;
    setdvar("r_poisonFX_debug_amount", amount);
    wait 3;
    while (amount > 0) {
        amount = max(amount - delta, 0);
        setdvar("r_poisonFX_debug_amount", amount);
        wait 0.016;
    }
    setdvar("r_poisonFX_debug_amount", 0);
    setdvar("r_poisonFX_debug_enable", 0);
}

// Namespace zm_moon_sq
// Params 7, eflags: 0x0
// Checksum 0x1fe40261, Offset: 0xbc0
// Size: 0x25e
function soul_swap(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (localclientnum != 0) {
        return;
    }
    if (bnewent) {
        return;
    }
    if (!newval) {
        return;
    }
    if (getlocalplayers().size == 1) {
        level thread function_62979c5b();
    }
    for (i = 0; i < getlocalplayers().size; i++) {
        e = spawn(i, self.origin + (0, 0, 24), "script_model");
        e setmodel("tag_origin");
        if (i == 0) {
            e playsound(0, "zmb_squest_soul_leave");
        }
        e thread function_384d443e(i, "soul_swap_trail", level.var_5e1c6b8d.origin + (0, 0, 24));
        e = spawn(i, level.var_5e1c6b8d.origin + (0, 0, 24), "script_model");
        e setmodel("tag_origin");
        if (i == 0) {
            e playsound(0, "zmb_squest_soul_leave");
        }
        e thread function_384d443e(i, "soul_swap_trail", self.origin + (0, 0, 24));
    }
}

// Namespace zm_moon_sq
// Params 3, eflags: 0x0
// Checksum 0x558491b7, Offset: 0xe28
// Size: 0xb4
function function_384d443e(localclientnum, fx_name, dest) {
    playfxontag(localclientnum, level._effect[fx_name], self, "tag_origin");
    self moveto(dest, 0.5);
    self waittill(#"movedone");
    playsound(0, "zmb_squest_soul_impact", dest);
    self delete();
}

// Namespace zm_moon_sq
// Params 7, eflags: 0x0
// Checksum 0xb518d361, Offset: 0xee8
// Size: 0x264
function function_86a718a9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (localclientnum != 0) {
        return;
    }
    closest = undefined;
    min_dist = 99980001;
    for (i = 0; i < level.var_d224bbf0.size; i++) {
        dist = distancesquared(self.origin, level.var_d224bbf0[i].origin);
        if (dist < min_dist) {
            min_dist = dist;
            closest = level.var_d224bbf0[i];
        }
    }
    if (isdefined(closest)) {
        println("<dev string:x2a>" + self.origin + "<dev string:x34>" + closest.origin);
        for (i = 0; i < getlocalplayers().size; i++) {
            e = spawn(i, self.origin + (0, 0, 24), "script_model");
            e setmodel("tag_origin");
            if (i == 0) {
                e playsound(0, "zmb_squest_soul_leave");
            }
            e thread function_384d443e(i, "fx_weak_sauce_trail", closest.origin - (0, 0, 12));
        }
        return;
    }
    println("<dev string:x39>");
}

// Namespace zm_moon_sq
// Params 2, eflags: 0x0
// Checksum 0xceddb7ab, Offset: 0x1158
// Size: 0x1e8
function function_7013f302(var_689a45ac, var_fcc3f768) {
    var_19c24e40 = [];
    tanks = struct::get_array(var_689a45ac, "targetname");
    println("<dev string:x5a>");
    for (i = 0; i < tanks.size; i++) {
        tank = tanks[i];
        var_2b6ee6a7 = struct::get(tank.target, "targetname");
        s_target = struct::get(var_2b6ee6a7.target, "targetname");
        var_19c24e40[var_19c24e40.size] = s_target;
    }
    if (isdefined(var_fcc3f768)) {
        tanks = struct::get_array(var_fcc3f768, "targetname");
        for (i = 0; i < tanks.size; i++) {
            tank = tanks[i];
            var_2b6ee6a7 = struct::get(tank.target, "targetname");
            s_target = struct::get(var_2b6ee6a7.target, "targetname");
            var_19c24e40[var_19c24e40.size] = s_target;
        }
    }
    return var_19c24e40;
}

// Namespace zm_moon_sq
// Params 7, eflags: 0x0
// Checksum 0xe37a84ee, Offset: 0x1348
// Size: 0x11e
function charge_vril_init(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        var_cefa6d0 = struct::get_array("sq_cp_final", "targetname");
        for (i = 0; i < var_cefa6d0.size; i++) {
            targ = var_cefa6d0[i];
            var_93d55a25 = util::spawn_model(localclientnum, targ.model, targ.origin, targ.angles);
            var_93d55a25 playsound(localclientnum, "evt_clank");
        }
    }
}

// Namespace zm_moon_sq
// Params 7, eflags: 0x0
// Checksum 0x6f84c5f0, Offset: 0x1470
// Size: 0xdc
function sq_wire_init(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        targ = struct::get("sq_wire_final", "targetname");
        var_93d55a25 = util::spawn_model(localclientnum, targ.model, targ.origin, targ.angles);
        var_93d55a25 playsound(localclientnum, "evt_start_old_computer");
    }
}

// Namespace zm_moon_sq
// Params 1, eflags: 0x0
// Checksum 0xc97e5afc, Offset: 0x1558
// Size: 0x150
function function_1e7e25e0(struct) {
    endpos = struct::get(struct.target, "targetname");
    self moveto(endpos.origin, 3);
    self waittill(#"movedone");
    start_z = self.origin;
    amplitude = 7;
    frequency = 75;
    t = 0;
    level.var_5e1c6b8d = self;
    while (true) {
        var_a2bbb4cc = sin(frequency * t);
        var_c4ad35e3 = amplitude * var_a2bbb4cc;
        self.origin = start_z + (0, 0, var_c4ad35e3);
        t += 0.016;
        wait 0.016;
    }
}

// Namespace zm_moon_sq
// Params 7, eflags: 0x0
// Checksum 0xec7f178a, Offset: 0x16b0
// Size: 0x124
function sam_init(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        targ = struct::get("sq_sam", "targetname");
        var_93d55a25 = util::spawn_model(localclientnum, targ.model, targ.origin, targ.angles);
        playfx(localclientnum, level._effect["lght_marker_flare"], targ.origin);
        var_93d55a25 thread function_1e7e25e0(targ);
        var_93d55a25 playloopsound("evt_samantha_reveal_loop", 1);
    }
}

// Namespace zm_moon_sq
// Params 0, eflags: 0x0
// Checksum 0xce9e6f97, Offset: 0x17e0
// Size: 0xe0
function function_346ea5d8() {
    self endon(#"death");
    start_z = self.origin;
    amplitude = 2;
    frequency = 100;
    t = 0;
    while (true) {
        var_a2bbb4cc = sin(frequency * t);
        var_c4ad35e3 = amplitude * var_a2bbb4cc;
        self.origin = start_z + (0, 0, var_c4ad35e3);
        t += 0.016;
        wait 0.016;
    }
}

// Namespace zm_moon_sq
// Params 7, eflags: 0x0
// Checksum 0xee4a25cb, Offset: 0x18c8
// Size: 0x2f2
function vril_generator(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    targ = struct::get("sq_charge_vg_pos", "targetname");
    if (!isdefined(level.a_ents)) {
        level.a_ents = [];
    }
    switch (newval) {
    case 1:
        var_93d55a25 = util::spawn_model(localclientnum, targ.model, targ.origin, targ.angles);
        var_93d55a25 thread function_346ea5d8();
        level.a_ents[level.a_ents.size] = var_93d55a25;
        break;
    case 2:
        for (i = 0; i < level.a_ents.size; i++) {
            playfxontag(localclientnum, level._effect["vrill_glow"], level.a_ents[i], "tag_origin");
        }
        break;
    case 3:
        for (j = 0; j < level.a_ents.size; j++) {
            level.a_ents[j] delete();
        }
        level.a_ents = [];
        break;
    case 4:
        var_dbd86497 = struct::get("sq_vg_final", "targetname");
        level.a_ents = [];
        var_93d55a25 = util::spawn_model(localclientnum, var_dbd86497.model, var_dbd86497.origin, var_dbd86497.angles);
        level.a_ents[level.a_ents.size] = var_93d55a25;
        for (i = 0; i < level.a_ents.size; i++) {
            playfxontag(localclientnum, level._effect["vrill_glow"], level.a_ents[i], "tag_origin");
        }
        level._override_eye_fx = level._effect["blue_eyes"];
        break;
    }
}

// Namespace zm_moon_sq
// Params 7, eflags: 0x0
// Checksum 0xcf01b906, Offset: 0x1bc8
// Size: 0x5c
function charge_tank_1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    level.var_d224bbf0 = function_7013f302("sq_first_tank");
}

// Namespace zm_moon_sq
// Params 7, eflags: 0x0
// Checksum 0x9499ed76, Offset: 0x1c30
// Size: 0x64
function charge_tank_2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    level.var_d224bbf0 = function_7013f302("sq_second_tank", "sq_first_tank");
}

// Namespace zm_moon_sq
// Params 7, eflags: 0x0
// Checksum 0xd58008bb, Offset: 0x1ca0
// Size: 0x76
function sam_end_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        level thread function_da7234e2(localclientnum);
        return;
    }
    level notify(#"hash_f9b2abc9");
}

// Namespace zm_moon_sq
// Params 1, eflags: 0x0
// Checksum 0xc650302b, Offset: 0x1d20
// Size: 0x138
function function_da7234e2(localclientnum) {
    level endon(#"hash_f9b2abc9");
    var_845cd5d1 = struct::get("pyramid_walls_retract", "targetname");
    while (true) {
        a_players = getlocalplayers();
        for (i = 0; i < a_players.size; i++) {
            if (!isdefined(a_players[i])) {
                continue;
            }
            if (distancesquared(var_845cd5d1.origin, a_players[i].origin) < 562500) {
                a_players[i] playrumbleonentity(localclientnum, "slide_rumble");
            }
        }
        wait randomfloatrange(0.05, 0.15);
    }
}

// Namespace zm_moon_sq
// Params 7, eflags: 0x0
// Checksum 0xaa1a7b90, Offset: 0x1e60
// Size: 0x8e
function sam_vo_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        array::thread_all(getlocalplayers(), &function_9b1295b1, localclientnum);
        return;
    }
    level notify(#"hash_306cf2d4");
}

// Namespace zm_moon_sq
// Params 1, eflags: 0x0
// Checksum 0xd533178d, Offset: 0x1ef8
// Size: 0xb0
function function_9b1295b1(localclientnum) {
    self endon(#"disconnect");
    level endon(#"hash_306cf2d4");
    while (true) {
        self earthquake(randomfloatrange(0.2, 0.25), 5, self.origin, 100);
        self playrumbleonentity(localclientnum, "slide_rumble");
        wait randomfloatrange(0.1, 0.15);
    }
}

// Namespace zm_moon_sq
// Params 7, eflags: 0x0
// Checksum 0xbfdd5e48, Offset: 0x1fb0
// Size: 0x6a
function raise_rockets(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    level thread function_563a98ff();
    wait 4.5;
    level notify(#"hash_a8151d8f");
}

// Namespace zm_moon_sq
// Params 0, eflags: 0x0
// Checksum 0xfeca1520, Offset: 0x2028
// Size: 0x100
function function_563a98ff() {
    level endon(#"hash_a8151d8f");
    while (true) {
        for (i = 0; i < level.localplayers.size; i++) {
            player = getlocalplayers()[i];
            if (!isdefined(player)) {
                continue;
            }
            player earthquake(randomfloatrange(0.15, 0.2), 5, player.origin, 100);
            player playrumbleonentity(i, "slide_rumble");
        }
        wait randomfloatrange(0.1, 0.15);
    }
}

// Namespace zm_moon_sq
// Params 7, eflags: 0x0
// Checksum 0x921b9621, Offset: 0x2130
// Size: 0x66
function rocket_launch(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    level thread function_d2199485();
    wait 6;
    level notify(#"hash_93f26bd1");
}

// Namespace zm_moon_sq
// Params 0, eflags: 0x0
// Checksum 0xfb2814c2, Offset: 0x21a0
// Size: 0x100
function function_d2199485() {
    level endon(#"hash_93f26bd1");
    while (true) {
        for (i = 0; i < level.localplayers.size; i++) {
            player = getlocalplayers()[i];
            if (!isdefined(player)) {
                continue;
            }
            player earthquake(randomfloatrange(0.26, 0.31), 5, player.origin, 100);
            player playrumbleonentity(i, "damage_light");
        }
        wait randomfloatrange(0.1, 0.15);
    }
}

// Namespace zm_moon_sq
// Params 7, eflags: 0x0
// Checksum 0x91afdd3b, Offset: 0x22a8
// Size: 0x76
function rocket_explode(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    level.var_abc92c08 = 1;
    wait 3.5;
    level thread function_5df2c048();
    wait 4;
    level notify(#"hash_e43026d6");
}

// Namespace zm_moon_sq
// Params 0, eflags: 0x0
// Checksum 0x793e2651, Offset: 0x2328
// Size: 0x1c0
function function_5df2c048() {
    level endon(#"hash_e43026d6");
    for (i = 0; i < level.localplayers.size; i++) {
        player = getlocalplayers()[i];
        if (!isdefined(player)) {
            continue;
        }
        player earthquake(randomfloatrange(0.4, 0.45), 5, player.origin, 100);
        player playrumbleonentity(i, "damage_heavy");
    }
    wait 0.2;
    while (true) {
        for (i = 0; i < level.localplayers.size; i++) {
            player = getlocalplayers()[i];
            if (!isdefined(player)) {
                continue;
            }
            player earthquake(randomfloatrange(0.35, 0.4), 5, player.origin, 100);
            player playrumbleonentity(i, "damage_light");
        }
        wait randomfloatrange(0.1, 0.15);
    }
}

// Namespace zm_moon_sq
// Params 7, eflags: 0x0
// Checksum 0x74636dae, Offset: 0x24f0
// Size: 0x124
function function_38a2773c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (localclientnum != 0) {
        return;
    }
    var_8c15cb32 = struct::get("sd_bowl", "targetname");
    e_origin = util::spawn_model(localclientnum, "tag_origin", self.origin + (0, 0, 24));
    if (localclientnum == 0) {
        e_origin playsound(localclientnum, "zmb_squest_soul_leave");
    }
    e_origin thread function_384d443e(localclientnum, "fx_weak_sauce_trail", var_8c15cb32.origin - (0, 0, 12));
}

