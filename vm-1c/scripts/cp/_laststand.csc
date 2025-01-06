#using scripts/cp/_load;
#using scripts/cp/_util;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace _laststand;

// Namespace _laststand
// Params 0, eflags: 0x2
// Checksum 0x6c0ca5e3, Offset: 0x158
// Size: 0x124
function autoexec init() {
    level.laststands = [];
    for (i = 0; i < 4; i++) {
        level.laststands[i] = spawnstruct();
        level.laststands[i].bleedouttime = 0;
        level.laststands[i].laststand_update_clientfields = "laststand_update" + i;
        level.laststands[i].var_48ba472 = 0;
        clientfield::register("world", level.laststands[i].laststand_update_clientfields, 1, 5, "counter", &update_bleedout_timer, 0, 0);
    }
    level thread wait_and_set_revive_shader_constant();
}

// Namespace _laststand
// Params 0, eflags: 0x0
// Checksum 0x3627c892, Offset: 0x288
// Size: 0xb0
function wait_and_set_revive_shader_constant() {
    while (true) {
        level waittill(#"notetrack", localclientnum, note);
        if (note == "revive_shader_constant") {
            player = getlocalplayer(localclientnum);
            player mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 0, getservertime(localclientnum) / 1000);
        }
    }
}

// Namespace _laststand
// Params 3, eflags: 0x0
// Checksum 0xaa41963a, Offset: 0x340
// Size: 0x108
function function_c2e280cb(model, oldvalue, newvalue) {
    self endon(#"new_val");
    starttime = getrealtime();
    timesincelastupdate = 0;
    if (oldvalue == newvalue) {
        newvalue = oldvalue - 1;
    }
    while (timesincelastupdate <= 1) {
        timesincelastupdate = (getrealtime() - starttime) / 1000;
        var_81ef2a5 = lerpfloat(oldvalue, newvalue, timesincelastupdate) / 30;
        setuimodelvalue(model, var_81ef2a5);
        wait 0.016;
    }
}

// Namespace _laststand
// Params 7, eflags: 0x0
// Checksum 0x6deb8153, Offset: 0x450
// Size: 0x2b4
function update_bleedout_timer(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    substr = getsubstr(fieldname, 16);
    playernum = int(substr);
    level.laststands[playernum].var_48ba472 = level.laststands[playernum].bleedouttime;
    level.laststands[playernum].bleedouttime = newval - 1;
    if (level.laststands[playernum].var_48ba472 < level.laststands[playernum].bleedouttime) {
        level.laststands[playernum].var_48ba472 = level.laststands[playernum].bleedouttime;
    }
    model = getuimodel(getuimodelforcontroller(localclientnum), "WorldSpaceIndicators.bleedOutModel" + playernum + ".bleedOutPercent");
    if (isdefined(model)) {
        if (newval == 30) {
            level.laststands[playernum].bleedouttime = 0;
            level.laststands[playernum].var_48ba472 = 0;
            setuimodelvalue(model, 1);
            return;
        }
        if (newval == 29) {
            level.laststands[playernum] notify(#"new_val");
            level.laststands[playernum] thread function_c2e280cb(model, 30, 28);
            return;
        }
        level.laststands[playernum] notify(#"new_val");
        level.laststands[playernum] thread function_c2e280cb(model, level.laststands[playernum].var_48ba472, level.laststands[playernum].bleedouttime);
    }
}

