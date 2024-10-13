#using scripts/zm/_zm;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_ai_dogs;

// Namespace zm_ai_dogs
// Params 0, eflags: 0x2
// Checksum 0x1425f877, Offset: 0x168
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_ai_dogs", &__init__, undefined, undefined);
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x1 linked
// Checksum 0xdd2a52a2, Offset: 0x1a8
// Size: 0x5c
function __init__() {
    init_dog_fx();
    clientfield::register("actor", "dog_fx", 1, 1, "int", &dog_fx, 0, 0);
}

// Namespace zm_ai_dogs
// Params 0, eflags: 0x1 linked
// Checksum 0x9e597015, Offset: 0x210
// Size: 0x3a
function init_dog_fx() {
    level._effect["dog_eye_glow"] = "zombie/fx_dog_eyes_zmb";
    level._effect["dog_trail_fire"] = "zombie/fx_dog_fire_trail_zmb";
}

// Namespace zm_ai_dogs
// Params 7, eflags: 0x1 linked
// Checksum 0x75951ed4, Offset: 0x258
// Size: 0x17c
function dog_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self._eyeglow_fx_override = level._effect["dog_eye_glow"];
        self zm::createzombieeyes(localclientnum);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, zm::get_eyeball_on_luminance(), self zm::get_eyeball_color());
        self.var_a1ba564c = playfxontag(localclientnum, level._effect["dog_trail_fire"], self, "j_spine2");
        return;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, zm::get_eyeball_off_luminance(), self zm::get_eyeball_color());
    self zm::deletezombieeyes(localclientnum);
    if (isdefined(self.var_a1ba564c)) {
        deletefx(localclientnum, self.var_a1ba564c);
    }
}

