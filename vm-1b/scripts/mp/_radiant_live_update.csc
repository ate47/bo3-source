#using scripts/shared/system_shared;

#namespace radiant_live_update;

/#

    // Namespace radiant_live_update
    // Params 0, eflags: 0x2
    // Checksum 0x67fe901d, Offset: 0x98
    // Size: 0x2a
    function autoexec function_2dc19561() {
        system::register("<dev string:x28>", &__init__, undefined, undefined);
    }

    // Namespace radiant_live_update
    // Params 0, eflags: 0x0
    // Checksum 0x530f65d6, Offset: 0xd0
    // Size: 0x12
    function __init__() {
        thread scriptstruct_debug_render();
    }

    // Namespace radiant_live_update
    // Params 0, eflags: 0x0
    // Checksum 0x7efdbed9, Offset: 0xf0
    // Size: 0x4b
    function scriptstruct_debug_render() {
        while (true) {
            level waittill(#"liveupdate", selected_struct);
            if (isdefined(selected_struct)) {
                level thread render_struct(selected_struct);
                continue;
            }
            level notify(#"stop_struct_render");
        }
    }

    // Namespace radiant_live_update
    // Params 1, eflags: 0x0
    // Checksum 0xc08578df, Offset: 0x148
    // Size: 0x75
    function render_struct(selected_struct) {
        self endon(#"stop_struct_render");
        if (!isdefined(selected_struct.origin)) {
            return;
        }
        while (isdefined(selected_struct)) {
            box(selected_struct.origin, (-16, -16, -16), (16, 16, 16), 0, (1, 0.4, 0.4));
            wait 0.016;
        }
    }

#/
