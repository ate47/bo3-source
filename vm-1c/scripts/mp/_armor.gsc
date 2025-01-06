#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace armor;

// Namespace armor
// Params 1, eflags: 0x0
// Checksum 0xc4148b87, Offset: 0x148
// Size: 0xec
function setlightarmorhp(newvalue) {
    if (isdefined(newvalue)) {
        self.lightarmorhp = newvalue;
        if (isplayer(self) && isdefined(self.var_89273a50) && self.var_89273a50 > 0) {
            lightarmorpercent = math::clamp(self.lightarmorhp / self.var_89273a50, 0, 1);
            self setcontrolleruimodelvalue("hudItems.armorPercent", lightarmorpercent);
        }
        return;
    }
    self.lightarmorhp = undefined;
    self.var_89273a50 = undefined;
    self setcontrolleruimodelvalue("hudItems.armorPercent", 0);
}

// Namespace armor
// Params 1, eflags: 0x0
// Checksum 0x8c781c9f, Offset: 0x240
// Size: 0xb4
function setlightarmor(optionalarmorvalue) {
    self notify(#"give_light_armor");
    if (isdefined(self.lightarmorhp)) {
        unsetlightarmor();
    }
    self thread removelightarmorondeath();
    self thread removelightarmoronmatchend();
    if (isdefined(optionalarmorvalue)) {
        self.var_89273a50 = optionalarmorvalue;
    } else {
        self.var_89273a50 = -106;
    }
    self setlightarmorhp(self.var_89273a50);
}

// Namespace armor
// Params 0, eflags: 0x0
// Checksum 0xba7ec9f2, Offset: 0x300
// Size: 0x44
function removelightarmorondeath() {
    self endon(#"disconnect");
    self endon(#"give_light_armor");
    self endon(#"remove_light_armor");
    self waittill(#"death");
    unsetlightarmor();
}

// Namespace armor
// Params 0, eflags: 0x0
// Checksum 0x602433bd, Offset: 0x350
// Size: 0x2a
function unsetlightarmor() {
    self setlightarmorhp(undefined);
    self notify(#"remove_light_armor");
}

// Namespace armor
// Params 0, eflags: 0x0
// Checksum 0x2bf70c92, Offset: 0x388
// Size: 0x3c
function removelightarmoronmatchend() {
    self endon(#"disconnect");
    self endon(#"remove_light_armor");
    level waittill(#"game_ended");
    self thread unsetlightarmor();
}

// Namespace armor
// Params 0, eflags: 0x0
// Checksum 0x62d02b25, Offset: 0x3d0
// Size: 0x1a
function haslightarmor() {
    return isdefined(self.lightarmorhp) && self.lightarmorhp > 0;
}

// Namespace armor
// Params 0, eflags: 0x0
// Checksum 0x5530d2f0, Offset: 0x3f8
// Size: 0x1a
function function_3e7fdc00() {
    if (isdefined(self.lightarmorhp)) {
        return self.lightarmorhp;
    }
    return 0;
}

