#namespace blackboard;

// Namespace blackboard
// Params 4, eflags: 0x1 linked
// Checksum 0x13510906, Offset: 0x80
// Size: 0x11e
function registerblackboardattribute(entity, attributename, defaultattributevalue, getterfunction) {
    assert(isdefined(entity.__blackboard), "<dev string:x28>");
    assert(!isdefined(entity.__blackboard[attributename]), "<dev string:x65>" + attributename + "<dev string:x7d>");
    if (isdefined(getterfunction)) {
        assert(isfunctionptr(getterfunction));
        entity.__blackboard[attributename] = getterfunction;
        return;
    }
    if (!isdefined(defaultattributevalue)) {
        defaultattributevalue = undefined;
    }
    entity.__blackboard[attributename] = defaultattributevalue;
}

// Namespace blackboard
// Params 2, eflags: 0x1 linked
// Checksum 0x2bc848d0, Offset: 0x1a8
// Size: 0x112
function getblackboardattribute(entity, attributename) {
    if (isfunctionptr(entity.__blackboard[attributename])) {
        getterfunction = entity.__blackboard[attributename];
        attributevalue = entity [[ getterfunction ]]();
        /#
            if (isactor(entity)) {
                entity updatetrackedblackboardattribute(attributename);
            }
        #/
        return attributevalue;
    }
    /#
        if (isactor(entity)) {
            entity updatetrackedblackboardattribute(attributename);
        }
    #/
    return entity.__blackboard[attributename];
}

// Namespace blackboard
// Params 3, eflags: 0x1 linked
// Checksum 0xd86dd684, Offset: 0x2c8
// Size: 0x10c
function setblackboardattribute(entity, attributename, attributevalue) {
    if (isdefined(entity.__blackboard[attributename])) {
        if (!isdefined(attributevalue) && isfunctionptr(entity.__blackboard[attributename])) {
            return;
        }
        assert(!isfunctionptr(entity.__blackboard[attributename]), "<dev string:x92>");
    }
    entity.__blackboard[attributename] = attributevalue;
    /#
        if (isactor(entity)) {
            entity updatetrackedblackboardattribute(attributename);
        }
    #/
}

// Namespace blackboard
// Params 1, eflags: 0x1 linked
// Checksum 0x3811a412, Offset: 0x3e0
// Size: 0x54
function createblackboardforentity(entity) {
    if (!isdefined(entity.__blackboard)) {
        entity.__blackboard = [];
    }
    if (!isdefined(level._setblackboardattributefunc)) {
        level._setblackboardattributefunc = &setblackboardattribute;
    }
}

