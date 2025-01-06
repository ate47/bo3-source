#using scripts/codescripts/struct;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/hud_util_shared;

#namespace hostmigration;

// Namespace hostmigration
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x100
// Size: 0x2
function callback_hostmigrationsave() {
    
}

// Namespace hostmigration
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x110
// Size: 0x2
function callback_prehostmigrationsave() {
    
}

// Namespace hostmigration
// Params 0, eflags: 0x0
// Checksum 0x164940af, Offset: 0x120
// Size: 0x15b
function callback_hostmigration() {
    setslowmotion(1, 1, 0);
    level.hostmigrationreturnedplayercount = 0;
    if (level.inprematchperiod) {
        level waittill(#"prematch_over");
    }
    if (level.gameended) {
        println("<dev string:x28>" + gettime() + "<dev string:x44>");
        return;
    }
    println("<dev string:x28>" + gettime());
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
    println("<dev string:x6b>" + gettime());
    recordmatchbegin();
    level notify(#"host_migration_end");
}

