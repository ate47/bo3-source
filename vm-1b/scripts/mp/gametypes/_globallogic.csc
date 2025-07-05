#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/weapons/_hive_gun;
#using scripts/shared/weapons/_weaponobjects;

#namespace globallogic;

// Namespace globallogic
// Params 0, eflags: 0x2
// Checksum 0xba4c641, Offset: 0x2e8
// Size: 0x32
function autoexec __init__sytem__() {
    system::register("globallogic", &__init__, undefined, "visionset_mgr");
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xb1a189b3, Offset: 0x328
// Size: 0x1ea
function __init__() {
    visionset_mgr::register_visionset_info("mpintro", 1, 31, undefined, "mpintro");
    clientfield::register("world", "game_ended", 1, 1, "int", &game_ended, 1, 1);
    clientfield::register("world", "post_game", 1, 1, "int", &post_game, 1, 1);
    registerclientfield("playercorpse", "firefly_effect", 1, 2, "int", &firefly_effect_cb, 0);
    registerclientfield("playercorpse", "annihilate_effect", 1, 1, "int", &annihilate_effect_cb, 0);
    registerclientfield("playercorpse", "pineapplegun_effect", 1, 1, "int", &pineapplegun_effect_cb, 0);
    registerclientfield("actor", "annihilate_effect", 1, 1, "int", &annihilate_effect_cb, 0);
    registerclientfield("actor", "pineapplegun_effect", 1, 1, "int", &pineapplegun_effect_cb, 0);
    level._effect["annihilate_explosion"] = "weapon/fx_hero_annhilatr_death_blood";
    level._effect["pineapplegun_explosion"] = "weapon/fx_hero_pineapple_death_blood";
    level.gameended = 0;
    level.postgame = 0;
}

// Namespace globallogic
// Params 7, eflags: 0x0
// Checksum 0x827a1a70, Offset: 0x520
// Size: 0x5e
function game_ended(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !level.gameended) {
        level notify(#"game_ended");
        level.gameended = 1;
    }
}

// Namespace globallogic
// Params 7, eflags: 0x0
// Checksum 0x803c0497, Offset: 0x588
// Size: 0x5e
function post_game(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !level.postgame) {
        level notify(#"post_game");
        level.postgame = 1;
    }
}

// Namespace globallogic
// Params 7, eflags: 0x0
// Checksum 0x85ced662, Offset: 0x5f0
// Size: 0x5a
function firefly_effect_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (bnewent && newval) {
        self thread hive_gun::function_efe10ed8(localclientnum, newval);
    }
}

// Namespace globallogic
// Params 7, eflags: 0x0
// Checksum 0xc7689b5, Offset: 0x658
// Size: 0x132
function annihilate_effect_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !oldval) {
        where = self gettagorigin("J_SpineLower");
        if (!isdefined(where)) {
            where = self.origin;
        }
        where += (0, 0, -40);
        character_index = self getcharacterbodytype();
        fields = getcharacterfields(character_index, currentsessionmode());
        if (fields.fullbodyexplosion != "") {
            if (util::is_mature() && !util::is_gib_restricted_build()) {
                playfx(localclientnum, fields.fullbodyexplosion, where);
            }
            playfx(localclientnum, "explosions/fx_exp_grenade_default", where);
        }
    }
}

// Namespace globallogic
// Params 7, eflags: 0x0
// Checksum 0x70d4290b, Offset: 0x798
// Size: 0xaa
function pineapplegun_effect_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !oldval) {
        where = self gettagorigin("J_SpineLower");
        if (!isdefined(where)) {
            where = self.origin;
        }
        if (isdefined(level._effect["pineapplegun_explosion"])) {
            playfx(localclientnum, level._effect["pineapplegun_explosion"], where);
        }
    }
}

