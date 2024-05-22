#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_equipment;

// Namespace zm_equipment
// Params 0, eflags: 0x2
// Checksum 0x314f8b, Offset: 0x108
// Size: 0x34
function function_2dc19561() {
    system::register("zm_equipment", &__init__, undefined, undefined);
}

// Namespace zm_equipment
// Params 0, eflags: 0x1 linked
// Checksum 0x33123316, Offset: 0x148
// Size: 0x7c
function __init__() {
    level._equip_activated_callbacks = [];
    level.buildable_piece_count = 24;
    if (!(isdefined(level._no_equipment_activated_clientfield) && level._no_equipment_activated_clientfield)) {
        clientfield::register("scriptmover", "equipment_activated", 1, 4, "int", &equipment_activated_clientfield_cb, 1, 0);
    }
}

// Namespace zm_equipment
// Params 2, eflags: 0x0
// Checksum 0xd8d48200, Offset: 0x1d0
// Size: 0x26
function add_equip_activated_callback_override(model, func) {
    level._equip_activated_callbacks[model] = func;
}

// Namespace zm_equipment
// Params 7, eflags: 0x1 linked
// Checksum 0x3110322e, Offset: 0x200
// Size: 0x13a
function equipment_activated_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.model) && isdefined(level._equip_activated_callbacks[self.model])) {
        [[ level._equip_activated_callbacks[self.model] ]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    }
    if (!newval) {
        if (isdefined(self._equipment_activated_fx)) {
            for (i = 0; i < self._equipment_activated_fx.size; i++) {
                for (j = 0; j < self._equipment_activated_fx[i].size; j++) {
                    deletefx(i, self._equipment_activated_fx[i][j]);
                }
            }
            self._equipment_activated_fx = undefined;
        }
    }
}

// Namespace zm_equipment
// Params 4, eflags: 0x0
// Checksum 0x7593f261, Offset: 0x348
// Size: 0x2a6
function play_fx_for_all_clients(fx, tag, storehandles, forward) {
    if (!isdefined(storehandles)) {
        storehandles = 0;
    }
    if (!isdefined(forward)) {
        forward = undefined;
    }
    numlocalplayers = getlocalplayers().size;
    if (!isdefined(self._equipment_activated_fx)) {
        self._equipment_activated_fx = [];
        for (i = 0; i < numlocalplayers; i++) {
            self._equipment_activated_fx[i] = [];
        }
    }
    if (isdefined(tag)) {
        for (i = 0; i < numlocalplayers; i++) {
            if (storehandles) {
                self._equipment_activated_fx[i][self._equipment_activated_fx[i].size] = playfxontag(i, fx, self, tag);
                continue;
            }
            self_for_client = getentbynum(i, self getentitynumber());
            if (isdefined(self_for_client)) {
                playfxontag(i, fx, self_for_client, tag);
            }
        }
        return;
    }
    for (i = 0; i < numlocalplayers; i++) {
        if (storehandles) {
            if (isdefined(forward)) {
                self._equipment_activated_fx[i][self._equipment_activated_fx[i].size] = playfx(i, fx, self.origin, forward);
            } else {
                self._equipment_activated_fx[i][self._equipment_activated_fx[i].size] = playfx(i, fx, self.origin);
            }
            continue;
        }
        if (isdefined(forward)) {
            playfx(i, fx, self.origin, forward);
            continue;
        }
        playfx(i, fx, self.origin);
    }
}

// Namespace zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x80a7d5fa, Offset: 0x5f8
// Size: 0x36
function is_included(equipment) {
    if (!isdefined(level._included_equipment)) {
        return false;
    }
    return isdefined(level._included_equipment[equipment.rootweapon]);
}

// Namespace zm_equipment
// Params 1, eflags: 0x0
// Checksum 0x5e180a1f, Offset: 0x638
// Size: 0x5a
function include(equipment_name) {
    if (!isdefined(level._included_equipment)) {
        level._included_equipment = [];
    }
    equipment = getweapon(equipment_name);
    level._included_equipment[equipment] = equipment;
}

