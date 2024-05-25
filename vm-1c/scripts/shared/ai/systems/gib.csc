#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace gibclientutils;

// Namespace gibclientutils
// Params 0, eflags: 0x2
// Checksum 0x79a307f1, Offset: 0x208
// Size: 0x434
function autoexec main() {
    clientfield::register("actor", "gib_state", 1, 9, "int", &_gibhandler, 0, 0);
    clientfield::register("playercorpse", "gib_state", 1, 15, "int", &_gibhandler, 0, 0);
    var_19c51405 = struct::get_script_bundles("gibcharacterdef");
    gibpiecelookup = [];
    gibpiecelookup[2] = "annihilate";
    gibpiecelookup[8] = "head";
    gibpiecelookup[16] = "rightarm";
    gibpiecelookup[32] = "leftarm";
    gibpiecelookup[-128] = "rightleg";
    gibpiecelookup[256] = "leftleg";
    processedbundles = [];
    foreach (var_7c95de4b, definition in var_19c51405) {
        var_5ec70049 = spawnstruct();
        var_5ec70049.var_5ce61d20 = [];
        var_5ec70049.name = var_7c95de4b;
        foreach (var_79390ec7, var_f815bc88 in gibpiecelookup) {
            gibstruct = spawnstruct();
            gibstruct.gibmodel = function_e8ef6cb0(definition, gibpiecelookup[var_79390ec7] + "_gibmodel");
            gibstruct.gibtag = function_e8ef6cb0(definition, gibpiecelookup[var_79390ec7] + "_gibtag");
            gibstruct.gibfx = function_e8ef6cb0(definition, gibpiecelookup[var_79390ec7] + "_gibfx");
            gibstruct.gibfxtag = function_e8ef6cb0(definition, gibpiecelookup[var_79390ec7] + "_gibeffecttag");
            gibstruct.gibdynentfx = function_e8ef6cb0(definition, gibpiecelookup[var_79390ec7] + "_gibdynentfx");
            gibstruct.gibsound = function_e8ef6cb0(definition, gibpiecelookup[var_79390ec7] + "_gibsound");
            var_5ec70049.var_5ce61d20[var_79390ec7] = gibstruct;
        }
        processedbundles[var_7c95de4b] = var_5ec70049;
    }
    level.var_3f831f3b["gibcharacterdef"] = processedbundles;
    level thread _annihilatecorpse();
}

// Namespace gibclientutils
// Params 0, eflags: 0x5 linked
// Checksum 0x19fdf876, Offset: 0x648
// Size: 0x1f8
function private _annihilatecorpse() {
    while (true) {
        localclientnum, body, origin = level waittill(#"corpse_explode");
        if (!util::is_mature() || util::is_gib_restricted_build()) {
            continue;
        }
        if (isdefined(body) && _hasgibdef(body) && body isragdoll()) {
            cliententgibhead(localclientnum, body);
            cliententgibrightarm(localclientnum, body);
            cliententgibleftarm(localclientnum, body);
            cliententgibrightleg(localclientnum, body);
            cliententgibleftleg(localclientnum, body);
        }
        if (isdefined(body) && _hasgibdef(body) && body.archetype == "human") {
            if (randomint(100) >= 50) {
                continue;
            }
            if (isdefined(origin) && distancesquared(body.origin, origin) <= 14400) {
                body.ignoreragdoll = 1;
                body _gibentity(localclientnum, 50 | 384, 1);
            }
        }
    }
}

// Namespace gibclientutils
// Params 3, eflags: 0x5 linked
// Checksum 0x41014bcc, Offset: 0x848
// Size: 0x20c
function private _clonegibdata(localclientnum, entity, clone) {
    clone.gib_data = spawnstruct();
    clone.gib_data.gib_state = entity.gib_state;
    clone.gib_data.gibdef = entity.gibdef;
    clone.gib_data.hatmodel = entity.hatmodel;
    clone.gib_data.head = entity.head;
    clone.gib_data.legdmg1 = entity.legdmg1;
    clone.gib_data.legdmg2 = entity.legdmg2;
    clone.gib_data.legdmg3 = entity.legdmg3;
    clone.gib_data.legdmg4 = entity.legdmg4;
    clone.gib_data.torsodmg1 = entity.torsodmg1;
    clone.gib_data.torsodmg2 = entity.torsodmg2;
    clone.gib_data.torsodmg3 = entity.torsodmg3;
    clone.gib_data.torsodmg4 = entity.torsodmg4;
    clone.gib_data.torsodmg5 = entity.torsodmg5;
}

// Namespace gibclientutils
// Params 1, eflags: 0x5 linked
// Checksum 0x51917e21, Offset: 0xa60
// Size: 0x92
function private function_e2149f4f(entity) {
    if (entity isplayer() || entity isplayercorpse()) {
        return entity getplayergibdef();
    } else if (isdefined(entity.gib_data)) {
        return entity.gib_data.gibdef;
    }
    return entity.gibdef;
}

// Namespace gibclientutils
// Params 2, eflags: 0x5 linked
// Checksum 0xf077f9c0, Offset: 0xb00
// Size: 0x86
function private _getgibbedstate(localclientnum, entity) {
    if (isdefined(entity.gib_data) && isdefined(entity.gib_data.gib_state)) {
        return entity.gib_data.gib_state;
    } else if (isdefined(entity.gib_state)) {
        return entity.gib_state;
    }
    return 0;
}

// Namespace gibclientutils
// Params 2, eflags: 0x5 linked
// Checksum 0xb4c565c0, Offset: 0xb90
// Size: 0x17e
function private _getgibbedlegmodel(localclientnum, entity) {
    gibstate = _getgibbedstate(localclientnum, entity);
    rightleggibbed = gibstate & -128;
    leftleggibbed = gibstate & 256;
    if (rightleggibbed && leftleggibbed) {
        return (isdefined(entity.gib_data) ? entity.gib_data.legdmg4 : entity.legdmg4);
    } else if (rightleggibbed) {
        return (isdefined(entity.gib_data) ? entity.gib_data.legdmg2 : entity.legdmg2);
    } else if (leftleggibbed) {
        return (isdefined(entity.gib_data) ? entity.gib_data.legdmg3 : entity.legdmg3);
    }
    return isdefined(entity.gib_data) ? entity.gib_data.legdmg1 : entity.legdmg1;
}

// Namespace gibclientutils
// Params 3, eflags: 0x5 linked
// Checksum 0xfe07e53d, Offset: 0xd18
// Size: 0xd4
function private _getgibextramodel(localclientnumm, entity, gibflag) {
    if (gibflag == 4) {
        return (isdefined(entity.gib_data) ? entity.gib_data.hatmodel : entity.hatmodel);
    }
    if (gibflag == 8) {
        return (isdefined(entity.gib_data) ? entity.gib_data.head : entity.head);
    }
    assertmsg("leftarm");
}

// Namespace gibclientutils
// Params 2, eflags: 0x5 linked
// Checksum 0xf5514252, Offset: 0xdf8
// Size: 0x17e
function private _getgibbedtorsomodel(localclientnum, entity) {
    gibstate = _getgibbedstate(localclientnum, entity);
    rightarmgibbed = gibstate & 16;
    leftarmgibbed = gibstate & 32;
    if (rightarmgibbed && leftarmgibbed) {
        return (isdefined(entity.gib_data) ? entity.gib_data.torsodmg2 : entity.torsodmg2);
    } else if (rightarmgibbed) {
        return (isdefined(entity.gib_data) ? entity.gib_data.torsodmg2 : entity.torsodmg2);
    } else if (leftarmgibbed) {
        return (isdefined(entity.gib_data) ? entity.gib_data.torsodmg3 : entity.torsodmg3);
    }
    return isdefined(entity.gib_data) ? entity.gib_data.torsodmg1 : entity.torsodmg1;
}

// Namespace gibclientutils
// Params 3, eflags: 0x5 linked
// Checksum 0xc9277a10, Offset: 0xf80
// Size: 0xb4
function private _gibpiecetag(localclientnum, entity, gibflag) {
    if (!_hasgibdef(self)) {
        return;
    }
    var_5ec70049 = struct::get_script_bundle("gibcharacterdef", function_e2149f4f(entity));
    gibpiece = var_5ec70049.var_5ce61d20[gibflag];
    if (isdefined(gibpiece)) {
        return gibpiece.gibfxtag;
    }
}

// Namespace gibclientutils
// Params 3, eflags: 0x5 linked
// Checksum 0x227fac2a, Offset: 0x1040
// Size: 0x2a0
function private _gibentity(localclientnum, gibflags, shouldspawngibs) {
    entity = self;
    if (!_hasgibdef(entity)) {
        return;
    }
    currentgibflag = 2;
    gibdir = undefined;
    if (entity isplayer() || entity isplayercorpse()) {
        yaw_bits = gibflags >> 9 & 8 - 1;
        yaw = getanglefrombits(yaw_bits, 3);
        gibdir = anglestoforward((0, yaw, 0));
    }
    var_5ec70049 = struct::get_script_bundle("gibcharacterdef", function_e2149f4f(entity));
    while (gibflags >= currentgibflag) {
        if (gibflags & currentgibflag) {
            gibpiece = var_5ec70049.var_5ce61d20[currentgibflag];
            if (isdefined(gibpiece)) {
                if (shouldspawngibs) {
                    entity thread _gibpiece(localclientnum, entity, gibpiece.gibmodel, gibpiece.gibtag, gibpiece.gibdynentfx, gibdir);
                }
                _playgibfx(localclientnum, entity, gibpiece.gibfx, gibpiece.gibfxtag);
                _playgibsound(localclientnum, entity, gibpiece.gibsound);
                if (currentgibflag == 2) {
                    entity hide();
                    entity.ignoreragdoll = 1;
                }
            }
            _handlegibcallbacks(localclientnum, entity, currentgibflag);
        }
        currentgibflag <<= 1;
    }
}

// Namespace gibclientutils
// Params 3, eflags: 0x5 linked
// Checksum 0xc67cd0a3, Offset: 0x12e8
// Size: 0x98
function private _setgibbed(localclientnum, entity, gibflag) {
    gib_state = _getgibbedstate(localclientnum, entity) | gibflag & 512 - 1;
    if (isdefined(entity.gib_data)) {
        entity.gib_data.gib_state = gib_state;
        return;
    }
    entity.gib_state = gib_state;
}

// Namespace gibclientutils
// Params 3, eflags: 0x5 linked
// Checksum 0x9b25048b, Offset: 0x1388
// Size: 0x1c4
function private _gibcliententityinternal(localclientnum, entity, gibflag) {
    if (!util::is_mature() || util::is_gib_restricted_build()) {
        return;
    }
    if (!isdefined(entity) || !_hasgibdef(entity)) {
        return;
    }
    if (entity.type !== "scriptmover") {
        return;
    }
    if (isgibbed(localclientnum, entity, gibflag)) {
        return;
    }
    if (!(_getgibbedstate(localclientnum, entity) < 16)) {
        legmodel = _getgibbedlegmodel(localclientnum, entity);
        entity detach(legmodel, "");
    }
    _setgibbed(localclientnum, entity, gibflag);
    entity setmodel(_getgibbedtorsomodel(localclientnum, entity));
    entity attach(_getgibbedlegmodel(localclientnum, entity), "");
    entity _gibentity(localclientnum, gibflag, 1);
}

// Namespace gibclientutils
// Params 3, eflags: 0x5 linked
// Checksum 0xa71976e1, Offset: 0x1558
// Size: 0x1ec
function private _gibclientextrainternal(localclientnum, entity, gibflag) {
    if (!util::is_mature() || util::is_gib_restricted_build()) {
        return;
    }
    if (!isdefined(entity)) {
        return;
    }
    if (entity.type !== "scriptmover") {
        return;
    }
    if (isgibbed(localclientnum, entity, gibflag)) {
        return;
    }
    gibmodel = _getgibextramodel(localclientnum, entity, gibflag);
    if (isdefined(gibmodel) && entity isattached(gibmodel, "")) {
        entity detach(gibmodel, "");
    }
    if (gibflag == 8) {
        if (isdefined(isdefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5)) {
            entity attach(isdefined(entity.gib_data) ? entity.gib_data.torsodmg5 : entity.torsodmg5, "");
        }
    }
    _setgibbed(localclientnum, entity, gibflag);
    entity _gibentity(localclientnum, gibflag, 1);
}

// Namespace gibclientutils
// Params 7, eflags: 0x5 linked
// Checksum 0x8f4d523d, Offset: 0x1750
// Size: 0x1b0
function private _gibhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (entity isplayer() || entity isplayercorpse()) {
        if (!util::is_mature() || util::is_gib_restricted_build()) {
            return;
        }
    } else {
        if (isdefined(entity.maturegib) && entity.maturegib && !util::is_mature()) {
            return;
        }
        if (isdefined(entity.restrictedgib) && entity.restrictedgib && !isshowgibsenabled()) {
            return;
        }
    }
    gibflags = oldvalue ^ newvalue;
    shouldspawngibs = !(newvalue & 1);
    if (bnewent) {
        gibflags = 0 ^ newvalue;
    }
    entity _gibentity(localclientnum, gibflags, shouldspawngibs);
    entity.gib_state = newvalue;
}

// Namespace gibclientutils
// Params 6, eflags: 0x1 linked
// Checksum 0x9567b73a, Offset: 0x1908
// Size: 0x304
function _gibpiece(localclientnum, entity, gibmodel, gibtag, gibfx, gibdir) {
    if (!isdefined(gibtag) || !isdefined(gibmodel)) {
        return;
    }
    startposition = entity gettagorigin(gibtag);
    startangles = entity gettagangles(gibtag);
    endposition = startposition;
    endangles = startangles;
    forwardvector = undefined;
    if (!isdefined(startposition) || !isdefined(startangles)) {
        return 0;
    }
    if (isdefined(gibdir)) {
        startposition = (0, 0, 0);
        forwardvector = gibdir;
        forwardvector *= randomfloatrange(100, 500);
    } else {
        wait(0.016);
        if (isdefined(entity)) {
            endposition = entity gettagorigin(gibtag);
            endangles = entity gettagangles(gibtag);
        } else {
            endposition = startposition + anglestoforward(startangles) * 10;
            endangles = startangles;
        }
        if (!isdefined(endposition) || !isdefined(endangles)) {
            return 0;
        }
        forwardvector = vectornormalize(endposition - startposition);
        forwardvector *= randomfloatrange(0.6, 1);
        forwardvector += (randomfloatrange(0, 0.2), randomfloatrange(0, 0.2), randomfloatrange(0.2, 0.7));
    }
    if (isdefined(entity)) {
        gibentity = createdynentandlaunch(localclientnum, gibmodel, endposition, endangles, startposition, forwardvector, gibfx, 1);
        if (isdefined(gibentity)) {
            setdynentbodyrenderoptionspacked(gibentity, entity getbodyrenderoptionspacked());
        }
    }
}

// Namespace gibclientutils
// Params 3, eflags: 0x5 linked
// Checksum 0x9789438d, Offset: 0x1c18
// Size: 0xde
function private _handlegibcallbacks(localclientnum, entity, gibflag) {
    if (isdefined(entity._gibcallbacks) && isdefined(entity._gibcallbacks[gibflag])) {
        foreach (callback in entity._gibcallbacks[gibflag]) {
            [[ callback ]](localclientnum, entity, gibflag);
        }
    }
}

// Namespace gibclientutils
// Params 1, eflags: 0x5 linked
// Checksum 0x2230dba5, Offset: 0x1d00
// Size: 0x5c
function private _handlegibannihilate(localclientnum) {
    entity = self;
    entity endon(#"entityshutdown");
    entity waittillmatch(#"_anim_notify_", "gib_annihilate");
    cliententgibannihilate(localclientnum, entity);
}

// Namespace gibclientutils
// Params 1, eflags: 0x5 linked
// Checksum 0x12a546e0, Offset: 0x1d68
// Size: 0x5c
function private _handlegibhead(localclientnum) {
    entity = self;
    entity endon(#"entityshutdown");
    entity waittillmatch(#"_anim_notify_", "gib = \"head\"");
    cliententgibhead(localclientnum, entity);
}

// Namespace gibclientutils
// Params 1, eflags: 0x5 linked
// Checksum 0xcc7feb5c, Offset: 0x1dd0
// Size: 0x5c
function private _handlegibrightarm(localclientnum) {
    entity = self;
    entity endon(#"entityshutdown");
    entity waittillmatch(#"_anim_notify_", "gib = \"arm_right\"");
    cliententgibrightarm(localclientnum, entity);
}

// Namespace gibclientutils
// Params 1, eflags: 0x5 linked
// Checksum 0x45fd21e3, Offset: 0x1e38
// Size: 0x5c
function private _handlegibleftarm(localclientnum) {
    entity = self;
    entity endon(#"entityshutdown");
    entity waittillmatch(#"_anim_notify_", "gib = \"arm_left\"");
    cliententgibleftarm(localclientnum, entity);
}

// Namespace gibclientutils
// Params 1, eflags: 0x5 linked
// Checksum 0x9c070701, Offset: 0x1ea0
// Size: 0x5c
function private _handlegibrightleg(localclientnum) {
    entity = self;
    entity endon(#"entityshutdown");
    entity waittillmatch(#"_anim_notify_", "gib = \"leg_right\"");
    cliententgibrightleg(localclientnum, entity);
}

// Namespace gibclientutils
// Params 1, eflags: 0x5 linked
// Checksum 0xcee07666, Offset: 0x1f08
// Size: 0x5c
function private _handlegibleftleg(localclientnum) {
    entity = self;
    entity endon(#"entityshutdown");
    entity waittillmatch(#"_anim_notify_", "gib = \"leg_left\"");
    cliententgibleftleg(localclientnum, entity);
}

// Namespace gibclientutils
// Params 1, eflags: 0x5 linked
// Checksum 0xc685497c, Offset: 0x1f70
// Size: 0x6c
function private _hasgibdef(entity) {
    return isdefined(entity.gib_data) && isdefined(entity.gib_data.gibdef) || isdefined(entity.gibdef) || entity getplayergibdef() != "unknown";
}

// Namespace gibclientutils
// Params 4, eflags: 0x1 linked
// Checksum 0x1e96fe57, Offset: 0x1fe8
// Size: 0x10a
function _playgibfx(localclientnum, entity, fxfilename, fxtag) {
    if (isdefined(fxfilename) && isdefined(fxtag) && entity hasdobj(localclientnum)) {
        fx = playfxontag(localclientnum, fxfilename, entity, fxtag);
        if (isdefined(fx)) {
            if (isdefined(entity.team)) {
                setfxteam(localclientnum, fx, entity.team);
            }
            if (isdefined(level.setgibfxtoignorepause) && level.setgibfxtoignorepause) {
                setfxignorepause(localclientnum, fx, 1);
            }
        }
        return fx;
    }
}

// Namespace gibclientutils
// Params 3, eflags: 0x1 linked
// Checksum 0xfbc0048, Offset: 0x2100
// Size: 0x4c
function _playgibsound(localclientnum, entity, soundalias) {
    if (isdefined(soundalias)) {
        playsound(localclientnum, soundalias, entity.origin);
    }
}

// Namespace gibclientutils
// Params 4, eflags: 0x1 linked
// Checksum 0x30d2d745, Offset: 0x2158
// Size: 0xf6
function addgibcallback(localclientnum, entity, gibflag, callbackfunction) {
    assert(isfunctionptr(callbackfunction));
    if (!isdefined(entity._gibcallbacks)) {
        entity._gibcallbacks = [];
    }
    if (!isdefined(entity._gibcallbacks[gibflag])) {
        entity._gibcallbacks[gibflag] = [];
    }
    gibcallbacks = entity._gibcallbacks[gibflag];
    gibcallbacks[gibcallbacks.size] = callbackfunction;
    entity._gibcallbacks[gibflag] = gibcallbacks;
}

// Namespace gibclientutils
// Params 2, eflags: 0x1 linked
// Checksum 0x5d4a37dd, Offset: 0x2258
// Size: 0x7c
function cliententgibannihilate(localclientnum, entity) {
    if (!util::is_mature() || util::is_gib_restricted_build()) {
        return;
    }
    entity.ignoreragdoll = 1;
    entity _gibentity(localclientnum, 50 | 384, 1);
}

// Namespace gibclientutils
// Params 2, eflags: 0x1 linked
// Checksum 0x99acda71, Offset: 0x22e0
// Size: 0x54
function cliententgibhead(localclientnum, entity) {
    _gibclientextrainternal(localclientnum, entity, 4);
    _gibclientextrainternal(localclientnum, entity, 8);
}

// Namespace gibclientutils
// Params 2, eflags: 0x1 linked
// Checksum 0x33bace49, Offset: 0x2340
// Size: 0x54
function cliententgibleftarm(localclientnum, entity) {
    if (isgibbed(localclientnum, entity, 16)) {
        return;
    }
    _gibcliententityinternal(localclientnum, entity, 32);
}

// Namespace gibclientutils
// Params 2, eflags: 0x1 linked
// Checksum 0xdb348e9d, Offset: 0x23a0
// Size: 0x54
function cliententgibrightarm(localclientnum, entity) {
    if (isgibbed(localclientnum, entity, 32)) {
        return;
    }
    _gibcliententityinternal(localclientnum, entity, 16);
}

// Namespace gibclientutils
// Params 2, eflags: 0x1 linked
// Checksum 0x10359dca, Offset: 0x2400
// Size: 0x34
function cliententgibleftleg(localclientnum, entity) {
    _gibcliententityinternal(localclientnum, entity, 256);
}

// Namespace gibclientutils
// Params 2, eflags: 0x1 linked
// Checksum 0xadc4650a, Offset: 0x2440
// Size: 0x34
function cliententgibrightleg(localclientnum, entity) {
    _gibcliententityinternal(localclientnum, entity, -128);
}

// Namespace gibclientutils
// Params 2, eflags: 0x1 linked
// Checksum 0x6e4c48b6, Offset: 0x2480
// Size: 0x378
function createscriptmodelofentity(localclientnum, entity) {
    clone = spawn(localclientnum, entity.origin, "script_model");
    clone.angles = entity.angles;
    _clonegibdata(localclientnum, entity, clone);
    gibstate = _getgibbedstate(localclientnum, clone);
    if (!util::is_mature() || util::is_gib_restricted_build()) {
        gibstate = 0;
    }
    if (!(_getgibbedstate(localclientnum, entity) < 16)) {
        clone setmodel(_getgibbedtorsomodel(localclientnum, entity));
        clone attach(_getgibbedlegmodel(localclientnum, entity), "");
    } else {
        clone setmodel(entity.model);
    }
    if (gibstate & 8) {
        if (isdefined(isdefined(clone.gib_data) ? clone.gib_data.torsodmg5 : clone.torsodmg5)) {
            clone attach(isdefined(clone.gib_data) ? clone.gib_data.torsodmg5 : clone.torsodmg5, "");
        }
    } else {
        if (isdefined(isdefined(clone.gib_data) ? clone.gib_data.head : clone.head)) {
            clone attach(isdefined(clone.gib_data) ? clone.gib_data.head : clone.head, "");
        }
        if (!(gibstate & 4) && isdefined(isdefined(clone.gib_data) ? clone.gib_data.hatmodel : clone.hatmodel)) {
            clone attach(isdefined(clone.gib_data) ? clone.gib_data.hatmodel : clone.hatmodel, "");
        }
    }
    return clone;
}

// Namespace gibclientutils
// Params 3, eflags: 0x1 linked
// Checksum 0xb80f09c8, Offset: 0x2800
// Size: 0x38
function isgibbed(localclientnum, entity, gibflag) {
    return _getgibbedstate(localclientnum, entity) & gibflag;
}

// Namespace gibclientutils
// Params 2, eflags: 0x0
// Checksum 0x62794254, Offset: 0x2840
// Size: 0x2e
function isundamaged(localclientnum, entity) {
    return _getgibbedstate(localclientnum, entity) == 0;
}

// Namespace gibclientutils
// Params 2, eflags: 0x1 linked
// Checksum 0xc94319c4, Offset: 0x2878
// Size: 0x64
function gibentity(localclientnum, gibflags) {
    self _gibentity(localclientnum, gibflags, 1);
    self.gib_state = _getgibbedstate(localclientnum, self) | gibflags & 512 - 1;
}

// Namespace gibclientutils
// Params 1, eflags: 0x1 linked
// Checksum 0x85465374, Offset: 0x28e8
// Size: 0xac
function handlegibnotetracks(localclientnum) {
    entity = self;
    entity thread _handlegibannihilate(localclientnum);
    entity thread _handlegibhead(localclientnum);
    entity thread _handlegibrightarm(localclientnum);
    entity thread _handlegibleftarm(localclientnum);
    entity thread _handlegibrightleg(localclientnum);
    entity thread _handlegibleftleg(localclientnum);
}

// Namespace gibclientutils
// Params 1, eflags: 0x1 linked
// Checksum 0xf57717a3, Offset: 0x29a0
// Size: 0x2c
function playergibleftarm(localclientnum) {
    self gibentity(localclientnum, 32);
}

// Namespace gibclientutils
// Params 1, eflags: 0x0
// Checksum 0xdb12aa18, Offset: 0x29d8
// Size: 0x2c
function playergibrightarm(localclientnum) {
    self gibentity(localclientnum, 16);
}

// Namespace gibclientutils
// Params 1, eflags: 0x1 linked
// Checksum 0x4987943e, Offset: 0x2a10
// Size: 0x2c
function playergibleftleg(localclientnum) {
    self gibentity(localclientnum, 256);
}

// Namespace gibclientutils
// Params 1, eflags: 0x0
// Checksum 0x219354d, Offset: 0x2a48
// Size: 0x2c
function playergibrightleg(localclientnum) {
    self gibentity(localclientnum, -128);
}

// Namespace gibclientutils
// Params 1, eflags: 0x0
// Checksum 0x3c5f7a02, Offset: 0x2a80
// Size: 0x4c
function playergiblegs(localclientnum) {
    self gibentity(localclientnum, -128);
    self gibentity(localclientnum, 256);
}

// Namespace gibclientutils
// Params 2, eflags: 0x1 linked
// Checksum 0x1d8d4fba, Offset: 0x2ad8
// Size: 0x32
function playergibtag(localclientnum, gibflag) {
    return _gibpiecetag(localclientnum, self, gibflag);
}

