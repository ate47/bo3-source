#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace client_flag;

// Namespace client_flag
// Params 0, eflags: 0x2
// Checksum 0x27c4d154, Offset: 0xf8
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("client_flag", &__init__, undefined, undefined);
}

// Namespace client_flag
// Params 0, eflags: 0x0
// Checksum 0xebd038f0, Offset: 0x130
// Size: 0x3a
function __init__() {
    clientfield::register("scriptmover", "ctf_flag_away", 1, 1, "int", &setctfaway, 0, 0);
}

// Namespace client_flag
// Params 7, eflags: 0x0
// Checksum 0x74c800ff, Offset: 0x178
// Size: 0x7a
function setctfaway(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    team = self.team;
    setflagasaway(localclientnum, team, newval);
    self thread clearctfaway(localclientnum, team);
}

// Namespace client_flag
// Params 2, eflags: 0x0
// Checksum 0xef8b1955, Offset: 0x200
// Size: 0x32
function clearctfaway(localclientnum, team) {
    self waittill(#"entityshutdown");
    setflagasaway(localclientnum, team, 0);
}

