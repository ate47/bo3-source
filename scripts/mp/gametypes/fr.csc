#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace fr;

// Namespace fr
// Params 0
// Checksum 0xbb534e6e, Offset: 0x300
// Size: 0x33c
function main()
{
    callback::on_localclient_connect( &on_player_connect );
    clientfield::register( "world", "freerun_state", 1, 3, "int", &freerunstatechanged, 0, 0 );
    clientfield::register( "world", "freerun_retries", 1, 16, "int", &freerunretriesupdated, 0, 0 );
    clientfield::register( "world", "freerun_faults", 1, 16, "int", &freerunfaultsupdated, 0, 0 );
    clientfield::register( "world", "freerun_startTime", 1, 31, "int", &freerunstarttimeupdated, 0, 0 );
    clientfield::register( "world", "freerun_finishTime", 1, 31, "int", &freerunfinishtimeupdated, 0, 0 );
    clientfield::register( "world", "freerun_bestTime", 1, 31, "int", &freerunbesttimeupdated, 0, 0 );
    clientfield::register( "world", "freerun_timeAdjustment", 1, 31, "int", &freeruntimeadjustmentupdated, 0, 0 );
    clientfield::register( "world", "freerun_timeAdjustmentNegative", 1, 1, "int", &freeruntimeadjustmentsignupdated, 0, 0 );
    clientfield::register( "world", "freerun_bulletPenalty", 1, 16, "int", &freerunbulletpenaltyupdated, 0, 0 );
    clientfield::register( "world", "freerun_pausedTime", 1, 31, "int", &freerunpausedtimeupdated, 0, 0 );
    clientfield::register( "world", "freerun_checkpointIndex", 1, 7, "int", &freeruncheckpointupdated, 0, 0 );
}

// Namespace fr
// Params 1
// Checksum 0x55fec4ee, Offset: 0x648
// Size: 0x3c
function on_player_connect( localclientnum )
{
    allowactionslotinput( localclientnum );
    allowscoreboard( localclientnum, 0 );
}

// Namespace fr
// Params 7
// Checksum 0xeba1747b, Offset: 0x690
// Size: 0xa4
function freerunstatechanged( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    controllermodel = getuimodelforcontroller( localclientnum );
    statemodel = createuimodel( controllermodel, "FreeRun.runState" );
    setuimodelvalue( statemodel, newval );
}

// Namespace fr
// Params 7
// Checksum 0x3cfa0699, Offset: 0x740
// Size: 0xa4
function freerunretriesupdated( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    controllermodel = getuimodelforcontroller( localclientnum );
    retriesmodel = createuimodel( controllermodel, "FreeRun.freeRunInfo.retries" );
    setuimodelvalue( retriesmodel, newval );
}

// Namespace fr
// Params 7
// Checksum 0x33bf8e3e, Offset: 0x7f0
// Size: 0xa4
function freerunfaultsupdated( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    controllermodel = getuimodelforcontroller( localclientnum );
    faultsmodel = createuimodel( controllermodel, "FreeRun.freeRunInfo.faults" );
    setuimodelvalue( faultsmodel, newval );
}

// Namespace fr
// Params 7
// Checksum 0x6f52fa34, Offset: 0x8a0
// Size: 0xa4
function freerunstarttimeupdated( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    controllermodel = getuimodelforcontroller( localclientnum );
    model = createuimodel( controllermodel, "FreeRun.startTime" );
    setuimodelvalue( model, newval );
}

// Namespace fr
// Params 7
// Checksum 0xe9c3c603, Offset: 0x950
// Size: 0xa4
function freerunfinishtimeupdated( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    controllermodel = getuimodelforcontroller( localclientnum );
    model = createuimodel( controllermodel, "FreeRun.finishTime" );
    setuimodelvalue( model, newval );
}

// Namespace fr
// Params 7
// Checksum 0x57c0600c, Offset: 0xa00
// Size: 0xa4
function freerunbesttimeupdated( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    controllermodel = getuimodelforcontroller( localclientnum );
    model = createuimodel( controllermodel, "FreeRun.freeRunInfo.bestTime" );
    setuimodelvalue( model, newval );
}

// Namespace fr
// Params 7
// Checksum 0x7b79fe2b, Offset: 0xab0
// Size: 0xa4
function freeruntimeadjustmentupdated( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    controllermodel = getuimodelforcontroller( localclientnum );
    model = createuimodel( controllermodel, "FreeRun.timer.timeAdjustment" );
    setuimodelvalue( model, newval );
}

// Namespace fr
// Params 7
// Checksum 0x73db482, Offset: 0xb60
// Size: 0xa4
function freeruntimeadjustmentsignupdated( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    controllermodel = getuimodelforcontroller( localclientnum );
    model = createuimodel( controllermodel, "FreeRun.timer.timeAdjustmentNegative" );
    setuimodelvalue( model, newval );
}

// Namespace fr
// Params 7
// Checksum 0xa1da69c4, Offset: 0xc10
// Size: 0xa4
function freerunbulletpenaltyupdated( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    controllermodel = getuimodelforcontroller( localclientnum );
    bulletpenaltymodel = createuimodel( controllermodel, "FreeRun.freeRunInfo.bulletPenalty" );
    setuimodelvalue( bulletpenaltymodel, newval );
}

// Namespace fr
// Params 7
// Checksum 0xe5dcc027, Offset: 0xcc0
// Size: 0xa4
function freerunpausedtimeupdated( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    controllermodel = getuimodelforcontroller( localclientnum );
    model = createuimodel( controllermodel, "FreeRun.pausedTime" );
    setuimodelvalue( model, newval );
}

// Namespace fr
// Params 7
// Checksum 0x59a4b026, Offset: 0xd70
// Size: 0xa4
function freeruncheckpointupdated( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    controllermodel = getuimodelforcontroller( localclientnum );
    model = createuimodel( controllermodel, "FreeRun.freeRunInfo.activeCheckpoint" );
    setuimodelvalue( model, newval );
}

// Namespace fr
// Params 0
// Checksum 0x99ec1590, Offset: 0xe20
// Size: 0x4
function onprecachegametype()
{
    
}

// Namespace fr
// Params 0
// Checksum 0x99ec1590, Offset: 0xe30
// Size: 0x4
function onstartgametype()
{
    
}

