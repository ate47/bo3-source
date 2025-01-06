#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_emp;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_placeables;
#using scripts/mp/teams/_teams;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/weapons/_weaponobjects;

#using_animtree("mp_emp_power_core");

#namespace emp;

// Namespace emp
// Params 0, eflags: 0x0
// Checksum 0x70aece54, Offset: 0x668
// Size: 0x282
function init() {
    bundle = struct::get_script_bundle("killstreak", "killstreak_emp");
    level.empkillstreakbundle = bundle;
    if (level.teambased) {
        foreach (team in level.teams) {
            level.activeemps[team] = 0;
        }
    }
    level.enemyempactivefunc = &enemyempactive;
    level thread emptracker();
    killstreaks::register("emp", "emp", "killstreak_emp", "emp_used", &function_9765d140);
    killstreaks::function_f79fd1e9("emp", %KILLSTREAK_EARNED_EMP, %KILLSTREAK_EMP_NOT_AVAILABLE, %KILLSTREAK_EMP_INBOUND, undefined, %KILLSTREAK_EMP_HACKED, 0);
    killstreaks::register_dialog("emp", "mpl_killstreak_emp_activate", "empDialogBundle", undefined, "friendlyEmp", "enemyEmp", "enemyEmpMultiple", "friendlyEmpHacked", "enemyEmpHacked", "requestEmp", "threatEmp");
    clientfield::register("scriptmover", "emp_turret_init", 1, 1, "int");
    clientfield::register("vehicle", "emp_turret_deploy", 1, 1, "int");
    var_dff7fbfe = mp_emp_power_core%o_turret_emp_core_spin;
    deployanim = mp_emp_power_core%o_turret_emp_core_deploy;
    callback::on_spawned(&onplayerspawned);
    callback::on_connect(&onplayerconnect);
    vehicle::add_main_callback("emp_turret", &initturretvehicle);
}

// Namespace emp
// Params 0, eflags: 0x0
// Checksum 0x80b9630d, Offset: 0x8f8
// Size: 0xb2
function initturretvehicle() {
    turretvehicle = self;
    turretvehicle killstreaks::setup_health("emp");
    turretvehicle.damagetaken = 0;
    turretvehicle.health = turretvehicle.maxhealth;
    turretvehicle clientfield::set("enemyvehicle", 1);
    turretvehicle.soundmod = "drone_land";
    turretvehicle.overridevehicledamage = &onturretdamage;
    turretvehicle.var_60bdc617 = &onturretdeath;
    target_set(turretvehicle, (0, 0, 36));
}

// Namespace emp
// Params 0, eflags: 0x0
// Checksum 0x58ab11d0, Offset: 0x9b8
// Size: 0x1a
function onplayerspawned() {
    self endon(#"disconnect");
    self updateemp();
}

// Namespace emp
// Params 0, eflags: 0x0
// Checksum 0x46a28eaf, Offset: 0x9e0
// Size: 0x2b
function onplayerconnect() {
    self.entnum = self getentitynumber();
    level.activeemps[self.entnum] = 0;
}

// Namespace emp
// Params 0, eflags: 0x0
// Checksum 0x3ad09002, Offset: 0xa18
// Size: 0x185
function function_9765d140() {
    player = self;
    killstreakid = player killstreakrules::killstreakstart("emp", player.team, 0, 0);
    if (killstreakid == -1) {
        return false;
    }
    bundle = level.empkillstreakbundle;
    var_63856d52 = player placeables::spawnplaceable("emp", killstreakid, &function_b5da3f4f, &oncancelplacement, undefined, &onshutdown, undefined, undefined, "wpn_t7_turret_emp_core", "wpn_t7_turret_emp_core_yellow", "wpn_t7_turret_emp_core_red", 1, "", undefined, undefined, 0, bundle.ksplaceablehint, bundle.ksplaceableinvalidlocationhint);
    var_63856d52 thread util::ghost_wait_show_to_player(player);
    var_63856d52.othermodel thread util::ghost_wait_show_to_others(player);
    var_63856d52 clientfield::set("emp_turret_init", 1);
    var_63856d52.othermodel clientfield::set("emp_turret_init", 1);
    event = var_63856d52 util::waittill_any_return("placed", "cancelled", "death");
    if (event != "placed") {
        return false;
    }
    return true;
}

// Namespace emp
// Params 1, eflags: 0x0
// Checksum 0x4c38b2df, Offset: 0xba8
// Size: 0x2aa
function function_b5da3f4f(emp) {
    player = self;
    assert(isplayer(player));
    assert(!isdefined(emp.vehicle));
    emp.vehicle = spawnvehicle("emp_turret", emp.origin, emp.angles);
    emp.vehicle thread util::ghost_wait_show(0.05);
    emp.vehicle.killstreaktype = emp.killstreaktype;
    emp.vehicle.owner = player;
    emp.vehicle setowner(player);
    emp.vehicle.ownerentnum = player.entnum;
    emp.vehicle.parentstruct = emp;
    player.emptime = gettime();
    player killstreaks::play_killstreak_start_dialog("emp", player.pers["team"], emp.killstreakid);
    player addweaponstat(getweapon("emp"), "used", 1);
    level thread popups::displaykillstreakteammessagetoall("emp", player);
    emp.vehicle killstreaks::configure_team("emp", emp.killstreakid, player);
    emp.vehicle killstreak_hacking::enable_hacking("emp", &hackedcallbackpre, &hackedcallbackpost);
    emp thread killstreaks::waitfortimeout("emp", 40000, &on_timeout, "death");
    if (issentient(emp.vehicle) == 0) {
        emp.vehicle makesentient();
    }
    emp.vehicle vehicle::disconnect_paths(0, 0);
    player thread deployempturret(emp);
}

// Namespace emp
// Params 1, eflags: 0x0
// Checksum 0xfb6dbe63, Offset: 0xe60
// Size: 0x18a
function deployempturret(emp) {
    player = self;
    player endon(#"disconnect");
    player endon(#"joined_team");
    player endon(#"joined_spectators");
    emp endon(#"death");
    emp.vehicle useanimtree(#mp_emp_power_core);
    emp.vehicle setanim(mp_emp_power_core%o_turret_emp_core_deploy, 1);
    length = getanimlength(mp_emp_power_core%o_turret_emp_core_deploy);
    emp.vehicle clientfield::set("emp_turret_deploy", 1);
    wait length * 0.75;
    emp.vehicle thread playempfx();
    emp.vehicle playsound("mpl_emp_turret_activate");
    emp.vehicle setanim(mp_emp_power_core%o_turret_emp_core_spin, 1);
    player thread emp_jamenemies(emp, 0);
    wait length * 0.25;
    emp.vehicle clearanim(mp_emp_power_core%o_turret_emp_core_deploy, 0);
}

// Namespace emp
// Params 1, eflags: 0x0
// Checksum 0x94c76fad, Offset: 0xff8
// Size: 0x6a
function hackedcallbackpre(hacker) {
    emp_vehicle = self;
    emp_vehicle clientfield::set("enemyvehicle", 2);
    emp_vehicle.parentstruct killstreaks::configure_team("emp", emp_vehicle.parentstruct.killstreakid, hacker, undefined, undefined, undefined, 1);
}

// Namespace emp
// Params 1, eflags: 0x0
// Checksum 0xe33a17ac, Offset: 0x1070
// Size: 0x32
function hackedcallbackpost(hacker) {
    emp_vehicle = self;
    hacker thread emp_jamenemies(emp_vehicle.parentstruct, 1);
}

// Namespace emp
// Params 1, eflags: 0x0
// Checksum 0x78aa648c, Offset: 0x10b0
// Size: 0x3a
function doneempfx(fxtagorigin) {
    playfx("killstreaks/fx_emp_exp_death", fxtagorigin);
    playsoundatposition("mpl_emp_turret_deactivate", fxtagorigin);
}

// Namespace emp
// Params 0, eflags: 0x0
// Checksum 0xe58bdcc4, Offset: 0x10f8
// Size: 0x31
function playempfx() {
    emp_vehicle = self;
    emp_vehicle playloopsound("mpl_emp_turret_loop_close");
    wait 0.05;
    if (isdefined(emp_vehicle)) {
    }
}

// Namespace emp
// Params 0, eflags: 0x0
// Checksum 0xd62c7576, Offset: 0x1138
// Size: 0x62
function on_timeout() {
    emp = self;
    if (isdefined(emp.vehicle)) {
        fxtagorigin = emp.vehicle gettagorigin("tag_fx");
        doneempfx(fxtagorigin);
    }
    shutdownemp(emp);
}

// Namespace emp
// Params 1, eflags: 0x0
// Checksum 0x9b515371, Offset: 0x11a8
// Size: 0x3a
function oncancelplacement(emp) {
    stopemp(emp.team, emp.ownerentnum, emp.originalteam, emp.killstreakid);
}

// Namespace emp
// Params 15, eflags: 0x0
// Checksum 0x5b2fd2b4, Offset: 0x11f0
// Size: 0x11c
function onturretdamage(einflictor, attacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    empdamage = 0;
    idamage = self killstreaks::ondamageperweapon("emp", attacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, empdamage, undefined, 1, 1);
    self.damagetaken = self.damagetaken + idamage;
    if (self.damagetaken > self.maxhealth && !isdefined(self.will_die)) {
        self.will_die = 1;
        self thread ondeathafterframeend(attacker, weapon);
    }
    return idamage;
}

// Namespace emp
// Params 8, eflags: 0x0
// Checksum 0xf18171d6, Offset: 0x1318
// Size: 0x5a
function onturretdeath(inflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    self ondeath(attacker, weapon);
}

// Namespace emp
// Params 2, eflags: 0x0
// Checksum 0xe678e878, Offset: 0x1380
// Size: 0x2a
function ondeathafterframeend(attacker, weapon) {
    waittillframeend();
    if (isdefined(self)) {
        self ondeath(attacker, weapon);
    }
}

// Namespace emp
// Params 2, eflags: 0x0
// Checksum 0xa5870dc4, Offset: 0x13b8
// Size: 0x10a
function ondeath(attacker, weapon) {
    emp_vehicle = self;
    fxtagorigin = self gettagorigin("tag_fx");
    doneempfx(fxtagorigin);
    if (isplayer(attacker)) {
        scoreevents::processscoreevent("destroyed_emp", attacker, emp_vehicle, weapon);
        luinotifyevent(%player_callout, 2, %KILLSTREAK_DESTROYED_EMP, attacker.entnum);
    }
    if (isdefined(attacker) && isdefined(emp_vehicle.owner) && attacker != emp_vehicle.owner) {
        emp_vehicle killstreaks::play_destroyed_dialog_on_owner("emp", emp_vehicle.parentstruct.killstreakid);
    }
    shutdownemp(emp_vehicle.parentstruct);
}

// Namespace emp
// Params 1, eflags: 0x0
// Checksum 0x696cfa0b, Offset: 0x14d0
// Size: 0x1a
function onshutdown(emp) {
    shutdownemp(emp);
}

// Namespace emp
// Params 1, eflags: 0x0
// Checksum 0x723abbb4, Offset: 0x14f8
// Size: 0xea
function shutdownemp(emp) {
    if (!isdefined(emp)) {
        return;
    }
    if (isdefined(emp.already_shutdown)) {
        return;
    }
    emp.already_shutdown = 1;
    if (isdefined(emp.vehicle)) {
        emp.vehicle clientfield::set("emp_turret_deploy", 0);
    }
    stopemp(emp.team, emp.ownerentnum, emp.originalteam, emp.killstreakid);
    if (isdefined(emp.othermodel)) {
        emp.othermodel delete();
    }
    if (isdefined(emp.vehicle)) {
        emp.vehicle delete();
    }
    emp delete();
}

// Namespace emp
// Params 4, eflags: 0x0
// Checksum 0xcb9ab577, Offset: 0x15f0
// Size: 0x42
function stopemp(currentteam, currentownerentnum, originalteam, killstreakid) {
    stopempeffect(currentteam, currentownerentnum);
    stopemprule(originalteam, killstreakid);
}

// Namespace emp
// Params 2, eflags: 0x0
// Checksum 0x5546183b, Offset: 0x1640
// Size: 0x3b
function stopempeffect(team, ownerentnum) {
    if (level.teambased) {
        level.activeemps[team] = 0;
    }
    level.activeemps[ownerentnum] = 0;
    level notify(#"emp_updated");
}

// Namespace emp
// Params 2, eflags: 0x0
// Checksum 0xf3d031cf, Offset: 0x1688
// Size: 0x2a
function stopemprule(killstreakoriginalteam, killstreakid) {
    killstreakrules::killstreakstop("emp", killstreakoriginalteam, killstreakid);
}

// Namespace emp
// Params 0, eflags: 0x0
// Checksum 0xdd95b781, Offset: 0x16c0
// Size: 0x14
function hasactiveemp() {
    return level.activeemps[self.entnum] > 0;
}

// Namespace emp
// Params 1, eflags: 0x0
// Checksum 0x6836fea0, Offset: 0x16e0
// Size: 0x14
function teamhasactiveemp(team) {
    return level.activeemps[team] > 0;
}

// Namespace emp
// Params 0, eflags: 0x0
// Checksum 0x6157095d, Offset: 0x1700
// Size: 0x102
function enemyempactive() {
    if (level.teambased) {
        foreach (team in level.teams) {
            if (team != self.team && teamhasactiveemp(team)) {
                return true;
            }
        }
    } else {
        enemies = self teams::getenemyplayers();
        foreach (player in enemies) {
            if (player hasactiveemp()) {
                return true;
            }
        }
    }
    return false;
}

// Namespace emp
// Params 2, eflags: 0x0
// Checksum 0xd0cdf090, Offset: 0x1810
// Size: 0x162
function emp_jamenemies(empent, hacked) {
    level endon(#"game_ended");
    self endon(#"killstreak_hacked");
    if (level.teambased) {
        if (hacked) {
            level.activeemps[empent.originalteam] = 0;
        }
        level.activeemps[self.team] = 1;
    }
    level.activeemps[empent.originalownerentnum] = 0;
    level.activeemps[self.entnum] = 1;
    level notify(#"emp_updated");
    level notify(#"emp_deployed");
    visionsetnaked("flash_grenade", 1.5);
    wait 0.1;
    visionsetnaked("flash_grenade", 0);
    visionsetnaked(getdvarstring("mapname"), 5);
    empkillstreakweapon = getweapon("emp");
    empkillstreakweapon.isempkillstreak = 1;
    level killstreaks::destroyotherteamsactivevehicles(self, empkillstreakweapon);
    level killstreaks::destroyotherteamsequipment(self, empkillstreakweapon);
    level weaponobjects::destroy_other_teams_supplemental_watcher_objects(self, empkillstreakweapon);
}

// Namespace emp
// Params 0, eflags: 0x0
// Checksum 0x8e2c26f5, Offset: 0x1980
// Size: 0x7f
function emptracker() {
    level endon(#"game_ended");
    while (true) {
        level waittill(#"emp_updated");
        foreach (player in level.players) {
            player updateemp();
        }
    }
}

// Namespace emp
// Params 0, eflags: 0x0
// Checksum 0x8da7ff69, Offset: 0x1a08
// Size: 0x80
function updateemp() {
    player = self;
    enemy_emp_active = player enemyempactive();
    player setempjammed(enemy_emp_active);
    emped = player isempjammed();
    player clientfield::set_to_player("empd_monitor_distance", emped);
    if (emped) {
        player notify(#"emp_jammed");
    }
}

