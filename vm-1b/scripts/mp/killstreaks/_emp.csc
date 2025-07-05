#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#using_animtree("mp_emp_power_core");

#namespace emp;

// Namespace emp
// Params 0, eflags: 0x2
// Checksum 0x6649ed67, Offset: 0x1e0
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("emp", &__init__, undefined, undefined);
}

// Namespace emp
// Params 0, eflags: 0x0
// Checksum 0xa0ec91bb, Offset: 0x218
// Size: 0x82
function __init__() {
    clientfield::register("scriptmover", "emp_turret_init", 1, 1, "int", &emp_turret_init, 0, 0);
    clientfield::register("vehicle", "emp_turret_deploy", 1, 1, "int", &emp_turret_deploy_start, 0, 0);
    thread monitor_emp_killstreaks();
}

// Namespace emp
// Params 0, eflags: 0x0
// Checksum 0x6e3d71d0, Offset: 0x2a8
// Size: 0x159
function monitor_emp_killstreaks() {
    level endon(#"disconnect");
    if (!isdefined(level.emp_killstreaks)) {
        level.emp_killstreaks = [];
    }
    for (;;) {
        has_at_least_one_active_enemy_turret = 0;
        arrayremovevalue(level.emp_killstreaks, undefined);
        local_players = getlocalplayers();
        foreach (local_player in local_players) {
            if (local_player islocalplayer() == 0) {
                continue;
            }
            closest_enemy_emp = get_closest_enemy_emp_killstreak(local_player);
            if (isdefined(closest_enemy_emp)) {
                has_at_least_one_active_enemy_turret = 1;
                localclientnum = local_player getlocalclientnumber();
                update_distance_to_closest_emp(localclientnum, distance(local_player.origin, closest_enemy_emp.origin));
            }
        }
        wait has_at_least_one_active_enemy_turret ? 0.1 : 0.7;
    }
}

// Namespace emp
// Params 1, eflags: 0x0
// Checksum 0xb9892e2c, Offset: 0x410
// Size: 0xe1
function get_closest_enemy_emp_killstreak(local_player) {
    closest_emp = undefined;
    closest_emp_distance_squared = 99999999;
    foreach (emp in level.emp_killstreaks) {
        if (emp.owner == local_player || emp.team == local_player.team) {
            continue;
        }
        distance_squared = distancesquared(local_player.origin, emp.origin);
        if (distance_squared < closest_emp_distance_squared) {
            closest_emp = emp;
            closest_emp_distance_squared = distance_squared;
        }
    }
    return closest_emp;
}

// Namespace emp
// Params 2, eflags: 0x0
// Checksum 0x8211e9d8, Offset: 0x500
// Size: 0x6a
function update_distance_to_closest_emp(localclientnum, new_value) {
    if (!isdefined(localclientnum)) {
        return;
    }
    distance_to_closest_enemy_emp_ui_model = getuimodel(getuimodelforcontroller(localclientnum), "distanceToClosestEnemyEmpKillstreak");
    if (isdefined(distance_to_closest_enemy_emp_ui_model)) {
        setuimodelvalue(distance_to_closest_enemy_emp_ui_model, new_value);
    }
}

// Namespace emp
// Params 7, eflags: 0x0
// Checksum 0xf6037047, Offset: 0x578
// Size: 0xc2
function emp_turret_init(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    if (!newval) {
        return;
    }
    self useanimtree(#mp_emp_power_core);
    self setanimrestart(mp_emp_power_core%o_turret_emp_core_deploy, 1, 0, 0);
    self setanimtime(mp_emp_power_core%o_turret_emp_core_deploy, 0);
}

// Namespace emp
// Params 2, eflags: 0x0
// Checksum 0xd7dd320e, Offset: 0x648
// Size: 0x3a
function cleanup_fx_on_shutdown(localclientnum, handle) {
    self endon(#"kill_fx_cleanup");
    self waittill(#"entityshutdown");
    stopfx(localclientnum, handle);
}

// Namespace emp
// Params 7, eflags: 0x0
// Checksum 0x7708b4fd, Offset: 0x690
// Size: 0xa9
function emp_turret_deploy_start(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        self thread emp_turret_deploy(localclientnum);
        return;
    }
    self notify(#"kill_fx_cleanup");
    if (isdefined(self.fxhandle)) {
        stopfx(localclientnum, self.fxhandle);
        self.fxhandle = undefined;
    }
}

// Namespace emp
// Params 1, eflags: 0x0
// Checksum 0x10b482cc, Offset: 0x748
// Size: 0x142
function emp_turret_deploy(localclientnum) {
    self endon(#"entityshutdown");
    self useanimtree(#mp_emp_power_core);
    self setanimrestart(mp_emp_power_core%o_turret_emp_core_deploy, 1, 0, 1);
    length = getanimlength(mp_emp_power_core%o_turret_emp_core_deploy);
    wait length * 0.75;
    self useanimtree(#mp_emp_power_core);
    self setanim(mp_emp_power_core%o_turret_emp_core_spin, 1);
    self.fxhandle = playfxontag(localclientnum, "killstreaks/fx_emp_core", self, "tag_fx");
    self thread cleanup_fx_on_shutdown(localclientnum, self.fxhandle);
    wait length * 0.25;
    self setanim(mp_emp_power_core%o_turret_emp_core_deploy, 0);
}

