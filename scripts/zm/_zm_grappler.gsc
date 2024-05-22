#using scripts/zm/_zm_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_grappler;

// Namespace zm_grappler
// Params 0, eflags: 0x2
// Checksum 0xc67ef4f, Offset: 0x220
// Size: 0x3c
function function_2dc19561() {
    system::register("zm_grappler", &__init__, &__main__, undefined);
}

// Namespace zm_grappler
// Params 0, eflags: 0x1 linked
// Checksum 0x3225733, Offset: 0x268
// Size: 0x64
function __init__() {
    clientfield::register("scriptmover", "grappler_beam_source", 15000, 1, "int");
    clientfield::register("scriptmover", "grappler_beam_target", 15000, 1, "int");
}

// Namespace zm_grappler
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x2d8
// Size: 0x4
function __main__() {
    
}

// Namespace zm_grappler
// Params 4, eflags: 0x1 linked
// Checksum 0xe69fe55d, Offset: 0x2e8
// Size: 0x3bc
function start_grapple(var_683c052c, e_grapplee, n_type, n_speed) {
    if (!isdefined(n_speed)) {
        n_speed = 1800;
    }
    /#
        assert(n_type == 2);
    #/
    e_source = create_mover(var_683c052c function_1e702195(), var_683c052c.angles);
    e_beamend = create_mover(var_683c052c function_1e702195(), var_683c052c.angles * -1);
    thread function_28ac2916(e_source, e_beamend);
    if (isdefined(e_beamend)) {
        e_grapplee function_63b4b8a5(1);
        util::wait_network_frame();
        n_time = function_3e1b1cea(var_683c052c, e_grapplee, n_speed);
        e_beamend.origin = var_683c052c function_1e702195();
        var_c35f0f99 = e_grapplee function_1e702195();
        e_beamend playsound("zmb_grapple_start");
        e_beamend moveto(var_c35f0f99, n_time);
        e_beamend waittill(#"movedone");
        var_8986f6e8 = var_c35f0f99 - e_grapplee.origin;
        e_beamend.origin = e_grapplee.origin;
        if (isplayer(e_grapplee)) {
            e_grapplee playerlinkto(e_beamend, "tag_origin");
        } else {
            e_grapplee linkto(e_beamend);
        }
        e_grapplee playsound("zmb_grapple_grab");
        var_de84fe14 = var_683c052c function_1e702195() - var_8986f6e8;
        e_beamend moveto(var_de84fe14, n_time);
        e_beamend playsound("zmb_grapple_pull");
        e_beamend waittill(#"movedone");
        function_b7c692b0();
        e_beamend clientfield::set("grappler_beam_target", 0);
        e_grapplee unlink();
        e_grapplee function_63b4b8a5(0);
        util::wait_network_frame();
        destroy_mover(e_beamend);
        destroy_mover(e_source);
    }
}

// Namespace zm_grappler
// Params 0, eflags: 0x5 linked
// Checksum 0x140f8570, Offset: 0x6b0
// Size: 0x28
function function_b7c692b0() {
    while (isdefined(level.var_5b94112c) && level.var_5b94112c) {
        wait(0.05);
    }
}

// Namespace zm_grappler
// Params 2, eflags: 0x5 linked
// Checksum 0xd04d742b, Offset: 0x6e0
// Size: 0xb0
function function_28ac2916(e_source, e_target) {
    function_b7c692b0();
    level.var_5b94112c = 1;
    if (isdefined(e_source)) {
        e_source clientfield::set("grappler_beam_source", 1);
    }
    util::wait_network_frame();
    if (isdefined(e_target)) {
        e_target clientfield::set("grappler_beam_target", 1);
    }
    util::wait_network_frame();
    level.var_5b94112c = 0;
}

// Namespace zm_grappler
// Params 3, eflags: 0x5 linked
// Checksum 0x6d5dc9a2, Offset: 0x798
// Size: 0x72
function function_3e1b1cea(e_from, e_to, n_speed) {
    n_distance = distance(e_from function_1e702195(), e_to function_1e702195());
    return n_distance / n_speed;
}

// Namespace zm_grappler
// Params 1, eflags: 0x5 linked
// Checksum 0xe8143a3e, Offset: 0x818
// Size: 0x104
function function_63b4b8a5(var_365c612) {
    if (!isdefined(self)) {
        return;
    }
    if (var_365c612 != (isdefined(self.var_14f171d3) && self.var_14f171d3)) {
        self.var_14f171d3 = var_365c612;
        if (isplayer(self)) {
            self util::freeze_player_controls(var_365c612);
            self setplayercollision(!var_365c612);
            if (var_365c612) {
                self zm_utility::function_139befeb();
                self.var_61f01d73 = self enableinvulnerability();
                return;
            }
            self zm_utility::function_36f941b3();
            if (!(isdefined(self.var_61f01d73) && self.var_61f01d73)) {
                self disableinvulnerability();
            }
        }
    }
}

// Namespace zm_grappler
// Params 0, eflags: 0x5 linked
// Checksum 0x48e5527d, Offset: 0x928
// Size: 0x46
function function_1e702195() {
    if (isdefined(self.grapple_tag)) {
        v_origin = self gettagorigin(self.grapple_tag);
        return v_origin;
    }
    return self.origin;
}

// Namespace zm_grappler
// Params 2, eflags: 0x5 linked
// Checksum 0x805558df, Offset: 0x978
// Size: 0x54
function create_mover(v_origin, v_angles) {
    model = "tag_origin";
    e_ent = util::spawn_model(model, v_origin, v_angles);
    return e_ent;
}

// Namespace zm_grappler
// Params 1, eflags: 0x5 linked
// Checksum 0x41501f2b, Offset: 0x9d8
// Size: 0x2c
function destroy_mover(e_beamend) {
    if (isdefined(e_beamend)) {
        e_beamend delete();
    }
}

