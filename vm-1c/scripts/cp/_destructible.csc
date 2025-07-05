#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace destructible;

// Namespace destructible
// Params 0, eflags: 0x2
// Checksum 0x183d495f, Offset: 0x100
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("destructible", &__init__, undefined, undefined);
}

// Namespace destructible
// Params 0, eflags: 0x0
// Checksum 0x5fc646db, Offset: 0x140
// Size: 0x4c
function __init__() {
    clientfield::register("scriptmover", "start_destructible_explosion", 1, 11, "int", &doexplosion, 0, 0);
}

// Namespace destructible
// Params 2, eflags: 0x0
// Checksum 0x69261b71, Offset: 0x198
// Size: 0x74
function playgrenaderumble(localclientnum, position) {
    playrumbleonposition(localclientnum, "grenade_rumble", position);
    getlocalplayer(localclientnum) earthquake(0.5, 0.5, position, 800);
}

// Namespace destructible
// Params 7, eflags: 0x0
// Checksum 0x38a4089c, Offset: 0x218
// Size: 0x1a4
function doexplosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        return;
    }
    var_824b40e2 = newval & 1 << 10;
    if (var_824b40e2) {
        newval -= 1 << 10;
    }
    physics_force = 0.3;
    var_34aa7e9b = newval & 1 << 9;
    if (var_34aa7e9b) {
        physics_force = 0.5;
        newval -= 1 << 9;
    }
    if (isdefined(var_824b40e2) && var_824b40e2) {
        physicsexplosionsphere(localclientnum, self.origin, newval, newval / 2, physics_force, 25, 400);
    } else {
        physicsexplosionsphere(localclientnum, self.origin, newval, newval - 1, physics_force, 25, 400);
    }
    playgrenaderumble(localclientnum, self.origin);
    soundrattle(self.origin, -56, 800);
}

