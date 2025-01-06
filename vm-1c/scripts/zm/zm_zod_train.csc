#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_filter;

#namespace zm_train;

// Namespace zm_train
// Params 0, eflags: 0x2
// Checksum 0xbf8aa55d, Offset: 0x4a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_train", &__init__, undefined, undefined);
}

// Namespace zm_train
// Params 0, eflags: 0x0
// Checksum 0xa426b2d4, Offset: 0x4e8
// Size: 0x2ec
function __init__() {
    if (!isdefined(level._additional_wallbuy_weapons)) {
        level._additional_wallbuy_weapons = [];
    }
    var_d7d92d53 = getweapon("smg_sten");
    if (!isdefined(level._additional_wallbuy_weapons)) {
        level._additional_wallbuy_weapons = [];
    } else if (!isarray(level._additional_wallbuy_weapons)) {
        level._additional_wallbuy_weapons = array(level._additional_wallbuy_weapons);
    }
    level._additional_wallbuy_weapons[level._additional_wallbuy_weapons.size] = var_d7d92d53;
    level._effect["train_switch_use"] = "light/fx_light_button_green_traincar_zod_zmb";
    level._effect["train_switch_cooldown"] = "light/fx_light_button_yellow_traincar_zod_zmb";
    level._effect["train_switch_offline"] = "light/fx_light_button_red_train_zod_zmb";
    level._effect["callbox_use"] = "light/fx_light_button_green_traincar_zod_zmb";
    level._effect["callbox_cooldown"] = "light/fx_light_button_yellow_traincar_zod_zmb";
    level._effect["callbox_offline"] = "light/fx_light_button_red_train_zod_zmb";
    level._effect["map_light"] = "light/fx_light_button_yellow_traincar_zod_zmb";
    clientfield::register("vehicle", "train_switch_light", 1, 2, "int", &train_switch_light, 0, 0);
    clientfield::register("scriptmover", "train_callbox_light", 1, 2, "int", &train_callbox_light, 0, 0);
    clientfield::register("scriptmover", "train_map_light", 1, 2, "int", &train_map_light, 0, 0);
    clientfield::register("vehicle", "train_rain_fx_occluder", 1, 1, "int", &train_rain_fx_occluder, 0, 0);
    clientfield::register("world", "sndTrainVox", 1, 4, "int", &sndTrainVox, 0, 0);
    level thread function_1093db4e();
}

// Namespace zm_train
// Params 7, eflags: 0x0
// Checksum 0x6776114f, Offset: 0x7e0
// Size: 0x15c
function train_rain_fx_occluder(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdemoplaying() && getnumfreeentities(localclientnum) < 100) {
        var_2a6bebf9 = getnumfreeentities(localclientnum);
        return;
    }
    if (newval) {
        if (!isdefined(self.mdl_tag)) {
            self.mdl_tag = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
            self.mdl_tag linkto(self);
            self.var_c604c399 = addboltedfxexclusionvolume(localclientnum, self.mdl_tag, "tag_origin", (768 / 2, -72 / 2, 296 / 2));
        }
    }
}

// Namespace zm_train
// Params 7, eflags: 0x0
// Checksum 0x44b67039, Offset: 0x948
// Size: 0x39e
function train_switch_light(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 0:
        if (isdefined(self.var_f5d230df)) {
            stopfx(localclientnum, self.var_f5d230df);
        }
        if (isdefined(self.var_2e5172f3)) {
            stopfx(localclientnum, self.var_2e5172f3);
        }
        self.var_f5d230df = playfxontag(localclientnum, level._effect["train_switch_cooldown"], self, "tag_fx_switch_front");
        self.var_2e5172f3 = playfxontag(localclientnum, level._effect["train_switch_cooldown"], self, "tag_fx_switch_back");
        var_98df44c1 = self gettagorigin("tag_fx_switch_front");
        var_bee1bf2a = self gettagorigin("tag_fx_switch_back");
        level thread function_3e0f1f7e("evt_train_switch_hit", var_98df44c1, var_bee1bf2a);
        break;
    case 1:
        if (isdefined(self.var_f5d230df)) {
            stopfx(localclientnum, self.var_f5d230df);
        }
        if (isdefined(self.var_2e5172f3)) {
            stopfx(localclientnum, self.var_2e5172f3);
        }
        self.var_f5d230df = playfxontag(localclientnum, level._effect["train_switch_use"], self, "tag_fx_switch_front");
        self.var_2e5172f3 = playfxontag(localclientnum, level._effect["train_switch_use"], self, "tag_fx_switch_back");
        var_98df44c1 = self gettagorigin("tag_fx_switch_front");
        var_bee1bf2a = self gettagorigin("tag_fx_switch_back");
        level thread function_3e0f1f7e("evt_train_switch_ready", var_98df44c1, var_bee1bf2a);
        break;
    case 2:
        if (isdefined(self.var_f5d230df)) {
            stopfx(localclientnum, self.var_f5d230df);
        }
        if (isdefined(self.var_2e5172f3)) {
            stopfx(localclientnum, self.var_2e5172f3);
        }
        self.var_f5d230df = playfxontag(localclientnum, level._effect["train_switch_offline"], self, "tag_fx_switch_front");
        self.var_2e5172f3 = playfxontag(localclientnum, level._effect["train_switch_offline"], self, "tag_fx_switch_back");
        break;
    }
}

// Namespace zm_train
// Params 3, eflags: 0x0
// Checksum 0xe2e60efb, Offset: 0xcf0
// Size: 0x64
function function_3e0f1f7e(alias, origin1, origin2) {
    playsound(0, alias, origin1);
    wait 0.05;
    playsound(0, alias, origin2);
}

// Namespace zm_train
// Params 7, eflags: 0x0
// Checksum 0xfc9dc8ef, Offset: 0xd60
// Size: 0x19e
function train_callbox_light(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 0:
        if (isdefined(self.fx)) {
            stopfx(localclientnum, self.fx);
        }
        self.fx = playfxontag(localclientnum, level._effect["callbox_cooldown"], self, "Tag_fx_light");
        break;
    case 1:
        if (isdefined(self.fx)) {
            stopfx(localclientnum, self.fx);
        }
        self.fx = playfxontag(localclientnum, level._effect["callbox_use"], self, "Tag_fx_light");
        break;
    case 2:
        if (isdefined(self.fx)) {
            stopfx(localclientnum, self.fx);
        }
        self.fx = playfxontag(localclientnum, level._effect["callbox_offline"], self, "Tag_fx_light");
        break;
    }
}

// Namespace zm_train
// Params 7, eflags: 0x0
// Checksum 0x6d2bce3e, Offset: 0xf08
// Size: 0x1e6
function train_map_light(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_66058d50) && newval != 1) {
        stopfx(localclientnum, self.var_66058d50);
        self.var_66058d50 = undefined;
    }
    if (isdefined(self.var_de7b8712) && newval != 2) {
        stopfx(localclientnum, self.var_de7b8712);
        self.var_de7b8712 = undefined;
    }
    if (isdefined(self.var_79780b1f) && newval != 3) {
        stopfx(localclientnum, self.var_79780b1f);
        self.var_79780b1f = undefined;
    }
    switch (newval) {
    case 1:
        self.var_66058d50 = playfxontag(localclientnum, level._effect["map_light"], self, "tag_fx_light_waterfront");
        break;
    case 2:
        self.var_de7b8712 = playfxontag(localclientnum, level._effect["map_light"], self, "tag_fx_light_footlight");
        break;
    case 3:
        self.var_79780b1f = playfxontag(localclientnum, level._effect["map_light"], self, "tag_fx_light_canals");
        break;
    }
}

// Namespace zm_train
// Params 0, eflags: 0x0
// Checksum 0xda311d1e, Offset: 0x10f8
// Size: 0x8c
function function_1093db4e() {
    level.var_98f27ad = array("vox_tanc_board_canal_", "vox_tanc_board_slums_", "vox_tanc_board_theater_", "vox_tanc_depart_canal_", "vox_tanc_depart_slums_", "vox_tanc_depart_theater_", "vox_tanc_divert_canal_", "vox_tanc_divert_slums_", "vox_tanc_divert_theater_");
    level.var_71738ea0 = struct::get_array("sndTrainVox", "targetname");
}

// Namespace zm_train
// Params 7, eflags: 0x0
// Checksum 0x4c2504b0, Offset: 0x1190
// Size: 0x16c
function sndTrainVox(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_71738ea0)) {
        return;
    }
    if (newval) {
        alias = level.var_98f27ad[newval - 1];
        foreach (location in level.var_71738ea0) {
            num = 1;
            if (location.script_string == "small") {
                num = 0;
            }
            playsound(0, alias + num, location.origin);
            wait 0.016;
        }
    }
    level.var_71738ea0 = array::randomize(level.var_71738ea0);
}

