#using scripts/shared/hud_util_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/codescripts/struct;

#namespace hostmigration;

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x100
// Size: 0x4
function callback_hostmigrationsave() {
    
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x110
// Size: 0x4
function callback_prehostmigrationsave() {
    
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// Checksum 0x715cbd54, Offset: 0x120
// Size: 0x1c2
function callback_hostmigration() {
    setslowmotion(1, 1, 0);
    level.hostmigrationreturnedplayercount = 0;
    if (level.inprematchperiod) {
        level waittill(#"prematch_over");
    }
    if (level.gameended) {
        println("<unknown string>" + gettime() + "<unknown string>");
        return;
    }
    println("<unknown string>" + gettime());
    level.hostmigrationtimer = 1;
    sethostmigrationstatus(1);
    level notify(#"host_migration_begin");
    thread locktimer();
    players = level.players;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        player thread hostmigrationtimerthink();
    }
    level endon(#"host_migration_begin");
    hostmigrationwait();
    level.hostmigrationtimer = undefined;
    sethostmigrationstatus(0);
    println("<unknown string>" + gettime());
    recordmatchbegin();
    level notify(#"host_migration_end");
}

