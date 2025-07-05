#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace skeleton;

// Namespace skeleton
// Params 0, eflags: 0x2
// Checksum 0xb77616bf, Offset: 0x138
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("skeleton", &__init__, undefined, undefined);
}

// Namespace skeleton
// Params 0, eflags: 0x2
// Checksum 0x99ec1590, Offset: 0x178
// Size: 0x4
function autoexec precache() {
    
}

// Namespace skeleton
// Params 0, eflags: 0x0
// Checksum 0x90eda43c, Offset: 0x188
// Size: 0x64
function __init__() {
    if (ai::shouldregisterclientfieldforarchetype("skeleton")) {
        clientfield::register("actor", "skeleton", 1, 1, "int", &zombieclientutils::zombiehandler, 0, 0);
    }
}

#namespace zombieclientutils;

// Namespace zombieclientutils
// Params 7, eflags: 0x0
// Checksum 0xcdfb6200, Offset: 0x1f8
// Size: 0x184
function zombiehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (isdefined(entity.archetype) && entity.archetype != "zombie") {
        return;
    }
    if (!isdefined(entity.initializedgibcallbacks) || !entity.initializedgibcallbacks) {
        entity.initializedgibcallbacks = 1;
        gibclientutils::addgibcallback(localclientnum, entity, 8, &_gibcallback);
        gibclientutils::addgibcallback(localclientnum, entity, 16, &_gibcallback);
        gibclientutils::addgibcallback(localclientnum, entity, 32, &_gibcallback);
        gibclientutils::addgibcallback(localclientnum, entity, -128, &_gibcallback);
        gibclientutils::addgibcallback(localclientnum, entity, 256, &_gibcallback);
    }
}

// Namespace zombieclientutils
// Params 3, eflags: 0x4
// Checksum 0x3ac2300a, Offset: 0x388
// Size: 0xa6
function private _gibcallback(localclientnum, entity, gibflag) {
    switch (gibflag) {
    case 8:
        playsound(0, "zmb_zombie_head_gib", self.origin);
        break;
    case 16:
    case 32:
    case 128:
    case 256:
        playsound(0, "zmb_death_gibs", self.origin);
        break;
    }
}

