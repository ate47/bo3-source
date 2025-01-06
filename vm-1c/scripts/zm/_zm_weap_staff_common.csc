#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace zm_weap_staff;

// Namespace zm_weap_staff
// Params 0, eflags: 0x2
// Checksum 0xd504e4ef, Offset: 0x120
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_staff", &__init__, undefined, undefined);
}

// Namespace zm_weap_staff
// Params 0, eflags: 0x0
// Checksum 0x22c0e03f, Offset: 0x160
// Size: 0x34
function __init__() {
    level.var_27b5be99 = [];
    callback::on_localplayer_spawned(&function_d10163c2);
}

// Namespace zm_weap_staff
// Params 2, eflags: 0x0
// Checksum 0x2cd8922, Offset: 0x1a0
// Size: 0x26
function function_4be5e665(w_weapon, fx) {
    level.var_27b5be99[w_weapon] = fx;
}

// Namespace zm_weap_staff
// Params 1, eflags: 0x0
// Checksum 0xc7652c7a, Offset: 0x1d0
// Size: 0xb8
function function_d10163c2(localclientnum) {
    self notify(#"hash_d10163c2");
    self endon(#"hash_d10163c2");
    self endon(#"entityshutdown");
    while (isdefined(self)) {
        self waittill(#"weapon_change", w_weapon);
        self notify(#"hash_d4c51f0");
        self function_d4c51f0(localclientnum);
        if (isdefined(level.var_27b5be99[w_weapon])) {
            self thread function_2b18ce1b(localclientnum, level.var_27b5be99[w_weapon]);
        }
    }
}

// Namespace zm_weap_staff
// Params 2, eflags: 0x0
// Checksum 0x207fdc2b, Offset: 0x290
// Size: 0xb0
function function_2b18ce1b(localclientnum, fx) {
    self endon(#"hash_d4c51f0");
    while (isdefined(self)) {
        charge = getweaponchargelevel(localclientnum);
        if (charge > 0) {
            if (!isdefined(self.var_2a76e26)) {
                self.var_2a76e26 = playviewmodelfx(localclientnum, fx, "tag_fx_upg_1");
            }
        } else {
            function_d4c51f0(localclientnum);
        }
        wait 0.15;
    }
}

// Namespace zm_weap_staff
// Params 1, eflags: 0x0
// Checksum 0x1854de80, Offset: 0x348
// Size: 0x3e
function function_d4c51f0(localclientnum) {
    if (isdefined(self.var_2a76e26)) {
        stopfx(localclientnum, self.var_2a76e26);
        self.var_2a76e26 = undefined;
    }
}

