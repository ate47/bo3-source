#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace decoy;

// Namespace decoy
// Params 0, eflags: 0x1 linked
// namespace_b97178f7<file_0>::function_1463e4e5
// Checksum 0x9c1b8c04, Offset: 0xf8
// Size: 0x44
function init_shared() {
    level thread function_e678919e();
    callback::add_weapon_type("nightingale", &spawned);
}

// Namespace decoy
// Params 1, eflags: 0x1 linked
// namespace_b97178f7<file_0>::function_ab1f9ea1
// Checksum 0x32f989bd, Offset: 0x148
// Size: 0x24
function spawned(localclientnum) {
    self thread function_7756ea79(localclientnum);
}

// Namespace decoy
// Params 1, eflags: 0x1 linked
// namespace_b97178f7<file_0>::function_7756ea79
// Checksum 0x346133b7, Offset: 0x178
// Size: 0x60
function function_7756ea79(localclientnum) {
    self endon(#"entityshutdown");
    while (true) {
        self waittill(#"fake_fire");
        playfxontag(localclientnum, level._effect["decoy_fire"], self, "tag_origin");
    }
}

// Namespace decoy
// Params 0, eflags: 0x1 linked
// namespace_b97178f7<file_0>::function_e678919e
// Checksum 0xecbe9d4f, Offset: 0x1e0
// Size: 0x28
function function_e678919e() {
    while (true) {
        origin = self waittill(#"fake_fire");
    }
}

