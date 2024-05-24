#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/weapons/_hive_gun;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace globallogic;

// Namespace globallogic
// Params 0, eflags: 0x2
// Checksum 0x4fcd213b, Offset: 0x358
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("globallogic", &__init__, undefined, "visionset_mgr");
}

// Namespace globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0xc81c8126, Offset: 0x398
// Size: 0x248
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
// Params 7, eflags: 0x1 linked
// Checksum 0xff080585, Offset: 0x5e8
// Size: 0x6c
function game_ended(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !level.gameended) {
        level notify(#"game_ended");
        level.gameended = 1;
    }
}

// Namespace globallogic
// Params 7, eflags: 0x1 linked
// Checksum 0xc8c19e43, Offset: 0x660
// Size: 0x6c
function post_game(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !level.postgame) {
        level notify(#"post_game");
        level.postgame = 1;
    }
}

// Namespace globallogic
// Params 7, eflags: 0x1 linked
// Checksum 0x2437adb2, Offset: 0x6d8
// Size: 0x6c
function firefly_effect_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (bnewent && newval) {
        self thread namespace_5cffdc90::function_efe10ed8(localclientnum, newval);
    }
}

// Namespace globallogic
// Params 7, eflags: 0x1 linked
// Checksum 0xeb68fc0a, Offset: 0x750
// Size: 0x184
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
// Params 7, eflags: 0x1 linked
// Checksum 0x3bd754f3, Offset: 0x8e0
// Size: 0xd4
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

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0xf8be006, Offset: 0x9c0
// Size: 0x48
function function_17f0b9e4(localclientnum) {
    self endon(#"entityshutdown");
    while (true) {
        self waittill(#"hash_4aacea01");
        self thread play_plant_sound(localclientnum);
    }
}

// Namespace globallogic
// Params 1, eflags: 0x1 linked
// Checksum 0xc9c8f435, Offset: 0xa10
// Size: 0x150
function play_plant_sound(localclientnum) {
    self notify(#"play_plant_sound");
    self endon(#"play_plant_sound");
    self endon(#"entityshutdown");
    self endon(#"stop_plant_sound");
    player = getlocalplayer(localclientnum);
    var_f919f008 = getweapon("briefcase_bomb");
    var_26f401f = getweapon("briefcase_bomb_defuse");
    wait(0.25);
    while (true) {
        if (!isdefined(player)) {
            return;
        }
        if (player.weapon != var_f919f008 && player.weapon != var_26f401f) {
            return;
        }
        if (player != self || isthirdperson(localclientnum)) {
            self playsound(localclientnum, "fly_bomb_buttons_npc");
        }
        wait(0.15);
    }
}

// Namespace globallogic
// Params 0, eflags: 0x1 linked
// Checksum 0x56d077c2, Offset: 0xb68
// Size: 0x5c
function function_9350c173() {
    util::waitforallclients();
    wait(5);
    var_57f81ff6 = getdvarint("sys_threadWatchdogTimeoutLive", 30000);
    setdvar("sys_threadWatchdogTimeout", var_57f81ff6);
}

// Namespace globallogic
// Params 0, eflags: 0x2
// Checksum 0xe79c43d8, Offset: 0xbd0
// Size: 0x34
function autoexec function_d00a98f6() {
    if (getdvarint("sys_threadWatchdogTimeoutLive", 0) > 0) {
        level thread function_9350c173();
    }
}

