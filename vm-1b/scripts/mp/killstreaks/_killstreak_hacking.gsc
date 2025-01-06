#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/clientfield_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace killstreak_hacking;

// Namespace killstreak_hacking
// Params 3, eflags: 0x0
// Checksum 0x6e2765bb, Offset: 0x218
// Size: 0x15a
function enable_hacking(killstreakname, prehackfunction, posthackfunction) {
    killstreak = self;
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
// Checksum 0xa92a11d7, Offset: 0x380
// Size: 0x19
function disable_hacking() {
    killstreak = self;
    killstreak.killstreak_hackedcallback = undefined;
}

// Namespace killstreak_hacking
// Params 0, eflags: 0x0
// Checksum 0x6e64c1bd, Offset: 0x3a8
// Size: 0x52
function hackerfx() {
    killstreak = self;
    if (isdefined(killstreak.killstreakhackfx) && killstreak.killstreakhackfx != "") {
        playfxontag(killstreak.killstreakhackfx, killstreak, "tag_origin");
    }
}

// Namespace killstreak_hacking
// Params 0, eflags: 0x0
// Checksum 0x2a32470a, Offset: 0x408
// Size: 0x52
function hackerloopfx() {
    killstreak = self;
    if (isdefined(killstreak.killstreakloophackfx) && killstreak.killstreakloophackfx != "") {
        playfxontag(killstreak.killstreakloophackfx, killstreak, "tag_origin");
    }
}

// Namespace killstreak_hacking
// Params 1, eflags: 0x4
// Checksum 0xd3efb023, Offset: 0x468
// Size: 0x15a
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
// Checksum 0x7ea11fe4, Offset: 0x5d0
// Size: 0x22
function override_hacked_killstreak_reference(killstreakref) {
    killstreak = self;
    killstreak.hackedkillstreakref = killstreakref;
}

// Namespace killstreak_hacking
// Params 0, eflags: 0x0
// Checksum 0xa5ba0b8b, Offset: 0x600
// Size: 0x72
function get_hacked_timeout_duration_ms() {
    killstreak = self;
    timeout = killstreak killstreak_bundles::get_hack_timeout();
    if (!isdefined(timeout) || timeout <= 0) {
        assertmsg("<dev string:x28>" + killstreak.killstreaktype + "<dev string:x50>");
        return;
    }
    return timeout * 1000;
}

// Namespace killstreak_hacking
// Params 2, eflags: 0x0
// Checksum 0x44ae7ad6, Offset: 0x680
// Size: 0x51
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
// Params 1, eflags: 0x0
// Checksum 0xf4ccb3d4, Offset: 0x6e0
// Size: 0xc2
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
        hacker iprintlnbold("<dev string:x87>");
    #/
}

/#

    // Namespace killstreak_hacking
    // Params 0, eflags: 0x0
    // Checksum 0xe2512846, Offset: 0x7b0
    // Size: 0x1c
    function killstreak_switch_team_end() {
        killstreakentity = self;
        killstreakentity notify(#"killstreak_switch_team_end");
    }

    // Namespace killstreak_hacking
    // Params 1, eflags: 0x0
    // Checksum 0x4f2654a1, Offset: 0x7d8
    // Size: 0x18f
    function killstreak_switch_team(owner) {
        killstreakentity = self;
        killstreakentity notify(#"killstreak_switch_team_singleton");
        killstreakentity endon(#"killstreak_switch_team_singleton");
        killstreakentity endon(#"death");
        setdvar("<dev string:xae>", "<dev string:xc9>");
        while (true) {
            wait 0.5;
            devgui_int = getdvarint("<dev string:xae>");
            if (devgui_int != 0) {
                team = "<dev string:xca>";
                if (isdefined(level.getenemyteam) && isdefined(owner) && isdefined(owner.team)) {
                    team = [[ level.getenemyteam ]](owner.team);
                }
                if (isdefined(level.devongetormakebot)) {
                    player = [[ level.devongetormakebot ]](team);
                }
                if (!isdefined(player)) {
                    println("<dev string:xd5>");
                    wait 1;
                    continue;
                }
                if (!isdefined(killstreakentity.killstreak_hackedcallback)) {
                    /#
                        iprintlnbold("<dev string:xef>");
                    #/
                    return;
                }
                killstreakentity notify(#"killstreak_hacked", player);
                killstreakentity.previouslyhacked = 1;
                killstreakentity [[ killstreakentity.killstreak_hackedcallback ]](player);
                wait 0.5;
                setdvar("<dev string:xae>", "<dev string:x107>");
                return;
            }
        }
    }

#/
