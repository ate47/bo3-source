#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace claymore;

// Namespace claymore
// Params 0, eflags: 0x2
// Checksum 0x46d1c433, Offset: 0x150
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("claymore", &__init__, undefined, undefined);
}

// Namespace claymore
// Params 1, eflags: 0x0
// Checksum 0x6ee18b1b, Offset: 0x188
// Size: 0x4a
function __init__(localclientnum) {
    level._effect["fx_claymore_laser"] = "_t6/weapon/claymore/fx_claymore_laser";
    callback::add_weapon_type("claymore", &spawned);
}

// Namespace claymore
// Params 1, eflags: 0x0
// Checksum 0xcfb582c7, Offset: 0x1e0
// Size: 0x9d
function spawned(localclientnum) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    while (true) {
        if (isdefined(self.stunned) && self.stunned) {
            wait 0.1;
            continue;
        }
        self.claymorelaserfxid = playfxontag(localclientnum, level._effect["fx_claymore_laser"], self, "tag_fx");
        self waittill(#"stunned");
        stopfx(localclientnum, self.claymorelaserfxid);
    }
}

