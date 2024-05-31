#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/_util;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace killstreak_hacking;

// Namespace killstreak_hacking
// Params 3, eflags: 0x1 linked
// Checksum 0x9a316672, Offset: 0x218
// Size: 0x1f0
function enable_hacking(killstreakname, prehackfunction, posthackfunction) {
    killstreak = self;
    level.challenge_scorestreaksenabled = 1;
    killstreak.challenge_isscorestreak = 1;
    killstreak.killstreak_hackedcallback = &_hacked_callback;
    killstreak.killstreakprehackfunction = prehackfunction;
    killstreak.killstreakposthackfunction = posthackfunction;
    killstreak.hackertoolinnertimems = killstreak killstreak_bundles::get_hack_tool_inner_time();
    killstreak.hackertooloutertimems = killstreak killstreak_bundles::get_hack_tool_outer_time();
    killstreak.hackertoolinnerradius = killstreak killstreak_bundles::get_hack_tool_inner_radius();
    killstreak.hackertoolouterradius = killstreak killstreak_bundles::get_hack_tool_outer_radius();
    killstreak.hackertoolradius = killstreak.hackertoolouterradius;
    killstreak.killstreakhackloopfx = killstreak killstreak_bundles::get_hack_loop_fx();
    killstreak.killstreakhackfx = killstreak killstreak_bundles::get_hack_fx();
    killstreak.killstreakhackscoreevent = killstreak killstreak_bundles::get_hack_scoreevent();
    killstreak.killstreakhacklostlineofsightlimitms = killstreak killstreak_bundles::get_lost_line_of_sight_limit_msec();
    killstreak.killstreakhacklostlineofsighttimems = killstreak killstreak_bundles::get_hack_tool_no_line_of_sight_time();
    killstreak.killstreak_hackedprotection = killstreak killstreak_bundles::get_hack_protection();
}

// Namespace killstreak_hacking
// Params 0, eflags: 0x0
// Checksum 0x80672ed6, Offset: 0x410
// Size: 0x22
function disable_hacking() {
    killstreak = self;
    killstreak.killstreak_hackedcallback = undefined;
}

// Namespace killstreak_hacking
// Params 0, eflags: 0x1 linked
// Checksum 0x9f1cc764, Offset: 0x440
// Size: 0x6c
function hackerfx() {
    killstreak = self;
    if (isdefined(killstreak.killstreakhackfx) && killstreak.killstreakhackfx != "") {
        playfxontag(killstreak.killstreakhackfx, killstreak, "tag_origin");
    }
}

// Namespace killstreak_hacking
// Params 0, eflags: 0x1 linked
// Checksum 0x9ea8bc02, Offset: 0x4b8
// Size: 0x6c
function hackerloopfx() {
    killstreak = self;
    if (isdefined(killstreak.killstreakloophackfx) && killstreak.killstreakloophackfx != "") {
        playfxontag(killstreak.killstreakloophackfx, killstreak, "tag_origin");
    }
}

// Namespace killstreak_hacking
// Params 1, eflags: 0x5 linked
// Checksum 0x287bdd31, Offset: 0x530
// Size: 0x1e4
function private _hacked_callback(hacker) {
    killstreak = self;
    originalowner = killstreak.owner;
    if (isdefined(killstreak.killstreakhackscoreevent)) {
        scoreevents::processscoreevent(killstreak.killstreakhackscoreevent, hacker, originalowner, level.weaponhackertool);
    }
    if (isdefined(killstreak.killstreakprehackfunction)) {
        killstreak thread [[ killstreak.killstreakprehackfunction ]](hacker);
    }
    killstreak killstreaks::configure_team_internal(hacker, 1);
    killstreak clientfield::set("enemyvehicle", 2);
    if (isdefined(killstreak.killstreakhackfx)) {
        killstreak thread hackerfx();
    }
    if (isdefined(killstreak.killstreakhackloopfx)) {
        killstreak thread hackerloopfx();
    }
    if (isdefined(killstreak.killstreakposthackfunction)) {
        killstreak thread [[ killstreak.killstreakposthackfunction ]](hacker);
    }
    killstreaktype = killstreak.killstreaktype;
    if (isdefined(killstreak.hackedkillstreakref)) {
        killstreaktype = killstreak.hackedkillstreakref;
    }
    level thread popups::displaykillstreakhackedteammessagetoall(killstreaktype, hacker);
    killstreak _update_health(hacker);
}

// Namespace killstreak_hacking
// Params 1, eflags: 0x0
// Checksum 0x98e3cb3c, Offset: 0x720
// Size: 0x30
function override_hacked_killstreak_reference(killstreakref) {
    killstreak = self;
    killstreak.hackedkillstreakref = killstreakref;
}

// Namespace killstreak_hacking
// Params 0, eflags: 0x1 linked
// Checksum 0x19ecf789, Offset: 0x758
// Size: 0x98
function get_hacked_timeout_duration_ms() {
    killstreak = self;
    timeout = killstreak killstreak_bundles::get_hack_timeout();
    if (!isdefined(timeout) || timeout <= 0) {
        assertmsg("<unknown string>" + killstreak.killstreaktype + "<unknown string>");
        return;
    }
    return timeout * 1000;
}

// Namespace killstreak_hacking
// Params 2, eflags: 0x1 linked
// Checksum 0x74ad9713, Offset: 0x7f8
// Size: 0x6a
function set_vehicle_drivable_time_starting_now(killstreak, duration_ms) {
    if (!isdefined(duration_ms)) {
        duration_ms = -1;
    }
    if (duration_ms == -1) {
        duration_ms = killstreak get_hacked_timeout_duration_ms();
    }
    return self vehicle::set_vehicle_drivable_time_starting_now(duration_ms);
}

// Namespace killstreak_hacking
// Params 1, eflags: 0x1 linked
// Checksum 0x11725507, Offset: 0x870
// Size: 0xec
function _update_health(hacker) {
    killstreak = self;
    if (isdefined(killstreak.hackedhealthupdatecallback)) {
        killstreak [[ killstreak.hackedhealthupdatecallback ]](hacker);
        return;
    }
    if (issentient(killstreak)) {
        hackedhealth = killstreak_bundles::get_hacked_health(killstreak.killstreaktype);
        assert(isdefined(hackedhealth));
        if (self.health > hackedhealth) {
            self.health = hackedhealth;
        }
        return;
    }
    /#
        hacker iprintlnbold("<unknown string>");
    #/
}

/#

    // Namespace killstreak_hacking
    // Params 0, eflags: 0x1 linked
    // Checksum 0x620fb7d2, Offset: 0x968
    // Size: 0x28
    function killstreak_switch_team_end() {
        killstreakentity = self;
        killstreakentity notify(#"killstreak_switch_team_end");
    }

    // Namespace killstreak_hacking
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe90c2a8d, Offset: 0x998
    // Size: 0x202
    function killstreak_switch_team(owner) {
        killstreakentity = self;
        killstreakentity notify(#"killstreak_switch_team_singleton");
        killstreakentity endon(#"killstreak_switch_team_singleton");
        killstreakentity endon(#"death");
        setdvar("<unknown string>", "<unknown string>");
        while (true) {
            wait(0.5);
            devgui_int = getdvarint("<unknown string>");
            if (devgui_int != 0) {
                team = "<unknown string>";
                if (isdefined(level.getenemyteam) && isdefined(owner) && isdefined(owner.team)) {
                    team = [[ level.getenemyteam ]](owner.team);
                }
                if (isdefined(level.devongetormakebot)) {
                    player = [[ level.devongetormakebot ]](team);
                }
                if (!isdefined(player)) {
                    println("<unknown string>");
                    wait(1);
                    continue;
                }
                if (!isdefined(killstreakentity.killstreak_hackedcallback)) {
                    /#
                        iprintlnbold("<unknown string>");
                    #/
                    return;
                }
                killstreakentity notify(#"killstreak_hacked", player);
                killstreakentity.previouslyhacked = 1;
                killstreakentity [[ killstreakentity.killstreak_hackedcallback ]](player);
                wait(0.5);
                setdvar("<unknown string>", "<unknown string>");
                return;
            }
        }
    }

#/
