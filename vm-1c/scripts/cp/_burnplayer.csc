#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace burnplayer;

// Namespace burnplayer
// Params 0, eflags: 0x1 linked
// namespace_97b5406d<file_0>::function_63e16ac6
// Checksum 0x99ec1590, Offset: 0x140
// Size: 0x4
function function_63e16ac6() {
    
}

// Namespace burnplayer
// Params 1, eflags: 0x0
// namespace_97b5406d<file_0>::function_b071d8c
// Checksum 0x16dfc1bc, Offset: 0x150
// Size: 0x19c
function function_b071d8c(localclientnum) {
    self util::waittill_dobj(localclientnum);
    if (!isdefined(level._effect["character_fire_death_torso"])) {
        function_63e16ac6();
    }
    tagarray = [];
    tagarray[tagarray.size] = "J_Wrist_RI";
    tagarray[tagarray.size] = "J_Wrist_LE";
    tagarray[tagarray.size] = "J_Elbow_LE";
    tagarray[tagarray.size] = "J_Elbow_RI";
    tagarray[tagarray.size] = "J_Knee_RI";
    tagarray[tagarray.size] = "J_Knee_LE";
    tagarray[tagarray.size] = "J_Ankle_RI";
    tagarray[tagarray.size] = "J_Ankle_LE";
    if (isdefined(level._effect["character_fire_death_sm"])) {
        for (arrayindex = 0; arrayindex < tagarray.size; arrayindex++) {
            playfxontag(localclientnum, level._effect["character_fire_death_sm"], self, tagarray[arrayindex]);
        }
    }
    playfxontag(localclientnum, level._effect["character_fire_death_torso"], self, "J_SpineLower");
}

