#using scripts/shared/ai_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace _zm_ai_monkey;

// Namespace _zm_ai_monkey
// Params 0, eflags: 0x2
// Checksum 0x1aff4f1b, Offset: 0x130
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("monkey", &__init__, undefined, undefined);
}

// Namespace _zm_ai_monkey
// Params 0, eflags: 0x0
// Checksum 0xf6fe3408, Offset: 0x170
// Size: 0x8e
function __init__() {
    ai::add_archetype_spawn_function("monkey", &function_70fb871f);
    clientfield::register("actor", "monkey_eye_glow", 21000, 1, "int", &function_2e74dabc, 0, 0);
    level._effect["monkey_eye_glow"] = "dlc5/zmhd/fx_zmb_monkey_eyes";
}

// Namespace _zm_ai_monkey
// Params 1, eflags: 0x4
// Checksum 0x19f02544, Offset: 0x208
// Size: 0x24
function private function_70fb871f(localclientnum) {
    self function_ec8b2835(1);
}

// Namespace _zm_ai_monkey
// Params 7, eflags: 0x0
// Checksum 0x2d016d55, Offset: 0x238
// Size: 0x158
function function_2e74dabc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        waittillframeend();
        if (!isdefined(self)) {
            return;
        }
        var_f9e79b00 = self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 3, 0);
        self._eyearray[localclientnum] = playfxontag(localclientnum, level._effect["monkey_eye_glow"], self, "j_eyeball_le");
        return;
    }
    waittillframeend();
    if (!isdefined(self)) {
        return;
    }
    var_f9e79b00 = self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 3, 0);
    if (isdefined(self._eyearray)) {
        if (isdefined(self._eyearray[localclientnum])) {
            deletefx(localclientnum, self._eyearray[localclientnum], 1);
            self._eyearray[localclientnum] = undefined;
        }
    }
}

