#using scripts/codescripts/struct;
#using scripts/shared/exploder_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/sound_shared;
#using scripts/zm/_util;

#namespace fx;

/#

    // Namespace fx
    // Params 4, eflags: 0x0
    // Checksum 0x692da508, Offset: 0x110
    // Size: 0x184
    function print_org(fxcommand, fxid, fxpos, waittime) {
        if (getdvarstring("<dev string:x28>") == "<dev string:x2e>") {
            println("<dev string:x30>");
            println("<dev string:x32>" + fxpos[0] + "<dev string:x3d>" + fxpos[1] + "<dev string:x3d>" + fxpos[2] + "<dev string:x3f>");
            println("<dev string:x41>");
            println("<dev string:x5c>");
            println("<dev string:x69>" + fxcommand + "<dev string:x3f>");
            println("<dev string:x7e>" + fxid + "<dev string:x3f>");
            println("<dev string:x8e>" + waittime + "<dev string:x3f>");
            println("<dev string:x9f>");
        }
    }

#/

// Namespace fx
// Params 8, eflags: 0x0
// Checksum 0x78a02089, Offset: 0x2a0
// Size: 0x74
function gunfireloopfx(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
    thread gunfireloopfxthread(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax);
}

// Namespace fx
// Params 8, eflags: 0x0
// Checksum 0x57640d33, Offset: 0x320
// Size: 0x232
function gunfireloopfxthread(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
    level endon(#"hash_ce9de5d2");
    wait 0.05;
    if (betweensetsmax < betweensetsmin) {
        temp = betweensetsmax;
        betweensetsmax = betweensetsmin;
        betweensetsmin = temp;
    }
    betweensetsbase = betweensetsmin;
    betweensetsrange = betweensetsmax - betweensetsmin;
    if (shotdelaymax < shotdelaymin) {
        temp = shotdelaymax;
        shotdelaymax = shotdelaymin;
        shotdelaymin = temp;
    }
    shotdelaybase = shotdelaymin;
    shotdelayrange = shotdelaymax - shotdelaymin;
    if (shotsmax < shotsmin) {
        temp = shotsmax;
        shotsmax = shotsmin;
        shotsmin = temp;
    }
    shotsbase = shotsmin;
    shotsrange = shotsmax - shotsmin;
    fxent = spawnfx(level._effect[fxid], fxpos);
    for (;;) {
        shotnum = shotsbase + randomint(shotsrange);
        for (i = 0; i < shotnum; i++) {
            triggerfx(fxent);
            wait shotdelaybase + randomfloat(shotdelayrange);
        }
        wait betweensetsbase + randomfloat(betweensetsrange);
    }
}

// Namespace fx
// Params 9, eflags: 0x0
// Checksum 0x7261cb9c, Offset: 0x560
// Size: 0x84
function gunfireloopfxvec(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
    thread gunfireloopfxvecthread(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax);
}

// Namespace fx
// Params 9, eflags: 0x0
// Checksum 0x53e758c6, Offset: 0x5f0
// Size: 0x2d2
function gunfireloopfxvecthread(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax) {
    level endon(#"hash_ce9de5d2");
    wait 0.05;
    if (betweensetsmax < betweensetsmin) {
        temp = betweensetsmax;
        betweensetsmax = betweensetsmin;
        betweensetsmin = temp;
    }
    betweensetsbase = betweensetsmin;
    betweensetsrange = betweensetsmax - betweensetsmin;
    if (shotdelaymax < shotdelaymin) {
        temp = shotdelaymax;
        shotdelaymax = shotdelaymin;
        shotdelaymin = temp;
    }
    shotdelaybase = shotdelaymin;
    shotdelayrange = shotdelaymax - shotdelaymin;
    if (shotsmax < shotsmin) {
        temp = shotsmax;
        shotsmax = shotsmin;
        shotsmin = temp;
    }
    shotsbase = shotsmin;
    shotsrange = shotsmax - shotsmin;
    fxpos2 = vectornormalize(fxpos2 - fxpos);
    fxent = spawnfx(level._effect[fxid], fxpos, fxpos2);
    for (;;) {
        shotnum = shotsbase + randomint(shotsrange);
        for (i = 0; i < int(shotnum / level.fxfireloopmod); i++) {
            triggerfx(fxent);
            delay = (shotdelaybase + randomfloat(shotdelayrange)) * level.fxfireloopmod;
            if (delay < 0.05) {
                delay = 0.05;
            }
            wait delay;
        }
        wait shotdelaybase + randomfloat(shotdelayrange);
        wait betweensetsbase + randomfloat(betweensetsrange);
    }
}

// Namespace fx
// Params 1, eflags: 0x0
// Checksum 0xd996a8c1, Offset: 0x8d0
// Size: 0x5c
function grenadeexplosionfx(pos) {
    playfx(level._effect["mechanical explosion"], pos);
    earthquake(0.15, 0.5, pos, -6);
}

