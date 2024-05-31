#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_powerups;

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// namespace_22646992<file_0>::function_c35e6aab
// Checksum 0xd9e08d5a, Offset: 0x1e0
// Size: 0x10c
function init() {
    add_zombie_powerup("insta_kill_ug", "powerup_instant_kill_ug", 1);
    level thread function_ced9fed2();
    level._effect["powerup_on"] = "zombie/fx_powerup_on_green_zmb";
    if (isdefined(level.using_zombie_powerups) && level.using_zombie_powerups) {
        level._effect["powerup_on_red"] = "zombie/fx_powerup_on_red_zmb";
    }
    level._effect["powerup_on_solo"] = "zombie/fx_powerup_on_solo_zmb";
    level._effect["powerup_on_caution"] = "zombie/fx_powerup_on_caution_zmb";
    clientfield::register("scriptmover", "powerup_fx", 1, 3, "int", &powerup_fx_callback, 0, 0);
}

// Namespace zm_powerups
// Params 3, eflags: 0x1 linked
// namespace_22646992<file_0>::function_1be071ae
// Checksum 0x625b084, Offset: 0x2f8
// Size: 0x108
function add_zombie_powerup(powerup_name, client_field_name, clientfield_version) {
    if (!isdefined(clientfield_version)) {
        clientfield_version = 1;
    }
    if (isdefined(level.zombie_include_powerups) && !isdefined(level.zombie_include_powerups[powerup_name])) {
        return;
    }
    struct = spawnstruct();
    if (!isdefined(level.zombie_powerups)) {
        level.zombie_powerups = [];
    }
    struct.powerup_name = powerup_name;
    level.zombie_powerups[powerup_name] = struct;
    if (isdefined(client_field_name)) {
        clientfield::register("toplayer", client_field_name, clientfield_version, 2, "int", &powerup_state_callback, 0, 1);
        struct.client_field_name = client_field_name;
    }
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// namespace_22646992<file_0>::function_ced9fed2
// Checksum 0xa55f1e7a, Offset: 0x408
// Size: 0xb6
function function_ced9fed2() {
    wait(0.1);
    powerup_keys = getarraykeys(level.zombie_powerups);
    var_52fbf591 = undefined;
    for (powerup_key_index = 0; powerup_key_index < powerup_keys.size; powerup_key_index++) {
        var_52fbf591 = level.zombie_powerups[powerup_keys[powerup_key_index]].client_field_name;
        if (isdefined(var_52fbf591)) {
            setupclientfieldcodecallbacks("toplayer", 1, var_52fbf591);
        }
    }
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// namespace_22646992<file_0>::function_2a156bc5
// Checksum 0x97187979, Offset: 0x4c8
// Size: 0x36
function include_zombie_powerup(powerup_name) {
    if (!isdefined(level.zombie_include_powerups)) {
        level.zombie_include_powerups = [];
    }
    level.zombie_include_powerups[powerup_name] = 1;
}

// Namespace zm_powerups
// Params 7, eflags: 0x1 linked
// namespace_22646992<file_0>::function_cc23cad5
// Checksum 0x3cb1864e, Offset: 0x508
// Size: 0x52
function powerup_state_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"powerup", fieldname, newval);
}

// Namespace zm_powerups
// Params 7, eflags: 0x1 linked
// namespace_22646992<file_0>::function_bf10c912
// Checksum 0x262aef0e, Offset: 0x568
// Size: 0x17c
function powerup_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        fx = level._effect["powerup_on"];
        break;
    case 2:
        fx = level._effect["powerup_on_solo"];
        break;
    case 3:
        fx = level._effect["powerup_on_red"];
        break;
    case 4:
        fx = level._effect["powerup_on_caution"];
        break;
    default:
        return;
    }
    if (!isdefined(fx)) {
        return;
    }
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.fx)) {
        stopfx(localclientnum, self.fx);
    }
    self.fx = playfxontag(localclientnum, fx, self, "tag_origin");
}

