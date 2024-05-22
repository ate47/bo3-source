#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace client_flag;

// Namespace client_flag
// Params 0, eflags: 0x2
// Checksum 0x983df1c2, Offset: 0xf8
// Size: 0x34
function function_2dc19561() {
    system::register("client_flag", &__init__, undefined, undefined);
}

// Namespace client_flag
// Params 0, eflags: 0x1 linked
// Checksum 0x812ff7f, Offset: 0x138
// Size: 0x4c
function __init__() {
    clientfield::register("scriptmover", "ctf_flag_away", 1, 1, "int", &setctfaway, 0, 0);
}

// Namespace client_flag
// Params 7, eflags: 0x1 linked
// Checksum 0xf37fb99f, Offset: 0x190
// Size: 0x8c
function setctfaway(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    team = self.team;
    setflagasaway(localclientnum, team, newval);
    self thread clearctfaway(localclientnum, team);
}

// Namespace client_flag
// Params 2, eflags: 0x1 linked
// Checksum 0x4a4f0902, Offset: 0x228
// Size: 0x3c
function clearctfaway(localclientnum, team) {
    self waittill(#"entityshutdown");
    setflagasaway(localclientnum, team, 0);
}

