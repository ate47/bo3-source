#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;

#namespace namespace_2e795785;

/#

    // Namespace namespace_2e795785
    // Params 0, eflags: 0x1 linked
    // namespace_2e795785<file_0>::function_6f199738
    // Checksum 0x2218b5b3, Offset: 0x100
    // Size: 0x54
    function function_6f199738() {
        execdevgui("<unknown string>");
        level thread function_17186302();
        level thread function_10489e30();
    }

    // Namespace namespace_2e795785
    // Params 0, eflags: 0x1 linked
    // namespace_2e795785<file_0>::function_17186302
    // Checksum 0x9b383309, Offset: 0x160
    // Size: 0x758
    function function_17186302() {
        setdvar("<unknown string>", 0);
        while (true) {
            if (isdefined(level.var_a9e78bf7) && getdvarstring("<unknown string>") == "<unknown string>") {
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + "<unknown string>" + level.var_b1955bd6 + "<unknown string>" + level.var_d0e37460 + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
                printtoprightln("<unknown string>" + "<unknown string>" + level.var_a9e78bf7["<unknown string>"]);
            }
            wait(0.05);
        }
    }

    // Namespace namespace_2e795785
    // Params 0, eflags: 0x1 linked
    // namespace_2e795785<file_0>::function_10489e30
    // Checksum 0x81f50a35, Offset: 0x8c0
    // Size: 0x248
    function function_10489e30() {
        setdvar("<unknown string>", 0);
        while (true) {
            if (isdefined(level.var_5deb2d16) && (getdvarstring("<unknown string>") == "<unknown string>" || level.var_5deb2d16)) {
                skiptos = getskiptos();
                if (!isdefined(level.var_c7b985ff)) {
                    level.var_c7b985ff = newhudelem();
                    level.var_c7b985ff.alignx = "<unknown string>";
                    level.var_c7b985ff.aligny = "<unknown string>";
                    level.var_c7b985ff.x = -56;
                    level.var_c7b985ff.y = 100;
                    level.var_c7b985ff.fontscale = 2;
                    level.var_c7b985ff.sort = 20;
                    level.var_c7b985ff.alpha = 1;
                    level.var_c7b985ff.color = (0.8, 0.8, 0.8);
                    level.var_c7b985ff.font = "<unknown string>";
                }
                prefix = "<unknown string>";
                if (isdefined(level.var_5deb2d16) && level.var_5deb2d16) {
                    prefix = "<unknown string>";
                }
                if (isdefined(level.var_c0e97bd)) {
                    level.var_c7b985ff settext(prefix + "<unknown string>" + level.var_c0e97bd);
                } else {
                    level.var_c7b985ff settext(prefix + "<unknown string>" + "<unknown string>");
                }
            } else if (isdefined(level.var_c7b985ff)) {
                level.var_c7b985ff destroy();
            }
            wait(0.05);
        }
    }

    // Namespace namespace_2e795785
    // Params 0, eflags: 0x0
    // namespace_2e795785<file_0>::function_a2a8d5a6
    // Checksum 0x6488e7fc, Offset: 0xb10
    // Size: 0x250
    function function_a2a8d5a6() {
        setdvar("<unknown string>", 0);
        nodes = getallnodes();
        while (true) {
            if (getdvarstring("<unknown string>") == "<unknown string>") {
                level.var_915cfc91 = [];
                foreach (node in nodes) {
                    if (node.type == "<unknown string>" || node.type == "<unknown string>") {
                        if (isdefined(node.script_noteworthy) && node.script_noteworthy == "<unknown string>") {
                            if (!isinarray(level.var_915cfc91, node.animscript)) {
                                level.var_915cfc91[level.var_915cfc91.size] = node.animscript;
                            }
                        }
                    }
                }
                foreach (animscript in level.var_915cfc91) {
                    println("<unknown string>" + animscript);
                }
            }
            setdvar("<unknown string>", 0);
            wait(0.1);
        }
    }

#/
