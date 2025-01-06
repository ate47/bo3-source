#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;

#namespace item_drop;

// Namespace item_drop
// Params 0, eflags: 0x2
// Checksum 0x19fae8b3, Offset: 0x1f8
// Size: 0x5c
function autoexec main() {
    if (!isdefined(level.item_drops)) {
        level.item_drops = [];
    }
    level thread function_8c807b6a();
    wait 0.05;
    callback::on_actor_killed(&function_fe6d2452);
}

// Namespace item_drop
// Params 3, eflags: 0x0
// Checksum 0x1e0c7d51, Offset: 0x260
// Size: 0xc0
function function_5b4e1da2(name, model, callback) {
    if (!isdefined(level.item_drops)) {
        level.item_drops = [];
    }
    if (!isdefined(level.item_drops[name])) {
        level.item_drops[name] = spawnstruct();
    }
    level.item_drops[name].name = name;
    level.item_drops[name].model = model;
    level.item_drops[name].callback = callback;
}

// Namespace item_drop
// Params 2, eflags: 0x0
// Checksum 0xb3428da2, Offset: 0x328
// Size: 0x9c
function function_1df4103f(name, dropchance) {
    if (!isdefined(level.item_drops)) {
        level.item_drops = [];
    }
    if (!isdefined(level.item_drops[name])) {
        level.item_drops[name] = spawnstruct();
    }
    level.item_drops[name].name = name;
    level.item_drops[name].var_7bc9910b = dropchance;
}

// Namespace item_drop
// Params 2, eflags: 0x0
// Checksum 0x9cab6c7a, Offset: 0x3d0
// Size: 0x9c
function function_744c208b(name, spawnpoints) {
    if (!isdefined(level.item_drops)) {
        level.item_drops = [];
    }
    if (!isdefined(level.item_drops[name])) {
        level.item_drops[name] = spawnstruct();
    }
    level.item_drops[name].name = name;
    level.item_drops[name].spawnpoints = spawnpoints;
}

// Namespace item_drop
// Params 1, eflags: 0x0
// Checksum 0xf325cfdd, Offset: 0x478
// Size: 0x25c
function function_fe6d2452(params) {
    if (level.script != "sp_proto_characters" && level.script != "challenge_bloodbath") {
        return;
    }
    if (isdefined(self.var_e5641f85) && self.var_e5641f85) {
        return;
    }
    self.var_e5641f85 = 1;
    drop = array::random(level.item_drops);
    /#
        if (isdefined(drop.var_7bc9910b)) {
            drop.var_7bc9910b = getdvarfloat("<dev string:x28>" + drop.name);
        }
    #/
    if (getdvarint("scr_drop_autorecover")) {
        killer = self.var_b85025c5;
        if (isdefined(killer)) {
            if (isdefined(drop.callback)) {
                multiplier = self function_9b96760a();
                if (!killer [[ drop.callback ]](multiplier)) {
                    return;
                }
            }
            playsoundatposition("fly_supply_bag_pick_up", killer.origin);
        }
        return;
    }
    if (isdefined(drop.var_7bc9910b) && randomfloat(1) < drop.var_7bc9910b) {
        origin = self.origin + (0, 0, 30);
        newdrop = function_49d52f82(drop, origin);
        newdrop.multiplier = self function_9b96760a();
        level.var_4f2308ad[level.var_4f2308ad.size] = newdrop;
        newdrop thread function_64a1deed();
    }
}

// Namespace item_drop
// Params 0, eflags: 0x0
// Checksum 0x66a5e242, Offset: 0x6e0
// Size: 0xb0
function function_9b96760a() {
    var_5fb85588 = getdvarfloat("scr_drop_default_min");
    if (isdefined(self.var_56af7b9b)) {
        var_5fb85588 = self.var_56af7b9b;
    }
    var_777f6f72 = getdvarfloat("scr_drop_default_max");
    if (isdefined(self.var_241b86b1)) {
        var_777f6f72 = self.var_241b86b1;
    }
    if (var_5fb85588 < var_777f6f72) {
        return randomfloatrange(var_5fb85588, var_777f6f72);
    }
    return var_5fb85588;
}

// Namespace item_drop
// Params 0, eflags: 0x0
// Checksum 0xdaab1e00, Offset: 0x798
// Size: 0x120
function function_8c807b6a() {
    level.var_4f2308ad = [];
    level flag::wait_till("all_players_spawned");
    while (true) {
        wait 15;
        if (level.var_4f2308ad.size < 1 && level.item_drops.size > 0) {
            drop = array::random(level.item_drops);
            if (isdefined(drop.spawnpoints)) {
                origin = array::random(drop.spawnpoints);
                newdrop = function_49d52f82(drop, origin);
                level.var_4f2308ad[level.var_4f2308ad.size] = newdrop;
                newdrop thread function_64a1deed();
            }
        }
    }
}

// Namespace item_drop
// Params 2, eflags: 0x0
// Checksum 0xc54ffaef, Offset: 0x8c0
// Size: 0xf8
function function_49d52f82(drop, origin) {
    nd = spawnstruct();
    nd.drop = drop;
    nd.origin = origin;
    nd.model = spawn("script_model", nd.origin);
    nd.model setmodel(drop.model);
    nd.model thread function_35a6028b();
    playsoundatposition("fly_supply_bag_drop", origin);
    return nd;
}

// Namespace item_drop
// Params 0, eflags: 0x0
// Checksum 0xd60423aa, Offset: 0x9c0
// Size: 0x76
function function_35a6028b() {
    angle = 0;
    time = 0;
    self endon(#"death");
    while (isdefined(self)) {
        angle = time * 90;
        self.angles = (0, angle, 0);
        wait 0.05;
        time += 0.05;
    }
}

// Namespace item_drop
// Params 0, eflags: 0x0
// Checksum 0x30b7d420, Offset: 0xa40
// Size: 0x9c
function function_64a1deed() {
    trigger = spawn("trigger_radius", self.origin, 0, 60, 60);
    self.pickuptrigger = trigger;
    while (isdefined(self)) {
        trigger waittill(#"trigger", player);
        if (player thread pickup(self)) {
            break;
        }
    }
    trigger delete();
}

// Namespace item_drop
// Params 1, eflags: 0x0
// Checksum 0x28155834, Offset: 0xae8
// Size: 0xf0
function pickup(drop) {
    if (isdefined(drop.drop.callback)) {
        multiplier = 1;
        if (isdefined(drop.multiplier)) {
            multiplier = drop.multiplier;
        }
        if (!self [[ drop.drop.callback ]](multiplier)) {
            return false;
        }
    }
    playsoundatposition("fly_supply_bag_pick_up", self.origin);
    drop.model delete();
    arrayremovevalue(level.var_4f2308ad, drop);
    return true;
}

