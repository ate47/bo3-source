#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;

#namespace namespace_aa481297;

// Namespace namespace_aa481297
// Params 0, eflags: 0x2
// namespace_aa481297<file_0>::function_2dc19561
// Checksum 0xea56ae85, Offset: 0x130
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("cp_mobile_armory", &__init__, &__main__, undefined);
}

// Namespace namespace_aa481297
// Params 0, eflags: 0x1 linked
// namespace_aa481297<file_0>::function_8c87d8eb
// Checksum 0x9980bafc, Offset: 0x178
// Size: 0x4c
function __init__() {
    clientfield::register("toplayer", "mobile_armory_cac", 1, 4, "int", &function_dd709a6d, 0, 0);
}

// Namespace namespace_aa481297
// Params 0, eflags: 0x1 linked
// namespace_aa481297<file_0>::function_5b6b9132
// Checksum 0x99ec1590, Offset: 0x1d0
// Size: 0x4
function __main__() {
    
}

// Namespace namespace_aa481297
// Params 7, eflags: 0x1 linked
// namespace_aa481297<file_0>::function_dd709a6d
// Checksum 0x2c5f84b4, Offset: 0x1e0
// Size: 0x1b6
function function_dd709a6d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isspectating(localclientnum, 0)) {
        return;
    }
    if (!isdefined(self.var_c8b2875a)) {
        self.var_c8b2875a = createluimenu(localclientnum, "ChooseClass_InGame");
    }
    if (isdefined(self.var_c8b2875a)) {
        if (newval) {
            setluimenudata(localclientnum, self.var_c8b2875a, "isInMobileArmory", 1);
            var_5ebe0017 = newval >> 1;
            if (var_5ebe0017) {
                var_91475d5f = newval >> 2;
                var_91475d5f += 6;
                setluimenudata(localclientnum, self.var_c8b2875a, "fieldOpsKitClassNum", var_91475d5f);
            }
            openluimenu(localclientnum, self.var_c8b2875a);
            return;
        }
        setluimenudata(localclientnum, self.var_c8b2875a, "close_current_menu", 1);
        closeluimenu(localclientnum, self.var_c8b2875a);
        self.var_c8b2875a = undefined;
    }
}

