#using scripts/shared/scene_shared;

#namespace struct;

// Namespace struct
// Params 0, eflags: 0x2
// Checksum 0x7da99b52, Offset: 0x170
// Size: 0x24
function autoexec __init__() {
    if (!isdefined(level.struct)) {
        init_structs();
    }
}

// Namespace struct
// Params 0, eflags: 0x1 linked
// Checksum 0x98b4dd06, Offset: 0x1a0
// Size: 0xea
function init_structs() {
    level.struct = [];
    level.var_3f831f3b = [];
    level.var_570603 = [];
    level.struct_class_names = [];
    level.struct_class_names["target"] = [];
    level.struct_class_names["targetname"] = [];
    level.struct_class_names["script_noteworthy"] = [];
    level.struct_class_names["script_linkname"] = [];
    level.struct_class_names["script_label"] = [];
    level.struct_class_names["classname"] = [];
    level.struct_class_names["script_unitrigger_type"] = [];
    level.struct_class_names["scriptbundlename"] = [];
    level.struct_class_names["prefabname"] = [];
}

// Namespace struct
// Params 1, eflags: 0x1 linked
// Checksum 0x198d4c90, Offset: 0x298
// Size: 0x68
function function_aa4875d1(struct) {
    struct.var_5aabff8a = undefined;
    struct.configstringfiletype = undefined;
    /#
        devstate = struct.devstate;
    #/
    struct.devstate = undefined;
    /#
        struct.devstate = devstate;
    #/
}

// Namespace struct
// Params 3, eflags: 0x1 linked
// Checksum 0xa9efca9e, Offset: 0x308
// Size: 0x1fc
function createstruct(struct, type, name) {
    if (!isdefined(level.struct)) {
        init_structs();
    }
    if (isdefined(type)) {
        var_d64c42bd = getdvarstring("mapname") == "core_frontend";
        if (!isdefined(level.var_3f831f3b[type])) {
            level.var_3f831f3b[type] = [];
        }
        if (isdefined(level.var_3f831f3b[type][name])) {
            return level.var_3f831f3b[type][name];
        }
        if (type == "scene") {
            level.var_3f831f3b[type][name] = scene::remove_invalid_scene_objects(struct);
        } else if (!(sessionmodeismultiplayergame() || var_d64c42bd) && type == "mpdialog_player") {
        } else if (!(sessionmodeismultiplayergame() || var_d64c42bd) && type == "gibcharacterdef" && issubstr(name, "c_t7_mp_")) {
        } else if (!(sessionmodeiscampaigngame() || var_d64c42bd) && type == "collectibles") {
        } else {
            level.var_3f831f3b[type][name] = struct;
        }
        function_aa4875d1(struct);
        return;
    }
    struct init();
}

// Namespace struct
// Params 3, eflags: 0x1 linked
// Checksum 0xaf40fd54, Offset: 0x510
// Size: 0x54
function function_f3b581d0(items, assettype, name) {
    if (!isdefined(level.struct)) {
        init_structs();
    }
    level.var_570603[assettype][name] = items;
}

// Namespace struct
// Params 0, eflags: 0x1 linked
// Checksum 0xaa77f2f9, Offset: 0x570
// Size: 0x93e
function init() {
    if (!isdefined(level.struct)) {
        level.struct = [];
    } else if (!isarray(level.struct)) {
        level.struct = array(level.struct);
    }
    level.struct[level.struct.size] = self;
    if (!isdefined(self.angles)) {
        self.angles = (0, 0, 0);
    }
    if (isdefined(self.targetname)) {
        if (!isdefined(level.struct_class_names["targetname"][self.targetname])) {
            level.struct_class_names["targetname"][self.targetname] = [];
        } else if (!isarray(level.struct_class_names["targetname"][self.targetname])) {
            level.struct_class_names["targetname"][self.targetname] = array(level.struct_class_names["targetname"][self.targetname]);
        }
        level.struct_class_names["targetname"][self.targetname][level.struct_class_names["targetname"][self.targetname].size] = self;
    }
    if (isdefined(self.target)) {
        if (!isdefined(level.struct_class_names["target"][self.target])) {
            level.struct_class_names["target"][self.target] = [];
        } else if (!isarray(level.struct_class_names["target"][self.target])) {
            level.struct_class_names["target"][self.target] = array(level.struct_class_names["target"][self.target]);
        }
        level.struct_class_names["target"][self.target][level.struct_class_names["target"][self.target].size] = self;
    }
    if (isdefined(self.script_noteworthy)) {
        if (!isdefined(level.struct_class_names["script_noteworthy"][self.script_noteworthy])) {
            level.struct_class_names["script_noteworthy"][self.script_noteworthy] = [];
        } else if (!isarray(level.struct_class_names["script_noteworthy"][self.script_noteworthy])) {
            level.struct_class_names["script_noteworthy"][self.script_noteworthy] = array(level.struct_class_names["script_noteworthy"][self.script_noteworthy]);
        }
        level.struct_class_names["script_noteworthy"][self.script_noteworthy][level.struct_class_names["script_noteworthy"][self.script_noteworthy].size] = self;
    }
    if (isdefined(self.script_linkname)) {
        assert(!isdefined(level.struct_class_names["prefabname"][self.script_linkname]), "prefabname");
        level.struct_class_names["script_linkname"][self.script_linkname][0] = self;
    }
    if (isdefined(self.script_label)) {
        if (!isdefined(level.struct_class_names["script_label"][self.script_label])) {
            level.struct_class_names["script_label"][self.script_label] = [];
        } else if (!isarray(level.struct_class_names["script_label"][self.script_label])) {
            level.struct_class_names["script_label"][self.script_label] = array(level.struct_class_names["script_label"][self.script_label]);
        }
        level.struct_class_names["script_label"][self.script_label][level.struct_class_names["script_label"][self.script_label].size] = self;
    }
    if (isdefined(self.classname)) {
        if (!isdefined(level.struct_class_names["classname"][self.classname])) {
            level.struct_class_names["classname"][self.classname] = [];
        } else if (!isarray(level.struct_class_names["classname"][self.classname])) {
            level.struct_class_names["classname"][self.classname] = array(level.struct_class_names["classname"][self.classname]);
        }
        level.struct_class_names["classname"][self.classname][level.struct_class_names["classname"][self.classname].size] = self;
    }
    if (isdefined(self.script_unitrigger_type)) {
        if (!isdefined(level.struct_class_names["script_unitrigger_type"][self.script_unitrigger_type])) {
            level.struct_class_names["script_unitrigger_type"][self.script_unitrigger_type] = [];
        } else if (!isarray(level.struct_class_names["script_unitrigger_type"][self.script_unitrigger_type])) {
            level.struct_class_names["script_unitrigger_type"][self.script_unitrigger_type] = array(level.struct_class_names["script_unitrigger_type"][self.script_unitrigger_type]);
        }
        level.struct_class_names["script_unitrigger_type"][self.script_unitrigger_type][level.struct_class_names["script_unitrigger_type"][self.script_unitrigger_type].size] = self;
    }
    if (isdefined(self.scriptbundlename)) {
        if (!isdefined(level.struct_class_names["scriptbundlename"][self.scriptbundlename])) {
            level.struct_class_names["scriptbundlename"][self.scriptbundlename] = [];
        } else if (!isarray(level.struct_class_names["scriptbundlename"][self.scriptbundlename])) {
            level.struct_class_names["scriptbundlename"][self.scriptbundlename] = array(level.struct_class_names["scriptbundlename"][self.scriptbundlename]);
        }
        level.struct_class_names["scriptbundlename"][self.scriptbundlename][level.struct_class_names["scriptbundlename"][self.scriptbundlename].size] = self;
    }
    if (isdefined(self.prefabname)) {
        if (!isdefined(level.struct_class_names["prefabname"][self.prefabname])) {
            level.struct_class_names["prefabname"][self.prefabname] = [];
        } else if (!isarray(level.struct_class_names["prefabname"][self.prefabname])) {
            level.struct_class_names["prefabname"][self.prefabname] = array(level.struct_class_names["prefabname"][self.prefabname]);
        }
        level.struct_class_names["prefabname"][self.prefabname][level.struct_class_names["prefabname"][self.prefabname].size] = self;
    }
}

// Namespace struct
// Params 2, eflags: 0x1 linked
// Checksum 0xf9cfb9, Offset: 0xeb8
// Size: 0xd2
function get(kvp_value, kvp_key) {
    if (!isdefined(kvp_key)) {
        kvp_key = "targetname";
    }
    if (isdefined(level.struct_class_names[kvp_key]) && isdefined(level.struct_class_names[kvp_key][kvp_value])) {
        /#
            if (level.struct_class_names[kvp_key][kvp_value].size > 1) {
                assertmsg("prefabname" + kvp_key + "prefabname" + kvp_value + "prefabname");
                return undefined;
            }
        #/
        return level.struct_class_names[kvp_key][kvp_value][0];
    }
}

// Namespace struct
// Params 2, eflags: 0x1 linked
// Checksum 0x6f176828, Offset: 0xf98
// Size: 0x84
function spawn(v_origin, v_angles) {
    if (!isdefined(v_origin)) {
        v_origin = (0, 0, 0);
    }
    if (!isdefined(v_angles)) {
        v_angles = (0, 0, 0);
    }
    s = spawnstruct();
    s.origin = v_origin;
    s.angles = v_angles;
    return s;
}

// Namespace struct
// Params 2, eflags: 0x1 linked
// Checksum 0x31b74458, Offset: 0x1028
// Size: 0x6e
function get_array(kvp_value, kvp_key) {
    if (!isdefined(kvp_key)) {
        kvp_key = "targetname";
    }
    if (isdefined(level.struct_class_names[kvp_key][kvp_value])) {
        return arraycopy(level.struct_class_names[kvp_key][kvp_value]);
    }
    return [];
}

// Namespace struct
// Params 0, eflags: 0x1 linked
// Checksum 0x75bce4b5, Offset: 0x10a0
// Size: 0x1fc
function delete() {
    if (isdefined(self.target)) {
        arrayremovevalue(level.struct_class_names["target"][self.target], self);
    }
    if (isdefined(self.targetname)) {
        arrayremovevalue(level.struct_class_names["targetname"][self.targetname], self);
    }
    if (isdefined(self.script_noteworthy)) {
        arrayremovevalue(level.struct_class_names["script_noteworthy"][self.script_noteworthy], self);
    }
    if (isdefined(self.script_linkname)) {
        arrayremovevalue(level.struct_class_names["script_linkname"][self.script_linkname], self);
    }
    if (isdefined(self.script_label)) {
        arrayremovevalue(level.struct_class_names["script_label"][self.script_label], self);
    }
    if (isdefined(self.classname)) {
        arrayremovevalue(level.struct_class_names["classname"][self.classname], self);
    }
    if (isdefined(self.script_unitrigger_type)) {
        arrayremovevalue(level.struct_class_names["script_unitrigger_type"][self.script_unitrigger_type], self);
    }
    if (isdefined(self.scriptbundlename)) {
        arrayremovevalue(level.struct_class_names["scriptbundlename"][self.scriptbundlename], self);
    }
    if (isdefined(self.prefabname)) {
        arrayremovevalue(level.struct_class_names["prefabname"][self.prefabname], self);
    }
}

// Namespace struct
// Params 2, eflags: 0x1 linked
// Checksum 0xf37a50f0, Offset: 0x12a8
// Size: 0x54
function get_script_bundle(str_type, str_name) {
    if (isdefined(level.var_3f831f3b[str_type]) && isdefined(level.var_3f831f3b[str_type][str_name])) {
        return level.var_3f831f3b[str_type][str_name];
    }
}

// Namespace struct
// Params 2, eflags: 0x1 linked
// Checksum 0x8f5993ba, Offset: 0x1308
// Size: 0x52
function function_368120a1(str_type, str_name) {
    if (isdefined(level.var_3f831f3b[str_type]) && isdefined(level.var_3f831f3b[str_type][str_name])) {
        level.var_3f831f3b[str_type][str_name] = undefined;
    }
}

// Namespace struct
// Params 1, eflags: 0x1 linked
// Checksum 0xacd6eaeb, Offset: 0x1368
// Size: 0x3c
function get_script_bundles(str_type) {
    if (isdefined(level.var_3f831f3b) && isdefined(level.var_3f831f3b[str_type])) {
        return level.var_3f831f3b[str_type];
    }
    return [];
}

// Namespace struct
// Params 2, eflags: 0x0
// Checksum 0x6e491d6, Offset: 0x13b0
// Size: 0x54
function get_script_bundle_list(str_type, str_name) {
    if (isdefined(level.var_570603[str_type]) && isdefined(level.var_570603[str_type][str_name])) {
        return level.var_570603[str_type][str_name];
    }
}

// Namespace struct
// Params 2, eflags: 0x1 linked
// Checksum 0x817c52f3, Offset: 0x1410
// Size: 0x116
function get_script_bundle_instances(str_type, str_name) {
    if (!isdefined(str_name)) {
        str_name = "";
    }
    a_instances = get_array("scriptbundle_" + str_type, "classname");
    if (str_name != "") {
        foreach (i, s_instance in a_instances) {
            if (s_instance.name != str_name) {
                arrayremoveindex(a_instances, i, 1);
            }
        }
    }
    return a_instances;
}

// Namespace struct
// Params 3, eflags: 0x1 linked
// Checksum 0x404b2231, Offset: 0x1530
// Size: 0x314
function findstruct(param1, name, index) {
    if (isvec(param1)) {
        position = param1;
        foreach (key, _ in level.struct_class_names) {
            foreach (s_array in level.struct_class_names[key]) {
                foreach (struct in s_array) {
                    if (distancesquared(struct.origin, position) < 1) {
                        return struct;
                    }
                }
            }
        }
        if (isdefined(level.struct)) {
            foreach (struct in level.struct) {
                if (distancesquared(struct.origin, position) < 1) {
                    return struct;
                }
            }
        }
    } else {
        s = get(param1);
        if (isdefined(s)) {
            return s;
        }
        s = get_script_bundle(param1, name);
        if (isdefined(s)) {
            if (index < 0) {
                return s;
            } else if (isdefined(s.objects)) {
                return s.objects[index];
            }
        }
    }
    return undefined;
}

