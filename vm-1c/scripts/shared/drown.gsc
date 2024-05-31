#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/codescripts/struct;

#namespace drown;

// Namespace drown
// Params 0, eflags: 0x2
// Checksum 0xb0721313, Offset: 0x1e0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("drown", &__init__, undefined, undefined);
}

// Namespace drown
// Params 0, eflags: 0x1 linked
// Checksum 0x90f85851, Offset: 0x220
// Size: 0x12c
function __init__() {
    callback::on_spawned(&on_player_spawned);
    level.drown_damage = getdvarfloat("player_swimDamage");
    level.var_8e026421 = getdvarfloat("player_swimDamagerInterval") * 1000;
    level.var_460fc258 = getdvarfloat("player_swimTime") * 1000;
    level.drown_pre_damage_stage_time = 2000;
    if (!isdefined(level.vsmgr_prio_overlay_drown_blur)) {
        level.vsmgr_prio_overlay_drown_blur = 10;
    }
    visionset_mgr::register_info("overlay", "drown_blur", 1, level.vsmgr_prio_overlay_drown_blur, 1, 1, &visionset_mgr::ramp_in_out_thread_per_player, 1);
    clientfield::register("toplayer", "drown_stage", 1, 3, "int");
}

// Namespace drown
// Params 0, eflags: 0x1 linked
// Checksum 0x6ec5f7a5, Offset: 0x358
// Size: 0x68
function activate_player_health_visionset() {
    self deactivate_player_health_visionset();
    if (!self.drown_vision_set) {
        visionset_mgr::activate("overlay", "drown_blur", self, 0.1, 0.25, 0.1);
        self.drown_vision_set = 1;
    }
}

// Namespace drown
// Params 0, eflags: 0x1 linked
// Checksum 0x988638a, Offset: 0x3c8
// Size: 0x50
function deactivate_player_health_visionset() {
    if (!isdefined(self.drown_vision_set) || self.drown_vision_set) {
        visionset_mgr::deactivate("overlay", "drown_blur", self);
        self.drown_vision_set = 0;
    }
}

// Namespace drown
// Params 0, eflags: 0x1 linked
// Checksum 0xe64699d5, Offset: 0x420
// Size: 0x64
function on_player_spawned() {
    self thread watch_player_drowning();
    self thread function_cb6a2e72();
    self thread watch_game_ended();
    self deactivate_player_health_visionset();
}

// Namespace drown
// Params 0, eflags: 0x1 linked
// Checksum 0x5e216765, Offset: 0x490
// Size: 0x278
function watch_player_drowning() {
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    self.lastwaterdamagetime = self getlastoutwatertime();
    self.drownstage = 0;
    self clientfield::set_to_player("drown_stage", 0);
    if (!isdefined(self.var_460fc258)) {
        self.var_460fc258 = level.var_460fc258;
    }
    if (isdefined(self.var_d1d70226) && self.var_d1d70226) {
        return;
    }
    while (true) {
        if (self isplayerunderwater() && self isplayerswimming()) {
            if (gettime() - self.lastwaterdamagetime > self.var_460fc258 - level.drown_pre_damage_stage_time && self.drownstage == 0) {
                self.drownstage++;
                self clientfield::set_to_player("drown_stage", self.drownstage);
            }
            if (gettime() - self.lastwaterdamagetime > self.var_460fc258) {
                self.lastwaterdamagetime += level.var_8e026421;
                var_b25e4fe = 6;
                self dodamage(level.drown_damage, self.origin, undefined, undefined, undefined, "MOD_DROWN", var_b25e4fe);
                self activate_player_health_visionset();
                if (self.drownstage < 4) {
                    self.drownstage++;
                    self clientfield::set_to_player("drown_stage", self.drownstage);
                }
            }
        } else {
            self.drownstage = 0;
            self clientfield::set_to_player("drown_stage", 0);
            self.lastwaterdamagetime = self getlastoutwatertime();
            self deactivate_player_health_visionset();
        }
        wait(0.05);
    }
}

// Namespace drown
// Params 0, eflags: 0x1 linked
// Checksum 0xab8ef219, Offset: 0x710
// Size: 0x6c
function function_cb6a2e72() {
    self endon(#"disconnect");
    self endon(#"game_ended");
    self waittill(#"death");
    self.drownstage = 0;
    self clientfield::set_to_player("drown_stage", 0);
    self deactivate_player_health_visionset();
}

// Namespace drown
// Params 0, eflags: 0x1 linked
// Checksum 0x29f3389, Offset: 0x788
// Size: 0x6c
function watch_game_ended() {
    self endon(#"disconnect");
    self endon(#"death");
    level waittill(#"game_ended");
    self.drownstage = 0;
    self clientfield::set_to_player("drown_stage", 0);
    self deactivate_player_health_visionset();
}

// Namespace drown
// Params 0, eflags: 0x1 linked
// Checksum 0xad6fe649, Offset: 0x800
// Size: 0x42
function is_player_drowning() {
    drowning = 1;
    if (!isdefined(self.drownstage) || self.drownstage == 0) {
        drowning = 0;
    }
    return drowning;
}

