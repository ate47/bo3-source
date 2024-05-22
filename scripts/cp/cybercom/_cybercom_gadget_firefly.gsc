#using scripts/cp/_achievements;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/shared/statemachine_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/animation_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_3ed98204;

// Namespace namespace_3ed98204
// Params 0, eflags: 0x1 linked
// Checksum 0xd697869, Offset: 0x8b0
// Size: 0xc4
function init() {
    clientfield::register("vehicle", "firefly_state", 1, 4, "int");
    clientfield::register("actor", "firefly_state", 1, 4, "int");
    scene::add_scene_func("p7_fxanim_gp_ability_firefly_launch_bundle", &function_1e89505d, "play");
    scene::add_scene_func("p7_fxanim_gp_ability_firebug_launch_bundle", &function_1e89505d, "play");
}

// Namespace namespace_3ed98204
// Params 0, eflags: 0x1 linked
// Checksum 0xf97f2a90, Offset: 0x980
// Size: 0x184
function main() {
    namespace_d00ec32::function_36b56038(2, 8, 1);
    level.cybercom.firefly_swarm = spawnstruct();
    level.cybercom.firefly_swarm.var_875da84b = &function_875da84b;
    level.cybercom.firefly_swarm.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.firefly_swarm.var_bdb47551 = &function_bdb47551;
    level.cybercom.firefly_swarm.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.firefly_swarm.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.firefly_swarm._on = &_on;
    level.cybercom.firefly_swarm._off = &_off;
    level.cybercom.firefly_swarm.var_4135a1c4 = &function_4135a1c4;
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0xadc32b30, Offset: 0xb10
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_3ed98204
// Params 2, eflags: 0x1 linked
// Checksum 0x5f7ce284, Offset: 0xb28
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_3ed98204
// Params 2, eflags: 0x1 linked
// Checksum 0xd8ea36de, Offset: 0xb48
// Size: 0xcc
function function_bdb47551(slot, weapon) {
    self.cybercom.var_9d8e0758 = &function_8aac802c;
    self.cybercom.var_c40accd3 = &function_602b28e9;
    self thread cybercom::function_b5f4e597(weapon);
    self cybercom::function_8257bcb3("base_rifle", 2);
    self cybercom::function_8257bcb3("fem_rifle", 2);
    self cybercom::function_8257bcb3("riotshield", 2);
}

// Namespace namespace_3ed98204
// Params 2, eflags: 0x1 linked
// Checksum 0xafacf266, Offset: 0xc20
// Size: 0x14
function function_39ea6a1b(slot, weapon) {
    
}

// Namespace namespace_3ed98204
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xc40
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_3ed98204
// Params 2, eflags: 0x1 linked
// Checksum 0x2f1d4256, Offset: 0xc50
// Size: 0xf4
function _on(slot, weapon) {
    cybercom::function_adc40f11(weapon, 1);
    self thread function_519bddcd(self function_1a9006bd("cybercom_fireflyswarm") == 2);
    self notify(#"bhtn_action_notify", "firefly_deploy");
    if (isplayer(self)) {
        itemindex = getitemindexfromref("cybercom_fireflyswarm");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
}

// Namespace namespace_3ed98204
// Params 2, eflags: 0x1 linked
// Checksum 0xc9f26572, Offset: 0xd50
// Size: 0x14
function _off(slot, weapon) {
    
}

// Namespace namespace_3ed98204
// Params 2, eflags: 0x1 linked
// Checksum 0x36b4b19, Offset: 0xd70
// Size: 0x14
function function_4135a1c4(slot, weapon) {
    
}

// Namespace namespace_3ed98204
// Params 3, eflags: 0x1 linked
// Checksum 0x6e6bebce, Offset: 0xd90
// Size: 0x2dc
function function_2cba8648(target, var_9bc2efcb, upgraded) {
    if (!isdefined(var_9bc2efcb)) {
        var_9bc2efcb = 1;
    }
    if (!isdefined(upgraded)) {
        upgraded = 1;
    }
    self endon(#"death");
    if (self.archetype != "human") {
        return;
    }
    if (isdefined(var_9bc2efcb) && var_9bc2efcb) {
        type = self cybercom::function_5e3d3aa();
        self orientmode("face default");
        self animscripted("ai_cybercom_anim", self.origin, self.angles, "ai_base_rifle_" + type + "_exposed_cybercom_activate");
        self playsound("gdt_firefly_activate_npc");
        self waittillmatch(#"hash_39fa7e38", "fire");
    }
    if (isarray(target)) {
        foreach (guy in target) {
            if (!isdefined(guy)) {
                continue;
            }
            if (guy.archetype == "human" || guy.archetype == "human_riotshield" || isdefined(guy.archetype) && guy.archetype == "zombie") {
                self thread function_519bddcd(upgraded, guy, 1);
            }
        }
        return;
    }
    if (isdefined(target)) {
        if (target.archetype == "human" || target.archetype == "human_riotshield" || isdefined(target.archetype) && target.archetype == "zombie") {
            self thread function_519bddcd(upgraded, target);
        }
    }
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0xf5d479f6, Offset: 0x1078
// Size: 0x11c
function function_1e89505d(a_ents) {
    anim_model = a_ents["ability_firefly_launch"];
    anim_model waittill(#"hash_9571598b");
    if (isdefined(anim_model)) {
        origin = anim_model gettagorigin("tag_fx_01_end_jnt");
        angles = anim_model gettagangles("tag_fx_01_end_jnt");
        anim_model delete();
    }
    if (isdefined(self.owner)) {
        if (!isdefined(origin)) {
            origin = self.owner.origin + (0, 0, 72);
        }
        if (!isdefined(angles)) {
            angles = self.owner.angles;
        }
        self.owner notify(#"hash_74e27b96", origin, angles);
    }
}

// Namespace namespace_3ed98204
// Params 0, eflags: 0x1 linked
// Checksum 0x71a2327f, Offset: 0x11a0
// Size: 0xd2
function function_a767f9b4() {
    aiarray = getaiarray();
    foreach (ai in aiarray) {
        if (ai === self) {
            continue;
        }
        if (ai.var_375cf54a === 1) {
            ai setpersonalignore(self);
        }
    }
}

// Namespace namespace_3ed98204
// Params 4, eflags: 0x1 linked
// Checksum 0xfa7bc0be, Offset: 0x1280
// Size: 0x968
function function_519bddcd(upgraded, targetent, var_b15e885a, var_b6dd531c) {
    if (!isdefined(var_b15e885a)) {
        var_b15e885a = getdvarint("scr_firefly_swarm_count", 3);
    }
    if (!isdefined(var_b6dd531c)) {
        var_b6dd531c = getdvarint("scr_firefly_swarm_split_count", 0);
    }
    self endon(#"death");
    lifetime = getdvarint("scr_firefly_swarm_lifetime", 14);
    var_3691675 = var_b6dd531c;
    var_c1ee81b = 0;
    var_8cdffe04 = 0;
    var_4f33000c = [];
    if (isdefined(targetent.is_disabled) && isdefined(targetent) && targetent.is_disabled) {
        targetent = undefined;
    }
    if (!isvehicle(self)) {
        var_171f5aa7 = spawnstruct();
        var_171f5aa7.owner = self;
        if (isplayer(self)) {
            origin = self geteye();
            angles = self getplayerangles();
        } else {
            origin = self gettagorigin("tag_eye");
            angles = self gettagangles("tag_eye");
        }
        var_2bcb465b = origin + anglestoforward(angles) * 100;
        trace = bullettrace(origin, var_2bcb465b, 0, undefined);
        if (trace["fraction"] == 1) {
            var_171f5aa7.origin = origin;
            var_171f5aa7.angles = angles;
            if (upgraded) {
                if (sessionmodeiscampaignzombiesgame() && isworldpaused()) {
                } else {
                    var_171f5aa7 thread scene::play("p7_fxanim_gp_ability_firebug_launch_bundle");
                    origin, angles = self waittill(#"hash_74e27b96");
                }
            } else if (sessionmodeiscampaignzombiesgame() && isworldpaused()) {
            } else {
                var_171f5aa7 thread scene::play("p7_fxanim_gp_ability_firefly_launch_bundle");
                origin, angles = self waittill(#"hash_74e27b96");
            }
        } else {
            origin = self.origin + (0, 0, 72);
            angles = self.angles;
        }
        if (upgraded) {
            lifetime = getdvarint("scr_firefly_swarm_upgraded_lifetime", 14);
            var_8cdffe04 = getdvarint("scr_firefly_swarm_firebug_count", 1);
        }
        lifetime *= 1000;
        var_e0d7f279 = gettime() + lifetime;
        var_4f33000c = self function_cd0239e5(self.origin, self.angles);
    } else {
        var_e0d7f279 = self.lifetime;
        var_b15e885a = 1;
        var_3691675 = 0;
        var_c1ee81b = 1;
        var_8cdffe04 = isdefined(self.var_dd7b8ea) ? self.var_dd7b8ea : 0;
        origin = self.origin;
        angles = self.angles;
    }
    while (var_b15e885a) {
        swarm = spawnvehicle("spawner_bo3_cybercom_firefly", origin, angles, "firefly_swarm");
        var_b15e885a--;
        if (isdefined(swarm)) {
            if (sessionmodeiscampaignzombiesgame()) {
                swarm setignorepauseworld(1);
            }
            swarm.threatbias = -300;
            if (!isdefined(targetent)) {
                if (var_4f33000c.size) {
                    targetent = cybercom::function_5ee38fe3(swarm.origin, var_4f33000c);
                    arrayremovevalue(var_4f33000c, targetent, 0);
                }
            }
            swarm.var_2344774d = level.cybercom.var_f9269224;
            swarm.owner = self;
            swarm.team = self.team;
            swarm.lifetime = var_e0d7f279;
            swarm.var_3691675 = var_3691675;
            swarm.targetent = targetent;
            swarm.var_35a76be7 = var_c1ee81b;
            swarm.var_dd7b8ea = var_8cdffe04;
            swarm.firefly = 1;
            swarm.debug = spawnstruct();
            swarm.debug.main = 0;
            swarm.debug.attack = 0;
            swarm.debug.hunt = 0;
            swarm.debug.move = 0;
            swarm.debug.dead = 0;
            swarm function_a767f9b4();
            swarm.state_machine = statemachine::create("brain", swarm, "swarm_change_state");
            swarm.state_machine statemachine::add_state("init", &function_c57b33a, &function_cad082e8, &function_744baaac);
            swarm.state_machine statemachine::add_state("main", &function_c57b33a, &function_4a163234, &function_744baaac);
            swarm.state_machine statemachine::add_state("move", &function_c57b33a, &function_cf23fec8, &function_744baaac);
            swarm.state_machine statemachine::add_state("attack", &function_c57b33a, &function_36654cef, &function_744baaac);
            swarm.state_machine statemachine::add_state("hunt", &function_c57b33a, &function_a3deb004, &function_744baaac);
            swarm.state_machine statemachine::add_state("dead", &function_c57b33a, &function_b7b30921, &function_744baaac);
            swarm.state_machine statemachine::set_state("init");
            targetent = undefined;
        }
        level notify(#"hash_61df3d1c", swarm);
        level.cybercom.var_f9269224 += 1;
        level.cybercom.var_12f85dec++;
    }
}

// Namespace namespace_3ed98204
// Params 0, eflags: 0x1 linked
// Checksum 0x154f396e, Offset: 0x1bf0
// Size: 0xe8
function function_54bc061f() {
    self endon(#"death");
    wait(0.1);
    for (;;) {
        self setspeed(self.settings.defaultmovespeed);
        self.current_pathto_pos = getnextmoveposition_tactical();
        if (isdefined(self.current_pathto_pos)) {
            usepathfinding = 1;
            if (self.isonnav === 0) {
                usepathfinding = 0;
            }
            if (self setvehgoalpos(self.current_pathto_pos, 1, usepathfinding)) {
                self thread path_update_interrupt();
                self vehicle_ai::waittill_pathing_done();
            }
        }
        wait(0.5);
    }
}

// Namespace namespace_3ed98204
// Params 0, eflags: 0x1 linked
// Checksum 0x70cc82ba, Offset: 0x1ce0
// Size: 0xa0
function path_update_interrupt() {
    self endon(#"death");
    self endon(#"near_goal");
    self endon(#"reached_end_node");
    wait(1);
    while (true) {
        if (isdefined(self.current_pathto_pos)) {
            if (distance2dsquared(self.current_pathto_pos, self.goalpos) > self.goalradius * self.goalradius) {
                wait(0.2);
                self notify(#"near_goal");
            }
        }
        wait(0.2);
    }
}

// Namespace namespace_3ed98204
// Params 0, eflags: 0x1 linked
// Checksum 0x104ac3e7, Offset: 0x1d88
// Size: 0x316
function getnextmoveposition_tactical() {
    if (self.goalforced) {
        goalpos = self getclosestpointonnavvolume(self.goalpos, 100);
        if (isdefined(goalpos)) {
            if (distancesquared(goalpos, self.goalpos) > 50 * 50) {
                self.isonnav = 0;
            }
            return goalpos;
        }
        return self.goalpos;
    }
    querymultiplier = 1;
    queryresult = positionquery_source_navigation(self.origin, 80, 500 * querymultiplier, 500, 3 * self.radius * querymultiplier, self, self.radius * querymultiplier);
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    self.isonnav = queryresult.centeronnav;
    best_point = undefined;
    best_score = -999999;
    foreach (point in queryresult.data) {
        randomscore = randomfloatrange(0, 100);
        disttooriginscore = point.disttoorigin2d * 0.2;
        point.score += randomscore + disttooriginscore;
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["fem_rifle"] = disttooriginscore;
        #/
        point.score += disttooriginscore;
        if (point.score > best_score) {
            best_score = point.score;
            best_point = point;
        }
    }
    self vehicle_ai::positionquery_debugscores(queryresult);
    if (!isdefined(best_point)) {
        return undefined;
    }
    return best_point.origin;
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0xf691e8f5, Offset: 0x20a8
// Size: 0x46
function function_744baaac(params) {
    if (isdefined(self.badplace)) {
        badplace_delete("swarmBP_" + self.var_2344774d);
        self.badplace = undefined;
    }
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0x7c4abdd6, Offset: 0x20f8
// Size: 0x14
function function_c57b33a(params) {
    wait(0.05);
}

// Namespace namespace_3ed98204
// Params 0, eflags: 0x1 linked
// Checksum 0xc9fc7b5d, Offset: 0x2118
// Size: 0x2c
function getenemyteam() {
    if (self.team === "axis") {
        return "allies";
    }
    return "axis";
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0xe27d6667, Offset: 0x2150
// Size: 0x634
function function_cad082e8(params) {
    self setmodel("tag_origin");
    self notsolid();
    self.notsolid = 1;
    self.vehaircraftcollisionenabled = 0;
    self notify(#"end_nudge_collision");
    self.ignoreall = 1;
    self.takedamage = 0;
    self.goalradius = 36;
    self.goalheight = 36;
    self.good_melee_target = 1;
    self setneargoalnotifydist(48);
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    if (getdvarint("scr_firefly_swarm_debug", 0)) {
        self thread cybercom::function_252cee46();
    }
    self thread function_55a395c8();
    self thread function_99d5c745();
    self clearforcedgoal();
    self setgoal(self.origin, 1, self.goalradius);
    if (!ispointinnavvolume(self.origin, "navvolume_small")) {
        if (isdefined(self.owner)) {
            var_74b53775 = self.owner geteye();
        } else {
            var_74b53775 = self.origin;
        }
        pointonnavvolume = self getclosestpointonnavvolume(var_74b53775, 100);
        if (isdefined(pointonnavvolume)) {
            if (!self.var_dd7b8ea) {
                self clientfield::set("firefly_state", 2);
            } else {
                self clientfield::set("firefly_state", 7);
            }
            self setvehgoalpos(pointonnavvolume, 1, 0);
            self util::waittill_any_timeout(2, "near_goal");
        }
    }
    self thread function_54bc061f();
    if (!(isdefined(self.var_35a76be7) && self.var_35a76be7)) {
        enemies = self function_8aac802c();
        var_d9574143 = arraysortclosest(enemies, self.origin, enemies.size, 0, 512);
        if (var_d9574143.size == 0) {
            angles = (self.angles[0], self.angles[1], 0);
            var_2bcb465b = self.origin + anglestoforward(angles) * -16;
            a_trace = bullettrace(self.origin, var_2bcb465b, 0, undefined, 1);
            var_a2dfe760 = a_trace["position"];
            queryresult = positionquery_source_navigation(var_a2dfe760, 0, 72, 72, 20, self);
            if (queryresult.data.size > 0) {
                pathsuccess = self findpath(self.origin, queryresult.data[0].origin, 1, 0);
                if (pathsuccess) {
                    if (getdvarint("scr_firefly_swarm_debug", 0)) {
                        level thread cybercom::debug_circle(queryresult.data[0].origin, 16, 10, (1, 0, 0));
                    }
                    self clearforcedgoal();
                    self setgoal(queryresult.data[0].origin, 1, self.goalradius);
                    if (!self.var_dd7b8ea) {
                        self clientfield::set("firefly_state", 2);
                    } else {
                        self clientfield::set("firefly_state", 7);
                    }
                    self util::waittill_any_timeout(5, "near_goal");
                }
            }
        }
    }
    if (isdefined(self.targetent) && isalive(self.targetent)) {
        self.targetent.swarm = self;
        self.state_machine statemachine::set_state("move");
        return;
    }
    self.state_machine statemachine::set_state("hunt");
}

// Namespace namespace_3ed98204
// Params 0, eflags: 0x1 linked
// Checksum 0x9631c0f9, Offset: 0x2790
// Size: 0xa0
function function_99d5c745() {
    self endon(#"hash_c547a8e7");
    self endon(#"death");
    wait(3);
    while (self.var_3691675 > 0) {
        wait(0.5);
        var_98949c32 = self function_3ab9233(getdvarint("scr_firefly_swarm_split_radius", 864));
        if (isdefined(var_98949c32)) {
            self thread function_519bddcd(0, var_98949c32);
            self.var_3691675--;
        }
    }
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0x27b62359, Offset: 0x2838
// Size: 0x350
function function_ba872fe6(target) {
    var_5b928902 = [];
    base = "base_rifle";
    if (isdefined(self.voiceprefix) && getsubstr(self.voiceprefix, 7) == "f") {
        base = "fem_rifle";
    } else if (target.archetype === "human_riotshield") {
        base = "riotshield";
    }
    type = target cybercom::function_5e3d3aa();
    if (type == "") {
        target.swarm = undefined;
        self.targetent = undefined;
        target.var_86386274 = gettime() + 1000;
        self.state_machine statemachine::set_state("main");
        return;
    }
    self thread function_45a6577f(target);
    self clientfield::set("firefly_state", 1);
    variant = self.owner cybercom::function_e06423b6(base);
    if (self.var_dd7b8ea > 0) {
        self.var_dd7b8ea--;
        var_5b928902["intro"] = "ai_" + base + "_" + type + "_exposed_swarm_upg_react_intro" + variant;
        target thread function_4c41b2f7(self, var_5b928902, getweapon("gadget_firefly_swarm_upgraded"));
        target notify(#"bhtn_action_notify", "fireflyAttack");
        target clientfield::set("firefly_state", 9);
    } else {
        if (target.archetype === "human") {
            var_5b928902["intro"] = "ai_" + base + "_" + type + "_exposed_swarm_react_intro" + variant;
            var_5b928902["outro"] = "ai_" + base + "_" + type + "_exposed_swarm_react_outro" + variant;
        } else {
            var_5b928902 = [];
        }
        target clientfield::set("firefly_state", 4);
        target thread function_34de18ba(self, var_5b928902, getweapon("gadget_firefly_swarm"));
        target notify(#"bhtn_action_notify", "fireflyAttack");
    }
    self waittill(#"hash_b07f7e73");
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0xcd248b28, Offset: 0x2b90
// Size: 0x164
function function_6fb6c7d7(target) {
    /#
        assert(isdefined(target));
    #/
    if (!self.var_dd7b8ea) {
        target clientfield::set("firefly_state", 4);
    } else {
        target clientfield::set("firefly_state", 9);
    }
    if (self.var_dd7b8ea > 0) {
        self.var_dd7b8ea--;
        target clientfield::set("arch_actor_fire_fx", 1);
        target.health = 1;
    }
    wait(1);
    if (isdefined(target)) {
        target.swarm = undefined;
    }
    wait(randomintrange(3, 7));
    if (isdefined(target) && isalive(target)) {
        target dodamage(target.health, target.origin, undefined, undefined, "none", "MOD_BURNED");
    }
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0xcbd5a040, Offset: 0x2d00
// Size: 0x1f0
function function_cb5f9a2(target) {
    /#
        assert(isdefined(target));
    #/
    if (!self.var_dd7b8ea) {
        target clientfield::set("firefly_state", 4);
    } else {
        target clientfield::set("firefly_state", 9);
    }
    self thread function_45a6577f(target);
    self clientfield::set("firefly_state", 1);
    var_5b928902 = [];
    if (self.var_dd7b8ea > 0 && target.health <= getdvarint("scr_firefly_swarm_warlord_hitpoint_allowed_thresh", 400)) {
        self.var_dd7b8ea--;
        target thread function_4c41b2f7(self, var_5b928902, getweapon("gadget_firefly_swarm_upgraded"));
        target notify(#"bhtn_action_notify", "fireflyAttack");
        target clientfield::set("firefly_state", 9);
    } else {
        target clientfield::set("firefly_state", 4);
        target thread function_34de18ba(self, var_5b928902, getweapon("gadget_firefly_swarm"));
        target notify(#"bhtn_action_notify", "fireflyAttack");
    }
    self waittill(#"hash_b07f7e73");
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0x6169ce67, Offset: 0x2ef8
// Size: 0xbc
function function_eb96939e(target) {
    self thread function_326c3df4(target);
    if (isdefined(self.owner)) {
        attacker = self.owner;
    } else {
        attacker = self;
    }
    target dodamage(getdvarint("scr_swarm_player_damage", 50), target.origin, attacker, self, "none", "MOD_UNKNOWN", 0, getweapon("gadget_firefly_swarm_upgraded"));
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0xf45241ef, Offset: 0x2fc0
// Size: 0x39c
function function_36654cef(params) {
    self endon(#"hash_c547a8e7");
    self endon(#"death");
    self.debug.attack++;
    self clientfield::set("firefly_state", 1);
    target = self.targetent;
    if (!isdefined(target) || !isalive(target)) {
        self.targetent = undefined;
        self.state_machine statemachine::set_state("main");
        return;
    }
    target notify(#"hash_f8c5dd60", getweapon("gadget_firefly_swarm"), self.owner);
    if (!self.var_dd7b8ea) {
        target clientfield::set("firefly_state", 4);
    } else {
        target clientfield::set("firefly_state", 9);
    }
    if (isdefined(target.archetype)) {
        if (target.archetype == "human" || target.archetype == "human_riotshield") {
            self setgoal(self.targetent.origin + (0, 0, 48), 1, self.goalradius);
            badplace_cylinder("swarmBP_" + self.var_2344774d, 0, target.origin, 256, 80, "axis");
            self.badplace = 1;
            self function_ba872fe6(target);
        } else if (target.archetype == "zombie") {
            self function_6fb6c7d7(target);
        } else if (target.archetype == "warlord") {
            self function_cb5f9a2(target);
        }
    } else if (isplayer(target)) {
        self setgoal(self.targetent.origin + (0, 0, 48), 1, self.goalradius);
        badplace_cylinder("swarmBP_" + self.var_2344774d, 0, target.origin, 256, 80, "axis");
        self.badplace = 1;
        self function_eb96939e(target);
    }
    self.targetent = undefined;
    self.state_machine statemachine::set_state("main");
    self.debug.attack--;
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0xccf3c95b, Offset: 0x3368
// Size: 0x3e
function function_45a6577f(target) {
    self endon(#"death");
    self endon(#"hash_b07f7e73");
    target waittill(#"death");
    self notify(#"hash_b07f7e73");
}

// Namespace namespace_3ed98204
// Params 3, eflags: 0x5 linked
// Checksum 0x96299d04, Offset: 0x33b0
// Size: 0xba
function function_edd19e27(swarm, var_5b928902, weapon) {
    self endon(#"death");
    if (isdefined(swarm)) {
        self dodamage(5, self.origin, swarm.owner, swarm, "none", "MOD_BURNED", 0, weapon, -1, 1);
    }
    if (!self cybercom::function_421746e0()) {
        self waittillmatch(#"bhtn_action_terminate", "specialpain");
    }
    self notify(#"hash_2a24f27a");
}

// Namespace namespace_3ed98204
// Params 0, eflags: 0x5 linked
// Checksum 0x6a605b37, Offset: 0x3478
// Size: 0x3c
function function_6fffd543() {
    corpse = self waittill(#"actor_corpse");
    corpse clientfield::set("arch_actor_fire_fx", 2);
}

// Namespace namespace_3ed98204
// Params 3, eflags: 0x5 linked
// Checksum 0xdec40ca7, Offset: 0x34c0
// Size: 0x344
function function_4c41b2f7(swarm, var_5b928902, weapon) {
    self endon(#"death");
    self.ignoreall = 1;
    self.is_disabled = 1;
    var_c318824b = 0;
    self notify(#"hash_37486b44", swarm);
    level notify(#"hash_37486b44", self, swarm);
    if (self cybercom::islinked()) {
        self unlink();
        var_c318824b = 1;
    }
    if (!(isdefined(var_c318824b) && var_c318824b) && isdefined(var_5b928902["intro"])) {
        self animscripted("swarm_intro_anim", self.origin, self.angles, var_5b928902["intro"]);
        self waittillmatch(#"hash_352d2dcc", "end");
    }
    self clientfield::set("arch_actor_fire_fx", 1);
    self thread function_6fffd543();
    if (!(isdefined(var_c318824b) && var_c318824b)) {
        self thread function_edd19e27(swarm, var_5b928902, weapon);
        self util::waittill_any_timeout(getdvarint("scr_firefly_swarm_human_burn_duration", 10), "firebug_time_to_die");
    }
    self clientfield::set("firefly_state", 10);
    if (isdefined(swarm)) {
        swarm notify(#"hash_b07f7e73");
        if (isdefined(self.voiceprefix) && isdefined(self.var_273d3e89)) {
            self thread battlechatter::function_81d8fcf2(self.voiceprefix + self.var_273d3e89 + "_exert_firefly_burning", 1);
        }
        swarm.owner notify(#"hash_304642e3");
        self dodamage(self.health, self.origin, swarm.owner, swarm, "none", "MOD_BURNED", 0, weapon, -1, 1);
        return;
    }
    if (isdefined(self.voiceprefix) && isdefined(self.var_273d3e89)) {
        self thread battlechatter::function_81d8fcf2(self.voiceprefix + self.var_273d3e89 + "_exert_firefly_burning", 1);
    }
    self dodamage(self.health, self.origin, undefined, undefined, "none", "MOD_BURNED", 0, weapon, -1, 1);
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x4
// Checksum 0x188338f0, Offset: 0x3810
// Size: 0x72
function function_77e5963a(swarm) {
    while (isdefined(swarm)) {
        self util::waittill_any_timeout(1, "damage");
        if (isdefined(self) && self.health <= 0) {
            self clientfield::set("firefly_state", 10);
            return;
        }
    }
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x5 linked
// Checksum 0x88c1f5d2, Offset: 0x3890
// Size: 0x54
function function_369d3494(swarm) {
    swarm endon(#"death");
    corpse = self waittill(#"actor_corpse");
    corpse clientfield::set("firefly_state", 10);
}

// Namespace namespace_3ed98204
// Params 4, eflags: 0x0
// Checksum 0xa54d7d0a, Offset: 0x38f0
// Size: 0xb4
function function_963f8ef6(match, note, var_1ccbc268, end) {
    self endon(#"death");
    if (isdefined(end)) {
        self endon(end);
        while (true) {
            if (isdefined(match)) {
                self waittillmatch(match, note);
            } else {
                self waittill(note);
            }
            self notify(var_1ccbc268);
        }
        return;
    }
    if (isdefined(match)) {
        self waittillmatch(match, note);
    } else {
        self waittill(note);
    }
    self notify(var_1ccbc268);
}

// Namespace namespace_3ed98204
// Params 3, eflags: 0x5 linked
// Checksum 0xa0b31d42, Offset: 0x39b0
// Size: 0x46c
function function_34de18ba(swarm, var_5b928902, weapon) {
    self endon(#"death");
    self thread function_369d3494(swarm);
    var_ee89044a = self.badplaceawareness;
    self.badplaceawareness = 0.1;
    self.is_disabled = 1;
    self orientmode("face point", swarm.origin);
    self notify(#"hash_4457f945", swarm);
    level notify(#"hash_4457f945", self, swarm);
    if (self cybercom::function_421746e0()) {
        self kill(self.origin, isdefined(swarm.owner) ? swarm.owner : undefined);
        if (isdefined(swarm)) {
            swarm notify(#"hash_b07f7e73");
        }
        return;
    }
    if (!isalive(self) || self isragdoll()) {
        return;
    }
    if (isdefined(var_5b928902["intro"])) {
        self animscripted("swarm_intro_anim", self.origin, self.angles, var_5b928902["intro"]);
        self thread cybercom::function_cf64f12c("damage", "swarm_intro_anim");
        self waittillmatch(#"hash_352d2dcc", "end");
    }
    for (attack = 1; attack && isdefined(swarm); attack = isdefined(swarm) && !(isdefined(swarm.var_24bf6015) && swarm.var_24bf6015) && distancesquared(self.origin + (0, 0, 48), swarm.origin) < getdvarint("scr_firefly_swarm_attack_radius", 110) * getdvarint("scr_firefly_swarm_attack_radius", 110) && isalive(self)) {
        self dodamage(5, self.origin, swarm.owner, swarm, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
        wait(0.05);
        self waittillmatch(#"bhtn_action_terminate", "specialpain");
    }
    self notify(#"hash_b07f7e73");
    if (isalive(self) && !self isragdoll()) {
        self clientfield::set("firefly_state", 5);
        self.badplaceawareness = var_ee89044a;
        self.swarm = undefined;
        self orientmode("face default");
        if (isdefined(var_5b928902["outro"])) {
            self animscripted("swarm_outro_anim", self.origin, self.angles, var_5b928902["outro"]);
            self thread cybercom::function_cf64f12c("damage", "swarm_outro_anim");
            self waittillmatch(#"hash_f331901", "end");
        }
        self.is_disabled = undefined;
    }
    if (isdefined(swarm)) {
        swarm notify(#"hash_b07f7e73");
    }
}

// Namespace namespace_3ed98204
// Params 0, eflags: 0x1 linked
// Checksum 0xbfe99ad4, Offset: 0x3e28
// Size: 0xe4
function function_4169c117() {
    if (isdefined(self)) {
        self notify(#"hash_c547a8e7");
        if (isdefined(self.targetent) && !isplayer(self.targetent)) {
            self.targetent clientfield::set("firefly_state", 5);
            self.targetent.swarm = undefined;
            self.targetent.var_ce97216f = gettime() + 2000;
        }
        level.cybercom.var_12f85dec--;
        achievements::function_b2d1aafa();
        self function_744baaac();
        self delete();
    }
}

// Namespace namespace_3ed98204
// Params 0, eflags: 0x1 linked
// Checksum 0x1815d5b3, Offset: 0x3f18
// Size: 0x4c
function function_55a395c8() {
    self endon(#"death");
    while (gettime() < self.lifetime) {
        wait(1);
    }
    self.var_24bf6015 = 1;
    wait(2);
    self function_4169c117();
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0x401b90a4, Offset: 0x3f70
// Size: 0x15c
function function_b7b30921(params) {
    self notify(#"hash_c547a8e7");
    self endon(#"death");
    self clearforcedgoal();
    if (!self.var_dd7b8ea) {
        self clientfield::set("firefly_state", 5);
    } else {
        self clientfield::set("firefly_state", 10);
    }
    if (isdefined(self.targetent) && !isplayer(self.targetent)) {
        self.targetent clientfield::set("firefly_state", 5);
        self.targetent.swarm = undefined;
        self.targetent.var_ce97216f = gettime() + 2000;
    }
    self vehicle::toggle_sounds(0);
    if (isdefined(self.owner)) {
        self.owner notify(#"bhtn_action_notify", "firefly_end");
    }
    wait(3);
    self function_4169c117();
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0x1e0a005d, Offset: 0x40d8
// Size: 0x16c
function function_4a163234(params) {
    self endon(#"hash_c547a8e7");
    self endon(#"death");
    if (isdefined(self.var_24bf6015) && self.var_24bf6015) {
        self.state_machine statemachine::set_state("dead");
        return;
    }
    self.debug.main++;
    if (!isdefined(self.targetent)) {
        self.state_machine statemachine::set_state("hunt");
    } else if (distancesquared(self.targetent.origin + (0, 0, 48), self.origin) > getdvarint("scr_firefly_swarm_attack_radius", 110) * getdvarint("scr_firefly_swarm_attack_radius", 110)) {
        self.state_machine statemachine::set_state("move");
    } else {
        self.state_machine statemachine::set_state("attack");
    }
    self.debug.main--;
}

// Namespace namespace_3ed98204
// Params 0, eflags: 0x5 linked
// Checksum 0x378bf8f3, Offset: 0x4250
// Size: 0xf2
function function_8aac802c() {
    humans = arraycombine(getaispeciesarray(self getenemyteam(), "human"), getaispeciesarray("team3", "human"), 0, 0);
    zombies = arraycombine(getaispeciesarray(self getenemyteam(), "zombie"), getaispeciesarray("team3", "zombie"), 0, 0);
    return arraycombine(humans, zombies, 0, 0);
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x5 linked
// Checksum 0xcd42bbf, Offset: 0x4350
// Size: 0x1c8
function function_602b28e9(target) {
    if (isdefined(self.owner) && !self.owner cybercom::function_7a7d1608(target, getweapon("gadget_firefly_swarm"))) {
        return false;
    }
    if (target.archetype != "human" && target.archetype != "human_riotshield" && target.archetype != "zombie" && target.archetype != "warlord") {
        return false;
    }
    if (target cybercom::function_8fd8f5b1("cybercom_fireflyswarm")) {
        return false;
    }
    if (isdefined(target.swarm)) {
        return false;
    }
    if (isdefined(target.var_86386274)) {
        if (target.var_86386274 > gettime()) {
            return false;
        }
        target.var_86386274 = undefined;
    }
    if (isdefined(target.var_ce97216f) && gettime() < target.var_ce97216f) {
        return false;
    }
    if (isactor(target) && target cybercom::getentitypose() != "stand" && target cybercom::getentitypose() != "crouch") {
        return false;
    }
    return true;
}

// Namespace namespace_3ed98204
// Params 4, eflags: 0x1 linked
// Checksum 0x96f2d438, Offset: 0x4520
// Size: 0x1a2
function function_cd0239e5(origin, angles, var_10a84c6e, var_1a6983c2) {
    if (!isdefined(var_10a84c6e)) {
        var_10a84c6e = getdvarint("scr_firefly_swarm_hunt_radius", 1536);
    }
    if (!isdefined(var_1a6983c2)) {
        var_1a6983c2 = cos(45);
    }
    enemies = self function_8aac802c();
    var_d9574143 = arraysortclosest(enemies, origin, enemies.size, 0, var_10a84c6e);
    var_4f33000c = [];
    foreach (guy in var_d9574143) {
        if (!function_602b28e9(guy)) {
            continue;
        }
        if (util::within_fov(origin, angles, guy.origin, var_1a6983c2)) {
            var_4f33000c[var_4f33000c.size] = guy;
        }
    }
    return var_4f33000c;
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0x1a5d1eb0, Offset: 0x46d0
// Size: 0x224
function function_3ab9233(var_10a84c6e) {
    if (!isdefined(var_10a84c6e)) {
        var_10a84c6e = getdvarint("scr_firefly_swarm_hunt_radius", 1536);
    }
    self endon(#"hash_c547a8e7");
    self endon(#"death");
    enemies = self function_8aac802c();
    var_d9574143 = arraysortclosest(enemies, self.origin, enemies.size, 0, var_10a84c6e);
    closest = undefined;
    while (var_d9574143.size > 0) {
        closest = cybercom::function_5ee38fe3(self.origin, var_d9574143, var_10a84c6e);
        if (!function_602b28e9(closest)) {
            arrayremovevalue(var_d9574143, closest, 0);
            closest = undefined;
            wait(0.05);
            continue;
        }
        if (!isdefined(closest)) {
            break;
        }
        pathsuccess = 0;
        queryresult = positionquery_source_navigation(closest.origin, 0, -128, -128, 20, self);
        if (queryresult.data.size > 0) {
            pathsuccess = self findpath(self.origin, queryresult.data[0].origin, 1, 0);
        }
        if (!pathsuccess) {
            arrayremovevalue(var_d9574143, closest, 0);
            closest = undefined;
            wait(0.05);
            continue;
        }
        break;
    }
    return closest;
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0x3963bb96, Offset: 0x4900
// Size: 0x1a4
function function_a3deb004(params) {
    self endon(#"hash_c547a8e7");
    self endon(#"death");
    self.debug.hunt++;
    self util::waittill_any_timeout(3, "near_goal");
    self clearforcedgoal();
    if (!self.var_dd7b8ea) {
        self clientfield::set("firefly_state", 1);
    } else {
        self clientfield::set("firefly_state", 6);
    }
    if (getdvarint("scr_firefly_swarm_debug", 0)) {
        self thread cybercom::debug_circle(self.origin, getdvarint("scr_firefly_swarm_hunt_radius", 1536), 0.1, (1, 1, 0));
    }
    self.targetent = self function_3ab9233();
    if (isdefined(self.targetent)) {
        self.targetent.swarm = self;
    }
    if (!isdefined(self.targetent) && isdefined(self.owner)) {
    }
    self.state_machine statemachine::set_state("main");
    self.debug.hunt--;
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0x6fe6dfcb, Offset: 0x4ab0
// Size: 0x1bc
function function_cf23fec8(params) {
    self endon(#"hash_c547a8e7");
    self endon(#"death");
    self.debug.move++;
    if (!self.var_dd7b8ea) {
        self clientfield::set("firefly_state", 2);
    } else {
        self clientfield::set("firefly_state", 7);
    }
    wait(0.5);
    self.goalradius = 12;
    self.goalheight = 12;
    if (!self.var_dd7b8ea) {
        self clientfield::set("firefly_state", 3);
    } else {
        self clientfield::set("firefly_state", 8);
    }
    self clearforcedgoal();
    if (isdefined(self.targetent)) {
        self setgoal(self.targetent.origin + (0, 0, 48), 1, self.goalradius);
        event = self util::waittill_any_timeout(30, "near_goal");
    }
    self.state_machine statemachine::set_state("main");
    self.debug.move--;
}

// Namespace namespace_3ed98204
// Params 1, eflags: 0x1 linked
// Checksum 0x259916c8, Offset: 0x4c78
// Size: 0x3c
function function_326c3df4(player) {
    self endon(#"disconnect");
    player shellshock("proximity_grenade", 2, 0);
}

