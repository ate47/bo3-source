#using scripts/mp/_util;
#using scripts/mp/gametypes/tdm;
#using scripts/mp/gametypes/_weapons;
#using scripts/mp/gametypes/_wager;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/gametypes/_globallogic_spawn;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_player;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_dogtags;
#using scripts/mp/gametypes/_deathicons;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/loadout_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/abilities/_ability_util;

#namespace namespace_66b6bfda;

// Namespace namespace_66b6bfda
// Params 0, eflags: 0x0
// namespace_66b6bfda<file_0>::function_d290ebfa
// Checksum 0x596e36f7, Offset: 0x508
// Size: 0xcc
function main() {
    tdm::main();
    gameobjects::register_allowed_gameobject("tdm");
    level.leaderdialog = undefined;
    level.var_cbfbddb2 = getweapon("sniper_powerbolt", "extclip", "swayreduc");
    level.onstartgametype = &onstartgametype;
    level.onplayerkilled = &onplayerkilled;
    level.givecustomloadout = &givecustomloadout;
    callback::on_connect(&on_player_connect);
}

// Namespace namespace_66b6bfda
// Params 0, eflags: 0x0
// namespace_66b6bfda<file_0>::function_34685338
// Checksum 0x6974d434, Offset: 0x5e0
// Size: 0x2c
function onstartgametype() {
    tdm::onstartgametype();
    level function_c12878ec();
}

// Namespace namespace_66b6bfda
// Params 0, eflags: 0x0
// namespace_66b6bfda<file_0>::function_fb4f96b5
// Checksum 0xac5ae67b, Offset: 0x618
// Size: 0x1c
function on_player_connect() {
    self thread function_ef6a5017();
}

// Namespace namespace_66b6bfda
// Params 0, eflags: 0x0
// namespace_66b6bfda<file_0>::function_ed44e709
// Checksum 0x279c349e, Offset: 0x640
// Size: 0x358
function givecustomloadout() {
    loadout::function_79d05183(1);
    loadout::function_1d84af77(self.curclass);
    loadout::giveperks();
    primaryweapon = self getloadoutweapon(self.class_num, "primary");
    weaponclass = util::getweaponclass(primaryweapon);
    var_d5801c8a = 1;
    if (!isdefined(primaryweapon) || primaryweapon == level.weaponnone || primaryweapon == level.weaponnull || !isdefined(weaponclass) || weaponclass != "weapon_sniper") {
        primaryweapon = level.var_cbfbddb2;
        var_d5801c8a = 0;
    }
    self function_b41dbb1d(primaryweapon, var_d5801c8a);
    sidearm = self getloadoutweapon(self.class_num, "secondary");
    weaponclass = util::getweaponclass(sidearm);
    if (isdefined(sidearm) && sidearm != level.weaponnone && sidearm != level.weaponnull && isdefined(weaponclass) && weaponclass == "weapon_sniper") {
        self function_f0582641(sidearm);
    }
    primaryoffhand = getweapon("null_offhand_primary");
    primaryoffhandcount = 0;
    self giveweapon(primaryoffhand);
    self setweaponammostock(primaryoffhand, primaryoffhandcount);
    self switchtooffhand(primaryoffhand);
    self.grenadetypeprimary = primaryoffhand;
    self.grenadetypeprimarycount = primaryoffhandcount;
    secondaryoffhand = getweapon("null_offhand_secondary");
    secondaryoffhandcount = 0;
    self giveweapon(secondaryoffhand);
    self setweaponammoclip(secondaryoffhand, secondaryoffhandcount);
    self switchtooffhand(secondaryoffhand);
    self.grenadetypesecondary = secondaryoffhand;
    self.grenadetypesecondarycount = secondaryoffhandcount;
    self function_e6707d5e();
    loadout::function_4ddd42ba();
    self allowmelee(0);
    return primaryweapon;
}

// Namespace namespace_66b6bfda
// Params 0, eflags: 0x0
// namespace_66b6bfda<file_0>::function_e6707d5e
// Checksum 0xfaf8dcec, Offset: 0x9a0
// Size: 0x2ac
function function_e6707d5e() {
    self.var_66cb8722 = undefined;
    loadout::function_e193f5c5();
    if (!isdefined(self.var_66cb8722)) {
        bodyindex = self getcharacterbodytype();
        var_3eeea260 = "none";
        switch (bodyindex) {
        case 0:
            var_3eeea260 = "gadget_speed_burst";
            break;
        case 1:
            var_3eeea260 = "gadget_vision_pulse";
            break;
        case 2:
            var_3eeea260 = "gadget_flashback";
            break;
        case 3:
            var_3eeea260 = "gadget_armor";
            break;
        case 4:
            var_3eeea260 = "gadget_combat_efficiency";
            break;
        case 5:
            var_3eeea260 = "gadget_resurrect";
            break;
        case 6:
            var_3eeea260 = "gadget_clone";
            break;
        case 7:
            var_3eeea260 = "gadget_camo";
            break;
        case 8:
            var_3eeea260 = "gadget_heat_wave";
            break;
        case 9:
            var_3eeea260 = "gadget_roulette";
            break;
        default:
            break;
        }
        if (var_3eeea260 != "none") {
            changedclass = self.pers["changed_class"];
            roundbased = !util::isoneround();
            firstround = util::isfirstround();
            specialoffhand = getweapon(var_3eeea260);
            specialoffhandcount = specialoffhand.startammo;
            self giveweapon(specialoffhand);
            self setweaponammoclip(specialoffhand, specialoffhandcount);
            self switchtooffhand(specialoffhand);
            self.var_66cb8722 = specialoffhand;
            self.var_877b90bf = specialoffhandcount;
            self ability_util::gadget_reset(specialoffhand, changedclass, roundbased, firstround);
        }
    }
}

// Namespace namespace_66b6bfda
// Params 2, eflags: 0x0
// namespace_66b6bfda<file_0>::function_b41dbb1d
// Checksum 0x6c1fd34b, Offset: 0xc58
// Size: 0x1d8
function function_b41dbb1d(primaryweapon, var_d5801c8a) {
    if (var_d5801c8a) {
        primaryweaponoptions = self calcweaponoptions(self.class_num, 0);
        var_65ce895e = self getattachmentcosmeticvariantforweapon(self.class_num, "primary");
        self giveweapon(primaryweapon, primaryweaponoptions, var_65ce895e);
    } else {
        self giveweapon(primaryweapon);
    }
    self.primaryloadoutweapon = primaryweapon;
    self.var_367ea154 = primaryweapon.altweapon;
    if (var_d5801c8a) {
        self.primaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex(self.class_num, 0);
    }
    if (self hasperk("specialty_extraammo")) {
        self givemaxammo(primaryweapon);
    }
    self thread loadout::initweaponattachments(primaryweapon);
    self.pers["changed_class"] = 0;
    self.spawnweapon = primaryweapon;
    self.pers["spawnWeapon"] = self.spawnweapon;
    switchimmediate = isdefined(self.alreadysetspawnweapononce);
    self setspawnweapon(primaryweapon, switchimmediate);
    self.alreadysetspawnweapononce = 1;
}

// Namespace namespace_66b6bfda
// Params 1, eflags: 0x0
// namespace_66b6bfda<file_0>::function_f0582641
// Checksum 0x6eb5bf46, Offset: 0xe38
// Size: 0x114
function function_f0582641(sidearm) {
    secondaryweaponoptions = self calcweaponoptions(self.class_num, 1);
    var_65ce895e = self getattachmentcosmeticvariantforweapon(self.class_num, "secondary");
    self giveweapon(sidearm, secondaryweaponoptions, var_65ce895e);
    self.secondaryloadoutweapon = sidearm;
    self.var_f8a642e8 = sidearm.altweapon;
    self.secondaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex(self.class_num, 1);
    if (self hasperk("specialty_extraammo")) {
        self givemaxammo(sidearm);
    }
}

// Namespace namespace_66b6bfda
// Params 9, eflags: 0x0
// namespace_66b6bfda<file_0>::function_c2658b46
// Checksum 0x9ae37041, Offset: 0xf58
// Size: 0x2ac
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    victim = self;
    if (isdefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
        should_spawn_tags = self dogtags::should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
        should_spawn_tags = should_spawn_tags && !globallogic_spawn::mayspawn();
        if (should_spawn_tags) {
            level thread dogtags::spawn_dog_tag(self, attacker, &dogtags::onusedogtag, 0);
        }
    }
    if (!isdefined(attacker)) {
        return;
    }
    wassuicide = attacker == self || !isplayer(attacker);
    if (wassuicide) {
        return;
    }
    if (isdefined(attacker) && isdefined(victim) && isdefined(attacker.origin) && isdefined(victim.origin)) {
        var_ee0d98ff = distance(attacker.origin, victim.origin) * 0.0254;
        killrange = int(max(var_ee0d98ff, 1));
        attacker thread function_2d46be95(killrange);
    }
    attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
    self globallogic_score::giveteamscoreforobjective(self.team, level.teamscoreperdeath * -1);
    if (smeansofdeath == "MOD_HEAD_SHOT") {
        attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperheadshot);
    }
}

// Namespace namespace_66b6bfda
// Params 0, eflags: 0x0
// namespace_66b6bfda<file_0>::function_357ca474
// Checksum 0xbf2f7274, Offset: 0x1210
// Size: 0x88
function function_357ca474() {
    level endon(#"game_ended");
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"hash_dce9eda4");
    self endon(#"hash_dce9eda4");
    self.var_ea382ca4.alpha = 1;
    self.var_ea382ca4 fadeovertime(3);
    self.var_ea382ca4.alpha = 0;
}

// Namespace namespace_66b6bfda
// Params 1, eflags: 0x0
// namespace_66b6bfda<file_0>::function_2d46be95
// Checksum 0x5e951db9, Offset: 0x12a0
// Size: 0x254
function function_2d46be95(killrange) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    var_e7d83b48 = killrange;
    if (killrange >= -106) {
        self.var_ea382ca4.color = (0, 1, 0);
    } else {
        var_e7d83b48 = 0.01 * (100 - 0.67 * var_e7d83b48);
        self.var_ea382ca4.color = (var_e7d83b48, 1, var_e7d83b48);
    }
    self.var_ea382ca4 setvalue(killrange);
    if (!isdefined(self.var_bcc9bee4) || self.var_bcc9bee4 < killrange) {
        self.var_bcc9bee4 = killrange;
        self.var_f9eb945c.color = (var_e7d83b48, 1, var_e7d83b48);
        self.var_f9eb945c setvalue(self.var_bcc9bee4);
        self.var_f9eb945c.alpha = 1;
        if (killrange >= -106) {
            self.var_f9eb945c.color = (0, 1, 0);
            self.var_f9eb945c.glowalpha = 0.5;
        }
        if (!isdefined(level.var_db316bcf) || level.var_db316bcf < killrange) {
            level.var_db316bcf = killrange;
            level.var_a670a293.color = (var_e7d83b48, 1, var_e7d83b48);
            level.var_a670a293 setvalue(level.var_db316bcf);
            level.var_a670a293.alpha = 1;
            if (killrange >= -106) {
                level.var_a670a293.color = (0, 1, 0);
                level.var_a670a293.glowalpha = 0.5;
            }
        }
    }
    self thread function_357ca474();
}

// Namespace namespace_66b6bfda
// Params 0, eflags: 0x0
// namespace_66b6bfda<file_0>::function_b5214454
// Checksum 0xb1984705, Offset: 0x1500
// Size: 0x50
function function_b5214454() {
    self endon(#"disconnect");
    while (true) {
        level waittill(#"game_ended");
        self.var_ea382ca4.alpha = 0;
        self.var_f9eb945c.alpha = 0;
    }
}

// Namespace namespace_66b6bfda
// Params 0, eflags: 0x0
// namespace_66b6bfda<file_0>::function_ef6a5017
// Checksum 0x8cbdc41d, Offset: 0x1558
// Size: 0x284
function function_ef6a5017() {
    self endon(#"disconnect");
    self.var_ea382ca4 = hud::createfontstring("objective", 1);
    self.var_ea382ca4.label = %MP_RANGE_KILL_INDICATOR;
    self.var_ea382ca4 setvalue(0);
    self.var_ea382ca4.x = 0;
    self.var_ea382ca4.y = 20;
    self.var_ea382ca4.alignx = "center";
    self.var_ea382ca4.aligny = "middle";
    self.var_ea382ca4.horzalign = "user_center";
    self.var_ea382ca4.vertalign = "middle";
    self.var_ea382ca4.archived = 1;
    self.var_ea382ca4.fontscale = 1;
    self.var_ea382ca4.alpha = 0;
    self.var_ea382ca4.glowalpha = 0.5;
    self.var_ea382ca4.hidewheninmenu = 0;
    self.var_f9eb945c = hud::createfontstring("objective", 1);
    self.var_f9eb945c.x = -6;
    self.var_f9eb945c.y = 2;
    self.var_f9eb945c.alignx = "right";
    self.var_f9eb945c.aligny = "top";
    self.var_f9eb945c.horzalign = "user_right";
    self.var_f9eb945c.vertalign = "user_top";
    self.var_f9eb945c.label = %MP_MAX_KILL_INDICATOR;
    self.var_f9eb945c setvalue(0);
    self.var_f9eb945c.alpha = 0;
    self.var_f9eb945c.archived = 0;
    self.var_f9eb945c.hidewheninmenu = 1;
    self thread function_b5214454();
}

// Namespace namespace_66b6bfda
// Params 0, eflags: 0x0
// namespace_66b6bfda<file_0>::function_c12878ec
// Checksum 0xf6930d8, Offset: 0x17e8
// Size: 0x120
function function_c12878ec() {
    level.var_a670a293 = hud::createserverfontstring("objective", 1);
    level.var_a670a293.x = -6;
    level.var_a670a293.y = 14;
    level.var_a670a293.alignx = "right";
    level.var_a670a293.aligny = "top";
    level.var_a670a293.horzalign = "user_right";
    level.var_a670a293.vertalign = "user_top";
    level.var_a670a293.label = %MP_MAX_MATCH_INDICATOR;
    level.var_a670a293 setvalue(0);
    level.var_a670a293.alpha = 0;
    level.var_a670a293.archived = 0;
    level.var_a670a293.hidewheninmenu = 1;
}

