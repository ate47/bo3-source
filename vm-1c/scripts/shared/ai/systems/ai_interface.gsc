#namespace ai_interface;

/#

    // Namespace ai_interface
    // Params 0, eflags: 0x2
    // Checksum 0x493a47d0, Offset: 0xe8
    // Size: 0x2c
    function autoexec main() {
        level.__ai_debuginterface = getdvarint("_interface_vector");
    }

    // Namespace ai_interface
    // Params 3, eflags: 0x5 linked
    // Checksum 0x85fdf085, Offset: 0x120
    // Size: 0x2d6
    function private _checkvalue(archetype, attributename, value) {
        attribute = level.__ai_interface[archetype][attributename];
        switch (attribute["_interface_vector"]) {
        case 8:
            possiblevalues = attribute["_interface_vector"];
            assert(!isarray(possiblevalues) || isinarray(possiblevalues, value), "_interface_vector" + value + "_interface_vector" + attributename + "_interface_vector");
            break;
        case 8:
            maxvalue = attribute["_interface_vector"];
            minvalue = attribute["_interface_vector"];
            assert(isint(value) || isfloat(value), "_interface_vector" + attributename + "_interface_vector" + value + "_interface_vector");
            assert(value <= maxvalue && (!isdefined(maxvalue) && !isdefined(minvalue) || value >= minvalue), "_interface_vector" + value + "_interface_vector" + minvalue + "_interface_vector" + maxvalue + "_interface_vector");
            break;
        case 8:
            if (isdefined(value)) {
                assert(isvec(value), "_interface_vector" + attributename + "_interface_vector" + value + "_interface_vector");
            }
            break;
        default:
            assert("_interface_vector" + attribute["_interface_vector"] + "_interface_vector" + attributename + "_interface_vector");
            break;
        }
    }

    // Namespace ai_interface
    // Params 2, eflags: 0x5 linked
    // Checksum 0x7b801fce, Offset: 0x400
    // Size: 0x2b4
    function private _checkprerequisites(entity, attribute) {
        assert(isentity(entity), "_interface_vector");
        assert(isactor(entity) || isvehicle(entity), "_interface_vector");
        assert(isstring(attribute), "_interface_vector");
        if (isdefined(level.__ai_debuginterface) && level.__ai_debuginterface > 0) {
            assert(isarray(entity.__interface), "_interface_vector" + entity.archetype + "_interface_vector" + "_interface_vector");
            assert(isarray(level.__ai_interface), "_interface_vector");
            assert(isarray(level.__ai_interface[entity.archetype]), "_interface_vector" + entity.archetype + "_interface_vector");
            assert(isarray(level.__ai_interface[entity.archetype][attribute]), "_interface_vector" + attribute + "_interface_vector" + entity.archetype + "_interface_vector");
            assert(isstring(level.__ai_interface[entity.archetype][attribute]["_interface_vector"]), "_interface_vector" + attribute + "_interface_vector");
        }
    }

    // Namespace ai_interface
    // Params 3, eflags: 0x5 linked
    // Checksum 0x758169d8, Offset: 0x6c0
    // Size: 0xcc
    function private _checkregistrationprerequisites(archetype, attribute, callbackfunction) {
        assert(isstring(archetype), "_interface_vector");
        assert(isstring(attribute), "_interface_vector");
        assert(!isdefined(callbackfunction) || isfunctionptr(callbackfunction), "_interface_vector");
    }

#/

// Namespace ai_interface
// Params 1, eflags: 0x5 linked
// Checksum 0xc53888b5, Offset: 0x798
// Size: 0x46
function private _initializelevelinterface(archetype) {
    if (!isdefined(level.__ai_interface)) {
        level.__ai_interface = [];
    }
    if (!isdefined(level.__ai_interface[archetype])) {
        level.__ai_interface[archetype] = [];
    }
}

#namespace ai;

// Namespace ai
// Params 1, eflags: 0x1 linked
// Checksum 0x16e05325, Offset: 0x7e8
// Size: 0x30
function createinterfaceforentity(entity) {
    if (!isdefined(entity.__interface)) {
        entity.__interface = [];
    }
}

// Namespace ai
// Params 2, eflags: 0x1 linked
// Checksum 0xf3e78b73, Offset: 0x820
// Size: 0x88
function getaiattribute(entity, attribute) {
    /#
        ai_interface::_checkprerequisites(entity, attribute);
    #/
    if (!isdefined(entity.__interface[attribute])) {
        return level.__ai_interface[entity.archetype][attribute]["default_value"];
    }
    return entity.__interface[attribute];
}

// Namespace ai
// Params 2, eflags: 0x1 linked
// Checksum 0x1fec0c42, Offset: 0x8b0
// Size: 0x84
function hasaiattribute(entity, attribute) {
    return isdefined(entity) && isdefined(attribute) && isdefined(entity.archetype) && isdefined(level.__ai_interface) && isdefined(level.__ai_interface[entity.archetype]) && isdefined(level.__ai_interface[entity.archetype][attribute]);
}

// Namespace ai
// Params 5, eflags: 0x1 linked
// Checksum 0x28515adb, Offset: 0x940
// Size: 0x1cc
function registermatchedinterface(archetype, attribute, defaultvalue, possiblevalues, callbackfunction) {
    /#
        ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
        assert(!isdefined(possiblevalues) || isarray(possiblevalues), "_interface_vector");
    #/
    ai_interface::_initializelevelinterface(archetype);
    assert(!isdefined(level.__ai_interface[archetype][attribute]), "_interface_vector" + attribute + "_interface_vector" + archetype + "_interface_vector");
    level.__ai_interface[archetype][attribute] = [];
    level.__ai_interface[archetype][attribute]["callback"] = callbackfunction;
    level.__ai_interface[archetype][attribute]["default_value"] = defaultvalue;
    level.__ai_interface[archetype][attribute]["type"] = "_interface_match";
    level.__ai_interface[archetype][attribute]["values"] = possiblevalues;
    /#
        ai_interface::_checkvalue(archetype, attribute, defaultvalue);
    #/
}

// Namespace ai
// Params 6, eflags: 0x1 linked
// Checksum 0x29ba9605, Offset: 0xb18
// Size: 0x304
function registernumericinterface(archetype, attribute, defaultvalue, minimum, maximum, callbackfunction) {
    /#
        ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
        assert(!isdefined(minimum) || isint(minimum) || isfloat(minimum), "_interface_vector");
        assert(!isdefined(maximum) || isint(maximum) || isfloat(maximum), "_interface_vector");
        assert(isdefined(minimum) && (!isdefined(minimum) && !isdefined(maximum) || isdefined(maximum)), "_interface_vector");
        assert(!isdefined(minimum) && !isdefined(maximum) || minimum <= maximum, "_interface_vector" + attribute + "_interface_vector" + "_interface_vector");
    #/
    ai_interface::_initializelevelinterface(archetype);
    assert(!isdefined(level.__ai_interface[archetype][attribute]), "_interface_vector" + attribute + "_interface_vector" + archetype + "_interface_vector");
    level.__ai_interface[archetype][attribute] = [];
    level.__ai_interface[archetype][attribute]["callback"] = callbackfunction;
    level.__ai_interface[archetype][attribute]["default_value"] = defaultvalue;
    level.__ai_interface[archetype][attribute]["max_value"] = maximum;
    level.__ai_interface[archetype][attribute]["min_value"] = minimum;
    level.__ai_interface[archetype][attribute]["type"] = "_interface_numeric";
    /#
        ai_interface::_checkvalue(archetype, attribute, defaultvalue);
    #/
}

// Namespace ai
// Params 4, eflags: 0x1 linked
// Checksum 0xe702d1d2, Offset: 0xe28
// Size: 0x15c
function registervectorinterface(archetype, attribute, defaultvalue, callbackfunction) {
    /#
        ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
    #/
    ai_interface::_initializelevelinterface(archetype);
    assert(!isdefined(level.__ai_interface[archetype][attribute]), "_interface_vector" + attribute + "_interface_vector" + archetype + "_interface_vector");
    level.__ai_interface[archetype][attribute] = [];
    level.__ai_interface[archetype][attribute]["callback"] = callbackfunction;
    level.__ai_interface[archetype][attribute]["default_value"] = defaultvalue;
    level.__ai_interface[archetype][attribute]["type"] = "_interface_vector";
    /#
        ai_interface::_checkvalue(archetype, attribute, defaultvalue);
    #/
}

// Namespace ai
// Params 3, eflags: 0x1 linked
// Checksum 0x4b1eb09, Offset: 0xf90
// Size: 0x13a
function setaiattribute(entity, attribute, value) {
    /#
        ai_interface::_checkprerequisites(entity, attribute);
        ai_interface::_checkvalue(entity.archetype, attribute, value);
    #/
    oldvalue = entity.__interface[attribute];
    if (!isdefined(oldvalue)) {
        oldvalue = level.__ai_interface[entity.archetype][attribute]["default_value"];
    }
    entity.__interface[attribute] = value;
    callback = level.__ai_interface[entity.archetype][attribute]["callback"];
    if (isfunctionptr(callback)) {
        [[ callback ]](entity, attribute, oldvalue, value);
    }
}

