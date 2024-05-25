#using scripts/zm/zm_island_util;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_6c640490;

// Namespace namespace_6c640490
// Params 0, eflags: 0x2
// Checksum 0x8031d76c, Offset: 0x3a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_island_side_ee_distant_monster", &__init__, undefined, undefined);
}

// Namespace namespace_6c640490
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x3e8
// Size: 0x4
function __init__() {
    
}

// Namespace namespace_6c640490
// Params 0, eflags: 0x1 linked
// Checksum 0xbe0b4f08, Offset: 0x3f8
// Size: 0x5c
function main() {
    var_53564731 = getent("ee_vista_monster", "targetname");
    level thread function_e94b80b9();
    /#
        level thread function_abe01b4d();
    #/
}

// Namespace namespace_6c640490
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x460
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace namespace_6c640490
// Params 0, eflags: 0x1 linked
// Checksum 0xa4956a7d, Offset: 0x470
// Size: 0x114
function function_e94b80b9() {
    while (level.round_number < 50) {
        level waittill(#"start_of_round");
    }
    var_d95fb733 = 0;
    do {
        foreach (player in level.activeplayers) {
            if (zm_utility::is_player_valid(player) && player hasweapon(level.var_c003f5b, 1)) {
                var_d95fb733 = 1;
            }
        }
        wait(2);
    } while (!(isdefined(var_d95fb733) && var_d95fb733));
    function_549b07cb();
}

// Namespace namespace_6c640490
// Params 0, eflags: 0x1 linked
// Checksum 0x25e29879, Offset: 0x590
// Size: 0x1d4
function function_549b07cb() {
    e_vehicle = vehicle::simple_spawn_single("veh_distant_monster");
    e_vehicle hide();
    nd_start = getvehiclenode(e_vehicle.target, "targetname");
    e_vehicle attachpath(nd_start);
    var_53564731 = getent("ee_vista_monster", "targetname");
    var_53564731 setforcenocull();
    var_53564731.origin = e_vehicle.origin;
    var_53564731.angles = e_vehicle.angles;
    var_53564731 linkto(e_vehicle);
    e_vehicle setspeed(5, 100);
    e_vehicle startpath();
    var_53564731 playsound("zmb_distant_monster_mash");
    e_vehicle waittill(#"reached_end_node");
    e_vehicle.delete_on_death = 1;
    e_vehicle notify(#"death");
    if (!isalive(e_vehicle)) {
        e_vehicle delete();
    }
}

/#

    // Namespace namespace_6c640490
    // Params 0, eflags: 0x1 linked
    // Checksum 0xef872461, Offset: 0x770
    // Size: 0x6c
    function function_abe01b4d() {
        zm_devgui::add_custom_devgui_callback(&function_603ad7e1);
        level.var_7b18dfab = 0;
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
    }

    // Namespace namespace_6c640490
    // Params 1, eflags: 0x1 linked
    // Checksum 0xbf55fbe2, Offset: 0x7e8
    // Size: 0x66
    function function_603ad7e1(cmd) {
        switch (cmd) {
        case 8:
            function_549b07cb();
            return 1;
        case 8:
            level.var_7b18dfab = !level.var_7b18dfab;
            return 1;
        }
        return 0;
    }

#/
