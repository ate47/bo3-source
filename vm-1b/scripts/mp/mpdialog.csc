#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace mpdialog;

// Namespace mpdialog
// Params 0, eflags: 0x2
// Checksum 0xcccf12af, Offset: 0x2d8
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("mpdialog", &__init__, undefined, undefined);
}

// Namespace mpdialog
// Params 0, eflags: 0x0
// Checksum 0x4cc3113b, Offset: 0x310
// Size: 0x16a
function __init__() {
    level.mpboostresponse = [];
    level.mpboostresponse["assassin"] = "Spectre";
    level.mpboostresponse["grenadier"] = "Grenadier";
    level.mpboostresponse["outrider"] = "Outrider";
    level.mpboostresponse["prophet"] = "Technomancer";
    level.mpboostresponse["pyro"] = "Firebreak";
    level.mpboostresponse["reaper"] = "Reaper";
    level.mpboostresponse["ruin"] = "Mercenary";
    level.mpboostresponse["seraph"] = "Enforcer";
    level.mpboostresponse["trapper"] = "Trapper";
    level.clientvoicesetup = &client_voice_setup;
    clientfield::register("world", "boost_number", 1, 2, "int", &set_boost_number, 1, 1);
    clientfield::register("allplayers", "play_boost", 1, 2, "int", &play_boost_vox, 1, 0);
}

// Namespace mpdialog
// Params 1, eflags: 0x0
// Checksum 0xc105e1b8, Offset: 0x488
// Size: 0x6a
function client_voice_setup(localclientnum) {
    self thread snipervonotify(localclientnum, "playerbreathinsound", "exertSniperHold");
    self thread snipervonotify(localclientnum, "playerbreathoutsound", "exertSniperExhale");
    self thread snipervonotify(localclientnum, "playerbreathgaspsound", "exertSniperGasp");
}

// Namespace mpdialog
// Params 3, eflags: 0x0
// Checksum 0x1a2816e9, Offset: 0x500
// Size: 0x7d
function snipervonotify(localclientnum, notifystring, dialogkey) {
    self endon(#"entityshutdown");
    for (;;) {
        self waittill(notifystring);
        if (isunderwater(localclientnum)) {
            return;
        }
        dialogalias = self get_player_dialog_alias(dialogkey);
        if (isdefined(dialogalias)) {
            self playsound(0, dialogalias);
        }
    }
}

// Namespace mpdialog
// Params 7, eflags: 0x0
// Checksum 0xd2f88255, Offset: 0x588
// Size: 0x42
function set_boost_number(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.boostnumber = newval;
}

// Namespace mpdialog
// Params 7, eflags: 0x0
// Checksum 0x3e32e74f, Offset: 0x5d8
// Size: 0xfa
function play_boost_vox(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    localplayerteam = getlocalplayerteam(localclientnum);
    entitynumber = self getentitynumber();
    if (newval == 0 || self.team != localplayerteam || level._sndnextsnapshot != "mpl_prematch" || level.booststartentnum === entitynumber || level.boostresponseentnum === entitynumber) {
        return;
    }
    if (newval == 1) {
        level.booststartentnum = entitynumber;
        self thread play_boost_start_vox(localclientnum);
        return;
    }
    if (newval == 2) {
        level.boostresponseentnum = entitynumber;
        self thread play_boost_start_response_vox(localclientnum);
    }
}

// Namespace mpdialog
// Params 1, eflags: 0x0
// Checksum 0x474112ae, Offset: 0x6e0
// Size: 0xf2
function play_boost_start_vox(localclientnum) {
    self endon(#"entityshutdown");
    self endon(#"death");
    wait 2;
    playbackid = self play_dialog("boostStart" + level.boostnumber, localclientnum);
    if (isdefined(playbackid) && playbackid >= 0) {
        while (soundplaying(playbackid)) {
            wait 0.05;
        }
    }
    wait 0.5;
    level.booststartresponse = "boostStartResp" + level.mpboostresponse[self getmpdialogname()] + level.boostnumber;
    if (isdefined(level.boostresponseentnum)) {
        responder = getentbynum(localclientnum, level.boostresponseentnum);
        responder thread play_boost_start_response_vox(localclientnum);
    }
}

// Namespace mpdialog
// Params 1, eflags: 0x0
// Checksum 0x998b952f, Offset: 0x7e0
// Size: 0x62
function play_boost_start_response_vox(localclientnum) {
    self endon(#"entityshutdown");
    self endon(#"death");
    if (!isdefined(level.booststartresponse) || self.team != getlocalplayerteam(localclientnum)) {
        return;
    }
    self play_dialog(level.booststartresponse, localclientnum);
}

// Namespace mpdialog
// Params 2, eflags: 0x0
// Checksum 0x211afc57, Offset: 0x850
// Size: 0x51
function get_commander_dialog_alias(commandername, dialogkey) {
    if (!isdefined(commandername)) {
        return;
    }
    commanderbundle = struct::get_script_bundle("mpdialog_commander", commandername);
    return get_dialog_bundle_alias(commanderbundle, dialogkey);
}

// Namespace mpdialog
// Params 1, eflags: 0x0
// Checksum 0xd4cd17d9, Offset: 0x8b0
// Size: 0x61
function get_player_dialog_alias(dialogkey) {
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return undefined;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    return get_dialog_bundle_alias(playerbundle, dialogkey);
}

// Namespace mpdialog
// Params 2, eflags: 0x0
// Checksum 0xc29c0ae8, Offset: 0x920
// Size: 0x7d
function get_dialog_bundle_alias(dialogbundle, dialogkey) {
    if (!isdefined(dialogbundle) || !isdefined(dialogkey)) {
        return undefined;
    }
    dialogalias = function_e8ef6cb0(dialogbundle, dialogkey);
    if (!isdefined(dialogalias)) {
        return;
    }
    voiceprefix = function_e8ef6cb0(dialogbundle, "voiceprefix");
    if (isdefined(voiceprefix)) {
        dialogalias = voiceprefix + dialogalias;
    }
    return dialogalias;
}

// Namespace mpdialog
// Params 2, eflags: 0x0
// Checksum 0x95dace44, Offset: 0x9a8
// Size: 0x109
function play_dialog(dialogkey, localclientnum) {
    if (!isdefined(dialogkey) || !isdefined(localclientnum)) {
        return -1;
    }
    dialogalias = self get_player_dialog_alias(dialogkey);
    if (!isdefined(dialogalias)) {
        return -1;
    }
    soundpos = (self.origin[0], self.origin[1], self.origin[2] + 60);
    if (!isspectating(localclientnum)) {
        return self playsound(undefined, dialogalias, soundpos);
    }
    voicebox = spawn(localclientnum, self.origin, "script_model");
    self thread update_voice_origin(voicebox);
    voicebox thread delete_after(10);
    return voicebox playsound(undefined, dialogalias, soundpos);
}

// Namespace mpdialog
// Params 1, eflags: 0x0
// Checksum 0x66ef0f42, Offset: 0xac0
// Size: 0x39
function update_voice_origin(voicebox) {
    while (true) {
        wait 0.1;
        if (!isdefined(self) || !isdefined(voicebox)) {
            return;
        }
        voicebox.origin = self.origin;
    }
}

// Namespace mpdialog
// Params 1, eflags: 0x0
// Checksum 0xa31b294c, Offset: 0xb08
// Size: 0x1a
function delete_after(waittime) {
    wait waittime;
    self delete();
}

