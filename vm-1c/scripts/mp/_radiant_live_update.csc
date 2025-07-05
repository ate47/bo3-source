#using scripts/shared/system_shared;

#namespace radiant_live_update;

/#

    // Namespace radiant_live_update
    // Params 0, eflags: 0x2
    // Checksum 0x9d5f210a, Offset: 0x98
    // Size: 0x34
    function autoexec __init__sytem__() {
        system::register("<dev string:x28>", &__init__, undefined, undefined);
    }

    // Namespace radiant_live_update
    // Params 0, eflags: 0x0
    // Checksum 0x6df52f2c, Offset: 0xd8
    // Size: 0x1c
    function __init__() {
        thread scriptstruct_debug_render();
    }

    // Namespace radiant_live_update
    // Params 0, eflags: 0x0
    // Checksum 0xb25aa584, Offset: 0x100
    // Size: 0x62
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
    // Checksum 0x7521c6d9, Offset: 0x170
    // Size: 0x98
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
