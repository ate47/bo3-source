#using scripts/shared/ai/zombie_vortex;
#using scripts/zm/_zm_weapons;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_42517170;

// Namespace namespace_42517170
// Params 0, eflags: 0x2
// namespace_42517170<file_0>::function_2dc19561
// Checksum 0xf095ae55, Offset: 0x240
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("idgun", &init, undefined, undefined);
}

// Namespace namespace_42517170
// Params 0, eflags: 0x1 linked
// namespace_42517170<file_0>::function_c35e6aab
// Checksum 0xb8ff88de, Offset: 0x280
// Size: 0x94
function init() {
    level.weaponnone = getweapon("none");
    level.var_29323b70 = getweapon("robotech_launcher");
    level.var_672ab258 = getweapon("robotech_launcher_upgraded");
    function_436486f7();
    callback::on_spawned(&function_50ee0a95);
}

// Namespace namespace_42517170
// Params 1, eflags: 0x1 linked
// namespace_42517170<file_0>::function_50ee0a95
// Checksum 0x37a76aeb, Offset: 0x320
// Size: 0xc
function function_50ee0a95(localclientnum) {
    
}

// Namespace namespace_42517170
// Params 1, eflags: 0x1 linked
// namespace_42517170<file_0>::function_e1efbc50
// Checksum 0xbe04984c, Offset: 0x338
// Size: 0x8a
function function_e1efbc50(var_9727e47e) {
    if (var_9727e47e != level.weaponnone) {
        if (!isdefined(level.idgun_weapons)) {
            level.idgun_weapons = [];
        } else if (!isarray(level.idgun_weapons)) {
            level.idgun_weapons = array(level.idgun_weapons);
        }
        level.idgun_weapons[level.idgun_weapons.size] = var_9727e47e;
    }
}

// Namespace namespace_42517170
// Params 0, eflags: 0x1 linked
// namespace_42517170<file_0>::function_436486f7
// Checksum 0x3f9201a2, Offset: 0x3d0
// Size: 0x154
function function_436486f7() {
    level.idgun_weapons = [];
    function_e1efbc50(getweapon("idgun_0"));
    function_e1efbc50(getweapon("idgun_1"));
    function_e1efbc50(getweapon("idgun_2"));
    function_e1efbc50(getweapon("idgun_3"));
    function_e1efbc50(getweapon("idgun_upgraded_0"));
    function_e1efbc50(getweapon("idgun_upgraded_1"));
    function_e1efbc50(getweapon("idgun_upgraded_2"));
    function_e1efbc50(getweapon("idgun_upgraded_3"));
}

// Namespace namespace_42517170
// Params 1, eflags: 0x0
// namespace_42517170<file_0>::function_9b7ac6a9
// Checksum 0xb93c7c99, Offset: 0x530
// Size: 0x98
function function_9b7ac6a9(weapon) {
    if (weapon === getweapon("idgun_upgraded_0") || weapon === getweapon("idgun_upgraded_1") || weapon === getweapon("idgun_upgraded_2") || weapon === getweapon("idgun_upgraded_3")) {
        return true;
    }
    return false;
}

// Namespace namespace_42517170
// Params 1, eflags: 0x0
// namespace_42517170<file_0>::function_ea8d6d0d
// Checksum 0x97dea99a, Offset: 0x5d0
// Size: 0x3e
function is_idgun_damage(weapon) {
    if (isdefined(level.idgun_weapons)) {
        if (isinarray(level.idgun_weapons, weapon)) {
            return true;
        }
    }
    return false;
}

