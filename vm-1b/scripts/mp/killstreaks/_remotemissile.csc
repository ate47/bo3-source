#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace remotemissile;

// Namespace remotemissile
// Params 0, eflags: 0x2
// Checksum 0xd9bf0b73, Offset: 0x1f8
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("remotemissile", &__init__, undefined, undefined);
}

// Namespace remotemissile
// Params 0, eflags: 0x0
// Checksum 0x441642c6, Offset: 0x230
// Size: 0x72
function __init__() {
    clientfield::register("missile", "remote_missile_bomblet_fired", 1, 1, "int", &bomblets_deployed, 0, 0);
    clientfield::register("missile", "remote_missile_fired", 1, 2, "int", &missile_fired, 0, 0);
}

// Namespace remotemissile
// Params 7, eflags: 0x0
// Checksum 0x58572ee7, Offset: 0x2b0
// Size: 0x232
function missile_fired(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        player = getlocalplayer(localclientnum);
        owner = self getowner(localclientnum);
        clientobjid = util::getnextobjid(localclientnum);
        objective_add(localclientnum, clientobjid, "invisible", self.origin, self.team, owner);
        objective_onentity(localclientnum, clientobjid, self, 1, 0, 1);
        self.hellfireobjid = clientobjid;
        self thread destruction_watcher(localclientnum, clientobjid);
        objective_state(localclientnum, clientobjid, "active");
        if (player hasperk(localclientnum, "specialty_showenemyequipment") || self.team == player.team) {
            objective_seticon(localclientnum, clientobjid, "remotemissile_target");
            objective_seticonsize(localclientnum, clientobjid, 50);
        }
        self thread hud_update(localclientnum);
    } else if (newval == 2) {
        if (isdefined(self.hellfireobjid)) {
            self notify(#"hellfire_detonated");
            objective_delete(localclientnum, self.hellfireobjid);
            util::releaseobjid(localclientnum, self.hellfireobjid);
        }
    } else {
        self notify(#"cleanup_objectives");
    }
    ammo_ui_data_model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.ammo");
    if (isdefined(ammo_ui_data_model)) {
        setuimodelvalue(ammo_ui_data_model, 1);
    }
}

// Namespace remotemissile
// Params 7, eflags: 0x0
// Checksum 0x95a67891, Offset: 0x4f0
// Size: 0x1ba
function bomblets_deployed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (bnewent && oldval == newval) {
        return;
    }
    if (newval == 1) {
        player = getlocalplayer(localclientnum);
        owner = self getowner(localclientnum);
        clientobjid = util::getnextobjid(localclientnum);
        objective_add(localclientnum, clientobjid, "invisible", self.origin, self.team, owner);
        objective_onentity(localclientnum, clientobjid, self, 1, 0, 1);
        self thread destruction_watcher(localclientnum, clientobjid);
        objective_state(localclientnum, clientobjid, "active");
        if (player hasperk(localclientnum, "specialty_showenemyequipment") || player.team == self.team) {
            objective_seticon(localclientnum, clientobjid, "remotemissile_target");
        }
    } else {
        self notify(#"cleanup_objectives");
    }
    ammo_ui_data_model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.ammo");
    if (isdefined(ammo_ui_data_model)) {
        setuimodelvalue(ammo_ui_data_model, 0);
    }
}

// Namespace remotemissile
// Params 2, eflags: 0x0
// Checksum 0xa4820a3a, Offset: 0x6b8
// Size: 0x6a
function destruction_watcher(localclientnum, clientobjid) {
    self util::waittill_any("death", "entityshutdown", "cleanup_objectives");
    wait 0.1;
    if (isdefined(clientobjid)) {
        objective_delete(localclientnum, clientobjid);
        util::releaseobjid(localclientnum, clientobjid);
    }
}

// Namespace remotemissile
// Params 1, eflags: 0x0
// Checksum 0x3f5da067, Offset: 0x730
// Size: 0x15d
function hud_update(localclientnum) {
    self endon(#"entityshutdown");
    self notify(#"remote_missile_singeton");
    self endon(#"remote_missile_singeton");
    missile = self;
    altitude_ui_data_model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.altitude");
    speed_ui_data_model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.speed");
    if (!isdefined(altitude_ui_data_model) || !isdefined(speed_ui_data_model)) {
        return;
    }
    prev_z = missile.origin[2];
    fps = 20;
    delay = 1 / fps;
    while (true) {
        cur_z = missile.origin[2];
        setuimodelvalue(altitude_ui_data_model, cur_z);
        dist = (prev_z - cur_z) * fps;
        val = dist / 17.6;
        setuimodelvalue(speed_ui_data_model, val);
        prev_z = cur_z;
        wait delay;
    }
}

