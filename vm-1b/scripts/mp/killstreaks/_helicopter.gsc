#using scripts/mp/_challenges;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_player;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_dogs;
#using scripts/mp/killstreaks/_flak_drone;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreak_detect;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_heatseekingmissile;
#using scripts/shared/weapons/_weaponobjects;

#using_animtree("mp_vehicles");

#namespace helicopter;

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0xfd75823d, Offset: 0x1408
// Size: 0xd7
function precachehelicopter(model, type) {
    if (!isdefined(type)) {
        type = "blackhawk";
    }
    level.vehicle_deathmodel[model] = model;
    level.heli_sound["hit"] = "evt_helicopter_hit";
    level.heli_sound["hitsecondary"] = "evt_helicopter_hit";
    level.heli_sound["damaged"] = "null";
    level.heli_sound["spinloop"] = "evt_helicopter_spin_loop";
    level.heli_sound["spinstart"] = "evt_helicopter_spin_start";
    level.heli_sound["crash"] = "evt_helicopter_midair_exp";
    level.heli_sound["missilefire"] = "wpn_hellfire_fire_npc";
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xf352f60b, Offset: 0x14e8
// Size: 0x234
function usekillstreakhelicopter(hardpointtype) {
    if (self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
        return false;
    }
    if (!isdefined(level.heli_paths) || !level.heli_paths.size) {
        /#
            iprintlnbold("<dev string:x28>");
        #/
        return false;
    }
    if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
        result = self selecthelicopterlocation(hardpointtype);
        if (!isdefined(result) || result == 0) {
            return false;
        }
    }
    destination = 0;
    missilesenabled = 0;
    if (hardpointtype == "helicopter_x2") {
        missilesenabled = 1;
    }
    assert(level.heli_paths.size > 0, "<dev string:x52>");
    random_path = randomint(level.heli_paths[destination].size);
    startnode = level.heli_paths[destination][random_path];
    protectlocation = undefined;
    armored = 0;
    if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
        protectlocation = (level.helilocation[0], level.helilocation[1], int(airsupport::getminimumflyheight()) - -56);
        armored = 0;
        startnode = getvalidprotectlocationstart(random_path, protectlocation, destination);
    }
    killstreak_id = self killstreakrules::killstreakstart(hardpointtype, self.team);
    if (killstreak_id == -1) {
        return false;
    }
    self killstreaks::play_killstreak_start_dialog(hardpointtype, self.team, killstreak_id);
    self thread announcehelicopterinbound(hardpointtype);
    thread heli_think(self, startnode, self.team, missilesenabled, protectlocation, hardpointtype, armored, killstreak_id);
    return true;
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xc3ca003b, Offset: 0x1728
// Size: 0x4a
function announcehelicopterinbound(hardpointtype) {
    team = self.team;
    self addweaponstat(killstreaks::get_killstreak_weapon(hardpointtype), "used", 1);
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x6503588f, Offset: 0x1780
// Size: 0x57a
function heli_path_graph() {
    path_start = getentarray("heli_start", "targetname");
    path_dest = getentarray("heli_dest", "targetname");
    loop_start = getentarray("heli_loop_start", "targetname");
    gunner_loop_start = getentarray("heli_gunner_loop_start", "targetname");
    leave_nodes = getentarray("heli_leave", "targetname");
    crash_start = getentarray("heli_crash_start", "targetname");
    assert(isdefined(path_start) && isdefined(path_dest), "<dev string:x7f>");
    for (i = 0; i < path_dest.size; i++) {
        startnode_array = [];
        isprimarydest = 0;
        destnode_pointer = path_dest[i];
        destnode = getent(destnode_pointer.target, "targetname");
        for (j = 0; j < path_start.size; j++) {
            todest = 0;
            for (currentnode = path_start[j]; isdefined(currentnode.target); currentnode = nextnode) {
                nextnode = getent(currentnode.target, "targetname");
                if (nextnode.origin == destnode.origin) {
                    todest = 1;
                    break;
                }
                airsupport::debug_print3d_simple("+", currentnode, (0, 0, -10));
                if (isdefined(nextnode.target)) {
                    airsupport::debug_line(nextnode.origin, getent(nextnode.target, "targetname").origin, (0.25, 0.5, 0.25), 5);
                }
                if (isdefined(currentnode.script_delay)) {
                    airsupport::debug_print3d_simple("Wait: " + currentnode.script_delay, currentnode, (0, 0, 10));
                }
            }
            if (todest) {
                startnode_array[startnode_array.size] = getent(path_start[j].target, "targetname");
                if (isdefined(path_start[j].script_noteworthy) && path_start[j].script_noteworthy == "primary") {
                    isprimarydest = 1;
                }
            }
        }
        assert(isdefined(startnode_array) && startnode_array.size > 0, "<dev string:x9f>");
        if (isprimarydest) {
            level.heli_primary_path = startnode_array;
            continue;
        }
        level.heli_paths[level.heli_paths.size] = startnode_array;
    }
    for (i = 0; i < loop_start.size; i++) {
        startnode = getent(loop_start[i].target, "targetname");
        level.heli_loop_paths[level.heli_loop_paths.size] = startnode;
    }
    assert(isdefined(level.heli_loop_paths[0]), "<dev string:xb9>");
    for (i = 0; i < gunner_loop_start.size; i++) {
        startnode = getent(gunner_loop_start[i].target, "targetname");
        startnode.isgunnerpath = 1;
        level.heli_loop_paths[level.heli_loop_paths.size] = startnode;
    }
    for (i = 0; i < path_start.size; i++) {
        if (isdefined(path_start[i].script_noteworthy) && path_start[i].script_noteworthy == "primary") {
            continue;
        }
        level.heli_startnodes[level.heli_startnodes.size] = path_start[i];
    }
    assert(isdefined(level.heli_startnodes[0]), "<dev string:xdf>");
    for (i = 0; i < leave_nodes.size; i++) {
        level.heli_leavenodes[level.heli_leavenodes.size] = leave_nodes[i];
    }
    assert(isdefined(level.heli_leavenodes[0]), "<dev string:x106>");
    for (i = 0; i < crash_start.size; i++) {
        crash_start_node = getent(crash_start[i].target, "targetname");
        level.heli_crash_paths[level.heli_crash_paths.size] = crash_start_node;
    }
    assert(isdefined(level.heli_crash_paths[0]), "<dev string:x12d>");
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0xb265566, Offset: 0x1d08
// Size: 0x58a
function init() {
    path_start = getentarray("heli_start", "targetname");
    loop_start = getentarray("heli_loop_start", "targetname");
    /#
        debug_refresh = 1;
    #/
    thread heli_update_global_dvars(debug_refresh);
    level.chaff_offset["attack"] = (-130, 0, -140);
    level.choppercomlinkfriendly = "veh_t7_drone_hunter";
    level.choppercomlinkenemy = "veh_t7_drone_hunter";
    level.chopperregular = "veh_t7_drone_hunter";
    precachehelicopter(level.chopperregular);
    precachehelicopter(level.choppercomlinkfriendly);
    precachehelicopter(level.choppercomlinkenemy);
    clientfield::register("helicopter", "heli_comlink_bootup_anim", 1, 1, "int");
    clientfield::register("helicopter", "heli_warn_targeted", 1, 1, "int");
    clientfield::register("helicopter", "heli_warn_locked", 1, 1, "int");
    clientfield::register("helicopter", "heli_warn_fired", 1, 1, "int");
    clientfield::register("helicopter", "active_camo", 1, 3, "int");
    clientfield::register("vehicle", "heli_comlink_bootup_anim", 1, 1, "int");
    clientfield::register("vehicle", "heli_warn_targeted", 1, 1, "int");
    clientfield::register("vehicle", "heli_warn_locked", 1, 1, "int");
    clientfield::register("vehicle", "heli_warn_fired", 1, 1, "int");
    clientfield::register("vehicle", "active_camo", 1, 3, "int");
    level.heli_paths = [];
    level.heli_loop_paths = [];
    level.heli_startnodes = [];
    level.heli_leavenodes = [];
    level.heli_crash_paths = [];
    level.last_start_node_index = 0;
    level.chopper_fx["explode"]["death"] = "killstreaks/fx_heli_exp_lg";
    level.chopper_fx["explode"]["guard"] = "killstreaks/fx_heli_exp_md";
    level.chopper_fx["explode"]["gunner"] = "killstreaks/fx_vtol_exp";
    level.chopper_fx["explode"]["large"] = "killstreaks/fx_heli_exp_sm";
    level.chopper_fx["damage"]["light_smoke"] = "killstreaks/fx_heli_smk_trail_engine_33";
    level.chopper_fx["damage"]["heavy_smoke"] = "killstreaks/fx_heli_smk_trail_engine_66";
    level.chopper_fx["smoke"]["trail"] = "killstreaks/fx_heli_smk_trail_tail";
    level.chopper_fx["fire"]["trail"]["large"] = "killstreaks/fx_heli_smk_trail_engine";
    level._effect["heli_comlink_light"]["friendly"] = "_debug/fx_debug_deleted_fx";
    level._effect["heli_comlink_light"]["enemy"] = "_debug/fx_debug_deleted_fx";
    level.var_a895d3b4 = mp_vehicles%veh_anim_future_heli_gearup_bay_open;
    killstreaks::register("helicopter_comlink", "helicopter_comlink", "killstreak_helicopter_comlink", "helicopter_used", &usekillstreakhelicopter, 1);
    killstreaks::function_f79fd1e9("helicopter_comlink", %KILLSTREAK_EARNED_HELICOPTER_COMLINK, %KILLSTREAK_HELICOPTER_COMLINK_NOT_AVAILABLE, %KILLSTREAK_HELICOPTER_COMLINK_INBOUND, undefined, %KILLSTREAK_HELICOPTER_COMLINK_HACKED);
    killstreaks::register_dialog("helicopter_comlink", "mpl_killstreak_heli", "helicopterDialogBundle", "helicopterPilotDialogBundle", "friendlyHelicopter", "enemyHelicopter", "enemyHelicopterMultiple", "friendlyHelicopterHacked", "enemyHelicopterHacked", "requestHelicopter", "threatHelicopter");
    killstreaks::register_alt_weapon("helicopter_comlink", "cobra_20mm_comlink");
    killstreaks::set_team_kill_penalty_scale("helicopter_comlink", 0);
    level.killstreaks["helicopter_comlink"].threatonkill = 1;
    level.killstreaks["inventory_helicopter_comlink"].threatonkill = 1;
    if (!path_start.size && !loop_start.size) {
        return;
    }
    heli_path_graph();
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xca27bb8c, Offset: 0x22a0
// Size: 0x553
function heli_update_global_dvars(debug_refresh) {
    do {
        level.heli_loopmax = function_91077906("scr_heli_loopmax", "2");
        level.heli_missile_rof = function_91077906("scr_heli_missile_rof", "2");
        level.heli_armor = function_91077906("scr_heli_armor", "500");
        level.heli_maxhealth = function_91077906("scr_heli_maxhealth", "1000");
        level.heli_amored_maxhealth = function_91077906("scr_heli_armored_maxhealth", "1500");
        level.heli_missile_max = function_91077906("scr_heli_missile_max", "20");
        level.heli_dest_wait = function_91077906("scr_heli_dest_wait", "8");
        level.heli_debug = function_91077906("scr_heli_debug", "0");
        level.heli_debug_crash = function_91077906("scr_heli_debug_crash", "0");
        level.heli_targeting_delay = function_c233870c("scr_heli_targeting_delay", "0.6");
        level.heli_turretreloadtime = function_c233870c("scr_heli_turretReloadTime", "0.5");
        level.heli_turretclipsize = function_91077906("scr_heli_turretClipSize", "80");
        level.heli_visual_range = isdefined(level.heli_visual_range_override) ? level.heli_visual_range_override : function_91077906("scr_heli_visual_range", "3500");
        level.heli_missile_range = function_91077906("scr_heli_missile_range", "100000");
        level.heli_health_degrade = function_91077906("scr_heli_health_degrade", "0");
        level.var_a570af72 = function_91077906("scr_heli_turret_angle_tan", "1");
        level.heli_turret_target_cone = function_c233870c("scr_heli_turret_target_cone", "0.6");
        level.heli_target_spawnprotection = function_91077906("scr_heli_target_spawnprotection", "5");
        level.heli_missile_regen_time = function_c233870c("scr_heli_missile_regen_time", "10");
        level.heli_turret_spinup_delay = function_c233870c("scr_heli_turret_spinup_delay", "1.0");
        level.heli_target_recognition = function_c233870c("scr_heli_target_recognition", "0.3");
        level.heli_missile_friendlycare = function_91077906("scr_heli_missile_friendlycare", "512");
        level.heli_missile_target_cone = function_c233870c("scr_heli_missile_target_cone", "0.6");
        level.heli_valid_target_cone = function_c233870c("scr_heli_missile_valid_target_cone", "0.7");
        level.heli_armor_bulletdamage = function_c233870c("scr_heli_armor_bulletdamage", "0.5");
        level.heli_attract_strength = function_c233870c("scr_heli_attract_strength", "1000");
        level.heli_attract_range = function_c233870c("scr_heli_attract_range", "20000");
        level.helicopterturretmaxangle = function_91077906("scr_helicopterTurretMaxAngle", "35");
        level.heli_protect_time = function_c233870c("scr_heli_protect_time", "60");
        level.heli_protect_pos_time = function_c233870c("scr_heli_protect_pos_time", "12");
        level.heli_protect_radius = function_91077906("scr_heli_protect_radius", "2000");
        level.heli_missile_reload_time = function_c233870c("scr_heli_missile_reload_time", "5.0");
        level.heli_warning_distance = function_91077906("scr_heli_warning_distance", "500");
        wait 1;
    } while (isdefined(debug_refresh));
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0x614c23a2, Offset: 0x2800
// Size: 0x39
function function_91077906(dvar, def) {
    return int(function_c233870c(dvar, def));
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0x2f38ea79, Offset: 0x2848
// Size: 0x6a
function function_c233870c(dvar, def) {
    if (getdvarstring(dvar) != "") {
        return getdvarfloat(dvar);
    }
    setdvar(dvar, def);
    return float(def);
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0x734e1438, Offset: 0x28c0
// Size: 0x32
function set_goal_pos(goalpos, stop) {
    self.heligoalpos = goalpos;
    self setvehgoalpos(goalpos, stop);
}

// Namespace helicopter
// Params 8, eflags: 0x0
// Checksum 0x920403fe, Offset: 0x2900
// Size: 0x1ac
function spawn_helicopter(owner, origin, angles, model, targetname, target_offset, hardpointtype, killstreak_id) {
    chopper = spawnhelicopter(owner, origin, angles, model, targetname);
    chopper.owner = owner;
    chopper clientfield::set("enemyvehicle", 1);
    chopper.attackers = [];
    chopper.attackerdata = [];
    chopper.attackerdamage = [];
    chopper.flareattackerdamage = [];
    chopper.destroyfunc = &destroyhelicopter;
    chopper.hardpointtype = hardpointtype;
    chopper.killstreak_id = killstreak_id;
    chopper.pilotistalking = 0;
    chopper setdrawinfrared(1);
    chopper.allowcontinuedlockonafterinvis = 1;
    chopper.soundmod = "heli";
    if (!isdefined(target_offset)) {
        target_offset = (0, 0, 0);
    }
    chopper.target_offset = target_offset;
    target_set(chopper, target_offset);
    if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
        chopper.allowhackingaftercloak = 1;
        chopper.flak_drone = flak_drone::spawn(chopper, &onflakdronedestroyed);
        chopper init_active_camo();
    }
    return chopper;
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x53c60734, Offset: 0x2ab8
// Size: 0x6a
function onflakdronedestroyed() {
    chopper = self;
    if (!isdefined(chopper)) {
        return;
    }
    chopper.numflares = 0;
    chopper killstreaks::play_pilot_dialog_on_owner("weaponDestroyed", "helicopter_comlink", chopper.killstreak_id);
    chopper thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", "death");
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xe195cef9, Offset: 0x2b30
// Size: 0x35
function explodeoncontact(hardpointtype) {
    self endon(#"death");
    wait 10;
    for (;;) {
        self waittill(#"touch");
        self thread heli_explode();
    }
}

// Namespace helicopter
// Params 3, eflags: 0x0
// Checksum 0xd7cee12a, Offset: 0x2b70
// Size: 0x113
function getvalidprotectlocationstart(random_path, protectlocation, destination) {
    startnode = level.heli_paths[destination][random_path];
    path_index = (random_path + 1) % level.heli_paths[destination].size;
    innofly = airsupport::crossesnoflyzone(protectlocation + (0, 0, 1), protectlocation);
    if (isdefined(innofly)) {
        protectlocation = (protectlocation[0], protectlocation[1], level.noflyzones[innofly].origin[2] + level.noflyzones[innofly].height);
    }
    noflyzone = airsupport::crossesnoflyzone(startnode.origin, protectlocation);
    while (isdefined(noflyzone) && path_index != random_path) {
        startnode = level.heli_paths[destination][path_index];
        if (isdefined(noflyzone)) {
            path_index = (path_index + 1) % level.heli_paths[destination].size;
        }
    }
    return level.heli_paths[destination][path_index];
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xb4fc3735, Offset: 0x2c90
// Size: 0x186
function getvalidrandomleavenode(start) {
    if (self === level.vtol) {
        foreach (node in level.heli_leavenodes) {
            if (isdefined(node.script_noteworthy) && node.script_noteworthy == "primary") {
                return node;
            }
        }
    }
    random_leave_node = randomint(level.heli_leavenodes.size);
    leavenode = level.heli_leavenodes[random_leave_node];
    path_index = (random_leave_node + 1) % level.heli_leavenodes.size;
    noflyzone = airsupport::crossesnoflyzone(leavenode.origin, start);
    isprimary = leavenode.script_noteworthy === "primary";
    while ((isdefined(noflyzone) || isprimary) && path_index != random_leave_node) {
        leavenode = level.heli_leavenodes[path_index];
        noflyzone = airsupport::crossesnoflyzone(leavenode.origin, start);
        isprimary = leavenode.script_noteworthy === "primary";
        path_index = (path_index + 1) % level.heli_leavenodes.size;
    }
    return level.heli_leavenodes[path_index];
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xb27ad09f, Offset: 0x2e20
// Size: 0xe2
function getvalidrandomstartnode(dest) {
    path_index = randomint(level.heli_startnodes.size);
    best_index = path_index;
    count = 0;
    for (i = 0; i < level.heli_startnodes.size; i++) {
        startnode = level.heli_startnodes[path_index];
        noflyzone = airsupport::crossesnoflyzone(startnode.origin, dest);
        if (!isdefined(noflyzone)) {
            best_index = path_index;
            if (path_index != level.last_start_node_index) {
                break;
            }
        }
        path_index = (path_index + 1) % level.heli_startnodes.size;
    }
    level.last_start_node_index = best_index;
    return level.heli_startnodes[best_index];
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xa09f4c21, Offset: 0x2f10
// Size: 0xd2
function getvalidrandomcrashnode(start) {
    random_leave_node = randomint(level.heli_crash_paths.size);
    leavenode = level.heli_crash_paths[random_leave_node];
    path_index = (random_leave_node + 1) % level.heli_crash_paths.size;
    noflyzone = airsupport::crossesnoflyzone(leavenode.origin, start);
    while (isdefined(noflyzone) && path_index != random_leave_node) {
        leavenode = level.heli_crash_paths[path_index];
        noflyzone = airsupport::crossesnoflyzone(leavenode.origin, start);
        path_index = (path_index + 1) % level.heli_crash_paths.size;
    }
    return level.heli_crash_paths[path_index];
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0x7c55a68, Offset: 0x2ff0
// Size: 0x32
function configureteampost(owner, ishacked) {
    chopper = self;
    owner thread watchforearlyleave(chopper);
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x8973b620, Offset: 0x3030
// Size: 0x82
function hackedcallbackpost(hacker) {
    heli = self;
    if (isdefined(heli.flak_drone)) {
        heli.flak_drone flak_drone::configureteam(heli, 1);
    }
    heli.endtime = gettime() + killstreak_bundles::get_hack_timeout() * 1000;
    heli.killstreakendtime = int(heli.endtime);
}

// Namespace helicopter
// Params 8, eflags: 0x0
// Checksum 0x2e366a9a, Offset: 0x30c0
// Size: 0x53a
function heli_think(owner, startnode, heli_team, missilesenabled, protectlocation, hardpointtype, armored, killstreak_id) {
    heliorigin = startnode.origin;
    heliangles = startnode.angles;
    if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
        choppermodelfriendly = level.choppercomlinkfriendly;
        choppermodelenemy = level.choppercomlinkenemy;
    } else {
        choppermodelfriendly = level.chopperregular;
        choppermodelenemy = level.chopperregular;
    }
    chopper = spawn_helicopter(owner, heliorigin, heliangles, "heli_ai_mp", choppermodelfriendly, (0, 0, 100), hardpointtype, killstreak_id);
    chopper.harpointtype = hardpointtype;
    chopper killstreaks::configure_team(hardpointtype, killstreak_id, owner, "helicopter", undefined, &configureteampost);
    if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
        chopper killstreak_hacking::enable_hacking("helicopter_comlink", undefined, &hackedcallbackpost);
    }
    chopper setenemymodel(choppermodelenemy);
    chopper thread watchforemp();
    function_38a2c2c2(chopper, 0);
    chopper thread function_6de97db8();
    if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
        chopper.defaultweapon = getweapon("cobra_20mm_comlink");
    } else {
        chopper.defaultweapon = getweapon("cobra_20mm");
    }
    chopper.requireddeathcount = owner.deathcount;
    chopper.chaff_offset = level.chaff_offset["attack"];
    minigun_snd_ent = spawn("script_origin", chopper gettagorigin("tag_flash"));
    minigun_snd_ent linkto(chopper, "tag_flash", (0, 0, 0), (0, 0, 0));
    chopper.minigun_snd_ent = minigun_snd_ent;
    minigun_snd_ent thread autostopsound();
    chopper thread heli_existance();
    level.chopper = chopper;
    chopper.reached_dest = 0;
    if (armored) {
        chopper.maxhealth = level.heli_amored_maxhealth;
    } else {
        chopper.maxhealth = level.heli_maxhealth;
    }
    chopper.rocketdamageoneshot = level.heli_maxhealth + 1;
    chopper.var_474dd144 = level.heli_maxhealth / 2 + 1;
    if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
        chopper.numflares = 1;
    } else if (hardpointtype == "helicopter_guard") {
        chopper.numflares = 1;
    } else {
        chopper.numflares = 2;
    }
    chopper.flareoffset = (0, 0, -256);
    chopper.waittime = level.heli_dest_wait;
    chopper.loopcount = 0;
    chopper.evasive = 0;
    chopper.health_bulletdamageble = level.heli_armor;
    chopper.health_evasive = level.heli_armor;
    chopper.targeting_delay = level.heli_targeting_delay;
    chopper.primarytarget = undefined;
    chopper.secondarytarget = undefined;
    chopper.attacker = undefined;
    chopper.missile_ammo = level.heli_missile_max;
    chopper.currentstate = "ok";
    chopper.lastrocketfiretime = -1;
    if (isdefined(protectlocation)) {
        chopper thread heli_protect(startnode, protectlocation, hardpointtype, heli_team);
        chopper clientfield::set("heli_comlink_bootup_anim", 1);
    } else {
        chopper thread heli_fly(startnode, 2, hardpointtype);
    }
    chopper thread heli_damage_monitor(hardpointtype);
    chopper thread wait_for_killed();
    chopper thread heli_health(hardpointtype);
    chopper thread attack_targets(missilesenabled, hardpointtype);
    chopper thread heli_targeting(missilesenabled, hardpointtype);
    chopper thread heli_missile_regen();
    if (hardpointtype != "helicopter_comlink") {
        chopper thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", "death");
        chopper thread create_flare_ent((0, 0, -100));
    }
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x7cd5f0, Offset: 0x3608
// Size: 0x22
function autostopsound() {
    self endon(#"death");
    level waittill(#"game_ended");
    self stoploopsound();
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0xd4ca952, Offset: 0x3638
// Size: 0x1a
function heli_existance() {
    self waittill(#"leaving");
    self spawning::remove_influencers();
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xc044a23a, Offset: 0x3660
// Size: 0x82
function create_flare_ent(offset) {
    self.flare_ent = spawn("script_model", self gettagorigin("tag_origin"));
    self.flare_ent setmodel("tag_origin");
    self.flare_ent linkto(self, "tag_origin", offset);
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x9aa2bf0b, Offset: 0x36f0
// Size: 0xe9
function heli_missile_regen() {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    for (;;) {
        airsupport::debug_print3d("Missile Ammo: " + self.missile_ammo, (0.5, 0.5, 1), self, (0, 0, -100), 0);
        if (self.missile_ammo >= level.heli_missile_max) {
            self waittill(#"hash_b0c5ea03");
        } else if (self.currentstate == "heavy smoke") {
            wait level.heli_missile_regen_time / 4;
        } else if (self.currentstate == "light smoke") {
            wait level.heli_missile_regen_time / 2;
        } else {
            wait level.heli_missile_regen_time;
        }
        if (self.missile_ammo < level.heli_missile_max) {
            self.missile_ammo++;
        }
    }
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0x8525f8c, Offset: 0x37e8
// Size: 0x4dd
function heli_targeting(missilesenabled, hardpointtype) {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    for (;;) {
        targets = [];
        targetsmissile = [];
        players = level.players;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (self cantargetplayer_turret(player, hardpointtype)) {
                if (isdefined(player)) {
                    targets[targets.size] = player;
                }
            }
            if (missilesenabled && self cantargetplayer_missile(player, hardpointtype)) {
                if (isdefined(player)) {
                    targetsmissile[targetsmissile.size] = player;
                }
                continue;
            }
        }
        dogs = dogs::function_b944b696();
        foreach (dog in dogs) {
            if (self cantargetdog_turret(dog)) {
                targets[targets.size] = dog;
            }
            if (missilesenabled && self cantargetdog_missile(dog)) {
                targetsmissile[targetsmissile.size] = dog;
            }
        }
        tanks = getentarray("talon", "targetname");
        foreach (tank in tanks) {
            if (self cantargettank_turret(tank)) {
                targets[targets.size] = tank;
            }
        }
        actors = getactorarray();
        foreach (actor in actors) {
            if (isdefined(actor) && isdefined(actor.isaiclone) && isalive(actor)) {
                if (self cantargetactor_turret(actor, hardpointtype)) {
                    targets[targets.size] = actor;
                }
            }
        }
        if (targets.size == 0 && targetsmissile.size == 0) {
            self.primarytarget = undefined;
            self.secondarytarget = undefined;
            debug_print_target();
            self setgoalyaw(randomint(360));
            wait self.targeting_delay;
            continue;
        }
        if (targets.size == 1) {
            if (isdefined(targets[0].isaiclone)) {
                killstreaks::update_actor_threat(targets[0]);
            } else if (targets[0].type == "dog" || isdefined(targets[0].type) && targets[0].type == "tank_drone") {
                killstreaks::update_dog_threat(targets[0]);
            } else {
                killstreaks::update_player_threat(targets[0]);
            }
            self.primarytarget = targets[0];
            self notify(#"hash_907788c7");
            self.secondarytarget = undefined;
            debug_print_target();
        } else if (targets.size > 1) {
            assignprimarytargets(targets);
        }
        if (targetsmissile.size == 1) {
            if (!isdefined(targetsmissile[0].type) || targetsmissile[0].type != "dog" || targets[0].type == "tank_drone") {
                self killstreaks::update_missile_player_threat(targetsmissile[0]);
            } else if (targetsmissile[0].type == "dog") {
                self killstreaks::update_missile_dog_threat(targetsmissile[0]);
            }
            self.secondarytarget = targetsmissile[0];
            self notify(#"hash_519af70b");
            debug_print_target();
        } else if (targetsmissile.size > 1) {
            assignsecondarytargets(targetsmissile);
        }
        wait self.targeting_delay;
        debug_print_target();
    }
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0x135566cd, Offset: 0x3cd0
// Size: 0x1a5
function cantargetplayer_turret(player, hardpointtype) {
    cantarget = 1;
    if (!isalive(player) || player.sessionstate != "playing") {
        return 0;
    }
    if (player == self.owner) {
        self check_owner(hardpointtype);
        return 0;
    }
    if (player airsupport::cantargetplayerwithspecialty() == 0) {
        return 0;
    }
    if (distance(player.origin, self.origin) > level.heli_visual_range) {
        return 0;
    }
    if (!isdefined(player.team)) {
        return 0;
    }
    if (level.teambased && player.team == self.team) {
        return 0;
    }
    if (player.team == "spectator") {
        return 0;
    }
    if (isdefined(player.spawntime) && (gettime() - player.spawntime) / 1000 <= level.heli_target_spawnprotection) {
        return 0;
    }
    heli_centroid = self.origin + (0, 0, -160);
    heli_forward_norm = anglestoforward(self.angles);
    heli_turret_point = heli_centroid + -112 * heli_forward_norm;
    visible_amount = player sightconetrace(heli_turret_point, self);
    if (visible_amount < level.heli_target_recognition) {
        return 0;
    }
    return cantarget;
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0x3c595a78, Offset: 0x3e80
// Size: 0x12d
function cantargetactor_turret(actor, hardpointtype) {
    helicopter = self;
    cantarget = 1;
    if (!isalive(actor)) {
        return actor;
    }
    if (!isdefined(actor.team)) {
        return 0;
    }
    if (level.teambased && actor.team == helicopter.team) {
        return 0;
    }
    if (distancesquared(actor.origin, helicopter.origin) > level.heli_visual_range * level.heli_visual_range) {
        return 0;
    }
    heli_centroid = helicopter.origin + (0, 0, -160);
    heli_forward_norm = anglestoforward(helicopter.angles);
    heli_turret_point = heli_centroid + -112 * heli_forward_norm;
    visible_amount = actor sightconetrace(heli_turret_point, helicopter);
    if (visible_amount < level.heli_target_recognition) {
        return 0;
    }
    return cantarget;
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0x879ccef2, Offset: 0x3fb8
// Size: 0x9e
function getverticaltan(startorigin, endorigin) {
    vector = endorigin - startorigin;
    opposite = startorigin[2] - endorigin[2];
    if (opposite < 0) {
        opposite *= 1;
    }
    adjacent = distance2d(startorigin, endorigin);
    if (adjacent < 0) {
        adjacent *= 1;
    }
    if (adjacent < 0.01) {
        adjacent = 0.01;
    }
    tangent = opposite / adjacent;
    return tangent;
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0xcc8aa56d, Offset: 0x4060
// Size: 0x1ef
function cantargetplayer_missile(player, hardpointtype) {
    cantarget = 1;
    if (!isalive(player) || player.sessionstate != "playing") {
        return 0;
    }
    if (player == self.owner) {
        self check_owner(hardpointtype);
        return 0;
    }
    if (player airsupport::cantargetplayerwithspecialty() == 0) {
        return 0;
    }
    if (distance(player.origin, self.origin) > level.heli_missile_range) {
        return 0;
    }
    if (!isdefined(player.team)) {
        return 0;
    }
    if (level.teambased && player.team == self.team) {
        return 0;
    }
    if (player.team == "spectator") {
        return 0;
    }
    if (isdefined(player.spawntime) && (gettime() - player.spawntime) / 1000 <= level.heli_target_spawnprotection) {
        return 0;
    }
    if (self target_cone_check(player, level.heli_missile_target_cone) == 0) {
        return 0;
    }
    heli_centroid = self.origin + (0, 0, -160);
    heli_forward_norm = anglestoforward(self.angles);
    heli_turret_point = heli_centroid + -112 * heli_forward_norm;
    if (!isdefined(player.lasthit)) {
        player.lasthit = 0;
    }
    player.lasthit = self heliturretsighttrace(heli_turret_point, player, player.lasthit);
    if (player.lasthit != 0) {
        return 0;
    }
    return cantarget;
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xdb6fb9d3, Offset: 0x4258
// Size: 0x147
function cantargetdog_turret(dog) {
    cantarget = 1;
    if (!isdefined(dog)) {
        return 0;
    }
    if (distance(dog.origin, self.origin) > level.heli_visual_range) {
        return 0;
    }
    if (!isdefined(dog.team)) {
        return 0;
    }
    if (level.teambased && dog.team == self.team) {
        return 0;
    }
    if (isdefined(dog.script_owner) && self.owner == dog.script_owner) {
        return 0;
    }
    heli_centroid = self.origin + (0, 0, -160);
    heli_forward_norm = anglestoforward(self.angles);
    heli_turret_point = heli_centroid + -112 * heli_forward_norm;
    if (!isdefined(dog.lasthit)) {
        dog.lasthit = 0;
    }
    dog.lasthit = self heliturretdogtrace(heli_turret_point, dog, dog.lasthit);
    if (dog.lasthit != 0) {
        return 0;
    }
    return cantarget;
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x99b1013b, Offset: 0x43a8
// Size: 0x147
function cantargetdog_missile(dog) {
    cantarget = 1;
    if (!isdefined(dog)) {
        return 0;
    }
    if (distance(dog.origin, self.origin) > level.heli_missile_range) {
        return 0;
    }
    if (!isdefined(dog.team)) {
        return 0;
    }
    if (level.teambased && dog.team == self.team) {
        return 0;
    }
    if (isdefined(dog.script_owner) && self.owner == dog.script_owner) {
        return 0;
    }
    heli_centroid = self.origin + (0, 0, -160);
    heli_forward_norm = anglestoforward(self.angles);
    heli_turret_point = heli_centroid + -112 * heli_forward_norm;
    if (!isdefined(dog.lasthit)) {
        dog.lasthit = 0;
    }
    dog.lasthit = self heliturretdogtrace(heli_turret_point, dog, dog.lasthit);
    if (dog.lasthit != 0) {
        return 0;
    }
    return cantarget;
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xae497a80, Offset: 0x44f8
// Size: 0x9d
function cantargettank_turret(tank) {
    cantarget = 1;
    if (!isdefined(tank)) {
        return 0;
    }
    if (distance(tank.origin, self.origin) > level.heli_visual_range) {
        return 0;
    }
    if (!isdefined(tank.team)) {
        return 0;
    }
    if (level.teambased && tank.team == self.team) {
        return 0;
    }
    if (isdefined(tank.owner) && self.owner == tank.owner) {
        return 0;
    }
    return cantarget;
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x513f977e, Offset: 0x45a0
// Size: 0x1ab
function assignprimarytargets(targets) {
    for (idx = 0; idx < targets.size; idx++) {
        if (isdefined(targets[idx].isaiclone)) {
            killstreaks::update_actor_threat(targets[idx]);
            continue;
        }
        if (isdefined(targets[idx].type) && targets[idx].type == "dog") {
            killstreaks::update_dog_threat(targets[idx]);
            continue;
        }
        if (isplayer(targets[idx])) {
            killstreaks::update_player_threat(targets[idx]);
            continue;
        }
        killstreaks::update_non_player_threat(targets[idx]);
    }
    assert(targets.size >= 2, "<dev string:x154>");
    highest = 0;
    second_highest = 0;
    primarytarget = undefined;
    for (idx = 0; idx < targets.size; idx++) {
        assert(isdefined(targets[idx].threatlevel), "<dev string:x187>");
        if (targets[idx].threatlevel >= highest) {
            highest = targets[idx].threatlevel;
            primarytarget = targets[idx];
        }
    }
    assert(isdefined(primarytarget), "<dev string:x1b0>");
    self.primarytarget = primarytarget;
    self notify(#"hash_907788c7");
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xbf04de1, Offset: 0x4758
// Size: 0x193
function assignsecondarytargets(targets) {
    for (idx = 0; idx < targets.size; idx++) {
        if (!isdefined(targets[idx].type) || targets[idx].type != "dog") {
            self killstreaks::update_missile_player_threat(targets[idx]);
            continue;
        }
        if (targets[idx].type == "dog" || targets[0].type == "tank_drone") {
            killstreaks::update_missile_dog_threat(targets[idx]);
        }
    }
    assert(targets.size >= 2, "<dev string:x154>");
    highest = 0;
    second_highest = 0;
    primarytarget = undefined;
    secondarytarget = undefined;
    for (idx = 0; idx < targets.size; idx++) {
        assert(isdefined(targets[idx].missilethreatlevel), "<dev string:x187>");
        if (targets[idx].missilethreatlevel >= highest) {
            highest = targets[idx].missilethreatlevel;
            secondarytarget = targets[idx];
        }
    }
    assert(isdefined(secondarytarget), "<dev string:x1e0>");
    self.secondarytarget = secondarytarget;
    self notify(#"hash_519af70b");
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x87ad7bb4, Offset: 0x48f8
// Size: 0x9a
function heli_reset() {
    self cleartargetyaw();
    self cleargoalyaw();
    self setspeed(60, 25);
    self setyawspeed(75, 45, 45);
    self setmaxpitchroll(30, 30);
    self setneargoalnotifydist(256);
    self setturningability(0.9);
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xf0a515f9, Offset: 0x49a0
// Size: 0x4b
function heli_wait(waittime) {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"evasive");
    self thread heli_hover();
    wait waittime;
    heli_reset();
    self notify(#"hash_38f853e7");
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0xe8845697, Offset: 0x49f8
// Size: 0x62
function heli_hover() {
    self endon(#"death");
    self endon(#"hash_38f853e7");
    self endon(#"evasive");
    self endon(#"leaving");
    self endon(#"crashing");
    randint = randomint(360);
    self setgoalyaw(self.angles[1] + randint);
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x8cbffbb3, Offset: 0x4a68
// Size: 0x9d
function wait_for_killed() {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    self.bda = 0;
    while (true) {
        self waittill(#"killed", victim);
        if (!isdefined(self.owner) || !isdefined(victim)) {
            continue;
        }
        if (self.owner == victim) {
            continue;
        }
        if (level.teambased && self.owner.team == victim.team) {
            continue;
        }
        self thread wait_for_bda_timeout();
    }
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x4fb51af3, Offset: 0x4b10
// Size: 0x22
function wait_for_bda_timeout() {
    self endon(#"killed");
    wait 2.5;
    self play_bda_dialog();
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x665d3d4f, Offset: 0x4b40
// Size: 0x9e
function play_bda_dialog() {
    if (self.bda == 1) {
        bdadialog = "kill1";
    } else if (self.bda == 2) {
        bdadialog = "kill2";
    } else if (self.bda == 3) {
        bdadialog = "kill3";
    } else if (self.bda > 3) {
        bdadialog = "killMultiple";
    }
    self killstreaks::play_pilot_dialog_on_owner(bdadialog, self.killstreaktype, self.killstreak_id);
    self notify(#"bda_dialog", bdadialog);
    self.bda = 0;
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x568473b1, Offset: 0x4be8
// Size: 0x66
function heli_hacked_health_update(hacker) {
    helicopter = self;
    hackeddamagetaken = helicopter.maxhealth - helicopter.hackedhealth;
    assert(hackeddamagetaken > 0);
    if (hackeddamagetaken > helicopter.damagetaken) {
        helicopter.damagetaken = hackeddamagetaken;
    }
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x7d10c51f, Offset: 0x4c58
// Size: 0x8e5
function heli_damage_monitor(hardpointtype) {
    helicopter = self;
    self endon(#"death");
    self endon(#"crashing");
    self.damagetaken = 0;
    last_hit_vo = 0;
    hit_vo_spacing = 6000;
    tablehealth = killstreak_bundles::get_max_health(hardpointtype);
    if (isdefined(tablehealth)) {
        self.maxhealth = tablehealth;
    }
    helicopter.hackedhealthupdatecallback = &heli_hacked_health_update;
    helicopter.hackedhealth = killstreak_bundles::get_hacked_health(hardpointtype);
    if (!isdefined(self.attackerdata)) {
        self.attackers = [];
        self.attackerdata = [];
        self.attackerdamage = [];
        self.flareattackerdamage = [];
    }
    for (;;) {
        self waittill(#"damage", damage, attacker, direction, point, type, modelname, tagname, partname, weapon, flags, inflictor, chargelevel);
        if (!isdefined(attacker) || !isplayer(attacker)) {
            continue;
        }
        heli_friendlyfire = weaponobjects::friendlyfirecheck(self.owner, attacker);
        if (!heli_friendlyfire) {
            continue;
        }
        if (!level.hardcoremode) {
            if (isdefined(self.owner) && attacker == self.owner) {
                continue;
            }
            if (level.teambased) {
                isvalidattacker = isdefined(attacker.team) && attacker.team != self.team;
            } else {
                isvalidattacker = 1;
            }
            if (!isvalidattacker) {
                continue;
            }
        }
        self.attacker = attacker;
        weapon_damage = killstreak_bundles::get_weapon_damage(hardpointtype, self.maxhealth, attacker, weapon, type, damage, flags, chargelevel);
        if (!isdefined(weapon_damage)) {
            if (type == "MOD_RIFLE_BULLET" || type == "MOD_PISTOL_BULLET") {
                hasfmj = attacker hasperk("specialty_armorpiercing");
                if (hasfmj) {
                    damage += int(damage * level.cac_armorpiercing_data);
                }
                damage *= level.heli_armor_bulletdamage;
            } else if (type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_EXPLOSIVE") {
                switch (weapon.name) {
                case "tow_turret":
                    if (isdefined(self.var_474dd144)) {
                        damage = self.var_474dd144;
                    } else if (isdefined(self.rocketdamageoneshot)) {
                        damage = self.rocketdamageoneshot;
                    }
                    break;
                default:
                    if (isdefined(self.rocketdamageoneshot)) {
                        damage = self.rocketdamageoneshot;
                    }
                    break;
                }
            }
            weapon_damage = damage;
        }
        if (weapon_damage > 0) {
            self challenges::trackassists(attacker, weapon_damage, 0);
        }
        self.damagetaken = self.damagetaken + weapon_damage;
        playercontrolled = 0;
        if (self.damagetaken > self.maxhealth && !isdefined(self.xpgiven)) {
            self.xpgiven = 1;
            switch (hardpointtype) {
            case "helicopter_gunner":
                playercontrolled = 1;
                event = "destroyed_vtol_mothership";
                goto LOC_000004d4;
            case "helicopter_comlink":
            case "inventory_helicopter_comlink":
                event = "destroyed_helicopter_comlink";
                if (self.leaving !== 1) {
                    self killstreaks::play_destroyed_dialog_on_owner(self.killstreaktype, self.killstreak_id);
                }
                goto LOC_000004d4;
            case "supply_drop":
                if (isdefined(helicopter.killstreakweaponname)) {
                    switch (helicopter.killstreakweaponname) {
                    case "ai_tank_drop":
                    case "ai_tank_drop_marker":
                    case "ai_tank_marker":
                    case "inventory_ai_tank_drop":
                    case "inventory_ai_tank_marker":
                        event = "destroyed_helicopter_agr_drop";
                        break;
                    case "combat_robot_drop":
                    case "combat_robot_marker":
                    case "inventory_combat_robot_drop":
                    case "inventory_combat_robot_marker":
                        event = "destroyed_helicopter_giunit_drop";
                        break;
                    default:
                        event = "destroyed_helicopter_supply_drop";
                        break;
                    }
                LOC_000004d4:
                } else {
                    event = "destroyed_helicopter_supply_drop";
                }
                break;
            }
            if (isdefined(event)) {
                if (isdefined(self.owner) && self.owner util::isenemyplayer(attacker)) {
                    challenges::destroyedhelicopter(attacker, weapon, type);
                    challenges::destroyedaircraft(attacker, weapon);
                    scoreevents::processscoreevent(event, attacker, self.owner, weapon);
                    attacker challenges::addflyswatterstat(weapon, self);
                    if (playercontrolled == 1) {
                        attacker challenges::destroyedplayercontrolledaircraft();
                    }
                    if (hardpointtype == "helicopter_player_gunner") {
                        attacker addweaponstat(weapon, "destroyed_controlled_killstreak", 1);
                    }
                }
            }
            weaponstatname = "destroyed";
            switch (weapon.name) {
            case "auto_tow":
            case "tow_turret":
            case "tow_turret_drop":
                weaponstatname = "kills";
                break;
            }
            attacker addweaponstat(weapon, weaponstatname, 1);
            killstreakreference = undefined;
            switch (hardpointtype) {
            case "helicopter_gunner":
                killstreakreference = "killstreak_helicopter_gunner";
                break;
            case "helicopter_player_gunner":
                killstreakreference = "killstreak_helicopter_player_gunner";
                break;
            case "helicopter_player_firstperson":
                killstreakreference = "killstreak_helicopter_player_firstperson";
                break;
            case "helicopter":
            case "helicopter_comlink":
            case "helicopter_x2":
            case "inventory_helicopter_comlink":
                killstreakreference = "killstreak_helicopter_comlink";
                break;
            case "supply_drop":
                killstreakreference = "killstreak_supply_drop";
                break;
            case "helicopter_guard":
                killstreakreference = "killstreak_helicopter_guard";
                break;
            }
            if (isdefined(killstreakreference)) {
                level.globalkillstreaksdestroyed++;
                attacker addweaponstat(getweapon(hardpointtype), "destroyed", 1);
            }
            notifystring = %KILLSTREAK_DESTROYED_HELICOPTER;
            if (hardpointtype == "helicopter_player_gunner") {
                notifystring = %KILLSTREAK_DESTROYED_HELICOPTER_GUNNER;
                self.owner sendkillstreakdamageevent(600);
            }
            luinotifyevent(%player_callout, 2, notifystring, attacker.entnum);
            if (isdefined(self.attackers)) {
                for (j = 0; j < self.attackers.size; j++) {
                    player = self.attackers[j];
                    if (!isdefined(player)) {
                        continue;
                    }
                    if (player == attacker) {
                        continue;
                    }
                    flare_done = self.flareattackerdamage[player.clientid];
                    if (isdefined(flare_done) && flare_done == 1) {
                        scoreevents::processscoreevent("aircraft_flare_assist", player);
                        continue;
                    }
                    damage_done = self.attackerdamage[player.clientid];
                    player thread processcopterassist(self, damage_done);
                }
                self.attackers = [];
            }
            attacker notify(#"destroyed_helicopter");
            if (target_istarget(self)) {
                target_remove(self);
            }
        } else if (isdefined(self.owner) && isplayer(self.owner)) {
            if (last_hit_vo + hit_vo_spacing < gettime()) {
                if (type == "MOD_PROJECTILE" || randomintrange(0, 3) == 0) {
                    last_hit_vo = gettime();
                }
            }
        }
        if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
            self thread heli_active_camo_damage_update(damage);
        }
    }
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0xc4b5d97a, Offset: 0x5548
// Size: 0x7a
function init_active_camo() {
    heli = self;
    heli.active_camo_supported = 1;
    heli.active_camo_damage = 0;
    heli.active_camo_disabled = 0;
    heli.camo_state = 0;
    heli_set_active_camo_state(1);
    if (isdefined(heli.flak_drone)) {
        heli.flak_drone flak_drone::setcamostate(1);
    }
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x1c2ce59a, Offset: 0x55d0
// Size: 0x1ca
function heli_set_active_camo_state(state) {
    heli = self;
    if (!isdefined(heli.active_camo_supported)) {
        return;
    }
    if (state == 0) {
        heli clientfield::set("toggle_lights", 1);
        if (heli.camo_state == 1) {
            heli playsound("veh_hind_cloak_off");
        }
        heli.camo_state = 0;
        heli.camo_state_switch_time = gettime();
    } else if (state == 1) {
        if (heli.active_camo_disabled) {
            return;
        }
        heli clientfield::set("toggle_lights", 0);
        if (heli.camo_state == 0) {
            heli playsound("veh_hind_cloak_on");
        }
        heli.camo_state = 1;
        heli.camo_state_switch_time = gettime();
        if (isdefined(heli.owner)) {
            if (isdefined(heli.play_camo_dialog) && heli.play_camo_dialog) {
                heli killstreaks::play_pilot_dialog_on_owner("activateCounter", "helicopter_comlink", self.killstreak_id);
                heli.play_camo_dialog = 0;
            } else if (!isdefined(heli.play_camo_dialog)) {
                heli.play_camo_dialog = 1;
            }
        }
    } else if (state == 2) {
        heli clientfield::set("toggle_lights", 1);
    }
    if (isdefined(heli.flak_drone)) {
        heli.flak_drone flak_drone::setcamostate(state);
    }
    heli clientfield::set("active_camo", state);
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xf2193d76, Offset: 0x57a8
// Size: 0x9a
function heli_active_camo_damage_update(damage) {
    self endon(#"death");
    self endon(#"crashing");
    heli = self;
    heli.active_camo_damage += damage;
    if (heli.active_camo_damage > 100) {
        heli.active_camo_disabled = 1;
        heli thread heli_active_camo_damage_disable();
        return;
    }
    heli heli_set_active_camo_state(2);
    wait 1;
    heli heli_set_active_camo_state(1);
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x642fb287, Offset: 0x5850
// Size: 0x72
function heli_active_camo_damage_disable() {
    self endon(#"death");
    self endon(#"crashing");
    heli = self;
    heli notify(#"heli_active_camo_damage_disable");
    heli endon(#"heli_active_camo_damage_disable");
    heli heli_set_active_camo_state(0);
    wait 10;
    heli.active_camo_damage = 0;
    heli.active_camo_disabled = 0;
    heli heli_set_active_camo_state(1);
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0xf773975f, Offset: 0x58d0
// Size: 0x385
function heli_health(hardpointtype, playernotify) {
    self endon(#"death");
    self endon(#"crashing");
    self.currentstate = "ok";
    self.laststate = "ok";
    self setdamagestage(3);
    damagestate = 3;
    tablehealth = killstreak_bundles::get_max_health(hardpointtype);
    if (isdefined(tablehealth)) {
        self.maxhealth = tablehealth;
    }
    for (;;) {
        self waittill(#"damage", damage, attacker, direction, point, type, modelname, tagname, partname, weapon);
        wait 0.05;
        if (self.damagetaken > self.maxhealth) {
            damagestate = 0;
            self setdamagestage(damagestate);
            self heli_set_active_camo_state(0);
            self thread heli_crash(hardpointtype, self.owner, playernotify);
        } else if (self.damagetaken >= self.maxhealth * 0.66 && damagestate >= 2) {
            self killstreaks::play_pilot_dialog_on_owner("damaged", "helicopter_comlink", self.killstreak_id);
            if (isdefined(self.vehicletype) && self.vehicletype == "heli_player_gunner_mp") {
                playfxontag(level.chopper_fx["damage"]["heavy_smoke"], self, "tag_origin");
            } else {
                playfxontag(level.chopper_fx["damage"]["heavy_smoke"], self, "tag_main_rotor");
            }
            damagestate = 1;
            self.currentstate = "heavy smoke";
            self.evasive = 1;
            self notify(#"damage state");
        } else if (self.damagetaken >= self.maxhealth * 0.33 && damagestate == 3) {
            if (isdefined(self.vehicletype) && self.vehicletype == "heli_player_gunner_mp") {
                playfxontag(level.chopper_fx["damage"]["light_smoke"], self, "tag_origin");
            } else {
                playfxontag(level.chopper_fx["damage"]["light_smoke"], self, "tag_main_rotor");
            }
            damagestate = 2;
            self.currentstate = "light smoke";
            self notify(#"damage state");
        }
        if (self.damagetaken <= level.heli_armor) {
            airsupport::debug_print3d_simple("Armor: " + level.heli_armor - self.damagetaken, self, (0, 0, 100), 20);
            continue;
        }
        airsupport::debug_print3d_simple("Health: " + self.maxhealth - self.damagetaken, self, (0, 0, 100), 20);
    }
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x46f1835c, Offset: 0x5c60
// Size: 0x102
function heli_evasive(hardpointtype) {
    self notify(#"evasive");
    self.evasive = 1;
    loop_startnode = level.heli_loop_paths[0];
    var_dca2b26f = 1;
    if (hardpointtype == "helicopter_gunner") {
        var_dca2b26f = 0;
        for (i = 0; i < level.heli_loop_paths.size; i++) {
            if (isdefined(level.heli_loop_paths[i].isgunnerpath) && level.heli_loop_paths[i].isgunnerpath) {
                loop_startnode = level.heli_loop_paths[i];
                var_dca2b26f = 1;
                break;
            }
        }
    }
    assert(var_dca2b26f, "<dev string:x215>");
    startwait = 2;
    if (isdefined(self.donotstop) && self.donotstop) {
        startwait = 0;
    }
    self thread heli_fly(loop_startnode, startwait, hardpointtype);
}

// Namespace helicopter
// Params 3, eflags: 0x0
// Checksum 0xfd7c67bd, Offset: 0x5d70
// Size: 0x42
function notify_player(player, playernotify, delay) {
    if (!isdefined(player)) {
        return;
    }
    if (!isdefined(playernotify)) {
        return;
    }
    player endon(#"disconnect");
    player endon(playernotify);
    wait delay;
    player notify(playernotify);
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x709e0c9c, Offset: 0x5dc0
// Size: 0x26
function play_going_down_vo(delay) {
    self.owner endon(#"disconnect");
    self endon(#"death");
    wait delay;
}

// Namespace helicopter
// Params 3, eflags: 0x0
// Checksum 0xc89cefc5, Offset: 0x5df0
// Size: 0x39a
function heli_crash(hardpointtype, player, playernotify) {
    self endon(#"death");
    self notify(#"crashing");
    self spawning::remove_influencers();
    self stoploopsound(0);
    if (isdefined(self.minigun_snd_ent)) {
        self.minigun_snd_ent stoploopsound();
    }
    if (isdefined(self.alarm_snd_ent)) {
        self.alarm_snd_ent stoploopsound();
    }
    crashtypes = [];
    crashtypes[0] = "crashOnPath";
    crashtypes[1] = "spinOut";
    crashtype = crashtypes[randomint(2)];
    if (isdefined(self.crashtype)) {
        crashtype = self.crashtype;
    }
    /#
        if (level.heli_debug_crash) {
            switch (level.heli_debug_crash) {
            case 1:
                crashtype = "<dev string:x23f>";
                break;
            case 2:
                crashtype = "<dev string:x247>";
                break;
            case 3:
                crashtype = "<dev string:x253>";
                break;
            default:
                break;
            }
        }
    #/
    switch (crashtype) {
    case "explode":
        thread notify_player(player, playernotify, 0);
        self thread heli_explode();
        break;
    case "crashOnPath":
        if (isdefined(player)) {
            self thread play_going_down_vo(0.5);
        }
        thread notify_player(player, playernotify, 4);
        self clear_client_flags();
        self thread crashonnearestcrashpath(hardpointtype);
        break;
    case "spinOut":
        if (isdefined(player)) {
            self thread play_going_down_vo(0.5);
        }
        thread notify_player(player, playernotify, 4);
        self clear_client_flags();
        heli_reset();
        heli_speed = 30 + randomint(50);
        heli_accel = 10 + randomint(25);
        leavenode = getvalidrandomcrashnode(self.origin);
        self setspeed(heli_speed, heli_accel);
        self set_goal_pos(leavenode.origin, 0);
        rateofspin = 45 + randomint(90);
        thread heli_secondary_explosions();
        self thread heli_spin(rateofspin);
        self util::waittill_any_timeout(randomintrange(4, 6), "near_goal");
        if (isdefined(player) && isdefined(playernotify)) {
            player notify(playernotify);
        }
        self thread heli_explode();
        break;
    }
    self thread explodeoncontact(hardpointtype);
    time = randomintrange(4, 6);
    self thread waitthenexplode(time);
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0xb54a17c2, Offset: 0x6198
// Size: 0x22
function damagedrotorfx() {
    self endon(#"death");
    self setrotorspeed(0.6);
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x1e1a4489, Offset: 0x61c8
// Size: 0x2a
function waitthenexplode(time) {
    self endon(#"death");
    wait time;
    self thread heli_explode();
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x84819b67, Offset: 0x6200
// Size: 0x16a
function crashonnearestcrashpath(hardpointtype) {
    crashpathdistance = -1;
    crashpath = level.heli_crash_paths[0];
    for (i = 0; i < level.heli_crash_paths.size; i++) {
        currentdistance = distance(self.origin, level.heli_crash_paths[i].origin);
        if (crashpathdistance == -1 || crashpathdistance > currentdistance) {
            crashpathdistance = currentdistance;
            crashpath = level.heli_crash_paths[i];
        }
    }
    heli_speed = 30 + randomint(50);
    heli_accel = 10 + randomint(25);
    self setspeed(heli_speed, heli_accel);
    thread heli_secondary_explosions();
    self thread heli_fly(crashpath, 0, hardpointtype);
    rateofspin = 45 + randomint(90);
    self thread heli_spin(rateofspin);
    self waittill(#"path start");
    self waittill(#"hash_9b1f1e2d");
    self thread heli_explode();
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xa1562e6c, Offset: 0x6378
// Size: 0x77
function checkhelicoptertag(tagname) {
    if (isdefined(self.model)) {
        if (self.model == "veh_t7_drone_hunter") {
            switch (tagname) {
            case "tag_engine_left":
                return "tag_fx_exhaust2";
            case "tag_engine_right":
                return "tag_fx_exhaust1";
            case "tail_rotor_jnt":
                return "tag_fx_tail";
            default:
                break;
            }
        }
    }
    return tagname;
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x2a6d5ba9, Offset: 0x63f8
// Size: 0x1ea
function heli_secondary_explosions() {
    self endon(#"death");
    playfxontag(level.chopper_fx["explode"]["large"], self, self checkhelicoptertag("tag_engine_left"));
    self playsound(level.heli_sound["hit"]);
    if (isdefined(self.vehicletype) && self.vehicletype == "heli_player_gunner_mp") {
        self thread trail_fx(level.chopper_fx["smoke"]["trail"], self checkhelicoptertag("tag_engine_right"), "stop tail smoke");
    } else {
        self thread trail_fx(level.chopper_fx["smoke"]["trail"], self checkhelicoptertag("tail_rotor_jnt"), "stop tail smoke");
    }
    self setdamagestage(0);
    self thread trail_fx(level.chopper_fx["fire"]["trail"]["large"], self checkhelicoptertag("tag_engine_left"), "stop body fire");
    wait 3;
    if (!isdefined(self)) {
        return;
    }
    playfxontag(level.chopper_fx["explode"]["large"], self, self checkhelicoptertag("tag_engine_left"));
    self playsound(level.heli_sound["hitsecondary"]);
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x41c84400, Offset: 0x65f0
// Size: 0x71
function heli_spin(speed) {
    self endon(#"death");
    self thread spinsoundshortly();
    self setyawspeed(speed, speed / 3, speed / 3);
    while (isdefined(self)) {
        self settargetyaw(self.angles[1] + speed * 0.9);
        wait 1;
    }
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0xd76d6dc9, Offset: 0x6670
// Size: 0x72
function spinsoundshortly() {
    self endon(#"death");
    wait 0.25;
    self stoploopsound();
    wait 0.05;
    self playloopsound(level.heli_sound["spinloop"]);
    wait 0.05;
    self playsound(level.heli_sound["spinstart"]);
}

// Namespace helicopter
// Params 3, eflags: 0x0
// Checksum 0xf77473e4, Offset: 0x66f0
// Size: 0x32
function trail_fx(trail_fx, trail_tag, stop_notify) {
    playfxontag(trail_fx, self, trail_tag);
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0xb9b04feb, Offset: 0x6730
// Size: 0x12a
function destroyhelicopter() {
    team = self.originalteam;
    if (target_istarget(self)) {
        target_remove(self);
    }
    self spawning::remove_influencers();
    if (isdefined(self.interior_model)) {
        self.interior_model delete();
        self.interior_model = undefined;
    }
    if (isdefined(self.minigun_snd_ent)) {
        self.minigun_snd_ent stoploopsound();
        self.minigun_snd_ent delete();
        self.minigun_snd_ent = undefined;
    }
    if (isdefined(self.alarm_snd_ent)) {
        self.alarm_snd_ent delete();
        self.alarm_snd_ent = undefined;
    }
    if (isdefined(self.flare_ent)) {
        self.flare_ent delete();
        self.flare_ent = undefined;
    }
    killstreakrules::killstreakstop(self.hardpointtype, team, self.killstreak_id);
    self delete();
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0xc95b26, Offset: 0x6868
// Size: 0x14c
function heli_explode() {
    self endon(#"death");
    forward = self.origin + (0, 0, 100) - self.origin;
    if (isdefined(self.helitype) && self.helitype == "littlebird") {
        playfx(level.chopper_fx["explode"]["guard"], self.origin, forward);
    } else if (isdefined(self.vehicletype) && self.vehicletype == "heli_player_gunner_mp") {
        playfx(level.chopper_fx["explode"]["gunner"], self.origin, forward);
    } else {
        playfx(level.chopper_fx["explode"]["death"], self.origin, forward);
    }
    self playsound(level.heli_sound["crash"]);
    wait 0.1;
    assert(isdefined(self.destroyfunc));
    self [[ self.destroyfunc ]]();
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x58974ac9, Offset: 0x69c0
// Size: 0x4a
function clear_client_flags() {
    self clientfield::set("heli_warn_fired", 0);
    self clientfield::set("heli_warn_targeted", 0);
    self clientfield::set("heli_warn_locked", 0);
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x97bdd04b, Offset: 0x6a18
// Size: 0x204
function heli_leave() {
    self notify(#"hash_df1f87c9");
    self notify(#"leaving");
    hardpointtype = self.hardpointtype;
    self.leaving = 1;
    if (!(isdefined(self.var_7f031ea3) && self.var_7f031ea3)) {
        self killstreaks::play_pilot_dialog_on_owner("timeout", hardpointtype);
        self killstreaks::play_taacom_dialog_response_on_owner("timeoutConfirmed", hardpointtype);
    }
    leavenode = getvalidrandomleavenode(self.origin);
    heli_reset();
    self clearlookatent();
    exitangles = vectortoangles(leavenode.origin - self.origin);
    self setgoalyaw(exitangles[1]);
    wait 1.5;
    if (!isdefined(self)) {
        return;
    }
    self setspeed(-76, 65);
    self set_goal_pos(self.origin + (leavenode.origin - self.origin) / 2 + (0, 0, 1000), 0);
    self waittill(#"near_goal");
    if (isdefined(self)) {
        self set_goal_pos(leavenode.origin, 1);
        self waittillmatch(#"goal");
        if (isdefined(self)) {
            self stoploopsound(1);
            self util::death_notify_wrapper();
            if (isdefined(self.alarm_snd_ent)) {
                self.alarm_snd_ent stoploopsound();
                self.alarm_snd_ent delete();
                self.alarm_snd_ent = undefined;
            }
            assert(isdefined(self.destroyfunc));
            self [[ self.destroyfunc ]]();
        }
    }
}

// Namespace helicopter
// Params 3, eflags: 0x0
// Checksum 0x8132c7c, Offset: 0x6c28
// Size: 0x3da
function heli_fly(currentnode, startwait, hardpointtype) {
    self endon(#"death");
    self endon(#"leaving");
    self notify(#"flying");
    self endon(#"flying");
    self endon(#"abandoned");
    self.reached_dest = 0;
    heli_reset();
    pos = self.origin;
    wait startwait;
    while (isdefined(currentnode.target)) {
        nextnode = getent(currentnode.target, "targetname");
        assert(isdefined(nextnode), "<dev string:x25b>");
        pos = nextnode.origin + (0, 0, 30);
        if (isdefined(currentnode.script_airspeed) && isdefined(currentnode.script_accel)) {
            heli_speed = currentnode.script_airspeed;
            heli_accel = currentnode.script_accel;
        } else {
            heli_speed = 30 + randomint(20);
            heli_accel = 10 + randomint(5);
        }
        if (isdefined(self.pathspeedscale)) {
            heli_speed *= self.pathspeedscale;
            heli_accel *= self.pathspeedscale;
        }
        if (!isdefined(nextnode.target)) {
            stop = 1;
        } else {
            stop = 0;
        }
        airsupport::debug_line(currentnode.origin, nextnode.origin, (1, 0.5, 0.5), -56);
        if (self.currentstate == "heavy smoke" || self.currentstate == "light smoke") {
            self setspeed(heli_speed, heli_accel);
            self set_goal_pos(pos, stop);
            self waittill(#"near_goal");
            self notify(#"path start");
        } else {
            if (isdefined(nextnode.script_delay) && !isdefined(self.donotstop)) {
                stop = 1;
            }
            self setspeed(heli_speed, heli_accel);
            self set_goal_pos(pos, stop);
            if (!isdefined(nextnode.script_delay) || isdefined(self.donotstop)) {
                self waittill(#"near_goal");
                self notify(#"path start");
            } else {
                self setgoalyaw(nextnode.angles[1]);
                self waittillmatch(#"goal");
                heli_wait(nextnode.script_delay);
            }
        }
        for (index = 0; index < level.heli_loop_paths.size; index++) {
            if (level.heli_loop_paths[index].origin == nextnode.origin) {
                self.loopcount++;
            }
        }
        if (self.loopcount >= level.heli_loopmax) {
            self thread heli_leave();
            return;
        }
        currentnode = nextnode;
    }
    self setgoalyaw(currentnode.angles[1]);
    self.reached_dest = 1;
    self notify(#"hash_9b1f1e2d");
    if (isdefined(self.waittime) && self.waittime > 0) {
        heli_wait(self.waittime);
    }
    if (isdefined(self)) {
        self thread heli_evasive(hardpointtype);
    }
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0x8991807d, Offset: 0x7010
// Size: 0xce
function heli_random_point_in_radius(protectdest, nodeheight) {
    min_distance = int(level.heli_protect_radius * 0.2);
    direction = randomintrange(0, 360);
    distance = randomintrange(min_distance, level.heli_protect_radius);
    x = cos(direction);
    y = sin(direction);
    x *= distance;
    y *= distance;
    return (protectdest[0] + x, protectdest[1] + y, nodeheight);
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0x5b081a8c, Offset: 0x70e8
// Size: 0xb8
function heli_get_protect_spot(protectdest, nodeheight) {
    protect_spot = heli_random_point_in_radius(protectdest, nodeheight);
    tries = 10;
    for (noflyzone = airsupport::crossesnoflyzone(protectdest, protect_spot); tries != 0 && isdefined(noflyzone); noflyzone = airsupport::crossesnoflyzone(protectdest, protect_spot)) {
        protect_spot = heli_random_point_in_radius(protectdest, nodeheight);
        tries--;
    }
    noflyzoneheight = airsupport::getnoflyzoneheightcrossed(protectdest, protect_spot, nodeheight);
    return (protect_spot[0], protect_spot[1], noflyzoneheight);
}

// Namespace helicopter
// Params 3, eflags: 0x0
// Checksum 0x382d19ea, Offset: 0x71a8
// Size: 0x27
function function_55098db7(time, msg1, msg2) {
    self endon(msg1);
    self endon(msg2);
    wait time;
    return true;
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x8830e5e3, Offset: 0x71d8
// Size: 0x82
function set_heli_speed_normal() {
    self setmaxpitchroll(30, 30);
    heli_speed = 30 + randomint(20);
    heli_accel = 10 + randomint(5);
    self setspeed(heli_speed, heli_accel);
    self setyawspeed(75, 45, 45);
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x755c240b, Offset: 0x7268
// Size: 0x82
function set_heli_speed_evasive() {
    self setmaxpitchroll(30, 90);
    heli_speed = 50 + randomint(20);
    heli_accel = 30 + randomint(5);
    self setspeed(heli_speed, heli_accel);
    self setyawspeed(100, 75, 75);
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x29cb8858, Offset: 0x72f8
// Size: 0x42
function set_heli_speed_hover() {
    self setmaxpitchroll(0, 90);
    self setspeed(20, 10);
    self setyawspeed(55, 25, 25);
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x7e1ead48, Offset: 0x7348
// Size: 0x35
function is_targeted() {
    if (isdefined(self.locking_on) && self.locking_on) {
        return true;
    }
    if (isdefined(self.locked_on) && self.locked_on) {
        return true;
    }
    return false;
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x25043be0, Offset: 0x7388
// Size: 0xca
function heli_mobilespawn(protectdest) {
    self endon(#"death");
    self notify(#"flying");
    self endon(#"flying");
    self endon(#"abandoned");
    iprintlnbold("PROTECT ORIGIN: (" + protectdest[0] + "," + protectdest[1] + "," + protectdest[2] + ")\n");
    heli_reset();
    self sethoverparams(50, 100, 50);
    wait 2;
    set_heli_speed_normal();
    self set_goal_pos(protectdest, 1);
    self waittill(#"near_goal");
    set_heli_speed_hover();
}

// Namespace helicopter
// Params 4, eflags: 0x0
// Checksum 0xdd1c643e, Offset: 0x7460
// Size: 0x382
function heli_protect(startnode, protectdest, hardpointtype, heli_team) {
    self endon(#"death");
    self notify(#"flying");
    self endon(#"flying");
    self endon(#"abandoned");
    self.reached_dest = 0;
    heli_reset();
    self sethoverparams(50, 100, 50);
    wait 2;
    currentdest = protectdest;
    nodeheight = protectdest[2];
    nextnode = startnode;
    heightoffset = 0;
    if (heli_team == "axis") {
        heightoffset = 400;
    }
    protectdest = (protectdest[0], protectdest[1], nodeheight);
    noflyzoneheight = airsupport::getnoflyzoneheight(protectdest);
    protectdest = (protectdest[0], protectdest[1], noflyzoneheight + heightoffset);
    currentdest = protectdest;
    starttime = gettime();
    self.endtime = starttime + level.heli_protect_time * 1000;
    self.killstreakendtime = int(self.endtime);
    self setspeed(-106, 80);
    self set_goal_pos(self.origin + (currentdest - self.origin) / 3 + (0, 0, 1000), 0);
    self waittill(#"near_goal");
    heli_speed = 30 + randomint(20);
    heli_accel = 10 + randomint(5);
    self thread updatetargetyaw();
    mapenter = 1;
    while (gettime() < self.endtime) {
        stop = 1;
        if (!mapenter) {
            self updatespeed();
        } else {
            mapenter = 0;
        }
        self set_goal_pos(currentdest, stop);
        self thread updatespeedonlock();
        self util::waittill_any("near_goal", "locking on");
        hostmigration::waittillhostmigrationdone();
        self notify(#"path start");
        if (!self is_targeted()) {
            waittillframeend();
            time = level.heli_protect_pos_time;
            if (self.evasive == 1) {
                time = 2;
            }
            set_heli_speed_hover();
            function_55098db7(time, "locking on", "damage state");
        } else {
            wait 2;
        }
        prevdest = currentdest;
        currentdest = heli_get_protect_spot(protectdest, nodeheight);
        noflyzoneheight = airsupport::getnoflyzoneheight(currentdest);
        currentdest = (currentdest[0], currentdest[1], noflyzoneheight + heightoffset);
        noflyzones = airsupport::crossesnoflyzones(prevdest, currentdest);
        if (isdefined(noflyzones) && noflyzones.size > 0) {
            currentdest = prevdest;
        }
    }
    self heli_set_active_camo_state(1);
    self thread heli_leave();
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x6bab0c09, Offset: 0x77f0
// Size: 0x4a
function updatespeedonlock() {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    self util::waittill_any("near_goal", "locking on");
    self updatespeed();
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x98fe38c5, Offset: 0x7848
// Size: 0x4a
function updatespeed() {
    if (isdefined(self.evasive) && (self is_targeted() || self.evasive)) {
        set_heli_speed_evasive();
        return;
    }
    set_heli_speed_normal();
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x259ea334, Offset: 0x78a0
// Size: 0x81
function updatetargetyaw() {
    self notify(#"endtargetyawupdate");
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    self endon(#"endtargetyawupdate");
    for (;;) {
        if (isdefined(self.primarytarget)) {
            yaw = math::get_2d_yaw(self.origin, self.primarytarget.origin);
            self settargetyaw(yaw);
        }
        wait 1;
    }
}

// Namespace helicopter
// Params 3, eflags: 0x0
// Checksum 0x8bbc2304, Offset: 0x7930
// Size: 0x19b
function fire_missile(smissiletype, ishots, etarget) {
    if (!isdefined(ishots)) {
        ishots = 1;
    }
    assert(self.health > 0);
    weapon = undefined;
    weaponshoottime = undefined;
    tags = [];
    switch (smissiletype) {
    case "ffar":
        weapon = getweapon("hind_FFAR");
        tags[0] = "tag_store_r_2";
        break;
    default:
        assertmsg("<dev string:x28e>");
        break;
    }
    assert(isdefined(weapon));
    assert(tags.size > 0);
    weaponshoottime = weapon.firetime;
    assert(isdefined(weaponshoottime));
    self setvehweapon(weapon);
    nextmissiletag = -1;
    for (i = 0; i < ishots; i++) {
        nextmissiletag++;
        if (nextmissiletag >= tags.size) {
            nextmissiletag = 0;
        }
        emissile = self fireweapon(0, etarget);
        emissile.killcament = self;
        self.lastrocketfiretime = gettime();
        if (i < ishots - 1) {
            wait weaponshoottime;
        }
    }
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xe2fa20fd, Offset: 0x7ad8
// Size: 0x62
function check_owner(hardpointtype) {
    if (!isdefined(self.owner) || !isdefined(self.owner.team) || self.owner.team != self.team) {
        self notify(#"abandoned");
        self thread heli_leave();
    }
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0xb2ad822d, Offset: 0x7b48
// Size: 0x3a
function attack_targets(missilesenabled, hardpointtype) {
    self thread attack_primary(hardpointtype);
    if (missilesenabled) {
        self thread attack_secondary(hardpointtype);
    }
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x10beede3, Offset: 0x7b90
// Size: 0x15d
function attack_secondary(hardpointtype) {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    for (;;) {
        if (isdefined(self.secondarytarget)) {
            self.secondarytarget.antithreat = undefined;
            self.missiletarget = self.secondarytarget;
            antithreat = 0;
            while (isdefined(self.missiletarget) && isalive(self.missiletarget)) {
                if (self target_cone_check(self.missiletarget, level.heli_missile_target_cone)) {
                    self thread missile_support(self.missiletarget, level.heli_missile_rof, 1, undefined);
                } else {
                    break;
                }
                antithreat += 100;
                self.missiletarget.antithreat = antithreat;
                wait level.heli_missile_rof;
                if (isdefined(self.secondarytarget) && (!isdefined(self.secondarytarget) || self.missiletarget != self.secondarytarget)) {
                    break;
                }
            }
            if (isdefined(self.missiletarget)) {
                self.missiletarget.antithreat = undefined;
            }
        }
        self waittill(#"hash_519af70b");
        self check_owner(hardpointtype);
    }
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0x62af9f4a, Offset: 0x7cf8
// Size: 0xca
function turret_target_check(turrettarget, attackangle) {
    targetyaw = math::get_2d_yaw(self.origin, turrettarget.origin);
    chopperyaw = self.angles[1];
    if (targetyaw < 0) {
        targetyaw *= -1;
    }
    targetyaw = int(targetyaw) % 360;
    if (chopperyaw < 0) {
        chopperyaw *= -1;
    }
    chopperyaw = int(chopperyaw) % 360;
    if (chopperyaw > targetyaw) {
        difference = chopperyaw - targetyaw;
    } else {
        difference = targetyaw - chopperyaw;
    }
    return difference <= attackangle;
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0x40befdc4, Offset: 0x7dd0
// Size: 0xc6
function target_cone_check(target, conecosine) {
    heli2target_normal = vectornormalize(target.origin - self.origin);
    heli2forward = anglestoforward(self.angles);
    heli2forward_normal = vectornormalize(heli2forward);
    heli_dot_target = vectordot(heli2target_normal, heli2forward_normal);
    if (heli_dot_target >= conecosine) {
        airsupport::debug_print3d_simple("Cone sight: " + heli_dot_target, self, (0, 0, -40), 40);
        return true;
    }
    return false;
}

// Namespace helicopter
// Params 4, eflags: 0x0
// Checksum 0xbb811d32, Offset: 0x7ea0
// Size: 0x213
function missile_support(target_player, rof, instantfire, endon_notify) {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    if (isdefined(endon_notify)) {
        self endon(endon_notify);
    }
    self.turret_giveup = 0;
    if (!instantfire) {
        wait rof;
        self.turret_giveup = 1;
        self notify(#"hash_e4ae4515");
    }
    if (isdefined(target_player)) {
        if (level.teambased) {
            for (i = 0; i < level.players.size; i++) {
                player = level.players[i];
                if (isdefined(player.team) && player.team == self.team && distance(player.origin, target_player.origin) <= level.heli_missile_friendlycare) {
                    airsupport::debug_print3d_simple("Missile omitted due to nearby friendly", self, (0, 0, -80), 40);
                    self notify(#"hash_2ff1ad5e");
                    return;
                }
            }
        } else {
            player = self.owner;
            if (isdefined(player) && isdefined(player.team) && player.team == self.team && distance(player.origin, target_player.origin) <= level.heli_missile_friendlycare) {
                airsupport::debug_print3d_simple("Missile omitted due to nearby friendly", self, (0, 0, -80), 40);
                self notify(#"hash_2ff1ad5e");
                return;
            }
        }
    }
    if (self.missile_ammo > 0 && isdefined(target_player)) {
        self fire_missile("ffar", 1, target_player);
        self.missile_ammo--;
        self notify(#"hash_b0c5ea03");
    } else {
        return;
    }
    if (instantfire) {
        wait rof;
        self notify(#"hash_2ff1ad5e");
    }
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x297422e0, Offset: 0x80c0
// Size: 0x3ed
function attack_primary(hardpointtype) {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    level endon(#"game_ended");
    for (;;) {
        if (isdefined(self.primarytarget)) {
            self.primarytarget.antithreat = undefined;
            self.turrettarget = self.primarytarget;
            antithreat = 0;
            last_pos = undefined;
            while (isdefined(self.turrettarget) && isalive(self.turrettarget)) {
                if (hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
                    self setlookatent(self.turrettarget);
                }
                helicopterturretmaxangle = function_91077906("scr_helicopterTurretMaxAngle", level.helicopterturretmaxangle);
                while (isdefined(self.turrettarget) && isalive(self.turrettarget) && self turret_target_check(self.turrettarget, helicopterturretmaxangle) == 0) {
                    wait 0.1;
                }
                if (!isdefined(self.turrettarget) || !isalive(self.turrettarget)) {
                    break;
                }
                self setturrettargetent(self.turrettarget, (0, 0, 50));
                self waittill(#"turret_on_target");
                hostmigration::waittillhostmigrationdone();
                self notify(#"turret_on_target");
                if (self.pilotistalking) {
                }
                self thread function_7b27c61a(self.turrettarget);
                wait 1;
                self heli_set_active_camo_state(0);
                wait level.heli_turret_spinup_delay;
                weaponshoottime = self.defaultweapon.firetime;
                self setvehweapon(self.defaultweapon);
                for (i = 0; i < level.heli_turretclipsize; i++) {
                    if (isdefined(self.turrettarget) && isdefined(self.primarytarget)) {
                        if (self.primarytarget != self.turrettarget) {
                            self setturrettargetent(self.primarytarget, (0, 0, 40));
                        }
                    } else if (isdefined(self.targetlost) && self.targetlost && isdefined(self.var_52daed11)) {
                        self setturrettargetvec(self.var_52daed11);
                    } else {
                        self clearturrettarget();
                    }
                    if (gettime() != self.lastrocketfiretime) {
                        self setvehweapon(self.defaultweapon);
                        minigun = self fireweapon();
                    }
                    if (i < level.heli_turretclipsize - 1) {
                        wait weaponshoottime;
                    }
                }
                self notify(#"hash_849f87ba");
                wait level.heli_turretreloadtime;
                wait 3;
                self heli_set_active_camo_state(1);
                if (isdefined(self.turrettarget) && isalive(self.turrettarget)) {
                    antithreat += 100;
                    self.turrettarget.antithreat = antithreat;
                }
                if (isdefined(self.turrettarget) && isdefined(self.primarytarget) && (!isdefined(self.primarytarget) || self.primarytarget != self.turrettarget)) {
                    break;
                }
            }
            if (isdefined(self.turrettarget)) {
                self.turrettarget.antithreat = undefined;
            }
        }
        self waittill(#"hash_907788c7");
        self check_owner(hardpointtype);
    }
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x6bfe0b26, Offset: 0x84b8
// Size: 0x1ed
function function_7b27c61a(turrettarget) {
    self notify(#"hash_4008e0d0");
    self endon(#"hash_4008e0d0");
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    self endon(#"hash_849f87ba");
    turrettarget endon(#"death");
    turrettarget endon(#"disconnect");
    self.targetlost = 0;
    self.var_52daed11 = undefined;
    while (isdefined(turrettarget)) {
        heli_centroid = self.origin + (0, 0, -160);
        heli_forward_norm = anglestoforward(self.angles);
        heli_turret_point = heli_centroid + -112 * heli_forward_norm;
        var_7e7ba03f = turrettarget sightconetrace(heli_turret_point, self);
        if (var_7e7ba03f < level.heli_target_recognition) {
            break;
        }
        wait 0.05;
    }
    if (isdefined(turrettarget) && isdefined(turrettarget.origin)) {
        assert(isdefined(turrettarget.origin), "<dev string:x2bb>");
        self.var_52daed11 = turrettarget.origin + (0, 0, 40);
        assert(isdefined(self.var_52daed11), "<dev string:x2f2>");
        self setturrettargetvec(self.var_52daed11);
        assert(isdefined(self.var_52daed11), "<dev string:x328>");
        airsupport::debug_print3d_simple("Turret target lost at: " + self.var_52daed11, self, (0, 0, -70), 60);
        self.targetlost = 1;
        return;
    }
    self.targetlost = undefined;
    self.var_52daed11 = undefined;
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x19cd9b30, Offset: 0x86b0
// Size: 0x1fa
function debug_print_target() {
    if (isdefined(level.heli_debug) && level.heli_debug == 1) {
        if (isdefined(self.primarytarget) && isdefined(self.primarytarget.threatlevel)) {
            if (isdefined(self.primarytarget.type) && self.primarytarget.type == "dog") {
                name = "dog";
            } else {
                name = self.primarytarget.name;
            }
            primary_msg = "Primary: " + name + " : " + self.primarytarget.threatlevel;
        } else {
            primary_msg = "Primary: ";
        }
        if (isdefined(self.secondarytarget) && isdefined(self.secondarytarget.threatlevel)) {
            if (isdefined(self.secondarytarget.type) && self.secondarytarget.type == "dog") {
                name = "dog";
            } else {
                name = self.secondarytarget.name;
            }
            secondary_msg = "Secondary: " + name + " : " + self.secondarytarget.threatlevel;
        } else {
            secondary_msg = "Secondary: ";
        }
        frames = int(self.targeting_delay * 20) + 1;
        thread airsupport::draw_text(primary_msg, (1, 0.6, 0.6), self, (0, 0, 40), frames);
        thread airsupport::draw_text(secondary_msg, (1, 0.6, 0.6), self, (0, 0, 0), frames);
    }
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x3b484cc9, Offset: 0x88b8
// Size: 0x28
function waittill_confirm_location() {
    self endon(#"emp_jammed");
    self endon(#"emp_grenaded");
    self waittill(#"confirm_location", location);
    return location;
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x7785361b, Offset: 0x88e8
// Size: 0x99
function selecthelicopterlocation(hardpointtype) {
    self beginlocationcomlinkselection("compass_objpoint_helicopter", 1500);
    self.selectinglocation = 1;
    self thread airsupport::endselectionthink();
    location = self waittill_confirm_location();
    if (!isdefined(location)) {
        return 0;
    }
    if (self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
        return 0;
    }
    level.helilocation = location;
    return airsupport::function_b49a99ff(location, undefined);
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0x969c2a35, Offset: 0x8990
// Size: 0xda
function processcopterassist(destroyedcopter, damagedone) {
    self endon(#"disconnect");
    destroyedcopter endon(#"disconnect");
    wait 0.05;
    if (!isdefined(level.teams[self.team])) {
        return;
    }
    if (self.team == destroyedcopter.team) {
        return;
    }
    assist_level = "aircraft_destruction_assist";
    assist_level_value = int(ceil(damagedone.damage / destroyedcopter.maxhealth * 4));
    if (assist_level_value > 0) {
        if (assist_level_value > 3) {
            assist_level_value = 3;
        }
        assist_level = assist_level + "_" + assist_level_value * 25;
    }
    scoreevents::processscoreevent(assist_level, self);
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0xcfad6b40, Offset: 0x8a78
// Size: 0x5a
function function_6de97db8() {
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    level endon(#"game_ended");
    self util::waittill_any("turret_on_target", "path start", "near_goal");
    function_38a2c2c2(self, 1);
}

// Namespace helicopter
// Params 4, eflags: 0x0
// Checksum 0x3c93b2c6, Offset: 0x8ae0
// Size: 0xba
function playpilotdialog(dialog, time, voice, shouldwait) {
    self endon(#"death");
    level endon(#"remote_end");
    if (isdefined(time)) {
        wait time;
    }
    if (!isdefined(self.pilotvoicenumber)) {
        self.pilotvoicenumber = 0;
    }
    if (isdefined(voice)) {
        voicenumber = voice;
    } else {
        voicenumber = self.pilotvoicenumber;
    }
    soundalias = level.teamprefix[self.team] + voicenumber + "_" + dialog;
    if (isdefined(self.owner)) {
        self.owner playpilottalking(shouldwait, soundalias);
    }
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0xe1b4bce6, Offset: 0x8ba8
// Size: 0x96
function playpilottalking(shouldwait, soundalias) {
    self endon(#"disconnect");
    self endon(#"joined_team");
    self endon(#"joined_spectators");
    for (trycounter = 0; isdefined(self.pilottalking) && self.pilottalking && trycounter < 10; trycounter++) {
        if (isdefined(shouldwait) && !shouldwait) {
            return;
        }
        wait 1;
    }
    self.pilottalking = 1;
    self playlocalsound(soundalias);
    wait 3;
    self.pilottalking = 0;
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xce7e2eb6, Offset: 0x8c48
// Size: 0x6f
function watchforearlyleave(chopper) {
    chopper notify(#"watchforearlyleave_helicopter");
    chopper endon(#"watchforearlyleave_helicopter");
    chopper endon(#"death");
    self endon(#"heli_timeup");
    self util::waittill_any("joined_team", "disconnect");
    if (isdefined(chopper)) {
        chopper thread heli_leave();
    }
    if (isdefined(self)) {
        self notify(#"heli_timeup");
    }
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x6dea668d, Offset: 0x8cc0
// Size: 0x42
function watchforemp() {
    heli = self;
    heli endon(#"death");
    heli endon(#"heli_timeup");
    heli.owner waittill(#"emp_jammed");
    heli thread heli_explode();
}

