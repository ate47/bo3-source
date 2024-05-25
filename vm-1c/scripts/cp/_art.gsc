#using scripts/shared/util_shared;
#using scripts/shared/system_shared;

#namespace art;

// Namespace art
// Params 0, eflags: 0x2
// Checksum 0x3c15d7ad, Offset: 0xe0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("art", &__init__, undefined, undefined);
}

// Namespace art
// Params 0, eflags: 0x1 linked
// Checksum 0x1dd76bb5, Offset: 0x120
// Size: 0x234
function __init__() {
    /#
        if (getdvarstring(" ") == " " || getdvarstring(" ") == " ") {
            setdvar(" ", 0);
        }
        if (getdvarstring(" ") == " ") {
            setdvar(" ", " ");
        }
        if (getdvarstring(" ") == " ") {
            setdvar(" ", " ");
        }
        if (getdvarstring(" ") == " " && isdefined(level.script)) {
            setdvar(" ", level.script);
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
}

/#

    // Namespace art
    // Params 2, eflags: 0x0
    // Checksum 0x3e51d20e, Offset: 0x360
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
// Checksum 0xd3e0c415, Offset: 0x3b0
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

/#

    // Namespace art
    // Params 0, eflags: 0x0
    // Checksum 0x44a9f1df, Offset: 0x490
    // Size: 0x1bc
    function setfogsliders() {
        fogall = strtok_loc(getdvarstring(" "), " ");
        red = fogall[0];
        green = fogall[1];
        blue = fogall[2];
        halfplane = getdvarstring(" ");
        nearplane = getdvarstring(" ");
        if (!isdefined(red) || !isdefined(green) || !isdefined(blue) || !isdefined(halfplane)) {
            red = 1;
            green = 1;
            blue = 1;
            halfplane = 10000001;
            nearplane = 10000000;
        }
        setdvar(" ", halfplane);
        setdvar(" ", nearplane);
        setdvar(" ", red + " " + green + " " + blue);
    }

    // Namespace art
    // Params 0, eflags: 0x1 linked
    // Checksum 0xad62ddc, Offset: 0x658
    // Size: 0x960
    function tweakart() {
        if (!isdefined(level.tweakfile)) {
            level.tweakfile = 0;
        }
        if (getdvarstring(" ") == " ") {
            setdvar(" ", " ");
            setdvar(" ", " ");
            setdvar(" ", " ");
            setdvar(" ", " ");
        }
        setdvar(" ", " ");
        setdvar(" ", " ");
        setdvar(" ", " ");
        setdvar(" ", level.dofdefault[" "]);
        setdvar(" ", level.dofdefault[" "]);
        setdvar(" ", level.dofdefault[" "]);
        setdvar(" ", level.dofdefault[" "]);
        setdvar(" ", level.dofdefault[" "]);
        setdvar(" ", level.dofdefault[" "]);
        file = undefined;
        filename = undefined;
        tweak_toggle = 1;
        for (;;) {
            while (getdvarint(" ") == 0) {
                tweak_toggle = 1;
                wait(0.05);
            }
            if (tweak_toggle) {
                tweak_toggle = 0;
                fogsettings = getfogsettings();
                setdvar(" ", fogsettings[0]);
                setdvar(" ", fogsettings[1]);
                setdvar(" ", fogsettings[3]);
                setdvar(" ", fogsettings[2]);
                setdvar(" ", fogsettings[4] + " " + fogsettings[5] + " " + fogsettings[6]);
                setdvar(" ", fogsettings[7]);
                setdvar(" ", fogsettings[8] + " " + fogsettings[9] + " " + fogsettings[10]);
                level.fogsundir = [];
                level.fogsundir[0] = fogsettings[11];
                level.fogsundir[1] = fogsettings[12];
                level.fogsundir[2] = fogsettings[13];
                setdvar(" ", fogsettings[14]);
                setdvar(" ", fogsettings[15]);
                setdvar(" ", fogsettings[16]);
            }
            level.fogexphalfplane = getdvarfloat(" ");
            level.fogexphalfheight = getdvarfloat(" ");
            level.fognearplane = getdvarfloat(" ");
            level.fogbaseheight = getdvarfloat(" ");
            colors = strtok(getdvarstring(" "), " ");
            level.fogcolorred = int(colors[0]);
            level.fogcolorgreen = int(colors[1]);
            level.fogcolorblue = int(colors[2]);
            level.fogcolorscale = getdvarfloat(" ");
            colors = strtok(getdvarstring(" "), " ");
            level.sunfogcolorred = int(colors[0]);
            level.sunfogcolorgreen = int(colors[1]);
            level.sunfogcolorblue = int(colors[2]);
            level.sunstartangle = getdvarfloat(" ");
            level.sunendangle = getdvarfloat(" ");
            level.fogmaxopacity = getdvarfloat(" ");
            if (getdvarint(" ")) {
                setdvar(" ", " ");
                println(" ");
                players = getplayers();
                dir = vectornormalize(anglestoforward(players[0] getplayerangles()));
                level.fogsundir = [];
                level.fogsundir[0] = dir[0];
                level.fogsundir[1] = dir[1];
                level.fogsundir[2] = dir[2];
            }
            fovslidercheck();
            dumpsettings();
            if (!getdvarint(" ")) {
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

    // Namespace art
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8aa4dfdd, Offset: 0xfc0
    // Size: 0x2dc
    function fovslidercheck() {
        if (level.dofdefault[" "] >= level.dofdefault[" "]) {
            level.dofdefault[" "] = level.dofdefault[" "] - 1;
            setdvar(" ", level.dofdefault[" "]);
        }
        if (level.dofdefault[" "] <= level.dofdefault[" "]) {
            level.dofdefault[" "] = level.dofdefault[" "] + 1;
            setdvar(" ", level.dofdefault[" "]);
        }
        if (level.dofdefault[" "] >= level.dofdefault[" "]) {
            level.dofdefault[" "] = level.dofdefault[" "] - 1;
            setdvar(" ", level.dofdefault[" "]);
        }
        if (level.dofdefault[" "] <= level.dofdefault[" "]) {
            level.dofdefault[" "] = level.dofdefault[" "] + 1;
            setdvar(" ", level.dofdefault[" "]);
        }
        if (level.dofdefault[" "] >= level.dofdefault[" "]) {
            level.dofdefault[" "] = level.dofdefault[" "] - 0.1;
            setdvar(" ", level.dofdefault[" "]);
        }
        if (level.dofdefault[" "] <= level.dofdefault[" "]) {
            level.dofdefault[" "] = level.dofdefault[" "] + 1;
            setdvar(" ", level.dofdefault[" "]);
        }
    }

    // Namespace art
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb77dd255, Offset: 0x12a8
    // Size: 0x404
    function dumpsettings() {
        if (getdvarstring(" ") != " ") {
            println(" " + level.fognearplane + " ");
            println(" " + level.fogexphalfplane + " ");
            println(" " + level.fogexphalfheight + " ");
            println(" " + level.fogbaseheight + " ");
            println(" " + level.fogcolorred + " ");
            println(" " + level.fogcolorgreen + " ");
            println(" " + level.fogcolorblue + " ");
            println(" " + level.fogcolorscale + " ");
            println(" " + level.sunfogcolorred + " ");
            println(" " + level.sunfogcolorgreen + " ");
            println(" " + level.sunfogcolorblue + " ");
            println(" " + level.fogsundir[0] + " ");
            println(" " + level.fogsundir[1] + " ");
            println(" " + level.fogsundir[2] + " ");
            println(" " + level.sunstartangle + " ");
            println(" " + level.sunendangle + " ");
            println(" ");
            println(" " + level.fogmaxopacity + " ");
            println(" ");
            println(" ");
            println(" ");
            println(" ");
            setdvar(" ", " ");
        }
    }

#/
