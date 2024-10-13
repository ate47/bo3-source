#using scripts/shared/callbacks_shared;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/math_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/ai_shared;

#namespace archetype_damage_effects;

// Namespace archetype_damage_effects
// Params 0, eflags: 0x2
// Checksum 0x25729624, Offset: 0x208
// Size: 0xe4
function autoexec main() {
    clientfield::register("actor", "arch_actor_fire_fx", 1, 2, "int");
    clientfield::register("actor", "arch_actor_char", 1, 2, "int");
    callback::on_actor_damage(&onactordamagecallback);
    callback::on_vehicle_damage(&function_2bc18574);
    callback::on_actor_killed(&onactorkilledcallback);
    callback::on_vehicle_killed(&function_285b856c);
}

// Namespace archetype_damage_effects
// Params 1, eflags: 0x1 linked
// Checksum 0x15d56ac5, Offset: 0x2f8
// Size: 0x24
function onactordamagecallback(params) {
    onactordamage(params);
}

// Namespace archetype_damage_effects
// Params 1, eflags: 0x1 linked
// Checksum 0xdf17122b, Offset: 0x328
// Size: 0x24
function function_2bc18574(params) {
    function_ec419ed9(params);
}

// Namespace archetype_damage_effects
// Params 1, eflags: 0x1 linked
// Checksum 0x18abf46b, Offset: 0x358
// Size: 0x6e
function onactorkilledcallback(params) {
    onactorkilled();
    switch (self.archetype) {
    case "human":
        function_696061ce();
        break;
    case "robot":
        function_30a29e89();
        break;
    }
}

// Namespace archetype_damage_effects
// Params 1, eflags: 0x1 linked
// Checksum 0x95693ed5, Offset: 0x3d0
// Size: 0x24
function function_285b856c(params) {
    function_b5c6dde1(params);
}

// Namespace archetype_damage_effects
// Params 1, eflags: 0x1 linked
// Checksum 0x90504447, Offset: 0x400
// Size: 0xc
function onactordamage(params) {
    
}

// Namespace archetype_damage_effects
// Params 1, eflags: 0x1 linked
// Checksum 0x12f19214, Offset: 0x418
// Size: 0x24
function function_ec419ed9(params) {
    function_b5c6dde1(params);
}

// Namespace archetype_damage_effects
// Params 0, eflags: 0x1 linked
// Checksum 0x48e1ff5a, Offset: 0x448
// Size: 0x7c
function onactorkilled() {
    if (isdefined(self.damagemod)) {
        if (self.damagemod == "MOD_BURNED") {
            if (isdefined(self.damageweapon) && isdefined(self.damageweapon.specialpain) && self.damageweapon.specialpain == 0) {
                self clientfield::set("arch_actor_fire_fx", 2);
            }
        }
    }
}

// Namespace archetype_damage_effects
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x4d0
// Size: 0x4
function function_696061ce() {
    
}

// Namespace archetype_damage_effects
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x4e0
// Size: 0x4
function function_30a29e89() {
    
}

// Namespace archetype_damage_effects
// Params 1, eflags: 0x1 linked
// Checksum 0x8cb7853b, Offset: 0x4f0
// Size: 0xc
function function_b5c6dde1(params) {
    
}

