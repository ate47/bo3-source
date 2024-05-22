#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace fr;

// Namespace fr
// Params 0, eflags: 0x1 linked
// Checksum 0xbb534e6e, Offset: 0x300
// Size: 0x33c
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
// Params 1, eflags: 0x1 linked
// Checksum 0x55fec4ee, Offset: 0x648
// Size: 0x3c
function on_player_connect(localclientnum) {
    allowactionslotinput(localclientnum);
    allowscoreboard(localclientnum, 0);
}

// Namespace fr
// Params 7, eflags: 0x1 linked
// Checksum 0xeba1747b, Offset: 0x690
// Size: 0xa4
function function_16cab10f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    var_bcd4b057 = createuimodel(controllermodel, "FreeRun.runState");
    setuimodelvalue(var_bcd4b057, newval);
}

// Namespace fr
// Params 7, eflags: 0x1 linked
// Checksum 0x3cfa0699, Offset: 0x740
// Size: 0xa4
function function_c6ce0f39(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    var_d3f176c = createuimodel(controllermodel, "FreeRun.freeRunInfo.retries");
    setuimodelvalue(var_d3f176c, newval);
}

// Namespace fr
// Params 7, eflags: 0x1 linked
// Checksum 0x33bf8e3e, Offset: 0x7f0
// Size: 0xa4
function function_ad9d02(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    var_abdc79a1 = createuimodel(controllermodel, "FreeRun.freeRunInfo.faults");
    setuimodelvalue(var_abdc79a1, newval);
}

// Namespace fr
// Params 7, eflags: 0x1 linked
// Checksum 0x6f52fa34, Offset: 0x8a0
// Size: 0xa4
function function_9214001e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    model = createuimodel(controllermodel, "FreeRun.startTime");
    setuimodelvalue(model, newval);
}

// Namespace fr
// Params 7, eflags: 0x1 linked
// Checksum 0xe9c3c603, Offset: 0x950
// Size: 0xa4
function function_aa7f64c1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    model = createuimodel(controllermodel, "FreeRun.finishTime");
    setuimodelvalue(model, newval);
}

// Namespace fr
// Params 7, eflags: 0x1 linked
// Checksum 0x57c0600c, Offset: 0xa00
// Size: 0xa4
function function_5c60cddc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    model = createuimodel(controllermodel, "FreeRun.freeRunInfo.bestTime");
    setuimodelvalue(model, newval);
}

// Namespace fr
// Params 7, eflags: 0x1 linked
// Checksum 0x7b79fe2b, Offset: 0xab0
// Size: 0xa4
function function_ac5d4a6d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    model = createuimodel(controllermodel, "FreeRun.timer.timeAdjustment");
    setuimodelvalue(model, newval);
}

// Namespace fr
// Params 7, eflags: 0x1 linked
// Checksum 0x73db482, Offset: 0xb60
// Size: 0xa4
function function_7b5865b4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    model = createuimodel(controllermodel, "FreeRun.timer.timeAdjustmentNegative");
    setuimodelvalue(model, newval);
}

// Namespace fr
// Params 7, eflags: 0x1 linked
// Checksum 0xa1da69c4, Offset: 0xc10
// Size: 0xa4
function function_d069a1b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    var_46020d17 = createuimodel(controllermodel, "FreeRun.freeRunInfo.bulletPenalty");
    setuimodelvalue(var_46020d17, newval);
}

// Namespace fr
// Params 7, eflags: 0x1 linked
// Checksum 0xe5dcc027, Offset: 0xcc0
// Size: 0xa4
function function_497cebcc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    model = createuimodel(controllermodel, "FreeRun.pausedTime");
    setuimodelvalue(model, newval);
}

// Namespace fr
// Params 7, eflags: 0x1 linked
// Checksum 0x59a4b026, Offset: 0xd70
// Size: 0xa4
function function_7d2b77a9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    controllermodel = getuimodelforcontroller(localclientnum);
    model = createuimodel(controllermodel, "FreeRun.freeRunInfo.activeCheckpoint");
    setuimodelvalue(model, newval);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0xe20
// Size: 0x4
function onprecachegametype() {
    
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0xe30
// Size: 0x4
function onstartgametype() {
    
}

