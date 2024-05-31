#using scripts/zm/zm_zod_quest;
#using scripts/zm/zm_zod_portals;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_783690d8;

// Namespace namespace_783690d8
// Method(s) 19 Total 19
class class_1143ac18 {

    // Namespace namespace_1143ac18
    // Params 0, eflags: 0x1 linked
    // namespace_1143ac18<file_0>::function_9b385ca5
    // Checksum 0xc1bb7744, Offset: 0x448
    // Size: 0x28
    function constructor() {
        self.var_e9913a67 = [];
        self.var_22f50938 = [];
        self.var_b147f2bf = [];
    }

    // Namespace namespace_1143ac18
    // Params 0, eflags: 0x1 linked
    // namespace_1143ac18<file_0>::function_3408f1a2
    // Checksum 0x80b5ad1f, Offset: 0x15e0
    // Size: 0x22
    function function_3408f1a2() {
        if (self.var_afea543d && self.var_6e27ff4) {
            return true;
        }
        return false;
    }

    // Namespace namespace_1143ac18
    // Params 1, eflags: 0x1 linked
    // namespace_1143ac18<file_0>::function_89be164a
    // Checksum 0xb649329c, Offset: 0x1558
    // Size: 0x80
    function function_89be164a(e_trigger) {
        if (isdefined(e_trigger.script_int) && isdefined(e_trigger.script_percent)) {
            self.var_afea543d = e_trigger.script_int;
            self.var_6e27ff4 = e_trigger.script_percent;
            return;
        }
        self.var_afea543d = 0;
        self.var_6e27ff4 = 0;
    }

    // Namespace namespace_1143ac18
    // Params 1, eflags: 0x1 linked
    // namespace_1143ac18<file_0>::function_4b1eb226
    // Checksum 0x99c7cbb2, Offset: 0x1460
    // Size: 0xec
    function function_4b1eb226(e_clip) {
        e_clip setcandamage(1);
        while (true) {
            var_bee83e92, e_attacker, v_dir, v_pos, str_type = e_clip waittill(#"damage");
            if (isdefined(e_attacker.beastmode) && isdefined(e_attacker) && isplayer(e_attacker) && e_attacker.beastmode && str_type === "MOD_MELEE") {
                self.m_e_trigger notify(#"trigger", e_attacker);
                break;
            }
        }
    }

    // Namespace namespace_1143ac18
    // Params 4, eflags: 0x1 linked
    // namespace_1143ac18<file_0>::function_de460788
    // Checksum 0x9092c83d, Offset: 0x1168
    // Size: 0x2ea
    function add_callback(fn_callback, param1, param2, param3) {
        assert(isdefined(fn_callback) && isfunctionptr(fn_callback));
        s = spawnstruct();
        s.fn = fn_callback;
        s.params = [];
        if (isdefined(param1)) {
            if (!isdefined(s.params)) {
                s.params = [];
            } else if (!isarray(s.params)) {
                s.params = array(s.params);
            }
            s.params[s.params.size] = param1;
        }
        if (isdefined(param2)) {
            if (!isdefined(s.params)) {
                s.params = [];
            } else if (!isarray(s.params)) {
                s.params = array(s.params);
            }
            s.params[s.params.size] = param2;
        }
        if (isdefined(param3)) {
            if (!isdefined(s.params)) {
                s.params = [];
            } else if (!isarray(s.params)) {
                s.params = array(s.params);
            }
            s.params[s.params.size] = param3;
        }
        if (!isdefined(self.var_e9913a67)) {
            self.var_e9913a67 = [];
        } else if (!isarray(self.var_e9913a67)) {
            self.var_e9913a67 = array(self.var_e9913a67);
        }
        self.var_e9913a67[self.var_e9913a67.size] = s;
    }

    // Namespace namespace_1143ac18
    // Params 0, eflags: 0x5 linked
    // namespace_1143ac18<file_0>::function_10514fab
    // Checksum 0x2a99ccba, Offset: 0xfe0
    // Size: 0x180
    function private function_10514fab() {
        foreach (var_45e75a74 in self.var_e9913a67) {
            switch (var_45e75a74.params.size) {
            case 0:
                self thread [[ var_45e75a74.fn ]]();
                break;
            case 1:
                self thread [[ var_45e75a74.fn ]](var_45e75a74.params[0]);
                break;
            case 2:
                self thread [[ var_45e75a74.fn ]](var_45e75a74.params[0], var_45e75a74.params[1]);
                break;
            case 3:
                self thread [[ var_45e75a74.fn ]](var_45e75a74.params[0], var_45e75a74.params[1], var_45e75a74.params[2]);
                break;
            }
        }
    }

    // Namespace namespace_1143ac18
    // Params 0, eflags: 0x5 linked
    // namespace_1143ac18<file_0>::function_d290ebfa
    // Checksum 0x9c3fa03f, Offset: 0xd30
    // Size: 0x2a8
    function private main() {
        who = self.m_e_trigger waittill(#"trigger");
        if (isdefined(who)) {
            who notify(#"hash_d8f4150d");
        }
        foreach (model in self.var_b147f2bf) {
            if (model.targetname == "fxanim_beast_door") {
                model playsound("zmb_bm_interaction_door");
            }
            if (model.targetname == "fxanim_crate_breakable_01") {
                model playsound("zmb_bm_interaction_crate_large");
            }
            if (model.targetname == "fxanim_crate_breakable_02") {
                model playsound("zmb_bm_interaction_crate_small");
            }
            if (model.targetname == "fxanim_crate_breakable_03") {
                model playsound("zmb_bm_interaction_crate_small");
            }
        }
        function_10514fab();
        foreach (e_clip in self.var_874b5dbf) {
            e_clip delete();
        }
        function_80d521ff(0);
        function_6ea46467(0);
        if (isdefined(self.m_e_trigger.script_flag_set)) {
            level flag::set(self.m_e_trigger.script_flag_set);
        }
        if (isdefined(self.var_8c958204)) {
            [[ self.var_8c958204 ]](self.var_b94c1eb);
        }
    }

    // Namespace namespace_1143ac18
    // Params 0, eflags: 0x5 linked
    // namespace_1143ac18<file_0>::function_387c449e
    // Checksum 0x4bc00414, Offset: 0xcf8
    // Size: 0x2c
    function private function_387c449e() {
        self waittill(#"hash_13f02a5d");
        self clientfield::set("set_fade_material", 0);
    }

    // Namespace namespace_1143ac18
    // Params 0, eflags: 0x5 linked
    // namespace_1143ac18<file_0>::function_d8055c34
    // Checksum 0x3f763d8e, Offset: 0xcb8
    // Size: 0x36
    function private function_d8055c34() {
        self thread function_387c449e();
        wait(10);
        if (isdefined(self)) {
            self notify(#"hash_13f02a5d");
        }
    }

    // Namespace namespace_1143ac18
    // Params 1, eflags: 0x5 linked
    // namespace_1143ac18<file_0>::function_6ea46467
    // Checksum 0xecda0067, Offset: 0xbf0
    // Size: 0xba
    function private function_6ea46467(var_451c9181) {
        foreach (e_model in self.var_b147f2bf) {
            if (var_451c9181) {
                e_model clientfield::set("set_fade_material", 1);
                continue;
            }
            e_model thread function_d8055c34();
        }
    }

    // Namespace namespace_1143ac18
    // Params 1, eflags: 0x5 linked
    // namespace_1143ac18<file_0>::function_80d521ff
    // Checksum 0x2f57be24, Offset: 0xb40
    // Size: 0xa8
    function private function_80d521ff(var_451c9181) {
        foreach (e_model in self.var_b147f2bf) {
            e_model clientfield::set("bminteract", var_451c9181);
        }
        self.var_40a64b9d = var_451c9181;
    }

    // Namespace namespace_1143ac18
    // Params 0, eflags: 0x1 linked
    // namespace_1143ac18<file_0>::function_82bc26b5
    // Checksum 0x28b91ca8, Offset: 0xae0
    // Size: 0x54
    function function_82bc26b5() {
        wait(1);
        level clientfield::set("breakable_show", self.var_afea543d);
        level clientfield::set("breakable_hide", self.var_6e27ff4);
    }

    // Namespace namespace_1143ac18
    // Params 0, eflags: 0x5 linked
    // namespace_1143ac18<file_0>::function_17dbc3e9
    // Checksum 0x10f788af, Offset: 0x978
    // Size: 0x15c
    function private function_17dbc3e9() {
        var_c661ffbe = struct::get(self.m_e_trigger.target, "targetname");
        if (isdefined(var_c661ffbe) && isdefined(var_c661ffbe.scriptbundlename)) {
            if (!isdefined(level.var_4c3d0fb8)) {
                level.var_4c3d0fb8 = [];
            }
            if (!isdefined(level.var_4c3d0fb8[var_c661ffbe.scriptbundlename])) {
                level.var_4c3d0fb8[var_c661ffbe.scriptbundlename] = var_c661ffbe.scriptbundlename;
            }
            if (function_3408f1a2()) {
                self thread function_82bc26b5();
            } else {
                level scene::init(self.m_e_trigger.target, "targetname");
            }
            var_5b3a6271 = function_3408f1a2();
            add_callback(&namespace_783690d8::function_31bb7714, var_5b3a6271, self.var_afea543d, self.var_6e27ff4);
        }
    }

    // Namespace namespace_1143ac18
    // Params 1, eflags: 0x1 linked
    // namespace_1143ac18<file_0>::function_21868f44
    // Checksum 0xc0bb2836, Offset: 0x890
    // Size: 0xdc
    function function_21868f44(e_model) {
        if (!isdefined(self.var_b147f2bf)) {
            self.var_b147f2bf = [];
        } else if (!isarray(self.var_b147f2bf)) {
            self.var_b147f2bf = array(self.var_b147f2bf);
        }
        self.var_b147f2bf[self.var_b147f2bf.size] = e_model;
        if (function_61ed2bc3("any_damage")) {
            thread function_4b1eb226(e_model);
        }
        function_80d521ff(self.var_40a64b9d);
        function_6ea46467(1);
    }

    // Namespace namespace_1143ac18
    // Params 1, eflags: 0x1 linked
    // namespace_1143ac18<file_0>::function_61ed2bc3
    // Checksum 0xf0928bec, Offset: 0x858
    // Size: 0x2c
    function function_61ed2bc3(var_f2eb1416) {
        return isdefined(self.var_22f50938[var_f2eb1416]) && self.var_22f50938[var_f2eb1416];
    }

    // Namespace namespace_1143ac18
    // Params 0, eflags: 0x5 linked
    // namespace_1143ac18<file_0>::function_f559704d
    // Checksum 0xdf483ab, Offset: 0x660
    // Size: 0x1ea
    function private function_f559704d() {
        if (!isdefined(self.m_e_trigger.script_parameters)) {
            return;
        }
        a_params = strtok(self.m_e_trigger.script_parameters, ",");
        foreach (var_b57e3a38 in a_params) {
            self.var_22f50938[var_b57e3a38] = 1;
            if (var_b57e3a38 == "connect_paths") {
                add_callback(&namespace_783690d8::function_1e436158);
                continue;
            }
            if (var_b57e3a38 == "any_damage") {
                foreach (e_clip in self.var_874b5dbf) {
                    thread function_4b1eb226(e_clip);
                }
                continue;
            }
            assertmsg("bminteract" + var_b57e3a38 + "bminteract" + self.m_e_trigger.targetname + "bminteract");
        }
    }

    // Namespace namespace_1143ac18
    // Params 2, eflags: 0x1 linked
    // namespace_1143ac18<file_0>::function_32f1f123
    // Checksum 0x9b0e0a50, Offset: 0x628
    // Size: 0x2c
    function function_32f1f123(var_55b30dc8, arg) {
        self.var_8c958204 = var_55b30dc8;
        self.var_b94c1eb = arg;
    }

    // Namespace namespace_1143ac18
    // Params 1, eflags: 0x1 linked
    // namespace_1143ac18<file_0>::function_c35e6aab
    // Checksum 0x1cbc39f5, Offset: 0x478
    // Size: 0x1a4
    function init(e_trigger) {
        self.m_e_trigger = e_trigger;
        self.var_874b5dbf = getentarray(e_trigger.target, "targetname");
        self.var_889ff800 = getnodearray(e_trigger.target, "targetname");
        foreach (node in self.var_889ff800) {
            if (isdefined(node.script_noteworthy) && node.script_noteworthy == "air_beast_node") {
                unlinktraversal(node);
            }
        }
        function_89be164a(e_trigger);
        function_17dbc3e9();
        function_f559704d();
        function_80d521ff(1);
        function_6ea46467(1);
        thread main();
    }

}

// Namespace namespace_783690d8
// Params 0, eflags: 0x2
// namespace_783690d8<file_0>::function_2dc19561
// Checksum 0x873314bf, Offset: 0x408
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_zod_smashables", &__init__, undefined, undefined);
}

// Namespace namespace_783690d8
// Params 0, eflags: 0x1 linked
// namespace_783690d8<file_0>::function_8c87d8eb
// Checksum 0x6a6bfee7, Offset: 0x19e0
// Size: 0xb2
function __init__() {
    level thread function_9303865();
    foreach (str_bundle in level.var_4c3d0fb8) {
        scene::add_scene_func(str_bundle, &function_b0597c09, "init");
    }
}

// Namespace namespace_783690d8
// Params 1, eflags: 0x5 linked
// namespace_783690d8<file_0>::function_98f24ad1
// Checksum 0xee087432, Offset: 0x1aa0
// Size: 0xbe
function private function_98f24ad1(str_targetname) {
    foreach (var_e535841d in level.var_ac1aab64) {
        if (isdefined(var_e535841d.m_e_trigger.target) && var_e535841d.m_e_trigger.target == str_targetname) {
            return var_e535841d;
        }
    }
    return undefined;
}

// Namespace namespace_783690d8
// Params 1, eflags: 0x5 linked
// namespace_783690d8<file_0>::function_b0597c09
// Checksum 0xd83fc7c7, Offset: 0x1b68
// Size: 0xe6
function private function_b0597c09(a_models) {
    var_e535841d = undefined;
    foreach (e_model in a_models) {
        if (!isdefined(var_e535841d)) {
            var_e535841d = function_98f24ad1(e_model._o_scene._e_root.targetname);
        }
        if (isdefined(var_e535841d)) {
            [[ var_e535841d ]]->function_21868f44(e_model);
        }
    }
}

// Namespace namespace_783690d8
// Params 0, eflags: 0x5 linked
// namespace_783690d8<file_0>::function_9303865
// Checksum 0xe898167c, Offset: 0x1c58
// Size: 0x29a
function private function_9303865() {
    level.var_ac1aab64 = [];
    var_5b2a4fe5 = getentarray("beast_melee_only", "script_noteworthy");
    n_id = 0;
    foreach (trigger in var_5b2a4fe5) {
        str_id = "smash_unnamed_" + n_id;
        if (isdefined(trigger.targetname)) {
            str_id = trigger.targetname;
        } else {
            trigger.targetname = str_id;
            n_id++;
        }
        if (isdefined(level.var_ac1aab64[str_id])) {
            assertmsg("bminteract" + str_id + "bminteract");
            continue;
        }
        var_bb87fb61 = new class_1143ac18();
        level.var_ac1aab64[str_id] = var_bb87fb61;
        if (issubstr(str_id, "portal")) {
            [[ var_bb87fb61 ]]->function_32f1f123(&namespace_8e2647d0::function_54ec766b, str_id);
        }
        if (issubstr(str_id, "memento")) {
            [[ var_bb87fb61 ]]->function_32f1f123(&namespace_1f61c67f::function_c2c28545, str_id);
        }
        if (issubstr(str_id, "beast_kiosk")) {
            [[ var_bb87fb61 ]]->function_32f1f123(&function_98a01ab9, str_id);
        }
        if (str_id === "unlock_quest_key") {
            [[ var_bb87fb61 ]]->function_32f1f123(&function_1c061892, str_id);
        }
        [[ var_bb87fb61 ]]->init(trigger);
    }
}

// Namespace namespace_783690d8
// Params 1, eflags: 0x1 linked
// namespace_783690d8<file_0>::function_98a01ab9
// Checksum 0x194d5801, Offset: 0x1f00
// Size: 0x4c
function function_98a01ab9(str_id) {
    function_14a1c32c("beast_mode_kiosk_unavailable", str_id);
    function_14a1c32c("beast_mode_kiosk", str_id);
}

// Namespace namespace_783690d8
// Params 2, eflags: 0x1 linked
// namespace_783690d8<file_0>::function_14a1c32c
// Checksum 0xc71a8978, Offset: 0x1f58
// Size: 0xda
function function_14a1c32c(str_targetname, str_id) {
    triggers = getentarray(str_targetname, "targetname");
    foreach (trigger in triggers) {
        if (trigger.script_noteworthy === str_id) {
            trigger.is_unlocked = 1;
        }
    }
}

// Namespace namespace_783690d8
// Params 1, eflags: 0x1 linked
// namespace_783690d8<file_0>::function_1c061892
// Checksum 0xbd1dd1bd, Offset: 0x2040
// Size: 0x18
function function_1c061892(str_id) {
    level.var_c913a45f = 1;
}

// Namespace namespace_783690d8
// Params 5, eflags: 0x1 linked
// namespace_783690d8<file_0>::function_de460788
// Checksum 0xf72c2cb0, Offset: 0x2060
// Size: 0xa8
function add_callback(targetname, fn_callback, param1, param2, param3) {
    var_bb87fb61 = level.var_ac1aab64[targetname];
    if (!isdefined(var_bb87fb61)) {
        assertmsg("bminteract" + targetname + "bminteract");
        return;
    }
    [[ var_bb87fb61 ]]->add_callback(fn_callback, param1, param2, param3);
}

// Namespace namespace_783690d8
// Params 0, eflags: 0x5 linked
// namespace_783690d8<file_0>::function_1e436158
// Checksum 0x3e491af4, Offset: 0x2110
// Size: 0xe2
function private function_1e436158() {
    self.var_874b5dbf[0] connectpaths();
    if (isdefined(self.var_889ff800)) {
        foreach (node in self.var_889ff800) {
            if (isdefined(node.script_noteworthy) && node.script_noteworthy == "air_beast_node") {
                linktraversal(node);
            }
        }
    }
}

// Namespace namespace_783690d8
// Params 3, eflags: 0x5 linked
// namespace_783690d8<file_0>::function_31bb7714
// Checksum 0xef2183cd, Offset: 0x2200
// Size: 0xd4
function private function_31bb7714(var_5b3a6271, var_bc554281, var_6bf8cfb8) {
    str_fxanim = self.m_e_trigger.target;
    s_fxanim = struct::get(str_fxanim, "targetname");
    if (var_bc554281) {
        level clientfield::set("breakable_hide", var_bc554281);
    }
    level scene::play(str_fxanim, "targetname");
    if (var_6bf8cfb8) {
        level clientfield::set("breakable_show", var_6bf8cfb8);
    }
}

