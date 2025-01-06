#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_metro_fx;
#using scripts/mp/mp_metro_sound;
#using scripts/mp/mp_metro_train;
#using scripts/shared/clientfield_shared;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_metro;

// Namespace mp_metro
// Params 0, eflags: 0x0
// Checksum 0xc4cc6d61, Offset: 0x1d8
// Size: 0x10a
function main() {
    precache();
    setdvar("phys_buoyancy", 1);
    clientfield::register("scriptmover", "mp_metro_train_timer", 1, 1, "int");
    mp_metro_fx::main();
    mp_metro_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_metro");
    setdvar("compassmaxrange", "2100");
    if (getgametypesetting("allowMapScripting")) {
        level thread mp_metro_train::init();
    }
    /#
        level thread function_a6fb40d5();
        execdevgui("<dev string:x28>");
    #/
}

// Namespace mp_metro
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x2f0
// Size: 0x2
function precache() {
    
}

/#

    // Namespace mp_metro
    // Params 0, eflags: 0x0
    // Checksum 0x2562201f, Offset: 0x300
    // Size: 0xdd
    function function_a6fb40d5() {
        setdvar("<dev string:x3f>", "<dev string:x4d>");
        for (;;) {
            wait 0.5;
            devgui_string = getdvarstring("<dev string:x3f>");
            switch (devgui_string) {
            case "<dev string:x4d>":
                break;
            case "<dev string:x4e>":
                level notify(#"train_start_1");
                break;
            case "<dev string:x5c>":
                level notify(#"train_start_2");
                break;
            default:
                break;
            }
            if (getdvarstring("<dev string:x3f>") != "<dev string:x4d>") {
                setdvar("<dev string:x3f>", "<dev string:x4d>");
            }
        }
    }

#/
