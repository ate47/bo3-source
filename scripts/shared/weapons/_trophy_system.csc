#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#using_animtree("mp_trophy_system");

#namespace trophy_system;

// Namespace trophy_system
// Params 1, eflags: 0x1 linked
// Checksum 0x984c335, Offset: 0x1a8
// Size: 0x9c
function init_shared(localclientnum) {
    clientfield::register("missile", "trophy_system_state", 1, 2, "int", &trophy_state_change, 0, 1);
    clientfield::register("scriptmover", "trophy_system_state", 1, 2, "int", &trophy_state_change_recon, 0, 0);
}

// Namespace trophy_system
// Params 7, eflags: 0x1 linked
// Checksum 0x8aaa277b, Offset: 0x250
// Size: 0xde
function trophy_state_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    switch (newval) {
    case 1:
        self thread trophy_rolling_anim(localclientnum);
        break;
    case 2:
        self thread trophy_stationary_anim(localclientnum);
        break;
    case 3:
        break;
    case 0:
        break;
    }
}

// Namespace trophy_system
// Params 7, eflags: 0x1 linked
// Checksum 0x226fa8b2, Offset: 0x338
// Size: 0xde
function trophy_state_change_recon(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    switch (newval) {
    case 1:
        self thread trophy_rolling_anim(localclientnum);
        break;
    case 2:
        self thread trophy_stationary_anim(localclientnum);
        break;
    case 3:
        break;
    case 0:
        break;
    }
}

// Namespace trophy_system
// Params 1, eflags: 0x1 linked
// Checksum 0x5ac8d53d, Offset: 0x420
// Size: 0x5c
function trophy_rolling_anim(localclientnum) {
    self endon(#"entityshutdown");
    self useanimtree(#mp_trophy_system);
    self setanim(mp_trophy_system%o_trophy_deploy, 1);
}

// Namespace trophy_system
// Params 1, eflags: 0x1 linked
// Checksum 0x2afc6136, Offset: 0x488
// Size: 0x84
function trophy_stationary_anim(localclientnum) {
    self endon(#"entityshutdown");
    self useanimtree(#mp_trophy_system);
    self setanim(mp_trophy_system%o_trophy_deploy, 0);
    self setanim(mp_trophy_system%o_trophy_spin, 1);
}

