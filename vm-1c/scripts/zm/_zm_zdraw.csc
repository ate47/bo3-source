#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_util;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_zdraw;

/#

    // Namespace zm_zdraw
    // Params 0, eflags: 0x2
    // Checksum 0x40ae5d3, Offset: 0x198
    // Size: 0x44
    function autoexec function_2dc19561() {
        system::register("<unknown string>", &__init__, &__main__, undefined);
    }

    // Namespace zm_zdraw
    // Params 0, eflags: 0x1 linked
    // Checksum 0xbcf0ce2d, Offset: 0x1e8
    // Size: 0x8c
    function __init__() {
        setdvar("<unknown string>", "<unknown string>");
        level.zdraw = spawnstruct();
        function_3e630288();
        function_aa8545fe();
        function_404ac348();
        level thread function_41fec76e();
    }

    // Namespace zm_zdraw
    // Params 0, eflags: 0x1 linked
    // Checksum 0xeb8facf, Offset: 0x280
    // Size: 0x8
    function __main__() {
        
    }

    // Namespace zm_zdraw
    // Params 0, eflags: 0x1 linked
    // Checksum 0x634bd6e3, Offset: 0x290
    // Size: 0x3be
    function function_3e630288() {
        level.zdraw.colors = [];
        level.zdraw.colors["<unknown string>"] = (1, 0, 0);
        level.zdraw.colors["<unknown string>"] = (0, 1, 0);
        level.zdraw.colors["<unknown string>"] = (0, 0, 1);
        level.zdraw.colors["<unknown string>"] = (1, 1, 0);
        level.zdraw.colors["<unknown string>"] = (1, 0.5, 0);
        level.zdraw.colors["<unknown string>"] = (0, 1, 1);
        level.zdraw.colors["<unknown string>"] = (1, 0, 1);
        level.zdraw.colors["<unknown string>"] = (0, 0, 0);
        level.zdraw.colors["<unknown string>"] = (1, 1, 1);
        level.zdraw.colors["<unknown string>"] = (0.75, 0.75, 0.75);
        level.zdraw.colors["<unknown string>"] = (0.1, 0.1, 0.1);
        level.zdraw.colors["<unknown string>"] = (0.2, 0.2, 0.2);
        level.zdraw.colors["<unknown string>"] = (0.3, 0.3, 0.3);
        level.zdraw.colors["<unknown string>"] = (0.4, 0.4, 0.4);
        level.zdraw.colors["<unknown string>"] = (0.5, 0.5, 0.5);
        level.zdraw.colors["<unknown string>"] = (0.6, 0.6, 0.6);
        level.zdraw.colors["<unknown string>"] = (0.7, 0.7, 0.7);
        level.zdraw.colors["<unknown string>"] = (0.8, 0.8, 0.8);
        level.zdraw.colors["<unknown string>"] = (0.9, 0.9, 0.9);
        level.zdraw.colors["<unknown string>"] = (0.439216, 0.501961, 0.564706);
        level.zdraw.colors["<unknown string>"] = (1, 0.752941, 0.796078);
        level.zdraw.colors["<unknown string>"] = (0.501961, 0.501961, 0);
        level.zdraw.colors["<unknown string>"] = (0.545098, 0.270588, 0.0745098);
        level.zdraw.colors["<unknown string>"] = (1, 1, 1);
    }

    // Namespace zm_zdraw
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf1be390b, Offset: 0x658
    // Size: 0x1d6
    function function_aa8545fe() {
        level.zdraw.commands = [];
        level.zdraw.commands["<unknown string>"] = &function_5ef6cf9b;
        level.zdraw.commands["<unknown string>"] = &function_eae4114a;
        level.zdraw.commands["<unknown string>"] = &function_f2f3c18e;
        level.zdraw.commands["<unknown string>"] = &function_8f04ad79;
        level.zdraw.commands["<unknown string>"] = &function_a13efe1c;
        level.zdraw.commands["<unknown string>"] = &function_b3b92edc;
        level.zdraw.commands["<unknown string>"] = &function_8c2ca616;
        level.zdraw.commands["<unknown string>"] = &function_3145e33f;
        level.zdraw.commands["<unknown string>"] = &function_f36ec3d2;
        level.zdraw.commands["<unknown string>"] = &function_7bdd3089;
        level.zdraw.commands["<unknown string>"] = &function_be7cf134;
    }

    // Namespace zm_zdraw
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6298ca10, Offset: 0x838
    // Size: 0xf4
    function function_404ac348() {
        level.zdraw.color = level.zdraw.colors["<unknown string>"];
        level.zdraw.alpha = 1;
        level.zdraw.scale = 1;
        level.zdraw.duration = int(1 * 62.5);
        level.zdraw.radius = 8;
        level.zdraw.sides = 10;
        level.zdraw.var_5f3c7817 = (0, 0, 0);
        level.zdraw.var_922ae5d = 0;
        level.zdraw.var_c1953771 = "<unknown string>";
    }

    // Namespace zm_zdraw
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc11a2415, Offset: 0x938
    // Size: 0xd8
    function function_41fec76e() {
        level notify(#"hash_15f14510");
        level endon(#"hash_15f14510");
        for (;;) {
            cmd = getdvarstring("<unknown string>");
            if (cmd.size) {
                function_404ac348();
                params = strtok(cmd, "<unknown string>");
                function_4282fd75(params, 0, 1);
                setdvar("<unknown string>", "<unknown string>");
            }
            wait(0.5);
        }
    }

    // Namespace zm_zdraw
    // Params 3, eflags: 0x1 linked
    // Checksum 0xe3d442e7, Offset: 0xa18
    // Size: 0xe4
    function function_4282fd75(var_859cfb21, startat, toplevel) {
        if (!isdefined(toplevel)) {
            toplevel = 0;
        }
        while (isdefined(var_859cfb21[startat])) {
            if (isdefined(level.zdraw.commands[var_859cfb21[startat]])) {
                startat = [[ level.zdraw.commands[var_859cfb21[startat]] ]](var_859cfb21, startat + 1);
                continue;
            }
            if (isdefined(toplevel) && toplevel) {
                function_c69caf7e("<unknown string>" + var_859cfb21[startat]);
            }
            return startat;
        }
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2, eflags: 0x1 linked
    // Checksum 0x3dcfcace, Offset: 0xb08
    // Size: 0x16c
    function function_7bdd3089(var_859cfb21, startat) {
        while (isdefined(var_859cfb21[startat])) {
            if (function_c0fb9425(var_859cfb21[startat])) {
                var_b78d9698 = function_36371547(var_859cfb21, startat);
                if (var_b78d9698 > startat) {
                    startat = var_b78d9698;
                    center = level.zdraw.var_5f3c7817;
                    sphere(center, level.zdraw.radius, level.zdraw.color, level.zdraw.alpha, 1, level.zdraw.sides, level.zdraw.duration);
                    level.zdraw.var_5f3c7817 = (0, 0, 0);
                }
                continue;
            }
            var_b78d9698 = function_4282fd75(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                continue;
            }
            return startat;
        }
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2, eflags: 0x1 linked
    // Checksum 0x8c83621a, Offset: 0xc80
    // Size: 0x13c
    function function_f36ec3d2(var_859cfb21, startat) {
        while (isdefined(var_859cfb21[startat])) {
            if (function_c0fb9425(var_859cfb21[startat])) {
                var_b78d9698 = function_36371547(var_859cfb21, startat);
                if (var_b78d9698 > startat) {
                    startat = var_b78d9698;
                    center = level.zdraw.var_5f3c7817;
                    debugstar(center, level.zdraw.duration, level.zdraw.color);
                    level.zdraw.var_5f3c7817 = (0, 0, 0);
                }
                continue;
            }
            var_b78d9698 = function_4282fd75(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                continue;
            }
            return startat;
        }
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2, eflags: 0x1 linked
    // Checksum 0xd7519ba1, Offset: 0xdc8
    // Size: 0x19c
    function function_be7cf134(var_859cfb21, startat) {
        level.zdraw.linestart = undefined;
        while (isdefined(var_859cfb21[startat])) {
            if (function_c0fb9425(var_859cfb21[startat])) {
                var_b78d9698 = function_36371547(var_859cfb21, startat);
                if (var_b78d9698 > startat) {
                    startat = var_b78d9698;
                    lineend = level.zdraw.var_5f3c7817;
                    if (isdefined(level.zdraw.linestart)) {
                        line(level.zdraw.linestart, lineend, level.zdraw.color, level.zdraw.alpha, 1, level.zdraw.duration);
                    }
                    level.zdraw.linestart = lineend;
                    level.zdraw.var_5f3c7817 = (0, 0, 0);
                }
                continue;
            }
            var_b78d9698 = function_4282fd75(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                continue;
            }
            return startat;
        }
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2, eflags: 0x1 linked
    // Checksum 0x3f83e1b0, Offset: 0xf70
    // Size: 0x204
    function function_3145e33f(var_859cfb21, startat) {
        level.zdraw.text = "<unknown string>";
        if (isdefined(var_859cfb21[startat])) {
            var_b78d9698 = function_ce50bae5(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.text = level.zdraw.var_c1953771;
                level.zdraw.var_c1953771 = "<unknown string>";
            }
        }
        while (isdefined(var_859cfb21[startat])) {
            if (function_c0fb9425(var_859cfb21[startat])) {
                var_b78d9698 = function_36371547(var_859cfb21, startat);
                if (var_b78d9698 > startat) {
                    startat = var_b78d9698;
                    center = level.zdraw.var_5f3c7817;
                    print3d(center, level.zdraw.text, level.zdraw.color, level.zdraw.alpha, level.zdraw.scale, level.zdraw.duration);
                    level.zdraw.var_5f3c7817 = (0, 0, 0);
                }
                continue;
            }
            var_b78d9698 = function_4282fd75(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                continue;
            }
            return startat;
        }
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2, eflags: 0x1 linked
    // Checksum 0x28301e68, Offset: 0x1180
    // Size: 0x17a
    function function_5ef6cf9b(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            if (function_c0fb9425(var_859cfb21[startat])) {
                var_b78d9698 = function_36371547(var_859cfb21, startat);
                if (var_b78d9698 > startat) {
                    startat = var_b78d9698;
                    level.zdraw.color = level.zdraw.var_5f3c7817;
                    level.zdraw.var_5f3c7817 = (0, 0, 0);
                } else {
                    level.zdraw.color = (1, 1, 1);
                }
            } else {
                if (isdefined(level.zdraw.colors[var_859cfb21[startat]])) {
                    level.zdraw.color = level.zdraw.colors[var_859cfb21[startat]];
                } else {
                    level.zdraw.color = (1, 1, 1);
                    function_c69caf7e("<unknown string>" + var_859cfb21[startat]);
                }
                startat += 1;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2, eflags: 0x1 linked
    // Checksum 0x22d4065c, Offset: 0x1308
    // Size: 0xba
    function function_eae4114a(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.alpha = level.zdraw.var_922ae5d;
                level.zdraw.var_922ae5d = 0;
            } else {
                level.zdraw.alpha = 1;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2, eflags: 0x1 linked
    // Checksum 0x51378d73, Offset: 0x13d0
    // Size: 0xba
    function function_a13efe1c(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.scale = level.zdraw.var_922ae5d;
                level.zdraw.var_922ae5d = 0;
            } else {
                level.zdraw.scale = 1;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2, eflags: 0x1 linked
    // Checksum 0xaecad868, Offset: 0x1498
    // Size: 0xea
    function function_f2f3c18e(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.duration = int(level.zdraw.var_922ae5d);
                level.zdraw.var_922ae5d = 0;
            } else {
                level.zdraw.duration = int(1 * 62.5);
            }
        }
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2, eflags: 0x1 linked
    // Checksum 0xfcc0d5ed, Offset: 0x1590
    // Size: 0xf2
    function function_8f04ad79(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.duration = int(62.5 * level.zdraw.var_922ae5d);
                level.zdraw.var_922ae5d = 0;
            } else {
                level.zdraw.duration = int(1 * 62.5);
            }
        }
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2, eflags: 0x1 linked
    // Checksum 0xc3cbaee6, Offset: 0x1690
    // Size: 0xba
    function function_b3b92edc(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.radius = level.zdraw.var_922ae5d;
                level.zdraw.var_922ae5d = 0;
            } else {
                level.zdraw.radius = 8;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2, eflags: 0x1 linked
    // Checksum 0xfe5106db, Offset: 0x1758
    // Size: 0xce
    function function_8c2ca616(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.sides = int(level.zdraw.var_922ae5d);
                level.zdraw.var_922ae5d = 0;
            } else {
                level.zdraw.sides = 10;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw
    // Params 1, eflags: 0x1 linked
    // Checksum 0x1c3ee0d0, Offset: 0x1830
    // Size: 0x88
    function function_c0fb9425(param) {
        if (isstring(param) && (isint(param) || isfloat(param) || isdefined(param) && strisnumber(param))) {
            return 1;
        }
        return 0;
    }

    // Namespace zm_zdraw
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb60484ea, Offset: 0x18c0
    // Size: 0x260
    function function_36371547(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.var_5f3c7817 = (level.zdraw.var_922ae5d, level.zdraw.var_5f3c7817[1], level.zdraw.var_5f3c7817[2]);
                level.zdraw.var_922ae5d = 0;
            } else {
                function_c69caf7e("<unknown string>");
                return startat;
            }
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.var_5f3c7817 = (level.zdraw.var_5f3c7817[0], level.zdraw.var_922ae5d, level.zdraw.var_5f3c7817[2]);
                level.zdraw.var_922ae5d = 0;
            } else {
                function_c69caf7e("<unknown string>");
                return startat;
            }
            var_b78d9698 = function_33acda19(var_859cfb21, startat);
            if (var_b78d9698 > startat) {
                startat = var_b78d9698;
                level.zdraw.var_5f3c7817 = (level.zdraw.var_5f3c7817[0], level.zdraw.var_5f3c7817[1], level.zdraw.var_922ae5d);
                level.zdraw.var_922ae5d = 0;
            } else {
                function_c69caf7e("<unknown string>");
                return startat;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2, eflags: 0x1 linked
    // Checksum 0x24066f26, Offset: 0x1b28
    // Size: 0x8a
    function function_33acda19(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            if (function_c0fb9425(var_859cfb21[startat])) {
                level.zdraw.var_922ae5d = float(var_859cfb21[startat]);
                startat += 1;
            }
        }
        return startat;
    }

    // Namespace zm_zdraw
    // Params 2, eflags: 0x1 linked
    // Checksum 0x2f7f683f, Offset: 0x1bc0
    // Size: 0x5a
    function function_ce50bae5(var_859cfb21, startat) {
        if (isdefined(var_859cfb21[startat])) {
            level.zdraw.var_c1953771 = var_859cfb21[startat];
            startat += 1;
        }
        return startat;
    }

    // Namespace zm_zdraw
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8cafbd4a, Offset: 0x1c28
    // Size: 0x34
    function function_c69caf7e(msg) {
        println("<unknown string>" + msg);
    }

#/
