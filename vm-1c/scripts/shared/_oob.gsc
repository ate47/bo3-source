#using scripts/shared/hostmigration_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;

#namespace oob;

// Namespace oob
// Params 0, eflags: 0x2
// namespace_6ece97b7<file_0>::function_2dc19561
// Checksum 0xae8c057d, Offset: 0x200
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("out_of_bounds", &__init__, undefined, undefined);
}

// Namespace oob
// Params 0, eflags: 0x1 linked
// namespace_6ece97b7<file_0>::function_8c87d8eb
// Checksum 0x7d58f041, Offset: 0x240
// Size: 0x2d4
function __init__() {
    level.oob_triggers = [];
    if (sessionmodeismultiplayergame()) {
        level.oob_timekeep_ms = getdvarint("oob_timekeep_ms", 3000);
        level.oob_timelimit_ms = getdvarint("oob_timelimit_ms", 3000);
        level.oob_damage_interval_ms = getdvarint("oob_damage_interval_ms", 3000);
        level.oob_damage_per_interval = getdvarint("oob_damage_per_interval", 999);
        level.oob_max_distance_before_black = getdvarint("oob_max_distance_before_black", 100000);
        level.oob_time_remaining_before_black = getdvarint("oob_time_remaining_before_black", -1);
    } else {
        level.oob_timelimit_ms = getdvarint("oob_timelimit_ms", 6000);
        level.oob_damage_interval_ms = getdvarint("oob_damage_interval_ms", 1000);
        level.oob_damage_per_interval = getdvarint("oob_damage_per_interval", 5);
        level.oob_max_distance_before_black = getdvarint("oob_max_distance_before_black", 400);
        level.oob_time_remaining_before_black = getdvarint("oob_time_remaining_before_black", 1000);
    }
    level.oob_damage_interval_sec = level.oob_damage_interval_ms / 1000;
    var_7d1bc4f6 = getentarray("trigger_out_of_bounds", "classname");
    foreach (trigger in var_7d1bc4f6) {
        trigger thread run_oob_trigger();
    }
    clientfield::register("toplayer", "out_of_bounds", 1, 5, "int");
}

// Namespace oob
// Params 0, eflags: 0x1 linked
// namespace_6ece97b7<file_0>::function_1469cd68
// Checksum 0x783e749c, Offset: 0x520
// Size: 0xa4
function run_oob_trigger() {
    self.oob_players = [];
    if (!isdefined(level.oob_triggers)) {
        level.oob_triggers = [];
    } else if (!isarray(level.oob_triggers)) {
        level.oob_triggers = array(level.oob_triggers);
    }
    level.oob_triggers[level.oob_triggers.size] = self;
    self thread waitforplayertouch();
    self thread waitforclonetouch();
}

// Namespace oob
// Params 0, eflags: 0x1 linked
// namespace_6ece97b7<file_0>::function_b99692eb
// Checksum 0x7f9c0879, Offset: 0x5d0
// Size: 0x20
function isoutofbounds() {
    if (!isdefined(self.oob_start_time)) {
        return false;
    }
    return self.oob_start_time != -1;
}

// Namespace oob
// Params 0, eflags: 0x1 linked
// namespace_6ece97b7<file_0>::function_37b1b5d8
// Checksum 0x93e8a62e, Offset: 0x5f8
// Size: 0x1d6
function istouchinganyoobtrigger() {
    var_41383ff5 = [];
    result = 0;
    foreach (trigger in level.oob_triggers) {
        if (!isdefined(trigger)) {
            if (!isdefined(var_41383ff5)) {
                var_41383ff5 = [];
            } else if (!isarray(var_41383ff5)) {
                var_41383ff5 = array(var_41383ff5);
            }
            var_41383ff5[var_41383ff5.size] = trigger;
            continue;
        }
        if (!trigger istriggerenabled()) {
            continue;
        }
        if (self istouching(trigger)) {
            result = 1;
            break;
        }
    }
    foreach (trigger in var_41383ff5) {
        arrayremovevalue(level.oob_triggers, trigger);
    }
    var_41383ff5 = [];
    var_41383ff5 = undefined;
    return result;
}

// Namespace oob
// Params 2, eflags: 0x1 linked
// namespace_6ece97b7<file_0>::function_6d6be069
// Checksum 0x59fe2514, Offset: 0x7d8
// Size: 0xc6
function resetoobtimer(is_host_migrating, b_disable_timekeep) {
    self.oob_lastvalidplayerloc = undefined;
    self.oob_lastvalidplayerdir = undefined;
    self clientfield::set_to_player("out_of_bounds", 0);
    self util::show_hud(1);
    self.oob_start_time = -1;
    if (isdefined(level.oob_timekeep_ms)) {
        if (isdefined(b_disable_timekeep) && b_disable_timekeep) {
            self.last_oob_timekeep_ms = undefined;
        } else {
            self.last_oob_timekeep_ms = gettime();
        }
    }
    if (!(isdefined(is_host_migrating) && is_host_migrating)) {
        self notify(#"oob_host_migration_exit");
    }
    self notify(#"oob_exit");
}

// Namespace oob
// Params 0, eflags: 0x1 linked
// namespace_6ece97b7<file_0>::function_db666897
// Checksum 0x2f380cd2, Offset: 0x8a8
// Size: 0x9c
function waitforclonetouch() {
    self endon(#"death");
    while (true) {
        clone = self waittill(#"trigger");
        if (isactor(clone) && isdefined(clone.isaiclone) && clone.isaiclone && !clone isplayinganimscripted()) {
            clone notify(#"clone_shutdown");
        }
    }
}

// Namespace oob
// Params 1, eflags: 0x0
// namespace_6ece97b7<file_0>::function_ad23a9de
// Checksum 0xafc02708, Offset: 0x950
// Size: 0x50
function getadjusedplayer(player) {
    if (isdefined(player.hijacked_vehicle_entity) && isalive(player.hijacked_vehicle_entity)) {
        return player.hijacked_vehicle_entity;
    }
    return player;
}

// Namespace oob
// Params 0, eflags: 0x1 linked
// namespace_6ece97b7<file_0>::function_8bf6514d
// Checksum 0xa3d43195, Offset: 0x9a8
// Size: 0x310
function waitforplayertouch() {
    self endon(#"death");
    while (true) {
        if (sessionmodeismultiplayergame()) {
            hostmigration::waittillhostmigrationdone();
        }
        entity = self waittill(#"trigger");
        if (!isplayer(entity) && !(isdefined(entity.hijacked) && isvehicle(entity) && entity.hijacked && isdefined(entity.owner) && isalive(entity))) {
            continue;
        }
        if (isplayer(entity)) {
            player = entity;
        } else {
            vehicle = entity;
            player = vehicle.owner;
        }
        if (!player isoutofbounds() && !player isplayinganimscripted() && !(isdefined(player.oobdisabled) && player.oobdisabled)) {
            player notify(#"oob_enter");
            if (isdefined(level.oob_timekeep_ms) && isdefined(player.last_oob_timekeep_ms) && isdefined(player.last_oob_duration_ms) && gettime() - player.last_oob_timekeep_ms < level.oob_timekeep_ms) {
                player.oob_start_time = gettime() - level.oob_timelimit_ms - player.last_oob_duration_ms;
            } else {
                player.oob_start_time = gettime();
            }
            player.oob_lastvalidplayerloc = entity.origin;
            player.oob_lastvalidplayerdir = vectornormalize(entity getvelocity());
            player util::show_hud(0);
            player thread watchforleave(self, entity);
            player thread watchfordeath(self, entity);
            if (sessionmodeismultiplayergame()) {
                player thread watchforhostmigration(self, entity);
            }
        }
    }
}

// Namespace oob
// Params 2, eflags: 0x1 linked
// namespace_6ece97b7<file_0>::function_8d0415af
// Checksum 0x524e78f8, Offset: 0xcc0
// Size: 0xec
function getdistancefromlastvalidplayerloc(trigger, entity) {
    if (isdefined(self.oob_lastvalidplayerdir) && self.oob_lastvalidplayerdir != (0, 0, 0)) {
        vectoplayerlocfromorigin = entity.origin - self.oob_lastvalidplayerloc;
        distance = vectordot(vectoplayerlocfromorigin, self.oob_lastvalidplayerdir);
    } else {
        distance = distance(entity.origin, self.oob_lastvalidplayerloc);
    }
    if (distance < 0) {
        distance = 0;
    }
    if (distance > level.oob_max_distance_before_black) {
        distance = level.oob_max_distance_before_black;
    }
    return distance / level.oob_max_distance_before_black;
}

// Namespace oob
// Params 2, eflags: 0x1 linked
// namespace_6ece97b7<file_0>::function_9b146f7c
// Checksum 0xedc2676f, Offset: 0xdb8
// Size: 0x1b4
function updatevisualeffects(trigger, entity) {
    timeremaining = level.oob_timelimit_ms - gettime() - self.oob_start_time;
    if (isdefined(level.oob_timekeep_ms)) {
        self.last_oob_duration_ms = timeremaining;
    }
    oob_effectvalue = 0;
    if (timeremaining <= level.oob_time_remaining_before_black) {
        if (!isdefined(self.oob_lasteffectvalue)) {
            self.oob_lasteffectvalue = getdistancefromlastvalidplayerloc(trigger, entity);
        }
        time_val = 1 - timeremaining / level.oob_time_remaining_before_black;
        if (time_val > 1) {
            time_val = 1;
        }
        oob_effectvalue = self.oob_lasteffectvalue + (1 - self.oob_lasteffectvalue) * time_val;
    } else {
        oob_effectvalue = getdistancefromlastvalidplayerloc(trigger, entity);
        if (oob_effectvalue > 0.9) {
            oob_effectvalue = 0.9;
        } else if (oob_effectvalue < 0.05) {
            oob_effectvalue = 0.05;
        }
        self.oob_lasteffectvalue = oob_effectvalue;
    }
    oob_effectvalue = ceil(oob_effectvalue * 31);
    self clientfield::set_to_player("out_of_bounds", int(oob_effectvalue));
}

// Namespace oob
// Params 1, eflags: 0x1 linked
// namespace_6ece97b7<file_0>::function_f668bd18
// Checksum 0xef12af99, Offset: 0xf78
// Size: 0xf4
function killentity(entity) {
    var_898f686f = entity;
    if (isplayer(entity) && entity isinvehicle()) {
        vehicle = entity getvehicleoccupied();
        if (isdefined(vehicle) && vehicle.var_8a47a759 === 1) {
            var_898f686f = vehicle;
        }
    }
    self resetoobtimer();
    var_898f686f dodamage(var_898f686f.health + 10000, var_898f686f.origin, undefined, undefined, "none", "MOD_TRIGGER_HURT");
}

// Namespace oob
// Params 2, eflags: 0x1 linked
// namespace_6ece97b7<file_0>::function_db083e88
// Checksum 0xaab08131, Offset: 0x1078
// Size: 0x140
function watchforleave(trigger, entity) {
    self endon(#"oob_exit");
    entity endon(#"death");
    while (true) {
        if (entity istouchinganyoobtrigger()) {
            updatevisualeffects(trigger, entity);
            if (level.oob_timelimit_ms - gettime() - self.oob_start_time <= 0) {
                if (isplayer(entity)) {
                    entity disableinvulnerability();
                    entity.ignoreme = 0;
                    entity.laststand = undefined;
                    if (isdefined(entity.revivetrigger)) {
                        entity.revivetrigger delete();
                    }
                }
                self thread killentity(entity);
            }
        } else {
            self resetoobtimer();
        }
        wait(0.1);
    }
}

// Namespace oob
// Params 2, eflags: 0x1 linked
// namespace_6ece97b7<file_0>::function_1d10e97f
// Checksum 0x8e5e8487, Offset: 0x11c0
// Size: 0x6c
function watchfordeath(trigger, entity) {
    self endon(#"disconnect");
    self endon(#"oob_exit");
    util::waittill_any_ents_two(self, "death", entity, "death");
    self resetoobtimer();
}

// Namespace oob
// Params 2, eflags: 0x1 linked
// namespace_6ece97b7<file_0>::function_c468111b
// Checksum 0xda556949, Offset: 0x1238
// Size: 0x4c
function watchforhostmigration(trigger, entity) {
    self endon(#"oob_host_migration_exit");
    level waittill(#"host_migration_begin");
    self resetoobtimer(1, 1);
}

// Namespace oob
// Params 1, eflags: 0x1 linked
// namespace_6ece97b7<file_0>::function_113a0740
// Checksum 0x6cf93ae2, Offset: 0x1290
// Size: 0x48
function disableplayeroob(disabled) {
    if (disabled) {
        self resetoobtimer();
        self.oobdisabled = 1;
        return;
    }
    self.oobdisabled = 0;
}

