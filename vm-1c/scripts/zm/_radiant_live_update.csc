#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace radiant_live_udpate;

/#

    // Namespace radiant_live_udpate
    // Params 0, eflags: 0x2
    // namespace_32d9575d<file_0>::function_2dc19561
    // Checksum 0x95b1ff47, Offset: 0xb8
    // Size: 0x34
    function autoexec function_2dc19561() {
        system::register("<unknown string>", &__init__, undefined, undefined);
    }

    // Namespace radiant_live_udpate
    // Params 0, eflags: 0x1 linked
    // namespace_32d9575d<file_0>::function_8c87d8eb
    // Checksum 0x689e53d2, Offset: 0xf8
    // Size: 0x1c
    function __init__() {
        thread scriptstruct_debug_render();
    }

    // Namespace radiant_live_udpate
    // Params 0, eflags: 0x1 linked
    // namespace_32d9575d<file_0>::function_a864be3e
    // Checksum 0x536ea647, Offset: 0x120
    // Size: 0x62
    function scriptstruct_debug_render() {
        while (true) {
            selected_struct = level waittill(#"liveupdate");
            if (isdefined(selected_struct)) {
                level thread render_struct(selected_struct);
                continue;
            }
            level notify(#"stop_struct_render");
        }
    }

    // Namespace radiant_live_udpate
    // Params 1, eflags: 0x1 linked
    // namespace_32d9575d<file_0>::function_27d8985f
    // Checksum 0x595b7e89, Offset: 0x190
    // Size: 0x80
    function render_struct(selected_struct) {
        self endon(#"stop_struct_render");
        while (isdefined(selected_struct)) {
            box(selected_struct.origin, (-16, -16, -16), (16, 16, 16), 0, (1, 0.4, 0.4));
            wait(0.01);
        }
    }

#/
