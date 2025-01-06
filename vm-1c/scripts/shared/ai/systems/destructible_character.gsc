#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;

#namespace destructible_character;

// Namespace destructible_character
// Params 0, eflags: 0x2
// Checksum 0x80508b30, Offset: 0x258
// Size: 0x3ce
function autoexec main() {
    clientfield::register("actor", "destructible_character_state", 1, 21, "int");
    destructibles = struct::get_script_bundles("destructiblecharacterdef");
    processedbundles = [];
    foreach (var_93dca242, destructible in destructibles) {
        destructbundle = spawnstruct();
        destructbundle.piececount = destructible.piececount;
        destructbundle.pieces = [];
        destructbundle.name = var_93dca242;
        for (index = 1; index <= destructbundle.piececount; index++) {
            piecestruct = spawnstruct();
            piecestruct.gibmodel = function_e8ef6cb0(destructible, "piece" + index + "_gibmodel");
            piecestruct.gibtag = function_e8ef6cb0(destructible, "piece" + index + "_gibtag");
            piecestruct.gibfx = function_e8ef6cb0(destructible, "piece" + index + "_gibfx");
            piecestruct.gibfxtag = function_e8ef6cb0(destructible, "piece" + index + "_gibeffecttag");
            piecestruct.gibdynentfx = function_e8ef6cb0(destructible, "piece" + index + "_gibdynentfx");
            piecestruct.gibsound = function_e8ef6cb0(destructible, "piece" + index + "_gibsound");
            piecestruct.hitlocation = function_e8ef6cb0(destructible, "piece" + index + "_hitlocation");
            piecestruct.hidetag = function_e8ef6cb0(destructible, "piece" + index + "_hidetag");
            piecestruct.detachmodel = function_e8ef6cb0(destructible, "piece" + index + "_detachmodel");
            destructbundle.pieces[destructbundle.pieces.size] = piecestruct;
        }
        processedbundles[var_93dca242] = destructbundle;
    }
    level.scriptbundles["destructiblecharacterdef"] = processedbundles;
}

#namespace destructserverutils;

// Namespace destructserverutils
// Params 1, eflags: 0x4
// Checksum 0x5b7d7283, Offset: 0x630
// Size: 0x32
function private _getdestructstate(entity) {
    if (isdefined(entity._destruct_state)) {
        return entity._destruct_state;
    }
    return 0;
}

// Namespace destructserverutils
// Params 2, eflags: 0x4
// Checksum 0xe9f4b4ff, Offset: 0x670
// Size: 0x6c
function private _setdestructed(entity, destructflag) {
    entity._destruct_state = _getdestructstate(entity) | destructflag;
    entity clientfield::set("destructible_character_state", entity._destruct_state);
}

// Namespace destructserverutils
// Params 2, eflags: 0x0
// Checksum 0x7c881414, Offset: 0x6e8
// Size: 0x6c
function copydestructstate(originalentity, newentity) {
    newentity._destruct_state = _getdestructstate(originalentity);
    togglespawngibs(newentity, 0);
    reapplydestructedpieces(newentity);
}

// Namespace destructserverutils
// Params 2, eflags: 0x0
// Checksum 0xf486511e, Offset: 0x760
// Size: 0xf6
function destructhitlocpieces(entity, hitloc) {
    if (isdefined(entity.destructibledef)) {
        destructbundle = struct::get_script_bundle("destructiblecharacterdef", entity.destructibledef);
        for (index = 1; index <= destructbundle.pieces.size; index++) {
            piece = destructbundle.pieces[index - 1];
            if (isdefined(piece.hitlocation) && piece.hitlocation == hitloc) {
                destructpiece(entity, index);
            }
        }
    }
}

// Namespace destructserverutils
// Params 1, eflags: 0x0
// Checksum 0x6431abe9, Offset: 0x860
// Size: 0x6c
function destructleftarmpieces(entity) {
    destructhitlocpieces(entity, "left_arm_upper");
    destructhitlocpieces(entity, "left_arm_lower");
    destructhitlocpieces(entity, "left_hand");
}

// Namespace destructserverutils
// Params 1, eflags: 0x0
// Checksum 0x4616100b, Offset: 0x8d8
// Size: 0x6c
function destructleftlegpieces(entity) {
    destructhitlocpieces(entity, "left_leg_upper");
    destructhitlocpieces(entity, "left_leg_lower");
    destructhitlocpieces(entity, "left_foot");
}

// Namespace destructserverutils
// Params 2, eflags: 0x0
// Checksum 0xe0c62230, Offset: 0x950
// Size: 0x194
function destructpiece(entity, piecenumber) {
    assert(1 <= piecenumber && piecenumber <= 20);
    if (isdestructed(entity, piecenumber)) {
        return;
    }
    _setdestructed(entity, 1 << piecenumber);
    if (!isdefined(entity.destructibledef)) {
        return;
    }
    destructbundle = struct::get_script_bundle("destructiblecharacterdef", entity.destructibledef);
    piece = destructbundle.pieces[piecenumber - 1];
    if (isdefined(piece.hidetag) && entity haspart(piece.hidetag)) {
        entity hidepart(piece.hidetag);
    }
    if (isdefined(piece.detachmodel)) {
        entity detach(piece.detachmodel, "");
    }
}

// Namespace destructserverutils
// Params 2, eflags: 0x0
// Checksum 0xb71e5d11, Offset: 0xaf0
// Size: 0x188
function destructnumberrandompieces(entity, num_pieces_to_destruct) {
    if (!isdefined(num_pieces_to_destruct)) {
        num_pieces_to_destruct = 0;
    }
    destructible_pieces_list = [];
    destructablepieces = getpiececount(entity);
    if (num_pieces_to_destruct == 0) {
        num_pieces_to_destruct = destructablepieces;
    }
    for (i = 0; i < destructablepieces; i++) {
        destructible_pieces_list[i] = i + 1;
    }
    destructible_pieces_list = array::randomize(destructible_pieces_list);
    foreach (piece in destructible_pieces_list) {
        if (!isdestructed(entity, piece)) {
            destructpiece(entity, piece);
            num_pieces_to_destruct--;
            if (num_pieces_to_destruct == 0) {
                break;
            }
        }
    }
}

// Namespace destructserverutils
// Params 1, eflags: 0x0
// Checksum 0x69fabbac, Offset: 0xc80
// Size: 0x8e
function destructrandompieces(entity) {
    destructpieces = getpiececount(entity);
    for (index = 0; index < destructpieces; index++) {
        if (math::cointoss()) {
            destructpiece(entity, index + 1);
        }
    }
}

// Namespace destructserverutils
// Params 1, eflags: 0x0
// Checksum 0x81d5bd7e, Offset: 0xd18
// Size: 0x6c
function destructrightarmpieces(entity) {
    destructhitlocpieces(entity, "right_arm_upper");
    destructhitlocpieces(entity, "right_arm_lower");
    destructhitlocpieces(entity, "right_hand");
}

// Namespace destructserverutils
// Params 1, eflags: 0x0
// Checksum 0xd0a8f0cf, Offset: 0xd90
// Size: 0x6c
function destructrightlegpieces(entity) {
    destructhitlocpieces(entity, "right_leg_upper");
    destructhitlocpieces(entity, "right_leg_lower");
    destructhitlocpieces(entity, "right_foot");
}

// Namespace destructserverutils
// Params 1, eflags: 0x0
// Checksum 0x5831dddd, Offset: 0xe08
// Size: 0x6a
function getpiececount(entity) {
    if (isdefined(entity.destructibledef)) {
        destructbundle = struct::get_script_bundle("destructiblecharacterdef", entity.destructibledef);
        if (isdefined(destructbundle)) {
            return destructbundle.piececount;
        }
    }
    return 0;
}

// Namespace destructserverutils
// Params 12, eflags: 0x0
// Checksum 0xb4d83525, Offset: 0xe80
// Size: 0x100
function handledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
    entity = self;
    if (isdefined(entity.skipdeath) && entity.skipdeath) {
        return idamage;
    }
    if (isdefined(entity.var_132756fd) && entity.var_132756fd) {
        return idamage;
    }
    togglespawngibs(entity, 1);
    destructhitlocpieces(entity, shitloc);
    return idamage;
}

// Namespace destructserverutils
// Params 2, eflags: 0x0
// Checksum 0xf5e6bf8c, Offset: 0xf88
// Size: 0x66
function isdestructed(entity, piecenumber) {
    assert(1 <= piecenumber && piecenumber <= 20);
    return _getdestructstate(entity) & 1 << piecenumber;
}

// Namespace destructserverutils
// Params 1, eflags: 0x0
// Checksum 0x211c5f3e, Offset: 0xff8
// Size: 0x12e
function reapplydestructedpieces(entity) {
    if (!isdefined(entity.destructibledef)) {
        return;
    }
    destructbundle = struct::get_script_bundle("destructiblecharacterdef", entity.destructibledef);
    for (index = 1; index <= destructbundle.pieces.size; index++) {
        if (!isdestructed(entity, index)) {
            continue;
        }
        piece = destructbundle.pieces[index - 1];
        if (isdefined(piece.hidetag) && entity haspart(piece.hidetag)) {
            entity hidepart(piece.hidetag);
        }
    }
}

// Namespace destructserverutils
// Params 1, eflags: 0x0
// Checksum 0xbbc3b6d1, Offset: 0x1130
// Size: 0x10e
function showdestructedpieces(entity) {
    if (!isdefined(entity.destructibledef)) {
        return;
    }
    destructbundle = struct::get_script_bundle("destructiblecharacterdef", entity.destructibledef);
    for (index = 1; index <= destructbundle.pieces.size; index++) {
        piece = destructbundle.pieces[index - 1];
        if (isdefined(piece.hidetag) && entity haspart(piece.hidetag)) {
            entity showpart(piece.hidetag);
        }
    }
}

// Namespace destructserverutils
// Params 2, eflags: 0x0
// Checksum 0x50fba039, Offset: 0x1248
// Size: 0xa4
function togglespawngibs(entity, shouldspawngibs) {
    if (shouldspawngibs) {
        entity._destruct_state = _getdestructstate(entity) | 1;
    } else {
        entity._destruct_state = _getdestructstate(entity) & -2;
    }
    entity clientfield::set("destructible_character_state", entity._destruct_state);
}

