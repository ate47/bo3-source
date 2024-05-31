#using scripts/zm/_zm_placeable_mine;
#using scripts/zm/_util;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/weapons/_bouncingbetty;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace bouncingbetty;

// Namespace bouncingbetty
// Params 0, eflags: 0x2
// namespace_c147e610<file_0>::function_2dc19561
// Checksum 0x43c5de25, Offset: 0x1b0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("bouncingbetty", &__init__, undefined, undefined);
}

// Namespace bouncingbetty
// Params 0, eflags: 0x1 linked
// namespace_c147e610<file_0>::function_8c87d8eb
// Checksum 0x6c2e6e41, Offset: 0x1f0
// Size: 0xe4
function __init__() {
    level._proximityweaponobjectdetonation_override = &proximityweaponobjectdetonation_override;
    init_shared();
    zm_placeable_mine::add_mine_type("bouncingbetty", %MP_BOUNCINGBETTY_PICKUP);
    level.bettyjumpheight = 55;
    level.bettydamagemax = 1000;
    level.bettydamagemin = 800;
    level.bettydamageheight = level.bettyjumpheight;
    /#
        setdvar("<unknown string>", level.bettydamagemax);
        setdvar("<unknown string>", level.bettydamagemin);
        setdvar("<unknown string>", level.bettyjumpheight);
    #/
}

// Namespace bouncingbetty
// Params 1, eflags: 0x1 linked
// namespace_c147e610<file_0>::function_830caae9
// Checksum 0x7d73c82a, Offset: 0x2e0
// Size: 0x178
function proximityweaponobjectdetonation_override(watcher) {
    self endon(#"death");
    self endon(#"hacked");
    self endon(#"kill_target_detection");
    weaponobjects::proximityweaponobject_activationdelay(watcher);
    damagearea = weaponobjects::proximityweaponobject_createdamagearea(watcher);
    up = anglestoup(self.angles);
    traceorigin = self.origin + up;
    if (isdefined(level.var_4382ca27)) {
        self thread [[ level.var_4382ca27 ]](watcher);
    }
    while (true) {
        ent = damagearea waittill(#"trigger");
        if (!weaponobjects::proximityweaponobject_validtriggerentity(watcher, ent)) {
            continue;
        }
        if (weaponobjects::proximityweaponobject_isspawnprotected(watcher, ent)) {
            continue;
        }
        if (ent damageconetrace(traceorigin, self) > 0) {
            thread weaponobjects::proximityweaponobject_dodetonation(watcher, ent, traceorigin);
        }
    }
}

