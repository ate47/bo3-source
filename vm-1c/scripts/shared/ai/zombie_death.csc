#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace zombie_death;

// Namespace zombie_death
// Params 0, eflags: 0x2
// Checksum 0x70598e7a, Offset: 0x180
// Size: 0x5a
function autoexec init_fire_fx() {
    wait(0.016);
    if (!isdefined(level._effect)) {
        level._effect = [];
    }
    level._effect["character_fire_death_sm"] = "zombie/fx_fire_torso_zmb";
    level._effect["character_fire_death_torso"] = "zombie/fx_fire_torso_zmb";
}

// Namespace zombie_death
// Params 1, eflags: 0x1 linked
// Checksum 0xeb2011aa, Offset: 0x1e8
// Size: 0x5e
function on_fire_timeout(localclientnum) {
    self endon(#"death");
    self endon(#"entityshutdown");
    wait(12);
    if (isdefined(self) && isalive(self)) {
        self.is_on_fire = 0;
        self notify(#"stop_flame_damage");
    }
}

// Namespace zombie_death
// Params 1, eflags: 0x1 linked
// Checksum 0xdadb1011, Offset: 0x250
// Size: 0x334
function flame_death_fx(localclientnum) {
    self endon(#"death");
    self endon(#"entityshutdown");
    if (isdefined(self.is_on_fire) && self.is_on_fire) {
        return;
    }
    self.is_on_fire = 1;
    self thread on_fire_timeout();
    if (isdefined(level._effect) && isdefined(level._effect["character_fire_death_torso"])) {
        fire_tag = "j_spinelower";
        if (!isdefined(self gettagorigin(fire_tag))) {
            fire_tag = "tag_origin";
        }
        if (!isdefined(self.isdog) || !self.isdog) {
            playfxontag(localclientnum, level._effect["character_fire_death_torso"], self, fire_tag);
        }
    } else {
        println("J_Elbow_RI");
    }
    if (isdefined(level._effect) && isdefined(level._effect["character_fire_death_sm"])) {
        if (self.archetype !== "parasite" && self.archetype !== "raps") {
            wait(1);
            tagarray = [];
            tagarray[0] = "J_Elbow_LE";
            tagarray[1] = "J_Elbow_RI";
            tagarray[2] = "J_Knee_RI";
            tagarray[3] = "J_Knee_LE";
            tagarray = randomize_array(tagarray);
            playfxontag(localclientnum, level._effect["character_fire_death_sm"], self, tagarray[0]);
            wait(1);
            tagarray[0] = "J_Wrist_RI";
            tagarray[1] = "J_Wrist_LE";
            if (!(isdefined(self.missinglegs) && self.missinglegs)) {
                tagarray[2] = "J_Ankle_RI";
                tagarray[3] = "J_Ankle_LE";
            }
            tagarray = randomize_array(tagarray);
            playfxontag(localclientnum, level._effect["character_fire_death_sm"], self, tagarray[0]);
            playfxontag(localclientnum, level._effect["character_fire_death_sm"], self, tagarray[1]);
        }
        return;
    }
    println("J_Elbow_RI");
}

// Namespace zombie_death
// Params 1, eflags: 0x1 linked
// Checksum 0x9fdf39c8, Offset: 0x590
// Size: 0x9c
function randomize_array(array) {
    for (i = 0; i < array.size; i++) {
        j = randomint(array.size);
        temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    return array;
}

