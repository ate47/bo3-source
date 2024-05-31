#using scripts/codescripts/struct;

#namespace namespace_779c23e4;

// Namespace namespace_779c23e4
// Params 0, eflags: 0x1 linked
// namespace_779c23e4<file_0>::function_d290ebfa
// Checksum 0x8f1390a6, Offset: 0x118
// Size: 0x44
function main() {
    function_4d3ba930();
    function_d4d4c648();
    level thread function_848fb66a(25, 35);
}

// Namespace namespace_779c23e4
// Params 0, eflags: 0x1 linked
// namespace_779c23e4<file_0>::function_4d3ba930
// Checksum 0xe58602aa, Offset: 0x168
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

// Namespace namespace_779c23e4
// Params 2, eflags: 0x1 linked
// namespace_779c23e4<file_0>::function_2df9c9dc
// Checksum 0x3838b6db, Offset: 0x2b0
// Size: 0x68
function function_2df9c9dc(prefix, count) {
    aliases = [];
    for (i = 0; i < count; i++) {
        aliases[aliases.size] = prefix + i;
    }
    return aliases;
}

// Namespace namespace_779c23e4
// Params 0, eflags: 0x1 linked
// namespace_779c23e4<file_0>::function_d4d4c648
// Checksum 0xb693e6a5, Offset: 0x320
// Size: 0x54
function function_d4d4c648() {
    level.var_6dc64e30 = function_2df9c9dc("vox_reco_announcement_general_", 30);
    level.var_9ee8e0f7 = function_2df9c9dc("vox_pani_announcement_attack_", 22);
}

// Namespace namespace_779c23e4
// Params 2, eflags: 0x1 linked
// namespace_779c23e4<file_0>::function_848fb66a
// Checksum 0x5ac3add9, Offset: 0x380
// Size: 0x128
function function_848fb66a(mintime, maxtime) {
    while (level.var_6dc64e30.size > 0) {
        waittime = randomintrange(mintime, maxtime);
        wait(waittime);
        var_583acf7b = function_5e7ad856(level.var_6dc64e30);
        function_af33668b(var_583acf7b);
        var_ab2de14f = randomfloat(1);
        if (0.3 > var_ab2de14f && level.var_9ee8e0f7.size > 0) {
            wait(randomfloatrange(1, 2));
            var_3d73fab2 = function_5e7ad856(level.var_9ee8e0f7);
            function_af33668b(var_3d73fab2, var_583acf7b);
        }
    }
}

// Namespace namespace_779c23e4
// Params 1, eflags: 0x1 linked
// namespace_779c23e4<file_0>::function_5e7ad856
// Checksum 0x511042d8, Offset: 0x4b0
// Size: 0x68
function function_5e7ad856(&aliasarray) {
    randomindex = randomint(aliasarray.size);
    alias = aliasarray[randomindex];
    arrayremoveindex(aliasarray, randomindex);
    return alias;
}

// Namespace namespace_779c23e4
// Params 2, eflags: 0x1 linked
// namespace_779c23e4<file_0>::function_af33668b
// Checksum 0xf6fc5281, Offset: 0x520
// Size: 0xa2
function function_af33668b(alias, stopalias) {
    foreach (intercom in level.var_ec494688) {
        intercom thread function_c0a23046(alias, stopalias);
    }
}

// Namespace namespace_779c23e4
// Params 2, eflags: 0x1 linked
// namespace_779c23e4<file_0>::function_c0a23046
// Checksum 0xe70e134, Offset: 0x5d0
// Size: 0x7c
function function_c0a23046(alias, stopalias) {
    if (isdefined(stopalias)) {
        self stopsound(stopalias);
        wait(0.05);
        self playsound("amb_intercom_interrupt");
        wait(2);
    }
    self playsound(alias);
}

