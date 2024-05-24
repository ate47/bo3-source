#using scripts/shared/callbacks_shared;
#using scripts/zm/_callbacks;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/vehicles/_dragon_whelp;

#namespace namespace_2ef08cd1;

// Namespace namespace_2ef08cd1
// Params 0, eflags: 0x2
// Checksum 0x4388266d, Offset: 0x4f8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_dragon_gauntlet", &__init__, undefined, undefined);
}

// Namespace namespace_2ef08cd1
// Params 0, eflags: 0x0
// Checksum 0x14b25167, Offset: 0x538
// Size: 0x24
function __init__() {
    callback::on_localplayer_spawned(&player_on_spawned);
}

// Namespace namespace_2ef08cd1
// Params 1, eflags: 0x0
// Checksum 0x79cc3a39, Offset: 0x568
// Size: 0x24
function player_on_spawned(localclientnum) {
    self thread watch_weapon_changes(localclientnum);
}

// Namespace namespace_2ef08cd1
// Params 1, eflags: 0x0
// Checksum 0xceb2ebf0, Offset: 0x598
// Size: 0x18e
function watch_weapon_changes(localclientnum) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    self.var_eb91e4f9 = getweapon("dragon_gauntlet_flamethrower");
    self.var_dd5c3be0 = getweapon("dragon_gauntlet");
    while (isdefined(self)) {
        weapon = self waittill(#"weapon_change");
        if (weapon === self.var_eb91e4f9) {
            self thread function_7645efdb(localclientnum);
            self thread function_6c7c9327(localclientnum);
            self notify(#"hash_7c243ce8");
        }
        if (weapon === self.var_dd5c3be0) {
            self thread function_99aba1a5(localclientnum);
            self thread function_a8ac2d1d(localclientnum);
            self thread function_3011ccf6(localclientnum);
        }
        if (weapon !== self.var_eb91e4f9 && weapon !== self.var_dd5c3be0) {
            self function_99aba1a5(localclientnum);
            self function_7645efdb(localclientnum);
            self notify(#"hash_7c243ce8");
        }
    }
}

// Namespace namespace_2ef08cd1
// Params 1, eflags: 0x0
// Checksum 0x7052a51b, Offset: 0x730
// Size: 0x16e
function function_6c7c9327(localclientnum) {
    self endon(#"disconnect");
    self util::waittill_any_timeout(0.5, "weapon_change_complete", "disconnect");
    if (getcurrentweapon(localclientnum) === getweapon("dragon_gauntlet_flamethrower")) {
        if (!isdefined(self.var_11d5152b)) {
            self.var_11d5152b = [];
        }
        self.var_11d5152b[self.var_11d5152b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_orange_glow1", "tag_fx_7");
        self.var_11d5152b[self.var_11d5152b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_orange_glow2", "tag_fx_6");
        self.var_11d5152b[self.var_11d5152b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_whelp_eye_glow_sm", "tag_eye_left_fx");
        self.var_11d5152b[self.var_11d5152b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_whelp_mouth_drips_sm", "tag_throat_fx");
    }
}

// Namespace namespace_2ef08cd1
// Params 1, eflags: 0x0
// Checksum 0x14c08406, Offset: 0x8a8
// Size: 0x2be
function function_a8ac2d1d(localclientnum) {
    self endon(#"disconnect");
    self util::waittill_any_timeout(0.5, "weapon_change_complete", "disconnect");
    if (getcurrentweapon(localclientnum) === getweapon("dragon_gauntlet")) {
        if (!isdefined(self.var_a7abd31)) {
            self.var_a7abd31 = [];
        }
        self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow1", "tag_fx_7");
        self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow2", "tag_fx_6");
        self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow_finger2", "tag_fx_1");
        self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow_finger", "tag_fx_2");
        self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow_finger", "tag_fx_3");
        self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow_finger", "tag_fx_4");
        self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_tube", "tag_gauntlet_tube_01");
        self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_tube", "tag_gauntlet_tube_02");
        self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_tube", "tag_gauntlet_tube_03");
        self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_tube", "tag_gauntlet_tube_04");
    }
}

// Namespace namespace_2ef08cd1
// Params 1, eflags: 0x0
// Checksum 0x1485465f, Offset: 0xb70
// Size: 0xb2
function function_99aba1a5(localclientnum) {
    if (isdefined(self.var_11d5152b) && self.var_11d5152b.size > 0) {
        foreach (fx in self.var_11d5152b) {
            stopfx(localclientnum, fx);
        }
    }
}

// Namespace namespace_2ef08cd1
// Params 1, eflags: 0x0
// Checksum 0x6cbd7e65, Offset: 0xc30
// Size: 0xb2
function function_7645efdb(localclientnum) {
    if (isdefined(self.var_a7abd31) && self.var_a7abd31.size > 0) {
        foreach (fx in self.var_a7abd31) {
            stopfx(localclientnum, fx);
        }
    }
}

// Namespace namespace_2ef08cd1
// Params 1, eflags: 0x0
// Checksum 0xbb81351a, Offset: 0xcf0
// Size: 0x31e
function function_3011ccf6(localclientnum) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"bled_out");
    self endon(#"hash_7c243ce8");
    self notify(#"hash_8d98e9db");
    self endon(#"hash_8d98e9db");
    while (isdefined(self)) {
        note = self waittill(#"notetrack");
        if (note === "dragon_gauntlet_115_punch_fx_start") {
            if (!isdefined(self.var_4d73e75b)) {
                self.var_4d73e75b = [];
            }
            self.var_4d73e75b[self.var_4d73e75b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow_finger3", "tag_fx_1");
            self.var_4d73e75b[self.var_4d73e75b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow_finger3", "tag_fx_2");
            self.var_4d73e75b[self.var_4d73e75b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow_finger3", "tag_fx_3");
            self.var_4d73e75b[self.var_4d73e75b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow_finger3", "tag_fx_4");
            self.var_4d73e75b[self.var_4d73e75b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_tube2", "tag_gauntlet_tube_01");
            self.var_4d73e75b[self.var_4d73e75b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_tube2", "tag_gauntlet_tube_02");
            self.var_4d73e75b[self.var_4d73e75b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_tube2", "tag_gauntlet_tube_03");
            self.var_4d73e75b[self.var_4d73e75b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_tube2", "tag_gauntlet_tube_04");
        }
        if (note === "dragon_gauntlet_115_punch_fx_stop") {
            if (isdefined(self.var_4d73e75b) && self.var_4d73e75b.size > 0) {
                foreach (fx in self.var_4d73e75b) {
                    stopfx(localclientnum, fx);
                }
            }
        }
    }
}

