#using scripts/mp/mp_metro_train;
#using scripts/mp/mp_metro_sound;
#using scripts/mp/mp_metro_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/shared/compass;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_27da2c28;

// Namespace namespace_27da2c28
// Params 0, eflags: 0x1 linked
// namespace_27da2c28<file_0>::function_d290ebfa
// Checksum 0x15cb9fb7, Offset: 0x1d8
// Size: 0x1ac
function main() {
    precache();
    setdvar("phys_buoyancy", 1);
    clientfield::register("scriptmover", "mp_metro_train_timer", 1, 1, "int");
    namespace_dbba1d69::main();
    namespace_4dd2d99c::main();
    load::main();
    compass::setupminimap("compass_map_mp_metro");
    setdvar("compassmaxrange", "2100");
    level.cleandepositpoints = array((-399.059, 1.39783, -47.875), (-1539.2, -239.678, -207.875), (878.216, -0.543464, -47.875), (69.9086, 1382.49, 0.125));
    if (getgametypesetting("allowMapScripting")) {
        level thread namespace_1931cdeb::init();
    }
    /#
        level thread function_a6fb40d5();
        execdevgui("<unknown string>");
    #/
}

// Namespace namespace_27da2c28
// Params 0, eflags: 0x1 linked
// namespace_27da2c28<file_0>::function_f7046c76
// Checksum 0x99ec1590, Offset: 0x390
// Size: 0x4
function precache() {
    
}

/#

    // Namespace namespace_27da2c28
    // Params 0, eflags: 0x1 linked
    // namespace_27da2c28<file_0>::function_a6fb40d5
    // Checksum 0x1961e654, Offset: 0x3a0
    // Size: 0x100
    function function_a6fb40d5() {
        setdvar("<unknown string>", "<unknown string>");
        for (;;) {
            wait(0.5);
            devgui_string = getdvarstring("<unknown string>");
            switch (devgui_string) {
            case 8:
                break;
            case 8:
                level notify(#"hash_a5d9b10");
                break;
            case 8:
                level notify(#"hash_7c650a4b");
                break;
            default:
                break;
            }
            if (getdvarstring("<unknown string>") != "<unknown string>") {
                setdvar("<unknown string>", "<unknown string>");
            }
        }
    }

#/
