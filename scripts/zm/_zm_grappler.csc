#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/beam_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_grappler;

// Namespace zm_grappler
// Params 0, eflags: 0x2
// Checksum 0xf7763e72, Offset: 0x208
// Size: 0x34
function function_2dc19561() {
    system::register("zm_grappler", &__init__, undefined, undefined);
}

// Namespace zm_grappler
// Params 0, eflags: 0x0
// Checksum 0xd78a5aeb, Offset: 0x248
// Size: 0x94
function __init__() {
    clientfield::register("scriptmover", "grappler_beam_source", 15000, 1, "int", &grappler_source, 0, 0);
    clientfield::register("scriptmover", "grappler_beam_target", 15000, 1, "int", &grappler_beam, 0, 0);
}

// Namespace zm_grappler
// Params 7, eflags: 0x0
// Checksum 0x2bedf7c9, Offset: 0x2e8
// Size: 0x6e
function grappler_source(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.grappler_sources)) {
        level.grappler_sources = [];
    }
    if (newval) {
        level.grappler_sources[localclientnum] = self;
    }
}

// Namespace zm_grappler
// Params 7, eflags: 0x0
// Checksum 0x99739a26, Offset: 0x360
// Size: 0xd6
function grappler_beam(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.grappler_sources)) {
        level.grappler_sources = [];
    }
    /#
        assert(isdefined(level.grappler_sources[localclientnum]));
    #/
    pivot = level.grappler_sources[localclientnum];
    if (newval) {
        thread function_55af4b5b(self, "tag_origin", pivot, 0.05);
        return;
    }
    self notify(#"grappler_done");
}

// Namespace zm_grappler
// Params 4, eflags: 0x0
// Checksum 0x10dd379b, Offset: 0x440
// Size: 0x54
function function_55af4b5b(player, tag, pivot, delay) {
    player endon(#"grappler_done");
    wait(delay);
    thread grapple_beam(player, tag, pivot);
}

// Namespace zm_grappler
// Params 3, eflags: 0x0
// Checksum 0x48d4d47e, Offset: 0x4a0
// Size: 0x8c
function grapple_beam(player, tag, pivot) {
    level beam::launch(player, tag, pivot, "tag_origin", "zod_beast_grapple_beam");
    player waittill(#"grappler_done");
    level beam::kill(player, tag, pivot, "tag_origin", "zod_beast_grapple_beam");
}

