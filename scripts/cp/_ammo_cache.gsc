#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/shared/trigger_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/util_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace ammo_cache;

// Namespace ammo_cache
// Method(s) 11 Total 11
class class_1e7268a3 {

    // Namespace namespace_1e7268a3
    // Params 1, eflags: 0x1 linked
    // Checksum 0x52045c14, Offset: 0x1008
    // Size: 0x6c
    function function_71f6269a(var_bd13c94b) {
        self waittill(#"death");
        self.gameobject gameobjects::destroy_object(1);
        self.gameobject delete();
        if (isdefined(var_bd13c94b)) {
            var_bd13c94b delete();
        }
    }

    // Namespace namespace_1e7268a3
    // Params 1, eflags: 0x1 linked
    // Checksum 0x13613ccb, Offset: 0xe68
    // Size: 0x194
    function function_2902ab6c(var_60a09143) {
        var_60a09143 endon(#"death");
        if (var_60a09143.var_ce22f999) {
            return;
        }
        var_60a09143.var_ce22f999 = 1;
        var_60a09143 scene::play("p7_fxanim_gp_ammo_resupply_02_open_bundle", var_60a09143);
        wait(1);
        var_d3571721 = 1;
        while (var_d3571721 > 0) {
            var_d3571721 = 0;
            foreach (e_player in level.players) {
                dist_sq = distancesquared(e_player.origin, var_60a09143.origin);
                if (dist_sq <= 14400) {
                    var_d3571721++;
                }
            }
            wait(0.5);
        }
        var_60a09143 scene::play("p7_fxanim_gp_ammo_resupply_02_close_bundle", var_60a09143);
        var_60a09143.var_ce22f999 = 0;
    }

    // Namespace namespace_1e7268a3
    // Params 1, eflags: 0x1 linked
    // Checksum 0xd085a242, Offset: 0xdd8
    // Size: 0x88
    function function_e76edd0b(var_60a09143) {
        self endon(#"death");
        var_60a09143 endon(#"death");
        while (true) {
            entity = self waittill(#"trigger");
            if (!isdefined(var_60a09143)) {
                break;
            }
            if (isplayer(entity)) {
                function_2902ab6c(var_60a09143);
            }
        }
    }

    // Namespace namespace_1e7268a3
    // Params 1, eflags: 0x1 linked
    // Checksum 0xa82182a2, Offset: 0xd90
    // Size: 0x3c
    function function_57e40211(w_weapon) {
        switch (w_weapon.name) {
        case 19:
            return true;
        }
        return false;
    }

    // Namespace namespace_1e7268a3
    // Params 1, eflags: 0x1 linked
    // Checksum 0x4982b758, Offset: 0xc08
    // Size: 0x17c
    function onuse(e_player) {
        a_w_weapons = e_player getweaponslist();
        foreach (w_weapon in a_w_weapons) {
            if (function_57e40211(w_weapon)) {
                continue;
            }
            e_player givemaxammo(w_weapon);
            e_player setweaponammoclip(w_weapon, w_weapon.clipsize);
        }
        e_player notify(#"hash_a88bbdc9");
        e_player playrumbleonentity("damage_light");
        e_player util::function_ee182f5d();
        if (self.single_use) {
            objective_clearentity(self.objectiveid);
            self gameobjects::destroy_object(1, undefined, 1);
        }
    }

    // Namespace namespace_1e7268a3
    // Params 3, eflags: 0x1 linked
    // Checksum 0x39c03398, Offset: 0xbc0
    // Size: 0x3c
    function onenduse(team, e_player, b_result) {
        if (!b_result) {
            e_player util::function_ee182f5d();
        }
    }

    // Namespace namespace_1e7268a3
    // Params 1, eflags: 0x1 linked
    // Checksum 0x276b7bc3, Offset: 0xb70
    // Size: 0x44
    function onbeginuse(e_player) {
        e_player playsound("fly_ammo_crate_refill");
        e_player util::function_f9e9f0f0();
    }

    // Namespace namespace_1e7268a3
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb92ecb5b, Offset: 0xb08
    // Size: 0x5c
    function function_82b8e134(origin, angles) {
        var_62a5879d = util::spawn_model("p6_ammo_resupply_future_01", origin, angles, 1);
        function_35dd0243(var_62a5879d);
    }

    // Namespace namespace_1e7268a3
    // Params 1, eflags: 0x1 linked
    // Checksum 0x1ee86ce1, Offset: 0x5b8
    // Size: 0x544
    function function_35dd0243(var_455957d8) {
        t_use = spawn("trigger_radius_use", var_455957d8.origin + (0, 0, 30), 0, 94, 64);
        t_use triggerignoreteam();
        t_use setvisibletoall();
        t_use usetriggerrequirelookat();
        t_use setteamfortrigger("none");
        t_use setcursorhint("HINT_INTERACTIVE_PROMPT");
        t_use sethintstring(%COOP_REFILL_AMMO);
        if (isdefined(var_455957d8.script_linkto)) {
            moving_platform = getent(var_455957d8.script_linkto, "targetname");
            var_455957d8 linkto(moving_platform);
        }
        t_use enablelinkto();
        t_use linkto(var_455957d8);
        var_455957d8 oed::function_e228c18a(1);
        if (var_455957d8.script_string === "single_use") {
            var_988e928 = gameobjects::create_use_object("any", t_use, array(var_455957d8), (0, 0, 32), %cp_ammo_box);
        } else {
            var_988e928 = gameobjects::create_use_object("any", t_use, array(var_455957d8), (0, 0, 32), %cp_ammo_crate);
        }
        var_988e928 gameobjects::allow_use("any");
        var_988e928 gameobjects::set_use_text(%COOP_AMMO_REFILL);
        var_988e928 gameobjects::set_owner_team("allies");
        var_988e928 gameobjects::set_visible_team("any");
        var_988e928.onuse = &onuse;
        var_988e928.useweapon = undefined;
        var_988e928.origin = var_455957d8.origin;
        var_988e928.angles = var_988e928.angles;
        if (var_455957d8.script_string === "single_use") {
            var_988e928 gameobjects::set_use_time(0.75);
            var_988e928.onbeginuse = &onbeginuse;
            var_988e928.onenduse = &onenduse;
            var_988e928.single_use = 1;
        } else {
            var_988e928 gameobjects::set_use_time(0.75);
            var_988e928.onbeginuse = &onbeginuse;
            var_988e928.onenduse = &onenduse;
            var_988e928.single_use = 0;
            var_455957d8.gameobject = var_988e928;
            self.var_60a09143 = var_455957d8;
            self.var_60a09143.var_ce22f999 = 0;
            var_bd13c94b = spawn("trigger_radius", t_use.origin, 0, 94, 64);
            var_bd13c94b setvisibletoall();
            var_bd13c94b setteamfortrigger("allies");
            var_bd13c94b enablelinkto();
            var_bd13c94b linkto(var_455957d8);
            var_bd13c94b thread function_e76edd0b(self.var_60a09143);
        }
        var_455957d8.gameobject = var_988e928;
        var_455957d8 thread function_71f6269a(var_bd13c94b);
    }

}

// Namespace ammo_cache
// Params 0, eflags: 0x2
// Checksum 0x33878d37, Offset: 0x330
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("cp_supply_manager", &__init__, &__main__, undefined);
}

// Namespace ammo_cache
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x378
// Size: 0x4
function __init__() {
    
}

// Namespace ammo_cache
// Params 0, eflags: 0x1 linked
// Checksum 0x647b572c, Offset: 0x388
// Size: 0x204
function __main__() {
    wait(0.05);
    if (isdefined(level.var_7ba8d184)) {
        level thread [[ level.var_7ba8d184 ]]();
        return;
    }
    level.var_bd9a76fb = 31;
    var_8e327af8 = getentarray("ammo_cache", "script_noteworthy");
    foreach (var_455957d8 in var_8e327af8) {
        ammo_cache = new class_1e7268a3();
        [[ ammo_cache ]]->function_35dd0243(var_455957d8);
    }
    var_6c2e87ca = struct::get_array("ammo_cache", "script_noteworthy");
    foreach (var_cd9300aa in var_6c2e87ca) {
        ammo_cache = new class_1e7268a3();
        [[ ammo_cache ]]->function_82b8e134(var_cd9300aa.origin, var_cd9300aa.angles);
    }
    setdvar("AmmoBoxPickupTime", 0.75);
}

// Namespace ammo_cache
// Params 1, eflags: 0x0
// Checksum 0x1c1e7f56, Offset: 0x12c0
// Size: 0x2c
function hide_waypoint(e_player) {
    self.gameobject gameobjects::hide_waypoint(e_player);
}

// Namespace ammo_cache
// Params 1, eflags: 0x0
// Checksum 0xbef11540, Offset: 0x12f8
// Size: 0x2c
function show_waypoint(e_player) {
    self.gameobject gameobjects::show_waypoint(e_player);
}

