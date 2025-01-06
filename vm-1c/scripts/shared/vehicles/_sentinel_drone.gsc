#using scripts/codescripts/struct;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;

#using_animtree("generic");

#namespace sentinel_drone;

// Namespace sentinel_drone
// Params 0, eflags: 0x2
// Checksum 0x14959206, Offset: 0xb98
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("sentinel_drone", &__init__, undefined, undefined);
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xe37725f6, Offset: 0xbd8
// Size: 0x73e
function __init__() {
    clientfield::register("scriptmover", "sentinel_drone_beam_set_target_id", 12000, 5, "int");
    clientfield::register("vehicle", "sentinel_drone_beam_set_source_to_target", 12000, 5, "int");
    clientfield::register("toplayer", "sentinel_drone_damage_player_fx", 12000, 1, "counter");
    clientfield::register("vehicle", "sentinel_drone_beam_fire1", 12000, 1, "int");
    clientfield::register("vehicle", "sentinel_drone_beam_fire2", 12000, 1, "int");
    clientfield::register("vehicle", "sentinel_drone_beam_fire3", 12000, 1, "int");
    clientfield::register("vehicle", "sentinel_drone_arm_cut_1", 12000, 1, "int");
    clientfield::register("vehicle", "sentinel_drone_arm_cut_2", 12000, 1, "int");
    clientfield::register("vehicle", "sentinel_drone_arm_cut_3", 12000, 1, "int");
    clientfield::register("vehicle", "sentinel_drone_face_cut", 12000, 1, "int");
    clientfield::register("vehicle", "sentinel_drone_beam_charge", 12000, 1, "int");
    clientfield::register("vehicle", "sentinel_drone_camera_scanner", 12000, 1, "int");
    clientfield::register("vehicle", "sentinel_drone_camera_destroyed", 12000, 1, "int");
    clientfield::register("scriptmover", "sentinel_drone_deathfx", 1, 1, "int");
    vehicle::add_main_callback("sentinel_drone", &function_ea83a33b);
    level.var_da3f186 = [];
    if (!isdefined(level.var_da3f186)) {
        level.var_da3f186 = [];
    } else if (!isarray(level.var_da3f186)) {
        level.var_da3f186 = array(level.var_da3f186);
    }
    level.var_da3f186[level.var_da3f186.size] = "vox_valk_valkyrie_detected_0";
    if (!isdefined(level.var_da3f186)) {
        level.var_da3f186 = [];
    } else if (!isarray(level.var_da3f186)) {
        level.var_da3f186 = array(level.var_da3f186);
    }
    level.var_da3f186[level.var_da3f186.size] = "vox_valk_valkyrie_detected_1";
    if (!isdefined(level.var_da3f186)) {
        level.var_da3f186 = [];
    } else if (!isarray(level.var_da3f186)) {
        level.var_da3f186 = array(level.var_da3f186);
    }
    level.var_da3f186[level.var_da3f186.size] = "vox_valk_valkyrie_detected_2";
    if (!isdefined(level.var_da3f186)) {
        level.var_da3f186 = [];
    } else if (!isarray(level.var_da3f186)) {
        level.var_da3f186 = array(level.var_da3f186);
    }
    level.var_da3f186[level.var_da3f186.size] = "vox_valk_valkyrie_detected_3";
    if (!isdefined(level.var_da3f186)) {
        level.var_da3f186 = [];
    } else if (!isarray(level.var_da3f186)) {
        level.var_da3f186 = array(level.var_da3f186);
    }
    level.var_da3f186[level.var_da3f186.size] = "vox_valk_valkyrie_detected_4";
    level.var_5fc16234 = [];
    if (!isdefined(level.var_5fc16234)) {
        level.var_5fc16234 = [];
    } else if (!isarray(level.var_5fc16234)) {
        level.var_5fc16234 = array(level.var_5fc16234);
    }
    level.var_5fc16234[level.var_5fc16234.size] = "vox_valk_valkyrie_health_low_0";
    if (!isdefined(level.var_5fc16234)) {
        level.var_5fc16234 = [];
    } else if (!isarray(level.var_5fc16234)) {
        level.var_5fc16234 = array(level.var_5fc16234);
    }
    level.var_5fc16234[level.var_5fc16234.size] = "vox_valk_valkyrie_health_low_1";
    if (!isdefined(level.var_5fc16234)) {
        level.var_5fc16234 = [];
    } else if (!isarray(level.var_5fc16234)) {
        level.var_5fc16234 = array(level.var_5fc16234);
    }
    level.var_5fc16234[level.var_5fc16234.size] = "vox_valk_valkyrie_health_low_2";
    if (!isdefined(level.var_5fc16234)) {
        level.var_5fc16234 = [];
    } else if (!isarray(level.var_5fc16234)) {
        level.var_5fc16234 = array(level.var_5fc16234);
    }
    level.var_5fc16234[level.var_5fc16234.size] = "vox_valk_valkyrie_health_low_3";
    if (!isdefined(level.var_5fc16234)) {
        level.var_5fc16234 = [];
    } else if (!isarray(level.var_5fc16234)) {
        level.var_5fc16234 = array(level.var_5fc16234);
    }
    level.var_5fc16234[level.var_5fc16234.size] = "vox_valk_valkyrie_health_low_4";
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x4bb131f1, Offset: 0x1320
// Size: 0x58c
function function_ea83a33b() {
    self useanimtree(#generic);
    target_set(self, (0, 0, 0));
    self.health = self.healthdefault;
    if (!isdefined(level.var_836f8023)) {
        level.var_836f8023 = self.health;
    }
    self.maxhealth = level.var_836f8023;
    if (!isdefined(level.var_f30e446c)) {
        level.var_f30e446c = -56;
    }
    if (!isdefined(level.var_6b250a03)) {
        level.var_6b250a03 = -56;
    }
    if (!isdefined(level.var_a8c2ef68)) {
        level.var_a8c2ef68 = -56;
    }
    if (!isdefined(level.var_b24be8f0)) {
        level.var_b24be8f0 = -56;
    }
    if (!isdefined(level.var_f36b0ec6)) {
        level.var_f36b0ec6 = 300;
    }
    if (!isdefined(level.var_218f2356)) {
        level.var_218f2356 = 100;
    }
    self.var_4989d42a = [];
    self.var_4989d42a[2] = level.var_f30e446c;
    self.var_4989d42a[1] = level.var_6b250a03;
    self.var_4989d42a[3] = level.var_a8c2ef68;
    self.var_b24be8f0 = level.var_b24be8f0;
    self.var_f36b0ec6 = level.var_f36b0ec6;
    self.var_218f2356 = level.var_218f2356;
    self.var_b75e6e79 = util::spawn_model("tag_origin", self.position, self.angles);
    if (!isdefined(level.var_cc9f03f2)) {
        level.var_cc9f03f2 = 0;
    }
    level.var_cc9f03f2 = (level.var_cc9f03f2 + 1) % 32;
    if (level.var_cc9f03f2 == 0) {
        level.var_cc9f03f2 = 1;
    }
    self.var_cdd8a831 = level.var_cc9f03f2;
    blackboard::createblackboardforentity(self);
    self blackboard::registervehicleblackboardattributes();
    ai::createinterfaceforentity(self);
    self vehicle::friendly_fire_shield();
    self enableaimassist();
    self setneargoalnotifydist(35);
    self setvehicleavoidance(1);
    self setdrawinfrared(1);
    self sethoverparams(0, 0, 10);
    self.no_gib = 1;
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.vehaircraftcollisionenabled = 1;
    assert(isdefined(self.scriptbundlesettings));
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.goalradius = 999999;
    self.goalheight = 4000;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self.var_b948f7a = 0;
    self.var_c5af3448 = 0;
    self.var_a91dcd28 = 3;
    setdvar("Sentinel_Move_Speed", 25);
    setdvar("Sentinel_Evade_Speed", 40);
    self.var_5de5a96c = 0;
    self.disable_flame_fx = 1;
    self.var_65eda69a = 1;
    self.var_4c646766 = gettime() + 1000 + randomint(1000);
    self.pers = [];
    self.pers["team"] = self.team;
    self.overridevehicledamage = &function_bfd6b3a;
    self.var_adbbf126 = &function_4ccd6c6d;
    if (!isdefined(level.var_979a2615)) {
        level.var_979a2615 = [];
    }
    array::add(level.var_979a2615, self);
    if (isdefined(level.var_171fdd35)) {
        self.var_c3cb9d57 = level.var_171fdd35;
    }
    self thread vehicle_ai::nudge_collision();
    self thread function_8d62fae7();
    self thread function_f1ce0a96();
    /#
        self thread function_dcfe661f();
        self thread function_ad2bc47f();
    #/
    defaultrole();
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x108bafd, Offset: 0x18b8
// Size: 0x90
function function_f1ce0a96() {
    self endon(#"death");
    if (!isdefined(self.var_4707ed01)) {
        wait 1;
        self.var_b75e6e79 clientfield::set("sentinel_drone_beam_set_target_id", self.var_cdd8a831);
        wait 0.1;
        self clientfield::set("sentinel_drone_beam_set_source_to_target", self.var_cdd8a831);
        wait 1;
        self.var_4707ed01 = 1;
    }
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xa8d77fc6, Offset: 0x1950
// Size: 0xb4
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self vehicle_ai::call_custom_add_state_callbacks();
    vehicle_ai::startinitialstate("combat");
}

// Namespace sentinel_drone
// Params 1, eflags: 0x4
// Checksum 0x83eece16, Offset: 0x1a10
// Size: 0x198
function private is_target_valid(target) {
    if (!isdefined(target)) {
        return false;
    }
    if (!isalive(target)) {
        return false;
    }
    if (isplayer(target) && target.sessionstate == "spectator") {
        return false;
    }
    if (isplayer(target) && target.sessionstate == "intermission") {
        return false;
    }
    if (isdefined(target.ignoreme) && target.ignoreme) {
        return false;
    }
    if (target isnotarget()) {
        return false;
    }
    if (isdefined(target.var_6c653628) && target.var_6c653628) {
        return false;
    }
    if (isdefined(level.var_f7c913a)) {
        if (![[ level.var_f7c913a ]](target)) {
            return false;
        }
    }
    if (isdefined(self.var_5de5a96c) && self.var_5de5a96c && isplayer(target)) {
        if (isdefined(function_ab641ee6())) {
            return false;
        }
    }
    return true;
}

// Namespace sentinel_drone
// Params 3, eflags: 0x0
// Checksum 0x429a4e, Offset: 0x1bb0
// Size: 0x9c
function function_ab641ee6(var_1ec2ee0c, var_c6731da, radius) {
    if (!isdefined(var_1ec2ee0c)) {
        var_1ec2ee0c = 1;
    }
    if (!isdefined(var_c6731da)) {
        var_c6731da = 1;
    }
    if (!isdefined(radius)) {
        radius = 2000;
    }
    if (isdefined(self.var_cafbb1d0)) {
        ai_zombie = [[ self.var_cafbb1d0 ]](self.origin, var_1ec2ee0c, var_c6731da, radius);
        return ai_zombie;
    }
    return undefined;
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x25a4874c, Offset: 0x1c58
// Size: 0x1ec
function function_f02617ec() {
    var_3f2eb28d = getplayers();
    least_hunted = var_3f2eb28d[0];
    var_308144dc = 2000 * 2000;
    for (i = 0; i < var_3f2eb28d.size; i++) {
        if (!isdefined(var_3f2eb28d[i].var_cc6115d2)) {
            var_3f2eb28d[i].var_cc6115d2 = 0;
        }
        if (!is_target_valid(var_3f2eb28d[i])) {
            continue;
        }
        if (!is_target_valid(least_hunted)) {
            least_hunted = var_3f2eb28d[i];
            continue;
        }
        dist_to_target_sq = distance2dsquared(self.origin, var_3f2eb28d[i].origin);
        var_57b120f3 = distance2dsquared(self.origin, least_hunted.origin);
        if (var_57b120f3 >= var_308144dc && dist_to_target_sq < var_308144dc) {
            least_hunted = var_3f2eb28d[i];
            continue;
        }
        if (var_3f2eb28d[i].var_cc6115d2 < least_hunted.var_cc6115d2) {
            least_hunted = var_3f2eb28d[i];
        }
    }
    if (!is_target_valid(least_hunted)) {
        return undefined;
    }
    return least_hunted;
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0x5cd21a5, Offset: 0x1e50
// Size: 0x184
function function_6446f90(enemy) {
    if (isdefined(self.var_5f321fd6)) {
        if (!isdefined(self.var_5f321fd6.var_cc6115d2)) {
            self.var_5f321fd6.var_cc6115d2 = 0;
        }
        if (self.var_5f321fd6.var_cc6115d2 > 0) {
            self.var_5f321fd6.var_cc6115d2--;
        }
    }
    if (!is_target_valid(enemy)) {
        self.var_5f321fd6 = undefined;
        self clearlookatent();
        self clearturrettarget(0);
        return;
    }
    self.var_5f321fd6 = enemy;
    if (isdefined(self.var_bd4e7246)) {
        if (isplayer(enemy)) {
            function_36da0be3(level.var_da3f186);
        }
    } else {
        self.var_bd4e7246 = 1;
    }
    if (!isdefined(self.var_5f321fd6.var_cc6115d2)) {
        self.var_5f321fd6.var_cc6115d2 = 0;
    }
    self.var_5f321fd6.var_cc6115d2++;
    self setlookatent(self.var_5f321fd6);
    self setturrettargetent(self.var_5f321fd6);
}

// Namespace sentinel_drone
// Params 0, eflags: 0x4
// Checksum 0xbef6f57f, Offset: 0x1fe0
// Size: 0xf8
function private function_85ecd02d() {
    self endon(#"change_state");
    self endon(#"death");
    for (;;) {
        if (isdefined(self.ignoreall) && self.ignoreall) {
            wait 0.5;
            continue;
        }
        if (is_target_valid(self.var_5f321fd6)) {
            wait 0.5;
            continue;
        }
        if (isdefined(self.var_5de5a96c) && self.var_5de5a96c) {
            target = function_ab641ee6();
            if (!isdefined(target)) {
                target = function_f02617ec();
            }
        } else {
            target = function_f02617ec();
        }
        function_6446f90(target);
        wait 0.5;
    }
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0x8a4ed1a5, Offset: 0x20e0
// Size: 0x1d0
function state_combat_update(params) {
    self endon(#"change_state");
    self endon(#"death");
    self.lasttimetargetinsight = 0;
    self.var_b948f7a = 0;
    wait 0.3;
    if (isdefined(self.owner) && isdefined(self.owner.enemy)) {
        self.var_5f321fd6 = self.owner.enemy;
    }
    thread function_85ecd02d();
    thread function_c06cc462();
    thread function_fbd5fc24();
    while (true) {
        if (isdefined(self.var_f3a353d6) && self.var_f3a353d6) {
            wait 0.1;
        } else if (isdefined(self.var_eecb28e1) && self.var_eecb28e1) {
            wait 0.1;
        } else if (isdefined(self.var_eebcd2ad) && !isdefined(self.var_8b06de4d) && self.var_eebcd2ad) {
            if (function_ae45ed34()) {
                thread function_c06cc462();
            }
        } else if (!isdefined(self.var_5f321fd6)) {
            wait 0.25;
        } else if (self.var_a91dcd28 > 0) {
            if (randomint(100) < 30) {
                if (self function_bca4bd7a()) {
                    thread function_c06cc462();
                }
            }
        }
        wait 0.1;
    }
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xecb70b5, Offset: 0x22b8
// Size: 0x3c
function function_ab6da2e2() {
    function_c28fa12c();
    self.var_f3a353d6 = 1;
    self asmrequestsubstate("intro@default");
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xe811dd29, Offset: 0x2300
// Size: 0x44
function function_d5314e71() {
    self.var_f3a353d6 = 0;
    if (!self vehicle_ai::is_instate("scripted")) {
        self thread function_c06cc462();
    }
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xda023dca, Offset: 0x2350
// Size: 0x4c8
function function_ae45ed34() {
    self endon(#"change_state");
    self endon(#"death");
    var_7ff21c44 = anglestoright(self.angles);
    var_7ff21c44 = vectornormalize(var_7ff21c44);
    var_ee4a08e4 = getdvarfloat("sentinel_drone_juke_initial_pause_dvar", 0.2);
    juke_speed = getdvarint("sentinel_drone_juke_speed_dvar", 300);
    var_b3c1e0a0 = getdvarint("sentinel_drone_juke_offset_dvar", 20);
    var_ad058604 = getdvarint("sentinel_drone_juke_distance_dvar", 100);
    var_7c5d60e7 = getdvarint("sentinel_drone_juke_distance_max_dvar", -6);
    var_b895864e = getdvarfloat("sentinel_drone_juke_min_anim_rate_dvar", 0.9);
    var_f2c22b45 = 0;
    if (math::cointoss()) {
        var_92709e6b = self.origin + vectorscale(var_7ff21c44, var_7c5d60e7);
        var_4876bf22 = "dodge_right@attack";
    } else {
        var_7ff21c44 = vectorscale(var_7ff21c44, -1);
        var_92709e6b = self.origin - vectorscale(var_7ff21c44, var_7c5d60e7 * -1);
        var_4876bf22 = "dodge_left@attack";
    }
    trace = function_e6cdb4ef(self.origin, var_92709e6b, self, 1);
    if (isdefined(trace["position"])) {
        if (!ispointinnavvolume(trace["position"], "navvolume_small")) {
            trace["position"] = self getclosestpointonnavvolume(trace["position"], 100);
        }
        if (isdefined(trace["position"])) {
            if (trace["fraction"] == 1) {
                var_c9a8a34e = var_7c5d60e7 - var_b3c1e0a0;
            } else {
                var_c9a8a34e = var_7c5d60e7 * trace["fraction"] - var_b3c1e0a0;
            }
            if (var_c9a8a34e >= var_ad058604) {
                var_b52b4205 = var_ad058604 / var_c9a8a34e;
                if (var_b52b4205 < var_b895864e) {
                    var_b52b4205 = var_b895864e;
                }
                var_485905b8 = var_c9a8a34e / var_ad058604 * juke_speed;
                var_f2c22b45 = 1;
            }
        }
    }
    self.var_eebcd2ad = 0;
    if (var_f2c22b45) {
        function_c28fa12c();
        wait 0.1;
        self clientfield::set("sentinel_drone_camera_scanner", 1);
        self asmrequestsubstate(var_4876bf22);
        self asmsetanimationrate(var_b52b4205);
        wait var_ee4a08e4;
        self setspeed(var_485905b8);
        self setvehvelocity(vectorscale(var_7ff21c44, var_485905b8));
        self setvehgoalpos(trace["position"], 1, 0);
        wait 1;
        self asmsetanimationrate(1);
        function_c28fa12c();
        self clientfield::set("sentinel_drone_camera_scanner", 0);
        wait 0.1;
    }
    if (math::cointoss()) {
        self function_bca4bd7a();
    }
    return var_f2c22b45;
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xa8730c5a, Offset: 0x2820
// Size: 0x27c
function function_c28fa12c() {
    self endon(#"change_state");
    self endon(#"death");
    self notify(#"hash_42404032");
    self notify(#"near_goal");
    wait 0.05;
    if (getdvarint("sentinel_NavigationStandStill_new", 0) > 0) {
        self clearvehgoalpos();
        self setvehvelocity((0, 0, 0));
        self.vehaircraftcollisionenabled = 1;
        /#
            if (getdvarint("<dev string:x28>") > 0) {
                recordsphere(self.origin, 30, (1, 0.5, 0));
            }
        #/
        return;
    }
    if (getdvarint("sentinel_ClearVehGoalPos", 1) == 1) {
        self clearvehgoalpos();
    }
    if (getdvarint("sentinel_PathVariableOffsetClear", 1) == 1) {
        self pathvariableoffsetclear();
    }
    if (getdvarint("sentinel_PathFixedOffsetClear", 1) == 1) {
        self pathfixedoffsetclear();
    }
    if (getdvarint("sentinel_ClearSpeed", 1) == 1) {
        self setspeed(0);
        self setvehvelocity((0, 0, 0));
        self setphysacceleration((0, 0, 0));
        self setangularvelocity((0, 0, 0));
    }
    self.vehaircraftcollisionenabled = 1;
    /#
        if (getdvarint("<dev string:x28>") > 0) {
            recordsphere(self.origin, 30, (1, 0.5, 0));
        }
    #/
}

// Namespace sentinel_drone
// Params 0, eflags: 0x4
// Checksum 0xa63be82b, Offset: 0x2aa8
// Size: 0xbe
function private function_7ad16dc4() {
    if (gettime() > self.var_b948f7a) {
        return true;
    }
    if (isdefined(self.var_5f321fd6)) {
        if (isdefined(self.var_f0d65155)) {
            if (gettime() - self.var_f0d65155 > 3000) {
                speed = self getspeed();
                if (speed < 1) {
                    if (!function_7e57f99c(self.origin, self.var_5f321fd6.origin + (0, 0, 48), 1)) {
                        return true;
                    }
                }
            }
        }
    }
    return false;
}

// Namespace sentinel_drone
// Params 0, eflags: 0x4
// Checksum 0x42a3c24c, Offset: 0x2b70
// Size: 0x10
function private function_b7a88435() {
    self.var_b948f7a = 0;
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x4d5a5ac4, Offset: 0x2b88
// Size: 0xa80
function function_c06cc462() {
    self endon(#"change_state");
    self endon(#"death");
    self endon(#"hash_42404032");
    self notify(#"hash_c06cc462");
    self endon(#"hash_c06cc462");
    lasttimechangeposition = 0;
    self.shouldgotonewposition = 0;
    self.var_f6b5bc23 = 0;
    Sentinel_Move_Speed = getdvarint("Sentinel_Move_Speed", 25);
    Sentinel_Evade_Speed = getdvarint("Sentinel_Evade_Speed", 40);
    self setspeed(Sentinel_Move_Speed);
    self asmrequestsubstate("locomotion@movement");
    self.current_pathto_pos = undefined;
    self.var_b4f49a80 = 0;
    var_bf311db = 1;
    while (true) {
        current_pathto_pos = undefined;
        var_f52922bb = 0;
        if (isdefined(self.var_f3a353d6) && self.var_f3a353d6) {
            wait 0.1;
        } else if (self.goalforced) {
            returndata = [];
            returndata["origin"] = self getclosestpointonnavvolume(self.goalpos, 100);
            returndata["centerOnNav"] = ispointinnavvolume(self.origin, "navvolume_small");
            current_pathto_pos = returndata["origin"];
        } else if (isdefined(self.var_8b06de4d)) {
            returndata = [];
            returndata["origin"] = self getclosestpointonnavvolume(self.var_8b06de4d, 100);
            returndata["centerOnNav"] = ispointinnavvolume(self.origin, "navvolume_small");
            current_pathto_pos = returndata["origin"];
        } else if (function_7ad16dc4()) {
            if (isdefined(self.var_29317efb) && self.var_29317efb) {
                self.var_29317efb = 0;
                self setspeed(Sentinel_Evade_Speed);
            } else {
                self setspeed(Sentinel_Move_Speed);
            }
            returndata = function_b57b1706(self.var_5de5a96c);
            current_pathto_pos = returndata["origin"];
            self.var_f0d65155 = gettime();
            self.var_b948f7a = gettime() + 1000 + randomint(4000);
            var_f52922bb = 1;
        } else if (gettime() > self.var_b4f49a80 && function_ae15e4ec(self.origin, 100)) {
            self.var_29317efb = 1;
            self.var_b4f49a80 = gettime() + 1000;
            self.var_b948f7a = 0;
            self notify(#"near_goal");
        }
        var_eba9ef7e = ispointinnavvolume(self.origin, "navvolume_small");
        /#
            if (getdvarint("<dev string:x44>", 0) == 1) {
                current_pathto_pos = undefined;
                var_eba9ef7e = 1;
            }
        #/
        if (isdefined(current_pathto_pos)) {
            if (isdefined(var_eba9ef7e) && isdefined(self.stucktime) && var_eba9ef7e) {
                self.stucktime = undefined;
            }
            /#
                if (getdvarint("<dev string:x28>") > 0) {
                    recordsphere(current_pathto_pos, 8, (0, 0, 1));
                }
            #/
            /#
                if (getdvarint("<dev string:x5c>") > 0) {
                    if (!ispointinnavvolume(current_pathto_pos, "<dev string:x77>")) {
                        recordline(current_pathto_pos, level.players[0].origin + (0, 0, 48), (1, 1, 1));
                        recordsphere(current_pathto_pos, 10, (1, 1, 1));
                        printtoprightln("<dev string:x87>" + self getentitynumber(), (1, 1, 1));
                    }
                    if (!(isdefined(var_eba9ef7e) && var_eba9ef7e)) {
                        recordline(self.origin, level.players[0].origin + (0, 0, 48), (0, 1, 0));
                        recordsphere(self.origin, 10, (0, 1, 0));
                        printtoprightln("<dev string:x98>" + self getentitynumber(), (0, 1, 0));
                    }
                }
            #/
            if (self setvehgoalpos(current_pathto_pos, 1, var_bf311db)) {
                var_bf311db = 1;
                self.var_f52922bb = var_f52922bb;
                self thread function_a0ac642f();
                self vehicle_ai::waittill_pathing_done(5);
                current_pathto_pos = undefined;
            } else if (isdefined(var_eba9ef7e) && var_eba9ef7e) {
                /#
                    if (getdvarint("<dev string:x5c>") > 0) {
                        printtoprightln("<dev string:xa5>" + self getentitynumber(), (1, 0, 0));
                        recordline(current_pathto_pos, level.players[0].origin + (0, 0, 48), (1, 0, 0));
                        recordsphere(current_pathto_pos, 10, (1, 0, 0));
                        recordline(self.origin, level.players[0].origin + (0, 0, 48), (1, 0.2, 0.2));
                        recordsphere(self.origin, 10, (1, 0, 0));
                    }
                #/
                self function_8a02f3d0();
                self.var_82e95b01 = undefined;
            }
        }
        if (!(isdefined(var_eba9ef7e) && var_eba9ef7e)) {
            if (!isdefined(self.var_82e95b01)) {
                self.var_82e95b01 = gettime();
            }
            if (gettime() - self.var_82e95b01 >= 3000) {
                self.var_f6b5bc23 = 0;
            } else {
                self.var_f6b5bc23++;
            }
            self.var_82e95b01 = gettime();
            if (self.var_f6b5bc23 > 25) {
                var_583e20b3 = self getclosestpointonnavvolume(self.origin, 120);
                if (isdefined(var_583e20b3)) {
                    dvar_sentinel_getback_to_volume_epsilon = getdvarint("dvar_sentinel_getback_to_volume_epsilon", 5);
                    if (distance(self.origin, var_583e20b3) < dvar_sentinel_getback_to_volume_epsilon) {
                        self.origin = var_583e20b3;
                        /#
                            if (getdvarint("<dev string:x28>") > 0) {
                                recordsphere(var_583e20b3, 8, (1, 0, 0));
                            }
                        #/
                    } else {
                        self.vehaircraftcollisionenabled = 0;
                        /#
                            if (getdvarint("<dev string:x28>") > 0) {
                                recordsphere(var_583e20b3, 8, (1, 0, 0));
                            }
                        #/
                        if (self setvehgoalpos(var_583e20b3, 1, 0)) {
                            self thread function_a0ac642f();
                            self vehicle_ai::waittill_pathing_done(5);
                            current_pathto_pos = undefined;
                        }
                        self.vehaircraftcollisionenabled = 1;
                    }
                } else if (self.var_f6b5bc23 > 100) {
                    self function_8a02f3d0();
                }
            }
        }
        if (!(isdefined(var_eba9ef7e) && var_eba9ef7e)) {
            if (!isdefined(self.stucktime)) {
                self.stucktime = gettime();
            }
            if (gettime() - self.stucktime > 15000) {
                self function_8a02f3d0();
            }
        }
        wait 0.1;
    }
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0x8cad2a6e, Offset: 0x3610
// Size: 0xec6
function function_b57b1706(var_618a6813) {
    self endon(#"change_state");
    self endon(#"death");
    if (isdefined(self.var_5f321fd6)) {
        selfdisttotarget = distance2d(self.origin, self.var_5f321fd6.origin);
    } else {
        selfdisttotarget = 0;
    }
    gooddist = 0.5 * (function_85f552ef() + function_1af7dd91());
    closedist = 1.2 * gooddist;
    fardist = 3 * gooddist;
    querymultiplier = mapfloat(closedist, fardist, 1, 3, selfdisttotarget);
    preferedheightrange = 0.5 * (function_227df48e() + function_75556350());
    randomness = 20;
    SENTINEL_DRONE_TOO_CLOSE_TO_SELF_DIST_EX = getdvarint("SENTINEL_DRONE_TOO_CLOSE_TO_SELF_DIST_EX", 70);
    SENTINEL_DRONE_MOVE_DIST_MAX_EX = getdvarint("SENTINEL_DRONE_MOVE_DIST_MAX_EX", 600);
    SENTINEL_DRONE_MOVE_SPACING = getdvarint("SENTINEL_DRONE_MOVE_SPACING", 25);
    SENTINEL_DRONE_RADIUS_EX = getdvarint("SENTINEL_DRONE_RADIUS_EX", 35);
    SENTINEL_DRONE_HIGHT_EX = getdvarint("SENTINEL_DRONE_HIGHT_EX", int(preferedheightrange));
    var_1ae3e20e = 1.5;
    var_6cf3475d = self.settings.engagementdistmin;
    var_642b5e53 = SENTINEL_DRONE_MOVE_DIST_MAX_EX;
    if (!(isdefined(var_618a6813) && var_618a6813) && isdefined(self.var_5f321fd6) && gettime() > self.var_4c646766) {
        var_be5ca9fb = self.var_5f321fd6.origin + (0, 0, 48);
        if (!ispointinnavvolume(var_be5ca9fb, "navvolume_small")) {
            closest_point_on_nav_volume = getdvarint("closest_point_on_nav_volume", 120);
            var_be5ca9fb = self getclosestpointonnavvolume(var_be5ca9fb, closest_point_on_nav_volume);
        }
        if (!isdefined(var_be5ca9fb)) {
            queryresult = positionquery_source_navigation(self.origin, SENTINEL_DRONE_TOO_CLOSE_TO_SELF_DIST_EX, SENTINEL_DRONE_MOVE_DIST_MAX_EX * querymultiplier, SENTINEL_DRONE_HIGHT_EX * querymultiplier, SENTINEL_DRONE_MOVE_SPACING, "navvolume_small", SENTINEL_DRONE_MOVE_SPACING * var_1ae3e20e);
        } else {
            if (function_5853dcd1()) {
                var_1ae3e20e = 1;
                SENTINEL_DRONE_MOVE_SPACING = 15;
                var_6cf3475d = self.settings.engagementdistmin * getdvarfloat("sentinel_query_min_dist", 0.2);
                var_642b5e53 *= 0.5;
            } else if (isdefined(self.var_f117ac20) && self.var_f117ac20 || function_5d3b9aa4()) {
                var_1ae3e20e = 1;
                SENTINEL_DRONE_MOVE_SPACING = 15;
                var_6cf3475d = self.settings.engagementdistmin * getdvarfloat("sentinel_query_min_dist", 0.5);
            }
            queryresult = positionquery_source_navigation(var_be5ca9fb, var_6cf3475d, var_642b5e53 * querymultiplier, SENTINEL_DRONE_HIGHT_EX * querymultiplier, SENTINEL_DRONE_MOVE_SPACING, "navvolume_small", SENTINEL_DRONE_MOVE_SPACING * var_1ae3e20e);
        }
    } else {
        queryresult = positionquery_source_navigation(self.origin, SENTINEL_DRONE_TOO_CLOSE_TO_SELF_DIST_EX, SENTINEL_DRONE_MOVE_DIST_MAX_EX * querymultiplier, SENTINEL_DRONE_HIGHT_EX * querymultiplier, SENTINEL_DRONE_MOVE_SPACING, "navvolume_small", SENTINEL_DRONE_MOVE_SPACING * var_1ae3e20e);
    }
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    if (isdefined(self.var_5f321fd6)) {
        if (randomint(100) > 15) {
            self vehicle_ai::positionquery_filter_engagementdist(queryresult, self.var_5f321fd6, function_85f552ef(), function_1af7dd91());
        }
        goalheight = self.var_5f321fd6.origin[2] + 0.5 * (function_75556350() + function_227df48e());
        enemy_origin = self.var_5f321fd6.origin + (0, 0, 48);
    } else {
        goalheight = self.origin[2] + 0.5 * (function_75556350() + function_227df48e());
        enemy_origin = self.origin;
    }
    best_point = undefined;
    best_score = undefined;
    trace_count = 0;
    foreach (point in queryresult.data) {
        if (function_7e57f99c(enemy_origin, point.origin)) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:xbe>"] = 25;
            #/
            point.score += 25;
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:xd7>"] = randomfloatrange(0, randomness);
        #/
        point.score += randomfloatrange(0, randomness);
        if (isdefined(point.distawayfromengagementarea)) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:xde>"] = point.distawayfromengagementarea * -1;
            #/
            point.score += point.distawayfromengagementarea * -1;
        }
        var_5c9baa31 = function_50edda43(point.origin, -56);
        if (isdefined(var_5c9baa31) && var_5c9baa31) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:xed>"] = -200;
            #/
            point.score += -200;
        }
        var_9958f944 = function_50edda43(point.origin, 100);
        if (isdefined(var_9958f944) && var_9958f944) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x101>"] = -2000;
            #/
            point.score += -2000;
        }
        var_2063a4d2 = function_ae15e4ec(point.origin, -106);
        if (isdefined(var_2063a4d2) && var_2063a4d2) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x118>"] = -200;
            #/
            point.score += -200;
        }
        distfrompreferredheight = abs(point.origin[2] - goalheight);
        if (distfrompreferredheight > preferedheightrange) {
            heightscore = (distfrompreferredheight - preferedheightrange) * 3;
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x12a>"] = heightscore * -1;
            #/
            point.score += heightscore * -1;
        }
        if (!isdefined(best_score)) {
            best_score = point.score;
            best_point = point;
            if (isdefined(self.var_5f321fd6)) {
                best_point.var_52a71e60 = int(bullettracepassed(point.origin, enemy_origin, 0, self, self.var_5f321fd6));
            } else {
                best_point.var_52a71e60 = int(bullettracepassed(point.origin, enemy_origin, 0, self));
            }
            continue;
        }
        if (point.score > best_score) {
            if (isdefined(self.var_5f321fd6)) {
                point.var_52a71e60 = int(bullettracepassed(point.origin, enemy_origin, 0, self, self.var_5f321fd6));
            } else {
                point.var_52a71e60 = int(bullettracepassed(point.origin, enemy_origin, 0, self));
            }
            if (point.var_52a71e60 >= best_point.var_52a71e60) {
                best_score = point.score;
                best_point = point;
            }
        }
    }
    if (isdefined(best_point)) {
        if (best_point.score < -1000) {
            best_point = undefined;
        }
    }
    self vehicle_ai::positionquery_debugscores(queryresult);
    /#
        if (isdefined(getdvarint("<dev string:x131>")) && getdvarint("<dev string:x131>")) {
            if (isdefined(best_point)) {
                recordline(self.origin, best_point.origin, (0.3, 1, 0));
            }
            if (isdefined(self.var_5f321fd6)) {
                recordline(self.origin, self.var_5f321fd6.origin, (1, 0, 0.4));
            }
        }
    #/
    returndata = [];
    returndata["origin"] = isdefined(best_point) ? best_point.origin : undefined;
    returndata["centerOnNav"] = queryresult.centeronnav;
    return returndata;
}

// Namespace sentinel_drone
// Params 3, eflags: 0x0
// Checksum 0x55ed72b4, Offset: 0x44e0
// Size: 0x38c
function function_fe5946f6(var_444ce0bc, time_out, var_be5ca9fb) {
    self endon(#"change_state");
    self endon(#"death");
    if (isdefined(time_out)) {
        var_8b930408 = gettime() + time_out;
    }
    if (!isdefined(var_be5ca9fb)) {
        if (isdefined(var_444ce0bc) && var_444ce0bc) {
            var_be5ca9fb = self.var_5f321fd6.origin + (0, 0, 48);
        } else {
            var_fa107381 = anglestoforward(self.angles);
            var_be5ca9fb = self.origin + var_fa107381 * length(self.var_5f321fd6.origin - self.origin);
            var_be5ca9fb = (var_be5ca9fb[0], var_be5ca9fb[1], self.var_5f321fd6.origin[2]);
        }
    }
    var_95222bef = vectornormalize(var_be5ca9fb - self.origin);
    var_be5ca9fb = self.origin + var_95222bef * 1200;
    self clearlookatent();
    self setvehgoalpos(var_be5ca9fb, 1, 0);
    self function_b4518657(var_be5ca9fb);
    while (true) {
        velocity = self getvelocity() * 0.1;
        velocitymag = length(velocity);
        if (velocitymag < 1) {
            velocitymag = 1;
        }
        predicted_pos = self.origin + velocity;
        offset = vectornormalize(predicted_pos - self.origin) * 35;
        trace = function_e6cdb4ef(self.origin + offset, predicted_pos + offset, self, 1);
        if (trace["fraction"] < 1) {
            if (!(isdefined(trace["entity"]) && trace["entity"].archetype === "zombie" && isdefined(trace["entity"].health) && trace["entity"].health == 0)) {
                function_8a02f3d0();
                return;
            }
        }
        if (isdefined(var_8b930408) && gettime() > var_8b930408) {
            function_8a02f3d0();
            return;
        }
        wait 0.1;
    }
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x2c5250a9, Offset: 0x4878
// Size: 0x138
function function_a0ac642f() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"near_goal");
    self endon(#"reached_end_node");
    self notify(#"hash_a0ac642f");
    self endon(#"hash_a0ac642f");
    skip_sentinel_PathUpdateInterrupt = getdvarint("skip_sentinel_PathUpdateInterrupt", 1);
    if (skip_sentinel_PathUpdateInterrupt == 1) {
        return;
    }
    wait 1;
    while (true) {
        if (isdefined(self.current_pathto_pos)) {
            if (distance2dsquared(self.origin, self.goalpos) < self.goalradius * self.goalradius) {
                /#
                    if (getdvarint("<dev string:x28>") > 0) {
                        recordsphere(self.origin, 30, (1, 0, 0));
                    }
                #/
                wait 0.2;
                self notify(#"near_goal");
            }
        }
        wait 0.2;
    }
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x3cc00f00, Offset: 0x49b8
// Size: 0x74
function function_fbd5fc24() {
    self endon(#"death");
    self endon(#"change_state");
    while (true) {
        while (function_ae15e4ec(self.origin, 120)) {
            self playrumbleonentity("damage_heavy");
            wait 0.1;
        }
        wait 0.5;
    }
}

// Namespace sentinel_drone
// Params 2, eflags: 0x0
// Checksum 0x3da810d, Offset: 0x4a38
// Size: 0x688
function function_46c1510d(var_5743760a, var_3dabddf3) {
    result = spawnstruct();
    result.can_see_enemy = 0;
    var_e3f29d5f = 0;
    var_6536a83d = 0;
    origin_point = var_5743760a;
    if (!isdefined(var_3dabddf3)) {
        target_point = self.var_5f321fd6.origin + (0, 0, 48);
        if (isplayer(self.var_5f321fd6)) {
            var_db2b7e6e = self.var_5f321fd6 getstance();
            if (var_db2b7e6e == "prone") {
                target_point = self.var_5f321fd6.origin + (0, 0, 2);
            }
        }
    } else {
        var_6536a83d = 1;
        target_point = var_3dabddf3;
    }
    var_9407ef2d = anglestoforward(self.angles);
    var_7815db60 = target_point - origin_point;
    if (vectordot(var_9407ef2d, var_7815db60) <= 0) {
        if (!var_6536a83d) {
            return result;
        } else {
            var_e3f29d5f = 1;
        }
    }
    if (!(isdefined(var_e3f29d5f) && var_e3f29d5f)) {
        var_3b8d6bb2 = anglestoright(self.angles);
        var_c7bcfc11 = (var_7815db60[0], var_7815db60[1], 0);
        var_a72ca1b7 = vectordot(var_c7bcfc11, var_3b8d6bb2);
        if (abs(var_a72ca1b7) > 50) {
            if (!var_6536a83d) {
                return result;
            } else {
                var_e3f29d5f = 1;
            }
        }
    }
    if (var_6536a83d) {
        var_7141264 = distance(target_point, origin_point);
        var_61d1b6a5 = target_point - origin_point;
        var_61d1b6a5 = vectornormalize(var_61d1b6a5);
        target_point = origin_point + vectorscale(var_61d1b6a5, 1200);
    }
    trace = function_e6cdb4ef(origin_point, target_point, self.var_5f321fd6, 0);
    /#
        if (getdvarint("<dev string:x28>") > 0) {
            recordline(origin_point, target_point, (0, 1, 0));
            recordsphere(target_point, 8);
        }
    #/
    result.var_c7a5b906 = trace["entity"];
    result.hit_position = trace["position"];
    if (isdefined(self.var_5de5a96c) && self.var_5de5a96c && isdefined(trace["entity"]) && isdefined(trace["entity"].archetype) && (isplayer(trace["entity"]) || trace["entity"].archetype == "zombie")) {
        result.can_see_enemy = 1;
        return result;
    }
    /#
        if (getdvarint("<dev string:x28>") > 0) {
            if (isdefined(trace["<dev string:x149>"]) && isdefined(trace["<dev string:x149>"].archetype) && trace["<dev string:x149>"].archetype == "<dev string:x150>" && !isalive(trace["<dev string:x149>"])) {
                printtoprightln("<dev string:x157>" + trace["<dev string:x149>"] getentitynumber() + "<dev string:x17f>" + gettime());
                recordline(origin_point, trace["<dev string:x183>"], (1, 0, 0));
                recordsphere(trace["<dev string:x183>"], 8, (1, 0, 0));
            }
        }
    #/
    if (isdefined(trace["entity"]) && isdefined(trace["entity"].archetype) && trace["entity"].archetype == "zombie" && !isalive(trace["entity"])) {
        trace = function_e6cdb4ef(origin_point, target_point, self.var_5f321fd6, 0, 1);
        if (trace["fraction"] == 1) {
            result.var_c7a5b906 = self.var_5f321fd6;
            result.hit_position = target_point;
            result.can_see_enemy = 1;
        }
    }
    return result;
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x5c61cf52, Offset: 0x50c8
// Size: 0x65c
function function_bca4bd7a() {
    if (isdefined(self.var_f3a353d6) && self.var_f3a353d6) {
        return false;
    }
    if (self.var_a91dcd28 <= 0) {
        return false;
    }
    if (!(isdefined(self.var_4707ed01) && self.var_4707ed01)) {
        wait 0.5;
        return false;
    }
    if (!isdefined(self.nextfiretime) || isdefined(self.var_5f321fd6) && gettime() > self.nextfiretime) {
        if (function_7e57f99c(self.origin, self.var_5f321fd6.origin + (0, 0, 48), 1) && (isdefined(self.var_f117ac20) && self.var_f117ac20 || isdefined(self.var_f52922bb) && self.var_f52922bb && function_5d3b9aa4() || ispointinnavvolume(self.origin, "navvolume_small")) && !function_50edda43(self.origin, 100)) {
            result = function_46c1510d(self.origin);
            if (result.can_see_enemy) {
                self.nextfiretime = gettime() + 2500 + randomint(2500);
                function_c28fa12c();
                wait 0.1;
                if (!isdefined(self.var_5f321fd6)) {
                    return true;
                }
                enemy_pos = self.var_5f321fd6.origin;
                if (randomint(100) < 70) {
                    var_5938824d = 1;
                }
                self.var_37e1dee9 = self.origin;
                if (isdefined(var_5938824d) && var_5938824d) {
                    var_9bc38be3 = "fire_succession@attack";
                } else {
                    var_9bc38be3 = "fire@attack";
                }
                self asmrequestsubstate(var_9bc38be3);
                self clientfield::set("sentinel_drone_beam_charge", 1);
                var_18a4d3ec = result.hit_position - self.origin;
                self.var_b75e6e79.origin = result.hit_position;
                self.var_b75e6e79.angles = vectortoangles(var_18a4d3ec * -1);
                /#
                    if (getdvarint("<dev string:x28>") > 0) {
                        recordline(self.origin, result.hit_position, (0.9, 0.7, 0.6));
                        recordsphere(result.hit_position, 8, (0.9, 0.7, 0.6));
                    }
                #/
                self clearlookatent();
                self.angles = vectortoangles(var_18a4d3ec);
                self setlookatent(self.var_b75e6e79);
                self setturrettargetent(self.var_b75e6e79);
                self waittill(#"hash_b759bcc1");
                self clientfield::set("sentinel_drone_beam_charge", 0);
                result = function_46c1510d(self.var_37e1dee9, result.hit_position);
                if (result.can_see_enemy) {
                    if (!(isdefined(var_5938824d) && var_5938824d) && isplayer(result.var_c7a5b906)) {
                        result.var_c7a5b906 thread function_be7e4df0(int(50), self);
                    }
                    function_2ab4cc15(result.hit_position, var_5938824d);
                } else {
                    function_2ab4cc15(result.hit_position, var_5938824d);
                }
                self vehicle_ai::waittill_asm_complete(var_9bc38be3, 5);
                if (isdefined(self.var_5f321fd6)) {
                    self setlookatent(self.var_5f321fd6);
                    self setturrettargetent(self.var_5f321fd6);
                }
                self asmrequestsubstate("locomotion@movement");
                if (randomint(100) < 40) {
                    function_b7a88435();
                }
                if (randomint(100) < 30) {
                    self.nextfiretime = gettime() + 2500 + randomint(2500);
                }
                return true;
            }
        }
    }
    return false;
}

// Namespace sentinel_drone
// Params 2, eflags: 0x0
// Checksum 0x3b11866d, Offset: 0x5730
// Size: 0x148
function function_2ab4cc15(target_position, var_5938824d) {
    self endon(#"change_state");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"death_state_activated");
    self.lasttimefired = gettime();
    var_18a4d3ec = target_position - self.origin;
    self.var_b75e6e79.origin = target_position;
    self.var_b75e6e79.angles = vectortoangles(var_18a4d3ec * -1);
    self.angles = vectortoangles(var_18a4d3ec);
    self setturrettargetent(self.var_b75e6e79);
    self.var_7f3b8669 = 1;
    if (!(isdefined(var_5938824d) && var_5938824d)) {
        function_f0135159(target_position);
    } else {
        function_d9c08fec(target_position);
    }
    self.var_7f3b8669 = 0;
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0xd1942439, Offset: 0x5880
// Size: 0x1ae
function function_f0135159(target_position) {
    self endon(#"change_state");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"death_state_activated");
    for (i = 1; i <= 3; i++) {
        if (self.var_4989d42a[i] <= 0) {
            continue;
        }
        self clientfield::set("sentinel_drone_beam_fire" + i, 1);
    }
    wait 0.1;
    var_3aa73fe1 = gettime() + 2000;
    var_b803b724 = 0.1;
    player_damage = int(100 * var_b803b724);
    while (isdefined(self.var_36502289) && (gettime() < var_3aa73fe1 || self.var_36502289)) {
        function_fb023764(player_damage, target_position);
        wait var_b803b724;
    }
    for (i = 1; i <= 3; i++) {
        if (self.var_4989d42a[i] <= 0) {
            continue;
        }
        self clientfield::set("sentinel_drone_beam_fire" + i, 0);
    }
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0xcf2e17c7, Offset: 0x5a38
// Size: 0x1d6
function function_d9c08fec(target_position) {
    self endon(#"change_state");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"death_state_activated");
    player_damage = int(30);
    var_e9cb9869 = [];
    var_e9cb9869[0] = 2;
    var_e9cb9869[1] = 1;
    var_e9cb9869[2] = 3;
    var_8c8a6af4 = [];
    var_8c8a6af4[0] = "attack_quick_left";
    var_8c8a6af4[1] = "attack_quick_right";
    var_8c8a6af4[2] = "attack_quick_top";
    for (i = 0; i < 3; i++) {
        if (self.var_4989d42a[var_e9cb9869[i]] <= 0) {
            continue;
        }
        self util::waittill_any_timeout(0.3, var_8c8a6af4[i]);
        self clientfield::set("sentinel_drone_beam_fire" + var_e9cb9869[i], 1);
        function_fb023764(player_damage, target_position, 1);
        wait 0.1;
        self clientfield::set("sentinel_drone_beam_fire" + var_e9cb9869[i], 0);
    }
}

// Namespace sentinel_drone
// Params 3, eflags: 0x0
// Checksum 0x1f50650f, Offset: 0x5c18
// Size: 0x1ec
function function_fb023764(player_damage, target_position, var_5938824d) {
    if (!isdefined(var_5938824d)) {
        var_5938824d = 0;
    }
    trace = function_e6cdb4ef(self.origin, target_position, self.var_5f321fd6, 0);
    var_dab627da = trace["entity"];
    if (isdefined(trace["entity"]) && isdefined(trace["entity"].archetype) && trace["entity"].archetype == "zombie" && !isalive(trace["entity"])) {
        trace = function_e6cdb4ef(self.origin, target_position, self.var_5f321fd6, 0, 1);
        if (trace["fraction"] == 1) {
            var_dab627da = self.var_5f321fd6;
        }
    }
    if (isplayer(var_dab627da)) {
        var_dab627da thread function_be7e4df0(player_damage, self, var_5938824d);
        return;
    }
    if (isdefined(var_dab627da) && isdefined(var_dab627da.archetype) && var_dab627da.archetype == "zombie") {
        self thread function_45689097(var_dab627da.origin, var_dab627da, 80);
    }
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0xd25584ee, Offset: 0x5e10
// Size: 0x54
function function_2593e364(time) {
    self endon(#"change_state");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"death_state_activated");
    wait time;
    function_8a02f3d0();
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xc33a9ad4, Offset: 0x5e70
// Size: 0x1f8
function function_eb9b1410() {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"change_state");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"death_state_activated");
    wait 0.3;
    self.var_eecb28e1 = 1;
    self function_c28fa12c();
    function_36da0be3(level.var_5fc16234);
    var_be5ca9fb = self.var_5f321fd6.origin + (0, 0, 48);
    self asmrequestsubstate("suicide_intro@death");
    wait 2;
    if (self.var_f36b0ec6 <= 0) {
        var_444ce0bc = 0;
    } else {
        var_be5ca9fb = undefined;
        var_444ce0bc = 1;
    }
    self asmrequestsubstate("suicide_charge@death");
    self setspeed(60);
    self thread function_fe5946f6(var_444ce0bc, 4000, var_be5ca9fb);
    var_816cdc7b = 10000;
    while (isdefined(self) && isdefined(self.var_5f321fd6)) {
        distance_sq = distancesquared(self.var_5f321fd6.origin + (0, 0, 48), self.origin);
        if (distance_sq <= var_816cdc7b) {
            function_8a02f3d0();
        }
        wait 0.2;
    }
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0xccfa80c, Offset: 0x6070
// Size: 0x32
function function_e9e94054(part_name) {
    if (!isdefined(part_name)) {
        return 0;
    }
    return issubstr(part_name, "tag_arm_left");
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0x2ed068b9, Offset: 0x60b0
// Size: 0x32
function function_f74e02e5(part_name) {
    if (!isdefined(part_name)) {
        return 0;
    }
    return issubstr(part_name, "tag_arm_right");
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0xdbddc3d5, Offset: 0x60f0
// Size: 0x32
function function_d226e7b4(part_name) {
    if (!isdefined(part_name)) {
        return 0;
    }
    return issubstr(part_name, "tag_arm_top");
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0x262edb5d, Offset: 0x6130
// Size: 0x64
function function_b2db24e8(part_name) {
    if (!isdefined(part_name)) {
        return false;
    }
    if (part_name == "tag_faceplate_d0" || part_name == "ag_core_d0" || part_name == "tag_center_core" || part_name == "tag_core_spin") {
        return true;
    }
    return false;
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0xbe33b815, Offset: 0x61a0
// Size: 0x64
function function_87c3001c(part_name) {
    if (!isdefined(part_name)) {
        return false;
    }
    if (part_name == "tag_camera_dead" || part_name == "tag_flash" || part_name == "tag_laser" || part_name == "tag_turret") {
        return true;
    }
    return false;
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0x33634f31, Offset: 0x6210
// Size: 0x7e
function function_b8f3c1e5(part_name) {
    if (!isdefined(part_name)) {
        return 0;
    }
    if (function_e9e94054(part_name)) {
        return 2;
    } else if (function_f74e02e5(part_name)) {
        return 1;
    } else if (function_d226e7b4(part_name)) {
        return 3;
    }
    return 0;
}

// Namespace sentinel_drone
// Params 3, eflags: 0x4
// Checksum 0xc184b465, Offset: 0x6298
// Size: 0x2d6
function private function_d65f1aa1(damage, arm, eattacker) {
    if (!isdefined(eattacker)) {
        eattacker = undefined;
    }
    if (self.var_a91dcd28 == 0) {
        return;
    }
    if (arm == 0 || damage == 0) {
        return;
    }
    if (self.var_4989d42a[arm] <= 0) {
        return;
    }
    self.var_4989d42a[arm] = self.var_4989d42a[arm] - damage;
    if (self.var_4989d42a[arm] <= 0) {
        self.var_a91dcd28--;
        if (isplayer(eattacker)) {
            if (!isdefined(self.var_24bc4372) && self.var_a91dcd28 == 2) {
                self.var_24bc4372 = eattacker;
                self.var_4722a1aa = 1;
            } else if (self.var_24bc4372 !== eattacker) {
                self.var_4722a1aa = 0;
            }
        }
        self clientfield::set("sentinel_drone_arm_cut_" + arm, 1);
        if (arm == 2) {
            self hidepart("tag_arm_left_01", "", 1);
            self showpart("tag_arm_left_01_d1", "", 1);
        } else if (arm == 1) {
            self hidepart("tag_arm_right_01", "", 1);
            self showpart("tag_arm_right_01_d1", "", 1);
        } else if (arm == 3) {
            self hidepart("tag_arm_top_01", "", 1);
            self showpart("tag_arm_top_01_d1", "", 1);
        }
        if (self.var_a91dcd28 == 0 && !(isdefined(self.var_a6f6e6f5) && self.var_a6f6e6f5)) {
            function_b116891a();
            if (isplayer(eattacker)) {
                level notify(#"hash_9d4cd769", self.var_4722a1aa, eattacker);
            }
        }
    }
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0xc77ba67f, Offset: 0x6578
// Size: 0x9c
function function_a2874766(var_ebbcd0b7) {
    self.var_a6f6e6f5 = isdefined(var_ebbcd0b7) && var_ebbcd0b7;
    function_d65f1aa1(self.var_4989d42a[2] + 1000, 2);
    function_d65f1aa1(self.var_4989d42a[1] + 1000, 1);
    function_d65f1aa1(self.var_4989d42a[3] + 1000, 3);
}

// Namespace sentinel_drone
// Params 0, eflags: 0x4
// Checksum 0xe24824b6, Offset: 0x6620
// Size: 0x44
function private function_b116891a() {
    function_414ec94d();
    function_6aa9acab();
    wait 0.1;
    self thread function_eb9b1410();
}

// Namespace sentinel_drone
// Params 0, eflags: 0x4
// Checksum 0x27d97a9f, Offset: 0x6670
// Size: 0x2c
function private function_414ec94d() {
    function_ffc58b10(self.var_b24be8f0 + 1000, "tag_faceplate_d0");
}

// Namespace sentinel_drone
// Params 0, eflags: 0x4
// Checksum 0x27686850, Offset: 0x66a8
// Size: 0x2c
function private function_6aa9acab() {
    function_5084b8a6(self.var_218f2356 + 1000, "ag_core_d0");
}

// Namespace sentinel_drone
// Params 2, eflags: 0x4
// Checksum 0xc591878d, Offset: 0x66e0
// Size: 0xbc
function private function_ffc58b10(damage, partname) {
    if (damage == 0) {
        return;
    }
    if (self.var_b24be8f0 <= 0) {
        return;
    }
    if (!isdefined(partname) || partname != "tag_faceplate_d0") {
        return;
    }
    self.var_b24be8f0 -= damage;
    if (self.var_b24be8f0 <= 0) {
        self clientfield::set("sentinel_drone_face_cut", 1);
        self hidepart("tag_faceplate_d0", "", 1);
    }
}

// Namespace sentinel_drone
// Params 2, eflags: 0x4
// Checksum 0x8b39cc62, Offset: 0x67a8
// Size: 0xd4
function private function_5084b8a6(damage, partname) {
    if (damage == 0) {
        return;
    }
    if (self.var_b24be8f0 > 0) {
        return;
    }
    if (self.var_218f2356 <= 0) {
        return;
    }
    if (!function_b2db24e8(partname)) {
        return;
    }
    self.var_218f2356 -= damage;
    if (self.var_218f2356 <= 0) {
        self hidepart("tag_center_core_emmisive_blue", "", 1);
        self showpart("tag_center_core_emmisive_red", "", 1);
    }
}

// Namespace sentinel_drone
// Params 3, eflags: 0x4
// Checksum 0x866361b, Offset: 0x6888
// Size: 0x166
function private function_8cef2e36(damage, partname, eattacker) {
    if (damage == 0) {
        return;
    }
    if (self.var_f36b0ec6 <= 0) {
        return;
    }
    if (!function_87c3001c(partname)) {
        return;
    }
    self.var_f36b0ec6 -= damage;
    if (self.var_f36b0ec6 <= 0) {
        self hidepart("tag_turret", "", 1);
        self showpart("Tag_camera_dead", "", 1);
        self clientfield::set("sentinel_drone_camera_destroyed", 1);
        function_414ec94d();
        function_6aa9acab();
        self thread function_2593e364(2000);
        self thread function_eb9b1410();
        if (isplayer(eattacker)) {
            level notify(#"hash_73c2bce5", eattacker);
        }
    }
}

// Namespace sentinel_drone
// Params 15, eflags: 0x0
// Checksum 0xff900459, Offset: 0x69f8
// Size: 0x268
function function_bfd6b3a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(eattacker) && eattacker.archetype === "sentinel_drone") {
        return 0;
    }
    if (isdefined(einflictor) && einflictor.archetype === "sentinel_drone") {
        return 0;
    }
    if (isdefined(level.zombie_vars[eattacker.team]["zombie_insta_kill"]) && isdefined(eattacker) && isdefined(eattacker.team) && isdefined(level.zombie_vars) && isdefined(level.zombie_vars[eattacker.team]) && level.zombie_vars[eattacker.team]["zombie_insta_kill"]) {
        idamage *= 4;
    }
    if (self.var_b24be8f0 <= 0 && function_b2db24e8(partname)) {
        idamage *= 2;
    }
    if (gettime() > self.var_c5af3448) {
        if (math::cointoss()) {
            self.var_eebcd2ad = 1;
        } else {
            self.var_c5af3448 = gettime() + randomint(3000);
        }
    }
    thread function_d65f1aa1(idamage, function_b8f3c1e5(partname), eattacker);
    thread function_ffc58b10(idamage, partname);
    thread function_8cef2e36(idamage, partname, eattacker);
    return idamage;
}

// Namespace sentinel_drone
// Params 13, eflags: 0x0
// Checksum 0x4a936ebe, Offset: 0x6c68
// Size: 0x118
function function_4ccd6c6d(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime) {
    if (isdefined(eattacker) && eattacker.archetype === "sentinel_drone") {
        return 0;
    }
    if (isdefined(einflictor) && einflictor.archetype === "sentinel_drone") {
        return 0;
    }
    if (gettime() > self.var_c5af3448) {
        if (math::cointoss()) {
            self.var_eebcd2ad = 1;
        } else {
            self.var_c5af3448 = gettime() + 3000 + randomint(4000);
        }
    }
    return idamage;
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0x8e60ef0f, Offset: 0x6d88
// Size: 0x20c
function state_death_update(params) {
    self endon(#"death");
    self function_986375f9();
    self function_285cdfc3();
    self asmrequestsubstate("normal@death");
    function_6446f90(undefined);
    self thread vehicle_death::death_fx();
    self.var_b75e6e79 thread function_b9185b43(self.origin);
    min_distance = 110;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (!is_target_valid(players[i])) {
            continue;
        }
        var_e4b9d82 = min_distance * min_distance;
        distance_sq = distancesquared(self.origin, players[i].origin + (0, 0, 48));
        if (distance_sq < var_e4b9d82) {
            players[i] function_be7e4df0(60, self);
        }
    }
    self function_45689097(self.origin, undefined, 100);
    wait 0.1;
    self delete();
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0xb6026089, Offset: 0x6fa0
// Size: 0x74
function function_b9185b43(explosion_origin) {
    self endon(#"disconnect");
    self endon(#"death");
    self.origin = explosion_origin;
    wait 0.1;
    self clientfield::set("sentinel_drone_deathfx", 1);
    wait 6;
    self delete();
}

// Namespace sentinel_drone
// Params 2, eflags: 0x0
// Checksum 0x38d19739, Offset: 0x7020
// Size: 0x4e
function function_aed5ff39(b_enable, position) {
    if (isdefined(b_enable) && b_enable) {
        self.var_8b06de4d = position;
        return;
    }
    self.var_eebcd2ad = 0;
    self.var_8b06de4d = undefined;
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xd8616208, Offset: 0x7078
// Size: 0x6e
function function_5d3b9aa4() {
    if (!isdefined(self.var_a249f7c3)) {
        var_a249f7c3 = getent("sentinel_compact", "targetname");
    }
    if (isdefined(var_a249f7c3)) {
        if (self.var_5f321fd6 istouching(var_a249f7c3)) {
            return true;
        }
    }
    return false;
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x6d114289, Offset: 0x70f0
// Size: 0x8e
function function_5853dcd1() {
    if (!isdefined(self.var_5f321fd6)) {
        return false;
    }
    if (!isdefined(self.var_d9347e1a)) {
        self.var_d9347e1a = getent("sentinel_narrow_nav", "targetname");
    }
    if (isdefined(self.var_d9347e1a) && isdefined(self.var_5f321fd6)) {
        if (self.var_5f321fd6 istouching(self.var_d9347e1a)) {
            return true;
        }
    }
    return false;
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0xcd7c4b1, Offset: 0x7188
// Size: 0x8c
function function_4c8bb04a(var_5261497) {
    if (isdefined(var_5261497) && var_5261497) {
        self.var_f117ac20 = 1;
        blackboard::setblackboardattribute(self, "_stance", "crouch");
        return;
    }
    self.var_f117ac20 = 0;
    blackboard::setblackboardattribute(self, "_stance", "stand");
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xd02a7e25, Offset: 0x7220
// Size: 0xec
function function_8d62fae7() {
    self endon(#"disconnect");
    self endon(#"death");
    wait 0.2;
    self hidepart("tag_arm_left_01_d1", "", 1);
    self hidepart("tag_arm_right_01_d1", "", 1);
    self hidepart("tag_arm_top_01_d1", "", 1);
    self hidepart("Tag_camera_dead", "", 1);
    self hidepart("tag_center_core_emmisive_red", "", 1);
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xedad9ce3, Offset: 0x7318
// Size: 0x2c
function function_8a02f3d0() {
    self dodamage(self.health + 100, self.origin);
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x76523226, Offset: 0x7350
// Size: 0x7a
function function_1af7dd91() {
    if (function_5853dcd1()) {
        return (self.settings.engagementdistmin * 0.3);
    } else if (isdefined(self.var_f117ac20) && self.var_f117ac20) {
        return (self.settings.engagementdistmax * 0.85);
    }
    return self.settings.engagementdistmax;
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x8d8280fc, Offset: 0x73d8
// Size: 0x7a
function function_85f552ef() {
    if (function_5853dcd1()) {
        return (self.settings.engagementdistmin * 0.2);
    } else if (isdefined(self.var_f117ac20) && self.var_f117ac20) {
        return (self.settings.engagementdistmin * 0.5);
    }
    return self.settings.engagementdistmin;
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xa2379a1f, Offset: 0x7460
// Size: 0x46
function function_227df48e() {
    if (isdefined(self.var_f117ac20) && self.var_f117ac20) {
        return (self.settings.engagementheightmax * 0.8);
    }
    return self.settings.engagementheightmax;
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xfb4d5505, Offset: 0x74b0
// Size: 0x36
function function_75556350() {
    if (!isdefined(self.var_5f321fd6)) {
        return (self.settings.engagementheightmin * 3);
    }
    return self.settings.engagementheightmin;
}

// Namespace sentinel_drone
// Params 3, eflags: 0x0
// Checksum 0x25a0a1f, Offset: 0x74f0
// Size: 0x18e
function function_7e57f99c(origin, position, var_614e7398) {
    if (!(distance2dsquared(position, origin) > function_85f552ef() * function_85f552ef() && distance2dsquared(position, origin) < function_1af7dd91() * function_1af7dd91())) {
        return 0;
    }
    if (isdefined(var_614e7398) && var_614e7398) {
        return (abs(origin[2] - position[2]) >= function_75556350() && abs(origin[2] - position[2]) <= function_227df48e());
    }
    return position[2] - origin[2] >= function_75556350() && position[2] - origin[2] <= function_227df48e();
}

// Namespace sentinel_drone
// Params 5, eflags: 0x0
// Checksum 0xfa832b01, Offset: 0x7688
// Size: 0xdc
function function_e6cdb4ef(start, end, ignore_ent, var_afa84f9d, ignore_characters) {
    if (isdefined(var_afa84f9d) && var_afa84f9d) {
        trace = physicstrace(start, end, (-10, -10, -10), (10, 10, 10), self, 1 | 2);
        if (trace["fraction"] < 1) {
            return trace;
        }
    }
    trace = bullettrace(start, end, !(isdefined(ignore_characters) && ignore_characters), self);
    return trace;
}

// Namespace sentinel_drone
// Params 3, eflags: 0x0
// Checksum 0x29c62636, Offset: 0x7770
// Size: 0x5c
function function_45689097(origin, zombie, radius) {
    self endon(#"disconnect");
    self endon(#"death");
    if (isdefined(self.var_45689097)) {
        self thread [[ self.var_45689097 ]](origin, zombie, radius);
    }
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x1b67d9d3, Offset: 0x77d8
// Size: 0x4e
function function_285cdfc3() {
    for (i = 1; i <= 3; i++) {
        self clientfield::set("sentinel_drone_arm_cut_" + i, 0);
    }
}

// Namespace sentinel_drone
// Params 3, eflags: 0x0
// Checksum 0xdc76e773, Offset: 0x7830
// Size: 0x174
function function_be7e4df0(damage, eattacker, var_cb5b562c) {
    if (!isdefined(var_cb5b562c)) {
        var_cb5b562c = 0;
    }
    self notify(#"proximitygrenadedamagestart");
    self endon(#"proximitygrenadedamagestart");
    self endon(#"disconnect");
    self endon(#"death");
    eattacker endon(#"disconnect");
    self dodamage(damage, eattacker.origin, eattacker, eattacker);
    if (var_cb5b562c) {
        self playrumbleonentity("damage_heavy");
    } else {
        self playrumbleonentity("proximity_grenade");
    }
    if (self util::mayapplyscreeneffect()) {
        self clientfield::increment_to_player("sentinel_drone_damage_player_fx");
        if (var_cb5b562c) {
            self shellshock("electrocution_sentinel_drone", 0.5);
            return;
        }
        self shellshock("electrocution_sentinel_drone", 1);
    }
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x38c01283, Offset: 0x79b0
// Size: 0x84
function function_986375f9() {
    if (!isdefined(level.var_979a2615)) {
        return;
    }
    for (i = 0; i < level.var_979a2615.size; i++) {
        if (level.var_979a2615[i] == self) {
            level.var_979a2615[i] = undefined;
            break;
        }
    }
    level.var_979a2615 = array::remove_undefined(level.var_979a2615);
}

// Namespace sentinel_drone
// Params 2, eflags: 0x0
// Checksum 0xbfd4e364, Offset: 0x7a40
// Size: 0xe8
function function_50edda43(point, min_distance) {
    if (!isdefined(level.var_979a2615)) {
        return false;
    }
    for (i = 0; i < level.var_979a2615.size; i++) {
        if (!isdefined(level.var_979a2615[i])) {
            continue;
        }
        if (level.var_979a2615[i] == self) {
            continue;
        }
        var_e4b9d82 = min_distance * min_distance;
        distance_sq = distancesquared(level.var_979a2615[i].origin, point);
        if (distance_sq < var_e4b9d82) {
            return true;
        }
    }
    return false;
}

// Namespace sentinel_drone
// Params 2, eflags: 0x0
// Checksum 0xc2e2545b, Offset: 0x7b30
// Size: 0xf0
function function_ae15e4ec(origin, min_distance) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (!is_target_valid(players[i])) {
            continue;
        }
        var_e4b9d82 = min_distance * min_distance;
        distance_sq = distancesquared(origin, players[i].origin + (0, 0, 48));
        if (distance_sq < var_e4b9d82) {
            return true;
        }
    }
    return false;
}

// Namespace sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0xbb19da19, Offset: 0x7c28
// Size: 0x84
function function_36da0be3(var_7cb1f6e7) {
    if (isdefined(level.var_682d2753) && gettime() - level.var_682d2753 < 6000) {
        return;
    }
    taunt = randomint(var_7cb1f6e7.size);
    level.var_682d2753 = gettime();
    self playsound(var_7cb1f6e7[taunt]);
}

/#

    // Namespace sentinel_drone
    // Params 0, eflags: 0x0
    // Checksum 0xe7500709, Offset: 0x7cb8
    // Size: 0x78
    function function_82fe7ce0() {
        self endon(#"death");
        while (true) {
            radius = getdvarint("<dev string:x18c>", 35);
            sphere(self.origin, radius, (0, 1, 0), 0.5);
            wait 0.01;
        }
    }

    // Namespace sentinel_drone
    // Params 0, eflags: 0x0
    // Checksum 0x1d781517, Offset: 0x7d38
    // Size: 0x266
    function function_dcfe661f() {
        self endon(#"death");
        while (true) {
            if (getdvarint("<dev string:x19a>", 0) == 1) {
                self.var_36502289 = 1;
                forward_vector = anglestoforward(self.angles);
                forward_vector = self.origin + vectorscale(forward_vector, 1200);
                thread function_2ab4cc15(forward_vector);
                self clientfield::set("<dev string:x1b3>", 1);
            } else if (isdefined(self.var_36502289) && self.var_36502289) {
                self.var_36502289 = 0;
                self clientfield::set("<dev string:x1b3>", 0);
            }
            if (getdvarint("<dev string:x1ce>", 0) == 1) {
                self.var_99f5fd57 = 1;
            } else if (isdefined(self.var_99f5fd57) && self.var_99f5fd57) {
                self.var_99f5fd57 = 0;
                self clientfield::set("<dev string:x1b3>", 0);
            }
            if (getdvarint("<dev string:x1ea>", 0) == 1) {
                if (!(isdefined(self.var_4d52560e) && self.var_4d52560e)) {
                    self.var_4d52560e = 1;
                    thread function_d65f1aa1(1000, 2);
                    thread function_d65f1aa1(1000, 1);
                    thread function_d65f1aa1(1000, 3);
                }
            }
            if (getdvarint("<dev string:x202>", 0) == 1) {
                if (!(isdefined(self.var_d617bcbc) && self.var_d617bcbc)) {
                    self.var_d617bcbc = 1;
                    thread function_ffc58b10(1000, "<dev string:x21a>");
                }
            }
            wait 3;
        }
    }

    // Namespace sentinel_drone
    // Params 0, eflags: 0x0
    // Checksum 0xf023bab6, Offset: 0x7fa8
    // Size: 0x116
    function function_ad2bc47f() {
        self endon(#"death");
        while (isdefined(self)) {
            if (getdvarint("<dev string:x22b>", 0) == 1) {
                self.var_870ee4a0 = 1;
                self.var_5de5a96c = 1;
            } else if (isdefined(self.var_870ee4a0)) {
                self.var_870ee4a0 = undefined;
                self.var_5de5a96c = 0;
            }
            if (getdvarint("<dev string:x247>", 0) == 1) {
                self.var_99e3604f = 1;
                blackboard::setblackboardattribute(self, "<dev string:x25e>", "<dev string:x266>");
            } else if (isdefined(self.var_99e3604f)) {
                self.var_99e3604f = undefined;
                blackboard::setblackboardattribute(self, "<dev string:x25e>", "<dev string:x26d>");
            }
            wait 1;
        }
    }

#/
