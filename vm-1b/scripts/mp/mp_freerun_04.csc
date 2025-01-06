#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_freerun_04_fx;
#using scripts/mp/mp_freerun_04_sound;
#using scripts/shared/callbacks_shared;
#using scripts/shared/util_shared;

#namespace mp_freerun_04;

// Namespace mp_freerun_04
// Params 0, eflags: 0x0
// Checksum 0x43447689, Offset: 0x1b0
// Size: 0xaa
function main() {
    mp_freerun_04_fx::main();
    mp_freerun_04_sound::main();
    level._effect["blood_rain"] = "weather/fx_rain_blood_player_freerun_loop";
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
    load::main();
    util::waitforclient(0);
    callback::on_localplayer_spawned(&player_rain);
}

// Namespace mp_freerun_04
// Params 1, eflags: 0x0
// Checksum 0x8895c145, Offset: 0x268
// Size: 0xba
function player_rain(localclientnum) {
    self.e_link = spawn(localclientnum, self.origin, "script_model");
    self.e_link setmodel("tag_origin");
    self.e_link.angles = self.angles;
    self.e_link linkto(self);
    self.var_88aec2ed = playfxontag(localclientnum, level._effect["blood_rain"], self.e_link, "tag_origin");
}

