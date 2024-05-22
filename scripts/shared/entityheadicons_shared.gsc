#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace entityheadicons;

// Namespace entityheadicons
// Params 0, eflags: 0x0
// Checksum 0xfc589875, Offset: 0x160
// Size: 0x24
function init_shared() {
    callback::on_start_gametype(&start_gametype);
}

// Namespace entityheadicons
// Params 0, eflags: 0x1 linked
// Checksum 0xd3748abf, Offset: 0x190
// Size: 0xb8
function start_gametype() {
    if (isdefined(level.var_3d8a3717)) {
        return;
    }
    level.var_3d8a3717 = 1;
    /#
        assert(isdefined(game["<unknown string>"]), "<unknown string>");
    #/
    /#
        assert(isdefined(game["<unknown string>"]), "<unknown string>");
    #/
    if (!level.teambased) {
        return;
    }
    if (!isdefined(level.setentityheadicon)) {
        level.setentityheadicon = &setentityheadicon;
    }
    level.var_17c7d510 = [];
}

// Namespace entityheadicons
// Params 5, eflags: 0x1 linked
// Checksum 0x349b1bc6, Offset: 0x250
// Size: 0x384
function setentityheadicon(team, owner, offset, objective, var_cc32611f) {
    if (!level.teambased && !isdefined(owner)) {
        return;
    }
    if (!isdefined(var_cc32611f)) {
        var_cc32611f = 0;
    }
    if (!isdefined(self.entityheadiconteam)) {
        self.entityheadiconteam = "none";
        self.entityheadicons = [];
        self.entityheadobjectives = [];
    }
    if (level.teambased && !isdefined(owner)) {
        if (team == self.entityheadiconteam) {
            return;
        }
        self.entityheadiconteam = team;
    }
    if (isdefined(offset)) {
        self.entityheadiconoffset = offset;
    } else {
        self.entityheadiconoffset = (0, 0, 0);
    }
    if (isdefined(self.entityheadicons)) {
        for (i = 0; i < self.entityheadicons.size; i++) {
            if (isdefined(self.entityheadicons[i])) {
                self.entityheadicons[i] destroy();
            }
        }
    }
    if (isdefined(self.entityheadobjectives)) {
        for (i = 0; i < self.entityheadobjectives.size; i++) {
            if (isdefined(self.entityheadobjectives[i])) {
                objective_delete(self.entityheadobjectives[i]);
                self.entityheadobjectives[i] = undefined;
            }
        }
    }
    self.entityheadicons = [];
    self.entityheadobjectives = [];
    self notify(#"kill_entity_headicon_thread");
    if (!isdefined(objective)) {
        objective = game["entity_headicon_" + team];
    }
    if (isdefined(objective)) {
        if (isdefined(owner) && !level.teambased) {
            if (!isplayer(owner)) {
                /#
                    assert(isdefined(owner.owner), "<unknown string>");
                #/
                owner = owner.owner;
            }
            if (isstring(objective)) {
                owner function_a7801f67(self, objective, var_cc32611f);
            } else {
                owner updateentityheadclientobjective(self, objective, var_cc32611f);
            }
        } else if (isdefined(owner) && team != "none") {
            if (isstring(objective)) {
                owner function_49af735d(self, team, objective, var_cc32611f);
            } else {
                owner updateentityheadteamobjective(self, team, objective, var_cc32611f);
            }
        }
    }
    self thread destroyheadiconsondeath();
}

// Namespace entityheadicons
// Params 4, eflags: 0x1 linked
// Checksum 0xc517f71f, Offset: 0x5e0
// Size: 0x1aa
function function_49af735d(entity, team, icon, var_cc32611f) {
    var_c94daf9f = array(0.584, 0.839, 0.867);
    headicon = newteamhudelem(team);
    headicon.archived = 1;
    headicon.x = entity.entityheadiconoffset[0];
    headicon.y = entity.entityheadiconoffset[1];
    headicon.z = entity.entityheadiconoffset[2];
    headicon.alpha = 0.8;
    headicon.color = (var_c94daf9f[0], var_c94daf9f[1], var_c94daf9f[2]);
    headicon setshader(icon, 6, 6);
    headicon setwaypoint(var_cc32611f);
    headicon settargetent(entity);
    entity.entityheadicons[entity.entityheadicons.size] = headicon;
}

// Namespace entityheadicons
// Params 3, eflags: 0x1 linked
// Checksum 0x971bf79f, Offset: 0x798
// Size: 0x14a
function function_a7801f67(entity, icon, var_cc32611f) {
    headicon = newclienthudelem(self);
    headicon.archived = 1;
    headicon.x = entity.entityheadiconoffset[0];
    headicon.y = entity.entityheadiconoffset[1];
    headicon.z = entity.entityheadiconoffset[2];
    headicon.alpha = 0.8;
    headicon setshader(icon, 6, 6);
    headicon setwaypoint(var_cc32611f);
    headicon settargetent(entity);
    entity.entityheadicons[entity.entityheadicons.size] = headicon;
}

// Namespace entityheadicons
// Params 4, eflags: 0x1 linked
// Checksum 0x1ad8570c, Offset: 0x8f0
// Size: 0xc2
function updateentityheadteamobjective(entity, team, objective, var_cc32611f) {
    headiconobjectiveid = gameobjects::get_next_obj_id();
    objective_add(headiconobjectiveid, "active", entity, objective);
    objective_team(headiconobjectiveid, team);
    objective_setcolor(headiconobjectiveid, %FriendlyBlue);
    entity.entityheadobjectives[entity.entityheadobjectives.size] = headiconobjectiveid;
}

// Namespace entityheadicons
// Params 3, eflags: 0x1 linked
// Checksum 0xaa858299, Offset: 0x9c0
// Size: 0xd2
function updateentityheadclientobjective(entity, objective, var_cc32611f) {
    headiconobjectiveid = gameobjects::get_next_obj_id();
    objective_add(headiconobjectiveid, "active", entity, objective);
    objective_setinvisibletoall(headiconobjectiveid);
    objective_setvisibletoplayer(headiconobjectiveid, self);
    objective_setcolor(headiconobjectiveid, %FriendlyBlue);
    entity.entityheadobjectives[entity.entityheadobjectives.size] = headiconobjectiveid;
}

// Namespace entityheadicons
// Params 0, eflags: 0x1 linked
// Checksum 0xe5451607, Offset: 0xaa0
// Size: 0x11e
function destroyheadiconsondeath() {
    self notify(#"destroyheadiconsondeath_singleton");
    self endon(#"destroyheadiconsondeath_singleton");
    self util::waittill_any("death", "hacked");
    for (i = 0; i < self.entityheadicons.size; i++) {
        if (isdefined(self.entityheadicons[i])) {
            self.entityheadicons[i] destroy();
        }
    }
    for (i = 0; i < self.entityheadobjectives.size; i++) {
        if (isdefined(self.entityheadobjectives[i])) {
            gameobjects::release_obj_id(self.entityheadobjectives[i]);
            objective_delete(self.entityheadobjectives[i]);
        }
    }
}

// Namespace entityheadicons
// Params 0, eflags: 0x1 linked
// Checksum 0x65aff947, Offset: 0xbc8
// Size: 0x100
function destroyentityheadicons() {
    if (isdefined(self.entityheadicons)) {
        for (i = 0; i < self.entityheadicons.size; i++) {
            if (isdefined(self.entityheadicons[i])) {
                self.entityheadicons[i] destroy();
            }
        }
    }
    if (isdefined(self.entityheadobjectives)) {
        for (i = 0; i < self.entityheadobjectives.size; i++) {
            if (isdefined(self.entityheadobjectives[i])) {
                gameobjects::release_obj_id(self.entityheadobjectives[i]);
                objective_delete(self.entityheadobjectives[i]);
            }
        }
    }
    self.entityheadobjectives = [];
}

// Namespace entityheadicons
// Params 1, eflags: 0x0
// Checksum 0xe42c2e4f, Offset: 0xcd0
// Size: 0x84
function function_29295d50(headicon) {
    headicon.x = self.origin[0] + self.entityheadiconoffset[0];
    headicon.y = self.origin[1] + self.entityheadiconoffset[1];
    headicon.z = self.origin[2] + self.entityheadiconoffset[2];
}

// Namespace entityheadicons
// Params 0, eflags: 0x0
// Checksum 0xd7bae5e0, Offset: 0xd60
// Size: 0x92
function function_4501c87c() {
    if (isdefined(self.entityheadicons)) {
        foreach (icon in self.entityheadicons) {
            icon.var_f5d9ee81 = 1;
        }
    }
}

