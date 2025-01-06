#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace siegebot_theia;

// Namespace siegebot_theia
// Params 0, eflags: 0x2
// Checksum 0x4285e9fe, Offset: 0x1c8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("siegebot_theia", &__init__, undefined, undefined);
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0x52e56a4, Offset: 0x208
// Size: 0xbc
function __init__() {
    vehicle::add_vehicletype_callback("siegebot_theia", &_setup_);
    clientfield::register("vehicle", "sarah_rumble_on_landing", 1, 1, "counter", &sarah_rumble_on_landing, 0, 0);
    clientfield::register("vehicle", "sarah_minigun_spin", 1, 1, "int", &sarah_minigun_spin, 0, 0);
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xe21ac90a, Offset: 0x2d0
// Size: 0xc
function _setup_(localclientnum) {
    
}

// Namespace siegebot_theia
// Params 7, eflags: 0x0
// Checksum 0x77e99373, Offset: 0x2e8
// Size: 0x5c
function sarah_rumble_on_landing(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self playrumbleonentity(localclientnum, "cp_infection_sarah_battle_land");
}

// Namespace siegebot_theia
// Params 7, eflags: 0x0
// Checksum 0xeae09a0, Offset: 0x350
// Size: 0xec
function sarah_minigun_spin(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.scriptbundlesettings)) {
        return;
    }
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    if (!isdefined(settings)) {
        return;
    }
    if (isdefined(self.var_2e47b303)) {
        deletefx(localclientnum, self.var_2e47b303);
    }
    if (newval) {
        self.var_2e47b303 = playfxontag(localclientnum, settings.spin, self, settings.tag_spin);
    }
}

