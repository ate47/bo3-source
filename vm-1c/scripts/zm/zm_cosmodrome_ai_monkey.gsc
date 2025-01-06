#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_ai_monkey;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;

#namespace zm_cosmodrome_ai_monkey;

// Namespace zm_cosmodrome_ai_monkey
// Params 0, eflags: 0x0
// Checksum 0x889d33bc, Offset: 0x1f8
// Size: 0x1c
function init() {
    level.var_7deb01db = &function_9ddb51fd;
}

// Namespace zm_cosmodrome_ai_monkey
// Params 0, eflags: 0x0
// Checksum 0x6e75e3ce, Offset: 0x220
// Size: 0x27c
function function_9ddb51fd() {
    self endon(#"death");
    end = self function_886be33d();
    var_34be73b6 = struct::get(end.target, "targetname");
    var_842a10b = var_34be73b6.origin + (0, 0, 2000);
    lander = spawn("script_model", var_842a10b);
    angles = vectortoangles(end.origin - var_842a10b);
    lander.angles = angles;
    lander setmodel("p7_fxanim_zm_asc_lander_crash_mod");
    lander hide();
    lander thread function_1c5d6c69();
    self hide();
    util::wait_network_frame();
    lander clientfield::set("COSMO_MONKEY_LANDER_FX", 1);
    self forceteleport(lander.origin);
    self linkto(lander);
    wait 2.5;
    lander show();
    lander moveto(end.origin, 0.6);
    lander waittill(#"movedone");
    lander clientfield::set("COSMO_MONKEY_LANDER_FX", 0);
    wait 2;
    self unlink();
    self show();
}

// Namespace zm_cosmodrome_ai_monkey
// Params 0, eflags: 0x0
// Checksum 0x9ce6af15, Offset: 0x4a8
// Size: 0x4c
function function_1c5d6c69() {
    wait 8;
    self movez(-100, 0.5);
    self waittill(#"movedone");
    self delete();
}

// Namespace zm_cosmodrome_ai_monkey
// Params 0, eflags: 0x0
// Checksum 0xb076b3ad, Offset: 0x500
// Size: 0x1d2
function function_886be33d() {
    if (!isdefined(level.var_3ce9ca5f)) {
        level.var_3ce9ca5f = [];
    }
    if (!isdefined(level.var_3ce9ca5f[self.script_noteworthy])) {
        level.var_3ce9ca5f[self.script_noteworthy] = [];
        var_c7fba7d2 = struct::get_array("monkey_land", "targetname");
        for (i = 0; i < var_c7fba7d2.size; i++) {
            if (self.script_noteworthy == var_c7fba7d2[i].script_noteworthy) {
                level.var_3ce9ca5f[self.script_noteworthy][level.var_3ce9ca5f[self.script_noteworthy].size] = var_c7fba7d2[i];
            }
        }
    }
    choice = level.var_3ce9ca5f[self.script_noteworthy][0];
    max_dist = 1410065408;
    for (i = 0; i < level.var_3ce9ca5f[self.script_noteworthy].size; i++) {
        dist = distance2d(self.origin, level.var_3ce9ca5f[self.script_noteworthy][i].origin);
        if (dist < max_dist) {
            max_dist = dist;
            choice = level.var_3ce9ca5f[self.script_noteworthy][i];
        }
    }
    return choice;
}

// Namespace zm_cosmodrome_ai_monkey
// Params 0, eflags: 0x0
// Checksum 0x95d900d3, Offset: 0x6e0
// Size: 0x1c
function function_3cc4d318() {
    self.var_4bd2ae84 = &function_bf828621;
}

// Namespace zm_cosmodrome_ai_monkey
// Params 0, eflags: 0x0
// Checksum 0xc9abffa7, Offset: 0x708
// Size: 0xa4
function function_f5562f17() {
    self endon(#"death");
    while (true) {
        if (self.state != "bhb_jump") {
            if (!zm_utility::check_point_in_playable_area(self.origin)) {
                break;
            }
        }
        wait 1;
    }
    assertmsg("<dev string:x28>" + self.origin);
    self dodamage(self.health + 100, self.origin);
}

// Namespace zm_cosmodrome_ai_monkey
// Params 0, eflags: 0x0
// Checksum 0xd83ed238, Offset: 0x7b8
// Size: 0x6c
function function_bf828621() {
    self zombie_utility::reset_attack_spot();
    self thread zombie_utility::zombie_eye_glow_stop();
    level.monkey_death++;
    level.var_8757475e++;
    self namespace_8fb880d9::function_d5e87ee0();
    util::wait_network_frame();
}

