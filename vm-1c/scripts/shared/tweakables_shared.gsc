#using scripts/shared/system_shared;

#namespace tweakables;

// Namespace tweakables
// Params 0, eflags: 0x2
// Checksum 0x3ee9fd73, Offset: 0x448
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("tweakables", &__init__, undefined, undefined);
}

// Namespace tweakables
// Params 0, eflags: 0x1 linked
// Checksum 0xcde7e501, Offset: 0x488
// Size: 0x4cc
function __init__() {
    level.clienttweakables = [];
    level.tweakablesinitialized = 1;
    level.rules = [];
    level.gametweaks = [];
    level.teamtweaks = [];
    level.playertweaks = [];
    level.classtweaks = [];
    level.weapontweaks = [];
    level.hardpointtweaks = [];
    level.hudtweaks = [];
    registertweakable("game", "arcadescoring", "scr_game_arcadescoring", 0);
    registertweakable("game", "difficulty", "scr_game_difficulty", 1);
    registertweakable("game", "pinups", "scr_game_pinups", 0);
    registertweakable("team", "teamkillerplaylistbanquantum", "scr_team_teamkillerplaylistbanquantum", 0);
    registertweakable("team", "teamkillerplaylistbanpenalty", "scr_team_teamkillerplaylistbanpenalty", 0);
    registertweakable("player", "allowrevive", "scr_player_allowrevive", 1);
    registertweakable("weapon", "allowfrag", "scr_weapon_allowfrags", 1);
    registertweakable("weapon", "allowsmoke", "scr_weapon_allowsmoke", 1);
    registertweakable("weapon", "allowflash", "scr_weapon_allowflash", 1);
    registertweakable("weapon", "allowc4", "scr_weapon_allowc4", 1);
    registertweakable("weapon", "allowsatchel", "scr_weapon_allowsatchel", 1);
    registertweakable("weapon", "allowbetty", "scr_weapon_allowbetty", 1);
    registertweakable("weapon", "allowrpgs", "scr_weapon_allowrpgs", 1);
    registertweakable("weapon", "allowmines", "scr_weapon_allowmines", 1);
    registertweakable("hud", "showobjicons", "ui_hud_showobjicons", 1);
    setclienttweakable("hud", "showobjicons");
    registertweakable("killstreak", "allowradar", "scr_hardpoint_allowradar", 1);
    registertweakable("killstreak", "allowradardirection", "scr_hardpoint_allowradardirection", 1);
    registertweakable("killstreak", "allowcounteruav", "scr_hardpoint_allowcounteruav", 1);
    registertweakable("killstreak", "allowdogs", "scr_hardpoint_allowdogs", 1);
    registertweakable("killstreak", "allowhelicopter_comlink", "scr_hardpoint_allowhelicopter_comlink", 1);
    registertweakable("killstreak", "allowrcbomb", "scr_hardpoint_allowrcbomb", 1);
    registertweakable("killstreak", "allowauto_turret", "scr_hardpoint_allowauto_turret", 1);
    /#
        debug_refresh = 1;
    #/
    level thread updateuitweakables(debug_refresh);
}

// Namespace tweakables
// Params 2, eflags: 0x1 linked
// Checksum 0x93066055, Offset: 0x960
// Size: 0x1c4
function gettweakabledvarvalue(category, name) {
    switch (category) {
    case 52:
        dvar = level.rules[name].dvar;
        break;
    case 3:
        dvar = level.gametweaks[name].dvar;
        break;
    case 10:
        dvar = level.teamtweaks[name].dvar;
        break;
    case 15:
        dvar = level.playertweaks[name].dvar;
        break;
    case 51:
        dvar = level.classtweaks[name].dvar;
        break;
    case 18:
        dvar = level.weapontweaks[name].dvar;
        break;
    case 38:
        dvar = level.hardpointtweaks[name].dvar;
        break;
    case 35:
        dvar = level.hudtweaks[name].dvar;
        break;
    default:
        dvar = undefined;
        break;
    }
    assert(isdefined(dvar));
    value = getdvarint(dvar);
    return value;
}

// Namespace tweakables
// Params 2, eflags: 0x1 linked
// Checksum 0x9f27ce84, Offset: 0xb30
// Size: 0x1a0
function gettweakabledvar(category, name) {
    switch (category) {
    case 52:
        value = level.rules[name].dvar;
        break;
    case 3:
        value = level.gametweaks[name].dvar;
        break;
    case 10:
        value = level.teamtweaks[name].dvar;
        break;
    case 15:
        value = level.playertweaks[name].dvar;
        break;
    case 51:
        value = level.classtweaks[name].dvar;
        break;
    case 18:
        value = level.weapontweaks[name].dvar;
        break;
    case 38:
        value = level.hardpointtweaks[name].dvar;
        break;
    case 35:
        value = level.hudtweaks[name].dvar;
        break;
    default:
        value = undefined;
        break;
    }
    assert(isdefined(value));
    return value;
}

// Namespace tweakables
// Params 2, eflags: 0x1 linked
// Checksum 0x9629bce, Offset: 0xcd8
// Size: 0x218
function gettweakablevalue(category, name) {
    switch (category) {
    case 52:
        value = level.rules[name].value;
        break;
    case 3:
        value = level.gametweaks[name].value;
        break;
    case 10:
        value = level.teamtweaks[name].value;
        break;
    case 15:
        value = level.playertweaks[name].value;
        break;
    case 51:
        value = level.classtweaks[name].value;
        break;
    case 18:
        value = level.weapontweaks[name].value;
        break;
    case 38:
        value = level.hardpointtweaks[name].value;
        break;
    case 35:
        value = level.hudtweaks[name].value;
        break;
    default:
        value = undefined;
        break;
    }
    overridedvar = "scr_" + level.gametype + "_" + category + "_" + name;
    if (getdvarstring(overridedvar) != "") {
        return getdvarint(overridedvar);
    }
    assert(isdefined(value));
    return value;
}

// Namespace tweakables
// Params 2, eflags: 0x1 linked
// Checksum 0x31fc11e7, Offset: 0xef8
// Size: 0x1a0
function gettweakablelastvalue(category, name) {
    switch (category) {
    case 52:
        value = level.rules[name].lastvalue;
        break;
    case 3:
        value = level.gametweaks[name].lastvalue;
        break;
    case 10:
        value = level.teamtweaks[name].lastvalue;
        break;
    case 15:
        value = level.playertweaks[name].lastvalue;
        break;
    case 51:
        value = level.classtweaks[name].lastvalue;
        break;
    case 18:
        value = level.weapontweaks[name].lastvalue;
        break;
    case 38:
        value = level.hardpointtweaks[name].lastvalue;
        break;
    case 35:
        value = level.hudtweaks[name].lastvalue;
        break;
    default:
        value = undefined;
        break;
    }
    assert(isdefined(value));
    return value;
}

// Namespace tweakables
// Params 3, eflags: 0x0
// Checksum 0x2ee0f11c, Offset: 0x10a0
// Size: 0x1a4
function settweakablevalue(category, name, value) {
    switch (category) {
    case 52:
        dvar = level.rules[name].dvar;
        break;
    case 3:
        dvar = level.gametweaks[name].dvar;
        break;
    case 10:
        dvar = level.teamtweaks[name].dvar;
        break;
    case 15:
        dvar = level.playertweaks[name].dvar;
        break;
    case 51:
        dvar = level.classtweaks[name].dvar;
        break;
    case 18:
        dvar = level.weapontweaks[name].dvar;
        break;
    case 38:
        dvar = level.hardpointtweaks[name].dvar;
        break;
    case 35:
        dvar = level.hudtweaks[name].dvar;
        break;
    default:
        dvar = undefined;
        break;
    }
    setdvar(dvar, value);
}

// Namespace tweakables
// Params 3, eflags: 0x1 linked
// Checksum 0x17d9d3f5, Offset: 0x1250
// Size: 0x17a
function settweakablelastvalue(category, name, value) {
    switch (category) {
    case 52:
        level.rules[name].lastvalue = value;
        break;
    case 3:
        level.gametweaks[name].lastvalue = value;
        break;
    case 10:
        level.teamtweaks[name].lastvalue = value;
        break;
    case 15:
        level.playertweaks[name].lastvalue = value;
        break;
    case 51:
        level.classtweaks[name].lastvalue = value;
        break;
    case 18:
        level.weapontweaks[name].lastvalue = value;
        break;
    case 38:
        level.hardpointtweaks[name].lastvalue = value;
        break;
    case 35:
        level.hudtweaks[name].lastvalue = value;
        break;
    default:
        break;
    }
}

// Namespace tweakables
// Params 4, eflags: 0x1 linked
// Checksum 0xf1ccad1, Offset: 0x13d8
// Size: 0x5ca
function registertweakable(category, name, dvar, value) {
    if (isstring(value)) {
        if (getdvarstring(dvar) == "") {
            setdvar(dvar, value);
        } else {
            value = getdvarstring(dvar);
        }
    } else if (getdvarstring(dvar) == "") {
        setdvar(dvar, value);
    } else {
        value = getdvarint(dvar);
    }
    switch (category) {
    case 52:
        if (!isdefined(level.rules[name])) {
            level.rules[name] = spawnstruct();
        }
        level.rules[name].value = value;
        level.rules[name].lastvalue = value;
        level.rules[name].dvar = dvar;
        break;
    case 3:
        if (!isdefined(level.gametweaks[name])) {
            level.gametweaks[name] = spawnstruct();
        }
        level.gametweaks[name].value = value;
        level.gametweaks[name].lastvalue = value;
        level.gametweaks[name].dvar = dvar;
        break;
    case 10:
        if (!isdefined(level.teamtweaks[name])) {
            level.teamtweaks[name] = spawnstruct();
        }
        level.teamtweaks[name].value = value;
        level.teamtweaks[name].lastvalue = value;
        level.teamtweaks[name].dvar = dvar;
        break;
    case 15:
        if (!isdefined(level.playertweaks[name])) {
            level.playertweaks[name] = spawnstruct();
        }
        level.playertweaks[name].value = value;
        level.playertweaks[name].lastvalue = value;
        level.playertweaks[name].dvar = dvar;
        break;
    case 51:
        if (!isdefined(level.classtweaks[name])) {
            level.classtweaks[name] = spawnstruct();
        }
        level.classtweaks[name].value = value;
        level.classtweaks[name].lastvalue = value;
        level.classtweaks[name].dvar = dvar;
        break;
    case 18:
        if (!isdefined(level.weapontweaks[name])) {
            level.weapontweaks[name] = spawnstruct();
        }
        level.weapontweaks[name].value = value;
        level.weapontweaks[name].lastvalue = value;
        level.weapontweaks[name].dvar = dvar;
        break;
    case 38:
        if (!isdefined(level.hardpointtweaks[name])) {
            level.hardpointtweaks[name] = spawnstruct();
        }
        level.hardpointtweaks[name].value = value;
        level.hardpointtweaks[name].lastvalue = value;
        level.hardpointtweaks[name].dvar = dvar;
        break;
    case 35:
        if (!isdefined(level.hudtweaks[name])) {
            level.hudtweaks[name] = spawnstruct();
        }
        level.hudtweaks[name].value = value;
        level.hudtweaks[name].lastvalue = value;
        level.hudtweaks[name].dvar = dvar;
        break;
    }
}

// Namespace tweakables
// Params 2, eflags: 0x1 linked
// Checksum 0x91310e53, Offset: 0x19b0
// Size: 0x2a
function setclienttweakable(category, name) {
    level.clienttweakables[level.clienttweakables.size] = name;
}

// Namespace tweakables
// Params 1, eflags: 0x1 linked
// Checksum 0x68fae5b6, Offset: 0x19e8
// Size: 0x12e
function updateuitweakables(debug_refresh) {
    do {
        for (index = 0; index < level.clienttweakables.size; index++) {
            clienttweakable = level.clienttweakables[index];
            curvalue = gettweakabledvarvalue("hud", clienttweakable);
            lastvalue = gettweakablelastvalue("hud", clienttweakable);
            if (curvalue != lastvalue) {
                function_13dc3b34(gettweakabledvar("hud", clienttweakable), curvalue);
                settweakablelastvalue("hud", clienttweakable, curvalue);
            }
        }
        wait(randomfloatrange(0.9, 1.1));
    } while (isdefined(debug_refresh));
}

// Namespace tweakables
// Params 2, eflags: 0x1 linked
// Checksum 0xe472fdd5, Offset: 0x1b20
// Size: 0x14
function function_13dc3b34(dvar, value) {
    
}

