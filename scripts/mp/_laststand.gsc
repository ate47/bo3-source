#using scripts/mp/gametypes/_killcam;
#using scripts/mp/gametypes/_globallogic_spawn;
#using scripts/mp/gametypes/_globallogic_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/gadgets/_gadget_resurrect;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/killcam_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace laststand;

// Namespace laststand
// Params 0, eflags: 0x2
// Checksum 0x18dc050f, Offset: 0x340
// Size: 0x34
function function_2dc19561() {
    system::register("laststand", &__init__, undefined, undefined);
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x3a638fa7, Offset: 0x380
// Size: 0x1a
function __init__() {
    if (level.script == "frontend") {
        return;
    }
}

// Namespace laststand
// Params 9, eflags: 0x1 linked
// Checksum 0x39e574e1, Offset: 0x3a8
// Size: 0x12c
function player_last_stand_stats(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (isdefined(attacker) && isplayer(attacker) && attacker != self) {
        attacker.kills++;
        if (isdefined(weapon)) {
            var_a362aff = weapon;
            weaponpickedup = 0;
            if (isdefined(attacker.pickedupweapons) && isdefined(attacker.pickedupweapons[weapon])) {
                weaponpickedup = 1;
            }
            attacker addweaponstat(var_a362aff, "kills", 1, attacker.class_num, weaponpickedup);
        }
    }
    self.downs++;
}

// Namespace laststand
// Params 9, eflags: 0x1 linked
// Checksum 0xd2e67588, Offset: 0x4e0
// Size: 0x39c
function playerlaststand(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride) {
    if (self player_is_in_laststand()) {
        return;
    }
    if (isdefined(self.resurrect_not_allowed_by)) {
        return;
    }
    self globallogic_player::callback_playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, 0, 1);
    self notify(#"entering_last_stand");
    if (isdefined(level.var_c7048fc8)) {
        self [[ level.var_c7048fc8 ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride);
    }
    self.laststandparams = spawnstruct();
    self.laststandparams.einflictor = einflictor;
    self.laststandparams.attacker = attacker;
    self.laststandparams.idamage = idamage;
    self.laststandparams.smeansofdeath = smeansofdeath;
    self.laststandparams.sweapon = weapon;
    self.laststandparams.vdir = vdir;
    self.laststandparams.shitloc = shitloc;
    self.laststandparams.laststandstarttime = gettime();
    self.laststandparams.killcam_entity_info_cached = killcam::get_killcam_entity_info(attacker, einflictor, weapon);
    self thread player_last_stand_stats(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride);
    self.health = 1;
    self.laststand = 1;
    self.ignoreme = 1;
    self enableinvulnerability();
    self.meleeattackers = undefined;
    self.no_revive_trigger = 1;
    callback::callback(#"hash_6751ab5b");
    /#
        assert(isdefined(self.resurrect_weapon));
    #/
    /#
        assert(self.resurrect_weapon != level.weaponnone);
    #/
    slot = self ability_util::gadget_slot_for_type(40);
    self gadgetstatechange(slot, self.resurrect_weapon, 2);
    self laststand_disable_player_weapons();
    self thread function_1ca09cb();
    self thread resurrect::function_f3f47570();
    self thread function_d9e34d07();
    demo::bookmark("player_downed", gettime(), self);
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xa574874b, Offset: 0x888
// Size: 0x98
function function_1ca09cb() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"bleed_out");
    self endon(#"player_input_revive");
    self endon(#"hash_cbdf5176");
    level endon(#"game_ended");
    while (true) {
        if (self getcurrentweapon() != self.resurrect_weapon) {
            self switchtoweapon(self.resurrect_weapon);
        }
        wait(0.05);
    }
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x972b67c, Offset: 0x928
// Size: 0xc4
function laststand_disable_player_weapons() {
    weaponinventory = self getweaponslist(1);
    self.lastactiveweapon = self getcurrentweapon();
    if (self isthrowinggrenade()) {
        primaryweapons = self getweaponslistprimaries();
        if (isdefined(primaryweapons) && primaryweapons.size > 0) {
            self.lastactiveweapon = primaryweapons[0];
            self switchtoweaponimmediate(self.lastactiveweapon);
        }
    }
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xd6da5a9b, Offset: 0x9f8
// Size: 0x10c
function laststand_enable_player_weapons(var_24621d3b) {
    if (!isdefined(var_24621d3b)) {
        var_24621d3b = 1;
    }
    self enableweaponcycling();
    if (var_24621d3b) {
        self enableoffhandweapons();
    }
    if (isdefined(self.lastactiveweapon) && self.lastactiveweapon != level.weaponnone && self hasweapon(self.lastactiveweapon)) {
        self switchtoweapon(self.lastactiveweapon);
        return;
    }
    primaryweapons = self getweaponslistprimaries();
    if (isdefined(primaryweapons) && primaryweapons.size > 0) {
        self switchtoweapon(primaryweapons[0]);
    }
}

// Namespace laststand
// Params 2, eflags: 0x0
// Checksum 0x3df4a57f, Offset: 0xb10
// Size: 0xec
function laststand_clean_up_on_interrupt(playerbeingrevived, var_3012e872) {
    self endon(#"do_revive_ended_normally");
    revivetrigger = playerbeingrevived.revivetrigger;
    playerbeingrevived util::waittill_any("disconnect", "game_ended", "death");
    if (isdefined(revivetrigger)) {
        revivetrigger delete();
    }
    self function_4a66f284();
    if (isdefined(self.var_30d551a2)) {
        self.var_30d551a2 hud::destroyelem();
    }
    if (isdefined(self.var_fca62492)) {
        self.var_fca62492 destroy();
    }
}

// Namespace laststand
// Params 1, eflags: 0x0
// Checksum 0xd5d2893c, Offset: 0xc08
// Size: 0x68
function laststand_clean_up_reviving_any(playerbeingrevived) {
    self endon(#"do_revive_ended_normally");
    playerbeingrevived util::waittill_any("disconnect", "zombified", "stop_revive_trigger");
    self.is_reviving_any--;
    if (0 > self.is_reviving_any) {
        self.is_reviving_any = 0;
    }
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x844f6248, Offset: 0xc78
// Size: 0xac
function bleed_out() {
    demo::bookmark("player_bledout", gettime(), self, undefined, 1);
    level notify(#"bleed_out", self.characterindex);
    self undolaststand();
    self.ignoreme = 0;
    self.laststand = undefined;
    self.uselaststandparams = 1;
    if (!isdefined(self.laststandparams.attacker)) {
        self.laststandparams.attacker = self;
    }
    self suicide();
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x236c6a4b, Offset: 0xd30
// Size: 0x34
function function_d9e34d07() {
    self thread function_16999f69();
    self thread function_e2823d0a();
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xed4fe6f, Offset: 0xd70
// Size: 0xb6
function function_16999f69() {
    level endon(#"game_ended");
    self endon(#"hash_b4264f33");
    self endon(#"disconnect");
    self endon(#"death");
    self waittill(#"player_input_revive");
    demo::bookmark("player_revived", gettime(), self, self);
    self rejack();
    self laststand_enable_player_weapons();
    self.ignoreme = 0;
    self disableinvulnerability();
    self.laststand = undefined;
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x18b5e0de, Offset: 0xe30
// Size: 0x54
function function_e2823d0a() {
    level endon(#"game_ended");
    self endon(#"player_input_revive");
    self endon(#"disconnect");
    self endon(#"death");
    self waittill(#"hash_cbdf5176");
    self bleed_out();
}

