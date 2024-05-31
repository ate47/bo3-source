#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_f26b66b7;

// Namespace namespace_f26b66b7
// Params 0, eflags: 0x2
// namespace_f26b66b7<file_0>::function_2dc19561
// Checksum 0x71835031, Offset: 0x198
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_fog", &__init__, undefined, undefined);
}

// Namespace namespace_f26b66b7
// Params 0, eflags: 0x1 linked
// namespace_f26b66b7<file_0>::function_8c87d8eb
// Checksum 0x578ca1b8, Offset: 0x1d8
// Size: 0xcc
function __init__() {
    clientfield::register("world", "globalfog_bank", 15000, 2, "int", &function_83c92b90, 0, 0);
    clientfield::register("world", "litfog_scriptid_to_edit", 15000, 4, "int", undefined, 0, 0);
    clientfield::register("world", "litfog_bank", 15000, 2, "int", &function_7ac70b3c, 0, 0);
}

// Namespace namespace_f26b66b7
// Params 7, eflags: 0x1 linked
// namespace_f26b66b7<file_0>::function_83c92b90
// Checksum 0x6af5d1c8, Offset: 0x2b0
// Size: 0x5c
function function_83c92b90(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setworldfogactivebank(localclientnum, newval + 1);
}

// Namespace namespace_f26b66b7
// Params 7, eflags: 0x1 linked
// namespace_f26b66b7<file_0>::function_7ac70b3c
// Checksum 0x35f0ac60, Offset: 0x318
// Size: 0x84
function function_7ac70b3c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_18b9a65a = clientfield::get("litfog_scriptid_to_edit");
    setlitfogbank(localclientnum, var_18b9a65a, newval, -1);
}

