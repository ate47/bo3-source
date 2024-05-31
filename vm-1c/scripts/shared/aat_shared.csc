#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;

#namespace aat;

// Namespace aat
// Params 0, eflags: 0x2
// namespace_4db6bf4d<file_0>::function_2dc19561
// Checksum 0x7a1f1815, Offset: 0x150
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("aat", &__init__, undefined, undefined);
}

// Namespace aat
// Params 0, eflags: 0x5 linked
// namespace_4db6bf4d<file_0>::function_8c87d8eb
// Checksum 0x79f2846a, Offset: 0x190
// Size: 0x84
function private __init__() {
    level.aat_initializing = 1;
    level.aat_default_info_name = "none";
    level.aat_default_info_icon = "blacktransparent";
    level.aat = [];
    register("none", level.aat_default_info_name, level.aat_default_info_icon);
    callback::on_finalize_initialization(&finalize_clientfields);
}

// Namespace aat
// Params 3, eflags: 0x1 linked
// namespace_4db6bf4d<file_0>::function_50f16166
// Checksum 0xc478bd7c, Offset: 0x220
// Size: 0x178
function register(name, localized_string, icon) {
    assert(isdefined(level.aat_initializing) && level.aat_initializing, "<unknown string>");
    assert(isdefined(name), "<unknown string>");
    assert(!isdefined(level.aat[name]), "<unknown string>" + name + "<unknown string>");
    assert(isdefined(localized_string), "<unknown string>");
    assert(isdefined(icon), "<unknown string>");
    level.aat[name] = spawnstruct();
    level.aat[name].name = name;
    level.aat[name].localized_string = localized_string;
    level.aat[name].icon = icon;
}

// Namespace aat
// Params 7, eflags: 0x1 linked
// namespace_4db6bf4d<file_0>::function_4bd5555b
// Checksum 0x3e92723b, Offset: 0x3a0
// Size: 0x74
function aat_hud_manager(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.update_aat_hud)) {
        [[ level.update_aat_hud ]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace aat
// Params 0, eflags: 0x1 linked
// namespace_4db6bf4d<file_0>::function_cda32664
// Checksum 0xd278f4b0, Offset: 0x420
// Size: 0x190
function finalize_clientfields() {
    println("<unknown string>");
    if (level.aat.size > 1) {
        array::alphabetize(level.aat);
        i = 0;
        foreach (aat in level.aat) {
            aat.n_index = i;
            i++;
            println("<unknown string>" + aat.name);
        }
        n_bits = getminbitcountfornum(level.aat.size - 1);
        clientfield::register("toplayer", "aat_current", 1, n_bits, "int", &aat_hud_manager, 0, 1);
    }
    level.aat_initializing = 0;
}

// Namespace aat
// Params 1, eflags: 0x1 linked
// namespace_4db6bf4d<file_0>::function_55505bc1
// Checksum 0x958679c9, Offset: 0x5b8
// Size: 0xaa
function get_string(n_aat_index) {
    foreach (aat in level.aat) {
        if (aat.n_index == n_aat_index) {
            return aat.localized_string;
        }
    }
    return level.aat_default_info_name;
}

// Namespace aat
// Params 1, eflags: 0x1 linked
// namespace_4db6bf4d<file_0>::function_89b61b7d
// Checksum 0xb001f4e2, Offset: 0x670
// Size: 0xaa
function get_icon(n_aat_index) {
    foreach (aat in level.aat) {
        if (aat.n_index == n_aat_index) {
            return aat.icon;
        }
    }
    return level.aat_default_info_icon;
}

