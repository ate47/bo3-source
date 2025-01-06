#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace weaponobjects;

// Namespace weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xac375d84, Offset: 0x358
// Size: 0x220
function init_shared() {
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    clientfield::register("toplayer", "proximity_alarm", 1, 2, "int", &proximity_alarm_changed, 0, 1);
    clientfield::register("missile", "retrievable", 1, 1, "int", &retrievable_changed, 0, 1);
    clientfield::register("scriptmover", "retrievable", 1, 1, "int", &retrievable_changed, 0, 0);
    clientfield::register("missile", "enemyequip", 1, 2, "int", &enemyequip_changed, 0, 1);
    clientfield::register("scriptmover", "enemyequip", 1, 2, "int", &enemyequip_changed, 0, 0);
    clientfield::register("missile", "teamequip", 1, 1, "int", &teamequip_changed, 0, 1);
    level._effect["powerLight"] = "weapon/fx_equip_light_os";
    if (!isdefined(level.retrievable)) {
        level.retrievable = [];
    }
    if (!isdefined(level.enemyequip)) {
        level.enemyequip = [];
    }
}

// Namespace weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xc5c3fa9, Offset: 0x580
// Size: 0x5c
function on_localplayer_spawned(local_client_num) {
    if (self != getlocalplayer(local_client_num)) {
        return;
    }
    self thread watch_perks_changed(local_client_num);
    self thread function_94c5a728(local_client_num);
}

// Namespace weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xfa820889, Offset: 0x5e8
// Size: 0x138
function function_94c5a728(local_client_num) {
    self notify(#"hash_94c5a728");
    self endon(#"hash_94c5a728");
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    while (isdefined(self)) {
        self waittill(#"notetrack", note);
        if (note == "activate_datapad") {
            uimodel = createuimodel(getuimodelforcontroller(local_client_num), "hudItems.killstreakActivated");
            setuimodelvalue(uimodel, 1);
        }
        if (note == "deactivate_datapad") {
            uimodel = createuimodel(getuimodelforcontroller(local_client_num), "hudItems.killstreakActivated");
            setuimodelvalue(uimodel, 0);
        }
    }
}

// Namespace weaponobjects
// Params 7, eflags: 0x0
// Checksum 0xcbd78f61, Offset: 0x728
// Size: 0x5c
function proximity_alarm_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    update_sound(local_client_num, bnewent, newval, oldval);
}

// Namespace weaponobjects
// Params 4, eflags: 0x0
// Checksum 0x72e6f4de, Offset: 0x790
// Size: 0x15c
function update_sound(local_client_num, bnewent, newval, oldval) {
    if (newval == 2) {
        if (!isdefined(self._proximity_alarm_snd_ent)) {
            self._proximity_alarm_snd_ent = spawn(local_client_num, self.origin, "script_origin");
            self thread sndproxalert_entcleanup(local_client_num, self._proximity_alarm_snd_ent);
        }
        playsound(local_client_num, "uin_c4_proximity_alarm_start", (0, 0, 0));
        self._proximity_alarm_snd_ent playloopsound("uin_c4_proximity_alarm_loop", 0.1);
        return;
    }
    if (newval == 1) {
        return;
    }
    if (newval == 0 && isdefined(oldval) && oldval != newval) {
        playsound(local_client_num, "uin_c4_proximity_alarm_stop", (0, 0, 0));
        if (isdefined(self._proximity_alarm_snd_ent)) {
            self._proximity_alarm_snd_ent stopallloopsounds(0.5);
        }
    }
}

// Namespace weaponobjects
// Params 7, eflags: 0x0
// Checksum 0x9a7e1acc, Offset: 0x8f8
// Size: 0x5c
function teamequip_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self updateteamequipment(local_client_num, newval);
}

// Namespace weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x2cbfaeda, Offset: 0x960
// Size: 0x2c
function updateteamequipment(local_client_num, newval) {
    self checkteamequipment(local_client_num);
}

// Namespace weaponobjects
// Params 7, eflags: 0x0
// Checksum 0x5f56a585, Offset: 0x998
// Size: 0xbc
function retrievable_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.var_f12ccf06)) {
        self [[ level.var_f12ccf06 ]](local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
        return;
    }
    self util::add_remove_list(level.retrievable, newval);
    self updateretrievable(local_client_num, newval);
}

// Namespace weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x26b546d1, Offset: 0xa60
// Size: 0x84
function updateretrievable(local_client_num, newval) {
    if (isdefined(self.owner) && self.owner == getlocalplayer(local_client_num)) {
        self duplicate_render::set_item_retrievable(local_client_num, newval);
        return;
    }
    if (isdefined(self.currentdrfilter)) {
        self duplicate_render::set_item_retrievable(local_client_num, 0);
    }
}

// Namespace weaponobjects
// Params 7, eflags: 0x0
// Checksum 0x5371e2c, Offset: 0xaf0
// Size: 0xc4
function enemyequip_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.var_c301d021)) {
        self [[ level.var_c301d021 ]](local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
        return;
    }
    newval = newval != 0;
    self util::add_remove_list(level.enemyequip, newval);
    self updateenemyequipment(local_client_num, newval);
}

// Namespace weaponobjects
// Params 2, eflags: 0x0
// Checksum 0xa1d278e4, Offset: 0xbc0
// Size: 0x17c
function updateenemyequipment(local_client_num, newval) {
    watcher = getlocalplayer(local_client_num);
    friend = self util::function_f36b8920(local_client_num, 1);
    if (!friend && isdefined(watcher) && watcher hasperk(local_client_num, "specialty_showenemyequipment")) {
        self duplicate_render::set_item_friendly_equipment(local_client_num, 0);
        self duplicate_render::set_item_enemy_equipment(local_client_num, newval);
        return;
    }
    if (friend && isdefined(watcher) && watcher duplicate_render::show_friendly_outlines(local_client_num)) {
        self duplicate_render::set_item_enemy_equipment(local_client_num, 0);
        self duplicate_render::set_item_friendly_equipment(local_client_num, newval);
        return;
    }
    self duplicate_render::set_item_enemy_equipment(local_client_num, 0);
    self duplicate_render::set_item_friendly_equipment(local_client_num, 0);
}

// Namespace weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x90f4a382, Offset: 0xd48
// Size: 0xc
function function_be7bb045(local_client_num) {
    
}

// Namespace weaponobjects
// Params 1, eflags: 0x0
// Checksum 0xaac203e7, Offset: 0xd60
// Size: 0xfc
function watch_perks_changed(local_client_num) {
    self notify(#"watch_perks_changed");
    self endon(#"watch_perks_changed");
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    while (isdefined(self)) {
        wait 0.016;
        util::clean_deleted(level.retrievable);
        util::clean_deleted(level.enemyequip);
        array::thread_all(level.retrievable, &updateretrievable, local_client_num, 1);
        array::thread_all(level.enemyequip, &updateenemyequipment, local_client_num, 1);
        self waittill(#"perks_changed");
    }
}

// Namespace weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x8ce9836, Offset: 0xe68
// Size: 0x13a
function checkteamequipment(localclientnum) {
    if (!isdefined(self.owner)) {
        return;
    }
    if (!isdefined(self.equipmentoldteam)) {
        self.equipmentoldteam = self.team;
    }
    if (!isdefined(self.equipmentoldownerteam)) {
        self.equipmentoldownerteam = self.owner.team;
    }
    watcher = getlocalplayer(localclientnum);
    if (!isdefined(self.equipmentoldwatcherteam)) {
        self.equipmentoldwatcherteam = watcher.team;
    }
    if (self.equipmentoldteam != self.team || self.equipmentoldownerteam != self.owner.team || self.equipmentoldwatcherteam != watcher.team) {
        self.equipmentoldteam = self.team;
        self.equipmentoldownerteam = self.owner.team;
        self.equipmentoldwatcherteam = watcher.team;
        self notify(#"team_changed");
    }
}

// Namespace weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x957f9b8e, Offset: 0xfb0
// Size: 0xc4
function equipmentteamobject(localclientnum) {
    if (isdefined(level.disable_equipment_team_object) && level.disable_equipment_team_object) {
        return;
    }
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    wait 0.05;
    fx_handle = self thread playflarefx(localclientnum);
    self thread equipmentwatchteamfx(localclientnum, fx_handle);
    self thread equipmentwatchplayerteamchanged(localclientnum, fx_handle);
    self thread function_be7bb045();
}

// Namespace weaponobjects
// Params 1, eflags: 0x0
// Checksum 0x56f10273, Offset: 0x1080
// Size: 0x10c
function playflarefx(localclientnum) {
    self endon(#"entityshutdown");
    level endon(#"player_switch");
    if (!isdefined(self.equipmenttagfx)) {
        self.equipmenttagfx = "tag_origin";
    }
    if (!isdefined(self.equipmentfriendfx)) {
        self.equipmenttagfx = level._effect["powerLightGreen"];
    }
    if (!isdefined(self.equipmentenemyfx)) {
        self.equipmenttagfx = level._effect["powerLight"];
    }
    if (self util::function_f36b8920(localclientnum, 1)) {
        fx_handle = playfxontag(localclientnum, self.equipmentfriendfx, self, self.equipmenttagfx);
    } else {
        fx_handle = playfxontag(localclientnum, self.equipmentenemyfx, self, self.equipmenttagfx);
    }
    return fx_handle;
}

// Namespace weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x7a90ac67, Offset: 0x1198
// Size: 0xac
function equipmentwatchteamfx(localclientnum, fxhandle) {
    msg = self util::waittill_any_return("entityshutdown", "team_changed", "player_switch");
    if (isdefined(fxhandle)) {
        stopfx(localclientnum, fxhandle);
    }
    waittillframeend();
    if (msg != "entityshutdown" && isdefined(self)) {
        self thread equipmentteamobject(localclientnum);
    }
}

// Namespace weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x772f4850, Offset: 0x1250
// Size: 0xb6
function equipmentwatchplayerteamchanged(localclientnum, fxhandle) {
    self endon(#"entityshutdown");
    self notify(#"team_changed_watcher");
    self endon(#"team_changed_watcher");
    watcherplayer = getlocalplayer(localclientnum);
    while (true) {
        level waittill(#"team_changed", clientnum);
        player = getlocalplayer(clientnum);
        if (watcherplayer == player) {
            self notify(#"team_changed");
        }
    }
}

// Namespace weaponobjects
// Params 2, eflags: 0x0
// Checksum 0x97a62f70, Offset: 0x1310
// Size: 0x94
function sndproxalert_entcleanup(localclientnum, ent) {
    level util::waittill_any("sndDEDe", "demo_jump", "player_switch", "killcam_begin", "killcam_end");
    if (isdefined(ent)) {
        ent stopallloopsounds(0.5);
        ent delete();
    }
}

