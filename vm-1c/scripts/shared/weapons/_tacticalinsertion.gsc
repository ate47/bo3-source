#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/weapons/_hacker_tool;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace tacticalinsertion;

// Namespace tacticalinsertion
// Params 0, eflags: 0x1 linked
// Checksum 0x4bf2b742, Offset: 0x448
// Size: 0xcc
function init_shared() {
    if (level.gametype == "infect") {
        level.weapontacticalinsertion = getweapon("trophy_system");
    } else {
        level.weapontacticalinsertion = getweapon("tactical_insertion");
    }
    level._effect["tacticalInsertionFizzle"] = "_t6/misc/fx_equip_tac_insert_exp";
    clientfield::register("scriptmover", "tacticalinsertion", 1, 1, "int");
    callback::on_spawned(&on_player_spawned);
}

// Namespace tacticalinsertion
// Params 0, eflags: 0x1 linked
// Checksum 0x5fbb91d4, Offset: 0x520
// Size: 0x1c
function on_player_spawned() {
    self thread begin_other_grenade_tracking();
}

// Namespace tacticalinsertion
// Params 2, eflags: 0x1 linked
// Checksum 0xddb00f46, Offset: 0x548
// Size: 0xe8
function istacspawntouchingcrates(origin, angles) {
    crate_ents = getentarray("care_package", "script_noteworthy");
    mins = (-17, -17, -40);
    maxs = (17, 17, 40);
    for (i = 0; i < crate_ents.size; i++) {
        if (crate_ents[i] istouchingvolume(origin + (0, 0, 40), mins, maxs)) {
            return true;
        }
    }
    return false;
}

// Namespace tacticalinsertion
// Params 1, eflags: 0x1 linked
// Checksum 0xc01ebab1, Offset: 0x638
// Size: 0x148
function overridespawn(ispredictedspawn) {
    if (!isdefined(self.tacticalinsertion)) {
        return false;
    }
    origin = self.tacticalinsertion.origin;
    angles = self.tacticalinsertion.angles;
    team = self.tacticalinsertion.team;
    if (!ispredictedspawn) {
        self.tacticalinsertion destroy_tactical_insertion();
    }
    if (team != self.team) {
        return false;
    }
    if (istacspawntouchingcrates(origin)) {
        return false;
    }
    if (!ispredictedspawn) {
        self.tacticalinsertiontime = gettime();
        self spawn(origin, angles, "tactical insertion");
        self setspawnclientflag("SCDFL_DISABLE_LOGGING");
        self addweaponstat(level.weapontacticalinsertion, "used", 1);
    }
    return true;
}

// Namespace tacticalinsertion
// Params 1, eflags: 0x1 linked
// Checksum 0xca239d62, Offset: 0x788
// Size: 0x34
function waitanddelete(time) {
    self endon(#"death");
    wait(0.05);
    self delete();
}

// Namespace tacticalinsertion
// Params 1, eflags: 0x1 linked
// Checksum 0xfa400b03, Offset: 0x7c8
// Size: 0x74
function watch(player) {
    if (isdefined(player.tacticalinsertion)) {
        player.tacticalinsertion destroy_tactical_insertion();
    }
    player thread spawntacticalinsertion();
    self waitanddelete(0.05);
}

// Namespace tacticalinsertion
// Params 4, eflags: 0x1 linked
// Checksum 0xbeb5c2a8, Offset: 0x848
// Size: 0x1d2
function watchusetrigger(trigger, callback, playersoundonuse, npcsoundonuse) {
    self endon(#"delete");
    while (true) {
        player = trigger waittill(#"trigger");
        if (!isalive(player)) {
            continue;
        }
        if (!player isonground()) {
            continue;
        }
        if (isdefined(trigger.triggerteam) && player.team != trigger.triggerteam) {
            continue;
        }
        if (isdefined(trigger.triggerteamignore) && player.team == trigger.triggerteamignore) {
            continue;
        }
        if (isdefined(trigger.claimedby) && player != trigger.claimedby) {
            continue;
        }
        if (player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed()) {
            if (isdefined(playersoundonuse)) {
                player playlocalsound(playersoundonuse);
            }
            if (isdefined(npcsoundonuse)) {
                player playsound(npcsoundonuse);
            }
            self thread [[ callback ]](player);
        }
    }
}

// Namespace tacticalinsertion
// Params 0, eflags: 0x1 linked
// Checksum 0xcf66d2b6, Offset: 0xa28
// Size: 0x3c
function watchdisconnect() {
    self.tacticalinsertion endon(#"delete");
    self waittill(#"disconnect");
    self.tacticalinsertion thread destroy_tactical_insertion();
}

// Namespace tacticalinsertion
// Params 1, eflags: 0x1 linked
// Checksum 0xdf66aef9, Offset: 0xa70
// Size: 0x1e4
function destroy_tactical_insertion(attacker) {
    self.owner.tacticalinsertion = undefined;
    self notify(#"delete");
    self.owner notify(#"tactical_insertion_destroyed");
    self.friendlytrigger delete();
    self.enemytrigger delete();
    if (isdefined(attacker) && isdefined(attacker.pers["team"]) && isdefined(self.owner) && isdefined(self.owner.pers["team"])) {
        if (level.teambased) {
            if (attacker.pers["team"] != self.owner.pers["team"]) {
                attacker notify(#"destroyed_explosive");
                attacker challenges::destroyedequipment();
                attacker challenges::destroyedtacticalinsert();
                scoreevents::processscoreevent("destroyed_tac_insert", attacker);
            }
        } else if (attacker != self.owner) {
            attacker notify(#"destroyed_explosive");
            attacker challenges::destroyedequipment();
            attacker challenges::destroyedtacticalinsert();
            scoreevents::processscoreevent("destroyed_tac_insert", attacker);
        }
    }
    self delete();
}

// Namespace tacticalinsertion
// Params 1, eflags: 0x1 linked
// Checksum 0xf1a555fd, Offset: 0xc60
// Size: 0xe4
function fizzle(attacker) {
    if (isdefined(self.fizzle) && self.fizzle) {
        return;
    }
    self.fizzle = 1;
    playfx(level._effect["tacticalInsertionFizzle"], self.origin);
    self playsound("dst_tac_insert_break");
    if (isdefined(attacker) && attacker != self.owner) {
        if (isdefined(level.globallogic_audio_dialog_on_player_override)) {
            self.owner [[ level.globallogic_audio_dialog_on_player_override ]]("tact_destroyed", "item_destroyed");
        }
    }
    self destroy_tactical_insertion(attacker);
}

// Namespace tacticalinsertion
// Params 1, eflags: 0x1 linked
// Checksum 0x4e58df5b, Offset: 0xd50
// Size: 0x74
function pickup(attacker) {
    player = self.owner;
    self destroy_tactical_insertion();
    player giveweapon(level.weapontacticalinsertion);
    player setweaponammoclip(level.weapontacticalinsertion, 1);
}

// Namespace tacticalinsertion
// Params 0, eflags: 0x1 linked
// Checksum 0x27334525, Offset: 0xdd0
// Size: 0x8d0
function spawntacticalinsertion() {
    self endon(#"disconnect");
    trace = bullettrace(self.origin, self.origin + (0, 0, -30), 0, self);
    trace["position"] = trace["position"] + (0, 0, 1);
    if (!self isonground() && bullettracepassed(self.origin, self.origin + (0, 0, -30), 0, self)) {
        self giveweapon(level.weapontacticalinsertion);
        self setweaponammoclip(level.weapontacticalinsertion, 1);
        return;
    }
    self.tacticalinsertion = spawn("script_model", trace["position"]);
    self.tacticalinsertion setmodel("wpn_t7_trophy_system");
    self.tacticalinsertion.origin = self.origin + (0, 0, 1);
    self.tacticalinsertion.angles = self.angles;
    self.tacticalinsertion.team = self.team;
    self.tacticalinsertion setteam(self.team);
    self.tacticalinsertion.owner = self;
    self.tacticalinsertion setowner(self);
    self.tacticalinsertion setweapon(level.weapontacticalinsertion);
    self.tacticalinsertion endon(#"delete");
    self.tacticalinsertion hacker_tool::registerwithhackertool(level.equipmenthackertoolradius, level.equipmenthackertooltimems);
    triggerheight = 64;
    triggerradius = -128;
    self.tacticalinsertion.friendlytrigger = spawn("trigger_radius_use", self.tacticalinsertion.origin + (0, 0, 3));
    self.tacticalinsertion.friendlytrigger setcursorhint("HINT_NOICON", self.tacticalinsertion);
    self.tacticalinsertion.friendlytrigger sethintstring(%MP_TACTICAL_INSERTION_PICKUP);
    if (level.teambased) {
        self.tacticalinsertion.friendlytrigger setteamfortrigger(self.team);
        self.tacticalinsertion.friendlytrigger.triggerteam = self.team;
    }
    self clientclaimtrigger(self.tacticalinsertion.friendlytrigger);
    self.tacticalinsertion.friendlytrigger.claimedby = self;
    self.tacticalinsertion.enemytrigger = spawn("trigger_radius_use", self.tacticalinsertion.origin + (0, 0, 3));
    self.tacticalinsertion.enemytrigger setcursorhint("HINT_NOICON", self.tacticalinsertion);
    self.tacticalinsertion.enemytrigger sethintstring(%MP_TACTICAL_INSERTION_DESTROY);
    self.tacticalinsertion.enemytrigger setinvisibletoplayer(self);
    if (level.teambased) {
        self.tacticalinsertion.enemytrigger setexcludeteamfortrigger(self.team);
        self.tacticalinsertion.enemytrigger.triggerteamignore = self.team;
    }
    self.tacticalinsertion clientfield::set("tacticalinsertion", 1);
    self thread watchdisconnect();
    watcher = weaponobjects::getweaponobjectwatcherbyweapon(level.weapontacticalinsertion);
    self.tacticalinsertion thread watchusetrigger(self.tacticalinsertion.friendlytrigger, &pickup, watcher.pickupsoundplayer, watcher.pickupsound);
    self.tacticalinsertion thread watchusetrigger(self.tacticalinsertion.enemytrigger, &fizzle);
    if (isdefined(self.tacticalinsertioncount)) {
        self.tacticalinsertioncount++;
    } else {
        self.tacticalinsertioncount = 1;
    }
    self.tacticalinsertion setcandamage(1);
    self.tacticalinsertion.health = 1;
    while (true) {
        damage, attacker, direction, point, type, tagname, modelname, partname, weapon, idflags = self.tacticalinsertion waittill(#"damage");
        if ((!isdefined(attacker) || !isplayer(attacker) || level.teambased && attacker.team == self.team) && attacker != self) {
            continue;
        }
        if (attacker != self) {
            attacker challenges::destroyedequipment(weapon);
            attacker challenges::destroyedtacticalinsert();
            scoreevents::processscoreevent("destroyed_tac_insert", attacker);
        }
        if (watcher.stuntime > 0 && weapon.dostun) {
            self thread weaponobjects::stunstart(watcher, watcher.stuntime);
        }
        if (weapon.dodamagefeedback) {
            if (level.teambased && self.tacticalinsertion.owner.team != attacker.team) {
                if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                    attacker damagefeedback::update();
                }
            } else if (!level.teambased && self.tacticalinsertion.owner != attacker) {
                if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                    attacker damagefeedback::update();
                }
            }
        }
        if (isdefined(attacker) && attacker != self) {
            if (isdefined(level.globallogic_audio_dialog_on_player_override)) {
                self [[ level.globallogic_audio_dialog_on_player_override ]]("tact_destroyed", "item_destroyed");
            }
        }
        self.tacticalinsertion thread fizzle();
    }
}

// Namespace tacticalinsertion
// Params 0, eflags: 0x1 linked
// Checksum 0x6ba4f317, Offset: 0x16a8
// Size: 0xe4
function cancel_button_think() {
    if (!isdefined(self.tacticalinsertion)) {
        return;
    }
    text = cancel_text_create();
    self thread cancel_button_press();
    event = self util::waittill_any_return("tactical_insertion_destroyed", "disconnect", "end_killcam", "abort_killcam", "tactical_insertion_canceled", "spawned");
    if (event == "tactical_insertion_canceled") {
        self.tacticalinsertion destroy_tactical_insertion();
    }
    if (isdefined(text)) {
        text destroy();
    }
}

// Namespace tacticalinsertion
// Params 0, eflags: 0x1 linked
// Checksum 0x27f4f62b, Offset: 0x1798
// Size: 0x3c
function canceltackinsertionbutton() {
    if (level.console) {
        return self changeseatbuttonpressed();
    }
    return self jumpbuttonpressed();
}

// Namespace tacticalinsertion
// Params 0, eflags: 0x1 linked
// Checksum 0x60c973e8, Offset: 0x17e0
// Size: 0x62
function cancel_button_press() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    self endon(#"abort_killcam");
    while (true) {
        wait(0.05);
        if (self canceltackinsertionbutton()) {
            break;
        }
    }
    self notify(#"tactical_insertion_canceled");
}

// Namespace tacticalinsertion
// Params 0, eflags: 0x1 linked
// Checksum 0x672bac1a, Offset: 0x1850
// Size: 0x17c
function cancel_text_create() {
    text = newclienthudelem(self);
    text.archived = 0;
    text.y = -100;
    text.alignx = "center";
    text.aligny = "middle";
    text.horzalign = "center";
    text.vertalign = "bottom";
    text.sort = 10;
    text.font = "small";
    text.foreground = 1;
    text.hidewheninmenu = 1;
    if (self issplitscreen()) {
        text.y = -80;
        text.fontscale = 1.2;
    } else {
        text.fontscale = 1.6;
    }
    text settext(%PLATFORM_PRESS_TO_CANCEL_TACTICAL_INSERTION);
    text.alpha = 1;
    return text;
}

// Namespace tacticalinsertion
// Params 0, eflags: 0x0
// Checksum 0x8faae533, Offset: 0x19d8
// Size: 0xb6
function gettacticalinsertions() {
    tac_inserts = [];
    foreach (player in level.players) {
        if (isdefined(player.tacticalinsertion)) {
            tac_inserts[tac_inserts.size] = player.tacticalinsertion;
        }
    }
    return tac_inserts;
}

// Namespace tacticalinsertion
// Params 2, eflags: 0x1 linked
// Checksum 0x21fbc319, Offset: 0x1a98
// Size: 0xe0
function tacticalinsertiondestroyedbytrophysystem(attacker, trophysystem) {
    owner = self.owner;
    if (isdefined(attacker)) {
        attacker challenges::destroyedequipment(trophysystem.name);
        attacker challenges::destroyedtacticalinsert();
    }
    self thread fizzle();
    if (isdefined(owner)) {
        owner endon(#"death");
        owner endon(#"disconnect");
        wait(0.05);
        if (isdefined(level.globallogic_audio_dialog_on_player_override)) {
            owner [[ level.globallogic_audio_dialog_on_player_override ]]("tact_destroyed", "item_destroyed");
        }
    }
}

// Namespace tacticalinsertion
// Params 0, eflags: 0x1 linked
// Checksum 0xb6d0258c, Offset: 0x1b80
// Size: 0xe0
function begin_other_grenade_tracking() {
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"hash_35275331");
    self endon(#"hash_35275331");
    for (;;) {
        grenade, weapon, cooktime = self waittill(#"grenade_fire");
        if (grenade util::ishacked()) {
            continue;
        }
        if (weapon == level.weapontacticalinsertion) {
            if (level.gametype == "infect" && self.team == game["defenders"]) {
                return;
            }
            grenade thread watch(self);
        }
    }
}

