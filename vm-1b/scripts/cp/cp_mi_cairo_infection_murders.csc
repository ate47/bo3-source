#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace namespace_47ecfa2f;

// Namespace namespace_47ecfa2f
// Params 0, eflags: 0x0
// Checksum 0xbb543a1a, Offset: 0x238
// Size: 0x12
function main() {
    init_clientfields();
}

// Namespace namespace_47ecfa2f
// Params 0, eflags: 0x0
// Checksum 0x7c147bc7, Offset: 0x258
// Size: 0x11a
function init_clientfields() {
    clientfield::register("world", "black_station_ceiling_fxanim", 1, 2, "int", &black_station_ceiling_fxanim, 1, 0);
    clientfield::register("world", "igc_blackscreen_fade_in", 1, 1, "counter", &function_9eb32c49, 0, 0);
    clientfield::register("world", "igc_blackscreen_fade_in_immediate", 1, 1, "counter", &function_d2f9a5e3, 0, 0);
    clientfield::register("world", "igc_blackscreen_fade_out_immediate", 1, 1, "counter", &function_22cced56, 0, 0);
    clientfield::register("toplayer", "japanese_graphic_content_hide", 1, 1, "int", &function_f1acb728, 1, 1);
}

// Namespace namespace_47ecfa2f
// Params 7, eflags: 0x0
// Checksum 0x59d76306, Offset: 0x380
// Size: 0x82
function black_station_ceiling_fxanim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval == newval) {
        return;
    }
    if (newval == 1) {
        level thread scene::init("p7_fxanim_cp_infection_ceiling_open_bundle");
        return;
    }
    if (newval == 2) {
        level thread scene::play("p7_fxanim_cp_infection_ceiling_open_bundle");
    }
}

// Namespace namespace_47ecfa2f
// Params 7, eflags: 0x0
// Checksum 0x774446d2, Offset: 0x410
// Size: 0x92
function function_f1acb728(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (bnewent) {
        return;
    }
    if (util::is_gib_restricted_build()) {
        if (newval == 1) {
            self lui::screen_fade_out(0, "black");
            return;
        }
        if (newval == 0) {
            self lui::screen_fade_in(0, "black");
        }
    }
}

// Namespace namespace_47ecfa2f
// Params 7, eflags: 0x0
// Checksum 0x5457b50a, Offset: 0x4b0
// Size: 0x72
function function_9eb32c49(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    player lui::screen_fade_in(0.2, "black");
}

// Namespace namespace_47ecfa2f
// Params 7, eflags: 0x0
// Checksum 0xa252327, Offset: 0x530
// Size: 0x72
function function_d2f9a5e3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    player lui::screen_fade_in(0, "black");
}

// Namespace namespace_47ecfa2f
// Params 7, eflags: 0x0
// Checksum 0xb895af2a, Offset: 0x5b0
// Size: 0x72
function function_22cced56(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    player lui::screen_fade_out(0, "black");
}

