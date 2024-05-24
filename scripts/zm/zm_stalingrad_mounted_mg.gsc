#using scripts/zm/zm_stalingrad_vo;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_hero_weapon;
#using scripts/zm/_zm_audio;
#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_6d9dd78a;

// Namespace namespace_6d9dd78a
// Params 0, eflags: 0x2
// Checksum 0xa0554eaf, Offset: 0x2f0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_stalingrad_mounted_mg", &__init__, &__main__, undefined);
}

// Namespace namespace_6d9dd78a
// Params 0, eflags: 0x0
// Checksum 0xb57013cd, Offset: 0x338
// Size: 0xe8
function __init__() {
    clientfield::register("vehicle", "overheat_fx", 12000, 1, "int");
    var_a7761466 = struct::get("pavlov_mg", "targetname");
    s_unitrigger = var_a7761466 zm_unitrigger::create_unitrigger("", 64, &function_f734357f, &function_be759ad7);
    s_unitrigger.hint_parm1 = 1000;
    s_unitrigger.b_enabled = 1;
    s_unitrigger.b_in_use = 0;
}

// Namespace namespace_6d9dd78a
// Params 0, eflags: 0x0
// Checksum 0x1d39ddfe, Offset: 0x428
// Size: 0xac
function __main__() {
    level.var_ffcc580a = getent("pavlov_turret", "targetname");
    level.var_ffcc580a.turret_index = 0;
    level.var_ffcc580a turret::set_burst_parameters(0.75, 1.5, 0.25, 0.75, level.var_ffcc580a.turret_index);
}

// Namespace namespace_6d9dd78a
// Params 1, eflags: 0x0
// Checksum 0x8ad0c9ca, Offset: 0x4e0
// Size: 0x1c0
function function_f734357f(e_player) {
    if (e_player zm_hero_weapon::function_f3451c9f()) {
        self sethintstring("");
        return 0;
    }
    if (e_player.is_drinking > 0) {
        self sethintstring("");
        return 0;
    }
    if (level flag::get("lockdown_active") && level.var_1dfcc9b2.var_22bf30b7 !== 1) {
        self sethintstring("");
        return 0;
    }
    if (self.stub.b_enabled == 1 && self.stub.b_in_use == 0) {
        self sethintstring(%ZM_STALINGRAD_MOUNTED_MG_ACTIVATE, self.stub.hint_parm1);
        return 1;
    }
    if (self.stub.b_enabled == 0 && self.stub.b_in_use == 0) {
        self sethintstring(%ZM_STALINGRAD_MOUNTED_MG_COOLDOWN);
        return 0;
    }
    self sethintstring("");
    return 0;
}

// Namespace namespace_6d9dd78a
// Params 0, eflags: 0x0
// Checksum 0x6e04ec2d, Offset: 0x6a8
// Size: 0xe4
function function_be759ad7() {
    e_who = self waittill(#"trigger");
    if (!e_who zm_score::can_player_purchase(1000) && self.stub.b_enabled) {
        e_who zm_audio::create_and_play_dialog("general", "transport_deny");
        return;
    }
    if (self.stub.b_enabled && !self.stub.b_in_use) {
        e_who clientfield::increment_to_player("interact_rumble");
        e_who zm_score::minus_to_player_score(1000);
        self thread function_f8b87a4e(e_who);
    }
}

// Namespace namespace_6d9dd78a
// Params 1, eflags: 0x0
// Checksum 0xfa21b177, Offset: 0x798
// Size: 0x192
function function_f8b87a4e(e_player) {
    var_8de107a = self.stub;
    var_8de107a.b_in_use = 1;
    e_player thread namespace_dcf9c464::function_32f35525();
    self.stub thread function_8e896de5(e_player);
    level.var_ffcc580a turret::enable(0, 1);
    level.var_ffcc580a makevehicleusable();
    level.var_ffcc580a usevehicle(e_player, 0);
    level.var_ffcc580a.var_3a61625b = e_player;
    level.var_ffcc580a makevehicleunusable();
    wait(0.5);
    level.var_ffcc580a makevehicleusable();
    e_player waittill(#"exit_vehicle");
    level.var_ffcc580a makevehicleunusable();
    level.var_ffcc580a clearturrettarget();
    var_8de107a thread function_711e7f22();
    wait(1);
    var_8de107a.b_in_use = 0;
    level.var_ffcc580a.var_3a61625b = undefined;
}

// Namespace namespace_6d9dd78a
// Params 1, eflags: 0x0
// Checksum 0xce9dc375, Offset: 0x938
// Size: 0x5c
function function_8e896de5(e_player) {
    e_player endon(#"exit_vehicle");
    e_player endon(#"death");
    level.var_ffcc580a.n_start_time = gettime();
    wait(30);
    level.var_ffcc580a usevehicle(e_player, 0);
}

// Namespace namespace_6d9dd78a
// Params 0, eflags: 0x0
// Checksum 0x83e1d0ba, Offset: 0x9a0
// Size: 0xc4
function function_711e7f22() {
    self.b_enabled = 0;
    level.var_ffcc580a clientfield::set("overheat_fx", 1);
    var_55acad81 = (gettime() - level.var_ffcc580a.n_start_time) / 30000;
    if (var_55acad81 > 1) {
        var_55acad81 = 1;
    }
    n_cooldown = var_55acad81 * 15;
    wait(n_cooldown);
    self.b_enabled = 1;
    level.var_ffcc580a clientfield::set("overheat_fx", 0);
}

