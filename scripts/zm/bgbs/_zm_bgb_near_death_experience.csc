#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_near_death_experience;

// Namespace zm_bgb_near_death_experience
// Params 0, eflags: 0x2
// Checksum 0xad32b558, Offset: 0x220
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_near_death_experience", &__init__, undefined, undefined);
}

// Namespace zm_bgb_near_death_experience
// Params 0, eflags: 0x1 linked
// Checksum 0xa21b77b, Offset: 0x260
// Size: 0xd8
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    clientfield::register("allplayers", "zm_bgb_near_death_experience_3p_fx", 15000, 1, "int", &function_24480126, 0, 0);
    clientfield::register("toplayer", "zm_bgb_near_death_experience_1p_fx", 15000, 1, "int", &function_11972f24, 0, 1);
    bgb::register("zm_bgb_near_death_experience", "rounds");
    level.var_3b53e98b = [];
}

// Namespace zm_bgb_near_death_experience
// Params 7, eflags: 0x1 linked
// Checksum 0xf9b89d2f, Offset: 0x340
// Size: 0x128
function function_24480126(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    e_local_player = getlocalplayer(localclientnum);
    if (newval) {
        if (e_local_player != self) {
            if (!isdefined(self.var_6b39dbae)) {
                self.var_6b39dbae = [];
            }
            if (isdefined(self.var_6b39dbae[localclientnum])) {
                return;
            }
            self.var_6b39dbae[localclientnum] = playfxontag(localclientnum, "zombie/fx_bgb_near_death_3p", self, "j_spine4");
        }
        return;
    }
    if (isdefined(self.var_6b39dbae) && isdefined(self.var_6b39dbae[localclientnum])) {
        stopfx(localclientnum, self.var_6b39dbae[localclientnum]);
        self.var_6b39dbae[localclientnum] = undefined;
    }
}

// Namespace zm_bgb_near_death_experience
// Params 7, eflags: 0x1 linked
// Checksum 0xc232c717, Offset: 0x470
// Size: 0xf8
function function_11972f24(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(level.var_3b53e98b[localclientnum])) {
            deletefx(localclientnum, level.var_3b53e98b[localclientnum]);
        }
        level.var_3b53e98b[localclientnum] = playfxoncamera(localclientnum, "zombie/fx_bgb_near_death_1p", (0, 0, 0), (1, 0, 0));
        return;
    }
    if (isdefined(level.var_3b53e98b[localclientnum])) {
        stopfx(localclientnum, level.var_3b53e98b[localclientnum]);
        level.var_3b53e98b[localclientnum] = undefined;
    }
}

