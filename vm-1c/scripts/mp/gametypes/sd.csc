#using scripts/mp/gametypes/_globallogic;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace sd;

// Namespace sd
// Params 0, eflags: 0x0
// namespace_baf39230<file_0>::function_d290ebfa
// Checksum 0xfdd46164, Offset: 0xf8
// Size: 0x64
function main() {
    callback::on_spawned(&on_player_spawned);
    if (getgametypesetting("silentPlant") != 0) {
        setsoundcontext("bomb_plant", "silent");
    }
}

// Namespace sd
// Params 0, eflags: 0x0
// namespace_baf39230<file_0>::function_34685338
// Checksum 0x99ec1590, Offset: 0x168
// Size: 0x4
function onstartgametype() {
    
}

// Namespace sd
// Params 1, eflags: 0x0
// namespace_baf39230<file_0>::function_aebcf025
// Checksum 0x8be7ef9, Offset: 0x178
// Size: 0x3c
function on_player_spawned(localclientnum) {
    self thread function_63fb1af2();
    self thread globallogic::function_17f0b9e4(localclientnum);
}

// Namespace sd
// Params 0, eflags: 0x0
// namespace_baf39230<file_0>::function_63fb1af2
// Checksum 0x40b028a5, Offset: 0x1c0
// Size: 0x7e
function function_63fb1af2() {
    if (getgametypesetting("silentPlant") != 0) {
        self endon(#"entityshutdown");
        self notify(#"hash_63fb1af2");
        self endon(#"hash_63fb1af2");
        while (true) {
            self setsoundentcontext("bomb_plant", "silent");
            wait(1);
        }
    }
}

