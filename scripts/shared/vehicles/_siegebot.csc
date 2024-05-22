#using scripts/shared/weapons/spike_charge_siegebot;
#using scripts/shared/callbacks_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace siegebot;

// Namespace siegebot
// Params 0, eflags: 0x2
// Checksum 0x17543661, Offset: 0x178
// Size: 0x2c
function main() {
    vehicle::add_vehicletype_callback("siegebot", &_setup_);
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0x905b8876, Offset: 0x1b0
// Size: 0x54
function _setup_(localclientnum) {
    if (isdefined(self.scriptbundlesettings)) {
        settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    }
    if (!isdefined(settings)) {
        return;
    }
}

