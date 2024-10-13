#using scripts/zm/_zm_utility;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_6e97c459;

// Namespace namespace_6e97c459
// Params 0, eflags: 0x1 linked
// Checksum 0xe82d6be4, Offset: 0x228
// Size: 0x2c
function function_89eab5da() {
    level.var_d24533c5 = [];
    /#
        level thread function_f679bcf6();
    #/
}

// Namespace namespace_6e97c459
// Params 1, eflags: 0x1 linked
// Checksum 0x422ca32e, Offset: 0x260
// Size: 0xd2
function function_1337b040(a_gametypes) {
    if (isdefined(level.gamedifficulty) && level.gamedifficulty == 0) {
        return 0;
    }
    b_is_gametype_active = 0;
    if (!isarray(a_gametypes)) {
        a_gametypes = array(a_gametypes);
    }
    for (i = 0; i < a_gametypes.size; i++) {
        if (getdvarstring("g_gametype") == a_gametypes[i]) {
            b_is_gametype_active = 1;
        }
    }
    return b_is_gametype_active;
}

/#

    // Namespace namespace_6e97c459
    // Params 0, eflags: 0x1 linked
    // Checksum 0x76616890, Offset: 0x340
    // Size: 0x44
    function function_f679bcf6() {
        if (getdvarstring("<dev string:x28>") != "<dev string:x3d>") {
            return;
        }
        while (true) {
            wait 1;
        }
    }

#/

// Namespace namespace_6e97c459
// Params 2, eflags: 0x0
// Checksum 0x1f517eea, Offset: 0x390
// Size: 0x10a
function function_2be10038(var_a1409acb, trigger_func) {
    while (true) {
        amount, attacker, dir, point, type = self waittill(#"damage");
        self.var_91d22e1c = amount;
        self.attacker = attacker;
        self.var_59d0b36d = dir;
        self.var_20bb44ba = point;
        self.var_72f01e20 = type;
        for (i = 0; i < var_a1409acb.size; i++) {
            if (type == var_a1409acb[i]) {
                break;
            }
        }
    }
    if (isdefined(trigger_func)) {
        self [[ trigger_func ]]();
    }
    self notify(#"triggered");
}

// Namespace namespace_6e97c459
// Params 0, eflags: 0x1 linked
// Checksum 0xf715094f, Offset: 0x4a8
// Size: 0x3c
function function_592e1f46() {
    self endon(#"death");
    while (true) {
        self waittill(#"damage");
        self.var_bbca234 notify(#"triggered");
    }
}

// Namespace namespace_6e97c459
// Params 0, eflags: 0x0
// Checksum 0xf6762281, Offset: 0x4f0
// Size: 0x3c
function function_e4084aab() {
    self endon(#"death");
    while (true) {
        self waittill(#"damage");
        self.var_bbca234 notify(#"triggered");
    }
}

// Namespace namespace_6e97c459
// Params 1, eflags: 0x0
// Checksum 0xe6b43d0f, Offset: 0x538
// Size: 0x28
function function_bc92e34(name) {
    level.var_d24533c5[name].var_6d88edb0 = 1;
}

// Namespace namespace_6e97c459
// Params 2, eflags: 0x1 linked
// Checksum 0xb276c266, Offset: 0x568
// Size: 0xa4
function function_225a92d6(var_f814e008, var_6f3d2f15) {
    var_d1ed79d8 = "sidequestIcons." + var_f814e008 + ".";
    clientfield::register("clientuimodel", var_d1ed79d8 + "icon", var_6f3d2f15, 1, "int");
    clientfield::register("clientuimodel", var_d1ed79d8 + "notification", var_6f3d2f15, 1, "int");
}

// Namespace namespace_6e97c459
// Params 3, eflags: 0x1 linked
// Checksum 0x91bcd30e, Offset: 0x618
// Size: 0x9c
function function_f72f765e(var_76221a40, var_f814e008, var_275b4f28) {
    if (!isdefined(var_275b4f28)) {
        var_275b4f28 = 1;
    }
    clientfield::set_player_uimodel("sidequestIcons." + var_f814e008 + ".icon", 1);
    if (isdefined(var_275b4f28) && var_275b4f28) {
        clientfield::set_player_uimodel("sidequestIcons." + var_f814e008 + ".notification", 1);
    }
}

// Namespace namespace_6e97c459
// Params 2, eflags: 0x1 linked
// Checksum 0xa476429a, Offset: 0x6c0
// Size: 0x64
function function_9f2411a3(var_76221a40, var_f814e008) {
    clientfield::set_player_uimodel("sidequestIcons." + var_f814e008 + ".icon", 0);
    clientfield::set_player_uimodel("sidequestIcons." + var_f814e008 + ".notification", 0);
}

// Namespace namespace_6e97c459
// Params 6, eflags: 0x1 linked
// Checksum 0x4743d63a, Offset: 0x730
// Size: 0x1d2
function function_f59cfc65(name, init_func, var_4dfe0d36, complete_func, var_89a4d66b, var_6e1c2e3e) {
    if (!isdefined(level.var_d24533c5)) {
        function_89eab5da();
    }
    /#
        if (isdefined(level.var_d24533c5[name])) {
            println("<dev string:x3f>" + name);
            return;
        }
    #/
    sq = spawnstruct();
    sq.name = name;
    sq.stages = [];
    sq.var_c5d90674 = -1;
    sq.var_451a400c = -1;
    sq.var_5ea5f0b8 = 0;
    sq.init_func = init_func;
    sq.var_4dfe0d36 = var_4dfe0d36;
    sq.complete_func = complete_func;
    sq.var_89a4d66b = var_89a4d66b;
    sq.var_6e1c2e3e = var_6e1c2e3e;
    sq.assets = [];
    sq.var_6d88edb0 = 0;
    sq.var_c3624ed5 = [];
    sq.icons = [];
    sq.var_57800922 = 0;
    level.var_d24533c5[name] = sq;
}

// Namespace namespace_6e97c459
// Params 5, eflags: 0x1 linked
// Checksum 0x7db614d6, Offset: 0x910
// Size: 0x1f2
function function_5a90ed82(var_76221a40, var_35927d25, init_func, var_4dfe0d36, exit_func) {
    /#
        if (!isdefined(level.var_d24533c5)) {
            println("<dev string:x75>");
            return;
        }
        if (!isdefined(level.var_d24533c5[var_76221a40])) {
            println("<dev string:xc3>" + var_35927d25 + "<dev string:xe5>" + var_76221a40 + "<dev string:xf5>");
            return;
        }
        if (isdefined(level.var_d24533c5[var_76221a40].stages[var_35927d25])) {
            println("<dev string:x115>" + var_76221a40 + "<dev string:x12b>" + var_35927d25);
            return;
        }
    #/
    stage = spawnstruct();
    stage.name = var_35927d25;
    stage.var_b78f7e07 = level.var_d24533c5[var_76221a40].stages.size;
    stage.assets = [];
    stage.var_c3624ed5 = [];
    stage.var_4dfe0d36 = var_4dfe0d36;
    stage.init_func = init_func;
    stage.exit_func = exit_func;
    stage.completed = 0;
    stage.time_limit = 0;
    level.var_d24533c5[var_76221a40].stages[var_35927d25] = stage;
}

// Namespace namespace_6e97c459
// Params 4, eflags: 0x1 linked
// Checksum 0xe745e5b2, Offset: 0xb10
// Size: 0x158
function function_b9676730(var_76221a40, var_35927d25, time_limit, var_fa7fcd81) {
    /#
        if (!isdefined(level.var_d24533c5)) {
            println("<dev string:x148>");
            return;
        }
        if (!isdefined(level.var_d24533c5[var_76221a40])) {
            println("<dev string:x19d>" + var_35927d25 + "<dev string:x1cc>" + var_76221a40 + "<dev string:xf5>");
            return;
        }
        if (!isdefined(level.var_d24533c5[var_76221a40].stages[var_35927d25])) {
            println("<dev string:x1dc>" + var_35927d25 + "<dev string:x20a>" + var_76221a40 + "<dev string:x219>");
            return;
        }
    #/
    level.var_d24533c5[var_76221a40].stages[var_35927d25].time_limit = time_limit;
    level.var_d24533c5[var_76221a40].stages[var_35927d25].var_a2e1ea2b = var_fa7fcd81;
}

// Namespace namespace_6e97c459
// Params 5, eflags: 0x1 linked
// Checksum 0x20a25844, Offset: 0xc70
// Size: 0x284
function function_9a85e396(var_76221a40, var_35927d25, target_name, thread_func, var_5ce07c2b) {
    structs = struct::get_array(target_name, "targetname");
    /#
        if (!isdefined(level.var_d24533c5)) {
            println("<dev string:x234>" + target_name + "<dev string:x267>");
            return;
        }
        if (!isdefined(level.var_d24533c5[var_76221a40])) {
            println("<dev string:x284>" + target_name + "<dev string:xe5>" + var_76221a40 + "<dev string:xf5>");
            return;
        }
        if (!isdefined(level.var_d24533c5[var_76221a40].stages[var_35927d25])) {
            println("<dev string:x284>" + target_name + "<dev string:xe5>" + var_76221a40 + "<dev string:x2a6>" + var_35927d25 + "<dev string:x2aa>");
            return;
        }
        if (!structs.size) {
            println("<dev string:x2c5>" + target_name + "<dev string:x2e1>");
            return;
        }
    #/
    for (i = 0; i < structs.size; i++) {
        asset = spawnstruct();
        asset.type = "struct";
        asset.struct = structs[i];
        asset.thread_func = thread_func;
        asset.var_5ce07c2b = var_5ce07c2b;
        level.var_d24533c5[var_76221a40].stages[var_35927d25].assets[level.var_d24533c5[var_76221a40].stages[var_35927d25].assets.size] = asset;
    }
}

// Namespace namespace_6e97c459
// Params 3, eflags: 0x0
// Checksum 0x2c3f7ab6, Offset: 0xf00
// Size: 0x144
function function_f2dc5f55(var_76221a40, var_35927d25, title) {
    /#
        if (!isdefined(level.var_d24533c5)) {
            println("<dev string:x2ed>" + title + "<dev string:x267>");
            return;
        }
        if (!isdefined(level.var_d24533c5[var_76221a40])) {
            println("<dev string:x2ed>" + title + "<dev string:xe5>" + var_76221a40 + "<dev string:xf5>");
            return;
        }
        if (!isdefined(level.var_d24533c5[var_76221a40].stages[var_35927d25])) {
            println("<dev string:x31b>" + title + "<dev string:xe5>" + var_76221a40 + "<dev string:x2a6>" + var_35927d25 + "<dev string:x2aa>");
            return;
        }
    #/
    level.var_d24533c5[var_76221a40].stages[var_35927d25].title = title;
}

// Namespace namespace_6e97c459
// Params 5, eflags: 0x1 linked
// Checksum 0xecb7ffd2, Offset: 0x1050
// Size: 0x284
function function_ff87971b(var_76221a40, var_35927d25, target_name, thread_func, var_5ce07c2b) {
    ents = getentarray(target_name, "targetname");
    /#
        if (!isdefined(level.var_d24533c5)) {
            println("<dev string:x234>" + target_name + "<dev string:x267>");
            return;
        }
        if (!isdefined(level.var_d24533c5[var_76221a40])) {
            println("<dev string:x284>" + target_name + "<dev string:xe5>" + var_76221a40 + "<dev string:xf5>");
            return;
        }
        if (!isdefined(level.var_d24533c5[var_76221a40].stages[var_35927d25])) {
            println("<dev string:x284>" + target_name + "<dev string:xe5>" + var_76221a40 + "<dev string:x2a6>" + var_35927d25 + "<dev string:x2aa>");
            return;
        }
        if (!ents.size) {
            println("<dev string:x347>" + target_name + "<dev string:x2e1>");
            return;
        }
    #/
    for (i = 0; i < ents.size; i++) {
        asset = spawnstruct();
        asset.type = "entity";
        asset.ent = ents[i];
        asset.thread_func = thread_func;
        asset.var_5ce07c2b = var_5ce07c2b;
        level.var_d24533c5[var_76221a40].stages[var_35927d25].assets[level.var_d24533c5[var_76221a40].stages[var_35927d25].assets.size] = asset;
    }
}

// Namespace namespace_6e97c459
// Params 4, eflags: 0x1 linked
// Checksum 0xd680e68f, Offset: 0x12e0
// Size: 0x224
function function_93b970b8(var_76221a40, target_name, thread_func, var_5ce07c2b) {
    ents = getentarray(target_name, "targetname");
    /#
        if (!isdefined(level.var_d24533c5)) {
            println("<dev string:x234>" + target_name + "<dev string:x267>");
            return;
        }
        if (!isdefined(level.var_d24533c5[var_76221a40])) {
            println("<dev string:x284>" + target_name + "<dev string:xe5>" + var_76221a40 + "<dev string:xf5>");
            return;
        }
        if (!ents.size) {
            println("<dev string:x347>" + target_name + "<dev string:x2e1>");
            return;
        }
    #/
    for (i = 0; i < ents.size; i++) {
        asset = spawnstruct();
        asset.type = "entity";
        asset.ent = ents[i];
        asset.thread_func = thread_func;
        asset.var_5ce07c2b = var_5ce07c2b;
        asset.ent.thread_func = thread_func;
        asset.ent.var_5ce07c2b = var_5ce07c2b;
        level.var_d24533c5[var_76221a40].assets[level.var_d24533c5[var_76221a40].assets.size] = asset;
    }
}

// Namespace namespace_6e97c459
// Params 4, eflags: 0x1 linked
// Checksum 0x85696cf, Offset: 0x1510
// Size: 0x1ec
function function_f1e70f21(var_76221a40, target_name, thread_func, var_5ce07c2b) {
    structs = struct::get_array(target_name, "targetname");
    /#
        if (!isdefined(level.var_d24533c5)) {
            println("<dev string:x234>" + target_name + "<dev string:x267>");
            return;
        }
        if (!isdefined(level.var_d24533c5[var_76221a40])) {
            println("<dev string:x284>" + target_name + "<dev string:xe5>" + var_76221a40 + "<dev string:xf5>");
            return;
        }
        if (!structs.size) {
            println("<dev string:x2c5>" + target_name + "<dev string:x2e1>");
            return;
        }
    #/
    for (i = 0; i < structs.size; i++) {
        asset = spawnstruct();
        asset.type = "struct";
        asset.struct = structs[i];
        asset.thread_func = thread_func;
        asset.var_5ce07c2b = var_5ce07c2b;
        level.var_d24533c5[var_76221a40].assets[level.var_d24533c5[var_76221a40].assets.size] = asset;
    }
}

// Namespace namespace_6e97c459
// Params 2, eflags: 0x1 linked
// Checksum 0xb075fc6, Offset: 0x1708
// Size: 0x228
function function_e36b045f(asset, parent_struct) {
    ent = spawn("script_model", asset.origin);
    if (isdefined(asset.model)) {
        ent setmodel(asset.model);
        asset.var_d0dd151f = ent;
    }
    if (isdefined(asset.angles)) {
        ent.angles = asset.angles;
    }
    ent.script_noteworthy = asset.script_noteworthy;
    ent.type = "struct";
    ent.radius = asset.radius;
    ent.thread_func = parent_struct.thread_func;
    ent.var_5ce07c2b = parent_struct.var_5ce07c2b;
    ent.script_vector = parent_struct.script_vector;
    asset.var_5ce07c2b = parent_struct.var_5ce07c2b;
    asset.script_vector = parent_struct.script_vector;
    ent.target = asset.target;
    ent.script_float = asset.script_float;
    ent.script_int = asset.script_int;
    ent.var_e7d06426 = asset.var_e7d06426;
    ent.targetname = asset.targetname;
    return ent;
}

// Namespace namespace_6e97c459
// Params 0, eflags: 0x1 linked
// Checksum 0xf6dd6427, Offset: 0x1938
// Size: 0x200
function function_457aaf75() {
    for (i = 0; i < self.var_c3624ed5.size; i++) {
        asset = self.var_c3624ed5[i];
        switch (asset.type) {
        case "struct":
            if (isdefined(asset.trigger)) {
                println("<dev string:x360>");
                if (!(isdefined(asset.trigger.var_b82c7478) && asset.trigger.var_b82c7478)) {
                    asset.trigger delete();
                }
                asset.trigger = undefined;
            }
            asset delete();
            break;
        case "entity":
            if (isdefined(asset.trigger)) {
                println("<dev string:x389>");
                asset.trigger delete();
                asset.trigger = undefined;
            }
            break;
        }
    }
    var_a2a440dd = [];
    for (i = 0; i < self.var_c3624ed5.size; i++) {
        if (isdefined(self.var_c3624ed5[i])) {
            var_a2a440dd[var_a2a440dd.size] = self.var_c3624ed5[i];
        }
    }
    self.var_c3624ed5 = var_a2a440dd;
}

// Namespace namespace_6e97c459
// Params 0, eflags: 0x1 linked
// Checksum 0x5c4b1e5e, Offset: 0x1b40
// Size: 0x7d6
function function_51c2cc01() {
    for (i = 0; i < self.assets.size; i++) {
        asset = undefined;
        switch (self.assets[i].type) {
        case "struct":
            asset = self.assets[i].struct;
            self.var_c3624ed5[self.var_c3624ed5.size] = function_e36b045f(asset, self.assets[i]);
            break;
        case "entity":
            for (j = 0; j < self.var_c3624ed5.size; j++) {
                if (self.var_c3624ed5[j] == self.assets[i].ent) {
                    asset = self.var_c3624ed5[j];
                    break;
                }
            }
            asset = self.assets[i].ent;
            asset.type = "entity";
            self.var_c3624ed5[self.var_c3624ed5.size] = asset;
            break;
        default:
            println("<dev string:x3af>" + self.assets.type);
            break;
        }
        if (self.assets[i].type == "entity" && isdefined(asset.script_noteworthy) && !isdefined(asset.trigger) || isdefined(asset.script_noteworthy)) {
            trigger_radius = 15;
            trigger_height = 72;
            if (isdefined(asset.radius)) {
                trigger_radius = asset.radius;
            }
            if (isdefined(asset.height)) {
                trigger_height = asset.height;
            }
            var_8677d6f8 = 0;
            if (isdefined(asset.var_e7d06426)) {
                var_8677d6f8 = asset.var_e7d06426;
            }
            trigger_offset = (0, 0, 0);
            if (isdefined(asset.script_vector)) {
                trigger_offset = asset.script_vector;
            }
            switch (asset.script_noteworthy) {
            case "trigger_radius_use":
                use_trigger = spawn("trigger_radius_use", asset.origin + trigger_offset, var_8677d6f8, trigger_radius, trigger_height);
                use_trigger setcursorhint("HINT_NOICON");
                use_trigger triggerignoreteam();
                if (isdefined(asset.radius)) {
                    use_trigger.radius = asset.radius;
                }
                use_trigger.var_bbca234 = self.var_c3624ed5[self.var_c3624ed5.size - 1];
                if (isdefined(asset.var_5ce07c2b)) {
                    use_trigger thread [[ asset.var_5ce07c2b ]]();
                } else {
                    use_trigger thread function_26ae18ee();
                }
                self.var_c3624ed5[self.var_c3624ed5.size - 1].trigger = use_trigger;
                break;
            case "trigger_radius_damage":
                var_b9f32367 = spawn("trigger_damage", asset.origin + trigger_offset, var_8677d6f8, trigger_radius, trigger_height);
                var_b9f32367.angles = asset.angles;
                var_b9f32367.var_bbca234 = self.var_c3624ed5[self.var_c3624ed5.size - 1];
                if (isdefined(asset.var_5ce07c2b)) {
                    var_b9f32367 thread [[ asset.var_5ce07c2b ]]();
                } else {
                    var_b9f32367 thread function_592e1f46();
                }
                self.var_c3624ed5[self.var_c3624ed5.size - 1].trigger = var_b9f32367;
                break;
            case "trigger_radius":
                var_d17f5d3a = spawn("trigger_radius", asset.origin + trigger_offset, var_8677d6f8, trigger_radius, trigger_height);
                if (isdefined(asset.radius)) {
                    var_d17f5d3a.radius = asset.radius;
                }
                var_d17f5d3a.var_bbca234 = self.var_c3624ed5[self.var_c3624ed5.size - 1];
                if (isdefined(asset.var_5ce07c2b)) {
                    var_d17f5d3a thread [[ asset.var_5ce07c2b ]]();
                } else {
                    var_d17f5d3a thread function_6def6f41();
                }
                self.var_c3624ed5[self.var_c3624ed5.size - 1].trigger = var_d17f5d3a;
                break;
            case "entity_damage":
                asset.var_d0dd151f setcandamage(1);
                asset.var_bbca234 = self.var_c3624ed5[self.var_c3624ed5.size - 1];
                if (isdefined(asset.var_5ce07c2b)) {
                    asset.var_d0dd151f thread [[ asset.var_5ce07c2b ]]();
                } else {
                    asset.var_d0dd151f thread function_592e1f46();
                }
                break;
            }
        }
        if (isdefined(self.assets[i].thread_func) && !isdefined(self.var_c3624ed5[self.var_c3624ed5.size - 1].var_681c1b20)) {
            self.var_c3624ed5[self.var_c3624ed5.size - 1] thread [[ self.assets[i].thread_func ]]();
        }
        if (i % 2 == 0) {
            util::wait_network_frame();
        }
    }
}

// Namespace namespace_6e97c459
// Params 0, eflags: 0x1 linked
// Checksum 0x40ceace8, Offset: 0x2320
// Size: 0x9c
function function_6def6f41() {
    self endon(#"death");
    while (true) {
        player = self waittill(#"trigger");
        if (!isplayer(player)) {
            continue;
        }
        self.var_bbca234 notify(#"triggered");
        while (player istouching(self)) {
            wait 0.05;
        }
        self.var_bbca234 notify(#"hash_ee0bfc57");
    }
}

// Namespace namespace_6e97c459
// Params 2, eflags: 0x0
// Checksum 0x47b8a987, Offset: 0x23c8
// Size: 0x7c
function function_32150a3d(target_name, thread_func) {
    for (i = 0; i < self.var_c3624ed5.size; i++) {
        if (self.var_c3624ed5[i].targetname == target_name) {
            self.var_c3624ed5[i] thread [[ thread_func ]]();
        }
    }
}

// Namespace namespace_6e97c459
// Params 2, eflags: 0x1 linked
// Checksum 0xdf2e493b, Offset: 0x2450
// Size: 0x74
function function_c84afbfb(var_da5d3a32, stage) {
    if (isdefined(stage.var_4dfe0d36)) {
        level endon(var_da5d3a32.name + "_" + stage.name + "_over");
        stage [[ stage.var_4dfe0d36 ]]();
    }
}

// Namespace namespace_6e97c459
// Params 1, eflags: 0x1 linked
// Checksum 0xc0087f1c, Offset: 0x24d0
// Size: 0x114
function function_d9be8a5b(var_76221a40) {
    /#
        if (!isdefined(level.var_d24533c5)) {
            println("<dev string:x3e1>" + var_76221a40 + "<dev string:x267>");
            return;
        }
        if (!isdefined(level.var_d24533c5[var_76221a40])) {
            println("<dev string:x40f>" + var_76221a40 + "<dev string:xf5>");
            return;
        }
    #/
    var_da5d3a32 = level.var_d24533c5[var_76221a40];
    var_da5d3a32 function_51c2cc01();
    if (isdefined(var_da5d3a32.init_func)) {
        var_da5d3a32 [[ var_da5d3a32.init_func ]]();
    }
    if (isdefined(var_da5d3a32.var_4dfe0d36)) {
        var_da5d3a32 thread [[ var_da5d3a32.var_4dfe0d36 ]]();
    }
}

// Namespace namespace_6e97c459
// Params 2, eflags: 0x1 linked
// Checksum 0xa55cc497, Offset: 0x25f0
// Size: 0x1e4
function function_c09cb660(var_da5d3a32, stage) {
    if (isstring(var_da5d3a32)) {
        var_da5d3a32 = level.var_d24533c5[var_da5d3a32];
    }
    if (isstring(stage)) {
        stage = var_da5d3a32.stages[stage];
    }
    stage function_51c2cc01();
    var_da5d3a32.var_451a400c = stage.var_b78f7e07;
    level notify(var_da5d3a32.name + "_" + stage.name + "_started");
    stage.completed = 0;
    if (isdefined(var_da5d3a32.var_89a4d66b)) {
        stage [[ var_da5d3a32.var_89a4d66b ]]();
    }
    if (isdefined(stage.init_func)) {
        stage [[ stage.init_func ]]();
    }
    level.var_e68ff12d = stage.name;
    level thread function_c84afbfb(var_da5d3a32, stage);
    if (stage.time_limit > 0) {
        stage thread function_6591a62a(var_da5d3a32);
    }
    if (isdefined(stage.title)) {
        stage thread function_68003601(var_da5d3a32.var_6d88edb0);
    }
}

// Namespace namespace_6e97c459
// Params 1, eflags: 0x1 linked
// Checksum 0x3b5c4d8e, Offset: 0x27e0
// Size: 0x1dc
function function_68003601(var_c8111181) {
    if (var_c8111181) {
        level waittill(#"teleport_done");
        wait 2;
    }
    var_3fab4871 = newhudelem();
    var_3fab4871.location = 0;
    var_3fab4871.alignx = "center";
    var_3fab4871.aligny = "middle";
    var_3fab4871.foreground = 1;
    var_3fab4871.fontscale = 1.6;
    var_3fab4871.sort = 20;
    var_3fab4871.x = 320;
    var_3fab4871.y = 300;
    var_3fab4871.og_scale = 1;
    var_3fab4871.color = (128, 0, 0);
    var_3fab4871.alpha = 0;
    var_3fab4871.fontstyle3d = "shadowedmore";
    var_3fab4871 settext(self.title);
    var_3fab4871 fadeovertime(0.5);
    var_3fab4871.alpha = 1;
    wait 5;
    var_3fab4871 fadeovertime(1);
    var_3fab4871.alpha = 0;
    wait 1;
    var_3fab4871 destroy();
}

// Namespace namespace_6e97c459
// Params 1, eflags: 0x1 linked
// Checksum 0x72de4e23, Offset: 0x29c8
// Size: 0x174
function function_6591a62a(var_da5d3a32) {
    println("<dev string:x42d>" + var_da5d3a32.name + "<dev string:x44f>" + self.name + "<dev string:x2a6>" + self.time_limit + "<dev string:x457>");
    level endon(var_da5d3a32.name + "_" + self.name + "_over");
    level endon(#"hash_bd6f486d");
    level endon(#"end_game");
    time_limit = undefined;
    if (isdefined(self.var_a2e1ea2b)) {
        time_limit = [[ self.var_a2e1ea2b ]]() * 0.25;
    } else {
        time_limit = self.time_limit * 0.25;
    }
    wait time_limit;
    level notify(#"hash_5102f256");
    wait time_limit;
    level notify(#"hash_c466afcd");
    wait time_limit;
    level notify(#"hash_643b1d89");
    wait time_limit - 10;
    level notify(#"hash_b455418");
    wait 10;
    function_7332e9d3(var_da5d3a32, self);
}

/#

    // Namespace namespace_6e97c459
    // Params 1, eflags: 0x0
    // Checksum 0x22f0bca, Offset: 0x2b48
    // Size: 0x54
    function function_ff948a5c(str) {
        if (getdvarstring("<dev string:x28>") != "<dev string:x3d>") {
            return;
        }
        println(str);
    }

#/

// Namespace namespace_6e97c459
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x2ba8
// Size: 0x4
function function_11e71d56() {
    
}

// Namespace namespace_6e97c459
// Params 1, eflags: 0x0
// Checksum 0x74b1b447, Offset: 0x2bb8
// Size: 0x9e
function function_5ea5f0b8(var_76221a40) {
    /#
        if (!isdefined(level.var_d24533c5)) {
            println("<dev string:x461>" + var_76221a40 + "<dev string:x267>");
            return;
        }
        if (!isdefined(level.var_d24533c5[var_76221a40])) {
            println("<dev string:x461>" + var_76221a40 + "<dev string:xf5>");
            return;
        }
    #/
    return level.var_d24533c5[var_76221a40].var_5ea5f0b8;
}

// Namespace namespace_6e97c459
// Params 2, eflags: 0x1 linked
// Checksum 0xd206fe7d, Offset: 0x2c60
// Size: 0x15c
function function_2f3ced1f(var_76221a40, var_35927d25) {
    /#
        if (!isdefined(level.var_d24533c5)) {
            println("<dev string:x49f>" + var_76221a40 + "<dev string:x267>");
            return;
        }
        if (!isdefined(level.var_d24533c5[var_76221a40])) {
            println("<dev string:x49f>" + var_76221a40 + "<dev string:xf5>");
            return;
        }
        if (!isdefined(level.var_d24533c5[var_76221a40].stages[var_35927d25])) {
            println("<dev string:x4d9>" + var_76221a40 + "<dev string:x2a6>" + var_35927d25 + "<dev string:x2aa>");
            return;
        }
        println("<dev string:x50b>");
    #/
    var_da5d3a32 = level.var_d24533c5[var_76221a40];
    stage = var_da5d3a32.stages[var_35927d25];
    level thread function_978ff1d9(var_da5d3a32, stage);
}

// Namespace namespace_6e97c459
// Params 2, eflags: 0x1 linked
// Checksum 0x4bf3cab2, Offset: 0x2dc8
// Size: 0x278
function function_978ff1d9(var_da5d3a32, stage) {
    level notify(var_da5d3a32.name + "_" + stage.name + "_over");
    level notify(var_da5d3a32.name + "_" + stage.name + "_completed");
    if (isdefined(var_da5d3a32.var_6e1c2e3e)) {
        println("<dev string:x527>");
        stage [[ var_da5d3a32.var_6e1c2e3e ]]();
    }
    if (isdefined(stage.exit_func)) {
        println("<dev string:x541>");
        stage [[ stage.exit_func ]](1);
    }
    stage.completed = 1;
    var_da5d3a32.var_c5d90674 = var_da5d3a32.var_451a400c;
    var_da5d3a32.var_451a400c = -1;
    stage function_457aaf75();
    var_7ef958c4 = 1;
    var_27cd5134 = getarraykeys(var_da5d3a32.stages);
    for (i = 0; i < var_27cd5134.size; i++) {
        if (var_da5d3a32.stages[var_27cd5134[i]].completed == 0) {
            var_7ef958c4 = 0;
            break;
        }
    }
    if (var_7ef958c4 == 1) {
        if (isdefined(var_da5d3a32.complete_func)) {
            var_da5d3a32 thread [[ var_da5d3a32.complete_func ]]();
        }
        level notify("sidequest_" + var_da5d3a32.name + "_complete");
        var_da5d3a32.var_e55f3ec = 1;
    }
}

// Namespace namespace_6e97c459
// Params 2, eflags: 0x1 linked
// Checksum 0xf1cce015, Offset: 0x3048
// Size: 0x104
function function_e9502c05(var_da5d3a32, stage) {
    level notify(var_da5d3a32.name + "_" + stage.name + "_over");
    level notify(var_da5d3a32.name + "_" + stage.name + "_failed");
    if (isdefined(var_da5d3a32.var_6e1c2e3e)) {
        stage [[ var_da5d3a32.var_6e1c2e3e ]]();
    }
    if (isdefined(stage.exit_func)) {
        stage [[ stage.exit_func ]](0);
    }
    var_da5d3a32.var_451a400c = -1;
    stage function_457aaf75();
}

// Namespace namespace_6e97c459
// Params 2, eflags: 0x1 linked
// Checksum 0x3a3503f, Offset: 0x3158
// Size: 0xb4
function function_7332e9d3(var_da5d3a32, stage) {
    println("<dev string:x559>");
    if (isstring(var_da5d3a32)) {
        var_da5d3a32 = level.var_d24533c5[var_da5d3a32];
    }
    if (isstring(stage)) {
        stage = var_da5d3a32.stages[stage];
    }
    level thread function_e9502c05(var_da5d3a32, stage);
}

// Namespace namespace_6e97c459
// Params 2, eflags: 0x1 linked
// Checksum 0x98936ec6, Offset: 0x3218
// Size: 0xcc
function function_adf7ce94(var_da5d3a32, var_b78f7e07) {
    stage = undefined;
    var_27cd5134 = getarraykeys(var_da5d3a32.stages);
    for (i = 0; i < var_27cd5134.size; i++) {
        if (var_da5d3a32.stages[var_27cd5134[i]].var_b78f7e07 == var_b78f7e07) {
            stage = var_da5d3a32.stages[var_27cd5134[i]];
            break;
        }
    }
    return stage;
}

// Namespace namespace_6e97c459
// Params 3, eflags: 0x0
// Checksum 0x8df06d02, Offset: 0x32f0
// Size: 0x70
function function_f7814a24(radius, origin, var_e12c35f8) {
    trig = spawn("trigger_damage", origin, 0, radius, 72);
    trig thread function_75455cff(var_e12c35f8);
    return trig;
}

// Namespace namespace_6e97c459
// Params 1, eflags: 0x1 linked
// Checksum 0x7b7980ef, Offset: 0x3368
// Size: 0xcc
function function_75455cff(var_e12c35f8) {
    self endon(#"death");
    damage_type = "NONE";
    while (true) {
        amount, attacker, dir, point, mod = self waittill(#"damage");
        for (i = 0; i < var_e12c35f8.size; i++) {
            if (mod == var_e12c35f8[i]) {
                self notify(#"triggered");
            }
        }
    }
}

// Namespace namespace_6e97c459
// Params 0, eflags: 0x1 linked
// Checksum 0x7946712f, Offset: 0x3440
// Size: 0x54
function function_26ae18ee() {
    self endon(#"death");
    while (true) {
        player = self waittill(#"trigger");
        self.var_bbca234 notify(#"triggered", player);
        wait 0.1;
    }
}

// Namespace namespace_6e97c459
// Params 2, eflags: 0x1 linked
// Checksum 0xa642a7c9, Offset: 0x34a0
// Size: 0x7a
function function_c0c0cab6(var_76221a40, var_35927d25) {
    var_da5d3a32 = level.var_d24533c5[var_76221a40];
    stage = var_da5d3a32.stages[var_35927d25];
    if (var_da5d3a32.var_451a400c == stage.var_b78f7e07) {
        return 1;
    }
    return 0;
}

// Namespace namespace_6e97c459
// Params 1, eflags: 0x1 linked
// Checksum 0xd5f51995, Offset: 0x3528
// Size: 0x178
function function_513e3f2a(var_76221a40) {
    /#
        if (!isdefined(level.var_d24533c5)) {
            println("<dev string:x572>" + var_76221a40 + "<dev string:x267>");
            return;
        }
        if (!isdefined(level.var_d24533c5[var_76221a40])) {
            println("<dev string:x5ac>" + var_76221a40 + "<dev string:xf5>");
            return;
        }
    #/
    var_da5d3a32 = level.var_d24533c5[var_76221a40];
    if (var_da5d3a32.var_5ea5f0b8 == 1) {
        return;
    }
    var_c242a0db = var_da5d3a32.var_c5d90674;
    if (var_c242a0db == -1) {
        var_c242a0db = 0;
    } else {
        var_c242a0db++;
    }
    stage = function_adf7ce94(var_da5d3a32, var_c242a0db);
    if (!isdefined(stage)) {
        println("<dev string:x5e6>" + var_76221a40 + "<dev string:x5fd>" + var_c242a0db);
        return;
    }
    function_c09cb660(var_da5d3a32, stage);
    return stage;
}

// Namespace namespace_6e97c459
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x36a8
// Size: 0x4
function main() {
    
}

// Namespace namespace_6e97c459
// Params 1, eflags: 0x1 linked
// Checksum 0x86c31be0, Offset: 0x36b8
// Size: 0x13c
function is_facing(facee) {
    orientation = self getplayerangles();
    forwardvec = anglestoforward(orientation);
    forwardvec2d = (forwardvec[0], forwardvec[1], 0);
    unitforwardvec2d = vectornormalize(forwardvec2d);
    tofaceevec = facee.origin - self.origin;
    tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
    unittofaceevec2d = vectornormalize(tofaceevec2d);
    dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
    return dotproduct > 0.9;
}

// Namespace namespace_6e97c459
// Params 2, eflags: 0x1 linked
// Checksum 0x8ad29fea, Offset: 0x3800
// Size: 0x18c
function function_dd92f786(notify_string, qualifier_func) {
    waittillframeend();
    while (!(isdefined(level.disable_print3d_ent) && level.disable_print3d_ent)) {
        if (!isdefined(self)) {
            return;
        }
        /#
            print3d(self.origin, "<dev string:x613>", (0, 255, 0), 1);
        #/
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            qualifier_passed = 1;
            if (isdefined(qualifier_func)) {
                qualifier_passed = players[i] [[ qualifier_func ]]();
            }
            if (qualifier_passed && distancesquared(self.origin, players[i].origin) < 4096) {
                if (players[i] is_facing(self)) {
                    if (players[i] usebuttonpressed()) {
                        self notify(notify_string, players[i]);
                        return;
                    }
                }
            }
        }
        wait 0.1;
    }
}

