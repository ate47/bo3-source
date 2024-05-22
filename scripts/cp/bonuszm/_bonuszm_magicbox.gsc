#using scripts/cp/bonuszm/_bonuszm_weapons;
#using scripts/cp/bonuszm/_bonuszm_spawner_shared;
#using scripts/cp/bonuszm/_bonuszm_data;
#using scripts/cp/bonuszm/_bonuszm_dev;
#using scripts/cp/_util;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_loadout;
#using scripts/shared/weapons_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/util_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_293e8aad;

// Namespace namespace_293e8aad
// Method(s) 12 Total 12
class class_dafbfd8e {

    // Namespace namespace_dafbfd8e
    // Params 0, eflags: 0x1 linked
    // Checksum 0x199d3232, Offset: 0xa30
    // Size: 0x10
    function constructor() {
        self.var_2bcbe272 = 0;
    }

    // Namespace namespace_dafbfd8e
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd4bdfc92, Offset: 0x1888
    // Size: 0xd8
    function function_b449e467() {
        self.var_b8eeb0fe.weapon_model clientfield::set("weapon_disappear_fx", 1);
        util::wait_network_frame();
        self.var_b8eeb0fe.weapon_model delete();
        wait(1);
        self.var_b8eeb0fe setzbarrierpiecestate(2, "closing");
        while (self.var_b8eeb0fe getzbarrierpiecestate(2) == "closing") {
            wait(0.1);
        }
        self.var_b8eeb0fe notify(#"closed");
    }

    // Namespace namespace_dafbfd8e
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe41281e5, Offset: 0x1670
    // Size: 0x20c
    function function_cf5042c5() {
        self.var_b8eeb0fe setzbarrierpiecestate(2, "opening");
        while (self.var_b8eeb0fe getzbarrierpiecestate(2) != "open") {
            wait(0.1);
        }
        self.var_b8eeb0fe setzbarrierpiecestate(3, "closed");
        self.var_b8eeb0fe setzbarrierpiecestate(4, "closed");
        util::wait_network_frame();
        self.var_b8eeb0fe zbarrierpieceuseboxriselogic(3);
        self.var_b8eeb0fe zbarrierpieceuseboxriselogic(4);
        self.var_b8eeb0fe showzbarrierpiece(3);
        self.var_b8eeb0fe showzbarrierpiece(4);
        self.var_b8eeb0fe setzbarrierpiecestate(3, "opening");
        self.var_b8eeb0fe setzbarrierpiecestate(4, "opening");
        while (self.var_b8eeb0fe getzbarrierpiecestate(3) != "open") {
            wait(0.5);
        }
        self.var_b8eeb0fe hidezbarrierpiece(3);
        self.var_b8eeb0fe hidezbarrierpiece(4);
    }

    // Namespace namespace_dafbfd8e
    // Params 0, eflags: 0x1 linked
    // Checksum 0x502c7259, Offset: 0x1638
    // Size: 0x2c
    function function_f555c05b() {
        weaponinfo = namespace_fdfaa57d::function_1e2e0936(1);
        return weaponinfo;
    }

    // Namespace namespace_dafbfd8e
    // Params 1, eflags: 0x1 linked
    // Checksum 0x982e330e, Offset: 0x1390
    // Size: 0x2a0
    function function_c3e9e1ab(e_player) {
        weapon = level.weaponnone;
        modelname = undefined;
        rand = undefined;
        var_5b9e73d8 = 40;
        self thread function_cf5042c5();
        for (i = 0; i < var_5b9e73d8; i++) {
            if (i < 20) {
                wait(0.05);
                continue;
            }
            if (i < 30) {
                wait(0.1);
                continue;
            }
            if (i < 35) {
                wait(0.2);
                continue;
            }
            if (i < 38) {
                wait(0.3);
            }
        }
        wait(1);
        self.var_b8eeb0fe.weaponinfo = function_f555c05b();
        v_float = anglestoup(self.var_b8eeb0fe.angles) * 40;
        self.var_b8eeb0fe.weapon_model = spawn("script_model", self.var_b8eeb0fe.origin + v_float, 0);
        self.var_b8eeb0fe.weapon_model.angles = (self.var_b8eeb0fe.angles[0] * -1, self.var_b8eeb0fe.angles[1] + -76, self.var_b8eeb0fe.angles[2] * -1);
        self.var_b8eeb0fe.weapon_model useweaponmodel(self.var_b8eeb0fe.weaponinfo[0], self.var_b8eeb0fe.weaponinfo[0].worldmodel);
        self.var_b8eeb0fe.weapon_model setweaponrenderoptions(self.var_b8eeb0fe.weaponinfo[2], 0, 0, 0, 0);
        self.var_b8eeb0fe notify(#"randomization_done");
    }

    // Namespace namespace_dafbfd8e
    // Params 3, eflags: 0x1 linked
    // Checksum 0x75edb728, Offset: 0x1300
    // Size: 0x84
    function function_7429abd1(var_7983c848, weaponinfo, e_player) {
        /#
            assert(isdefined(weaponinfo));
        #/
        e_player namespace_fdfaa57d::function_43128d49(weaponinfo, 0);
        var_7983c848 notify(#"hash_1285c563");
        e_player unlink();
    }

    // Namespace namespace_dafbfd8e
    // Params 1, eflags: 0x1 linked
    // Checksum 0x37fbce72, Offset: 0xf80
    // Size: 0x378
    function function_83bb9b69(e_player) {
        if (self.var_2bcbe272) {
            return;
        }
        self.mdl_magicbox.gameobject gameobjects::disable_object(1);
        self.var_2bcbe272 = 1;
        self.var_b8eeb0fe clientfield::set("magicbox_closed_glow", 0);
        self.var_b8eeb0fe clientfield::set("magicbox_open_glow", 1);
        weaponinfo = function_c3e9e1ab(e_player);
        var_7983c848 = spawn("trigger_radius_use", self.mdl_magicbox.origin + (0, 0, 3), 0, 94, 64);
        var_7983c848 triggerignoreteam();
        var_7983c848 setvisibletoall();
        var_7983c848 usetriggerrequirelookat();
        var_7983c848 setteamfortrigger("none");
        var_7983c848 setcursorhint("HINT_INTERACTIVE_PROMPT");
        var_7983c848 sethintstring(%COOP_MAGICBOX_SWAP_WEAPON);
        self.var_b8eeb0fe.var_7983c848 = var_7983c848;
        var_aafa484e = util::function_14518e76(var_7983c848, %cp_magic_box, %COOP_MAGICBOX_SWAP_WEAPON, &onuse);
        var_aafa484e.dontlinkplayertotrigger = 1;
        var_aafa484e.classobj = self;
        var_aafa484e enablelinkto();
        var_aafa484e linkto(var_7983c848);
        e_player unlink();
        var_7983c848 util::waittill_any_timeout(6, "player_took_weapon");
        var_7983c848 notify(#"hash_49d64e9");
        var_aafa484e gameobjects::destroy_object(1, 1);
        self thread function_b449e467();
        var_aafa484e delete();
        self.var_b8eeb0fe waittill(#"closed");
        self.var_b8eeb0fe clientfield::set("magicbox_closed_glow", 1);
        self.var_b8eeb0fe clientfield::set("magicbox_open_glow", 0);
        self.mdl_magicbox.gameobject gameobjects::enable_object(1);
        self.var_2bcbe272 = 0;
    }

    // Namespace namespace_dafbfd8e
    // Params 1, eflags: 0x1 linked
    // Checksum 0xa9df236c, Offset: 0xf68
    // Size: 0xc
    function onbeginuse(e_player) {
        
    }

    // Namespace namespace_dafbfd8e
    // Params 1, eflags: 0x1 linked
    // Checksum 0xeed7f6d2, Offset: 0xef0
    // Size: 0x6c
    function onuse(e_player) {
        if (!self.var_2bcbe272) {
            self thread function_83bb9b69(e_player);
            return;
        }
        e_player thread function_7429abd1(self.var_b8eeb0fe.var_7983c848, self.var_b8eeb0fe.weaponinfo, e_player);
    }

    // Namespace namespace_dafbfd8e
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa68deb28, Offset: 0xe68
    // Size: 0x7c
    function function_b471f57b() {
        if (!self.var_2bcbe272) {
            self.mdl_magicbox.gameobject gameobjects::destroy_object(1, 1);
            self.var_b8eeb0fe clientfield::set("magicbox_closed_glow", 0);
            util::wait_network_frame();
            self.var_b8eeb0fe hide();
        }
    }

    // Namespace namespace_dafbfd8e
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8bc511e3, Offset: 0xa58
    // Size: 0x404
    function function_309dd42b(var_96eb5b14) {
        e_trigger = spawn("trigger_radius_use", var_96eb5b14.origin + (0, 0, 3), 0, 94, 64);
        e_trigger triggerignoreteam();
        e_trigger setvisibletoall();
        e_trigger usetriggerrequirelookat();
        e_trigger setteamfortrigger("none");
        e_trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
        e_trigger sethintstring(%COOP_MAGICBOX);
        var_9fd18135 = getentarray("bonuszm_magicbox", "script_noteworthy");
        self.var_b8eeb0fe = arraygetclosest(e_trigger.origin, var_9fd18135);
        self.var_b8eeb0fe.origin = var_96eb5b14.origin;
        self.var_b8eeb0fe.angles = var_96eb5b14.angles + (0, -90, 0);
        self.var_b8eeb0fe hidezbarrierpiece(1);
        if (isdefined(var_96eb5b14.script_linkto)) {
            moving_platform = getent(var_96eb5b14.script_linkto, "targetname");
            var_96eb5b14 linkto(moving_platform);
            self.var_b8eeb0fe linkto(moving_platform);
            e_trigger enablelinkto();
            e_trigger linkto(moving_platform);
        }
        var_96e62168 = util::function_14518e76(e_trigger, %cp_magic_box, %COOP_OPEN, &onuse);
        var_96e62168.dontlinkplayertotrigger = 1;
        var_96e62168.classobj = self;
        if (!isdefined(var_96eb5b14.script_linkto)) {
            var_96e62168 enablelinkto();
            var_96e62168 linkto(e_trigger);
        }
        var_96eb5b14.gameobject = var_96e62168;
        self.var_b8eeb0fe.gameobject = var_96e62168;
        self.mdl_magicbox = var_96eb5b14;
        self.var_7c66997c = e_trigger;
        self.var_b8eeb0fe hidezbarrierpiece(0);
        self.var_b8eeb0fe clientfield::set("magicbox_closed_glow", 1);
        self.var_b8eeb0fe clientfield::set("magicbox_open_glow", 0);
        self.var_b8eeb0fe playloopsound("zmb_box_zcamp_loop");
        self.mdl_magicbox ghost();
        self.mdl_magicbox notsolid();
    }

}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x2
// Checksum 0xca80034, Offset: 0x4c0
// Size: 0x3c
function function_2dc19561() {
    system::register("cp_mobile_magicbox", &__init__, &__main__, undefined);
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0xaba8e5c8, Offset: 0x508
// Size: 0xec
function __init__() {
    level.var_40b3237f = &function_999eb742;
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    level.var_b2ea822f = &function_89a0f2a6;
    level.var_380bc8b7 = &function_76eab3e;
    clientfield::register("zbarrier", "magicbox_open_glow", 1, 1, "int");
    clientfield::register("zbarrier", "magicbox_closed_glow", 1, 1, "int");
    clientfield::register("scriptmover", "weapon_disappear_fx", 1, 1, "int");
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0xe339b3e7, Offset: 0x600
// Size: 0x302
function __main__() {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    wait(0.05);
    var_7422b1d5 = getentarray("mobile_armory_clip", "script_noteworthy");
    foreach (clip in var_7422b1d5) {
        clip delete();
    }
    mapname = getdvarstring("mapname");
    var_9f34c934 = getentarray("mobile_armory", "script_noteworthy");
    foreach (var_96eb5b14 in var_9f34c934) {
        if (mapname == "cp_mi_cairo_lotus") {
            if (distancesquared(var_96eb5b14.origin, (-7469, 1031, 4029)) < 22500) {
                var_9ff80c52 = 1;
            }
        }
        if (isdefined(var_9ff80c52) && var_9ff80c52) {
            var_40d9775d = getentarray("bonuszm_magicbox", "script_noteworthy");
            var_381b4609 = array::get_all_closest(var_96eb5b14.origin, var_40d9775d, array(var_96eb5b14), 1, 100);
            if (isdefined(var_381b4609) && isarray(var_381b4609) && var_381b4609.size) {
                var_381b4609[0] delete();
            }
            var_96eb5b14 show();
            continue;
        }
        var_96eb5b14 thread function_2816573(var_96eb5b14);
    }
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// Checksum 0xabf81680, Offset: 0x910
// Size: 0x54
function function_2816573(var_96eb5b14) {
    var_6982c48a = new class_dafbfd8e();
    [[ var_6982c48a ]]->function_309dd42b(var_96eb5b14);
    var_96eb5b14.var_b10011b8 = var_6982c48a;
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0x2b34b239, Offset: 0x970
// Size: 0xb2
function function_999eb742() {
    var_40d9775d = getentarray("bonuszm_magicbox", "script_noteworthy");
    foreach (magicbox in var_40d9775d) {
        magicbox delete();
    }
}

// Namespace namespace_293e8aad
// Params 0, eflags: 0x1 linked
// Checksum 0xab63d8b8, Offset: 0x1bd8
// Size: 0x122
function function_89a0f2a6() {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    var_7e526b74 = getentarray("bonuszm_magicbox", "script_noteworthy");
    foreach (magicbox in var_7e526b74) {
        magicbox.gameobject gameobjects::destroy_object(1, 1);
        magicbox clientfield::set("magicbox_closed_glow", 0);
        util::wait_network_frame();
        magicbox hide();
    }
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// Checksum 0x26114334, Offset: 0x1d08
// Size: 0x7c
function function_76eab3e(magicbox) {
    if (magicbox.script_noteworthy === "bonuszm_magicbox") {
        if (isdefined(magicbox.gameobject)) {
            magicbox.gameobject gameobjects::destroy_object(1, 1);
        }
        magicbox thread function_73ea8d16(magicbox);
    }
}

// Namespace namespace_293e8aad
// Params 1, eflags: 0x1 linked
// Checksum 0x301860b3, Offset: 0x1d90
// Size: 0x5c
function function_73ea8d16(magicbox) {
    magicbox endon(#"death");
    magicbox clientfield::set("magicbox_closed_glow", 0);
    util::wait_network_frame();
    magicbox delete();
}

