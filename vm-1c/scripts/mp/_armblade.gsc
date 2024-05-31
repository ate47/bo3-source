#using scripts/shared/util_shared;
#using scripts/shared/weapons/_proximity_grenade;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_a4323dc1;

// Namespace namespace_a4323dc1
// Params 0, eflags: 0x2
// namespace_a4323dc1<file_0>::function_2dc19561
// Checksum 0xaadaf54, Offset: 0x190
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("armblade", &__init__, undefined, undefined);
}

// Namespace namespace_a4323dc1
// Params 0, eflags: 0x1 linked
// namespace_a4323dc1<file_0>::function_8c87d8eb
// Checksum 0x78ff9695, Offset: 0x1d0
// Size: 0x44
function __init__() {
    level.var_f14b6bc1 = getweapon("hero_armblade");
    callback::on_spawned(&on_player_spawned);
}

// Namespace namespace_a4323dc1
// Params 0, eflags: 0x1 linked
// namespace_a4323dc1<file_0>::function_aebcf025
// Checksum 0x77faff85, Offset: 0x220
// Size: 0x1c
function on_player_spawned() {
    self thread function_1a8e90d4();
}

// Namespace namespace_a4323dc1
// Params 0, eflags: 0x1 linked
// namespace_a4323dc1<file_0>::function_1a8e90d4
// Checksum 0xc0d48719, Offset: 0x248
// Size: 0x130
function function_1a8e90d4() {
    self endon(#"disconnect");
    self endon(#"death");
    for (;;) {
        result = self util::waittill_any_return("weapon_change", "disconnect");
        if (isdefined(result)) {
            if (result == "weapon_change" && self getcurrentweapon() == level.var_f14b6bc1) {
                if (!isdefined(self.var_5a11ecea)) {
                    self.var_5a11ecea = spawn("script_origin", self.origin);
                    self.var_5a11ecea linkto(self);
                }
                self.var_5a11ecea playloopsound("wpn_armblade_idle", 0.25);
                continue;
            }
            if (isdefined(self.var_5a11ecea)) {
                self.var_5a11ecea stoploopsound(0.25);
            }
        }
    }
}

