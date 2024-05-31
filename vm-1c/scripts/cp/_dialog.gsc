#using scripts/shared/ai/systems/face;
#using scripts/shared/callbacks_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#namespace dialog;

// Namespace dialog
// Params 0, eflags: 0x2
// namespace_71b8dba1<file_0>::function_2dc19561
// Checksum 0xae9083f0, Offset: 0x370
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("dialog", &__init__, undefined, undefined);
}

// Namespace dialog
// Params 0, eflags: 0x1 linked
// namespace_71b8dba1<file_0>::function_8c87d8eb
// Checksum 0x11db08a0, Offset: 0x3b0
// Size: 0x54
function __init__() {
    level.vo = spawnstruct();
    level.vo.var_35e95274 = [];
    callback::on_spawned(&function_bfb57e5a);
}

// Namespace dialog
// Params 0, eflags: 0x1 linked
// namespace_71b8dba1<file_0>::function_bfb57e5a
// Checksum 0xa24dcb57, Offset: 0x410
// Size: 0x24
function function_bfb57e5a() {
    self luinotifyevent(%offsite_comms_complete);
}

// Namespace dialog
// Params 2, eflags: 0x1 linked
// namespace_71b8dba1<file_0>::function_69554b3e
// Checksum 0xc4c71d70, Offset: 0x440
// Size: 0xfc
function add(var_6ec80991, str_vox_file) {
    assert(isdefined(var_6ec80991), "human");
    assert(isdefined(str_vox_file), "human");
    if (!isdefined(level.scr_sound)) {
        level.scr_sound = [];
    }
    if (!isdefined(level.scr_sound["generic"])) {
        level.scr_sound["generic"] = [];
    }
    level.scr_sound["generic"][var_6ec80991] = str_vox_file;
    animation::add_global_notetrack_handler("vox#" + var_6ec80991, &function_3c0e32a, 0, var_6ec80991);
}

// Namespace dialog
// Params 1, eflags: 0x1 linked
// namespace_71b8dba1<file_0>::function_3c0e32a
// Checksum 0xa941fc30, Offset: 0x548
// Size: 0xbc
function function_3c0e32a(str_vo_line) {
    if (isplayer(self)) {
        if (self flagsys::get("shared_igc")) {
            function_13b3b16a(str_vo_line);
        } else {
            say(str_vo_line);
        }
        return;
    }
    if (function_9fc88ab6(str_vo_line)) {
        level function_13b3b16a(str_vo_line);
        return;
    }
    say(str_vo_line);
}

// Namespace dialog
// Params 1, eflags: 0x1 linked
// namespace_71b8dba1<file_0>::function_9fc88ab6
// Checksum 0x91f25a, Offset: 0x610
// Size: 0x82
function function_9fc88ab6(var_e8800af4) {
    str_alias = undefined;
    if (isdefined(level.scr_sound) && isdefined(level.scr_sound["generic"])) {
        str_alias = level.scr_sound["generic"][var_e8800af4];
    }
    if (!isdefined(str_alias)) {
        return 0;
    }
    return strendswith(str_alias, "plyr");
}

// Namespace dialog
// Params 5, eflags: 0x1 linked
// namespace_71b8dba1<file_0>::function_81141386
// Checksum 0xcd48912e, Offset: 0x6a0
// Size: 0x164
function say(str_vo_line, n_delay, var_57b7ba95, e_to_player, var_43937b21) {
    if (!isdefined(var_57b7ba95)) {
        var_57b7ba95 = 0;
    }
    ent = self;
    if (self == level) {
        if (isdefined(var_43937b21) && var_43937b21) {
            ent = spawn("script_model", (0, 0, 0));
            level.e_speaker = ent;
        } else {
            ent = spawn("script_origin", (0, 0, 0));
        }
        waittillframeend();
        level notify(#"hash_120cde7f", ent);
        var_57b7ba95 = 1;
    }
    ent endon(#"death");
    ent thread function_263a2879(str_vo_line, n_delay, var_57b7ba95, e_to_player);
    ent waittillmatch(#"hash_90f83311", str_vo_line);
    if (self == level) {
        ent delete();
        if (isdefined(level.e_speaker)) {
            level.e_speaker delete();
        }
    }
}

// Namespace dialog
// Params 4, eflags: 0x5 linked
// namespace_71b8dba1<file_0>::function_263a2879
// Checksum 0xe81d3e10, Offset: 0x810
// Size: 0x2a6
function private function_263a2879(str_vo_line, n_delay, var_57b7ba95, e_to_player) {
    if (!isdefined(var_57b7ba95)) {
        var_57b7ba95 = 0;
    }
    self endon(#"death");
    self.var_f3995442 = 1;
    self thread function_665c78f1(str_vo_line);
    level endon(#"hash_3962ec94");
    self endon(#"hash_3962ec94");
    if (isdefined(n_delay) && n_delay > 0) {
        wait(n_delay);
    }
    if (self.classname === "script_origin") {
        var_57b7ba95 = 1;
    }
    if (!var_57b7ba95) {
        if (!isdefined(self.health) || self.health <= 0) {
            if (!isplayer(self) || !(isdefined(self.laststand) && self.laststand)) {
                assertmsg("human");
                self.var_f3995442 = undefined;
                self notify(#"hash_90f83311", str_vo_line);
                return;
            }
        }
    }
    self.is_talking = 1;
    if (self.archetype == "human" || self.archetype == "human_riotshield" || self.archetype == "human_rpg" || isdefined(self.archetype) && self.archetype == "civilian") {
        self clientfield::set("facial_dial", 1);
    }
    self face::sayspecificdialogue(0, str_vo_line, 1, undefined, undefined, undefined, e_to_player);
    self waittillmatch(#"hash_90f83311", str_vo_line);
    if (self.archetype == "human" || self.archetype == "human_riotshield" || self.archetype == "human_rpg" || isdefined(self.archetype) && self.archetype == "civilian") {
        self clientfield::set("facial_dial", 0);
    }
    self.is_talking = undefined;
    self.var_f3995442 = undefined;
}

// Namespace dialog
// Params 1, eflags: 0x1 linked
// namespace_71b8dba1<file_0>::function_665c78f1
// Checksum 0xd0441982, Offset: 0xac0
// Size: 0x5e
function function_665c78f1(str_vo_line) {
    self endon(#"death");
    self notify(#"hash_8e6b4ba3");
    self endon(#"hash_8e6b4ba3");
    util::waittill_any_ents_two(level, "kill_pending_dialog", self, "kill_pending_dialog");
    self.var_f3995442 = undefined;
}

// Namespace dialog
// Params 2, eflags: 0x1 linked
// namespace_71b8dba1<file_0>::function_13b3b16a
// Checksum 0xf1c3dfeb, Offset: 0xb28
// Size: 0xf4
function function_13b3b16a(str_vo_line, n_delay) {
    if (self == level) {
        foreach (player in level.activeplayers) {
            player thread function_13b3b16a(str_vo_line, n_delay);
        }
        array::wait_till_match(level.activeplayers, "done speaking", str_vo_line);
        return;
    }
    say(str_vo_line, n_delay, 0, self);
}

// Namespace dialog
// Params 5, eflags: 0x0
// namespace_71b8dba1<file_0>::function_a463d127
// Checksum 0xb79bc563, Offset: 0xc28
// Size: 0x392
function remote(str_vo_line, n_delay, str_type, e_to_player, var_43937b21) {
    if (!isdefined(str_type)) {
        str_type = "dni";
    }
    if (str_type === "dni") {
        var_8ef9b1c0 = strtok(level.scr_sound["generic"][str_vo_line], "_");
        var_46866c13 = undefined;
        switch (var_8ef9b1c0[var_8ef9b1c0.size - 1]) {
        case 27:
            var_46866c13 = %CPUI_DIAZ_SEBASTIAN;
            break;
        case 28:
            var_46866c13 = %CPUI_EGYPTIAN_COMMAND;
            break;
        case 37:
            var_46866c13 = %CPUI_GOH_XIULAN;
            break;
        case 30:
            var_46866c13 = %CPUI_HENDRICKS_JACOB;
            break;
        case 32:
            var_46866c13 = %CPUI_KHALIL_ZEYAD;
            break;
        case 33:
            var_46866c13 = %CPUI_MARETTI_PETER;
            break;
        case 31:
            var_46866c13 = %CPUI_KANE_RACHEL;
            break;
        case 29:
            var_46866c13 = %CPUI_HALL_SARAH;
            break;
        case 34:
            var_46866c13 = %CPUI_TAYLOR_JOHN;
            break;
        case 35:
        case 36:
            var_46866c13 = %CPUI_VTOL_PILOT;
            break;
        default:
            var_46866c13 = undefined;
            break;
        }
        if (isdefined(var_46866c13) && !sessionmodeiscampaignzombiesgame()) {
            foreach (player in level.players) {
                if (!isdefined(e_to_player) || e_to_player == player) {
                    player luinotifyevent(%offsite_comms_message, 1, var_46866c13);
                }
            }
        }
    }
    level say(str_vo_line, n_delay, 1, e_to_player, var_43937b21);
    if (!sessionmodeiscampaignzombiesgame()) {
        if (str_type === "dni") {
            foreach (player in level.players) {
                if (!isdefined(e_to_player) || e_to_player == player) {
                    player luinotifyevent(%offsite_comms_complete);
                }
            }
        }
    }
}

