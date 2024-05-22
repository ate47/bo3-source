#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/ai_shared;

#namespace namespace_46de4034;

// Namespace namespace_46de4034
// Params 0, eflags: 0x2
// Checksum 0xacae8f51, Offset: 0x140
// Size: 0x34
function function_2dc19561() {
    system::register("direwolf", &__init__, undefined, undefined);
}

// Namespace namespace_46de4034
// Params 0, eflags: 0x2
// Checksum 0x3dec4ee8, Offset: 0x180
// Size: 0x1e
function precache() {
    level._effect["fx_bio_direwolf_eyes"] = "animals/fx_bio_direwolf_eyes";
}

// Namespace namespace_46de4034
// Params 0, eflags: 0x1 linked
// Checksum 0x11ddfcb1, Offset: 0x1a8
// Size: 0x64
function __init__() {
    if (ai::shouldregisterclientfieldforarchetype("direwolf")) {
        clientfield::register("actor", "direwolf_eye_glow_fx", 1, 1, "int", &function_beea0195, 0, 1);
    }
}

// Namespace namespace_46de4034
// Params 7, eflags: 0x5 linked
// Checksum 0xf0df0394, Offset: 0x218
// Size: 0x108
function function_beea0195(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (isdefined(entity.archetype) && entity.archetype != "direwolf") {
        return;
    }
    if (isdefined(entity.var_3efcb1a5)) {
        stopfx(localclientnum, entity.var_3efcb1a5);
        entity.var_3efcb1a5 = undefined;
    }
    if (newvalue) {
        entity.var_3efcb1a5 = playfxontag(localclientnum, level._effect["fx_bio_direwolf_eyes"], entity, "tag_eye");
    }
}

