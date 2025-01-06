#using scripts/codescripts/struct;
#using scripts/shared/flagsys_shared;
#using scripts/shared/util_shared;

#namespace debug_menu;

// Namespace debug_menu
// Params 2, eflags: 0x0
// Checksum 0xda27fa8c, Offset: 0x138
// Size: 0xc4
function open(localclientnum, a_menu_items) {
    close(localclientnum);
    level flagsys::set("menu_open");
    populatescriptdebugmenu(localclientnum, a_menu_items);
    luiload("uieditor.menus.ScriptDebugMenu");
    level.scriptdebugmenu = createluimenu(localclientnum, "ScriptDebugMenu");
    openluimenu(localclientnum, level.scriptdebugmenu);
}

// Namespace debug_menu
// Params 1, eflags: 0x0
// Checksum 0x1625bacb, Offset: 0x208
// Size: 0x5e
function close(localclientnum) {
    level flagsys::clear("menu_open");
    if (isdefined(level.scriptdebugmenu)) {
        closeluimenu(localclientnum, level.scriptdebugmenu);
        level.scriptdebugmenu = undefined;
    }
}

// Namespace debug_menu
// Params 3, eflags: 0x0
// Checksum 0xccac289, Offset: 0x270
// Size: 0xb4
function set_item_text(localclientnum, index, name) {
    controllermodel = getuimodelforcontroller(localclientnum);
    parentmodel = getuimodel(controllermodel, "cscDebugMenu.listItem" + index);
    model = getuimodel(parentmodel, "name");
    setuimodelvalue(model, name);
}

// Namespace debug_menu
// Params 3, eflags: 0x0
// Checksum 0x7e599460, Offset: 0x330
// Size: 0x11c
function set_item_color(localclientnum, index, color) {
    controllermodel = getuimodelforcontroller(localclientnum);
    parentmodel = getuimodel(controllermodel, "cscDebugMenu.listItem" + index);
    model = getuimodel(parentmodel, "color");
    if (isvec(color)) {
        color = "" + color[0] * -1 + " " + color[1] * -1 + " " + color[2] * -1;
    }
    setuimodelvalue(model, color);
}

