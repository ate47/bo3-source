#using scripts/shared/util_shared;
#using scripts/cp/_challenges;
#using scripts/cp/_util;
#using scripts/cp/gametypes/_save;
#using scripts/cp/_objectives;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/array_shared;

#namespace collectibles;

// Namespace collectibles
// Params 0, eflags: 0x2
// Checksum 0x12e3fc4c, Offset: 0x338
// Size: 0x3c
function function_2dc19561() {
    system::register("collectibles", &__init__, &__main__, undefined);
}

// Namespace collectibles
// Params 0, eflags: 0x1 linked
// Checksum 0x2eb0b64, Offset: 0x380
// Size: 0x40
function __init__() {
    level.mission_name = getmissionname();
    level.map_name = getrootmapname();
    level.var_3efe1e22 = [];
}

// Namespace collectibles
// Params 0, eflags: 0x1 linked
// Checksum 0x973f638e, Offset: 0x3c8
// Size: 0x1d2
function __main__() {
    level.collectibles = [];
    var_a87c5e50 = getentarray("collectible", "script_noteworthy");
    if (var_a87c5e50.size == 0) {
        return;
    }
    if (!function_148c7e54()) {
        foreach (mdl_collectible in var_a87c5e50) {
            collectible = function_8765a33c(mdl_collectible);
            array::add(level.collectibles, collectible, 0);
        }
        callback::on_spawned(&on_player_spawned);
        callback::on_connect(&on_player_connect);
        return;
    }
    foreach (mdl_collectible in var_a87c5e50) {
        mdl_collectible hide();
    }
}

// Namespace collectibles
// Params 0, eflags: 0x1 linked
// Checksum 0x5d3eeb48, Offset: 0x5a8
// Size: 0xf6
function function_37aecd21() {
    if (!isdefined(level.collectibles)) {
        return;
    }
    foreach (collectible in level.collectibles) {
        var_3efe1e22 = level.var_3efe1e22[collectible.mdl_collectible.model];
        if (isdefined(var_3efe1e22)) {
            collectible.trigger.origin += var_3efe1e22.offset;
        }
    }
}

// Namespace collectibles
// Params 3, eflags: 0x1 linked
// Checksum 0xef876f8d, Offset: 0x6a8
// Size: 0xb4
function function_93523442(var_977e0f67, radius, offset) {
    if (!isdefined(radius)) {
        radius = 60;
    }
    if (!isdefined(offset)) {
        offset = (0, 0, 0);
    }
    if (!isdefined(level.var_3efe1e22[var_977e0f67])) {
        level.var_3efe1e22[var_977e0f67] = spawnstruct();
    }
    level.var_3efe1e22[var_977e0f67].radius = radius;
    level.var_3efe1e22[var_977e0f67].offset = offset;
}

// Namespace collectibles
// Params 0, eflags: 0x5 linked
// Checksum 0x5bacd759, Offset: 0x768
// Size: 0x2a
function function_148c7e54() {
    return isdefined(level.var_bca96223) && level.var_bca96223 || sessionmodeiscampaignzombiesgame();
}

// Namespace collectibles
// Params 0, eflags: 0x1 linked
// Checksum 0x976820ec, Offset: 0x7a0
// Size: 0x1c4
function on_player_spawned() {
    if (!isdefined(self.var_b3dc8451)) {
        self.var_b3dc8451 = [];
    }
    foreach (collectible in level.collectibles) {
        if (self getdstat("PlayerStatsByMap", level.map_name, "collectibles", collectible.index)) {
            self.var_b3dc8451[collectible.mdl_collectible.model] = 1;
            collectible.mdl_collectible setinvisibletoplayer(self);
            objective_setinvisibletoplayer(collectible.objectiveid, self);
            collectible.trigger setinvisibletoplayer(self);
            if (array::contains(level.var_c02de660, toupper(level.mission_name))) {
            }
            continue;
        }
        self.var_b3dc8451[collectible.mdl_collectible.model] = 0;
    }
    self function_3955ccef();
}

// Namespace collectibles
// Params 0, eflags: 0x1 linked
// Checksum 0x3b028329, Offset: 0x970
// Size: 0x1c
function on_player_connect() {
    self thread function_332e2cfd();
}

// Namespace collectibles
// Params 0, eflags: 0x0
// Checksum 0x724b6757, Offset: 0x998
// Size: 0x80
function function_6ba0709f() {
    self endon(#"disconnect");
    if (!missionhascollectibles(getrootmapname())) {
        return;
    }
    while (true) {
        level util::waittill_any("checkpoint_save", "_checkpoint_save_safe");
        self function_d100c544();
    }
}

// Namespace collectibles
// Params 0, eflags: 0x1 linked
// Checksum 0x5ec59084, Offset: 0xa20
// Size: 0x368
function function_332e2cfd() {
    self endon(#"disconnect");
    if (!missionhascollectibles(getrootmapname())) {
        return;
    }
    while (true) {
        level waittill(#"save_restore");
        if (!isdefined(self.var_b3dc8451)) {
            self.var_b3dc8451 = [];
        }
        foreach (collectible in level.collectibles) {
            var_6b074374 = self function_70b41d41(collectible.index);
            var_32553838 = self getdstat("PlayerStatsByMap", level.map_name, "collectibles", collectible.index);
            if (isdefined(var_6b074374) && var_6b074374 && !(isdefined(var_32553838) && var_32553838)) {
                self.var_b3dc8451[collectible.mdl_collectible.model] = 1;
                collectible.mdl_collectible setinvisibletoplayer(self);
                objective_setinvisibletoplayer(collectible.objectiveid, self);
                collectible.trigger setinvisibletoplayer(self);
                self setdstat("PlayerStatsByMap", level.map_name, "collectibles", collectible.index, 1);
                self addrankxpvalue("picked_up_collectible", 500);
                uploadstats(self);
                self function_a8d8b9c7();
                self challenges::function_96ed590f("career_collectibles");
                continue;
            }
            if (!(isdefined(self getdstat("PlayerStatsByMap", level.map_name, "collectibles", collectible.index)) && self getdstat("PlayerStatsByMap", level.map_name, "collectibles", collectible.index))) {
                self.var_b3dc8451[collectible.mdl_collectible.model] = 0;
            }
        }
        self function_a8d8b9c7();
    }
}

// Namespace collectibles
// Params 1, eflags: 0x5 linked
// Checksum 0x7b07f2f9, Offset: 0xd90
// Size: 0xb8
function function_b963f25(mdl_collectible) {
    mdl_collectible.radius = 60;
    mdl_collectible.offset = (0, 0, 5);
    var_3efe1e22 = level.var_3efe1e22[mdl_collectible.model];
    if (isdefined(var_3efe1e22)) {
        mdl_collectible.radius = var_3efe1e22.radius;
        mdl_collectible.offset += var_3efe1e22.offset;
    }
    return mdl_collectible;
}

// Namespace collectibles
// Params 1, eflags: 0x1 linked
// Checksum 0x50815f5b, Offset: 0xe50
// Size: 0x33c
function function_8765a33c(mdl_collectible) {
    mdl_collectible = function_b963f25(mdl_collectible);
    trigger_use = spawn("trigger_radius_use", mdl_collectible.origin + mdl_collectible.offset, 0, mdl_collectible.radius, mdl_collectible.radius);
    trigger_use triggerignoreteam();
    trigger_use setvisibletoall();
    trigger_use usetriggerrequirelookat();
    trigger_use setteamfortrigger("none");
    trigger_use setcursorhint("HINT_INTERACTIVE_PROMPT");
    trigger_use sethintstring(%COLLECTIBLE_PICK_UP);
    istring = istring(mdl_collectible.model);
    var_837a6185 = gameobjects::create_use_object("any", trigger_use, array(mdl_collectible), (0, 0, 0), istring);
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
    return var_837a6185;
}

// Namespace collectibles
// Params 1, eflags: 0x1 linked
// Checksum 0x3e3b4033, Offset: 0x1198
// Size: 0x1cc
function onuse(e_player) {
    e_player.var_b3dc8451[self.mdl_collectible.model] = 1;
    self.mdl_collectible setinvisibletoplayer(e_player);
    self gameobjects::hide_waypoint(e_player);
    self.trigger setinvisibletoplayer(e_player);
    if (missionhascollectibles(getrootmapname())) {
        e_player setdstat("PlayerStatsByMap", level.map_name, "collectibles", self.index, 1);
        e_player addrankxpvalue("picked_up_collectible", 500);
        uploadstats(e_player);
        e_player function_8acd43fd(self.index, 1);
        e_player function_a8d8b9c7();
    }
    util::function_964b7eb7(e_player, istring("COLLECTIBLE_DISCOVERED"));
    e_player playsoundtoplayer("uin_collectible_pickup", e_player);
    e_player notify(#"picked_up_collectible");
    e_player challenges::function_96ed590f("career_collectibles");
}

// Namespace collectibles
// Params 1, eflags: 0x1 linked
// Checksum 0x7fcdce93, Offset: 0x1370
// Size: 0xc
function onbeginuse(e_player) {
    
}

// Namespace collectibles
// Params 1, eflags: 0x1 linked
// Checksum 0x52865663, Offset: 0x1388
// Size: 0xaa
function function_ccb1e08d(map_name) {
    if (!isdefined(map_name)) {
        map_name = getrootmapname();
    }
    if (!isdefined(map_name)) {
        return;
    }
    var_8a9d11b = 0;
    for (collectibleindex = 0; collectibleindex < 10; collectibleindex++) {
        if (self getdstat("PlayerStatsByMap", map_name, "collectibles", collectibleindex)) {
            var_8a9d11b++;
        }
    }
    return var_8a9d11b;
}

// Namespace collectibles
// Params 0, eflags: 0x1 linked
// Checksum 0x55fc12c4, Offset: 0x1440
// Size: 0x7e
function function_3955ccef() {
    var_8a9d11b = self function_ccb1e08d(getrootmapname());
    var_b95ead22 = getnumberofcollectiblesforlevel(getrootmapname());
    if (var_8a9d11b == var_b95ead22) {
        return true;
    }
    return false;
}

// Namespace collectibles
// Params 0, eflags: 0x5 linked
// Checksum 0xcffd827f, Offset: 0x14c8
// Size: 0xd2
function function_e1aad2b1() {
    self endon(#"disconnect");
    self notify(#"hash_e1aad2b1");
    self endon(#"hash_e1aad2b1");
    self util::waittill_notify_or_timeout("stats_changed", 2);
    if (isdefined(self) && self hascollectedallcollectibles()) {
        self setdstat("PlayerStatsList", "ALL_COLLECTIBLES_COLLECTED", "statValue", 1);
        self givedecoration("cp_medal_all_collectibles");
        self notify(#"hash_52c9c74a", "CP_ALL_COLLECTIBLES");
    }
}

// Namespace collectibles
// Params 0, eflags: 0x1 linked
// Checksum 0x6d58962f, Offset: 0x15a8
// Size: 0xa4
function function_a8d8b9c7() {
    /#
        assert(isplayer(self));
    #/
    if (self function_3955ccef()) {
        self setdstat("PlayerStatsByMap", getrootmapname(), "allCollectiblesCollected", 1);
        self notify(#"hash_52c9c74a", "CP_MISSION_COLLECTIBLES");
    }
    self thread function_e1aad2b1();
}

// Namespace collectibles
// Params 2, eflags: 0x1 linked
// Checksum 0xfb53950c, Offset: 0x1658
// Size: 0x44
function function_8acd43fd(var_5c0b5b64, value) {
    self setnoncheckpointdata("collectibles" + var_5c0b5b64 + "value", value);
}

// Namespace collectibles
// Params 1, eflags: 0x1 linked
// Checksum 0x4bf1df55, Offset: 0x16a8
// Size: 0x32
function function_70b41d41(var_5c0b5b64) {
    return self getnoncheckpointdata("collectibles" + var_5c0b5b64 + "value");
}

// Namespace collectibles
// Params 0, eflags: 0x1 linked
// Checksum 0xc9577c27, Offset: 0x16e8
// Size: 0xa2
function function_d100c544() {
    foreach (collectible in level.collectibles) {
        self clearnoncheckpointdata("collectibles" + collectible.index + "value");
    }
}

