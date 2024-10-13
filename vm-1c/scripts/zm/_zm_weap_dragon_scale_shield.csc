#using scripts/zm/_zm_weap_dragon_strike;
#using scripts/zm/_zm_weapons;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_8215525;

// Namespace namespace_8215525
// Params 0, eflags: 0x2
// Checksum 0x10f48560, Offset: 0x320
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_dragonshield", &__init__, undefined, undefined);
}

// Namespace namespace_8215525
// Params 0, eflags: 0x1 linked
// Checksum 0xc700c34f, Offset: 0x360
// Size: 0x1fc
function __init__() {
    clientfield::register("allplayers", "ds_ammo", 12000, 1, "int", &function_3b8ce539, 0, 0);
    clientfield::register("allplayers", "burninate", 12000, 1, "counter", &function_adc7474a, 0, 0);
    clientfield::register("allplayers", "burninate_upgraded", 12000, 1, "counter", &function_627dd7e5, 0, 0);
    clientfield::register("actor", "dragonshield_snd_projectile_impact", 12000, 1, "counter", &dragonshield_snd_projectile_impact, 0, 0);
    clientfield::register("vehicle", "dragonshield_snd_projectile_impact", 12000, 1, "counter", &dragonshield_snd_projectile_impact, 0, 0);
    clientfield::register("actor", "dragonshield_snd_zombie_knockdown", 12000, 1, "counter", &dragonshield_snd_zombie_knockdown, 0, 0);
    clientfield::register("vehicle", "dragonshield_snd_zombie_knockdown", 12000, 1, "counter", &dragonshield_snd_zombie_knockdown, 0, 0);
}

// Namespace namespace_8215525
// Params 7, eflags: 0x1 linked
// Checksum 0x9be36c85, Offset: 0x568
// Size: 0xa4
function function_3b8ce539(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 0, 0);
        return;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
}

// Namespace namespace_8215525
// Params 7, eflags: 0x1 linked
// Checksum 0x78f8c129, Offset: 0x618
// Size: 0xa4
function function_adc7474a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self islocalplayer()) {
        playfxontag(localclientnum, "dlc3/stalingrad/fx_dragon_shield_fire_1p", self, "tag_flash");
        return;
    }
    playfxontag(localclientnum, "dlc3/stalingrad/fx_dragon_shield_fire_3p", self, "tag_flash");
}

// Namespace namespace_8215525
// Params 7, eflags: 0x1 linked
// Checksum 0xd1abdacd, Offset: 0x6c8
// Size: 0xa4
function function_627dd7e5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self islocalplayer()) {
        playfxontag(localclientnum, "dlc3/stalingrad/fx_dragon_shield_fire_1p_up", self, "tag_flash");
        return;
    }
    playfxontag(localclientnum, "dlc3/stalingrad/fx_dragon_shield_fire_3p_up", self, "tag_flash");
}

// Namespace namespace_8215525
// Params 7, eflags: 0x1 linked
// Checksum 0x221ee2b3, Offset: 0x778
// Size: 0x8c
function dragonshield_snd_projectile_impact(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playsound(localclientnum, "vox_dragonshield_forcehit", self.origin);
    playsound(localclientnum, "wpn_dragonshield_proj_impact", self.origin);
}

// Namespace namespace_8215525
// Params 7, eflags: 0x1 linked
// Checksum 0x6d37b590, Offset: 0x810
// Size: 0x64
function dragonshield_snd_zombie_knockdown(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playsound(localclientnum, "fly_dragonshield_forcehit", self.origin);
}

