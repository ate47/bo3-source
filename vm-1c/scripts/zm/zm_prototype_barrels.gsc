#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;

#namespace zm_prototype_barrels;

// Namespace zm_prototype_barrels
// Params 0, eflags: 0x2
// Checksum 0xf15f8ac7, Offset: 0x308
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_prototype_barrels", &__init__, undefined, undefined);
}

// Namespace zm_prototype_barrels
// Params 0, eflags: 0x0
// Checksum 0x142f833e, Offset: 0x348
// Size: 0x1e4
function __init__() {
    var_37ec7c95 = 0;
    var_fe4ba9bc = getentarray("explodable_barrel", "targetname");
    if (isdefined(var_fe4ba9bc) && var_fe4ba9bc.size > 0) {
        var_37ec7c95 = 1;
    }
    var_fe4ba9bc = getentarray("explodable_barrel", "script_noteworthy");
    if (isdefined(var_fe4ba9bc) && var_fe4ba9bc.size > 0) {
        var_37ec7c95 = 1;
    }
    if (!var_37ec7c95) {
        return;
    }
    clientfield::register("scriptmover", "exploding_barrel_burn_fx", 21000, 1, "int");
    clientfield::register("scriptmover", "exploding_barrel_explode_fx", 21000, 1, "int");
    level.var_f3fbf98f = "exp_redbarrel";
    level.var_b08747d0 = "exp_redbarrel_ignition";
    level.var_24245e4b = 350;
    level.var_bbaf8ae8 = 0;
    array::thread_all(getentarray("explodable_barrel", "targetname"), &function_5cbc13a7);
    array::thread_all(getentarray("explodable_barrel", "script_noteworthy"), &function_5cbc13a7);
    level thread function_28ed3370();
}

// Namespace zm_prototype_barrels
// Params 0, eflags: 0x0
// Checksum 0x33453107, Offset: 0x538
// Size: 0x24
function function_66d46c7d() {
    self clientfield::set("exploding_barrel_burn_fx", 1);
}

// Namespace zm_prototype_barrels
// Params 0, eflags: 0x0
// Checksum 0x1b19fe27, Offset: 0x568
// Size: 0x24
function function_b6fe19c5() {
    self clientfield::set("exploding_barrel_explode_fx", 1);
}

// Namespace zm_prototype_barrels
// Params 0, eflags: 0x0
// Checksum 0x9b41691, Offset: 0x598
// Size: 0x1d0
function function_5cbc13a7() {
    if (self.classname != "script_model") {
        return;
    }
    self endon(#"exploding");
    self.damagetaken = 0;
    self setcandamage(1);
    for (;;) {
        self waittill(#"damage", amount, attacker, direction_vec, p, type);
        println("<dev string:x28>" + type);
        if (type == "MOD_MELEE" || type == "MOD_IMPACT") {
            continue;
        }
        if (isdefined(attacker.classname) && !isplayer(attacker) && isdefined(self.script_requires_player) && self.script_requires_player && attacker.classname != "worldspawn") {
            continue;
        }
        if (isdefined(self.var_29b74a30) && self.var_29b74a30) {
            self.damageowner = self;
        } else {
            self.damageowner = attacker;
        }
        if (level.var_bbaf8ae8) {
            wait randomfloat(1);
        }
        self.damagetaken += amount;
        if (self.damagetaken == amount) {
            self thread function_7a7f26e6();
        }
    }
}

// Namespace zm_prototype_barrels
// Params 0, eflags: 0x0
// Checksum 0xa49a7a4b, Offset: 0x770
// Size: 0x154
function function_7a7f26e6() {
    count = 0;
    var_5c4f80d6 = 0;
    while (self.damagetaken < level.var_24245e4b) {
        if (!var_5c4f80d6) {
            function_66d46c7d();
            level thread sound::play_in_space(level.var_b08747d0, self.origin);
            var_5c4f80d6 = 1;
        }
        if (count > 20) {
            count = 0;
        }
        if (count == 0) {
            self.damagetaken += 10 + randomfloat(10);
            badplace_cylinder("", 1, self.origin, -128, -6, "axis");
            self playsound("exp_barrel_fuse");
        }
        count++;
        wait 0.05;
    }
    self thread function_c19689f4();
}

// Namespace zm_prototype_barrels
// Params 0, eflags: 0x0
// Checksum 0x2b6e1189, Offset: 0x8d0
// Size: 0x420
function function_c19689f4() {
    self notify(#"exploding");
    self notify(#"death");
    up = anglestoup(self.angles);
    worldup = anglestoup((0, 90, 0));
    dot = vectordot(up, worldup);
    offset = (0, 0, 0);
    if (dot < 0.5) {
        start = self.origin + vectorscale(up, 22);
        end = physicstrace(start, start + (0, 0, -64));
        offset = end - self.origin;
    }
    offset += (0, 0, 4);
    function_b6fe19c5();
    level thread sound::play_in_space(level.var_f3fbf98f, self.origin);
    physicsexplosionsphere(self.origin + offset, 100, 80, 1);
    playrumbleonposition("barrel_explosion", self.origin + (0, 0, 32));
    level notify(#"hash_83cc4809");
    level.var_bbaf8ae8 = 1;
    if (isdefined(self.remove)) {
        self.remove connectpaths();
        self.remove delete();
    }
    maxdamage = -6;
    if (isdefined(self.script_damage)) {
        maxdamage = self.script_damage;
    }
    var_266f778f = -6;
    if (isdefined(self.radius)) {
        var_266f778f = self.radius;
    }
    attacker = undefined;
    if (isdefined(self.damageowner)) {
        attacker = self.damageowner;
    }
    level.var_6572d801["time"] = gettime();
    level.var_6572d801["origin"] = self.origin + (0, 0, 30);
    self radiusdamage(self.origin + (0, 0, 30), var_266f778f, maxdamage, 1, attacker);
    if (randomint(2) == 0) {
        self setmodel("p7_zm_nac_barrel_explosive_red_dmg_01");
    } else {
        self setmodel("p7_zm_nac_barrel_explosive_red_dmg_02");
    }
    if (dot < 0.5) {
        start = self.origin + vectorscale(up, 22);
        pos = physicstrace(start, start + (0, 0, -64));
        self.origin = pos;
        self.angles += (0, 0, 90);
    }
    waittillframeend();
    level.var_bbaf8ae8 = 0;
}

// Namespace zm_prototype_barrels
// Params 0, eflags: 0x0
// Checksum 0xdb63dd25, Offset: 0xcf8
// Size: 0x9c
function function_248dcb17() {
    if (isdefined(self.target)) {
        targ = getent(self.target, "targetname");
        if (targ.classname == "script_brushmodel") {
            self.remove = targ;
            return;
        }
    }
    if (isdefined(self.remove)) {
        arrayremovevalue(level.var_7917c292, self.remove);
    }
}

// Namespace zm_prototype_barrels
// Params 0, eflags: 0x0
// Checksum 0xff61ec09, Offset: 0xda0
// Size: 0xec
function function_28ed3370() {
    var_e1c041e0 = getentarray("explodable_barrel", "targetname");
    var_53c7b11b = getentarray("explodable_barrel", "script_noteworthy");
    if (isdefined(var_e1c041e0)) {
        var_69238c0b = var_e1c041e0.size;
    }
    if (isdefined(var_53c7b11b)) {
        var_69238c0b += var_53c7b11b.size;
    }
    for (var_1d2242bc = 0; var_1d2242bc < var_69238c0b; var_1d2242bc++) {
        level waittill(#"hash_83cc4809");
    }
    level thread zm_audio::sndmusicsystem_playstate("undone");
}

