#using scripts/codescripts/struct;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/margwa;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_utility;
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

#namespace glaive;

// Namespace glaive
// Params 0, eflags: 0x2
// Checksum 0xa11527fc, Offset: 0x490
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("glaive", &__init__, undefined, undefined);
}

// Namespace glaive
// Params 0, eflags: 0x0
// Checksum 0xb691aeea, Offset: 0x4d0
// Size: 0x5c
function __init__() {
    vehicle::add_main_callback("glaive", &function_4178dbae);
    clientfield::register("vehicle", "glaive_blood_fx", 1, 1, "int");
}

// Namespace glaive
// Params 0, eflags: 0x0
// Checksum 0xd0db9dac, Offset: 0x538
// Size: 0x1fc
function function_4178dbae() {
    self useanimtree(#generic);
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self setneargoalnotifydist(50);
    self sethoverparams(0, 0, 40);
    self playloopsound("wpn_sword2_looper");
    if (isdefined(self.scriptbundlesettings)) {
        self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    }
    blackboard::createblackboardforentity(self);
    self blackboard::registervehicleblackboardattributes();
    self.fovcosine = 0;
    self.fovcosinebusy = 0.574;
    self.vehaircraftcollisionenabled = 0;
    self.goalradius = 9999999;
    self.goalheight = 512;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self.overridevehicledamage = &function_c6e986c3;
    self.allowfriendlyfiredamageoverride = &function_226d16ed;
    self.ignoreme = 1;
    self.var_7cc7e526 = self.settings.lifetime;
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    defaultrole();
}

// Namespace glaive
// Params 0, eflags: 0x0
// Checksum 0x858d585f, Offset: 0x740
// Size: 0x108
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
    self vehicle_ai::add_state("slash", undefined, &function_14d89a82, undefined);
    /#
        setdvar("<dev string:x28>", 1);
    #/
    self thread function_ad866c00();
    vehicle_ai::startinitialstate("combat");
    self.starttime = gettime();
}

// Namespace glaive
// Params 1, eflags: 0x4
// Checksum 0xa618d061, Offset: 0x850
// Size: 0x206
function private function_cb8b2163(target) {
    if (!isdefined(target)) {
        return false;
    }
    if (!isalive(target)) {
        return false;
    }
    if (isdefined(self.intermission) && self.intermission) {
        return false;
    }
    if (isdefined(target.ignoreme) && target.ignoreme) {
        return false;
    }
    if (target isnotarget()) {
        return false;
    }
    if (isdefined(target.var_7d75bfbb) && target.var_7d75bfbb) {
        return false;
    }
    if (isdefined(target.archetype) && target.archetype == "margwa") {
        if (!target namespace_c96301ee::function_6fb4c3f9()) {
            return false;
        }
    }
    if (isdefined(target.archetype) && target.archetype == "zombie" && !(isdefined(target.completed_emerging_into_playable_area) && target.completed_emerging_into_playable_area)) {
        return false;
    }
    if (distancesquared(self.owner.origin, target.origin) > self.settings.var_1ca0fb66 * self.settings.var_1ca0fb66) {
        return false;
    }
    if (!sighttracepassed(self.origin, target.origin + (0, 0, 16), 0, target)) {
        return false;
    }
    return true;
}

// Namespace glaive
// Params 0, eflags: 0x4
// Checksum 0xf317b23f, Offset: 0xa60
// Size: 0xda
function private function_7ab362db() {
    var_e9ab3b34 = getaiteamarray("axis");
    arraysortclosest(var_e9ab3b34, self.owner.origin);
    foreach (var_5f305fb8 in var_e9ab3b34) {
        if (function_cb8b2163(var_5f305fb8)) {
            return var_5f305fb8;
        }
    }
}

// Namespace glaive
// Params 0, eflags: 0x4
// Checksum 0xe2ae9d0d, Offset: 0xb48
// Size: 0x158
function private function_ad866c00() {
    self endon(#"death");
    for (;;) {
        if (!isdefined(self.owner)) {
            wait 0.25;
            continue;
        }
        if (isdefined(self.ignoreall) && self.ignoreall) {
            wait 0.25;
            continue;
        }
        /#
            if (getdvarint("<dev string:x28>", 0)) {
                if (isdefined(self.var_f23a98eb)) {
                    line(self.origin, self.var_f23a98eb.origin, (1, 0, 0), 1, 0, 5);
                }
            }
        #/
        if (self function_cb8b2163(self.var_f23a98eb)) {
            wait 0.25;
            continue;
        }
        if (isdefined(self._glaive_must_return_to_owner) && self._glaive_must_return_to_owner) {
            wait 0.25;
            continue;
        }
        target = function_7ab362db();
        if (!isdefined(target)) {
            self.var_f23a98eb = undefined;
        } else {
            self.var_f23a98eb = target;
        }
        wait 0.25;
    }
}

// Namespace glaive
// Params 0, eflags: 0x0
// Checksum 0xf33a2d4, Offset: 0xca8
// Size: 0x68
function function_6996ae57() {
    var_23d518cb = gettime() - self.starttime > self.var_7cc7e526 * 1000;
    if (isdefined(var_23d518cb) && var_23d518cb) {
        return true;
    }
    if (self.owner.var_c9265b2e <= 0) {
        return true;
    }
    return false;
}

// Namespace glaive
// Params 0, eflags: 0x0
// Checksum 0x7f033140, Offset: 0xd18
// Size: 0x136
function function_1aae8db0() {
    if (isdefined(self.owner) && distancesquared(self.origin, self.owner.origin) > self.settings.var_1ca0fb66 * self.settings.var_1ca0fb66) {
        return true;
    }
    if (isdefined(self.owner) && !self function_cb8b2163(self.var_f23a98eb)) {
        if (distance2dsquared(self.origin, self.owner.origin) > -96 * -96) {
            return true;
        }
        if (!util::within_fov(self.owner.origin, self.owner.angles, self.origin, cos(60))) {
            return true;
        }
    }
    return false;
}

// Namespace glaive
// Params 1, eflags: 0x0
// Checksum 0xf8620b6e, Offset: 0xe58
// Size: 0x2c
function state_combat_enter(params) {
    self asmrequestsubstate("idle@movement");
}

// Namespace glaive
// Params 1, eflags: 0x0
// Checksum 0x4d8510a7, Offset: 0xe90
// Size: 0x664
function state_combat_update(params) {
    self endon(#"change_state");
    self endon(#"death");
    pathfailcount = 0;
    while (!isdefined(self.owner)) {
        wait 0.1;
        if (!isdefined(self.owner)) {
            self.owner = getplayers(self.team)[0];
        }
    }
    for (;;) {
        if (isdefined(self._glaive_must_return_to_owner) && (self function_6996ae57() || self._glaive_must_return_to_owner)) {
            self._glaive_must_return_to_owner = 1;
            if (!isalive(self.var_f23a98eb)) {
                self function_7ffdbe09();
            }
        }
        if (self function_1aae8db0()) {
            self function_bd13793a();
        } else if (isdefined(self.var_f23a98eb)) {
            foundpath = 0;
            targetpos = vehicle_ai::gettargetpos(self.var_f23a98eb, 1);
            if (isdefined(self.var_f23a98eb.archetype) && self.var_f23a98eb.archetype == "margwa") {
                targetpos = self.var_f23a98eb gettagorigin("j_chunk_head_bone");
            }
            targetpos += self.var_f23a98eb getvelocity() * 0.4;
            if (isdefined(targetpos)) {
                if (distance2dsquared(self.origin, self.var_f23a98eb.origin) < 80 * 80) {
                    self vehicle_ai::set_state("slash");
                } else if (isdefined(self.owner) && self function_cb8b2163(self.var_f23a98eb) && self function_ce82716()) {
                    function_3f19103d();
                    queryresult = positionquery_source_navigation(targetpos, 0, 64, 64, 8, self);
                    if (isdefined(self.var_f23a98eb)) {
                        positionquery_filter_sight(queryresult, targetpos, self geteye() - self.origin, self, 0, self.var_f23a98eb);
                    }
                    if (isdefined(queryresult.centeronnav) && queryresult.centeronnav) {
                        foreach (point in queryresult.data) {
                            if (isdefined(point.visibility) && point.visibility) {
                                self.current_pathto_pos = point.origin;
                                foundpath = self setvehgoalpos(self.current_pathto_pos, 1, 1);
                                if (foundpath) {
                                    self asmrequestsubstate("forward@movement");
                                    self util::waittill_any("near_goal", "goal");
                                    self asmrequestsubstate("idle@movement");
                                    break;
                                }
                            }
                        }
                    } else {
                        foreach (point in queryresult.data) {
                            if (isdefined(point.visibility) && point.visibility) {
                                self.current_pathto_pos = point.origin;
                                foundpath = self setvehgoalpos(self.current_pathto_pos, 1, 0);
                                if (foundpath) {
                                    self asmrequestsubstate("forward@movement");
                                    self util::waittill_any("near_goal", "goal");
                                    self asmrequestsubstate("idle@movement");
                                    break;
                                }
                            }
                        }
                    }
                }
            }
            if (!foundpath && self function_cb8b2163(self.var_f23a98eb)) {
                function_3f19103d();
                pathfailcount++;
                if (pathfailcount > 3) {
                    if (isdefined(self.owner)) {
                        self function_bd13793a();
                    }
                }
                wait 0.1;
            } else {
                pathfailcount = 0;
            }
        }
        wait 0.2;
    }
}

// Namespace glaive
// Params 0, eflags: 0x0
// Checksum 0x928fa15f, Offset: 0x1500
// Size: 0x9e
function function_ce82716() {
    if (isdefined(self.var_f23a98eb.archetype) && self.var_f23a98eb.archetype != "zombie") {
        return true;
    } else if (isdefined(self.var_f23a98eb.completed_emerging_into_playable_area) && isdefined(self.var_f23a98eb.archetype) && self.var_f23a98eb.archetype == "zombie" && self.var_f23a98eb.completed_emerging_into_playable_area) {
        return true;
    }
    return false;
}

// Namespace glaive
// Params 0, eflags: 0x0
// Checksum 0xa42902e4, Offset: 0x15a8
// Size: 0x2a4
function function_3f19103d() {
    queryresult = positionquery_source_navigation(self.origin, 0, 100, 64, 8, self);
    for (multiplier = 2; queryresult.data.size < 1; multiplier += 2) {
        queryresult = positionquery_source_navigation(self.origin, 0, 100 * multiplier, 64 * multiplier, 20 * multiplier, self);
    }
    if (queryresult.data.size && !queryresult.centeronnav) {
        best_point = undefined;
        best_score = 999999;
        foreach (point in queryresult.data) {
            point.score = abs(point.origin[2] - queryresult.origin[2]);
            if (point.score < best_score) {
                best_score = point.score;
                best_point = point;
            }
        }
        if (isdefined(best_point)) {
            self setneargoalnotifydist(2);
            point = best_point;
            self.current_pathto_pos = point.origin;
            foundpath = self setvehgoalpos(self.current_pathto_pos, 1, 0);
            if (foundpath) {
                self util::waittill_any("goal", "near_goal");
            }
            self setneargoalnotifydist(50);
        }
    }
}

// Namespace glaive
// Params 1, eflags: 0x0
// Checksum 0xef9a546c, Offset: 0x1858
// Size: 0xd6
function function_6727edba(enemy) {
    self endon(#"change_state");
    self endon(#"death");
    var_8a282a6c = "o_zombie_zod_sword_projectile_melee_synced_a";
    self.var_4dfc2454 = "tag_origin";
    if (isdefined(enemy.archetype)) {
        switch (enemy.archetype) {
        case "parasite":
            var_8a282a6c = "o_zombie_zod_sword_projectile_melee_parasite_synced_a";
            break;
        case "raps":
            var_8a282a6c = "o_zombie_zod_sword_projectile_melee_elemental_synced_a";
            break;
        case "margwa":
            var_8a282a6c = "o_zombie_zod_sword_projectile_melee_margwa_m_synced_a";
            self.var_4dfc2454 = "tag_sync";
            break;
        }
    }
    return var_8a282a6c;
}

// Namespace glaive
// Params 1, eflags: 0x0
// Checksum 0x2bfd094c, Offset: 0x1938
// Size: 0x46c
function function_14d89a82(params) {
    self endon(#"change_state");
    self endon(#"death");
    enemy = self.var_f23a98eb;
    var_5ed1df9b = 0;
    var_8a282a6c = self function_6727edba(enemy);
    self animscripted("anim_notify", enemy gettagorigin(self.var_4dfc2454), enemy gettagangles(self.var_4dfc2454), var_8a282a6c, "normal", undefined, undefined, 0.3, 0.3);
    self clientfield::set("glaive_blood_fx", 1);
    self waittill(#"anim_notify");
    if (isalive(enemy) && isdefined(enemy.archetype) && enemy.archetype == "margwa") {
        if (isdefined(enemy.chop_actor_cb)) {
            var_5ed1df9b = 1;
            enemy.var_7d75bfbb = 1;
            enemy thread function_e25879ca(5);
            self.owner [[ enemy.chop_actor_cb ]](enemy, self, self.weapon);
        }
    } else {
        var_ba284aab = getaiteamarray("axis");
        foreach (target in var_ba284aab) {
            if (distance2dsquared(self.origin, target.origin) < -128 * -128) {
                if (isdefined(target.archetype) && target.archetype == "margwa") {
                    continue;
                }
                target dodamage(target.health + 100, self.origin, self.owner, self, "none", "MOD_UNKNOWN", 0, self.weapon);
                self playsound("wpn_sword2_imp");
                if (isactor(target)) {
                    target zombie_utility::gib_random_parts();
                    target startragdoll();
                    target launchragdoll(100 * vectornormalize(target.origin - self.origin));
                }
            }
        }
    }
    self waittill(#"anim_notify", notetrack);
    while (!isdefined(notetrack) || notetrack != "end") {
        self waittill(#"anim_notify", notetrack);
    }
    self clientfield::set("glaive_blood_fx", 0);
    if (var_5ed1df9b) {
        target = function_7ab362db();
        self.var_f23a98eb = target;
    }
    self vehicle_ai::set_state("combat");
}

// Namespace glaive
// Params 1, eflags: 0x0
// Checksum 0x3a1f0cb2, Offset: 0x1db0
// Size: 0x26
function function_e25879ca(duration) {
    self endon(#"death");
    wait duration;
    self.var_7d75bfbb = undefined;
}

// Namespace glaive
// Params 0, eflags: 0x0
// Checksum 0x8f9968f4, Offset: 0x1de0
// Size: 0x3fc
function function_bd13793a() {
    self endon(#"hash_6e5855cf");
    self thread function_adad389c();
    starttime = gettime();
    self asmrequestsubstate("forward@movement");
    while (gettime() - starttime < self.var_7cc7e526 * 1000 * 0.1) {
        function_3f19103d();
        var_86bafe71 = vehicle_ai::gettargetpos(self.owner, 1) - (0, 0, 4);
        var_1a6b5a89 = anglestoforward(self.owner.angles);
        targetpos = var_86bafe71 + 80 * var_1a6b5a89;
        searchcenter = self getclosestpointonnavvolume(var_86bafe71);
        if (isdefined(searchcenter)) {
            queryresult = positionquery_source_navigation(searchcenter, 0, -112, 32, 12, self);
            foundpath = 0;
            foreach (point in queryresult.data) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x45>"] = distancesquared(point.origin, targetpos) * -1;
                #/
                point.score += distancesquared(point.origin, targetpos) * -1;
            }
            vehicle_ai::positionquery_postprocess_sortscore(queryresult);
            self vehicle_ai::positionquery_debugscores(queryresult);
            foreach (point in queryresult.data) {
                self.current_pathto_pos = point.origin;
                foundpath = self setvehgoalpos(self.current_pathto_pos, 1, 1);
                if (foundpath) {
                    break;
                }
            }
            if (!foundpath) {
                self.current_pathto_pos = searchcenter;
                self setvehgoalpos(self.current_pathto_pos, 1, 1);
            }
        }
        wait 1;
    }
    self asmrequestsubstate("idle@movement");
}

// Namespace glaive
// Params 0, eflags: 0x0
// Checksum 0x6b31f08f, Offset: 0x21e8
// Size: 0x364
function function_7ffdbe09() {
    self thread function_11952f05();
    starttime = gettime();
    self asmrequestsubstate("forward@movement");
    while (gettime() - starttime < self.var_7cc7e526 * 1000 * 0.3) {
        function_3f19103d();
        targetpos = vehicle_ai::gettargetpos(self.owner, 1);
        queryresult = positionquery_source_navigation(targetpos, 0, 64, 64, 8, self);
        foundpath = 0;
        trace_count = 0;
        foreach (point in queryresult.data) {
            if (sighttracepassed(self.origin, point.origin, 0, undefined)) {
                trace_count++;
                if (trace_count > 3) {
                    wait 0.05;
                    trace_count = 0;
                }
                if (!bullettracepassed(self.origin, point.origin, 0, self)) {
                    continue;
                }
            } else {
                continue;
            }
            self.current_pathto_pos = point.origin;
            foundpath = self setvehgoalpos(self.current_pathto_pos, 1, 1);
            if (foundpath) {
                break;
            }
        }
        if (!foundpath) {
            foreach (point in queryresult.data) {
                self.current_pathto_pos = point.origin;
                foundpath = self setvehgoalpos(self.current_pathto_pos, 1, 0);
                if (foundpath) {
                    break;
                }
            }
        }
        wait 1;
    }
    if (isdefined(self.owner)) {
        self.origin = self.owner.origin + (0, 0, 40);
    }
    self notify(#"returned_to_owner");
    wait 2;
}

// Namespace glaive
// Params 0, eflags: 0x0
// Checksum 0x373944f1, Offset: 0x2558
// Size: 0xb6
function function_11952f05() {
    self endon(#"death");
    while (abs(self.origin[2] - self.owner.origin[2]) > 80 * 80 || isdefined(self.owner) && distance2dsquared(self.origin, self.owner.origin) > 80 * 80) {
        wait 0.1;
    }
    self notify(#"returned_to_owner");
}

// Namespace glaive
// Params 0, eflags: 0x0
// Checksum 0xe937d992, Offset: 0x2618
// Size: 0x12a
function function_adad389c() {
    self endon(#"death");
    while (abs(self.origin[2] - self.owner.origin[2]) > -96 * -96 || distance2dsquared(self.origin, self.owner.origin) > -96 * -96 || isdefined(self.owner) && !util::within_fov(self.owner.origin, self.owner.angles, self.origin, cos(60))) {
        wait 0.1;
    }
    self asmrequestsubstate("idle@movement");
    self notify(#"hash_6e5855cf");
}

// Namespace glaive
// Params 4, eflags: 0x0
// Checksum 0x72c20d9d, Offset: 0x2750
// Size: 0x26
function function_226d16ed(einflictor, eattacker, smeansofdeath, weapon) {
    return false;
}

// Namespace glaive
// Params 15, eflags: 0x0
// Checksum 0x28d9cd22, Offset: 0x2780
// Size: 0x80
function function_c6e986c3(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    return true;
}

