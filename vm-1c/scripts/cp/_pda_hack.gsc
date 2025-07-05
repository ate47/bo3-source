#using scripts/cp/_util;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _pda_hack;

// Namespace _pda_hack
// Method(s) 14 Total 14
class class_d86d3a6 {

    // Namespace namespace_d86d3a6
    // Params 0, eflags: 0x0
    // Checksum 0xefc64391, Offset: 0x1d0
    // Size: 0x80
    function constructor() {
        self.var_6ba6041f = 1;
        self.var_f6ed93ab = 0;
        self.var_4d9e1d20 = 0;
        self.var_63f3839a = 2;
        self.var_e9a4f350 = 72;
        self.var_b347a23 = -128;
        self.var_69e7c65d = &function_fd069dd4;
        self.var_724f1b05 = 0;
        self.m_str_team = "axis";
    }

    // Namespace namespace_d86d3a6
    // Params 0, eflags: 0x0
    // Checksum 0xf9b0c4b0, Offset: 0x258
    // Size: 0x14
    function destructor() {
        clean_up();
    }

    // Namespace namespace_d86d3a6
    // Params 0, eflags: 0x0
    // Checksum 0xa83bf92c, Offset: 0xf58
    // Size: 0x2c
    function clean_up() {
        if (isdefined(self.var_a2d77bbb)) {
            self.var_a2d77bbb delete();
        }
    }

    // Namespace namespace_d86d3a6
    // Params 4, eflags: 0x0
    // Checksum 0x6f1c2cfe, Offset: 0xde8
    // Size: 0x168
    function function_4336408f(v_origin, n_radius, n_height, str_hint) {
        assert(isdefined(v_origin), "<dev string:xb4>");
        assert(isdefined(n_radius), "<dev string:xe2>");
        assert(isdefined(n_height), "<dev string:x110>");
        e_trigger = spawn("trigger_radius", v_origin, 0, n_radius, n_height);
        e_trigger triggerignoreteam();
        e_trigger setvisibletoall();
        e_trigger setteamfortrigger("none");
        e_trigger setcursorhint("HINT_NOICON");
        if (isdefined(str_hint)) {
            e_trigger sethintstring(str_hint);
        }
        return e_trigger;
    }

    // Namespace namespace_d86d3a6
    // Params 1, eflags: 0x0
    // Checksum 0x6ab3a10c, Offset: 0xda0
    // Size: 0x3c
    function function_62faa634(var_cbc69bae) {
        self endon(#"hash_bd3246ef");
        self hud::updatebar(0.01, 1 / var_cbc69bae);
    }

    // Namespace namespace_d86d3a6
    // Params 0, eflags: 0x0
    // Checksum 0xe9339f6b, Offset: 0xd38
    // Size: 0x5c
    function function_f7d58490() {
        if (isdefined(self) && isdefined(self.var_246c72d1)) {
            self unlink();
            self.var_246c72d1 delete();
            self enableweapons();
        }
    }

    // Namespace namespace_d86d3a6
    // Params 1, eflags: 0x0
    // Checksum 0x521e01b5, Offset: 0xbb8
    // Size: 0x174
    function function_e1c61785(trigger) {
        var_3ac7dd05 = trigger.origin + vectornormalize(anglestoforward(trigger.angles)) * 50;
        var_7c5a58b9 = bullettrace(var_3ac7dd05, var_3ac7dd05 - (0, 0, 100), 0, undefined)["position"];
        var_921dacdc = (0, vectortoangles(vectorscale(anglestoforward(trigger.angles), -1))[1], 0);
        self.var_246c72d1 = spawn("script_origin", var_7c5a58b9);
        self.var_246c72d1.angles = var_921dacdc;
        self playerlinkto(self.var_246c72d1, undefined, 0, 0, 0, 0, 0);
        self disableweapons();
    }

    // Namespace namespace_d86d3a6
    // Params 0, eflags: 0x0
    // Checksum 0xd41b1db0, Offset: 0x658
    // Size: 0x558
    function function_341b7c41() {
        self endon(#"hash_fd069dd4");
        self endon(#"hash_76b803d9");
        self.var_a2d77bbb endon(#"death");
        self.var_4d9e1d20 = 1;
        self.var_a2d77bbb sethintstring("");
        self.var_a2d77bbb sethintlowpriority(1);
        while (true) {
            self.var_a2d77bbb waittill(#"trigger", e_triggerer);
            if (!self.var_6ba6041f) {
                continue;
            }
            if (!e_triggerer util::is_player_looking_at(self.var_a2d77bbb.origin, 0.75, 0)) {
                self.var_a2d77bbb sethintstring("");
                self.var_a2d77bbb sethintlowpriority(1);
                continue;
            }
            self.var_a2d77bbb sethintstring(self.var_82559c86);
            self.var_a2d77bbb sethintlowpriority(1);
            if (!e_triggerer usebuttonpressed()) {
                continue;
            }
            foreach (player in level.players) {
                if (player != e_triggerer) {
                    self.var_a2d77bbb sethintstringforplayer(player, "");
                }
            }
            level.primaryprogressbarx = 0;
            level.primaryprogressbary = 110;
            level.primaryprogressbarheight = 8;
            level.primaryprogressbarwidth = 120;
            level.var_f0aa5b7d = 280;
            e_triggerer function_e1c61785(self.var_a2d77bbb);
            wait 0.8;
            n_start_time = 0;
            var_319ed91d = self.var_63f3839a;
            if (self.var_724f1b05) {
                if (isdefined(level.var_fdfac3e5)) {
                    var_319ed91d *= level.var_fdfac3e5;
                }
            }
            var_ee46aab4 = self.var_e9a4f350 * self.var_e9a4f350;
            var_98d5021b = distance2dsquared(e_triggerer.origin, self.var_a2d77bbb.origin);
            if (var_98d5021b > var_ee46aab4) {
                var_ee46aab4 = var_98d5021b;
            }
            var_b01de8c7 = 1;
            while (n_start_time < var_319ed91d && e_triggerer usebuttonpressed() && var_98d5021b <= var_ee46aab4 && var_b01de8c7) {
                n_start_time += 0.05;
                if (!isdefined(self.var_3ac7294a)) {
                    self.var_3ac7294a = e_triggerer hud::createprimaryprogressbar();
                    self.var_3ac7294a thread function_62faa634(var_319ed91d);
                }
                wait 0.05;
                var_98d5021b = distance2dsquared(e_triggerer.origin, self.var_a2d77bbb.origin);
                var_af239af9 = e_triggerer util::is_player_looking_at(self.var_a2d77bbb.origin, 0.75, 0);
            }
            if (isdefined(self.var_3ac7294a)) {
                self.var_3ac7294a notify(#"hash_bd3246ef");
                self.var_3ac7294a hud::destroyelem();
            }
            e_triggerer function_f7d58490();
            if (n_start_time >= var_319ed91d) {
                if (self.var_724f1b05) {
                    if (!isdefined(level.var_fdfac3e5)) {
                        level.var_fdfac3e5 = 1;
                    }
                    level.var_fdfac3e5 += 0.2;
                }
                self thread [[ self.var_69e7c65d ]](e_triggerer);
            }
            while (e_triggerer usebuttonpressed()) {
                wait 0.1;
            }
        }
    }

    // Namespace namespace_d86d3a6
    // Params 0, eflags: 0x0
    // Checksum 0x7a93950c, Offset: 0x640
    // Size: 0x10
    function function_ce55f4fa() {
        self waittill(#"hash_fd069dd4");
    }

    // Namespace namespace_d86d3a6
    // Params 1, eflags: 0x0
    // Checksum 0x3c8995ca, Offset: 0x580
    // Size: 0xb8
    function function_fd069dd4(e_triggerer) {
        self notify(#"hash_fd069dd4");
        self.m_str_team = "allies";
        self.var_a2d77bbb sethintstring("");
        self.var_a2d77bbb sethintlowpriority(1);
        if (isdefined(self.var_95115064)) {
            var_5152e048 = self.var_95115064;
        } else {
            var_5152e048 = self;
        }
        if (isdefined(self.var_1fa07047)) {
            var_5152e048 [[ self.var_1fa07047 ]]();
        }
    }

    // Namespace namespace_d86d3a6
    // Params 0, eflags: 0x0
    // Checksum 0xe5fd5d41, Offset: 0x510
    // Size: 0x68
    function disable_hacking() {
        if (self.var_f6ed93ab) {
            self notify(#"hash_76b803d9");
            self.var_a2d77bbb sethintstring("");
            self.var_a2d77bbb sethintlowpriority(1);
            self.var_4d9e1d20 = 0;
        }
    }

    // Namespace namespace_d86d3a6
    // Params 0, eflags: 0x0
    // Checksum 0x198d3c44, Offset: 0x438
    // Size: 0xcc
    function enable_hacking() {
        if (self.var_f6ed93ab) {
            if (self.m_str_team != "allies") {
                self.var_a2d77bbb sethintstring(self.var_82559c86);
                self.var_a2d77bbb sethintlowpriority(1);
                if (!self.var_4d9e1d20) {
                    self thread function_341b7c41();
                }
                return;
            }
            self.var_a2d77bbb sethintstring("");
            self.var_a2d77bbb sethintlowpriority(1);
        }
    }

    // Namespace namespace_d86d3a6
    // Params 1, eflags: 0x0
    // Checksum 0x4dd10459, Offset: 0x418
    // Size: 0x18
    function function_57511b5b(n_time) {
        self.var_63f3839a = n_time;
    }

    // Namespace namespace_d86d3a6
    // Params 5, eflags: 0x0
    // Checksum 0xdf0f4703, Offset: 0x278
    // Size: 0x194
    function function_808cd5de(v_origin, str_hint_string, v_angles, var_a65e7c1a, var_5152e048) {
        assert(isdefined(v_origin), "<dev string:x28>");
        if (!isdefined(v_angles)) {
            v_angles = (0, 0, 0);
        }
        self.var_82559c86 = str_hint_string;
        self.var_1fa07047 = var_a65e7c1a;
        self.var_95115064 = var_5152e048;
        self.var_a2d77bbb = function_4336408f(v_origin, self.var_e9a4f350, self.var_b347a23, self.var_82559c86);
        self.var_a2d77bbb.angles = v_angles;
        self.var_c7295a83 = spawn("script_model", v_origin);
        self.var_c7295a83 setmodel("");
        self.var_c7295a83 notsolid();
        assert(!self.var_f6ed93ab, "<dev string:x63>");
        self.var_f6ed93ab = 1;
        enable_hacking();
        self thread function_341b7c41();
    }

}

// Namespace _pda_hack
// Params 0, eflags: 0x2
// Checksum 0x2df759d0, Offset: 0x180
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("pda_hack", &__init__, undefined, undefined);
}

// Namespace _pda_hack
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1c0
// Size: 0x4
function __init__() {
    
}

