#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace turret;

// Namespace turret
// Params 0, eflags: 0x2
// namespace_37b990db<file_0>::function_2dc19561
// Checksum 0x161d6694, Offset: 0x170
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("turret", &__init__, undefined, undefined);
}

// Namespace turret
// Params 0, eflags: 0x1 linked
// namespace_37b990db<file_0>::function_8c87d8eb
// Checksum 0x24bc1512, Offset: 0x1b0
// Size: 0x4c
function __init__() {
    clientfield::register("vehicle", "toggle_lensflare", 1, 1, "int", &field_toggle_lensflare, 0, 0);
}

// Namespace turret
// Params 7, eflags: 0x1 linked
// namespace_37b990db<file_0>::function_11a8f6e7
// Checksum 0x5d22dae, Offset: 0x208
// Size: 0x120
function field_toggle_lensflare(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.scriptbundlesettings)) {
        return;
    }
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    if (!isdefined(settings)) {
        return;
    }
    if (isdefined(self.turret_lensflare_id)) {
        deletefx(localclientnum, self.turret_lensflare_id);
        self.turret_lensflare_id = undefined;
    }
    if (newval) {
        if (isdefined(settings.lensflare_fx) && isdefined(settings.lensflare_tag)) {
            self.turret_lensflare_id = playfxontag(localclientnum, settings.lensflare_fx, self, settings.lensflare_tag);
        }
    }
}

