#namespace clientfield;

// Namespace clientfield
// Params 8, eflags: 0x1 linked
// Checksum 0x5cf03b24, Offset: 0x78
// Size: 0x74
function register(str_pool_name, str_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new) {
    registerclientfield(str_pool_name, str_name, n_version, n_bits, str_type, func_callback, b_host, b_callback_for_zero_when_new);
}

// Namespace clientfield
// Params 1, eflags: 0x1 linked
// Checksum 0x4e79446d, Offset: 0xf8
// Size: 0x4c
function get(field_name) {
    if (self == level) {
        return codegetworldclientfield(field_name);
    }
    return codegetclientfield(self, field_name);
}

// Namespace clientfield
// Params 1, eflags: 0x1 linked
// Checksum 0xeda893ff, Offset: 0x150
// Size: 0x22
function get_to_player(field_name) {
    return codegetplayerstateclientfield(self, field_name);
}

// Namespace clientfield
// Params 1, eflags: 0x0
// Checksum 0x62b4f328, Offset: 0x180
// Size: 0x22
function get_player_uimodel(field_name) {
    return codegetuimodelclientfield(self, field_name);
}

