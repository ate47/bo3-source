#using scripts/shared/ai/margwa;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace doa;

// Namespace doa
// Params 0, eflags: 0x1 linked
// namespace_30ddac33<file_0>::function_d290ebfa
// Checksum 0x99ec1590, Offset: 0x148
// Size: 0x4
function main() {
    
}

// Namespace doa
// Params 0, eflags: 0x0
// namespace_30ddac33<file_0>::function_90f0668f
// Checksum 0x99ec1590, Offset: 0x158
// Size: 0x4
function onprecachegametype() {
    
}

// Namespace doa
// Params 0, eflags: 0x0
// namespace_30ddac33<file_0>::function_34685338
// Checksum 0x99ec1590, Offset: 0x168
// Size: 0x4
function onstartgametype() {
    
}

// Namespace doa
// Params 0, eflags: 0x2
// namespace_30ddac33<file_0>::function_a106fbcc
// Checksum 0xcb77fdb7, Offset: 0x178
// Size: 0x13c
function autoexec ignore_systems() {
    system::ignore("cybercom");
    system::ignore("healthoverlay");
    system::ignore("challenges");
    system::ignore("rank");
    system::ignore("hacker_tool");
    system::ignore("grapple");
    system::ignore("replay_gun");
    system::ignore("riotshield");
    system::ignore("oed");
    system::ignore("explosive_bolt");
    system::ignore("empgrenade");
    system::ignore("spawning");
    system::ignore("save");
}

