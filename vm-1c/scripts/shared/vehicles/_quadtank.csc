#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace quadtank;

// Namespace quadtank
// Params 0, eflags: 0x2
// Checksum 0x11649a0f, Offset: 0x230
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("quadtank", &__init__, undefined, undefined);
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0x2119266f, Offset: 0x270
// Size: 0xbc
function __init__() {
    vehicle::add_vehicletype_callback("quadtank", &_setup_);
    clientfield::register("toplayer", "player_shock_fx", 1, 1, "int", &function_fde81ec3, 0, 0);
    clientfield::register("vehicle", "quadtank_trophy_state", 1, 1, "int", &function_f6cc6e97, 0, 0);
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0xacfa3892, Offset: 0x338
// Size: 0x88
function _setup_(localclientnum) {
    player = getlocalplayer(localclientnum);
    if (isdefined(player)) {
        filter::init_filter_ev_interference(player);
    }
    self.notifyonbulletimpact = 1;
    self thread function_3502da52(localclientnum);
    self.var_628020e1 = 0;
}

// Namespace quadtank
// Params 7, eflags: 0x0
// Checksum 0x23d8a926, Offset: 0x3c8
// Size: 0x6c
function function_fde81ec3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self)) {
        self thread function_48b14d9d(localclientnum, 1, 1);
    }
}

// Namespace quadtank
// Params 3, eflags: 0x0
// Checksum 0x28397f6f, Offset: 0x440
// Size: 0x164
function function_48b14d9d(localclientnum, amount, fadeouttime) {
    self endon(#"disconnect");
    self notify(#"hash_cbd93caf");
    self endon(#"hash_cbd93caf");
    if (!isalive(self)) {
        return;
    }
    starttime = gettime();
    filter::set_filter_ev_interference_amount(self, 4, amount);
    filter::enable_filter_ev_interference(self, 4);
    while (gettime() <= starttime + fadeouttime * 1000 && isalive(self)) {
        ratio = (gettime() - starttime) / fadeouttime * 1000;
        currentvalue = lerpfloat(amount, 0, ratio);
        setfilterpassconstant(localclientnum, 4, 0, 0, currentvalue);
        wait 0.016;
    }
    setfilterpassenabled(localclientnum, 4, 0, 0);
}

// Namespace quadtank
// Params 7, eflags: 0x0
// Checksum 0xb278d423, Offset: 0x5b0
// Size: 0x5c
function function_f6cc6e97(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread function_e9d5fa52(localclientnum, newval === 1);
}

// Namespace quadtank
// Params 2, eflags: 0x0
// Checksum 0x309740ba, Offset: 0x618
// Size: 0x44c
function function_e9d5fa52(localclientnum, ison) {
    self endon(#"entityshutdown");
    self notify(#"hash_a62e39ef");
    self endon(#"hash_a62e39ef");
    if (isdefined(self.var_389b78dd)) {
        stopfx(localclientnum, self.var_389b78dd);
    }
    if (isdefined(self.var_f2d14c03)) {
        stopfx(localclientnum, self.var_f2d14c03);
    }
    vehicle::function_b7c7870e(localclientnum);
    if (isdefined(self.scriptbundlesettings)) {
        settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    }
    if (!isdefined(settings)) {
        return;
    }
    if (ison === 1) {
        var_2a1c5eea = isdefined(settings.var_5a624323) ? settings.var_5a624323 : 0.1;
        start = gettime();
        for (interval = 0.3; gettime() <= start + var_2a1c5eea * 1000; interval *= 0.8) {
            if (isdefined(settings.var_cfdb54fe) && isdefined(settings.var_f1c13278)) {
                self.var_f2d14c03 = playfxontag(localclientnum, settings.var_cfdb54fe, self, settings.var_f1c13278);
            }
            wait 0.05;
            if (isdefined(self.var_f2d14c03)) {
                stopfx(localclientnum, self.var_f2d14c03);
            }
            wait max(interval, 0.05);
        }
        if (isdefined(settings.var_cfdb54fe) && isdefined(settings.var_f1c13278)) {
            self.var_f2d14c03 = playfxontag(localclientnum, settings.var_cfdb54fe, self, settings.var_f1c13278);
        }
        self.var_628020e1 = 1;
        self playloopsound("wpn_trophy_spin_loop");
        rate = 0;
        while (isdefined(settings.var_b93b90fc) && rate < 1) {
            rate += 0.02;
            self setanim(settings.var_b93b90fc, 1, 0.1, rate);
            wait 0.016;
        }
        self setanim(settings.var_b93b90fc, 1, 0.1, 1);
        return;
    }
    self.var_628020e1 = 0;
    self stopallloopsounds();
    if (isdefined(settings.var_b93b90fc)) {
        self setanim(settings.var_b93b90fc, 0, 0.2, 1);
    }
    if (isdefined(settings.var_c6e73d45)) {
        self.var_389b78dd = playfxontag(localclientnum, settings.var_c6e73d45, self, "tag_target_lower");
    }
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0xa8819a65, Offset: 0xa70
// Size: 0x170
function function_3502da52(localclientnum) {
    self endon(#"entityshutdown");
    if (isdefined(self.scriptbundlesettings)) {
        settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    } else {
        return;
    }
    while (true) {
        self waittill(#"damage", attacker, impactpos, effectdir, partname);
        if (partname == "tag_target_lower" || partname == "tag_target_upper" || partname == "tag_defense_active" || partname == "tag_body_animate") {
            if (self.var_628020e1) {
                if (isdefined(attacker) && attacker isplayer() && attacker.team != self.team) {
                    playfx(localclientnum, settings.weakspotfx, impactpos, effectdir);
                    self playsound(0, "veh_quadtank_panel_hit");
                }
            }
        }
    }
}

