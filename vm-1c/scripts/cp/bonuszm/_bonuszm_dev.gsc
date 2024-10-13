#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;

#namespace namespace_2e795785;

/#

    // Namespace namespace_2e795785
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2218b5b3, Offset: 0x100
    // Size: 0x54
    function function_6f199738() {
        execdevgui("<dev string:x28>");
        level thread function_17186302();
        level thread function_10489e30();
    }

    // Namespace namespace_2e795785
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9b383309, Offset: 0x160
    // Size: 0x758
    function function_17186302() {
        setdvar("<dev string:x3e>", 0);
        while (true) {
            if (isdefined(level.var_a9e78bf7) && getdvarstring("<dev string:x3e>") == "<dev string:x50>") {
                printtoprightln("<dev string:x52>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x52>"]);
                printtoprightln("<dev string:x66>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x66>"]);
                printtoprightln("<dev string:x78>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x78>"]);
                printtoprightln("<dev string:x8c>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x8c>"]);
                printtoprightln("<dev string:xa8>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:xa8>"]);
                printtoprightln("<dev string:xb9>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:xb9>"]);
                printtoprightln("<dev string:xcd>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:xcd>"]);
                printtoprightln("<dev string:xe9>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:xe9>"]);
                printtoprightln("<dev string:xfd>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:xfd>"]);
                printtoprightln("<dev string:x113>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x113>"]);
                printtoprightln("<dev string:x11e>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x11e>"]);
                printtoprightln("<dev string:x12d>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x12d>"]);
                printtoprightln("<dev string:x13c>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x13c>"]);
                printtoprightln("<dev string:x149>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x149>"]);
                printtoprightln("<dev string:x162>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x162>"]);
                printtoprightln("<dev string:x177>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x177>"]);
                printtoprightln("<dev string:x18a>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x18a>"]);
                printtoprightln("<dev string:x19d>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x19d>"]);
                printtoprightln("<dev string:x1b4>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x1b4>"]);
                printtoprightln("<dev string:x1cb>" + "<dev string:x62>" + "<dev string:x1d7>" + level.var_b1955bd6 + "<dev string:x1e1>" + level.var_d0e37460 + "<dev string:x1e9>" + level.var_a9e78bf7["<dev string:x1cb>"]);
                printtoprightln("<dev string:x1eb>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x1eb>"]);
                printtoprightln("<dev string:x1fc>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x1fc>"]);
                printtoprightln("<dev string:x208>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x208>"]);
                printtoprightln("<dev string:x213>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x213>"]);
                printtoprightln("<dev string:x221>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x221>"]);
                printtoprightln("<dev string:x230>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x230>"]);
                printtoprightln("<dev string:x23f>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x23f>"]);
                printtoprightln("<dev string:x250>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x250>"]);
                printtoprightln("<dev string:x260>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x260>"]);
                printtoprightln("<dev string:x270>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x270>"]);
                printtoprightln("<dev string:x282>" + "<dev string:x62>" + level.var_a9e78bf7["<dev string:x282>"]);
            }
            wait 0.05;
        }
    }

    // Namespace namespace_2e795785
    // Params 0, eflags: 0x1 linked
    // Checksum 0x81f50a35, Offset: 0x8c0
    // Size: 0x248
    function function_10489e30() {
        setdvar("<dev string:x295>", 0);
        while (true) {
            if (isdefined(level.var_5deb2d16) && (getdvarstring("<dev string:x295>") == "<dev string:x50>" || level.var_5deb2d16)) {
                skiptos = getskiptos();
                if (!isdefined(level.var_c7b985ff)) {
                    level.var_c7b985ff = newhudelem();
                    level.var_c7b985ff.alignx = "<dev string:x2a9>";
                    level.var_c7b985ff.aligny = "<dev string:x2b0>";
                    level.var_c7b985ff.x = -56;
                    level.var_c7b985ff.y = 100;
                    level.var_c7b985ff.fontscale = 2;
                    level.var_c7b985ff.sort = 20;
                    level.var_c7b985ff.alpha = 1;
                    level.var_c7b985ff.color = (0.8, 0.8, 0.8);
                    level.var_c7b985ff.font = "<dev string:x2b7>";
                }
                prefix = "<dev string:x2bd>";
                if (isdefined(level.var_5deb2d16) && level.var_5deb2d16) {
                    prefix = "<dev string:x2be>";
                }
                if (isdefined(level.var_c0e97bd)) {
                    level.var_c7b985ff settext(prefix + "<dev string:x2c8>" + level.var_c0e97bd);
                } else {
                    level.var_c7b985ff settext(prefix + "<dev string:x2c8>" + "<dev string:x2bd>");
                }
            } else if (isdefined(level.var_c7b985ff)) {
                level.var_c7b985ff destroy();
            }
            wait 0.05;
        }
    }

    // Namespace namespace_2e795785
    // Params 0, eflags: 0x0
    // Checksum 0x6488e7fc, Offset: 0xb10
    // Size: 0x250
    function function_a2a8d5a6() {
        setdvar("<dev string:x2d1>", 0);
        nodes = getallnodes();
        while (true) {
            if (getdvarstring("<dev string:x2d1>") == "<dev string:x50>") {
                level.var_915cfc91 = [];
                foreach (node in nodes) {
                    if (node.type == "<dev string:x2ee>" || node.type == "<dev string:x2f4>") {
                        if (isdefined(node.script_noteworthy) && node.script_noteworthy == "<dev string:x2f8>") {
                            if (!isinarray(level.var_915cfc91, node.animscript)) {
                                level.var_915cfc91[level.var_915cfc91.size] = node.animscript;
                            }
                        }
                    }
                }
                foreach (animscript in level.var_915cfc91) {
                    println("<dev string:x309>" + animscript);
                }
            }
            setdvar("<dev string:x2d1>", 0);
            wait 0.1;
        }
    }

#/
