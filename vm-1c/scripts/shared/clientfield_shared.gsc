#namespace clientfield;

// Namespace clientfield
// Params 5, eflags: 0x1 linked
// namespace_71e9cb84<file_0>::function_50f16166
// Checksum 0xe517ff89, Offset: 0x78
// Size: 0x54
function register(str_pool_name, str_name, n_version, n_bits, str_type) {
    registerclientfield(str_pool_name, str_name, n_version, n_bits, str_type);
}

// Namespace clientfield
// Params 2, eflags: 0x1 linked
// namespace_71e9cb84<file_0>::function_74d6b22f
// Checksum 0x4076e995, Offset: 0xd8
// Size: 0x5c
function set(str_field_name, n_value) {
    if (self == level) {
        codesetworldclientfield(str_field_name, n_value);
        return;
    }
    codesetclientfield(self, str_field_name, n_value);
}

// Namespace clientfield
// Params 2, eflags: 0x1 linked
// namespace_71e9cb84<file_0>::function_e9c3870b
// Checksum 0x72f4f0bc, Offset: 0x140
// Size: 0x34
function set_to_player(str_field_name, n_value) {
    codesetplayerstateclientfield(self, str_field_name, n_value);
}

// Namespace clientfield
// Params 2, eflags: 0x1 linked
// namespace_71e9cb84<file_0>::function_cc4d5165
// Checksum 0x7680423f, Offset: 0x180
// Size: 0x4c
function set_player_uimodel(str_field_name, n_value) {
    if (!isentity(self)) {
        return;
    }
    codesetuimodelclientfield(self, str_field_name, n_value);
}

// Namespace clientfield
// Params 1, eflags: 0x1 linked
// namespace_71e9cb84<file_0>::function_8a67d1f9
// Checksum 0x794bb944, Offset: 0x1d8
// Size: 0x22
function get_player_uimodel(str_field_name) {
    return codegetuimodelclientfield(self, str_field_name);
}

// Namespace clientfield
// Params 2, eflags: 0x1 linked
// namespace_71e9cb84<file_0>::function_331efedc
// Checksum 0xa2ed5c1b, Offset: 0x208
// Size: 0x8e
function increment(str_field_name, n_increment_count) {
    if (!isdefined(n_increment_count)) {
        n_increment_count = 1;
    }
    for (i = 0; i < n_increment_count; i++) {
        if (self == level) {
            codeincrementworldclientfield(str_field_name);
            continue;
        }
        codeincrementclientfield(self, str_field_name);
    }
}

// Namespace clientfield
// Params 2, eflags: 0x1 linked
// namespace_71e9cb84<file_0>::function_4cf50a34
// Checksum 0xf74dcbaf, Offset: 0x2a0
// Size: 0x11e
function increment_uimodel(str_field_name, n_increment_count) {
    if (!isdefined(n_increment_count)) {
        n_increment_count = 1;
    }
    if (self == level) {
        foreach (player in level.players) {
            for (i = 0; i < n_increment_count; i++) {
                codeincrementuimodelclientfield(player, str_field_name);
            }
        }
        return;
    }
    for (i = 0; i < n_increment_count; i++) {
        codeincrementuimodelclientfield(self, str_field_name);
    }
}

// Namespace clientfield
// Params 2, eflags: 0x1 linked
// namespace_71e9cb84<file_0>::function_688ed188
// Checksum 0x6cc3899a, Offset: 0x3c8
// Size: 0x66
function increment_to_player(str_field_name, n_increment_count) {
    if (!isdefined(n_increment_count)) {
        n_increment_count = 1;
    }
    for (i = 0; i < n_increment_count; i++) {
        codeincrementplayerstateclientfield(self, str_field_name);
    }
}

// Namespace clientfield
// Params 1, eflags: 0x1 linked
// namespace_71e9cb84<file_0>::function_7922262b
// Checksum 0x31fe6086, Offset: 0x438
// Size: 0x4c
function get(str_field_name) {
    if (self == level) {
        return codegetworldclientfield(str_field_name);
    }
    return codegetclientfield(self, str_field_name);
}

// Namespace clientfield
// Params 1, eflags: 0x1 linked
// namespace_71e9cb84<file_0>::function_efc4a577
// Checksum 0x9d06d42d, Offset: 0x490
// Size: 0x22
function get_to_player(field_name) {
    return codegetplayerstateclientfield(self, field_name);
}

