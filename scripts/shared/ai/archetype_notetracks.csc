#using scripts/shared/util_shared;
#using scripts/shared/ai_shared;

#namespace notetracks;

// Namespace notetracks
// Params 0, eflags: 0x2
// Checksum 0xc0d60468, Offset: 0x138
// Size: 0x8c
function main() {
    if (sessionmodeiszombiesgame() && getdvarint("splitscreen_playerCount") > 2) {
        return;
    }
    if (sessionmodeiscampaigndeadopsgame() && getdvarint("splitscreen_playerCount") > 2) {
        return;
    }
    ai::add_ai_spawn_function(&initializenotetrackhandlers);
}

// Namespace notetracks
// Params 1, eflags: 0x5 linked
// Checksum 0xcb1d4e7f, Offset: 0x1d0
// Size: 0x84
function initializenotetrackhandlers(localclientnum) {
    addsurfacenotetrackfxhandler(localclientnum, "jumping", "surfacefxtable_jumping");
    addsurfacenotetrackfxhandler(localclientnum, "landing", "surfacefxtable_landing");
    addsurfacenotetrackfxhandler(localclientnum, "vtol_landing", "surfacefxtable_vtollanding");
}

// Namespace notetracks
// Params 3, eflags: 0x5 linked
// Checksum 0xad88a276, Offset: 0x260
// Size: 0x4c
function addsurfacenotetrackfxhandler(localclientnum, notetrack, surfacetable) {
    entity = self;
    entity thread handlesurfacenotetrackfx(localclientnum, notetrack, surfacetable);
}

// Namespace notetracks
// Params 3, eflags: 0x5 linked
// Checksum 0xafa940e2, Offset: 0x2b8
// Size: 0xb0
function handlesurfacenotetrackfx(localclientnum, notetrack, surfacetable) {
    entity = self;
    entity endon(#"entityshutdown");
    while (true) {
        entity waittill(notetrack);
        fxname = entity getaifxname(localclientnum, surfacetable);
        if (isdefined(fxname)) {
            playfx(localclientnum, fxname, entity.origin);
        }
    }
}

