#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/array_shared;

#namespace debug;

/#

    // Namespace debug
    // Params 0, eflags: 0x2
    // Checksum 0x7638e90, Offset: 0xd0
    // Size: 0x34
    function autoexec function_2dc19561() {
        system::register("<unknown string>", &__init__, undefined, undefined);
    }

    // Namespace debug
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6e21c650, Offset: 0x110
    // Size: 0x1c
    function __init__() {
        thread debug_draw_tuning_sphere();
    }

    // Namespace debug
    // Params 0, eflags: 0x1 linked
    // Checksum 0xad4bb121, Offset: 0x138
    // Size: 0x24a
    function debug_draw_tuning_sphere() {
        n_sphere_radius = 0;
        v_text_position = (0, 0, 0);
        n_text_scale = 1;
        while (true) {
            n_sphere_radius = getdvarfloat("<unknown string>", 0);
            while (n_sphere_radius >= 1) {
                players = getplayers();
                if (isdefined(players[0])) {
                    n_sphere_radius = getdvarfloat("<unknown string>", 0);
                    circle(players[0].origin, n_sphere_radius, (1, 0, 0), 0, 1, 16);
                    n_text_scale = sqrt(n_sphere_radius * 2.5) / 2;
                    vforward = anglestoforward(players[0].angles);
                    v_text_position = players[0].origin + vforward * n_sphere_radius;
                    sides = int(10 * (1 + int(n_text_scale) % 100));
                    sphere(v_text_position, n_text_scale, (1, 0, 0), 1, 1, sides, 16);
                    print3d(v_text_position + (0, 0, 20), n_sphere_radius, (1, 0, 0), 1, n_text_scale / 14, 16);
                }
                wait(0.05);
            }
            wait(1);
        }
    }

#/
