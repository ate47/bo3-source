#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace zm_radio;

// Namespace zm_radio
// Params 0, eflags: 0x2
// Checksum 0xd8989ec8, Offset: 0xc0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_radio", &__init__, &__main__, undefined);
}

// Namespace zm_radio
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x108
// Size: 0x4
function __init__() {
    
}

// Namespace zm_radio
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x118
// Size: 0x4
function __main__() {
    
}

// Namespace zm_radio
// Params 7, eflags: 0x0
// Checksum 0x43ab63f0, Offset: 0x128
// Size: 0x204
function function_3d58bdce(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    assert(isdefined(level.var_f3006fa7));
    assert(isdefined(level.var_c017e2d5));
    assert(isdefined(level.var_ce7032d4));
    assert(level.var_c017e2d5.size > 0);
    if (!isdefined(level.var_58522184)) {
        level.var_58522184 = 0;
    }
    if (!level.var_58522184) {
        if (newval) {
            playsound(0, "static", self.origin);
            if (soundplaying(level.var_f3006fa7)) {
                fade(level.var_f3006fa7, 1);
            } else {
                wait 0.5;
            }
            if (level.var_ce7032d4 < level.var_c017e2d5.size) {
                println("<dev string:x28>" + level.var_c017e2d5[level.var_ce7032d4]);
                level.var_f3006fa7 = playsound(0, level.var_c017e2d5[level.var_ce7032d4], self.origin);
            } else {
                return;
            }
        }
        return;
    }
    if (isdefined(level.var_f3006fa7)) {
        stopsound(level.var_f3006fa7);
    }
}

// Namespace zm_radio
// Params 1, eflags: 0x0
// Checksum 0xeb3ee950, Offset: 0x338
// Size: 0x3a
function function_1214cfea(song) {
    if (!isdefined(level.var_c017e2d5)) {
        level.var_c017e2d5 = [];
    }
    level.var_c017e2d5[level.var_c017e2d5.size] = song;
}

// Namespace zm_radio
// Params 7, eflags: 0x0
// Checksum 0x5c12166d, Offset: 0x380
// Size: 0x68
function function_2b7f281d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    assert(isdefined(level.var_ce7032d4));
    level.var_ce7032d4 = newval;
}

// Namespace zm_radio
// Params 2, eflags: 0x0
// Checksum 0xf6aafab2, Offset: 0x3f0
// Size: 0x9c
function fade(n_id, n_time) {
    n_rate = 0;
    if (n_time != 0) {
        n_rate = 1 / n_time;
    }
    setsoundvolumerate(n_id, n_rate);
    setsoundvolume(n_id, 0);
    wait n_time;
    stopsound(n_id);
}

// Namespace zm_radio
// Params 0, eflags: 0x0
// Checksum 0x98111f56, Offset: 0x498
// Size: 0x60
function function_6378a934() {
    while (true) {
        level waittill(#"hash_c64cc62a");
        level.var_58522184 = 1;
        level thread function_3d58bdce();
        level waittill(#"hash_290b26e3");
        level.var_58522184 = 0;
        wait 0.5;
    }
}

