#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace art;

// Namespace art
// Params 0, eflags: 0x2
// namespace_3fbd273c<file_0>::function_2dc19561
// Checksum 0x4bed714a, Offset: 0x1d0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("art", &__init__, undefined, undefined);
}

// Namespace art
// Params 0, eflags: 0x1 linked
// namespace_3fbd273c<file_0>::function_8c87d8eb
// Checksum 0x23317b66, Offset: 0x210
// Size: 0x26c
function __init__() {
    /#
        if (getdvarstring("") == "" || getdvarstring("") == "") {
            setdvar("", 0);
        }
        if (getdvarstring("") == "") {
            setdvar("", "");
        }
        if (getdvarstring("") == "") {
            setdvar("", "");
        }
        if (getdvarstring("") == "") {
            setdvar("", level.script);
        }
    #/
    if (!isdefined(level.dofdefault)) {
        level.dofdefault["nearStart"] = 0;
        level.dofdefault["nearEnd"] = 1;
        level.dofdefault["farStart"] = 8000;
        level.dofdefault["farEnd"] = 10000;
        level.dofdefault["nearBlur"] = 6;
        level.dofdefault["farBlur"] = 0;
    }
    level.curdof = (level.dofdefault["farStart"] - level.dofdefault["nearEnd"]) / 2;
    /#
        thread tweakart();
    #/
    if (!isdefined(level.script)) {
        level.script = tolower(getdvarstring("mapname"));
    }
}

/#

    // Namespace art
    // Params 2, eflags: 0x0
    // namespace_3fbd273c<file_0>::function_3aef23e5
    // Checksum 0xfa9c27a1, Offset: 0x488
    // Size: 0x44
    function artfxprintln(file, string) {
        if (file == -1) {
            return;
        }
        fprintln(file, string);
    }

#/

// Namespace art
// Params 2, eflags: 0x1 linked
// namespace_3fbd273c<file_0>::function_393e0a6f
// Checksum 0xc7a63654, Offset: 0x4d8
// Size: 0xd4
function strtok_loc(string, par1) {
    stringlist = [];
    indexstring = "";
    for (i = 0; i < string.size; i++) {
        if (string[i] == " ") {
            stringlist[stringlist.size] = indexstring;
            indexstring = "";
            continue;
        }
        indexstring += string[i];
    }
    if (indexstring.size) {
        stringlist[stringlist.size] = indexstring;
    }
    return stringlist;
}

// Namespace art
// Params 0, eflags: 0x0
// namespace_3fbd273c<file_0>::function_e61ed21d
// Checksum 0xbba05d5d, Offset: 0x5b8
// Size: 0x1b4
function setfogsliders() {
    fogall = strtok_loc(getdvarstring("g_fogColorReadOnly"), " ");
    red = fogall[0];
    green = fogall[1];
    blue = fogall[2];
    halfplane = getdvarstring("g_fogHalfDistReadOnly");
    nearplane = getdvarstring("g_fogStartDistReadOnly");
    if (!isdefined(red) || !isdefined(green) || !isdefined(blue) || !isdefined(halfplane)) {
        red = 1;
        green = 1;
        blue = 1;
        halfplane = 10000001;
        nearplane = 10000000;
    }
    setdvar("scr_fog_exp_halfplane", halfplane);
    setdvar("scr_fog_nearplane", nearplane);
    setdvar("scr_fog_color", red + " " + green + " " + blue);
}

/#

    // Namespace art
    // Params 0, eflags: 0x1 linked
    // namespace_3fbd273c<file_0>::function_2156b2de
    // Checksum 0xf1af3530, Offset: 0x778
    // Size: 0x960
    function tweakart() {
        if (!isdefined(level.tweakfile)) {
            level.tweakfile = 0;
        }
        if (getdvarstring("") == "") {
            setdvar("", "");
            setdvar("", "");
            setdvar("", "");
            setdvar("", "");
        }
        setdvar("", "");
        setdvar("", "");
        setdvar("", "");
        setdvar("", level.dofdefault[""]);
        setdvar("", level.dofdefault[""]);
        setdvar("", level.dofdefault[""]);
        setdvar("", level.dofdefault[""]);
        setdvar("", level.dofdefault[""]);
        setdvar("", level.dofdefault[""]);
        file = undefined;
        filename = undefined;
        tweak_toggle = 1;
        for (;;) {
            while (getdvarint("") == 0) {
                tweak_toggle = 1;
                wait(0.05);
            }
            if (tweak_toggle) {
                tweak_toggle = 0;
                fogsettings = getfogsettings();
                setdvar("", fogsettings[0]);
                setdvar("", fogsettings[1]);
                setdvar("", fogsettings[3]);
                setdvar("", fogsettings[2]);
                setdvar("", fogsettings[4] + "" + fogsettings[5] + "" + fogsettings[6]);
                setdvar("", fogsettings[7]);
                setdvar("", fogsettings[8] + "" + fogsettings[9] + "" + fogsettings[10]);
                level.fogsundir = [];
                level.fogsundir[0] = fogsettings[11];
                level.fogsundir[1] = fogsettings[12];
                level.fogsundir[2] = fogsettings[13];
                setdvar("", fogsettings[14]);
                setdvar("", fogsettings[15]);
                setdvar("", fogsettings[16]);
            }
            level.fogexphalfplane = getdvarfloat("");
            level.fogexphalfheight = getdvarfloat("");
            level.fognearplane = getdvarfloat("");
            level.fogbaseheight = getdvarfloat("");
            colors = strtok(getdvarstring(""), "");
            level.fogcolorred = int(colors[0]);
            level.fogcolorgreen = int(colors[1]);
            level.fogcolorblue = int(colors[2]);
            level.fogcolorscale = getdvarfloat("");
            colors = strtok(getdvarstring(""), "");
            level.sunfogcolorred = int(colors[0]);
            level.sunfogcolorgreen = int(colors[1]);
            level.sunfogcolorblue = int(colors[2]);
            level.sunstartangle = getdvarfloat("");
            level.sunendangle = getdvarfloat("");
            level.fogmaxopacity = getdvarfloat("");
            if (getdvarint("")) {
                setdvar("", "");
                println("");
                players = getplayers();
                dir = vectornormalize(anglestoforward(players[0] getplayerangles()));
                level.fogsundir = [];
                level.fogsundir[0] = dir[0];
                level.fogsundir[1] = dir[1];
                level.fogsundir[2] = dir[2];
            }
            fovslidercheck();
            dumpsettings();
            if (!getdvarint("")) {
                if (!isdefined(level.fogsundir)) {
                    level.fogsundir = [];
                    level.fogsundir[0] = 1;
                    level.fogsundir[1] = 0;
                    level.fogsundir[2] = 0;
                }
                setvolfog(level.fognearplane, level.fogexphalfplane, level.fogexphalfheight, level.fogbaseheight, level.fogcolorred, level.fogcolorgreen, level.fogcolorblue, level.fogcolorscale, level.sunfogcolorred, level.sunfogcolorgreen, level.sunfogcolorblue, level.fogsundir[0], level.fogsundir[1], level.fogsundir[2], level.sunstartangle, level.sunendangle, 0, level.fogmaxopacity);
            } else {
                setexpfog(100000000, 100000001, 0, 0, 0, 0);
            }
            wait(0.1);
        }
    }

#/

// Namespace art
// Params 0, eflags: 0x1 linked
// namespace_3fbd273c<file_0>::function_bf2db7af
// Checksum 0x106eb74a, Offset: 0x10e0
// Size: 0x2d4
function fovslidercheck() {
    if (level.dofdefault["nearStart"] >= level.dofdefault["nearEnd"]) {
        level.dofdefault["nearStart"] = level.dofdefault["nearEnd"] - 1;
        setdvar("scr_dof_nearStart", level.dofdefault["nearStart"]);
    }
    if (level.dofdefault["nearEnd"] <= level.dofdefault["nearStart"]) {
        level.dofdefault["nearEnd"] = level.dofdefault["nearStart"] + 1;
        setdvar("scr_dof_nearEnd", level.dofdefault["nearEnd"]);
    }
    if (level.dofdefault["farStart"] >= level.dofdefault["farEnd"]) {
        level.dofdefault["farStart"] = level.dofdefault["farEnd"] - 1;
        setdvar("scr_dof_farStart", level.dofdefault["farStart"]);
    }
    if (level.dofdefault["farEnd"] <= level.dofdefault["farStart"]) {
        level.dofdefault["farEnd"] = level.dofdefault["farStart"] + 1;
        setdvar("scr_dof_farEnd", level.dofdefault["farEnd"]);
    }
    if (level.dofdefault["farBlur"] >= level.dofdefault["nearBlur"]) {
        level.dofdefault["farBlur"] = level.dofdefault["nearBlur"] - 0.1;
        setdvar("scr_dof_farBlur", level.dofdefault["farBlur"]);
    }
    if (level.dofdefault["farStart"] <= level.dofdefault["nearEnd"]) {
        level.dofdefault["farStart"] = level.dofdefault["nearEnd"] + 1;
        setdvar("scr_dof_farStart", level.dofdefault["farStart"]);
    }
}

/#

    // Namespace art
    // Params 0, eflags: 0x1 linked
    // namespace_3fbd273c<file_0>::function_bf41deac
    // Checksum 0x8d4d7218, Offset: 0x13c0
    // Size: 0x404
    function dumpsettings() {
        if (getdvarstring("") != "") {
            println("" + level.fognearplane + "");
            println("" + level.fogexphalfplane + "");
            println("" + level.fogexphalfheight + "");
            println("" + level.fogbaseheight + "");
            println("" + level.fogcolorred + "");
            println("" + level.fogcolorgreen + "");
            println("" + level.fogcolorblue + "");
            println("" + level.fogcolorscale + "");
            println("" + level.sunfogcolorred + "");
            println("" + level.sunfogcolorgreen + "");
            println("" + level.sunfogcolorblue + "");
            println("" + level.fogsundir[0] + "");
            println("" + level.fogsundir[1] + "");
            println("" + level.fogsundir[2] + "");
            println("" + level.sunstartangle + "");
            println("" + level.sunendangle + "");
            println("");
            println("" + level.fogmaxopacity + "");
            println("");
            println("");
            println("");
            println("");
            setdvar("", "");
        }
    }

#/
