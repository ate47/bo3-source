#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/cp/gametypes/_spawning;
#using scripts/cp/gametypes/_save;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/load_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace hacking;

// Namespace hacking
// Params 0, eflags: 0x2
// Checksum 0xa04a14df, Offset: 0x340
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("hacking", &__init__, undefined, undefined);
}

// Namespace hacking
// Params 0, eflags: 0x1 linked
// Checksum 0xca384341, Offset: 0x380
// Size: 0x3c
function __init__() {
    level.hacking = spawnstruct();
    level.hacking flag::init("in_progress");
}

// Namespace hacking
// Params 2, eflags: 0x0
// Checksum 0x67b3e7c1, Offset: 0x3c8
// Size: 0x4c
function hack(var_498bbabf, var_c08cc2da) {
    onbeginuse(var_c08cc2da);
    wait(var_498bbabf);
    onenduse(undefined, var_c08cc2da, 1);
}

// Namespace hacking
// Params 6, eflags: 0x1 linked
// Checksum 0x791d6c21, Offset: 0x420
// Size: 0x2d8
function function_68df65d8(var_498bbabf, str_objective, str_hint_text, var_84221fce, a_keyline_objects, var_27d1693f) {
    if (!isdefined(var_498bbabf)) {
        var_498bbabf = 0.5;
    }
    if (!isdefined(str_objective)) {
        str_objective = %cp_hacking;
    }
    if (isdefined(str_hint_text)) {
        self sethintstring(str_hint_text);
    }
    self setcursorhint("HINT_INTERACTIVE_PROMPT");
    if (!isdefined(a_keyline_objects)) {
        a_keyline_objects = [];
    } else {
        if (!isdefined(a_keyline_objects)) {
            a_keyline_objects = [];
        } else if (!isarray(a_keyline_objects)) {
            a_keyline_objects = array(a_keyline_objects);
        }
        foreach (mdl in a_keyline_objects) {
            mdl oed::function_e228c18a(1);
        }
    }
    visuals = [];
    var_38c85157 = gameobjects::create_use_object("any", self, visuals, (0, 0, 0), str_objective);
    var_38c85157 gameobjects::allow_use("any");
    var_38c85157 gameobjects::set_use_time(0.35);
    var_38c85157 gameobjects::set_owner_team("allies");
    var_38c85157 gameobjects::set_visible_team("any");
    var_38c85157.onuse = &onuse;
    var_38c85157.onbeginuse = &onbeginuse;
    var_38c85157.onenduse = &onenduse;
    var_38c85157.var_84221fce = var_84221fce;
    var_38c85157.keepweapon = 1;
    var_38c85157.var_27d1693f = var_27d1693f;
    return var_38c85157;
}

// Namespace hacking
// Params 0, eflags: 0x1 linked
// Checksum 0xfcbd28cb, Offset: 0x700
// Size: 0x20
function trigger_wait() {
    e_who = self waittill(#"hash_1253961");
    return e_who;
}

// Namespace hacking
// Params 1, eflags: 0x1 linked
// Checksum 0xef3157b8, Offset: 0x728
// Size: 0xc
function onbeginuse(player) {
    
}

// Namespace hacking
// Params 3, eflags: 0x1 linked
// Checksum 0x2df3c2e7, Offset: 0x740
// Size: 0x1c
function onenduse(team, player, result) {
    
}

// Namespace hacking
// Params 1, eflags: 0x1 linked
// Checksum 0x827bcf4c, Offset: 0x768
// Size: 0x2c4
function onuse(player) {
    self gameobjects::disable_object();
    if (isdefined(player)) {
        level.hacking flag::set("in_progress");
        player cybercom::function_f8669cbf(1);
        player clientfield::set_to_player("sndCCHacking", 2);
        player util::delay(1, undefined, &clientfield::increment_to_player, "hack_dni_fx");
        if (isdefined(self.var_27d1693f)) {
            var_c4ed51d5 = util::spawn_model("tag_origin", player.origin, player.angles);
            var_c4ed51d5 linkto(self.var_27d1693f);
            player playerlinkto(var_c4ed51d5, "tag_origin");
            var_c4ed51d5 scene::play("cin_gen_player_hack_start", player);
            var_c4ed51d5 delete();
        } else {
            s_align = player;
            if (isdefined(self.trigger.target)) {
                s_align = struct::get(self.trigger.target, "targetname");
            }
            s_align scene::play("cin_gen_player_hack_start", player);
        }
        level notify(#"hash_221e0b70", 1, player);
        self.trigger notify(#"hash_1253961", player);
        if (isdefined(player)) {
            player clientfield::set_to_player("sndCCHacking", 0);
        }
        level.hacking flag::clear("in_progress");
    }
    if (isdefined(self.var_84221fce)) {
        [[ self.var_84221fce ]]();
    }
    objective_clearentity(self.objectiveid);
    self gameobjects::destroy_object(1, undefined, 1);
}

