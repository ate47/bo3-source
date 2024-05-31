#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_90429ef7;

// Namespace namespace_90429ef7
// Params 0, eflags: 0x1 linked
// namespace_90429ef7<file_0>::function_d290ebfa
// Checksum 0x9f4233fc, Offset: 0x1a8
// Size: 0x4c
function main() {
    clientfield::register("scriptmover", "barbecue_fx", 21000, 1, "int", &function_63c3c25d, 0, 0);
}

// Namespace namespace_90429ef7
// Params 1, eflags: 0x1 linked
// namespace_90429ef7<file_0>::function_f53f6b0a
// Checksum 0x7bec3a4f, Offset: 0x200
// Size: 0x78
function function_f53f6b0a(localclientnum) {
    self notify(#"hash_b9e014c3");
    self endon(#"hash_b9e014c3");
    self endon(#"entityshutdown");
    while (true) {
        playfxontag(localclientnum, level._effect["fire_sacrifice_flame"], self, "tag_origin");
        wait(0.5);
    }
}

// Namespace namespace_90429ef7
// Params 7, eflags: 0x1 linked
// namespace_90429ef7<file_0>::function_63c3c25d
// Checksum 0x47660f45, Offset: 0x280
// Size: 0x86
function function_63c3c25d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self thread function_f53f6b0a(localclientnum);
        level thread function_ebebc90(self);
        return;
    }
    self notify(#"hash_b9e014c3");
}

// Namespace namespace_90429ef7
// Params 1, eflags: 0x1 linked
// namespace_90429ef7<file_0>::function_ebebc90
// Checksum 0x2ca25794, Offset: 0x310
// Size: 0x8c
function function_ebebc90(entity) {
    origin = entity.origin;
    audio::playloopat("zmb_squest_fire_bbq_lp", origin);
    entity util::waittill_any("stop_bbq_fx_loop", "entityshutdown");
    audio::stoploopat("zmb_squest_fire_bbq_lp", origin);
}

