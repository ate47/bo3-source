#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace flashback;

// Namespace flashback
// Params 0, eflags: 0x2
// Checksum 0xeb9ab937, Offset: 0x350
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_flashback", &__init__, undefined, undefined);
}

// Namespace flashback
// Params 0, eflags: 0x1 linked
// Checksum 0x334ca8d3, Offset: 0x390
// Size: 0x20c
function __init__() {
    clientfield::register("scriptmover", "flashback_trail_fx", 1, 1, "int");
    clientfield::register("playercorpse", "flashback_clone", 1, 1, "int");
    clientfield::register("allplayers", "flashback_activated", 1, 1, "int");
    ability_player::register_gadget_activation_callbacks(16, &function_368b57d1, &function_c23cb11d);
    ability_player::register_gadget_possession_callbacks(16, &function_42bd2787, &function_d5e07d1d);
    ability_player::register_gadget_flicker_callbacks(16, &function_51535640);
    ability_player::register_gadget_is_inuse_callbacks(16, &function_90fcd171);
    ability_player::register_gadget_is_flickering_callbacks(16, &function_95ca4855);
    ability_player::register_gadget_primed_callbacks(16, &function_c2d1f5c2);
    callback::on_connect(&function_65109c96);
    callback::on_spawned(&function_6bf3f470);
    if (!isdefined(level.var_fa6a80b1)) {
        level.var_fa6a80b1 = 27;
    }
    visionset_mgr::register_info("overlay", "flashback_warp", 1, level.var_fa6a80b1, 1, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
}

// Namespace flashback
// Params 0, eflags: 0x1 linked
// Checksum 0x37403a6e, Offset: 0x5a8
// Size: 0x24
function function_6bf3f470() {
    self clientfield::set("flashback_activated", 0);
}

// Namespace flashback
// Params 1, eflags: 0x1 linked
// Checksum 0xe9bdcbe4, Offset: 0x5d8
// Size: 0x2a
function function_90fcd171(slot) {
    return self flagsys::get("gadget_flashback_on");
}

// Namespace flashback
// Params 1, eflags: 0x1 linked
// Checksum 0x9925899b, Offset: 0x610
// Size: 0x22
function function_95ca4855(slot) {
    return self gadgetflickering(slot);
}

// Namespace flashback
// Params 2, eflags: 0x1 linked
// Checksum 0x4693d28e, Offset: 0x640
// Size: 0x14
function function_51535640(slot, weapon) {
    
}

// Namespace flashback
// Params 2, eflags: 0x1 linked
// Checksum 0x3065ef30, Offset: 0x660
// Size: 0x14
function function_42bd2787(slot, weapon) {
    
}

// Namespace flashback
// Params 2, eflags: 0x1 linked
// Checksum 0x8c62a649, Offset: 0x680
// Size: 0x14
function function_d5e07d1d(slot, weapon) {
    
}

// Namespace flashback
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x6a0
// Size: 0x4
function function_65109c96() {
    
}

// Namespace flashback
// Params 0, eflags: 0x1 linked
// Checksum 0xa4337a8b, Offset: 0x6b0
// Size: 0x4c
function function_dcca4d3b() {
    self endon(#"death");
    wait(1);
    self clientfield::set("flashback_clone", 0);
    self ghost();
}

/#

    // Namespace flashback
    // Params 3, eflags: 0x0
    // Checksum 0xfb4c2fd1, Offset: 0x708
    // Size: 0x8c
    function debug_star(origin, seconds, color) {
        if (!isdefined(seconds)) {
            seconds = 1;
        }
        if (!isdefined(color)) {
            color = (1, 0, 0);
        }
        frames = int(20 * seconds);
        debugstar(origin, frames, color);
    }

#/

// Namespace flashback
// Params 1, eflags: 0x1 linked
// Checksum 0x98c08dcc, Offset: 0x7a0
// Size: 0xca
function function_1fce1f97(linkedgrenades) {
    waittillframeend();
    foreach (grenade in linkedgrenades) {
        grenade launch((randomfloatrange(-5, 5), randomfloatrange(-5, 5), 5));
    }
}

// Namespace flashback
// Params 1, eflags: 0x1 linked
// Checksum 0xfda47a9c, Offset: 0x878
// Size: 0x18c
function unlink_grenades(oldpos) {
    radius = 32;
    origin = oldpos;
    grenades = getentarray("grenade", "classname");
    radiussq = radius * radius;
    linkedgrenades = [];
    foreach (grenade in grenades) {
        if (distancesquared(origin, grenade.origin) < radiussq) {
            if (isdefined(grenade.stucktoplayer) && grenade.stucktoplayer == self) {
                grenade unlink();
                linkedgrenades[linkedgrenades.size] = grenade;
            }
        }
    }
    thread function_1fce1f97(linkedgrenades);
}

// Namespace flashback
// Params 2, eflags: 0x1 linked
// Checksum 0x3ef755f4, Offset: 0xa10
// Size: 0x264
function function_368b57d1(slot, weapon) {
    self flagsys::set("gadget_flashback_on");
    self gadgetsetactivatetime(slot, gettime());
    visionset_mgr::activate("overlay", "flashback_warp", self, 0.8, 0.8);
    self.var_ba21be83 = gettime();
    self notify(#"flashback");
    clone = self createflashbackclone();
    clone thread function_dcca4d3b();
    clone clientfield::set("flashback_clone", 1);
    self thread function_3e517104();
    oldpos = self gettagorigin("j_spineupper");
    offset = oldpos - self.origin;
    self unlink_grenades(oldpos);
    newpos = self flashbackstart(weapon) + offset;
    self notsolid();
    if (isdefined(newpos) && isdefined(oldpos)) {
        self thread function_62618cfe(slot, weapon, oldpos, newpos);
        function_7d14ae92(newpos, oldpos, 8);
        function_7d14ae92(oldpos, newpos, 8);
        if (isdefined(level.playgadgetsuccess)) {
            self [[ level.playgadgetsuccess ]](weapon, "flashbackSuccessDelay");
        }
    }
    self thread function_d0bbb73d(0.8);
}

// Namespace flashback
// Params 0, eflags: 0x1 linked
// Checksum 0xf40a13f, Offset: 0xc80
// Size: 0x7c
function function_3e517104() {
    self endon(#"death");
    self endon(#"disconnect");
    util::wait_network_frame();
    self clientfield::set("flashback_activated", 1);
    util::wait_network_frame();
    self clientfield::set("flashback_activated", 0);
}

// Namespace flashback
// Params 3, eflags: 0x1 linked
// Checksum 0xa25bb3a9, Offset: 0xd08
// Size: 0xfc
function function_7d14ae92(startpos, endpos, var_89ba3366) {
    var_89ba3366--;
    if (var_89ba3366 <= 0) {
        return;
    }
    trace = bullettrace(startpos, endpos, 0, self);
    if (trace["fraction"] < 1 && trace["normal"] != (0, 0, 0)) {
        playfx("player/fx_plyr_flashback_trail_impact", trace["position"], trace["normal"]);
        var_dc42b02b = trace["position"] - trace["normal"];
        /#
        #/
        function_7d14ae92(var_dc42b02b, endpos, var_89ba3366);
    }
}

// Namespace flashback
// Params 1, eflags: 0x1 linked
// Checksum 0xa85b71e7, Offset: 0xe10
// Size: 0x54
function function_d0bbb73d(time) {
    self endon(#"disconnect");
    self util::waittill_any_timeout(time, "death");
    visionset_mgr::deactivate("overlay", "flashback_warp", self);
}

// Namespace flashback
// Params 4, eflags: 0x1 linked
// Checksum 0xa43000fc, Offset: 0xe70
// Size: 0x1e4
function function_62618cfe(slot, weapon, oldpos, newpos) {
    dirvec = newpos - oldpos;
    if (dirvec == (0, 0, 0)) {
        dirvec = (0, 0, 1);
    }
    dirvec = vectornormalize(dirvec);
    angles = vectortoangles(dirvec);
    fxorg = spawn("script_model", oldpos, 0, angles);
    fxorg.angles = angles;
    fxorg setowner(self);
    fxorg setmodel("tag_origin");
    fxorg clientfield::set("flashback_trail_fx", 1);
    util::wait_network_frame();
    tagpos = self gettagorigin("j_spineupper");
    fxorg moveto(tagpos, 0.1);
    fxorg waittill(#"movedone");
    wait(1);
    fxorg clientfield::set("flashback_trail_fx", 0);
    util::wait_network_frame();
    fxorg delete();
}

// Namespace flashback
// Params 2, eflags: 0x1 linked
// Checksum 0xa715d4c6, Offset: 0x1060
// Size: 0x14
function function_c2d1f5c2(slot, weapon) {
    
}

// Namespace flashback
// Params 2, eflags: 0x1 linked
// Checksum 0xc39375b2, Offset: 0x1080
// Size: 0x84
function function_c23cb11d(slot, weapon) {
    self flagsys::clear("gadget_flashback_on");
    self solid();
    self flashbackfinish();
    if (level.gameended) {
        self freezecontrols(1);
    }
}

