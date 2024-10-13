#using scripts/shared/clientfield_shared;
#using scripts/cp/_challenges;
#using scripts/cp/_util;
#using scripts/cp/gametypes/_save;
#using scripts/cp/_objectives;
#using scripts/shared/music_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;

#namespace collectibles;

// Namespace collectibles
// Params 0, eflags: 0x2
// Checksum 0xf37ef3f8, Offset: 0x5f8
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("bzm_collectibles", &__init__, &__main__, undefined);
}

// Namespace collectibles
// Params 0, eflags: 0x1 linked
// Checksum 0x484ebc81, Offset: 0x640
// Size: 0x9c
function __init__() {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    clientfield::register("world", "cpzm_song_suppression", 1, 1, "int");
    level.mission_name = getmissionname();
    level.map_name = getrootmapname();
    level.var_3efe1e22 = [];
    level thread function_7c315d3a();
}

// Namespace collectibles
// Params 0, eflags: 0x1 linked
// Checksum 0x63f57881, Offset: 0x6e8
// Size: 0x2c
function __main__() {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    thread function_ab60ef67();
}

// Namespace collectibles
// Params 0, eflags: 0x1 linked
// Checksum 0xad974ede, Offset: 0x720
// Size: 0x20c
function function_ab60ef67() {
    wait 2;
    level.var_8a9d11b = 0;
    level.var_7e93a355 = 0;
    level.collectibles = [];
    var_a87c5e50 = getentarray("collectible", "script_noteworthy");
    if (var_a87c5e50.size <= 1) {
        return;
    }
    mapname = getdvarstring("mapname");
    if (issubstr(mapname, "blackstation")) {
        var_12d65c22 = 1;
    } else {
        var_12d65c22 = 0;
    }
    level.var_f5f95e45 = -1;
    foreach (mdl_collectible in var_a87c5e50) {
        if (var_12d65c22 && distancesquared((-1492, 1690, -640), mdl_collectible.origin) <= -56 * -56) {
            continue;
        }
        level.var_f5f95e45++;
        mdl_collectible.index = level.var_f5f95e45;
        collectible = function_8765a33c(mdl_collectible);
        array::add(level.collectibles, collectible, 0);
    }
    callback::on_spawned(&on_player_spawned);
}

// Namespace collectibles
// Params 1, eflags: 0x5 linked
// Checksum 0xe2c8ec89, Offset: 0x938
// Size: 0xe4
function private function_b963f25(mdl_collectible) {
    mdl_collectible.radius = 60;
    mdl_collectible.offset = (0, 0, 5);
    mdl_collectible.origin += (0, 0, 35);
    var_3efe1e22 = level.var_3efe1e22[mdl_collectible.model];
    if (isdefined(var_3efe1e22)) {
        mdl_collectible.radius = var_3efe1e22.radius;
        mdl_collectible.offset += var_3efe1e22.offset;
    }
    return mdl_collectible;
}

// Namespace collectibles
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xa28
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace collectibles
// Params 1, eflags: 0x1 linked
// Checksum 0xefd0fcb2, Offset: 0xa38
// Size: 0x3a8
function function_8765a33c(mdl_collectible) {
    mdl_collectible show();
    mdl_collectible = function_b963f25(mdl_collectible);
    trigger_use = spawn("trigger_radius_use", mdl_collectible.origin + mdl_collectible.offset, 0, 100, mdl_collectible.radius);
    trigger_use triggerignoreteam();
    trigger_use setvisibletoall();
    trigger_use usetriggerrequirelookat();
    trigger_use setteamfortrigger("none");
    trigger_use setcursorhint("HINT_INTERACTIVE_PROMPT");
    trigger_use sethintstring(%COLLECTIBLE_PICK_UP);
    var_837a6185 = gameobjects::create_use_object("any", trigger_use, array(mdl_collectible), (0, 0, 0), %cp_magic_song);
    var_837a6185 gameobjects::allow_use("any");
    var_837a6185 gameobjects::set_use_time(0.35);
    var_837a6185 gameobjects::set_owner_team("allies");
    var_837a6185 gameobjects::set_visible_team("any");
    var_837a6185.mdl_collectible = mdl_collectible;
    var_837a6185.onuse = &onuse;
    var_837a6185.onbeginuse = &onbeginuse;
    var_837a6185.single_use = 1;
    var_837a6185.origin = mdl_collectible.origin;
    var_837a6185.angles = var_837a6185.angles;
    if (isdefined(mdl_collectible.script_int)) {
        var_837a6185.index = mdl_collectible.script_int - 1;
    } else {
        var_837a6185.index = int(getsubstr(mdl_collectible.model, mdl_collectible.model.size - 2)) - 1;
    }
    mdl_collectible setmodel("p7_zm_teddybear_sitting");
    mdl_collectible clientfield::set("powerup_on_fx", 2);
    mdl_collectible setscale(0.7);
    /#
        level thread function_c7d0d818(var_837a6185.origin);
    #/
    return var_837a6185;
}

// Namespace collectibles
// Params 0, eflags: 0x1 linked
// Checksum 0xc218de9a, Offset: 0xde8
// Size: 0x1a0
function function_9b46b73e() {
    mapname = getrootmapname();
    foreach (collectible in level.collectibles) {
        foreach (player in level.players) {
            if (player getdstat("PlayerStatsByMap", mapname, "collectibles", collectible.index)) {
                collectible.mdl_collectible setinvisibletoplayer(player);
                objective_setinvisibletoplayer(collectible.objectiveid, player);
                collectible.trigger setinvisibletoplayer(player);
            }
        }
    }
}

// Namespace collectibles
// Params 1, eflags: 0x1 linked
// Checksum 0xb72548ea, Offset: 0xf90
// Size: 0x4e2
function onuse(e_player) {
    mapname = getrootmapname();
    foreach (player in level.players) {
        player playsoundtoplayer("uin_collectible_pickup", player);
        self.mdl_collectible setinvisibletoplayer(player);
        self gameobjects::hide_waypoint(player);
        self.trigger setinvisibletoplayer(player);
        player setdstat("PlayerStatsByMap", mapname, "collectibles", self.index, 1);
        uploadstats(player);
        util::function_964b7eb7(player, istring("COLLECTIBLE_DISCOVERED"));
    }
    level.var_8a9d11b++;
    var_27fba3a4 = level.collectibles.size;
    if (var_27fba3a4 > 3) {
        if (level.var_8a9d11b < 3) {
            return;
        }
    } else if (var_27fba3a4 - level.var_8a9d11b > 0) {
        return;
    }
    level thread function_9b46b73e();
    if (level.var_7e93a355 <= 1) {
        mapname = getrootmapname();
        level.var_7e93a355++;
        state = undefined;
        unlockname = undefined;
        switch (mapname) {
        case "cp_mi_cairo_aquifer_nightmares":
            state = "zm_abra";
            unlockname = "mus_abra_cadavre_intro";
            break;
        case "cp_mi_cairo_lotus_nightmares":
            state = "zm_always_running";
            unlockname = "mus_always_running_intro";
            break;
        case "cp_mi_cairo_ramses_nightmares":
            state = "zm_wafd";
            unlockname = "mus_we_all_fall_down_intro";
            break;
        case "cp_mi_eth_prologue_nightmares":
            state = "zm_pareidolia";
            unlockname = "mus_pareidolia_intro";
            break;
        case "cp_mi_sing_biodomes_nightmares":
            state = "zm_boa";
            unlockname = "mus_beauty_of_annihilation_intro";
            break;
        case "cp_mi_sing_blackstation_nightmares":
            state = "zm_carrion";
            unlockname = "mus_carrion_intro";
            break;
        case "cp_mi_sing_sgen_nightmares":
            state = "zm_lullaby";
            unlockname = "mus_lullaby_for_a_dead_man_intro";
            break;
        case "cp_mi_sing_vengeance_nightmares":
            state = "zm_coming_home";
            unlockname = "mus_coming_home_intro";
            break;
        case "cp_mi_zurich_coalescence_nightmares":
            state = "zm_archangel";
            unlockname = "mus_archangel_intro";
            break;
        case "cp_mi_zurich_newworld_nightmares":
            state = "zm_the_one";
            unlockname = "mus_the_one_intro";
            break;
        case "cp_mi_cairo_infection_nightmares":
            state = "zm_wawg";
            unlockname = "mus_where_are_we_going_intro";
            break;
        }
        if (isdefined(state)) {
            /#
                iprintln("<dev string:x28>" + unlockname);
            #/
            music::setmusicstate(state);
            level.var_effda531 = 1;
            level thread function_d789d2e(state);
        }
        foreach (player in level.players) {
            if (isdefined(unlockname)) {
                player unlocksongbyalias(unlockname);
            }
        }
    }
}

// Namespace collectibles
// Params 1, eflags: 0x1 linked
// Checksum 0x5b565deb, Offset: 0x1480
// Size: 0xa4
function function_d789d2e(state) {
    aliasname = "mus_" + state + "_intro";
    playbacktime = soundgetplaybacktime(aliasname);
    if (!isdefined(playbacktime) || playbacktime <= 0) {
        waittime = 1;
    } else {
        waittime = playbacktime * 0.001;
    }
    wait waittime;
    level.var_effda531 = 0;
}

// Namespace collectibles
// Params 1, eflags: 0x1 linked
// Checksum 0x2bed3b14, Offset: 0x1530
// Size: 0xc
function onbeginuse(e_player) {
    
}

/#

    // Namespace collectibles
    // Params 1, eflags: 0x1 linked
    // Checksum 0xdd46cde6, Offset: 0x1548
    // Size: 0x58
    function function_c7d0d818(origin1) {
        while (true) {
            recordline(origin1, origin1 + (0, 0, 2000), (1, 1, 1), "<dev string:x33>");
            wait 0.05;
        }
    }

#/

// Namespace collectibles
// Params 0, eflags: 0x1 linked
// Checksum 0xf6b94855, Offset: 0x15a8
// Size: 0x78
function function_7c315d3a() {
    while (true) {
        level waittill(#"hash_1c353a4f");
        if (isdefined(level.var_effda531) && level.var_effda531) {
            level clientfield::set("cpzm_song_suppression", 1);
        }
        level waittill(#"hash_14c06c0c");
        level clientfield::set("cpzm_song_suppression", 0);
    }
}

