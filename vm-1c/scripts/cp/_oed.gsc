#using scripts/cp/gametypes/_save;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace oed;

// Namespace oed
// Params 0, eflags: 0x2
// Checksum 0xc005c270, Offset: 0x2d8
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("oed", &__init__, &__main__, undefined);
}

// Namespace oed
// Params 0, eflags: 0x1 linked
// Checksum 0x14f4e14b, Offset: 0x320
// Size: 0x3bc
function __init__() {
    clientfield::register("toplayer", "ev_toggle", 1, 1, "int");
    clientfield::register("toplayer", "sitrep_toggle", 1, 1, "int");
    clientfield::register("toplayer", "tmode_toggle", 1, 3, "int");
    clientfield::register("toplayer", "active_dni_fx", 1, 1, "counter");
    clientfield::register("toplayer", "hack_dni_fx", 1, 1, "counter");
    clientfield::register("actor", "thermal_active", 1, 1, "int");
    clientfield::register("actor", "sitrep_material", 1, 1, "int");
    clientfield::register("actor", "force_tmode", 1, 1, "int");
    clientfield::register("actor", "tagged", 1, 1, "int");
    clientfield::register("vehicle", "thermal_active", 1, 1, "int");
    clientfield::register("vehicle", "sitrep_material", 1, 1, "int");
    clientfield::register("scriptmover", "thermal_active", 1, 1, "int");
    clientfield::register("scriptmover", "sitrep_material", 1, 1, "int");
    clientfield::register("item", "sitrep_material", 1, 1, "int");
    if (!isdefined(level.var_598df736)) {
        level.var_598df736 = 50;
    }
    visionset_mgr::register_info("visionset", "tac_mode", 1, level.var_598df736, 15, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
    callback::on_spawned(&on_player_spawned);
    spawner::add_global_spawn_function("axis", &function_d47e8f1b);
    spawner::add_global_spawn_function("allies", &function_d47e8f1b);
    level.var_d829fe9f = 1;
    level.var_1e983b11 = 1;
    level.var_f8b5c03f = 0;
    level.enable_thermal = &enable_thermal;
    level.disable_thermal = &disable_thermal;
}

// Namespace oed
// Params 0, eflags: 0x1 linked
// Checksum 0x3f596e70, Offset: 0x6e8
// Size: 0x14
function __main__() {
    function_9b299cd6();
}

// Namespace oed
// Params 0, eflags: 0x1 linked
// Checksum 0x83f9c8ed, Offset: 0x708
// Size: 0x74
function function_9b299cd6() {
    waittillframeend();
    if (level.var_1e983b11) {
        array::thread_all(util::query_ents(associativearray("classname", "weapon_"), 1, [], 1, 1), &function_e228c18a);
    }
}

// Namespace oed
// Params 0, eflags: 0x1 linked
// Checksum 0xbeab933a, Offset: 0x788
// Size: 0x13c
function on_player_spawned() {
    self.var_d829fe9f = level.var_d829fe9f;
    self.var_aa3f3ac2 = 0;
    self function_1c59df50(self.var_aa3f3ac2);
    self.var_1e983b11 = level.var_1e983b11;
    self.var_d5846b2c = 0;
    var_99268403 = 0;
    if (!sessionmodeiscampaignzombiesgame()) {
        if (isdefined(getlocalprofileint("tacticalModeAutoOn")) && getlocalprofileint("tacticalModeAutoOn")) {
            self.var_d5846b2c = 1;
            var_99268403 = 0;
        }
    }
    self function_12a9df06(self.var_d5846b2c, var_99268403);
    self clientfield::set_to_player("sitrep_toggle", 1);
    self thread function_cec8e852();
    self thread function_e29f0dd6();
}

// Namespace oed
// Params 0, eflags: 0x1 linked
// Checksum 0x9d6433fd, Offset: 0x8d0
// Size: 0x1f8
function function_cec8e852() {
    self endon(#"death");
    self endon(#"hash_3b109bff");
    while (true) {
        /#
            level flagsys::wait_till_clear("hack_dni_fx");
        #/
        if (level.var_d829fe9f && self.var_d829fe9f && self actionslotonebuttonpressed()) {
            if (!scene::is_igc_active()) {
                self.var_aa3f3ac2 = !(isdefined(self.var_aa3f3ac2) && self.var_aa3f3ac2);
                self function_1c59df50(self.var_aa3f3ac2);
                while (self actionslotonebuttonpressed()) {
                    wait(0.05);
                }
            }
        }
        if (!sessionmodeiscampaignzombiesgame() && level.var_1e983b11 && self.var_1e983b11 && self actionslotfourbuttonpressed()) {
            if (!scene::is_igc_active()) {
                self.var_d5846b2c = !(isdefined(self.var_d5846b2c) && self.var_d5846b2c);
                self function_12a9df06(self.var_d5846b2c);
                visionset_mgr::activate("visionset", "tac_mode", self, 0.05, 0, 0.8);
                wait(0.85);
                while (self actionslotfourbuttonpressed()) {
                    wait(0.05);
                }
            }
        }
        wait(0.05);
    }
}

// Namespace oed
// Params 0, eflags: 0x1 linked
// Checksum 0x64fc4f22, Offset: 0xad0
// Size: 0x5c
function function_d47e8f1b() {
    if (self.team == "axis") {
        self enable_thermal();
        return;
    }
    if (self.team == "allies") {
        self enable_thermal();
    }
}

// Namespace oed
// Params 1, eflags: 0x1 linked
// Checksum 0x326818c7, Offset: 0xb38
// Size: 0x74
function enable_thermal(var_ec99e627) {
    self endon(#"death");
    self clientfield::set("thermal_active", 1);
    self thread function_ba755d7a();
    if (isdefined(var_ec99e627)) {
        level waittill(var_ec99e627);
        self disable_thermal();
    }
}

// Namespace oed
// Params 0, eflags: 0x1 linked
// Checksum 0x1cbe5ffe, Offset: 0xbb8
// Size: 0x3c
function function_ba755d7a() {
    self endon(#"disable_thermal");
    self waittill(#"death");
    if (isdefined(self)) {
        self disable_thermal();
    }
}

// Namespace oed
// Params 0, eflags: 0x1 linked
// Checksum 0xa498e3d0, Offset: 0xc00
// Size: 0x32
function disable_thermal() {
    self clientfield::set("thermal_active", 0);
    self notify(#"disable_thermal");
}

// Namespace oed
// Params 1, eflags: 0x0
// Checksum 0x7213fd1f, Offset: 0xc40
// Size: 0xae
function function_b3c589a6(b_enabled) {
    if (!isdefined(b_enabled)) {
        b_enabled = 1;
    }
    level.var_d829fe9f = b_enabled;
    foreach (e_player in level.players) {
        e_player.var_d829fe9f = b_enabled;
    }
}

// Namespace oed
// Params 1, eflags: 0x1 linked
// Checksum 0x39b38f1c, Offset: 0xcf8
// Size: 0x4c
function enable_ev(b_enabled) {
    if (!isdefined(b_enabled)) {
        b_enabled = 1;
    }
    self.var_d829fe9f = b_enabled;
    if (!b_enabled) {
        self function_1c59df50(b_enabled);
    }
}

// Namespace oed
// Params 1, eflags: 0x1 linked
// Checksum 0xc4891479, Offset: 0xd50
// Size: 0xc4
function function_fc1750c9(b_enabled) {
    if (!isdefined(b_enabled)) {
        b_enabled = 1;
    }
    self.var_1e983b11 = b_enabled;
    if (b_enabled) {
        if (isdefined(getlocalprofileint("tacticalModeAutoOn")) && !sessionmodeiscampaignzombiesgame() && getlocalprofileint("tacticalModeAutoOn")) {
            self function_12a9df06(1, 0);
        }
        return;
    }
    self function_12a9df06(0, 0);
}

// Namespace oed
// Params 1, eflags: 0x0
// Checksum 0x582cd158, Offset: 0xe20
// Size: 0x34
function function_35ce409(b_enabled) {
    if (!isdefined(b_enabled)) {
        b_enabled = 1;
    }
    function_1c59df50(b_enabled);
}

// Namespace oed
// Params 1, eflags: 0x1 linked
// Checksum 0xc5f1f7bf, Offset: 0xe60
// Size: 0x164
function function_1c59df50(b_enabled) {
    if (!isdefined(b_enabled)) {
        b_enabled = 1;
    }
    self.var_aa3f3ac2 = b_enabled;
    if (self.var_aa3f3ac2) {
        if (isdefined(self.var_d5846b2c) && self.var_d5846b2c) {
            self.var_2b22c8c8 = 1;
        } else {
            self.var_2b22c8c8 = 0;
        }
        self function_12a9df06(0, 0, 0);
    }
    if (self.var_aa3f3ac2) {
        self notify(#"hash_2b839b92");
    } else {
        self notify(#"hash_49d8a575");
    }
    self clientfield::set_to_player("ev_toggle", self.var_aa3f3ac2);
    if (!self.var_aa3f3ac2) {
        if (isdefined(self.var_2b22c8c8) && self.var_2b22c8c8) {
            if (isdefined(getlocalprofileint("tacticalModeAutoOn")) && !sessionmodeiscampaignzombiesgame() && getlocalprofileint("tacticalModeAutoOn")) {
                self function_12a9df06(1, 0, 0);
            }
        }
    }
}

// Namespace oed
// Params 3, eflags: 0x1 linked
// Checksum 0x7dabbb2c, Offset: 0xfd0
// Size: 0x194
function function_12a9df06(b_enabled, var_99268403, var_8bdc47ed) {
    if (!isdefined(b_enabled)) {
        b_enabled = 1;
    }
    if (!isdefined(var_99268403)) {
        var_99268403 = 1;
    }
    if (!isdefined(var_8bdc47ed)) {
        var_8bdc47ed = 1;
    }
    self.var_d5846b2c = b_enabled;
    if (var_8bdc47ed && self.var_d5846b2c) {
        self function_1c59df50(0);
    }
    if (self.var_d5846b2c) {
        self notify(#"hash_8d6266d8");
    } else {
        self notify(#"hash_e0fad893");
    }
    self tmodesetserveruser(self.var_d5846b2c);
    code = 0;
    if (!isdefined(self.var_73c16596)) {
        self.var_73c16596 = 0;
    }
    self.var_73c16596++;
    self.var_73c16596 &= 1;
    code = self.var_73c16596;
    if (var_99268403) {
        code |= 2;
    }
    if (self.var_d5846b2c) {
        code |= 4;
    }
    self clientfield::set_to_player("tmode_toggle", code);
    self savegame::set_player_data("tmode", self.var_d5846b2c);
}

// Namespace oed
// Params 0, eflags: 0x1 linked
// Checksum 0x22f410bc, Offset: 0x1170
// Size: 0xca
function function_e29f0dd6() {
    var_c649c515 = getentarray();
    foreach (e_hero in var_c649c515) {
        if (isdefined(e_hero.is_hero) && e_hero.is_hero) {
            e_hero thread enable_thermal();
        }
    }
}

// Namespace oed
// Params 1, eflags: 0x0
// Checksum 0x9b87aa15, Offset: 0x1248
// Size: 0xae
function function_f0f40bb5(b_enabled) {
    if (!isdefined(b_enabled)) {
        b_enabled = 1;
    }
    level.var_1e983b11 = b_enabled;
    foreach (e_player in level.players) {
        e_player.var_1e983b11 = b_enabled;
    }
}

// Namespace oed
// Params 1, eflags: 0x0
// Checksum 0xd7561243, Offset: 0x1300
// Size: 0x4c
function function_6e4b8a4f(b_enabled) {
    if (!isdefined(b_enabled)) {
        b_enabled = 1;
    }
    self.var_10b39c91 = b_enabled;
    self clientfield::set("force_tmode", b_enabled);
}

// Namespace oed
// Params 2, eflags: 0x1 linked
// Checksum 0x6a66af27, Offset: 0x1358
// Size: 0x94
function function_e228c18a(var_63c5785a, var_ec99e627) {
    if (!isdefined(var_63c5785a)) {
        var_63c5785a = 0;
    }
    self endon(#"death");
    self clientfield::set("sitrep_material", 1);
    self thread function_6042d612();
    if (isdefined(var_ec99e627)) {
        level waittill(var_ec99e627);
        self function_14ec2d71();
    }
}

// Namespace oed
// Params 0, eflags: 0x1 linked
// Checksum 0xfaef3ff8, Offset: 0x13f8
// Size: 0x2c
function function_6042d612() {
    self waittill(#"death");
    if (isdefined(self)) {
        self function_14ec2d71();
    }
}

// Namespace oed
// Params 0, eflags: 0x1 linked
// Checksum 0xfcde8d83, Offset: 0x1430
// Size: 0x24
function function_14ec2d71() {
    self clientfield::set("sitrep_material", 0);
}

// Namespace oed
// Params 1, eflags: 0x0
// Checksum 0xff22c134, Offset: 0x1460
// Size: 0xea
function function_cb36c1ba(b_active) {
    if (!isdefined(b_active)) {
        b_active = 1;
    }
    foreach (player in level.players) {
        player.var_c5bcb2b9 = !(isdefined(player.var_c5bcb2b9) && player.var_c5bcb2b9);
        player clientfield::set_to_player("sitrep_toggle", player.var_c5bcb2b9);
    }
}

// Namespace oed
// Params 0, eflags: 0x0
// Checksum 0xa1955d30, Offset: 0x1558
// Size: 0xc8
function function_34347f5d() {
    if (!isdefined(self.angles)) {
        self.angles = (0, 0, 0);
    }
    var_8b914409 = level.var_3f831f3b["sitrep"][self.scriptbundlename];
    var_92fa0808 = util::spawn_model(var_8b914409.model, self.origin, self.angles);
    if (isdefined(var_8b914409.var_259ea471)) {
        var_92fa0808.var_79c8542e = var_8b914409.var_259ea471;
    } else {
        var_92fa0808.var_79c8542e = 0;
    }
    return var_92fa0808;
}

