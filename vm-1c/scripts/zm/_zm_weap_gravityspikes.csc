#using scripts/shared/ai/zombie_vortex;
#using scripts/shared/util_shared;
#using scripts/shared/array_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace _zm_weap_gravityspikes;

// Namespace _zm_weap_gravityspikes
// Params 0, eflags: 0x2
// Checksum 0xce31d842, Offset: 0x600
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_gravityspikes", &__init__, undefined, undefined);
}

// Namespace _zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x915f8b33, Offset: 0x640
// Size: 0x16a
function __init__(localclientnum) {
    register_clientfields();
    level._effect["gravityspikes_destroy"] = "electric/fx_elec_burst_lg_z270_os";
    level._effect["gravityspikes_location"] = "dlc1/castle/fx_weapon_gravityspike_location_glow";
    level._effect["gravityspikes_slam"] = "dlc1/zmb_weapon/fx_wpn_spike_grnd_hit";
    level._effect["gravityspikes_slam_1p"] = "dlc1/zmb_weapon/fx_wpn_spike_grnd_hit_1p";
    level._effect["gravityspikes_trap_start"] = "dlc1/zmb_weapon/fx_wpn_spike_trap_start";
    level._effect["gravityspikes_trap_loop"] = "dlc1/zmb_weapon/fx_wpn_spike_trap_loop";
    level._effect["gravityspikes_trap_end"] = "dlc1/zmb_weapon/fx_wpn_spike_trap_end";
    level._effect["gravity_trap_spike_spark"] = "dlc1/zmb_weapon/fx_wpn_spike_trap_handle_sparks";
    level._effect["zombie_sparky"] = "electric/fx_ability_elec_surge_short_robot_optim";
    level._effect["zombie_spark_light"] = "light/fx_light_spark_chest_zombie_optim";
    level._effect["zombie_spark_trail"] = "dlc1/zmb_weapon/fx_wpn_spike_torso_trail";
    level._effect["gravity_spike_zombie_explode"] = "dlc1/castle/fx_tesla_trap_body_exp";
}

// Namespace _zm_weap_gravityspikes
// Params 0, eflags: 0x1 linked
// Checksum 0xc6fca6e6, Offset: 0x7b8
// Size: 0x3ac
function register_clientfields() {
    clientfield::register("actor", "gravity_slam_down", 1, 1, "int", &gravity_slam_down, 0, 0);
    clientfield::register("scriptmover", "gravity_trap_fx", 1, 1, "int", &gravity_trap_fx, 0, 0);
    clientfield::register("scriptmover", "gravity_trap_spike_spark", 1, 1, "int", &gravity_trap_spike_spark, 0, 0);
    clientfield::register("scriptmover", "gravity_trap_destroy", 1, 1, "counter", &gravity_trap_destroy, 0, 0);
    clientfield::register("scriptmover", "gravity_trap_location", 1, 1, "int", &gravity_trap_location, 0, 0);
    clientfield::register("scriptmover", "gravity_slam_fx", 1, 1, "int", &gravity_slam_fx, 0, 0);
    clientfield::register("toplayer", "gravity_slam_player_fx", 1, 1, "counter", &gravity_slam_player_fx, 0, 0);
    clientfield::register("actor", "sparky_beam_fx", 1, 1, "int", &play_sparky_beam_fx, 0, 0);
    clientfield::register("actor", "sparky_zombie_fx", 1, 1, "int", &sparky_zombie_fx_cb, 0, 0);
    clientfield::register("actor", "sparky_zombie_trail_fx", 1, 1, "int", &sparky_zombie_trail_fx_cb, 0, 0);
    clientfield::register("toplayer", "gravity_trap_rumble", 1, 1, "int", &function_def5e8b7, 0, 0);
    clientfield::register("actor", "ragdoll_impact_watch", 1, 1, "int", &ragdoll_impact_watch_start, 0, 0);
    clientfield::register("actor", "gravity_spike_zombie_explode_fx", 12000, 1, "counter", &gravity_spike_zombie_explode, 1, 0);
}

// Namespace _zm_weap_gravityspikes
// Params 7, eflags: 0x1 linked
// Checksum 0x875f40a, Offset: 0xb70
// Size: 0x64
function gravity_slam_down(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self launchragdoll((0, 0, -200));
    }
}

// Namespace _zm_weap_gravityspikes
// Params 7, eflags: 0x1 linked
// Checksum 0x70b89c88, Offset: 0xbe0
// Size: 0xa4
function gravity_slam_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(self.slam_fx)) {
            deletefx(localclientnum, self.slam_fx, 1);
        }
        playfxontag(localclientnum, level._effect["gravityspikes_slam"], self, "tag_origin");
    }
}

// Namespace _zm_weap_gravityspikes
// Params 7, eflags: 0x1 linked
// Checksum 0xfbcd0719, Offset: 0xc90
// Size: 0x64
function gravity_slam_player_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxoncamera(localclientnum, level._effect["gravityspikes_slam_1p"]);
}

// Namespace _zm_weap_gravityspikes
// Params 7, eflags: 0x1 linked
// Checksum 0x81e2b595, Offset: 0xd00
// Size: 0x21c
function gravity_trap_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.b_gravity_trap_fx = 1;
        if (!isdefined(level.a_mdl_gravity_traps)) {
            level.a_mdl_gravity_traps = [];
        }
        if (!isinarray(level.a_mdl_gravity_traps, self)) {
            if (!isdefined(level.a_mdl_gravity_traps)) {
                level.a_mdl_gravity_traps = [];
            } else if (!isarray(level.a_mdl_gravity_traps)) {
                level.a_mdl_gravity_traps = array(level.a_mdl_gravity_traps);
            }
            level.a_mdl_gravity_traps[level.a_mdl_gravity_traps.size] = self;
        }
        playfxontag(localclientnum, level._effect["gravityspikes_trap_start"], self, "tag_origin");
        wait 0.5;
        if (isdefined(self.b_gravity_trap_fx) && self.b_gravity_trap_fx) {
            self.n_gravity_trap_fx = playfxontag(localclientnum, level._effect["gravityspikes_trap_loop"], self, "tag_origin");
        }
        return;
    }
    self.b_gravity_trap_fx = undefined;
    if (isdefined(self.n_gravity_trap_fx)) {
        deletefx(localclientnum, self.n_gravity_trap_fx, 1);
        self.n_gravity_trap_fx = undefined;
    }
    arrayremovevalue(level.a_mdl_gravity_traps, self);
    playfxontag(localclientnum, level._effect["gravityspikes_trap_end"], self, "tag_origin");
}

// Namespace _zm_weap_gravityspikes
// Params 7, eflags: 0x1 linked
// Checksum 0xc720c606, Offset: 0xf28
// Size: 0xac
function gravity_trap_spike_spark(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.spark_fx_id = playfxontag(localclientnum, level._effect["gravity_trap_spike_spark"], self, "tag_origin");
        return;
    }
    if (isdefined(self.spark_fx_id)) {
        deletefx(localclientnum, self.spark_fx_id, 1);
    }
}

// Namespace _zm_weap_gravityspikes
// Params 7, eflags: 0x1 linked
// Checksum 0xe05e49c4, Offset: 0xfe0
// Size: 0xbe
function gravity_trap_location(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.fx_id_location = playfxontag(localclientnum, level._effect["gravityspikes_location"], self, "tag_origin");
        return;
    }
    if (isdefined(self.fx_id_location)) {
        deletefx(localclientnum, self.fx_id_location, 1);
        self.fx_id_location = undefined;
    }
}

// Namespace _zm_weap_gravityspikes
// Params 7, eflags: 0x1 linked
// Checksum 0x4fed8c59, Offset: 0x10a8
// Size: 0x6c
function gravity_trap_destroy(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfx(localclientnum, level._effect["gravityspikes_destroy"], self.origin);
}

// Namespace _zm_weap_gravityspikes
// Params 7, eflags: 0x1 linked
// Checksum 0xb83210bb, Offset: 0x1120
// Size: 0x64
function ragdoll_impact_watch_start(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        self thread ragdoll_impact_watch(localclientnum);
    }
}

// Namespace _zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x4e8973f, Offset: 0x1190
// Size: 0x220
function ragdoll_impact_watch(localclientnum) {
    self endon(#"entityshutdown");
    self.v_start_pos = self.origin;
    n_wait_time = 0.05;
    n_gib_speed = 20;
    v_prev_origin = self.origin;
    wait n_wait_time;
    v_prev_vel = self.origin - v_prev_origin;
    n_prev_speed = length(v_prev_vel);
    v_prev_origin = self.origin;
    wait n_wait_time;
    b_first_loop = 1;
    while (true) {
        v_vel = self.origin - v_prev_origin;
        n_speed = length(v_vel);
        if (n_speed < n_prev_speed * 0.5 && n_speed <= n_gib_speed && !b_first_loop) {
            if (self.origin[2] > self.v_start_pos[2] + -128) {
                if (isdefined(level._effect["zombie_guts_explosion"]) && util::is_mature()) {
                    playfx(localclientnum, level._effect["zombie_guts_explosion"], self.origin, anglestoforward(self.angles));
                }
                self hide();
            }
            break;
        }
        v_prev_origin = self.origin;
        n_prev_speed = n_speed;
        b_first_loop = 0;
        wait n_wait_time;
    }
}

// Namespace _zm_weap_gravityspikes
// Params 7, eflags: 0x1 linked
// Checksum 0x26b93f54, Offset: 0x13b8
// Size: 0x76
function function_def5e8b7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread gravity_trap_rumble(localclientnum);
        return;
    }
    self notify(#"vortex_stop");
}

// Namespace _zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x71002509, Offset: 0x1438
// Size: 0x60
function gravity_trap_rumble(localclientnum) {
    level endon(#"demo_jump");
    self endon(#"vortex_stop");
    self endon(#"death");
    while (isdefined(self)) {
        self playrumbleonentity(localclientnum, "zod_idgun_vortex_interior");
        wait 0.075;
    }
}

// Namespace _zm_weap_gravityspikes
// Params 7, eflags: 0x1 linked
// Checksum 0x8e135540, Offset: 0x14a0
// Size: 0x15c
function play_sparky_beam_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        ai_zombie = self;
        var_de7d63cb = array("J_Spine4", "J_SpineUpper", "J_Spine1");
        str_tag = array::random(var_de7d63cb);
        if (isdefined(level.a_mdl_gravity_traps)) {
            mdl_gravity_trap = arraygetclosest(self.origin, level.a_mdl_gravity_traps);
        }
        if (isdefined(mdl_gravity_trap)) {
            self.e_sparky_beam = beamlaunch(localclientnum, mdl_gravity_trap, "tag_origin", ai_zombie, str_tag, "electric_arc_sm_tesla_beam_pap");
        }
        return;
    }
    if (isdefined(self.e_sparky_beam)) {
        beamkill(localclientnum, self.e_sparky_beam);
    }
}

// Namespace _zm_weap_gravityspikes
// Params 7, eflags: 0x1 linked
// Checksum 0x5d99e91a, Offset: 0x1608
// Size: 0x16e
function sparky_zombie_fx_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (!isdefined(self.sparky_loop_snd)) {
            self.sparky_loop_snd = self playloopsound("zmb_electrozomb_lp", 0.2);
        }
        self.var_444ab4e1 = playfxontag(localclientnum, level._effect["zombie_sparky"], self, "J_SpineUpper");
        setfxignorepause(localclientnum, self.var_444ab4e1, 1);
        self.var_444ab4e1 = playfxontag(localclientnum, level._effect["zombie_spark_light"], self, "J_SpineUpper");
        setfxignorepause(localclientnum, self.var_444ab4e1, 1);
        return;
    }
    if (isdefined(self.var_444ab4e1)) {
        deletefx(localclientnum, self.var_444ab4e1, 1);
    }
    self.var_444ab4e1 = undefined;
}

// Namespace _zm_weap_gravityspikes
// Params 7, eflags: 0x1 linked
// Checksum 0xa3bf1fbb, Offset: 0x1780
// Size: 0xde
function sparky_zombie_trail_fx_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.n_trail_fx = playfxontag(localclientnum, level._effect["zombie_spark_trail"], self, "J_SpineUpper");
        setfxignorepause(localclientnum, self.n_trail_fx, 1);
        return;
    }
    if (isdefined(self.n_trail_fx)) {
        deletefx(localclientnum, self.n_trail_fx, 1);
    }
    self.n_trail_fx = undefined;
}

// Namespace _zm_weap_gravityspikes
// Params 7, eflags: 0x1 linked
// Checksum 0xc43e3a6, Offset: 0x1868
// Size: 0x8c
function gravity_spike_zombie_explode(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    playfxontag(localclientnum, level._effect["gravity_spike_zombie_explode"], self, "j_spine4");
}

