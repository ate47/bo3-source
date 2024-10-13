#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weap_riotshield;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_elemental_zombies;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/_burnplayer;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/aat_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/mechz;
#using scripts/codescripts/struct;

#using_animtree("mechz_claw");

#namespace zm_ai_mechz_claw;

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x2
// Checksum 0x9ec616a5, Offset: 0x8a0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_ai_mechz_claw", &__init__, &__main__, undefined);
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x1 linked
// Checksum 0x31ef4976, Offset: 0x8e8
// Size: 0x18c
function __init__() {
    function_f20c04a4();
    spawner::add_archetype_spawn_function("mechz", &function_1aacf7d4);
    level.var_be0eac62 = 7000;
    level.var_ca204e3d = &function_671deda5;
    level.var_78fafa94 = &function_6028875a;
    level.var_48d0c948 = &function_d6f31ed2;
    level flag::init("mechz_launching_claw");
    level flag::init("mechz_claw_move_complete");
    clientfield::register("actor", "mechz_fx", 21000, 12, "int");
    clientfield::register("scriptmover", "mechz_claw", 21000, 1, "int");
    clientfield::register("actor", "mechz_wpn_source", 21000, 1, "int");
    clientfield::register("toplayer", "mechz_grab", 21000, 1, "int");
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0x99ec1590, Offset: 0xa80
// Size: 0x4
function private __main__() {
    
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0xfbfb3fd1, Offset: 0xa90
// Size: 0x164
function private function_f20c04a4() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMechzShouldShootClaw", &function_bdc90f38);
    behaviortreenetworkutility::registerbehaviortreeaction("zmMechzShootClawAction", &function_86ac6346, &function_a94df749, &function_1b118e5);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMechzShootClaw", &function_456e76fa);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMechzUpdateClaw", &function_a844c266);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMechzStopClaw", &function_75278fab);
    animationstatenetwork::registernotetrackhandlerfunction("muzzleflash", &function_de3abdba);
    animationstatenetwork::registernotetrackhandlerfunction("start_ft", &function_48c03479);
    animationstatenetwork::registernotetrackhandlerfunction("stop_ft", &function_235008e3);
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x5 linked
// Checksum 0x907b18c3, Offset: 0xc00
// Size: 0x2b2
function private function_bdc90f38(entity) {
    if (!isdefined(entity.favoriteenemy)) {
        return 0;
    }
    if (!(isdefined(entity.var_6d2e297f) && entity.var_6d2e297f)) {
        return 0;
    }
    if (isdefined(entity.var_b0d416a3) && gettime() - self.var_b0d416a3 < level.var_be0eac62) {
        return 0;
    }
    if (isdefined(entity.berserk) && entity.berserk) {
        return 0;
    }
    if (!entity namespace_e907cf54::function_65b0f653()) {
        return 0;
    }
    dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
    if (dist_sq < 40000 || dist_sq > 1000000) {
        return 0;
    }
    if (!entity.favoriteenemy function_a3e432fd()) {
        return 0;
    }
    var_acb1e176 = zm_zonemgr::get_zone_from_position(self.origin + (0, 0, 36));
    if (isdefined(var_acb1e176) && "ug_bottom_zone" == var_acb1e176) {
        return 0;
    }
    clip_mask = 1 | 8;
    var_e8b2869 = entity.origin + (0, 0, 65);
    trace = physicstrace(var_e8b2869, entity.favoriteenemy.origin + (0, 0, 30), (-15, -15, -20), (15, 15, 40), entity, clip_mask);
    b_cansee = isdefined(trace["entity"]) && (trace["fraction"] == 1 || trace["entity"] == entity.favoriteenemy);
    if (!b_cansee) {
        return 0;
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0xb0e1850e, Offset: 0xec0
// Size: 0x4e
function private function_a3e432fd() {
    if (self getstance() == "prone") {
        return false;
    }
    if (!zm_utility::is_player_valid(self)) {
        return false;
    }
    return true;
}

// Namespace zm_ai_mechz_claw
// Params 2, eflags: 0x5 linked
// Checksum 0x352735e5, Offset: 0xf18
// Size: 0x48
function private function_86ac6346(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    function_456e76fa(entity);
    return 5;
}

// Namespace zm_ai_mechz_claw
// Params 2, eflags: 0x5 linked
// Checksum 0xffb16407, Offset: 0xf68
// Size: 0x44
function private function_a94df749(entity, asmstatename) {
    if (!(isdefined(entity.var_7bee990f) && entity.var_7bee990f)) {
        return 4;
    }
    return 5;
}

// Namespace zm_ai_mechz_claw
// Params 2, eflags: 0x5 linked
// Checksum 0x9cf512ef, Offset: 0xfb8
// Size: 0x18
function private function_1b118e5(entity, asmstatename) {
    return 4;
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x5 linked
// Checksum 0xa327e930, Offset: 0xfd8
// Size: 0x44
function private function_456e76fa(entity) {
    self thread function_31c4b972();
    level flag::set("mechz_launching_claw");
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x5 linked
// Checksum 0x2ffbd5c6, Offset: 0x1028
// Size: 0xc
function private function_a844c266(entity) {
    
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x5 linked
// Checksum 0x5b9513e3, Offset: 0x1040
// Size: 0xc
function private function_75278fab(entity) {
    
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x5 linked
// Checksum 0x8d09aca8, Offset: 0x1058
// Size: 0x60
function private function_de3abdba(entity) {
    self.var_7bee990f = 1;
    self.var_b0d416a3 = gettime();
    entity function_672f9804();
    entity function_90832db7();
    self.var_b0d416a3 = gettime();
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x5 linked
// Checksum 0x4e70c510, Offset: 0x10c0
// Size: 0x64
function private function_48c03479(entity) {
    entity notify(#"hash_8225d137");
    entity clientfield::set("mechz_ft", 1);
    entity.var_ee93e137 = 1;
    entity thread function_fa513ca0();
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0xc2ac5bef, Offset: 0x1130
// Size: 0x118
function private function_fa513ca0() {
    self endon(#"death");
    self endon(#"hash_8225d137");
    while (true) {
        players = getplayers();
        foreach (player in players) {
            if (!(isdefined(player.is_burning) && player.is_burning)) {
                if (player istouching(self.var_ec9023a6)) {
                    player thread namespace_648c84b6::function_58121b44(self);
                }
            }
        }
        wait 0.05;
    }
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x5 linked
// Checksum 0xff08a825, Offset: 0x1250
// Size: 0x72
function private function_235008e3(entity) {
    entity notify(#"hash_8225d137");
    entity clientfield::set("mechz_ft", 0);
    entity.var_ee93e137 = 0;
    entity.var_43025ce8 = gettime() + 7500;
    entity.var_5cff5e58 = undefined;
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0xd1a9ed74, Offset: 0x12d0
// Size: 0x2ec
function private function_1aacf7d4() {
    if (isdefined(self.var_19cbb780)) {
        self.var_19cbb780 delete();
        self.var_19cbb780 = undefined;
    }
    self.var_34297332 = 0;
    org = self gettagorigin("tag_claw");
    ang = self gettagangles("tag_claw");
    self.var_19cbb780 = spawn("script_model", org);
    self.var_19cbb780 setmodel("c_t7_zm_dlchd_origins_mech_claw");
    self.var_19cbb780.angles = ang;
    self.var_19cbb780 linkto(self, "tag_claw");
    self.var_19cbb780 useanimtree(#mechz_claw);
    if (isdefined(self.var_3cc92ad9)) {
        self.var_3cc92ad9 unlink();
        self.var_3cc92ad9 delete();
        self.var_3cc92ad9 = undefined;
    }
    var_8677d6f8 = 0;
    trigger_radius = 3;
    trigger_height = 15;
    self.var_3cc92ad9 = spawn("script_model", org);
    self.var_3cc92ad9 setmodel("p7_chemistry_kit_large_bottle");
    ang = combineangles((-90, 0, 0), ang);
    self.var_3cc92ad9.angles = ang;
    self.var_3cc92ad9 hide();
    self.var_3cc92ad9 setcandamage(1);
    self.var_3cc92ad9.health = 10000;
    self.var_3cc92ad9 enablelinkto();
    self.var_3cc92ad9 linkto(self, "tag_claw");
    self thread function_5dfc412a();
    self hidepart("tag_claw");
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0x34e549ba, Offset: 0x15c8
// Size: 0x166
function private function_5dfc412a() {
    self endon(#"death");
    self.var_3cc92ad9 endon(#"death");
    while (true) {
        amount, inflictor, direction, point, type, tagname, modelname, partname, weaponname, idflags = self.var_3cc92ad9 waittill(#"damage");
        self.var_3cc92ad9.health = 10000;
        if (self.var_19cbb780 islinkedto(self)) {
            continue;
        }
        if (zm_utility::is_player_valid(inflictor)) {
            self dodamage(1, inflictor.origin, inflictor, inflictor, "left_hand", type);
            self.var_19cbb780 setcandamage(0);
            self notify(#"hash_23a11a8");
        }
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0x4ab73000, Offset: 0x1738
// Size: 0x4c
function private function_31c4b972() {
    self endon(#"claw_complete");
    self util::waittill_either("death", "kill_claw");
    self function_90832db7();
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0x3488fb5d, Offset: 0x1790
// Size: 0x3c4
function private function_90832db7() {
    self.var_34297332 &= ~256;
    self.var_34297332 &= ~64;
    self clientfield::set("mechz_fx", self.var_34297332);
    self function_9bfd96c8();
    if (isdefined(self.var_19cbb780)) {
        self.var_19cbb780 clearanim(mechz_claw%root, 0.2);
        if (isdefined(self.var_19cbb780.fx_ent)) {
            self.var_19cbb780.fx_ent delete();
            self.var_19cbb780.fx_ent = undefined;
        }
        if (!(isdefined(self.var_6d2e297f) && self.var_6d2e297f)) {
            self function_4208b4ec();
            level flag::clear("mechz_launching_claw");
        } else {
            if (!self.var_19cbb780 islinkedto(self)) {
                var_b17f4f7a = self gettagorigin("tag_claw");
                var_e3883c1c = self gettagangles("tag_claw");
                n_dist = distance(self.var_19cbb780.origin, var_b17f4f7a);
                n_time = n_dist / 1000;
                self.var_19cbb780 moveto(var_b17f4f7a, max(0.05, n_time));
                self.var_19cbb780 playloopsound("zmb_ai_mechz_claw_loop_in", 0.1);
                self.var_19cbb780 waittill(#"movedone");
                var_b17f4f7a = self gettagorigin("tag_claw");
                var_e3883c1c = self gettagangles("tag_claw");
                self.var_19cbb780 playsound("zmb_ai_mechz_claw_back");
                self.var_19cbb780 stoploopsound(1);
                self.var_19cbb780.origin = var_b17f4f7a;
                self.var_19cbb780.angles = var_e3883c1c;
                self.var_19cbb780 clearanim(mechz_claw%root, 0.2);
                self.var_19cbb780 linkto(self, "tag_claw", (0, 0, 0));
            }
            self.var_19cbb780 setanim(mechz_claw%ai_zombie_mech_grapple_arm_closed_idle, 1, 0.2, 1);
        }
    }
    self notify(#"claw_complete");
    self.var_7bee990f = 0;
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0xc95b0cc8, Offset: 0x1b60
// Size: 0x136
function private function_4208b4ec() {
    if (isdefined(self.var_19cbb780)) {
        self.var_19cbb780 setanim(mechz_claw%ai_zombie_mech_grapple_arm_open_idle, 1, 0.2, 1);
        if (isdefined(self.var_19cbb780.fx_ent)) {
            self.var_19cbb780.fx_ent delete();
        }
        self.var_19cbb780 unlink();
        self.var_19cbb780 physicslaunch(self.var_19cbb780.origin, (0, 0, -1));
        self.var_19cbb780 thread function_36db86b();
        self.var_19cbb780 = undefined;
    }
    if (isdefined(self.var_3cc92ad9)) {
        self.var_3cc92ad9 unlink();
        self.var_3cc92ad9 delete();
        self.var_3cc92ad9 = undefined;
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0x170a4a0c, Offset: 0x1ca0
// Size: 0x1c
function private function_36db86b() {
    wait 30;
    self delete();
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x5 linked
// Checksum 0x3726cb94, Offset: 0x1cc8
// Size: 0x1dc
function private function_9bfd96c8(var_48b8dde0) {
    self.var_9091a4b = undefined;
    if (isdefined(self.conehalfheight)) {
        if (isplayer(self.conehalfheight)) {
            self.conehalfheight clientfield::set_to_player("mechz_grab", 0);
            self.conehalfheight allowcrouch(1);
            self.conehalfheight allowprone(1);
        }
        if (!isdefined(self.conehalfheight.var_47f07922)) {
            trace_start = self.conehalfheight.origin + (0, 0, 70);
            trace_end = self.conehalfheight.origin + (0, 0, -500);
            var_b8cd7800 = playerphysicstrace(trace_start, trace_end) + (0, 0, 24);
            self.conehalfheight unlink();
            self.conehalfheight setorigin(var_b8cd7800);
        }
        self.conehalfheight = undefined;
        if (isdefined(var_48b8dde0) && var_48b8dde0) {
            self.var_19cbb780 setanim(mechz_claw%ai_zombie_mech_grapple_arm_open_idle, 1, 0.2, 1);
        }
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0x821df5f5, Offset: 0x1eb0
// Size: 0x2c
function private function_7c33f4fb() {
    if (!isdefined(self.var_5ad1fcf3)) {
        self.var_5ad1fcf3 = 0;
    }
    self.var_9091a4b = self.var_5ad1fcf3;
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0x941d14bb, Offset: 0x1ee8
// Size: 0x3c
function private function_d6f31ed2() {
    self namespace_e907cf54::hide_part("tag_claw");
    self.var_19cbb780 hide();
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x5 linked
// Checksum 0xa7799255, Offset: 0x1f30
// Size: 0xac
function private function_5f5eaf3a(var_99c3dd59) {
    self endon(#"disconnect");
    self zm_audio::create_and_play_dialog("general", "mech_grab");
    while (isdefined(self.isspeaking) && isdefined(self) && self.isspeaking) {
        wait 0.1;
    }
    wait 1;
    if (isalive(var_99c3dd59) && isdefined(var_99c3dd59.conehalfheight)) {
        var_99c3dd59 thread function_368dc30e();
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0xba759057, Offset: 0x1fe8
// Size: 0x188
function private function_368dc30e() {
    self endon(#"death");
    while (true) {
        if (!isdefined(self.conehalfheight)) {
            return;
        }
        a_players = getplayers();
        foreach (player in a_players) {
            if (player == self.conehalfheight) {
                continue;
            }
            if (distancesquared(self.origin, player.origin) < 1000000) {
                if (player util::is_player_looking_at(self.origin + (0, 0, 60), 0.75)) {
                    if (!(isdefined(player.dontspeak) && player.dontspeak)) {
                        player zm_audio::create_and_play_dialog("general", "shoot_mech_arm");
                        return;
                    }
                }
            }
        }
        wait 0.1;
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0x75701f2f, Offset: 0x2178
// Size: 0x2c
function private function_671deda5() {
    if (isdefined(self.conehalfheight)) {
        self thread function_9bfd96c8(1);
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0x34b66ba7, Offset: 0x21b0
// Size: 0x5c
function private function_6028875a() {
    if (isdefined(self.var_9091a4b)) {
        if (isdefined(self.conehalfheight) && self.var_5ad1fcf3 - self.var_9091a4b > self.var_46b8e412) {
            self.var_77116375 = 1;
            self thread function_9bfd96c8();
        }
    }
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x5 linked
// Checksum 0x169f6e1e, Offset: 0x2218
// Size: 0x94
function private function_8b0a73b5(mechz) {
    self endon(#"death");
    self endon(#"disconnect");
    mechz endon(#"death");
    mechz endon(#"claw_complete");
    mechz endon(#"kill_claw");
    while (true) {
        if (isdefined(self) && self laststand::player_is_in_laststand()) {
            mechz thread function_9bfd96c8();
            return;
        }
        wait 0.05;
    }
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x5 linked
// Checksum 0xe32c1eff, Offset: 0x22b8
// Size: 0x92
function private function_bed84b4(mechz) {
    self endon(#"death");
    self endon(#"disconnect");
    mechz endon(#"death");
    mechz endon(#"claw_complete");
    mechz endon(#"kill_claw");
    while (true) {
        self waittill(#"bgb_activation_request");
        if (isdefined(self) && self.bgb === "zm_bgb_anywhere_but_here") {
            mechz thread function_9bfd96c8();
            return;
        }
    }
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x5 linked
// Checksum 0xf69e84ff, Offset: 0x2358
// Size: 0x7a
function private function_38d105a4(mechz) {
    self endon(#"death");
    self endon(#"disconnect");
    mechz endon(#"death");
    mechz endon(#"claw_complete");
    mechz endon(#"kill_claw");
    while (true) {
        self waittill(#"hash_e2be4752");
        mechz thread function_9bfd96c8();
        return;
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0xf302a04c, Offset: 0x23e0
// Size: 0xe4c
function private function_672f9804() {
    self endon(#"death");
    self endon(#"kill_claw");
    if (!isdefined(self.favoriteenemy)) {
        return;
    }
    var_b17f4f7a = self gettagorigin("tag_claw");
    var_e3883c1c = vectortoangles(self.origin - self.favoriteenemy.origin);
    self.var_34297332 |= 256;
    self clientfield::set("mechz_fx", self.var_34297332);
    self.var_19cbb780 setanim(mechz_claw%ai_zombie_mech_grapple_arm_open_idle, 1, 0, 1);
    self.var_19cbb780 unlink();
    self.var_19cbb780.fx_ent = spawn("script_model", self.var_19cbb780 gettagorigin("tag_claw"));
    self.var_19cbb780.fx_ent.angles = self.var_19cbb780 gettagangles("tag_claw");
    self.var_19cbb780.fx_ent setmodel("tag_origin");
    self.var_19cbb780.fx_ent linkto(self.var_19cbb780, "tag_claw");
    self.var_19cbb780.fx_ent clientfield::set("mechz_claw", 1);
    self clientfield::set("mechz_wpn_source", 1);
    var_4741e2d5 = self.favoriteenemy.origin + (0, 0, 36);
    n_dist = distance(var_b17f4f7a, var_4741e2d5);
    n_time = n_dist / 1200;
    self playsound("zmb_ai_mechz_claw_fire");
    self.var_19cbb780 moveto(var_4741e2d5, n_time);
    self.var_19cbb780 thread function_2998f2a1();
    self.var_19cbb780 playloopsound("zmb_ai_mechz_claw_loop_out", 0.1);
    self.conehalfheight = undefined;
    do {
        a_players = getplayers();
        foreach (player in a_players) {
            if (!zm_utility::is_player_valid(player, 1, 1) || !player function_a3e432fd()) {
                continue;
            }
            n_dist_sq = distancesquared(player.origin + (0, 0, 36), self.var_19cbb780.origin);
            if (n_dist_sq < 2304) {
                clip_mask = 1 | 8;
                var_7d76644b = self.origin + (0, 0, 65);
                trace = physicstrace(var_7d76644b, player.origin + (0, 0, 30), (-15, -15, -20), (15, 15, 40), self, clip_mask);
                b_cansee = isdefined(trace["entity"]) && (trace["fraction"] == 1 || trace["entity"] == player);
                if (!b_cansee) {
                    continue;
                }
                if (isdefined(player.hasriotshieldequipped) && isdefined(player.hasriotshield) && player.hasriotshield && player.hasriotshieldequipped) {
                    var_96f0db77 = level.zombie_vars["riotshield_hit_points"];
                    player riotshield::player_damage_shield(var_96f0db77 - 1, 1);
                    wait 1;
                    player riotshield::player_damage_shield(1, 1);
                } else {
                    self.conehalfheight = player;
                    self.conehalfheight clientfield::set_to_player("mechz_grab", 1);
                    self.conehalfheight playerlinktodelta(self.var_19cbb780, "tag_attach_player");
                    self.conehalfheight setplayerangles(vectortoangles(self.origin - self.conehalfheight.origin));
                    self.conehalfheight playsound("zmb_ai_mechz_claw_grab");
                    self.conehalfheight setstance("stand");
                    self.conehalfheight allowcrouch(0);
                    self.conehalfheight allowprone(0);
                    self.conehalfheight thread function_5f5eaf3a(self);
                    self.conehalfheight thread function_bed84b4(self);
                    self.conehalfheight thread function_38d105a4(self);
                    if (!level flag::get("mechz_claw_move_complete")) {
                        self.var_19cbb780 moveto(self.var_19cbb780.origin, 0.05);
                    }
                }
                break;
            }
        }
        wait 0.05;
    } while (!level flag::get("mechz_claw_move_complete") && !isdefined(self.conehalfheight));
    if (!isdefined(self.conehalfheight)) {
        a_ai_zombies = zombie_utility::get_round_enemy_array();
        foreach (ai_zombie in a_ai_zombies) {
            if (isdefined(ai_zombie.is_mechz) && (isdefined(ai_zombie.var_7b846142) && (!isalive(ai_zombie) || ai_zombie.var_7b846142) || ai_zombie.is_mechz)) {
                continue;
            }
            n_dist_sq = distancesquared(ai_zombie.origin + (0, 0, 36), self.var_19cbb780.origin);
            if (n_dist_sq < 2304) {
                self.conehalfheight = ai_zombie;
                self.conehalfheight linkto(self.var_19cbb780, "tag_attach_player", (0, 0, 0));
                self.conehalfheight.var_6db0c472 = self;
                break;
            }
        }
    }
    self.var_19cbb780 clearanim(mechz_claw%root, 0.2);
    self.var_19cbb780 setanim(mechz_claw%ai_zombie_mech_grapple_arm_closed_idle, 1, 0.2, 1);
    wait 0.5;
    if (isdefined(self.conehalfheight)) {
        n_time = n_dist / -56;
    } else {
        n_time = n_dist / 1000;
    }
    self function_7c33f4fb();
    var_b17f4f7a = self gettagorigin("tag_claw");
    var_e3883c1c = self gettagangles("tag_claw");
    self.var_19cbb780 moveto(var_b17f4f7a, max(0.05, n_time));
    self.var_19cbb780 playloopsound("zmb_ai_mechz_claw_loop_in", 0.1);
    self.var_19cbb780 waittill(#"movedone");
    var_b17f4f7a = self gettagorigin("tag_claw");
    var_e3883c1c = self gettagangles("tag_claw");
    self.var_19cbb780 playsound("zmb_ai_mechz_claw_back");
    self.var_19cbb780 stoploopsound(1);
    if (zm_audio::sndisnetworksafe()) {
        self playsound("zmb_ai_mechz_vox_angry");
    }
    self.var_19cbb780.origin = var_b17f4f7a;
    self.var_19cbb780.angles = var_e3883c1c;
    self.var_19cbb780 clearanim(mechz_claw%root, 0.2);
    self.var_19cbb780 linkto(self, "tag_claw", (0, 0, 0));
    self.var_19cbb780 setanim(mechz_claw%ai_zombie_mech_grapple_arm_closed_idle, 1, 0.2, 1);
    self.var_19cbb780.fx_ent delete();
    self.var_19cbb780.fx_ent = undefined;
    self.var_34297332 &= ~256;
    self clientfield::set("mechz_fx", self.var_34297332);
    self clientfield::set("mechz_wpn_source", 0);
    level flag::clear("mechz_launching_claw");
    if (isdefined(self.conehalfheight)) {
        if (isplayer(self.conehalfheight) && zm_utility::is_player_valid(self.conehalfheight)) {
            self.conehalfheight thread function_8b0a73b5(self);
        } else if (isai(self.conehalfheight)) {
            self.conehalfheight thread function_860f0461(self);
        }
        self thread function_eb9df173(self.conehalfheight);
        self animscripted("flamethrower_anim", self.origin, self.angles, "ai_zombie_mech_ft_burn_player");
        self zombie_shared::donotetracks("flamethrower_anim");
    }
    level flag::clear("mechz_claw_move_complete");
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x5 linked
// Checksum 0x96078390, Offset: 0x3238
// Size: 0x1aa
function private function_eb9df173(player) {
    player endon(#"death");
    player endon(#"disconnect");
    self endon(#"death");
    self endon(#"claw_complete");
    self endon(#"kill_claw");
    self thread function_7792d05e(player);
    player thread function_d0e280a0(self);
    self.var_19cbb780 setcandamage(1);
    while (isdefined(self.conehalfheight)) {
        amount, inflictor, direction, point, type, tagname, modelname, partname, weaponname, idflags = self.var_19cbb780 waittill(#"damage");
        if (zm_utility::is_player_valid(inflictor)) {
            self dodamage(1, inflictor.origin, inflictor, inflictor, "left_hand", type);
            self.var_19cbb780 setcandamage(0);
            self notify(#"hash_23a11a8");
            break;
        }
    }
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x5 linked
// Checksum 0xd27c5750, Offset: 0x33f0
// Size: 0x8c
function private function_7792d05e(player) {
    self endon(#"hash_23a11a8");
    player endon(#"death");
    player endon(#"disconnect");
    self util::waittill_any("death", "claw_complete", "kill_claw");
    if (isdefined(self) && isdefined(self.var_19cbb780)) {
        self.var_19cbb780 setcandamage(0);
    }
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x5 linked
// Checksum 0xbb4ac903, Offset: 0x3488
// Size: 0xa4
function private function_d0e280a0(mechz) {
    mechz endon(#"hash_23a11a8");
    mechz endon(#"death");
    mechz endon(#"claw_complete");
    mechz endon(#"kill_claw");
    self util::waittill_any("death", "disconnect");
    if (isdefined(mechz) && isdefined(mechz.var_19cbb780)) {
        mechz.var_19cbb780 setcandamage(0);
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x5 linked
// Checksum 0x7fdf7c4b, Offset: 0x3538
// Size: 0x34
function private function_2998f2a1() {
    self waittill(#"movedone");
    wait 0.05;
    level flag::set("mechz_claw_move_complete");
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x5 linked
// Checksum 0xb7441423, Offset: 0x3578
// Size: 0x94
function private function_860f0461(mechz) {
    mechz waittillmatch(#"flamethrower_anim", "start_ft");
    if (isalive(self)) {
        self dodamage(self.health, self.origin, self);
        self zombie_utility::gib_random_parts();
        gibserverutils::annihilate(self);
    }
}

