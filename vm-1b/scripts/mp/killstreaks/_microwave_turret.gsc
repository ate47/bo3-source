#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_emp;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_placeables;
#using scripts/mp/killstreaks/_remote_weapons;
#using scripts/mp/killstreaks/_turret;
#using scripts/mp/teams/_teams;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/weapons/_weaponobjects;

#using_animtree("mp_microwaveturret");

#namespace microwave_turret;

// Namespace microwave_turret
// Params 0, eflags: 0x0
// Checksum 0xde154e73, Offset: 0x928
// Size: 0x1fa
function init() {
    killstreaks::register("microwave_turret", "microwave_turret_deploy", "killstreak_" + "microwave_turret", "microwave_turret" + "_used", &function_a6ec3693, 0, 1);
    killstreaks::function_f79fd1e9("microwave_turret", %KILLSTREAK_EARNED_MICROWAVE_TURRET, %KILLSTREAK_MICROWAVE_TURRET_NOT_AVAILABLE, %KILLSTREAK_MICROWAVE_TURRET_INBOUND, undefined, %KILLSTREAK_MICROWAVE_TURRET_HACKED, 0);
    killstreaks::register_dialog("microwave_turret", "mpl_killstreak_turret", "microwaveTurretDialogBundle", undefined, "friendlyMicrowaveTurret", "enemyMicrowaveTurret", "enemyMicrowaveTurretMultiple", "friendlyMicrowaveTurretHacked", "enemyMicrowaveTurretHacked", "requestMicrowaveTurret", "threatMicrowaveTurret");
    killstreaks::register_remote_override_weapon("microwave_turret", "microwave_turret");
    level.var_4d5c4eeb = mp_microwaveturret%o_turret_guardian_open;
    level.var_eb30cdd7 = mp_microwaveturret%o_turret_guardian_close;
    clientfield::register("vehicle", "turret_microwave_open", 1, 1, "int");
    clientfield::register("scriptmover", "turret_microwave_init", 1, 1, "int");
    clientfield::register("scriptmover", "turret_microwave_close", 1, 1, "int");
    vehicle::add_main_callback("microwave_turret", &initturretvehicle);
    callback::on_spawned(&on_player_spawned);
}

// Namespace microwave_turret
// Params 0, eflags: 0x0
// Checksum 0x54bcb76a, Offset: 0xb30
// Size: 0xde
function initturretvehicle() {
    turretvehicle = self;
    turretvehicle killstreaks::setup_health("microwave_turret");
    turretvehicle.damagetaken = 0;
    turretvehicle.health = turretvehicle.maxhealth;
    turretvehicle turret::function_3cf7ce0e(750 * 1.2, 0);
    turretvehicle turret::set_on_target_angle(15, 0);
    turretvehicle clientfield::set("enemyvehicle", 1);
    turretvehicle.soundmod = "hpm";
    turretvehicle.overridevehicledamage = &onturretdamage;
    turretvehicle.var_60bdc617 = &onturretdeath;
    turretvehicle.aim_only_no_shooting = 1;
}

// Namespace microwave_turret
// Params 0, eflags: 0x0
// Checksum 0x1548e19f, Offset: 0xc18
// Size: 0x19
function on_player_spawned() {
    player = self;
    player.var_b0df2ddb = undefined;
}

// Namespace microwave_turret
// Params 0, eflags: 0x0
// Checksum 0xd2f7d15, Offset: 0xc40
// Size: 0x22d
function function_a6ec3693() {
    player = self;
    assert(isplayer(player));
    killstreakid = self killstreakrules::killstreakstart("microwave_turret", player.team, 0, 0);
    if (killstreakid == -1) {
        return false;
    }
    bundle = level.killstreakbundle["microwave_turret"];
    turret = player placeables::spawnplaceable("microwave_turret", killstreakid, &onplaceturret, &oncancelplacement, &onpickupturret, &onshutdown, undefined, &onemp, "veh_t7_turret_guardian", "veh_t7_turret_guardian_yellow", "veh_t7_turret_guardian_red", 1, %KILLSTREAK_MICROWAVE_TURRET_PICKUP, 90000, undefined, 1800 + 1, bundle.ksplaceablehint, bundle.ksplaceableinvalidlocationhint);
    turret killstreaks::setup_health("microwave_turret");
    turret.damagetaken = 0;
    turret.killstreakendtime = gettime() + 90000;
    turret thread function_dd009dff(killstreakid, player.team);
    turret thread util::ghost_wait_show_to_player(player);
    turret.othermodel thread util::ghost_wait_show_to_others(player);
    turret clientfield::set("turret_microwave_init", 1);
    turret.othermodel clientfield::set("turret_microwave_init", 1);
    event = turret util::waittill_any_return("placed", "cancelled", "death");
    if (event != "placed") {
        return false;
    }
    return true;
}

// Namespace microwave_turret
// Params 1, eflags: 0x0
// Checksum 0x276c27ad, Offset: 0xe78
// Size: 0x2fa
function onplaceturret(turret) {
    player = self;
    assert(isplayer(player));
    if (isdefined(turret.vehicle)) {
        turret.vehicle.origin = turret.origin;
        turret.vehicle.angles = turret.angles;
        turret.vehicle thread util::ghost_wait_show(0.05);
    } else {
        turret.vehicle = spawnvehicle("microwave_turret", turret.origin, turret.angles, "dynamic_spawn_ai");
        turret.vehicle.owner = player;
        turret.vehicle setowner(player);
        turret.vehicle.ownerentnum = player.entnum;
        turret.vehicle.parentstruct = turret;
        turret.vehicle.team = player.team;
        turret.vehicle setteam(player.team);
        turret.vehicle turret::set_team(player.team, 0);
        turret.vehicle.ignore_vehicle_underneath_splash_scalar = 1;
        turret.vehicle.use_non_teambased_enemy_selection = 1;
        turret.vehicle.turret = turret;
        turret.vehicle thread util::ghost_wait_show(0.05);
        level thread popups::displaykillstreakteammessagetoall("microwave_turret", player);
        turret.vehicle killstreaks::configure_team("microwave_turret", turret.killstreakid, player);
        turret.vehicle killstreak_hacking::enable_hacking("microwave_turret", &hackedprefunction, &hackedpostfunction);
        player killstreaks::play_killstreak_start_dialog("microwave_turret", player.pers["team"], turret.killstreakid);
    }
    turret.vehicle turret::enable(0, 0);
    target_set(turret.vehicle, (0, 0, 36));
    turret.vehicle vehicle::disconnect_paths(0, 0);
    turret startmicrowave();
}

// Namespace microwave_turret
// Params 1, eflags: 0x0
// Checksum 0xc4649dc1, Offset: 0x1180
// Size: 0x7a
function hackedprefunction(hacker) {
    turretvehicle = self;
    turretvehicle.turret notify(#"hacker_delete_placeable_trigger");
    turretvehicle.turret stopmicrowave();
    turretvehicle.turret killstreaks::configure_team("microwave_turret", turretvehicle.turret.killstreakid, hacker, undefined, undefined, undefined, 1);
}

// Namespace microwave_turret
// Params 1, eflags: 0x0
// Checksum 0x4de58b4, Offset: 0x1208
// Size: 0x32
function hackedpostfunction(hacker) {
    turretvehicle = self;
    turretvehicle.turret startmicrowave();
}

// Namespace microwave_turret
// Params 1, eflags: 0x0
// Checksum 0xf2bf143b, Offset: 0x1248
// Size: 0x14
function oncancelplacement(turret) {
    turret notify(#"microwave_turret_shutdown");
}

// Namespace microwave_turret
// Params 1, eflags: 0x0
// Checksum 0xc40a7f6c, Offset: 0x1268
// Size: 0x9a
function onpickupturret(turret) {
    turret stopmicrowave();
    turret.vehicle thread function_18ab2c03(0.05);
    turret.vehicle turret::disable(0);
    turret.vehicle linkto(turret);
    target_remove(turret.vehicle);
    turret.vehicle vehicle::connect_paths();
}

// Namespace microwave_turret
// Params 1, eflags: 0x0
// Checksum 0x4b4039cf, Offset: 0x1310
// Size: 0x2a
function function_18ab2c03(wait_time) {
    self endon(#"death");
    wait wait_time;
    self ghost();
}

// Namespace microwave_turret
// Params 1, eflags: 0x0
// Checksum 0xb654cab8, Offset: 0x1348
// Size: 0x16
function onemp(attacker) {
    turret = self;
}

// Namespace microwave_turret
// Params 15, eflags: 0x0
// Checksum 0xb2aebc3, Offset: 0x1368
// Size: 0x104
function onturretdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    empdamage = int(idamage + self.healthdefault * 1 + 0.5);
    idamage = self killstreaks::ondamageperweapon("microwave_turret", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, empdamage, undefined, 1, 1);
    self.damagetaken = self.damagetaken + idamage;
    return idamage;
}

// Namespace microwave_turret
// Params 8, eflags: 0x0
// Checksum 0xbe4808e9, Offset: 0x1478
// Size: 0x1f2
function onturretdeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    turretvehicle = self;
    eattacker = self [[ level.figure_out_attacker ]](eattacker);
    if (isdefined(turretvehicle.parentstruct)) {
        turretvehicle.parentstruct placeables::forceshutdown();
        if (turretvehicle.parentstruct.killstreaktimedout === 1 && isdefined(turretvehicle.owner)) {
            turretvehicle.owner globallogic_audio::play_taacom_dialog("timeout", turretvehicle.parentstruct.killstreaktype);
        } else if (isdefined(eattacker) && isplayer(eattacker) && isdefined(turretvehicle.owner) && eattacker != turretvehicle.owner) {
            turretvehicle.parentstruct killstreaks::play_destroyed_dialog_on_owner(turretvehicle.parentstruct.killstreaktype, turretvehicle.parentstruct.killstreakid);
        }
    }
    if (isplayer(eattacker)) {
        scoreevents::processscoreevent("destroyed_microwave_turret", eattacker, self, weapon);
        luinotifyevent(%player_callout, 2, %KILLSTREAK_DESTROYED_MICROWAVE_TURRET, eattacker.entnum);
    }
    if (isdefined(turretvehicle.parentstruct)) {
        turretvehicle.parentstruct notify(#"microwave_turret_shutdown");
    }
    turretvehicle vehicle_death::death_fx();
    wait 0.1;
    turretvehicle delete();
}

// Namespace microwave_turret
// Params 1, eflags: 0x0
// Checksum 0x21d0753e, Offset: 0x1678
// Size: 0x6c
function onshutdown(turret) {
    turret stopmicrowave();
    if (isdefined(turret.vehicle)) {
        turret.vehicle playsound("mpl_m_turret_exp");
        turret.vehicle kill();
    }
    turret notify(#"microwave_turret_shutdown");
}

// Namespace microwave_turret
// Params 2, eflags: 0x0
// Checksum 0x6b8c5e37, Offset: 0x16f0
// Size: 0x42
function function_dd009dff(killstreak_id, team) {
    turret = self;
    turret waittill(#"microwave_turret_shutdown");
    killstreakrules::killstreakstop("microwave_turret", team, killstreak_id);
}

// Namespace microwave_turret
// Params 0, eflags: 0x0
// Checksum 0xcfc3addc, Offset: 0x1740
// Size: 0x55
function startmicrowave() {
    turret = self;
    if (isdefined(turret.trigger)) {
        turret.trigger delete();
    }
    InvalidOpCode(0xb9, level.vehicletriggerspawnflags, level.aitriggerspawnflags, 750, 750 * 2);
    // Unknown operator (0xb9, t7_1b, PC)
}

// Namespace microwave_turret
// Params 0, eflags: 0x0
// Checksum 0xebc81595, Offset: 0x1898
// Size: 0x118
function stopmicrowave() {
    turret = self;
    turret spawning::remove_influencers();
    if (isdefined(turret)) {
        turret clientfield::set("turret_microwave_close", 1);
        turret.othermodel clientfield::set("turret_microwave_close", 1);
        if (isdefined(turret.vehicle)) {
            turret.vehicle clientfield::set("turret_microwave_open", 0);
        }
        turret playsound("mpl_microwave_beam_off");
        if (isdefined(turret.microwavefxent)) {
            turret.microwavefxent delete();
        }
        if (isdefined(turret.trigger)) {
            turret.trigger notify(#"hash_2e236377");
            turret.trigger delete();
        }
        /#
            turret notify(#"stop_turret_debug");
        #/
    }
}

// Namespace microwave_turret
// Params 0, eflags: 0x0
// Checksum 0x30e3b3c5, Offset: 0x19b8
// Size: 0x61
function turretdebugwatch() {
    turret = self;
    turret endon(#"stop_turret_debug");
    for (;;) {
        if (getdvarint("scr_microwave_turret_debug") != 0) {
            turret turretdebug();
            wait 0.05;
            continue;
        }
        wait 1;
    }
}

// Namespace microwave_turret
// Params 0, eflags: 0x0
// Checksum 0xfd1666b7, Offset: 0x1a28
// Size: 0xe2
function turretdebug() {
    turret = self;
    var_44a0aac0 = 3;
    angles = turret.vehicle gettagangles("tag_flash");
    origin = turret.vehicle gettagorigin("tag_flash");
    cone_apex = origin;
    forward = anglestoforward(angles);
    dome_apex = cone_apex + vectorscale(forward, 750);
    util::debug_spherical_cone(cone_apex, dome_apex, 15, 16, (0.95, 0.1, 0.1), 0.3, 1, var_44a0aac0);
}

// Namespace microwave_turret
// Params 0, eflags: 0x0
// Checksum 0x825bf704, Offset: 0x1b18
// Size: 0x85
function turretthink() {
    turret = self;
    turret endon(#"microwave_turret_shutdown");
    turret.trigger endon(#"death");
    turret.trigger endon(#"delete");
    while (true) {
        turret.trigger waittill(#"trigger", ent);
        if (!isdefined(ent.var_b0df2ddb) || !ent.var_b0df2ddb) {
            turret thread microwaveentity(ent);
        }
    }
}

// Namespace microwave_turret
// Params 1, eflags: 0x0
// Checksum 0xa69622e9, Offset: 0x1ba8
// Size: 0x4d
function microwaveentitypostshutdowncleanup(entity) {
    entity endon(#"disconnect");
    entity endon(#"end_microwaveentitypostshutdowncleanup");
    turret = self;
    turret waittill(#"microwave_turret_shutdown");
    if (isdefined(entity)) {
        entity.var_b0df2ddb = 0;
        entity.beingmicrowavedby = undefined;
    }
}

// Namespace microwave_turret
// Params 1, eflags: 0x0
// Checksum 0x43f74379, Offset: 0x1c00
// Size: 0x4fd
function microwaveentity(entity) {
    turret = self;
    turret endon(#"microwave_turret_shutdown");
    entity endon(#"disconnect");
    entity endon(#"death");
    if (isplayer(entity)) {
        entity endon(#"joined_team");
        entity endon(#"joined_spectators");
    }
    turret thread microwaveentitypostshutdowncleanup(entity);
    entity.var_b0df2ddb = 1;
    entity.beingmicrowavedby = self.owner;
    entity.microwavedamageinitialdelay = 1;
    entity.microwaveeffect = 0;
    shellshockscalar = 1;
    viewkickscalar = 1;
    damagescalar = 1;
    if (isplayer(entity) && entity hasperk("specialty_microwaveprotection")) {
        shellshockscalar = getdvarfloat("specialty_microwaveprotection_shellshock_scalar", 0.5);
        viewkickscalar = getdvarfloat("specialty_microwaveprotection_viewkick_scalar", 0.5);
        damagescalar = getdvarfloat("specialty_microwaveprotection_damage_scalar", 0.5);
    }
    turretweapon = getweapon("microwave_turret");
    while (true) {
        if (!isdefined(turret) || !turret microwaveturretaffectsentity(entity) || !isdefined(turret.trigger)) {
            if (!isdefined(entity)) {
                return;
            }
            entity.var_b0df2ddb = 0;
            entity.beingmicrowavedby = undefined;
            if (isdefined(entity.microwavepoisoning) && entity.microwavepoisoning) {
                entity.microwavepoisoning = 0;
            }
            entity notify(#"end_microwaveentitypostshutdowncleanup");
            return;
        }
        damage = 10 * damagescalar;
        if (level.hardcoremode) {
            damage /= 2;
        }
        if (!isai(entity) && entity util::mayapplyscreeneffect()) {
            if (!isdefined(entity.microwavepoisoning) || !entity.microwavepoisoning) {
                entity.microwavepoisoning = 1;
                entity.microwaveeffect = 0;
            }
        }
        if (isdefined(entity.microwavedamageinitialdelay)) {
            wait randomfloatrange(0.1, 0.3);
            entity.microwavedamageinitialdelay = undefined;
        }
        entity dodamage(damage, turret.origin, turret.owner, turret.vehicle, 0, "MOD_TRIGGER_HURT", 0, turretweapon);
        entity.microwaveeffect++;
        if (isplayer(entity) && !entity isremotecontrolling()) {
            if (entity.microwaveeffect % 2 == 1) {
                if (distancesquared(entity.origin, turret.origin) > 750 * 2 / 3 * 750 * 2 / 3) {
                    entity shellshock("mp_radiation_low", 1.5 * shellshockscalar);
                    entity viewkick(int(25 * viewkickscalar), turret.origin);
                } else if (distancesquared(entity.origin, turret.origin) > 750 * 1 / 3 * 750 * 1 / 3) {
                    entity shellshock("mp_radiation_med", 1.5 * shellshockscalar);
                    entity viewkick(int(50 * viewkickscalar), turret.origin);
                } else {
                    entity shellshock("mp_radiation_high", 1.5 * shellshockscalar);
                    entity viewkick(int(75 * viewkickscalar), turret.origin);
                }
            }
        }
        if (isplayer(entity) && entity.microwaveeffect % 3 == 2) {
            scoreevents::processscoreevent("hpm_suppress", turret.owner, entity, turretweapon);
        }
        wait 0.5;
    }
}

// Namespace microwave_turret
// Params 1, eflags: 0x0
// Checksum 0x469d8d4d, Offset: 0x2108
// Size: 0x20b
function microwaveturretaffectsentity(entity) {
    turret = self;
    if (!isalive(entity)) {
        return false;
    }
    if (!isplayer(entity) && !isai(entity)) {
        return false;
    }
    if (isdefined(turret.carried) && turret.carried) {
        return false;
    }
    if (turret weaponobjects::isstunned()) {
        return false;
    }
    if (isdefined(turret.owner) && entity == turret.owner) {
        return false;
    }
    if (!weaponobjects::friendlyfirecheck(turret.owner, entity, 0)) {
        return false;
    }
    if (distancesquared(entity.origin, turret.origin) > 750 * 750) {
        return false;
    }
    angles = turret.vehicle gettagangles("tag_flash");
    origin = turret.vehicle gettagorigin("tag_flash");
    shoot_at_pos = entity getshootatpos(turret);
    entdirection = vectornormalize(shoot_at_pos - origin);
    forward = anglestoforward(angles);
    dot = vectordot(entdirection, forward);
    if (dot < cos(15)) {
        return false;
    }
    if (entity damageconetrace(origin, turret, forward) <= 0) {
        return false;
    }
    return true;
}

