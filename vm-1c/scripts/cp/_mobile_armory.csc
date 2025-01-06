#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace _mobile_armory;

// Namespace _mobile_armory
// Params 0, eflags: 0x2
// Checksum 0xea56ae85, Offset: 0x130
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("cp_mobile_armory", &__init__, &__main__, undefined);
}

// Namespace _mobile_armory
// Params 0, eflags: 0x0
// Checksum 0x9980bafc, Offset: 0x178
// Size: 0x4c
function __init__() {
    clientfield::register("toplayer", "mobile_armory_cac", 1, 4, "int", &function_dd709a6d, 0, 0);
}

// Namespace _mobile_armory
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1d0
// Size: 0x4
function __main__() {
    
}

// Namespace _mobile_armory
// Params 7, eflags: 0x0
// Checksum 0x2c5f84b4, Offset: 0x1e0
// Size: 0x1b6
function function_dd709a6d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isspectating(localclientnum, 0)) {
        return;
    }
    if (!isdefined(self.mobile_armory_cac)) {
        self.mobile_armory_cac = createluimenu(localclientnum, "ChooseClass_InGame");
    }
    if (isdefined(self.mobile_armory_cac)) {
        if (newval) {
            setluimenudata(localclientnum, self.mobile_armory_cac, "isInMobileArmory", 1);
            var_5ebe0017 = newval >> 1;
            if (var_5ebe0017) {
                var_91475d5f = newval >> 2;
                var_91475d5f += 6;
                setluimenudata(localclientnum, self.mobile_armory_cac, "fieldOpsKitClassNum", var_91475d5f);
            }
            openluimenu(localclientnum, self.mobile_armory_cac);
            return;
        }
        setluimenudata(localclientnum, self.mobile_armory_cac, "close_current_menu", 1);
        closeluimenu(localclientnum, self.mobile_armory_cac);
        self.mobile_armory_cac = undefined;
    }
}

