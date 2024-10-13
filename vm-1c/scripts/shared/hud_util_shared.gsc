#using scripts/shared/util_shared;
#using scripts/shared/lui_shared;
#using scripts/codescripts/struct;

#namespace hud;

// Namespace hud
// Params 1, eflags: 0x1 linked
// Checksum 0x44b1a20e, Offset: 0x2e0
// Size: 0xdc
function setparent(element) {
    if (isdefined(self.parent) && self.parent == element) {
        return;
    }
    if (isdefined(self.parent)) {
        self.parent removechild(self);
    }
    self.parent = element;
    self.parent addchild(self);
    if (isdefined(self.point)) {
        self setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
        return;
    }
    self setpoint("TOP");
}

// Namespace hud
// Params 0, eflags: 0x1 linked
// Checksum 0x6adbf6ac, Offset: 0x3c8
// Size: 0xa
function getparent() {
    return self.parent;
}

// Namespace hud
// Params 1, eflags: 0x1 linked
// Checksum 0xebb23835, Offset: 0x3e0
// Size: 0x3a
function addchild(element) {
    element.index = self.children.size;
    self.children[self.children.size] = element;
}

// Namespace hud
// Params 1, eflags: 0x1 linked
// Checksum 0x6b0da04e, Offset: 0x428
// Size: 0xc6
function removechild(element) {
    element.parent = undefined;
    if (self.children[self.children.size - 1] != element) {
        self.children[element.index] = self.children[self.children.size - 1];
        self.children[element.index].index = element.index;
    }
    self.children[self.children.size - 1] = undefined;
    element.index = undefined;
}

// Namespace hud
// Params 5, eflags: 0x1 linked
// Checksum 0xba0f5e96, Offset: 0x4f8
// Size: 0x834
function setpoint(point, relativepoint, xoffset, yoffset, movetime) {
    if (!isdefined(movetime)) {
        movetime = 0;
    }
    element = self getparent();
    if (movetime) {
        self moveovertime(movetime);
    }
    if (!isdefined(xoffset)) {
        xoffset = 0;
    }
    self.xoffset = xoffset;
    if (!isdefined(yoffset)) {
        yoffset = 0;
    }
    self.yoffset = yoffset;
    self.point = point;
    self.alignx = "center";
    self.aligny = "middle";
    switch (point) {
    case "CENTER":
        break;
    case "TOP":
        self.aligny = "top";
        break;
    case "BOTTOM":
        self.aligny = "bottom";
        break;
    case "LEFT":
        self.alignx = "left";
        break;
    case "RIGHT":
        self.alignx = "right";
        break;
    case "TOPRIGHT":
    case "TOP_RIGHT":
        self.aligny = "top";
        self.alignx = "right";
        break;
    case "TOPLEFT":
    case "TOP_LEFT":
        self.aligny = "top";
        self.alignx = "left";
        break;
    case "TOPCENTER":
        self.aligny = "top";
        self.alignx = "center";
        break;
    case "BOTTOM RIGHT":
    case "BOTTOM_RIGHT":
        self.aligny = "bottom";
        self.alignx = "right";
        break;
    case "BOTTOM LEFT":
    case "BOTTOM_LEFT":
        self.aligny = "bottom";
        self.alignx = "left";
        break;
    default:
        println("<dev string:x28>" + point);
        break;
    }
    if (!isdefined(relativepoint)) {
        relativepoint = point;
    }
    self.relativepoint = relativepoint;
    relativex = "center";
    relativey = "middle";
    switch (relativepoint) {
    case "CENTER":
        break;
    case "TOP":
        relativey = "top";
        break;
    case "BOTTOM":
        relativey = "bottom";
        break;
    case "LEFT":
        relativex = "left";
        break;
    case "RIGHT":
        relativex = "right";
        break;
    case "TOPRIGHT":
    case "TOP_RIGHT":
        relativey = "top";
        relativex = "right";
        break;
    case "TOPLEFT":
    case "TOP_LEFT":
        relativey = "top";
        relativex = "left";
        break;
    case "TOPCENTER":
        relativey = "top";
        relativex = "center";
        break;
    case "BOTTOM RIGHT":
    case "BOTTOM_RIGHT":
        relativey = "bottom";
        relativex = "right";
        break;
    case "BOTTOM LEFT":
    case "BOTTOM_LEFT":
        relativey = "bottom";
        relativex = "left";
        break;
    default:
        println("<dev string:x58>" + relativepoint);
        break;
    }
    if (element == level.uiparent) {
        self.horzalign = relativex;
        self.vertalign = relativey;
    } else {
        self.horzalign = element.horzalign;
        self.vertalign = element.vertalign;
    }
    if (relativex == element.alignx) {
        offsetx = 0;
        xfactor = 0;
    } else if (relativex == "center" || element.alignx == "center") {
        offsetx = int(element.width / 2);
        if (relativex == "left" || element.alignx == "right") {
            xfactor = -1;
        } else {
            xfactor = 1;
        }
    } else {
        offsetx = element.width;
        if (relativex == "left") {
            xfactor = -1;
        } else {
            xfactor = 1;
        }
    }
    self.x = element.x + offsetx * xfactor;
    if (relativey == element.aligny) {
        offsety = 0;
        yfactor = 0;
    } else if (relativey == "middle" || element.aligny == "middle") {
        offsety = int(element.height / 2);
        if (relativey == "top" || element.aligny == "bottom") {
            yfactor = -1;
        } else {
            yfactor = 1;
        }
    } else {
        offsety = element.height;
        if (relativey == "top") {
            yfactor = -1;
        } else {
            yfactor = 1;
        }
    }
    self.y = element.y + offsety * yfactor;
    self.x += self.xoffset;
    self.y += self.yoffset;
    switch (self.elemtype) {
    case "bar":
        setpointbar(point, relativepoint, xoffset, yoffset);
        self.barframe setparent(self getparent());
        self.barframe setpoint(point, relativepoint, xoffset, yoffset);
        break;
    }
    self updatechildren();
}

// Namespace hud
// Params 4, eflags: 0x1 linked
// Checksum 0x2b7dbbe2, Offset: 0xd38
// Size: 0x1bc
function setpointbar(point, relativepoint, xoffset, yoffset) {
    self.bar.horzalign = self.horzalign;
    self.bar.vertalign = self.vertalign;
    self.bar.alignx = "left";
    self.bar.aligny = self.aligny;
    self.bar.y = self.y;
    if (self.alignx == "left") {
        self.bar.x = self.x;
    } else if (self.alignx == "right") {
        self.bar.x = self.x - self.width;
    } else {
        self.bar.x = self.x - int(self.width / 2);
    }
    if (self.aligny == "top") {
        self.bar.y = self.y;
    } else if (self.aligny == "bottom") {
        self.bar.y = self.y;
    }
    self updatebar(self.bar.frac);
}

// Namespace hud
// Params 2, eflags: 0x1 linked
// Checksum 0xed78d51a, Offset: 0xf00
// Size: 0x44
function updatebar(barfrac, rateofchange) {
    if (self.elemtype == "bar") {
        updatebarscale(barfrac, rateofchange);
    }
}

// Namespace hud
// Params 2, eflags: 0x1 linked
// Checksum 0xc9043f0a, Offset: 0xf50
// Size: 0x254
function updatebarscale(barfrac, rateofchange) {
    barwidth = int(self.width * barfrac + 0.5);
    if (!barwidth) {
        barwidth = 1;
    }
    self.bar.frac = barfrac;
    self.bar setshader(self.bar.shader, barwidth, self.height);
    assert(barwidth <= self.width, "<dev string:x90>" + barwidth + "<dev string:xa9>" + self.width + "<dev string:xae>" + barfrac);
    if (isdefined(rateofchange) && barwidth < self.width) {
        if (rateofchange > 0) {
            assert((1 - barfrac) / rateofchange > 0, "<dev string:xbe>" + barfrac + "<dev string:xc8>" + rateofchange);
            self.bar scaleovertime((1 - barfrac) / rateofchange, self.width, self.height);
        } else if (rateofchange < 0) {
            assert(barfrac / -1 * rateofchange > 0, "<dev string:xbe>" + barfrac + "<dev string:xc8>" + rateofchange);
            self.bar scaleovertime(barfrac / -1 * rateofchange, 1, self.height);
        }
    }
    self.bar.rateofchange = rateofchange;
    self.bar.lastupdatetime = gettime();
}

// Namespace hud
// Params 2, eflags: 0x1 linked
// Checksum 0x7d233e29, Offset: 0x11b0
// Size: 0x130
function createfontstring(font, fontscale) {
    fontelem = newclienthudelem(self);
    fontelem.elemtype = "font";
    fontelem.font = font;
    fontelem.fontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.height = int(level.fontheight * fontscale);
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem setparent(level.uiparent);
    fontelem.hidden = 0;
    return fontelem;
}

// Namespace hud
// Params 3, eflags: 0x1 linked
// Checksum 0x6ea1784a, Offset: 0x12e8
// Size: 0x158
function createserverfontstring(font, fontscale, team) {
    if (isdefined(team)) {
        fontelem = newteamhudelem(team);
    } else {
        fontelem = newhudelem();
    }
    fontelem.elemtype = "font";
    fontelem.font = font;
    fontelem.fontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.height = int(level.fontheight * fontscale);
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem setparent(level.uiparent);
    fontelem.hidden = 0;
    return fontelem;
}

// Namespace hud
// Params 3, eflags: 0x1 linked
// Checksum 0x885877fd, Offset: 0x1448
// Size: 0x158
function createservertimer(font, fontscale, team) {
    if (isdefined(team)) {
        timerelem = newteamhudelem(team);
    } else {
        timerelem = newhudelem();
    }
    timerelem.elemtype = "timer";
    timerelem.font = font;
    timerelem.fontscale = fontscale;
    timerelem.x = 0;
    timerelem.y = 0;
    timerelem.width = 0;
    timerelem.height = int(level.fontheight * fontscale);
    timerelem.xoffset = 0;
    timerelem.yoffset = 0;
    timerelem.children = [];
    timerelem setparent(level.uiparent);
    timerelem.hidden = 0;
    return timerelem;
}

// Namespace hud
// Params 2, eflags: 0x0
// Checksum 0xf387cccb, Offset: 0x15a8
// Size: 0x130
function createclienttimer(font, fontscale) {
    timerelem = newclienthudelem(self);
    timerelem.elemtype = "timer";
    timerelem.font = font;
    timerelem.fontscale = fontscale;
    timerelem.x = 0;
    timerelem.y = 0;
    timerelem.width = 0;
    timerelem.height = int(level.fontheight * fontscale);
    timerelem.xoffset = 0;
    timerelem.yoffset = 0;
    timerelem.children = [];
    timerelem setparent(level.uiparent);
    timerelem.hidden = 0;
    return timerelem;
}

// Namespace hud
// Params 3, eflags: 0x1 linked
// Checksum 0x798e9be7, Offset: 0x16e0
// Size: 0x130
function createicon(shader, width, height) {
    iconelem = newclienthudelem(self);
    iconelem.elemtype = "icon";
    iconelem.x = 0;
    iconelem.y = 0;
    iconelem.width = width;
    iconelem.height = height;
    iconelem.xoffset = 0;
    iconelem.yoffset = 0;
    iconelem.children = [];
    iconelem setparent(level.uiparent);
    iconelem.hidden = 0;
    if (isdefined(shader)) {
        iconelem setshader(shader, width, height);
    }
    return iconelem;
}

// Namespace hud
// Params 4, eflags: 0x1 linked
// Checksum 0x168c9662, Offset: 0x1818
// Size: 0x158
function function_d945e9e7(shader, width, height, team) {
    if (isdefined(team)) {
        iconelem = newteamhudelem(team);
    } else {
        iconelem = newhudelem();
    }
    iconelem.elemtype = "icon";
    iconelem.x = 0;
    iconelem.y = 0;
    iconelem.width = width;
    iconelem.height = height;
    iconelem.xoffset = 0;
    iconelem.yoffset = 0;
    iconelem.children = [];
    iconelem setparent(level.uiparent);
    iconelem.hidden = 0;
    if (isdefined(shader)) {
        iconelem setshader(shader, width, height);
    }
    return iconelem;
}

// Namespace hud
// Params 6, eflags: 0x1 linked
// Checksum 0xb0ac180f, Offset: 0x1978
// Size: 0x470
function function_6f88521b(color, width, height, flashfrac, team, selected) {
    if (isdefined(team)) {
        barelem = newteamhudelem(team);
    } else {
        barelem = newhudelem();
    }
    barelem.x = 0;
    barelem.y = 0;
    barelem.frac = 0;
    barelem.color = color;
    barelem.sort = -2;
    barelem.shader = "progress_bar_fill";
    barelem setshader("progress_bar_fill", width, height);
    barelem.hidden = 0;
    if (isdefined(flashfrac)) {
        barelem.flashfrac = flashfrac;
    }
    if (isdefined(team)) {
        barelemframe = newteamhudelem(team);
    } else {
        barelemframe = newhudelem();
    }
    barelemframe.elemtype = "icon";
    barelemframe.x = 0;
    barelemframe.y = 0;
    barelemframe.width = width;
    barelemframe.height = height;
    barelemframe.xoffset = 0;
    barelemframe.yoffset = 0;
    barelemframe.bar = barelem;
    barelemframe.barframe = barelemframe;
    barelemframe.children = [];
    barelemframe.sort = -1;
    barelemframe.color = (1, 1, 1);
    barelemframe setparent(level.uiparent);
    if (isdefined(selected)) {
        barelemframe setshader("progress_bar_fg_sel", width, height);
    } else {
        barelemframe setshader("progress_bar_fg", width, height);
    }
    barelemframe.hidden = 0;
    if (isdefined(team)) {
        barelembg = newteamhudelem(team);
    } else {
        barelembg = newhudelem();
    }
    barelembg.elemtype = "bar";
    barelembg.x = 0;
    barelembg.y = 0;
    barelembg.width = width;
    barelembg.height = height;
    barelembg.xoffset = 0;
    barelembg.yoffset = 0;
    barelembg.bar = barelem;
    barelembg.barframe = barelemframe;
    barelembg.children = [];
    barelembg.sort = -3;
    barelembg.color = (0, 0, 0);
    barelembg.alpha = 0.5;
    barelembg setparent(level.uiparent);
    barelembg setshader("progress_bar_bg", width, height);
    barelembg.hidden = 0;
    return barelembg;
}

// Namespace hud
// Params 4, eflags: 0x1 linked
// Checksum 0x5d150e36, Offset: 0x1df0
// Size: 0x3f0
function createbar(color, width, height, flashfrac) {
    barelem = newclienthudelem(self);
    barelem.x = 0;
    barelem.y = 0;
    barelem.frac = 0;
    barelem.color = color;
    barelem.sort = -2;
    barelem.shader = "progress_bar_fill";
    barelem setshader("progress_bar_fill", width, height);
    barelem.hidden = 0;
    if (isdefined(flashfrac)) {
        barelem.flashfrac = flashfrac;
    }
    barelemframe = newclienthudelem(self);
    barelemframe.elemtype = "icon";
    barelemframe.x = 0;
    barelemframe.y = 0;
    barelemframe.width = width;
    barelemframe.height = height;
    barelemframe.xoffset = 0;
    barelemframe.yoffset = 0;
    barelemframe.bar = barelem;
    barelemframe.barframe = barelemframe;
    barelemframe.children = [];
    barelemframe.sort = -1;
    barelemframe.color = (1, 1, 1);
    barelemframe setparent(level.uiparent);
    barelemframe.hidden = 0;
    barelembg = newclienthudelem(self);
    barelembg.elemtype = "bar";
    if (!level.splitscreen) {
        barelembg.x = -2;
        barelembg.y = -2;
    }
    barelembg.width = width;
    barelembg.height = height;
    barelembg.xoffset = 0;
    barelembg.yoffset = 0;
    barelembg.bar = barelem;
    barelembg.barframe = barelemframe;
    barelembg.children = [];
    barelembg.sort = -3;
    barelembg.color = (0, 0, 0);
    barelembg.alpha = 0.5;
    barelembg setparent(level.uiparent);
    if (!level.splitscreen) {
        barelembg setshader("progress_bar_bg", width + 4, height + 4);
    } else {
        barelembg setshader("progress_bar_bg", width + 0, height + 0);
    }
    barelembg.hidden = 0;
    return barelembg;
}

// Namespace hud
// Params 0, eflags: 0x0
// Checksum 0xc01af5d6, Offset: 0x21e8
// Size: 0x94
function getcurrentfraction() {
    frac = self.bar.frac;
    if (isdefined(self.bar.rateofchange)) {
        frac += (gettime() - self.bar.lastupdatetime) * self.bar.rateofchange;
        if (frac > 1) {
            frac = 1;
        }
        if (frac < 0) {
            frac = 0;
        }
    }
    return frac;
}

// Namespace hud
// Params 0, eflags: 0x1 linked
// Checksum 0x3c4bf479, Offset: 0x2288
// Size: 0xa0
function createprimaryprogressbar() {
    bar = createbar((1, 1, 1), level.primaryprogressbarwidth, level.primaryprogressbarheight);
    if (level.splitscreen) {
        bar setpoint("TOP", undefined, level.primaryprogressbarx, level.primaryprogressbary);
    } else {
        bar setpoint("CENTER", undefined, level.primaryprogressbarx, level.primaryprogressbary);
    }
    return bar;
}

// Namespace hud
// Params 0, eflags: 0x1 linked
// Checksum 0x29ccd3d1, Offset: 0x2330
// Size: 0xac
function createprimaryprogressbartext() {
    text = createfontstring("objective", level.primaryprogressbarfontsize);
    if (level.splitscreen) {
        text setpoint("TOP", undefined, level.primaryprogressbartextx, level.primaryprogressbartexty);
    } else {
        text setpoint("CENTER", undefined, level.primaryprogressbartextx, level.primaryprogressbartexty);
    }
    text.sort = -1;
    return text;
}

// Namespace hud
// Params 0, eflags: 0x0
// Checksum 0xbdf11818, Offset: 0x23e8
// Size: 0x120
function function_2dc3c5fb() {
    secondaryprogressbarheight = getdvarint("scr_secondaryProgressBarHeight", level.secondaryprogressbarheight);
    secondaryprogressbarx = getdvarint("scr_secondaryProgressBarX", level.secondaryprogressbarx);
    secondaryprogressbary = getdvarint("scr_secondaryProgressBarY", level.secondaryprogressbary);
    bar = createbar((1, 1, 1), level.secondaryprogressbarwidth, secondaryprogressbarheight);
    if (level.splitscreen) {
        bar setpoint("TOP", undefined, secondaryprogressbarx, secondaryprogressbary);
    } else {
        bar setpoint("CENTER", undefined, secondaryprogressbarx, secondaryprogressbary);
    }
    return bar;
}

// Namespace hud
// Params 0, eflags: 0x0
// Checksum 0xfa96e4a8, Offset: 0x2510
// Size: 0x104
function function_220d67ce() {
    secondaryprogressbartextx = getdvarint("scr_btx", level.secondaryprogressbartextx);
    secondaryprogressbartexty = getdvarint("scr_bty", level.secondaryprogressbartexty);
    text = createfontstring("objective", level.primaryprogressbarfontsize);
    if (level.splitscreen) {
        text setpoint("TOP", undefined, secondaryprogressbartextx, secondaryprogressbartexty);
    } else {
        text setpoint("CENTER", undefined, secondaryprogressbartextx, secondaryprogressbartexty);
    }
    text.sort = -1;
    return text;
}

// Namespace hud
// Params 1, eflags: 0x0
// Checksum 0xa7e34bd9, Offset: 0x2620
// Size: 0x70
function function_a276e732(team) {
    bar = function_6f88521b((1, 0, 0), level.teamprogressbarwidth, level.teamprogressbarheight, undefined, team);
    bar setpoint("TOP", undefined, 0, level.teamprogressbary);
    return bar;
}

// Namespace hud
// Params 1, eflags: 0x0
// Checksum 0x2eab32f8, Offset: 0x2698
// Size: 0x70
function function_67fad4f(team) {
    text = createserverfontstring("default", level.teamprogressbarfontsize, team);
    text setpoint("TOP", undefined, 0, level.teamprogressbartexty);
    return text;
}

// Namespace hud
// Params 1, eflags: 0x0
// Checksum 0xf0c54ebc, Offset: 0x2710
// Size: 0x20
function setflashfrac(flashfrac) {
    self.bar.flashfrac = flashfrac;
}

// Namespace hud
// Params 0, eflags: 0x1 linked
// Checksum 0x2841263c, Offset: 0x2738
// Size: 0xd4
function hideelem() {
    if (self.hidden) {
        return;
    }
    self.hidden = 1;
    if (self.alpha != 0) {
        self.alpha = 0;
    }
    if (self.elemtype == "bar" || self.elemtype == "bar_shader") {
        self.bar.hidden = 1;
        if (self.bar.alpha != 0) {
            self.bar.alpha = 0;
        }
        self.barframe.hidden = 1;
        if (self.barframe.alpha != 0) {
            self.barframe.alpha = 0;
        }
    }
}

// Namespace hud
// Params 0, eflags: 0x1 linked
// Checksum 0x5bb7f40b, Offset: 0x2818
// Size: 0x108
function showelem() {
    if (!self.hidden) {
        return;
    }
    self.hidden = 0;
    if (self.elemtype == "bar" || self.elemtype == "bar_shader") {
        if (self.alpha != 0.5) {
            self.alpha = 0.5;
        }
        self.bar.hidden = 0;
        if (self.bar.alpha != 1) {
            self.bar.alpha = 1;
        }
        self.barframe.hidden = 0;
        if (self.barframe.alpha != 1) {
            self.barframe.alpha = 1;
        }
        return;
    }
    if (self.alpha != 1) {
        self.alpha = 1;
    }
}

// Namespace hud
// Params 0, eflags: 0x0
// Checksum 0x9172b9ed, Offset: 0x2928
// Size: 0xf0
function flashthread() {
    self endon(#"death");
    if (!self.hidden) {
        self.alpha = 1;
    }
    while (true) {
        if (self.frac >= self.flashfrac) {
            if (!self.hidden) {
                self fadeovertime(0.3);
                self.alpha = 0.2;
                wait 0.35;
                self fadeovertime(0.3);
                self.alpha = 1;
            }
            wait 0.7;
            continue;
        }
        if (!self.hidden && self.alpha != 1) {
            self.alpha = 1;
        }
        wait 0.05;
    }
}

// Namespace hud
// Params 0, eflags: 0x1 linked
// Checksum 0xe278f85, Offset: 0x2a20
// Size: 0x134
function destroyelem() {
    tempchildren = [];
    for (index = 0; index < self.children.size; index++) {
        if (isdefined(self.children[index])) {
            tempchildren[tempchildren.size] = self.children[index];
        }
    }
    for (index = 0; index < tempchildren.size; index++) {
        tempchildren[index] setparent(self getparent());
    }
    if (self.elemtype == "bar" || self.elemtype == "bar_shader") {
        self.bar destroy();
        self.barframe destroy();
    }
    self destroy();
}

// Namespace hud
// Params 1, eflags: 0x0
// Checksum 0x58d979d3, Offset: 0x2b60
// Size: 0x34
function seticonshader(shader) {
    self setshader(shader, self.width, self.height);
}

// Namespace hud
// Params 1, eflags: 0x0
// Checksum 0x9a6e485, Offset: 0x2ba0
// Size: 0x18
function setwidth(width) {
    self.width = width;
}

// Namespace hud
// Params 1, eflags: 0x0
// Checksum 0x4299b34, Offset: 0x2bc0
// Size: 0x18
function setheight(height) {
    self.height = height;
}

// Namespace hud
// Params 2, eflags: 0x0
// Checksum 0x24809c94, Offset: 0x2be0
// Size: 0x2c
function setsize(width, height) {
    self.width = width;
    self.height = height;
}

// Namespace hud
// Params 0, eflags: 0x1 linked
// Checksum 0x7816c1ea, Offset: 0x2c18
// Size: 0x96
function updatechildren() {
    for (index = 0; index < self.children.size; index++) {
        child = self.children[index];
        child setpoint(child.point, child.relativepoint, child.xoffset, child.yoffset);
    }
}

// Namespace hud
// Params 5, eflags: 0x1 linked
// Checksum 0x4d45072c, Offset: 0x2cb8
// Size: 0x140
function function_21f67f44(player, var_15524e1c, var_f5409200, xpos, ypos) {
    iconsize = 32;
    if (player issplitscreen()) {
        iconsize = 22;
    }
    ypos -= 90 + iconsize * (3 - var_15524e1c);
    xpos -= 10 + iconsize * var_f5409200;
    icon = createicon("white", iconsize, iconsize);
    icon setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", xpos, ypos);
    icon.horzalign = "user_right";
    icon.vertalign = "user_bottom";
    icon.archived = 0;
    icon.foreground = 0;
    return icon;
}

// Namespace hud
// Params 5, eflags: 0x1 linked
// Checksum 0xb22da31f, Offset: 0x2e00
// Size: 0x110
function function_5bb28094(player, var_15524e1c, var_f5409200, xpos, ypos) {
    iconsize = 32;
    if (player issplitscreen()) {
        iconsize = 22;
    }
    ypos -= 90 + iconsize * (3 - var_15524e1c);
    xpos -= 10 + iconsize * var_f5409200;
    self setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", xpos, ypos);
    self.horzalign = "user_right";
    self.vertalign = "user_bottom";
    self.archived = 0;
    self.foreground = 0;
    self.alpha = 1;
}

// Namespace hud
// Params 1, eflags: 0x1 linked
// Checksum 0x40882419, Offset: 0x2f18
// Size: 0x34
function function_59b607f6(xcoord) {
    self setpoint("RIGHT", "LEFT", xcoord, 0);
}

// Namespace hud
// Params 2, eflags: 0x1 linked
// Checksum 0x15f6a718, Offset: 0x2f58
// Size: 0xd0
function function_81ff9096(icon, xcoord) {
    text = createfontstring("small", 1);
    text setparent(icon);
    text setpoint("RIGHT", "LEFT", xcoord, 0);
    text.archived = 0;
    text.alignx = "right";
    text.aligny = "middle";
    text.foreground = 0;
    return text;
}

// Namespace hud
// Params 5, eflags: 0x1 linked
// Checksum 0x1ee9da5f, Offset: 0x3030
// Size: 0xbc
function function_489f386e(iconelem, icon, alpha, var_31704579, text) {
    iconsize = 32;
    iconelem.alpha = alpha;
    if (alpha) {
        iconelem setshader(icon, iconsize, iconsize);
    }
    if (isdefined(var_31704579)) {
        var_31704579.alpha = alpha;
        if (alpha) {
            var_31704579 settext(text);
        }
    }
}

// Namespace hud
// Params 4, eflags: 0x1 linked
// Checksum 0xbc8a9c53, Offset: 0x30f8
// Size: 0xc8
function function_c7cd3259(iconelem, fadetime, var_31704579, var_deead00e) {
    if (isdefined(fadetime)) {
        if (!isdefined(var_deead00e) || !var_deead00e) {
            iconelem fadeovertime(fadetime);
        }
        if (isdefined(var_31704579)) {
            var_31704579 fadeovertime(fadetime);
        }
    }
    if (!isdefined(var_deead00e) || !var_deead00e) {
        iconelem.alpha = 0;
    }
    if (isdefined(var_31704579)) {
        var_31704579.alpha = 0;
    }
}

// Namespace hud
// Params 0, eflags: 0x1 linked
// Checksum 0x62581fb, Offset: 0x31c8
// Size: 0x24
function showperks() {
    self luinotifyevent(%show_perk_notification, 0);
}

// Namespace hud
// Params 3, eflags: 0x0
// Checksum 0x6af53447, Offset: 0x31f8
// Size: 0x2dc
function function_ae77a5ba(index, perk, ypos) {
    assert(game["<dev string:xd7>"] != "<dev string:xdd>");
    if (!isdefined(self.perkicon)) {
        self.perkicon = [];
        self.perkname = [];
    }
    if (!isdefined(self.perkicon[index])) {
        assert(!isdefined(self.perkname[index]));
        self.perkicon[index] = function_21f67f44(self, index, 0, -56, ypos);
        self.perkname[index] = function_81ff9096(self.perkicon[index], -96);
    } else {
        self.perkicon[index] function_5bb28094(self, index, 0, -56, ypos);
        self.perkname[index] function_59b607f6(-96);
    }
    if (perk == "perk_null" || perk == "weapon_null" || perk == "specialty_null") {
        alpha = 0;
    } else {
        assert(isdefined(level.perknames[perk]), perk);
        alpha = 1;
    }
    function_489f386e(self.perkicon[index], perk, alpha, self.perkname[index], level.perknames[perk]);
    self.perkicon[index] moveovertime(0.3);
    self.perkicon[index].x = -5;
    self.perkicon[index].hidewheninmenu = 1;
    self.perkname[index] moveovertime(0.3);
    self.perkname[index].x = -40;
    self.perkname[index].hidewheninmenu = 1;
}

// Namespace hud
// Params 3, eflags: 0x0
// Checksum 0xc4457c97, Offset: 0x34e0
// Size: 0x17c
function function_74b6cb2d(index, fadetime, var_deead00e) {
    if (!isdefined(fadetime)) {
        fadetime = 0.05;
    }
    if (level.perksenabled == 1) {
        if (game["state"] == "postgame") {
            if (isdefined(self.perkicon)) {
                assert(!isdefined(self.perkicon[index]));
                assert(!isdefined(self.perkname[index]));
            }
            return;
        }
        assert(isdefined(self.perkicon[index]));
        assert(isdefined(self.perkname[index]));
        if (isdefined(self.perkicon) && isdefined(self.perkicon[index]) && isdefined(self.perkname) && isdefined(self.perkname[index])) {
            function_c7cd3259(self.perkicon[index], fadetime, self.perkname[index], var_deead00e);
        }
    }
}

// Namespace hud
// Params 4, eflags: 0x0
// Checksum 0xe166c355, Offset: 0x3668
// Size: 0x15c
function function_8842ffe4(index, killstreak, xpos, ypos) {
    assert(game["<dev string:xd7>"] != "<dev string:xdd>");
    if (!isdefined(self.killstreakicon)) {
        self.killstreakicon = [];
    }
    if (!isdefined(self.killstreakicon[index])) {
        self.killstreakicon[index] = function_21f67f44(self, 3, self.killstreak.size - 1 - index, xpos, ypos);
    }
    if (killstreak == "killstreak_null" || killstreak == "weapon_null") {
        alpha = 0;
    } else {
        assert(isdefined(level.killstreakicons[killstreak]), killstreak);
        alpha = 1;
    }
    function_489f386e(self.killstreakicon[index], level.killstreakicons[killstreak], alpha);
}

// Namespace hud
// Params 2, eflags: 0x0
// Checksum 0x4f034ed1, Offset: 0x37d0
// Size: 0xbc
function function_743093ab(index, fadetime) {
    if (util::is_killstreaks_enabled()) {
        if (game["state"] == "postgame") {
            assert(!isdefined(self.killstreakicon[index]));
            return;
        }
        assert(isdefined(self.killstreakicon[index]));
        function_c7cd3259(self.killstreakicon[index], fadetime);
    }
}

// Namespace hud
// Params 0, eflags: 0x0
// Checksum 0x32844bc2, Offset: 0x3898
// Size: 0x5c
function function_21804f26() {
    self.x = 11;
    self.y = 120;
    self.horzalign = "user_left";
    self.vertalign = "user_top";
    self.alignx = "left";
    self.aligny = "top";
}

