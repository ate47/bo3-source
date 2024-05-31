#using scripts/shared/util_shared;

#namespace scriptbundle;

// Namespace scriptbundle
// Method(s) 6 Total 6
class cscriptbundleobjectbase {

    // Namespace cscriptbundleobjectbase
    // Params 1, eflags: 0x1 linked
    // namespace_28d48ba3<file_0>::function_3983140d
    // Checksum 0x9f43d606, Offset: 0x3b8
    // Size: 0x18
    function get_ent(localclientnum) {
        return self._e_array[localclientnum];
    }

    // Namespace cscriptbundleobjectbase
    // Params 2, eflags: 0x1 linked
    // namespace_28d48ba3<file_0>::function_fe17af4d
    // Checksum 0x7646283a, Offset: 0x290
    // Size: 0x120
    function error(condition, str_msg) {
        if (condition) {
            if ([[ self.var_190b1ea2 ]]->is_testing()) {
                scriptbundle::error_on_screen(str_msg);
            } else {
                assertmsg([[ self.var_190b1ea2 ]]->get_type() + "<unknown string>" + [[ self.var_190b1ea2 ]]->get_name() + "<unknown string>" + (isdefined("<unknown string>") ? "<unknown string>" + "<unknown string>" : isdefined(self._s.name) ? "<unknown string>" + self._s.name : "<unknown string>") + "<unknown string>" + str_msg);
            }
            thread [[ self.var_190b1ea2 ]]->on_error();
            return true;
        }
        return false;
    }

    // Namespace cscriptbundleobjectbase
    // Params 1, eflags: 0x1 linked
    // namespace_28d48ba3<file_0>::function_60ad95cd
    // Checksum 0xb01247da, Offset: 0x1c8
    // Size: 0xbc
    function log(str_msg) {
        println([[ self.var_190b1ea2 ]]->get_type() + "<unknown string>" + [[ self.var_190b1ea2 ]]->get_name() + "<unknown string>" + (isdefined("<unknown string>") ? "<unknown string>" + "<unknown string>" : isdefined(self._s.name) ? "<unknown string>" + self._s.name : "<unknown string>") + "<unknown string>" + str_msg);
    }

    // Namespace cscriptbundleobjectbase
    // Params 4, eflags: 0x1 linked
    // namespace_28d48ba3<file_0>::function_c35e6aab
    // Checksum 0x43c9e43a, Offset: 0xe8
    // Size: 0xd8
    function init(s_objdef, o_bundle, e_ent, localclientnum) {
        self._s = s_objdef;
        self.var_190b1ea2 = o_bundle;
        if (isdefined(e_ent)) {
            assert(!isdefined(localclientnum) || e_ent.localclientnum == localclientnum, "<unknown string>");
            self._n_clientnum = e_ent.localclientnum;
            self._e_array[self._n_clientnum] = e_ent;
            return;
        }
        self._e_array = [];
        if (isdefined(localclientnum)) {
            self._n_clientnum = localclientnum;
        }
    }

}

// Namespace scriptbundle
// Method(s) 13 Total 13
class cscriptbundlebase {

    // Namespace cscriptbundlebase
    // Params 0, eflags: 0x1 linked
    // namespace_3073d1de<file_0>::function_9b385ca5
    // Checksum 0xac1989e2, Offset: 0x540
    // Size: 0x1c
    function constructor() {
        self._a_objects = [];
        self._testing = 0;
    }

    // Namespace cscriptbundlebase
    // Params 2, eflags: 0x1 linked
    // namespace_3073d1de<file_0>::function_fe17af4d
    // Checksum 0x1d5fc6b9, Offset: 0x770
    // Size: 0x84
    function error(condition, str_msg) {
        if (condition) {
            if (self._testing) {
            } else {
                assertmsg(self._s.type + "<unknown string>" + self._str_name + "<unknown string>" + str_msg);
            }
            thread on_error();
            return true;
        }
        return false;
    }

    // Namespace cscriptbundlebase
    // Params 1, eflags: 0x1 linked
    // namespace_3073d1de<file_0>::function_60ad95cd
    // Checksum 0xa969e1b3, Offset: 0x710
    // Size: 0x54
    function log(str_msg) {
        println(self._s.type + "<unknown string>" + self._str_name + "<unknown string>" + str_msg);
    }

    // Namespace cscriptbundlebase
    // Params 1, eflags: 0x1 linked
    // namespace_3073d1de<file_0>::function_2a8a1f09
    // Checksum 0x263ac26f, Offset: 0x6d8
    // Size: 0x2c
    function remove_object(o_object) {
        arrayremovevalue(self._a_objects, o_object);
    }

    // Namespace cscriptbundlebase
    // Params 1, eflags: 0x1 linked
    // namespace_3073d1de<file_0>::function_aa84004
    // Checksum 0x8072093, Offset: 0x650
    // Size: 0x7a
    function add_object(o_object) {
        if (!isdefined(self._a_objects)) {
            self._a_objects = [];
        } else if (!isarray(self._a_objects)) {
            self._a_objects = array(self._a_objects);
        }
        self._a_objects[self._a_objects.size] = o_object;
    }

    // Namespace cscriptbundlebase
    // Params 0, eflags: 0x1 linked
    // namespace_3073d1de<file_0>::function_55d8d818
    // Checksum 0x1b2ec48b, Offset: 0x638
    // Size: 0xa
    function is_testing() {
        return self._testing;
    }

    // Namespace cscriptbundlebase
    // Params 0, eflags: 0x1 linked
    // namespace_3073d1de<file_0>::function_e17ab6da
    // Checksum 0x72042d02, Offset: 0x618
    // Size: 0x12
    function get_objects() {
        return self._s.objects;
    }

    // Namespace cscriptbundlebase
    // Params 0, eflags: 0x1 linked
    // namespace_3073d1de<file_0>::function_224e6cf9
    // Checksum 0xbdfeb2bc, Offset: 0x5f8
    // Size: 0x12
    function get_vm() {
        return self._s.vmtype;
    }

    // Namespace cscriptbundlebase
    // Params 0, eflags: 0x1 linked
    // namespace_3073d1de<file_0>::function_e9e6c8b
    // Checksum 0xcd14f293, Offset: 0x5e0
    // Size: 0xa
    function get_name() {
        return self._str_name;
    }

    // Namespace cscriptbundlebase
    // Params 0, eflags: 0x1 linked
    // namespace_3073d1de<file_0>::function_6f9dda36
    // Checksum 0xc9a13037, Offset: 0x5c0
    // Size: 0x12
    function get_type() {
        return self._s.type;
    }

    // Namespace cscriptbundlebase
    // Params 3, eflags: 0x1 linked
    // namespace_3073d1de<file_0>::function_c35e6aab
    // Checksum 0xe513f66, Offset: 0x578
    // Size: 0x40
    function init(str_name, s, b_testing) {
        self._s = s;
        self._str_name = str_name;
        self._testing = b_testing;
    }

    // Namespace cscriptbundlebase
    // Params 1, eflags: 0x1 linked
    // namespace_3073d1de<file_0>::function_e248348d
    // Checksum 0x2fd958c7, Offset: 0x528
    // Size: 0xc
    function on_error(e) {
        
    }

}

// Namespace scriptbundle
// Params 1, eflags: 0x1 linked
// namespace_f4a44050<file_0>::function_4c206f9a
// Checksum 0x622e9e5e, Offset: 0xaa0
// Size: 0x14c
function error_on_screen(str_msg) {
    if (str_msg != "") {
        if (!isdefined(level.scene_error_hud)) {
            level.scene_error_hud = createluimenu(0, "HudElementText");
            setluimenudata(0, level.scene_error_hud, "alignment", 1);
            setluimenudata(0, level.scene_error_hud, "x", 0);
            setluimenudata(0, level.scene_error_hud, "y", 10);
            setluimenudata(0, level.scene_error_hud, "width", 1920);
            openluimenu(0, level.scene_error_hud);
        }
        setluimenudata(0, level.scene_error_hud, "text", str_msg);
        self thread _destroy_error_on_screen();
    }
}

// Namespace scriptbundle
// Params 0, eflags: 0x1 linked
// namespace_f4a44050<file_0>::function_63d5271a
// Checksum 0xc8b25732, Offset: 0xbf8
// Size: 0x66
function _destroy_error_on_screen() {
    level notify(#"_destroy_error_on_screen");
    level endon(#"_destroy_error_on_screen");
    self util::waittill_notify_or_timeout("stopped", 5);
    closeluimenu(0, level.scene_error_hud);
    level.scene_error_hud = undefined;
}

