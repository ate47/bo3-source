#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace underwater;

// Namespace underwater
// Params 0, eflags: 0x0
// Checksum 0xbb543a1a, Offset: 0x2f0
// Size: 0x12
function main() {
    init_clientfields();
}

// Namespace underwater
// Params 0, eflags: 0x0
// Checksum 0x6e3d410f, Offset: 0x310
// Size: 0x72
function init_clientfields() {
    clientfield::register("world", "infection_underwater_debris", 1, 1, "int", &function_e186ab41, 1, 1);
    clientfield::register("toplayer", "water_motes", 1, 1, "int", &water_motes, 0, 0);
}

// Namespace underwater
// Params 7, eflags: 0x0
// Checksum 0xd4cd7bc1, Offset: 0x390
// Size: 0x72
function function_e186ab41(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    if (newval) {
        level thread function_c6db22a1(localclientnum);
        return;
    }
    level thread function_1c0537db(localclientnum);
}

// Namespace underwater
// Params 1, eflags: 0x0
// Checksum 0x8303e999, Offset: 0x410
// Size: 0x31a
function function_c6db22a1(localclientnum) {
    debris = [];
    level._effect["bubbles_pews"] = "water/fx_water_bubbles_debris_50x10";
    level._effect["bubbles_body"] = "water/fx_water_bubbles_debris_body";
    level._effect["bubbles_books"] = "water/fx_water_bubbles_debris_sm";
    position = struct::get_array("underwater_debris");
    for (i = 0; i < position.size; i++) {
        if (isdefined(position[i].model)) {
            junk = spawn(localclientnum, position[i].origin, "script_model");
            junk setmodel(position[i].model);
            junk.targetname = position[i].targetname;
            if (junk.model === "c_ger_winter_soldier_1_body") {
                junk thread scene::play("cin_gen_ambient_float01", junk);
                junk.sfx_id = playfxontag(localclientnum, level._effect["bubbles_body"], junk, "tag_origin");
            } else if (junk.model === "c_ger_winter_soldier_2_body") {
                junk thread scene::play("cin_gen_ambient_float02", junk);
                junk.sfx_id = playfxontag(localclientnum, level._effect["bubbles_body"], junk, "tag_origin");
            } else if (junk.model === "p7_church_pew_01") {
                junk.sfx_id = playfxontag(localclientnum, level._effect["bubbles_pews"], junk, "tag_origin");
            } else if (junk.model === "p7_book_vintage_02_burn") {
                junk.sfx_id = playfxontag(localclientnum, level._effect["bubbles_books"], junk, "tag_origin");
            } else if (junk.model === "p7_book_vintage_open_01_burn") {
                junk.sfx_id = playfxontag(localclientnum, level._effect["bubbles_books"], junk, "tag_origin");
            }
            if (isdefined(position[i].angles)) {
                junk.angles = position[i].angles;
            }
            if (isdefined(position[i].script_noteworthy)) {
                junk.script_noteworthy = position[i].script_noteworthy;
            }
            array::add(debris, junk, 0);
        }
    }
    array::thread_all(debris, &function_7c14204);
}

// Namespace underwater
// Params 0, eflags: 0x0
// Checksum 0x2f628c78, Offset: 0x738
// Size: 0xdf
function function_7c14204() {
    level endon(#"hash_33a3e0a5");
    bottom = bullettrace(self.origin, self.origin + (0, 0, -1500), 0, undefined);
    self moveto(bottom["position"], 60);
    while (true) {
        time = randomfloatrange(4, 6);
        self rotateto(self.angles + (randomfloatrange(-30, 30), randomfloatrange(-30, 30), randomfloatrange(-30, 30)), time);
        self waittill(#"rotatedone");
    }
}

// Namespace underwater
// Params 1, eflags: 0x0
// Checksum 0x73c3152d, Offset: 0x820
// Size: 0xca
function function_1c0537db(localclientnum) {
    debris = getentarray(localclientnum, "underwater_debris", "targetname");
    for (i = 0; i < debris.size; i++) {
        if (debris[i] scene::is_playing()) {
            debris[i] scene::stop();
        }
        debris[i] delete();
        if (isdefined(self.sfx_id)) {
            deletefx(localclientnum, self.sfx_id, 0);
            self.sfx_id = undefined;
        }
    }
    stopwatersheetingfx(localclientnum);
}

// Namespace underwater
// Params 7, eflags: 0x0
// Checksum 0xadb82abf, Offset: 0x8f8
// Size: 0x9a
function water_motes(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != 0) {
        self.var_8e8c7340 = playfxoncamera(localclientnum, level._effect["water_motes"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        return;
    }
    if (isdefined(self.var_8e8c7340)) {
        deletefx(localclientnum, self.var_8e8c7340, 1);
    }
}

