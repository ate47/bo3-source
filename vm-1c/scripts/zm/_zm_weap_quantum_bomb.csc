#using scripts/zm/_zm_weapons;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace zm_weap_quantum_bomb;

// Namespace zm_weap_quantum_bomb
// Params 0, eflags: 0x2
// Checksum 0x3333389c, Offset: 0x1d8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_quantum_bomb", &__init__, undefined, undefined);
}

// Namespace zm_weap_quantum_bomb
// Params 0, eflags: 0x1 linked
// Checksum 0x23d6b394, Offset: 0x218
// Size: 0x84
function __init__() {
    callback::add_weapon_type(getweapon("quantum_bomb"), &function_846d53b4);
    level._effect["quantum_bomb_viewmodel_twist"] = "dlc5/zmb_weapon/fx_twist";
    level._effect["quantum_bomb_viewmodel_press"] = "dlc5/zmb_weapon/fx_press";
    level thread function_1173d2d2();
}

// Namespace zm_weap_quantum_bomb
// Params 0, eflags: 0x1 linked
// Checksum 0x8d1f7953, Offset: 0x2a8
// Size: 0xba
function function_1173d2d2() {
    for (;;) {
        localclientnum, note = level waittill(#"notetrack");
        switch (note) {
        case "quantum_bomb_twist":
            playviewmodelfx(localclientnum, level._effect["quantum_bomb_viewmodel_twist"], "tag_weapon");
            break;
        case "quantum_bomb_press":
            playviewmodelfx(localclientnum, level._effect["quantum_bomb_viewmodel_press"], "tag_weapon");
            break;
        }
    }
}

// Namespace zm_weap_quantum_bomb
// Params 2, eflags: 0x1 linked
// Checksum 0xc30f72d7, Offset: 0x370
// Size: 0xac
function function_846d53b4(localclientnum, var_1778230f) {
    temp_ent = spawn(0, self.origin, "script_origin");
    temp_ent playloopsound("wpn_quantum_rise", 0.5);
    while (isdefined(self)) {
        temp_ent.origin = self.origin;
        wait 0.05;
    }
    temp_ent delete();
}

