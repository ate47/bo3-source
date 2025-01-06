#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/weapons/spike_charge_siegebot;

#using_animtree("generic");

#namespace siegebot;

// Namespace siegebot
// Params 0, eflags: 0x2
// Checksum 0x15e5d96b, Offset: 0x2a0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("siegebot_mp", &__init__, undefined, undefined);
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x762bff66, Offset: 0x2e0
// Size: 0xbc
function __init__() {
    vehicle::add_vehicletype_callback("siegebot_mp", &_setup_);
    clientfield::register("vehicle", "siegebot_retract_right_arm", 1, 1, "int", &function_3fa616b6, 0, 0);
    clientfield::register("vehicle", "siegebot_retract_left_arm", 1, 1, "int", &function_6a8021ad, 0, 0);
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0xd5a91301, Offset: 0x3a8
// Size: 0x6c
function _setup_(localclientnum) {
    if (isdefined(self.scriptbundlesettings)) {
        settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    }
    if (!isdefined(settings)) {
        return;
    }
    self thread function_8ab6a218(localclientnum);
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0xfc05430d, Offset: 0x420
// Size: 0x98
function function_8ab6a218(localclientnum) {
    self endon(#"death");
    self endon(#"entityshutdown");
    player = undefined;
    while (true) {
        self function_88eb9ff6(localclientnum, player);
        self waittill(#"enter_vehicle", player);
        self function_59400a42(localclientnum, player);
        self waittill(#"exit_vehicle", player);
    }
}

// Namespace siegebot
// Params 2, eflags: 0x0
// Checksum 0x2104ca27, Offset: 0x4c0
// Size: 0x76
function function_59400a42(localclientnum, player) {
    self playsound(localclientnum, "evt_siegebot_bootup_1");
    local_player = getlocalplayer(localclientnum);
    if (self islocalclientdriver(localclientnum)) {
    }
}

// Namespace siegebot
// Params 2, eflags: 0x0
// Checksum 0x935bbc9a, Offset: 0x540
// Size: 0x4e
function function_88eb9ff6(localclientnum, player) {
    self playsound(localclientnum, "evt_siegebot_shutdown_1");
    if (self islocalclientdriver(localclientnum)) {
    }
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x209c2db4, Offset: 0x598
// Size: 0x74
function function_5c502497() {
    self useanimtree(#generic);
    self clearanim(generic%ai_siegebot_base_mp_left_arm_extend, 0.2);
    self setanim(generic%ai_siegebot_base_mp_left_arm_retract, 1);
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x96f2d096, Offset: 0x618
// Size: 0xcc
function function_ffe3f04() {
    self useanimtree(#generic);
    self clearanim(generic%ai_siegebot_base_mp_left_arm_retract, 0.2);
    self setanim(generic%ai_siegebot_base_mp_left_arm_extend, 1);
    wait 0.1;
    if (self clientfield::get("siegebot_retract_left_arm") == 0) {
        self clearanim(generic%ai_siegebot_base_mp_left_arm_extend, 0.1);
    }
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x3762460a, Offset: 0x6f0
// Size: 0x74
function function_d12a9af0() {
    self useanimtree(#generic);
    self clearanim(generic%ai_siegebot_base_mp_right_arm_extend, 0.2);
    self setanim(generic%ai_siegebot_base_mp_right_arm_retract, 1);
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x1f293d6f, Offset: 0x770
// Size: 0xcc
function function_ce4c51d5() {
    self useanimtree(#generic);
    self clearanim(generic%ai_siegebot_base_mp_right_arm_retract, 0.2);
    self setanim(generic%ai_siegebot_base_mp_right_arm_extend, 1);
    wait 0.1;
    if (self clientfield::get("siegebot_retract_right_arm") == 0) {
        self clearanim(generic%ai_siegebot_base_mp_right_arm_extend, 0.1);
    }
}

// Namespace siegebot
// Params 7, eflags: 0x0
// Checksum 0xae00b72d, Offset: 0x848
// Size: 0x94
function function_3fa616b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        self thread function_d12a9af0();
        return;
    }
    self thread function_ce4c51d5();
}

// Namespace siegebot
// Params 7, eflags: 0x0
// Checksum 0x81f1a3f5, Offset: 0x8e8
// Size: 0x94
function function_6a8021ad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        self thread function_5c502497();
        return;
    }
    self thread function_ffe3f04();
}

