#using scripts/codescripts/struct;
#using scripts/shared/_burnplayer;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/entityheadicons_shared;
#using scripts/shared/killcam_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_tacticalinsertion;
#using scripts/shared/weapons/_weaponobjects;

#namespace incendiary;

// Namespace incendiary
// Params 0, eflags: 0x2
// Checksum 0x9616bef5, Offset: 0x498
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("incendiary_grenade", &init_shared, undefined, undefined);
}

// Namespace incendiary
// Params 0, eflags: 0x0
// Checksum 0xa3bdc9fa, Offset: 0x4d8
// Size: 0x124
function init_shared() {
    level.var_bb2e86bc = getdvarint("scr_incendiaryfireDamage", 75);
    level.var_deee66a6 = getdvarint("scr_incendiaryfireDamageHardcore", 15);
    level.var_8b6a49fb = getdvarint("scr_incendiaryfireDuration", 5);
    level.var_f0f3c565 = getdvarfloat("scr_incendiaryfxDuration", 0.4);
    level.var_e20975d2 = getdvarint("scr_incendiaryDamageRadius", 125);
    level.var_4857ef20 = getdvarfloat("scr_incendiaryfireDamageTickTime", 1);
    level.var_c19e19ab = [];
    callback::on_spawned(&function_aad39157);
}

/#

    // Namespace incendiary
    // Params 0, eflags: 0x0
    // Checksum 0x92c4fe82, Offset: 0x608
    // Size: 0xfc
    function function_f981c352() {
        level.var_bb2e86bc = getdvarint("<dev string:x28>", level.var_bb2e86bc);
        level.var_deee66a6 = getdvarint("<dev string:x41>", level.var_deee66a6);
        level.var_8b6a49fb = getdvarint("<dev string:x62>", level.var_8b6a49fb);
        level.var_e20975d2 = getdvarint("<dev string:x7d>", level.var_e20975d2);
        level.var_4857ef20 = getdvarfloat("<dev string:x98>", level.var_4857ef20);
        level.var_f0f3c565 = getdvarfloat("<dev string:xb9>", level.var_f0f3c565);
    }

#/

// Namespace incendiary
// Params 0, eflags: 0x0
// Checksum 0xd8712ba9, Offset: 0x710
// Size: 0x50
function function_aad39157() {
    watcher = self weaponobjects::createuseweaponobjectwatcher("incendiary_grenade", self.team);
    watcher.onspawn = &function_8772b94d;
}

// Namespace incendiary
// Params 2, eflags: 0x0
// Checksum 0x43c46383, Offset: 0x768
// Size: 0x74
function function_8772b94d(watcher, player) {
    player endon(#"death");
    player endon(#"disconnect");
    level endon(#"game_ended");
    player addweaponstat(self.weapon, "used", 1);
    thread function_ab966fda(player);
}

// Namespace incendiary
// Params 1, eflags: 0x0
// Checksum 0xd06908ac, Offset: 0x7e8
// Size: 0x16c
function function_ab966fda(owner) {
    self endon(#"hacked");
    self endon(#"delete");
    killcament = spawn("script_model", self.origin);
    killcament util::deleteaftertime(15);
    killcament.starttime = gettime();
    killcament linkto(self);
    killcament setweapon(self.weapon);
    killcament killcam::store_killcam_entity_on_entity(self);
    self waittill(#"projectile_impact_explode", origin, normal, surface);
    killcament unlink();
    /#
        function_f981c352();
    #/
    playsoundatposition("wpn_incendiary_core_start", self.origin);
    generatelocations(origin, owner, normal, killcament);
}

// Namespace incendiary
// Params 1, eflags: 0x0
// Checksum 0x6347e36c, Offset: 0x960
// Size: 0x7e
function function_5377f3a6(normal) {
    if (normal[2] < 0.5) {
        stepoutdistance = normal * getdvarint("scr_incendiary_stepout_wall", 50);
    } else {
        stepoutdistance = normal * getdvarint("scr_incendiary_stepout_ground", 12);
    }
    return stepoutdistance;
}

// Namespace incendiary
// Params 4, eflags: 0x0
// Checksum 0xc1dabfe9, Offset: 0x9e8
// Size: 0x2ac
function generatelocations(position, owner, normal, killcament) {
    startpos = position + function_5377f3a6(normal);
    desiredendpos = startpos + (0, 0, 60);
    phystrace = physicstrace(startpos, desiredendpos, (-4, -4, -4), (4, 4, 4), self, 1);
    goalpos = phystrace["fraction"] < 1 ? phystrace["position"] : desiredendpos;
    killcament moveto(goalpos, 0.5);
    rotation = randomint(360);
    if (normal[2] < 0.1) {
        black = (0.1, 0.1, 0.1);
        trace = hitpos(startpos, startpos + normal * -1 * 70 + (0, 0, -1) * 70, black);
        traceposition = trace["position"];
        var_7e9ec3c7 = getweapon("incendiary_fire");
        if (trace["fraction"] < 0.9) {
            wallnormal = trace["normal"];
            spawntimedfx(var_7e9ec3c7, trace["position"], wallnormal, level.var_8b6a49fb, self.team);
        }
    }
    fxcount = getdvarint("scr_incendiary_fx_count", 6);
    spawnalllocs(owner, startpos, normal, 1, rotation, killcament, fxcount);
}

// Namespace incendiary
// Params 5, eflags: 0x0
// Checksum 0x9800964a, Offset: 0xca0
// Size: 0xb6
function function_8be43ae5(startpos, fxindex, fxcount, defaultdistance, rotation) {
    currentangle = 360 / fxcount * fxindex;
    coscurrent = cos(currentangle + rotation);
    sincurrent = sin(currentangle + rotation);
    return startpos + (defaultdistance * coscurrent, defaultdistance * sincurrent, 0);
}

// Namespace incendiary
// Params 7, eflags: 0x0
// Checksum 0x210a9029, Offset: 0xd60
// Size: 0x526
function spawnalllocs(owner, startpos, normal, multiplier, rotation, killcament, fxcount) {
    defaultdistance = getdvarint("scr_incendiary_trace_distance", -36) * multiplier;
    defaultdropdistance = getdvarint("scr_incendiary_trace_down_distance", 90);
    colorarray = [];
    colorarray[colorarray.size] = (0.9, 0.2, 0.2);
    colorarray[colorarray.size] = (0.2, 0.9, 0.2);
    colorarray[colorarray.size] = (0.2, 0.2, 0.9);
    colorarray[colorarray.size] = (0.9, 0.9, 0.9);
    locations = [];
    locations["color"] = [];
    locations["loc"] = [];
    locations["tracePos"] = [];
    locations["distSqrd"] = [];
    locations["fxtoplay"] = [];
    locations["radius"] = [];
    for (fxindex = 0; fxindex < fxcount; fxindex++) {
        locations["point"][fxindex] = function_8be43ae5(startpos, fxindex, fxcount, defaultdistance, rotation);
        locations["color"][fxindex] = colorarray[fxindex % colorarray.size];
    }
    for (count = 0; count < fxcount; count++) {
        trace = hitpos(startpos, locations["point"][count], locations["color"][count]);
        traceposition = trace["position"];
        locations["tracePos"][count] = traceposition;
        if (trace["fraction"] < 0.7) {
            locations["loc"][count] = traceposition;
            locations["normal"][count] = trace["normal"];
            continue;
        }
        average = startpos / 2 + traceposition / 2;
        trace = hitpos(average, average - (0, 0, defaultdropdistance), locations["color"][count]);
        if (trace["fraction"] != 1) {
            locations["loc"][count] = trace["position"];
            locations["normal"][count] = trace["normal"];
        }
    }
    var_7e9ec3c7 = getweapon("incendiary_fire");
    spawntimedfx(var_7e9ec3c7, startpos, normal, level.var_8b6a49fb, self.team);
    level.var_e20975d2 = getdvarint("scr_incendiaryDamageRadius", level.var_e20975d2);
    thread damageeffectarea(owner, startpos, level.var_e20975d2, level.var_e20975d2, killcament);
    for (count = 0; count < locations["point"].size; count++) {
        if (isdefined(locations["loc"][count])) {
            normal = locations["normal"][count];
            spawntimedfx(var_7e9ec3c7, locations["loc"][count], normal, level.var_8b6a49fb, self.team);
        }
    }
}

/#

    // Namespace incendiary
    // Params 5, eflags: 0x0
    // Checksum 0xea38398a, Offset: 0x1290
    // Size: 0xbc
    function incendiary_debug_line(from, to, color, depthtest, time) {
        debug_rcbomb = getdvarint("<dev string:xd2>", 0);
        if (debug_rcbomb == 1) {
            if (!isdefined(time)) {
                time = 100;
            }
            if (!isdefined(depthtest)) {
                depthtest = 1;
            }
            line(from, to, color, 1, depthtest, time);
        }
    }

#/

// Namespace incendiary
// Params 5, eflags: 0x0
// Checksum 0xc4d4b028, Offset: 0x1358
// Size: 0x282
function damageeffectarea(owner, position, radius, height, killcament) {
    trigger_radius_position = position - (0, 0, height);
    trigger_radius_height = height * 2;
    fireeffectarea = spawn("trigger_radius", trigger_radius_position, 0, radius, trigger_radius_height);
    /#
        if (getdvarint("<dev string:xe7>")) {
            level thread util::drawcylinder(trigger_radius_position, radius, trigger_radius_height, undefined, "<dev string:xf9>");
        }
    #/
    if (isdefined(level.var_bf238099)) {
        owner thread [[ level.var_bf238099 ]](fireeffectarea);
    }
    loopwaittime = level.var_4857ef20;
    var_70ce2f94 = level.var_8b6a49fb;
    while (var_70ce2f94 > 0) {
        var_70ce2f94 -= loopwaittime;
        damageapplied = 0;
        potential_targets = self getpotentialtargets(owner);
        foreach (target in potential_targets) {
            self trytoapplyfiredamage(target, owner, position, fireeffectarea, loopwaittime, killcament);
        }
        wait loopwaittime;
    }
    if (isdefined(killcament)) {
        killcament entityheadicons::destroyentityheadicons();
    }
    fireeffectarea delete();
    /#
        if (getdvarint("<dev string:xe7>")) {
            level notify(#"hash_7e5be7f8");
        }
    #/
}

// Namespace incendiary
// Params 1, eflags: 0x0
// Checksum 0x187e2900, Offset: 0x15e8
// Size: 0x2f4
function getpotentialtargets(owner) {
    owner_team = isdefined(owner) ? owner.team : undefined;
    if (level.teambased && isdefined(owner_team) && level.friendlyfire == 0) {
        enemy_team = owner_team == "axis" ? "allies" : "axis";
        potential_targets = [];
        potential_targets = arraycombine(potential_targets, getplayers(enemy_team), 0, 0);
        potential_targets = arraycombine(potential_targets, getaiteamarray(enemy_team), 0, 0);
        potential_targets = arraycombine(potential_targets, getvehicleteamarray(enemy_team), 0, 0);
        potential_targets[potential_targets.size] = owner;
        return potential_targets;
    }
    all_targets = [];
    all_targets = arraycombine(all_targets, level.players, 0, 0);
    all_targets = arraycombine(all_targets, getaiarray(), 0, 0);
    all_targets = arraycombine(all_targets, getvehiclearray(), 0, 0);
    if (level.friendlyfire > 0) {
        return all_targets;
    }
    potential_targets = [];
    foreach (target in all_targets) {
        if (isdefined(owner)) {
            if (target != owner) {
                if (!isdefined(owner_team)) {
                    continue;
                }
                if (target.team == owner_team) {
                    continue;
                }
            }
        } else {
            if (!isdefined(self.team)) {
                continue;
            }
            if (target.team == self.team) {
                continue;
            }
        }
        potential_targets[potential_targets.size] = target;
    }
    return potential_targets;
}

// Namespace incendiary
// Params 6, eflags: 0x0
// Checksum 0xed3616e7, Offset: 0x18e8
// Size: 0x13c
function trytoapplyfiredamage(target, owner, position, fireeffectarea, resetfiretime, killcament) {
    if (!isdefined(target.var_d0efeba3) || target.var_d0efeba3 == 0) {
        if (!isdefined(target.sessionstate) || target istouching(fireeffectarea) && target.sessionstate == "playing") {
            trace = bullettrace(position, target getshootatpos(), 0, target, 1);
            if (trace["fraction"] == 1) {
                target.var_117f7ea6 = owner;
                target thread damageinfirearea(fireeffectarea, killcament, trace, position, resetfiretime);
            }
        }
    }
}

// Namespace incendiary
// Params 5, eflags: 0x0
// Checksum 0xde4d35b7, Offset: 0x1a30
// Size: 0x1a4
function damageinfirearea(fireeffectarea, killcament, trace, position, resetfiretime) {
    self endon(#"disconnect");
    self endon(#"death");
    timer = 0;
    damage = level.var_bb2e86bc;
    if (level.hardcoremode) {
        damage = level.var_deee66a6;
    }
    if (candofiredamage(killcament, self, resetfiretime)) {
        /#
            level.var_8296d89b = getdvarint("<dev string:xd2>", 0);
            if (level.var_8296d89b) {
                if (!isdefined(level.incendiarydamagetime)) {
                    level.incendiarydamagetime = gettime();
                }
                iprintlnbold(level.incendiarydamagetime - gettime());
                level.incendiarydamagetime = gettime();
            }
        #/
        self dodamage(damage, fireeffectarea.origin, self.var_117f7ea6, killcament, "none", "MOD_BURNED", 0, getweapon("incendiary_fire"));
        entnum = self getentitynumber();
        self thread sndfiredamage();
    }
}

// Namespace incendiary
// Params 0, eflags: 0x0
// Checksum 0xf358b7d9, Offset: 0x1be0
// Size: 0x11e
function sndfiredamage() {
    self notify(#"sndfire");
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"sndfire");
    if (!isdefined(self.sndfireent)) {
        self.sndfireent = spawn("script_origin", self.origin);
        self.sndfireent linkto(self, "tag_origin");
        self.sndfireent playsound("chr_burn_start");
        self thread sndfiredamage_deleteent(self.sndfireent);
    }
    self.sndfireent playloopsound("chr_burn_start_loop", 0.5);
    wait 3;
    self.sndfireent delete();
    self.sndfireent = undefined;
}

// Namespace incendiary
// Params 1, eflags: 0x0
// Checksum 0x5543a25e, Offset: 0x1d08
// Size: 0x44
function sndfiredamage_deleteent(ent) {
    self endon(#"disconnect");
    self waittill(#"death");
    if (isdefined(ent)) {
        ent delete();
    }
}

// Namespace incendiary
// Params 3, eflags: 0x0
// Checksum 0x6b3693ed, Offset: 0x1d58
// Size: 0xd0
function hitpos(start, end, color) {
    trace = bullettrace(start, end, 0, undefined);
    /#
        level.var_8296d89b = getdvarint("<dev string:xd2>", 0);
        if (level.var_8296d89b) {
            debugstar(trace["<dev string:x117>"], 2000, color);
        }
        thread incendiary_debug_line(start, trace["<dev string:x117>"], color, 1, 80);
    #/
    return trace;
}

// Namespace incendiary
// Params 3, eflags: 0x0
// Checksum 0x46eefbdf, Offset: 0x1e30
// Size: 0x84
function candofiredamage(killcament, victim, resetfiretime) {
    entnum = victim getentitynumber();
    if (!isdefined(level.var_c19e19ab[entnum])) {
        level.var_c19e19ab[entnum] = 0;
        level thread resetfiredamage(entnum, resetfiretime);
        return true;
    }
    return false;
}

// Namespace incendiary
// Params 2, eflags: 0x0
// Checksum 0x8a1547a9, Offset: 0x1ec0
// Size: 0x40
function resetfiredamage(entnum, time) {
    if (time > 0.05) {
        wait time - 0.05;
    }
    level.var_c19e19ab[entnum] = undefined;
}

