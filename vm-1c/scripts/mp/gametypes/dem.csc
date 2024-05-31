#using scripts/mp/gametypes/_globallogic;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace dem;

// Namespace dem
// Params 0, eflags: 0x0
// namespace_f4fa22d9<file_0>::function_d290ebfa
// Checksum 0xd2ce7fd9, Offset: 0xf8
// Size: 0x64
function main() {
    callback::on_spawned(&on_player_spawned);
    if (getgametypesetting("silentPlant") != 0) {
        setsoundcontext("bomb_plant", "silent");
    }
}

// Namespace dem
// Params 0, eflags: 0x0
// namespace_f4fa22d9<file_0>::function_90f0668f
// Checksum 0x99ec1590, Offset: 0x168
// Size: 0x4
function onprecachegametype() {
    
}

// Namespace dem
// Params 0, eflags: 0x0
// namespace_f4fa22d9<file_0>::function_34685338
// Checksum 0x99ec1590, Offset: 0x178
// Size: 0x4
function onstartgametype() {
    
}

// Namespace dem
// Params 1, eflags: 0x0
// namespace_f4fa22d9<file_0>::function_aebcf025
// Checksum 0x6fa62e24, Offset: 0x188
// Size: 0x24
function on_player_spawned(localclientnum) {
    self thread globallogic::function_17f0b9e4(localclientnum);
}

