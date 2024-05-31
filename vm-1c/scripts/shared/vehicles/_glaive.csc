#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace glaive;

// Namespace glaive
// Params 0, eflags: 0x2
// Checksum 0xcbdf1820, Offset: 0x1b0
// Size: 0x4c
function autoexec main() {
    clientfield::register("vehicle", "glaive_blood_fx", 1, 1, "int", &function_9e7195d7, 0, 0);
}

// Namespace glaive
// Params 7, eflags: 0x4
// Checksum 0x4f87c05d, Offset: 0x208
// Size: 0xdc
function private function_9e7195d7(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (isdefined(self.var_75b4710b)) {
        stopfx(localclientnum, self.var_75b4710b);
        self.var_75b4710b = undefined;
    }
    settings = struct::get_script_bundle("vehiclecustomsettings", "glaivesettings");
    if (isdefined(settings)) {
        if (newvalue) {
            self.var_75b4710b = playfxontag(localclientnum, settings.weakspotfx, self, "j_spineupper");
        }
    }
}

