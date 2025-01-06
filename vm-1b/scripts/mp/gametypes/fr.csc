#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace fr;

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x87e119b2, Offset: 0x300
// Size: 0x28a
function main() {
    callback::on_localclient_connect(&on_player_connect);
    clientfield::register("world", "freerun_state", 1, 3, "int", &function_16cab10f, 0, 0);
    clientfield::register("world", "freerun_retries", 1, 16, "int", &function_c6ce0f39, 0, 0);
    clientfield::register("world", "freerun_faults", 1, 16, "int", &function_ad9d02, 0, 0);
    clientfield::register("world", "freerun_startTime", 1, 31, "int", &function_9214001e, 0, 0);
    clientfield::register("world", "freerun_finishTime", 1, 31, "int", &function_aa7f64c1, 0, 0);
    clientfield::register("world", "freerun_bestTime", 1, 31, "int", &function_5c60cddc, 0, 0);
    clientfield::register("world", "freerun_timeAdjustment", 1, 31, "int", &function_ac5d4a6d, 0, 0);
    clientfield::register("world", "freerun_timeAdjustmentNegative", 1, 1, "int", &function_7b5865b4, 0, 0);
    clientfield::register("world", "freerun_bulletPenalty", 1, 16, "int", &function_d069a1b6, 0, 0);
    clientfield::register("world", "freerun_pausedTime", 1, 31, "int", &function_497cebcc, 0, 0);
    clientfield::register("world", "freerun_checkpointIndex", 1, 7, "int", &function_7d2b77a9, 0, 0);
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0x61343e72, Offset: 0x598
// Size: 0x2a
function on_player_connect(localclientnum) {
    allowactionslotinput(localclientnum);
    allowscoreboard(localclientnum, 0);
}

// Namespace fr
// Params 7, eflags: 0x0
// Checksum 0x10382d2e, Offset: 0x5d0
// Size: 0x8a
function function_16cab10f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    var_bcd4b057 = createuimodel(controllermodel, "FreeRun.runState");
    setuimodelvalue(var_bcd4b057, newval);
}

// Namespace fr
// Params 7, eflags: 0x0
// Checksum 0x87923ff2, Offset: 0x668
// Size: 0x8a
function function_c6ce0f39(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    var_d3f176c = createuimodel(controllermodel, "FreeRun.freeRunInfo.retries");
    setuimodelvalue(var_d3f176c, newval);
}

// Namespace fr
// Params 7, eflags: 0x0
// Checksum 0xc22da423, Offset: 0x700
// Size: 0x8a
function function_ad9d02(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    var_abdc79a1 = createuimodel(controllermodel, "FreeRun.freeRunInfo.faults");
    setuimodelvalue(var_abdc79a1, newval);
}

// Namespace fr
// Params 7, eflags: 0x0
// Checksum 0x57d6e588, Offset: 0x798
// Size: 0x8a
function function_9214001e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    model = createuimodel(controllermodel, "FreeRun.startTime");
    setuimodelvalue(model, newval);
}

// Namespace fr
// Params 7, eflags: 0x0
// Checksum 0x2cc1354b, Offset: 0x830
// Size: 0x8a
function function_aa7f64c1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    model = createuimodel(controllermodel, "FreeRun.finishTime");
    setuimodelvalue(model, newval);
}

// Namespace fr
// Params 7, eflags: 0x0
// Checksum 0xb6b154be, Offset: 0x8c8
// Size: 0x8a
function function_5c60cddc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    model = createuimodel(controllermodel, "FreeRun.freeRunInfo.bestTime");
    setuimodelvalue(model, newval);
}

// Namespace fr
// Params 7, eflags: 0x0
// Checksum 0x5c47f878, Offset: 0x960
// Size: 0x8a
function function_ac5d4a6d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    model = createuimodel(controllermodel, "FreeRun.timer.timeAdjustment");
    setuimodelvalue(model, newval);
}

// Namespace fr
// Params 7, eflags: 0x0
// Checksum 0x229d5939, Offset: 0x9f8
// Size: 0x8a
function function_7b5865b4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    model = createuimodel(controllermodel, "FreeRun.timer.timeAdjustmentNegative");
    setuimodelvalue(model, newval);
}

// Namespace fr
// Params 7, eflags: 0x0
// Checksum 0x2d8c8aca, Offset: 0xa90
// Size: 0x8a
function function_d069a1b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    var_46020d17 = createuimodel(controllermodel, "FreeRun.freeRunInfo.bulletPenalty");
    setuimodelvalue(var_46020d17, newval);
}

// Namespace fr
// Params 7, eflags: 0x0
// Checksum 0x990c933, Offset: 0xb28
// Size: 0x8a
function function_497cebcc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    model = createuimodel(controllermodel, "FreeRun.pausedTime");
    setuimodelvalue(model, newval);
}

// Namespace fr
// Params 7, eflags: 0x0
// Checksum 0x7e3792c6, Offset: 0xbc0
// Size: 0x8a
function function_7d2b77a9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    model = createuimodel(controllermodel, "FreeRun.freeRunInfo.activeCheckpoint");
    setuimodelvalue(model, newval);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xc58
// Size: 0x2
function onprecachegametype() {
    
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xc68
// Size: 0x2
function onstartgametype() {
    
}

