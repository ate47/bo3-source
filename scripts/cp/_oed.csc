#using scripts/shared/postfx_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace oed;

// Namespace oed
// Params 0, eflags: 0x2
// Checksum 0x9e85f2e, Offset: 0x4e0
// Size: 0x34
function function_2dc19561() {
    system::register("oed", &__init__, undefined, undefined);
}

// Namespace oed
// Params 0, eflags: 0x1 linked
// Checksum 0x9cb242eb, Offset: 0x520
// Size: 0x59c
function __init__() {
    clientfield::register("toplayer", "ev_toggle", 1, 1, "int", &function_683c01d7, 0, 0);
    clientfield::register("toplayer", "sitrep_toggle", 1, 1, "int", &function_87d1be5b, 0, 0);
    clientfield::register("toplayer", "tmode_toggle", 1, 3, "int", &function_8fc5e501, 0, 0);
    clientfield::register("toplayer", "active_dni_fx", 1, 1, "counter", &function_6b87ceb0, 0, 0);
    clientfield::register("toplayer", "hack_dni_fx", 1, 1, "counter", &hack_dni_fx, 0, 0);
    clientfield::register("actor", "thermal_active", 1, 1, "int", &function_ff9664ce, 0, 0);
    clientfield::register("actor", "sitrep_material", 1, 1, "int", &function_29cf4c66, 0, 0);
    clientfield::register("actor", "force_tmode", 1, 1, "int", &function_6e9780f5, 0, 0);
    clientfield::register("actor", "tagged", 1, 1, "int", &function_6ce4a07c, 0, 0);
    clientfield::register("vehicle", "thermal_active", 1, 1, "int", &function_ff9664ce, 0, 0);
    clientfield::register("vehicle", "sitrep_material", 1, 1, "int", &function_29cf4c66, 0, 0);
    clientfield::register("scriptmover", "thermal_active", 1, 1, "int", &function_ff9664ce, 0, 0);
    clientfield::register("scriptmover", "sitrep_material", 1, 1, "int", &function_29cf4c66, 0, 0);
    clientfield::register("item", "sitrep_material", 1, 1, "int", &function_29cf4c66, 0, 0);
    duplicate_render::set_dr_filter_offscreen("sitrep_keyline", 25, "keyline_active", "keyfill_active", 2, "mc/hud_outline_model_z_white", 0);
    duplicate_render::set_dr_filter_offscreen("sitrep_fill", 25, "keyfill_active", "keyline_active", 2, "mc/hud_outline_model_orange_alpha", 0);
    duplicate_render::set_dr_filter_offscreen("sitrep_keyfill", 30, "keyline_active,keyfill_active", undefined, 2, "mc/hud_outline_model_orange_calpha", 0);
    duplicate_render::set_dr_filter_offscreen("enemy_thermal", 24, "thermal_enemy_active", undefined, 2, "mc/hud_outline_model_z_red", 0);
    duplicate_render::set_dr_filter_offscreen("friendly_thermal", 24, "thermal_friendly_active", undefined, 2, "mc/hud_outline_model_z_green", 0);
    visionset_mgr::register_visionset_info("tac_mode", 1, 15, undefined, "tac_mode_blue");
    callback::on_spawned(&on_player_spawned);
    level flag::init("activate_tmode");
    level flag::init("activate_thermal");
    callback::on_localclient_shutdown(&on_localplayer_shutdown);
}

// Namespace oed
// Params 1, eflags: 0x1 linked
// Checksum 0x38f833bb, Offset: 0xac8
// Size: 0x13c
function on_player_spawned(localclientnum) {
    self.var_8b31f902 = 0;
    var_7fd179a9 = 10500;
    var_3b6a005d = 3000;
    if (isdefined(level.var_6411bf7a)) {
        var_7fd179a9 = level.var_6411bf7a;
    }
    if (isdefined(level.var_80d69208)) {
        var_3b6a005d = level.var_80d69208;
    }
    evsetranges(localclientnum, var_7fd179a9, var_3b6a005d);
    self oed_sitrepscan_setoutline(1);
    self oed_sitrepscan_setlinewidth(1);
    self oed_sitrepscan_setradius(1800);
    self oed_sitrepscan_setfalloff(0.01);
    self function_c8420300();
    function_357cbbf0(localclientnum);
    function_22ee3552(localclientnum);
}

// Namespace oed
// Params 1, eflags: 0x1 linked
// Checksum 0xa4633418, Offset: 0xc10
// Size: 0x3c
function on_localplayer_shutdown(localclientnum) {
    function_357cbbf0(localclientnum);
    function_22ee3552(localclientnum);
}

// Namespace oed
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xc58
// Size: 0x4
function function_c8420300() {
    
}

// Namespace oed
// Params 1, eflags: 0x1 linked
// Checksum 0xd0ac6a6e, Offset: 0xc68
// Size: 0x10a
function function_bcc974a(localclientnum) {
    if (!self islocalplayer()) {
        return;
    }
    var_99ccb8b4 = getentarray(localclientnum);
    foreach (entity in var_99ccb8b4) {
        if (isdefined(entity.var_1aa2bd23) && entity.var_1aa2bd23) {
            entity.var_1aa2bd23 = 0;
            entity tmodeclearflag(4);
        }
    }
}

// Namespace oed
// Params 7, eflags: 0x1 linked
// Checksum 0x576291e5, Offset: 0xd80
// Size: 0xcc
function function_683c01d7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!self islocalplayer()) {
        return;
    }
    if (!isdefined(self getlocalclientnumber())) {
        return;
    }
    if (self getlocalclientnumber() != localclientnum) {
        return;
    }
    if (level flagsys::get("menu_open")) {
        return;
    }
    self function_a36d7529(localclientnum, newval);
}

// Namespace oed
// Params 2, eflags: 0x1 linked
// Checksum 0xe305aaf5, Offset: 0xe58
// Size: 0x6c
function function_e8b1e8b2(localclientnum, newval) {
    if (isdefined(self)) {
        self evenable(newval);
        return;
    }
    /#
        println("hack_dni_fx");
    #/
    gadgetsetinfrared(localclientnum, newval);
}

// Namespace oed
// Params 1, eflags: 0x1 linked
// Checksum 0x214b8ef7, Offset: 0xed0
// Size: 0x8c
function function_22ee3552(localclientnum) {
    audio::stoploopat("gdt_oed_loop", (1, 2, 3));
    function_843d23d0(localclientnum);
    wait(0.016);
    self function_e8b1e8b2(localclientnum, 0);
    level flag::clear("activate_thermal");
}

// Namespace oed
// Params 1, eflags: 0x1 linked
// Checksum 0x172b43bc, Offset: 0xf68
// Size: 0x64
function function_357cbbf0(localclientnum) {
    self tmodeenable(0);
    self thread function_bcc974a(localclientnum);
    wait(0.016);
    level flag::clear("activate_tmode");
}

// Namespace oed
// Params 2, eflags: 0x1 linked
// Checksum 0x766e1517, Offset: 0xfd8
// Size: 0x1ac
function function_a36d7529(lcn, newval) {
    self.var_8b31f902 = newval;
    if (newval) {
        function_357cbbf0(lcn);
        self function_e8b1e8b2(lcn, newval);
        level flag::set("activate_thermal");
        if (isdefined(level.var_109d2487)) {
            [[ level.var_109d2487 ]]();
        }
        playsound(lcn, "gdt_oed_on", (0, 0, 0));
        audio::playloopat("gdt_oed_loop", (1, 2, 3));
        function_dd48a4cf(lcn);
        return;
    }
    playsound(lcn, "gdt_oed_off", (0, 0, 0));
    audio::stoploopat("gdt_oed_loop", (1, 2, 3));
    function_843d23d0(lcn);
    wait(0.016);
    self function_e8b1e8b2(lcn, newval);
    level flag::clear("activate_thermal");
}

// Namespace oed
// Params 7, eflags: 0x1 linked
// Checksum 0x2eff89d1, Offset: 0x1190
// Size: 0x14c
function function_ff9664ce(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    level flagsys::wait_till("duplicaterender_registry_ready");
    /#
        assert(isdefined(self), "hack_dni_fx");
    #/
    if (newval == 0) {
        self.var_de2e098b = 0;
        self set_entity_thermal(localclientnum, 0);
        return;
    }
    self.var_de2e098b = newval;
    player = getlocalplayer(localclientnum);
    if (isdefined(player.var_8b31f902) && player.var_8b31f902) {
        self set_entity_thermal(localclientnum, 1);
        return;
    }
    self set_entity_thermal(localclientnum, 0);
}

// Namespace oed
// Params 2, eflags: 0x1 linked
// Checksum 0xd700abb5, Offset: 0x12e8
// Size: 0xcc
function set_entity_thermal(localclientnum, b_enabled) {
    if (self.team == "allies") {
        self duplicate_render::set_dr_flag("thermal_friendly_active", b_enabled);
        n_index = 6;
    } else {
        self duplicate_render::set_dr_flag("thermal_enemy_active", b_enabled);
        n_index = 5;
    }
    if (b_enabled) {
        self tmodesetflag(n_index);
        return;
    }
    self tmodeclearflag(n_index);
}

// Namespace oed
// Params 1, eflags: 0x1 linked
// Checksum 0x6bdd7a07, Offset: 0x13c0
// Size: 0xe2
function function_dd48a4cf(localclientnum) {
    var_b3624865 = getentarray(localclientnum);
    foreach (entity in var_b3624865) {
        if (isdefined(entity.var_de2e098b) && entity.var_de2e098b) {
            entity set_entity_thermal(localclientnum, 1);
        }
    }
}

// Namespace oed
// Params 1, eflags: 0x1 linked
// Checksum 0x34e2355b, Offset: 0x14b0
// Size: 0xe2
function function_843d23d0(localclientnum) {
    var_b3624865 = getentarray(localclientnum);
    foreach (entity in var_b3624865) {
        if (isdefined(entity.var_de2e098b) && entity.var_de2e098b) {
            entity set_entity_thermal(localclientnum, 0);
        }
    }
}

// Namespace oed
// Params 7, eflags: 0x0
// Checksum 0x8b34fe18, Offset: 0x15a0
// Size: 0xac
function function_aa868720(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    level flagsys::wait_till("duplicaterender_registry_ready");
    /#
        assert(isdefined(self), "hack_dni_fx");
    #/
    if (newval) {
        self duplicate_render::set_item_enemy_equipment(localclientnum, newval);
    }
}

// Namespace oed
// Params 7, eflags: 0x1 linked
// Checksum 0x7c2c5a3a, Offset: 0x1658
// Size: 0x9c
function function_6e9780f5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_10b39c91 = 1;
        self tmodesetflag(1);
        return;
    }
    self.var_10b39c91 = 0;
    self tmodeclearflag(1);
}

// Namespace oed
// Params 7, eflags: 0x1 linked
// Checksum 0x8bc85b39, Offset: 0x1700
// Size: 0x54
function function_6ce4a07c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    forcetmodevisible(self, newval);
}

// Namespace oed
// Params 7, eflags: 0x1 linked
// Checksum 0xb23a7f52, Offset: 0x1760
// Size: 0x5c
function function_6b87ceb0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread postfx::playpostfxbundle("pstfx_tactical_bootup");
}

// Namespace oed
// Params 7, eflags: 0x1 linked
// Checksum 0x2279ff1e, Offset: 0x17c8
// Size: 0x7c
function hack_dni_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread postfx::playpostfxbundle("pstfx_hacking_bootup");
    self playsound(0, "uin_hack_mode_activate");
}

// Namespace oed
// Params 2, eflags: 0x1 linked
// Checksum 0xbf8d3cdb, Offset: 0x1850
// Size: 0x104
function function_3b4d6db0(localclientnum, var_99268403) {
    if (!isdefined(var_99268403)) {
        var_99268403 = 1;
    }
    self tmodeenable(0);
    if (!isdefined(level.var_e46224ba) && !isigcactive(localclientnum) && var_99268403) {
        self thread postfx::playpostfxbundle("pstfx_tactical_bootup");
    }
    self thread function_bcc974a(localclientnum);
    if (!isigcactive(localclientnum) && var_99268403) {
        self playsound(0, "uin_tac_mode_off");
    }
    level flag::clear("activate_tmode");
}

// Namespace oed
// Params 2, eflags: 0x1 linked
// Checksum 0xd69f07c4, Offset: 0x1960
// Size: 0xec
function function_165838aa(localclientnum, var_99268403) {
    if (!isdefined(var_99268403)) {
        var_99268403 = 1;
    }
    function_22ee3552(localclientnum);
    level flag::set("activate_tmode");
    self tmodeenable(1);
    if (isdefined(level.var_3bef64e1)) {
        [[ level.var_3bef64e1 ]]();
    }
    if (!isdefined(level.var_e46224ba) && var_99268403) {
        self thread postfx::playpostfxbundle("pstfx_tactical_bootup");
    }
    if (var_99268403) {
        self playsound(0, "uin_tac_mode_on");
    }
}

// Namespace oed
// Params 7, eflags: 0x1 linked
// Checksum 0x868f52f, Offset: 0x1a58
// Size: 0x124
function function_8fc5e501(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!self islocalplayer()) {
        return;
    }
    if (!isdefined(self.localclientnum)) {
        return;
    }
    if (self.localclientnum != localclientnum) {
        return;
    }
    if (level flagsys::get("menu_open")) {
        return;
    }
    self notify(#"hash_84f2548f");
    self.var_8b70667f = newval;
    var_99268403 = 0;
    if (newval & 2) {
        var_99268403 = 1;
    }
    if (newval & 4) {
        self function_165838aa(localclientnum, var_99268403);
        return;
    }
    self function_3b4d6db0(localclientnum, var_99268403);
}

// Namespace oed
// Params 7, eflags: 0x1 linked
// Checksum 0x74b8b325, Offset: 0x1b88
// Size: 0x94
function function_87d1be5b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!self islocalplayer()) {
        return;
    }
    if (!isdefined(self.localclientnum)) {
        return;
    }
    if (self.localclientnum != localclientnum) {
        return;
    }
    self thread function_9532d33d(localclientnum, newval);
}

// Namespace oed
// Params 2, eflags: 0x1 linked
// Checksum 0x551127ac, Offset: 0x1c28
// Size: 0x3c
function function_9532d33d(lcn, newval) {
    self.var_c5bcb2b9 = newval;
    self oed_sitrepscan_enable(newval);
}

// Namespace oed
// Params 7, eflags: 0x1 linked
// Checksum 0xa39f2aca, Offset: 0x1c70
// Size: 0x184
function function_29cf4c66(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    /#
        assert(isdefined(self), "hack_dni_fx");
    #/
    level flagsys::wait_till("duplicaterender_registry_ready");
    /#
        assert(isdefined(self), "hack_dni_fx");
    #/
    if (newval == 0) {
        self notify(#"hash_1b32b83b");
        self.var_6c4eaf38 = undefined;
        self duplicate_render::change_dr_flags(localclientnum, undefined, "keyline_active,keyfill_active");
        self tmodesetflag(2);
        return;
    }
    self duplicate_render::change_dr_flags(localclientnum, "keyline_active", "keyfill_active");
    self.var_ac0e7241 = 1;
    self tmodeclearflag(2);
    if (!isdefined(self.var_6c4eaf38)) {
        self.var_6c4eaf38 = 1;
        self thread function_537efcea(localclientnum);
    }
}

// Namespace oed
// Params 1, eflags: 0x1 linked
// Checksum 0x67d6593e, Offset: 0x1e00
// Size: 0x27a
function function_537efcea(localclientnum) {
    self endon(#"death");
    self endon(#"entityshutdown");
    self endon(#"hash_1b32b83b");
    player = getlocalplayer(localclientnum);
    player endon(#"disconnect");
    player endon(#"entityshutdown");
    var_56f99f06 = 0;
    var_56f99f06 = getdvarfloat("interactivePromptNearToDist", 8.4);
    var_56f99f06 *= 39.37;
    while (true) {
        n_dist = distance(self.origin, player.origin);
        var_98b6ad82 = level flag::get("activate_thermal");
        var_d2ca8de = 0;
        if ((var_98b6ad82 || var_d2ca8de) && ((n_dist <= 90 || n_dist > var_56f99f06) && self.var_ac0e7241 && !var_98b6ad82 && !var_d2ca8de || self.var_ac0e7241)) {
            self duplicate_render::change_dr_flags(localclientnum, undefined, "keyline_active,keyfill_active");
            self tmodeclearflag(2);
            self.var_ac0e7241 = 0;
        } else if (n_dist > 90 && n_dist <= var_56f99f06 && !self.var_ac0e7241 && !var_98b6ad82 && !var_d2ca8de) {
            self duplicate_render::change_dr_flags(localclientnum, "keyline_active", "keyfill_active");
            self tmodesetflag(2);
            self.var_ac0e7241 = 1;
        }
        wait(0.016 * randomintrange(1, 10));
    }
}

