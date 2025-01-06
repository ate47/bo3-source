#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;

#namespace zm_tomb_tank;

// Namespace zm_tomb_tank
// Params 0, eflags: 0x0
// Checksum 0xecac75d, Offset: 0x2f8
// Size: 0xdc
function init() {
    clientfield::register("vehicle", "tank_tread_fx", 21000, 1, "int", &function_66e53adf, 0, 0);
    clientfield::register("vehicle", "tank_flamethrower_fx", 21000, 2, "int", &function_de8b2ce1, 0, 0);
    clientfield::register("vehicle", "tank_cooldown_fx", 21000, 2, "int", &function_5bc757af, 0, 0);
}

// Namespace zm_tomb_tank
// Params 7, eflags: 0x0
// Checksum 0xe4d3786, Offset: 0x3e0
// Size: 0xca
function function_66e53adf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == oldval) {
        return;
    }
    if (newval == 1) {
        println("<dev string:x28>");
        self thread function_b809a3fd(localclientnum);
        return;
    }
    if (newval == 0) {
        println("<dev string:x41>");
        self notify(#"hash_51963593");
    }
}

// Namespace zm_tomb_tank
// Params 2, eflags: 0x0
// Checksum 0x78a6116c, Offset: 0x4b8
// Size: 0x148
function function_fec9fe59(localclientnum, str_tag) {
    self endon(#"hash_53f5220a");
    sndorigin = self gettagorigin(str_tag);
    sndent = spawn(0, sndorigin, "script_origin");
    sndent linkto(self, str_tag);
    sndent playsound(0, "zmb_tank_flame_start");
    sndent.var_9bdbad77 = sndent playloopsound("zmb_tank_flame_loop", 0.6);
    self thread function_a7df9920(sndent);
    while (true) {
        self.var_f53cfaa3 = playfxontag(localclientnum, level._effect["mech_wpn_flamethrower"], self, str_tag);
        wait 0.1;
    }
}

// Namespace zm_tomb_tank
// Params 1, eflags: 0x0
// Checksum 0x66d558c7, Offset: 0x608
// Size: 0x84
function function_a7df9920(ent) {
    self waittill(#"hash_53f5220a");
    ent playsound(0, "zmb_tank_flame_stop");
    ent stoploopsound(ent.var_9bdbad77, 0.25);
    wait 1;
    ent delete();
}

// Namespace zm_tomb_tank
// Params 7, eflags: 0x0
// Checksum 0x4d1ff73a, Offset: 0x698
// Size: 0x114
function function_de8b2ce1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self notify(#"hash_53f5220a");
    if (!isdefined(self.var_1be9b23)) {
        self.var_1be9b23 = spawn(0, (0, 0, 0), "script_origin");
    }
    if (newval == 0) {
        return;
    }
    str_tag = "tag_flash";
    switch (newval) {
    case 2:
        str_tag = "tag_flash_gunner1";
        break;
    case 3:
        str_tag = "tag_flash_gunner2";
        break;
    default:
        break;
    }
    self thread function_fec9fe59(localclientnum, str_tag);
}

// Namespace zm_tomb_tank
// Params 2, eflags: 0x0
// Checksum 0xe2aa29c5, Offset: 0x7b8
// Size: 0xf0
function function_a2fe7f71(localclientnum, var_2bc319f0) {
    self notify(#"hash_ab268b3b");
    self endon(#"entityshutdown");
    self endon(#"hash_ab268b3b");
    fx_id = level._effect["tank_exhaust"];
    if (var_2bc319f0) {
        fx_id = level._effect["tank_overheat"];
    }
    if (var_2bc319f0) {
        self thread function_341f7b4c(self.origin);
    } else {
        self thread function_64744406();
    }
    while (true) {
        playfxontag(localclientnum, fx_id, self, "tag_origin");
        wait 0.1;
    }
}

// Namespace zm_tomb_tank
// Params 1, eflags: 0x0
// Checksum 0x545f15e8, Offset: 0x8b0
// Size: 0x54
function function_341f7b4c(origin) {
    audio::playloopat("zmb_bot_timeout_steam", origin);
    self waittill(#"hash_ab268b3b");
    audio::stoploopat("zmb_bot_timeout_steam", origin);
}

// Namespace zm_tomb_tank
// Params 0, eflags: 0x0
// Checksum 0x71e4d048, Offset: 0x910
// Size: 0x17c
function function_64744406() {
    origin1 = self gettagorigin("tag_exhaust_1");
    ent1 = spawn(0, origin1, "script_origin");
    ent1 linkto(self, "tag_exhaust_1");
    origin2 = self gettagorigin("tag_exhaust_2");
    ent2 = spawn(0, origin2, "script_origin");
    ent2 linkto(self, "tag_exhaust_2");
    ent1 playloopsound("zmb_tank_exhaust_pipe", 1);
    ent2 playloopsound("zmb_tank_exhaust_pipe", 1);
    self waittill(#"hash_ab268b3b");
    ent1 delete();
    ent2 delete();
}

// Namespace zm_tomb_tank
// Params 7, eflags: 0x0
// Checksum 0x3f97db39, Offset: 0xa98
// Size: 0x206
function function_5bc757af(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self notify(#"hash_ab268b3b");
    if (isdefined(self.var_d168dad5)) {
        stopfx(localclientnum, self.var_d168dad5);
        self.var_d168dad5 = undefined;
    }
    if (isdefined(self.var_f76b553e)) {
        stopfx(localclientnum, self.var_f76b553e);
        self.var_f76b553e = undefined;
    }
    switch (newval) {
    case 1:
        self thread function_a2fe7f71(localclientnum, 1);
        self.var_d168dad5 = playfxontag(localclientnum, level._effect["tank_light_red"], self, "tag_light_left");
        self.var_f76b553e = playfxontag(localclientnum, level._effect["tank_light_red"], self, "tag_light_right");
        break;
    case 2:
        self.var_d168dad5 = playfxontag(localclientnum, level._effect["tank_light_grn"], self, "tag_light_left");
        self.var_f76b553e = playfxontag(localclientnum, level._effect["tank_light_grn"], self, "tag_light_right");
        break;
    case 0:
        self thread function_a2fe7f71(localclientnum, 0);
        break;
    }
}

// Namespace zm_tomb_tank
// Params 1, eflags: 0x0
// Checksum 0x9b0ed436, Offset: 0xca8
// Size: 0xb0
function function_b809a3fd(localclientnum) {
    self endon(#"hash_51963593");
    self thread function_85886bc2();
    while (true) {
        self.var_f39aab64 = playfxontag(localclientnum, level._effect["tank_treads"], self, "tag_wheel_back_left");
        self.var_50198d5b = playfxontag(localclientnum, level._effect["tank_treads"], self, "tag_wheel_back_right");
        wait 0.5;
    }
}

// Namespace zm_tomb_tank
// Params 0, eflags: 0x0
// Checksum 0xd6ea0071, Offset: 0xd60
// Size: 0x17c
function function_85886bc2() {
    origin3 = self gettagorigin("tag_wheel_back_left");
    ent3 = spawn(0, origin3, "script_origin");
    ent3 linkto(self, "tag_wheel_back_left");
    origin4 = self gettagorigin("tag_wheel_back_right");
    ent4 = spawn(0, origin4, "script_origin");
    ent4 linkto(self, "tag_wheel_back_right");
    ent3 playloopsound("zmb_tank_mud_tread", 1);
    ent4 playloopsound("zmb_tank_mud_tread", 1);
    self waittill(#"hash_51963593");
    ent3 delete();
    ent4 delete();
}

