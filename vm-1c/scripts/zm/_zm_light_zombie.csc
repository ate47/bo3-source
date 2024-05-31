#using scripts/zm/_zm_elemental_zombies;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/array_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/ai_shared;

#namespace namespace_6727c59c;

// Namespace namespace_6727c59c
// Params 0, eflags: 0x2
// namespace_6727c59c<file_0>::function_2dc19561
// Checksum 0xb1b5eb6e, Offset: 0x2f0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_light_zombie", &__init__, undefined, undefined);
}

// Namespace namespace_6727c59c
// Params 0, eflags: 0x1 linked
// namespace_6727c59c<file_0>::function_8c87d8eb
// Checksum 0x57c1363b, Offset: 0x330
// Size: 0x24
function __init__() {
    init_fx();
    register_clientfields();
}

// Namespace namespace_6727c59c
// Params 0, eflags: 0x1 linked
// namespace_6727c59c<file_0>::function_f53e79d4
// Checksum 0x40a47149, Offset: 0x360
// Size: 0x56
function init_fx() {
    level._effect["light_zombie_fx"] = "dlc1/zmb_weapon/fx_bow_wolf_wrap_torso";
    level._effect["light_zombie_suicide"] = "explosions/fx_exp_grenade_flshbng";
    level._effect["dlc1/zmb_weapon/fx_bow_wolf_impact_zm"] = "lihgt_zombie_damage_fx";
}

// Namespace namespace_6727c59c
// Params 0, eflags: 0x1 linked
// namespace_6727c59c<file_0>::function_4ece4a2f
// Checksum 0xfd5b8fd5, Offset: 0x3c0
// Size: 0xdc
function register_clientfields() {
    clientfield::register("actor", "light_zombie_clientfield_aura_fx", 15000, 1, "int", &function_98e8bc87, 0, 0);
    clientfield::register("actor", "light_zombie_clientfield_death_fx", 15000, 1, "int", &function_9127e2f8, 0, 0);
    clientfield::register("actor", "light_zombie_clientfield_damaged_fx", 15000, 1, "counter", &function_ad4789b4, 0, 0);
}

// Namespace namespace_6727c59c
// Params 7, eflags: 0x1 linked
// namespace_6727c59c<file_0>::function_9127e2f8
// Checksum 0xd3c8763, Offset: 0x4a8
// Size: 0x98
function function_9127e2f8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval !== newval && newval === 1) {
        fx = playfxontag(localclientnum, level._effect["light_zombie_suicide"], self, "j_spineupper");
    }
}

// Namespace namespace_6727c59c
// Params 7, eflags: 0x1 linked
// namespace_6727c59c<file_0>::function_ad4789b4
// Checksum 0x19e4adf, Offset: 0x548
// Size: 0x144
function function_ad4789b4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        if (isdefined(level._effect["dlc1/zmb_weapon/fx_bow_wolf_impact_zm"])) {
            playsound(localclientnum, "gdt_electro_bounce", self.origin);
            locs = array("j_wrist_le", "j_wrist_ri");
            fx = playfxontag(localclientnum, level._effect["dlc1/zmb_weapon/fx_bow_wolf_impact_zm"], self, array::random(locs));
            setfxignorepause(localclientnum, fx, 1);
        }
    }
}

// Namespace namespace_6727c59c
// Params 7, eflags: 0x1 linked
// namespace_6727c59c<file_0>::function_98e8bc87
// Checksum 0x577939d8, Offset: 0x698
// Size: 0xac
function function_98e8bc87(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    if (newval == 1) {
        fx = playfxontag(localclientnum, level._effect["light_zombie_fx"], self, "j_spineupper");
        setfxignorepause(localclientnum, fx, 1);
    }
}

