#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace destructible;

// Namespace destructible
// Params 0, eflags: 0x2
// Checksum 0x538cbb1b, Offset: 0x100
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("destructible", &__init__, undefined, undefined);
}

// Namespace destructible
// Params 0, eflags: 0x0
// Checksum 0x6f3eb909, Offset: 0x138
// Size: 0x3a
function __init__() {
    clientfield::register("scriptmover", "start_destructible_explosion", 1, 10, "int", &doexplosion, 0, 0);
}

// Namespace destructible
// Params 7, eflags: 0x0
// Checksum 0xfe9f8051, Offset: 0x180
// Size: 0x9a
function playgrenaderumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playrumbleonposition(localclientnum, "grenade_rumble", self.origin);
    getlocalplayer(localclientnum) earthquake(0.5, 0.5, self.origin, 800);
}

// Namespace destructible
// Params 7, eflags: 0x0
// Checksum 0xf0280dd3, Offset: 0x228
// Size: 0x5c
function doexplosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        return;
    }
    physics_explosion = 0;
    InvalidOpCode(0xc1, 9, 1, newval);
    // Unknown operator (0xc1, t7_1b, PC)
}

