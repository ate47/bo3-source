#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/fx_character;
#using scripts/shared/util_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/ai_shared;

#using_animtree("generic");

#namespace archetype_human;

// Namespace archetype_human
// Params 0, eflags: 0x2
// Checksum 0x99ec1590, Offset: 0x170
// Size: 0x4
function precache() {
    
}

// Namespace archetype_human
// Params 0, eflags: 0x2
// Checksum 0xd88af5a1, Offset: 0x180
// Size: 0x4c
function main() {
    clientfield::register("actor", "facial_dial", 1, 1, "int", &humanclientutils::facialdialoguehandler, 0, 1);
}

#namespace humanclientutils;

// Namespace humanclientutils
// Params 7, eflags: 0x1 linked
// Checksum 0xd40ee132, Offset: 0x1d8
// Size: 0x8c
function facialdialoguehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self.facialdialogueactive = 1;
        return;
    }
    if (isdefined(self.facialdialogueactive) && self.facialdialogueactive) {
        self clearanim(generic%faces, 0);
    }
}

