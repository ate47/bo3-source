#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_f040981e;

// Namespace namespace_f040981e
// Params 0, eflags: 0x2
// Checksum 0x5d2a0d9f, Offset: 0x3a0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_flashback", &__init__, undefined, undefined);
}

// Namespace namespace_f040981e
// Params 0, eflags: 0x1 linked
// Checksum 0x5d4d7917, Offset: 0x3e0
// Size: 0x144
function __init__() {
    clientfield::register("scriptmover", "flashback_trail_fx", 1, 1, "int", &function_e7b19c85, 0, 0);
    clientfield::register("playercorpse", "flashback_clone", 1, 1, "int", &function_20ec14bf, 0, 0);
    clientfield::register("allplayers", "flashback_activated", 1, 1, "int", &function_ed3d7194, 0, 0);
    visionset_mgr::register_overlay_info_style_postfx_bundle("flashback_warp", 1, 1, "pstfx_flashback_warp", 0.8);
    duplicate_render::set_dr_filter_framebuffer("flashback", 90, "flashback_on", "", 0, "mc/mtl_glitch", 0);
}

// Namespace namespace_f040981e
// Params 7, eflags: 0x1 linked
// Checksum 0x271cc57e, Offset: 0x530
// Size: 0x134
function function_ed3d7194(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_312e8bbc");
    player = getlocalplayer(localclientnum);
    isfirstperson = !isthirdperson(localclientnum) && player == self;
    if (newval) {
        if (isfirstperson) {
            self playsound(localclientnum, "mpl_flashback_reappear_plr");
            return;
        }
        self endon(#"entityshutdown");
        self util::waittill_dobj(localclientnum);
        self playsound(localclientnum, "mpl_flashback_reappear_npc");
        playtagfxset(localclientnum, "gadget_flashback_3p_off", self);
    }
}

// Namespace namespace_f040981e
// Params 7, eflags: 0x1 linked
// Checksum 0x293d556b, Offset: 0x670
// Size: 0x174
function function_e7b19c85(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    isfirstperson = !isthirdperson(localclientnum) && isdefined(self.owner) && isdefined(player) && self.owner == player;
    if (newval) {
        if (isfirstperson) {
            player playsound(localclientnum, "mpl_flashback_disappear_plr");
            return;
        }
        self endon(#"entityshutdown");
        self util::waittill_dobj(localclientnum);
        self playsound(localclientnum, "mpl_flashback_disappear_npc");
        playfxontag(localclientnum, "player/fx_plyr_flashback_demat", self, "tag_origin");
        playfxontag(localclientnum, "player/fx_plyr_flashback_trail", self, "tag_origin");
    }
}

// Namespace namespace_f040981e
// Params 7, eflags: 0x1 linked
// Checksum 0xd2c1efea, Offset: 0x7f0
// Size: 0x64
function function_20ec14bf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_846f9a6e(localclientnum, newval);
    }
}

// Namespace namespace_f040981e
// Params 1, eflags: 0x1 linked
// Checksum 0xd789a522, Offset: 0x860
// Size: 0x13c
function function_ed40d5dd(localclientnum) {
    self endon(#"entityshutdown");
    starttime = getservertime(localclientnum);
    while (true) {
        currenttime = getservertime(localclientnum);
        elapsedtime = currenttime - starttime;
        elapsedtime = float(elapsedtime / 1000);
        if (elapsedtime < 1) {
            amount = 1 - elapsedtime / 1;
            self mapshaderconstant(localclientnum, 0, "scriptVector3", 1, 1, 0, amount);
        } else {
            self mapshaderconstant(localclientnum, 0, "scriptVector3", 1, 1, 0, 0);
            break;
        }
        wait(0.016);
    }
}

// Namespace namespace_f040981e
// Params 2, eflags: 0x1 linked
// Checksum 0x35d10ce2, Offset: 0x9a8
// Size: 0x6c
function function_846f9a6e(localclientnum, var_57594972) {
    if (var_57594972) {
        self duplicate_render::set_dr_flag("flashback_on", 1);
        self duplicate_render::update_dr_filters(localclientnum);
        self function_ed40d5dd(localclientnum);
    }
}

