#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace aisquads;

// Namespace aisquads
// Method(s) 9 Total 9
class squad {

    // Namespace squad
    // Params 0, eflags: 0x0
    // Checksum 0x4fa8a6ea, Offset: 0x248
    // Size: 0x28
    function constructor() {
        self.squadleader = 0;
        self.squadmembers = [];
        self.squadbreadcrumb = [];
    }

    // Namespace squad
    // Params 0, eflags: 0x0
    // Checksum 0xe3f2f60c, Offset: 0x480
    // Size: 0x88
    function think() {
        if (isint(self.squadleader) && self.squadleader == 0 || !isdefined(self.squadleader)) {
            if (self.squadmembers.size > 0) {
                self.squadleader = self.squadmembers[0];
                self.squadbreadcrumb = self.squadleader.origin;
            } else {
                return false;
            }
        }
        return true;
    }

    // Namespace squad
    // Params 1, eflags: 0x0
    // Checksum 0x96aa4cc2, Offset: 0x410
    // Size: 0x68
    function removeaifromsqaud(ai) {
        if (isinarray(self.squadmembers, ai)) {
            arrayremovevalue(self.squadmembers, ai, 0);
            if (self.squadleader === ai) {
                self.squadleader = undefined;
            }
        }
    }

    // Namespace squad
    // Params 1, eflags: 0x0
    // Checksum 0x4437eda6, Offset: 0x380
    // Size: 0x82
    function addaitosquad(ai) {
        if (!isinarray(self.squadmembers, ai)) {
            if (ai.archetype == "robot") {
                ai ai::set_behavior_attribute("move_mode", "squadmember");
            }
            self.squadmembers[self.squadmembers.size] = ai;
        }
    }

    // Namespace squad
    // Params 0, eflags: 0x0
    // Checksum 0xfa8c37b4, Offset: 0x368
    // Size: 0xa
    function getmembers() {
        return self.squadmembers;
    }

    // Namespace squad
    // Params 0, eflags: 0x0
    // Checksum 0xdc71063c, Offset: 0x350
    // Size: 0xa
    function getleader() {
        return self.squadleader;
    }

    // Namespace squad
    // Params 0, eflags: 0x0
    // Checksum 0x6b4d95d4, Offset: 0x338
    // Size: 0xa
    function getsquadbreadcrumb() {
        return self.squadbreadcrumb;
    }

    // Namespace squad
    // Params 1, eflags: 0x0
    // Checksum 0x765756e1, Offset: 0x278
    // Size: 0xb4
    function addsquadbreadcrumbs(ai) {
        assert(self.squadleader == ai);
        if (distance2dsquared(self.squadbreadcrumb, ai.origin) >= 9216) {
            /#
                recordcircle(ai.origin, 4, (0, 0, 1), "<dev string:x28>", ai);
            #/
            self.squadbreadcrumb = ai.origin;
        }
    }

}

// Namespace aisquads
// Params 0, eflags: 0x2
// Checksum 0x912f91fc, Offset: 0x190
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("ai_squads", &__init__, undefined, undefined);
}

// Namespace aisquads
// Params 0, eflags: 0x0
// Checksum 0x67aafbbe, Offset: 0x1d0
// Size: 0x6c
function __init__() {
    level._squads = [];
    actorspawnerarray = getactorspawnerteamarray("axis");
    array::run_all(actorspawnerarray, &spawner::add_spawn_function, &squadmemberthink);
}

// Namespace aisquads
// Params 1, eflags: 0x4
// Checksum 0xc47ace35, Offset: 0x700
// Size: 0x38
function private createsquad(squadname) {
    level._squads[squadname] = new squad();
    return level._squads[squadname];
}

// Namespace aisquads
// Params 1, eflags: 0x4
// Checksum 0xb71a0bee, Offset: 0x740
// Size: 0x38
function private removesquad(squadname) {
    if (isdefined(level._squads) && isdefined(level._squads[squadname])) {
        level._squads[squadname] = undefined;
    }
}

// Namespace aisquads
// Params 1, eflags: 0x4
// Checksum 0x19402e25, Offset: 0x780
// Size: 0x18
function private getsquad(squadname) {
    return level._squads[squadname];
}

// Namespace aisquads
// Params 1, eflags: 0x4
// Checksum 0xfc4fd04c, Offset: 0x7a0
// Size: 0x5c
function private thinksquad(squadname) {
    while (true) {
        if ([[ level._squads[squadname] ]]->think()) {
            wait 0.5;
            continue;
        }
        removesquad(squadname);
        break;
    }
}

// Namespace aisquads
// Params 0, eflags: 0x4
// Checksum 0x7d4aac42, Offset: 0x808
// Size: 0x54
function private squadmemberdeath() {
    self waittill(#"death");
    if (isdefined(self.squadname) && isdefined(level._squads[self.squadname])) {
        [[ level._squads[self.squadname] ]]->removeaifromsqaud(self);
    }
}

// Namespace aisquads
// Params 0, eflags: 0x4
// Checksum 0x75d41fe9, Offset: 0x868
// Size: 0x416
function private squadmemberthink() {
    self endon(#"death");
    if (!isdefined(self.script_aisquadname)) {
        return;
    }
    wait 0.5;
    self.squadname = self.script_aisquadname;
    if (isdefined(self.squadname)) {
        if (!isdefined(level._squads[self.squadname])) {
            squad = createsquad(self.squadname);
            newsquadcreated = 1;
        } else {
            squad = getsquad(self.squadname);
        }
        [[ squad ]]->addaitosquad(self);
        self thread squadmemberdeath();
        if (isdefined(newsquadcreated) && newsquadcreated) {
            level thread thinksquad(self.squadname);
        }
        while (true) {
            squadleader = [[ level._squads[self.squadname] ]]->getleader();
            if (isdefined(squadleader) && !(isint(squadleader) && squadleader == 0)) {
                if (squadleader == self) {
                    /#
                        recordenttext(self.squadname + "<dev string:x33>", self, (0, 1, 0), "<dev string:x28>");
                    #/
                    /#
                        recordenttext(self.squadname + "<dev string:x33>", self, (0, 1, 0), "<dev string:x28>");
                    #/
                    /#
                        recordcircle(self.origin, 300, (1, 0.5, 0), "<dev string:x28>", self);
                    #/
                    if (isdefined(self.enemy)) {
                        self setgoal(self.enemy);
                    }
                    [[ squad ]]->addsquadbreadcrumbs(self);
                } else {
                    /#
                        recordline(self.origin, squadleader.origin, (0, 1, 0), "<dev string:x28>", self);
                    #/
                    /#
                        recordenttext(self.squadname + "<dev string:x3c>", self, (0, 1, 0), "<dev string:x28>");
                    #/
                    followposition = [[ squad ]]->getsquadbreadcrumb();
                    followdistsq = distance2dsquared(self.goalpos, followposition);
                    if (isdefined(squadleader.enemy)) {
                        if (isdefined(self.enemy) && (!isdefined(self.enemy) || self.enemy != squadleader.enemy)) {
                            self setentitytarget(squadleader.enemy, 1);
                        }
                    }
                    if (isdefined(self.goalpos) && followdistsq >= 256) {
                        if (followdistsq >= 22500) {
                            self ai::set_behavior_attribute("sprint", 1);
                        } else {
                            self ai::set_behavior_attribute("sprint", 0);
                        }
                        self setgoal(followposition, 1);
                    }
                }
            }
            wait 1;
        }
    }
}

// Namespace aisquads
// Params 1, eflags: 0x0
// Checksum 0x86ae2925, Offset: 0xc88
// Size: 0xbc
function isfollowingsquadleader(ai) {
    if (ai ai::get_behavior_attribute("move_mode") != "squadmember") {
        return false;
    }
    squadmember = issquadmember(ai);
    currentsquadleader = getsquadleader(ai);
    isaisquadleader = isdefined(currentsquadleader) && currentsquadleader == ai;
    if (squadmember && !isaisquadleader) {
        return true;
    }
    return false;
}

// Namespace aisquads
// Params 1, eflags: 0x0
// Checksum 0xc03c3f11, Offset: 0xd50
// Size: 0x76
function issquadmember(ai) {
    if (isdefined(ai.squadname)) {
        squad = getsquad(ai.squadname);
        if (isdefined(squad)) {
            return isinarray([[ squad ]]->getmembers(), ai);
        }
    }
    return 0;
}

// Namespace aisquads
// Params 1, eflags: 0x0
// Checksum 0xf0293a3f, Offset: 0xdd0
// Size: 0x88
function issquadleader(ai) {
    if (isdefined(ai.squadname)) {
        squad = getsquad(ai.squadname);
        if (isdefined(squad)) {
            squadleader = [[ squad ]]->getleader();
            return (isdefined(squadleader) && squadleader == ai);
        }
    }
    return false;
}

// Namespace aisquads
// Params 1, eflags: 0x0
// Checksum 0x166f1a3, Offset: 0xe60
// Size: 0x66
function getsquadleader(ai) {
    if (isdefined(ai.squadname)) {
        squad = getsquad(ai.squadname);
        if (isdefined(squad)) {
            return [[ squad ]]->getleader();
        }
    }
    return undefined;
}

