#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/system_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace cic_turret;

// Namespace cic_turret
// Params 0, eflags: 0x2
// Checksum 0xd265561e, Offset: 0x500
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("cic_turret", &__init__, undefined, undefined);
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x9a536174, Offset: 0x538
// Size: 0x19b
function __init__() {
    vehicle::add_main_callback("turret_cic", &function_4bf69f84);
    vehicle::add_main_callback("turret_cic_world", &function_4bf69f84);
    vehicle::add_main_callback("turret_sentry", &function_4bf69f84);
    vehicle::add_main_callback("turret_sentry_world", &function_4bf69f84);
    vehicle::add_main_callback("turret_sentry_cic", &function_4bf69f84);
    vehicle::add_main_callback("turret_sentry_rts", &function_4bf69f84);
    level._effect["cic_turret_damage01"] = "destruct/fx_dest_turret_1";
    level._effect["cic_turret_damage02"] = "destruct/fx_dest_turret_2";
    level._effect["sentry_turret_damage01"] = "destruct/fx_dest_turret_1";
    level._effect["sentry_turret_damage02"] = "destruct/fx_dest_turret_2";
    level._effect["cic_turret_death"] = "_t6/destructibles/fx_cic_turret_death";
    level._effect["cic_turret_stun"] = "_t6/electrical/fx_elec_sp_emp_stun_cic_turret";
    level._effect["sentry_turret_stun"] = "_t6/electrical/fx_elec_sp_emp_stun_sentry_turret";
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x780b7945, Offset: 0x6e0
// Size: 0x59
function function_4bf69f84() {
    // Can't decompile export cic_turret::function_4bf69f84 Unknown operator 0xe2
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0xd08eeb55, Offset: 0x960
// Size: 0x22
function function_64047fb9() {
    self.state_machine statemachine::set_state("scripted");
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x5e21e13b, Offset: 0x990
// Size: 0x22
function function_73a1f565() {
    self.state_machine statemachine::set_state("main");
}

// Namespace cic_turret
// Params 1, eflags: 0x0
// Checksum 0x73c99e3, Offset: 0x9c0
// Size: 0x3a
function function_6bf457cb(params) {
    // Can't decompile export cic_turret::function_6bf457cb Unknown operator 0x66
}

// Namespace cic_turret
// Params 1, eflags: 0x0
// Checksum 0x40f825a, Offset: 0xa08
// Size: 0x53
function function_31d70ab3(angles) {
    // Can't decompile export cic_turret::function_31d70ab3 Unknown operator 0x76
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0xa397e31f, Offset: 0xb18
// Size: 0x43
function function_d20b689f() {
    // Can't decompile export cic_turret::function_d20b689f Unknown operator 0xe2
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0xff0df41a, Offset: 0xbc8
// Size: 0x1a
function function_4ebb4502() {
    // Can't decompile export cic_turret::function_4ebb4502 Unknown operator 0x76
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x3b0c479f, Offset: 0xca0
// Size: 0x3b
function function_8929bfc3() {
    // Can't decompile export cic_turret::function_8929bfc3 Unknown operator 0x76
}

// Namespace cic_turret
// Params 1, eflags: 0x0
// Checksum 0x631d733b, Offset: 0x1048
// Size: 0x13
function function_2fae15b2(params) {
    // Can't decompile export cic_turret::function_2fae15b2 Unknown operator 0x76
}

// Namespace cic_turret
// Params 1, eflags: 0x0
// Checksum 0xf4f2c60e, Offset: 0x10f0
// Size: 0x2a
function function_b149aa04(health_pct) {
    // Can't decompile export cic_turret::function_b149aa04 Unknown operator 0x62
}

// Namespace cic_turret
// Params 2, eflags: 0x0
// Checksum 0xbc3273b, Offset: 0x1190
// Size: 0x21
function function_197cacdf(effect, tag) {
    // Can't decompile export cic_turret::function_197cacdf Unknown operator 0x18
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x5e2049ca, Offset: 0x12e8
// Size: 0x1c
function function_6c405c27() {
    // Can't decompile export cic_turret::function_6c405c27 Unknown operator 0x18
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x263e8b26, Offset: 0x1370
// Size: 0x2a
function function_c9084cfa() {
    // Can't decompile export cic_turret::function_c9084cfa Unknown operator 0x98
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x6206c1a7, Offset: 0x1528
// Size: 0x55
function death_fx() {
    // Can't decompile export cic_turret::death_fx Unknown operator 0x98
}

// Namespace cic_turret
// Params 2, eflags: 0x0
// Checksum 0x5e1a96c7, Offset: 0x15c0
// Size: 0x4a
function function_969be05e(attacker, hitdir) {
    // Can't decompile export cic_turret::function_969be05e Unknown operator 0x98
}

// Namespace cic_turret
// Params 1, eflags: 0x0
// Checksum 0x45efa700, Offset: 0x1698
// Size: 0x5a
function function_20d6503c(totalfiretime) {
    // Can't decompile export cic_turret::function_20d6503c Unknown operator 0x98
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0xcf8449e0, Offset: 0x1840
// Size: 0x1a
function function_c9760e52() {
    self playsound("veh_turret_alert");
}

// Namespace cic_turret
// Params 1, eflags: 0x0
// Checksum 0x59e1a81b, Offset: 0x1868
// Size: 0xa
function function_44158b0(team) {
    // Can't decompile export cic_turret::function_44158b0 Unknown operator 0x5d
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0xb31db029, Offset: 0x18a0
// Size: 0x1a
function function_38baa992() {
    // Can't decompile export cic_turret::function_38baa992 Unknown operator 0x98
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x8083dc91, Offset: 0x18e0
// Size: 0x12
function function_39f05215() {
    // Can't decompile export cic_turret::function_39f05215 jump with invalid delta: 0x42ed
}

// Namespace cic_turret
// Params 14, eflags: 0x0
// Checksum 0x64b4843, Offset: 0x1a80
// Size: 0x7a
function function_df1adf01(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname) {
    // Can't decompile export cic_turret::function_df1adf01 Unknown operator 0x5d
}

// Namespace cic_turret
// Params 1, eflags: 0x0
// Checksum 0xf35cae8a, Offset: 0x1bc0
// Size: 0x39
function function_2790de05(turret) {
    // Can't decompile export cic_turret::function_2790de05 Unknown operator 0x5d
}

// Namespace cic_turret
// Params 0, eflags: 0x0
// Checksum 0x90e66e78, Offset: 0x1cb0
// Size: 0x12
function function_d8937095() {
    // Can't decompile export cic_turret::function_d8937095 jump with invalid delta: 0x33ed
}

