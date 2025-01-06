#using scripts/codescripts/struct;
#using scripts/mp/_shoutcaster;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/util_shared;

#namespace escort;

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x1919e906, Offset: 0x1d8
// Size: 0x5a
function main() {
    clientfield::register("actor", "robot_state", 1, 2, "int", &function_76a7d70, 0, 1);
    callback::on_localclient_connect(&on_localclient_connect);
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x240
// Size: 0x2
function onprecachegametype() {
    
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x250
// Size: 0x2
function onstartgametype() {
    
}

// Namespace escort
// Params 1, eflags: 0x0
// Checksum 0xda2500f6, Offset: 0x260
// Size: 0xda
function on_localclient_connect(localclientnum) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.robotStatusText"), %MPUI_ESCORT_ROBOT_MOVING);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.robotStatusVisible"), 0);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.enemyRobot"), 0);
    level wait_team_changed(localclientnum);
}

// Namespace escort
// Params 7, eflags: 0x0
// Checksum 0x6427dee1, Offset: 0x348
// Size: 0x132
function function_76a7d70(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (bnewent) {
        if (!isdefined(level.escortrobots)) {
            level.escortrobots = [];
        } else if (!isarray(level.escortrobots)) {
            level.escortrobots = array(level.escortrobots);
        }
        level.escortrobots[level.escortrobots.size] = self;
        self thread update_robot_team(localclientnum);
    }
    if (newval == 1) {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.robotStatusVisible"), 1);
        return;
    }
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.robotStatusVisible"), 0);
}

// Namespace escort
// Params 1, eflags: 0x0
// Checksum 0x67466c7, Offset: 0x488
// Size: 0xaf
function wait_team_changed(localclientnum) {
    while (true) {
        level waittill(#"team_changed");
        while (!isdefined(getnonpredictedlocalplayer(localclientnum))) {
            wait 0.05;
        }
        if (!isdefined(level.escortrobots)) {
            continue;
        }
        foreach (robot in level.escortrobots) {
            robot thread update_robot_team(localclientnum);
        }
    }
}

// Namespace escort
// Params 1, eflags: 0x0
// Checksum 0xc8c9a9d3, Offset: 0x540
// Size: 0x132
function update_robot_team(localclientnum) {
    localplayerteam = getlocalplayerteam(localclientnum);
    if (shoutcaster::is_shoutcaster(localclientnum)) {
        friendly = self shoutcaster::is_friendly(localclientnum);
    } else {
        friend = self.team == localplayerteam;
    }
    if (friend) {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.enemyRobot"), 0);
    } else {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "escortGametype.enemyRobot"), 1);
    }
    self duplicate_render::set_dr_flag("enemyvehicle_fb", !friend);
    localplayer = getlocalplayer(localclientnum);
    localplayer duplicate_render::update_dr_filters(localclientnum);
}

