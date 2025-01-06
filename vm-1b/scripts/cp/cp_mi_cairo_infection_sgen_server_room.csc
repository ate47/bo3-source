#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace sgen_server_room;

// Namespace sgen_server_room
// Params 0, eflags: 0x0
// Checksum 0xd57797d9, Offset: 0x220
// Size: 0xaa
function main() {
    clientfield::register("world", "infection_sgen_server_debris", 1, 2, "int", &function_e8b6f49, 1, 1);
    clientfield::register("world", "infection_sgen_xcam_models", 1, 1, "int", &function_d5a1aabe, 1, 1);
    clientfield::register("actor", "infection_taylor_eye_shader", 1, 1, "int", &function_1b21c3a8, 0, 0);
}

// Namespace sgen_server_room
// Params 7, eflags: 0x0
// Checksum 0xaf1aaa96, Offset: 0x2d8
// Size: 0xa1
function function_e8b6f49(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    switch (newval) {
    case 1:
        level thread function_dce4d663(localclientnum);
        break;
    case 2:
        level notify(#"hash_a9cad786");
        break;
    case 3:
        level notify(#"hash_ec0728a9");
        break;
    default:
        break;
    }
}

// Namespace sgen_server_room
// Params 1, eflags: 0x0
// Checksum 0xc2f78f5f, Offset: 0x388
// Size: 0x142
function function_dce4d663(localclientnum) {
    debris = [];
    position = struct::get_array("sgen_server_debris");
    for (i = 0; i < position.size; i++) {
        if (isdefined(position[i].model)) {
            junk = spawn(localclientnum, position[i].origin, "script_model");
            junk setmodel(position[i].model);
            junk.targetname = position[i].targetname;
            if (isdefined(position[i].angles)) {
                junk.angles = position[i].angles;
            }
            if (isdefined(position[i].script_noteworthy)) {
                junk.script_noteworthy = position[i].script_noteworthy;
            }
            array::add(debris, junk, 0);
        }
    }
    level waittill(#"hash_a9cad786");
    array::thread_all(debris, &function_a926469a);
}

// Namespace sgen_server_room
// Params 0, eflags: 0x0
// Checksum 0x33fc93df, Offset: 0x4d8
// Size: 0x122
function function_a926469a() {
    drop_distance = self function_551b5ea9();
    drop_time = drop_distance / 600;
    var_8f681333 = drop_time;
    var_5204081d = var_8f681333 * 1.25;
    var_a1cc6c78 = drop_time * 0.25;
    var_dd8187f3 = randomfloatrange(var_8f681333, var_5204081d);
    endpos = (self.origin[0], self.origin[1], self.origin[2] - drop_distance);
    self moveto(endpos, var_dd8187f3);
    self rotateto(self.angles + (randomfloatrange(-45, 45), randomfloatrange(-45, 45), randomfloatrange(-45, 45)), var_dd8187f3);
    level waittill(#"hash_ec0728a9");
    self delete();
}

// Namespace sgen_server_room
// Params 0, eflags: 0x0
// Checksum 0x3220cba7, Offset: 0x608
// Size: 0x77
function function_551b5ea9() {
    var_b5b704ff = struct::get("tag_align_bastogne_sarah_intro", "targetname");
    v_start = self.origin;
    v_end = var_b5b704ff.origin;
    var_84dc6c43 = (v_start - v_end)[2];
    return abs(var_84dc6c43) + 64 + 40;
}

// Namespace sgen_server_room
// Params 7, eflags: 0x0
// Checksum 0x4d00a8b1, Offset: 0x688
// Size: 0xc3
function function_d5a1aabe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_c7b3d965 = getentarray(localclientnum, "pallas_xcam_model", "targetname");
    foreach (var_632ff3aa in var_c7b3d965) {
        var_632ff3aa delete();
    }
}

// Namespace sgen_server_room
// Params 7, eflags: 0x0
// Checksum 0xd3ed8301, Offset: 0x758
// Size: 0x83
function function_df5afb6d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4e6738e = 1.33333;
    for (i = 0; i < 3; i++) {
        thread function_9d64b4e6(0.1);
        wait var_4e6738e;
    }
}

// Namespace sgen_server_room
// Params 2, eflags: 0x0
// Checksum 0x4723736, Offset: 0x7e8
// Size: 0x55
function function_9d64b4e6(localclientnum, speed) {
    var_38d3010a = 0;
    for (var_38d3010a = 0; var_38d3010a <= 1; var_38d3010a += speed) {
        self mapshaderconstant(localclientnum, 0, "scriptVector1", var_38d3010a);
    }
}

// Namespace sgen_server_room
// Params 7, eflags: 0x0
// Checksum 0xaf81316d, Offset: 0x848
// Size: 0x6a
function function_1b21c3a8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval != newval) {
        if (newval == 1) {
            self mapshaderconstant(localclientnum, 0, "scriptVector0", 1, 1, 0, 0);
        }
    }
}

