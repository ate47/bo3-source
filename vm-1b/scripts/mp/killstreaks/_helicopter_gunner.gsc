#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_helicopter;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreak_detect;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_remote_weapons;
#using scripts/mp/teams/_teams;
#using scripts/shared/_oob;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/weapons/_hacker_tool;
#using scripts/shared/weapons/_heatseekingmissile;
#using scripts/shared/weapons/_weaponobjects;

#namespace helicopter_gunner;

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0x7eac6fea, Offset: 0xb08
// Size: 0x4a1
function init() {
    killstreaks::register("helicopter_gunner", "helicopter_player_gunner", "killstreak_helicopter_player_gunner", "helicopter_used", &activatemaingunner, 1);
    killstreaks::function_f79fd1e9("helicopter_gunner", %KILLSTREAK_EARNED_HELICOPTER_GUNNER, %KILLSTREAK_HELICOPTER_GUNNER_NOT_AVAILABLE, %KILLSTREAK_HELICOPTER_GUNNER_INBOUND, undefined, %KILLSTREAK_HELICOPTER_GUNNER_HACKED);
    killstreaks::register_dialog("helicopter_gunner", "mpl_killstreak_osprey_strt", "helicopterGunnerDialogBundle", "helicopterGunnerPilotDialogBundle", "friendlyHelicopterGunner", "enemyHelicopterGunner", "enemyHelicopterGunnerMultiple", "friendlyHelicopterGunnerHacked", "enemyHelecopterGunnerHacked", "requestHelicopterGunner", "threatHelicopterGunner");
    killstreaks::register_alt_weapon("helicopter_gunner", "helicopter_gunner_turret_rockets");
    killstreaks::register_alt_weapon("helicopter_gunner", "helicopter_gunner_turret_primary");
    killstreaks::register_alt_weapon("helicopter_gunner", "helicopter_gunner_turret_secondary");
    killstreaks::register_alt_weapon("helicopter_gunner", "helicopter_gunner_turret_tertiary");
    killstreaks::set_team_kill_penalty_scale("helicopter_gunner", level.teamkillreducedpenalty);
    killstreaks::devgui_scorestreak_command("helicopter_gunner", "Debug Paths", "toggle scr_devHeliPathsDebugDraw 1 0");
    killstreaks::register("helicopter_gunner_assistant", "helicopter_gunner_assistant", "killstreak_" + "helicopter_gunner_assistant", "helicopter_used", &function_99239c12, 1, undefined, 0, 0);
    killstreaks::function_f79fd1e9("helicopter_gunner_assistant", %KILLSTREAK_EARNED_HELICOPTER_GUNNER, %KILLSTREAK_HELICOPTER_GUNNER_NOT_AVAILABLE, %KILLSTREAK_HELICOPTER_GUNNER_INBOUND, undefined, %KILLSTREAK_HELICOPTER_GUNNER_HACKED);
    killstreaks::register_dialog("helicopter_gunner_assistant", "mpl_killstreak_osprey_strt", "helicopterGunnerDialogBundle", "helicopterGunnerPilotDialogBundle", "friendlyHelicopterGunner", "enemyHelicopterGunner", "enemyHelicopterGunnerMultiple", "friendlyHelicopterGunnerHacked", "enemyHelecopterGunnerHacked", "requestHelicopterGunner", "threatHelicopterGunner");
    killstreaks::set_team_kill_penalty_scale("helicopter_gunner_assistant", level.teamkillreducedpenalty);
    level.killstreaks["helicopter_gunner"].threatonkill = 1;
    callback::on_connect(&onplayerconnect);
    callback::on_spawned(&function_77d3af38);
    callback::on_joined_team(&function_77d3af38);
    callback::on_joined_spectate(&function_77d3af38);
    callback::on_disconnect(&function_77d3af38);
    callback::on_player_killed(&function_77d3af38);
    clientfield::register("vehicle", "vtol_turret_destroyed_0", 1, 1, "int");
    clientfield::register("vehicle", "vtol_turret_destroyed_1", 1, 1, "int");
    clientfield::register("vehicle", "mothership", 1, 1, "int");
    clientfield::register("toplayer", "vtol_update_client", 1, 1, "counter");
    clientfield::register("toplayer", "fog_bank_2", 1, 1, "int");
    visionset_mgr::register_info("visionset", "mothership_visionset", 1, 70, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
    level thread waitforgameendthread();
    level.vtol = undefined;
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0x27bd59bc, Offset: 0xfb8
// Size: 0x22
function onplayerconnect() {
    if (!isdefined(self.entnum)) {
        self.entnum = self getentitynumber();
    }
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0x7a3a2e1, Offset: 0xfe8
// Size: 0x1a
function function_77d3af38() {
    player = self;
    function_3dd23073();
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0xc4098de, Offset: 0x1010
// Size: 0x83
function function_3dd23073() {
    foreach (player in level.players) {
        if (isdefined(player.sessionstate) && player.sessionstate == "playing") {
            function_d72297a4(player);
        }
    }
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0x63237fde, Offset: 0x10a0
// Size: 0x132
function function_d72297a4(player) {
    if (!isdefined(player)) {
        return;
    }
    heli_team = undefined;
    if (isdefined(level.vtol) && isdefined(level.vtol.owner) && !level.vtol.shuttingdown && level.vtol.totalrockethits < 4) {
        heli_team = level.vtol.owner.team;
    }
    if (isdefined(heli_team) && player.team == heli_team) {
        if (function_abf9f4d3(player) != -1 && !isdefined(level.vtol.usage[player.entnum])) {
            if (!player killstreaks::has_killstreak("inventory_helicopter_gunner_assistant")) {
                player killstreaks::give("inventory_helicopter_gunner_assistant", undefined, undefined, 1, 1);
            }
            return;
        }
    }
    if (player killstreaks::has_killstreak("inventory_helicopter_gunner_assistant")) {
        player killstreaks::take("inventory_helicopter_gunner_assistant");
    }
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0xae78dc8, Offset: 0x11e0
// Size: 0xc3
function activatemaingunner(killstreaktype) {
    player = self;
    while (isdefined(level.vtol) && level.vtol.shuttingdown) {
        if (!player killstreakrules::iskillstreakallowed("helicopter_gunner", player.team)) {
            return 0;
        }
    }
    player util::freeze_player_controls(1);
    result = player function_631db007();
    player util::freeze_player_controls(0);
    if (level.gameended) {
        return 1;
    }
    if (!isdefined(result)) {
        return 0;
    }
    return result;
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0x654ea89a, Offset: 0x12b0
// Size: 0x9c
function function_99239c12(killstreaktype) {
    player = self;
    if (isdefined(level.vtol) && level.vtol.shuttingdown) {
        return 0;
    }
    if (isdefined(level.vtol.usage[player.entnum])) {
        return 0;
    }
    player util::freeze_player_controls(1);
    result = player function_e2d82116(0);
    player util::freeze_player_controls(0);
    return result;
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0x649255b4, Offset: 0x1358
// Size: 0xb9
function function_abf9f4d3(player) {
    if (isdefined(level.vtol) && !level.vtol.shuttingdown && level.vtol.team == player.team && level.vtol.owner != player) {
        for (i = 0; i < 2; i++) {
            if (!isdefined(level.vtol.var_76f5125e[i].occupant) && !level.vtol.var_76f5125e[i].destroyed) {
                return i;
            }
        }
    }
    return -1;
}

// Namespace helicopter_gunner
// Params 2, eflags: 0x0
// Checksum 0x881c4e2a, Offset: 0x1420
// Size: 0x17a
function function_b5fd53c7(index, var_dae2a98f) {
    level.vtol.var_76f5125e[index] = spawnstruct();
    var_f58b60e7 = level.vtol.var_76f5125e[index];
    var_f58b60e7.occupant = undefined;
    var_f58b60e7.destroyed = 0;
    var_f58b60e7.targettag = var_dae2a98f;
    var_f58b60e7.targetent = spawn("script_model", (0, 0, 0));
    var_f58b60e7.targetent.usevtoltime = 1;
    var_f58b60e7.targetent setmodel("p7_dogtags_enemy");
    var_f58b60e7.targetent linkto(level.vtol, var_f58b60e7.targettag, (0, 0, 0), (0, 0, 0));
    var_f58b60e7.targetent.team = level.vtol.team;
    target_set(var_f58b60e7.targetent, (0, 0, 0));
    target_setallowhighsteering(var_f58b60e7.targetent, 1);
    var_f58b60e7.targetent.parent = level.vtol;
    level.vtol vehicle::add_to_target_group(var_f58b60e7.targetent);
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0xeeeb30fc, Offset: 0x15a8
// Size: 0x1ea
function hackedprefunction(hacker) {
    heligunner = self;
    heligunner.owner unlink();
    level.vtol clientfield::set("vehicletransition", 0);
    visionset_mgr::deactivate("visionset", "mothership_visionset", heligunner.owner);
    heligunner.owner setmodellodbias(0);
    heligunner.owner clientfield::set_to_player("fog_bank_2", 0);
    heligunner.owner clientfield::set_to_player("toggle_flir_postfx", 0);
    heligunner.owner notify(#"gunner_left");
    heligunner.owner killstreaks::clear_using_remote();
    heligunner.owner killstreaks::unhide_compass();
    heligunner.owner vehicle::stop_monitor_missiles_locked_on_to_me();
    heligunner.owner vehicle::stop_monitor_damage_as_occupant();
    foreach (var_f58b60e7 in heligunner.var_76f5125e) {
        if (isdefined(var_f58b60e7.occupant)) {
            var_f58b60e7.occupant iprintlnbold(%KILLSTREAK_HELICOPTER_GUNNER_DAMAGED);
        }
        function_34b002ad(var_f58b60e7.occupant, 0);
    }
    heligunner makevehicleunusable();
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0x768be37, Offset: 0x17a0
// Size: 0x1e2
function hackedpostfunction(hacker) {
    heligunner = self;
    heligunner clientfield::set("enemyvehicle", 2);
    heligunner makevehicleusable();
    heligunner usevehicle(hacker, 0);
    level.vtol clientfield::set("vehicletransition", 1);
    heligunner thread vehicle::monitor_missiles_locked_on_to_me(hacker);
    heligunner thread vehicle::monitor_damage_as_occupant(hacker);
    hacker thread function_4c831d66();
    hacker killstreaks::hide_compass();
    heligunner thread watchplayerexitrequestthread(hacker);
    visionset_mgr::activate("visionset", "mothership_visionset", hacker, 1, heligunner killstreak_hacking::get_hacked_timeout_duration_ms(), 1);
    hacker setmodellodbias(isdefined(level.mothership_lod_bias) ? level.mothership_lod_bias : 8);
    heligunner.owner clientfield::set_to_player("fog_bank_2", 1);
    hacker thread watchplayerteamchangethread(heligunner);
    hacker killstreaks::set_killstreak_delay_killcam("helicopter_gunner");
    if (heligunner.killstreak_timer_started) {
        heligunner.killstreak_duration = heligunner killstreak_hacking::get_hacked_timeout_duration_ms();
        heligunner.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now(heligunner);
        heligunner.killstreakendtime = int(heligunner.killstreak_end_time);
        return;
    }
    heligunner.killstreak_timer_start_using_hacked_time = 1;
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0x5857bcc1, Offset: 0x1990
// Size: 0x67e
function function_631db007() {
    player = self;
    player endon(#"disconnect");
    level endon(#"game_ended");
    if (!isdefined(level.heli_paths) || !level.heli_paths.size) {
        return 0;
    }
    if (!isdefined(level.heli_primary_path) || !level.heli_primary_path.size) {
        return 0;
    }
    if (isdefined(player.isdefusing) && (isdefined(player.isplanting) && player.isplanting || player.isdefusing) || player util::isusingremote() || player iswallrunning() || player oob::isoutofbounds()) {
        return 0;
    }
    killstreak_id = player killstreakrules::killstreakstart("helicopter_gunner", player.team, undefined, 1);
    if (killstreak_id == -1) {
        return 0;
    }
    startnode = level.heli_primary_path[0];
    level.vtol = spawnvehicle("veh_bo3_mil_gunship_mp", startnode.origin, startnode.angles, "dynamic_spawn_ai");
    level.vtol killstreaks::configure_team("helicopter_gunner", killstreak_id, player, "helicopter");
    level.vtol killstreak_hacking::enable_hacking("helicopter_gunner", &hackedprefunction, &hackedpostfunction);
    level.vtol.killstreak_id = killstreak_id;
    level.vtol.destroyfunc = &deletehelicoptercallback;
    level.vtol.hardpointtype = "helicopter_gunner";
    level.vtol clientfield::set("enemyvehicle", 1);
    level.vtol clientfield::set("vtol_turret_destroyed_0", 0);
    level.vtol clientfield::set("vtol_turret_destroyed_1", 0);
    level.vtol clientfield::set("mothership", 1);
    level.vtol vehicle::init_target_group();
    level.vtol.killstreak_timer_started = 0;
    level.vtol.allowdeath = 0;
    level.vtol.playermovedrecently = 0;
    level.vtol.soundmod = "default_loud";
    level.vtol hacker_tool::registerwithhackertool(50, 10000);
    level.vtol.var_76f5125e = [];
    level.vtol.usage = [];
    function_b5fd53c7(0, "tag_gunner_barrel1");
    function_b5fd53c7(1, "tag_gunner_barrel2");
    level.destructible_callbacks["turret_destroyed"] = &vtoldestructiblecallback;
    level.destructible_callbacks["turret1_destroyed"] = &vtoldestructiblecallback;
    level.destructible_callbacks["turret2_destroyed"] = &vtoldestructiblecallback;
    level.vtol.shuttingdown = 0;
    level.vtol thread playlockonsoundsthread(player, level.vtol);
    level.vtol thread helicopter::wait_for_killed();
    level.vtol thread function_fba55417();
    level.vtol.maxhealth = 5000;
    tablehealth = killstreak_bundles::get_max_health("helicopter_gunner");
    if (isdefined(tablehealth)) {
        level.vtol.maxhealth = tablehealth;
    }
    level.vtol.original_health = level.vtol.maxhealth;
    level.vtol.health = level.vtol.maxhealth;
    level.vtol setcandamage(1);
    level.vtol thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("death");
    level.vtol thread function_71d93771();
    var_3bdccbbf = getentarray("heli_attack_area", "targetname");
    if (var_3bdccbbf.size) {
        level.vtol thread function_78edc502(startnode, var_3bdccbbf);
        player thread watchlocationchangethread(var_3bdccbbf);
    } else {
        level.vtol thread helicopter::heli_fly(startnode, 0, "helicopter_gunner");
    }
    level.vtol.totalrockethits = 0;
    level.vtol.turretrockethits = 0;
    level.vtol.targetent = undefined;
    level.vtol.overridevehicledamage = &function_c23b805c;
    level.vtol.hackedhealthupdatecallback = &function_3d00912f;
    level.vtol.detonateviaemp = &helicoptedetonateviaemp;
    player thread killstreaks::play_killstreak_start_dialog("helicopter_gunner", player.team, killstreak_id);
    level.vtol killstreaks::play_pilot_dialog_on_owner("arrive", "helicopter_gunner", killstreak_id);
    level.vtol thread waitforvtolshutdownthread();
    result = player function_e2d82116(1);
    return result;
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0x869a37da, Offset: 0x2018
// Size: 0x76
function function_3d00912f() {
    helicopter = self;
    if (helicopter.shuttingdown == 1) {
        return;
    }
    hackedhealth = killstreak_bundles::get_hacked_health("helicopter_gunner");
    assert(isdefined(hackedhealth));
    if (helicopter.health > hackedhealth) {
        helicopter.health = hackedhealth;
    }
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0x37be5fde, Offset: 0x2098
// Size: 0x4a
function waitforgameendthread() {
    level waittill(#"game_ended");
    if (isdefined(level.vtol) && isdefined(level.vtol.owner)) {
        function_34b002ad(level.vtol.owner, 1);
    }
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0xc02e9dc2, Offset: 0x20f0
// Size: 0x17a
function waitforvtolshutdownthread() {
    helicopter = self;
    helicopter waittill(#"hash_17ad017b", attacker);
    if (isdefined(attacker)) {
        luinotifyevent(%player_callout, 2, %KILLSTREAK_DESTROYED_HELICOPTER_GUNNER, attacker.entnum);
    }
    if (isdefined(helicopter.targetent)) {
        target_remove(helicopter.targetent);
        helicopter.targetent delete();
        helicopter.targetent = undefined;
    }
    for (seatindex = 0; seatindex < 2; seatindex++) {
        var_f58b60e7 = level.vtol.var_76f5125e[seatindex];
        if (isdefined(var_f58b60e7.targetent)) {
            target_remove(var_f58b60e7.targetent);
            var_f58b60e7.targetent delete();
            var_f58b60e7.targetent = undefined;
        }
    }
    killstreakrules::killstreakstop("helicopter_gunner", helicopter.originalteam, helicopter.killstreak_id);
    function_34b002ad(level.vtol.owner, 1);
    level.vtol = undefined;
    helicopter delete();
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0xe63ba841, Offset: 0x2278
// Size: 0x18
function deletehelicoptercallback() {
    helicopter = self;
    helicopter notify(#"hash_17ad017b", undefined);
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0x94d534f4, Offset: 0x2298
// Size: 0xa2
function ontimeoutcallback() {
    for (i = 0; i < 2; i++) {
        if (isdefined(level.vtol.var_76f5125e[i].occupant)) {
            level.vtol.var_76f5125e[i].occupant killstreaks::play_pilot_dialog("timeout", "helicopter_gunner", undefined, level.vtol.killstreak_id);
        }
    }
    function_34b002ad(level.vtol.owner, 1);
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0x926f964b, Offset: 0x2348
// Size: 0xcc
function watchplayerteamchangethread(helicopter) {
    helicopter notify(#"mothership_team_change");
    helicopter endon(#"mothership_team_change");
    assert(isplayer(self));
    player = self;
    player endon(#"gunner_left");
    player util::waittill_any("joined_team", "disconnect", "joined_spectators");
    ownerleft = helicopter.ownerentnum == player.entnum;
    player thread function_34b002ad(player, ownerleft);
    if (ownerleft) {
        helicopter notify(#"hash_17ad017b", undefined);
    }
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0xf53e4658, Offset: 0x2420
// Size: 0x121
function watchplayerexitrequestthread(player) {
    player notify(#"watchplayerexitrequestthread_singleton");
    player endon(#"watchplayerexitrequestthread_singleton");
    assert(isplayer(player));
    mothership = self;
    level endon(#"game_ended");
    player endon(#"disconnect");
    player endon(#"gunner_left");
    owner = mothership.ownerentnum == player.entnum;
    while (true) {
        timeused = 0;
        while (player usebuttonpressed()) {
            timeused += 0.05;
            if (timeused > 0.25) {
                mothership killstreaks::play_pilot_dialog_on_owner("remoteOperatorRemoved", "helicopter_gunner", level.vtol.killstreak_id);
                player thread function_34b002ad(player, owner);
                return;
            }
            wait 0.05;
        }
        wait 0.05;
    }
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0xa93bf3bf, Offset: 0x2550
// Size: 0x47c
function function_e2d82116(isowner) {
    assert(isplayer(self));
    player = self;
    seatindex = -1;
    if (!isowner) {
        seatindex = function_abf9f4d3(player);
        if (seatindex == -1) {
            return false;
        }
        level.vtol.var_76f5125e[seatindex].occupant = player;
    }
    player util::setusingremote("helicopter_gunner");
    player.ignoreempjammed = 1;
    result = player killstreaks::init_ride_killstreak("helicopter_gunner");
    player.ignoreempjammed = 0;
    if (result != "success") {
        if (result != "disconnect") {
            player killstreaks::clear_using_remote();
        }
        if (!isowner) {
            level.vtol.var_76f5125e[seatindex].occupant = undefined;
        }
        if (isowner) {
            level.vtol.failed2enter = 1;
            level.vtol notify(#"hash_17ad017b");
        }
        return false;
    }
    if (isowner) {
        level.vtol usevehicle(player, 0);
        level.vtol clientfield::set("vehicletransition", 1);
    } else {
        if (level.vtol.shuttingdown) {
            player killstreaks::clear_using_remote();
            return false;
        }
        level.vtol usevehicle(player, seatindex + 1);
        level.vtol clientfield::set("vehicletransition", 1);
        level.vtol killstreaks::play_pilot_dialog_on_owner("remoteOperatorAdd", "helicopter_gunner", level.vtol.killstreak_id);
    }
    killcament = spawn("script_model", (0, 0, 0));
    killcament setmodel("tag_origin");
    killcament.angles = (0, 0, 0);
    killcament setweapon(getweapon("helicopter_gunner_turret_primary"));
    killcament linkto(level.vtol, "tag_barrel", (370, 0, 25), (0, 0, 0));
    level.vtol.killcament = killcament;
    level.vtol.usage[player.entnum] = 1;
    level.vtol thread audio::sndupdatevehiclecontext(1);
    level.vtol thread vehicle::monitor_missiles_locked_on_to_me(player);
    level.vtol thread vehicle::monitor_damage_as_occupant(player);
    if (level.vtol.killstreak_timer_started) {
        player vehicle::set_vehicle_drivable_time(level.vtol.killstreak_duration, level.vtol.killstreak_end_time);
    } else {
        player vehicle::set_vehicle_drivable_time(9009009, gettime() + 9009009);
    }
    function_f40e2444(player);
    function_3dd23073();
    player thread function_4c831d66();
    level.vtol thread watchplayerexitrequestthread(player);
    player thread watchplayerteamchangethread(level.vtol);
    visionset_mgr::activate("visionset", "mothership_visionset", player, 1, 60000, 1);
    player setmodellodbias(isdefined(level.mothership_lod_bias) ? level.mothership_lod_bias : 8);
    player clientfield::set_to_player("fog_bank_2", 1);
    if (true) {
        player thread hidecompassafterwait(0.1);
    }
    return true;
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0x83a8f40f, Offset: 0x29d8
// Size: 0x32
function hidecompassafterwait(waittime) {
    self endon(#"death");
    self endon(#"disconnect");
    wait waittime;
    self killstreaks::hide_compass();
}

// Namespace helicopter_gunner
// Params 3, eflags: 0x0
// Checksum 0x29c92492, Offset: 0x2a18
// Size: 0x102
function mainturretdestroyed(helicopter, eattacker, weapon) {
    helicopter.owner iprintlnbold(%KILLSTREAK_HELICOPTER_GUNNER_DAMAGED);
    helicopter.shuttingdown = 1;
    function_3dd23073();
    eattacker = self [[ level.figure_out_attacker ]](eattacker);
    if (!isdefined(helicopter.destroyscoreeventgiven) && isdefined(eattacker)) {
        luinotifyevent(%player_callout, 2, %KILLSTREAK_DESTROYED_HELICOPTER_GUNNER, eattacker.entnum);
        scoreevents::processscoreevent("destroyed_vtol_mothership", eattacker, helicopter.owner, weapon);
        helicopter killstreaks::play_destroyed_dialog_on_owner("helicopter_gunner", helicopter.killstreak_id);
        helicopter.destroyscoreeventgiven = 1;
    }
    helicopter thread performleavehelicopterfromdamage();
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0x386ea6db, Offset: 0x2b28
// Size: 0xa5
function function_fba55417(killstreakid) {
    self endon(#"hash_17ad017b");
    while (true) {
        self waittill(#"bda_dialog", dialogkey);
        for (i = 0; i < 2; i++) {
            if (isdefined(level.vtol.var_76f5125e[i].occupant)) {
                level.vtol.var_76f5125e[i].occupant killstreaks::play_pilot_dialog(dialogkey, "helicopter_gunner", killstreakid, self.pilotindex);
            }
        }
    }
}

// Namespace helicopter_gunner
// Params 2, eflags: 0x0
// Checksum 0x2bd0323d, Offset: 0x2bd8
// Size: 0x1ea
function function_760c6125(helicopter, seatindex) {
    var_f58b60e7 = helicopter.var_76f5125e[seatindex];
    if (!var_f58b60e7.destroyed) {
        target_remove(var_f58b60e7.targetent);
        level.vtol vehicle::remove_from_target_group();
        var_f58b60e7.targetent delete();
        var_f58b60e7.targetent = undefined;
        var_f58b60e7.destroyed = 1;
        if (isdefined(helicopter.owner) && isdefined(helicopter.hardpointtype)) {
            helicopter killstreaks::play_pilot_dialog_on_owner("weaponDestroyed", helicopter.hardpointtype, helicopter.killstreak_id);
        }
        if (isdefined(var_f58b60e7.occupant)) {
            var_f58b60e7.occupant globallogic_audio::flush_killstreak_dialog_on_player(helicopter.killstreak_id);
            var_f58b60e7.occupant killstreaks::play_pilot_dialog("weaponDestroyed", helicopter.hardpointtype, undefined, helicopter.pilotindex);
            wait 2;
            function_34b002ad(var_f58b60e7.occupant, 0);
        }
    }
    if (seatindex == 0) {
        level.vtol clientfield::set("vtol_turret_destroyed_0", 1);
        level.vtol function_2d1db7fe();
        return;
    }
    if (seatindex == 1) {
        level.vtol clientfield::set("vtol_turret_destroyed_1", 1);
        level.vtol function_2d1db7fe();
    }
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0xae209b41, Offset: 0x2dd0
// Size: 0x9b
function function_2d1db7fe() {
    vtol = self;
    function_f40e2444(vtol.owner);
    foreach (var_f58b60e7 in vtol.var_76f5125e) {
        function_f40e2444(var_f58b60e7.occupant);
    }
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0x44d2c733, Offset: 0x2e78
// Size: 0x2a
function function_f40e2444(player) {
    if (isdefined(player)) {
        player clientfield::increment_to_player("vtol_update_client", 1);
    }
}

// Namespace helicopter_gunner
// Params 3, eflags: 0x0
// Checksum 0x4ffc5e5, Offset: 0x2eb0
// Size: 0xd2
function vtoldestructiblecallback(brokennotify, eattacker, weapon) {
    helicopter = self;
    helicopter endon(#"delete");
    helicopter endon(#"hash_17ad017b");
    notifies = [];
    notifies[0] = "turret1_destroyed";
    notifies[1] = "turret2_destroyed";
    for (seatindex = 0; seatindex < 2; seatindex++) {
        if (brokennotify == notifies[seatindex]) {
            function_760c6125(helicopter, seatindex);
            break;
        }
    }
    if (brokennotify == "turret_destroyed") {
        mainturretdestroyed(helicopter, eattacker, weapon);
        return;
    }
    helicopter function_2b572c4b();
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0x7eda8f59, Offset: 0x2f90
// Size: 0x152
function function_2b572c4b() {
    helicopter = self;
    if (helicopter.var_76f5125e[0].destroyed && helicopter.var_76f5125e[1].destroyed) {
        if (!isdefined(helicopter.targetent)) {
            helicopter.targetent = spawn("script_model", (0, 0, 0));
            helicopter.targetent setmodel("p7_dogtags_enemy");
            helicopter.targetent linkto(level.vtol, "tag_barrel", (0, 0, 0), (0, 0, 0));
            helicopter.targetent.parent = level.vtol;
            helicopter.targetent.team = level.vtol.team;
            target_set(helicopter.targetent, (0, 0, 0));
            helicopter.targetent.usevtoltime = 1;
            target_setallowhighsteering(helicopter.targetent, 1);
            level.vtol vehicle::add_to_target_group(helicopter.targetent);
        }
    }
}

// Namespace helicopter_gunner
// Params 2, eflags: 0x0
// Checksum 0x3301a626, Offset: 0x30f0
// Size: 0x36a
function function_34b002ad(player, ownerleft) {
    if (!isdefined(level.vtol) || level.vtol.completely_shutdown === 1) {
        return;
    }
    if (isdefined(player)) {
        player vehicle::stop_monitor_missiles_locked_on_to_me();
        player vehicle::stop_monitor_damage_as_occupant();
    }
    if (isdefined(player) && isdefined(level.vtol) && isdefined(level.vtol.owner)) {
        if (isdefined(player.usingvehicle) && player.usingvehicle) {
            player unlink();
            level.vtol clientfield::set("vehicletransition", 0);
            if (ownerleft) {
                player killstreaks::take("helicopter_gunner");
            } else {
                player killstreaks::take("inventory_helicopter_gunner_assistant");
            }
        }
    }
    if (ownerleft) {
        level.vtol.shuttingdown = 1;
        foreach (var_f58b60e7 in level.vtol.var_76f5125e) {
            if (isdefined(var_f58b60e7.occupant)) {
                var_f58b60e7.occupant iprintlnbold(%KILLSTREAK_HELICOPTER_GUNNER_DAMAGED);
                function_34b002ad(var_f58b60e7.occupant, 0);
            }
        }
        level.vtol.hardpointtype = "helicopter_gunner";
        level.vtol thread helicopter::heli_leave();
        level.vtol thread audio::sndupdatevehiclecontext(0);
    } else if (isdefined(player)) {
        player globallogic_audio::flush_killstreak_dialog_on_player(level.vtol.killstreak_id);
        foreach (var_f58b60e7 in level.vtol.var_76f5125e) {
            if (isdefined(var_f58b60e7.occupant) && var_f58b60e7.occupant == player) {
                var_f58b60e7.occupant = undefined;
                break;
            }
        }
    }
    if (isdefined(player)) {
        player clientfield::set_to_player("toggle_flir_postfx", 0);
        visionset_mgr::deactivate("visionset", "mothership_visionset", player);
        player setmodellodbias(0);
        player clientfield::set_to_player("fog_bank_2", 0);
        player killstreaks::unhide_compass();
        player notify(#"gunner_left");
        player killstreaks::clear_using_remote();
        if (level.gameended) {
            player util::freeze_player_controls(1);
        }
    }
    function_3dd23073();
    if (ownerleft) {
        level.vtol.completely_shutdown = 1;
    }
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0x48099aa, Offset: 0x3468
// Size: 0xa2
function function_dee9cced() {
    if (isdefined(level.vtol) && isdefined(level.vtol.owner)) {
        org = level.vtol gettagorigin("tag_barrel");
        magnitude = 0.3;
        duration = 2;
        radius = 500;
        v_pos = self.origin;
        earthquake(magnitude, duration, org, 500);
    }
}

// Namespace helicopter_gunner
// Params 15, eflags: 0x0
// Checksum 0xc1eb5095, Offset: 0x3518
// Size: 0x4e1
function function_c23b805c(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    helicopter = self;
    if (smeansofdeath == "MOD_TRIGGER_HURT") {
        return 0;
    }
    if (helicopter.shuttingdown) {
        return 0;
    }
    idamage = self killstreaks::ondamageperweapon("helicopter_gunner", eattacker, idamage, idflags, smeansofdeath, weapon, level.vtol.maxhealth, undefined, level.vtol.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
    if (idamage == 0) {
        return 0;
    }
    if (smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_EXPLOSIVE") {
        var_c3da14de = 1;
        missiletarget = einflictor missile_gettarget();
        function_dee9cced();
        helicopter.totalrockethits++;
        if (isdefined(missiletarget)) {
            for (seatindex = 0; seatindex < 2; seatindex++) {
                var_f58b60e7 = helicopter.var_76f5125e[seatindex];
                if (!var_f58b60e7.destroyed && var_f58b60e7.targetent == missiletarget) {
                    helicopter dodamage(idamage, var_f58b60e7.targetent.origin, eattacker, einflictor, shitloc, "MOD_UNKNOWN", 0, weapon, seatindex + 8);
                    idamage = 0;
                    function_760c6125(helicopter, seatindex);
                }
            }
            if (isdefined(helicopter.targetent) && helicopter.targetent == missiletarget) {
                helicopter.turretrockethits++;
                if (helicopter.turretrockethits >= 2) {
                    target_remove(helicopter.targetent);
                    helicopter.targetent delete();
                    helicopter.targetent = undefined;
                }
            }
        }
        if (helicopter.var_76f5125e[0].destroyed && helicopter.var_76f5125e[1].destroyed && !isdefined(helicopter.targetent)) {
            helicopter.targetent = spawn("script_model", (0, 0, 0));
            helicopter.targetent setmodel("p7_dogtags_enemy");
            helicopter.targetent linkto(level.vtol, "tag_barrel", (0, 0, 0), (0, 0, 0));
            helicopter.targetent.parent = level.vtol;
            helicopter.targetent.team = level.vtol.team;
            target_set(helicopter.targetent, (0, 0, 0));
            helicopter.targetent.usevtoltime = 1;
            target_setallowhighsteering(helicopter.targetent, 1);
        }
        if (helicopter.totalrockethits >= 4) {
            mainturretdestroyed(helicopter, eattacker, weapon);
            var_c3da14de = 0;
        }
        if (var_c3da14de) {
            function_3dd23073();
        }
    }
    if (idamage >= level.vtol.health && !helicopter.shuttingdown) {
        helicopter.owner iprintlnbold(%KILLSTREAK_HELICOPTER_GUNNER_DAMAGED);
        helicopter.shuttingdown = 1;
        function_3dd23073();
        if (!isdefined(helicopter.destroyscoreeventgiven) && isdefined(eattacker)) {
            eattacker = self [[ level.figure_out_attacker ]](eattacker);
            scoreevents::processscoreevent("destroyed_vtol_mothership", eattacker, helicopter.owner, weapon);
            helicopter killstreaks::play_destroyed_dialog_on_owner("helicopter_gunner", helicopter.killstreak_id);
            helicopter.destroyscoreeventgiven = 1;
        }
        helicopter thread performleavehelicopterfromdamage();
    }
    if (helicopter.shuttingdown) {
        if (idamage >= helicopter.health) {
            idamage = helicopter.health - 1;
        }
    }
    return idamage;
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0xb26e861f, Offset: 0x3a08
// Size: 0x8a
function performleavehelicopterfromdamage() {
    helicopter = self;
    helicopter endon(#"death");
    if (self.leave_by_damage_initiated === 1) {
        return;
    }
    self.leave_by_damage_initiated = 1;
    helicopter thread remote_weapons::do_static_fx();
    failsafe_timeout = 5;
    helicopter util::waittill_any_timeout(failsafe_timeout, "static_fx_done");
    function_34b002ad(helicopter.owner, 1);
}

// Namespace helicopter_gunner
// Params 2, eflags: 0x0
// Checksum 0x1d30f2a8, Offset: 0x3aa0
// Size: 0x2a
function helicoptedetonateviaemp(attacker, weapon) {
    mainturretdestroyed(level.vtol, attacker, weapon);
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0x77dba17, Offset: 0x3ad8
// Size: 0x5a
function missilecleanupthread(missile) {
    targetent = self;
    targetent endon(#"delete");
    targetent endon(#"death");
    missile util::waittill_any("death", "delete");
    targetent delete();
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0x64e42a5b, Offset: 0x3b40
// Size: 0x22d
function function_71d93771() {
    helicopter = self;
    player = helicopter.owner;
    player endon(#"disconnect");
    player endon(#"gunner_left");
    var_40f7aeb = getweapon("helicopter_gunner_turret_rockets");
    while (true) {
        player waittill(#"missile_fire", missile);
        trace_origin = level.vtol gettagorigin("tag_flash");
        var_3cdd662a = level.vtol gettagangles("tag_barrel");
        var_3cdd662a = anglestoforward(var_3cdd662a) * 8000;
        trace = bullettrace(trace_origin, trace_origin + var_3cdd662a, 0, level.vtol);
        end_origin = trace["position"];
        missiles = getentarray("rocket", "classname");
        /#
        #/
        foreach (missile in missiles) {
            if (missile.item == var_40f7aeb) {
                targetent = spawn("script_model", end_origin);
                missile missile_settarget(targetent);
                targetent thread missilecleanupthread(missile);
            }
        }
        weapon_wait_duration_ms = int(var_40f7aeb.firetime * 1000);
        player setvehicleweaponwaitduration(weapon_wait_duration_ms);
        player setvehicleweaponwaitendtime(gettime() + weapon_wait_duration_ms);
    }
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0x110b36a7, Offset: 0x3d78
// Size: 0x11d
function function_4c831d66() {
    assert(isplayer(self));
    player = self;
    player endon(#"disconnect");
    player endon(#"gunner_left");
    inverted = 0;
    player clientfield::set_to_player("toggle_flir_postfx", 2);
    while (true) {
        if (player jumpbuttonpressed()) {
            if (inverted) {
                player clientfield::set_to_player("toggle_flir_postfx", 2);
                player playsoundtoplayer("mpl_cgunner_flir_off", player);
            } else {
                player clientfield::set_to_player("toggle_flir_postfx", 1);
                player playsoundtoplayer("mpl_cgunner_flir_on", player);
            }
            inverted = !inverted;
            while (player jumpbuttonpressed()) {
                wait 0.05;
            }
        }
        wait 0.05;
    }
}

// Namespace helicopter_gunner
// Params 2, eflags: 0x0
// Checksum 0x96a5ac48, Offset: 0x3ea0
// Size: 0x165
function playlockonsoundsthread(player, heli) {
    player endon(#"disconnect");
    player endon(#"gunner_left");
    heli endon(#"death");
    heli endon(#"crashing");
    heli endon(#"leaving");
    heli.locksounds = spawn("script_model", heli.origin);
    wait 0.1;
    heli.locksounds linkto(heli, "tag_player");
    while (true) {
        heli waittill(#"locking on");
        while (true) {
            if (enemyislocking(heli)) {
                heli.locksounds playsoundtoplayer("uin_alert_lockon", player);
                wait 0.125;
            }
            if (enemylockedon(heli)) {
                heli.locksounds playsoundtoplayer("uin_alert_lockon", player);
                wait 0.125;
            }
            if (!enemyislocking(heli) && !enemylockedon(heli)) {
                heli.locksounds stopsounds();
                break;
            }
        }
    }
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0x1e653ad0, Offset: 0x4010
// Size: 0x21
function enemyislocking(heli) {
    return isdefined(heli.locking_on) && heli.locking_on;
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0x93919801, Offset: 0x4040
// Size: 0x21
function enemylockedon(heli) {
    return isdefined(heli.locked_on) && heli.locked_on;
}

// Namespace helicopter_gunner
// Params 2, eflags: 0x0
// Checksum 0xc93fe103, Offset: 0x4070
// Size: 0x349
function function_78edc502(startnode, destnodes) {
    self notify(#"flying");
    self endon(#"flying");
    self endon(#"death");
    self endon(#"crashing");
    self endon(#"leaving");
    nextnode = getent(startnode.target, "targetname");
    assert(isdefined(nextnode), "<dev string:x28>");
    self setspeed(-106, 80);
    self setvehgoalpos(nextnode.origin + (0, 0, 2000), 1);
    self waittill(#"near_goal");
    firstpass = 1;
    if (!self.playermovedrecently) {
        node = self updateareanodes(destnodes, 0);
        level.vtol.currentnode = node;
        targetnode = getent(node.target, "targetname");
        traveltonode(targetnode);
        if (isdefined(targetnode.script_airspeed) && isdefined(targetnode.script_accel)) {
            heli_speed = targetnode.script_airspeed;
            heli_accel = targetnode.script_accel;
        } else {
            heli_speed = -106 + randomint(20);
            heli_accel = 40 + randomint(10);
        }
        self setspeed(heli_speed, heli_accel);
        self setvehgoalpos(targetnode.origin + (0, 0, 2000), 1);
        self setgoalyaw(targetnode.angles[1] + 0);
    }
    if (0 != 0) {
        self waittill(#"near_goal");
        waittime = 0;
    } else if (!isdefined(targetnode.script_delay)) {
        self waittill(#"near_goal");
        waittime = 10 + randomint(5);
    } else {
        self waittillmatch(#"goal");
        waittime = targetnode.script_delay;
    }
    if (firstpass) {
        self.killstreak_duration = self.killstreak_timer_start_using_hacked_time === 1 ? self killstreak_hacking::get_hacked_timeout_duration_ms() : 60000;
        self.killstreak_end_time = gettime() + self.killstreak_duration;
        self.killstreakendtime = int(self.killstreak_end_time);
        self thread killstreaks::waitfortimeout("helicopter_gunner", self.killstreak_duration, &ontimeoutcallback, "delete", "death");
        self.killstreak_timer_started = 1;
        self updatedrivabletimeforalloccupants(self.killstreak_duration, self.killstreak_end_time);
        firstpass = 0;
    }
    wait waittime;
}

// Namespace helicopter_gunner
// Params 2, eflags: 0x0
// Checksum 0xd0bb0d76, Offset: 0x43c8
// Size: 0xa1
function updatedrivabletimeforalloccupants(duration_ms, end_time_ms) {
    if (isdefined(self.owner)) {
        self.owner vehicle::set_vehicle_drivable_time(duration_ms, end_time_ms);
    }
    for (i = 0; i < 2; i++) {
        if (isdefined(self.var_76f5125e[i].occupant) && !self.var_76f5125e[i].destroyed) {
            self.var_76f5125e[i].occupant vehicle::set_vehicle_drivable_time(duration_ms, end_time_ms);
        }
    }
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0x2473ccaf, Offset: 0x4478
// Size: 0x21d
function watchlocationchangethread(destnodes) {
    player = self;
    player endon(#"disconnect");
    player endon(#"gunner_left");
    helicopter = level.vtol;
    helicopter endon(#"delete");
    helicopter endon(#"hash_17ad017b");
    player.moves = 0;
    helicopter waittill(#"near_goal");
    helicopter waittill(#"goal");
    while (true) {
        if (self secondaryoffhandbuttonpressed()) {
            player.moves++;
            player thread setplayermovedrecentlythread();
            node = self updateareanodes(destnodes, 1);
            helicopter.currentnode = node;
            targetnode = getent(node.target, "targetname");
            player playlocalsound("mpl_cgunner_nav");
            helicopter traveltonode(targetnode);
            if (isdefined(targetnode.script_airspeed) && isdefined(targetnode.script_accel)) {
                heli_speed = targetnode.script_airspeed;
                heli_accel = targetnode.script_accel;
            } else {
                heli_speed = 80 + randomint(20);
                heli_accel = 40 + randomint(10);
            }
            helicopter setspeed(heli_speed, heli_accel);
            helicopter setvehgoalpos(targetnode.origin + (0, 0, 2000), 1);
            helicopter setgoalyaw(targetnode.angles[1] + 0);
            helicopter waittill(#"goal");
            while (self secondaryoffhandbuttonpressed()) {
                wait 0.05;
            }
        }
        wait 0.05;
    }
}

// Namespace helicopter_gunner
// Params 0, eflags: 0x0
// Checksum 0x605f0d4d, Offset: 0x46a0
// Size: 0x8e
function setplayermovedrecentlythread() {
    player = self;
    player endon(#"disconnect");
    player endon(#"gunner_left");
    helicopter = level.vtol;
    helicopter endon(#"delete");
    helicopter endon(#"hash_17ad017b");
    mymove = self.moves;
    level.vtol.playermovedrecently = 1;
    wait 100;
    if (mymove == self.moves && isdefined(level.vtol)) {
        level.vtol.playermovedrecently = 0;
    }
}

// Namespace helicopter_gunner
// Params 2, eflags: 0x0
// Checksum 0x4fa29a39, Offset: 0x4738
// Size: 0x335
function updateareanodes(areanodes, forcemove) {
    validenemies = [];
    foreach (node in areanodes) {
        node.validplayers = [];
        node.nodescore = 0;
    }
    foreach (player in level.players) {
        if (!isalive(player)) {
            continue;
        }
        if (player.team == self.team) {
            continue;
        }
        foreach (node in areanodes) {
            if (distancesquared(player.origin, node.origin) > 1048576) {
                continue;
            }
            node.validplayers[node.validplayers.size] = player;
        }
    }
    bestnode = undefined;
    foreach (node in areanodes) {
        if (isdefined(level.vtol.currentnode) && node == level.vtol.currentnode) {
            continue;
        }
        helinode = getent(node.target, "targetname");
        foreach (player in node.validplayers) {
            node.nodescore += 1;
            if (bullettracepassed(player.origin + (0, 0, 32), helinode.origin, 0, player)) {
                node.nodescore += 3;
            }
        }
        if (forcemove && distance(level.vtol.origin, helinode.origin) < -56) {
            node.nodescore = -1;
        }
        if (!isdefined(bestnode) || node.nodescore > bestnode.nodescore) {
            bestnode = node;
        }
    }
    return bestnode;
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0xa031c32, Offset: 0x4a78
// Size: 0x1dc
function traveltonode(goalnode) {
    originoffets = getoriginoffsets(goalnode);
    if (originoffets["start"] != self.origin) {
        if (isdefined(goalnode.script_airspeed) && isdefined(goalnode.script_accel)) {
            heli_speed = goalnode.script_airspeed;
            heli_accel = goalnode.script_accel;
        } else {
            heli_speed = 30 + randomint(20);
            heli_accel = 15 + randomint(15);
        }
        self setspeed(heli_speed, heli_accel);
        self setvehgoalpos(originoffets["start"] + (0, 0, 30), 0);
        self setgoalyaw(goalnode.angles[1] + 0);
        self waittill(#"goal");
    }
    if (originoffets["end"] != goalnode.origin) {
        if (isdefined(goalnode.script_airspeed) && isdefined(goalnode.script_accel)) {
            heli_speed = goalnode.script_airspeed;
            heli_accel = goalnode.script_accel;
        } else {
            heli_speed = 30 + randomint(20);
            heli_accel = 15 + randomint(15);
        }
        self setspeed(heli_speed, heli_accel);
        self setvehgoalpos(originoffets["end"] + (0, 0, 30), 0);
        self setgoalyaw(goalnode.angles[1] + 0);
        self waittill(#"goal");
    }
}

// Namespace helicopter_gunner
// Params 1, eflags: 0x0
// Checksum 0x7fa4abba, Offset: 0x4c60
// Size: 0x197
function getoriginoffsets(goalnode) {
    startorigin = self.origin;
    endorigin = goalnode.origin;
    numtraces = 0;
    maxtraces = 40;
    traceoffset = (0, 0, -196);
    for (traceorigin = bullettrace(startorigin + traceoffset, endorigin + traceoffset, 0, self); distancesquared(traceorigin["position"], endorigin + traceoffset) > 10 && numtraces < maxtraces; traceorigin = bullettrace(startorigin + traceoffset, endorigin + traceoffset, 0, self)) {
        println("<dev string:x5b>" + distancesquared(traceorigin["<dev string:x6a>"], endorigin + traceoffset));
        if (startorigin[2] < endorigin[2]) {
            startorigin += (0, 0, 128);
        } else if (startorigin[2] > endorigin[2]) {
            endorigin += (0, 0, 128);
        } else {
            startorigin += (0, 0, 128);
            endorigin += (0, 0, 128);
        }
        numtraces++;
    }
    offsets = [];
    offsets["start"] = startorigin;
    offsets["end"] = endorigin;
    return offsets;
}

