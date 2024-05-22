#using scripts/cp/_skipto;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/_util;
#using scripts/cp/_bb;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_loadout;
#using scripts/shared/clientfield_shared;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/trigger_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/util_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace mobile_armory;

// Namespace mobile_armory
// Method(s) 13 Total 13
class class_b4b9e1e4 {

    // Namespace namespace_b4b9e1e4
    // Params 1, eflags: 0x1 linked
    // Checksum 0x41601d6a, Offset: 0x1c48
    // Size: 0xcc
    function function_71f6269a(var_bd13c94b) {
        self waittill(#"death");
        self.gameobject gameobjects::destroy_object(1);
        self.gameobject delete();
        if (isdefined(self.target)) {
            var_5ba2ceb4 = getent(self.target, "targetname");
            if (isdefined(var_5ba2ceb4)) {
                var_5ba2ceb4 delete();
            }
        }
        if (isdefined(var_bd13c94b)) {
            var_bd13c94b delete();
        }
    }

    // Namespace namespace_b4b9e1e4
    // Params 1, eflags: 0x1 linked
    // Checksum 0x6f2cd033, Offset: 0x19b8
    // Size: 0x284
    function function_69cca2a0(var_ab455203) {
        if (var_ab455203.var_ce22f999) {
            return;
        }
        var_ab455203.var_ce22f999 = 1;
        var_ab455203 showpart("tag_weapons_01_jnt");
        var_ab455203 showpart("tag_weapons_02_jnt");
        var_ab455203 showpart("tag_weapons_03_jnt");
        var_ab455203 showpart("tag_weapons_04_jnt");
        var_ab455203 scene::play("p7_fxanim_gp_mobile_armory_open_bundle", var_ab455203);
        wait(1);
        var_d3571721 = 1;
        while (var_d3571721 > 0) {
            var_d3571721 = 0;
            foreach (e_player in level.players) {
                dist_sq = distancesquared(e_player.origin, var_ab455203.origin);
                if (dist_sq <= 15400) {
                    var_d3571721++;
                }
            }
            wait(0.5);
        }
        var_ab455203 scene::play("p7_fxanim_gp_mobile_armory_close_bundle", var_ab455203);
        var_ab455203 hidepart("tag_weapons_01_jnt");
        var_ab455203 hidepart("tag_weapons_02_jnt");
        var_ab455203 hidepart("tag_weapons_03_jnt");
        var_ab455203 hidepart("tag_weapons_04_jnt");
        var_ab455203.var_ce22f999 = 0;
    }

    // Namespace namespace_b4b9e1e4
    // Params 1, eflags: 0x1 linked
    // Checksum 0x958274b8, Offset: 0x1928
    // Size: 0x88
    function function_e76edd0b(var_ab455203) {
        self endon(#"death");
        var_ab455203 endon(#"death");
        while (true) {
            entity = self waittill(#"trigger");
            if (!isdefined(var_ab455203)) {
                break;
            }
            if (isplayer(entity)) {
                function_69cca2a0(var_ab455203);
            }
        }
    }

    // Namespace namespace_b4b9e1e4
    // Params 1, eflags: 0x1 linked
    // Checksum 0xa5ac5582, Offset: 0x17a8
    // Size: 0x174
    function function_6b1fa4df(weapon) {
        clipammo = self getweaponammoclip(weapon);
        stockammo = self getweaponammostock(weapon);
        stockmax = weapon.maxammo;
        if (stockammo > stockmax) {
            stockammo = stockmax;
        }
        item = self dropitem(weapon, "tag_origin");
        if (!isdefined(item)) {
            /#
                iprintlnbold("HINT_INTERACTIVE_PROMPT" + weapon.name + "HINT_INTERACTIVE_PROMPT");
            #/
            return;
        }
        level weapons::drop_limited_weapon(weapon, self, item);
        item itemweaponsetammo(clipammo, stockammo);
        item.owner = self;
        item thread weapons::watch_pickup();
        item thread weapons::delete_pickup_after_awhile();
    }

    // Namespace namespace_b4b9e1e4
    // Params 1, eflags: 0x1 linked
    // Checksum 0x90b7fa8a, Offset: 0x1730
    // Size: 0x6e
    function function_afd39ac7(e_player) {
        self.var_ab455203.gameobject.var_6f180198 = &function_66708329;
        self.var_ab455203.gameobject.var_3df2554f = e_player;
        wait(0.25);
        self.var_ab455203.gameobject.var_6f180198 = undefined;
    }

    // Namespace namespace_b4b9e1e4
    // Params 1, eflags: 0x1 linked
    // Checksum 0x9adeb507, Offset: 0x1700
    // Size: 0x24
    function function_66708329(e_player) {
        if (self.var_3df2554f === e_player) {
            return false;
        }
        return true;
    }

    // Namespace namespace_b4b9e1e4
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2b3eaf8d, Offset: 0xd60
    // Size: 0x994
    function function_ecdbdfeb(e_player) {
        e_player endon(#"death");
        e_player endon(#"entering_last_stand");
        e_player flagsys::clear("mobile_armory_begin_use");
        var_9cba4a73 = 1;
        if (isdefined(self.var_ab455203.script_int)) {
            var_9cba4a73 = 3;
            var_9cba4a73 += self.var_ab455203.script_int - 6 << 2;
        }
        e_player clientfield::set_to_player("mobile_armory_cac", var_9cba4a73);
        e_player flagsys::set("mobile_armory_in_use");
        var_eb5bcea7 = e_player getloadoutitemref(0, "cybercore");
        str_menu, response = e_player waittill(#"menuresponse");
        a_weaponlist = e_player getweaponslist();
        var_5b2a650 = e_player getloadoutweapon(e_player.class_num, "primary");
        var_95cf88cc = e_player getloadoutweapon(e_player.class_num, "secondary");
        var_961f11b8 = [];
        foreach (weapon in a_weaponlist) {
            if (isdefined(weapon.isheroweapon) && weapon.isheroweapon) {
                if (!isdefined(var_961f11b8)) {
                    var_961f11b8 = [];
                } else if (!isarray(var_961f11b8)) {
                    var_961f11b8 = array(var_961f11b8);
                }
                var_961f11b8[var_961f11b8.size] = weapon;
                continue;
            }
            if (weapon != var_5b2a650 && (weapon.inventorytype == "primary" || e_player function_76f34311("cybercom_copycat") && weapon.inventorytype == "secondary") && weapon != var_95cf88cc) {
                /#
                    iprintln("HINT_INTERACTIVE_PROMPT");
                #/
                if (response != "cancel") {
                    e_player function_6b1fa4df(weapon);
                }
            }
        }
        if (str_menu == "ChooseClass_InGame") {
            var_d3a640a8 = e_player getloadoutitemref(0, "cybercore");
            var_63a103f4 = var_d3a640a8 == var_eb5bcea7 || e_player cybercom::function_6e0bf068();
            e_player savegame::set_player_data("lives", undefined);
            if (response == "cancel") {
                e_player loadout::function_db96b564(!(isdefined(var_63a103f4) && var_63a103f4));
            } else {
                var_5dc22ce3 = strtok(response, ",");
                if (var_5dc22ce3.size > 1) {
                    var_bd5d3f48 = var_5dc22ce3[0];
                    clientnum = int(var_5dc22ce3[1]);
                    var_5a13c491 = util::getplayerfromclientnum(clientnum);
                } else {
                    var_bd5d3f48 = response;
                }
                playerclass = e_player loadout::getclasschoice(var_bd5d3f48);
                e_player savegame::set_player_data("playerClass", playerclass);
                if (isdefined(var_5a13c491)) {
                    xuid = var_5a13c491 getxuid();
                    e_player savegame::set_player_data("altPlayerID", xuid);
                } else {
                    e_player savegame::set_player_data("altPlayerID", undefined);
                }
                e_player savegame::set_player_data("saved_weapon", undefined);
                e_player savegame::set_player_data("saved_weapondata", undefined);
                e_player savegame::set_player_data("saved_rig1", undefined);
                e_player savegame::set_player_data("saved_rig1_upgraded", undefined);
                e_player savegame::set_player_data("saved_rig2", undefined);
                e_player savegame::set_player_data("saved_rig2_upgraded", undefined);
                e_player loadout::setclass(playerclass);
                e_player.tag_stowed_back = undefined;
                e_player.tag_stowed_hip = undefined;
                e_player loadout::giveloadout(e_player.pers["team"], playerclass, !(isdefined(var_63a103f4) && var_63a103f4), var_5a13c491);
            }
        }
        foreach (weapon in var_961f11b8) {
            e_player giveweapon(weapon);
        }
        a_weapons = e_player getweaponslist();
        foreach (weapon in a_weapons) {
            e_player givemaxammo(weapon);
            e_player setweaponammoclip(weapon, weapon.clipsize);
        }
        if (e_player flagsys::get("cancel_mobile_armory")) {
            e_player flagsys::clear("cancel_mobile_armory");
            e_player util::function_ee182f5d();
        } else {
            self thread function_afd39ac7(e_player);
            e_player hideviewmodel();
            e_player disableweapons(1);
            wait(0.5);
            e_player showviewmodel();
            e_player util::function_ee182f5d();
        }
        e_player clientfield::set_to_player("mobile_armory_cac", 0);
        bb::function_945c54c5("mobile_armory_used", e_player);
        e_player matchrecordincrementcheckpointstat(skipto::function_52c50cb8(), "mobileArmoryUsedCount");
        waittillframeend();
        e_player flagsys::clear("mobile_armory_in_use");
    }

    // Namespace namespace_b4b9e1e4
    // Params 1, eflags: 0x1 linked
    // Checksum 0xd34dbd72, Offset: 0xd30
    // Size: 0x24
    function onuse(e_player) {
        self thread function_ecdbdfeb(e_player);
    }

    // Namespace namespace_b4b9e1e4
    // Params 3, eflags: 0x1 linked
    // Checksum 0x5c5f10d9, Offset: 0xce8
    // Size: 0x3c
    function onenduse(team, e_player, b_result) {
        if (!b_result) {
            e_player util::function_ee182f5d();
        }
    }

    // Namespace namespace_b4b9e1e4
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7389b2e6, Offset: 0xc78
    // Size: 0x64
    function onbeginuse(e_player) {
        e_player playsound("fly_ammo_crate_refill");
        e_player util::function_f9e9f0f0();
        e_player flagsys::set("mobile_armory_begin_use");
    }

    // Namespace namespace_b4b9e1e4
    // Params 1, eflags: 0x1 linked
    // Checksum 0x50923ccc, Offset: 0x768
    // Size: 0x504
    function function_c3b04569(var_96eb5b14) {
        t_use = spawn("trigger_radius_use", var_96eb5b14.origin + (0, 0, 24), 0, 94, 64);
        t_use triggerignoreteam();
        t_use setvisibletoall();
        t_use usetriggerrequirelookat();
        t_use setteamfortrigger("none");
        t_use setcursorhint("HINT_INTERACTIVE_PROMPT");
        t_use sethintstring(%COOP_SELECT_LOADOUT);
        if (isdefined(var_96eb5b14.script_linkto)) {
            moving_platform = getent(var_96eb5b14.script_linkto, "targetname");
            var_96eb5b14 linkto(moving_platform);
            t_use enablelinkto();
            t_use linkto(moving_platform);
        }
        var_96eb5b14 oed::function_e228c18a(1);
        var_96eb5b14 hidepart("tag_weapons_01_jnt");
        var_96eb5b14 hidepart("tag_weapons_02_jnt");
        var_96eb5b14 hidepart("tag_weapons_03_jnt");
        var_96eb5b14 hidepart("tag_weapons_04_jnt");
        var_96e62168 = gameobjects::create_use_object("any", t_use, array(var_96eb5b14), (0, 0, 68), %cp_mobile_armory);
        var_96e62168 gameobjects::allow_use("any");
        var_96e62168 gameobjects::set_use_time(0.35);
        var_96e62168 gameobjects::set_use_text(%COOP_SELECT_LOADOUT);
        var_96e62168 gameobjects::set_owner_team("allies");
        var_96e62168 gameobjects::set_visible_team("any");
        var_96e62168.onuse = &onuse;
        var_96e62168.onbeginuse = &onbeginuse;
        var_96e62168.onenduse = &onenduse;
        var_96e62168.onuse_thread = 1;
        var_96e62168.useweapon = undefined;
        var_96e62168.single_use = 0;
        var_96e62168.classobj = self;
        var_96e62168.origin = var_96eb5b14.origin;
        var_96e62168.angles = var_96e62168.angles;
        if (!isdefined(var_96eb5b14.script_linkto)) {
            var_96e62168 enablelinkto();
            var_96e62168 linkto(t_use);
        }
        var_96eb5b14.gameobject = var_96e62168;
        self.var_ab455203 = var_96eb5b14;
        self.var_ab455203.var_ce22f999 = 0;
        var_bd13c94b = spawn("trigger_radius", t_use.origin, 0, 94, 64);
        var_bd13c94b setvisibletoall();
        var_bd13c94b setteamfortrigger("allies");
        var_bd13c94b thread function_e76edd0b(self.var_ab455203);
        self.var_ab455203 thread function_71f6269a(var_bd13c94b);
    }

}

// Namespace mobile_armory
// Params 0, eflags: 0x2
// Checksum 0x6a74fb30, Offset: 0x5a0
// Size: 0x3c
function function_2dc19561() {
    system::register("cp_mobile_armory", &__init__, &__main__, undefined);
}

// Namespace mobile_armory
// Params 0, eflags: 0x1 linked
// Checksum 0x811c6aa6, Offset: 0x5e8
// Size: 0x34
function __init__() {
    clientfield::register("toplayer", "mobile_armory_cac", 1, 4, "int");
}

// Namespace mobile_armory
// Params 0, eflags: 0x1 linked
// Checksum 0x97db59a0, Offset: 0x628
// Size: 0x112
function __main__() {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    } else if (isdefined(level.var_40b3237f)) {
        [[ level.var_40b3237f ]]();
    }
    wait(0.05);
    var_9f34c934 = getentarray("mobile_armory", "script_noteworthy");
    foreach (var_96eb5b14 in var_9f34c934) {
        mobile_armory = new class_b4b9e1e4();
        [[ mobile_armory ]]->function_c3b04569(var_96eb5b14);
    }
}

