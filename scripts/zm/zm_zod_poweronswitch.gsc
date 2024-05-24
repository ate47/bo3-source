#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_f7e00735;

// Namespace namespace_f7e00735
// Method(s) 8 Total 8
class class_b025d12c {

    // Namespace namespace_b025d12c
    // Params 0, eflags: 0x0
    // Checksum 0xe984fea1, Offset: 0x538
    // Size: 0x94
    function local_power_on() {
        self.var_d461052a sethintstring(%ZM_ZOD_POWERSWITCH_POWERED);
        do {
            player = self.var_d461052a waittill(#"trigger");
        } while (!function_68132e8f(player));
        self.var_d461052a setinvisibletoall();
        [[ self.var_e289acc3 ]](self.var_20a1be38);
    }

    // Namespace namespace_b025d12c
    // Params 1, eflags: 0x0
    // Checksum 0x7076de93, Offset: 0x4e8
    // Size: 0x46
    function function_68132e8f(player) {
        if (player zm_utility::in_revive_trigger()) {
            return false;
        }
        if (player.is_drinking > 0) {
            return false;
        }
        return true;
    }

    // Namespace namespace_b025d12c
    // Params 0, eflags: 0x0
    // Checksum 0xca7f8cca, Offset: 0x4c0
    // Size: 0x1c
    function function_3d8cc198() {
        self.var_d461052a setinvisibletoall();
    }

    // Namespace namespace_b025d12c
    // Params 0, eflags: 0x0
    // Checksum 0x2e261650, Offset: 0x478
    // Size: 0x3c
    function function_5e9f96b6() {
        level flag::wait_till("power_on" + self.var_19295d02);
        local_power_on();
    }

    // Namespace namespace_b025d12c
    // Params 2, eflags: 0x0
    // Checksum 0xecc657e, Offset: 0x428
    // Size: 0x48
    function function_1bfbfa4c(e_entity, var_d42f02cf) {
        if (!isdefined(e_entity.script_string) || e_entity.script_string != var_d42f02cf) {
            return false;
        }
        return true;
    }

    // Namespace namespace_b025d12c
    // Params 6, eflags: 0x0
    // Checksum 0x7fd9638b, Offset: 0x238
    // Size: 0x1e4
    function function_7944a602(var_d42f02cf, script_int, var_76ed2e72, func, arg1, var_e4d75d16) {
        if (!isdefined(var_e4d75d16)) {
            var_e4d75d16 = 0;
        }
        var_20b0fc79 = getentarray("stair_control", "targetname");
        var_20b0fc79 = array::filter(var_20b0fc79, 0, &function_1bfbfa4c, var_d42f02cf);
        self.var_8b97288d = var_20b0fc79[var_e4d75d16];
        var_61b625c6 = getentarray("stair_control_usetrigger", "targetname");
        var_61b625c6 = array::filter(var_61b625c6, 0, &function_1bfbfa4c, var_d42f02cf);
        self.var_d461052a = var_61b625c6[var_e4d75d16];
        self.var_d461052a sethintstring(%ZM_ZOD_POWERSWITCH_UNPOWERED);
        self.var_19295d02 = script_int;
        self.var_e289acc3 = func;
        self.var_20a1be38 = arg1;
        self.var_d461052a enablelinkto();
        self.var_d461052a linkto(self.var_8b97288d);
        if (isdefined(var_76ed2e72)) {
            self.var_8b97288d linkto(var_76ed2e72);
        }
        self thread function_5e9f96b6();
    }

}

