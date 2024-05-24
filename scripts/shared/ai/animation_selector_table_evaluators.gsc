#using scripts/shared/array_shared;
#using scripts/shared/ai/systems/animation_selector_table;

#namespace animation_selector_table_evaluators;

// Namespace animation_selector_table_evaluators
// Params 0, eflags: 0x2
// Checksum 0xc33db53e, Offset: 0x1c8
// Size: 0xa4
function autoexec registerastscriptfunctions() {
    animationselectortable::registeranimationselectortableevaluator("testFunction", &testfunction);
    animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimations", &evaluateblockedanimations);
    animationselectortable::registeranimationselectortableevaluator("evaluateHumanTurnAnimations", &evaluatehumanturnanimations);
    animationselectortable::registeranimationselectortableevaluator("evaluateHumanExposedArrivalAnimations", &evaluatehumanexposedarrivalanimations);
}

// Namespace animation_selector_table_evaluators
// Params 2, eflags: 0x1 linked
// Checksum 0xa47604a4, Offset: 0x278
// Size: 0x46
function testfunction(entity, animations) {
    if (isarray(animations) && animations.size > 0) {
        return animations[0];
    }
}

// Namespace animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0xdc0858, Offset: 0x2c8
// Size: 0x256
function private evaluator_checkanimationagainstgeo(entity, animation) {
    pixbeginevent("Evaluator_CheckAnimationAgainstGeo");
    /#
        assert(isactor(entity));
    #/
    localdeltahalfvector = getmovedelta(animation, 0, 0.5, entity);
    midpoint = entity localtoworldcoords(localdeltahalfvector);
    midpoint = (midpoint[0], midpoint[1], entity.origin[2]);
    /#
        recordline(entity.origin, midpoint, (1, 0.5, 0), "<unknown string>", entity);
    #/
    if (entity maymovetopoint(midpoint, 1, 1)) {
        localdeltavector = getmovedelta(animation, 0, 1, entity);
        endpoint = entity localtoworldcoords(localdeltavector);
        endpoint = (endpoint[0], endpoint[1], entity.origin[2]);
        /#
            recordline(midpoint, endpoint, (1, 0.5, 0), "<unknown string>", entity);
        #/
        if (entity maymovefrompointtopoint(midpoint, endpoint, 1, 1)) {
            pixendevent();
            return true;
        }
    }
    pixendevent();
    return false;
}

// Namespace animation_selector_table_evaluators
// Params 2, eflags: 0x4
// Checksum 0x2fcb299b, Offset: 0x528
// Size: 0x12e
function private evaluator_checkanimationendpointagainstgeo(entity, animation) {
    pixbeginevent("Evaluator_CheckAnimationEndPointAgainstGeo");
    /#
        assert(isactor(entity));
    #/
    localdeltavector = getmovedelta(animation, 0, 1, entity);
    endpoint = entity localtoworldcoords(localdeltavector);
    endpoint = (endpoint[0], endpoint[1], entity.origin[2]);
    if (entity maymovetopoint(endpoint, 0, 0)) {
        pixendevent();
        return true;
    }
    pixendevent();
    return false;
}

// Namespace animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0x6a17f2a2, Offset: 0x660
// Size: 0x19e
function private evaluator_checkanimationforovershootinggoal(entity, animation) {
    pixbeginevent("Evaluator_CheckAnimationForOverShootingGoal");
    /#
        assert(isactor(entity));
    #/
    localdeltavector = getmovedelta(animation, 0, 1, entity);
    endpoint = entity localtoworldcoords(localdeltavector);
    animdistsq = lengthsquared(localdeltavector);
    if (entity haspath()) {
        startpos = entity.origin;
        goalpos = entity.pathgoalpos;
        /#
            assert(isdefined(goalpos));
        #/
        disttogoalsq = distancesquared(startpos, goalpos);
        if (animdistsq < disttogoalsq) {
            pixendevent();
            return true;
        }
    }
    pixendevent();
    return false;
}

// Namespace animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0x60939db6, Offset: 0x808
// Size: 0xbe
function private evaluator_checkanimationagainstnavmesh(entity, animation) {
    /#
        assert(isactor(entity));
    #/
    localdeltavector = getmovedelta(animation, 0, 1, entity);
    endpoint = entity localtoworldcoords(localdeltavector);
    if (ispointonnavmesh(endpoint, entity)) {
        return true;
    }
    return false;
}

// Namespace animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0x29c22af3, Offset: 0x8d0
// Size: 0x112
function private evaluator_checkanimationarrivalposition(entity, animation) {
    localdeltavector = getmovedelta(animation, 0, 1, entity);
    endpoint = entity localtoworldcoords(localdeltavector);
    animdistsq = lengthsquared(localdeltavector);
    startpos = entity.origin;
    goalpos = entity.pathgoalpos;
    disttogoalsq = distancesquared(startpos, goalpos);
    return disttogoalsq < animdistsq && entity isposatgoal(endpoint);
}

// Namespace animation_selector_table_evaluators
// Params 3, eflags: 0x5 linked
// Checksum 0xdbfa0def, Offset: 0x9f0
// Size: 0x1ce
function private evaluator_findfirstvalidanimation(entity, animations, tests) {
    /#
        assert(isarray(animations), "<unknown string>");
    #/
    /#
        assert(isarray(tests), "<unknown string>");
    #/
    foreach (aliasanimations in animations) {
        if (aliasanimations.size > 0) {
            valid = 1;
            animation = aliasanimations[0];
            foreach (test in tests) {
                if (![[ test ]](entity, animation)) {
                    valid = 0;
                    break;
                }
            }
            if (valid) {
                return animation;
            }
        }
    }
}

// Namespace animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0x50cc3fa2, Offset: 0xbc8
// Size: 0x6e
function private evaluateblockedanimations(entity, animations) {
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstgeo, &evaluator_checkanimationforovershootinggoal));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0xaa2165c4, Offset: 0xc40
// Size: 0xee
function private evaluatehumanturnanimations(entity, animations) {
    /#
        if (isdefined(level.ai_dontturn) && level.ai_dontturn) {
            return undefined;
        }
    #/
    /#
        record3dtext("<unknown string>" + gettime() + "<unknown string>", entity.origin, (1, 0.5, 0), "<unknown string>", entity);
    #/
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationforovershootinggoal, &evaluator_checkanimationagainstgeo, &evaluator_checkanimationagainstnavmesh));
    }
    return undefined;
}

// Namespace animation_selector_table_evaluators
// Params 2, eflags: 0x5 linked
// Checksum 0x696dd51b, Offset: 0xd38
// Size: 0x76
function private evaluatehumanexposedarrivalanimations(entity, animations) {
    if (!isdefined(entity.pathgoalpos)) {
        return undefined;
    }
    if (animations.size > 0) {
        return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationarrivalposition));
    }
    return undefined;
}

