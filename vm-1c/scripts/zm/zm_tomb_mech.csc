#using scripts/shared/ai/mechz;
#using scripts/zm/_zm_ai_mechz_claw;
#using scripts/zm/_zm_ai_mechz;
#using scripts/zm/_zm;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_tomb_mech;

// Namespace zm_tomb_mech
// Params 0, eflags: 0x1 linked
// Checksum 0xdbda6c5d, Offset: 0x238
// Size: 0x4c
function init() {
    clientfield::register("actor", "tomb_mech_eye", 21000, 1, "int", &function_8c8b6484, 0, 0);
}

// Namespace zm_tomb_mech
// Params 7, eflags: 0x1 linked
// Checksum 0x78e40cc4, Offset: 0x290
// Size: 0xb8
function function_8c8b6484(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        waittillframeend();
        var_f9e79b00 = self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 3, 0);
        return;
    }
    waittillframeend();
    var_f9e79b00 = self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 3, 0);
}

