#using scripts/cp/gametypes/_globallogic_player;
#using scripts/shared/util_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/codescripts/struct;

#namespace burnplayer;

// Namespace burnplayer
// Params 0, eflags: 0x0
// Checksum 0xdb1a9ec1, Offset: 0x290
// Size: 0x20
function function_2068a2e3() {
    level.var_97bb6c9d = 15;
    level.var_2fac5686 = 1.5;
}

// Namespace burnplayer
// Params 3, eflags: 0x0
// Checksum 0xc392822c, Offset: 0x2b8
// Size: 0x384
function function_df1eee42(attacker, inflictor, mod) {
    if (isdefined(self.burning)) {
        return;
    }
    self thread function_1824cc36(level.var_2fac5686);
    self endon(#"disconnect");
    attacker endon(#"disconnect");
    waittillframeend();
    self.burning = 1;
    self thread function_f8ca07a9();
    tagarray = [];
    if (isai(self)) {
        tagarray[tagarray.size] = "J_Wrist_RI";
        tagarray[tagarray.size] = "J_Wrist_LE";
        tagarray[tagarray.size] = "J_Elbow_LE";
        tagarray[tagarray.size] = "J_Elbow_RI";
        tagarray[tagarray.size] = "J_Knee_RI";
        tagarray[tagarray.size] = "J_Knee_LE";
        tagarray[tagarray.size] = "J_Ankle_RI";
        tagarray[tagarray.size] = "J_Ankle_LE";
    } else {
        tagarray[tagarray.size] = "J_Wrist_RI";
        tagarray[tagarray.size] = "J_Wrist_LE";
        tagarray[tagarray.size] = "J_Elbow_LE";
        tagarray[tagarray.size] = "J_Elbow_RI";
        tagarray[tagarray.size] = "J_Knee_RI";
        tagarray[tagarray.size] = "J_Knee_LE";
        tagarray[tagarray.size] = "J_Ankle_RI";
        tagarray[tagarray.size] = "J_Ankle_LE";
        if (isplayer(self) && self.health > 0) {
            self setburn(3);
        }
    }
    if (isdefined(level._effect["character_fire_death_torso"])) {
        for (arrayindex = 0; arrayindex < tagarray.size; arrayindex++) {
            playfxontag(level._effect["character_fire_death_sm"], self, tagarray[arrayindex]);
        }
    }
    if (isai(self)) {
        playfxontag(level._effect["character_fire_death_torso"], self, "J_Spine1");
    } else {
        playfxontag(level._effect["character_fire_death_torso"], self, "J_SpineLower");
    }
    if (!isalive(self)) {
        return;
    }
    if (isplayer(self)) {
        self thread watchforwater(7);
        self thread watchfordeath();
    }
}

// Namespace burnplayer
// Params 3, eflags: 0x0
// Checksum 0x78dfafc5, Offset: 0x648
// Size: 0x3bc
function function_823d8381(attacker, inflictor, mod) {
    if (isdefined(self.burning) || self hasperk("specialty_fireproof")) {
        return;
    }
    self thread function_1824cc36(level.var_2fac5686);
    self endon(#"disconnect");
    attacker endon(#"disconnect");
    self endon(#"death");
    if (isdefined(self.burning)) {
        return;
    }
    self thread function_f8ca07a9();
    waittillframeend();
    self.burning = 1;
    self thread function_f8ca07a9();
    tagarray = [];
    if (isai(self)) {
        tagarray[tagarray.size] = "J_Wrist_RI";
        tagarray[tagarray.size] = "J_Wrist_LE";
        tagarray[tagarray.size] = "J_Elbow_LE";
        tagarray[tagarray.size] = "J_Elbow_RI";
        tagarray[tagarray.size] = "J_Knee_RI";
        tagarray[tagarray.size] = "J_Knee_LE";
        tagarray[tagarray.size] = "J_Ankle_RI";
        tagarray[tagarray.size] = "J_Ankle_LE";
    } else {
        tagarray[tagarray.size] = "J_Wrist_RI";
        tagarray[tagarray.size] = "J_Wrist_LE";
        tagarray[tagarray.size] = "J_Elbow_LE";
        tagarray[tagarray.size] = "J_Elbow_RI";
        tagarray[tagarray.size] = "J_Knee_RI";
        tagarray[tagarray.size] = "J_Knee_LE";
        tagarray[tagarray.size] = "J_Ankle_RI";
        tagarray[tagarray.size] = "J_Ankle_LE";
        if (isplayer(self)) {
            self setburn(3);
        }
    }
    if (isdefined(level._effect["character_fire_death_sm"])) {
        for (arrayindex = 0; arrayindex < tagarray.size; arrayindex++) {
            playfxontag(level._effect["character_fire_death_sm"], self, tagarray[arrayindex]);
        }
    }
    if (isdefined(level._effect["character_fire_death_torso"])) {
        playfxontag(level._effect["character_fire_death_torso"], self, "J_SpineLower");
    }
    if (!isalive(self)) {
        return;
    }
    self thread function_aec07428(attacker, inflictor, mod);
    if (isplayer(self)) {
        self thread watchforwater(7);
        self thread watchfordeath();
    }
}

// Namespace burnplayer
// Params 3, eflags: 0x0
// Checksum 0x71486487, Offset: 0xa10
// Size: 0x2b4
function function_fcb64b8(attacker, inflictor, weapon) {
    if (isdefined(self.burning) || self hasperk("specialty_fireproof")) {
        return;
    }
    self thread function_1824cc36(level.var_2fac5686);
    self endon(#"disconnect");
    waittillframeend();
    self.burning = 1;
    self thread function_f8ca07a9();
    tagarray = [];
    if (isai(self)) {
        tagarray[tagarray.size] = "J_Wrist_RI";
        tagarray[tagarray.size] = "J_Wrist_LE";
        tagarray[tagarray.size] = "J_Elbow_LE";
        tagarray[tagarray.size] = "J_Elbow_RI";
        tagarray[tagarray.size] = "J_Knee_RI";
        tagarray[tagarray.size] = "J_Knee_LE";
        tagarray[tagarray.size] = "J_Ankle_RI";
        tagarray[tagarray.size] = "J_Ankle_LE";
    } else {
        tagarray[tagarray.size] = "J_Knee_RI";
        tagarray[tagarray.size] = "J_Knee_LE";
        tagarray[tagarray.size] = "J_Ankle_RI";
        tagarray[tagarray.size] = "J_Ankle_LE";
    }
    if (isdefined(level._effect["character_fire_player_sm"])) {
        for (arrayindex = 0; arrayindex < tagarray.size; arrayindex++) {
            playfxontag(level._effect["character_fire_player_sm"], self, tagarray[arrayindex]);
        }
    }
    if (!isalive(self)) {
        return;
    }
    self thread function_72d46630(attacker, inflictor, weapon, 1);
    if (isplayer(self)) {
        self thread watchforwater(7);
        self thread watchfordeath();
    }
}

// Namespace burnplayer
// Params 3, eflags: 0x0
// Checksum 0xfde233a6, Offset: 0xcd0
// Size: 0x266
function function_c4881b4f(attacker, inflictor, weapon) {
    if (isdefined(self.burning)) {
        return;
    }
    self thread function_1824cc36(level.var_2fac5686);
    self endon(#"disconnect");
    waittillframeend();
    self.burning = 1;
    self thread function_f8ca07a9();
    tagarray = [];
    if (isai(self)) {
        tagarray[0] = "J_Spine1";
        tagarray[1] = "J_Elbow_LE";
        tagarray[2] = "J_Elbow_RI";
        tagarray[3] = "J_Head";
        tagarray[4] = "j_knee_ri";
        tagarray[5] = "j_knee_le";
    } else {
        tagarray[0] = "J_Elbow_RI";
        tagarray[1] = "j_knee_ri";
        tagarray[2] = "j_knee_le";
        if (isplayer(self) && self.health > 0) {
            self setburn(3);
        }
    }
    if (isplayer(self) && isalive(self)) {
        self thread watchforwater(7);
        self thread watchfordeath();
    }
    if (isdefined(level._effect["character_fire_player_sm"])) {
        for (arrayindex = 0; arrayindex < tagarray.size; arrayindex++) {
            playfxontag(level._effect["character_fire_player_sm"], self, tagarray[arrayindex]);
        }
    }
}

// Namespace burnplayer
// Params 3, eflags: 0x0
// Checksum 0xb18b1795, Offset: 0xf40
// Size: 0x276
function function_52491159(attacker, inflictor, weapon) {
    if (isdefined(self.burning)) {
        return;
    }
    self thread function_1824cc36(level.var_2fac5686);
    self endon(#"disconnect");
    waittillframeend();
    self.burning = 1;
    self thread function_f8ca07a9();
    tagarray = [];
    if (isai(self)) {
        tagarray[0] = "J_Spine1";
        tagarray[1] = "J_Elbow_LE";
        tagarray[2] = "J_Elbow_RI";
        tagarray[3] = "J_Head";
        tagarray[4] = "j_knee_ri";
        tagarray[5] = "j_knee_le";
    } else {
        tagarray[0] = "j_spinelower";
        tagarray[1] = "J_Elbow_RI";
        tagarray[2] = "j_knee_ri";
        tagarray[3] = "j_knee_le";
        if (isplayer(self) && self.health > 0) {
            self setburn(3);
        }
    }
    if (isplayer(self) && isalive(self)) {
        self thread watchforwater(7);
        self thread watchfordeath();
        return;
    }
    if (isdefined(level._effect["character_fire_player_sm"])) {
        for (arrayindex = 0; arrayindex < tagarray.size; arrayindex++) {
            playfxontag(level._effect["character_fire_player_sm"], self, tagarray[arrayindex]);
        }
    }
}

// Namespace burnplayer
// Params 0, eflags: 0x0
// Checksum 0x331c2cbf, Offset: 0x11c0
// Size: 0x5c
function function_30e7e350() {
    self.burning = 1;
    self thread function_f8ca07a9();
    self thread function_de3344dc();
    self thread function_1824cc36(level.var_2fac5686);
}

// Namespace burnplayer
// Params 0, eflags: 0x0
// Checksum 0x550702d5, Offset: 0x1228
// Size: 0x6e
function watchfordeath() {
    self endon(#"disconnect");
    self notify(#"hash_abaf0a23");
    self endon(#"hash_abaf0a23");
    self waittill(#"death");
    if (isplayer(self)) {
        self function_78f01691();
    }
    self.burning = undefined;
}

// Namespace burnplayer
// Params 1, eflags: 0x0
// Checksum 0xbff4f6f2, Offset: 0x12a0
// Size: 0xa8
function watchforwater(time) {
    self endon(#"disconnect");
    self notify(#"hash_bbb80fa");
    self endon(#"hash_bbb80fa");
    wait(0.1);
    looptime = 0.1;
    while (time > 0) {
        wait(looptime);
        if (self depthofplayerinwater() > 0) {
            function_2b4f1bd8();
            time = 0;
        }
        time -= looptime;
    }
}

// Namespace burnplayer
// Params 0, eflags: 0x0
// Checksum 0xb82d27e4, Offset: 0x1350
// Size: 0x120
function function_2b4f1bd8() {
    self notify(#"hash_3e41273b");
    tagarray = [];
    tagarray[0] = "j_spinelower";
    tagarray[1] = "J_Elbow_RI";
    tagarray[2] = "J_Head";
    tagarray[3] = "j_knee_ri";
    tagarray[4] = "j_knee_le";
    if (isdefined(level._effect["fx_fire_player_sm_smk_2sec"])) {
        for (arrayindex = 0; arrayindex < tagarray.size; arrayindex++) {
            playfxontag(level._effect["fx_fire_player_sm_smk_2sec"], self, tagarray[arrayindex]);
        }
    }
    self.burning = undefined;
    self function_78f01691();
    self.ingroundnapalm = 0;
}

// Namespace burnplayer
// Params 3, eflags: 0x0
// Checksum 0x6ed45aa1, Offset: 0x1478
// Size: 0x116
function function_aec07428(attacker, inflictor, mod) {
    if (isai(self)) {
        function_fa572a1e(attacker, inflictor, mod);
        return;
    }
    self endon(#"death");
    self endon(#"disconnect");
    attacker endon(#"disconnect");
    self endon(#"hash_3e41273b");
    while (isdefined(level.var_f808fd37) && isdefined(self) && self depthofplayerinwater() < 1) {
        self dodamage(level.var_f808fd37, self.origin, attacker, attacker, "none", mod, 0, getweapon("napalm"));
        wait(1);
    }
}

// Namespace burnplayer
// Params 3, eflags: 0x0
// Checksum 0x4ffec7e6, Offset: 0x1598
// Size: 0x308
function function_214dd4fb(attacker, inflictor, mod) {
    if (self hasperk("specialty_fireproof")) {
        return;
    }
    if (level.teambased) {
        if (attacker != self && attacker.team == self.team) {
            return;
        }
    }
    if (isai(self)) {
        function_425abcad(attacker, inflictor, mod);
        return;
    }
    if (isdefined(self.burning)) {
        return;
    }
    self thread function_f8ca07a9();
    self endon(#"death");
    self endon(#"disconnect");
    attacker endon(#"disconnect");
    self endon(#"hash_3e41273b");
    if (isdefined(level.var_5ad2ed74)) {
        if (getdvarstring("scr_groundBurnTime") == "") {
            waittime = level.var_5ad2ed74;
        } else {
            waittime = getdvarfloat("scr_groundBurnTime");
        }
    } else {
        waittime = 100;
    }
    self function_fcb64b8(attacker, inflictor, getweapon("napalm"));
    self.ingroundnapalm = 1;
    if (isdefined(level.var_a10a574c)) {
        if (getdvarstring("scr_napalmGroundDamage") == "") {
            var_a10a574c = level.var_a10a574c;
        } else {
            var_a10a574c = getdvarfloat("scr_napalmGroundDamage");
        }
        while (isdefined(self) && isdefined(inflictor) && self depthofplayerinwater() < 1 && waittime > 0) {
            self dodamage(level.var_a10a574c, self.origin, attacker, inflictor, "none", mod, 0, getweapon("napalm"));
            if (isplayer(self)) {
                self setburn(1.1);
            }
            wait(1);
            waittime -= 1;
        }
    }
    self.ingroundnapalm = 0;
}

// Namespace burnplayer
// Params 3, eflags: 0x0
// Checksum 0xdc0e1d40, Offset: 0x18a8
// Size: 0x96
function function_fa572a1e(attacker, inflictor, mod) {
    attacker endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_3e41273b");
    while (isdefined(level.var_f808fd37) && isdefined(self)) {
        self dodamage(level.var_f808fd37, self.origin, attacker, attacker, "none", mod);
        wait(1);
    }
}

// Namespace burnplayer
// Params 3, eflags: 0x0
// Checksum 0x3502b22d, Offset: 0x1948
// Size: 0xae
function function_425abcad(attacker, inflictor, mod) {
    attacker endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_3e41273b");
    while (isdefined(level.var_a10a574c) && isdefined(self)) {
        self dodamage(level.var_a10a574c, self.origin, attacker, attacker, "none", mod, 0, getweapon("napalm"));
        wait(1);
    }
}

// Namespace burnplayer
// Params 0, eflags: 0x0
// Checksum 0xdf5ba65e, Offset: 0x1a00
// Size: 0x2a
function function_f8ca07a9() {
    self endon(#"disconnect");
    self endon(#"death");
    wait(3);
    self.burning = undefined;
}

// Namespace burnplayer
// Params 4, eflags: 0x0
// Checksum 0x6603a47, Offset: 0x1a38
// Size: 0x204
function function_72d46630(attacker, inflictor, weapon, time) {
    if (isai(self)) {
        function_65e5cf8e(attacker, inflictor, weapon, time);
        return;
    }
    if (isdefined(attacker)) {
        attacker endon(#"disconnect");
    }
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_3e41273b");
    self thread function_de3344dc();
    self notify(#"hash_2f723e7e");
    wait_time = 1;
    while (isdefined(level.var_97bb6c9d) && isdefined(self) && self depthofplayerinwater() < 1 && time > 0) {
        if (isdefined(attacker) && isdefined(inflictor) && isdefined(weapon)) {
            if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                attacker damagefeedback::update();
            }
            self dodamage(level.var_97bb6c9d, self.origin, attacker, inflictor, "none", "MOD_BURNED", 0, weapon);
        } else {
            self dodamage(level.var_97bb6c9d, self.origin);
        }
        wait(wait_time);
        time -= wait_time;
    }
    self thread function_2b4f1bd8();
}

// Namespace burnplayer
// Params 4, eflags: 0x0
// Checksum 0x5e4b1cb, Offset: 0x1c48
// Size: 0x116
function function_65e5cf8e(attacker, inflictor, weapon, time) {
    if (!isdefined(attacker) || !isdefined(inflictor) || !isdefined(weapon)) {
        return;
    }
    attacker endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_3e41273b");
    self thread function_de3344dc();
    wait_time = 1;
    while (isdefined(level.var_97bb6c9d) && isdefined(self) && time > 0) {
        self dodamage(level.var_97bb6c9d, self.origin, attacker, inflictor, "none", "MOD_BURNED", 0, weapon);
        wait(wait_time);
        time -= wait_time;
    }
}

// Namespace burnplayer
// Params 1, eflags: 0x0
// Checksum 0x991e2e71, Offset: 0x1d68
// Size: 0x3c
function function_1824cc36(time) {
    self endon(#"disconnect");
    self endon(#"death");
    wait(time);
    self function_78f01691();
}

// Namespace burnplayer
// Params 0, eflags: 0x0
// Checksum 0xb0b2142f, Offset: 0x1db0
// Size: 0x124
function function_de3344dc() {
    self endon(#"disconnect");
    self endon(#"death");
    var_291ac48b = spawn("script_origin", self.origin);
    var_291ac48b linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_291ac48b playloopsound("mpl_player_burn_loop");
    self thread function_40125168(var_291ac48b);
    self waittill(#"hash_dfb19617");
    if (isdefined(var_291ac48b)) {
        var_291ac48b stoploopsound(0.5);
    }
    wait(0.5);
    if (isdefined(var_291ac48b)) {
        var_291ac48b delete();
    }
    /#
        println("<unknown string>");
    #/
}

// Namespace burnplayer
// Params 0, eflags: 0x0
// Checksum 0x7a6cf2fc, Offset: 0x1ee0
// Size: 0x1a
function function_78f01691() {
    self endon(#"disconnect");
    self notify(#"hash_dfb19617");
}

// Namespace burnplayer
// Params 1, eflags: 0x0
// Checksum 0xa85c6b1d, Offset: 0x1f08
// Size: 0x74
function function_40125168(ent) {
    ent endon(#"death");
    self util::waittill_any("death", "disconnect");
    ent delete();
    /#
        println("<unknown string>");
    #/
}

