#using scripts/codescripts/struct;

#namespace cp_doa_bo3_fx;

// Namespace cp_doa_bo3_fx
// Params 0, eflags: 0x0
// Checksum 0xd7edf776, Offset: 0x188
// Size: 0x7b
function main() {
    level._effect["raps_meteor_fire"] = "zombie/fx_meatball_trail_zmb";
    level._effect["lightning_raps_spawn"] = "zombie/fx_dog_lightning_buildup_zmb";
    level._effect["raps_gib"] = "zombie/fx_dog_explosion_zmb";
    level._effect["raps_trail_fire"] = "zombie/fx_raps_fire_trail_zmb";
    level._effect["raps_trail_ash"] = "zombie/fx_dog_ash_trail_zmb";
}

// Namespace cp_doa_bo3_fx
// Params 1, eflags: 0x0
// Checksum 0xd4ee48e2, Offset: 0x210
// Size: 0x42
function function_977dfbe0(origin) {
    playfx(level._effect["raps_gib"], origin);
    playsoundatposition("zmb_hellhound_explode", origin);
}

