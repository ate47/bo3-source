#using scripts/shared/util_shared;
#using scripts/shared/lui_shared;

#namespace scriptbundle;

// Namespace scriptbundle
// Method(s) 7 Total 7
class cscriptbundleobjectbase {

    // Namespace cscriptbundleobjectbase
    // Params 0, eflags: 0x1 linked
    // Checksum 0x54798668, Offset: 0x418
    // Size: 0xa
    function get_ent() {
        return self._e;
    }

    // Namespace cscriptbundleobjectbase
    // Params 2, eflags: 0x1 linked
    // Checksum 0xef96d976, Offset: 0x348
    // Size: 0xc4
    function warning(condition, str_msg) {
        if (condition) {
            str_msg = "[ " + [[ self.var_190b1ea2 ]]->get_name() + " ] " + (isdefined("no name") ? "" + "no name" : isdefined(self._s.name) ? "" + self._s.name : "") + ": " + str_msg;
            scriptbundle::warning_on_screen(str_msg);
            return true;
        }
        return false;
    }

    // Namespace cscriptbundleobjectbase
    // Params 2, eflags: 0x1 linked
    // Checksum 0x8f30bef4, Offset: 0x230
    // Size: 0x110
    function error(condition, str_msg) {
        if (condition) {
            str_msg = "[ " + [[ self.var_190b1ea2 ]]->get_name() + " ] " + (isdefined("no name") ? "" + "no name" : isdefined(self._s.name) ? "" + self._s.name : "") + ": " + str_msg;
            if ([[ self.var_190b1ea2 ]]->is_testing()) {
                scriptbundle::error_on_screen(str_msg);
            } else {
                assertmsg(str_msg);
            }
            thread [[ self.var_190b1ea2 ]]->on_error();
            return true;
        }
        return false;
    }

    // Namespace cscriptbundleobjectbase
    // Params 1, eflags: 0x1 linked
    // Checksum 0xfb9ca0a7, Offset: 0x168
    // Size: 0xbc
    function log(str_msg) {
        println([[ self.var_190b1ea2 ]]->get_type() + "x" + [[ self.var_190b1ea2 ]]->get_name() + "x" + (isdefined("x") ? "x" + "x" : isdefined(self._s.name) ? "x" + self._s.name : "x") + "x" + str_msg);
    }

    // Namespace cscriptbundleobjectbase
    // Params 3, eflags: 0x1 linked
    // Checksum 0x5844d1c3, Offset: 0x120
    // Size: 0x40
    function init(s_objdef, o_bundle, e_ent) {
        self._s = s_objdef;
        self.var_190b1ea2 = o_bundle;
        self._e = e_ent;
    }

}

// Namespace scriptbundle
// Method(s) 14 Total 14
class cscriptbundlebase {

    // Namespace cscriptbundlebase
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6de21345, Offset: 0x5c8
    // Size: 0x1c
    function constructor() {
        self._a_objects = [];
        self._testing = 0;
    }

    // Namespace cscriptbundlebase
    // Params 2, eflags: 0x1 linked
    // Checksum 0x6ed1fa83, Offset: 0x8a0
    // Size: 0x5c
    function warning(condition, str_msg) {
        if (condition) {
            if (self._testing) {
                scriptbundle::warning_on_screen("[ " + self._str_name + " ]: " + str_msg);
            }
            return true;
        }
        return false;
    }

    // Namespace cscriptbundlebase
    // Params 2, eflags: 0x1 linked
    // Checksum 0x109a92d7, Offset: 0x7f8
    // Size: 0x9c
    function error(condition, str_msg) {
        if (condition) {
            if (self._testing) {
                scriptbundle::error_on_screen(str_msg);
            } else {
                assertmsg(self._s.type + "x" + self._str_name + "x" + str_msg);
            }
            thread on_error();
            return true;
        }
        return false;
    }

    // Namespace cscriptbundlebase
    // Params 1, eflags: 0x1 linked
    // Checksum 0x76dbfee2, Offset: 0x798
    // Size: 0x54
    function log(str_msg) {
        println(self._s.type + "x" + self._str_name + "x" + str_msg);
    }

    // Namespace cscriptbundlebase
    // Params 1, eflags: 0x1 linked
    // Checksum 0x6f4cf57e, Offset: 0x760
    // Size: 0x2c
    function remove_object(o_object) {
        arrayremovevalue(self._a_objects, o_object);
    }

    // Namespace cscriptbundlebase
    // Params 1, eflags: 0x1 linked
    // Checksum 0x394eae86, Offset: 0x6d8
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
    // Checksum 0x4394c8e9, Offset: 0x6c0
    // Size: 0xa
    function is_testing() {
        return self._testing;
    }

    // Namespace cscriptbundlebase
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd36ab5bc, Offset: 0x6a0
    // Size: 0x12
    function get_objects() {
        return self._s.objects;
    }

    // Namespace cscriptbundlebase
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc521a181, Offset: 0x680
    // Size: 0x12
    function get_vm() {
        return self._s.vmtype;
    }

    // Namespace cscriptbundlebase
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3e31ff60, Offset: 0x668
    // Size: 0xa
    function get_name() {
        return self._str_name;
    }

    // Namespace cscriptbundlebase
    // Params 0, eflags: 0x1 linked
    // Checksum 0x63864013, Offset: 0x648
    // Size: 0x12
    function get_type() {
        return self._s.type;
    }

    // Namespace cscriptbundlebase
    // Params 3, eflags: 0x1 linked
    // Checksum 0xecff8071, Offset: 0x600
    // Size: 0x40
    function init(str_name, s, b_testing) {
        self._s = s;
        self._str_name = str_name;
        self._testing = b_testing;
    }

    // Namespace cscriptbundlebase
    // Params 1, eflags: 0x1 linked
    // Checksum 0x67ed96c9, Offset: 0x5b0
    // Size: 0xc
    function on_error(e) {
        
    }

}

// Namespace scriptbundle
// Params 1, eflags: 0x1 linked
// Checksum 0xbf45821f, Offset: 0xbd8
// Size: 0x184
function error_on_screen(str_msg) {
    if (str_msg != "") {
        if (!isdefined(level.scene_error_hud)) {
            level.scene_error_hud = level.players[0] openluimenu("HudElementText");
            level.players[0] setluimenudata(level.scene_error_hud, "alignment", 2);
            level.players[0] setluimenudata(level.scene_error_hud, "x", 0);
            level.players[0] setluimenudata(level.scene_error_hud, "y", 10);
            level.players[0] setluimenudata(level.scene_error_hud, "width", 1280);
            level.players[0] lui::set_color(level.scene_error_hud, (1, 0, 0));
        }
        level.players[0] setluimenudata(level.scene_error_hud, "text", str_msg);
        self thread _destroy_error_on_screen();
    }
}

// Namespace scriptbundle
// Params 0, eflags: 0x1 linked
// Checksum 0x1005fca8, Offset: 0xd68
// Size: 0x6e
function _destroy_error_on_screen() {
    level notify(#"_destroy_error_on_screen");
    level endon(#"_destroy_error_on_screen");
    self util::waittill_notify_or_timeout("stopped", 5);
    level.players[0] closeluimenu(level.scene_error_hud);
    level.scene_error_hud = undefined;
}

/#

    // Namespace scriptbundle
    // Params 1, eflags: 0x1 linked
    // Checksum 0x6a7dd4e6, Offset: 0xde0
    // Size: 0x18c
    function warning_on_screen(str_msg) {
        if (str_msg != "x") {
            if (!isdefined(level.scene_warning_hud)) {
                level.scene_warning_hud = level.players[0] openluimenu("x");
                level.players[0] setluimenudata(level.scene_warning_hud, "x", 2);
                level.players[0] setluimenudata(level.scene_warning_hud, "x", 0);
                level.players[0] setluimenudata(level.scene_warning_hud, "x", 1060);
                level.players[0] setluimenudata(level.scene_warning_hud, "x", 1280);
                level.players[0] lui::set_color(level.scene_warning_hud, (1, 1, 0));
            }
            level.players[0] setluimenudata(level.scene_warning_hud, "x", str_msg);
            self thread _destroy_warning_on_screen();
        }
    }

#/

// Namespace scriptbundle
// Params 0, eflags: 0x1 linked
// Checksum 0xef4b6a8f, Offset: 0xf78
// Size: 0x6e
function _destroy_warning_on_screen() {
    level notify(#"_destroy_warning_on_screen");
    level endon(#"_destroy_warning_on_screen");
    self util::waittill_notify_or_timeout("stopped", 10);
    level.players[0] closeluimenu(level.scene_warning_hud);
    level.scene_warning_hud = undefined;
}

