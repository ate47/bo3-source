#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace parasite;

// Namespace parasite
// Params 0, eflags: 0x2
// Checksum 0x8ee26695, Offset: 0x270
// Size: 0x104
function autoexec main() {
    clientfield::register("vehicle", "parasite_tell_fx", 1, 1, "int", &function_efb89eff, 0, 0);
    clientfield::register("toplayer", "parasite_damage", 1, 1, "counter", &parasite_damage, 0, 0);
    clientfield::register("vehicle", "parasite_secondary_deathfx", 1, 1, "int", &function_a6b394f4, 0, 0);
    vehicle::add_vehicletype_callback("parasite", &_setup_);
}

// Namespace parasite
// Params 7, eflags: 0x5 linked
// Checksum 0xbd1acd9c, Offset: 0x380
// Size: 0x12c
function private function_efb89eff(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (isdefined(self.var_ed1c01ec)) {
        stopfx(localclientnum, self.var_ed1c01ec);
        self.var_ed1c01ec = undefined;
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0.1);
    }
    settings = struct::get_script_bundle("vehiclecustomsettings", "parasitesettings");
    if (isdefined(settings)) {
        if (newvalue) {
            self.var_ed1c01ec = playfxontag(localclientnum, settings.weakspotfx, self, "tag_flash");
            self mapshaderconstant(localclientnum, 0, "scriptVector2", 1);
        }
    }
}

// Namespace parasite
// Params 7, eflags: 0x5 linked
// Checksum 0x4aff30da, Offset: 0x4b8
// Size: 0x64
function private parasite_damage(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self postfx::playpostfxbundle("pstfx_parasite_dmg");
    }
}

// Namespace parasite
// Params 7, eflags: 0x5 linked
// Checksum 0xcf923992, Offset: 0x528
// Size: 0xe4
function private function_a6b394f4(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    settings = struct::get_script_bundle("vehiclecustomsettings", "parasitesettings");
    if (isdefined(settings)) {
        if (newvalue) {
            handle = playfx(localclientnum, settings.secondary_death_fx_1, self gettagorigin(settings.secondary_death_tag_1));
            setfxignorepause(localclientnum, handle, 1);
        }
    }
}

// Namespace parasite
// Params 1, eflags: 0x5 linked
// Checksum 0x9bea6617, Offset: 0x618
// Size: 0x84
function private _setup_(localclientnum) {
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0.1);
    if (isdefined(level.debug_keyline_zombies) && level.debug_keyline_zombies) {
        self duplicate_render::set_dr_flag("keyline_active", 1);
        self duplicate_render::update_dr_filters(localclientnum);
    }
}

