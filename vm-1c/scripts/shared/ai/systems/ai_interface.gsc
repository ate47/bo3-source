#namespace ai_interface;

/#

    // Namespace ai_interface
    // Params 0, eflags: 0x2
    // Checksum 0x493a47d0, Offset: 0xe8
    // Size: 0x2c
    function autoexec main() {
        level.__ai_debuginterface = getdvarint("<dev string:x28>");
    }

    // Namespace ai_interface
    // Params 3, eflags: 0x5 linked
    // Checksum 0x85fdf085, Offset: 0x120
    // Size: 0x2d6
    function private _checkvalue(archetype, attributename, value) {
        attribute = level.__ai_interface[archetype][attributename];
        switch (attribute["<dev string:x3a>"]) {
        case "<dev string:x3f>":
            possiblevalues = attribute["<dev string:x50>"];
            assert(!isarray(possiblevalues) || isinarray(possiblevalues, value), "<dev string:x57>" + value + "<dev string:x5d>" + attributename + "<dev string:x90>");
            break;
        case "<dev string:x93>":
            maxvalue = attribute["<dev string:xa6>"];
            minvalue = attribute["<dev string:xb0>"];
            assert(isint(value) || isfloat(value), "<dev string:xba>" + attributename + "<dev string:xca>" + value + "<dev string:xeb>");
            assert(value <= maxvalue && (!isdefined(maxvalue) && !isdefined(minvalue) || value >= minvalue), "<dev string:x57>" + value + "<dev string:xff>" + minvalue + "<dev string:x123>" + maxvalue + "<dev string:x125>");
            break;
        case "<dev string:x128>":
            if (isdefined(value)) {
                assert(isvec(value), "<dev string:xba>" + attributename + "<dev string:x13a>" + value + "<dev string:xeb>");
            }
            break;
        default:
            assert("<dev string:x15a>" + attribute["<dev string:x3a>"] + "<dev string:x17a>" + attributename + "<dev string:x90>");
            break;
        }
    }

    // Namespace ai_interface
    // Params 2, eflags: 0x5 linked
    // Checksum 0x7b801fce, Offset: 0x400
    // Size: 0x2b4
    function private _checkprerequisites(entity, attribute) {
        assert(isentity(entity), "<dev string:x18c>");
        assert(isactor(entity) || isvehicle(entity), "<dev string:x1bc>");
        assert(isstring(attribute), "<dev string:x1f6>");
        if (isdefined(level.__ai_debuginterface) && level.__ai_debuginterface > 0) {
            assert(isarray(entity.__interface), "<dev string:x21f>" + entity.archetype + "<dev string:x22b>" + "<dev string:x25c>");
            assert(isarray(level.__ai_interface), "<dev string:x28b>");
            assert(isarray(level.__ai_interface[entity.archetype]), "<dev string:x2d4>" + entity.archetype + "<dev string:x2f6>");
            assert(isarray(level.__ai_interface[entity.archetype][attribute]), "<dev string:xba>" + attribute + "<dev string:x30e>" + entity.archetype + "<dev string:x338>");
            assert(isstring(level.__ai_interface[entity.archetype][attribute]["<dev string:x3a>"]), "<dev string:x33f>" + attribute + "<dev string:x90>");
        }
    }

    // Namespace ai_interface
    // Params 3, eflags: 0x5 linked
    // Checksum 0x758169d8, Offset: 0x6c0
    // Size: 0xcc
    function private _checkregistrationprerequisites(archetype, attribute, callbackfunction) {
        assert(isstring(archetype), "<dev string:x365>");
        assert(isstring(attribute), "<dev string:x39a>");
        assert(!isdefined(callbackfunction) || isfunctionptr(callbackfunction), "<dev string:x3cf>");
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
        assert(!isdefined(possiblevalues) || isarray(possiblevalues), "<dev string:x41f>");
    #/
    ai_interface::_initializelevelinterface(archetype);
    assert(!isdefined(level.__ai_interface[archetype][attribute]), "<dev string:x57>" + attribute + "<dev string:x463>" + archetype + "<dev string:x48b>");
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
        assert(!isdefined(minimum) || isint(minimum) || isfloat(minimum), "<dev string:x48d>");
        assert(!isdefined(maximum) || isint(maximum) || isfloat(maximum), "<dev string:x4cb>");
        assert(isdefined(minimum) && (!isdefined(minimum) && !isdefined(maximum) || isdefined(maximum)), "<dev string:x509>");
        assert(!isdefined(minimum) && !isdefined(maximum) || minimum <= maximum, "<dev string:xba>" + attribute + "<dev string:x55d>" + "<dev string:x586>");
    #/
    ai_interface::_initializelevelinterface(archetype);
    assert(!isdefined(level.__ai_interface[archetype][attribute]), "<dev string:x57>" + attribute + "<dev string:x463>" + archetype + "<dev string:x48b>");
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
    assert(!isdefined(level.__ai_interface[archetype][attribute]), "<dev string:x57>" + attribute + "<dev string:x463>" + archetype + "<dev string:x48b>");
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

