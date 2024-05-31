#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#using_animtree("mp_emp_power_core");

#namespace emp;

// Namespace emp
// Params 0, eflags: 0x2
// namespace_8790b7c1<file_0>::function_2dc19561
// Checksum 0x9159f0ab, Offset: 0x1e0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("emp", &__init__, undefined, undefined);
}

// Namespace emp
// Params 0, eflags: 0x1 linked
// namespace_8790b7c1<file_0>::function_8c87d8eb
// Checksum 0x1773b161, Offset: 0x220
// Size: 0xa4
function __init__() {
    clientfield::register("scriptmover", "emp_turret_init", 1, 1, "int", &emp_turret_init, 0, 0);
    clientfield::register("vehicle", "emp_turret_deploy", 1, 1, "int", &emp_turret_deploy_start, 0, 0);
    thread monitor_emp_killstreaks();
}

// Namespace emp
// Params 0, eflags: 0x1 linked
// namespace_8790b7c1<file_0>::function_6b792eb2
// Checksum 0xacc5acd2, Offset: 0x2d0
// Size: 0x1b4
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
        wait(has_at_least_one_active_enemy_turret ? 0.1 : 0.7);
    }
}

// Namespace emp
// Params 1, eflags: 0x1 linked
// namespace_8790b7c1<file_0>::function_8754feee
// Checksum 0x8441b57b, Offset: 0x490
// Size: 0x134
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
// Params 2, eflags: 0x1 linked
// namespace_8790b7c1<file_0>::function_db26c633
// Checksum 0x999f39b9, Offset: 0x5d0
// Size: 0x84
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
// Params 7, eflags: 0x1 linked
// namespace_8790b7c1<file_0>::function_7ee25d8f
// Checksum 0x42132b16, Offset: 0x660
// Size: 0xcc
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
// Params 2, eflags: 0x1 linked
// namespace_8790b7c1<file_0>::function_3a0d0ed5
// Checksum 0x335d503f, Offset: 0x738
// Size: 0x44
function cleanup_fx_on_shutdown(localclientnum, handle) {
    self endon(#"kill_fx_cleanup");
    self waittill(#"entityshutdown");
    stopfx(localclientnum, handle);
}

// Namespace emp
// Params 7, eflags: 0x1 linked
// namespace_8790b7c1<file_0>::function_49baf355
// Checksum 0xc434f4ee, Offset: 0x788
// Size: 0xce
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
// Params 1, eflags: 0x1 linked
// namespace_8790b7c1<file_0>::function_f70b47e0
// Checksum 0x5a3bf7ab, Offset: 0x860
// Size: 0x174
function emp_turret_deploy(localclientnum) {
    self endon(#"entityshutdown");
    self useanimtree(#mp_emp_power_core);
    self setanimrestart(mp_emp_power_core%o_turret_emp_core_deploy, 1, 0, 1);
    length = getanimlength(mp_emp_power_core%o_turret_emp_core_deploy);
    wait(length * 0.75);
    self useanimtree(#mp_emp_power_core);
    self setanim(mp_emp_power_core%o_turret_emp_core_spin, 1);
    self.fxhandle = playfxontag(localclientnum, "killstreaks/fx_emp_core", self, "tag_fx");
    self thread cleanup_fx_on_shutdown(localclientnum, self.fxhandle);
    wait(length * 0.25);
    self setanim(mp_emp_power_core%o_turret_emp_core_deploy, 0);
}

