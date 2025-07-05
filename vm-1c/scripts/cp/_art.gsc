#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace art;

// Namespace art
// Params 0, eflags: 0x2
// Checksum 0x3c15d7ad, Offset: 0xe0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("art", &__init__, undefined, undefined);
}

// Namespace art
// Params 0, eflags: 0x0
// Checksum 0x1dd76bb5, Offset: 0x120
// Size: 0x234
function __init__() {
    /#
        if (getdvarstring("<dev string:x28>") == "<dev string:x36>" || getdvarstring("<dev string:x28>") == "<dev string:x37>") {
            setdvar("<dev string:x28>", 0);
        }
        if (getdvarstring("<dev string:x39>") == "<dev string:x36>") {
            setdvar("<dev string:x39>", "<dev string:x48>");
        }
        if (getdvarstring("<dev string:x4a>") == "<dev string:x36>") {
            setdvar("<dev string:x4a>", "<dev string:x48>");
        }
        if (getdvarstring("<dev string:x62>") == "<dev string:x36>" && isdefined(level.script)) {
            setdvar("<dev string:x62>", level.script);
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
// Params 2, eflags: 0x0
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
        fogall = strtok_loc(getdvarstring("<dev string:x75>"), "<dev string:x88>");
        red = fogall[0];
        green = fogall[1];
        blue = fogall[2];
        halfplane = getdvarstring("<dev string:x8a>");
        nearplane = getdvarstring("<dev string:xa0>");
        if (!isdefined(red) || !isdefined(green) || !isdefined(blue) || !isdefined(halfplane)) {
            red = 1;
            green = 1;
            blue = 1;
            halfplane = 10000001;
            nearplane = 10000000;
        }
        setdvar("<dev string:xb7>", halfplane);
        setdvar("<dev string:xcd>", nearplane);
        setdvar("<dev string:xdf>", red + "<dev string:x88>" + green + "<dev string:x88>" + blue);
    }

    // Namespace art
    // Params 0, eflags: 0x0
    // Checksum 0xad62ddc, Offset: 0x658
    // Size: 0x960
    function tweakart() {
        if (!isdefined(level.tweakfile)) {
            level.tweakfile = 0;
        }
        if (getdvarstring("<dev string:xed>") == "<dev string:x36>") {
            setdvar("<dev string:xb7>", "<dev string:x100>");
            setdvar("<dev string:x104>", "<dev string:x100>");
            setdvar("<dev string:xcd>", "<dev string:x37>");
            setdvar("<dev string:xed>", "<dev string:x37>");
        }
        setdvar("<dev string:x11b>", "<dev string:x12c>");
        setdvar("<dev string:x130>", "<dev string:x37>");
        setdvar("<dev string:x13d>", "<dev string:x37>");
        setdvar("<dev string:x155>", level.dofdefault["<dev string:x167>"]);
        setdvar("<dev string:x171>", level.dofdefault["<dev string:x181>"]);
        setdvar("<dev string:x189>", level.dofdefault["<dev string:x19a>"]);
        setdvar("<dev string:x1a3>", level.dofdefault["<dev string:x1b2>"]);
        setdvar("<dev string:x1b9>", level.dofdefault["<dev string:x1ca>"]);
        setdvar("<dev string:x1d3>", level.dofdefault["<dev string:x1e3>"]);
        file = undefined;
        filename = undefined;
        tweak_toggle = 1;
        for (;;) {
            while (getdvarint("<dev string:x28>") == 0) {
                tweak_toggle = 1;
                wait 0.05;
            }
            if (tweak_toggle) {
                tweak_toggle = 0;
                fogsettings = getfogsettings();
                setdvar("<dev string:xcd>", fogsettings[0]);
                setdvar("<dev string:xb7>", fogsettings[1]);
                setdvar("<dev string:x104>", fogsettings[3]);
                setdvar("<dev string:xed>", fogsettings[2]);
                setdvar("<dev string:xdf>", fogsettings[4] + "<dev string:x88>" + fogsettings[5] + "<dev string:x88>" + fogsettings[6]);
                setdvar("<dev string:x1eb>", fogsettings[7]);
                setdvar("<dev string:x1ff>", fogsettings[8] + "<dev string:x88>" + fogsettings[9] + "<dev string:x88>" + fogsettings[10]);
                level.fogsundir = [];
                level.fogsundir[0] = fogsettings[11];
                level.fogsundir[1] = fogsettings[12];
                level.fogsundir[2] = fogsettings[13];
                setdvar("<dev string:x211>", fogsettings[14]);
                setdvar("<dev string:x229>", fogsettings[15]);
                setdvar("<dev string:x23f>", fogsettings[16]);
            }
            level.fogexphalfplane = getdvarfloat("<dev string:xb7>");
            level.fogexphalfheight = getdvarfloat("<dev string:x104>");
            level.fognearplane = getdvarfloat("<dev string:xcd>");
            level.fogbaseheight = getdvarfloat("<dev string:xed>");
            colors = strtok(getdvarstring("<dev string:xdf>"), "<dev string:x88>");
            level.fogcolorred = int(colors[0]);
            level.fogcolorgreen = int(colors[1]);
            level.fogcolorblue = int(colors[2]);
            level.fogcolorscale = getdvarfloat("<dev string:x1eb>");
            colors = strtok(getdvarstring("<dev string:x1ff>"), "<dev string:x88>");
            level.sunfogcolorred = int(colors[0]);
            level.sunfogcolorgreen = int(colors[1]);
            level.sunfogcolorblue = int(colors[2]);
            level.sunstartangle = getdvarfloat("<dev string:x211>");
            level.sunendangle = getdvarfloat("<dev string:x229>");
            level.fogmaxopacity = getdvarfloat("<dev string:x23f>");
            if (getdvarint("<dev string:x13d>")) {
                setdvar("<dev string:x13d>", "<dev string:x37>");
                println("<dev string:x253>");
                players = getplayers();
                dir = vectornormalize(anglestoforward(players[0] getplayerangles()));
                level.fogsundir = [];
                level.fogsundir[0] = dir[0];
                level.fogsundir[1] = dir[1];
                level.fogsundir[2] = dir[2];
            }
            fovslidercheck();
            dumpsettings();
            if (!getdvarint("<dev string:x281>")) {
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
            wait 0.1;
        }
    }

    // Namespace art
    // Params 0, eflags: 0x0
    // Checksum 0x8aa4dfdd, Offset: 0xfc0
    // Size: 0x2dc
    function fovslidercheck() {
        if (level.dofdefault["<dev string:x167>"] >= level.dofdefault["<dev string:x181>"]) {
            level.dofdefault["<dev string:x167>"] = level.dofdefault["<dev string:x181>"] - 1;
            setdvar("<dev string:x155>", level.dofdefault["<dev string:x167>"]);
        }
        if (level.dofdefault["<dev string:x181>"] <= level.dofdefault["<dev string:x167>"]) {
            level.dofdefault["<dev string:x181>"] = level.dofdefault["<dev string:x167>"] + 1;
            setdvar("<dev string:x171>", level.dofdefault["<dev string:x181>"]);
        }
        if (level.dofdefault["<dev string:x19a>"] >= level.dofdefault["<dev string:x1b2>"]) {
            level.dofdefault["<dev string:x19a>"] = level.dofdefault["<dev string:x1b2>"] - 1;
            setdvar("<dev string:x189>", level.dofdefault["<dev string:x19a>"]);
        }
        if (level.dofdefault["<dev string:x1b2>"] <= level.dofdefault["<dev string:x19a>"]) {
            level.dofdefault["<dev string:x1b2>"] = level.dofdefault["<dev string:x19a>"] + 1;
            setdvar("<dev string:x1a3>", level.dofdefault["<dev string:x1b2>"]);
        }
        if (level.dofdefault["<dev string:x1e3>"] >= level.dofdefault["<dev string:x1ca>"]) {
            level.dofdefault["<dev string:x1e3>"] = level.dofdefault["<dev string:x1ca>"] - 0.1;
            setdvar("<dev string:x1d3>", level.dofdefault["<dev string:x1e3>"]);
        }
        if (level.dofdefault["<dev string:x19a>"] <= level.dofdefault["<dev string:x181>"]) {
            level.dofdefault["<dev string:x19a>"] = level.dofdefault["<dev string:x181>"] + 1;
            setdvar("<dev string:x189>", level.dofdefault["<dev string:x19a>"]);
        }
    }

    // Namespace art
    // Params 0, eflags: 0x0
    // Checksum 0xb77dd255, Offset: 0x12a8
    // Size: 0x404
    function dumpsettings() {
        if (getdvarstring("<dev string:x130>") != "<dev string:x37>") {
            println("<dev string:x291>" + level.fognearplane + "<dev string:x2a0>");
            println("<dev string:x2a2>" + level.fogexphalfplane + "<dev string:x2a0>");
            println("<dev string:x2b0>" + level.fogexphalfheight + "<dev string:x2a0>");
            println("<dev string:x2c0>" + level.fogbaseheight + "<dev string:x2a0>");
            println("<dev string:x2d0>" + level.fogcolorred + "<dev string:x2a0>");
            println("<dev string:x2da>" + level.fogcolorgreen + "<dev string:x2a0>");
            println("<dev string:x2e4>" + level.fogcolorblue + "<dev string:x2a0>");
            println("<dev string:x2ee>" + level.fogcolorscale + "<dev string:x2a0>");
            println("<dev string:x2fc>" + level.sunfogcolorred + "<dev string:x2a0>");
            println("<dev string:x30a>" + level.sunfogcolorgreen + "<dev string:x2a0>");
            println("<dev string:x318>" + level.sunfogcolorblue + "<dev string:x2a0>");
            println("<dev string:x326>" + level.fogsundir[0] + "<dev string:x2a0>");
            println("<dev string:x334>" + level.fogsundir[1] + "<dev string:x2a0>");
            println("<dev string:x342>" + level.fogsundir[2] + "<dev string:x2a0>");
            println("<dev string:x350>" + level.sunstartangle + "<dev string:x2a0>");
            println("<dev string:x362>" + level.sunendangle + "<dev string:x2a0>");
            println("<dev string:x373>");
            println("<dev string:x37e>" + level.fogmaxopacity + "<dev string:x2a0>");
            println("<dev string:x36>");
            println("<dev string:x392>");
            println("<dev string:x3ee>");
            println("<dev string:x442>");
            setdvar("<dev string:x130>", "<dev string:x37>");
        }
    }

#/
