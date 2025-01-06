#using scripts/codescripts/struct;

#namespace mp_cryogen_sound;

// Namespace mp_cryogen_sound
// Params 0, eflags: 0x0
// Checksum 0x90657c46, Offset: 0x118
// Size: 0x44
function main() {
    function_4d3ba930();
    function_d4d4c648();
    level thread function_848fb66a(25, 35);
}

// Namespace mp_cryogen_sound
// Params 0, eflags: 0x0
// Checksum 0xb201916, Offset: 0x168
// Size: 0x140
function function_4d3ba930() {
    level.var_ec494688 = [];
    var_e30a53be = struct::get_array("cryogen_intercom", "targetname");
    foreach (var_247dac7 in var_e30a53be) {
        intercom = spawn("script_model", var_247dac7.origin, 0, var_247dac7.angles);
        intercom.angles = var_247dac7.angles;
        intercom setmodel("tag_origin");
        level.var_ec494688[level.var_ec494688.size] = intercom;
    }
}

// Namespace mp_cryogen_sound
// Params 2, eflags: 0x0
// Checksum 0x1793993f, Offset: 0x2b0
// Size: 0x68
function function_2df9c9dc(prefix, count) {
    aliases = [];
    for (i = 0; i < count; i++) {
        aliases[aliases.size] = prefix + i;
    }
    return aliases;
}

// Namespace mp_cryogen_sound
// Params 0, eflags: 0x0
// Checksum 0xb9db1e27, Offset: 0x320
// Size: 0x54
function function_d4d4c648() {
    level.var_6dc64e30 = function_2df9c9dc("vox_reco_announcement_general_", 30);
    level.var_9ee8e0f7 = function_2df9c9dc("vox_pani_announcement_attack_", 22);
}

// Namespace mp_cryogen_sound
// Params 2, eflags: 0x0
// Checksum 0xc77f5752, Offset: 0x380
// Size: 0x128
function function_848fb66a(mintime, maxtime) {
    while (level.var_6dc64e30.size > 0) {
        waittime = randomintrange(mintime, maxtime);
        wait waittime;
        var_583acf7b = function_5e7ad856(level.var_6dc64e30);
        function_af33668b(var_583acf7b);
        var_ab2de14f = randomfloat(1);
        if (0.3 > var_ab2de14f && level.var_9ee8e0f7.size > 0) {
            wait randomfloatrange(1, 2);
            var_3d73fab2 = function_5e7ad856(level.var_9ee8e0f7);
            function_af33668b(var_3d73fab2, var_583acf7b);
        }
    }
}

// Namespace mp_cryogen_sound
// Params 1, eflags: 0x0
// Checksum 0x9ee87adf, Offset: 0x4b0
// Size: 0x68
function function_5e7ad856(&aliasarray) {
    randomindex = randomint(aliasarray.size);
    alias = aliasarray[randomindex];
    arrayremoveindex(aliasarray, randomindex);
    return alias;
}

// Namespace mp_cryogen_sound
// Params 2, eflags: 0x0
// Checksum 0x4a87045, Offset: 0x520
// Size: 0xa2
function function_af33668b(alias, stopalias) {
    foreach (intercom in level.var_ec494688) {
        intercom thread function_c0a23046(alias, stopalias);
    }
}

// Namespace mp_cryogen_sound
// Params 2, eflags: 0x0
// Checksum 0xa67609b2, Offset: 0x5d0
// Size: 0x7c
function function_c0a23046(alias, stopalias) {
    if (isdefined(stopalias)) {
        self stopsound(stopalias);
        wait 0.05;
        self playsound("amb_intercom_interrupt");
        wait 2;
    }
    self playsound(alias);
}

