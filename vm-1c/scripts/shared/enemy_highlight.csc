#using scripts/cp/_util;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_68dfcbbe;

// Namespace namespace_68dfcbbe
// Params 7, eflags: 0x1 linked
// Checksum 0xaf4b7203, Offset: 0x160
// Size: 0xac
function function_a2489af5(localclientnum, materialname, size, var_e9190fc5, var_125eba4d, var_63949c1d, var_fe79589d) {
    self notify(#"hash_a2489af5");
    self.var_a2489af5 = 1;
    self thread function_eab5058b(localclientnum, var_63949c1d, var_fe79589d);
    self thread function_43ee2d3f(localclientnum, materialname, size, var_e9190fc5, var_125eba4d, var_fe79589d);
}

// Namespace namespace_68dfcbbe
// Params 3, eflags: 0x1 linked
// Checksum 0x4db856fe, Offset: 0x218
// Size: 0x304
function function_eab5058b(localclientnum, var_63949c1d, var_fe79589d) {
    self endon(#"hash_a2489af5");
    if (!isdefined(var_63949c1d)) {
        var_63949c1d = 0;
    }
    if (!isdefined(self.var_e88f18d7)) {
        self.var_e88f18d7 = [];
    }
    while (isdefined(self)) {
        if (!isdefined(getluimenu(localclientnum, "HudElementImage"))) {
            self.var_e88f18d7 = [];
        }
        var_99ccb8b4 = getentarray(localclientnum);
        self.var_f8f1eff7 = [];
        foreach (entity in var_99ccb8b4) {
            if (entity.type == "zbarrier") {
                continue;
            }
            if (var_63949c1d && entity.type != "actor" && entity.type != "player") {
                continue;
            }
            entnum = entity getentitynumber();
            isenemy = isdefined(entity.team) && entity.team == "axis";
            isally = !isenemy && isdefined(var_fe79589d);
            var_b4f6794d = (isenemy || isalive(entity) && isally) && !(isdefined(entity.var_dad0e5c1) && entity.var_dad0e5c1);
            if (var_b4f6794d && !isdefined(self.var_f8f1eff7[entnum])) {
                self.var_f8f1eff7[entnum] = entity;
                continue;
            }
            if (!var_b4f6794d && isdefined(self.var_f8f1eff7[entnum])) {
                self.var_f8f1eff7[entnum] = undefined;
                if (isdefined(self.var_e88f18d7[entnum])) {
                    closeluimenu(localclientnum, self.var_e88f18d7[entnum]);
                    self.var_e88f18d7[entnum] = undefined;
                }
            }
        }
        wait(1);
    }
}

// Namespace namespace_68dfcbbe
// Params 6, eflags: 0x1 linked
// Checksum 0xbd893a80, Offset: 0x528
// Size: 0x964
function function_43ee2d3f(localclientnum, materialname, size, var_e9190fc5, var_125eba4d, var_fe79589d) {
    self endon(#"hash_a2489af5");
    if (!isdefined(self.var_e88f18d7)) {
        self.var_e88f18d7 = [];
    }
    if (!isdefined(var_125eba4d)) {
        var_125eba4d = 1;
    }
    var_865e83e = int(var_125eba4d * 500);
    while (isdefined(self)) {
        if (!isdefined(getluimenu(localclientnum, "HudElementImage"))) {
            self.var_e88f18d7 = [];
        }
        eye = getlocalclienteyepos(localclientnum);
        angles = getlocalclientangles(localclientnum);
        if (isdefined(self.var_fbad6cb4)) {
            eye = self.var_fbad6cb4;
            angles = self.var_f28a7256;
        }
        var_55f7939b = cos(getlocalclientfov(localclientnum) * var_e9190fc5);
        var_99a7bd93 = anglestoforward(angles);
        var_4e91aa5b = [];
        foreach (entnum, entity in self.var_f8f1eff7) {
            if (!isdefined(entity) || !isdefined(entity.origin)) {
                continue;
            }
            entpos = undefined;
            var_3565acf = 0;
            isenemy = isdefined(entity.team) && entity.team == "axis";
            isally = !isenemy && isdefined(var_fe79589d);
            var_b4f6794d = (isenemy || isalive(entity) && isally) && !(isdefined(entity.var_dad0e5c1) && entity.var_dad0e5c1) && entity != self;
            if (var_b4f6794d && self.var_e88f18d7.size >= 32 && !isdefined(self.var_e88f18d7[entnum])) {
                var_b4f6794d = 0;
            }
            if (var_b4f6794d) {
                if (entity.type == "actor" || entity.type == "player") {
                    entpos = entity gettagorigin("J_Spine4");
                }
                if (!isdefined(entpos)) {
                    entpos = entity.origin + (0, 0, 40);
                }
                assert(isdefined(entpos));
                assert(isdefined(eye));
                var_eba44e82 = vectornormalize(entpos - eye);
                dot = vectordot(var_eba44e82, var_99a7bd93);
                if (dot < var_55f7939b) {
                    var_b4f6794d = 0;
                } else {
                    var_3565acf = max((1 - dot) / (1 - var_55f7939b) - 0.5, 0);
                }
                if (!isdefined(entity.var_459e92cf) || var_b4f6794d && entity.var_459e92cf <= getservertime(localclientnum)) {
                    from = eye + var_eba44e82 * 100;
                    to = entpos + var_eba44e82 * -100;
                    trace_point = tracepoint(from, to);
                    entity.var_17c88a1f = trace_point["fraction"] >= 1;
                    entity.var_459e92cf = getservertime(localclientnum) + var_865e83e + randomintrange(0, var_865e83e);
                }
            }
            if (var_b4f6794d && entity.var_17c88a1f) {
                var_e7323f20 = project3dto2d(localclientnum, entpos);
                if (!isdefined(self.var_e88f18d7[entnum])) {
                    if (isenemy) {
                        self.var_e88f18d7[entnum] = self function_dd6e51ad(localclientnum, entity, materialname, size);
                    } else {
                        self.var_e88f18d7[entnum] = self function_dd6e51ad(localclientnum, entity, var_fe79589d, size);
                    }
                }
                elem = self.var_e88f18d7[entnum];
                if (isdefined(elem)) {
                    var_4e91aa5b[entnum] = elem;
                    setluimenudata(localclientnum, elem, "x", var_e7323f20[0] - size * 0.5);
                    setluimenudata(localclientnum, elem, "y", var_e7323f20[1] - size * 0.5);
                    setluimenudata(localclientnum, elem, "alpha", 1 - var_3565acf);
                    if (isenemy) {
                        setluimenudata(localclientnum, elem, "red", 1);
                        setluimenudata(localclientnum, elem, "green", 0);
                        continue;
                    }
                    setluimenudata(localclientnum, elem, "red", 0);
                    setluimenudata(localclientnum, elem, "green", 1);
                }
            }
        }
        var_8506fa3b = [];
        foreach (entnum, val in self.var_e88f18d7) {
            if (!isdefined(var_4e91aa5b[entnum])) {
                var_8506fa3b[entnum] = entnum;
            }
        }
        foreach (entnum, val in var_8506fa3b) {
            closeluimenu(localclientnum, self.var_e88f18d7[entnum]);
            self.var_e88f18d7[entnum] = undefined;
        }
        wait(0.016);
    }
}

// Namespace namespace_68dfcbbe
// Params 1, eflags: 0x1 linked
// Checksum 0x5ca34da9, Offset: 0xe98
// Size: 0xda
function function_5f9074e0(localclientnum) {
    self notify(#"hash_a2489af5");
    self endon(#"hash_a2489af5");
    wait(0.016);
    if (isdefined(self.var_e88f18d7)) {
        foreach (hudelem in self.var_e88f18d7) {
            closeluimenu(localclientnum, hudelem);
        }
        self.var_e88f18d7 = undefined;
    }
    self.var_a2489af5 = undefined;
}

// Namespace namespace_68dfcbbe
// Params 4, eflags: 0x1 linked
// Checksum 0x24d1136b, Offset: 0xf80
// Size: 0x1f8
function function_dd6e51ad(localclientnum, entity, materialname, size) {
    hudelem = createluimenu(localclientnum, "HudElementImage");
    if (isdefined(hudelem)) {
        setluimenudata(localclientnum, hudelem, "x", 0);
        setluimenudata(localclientnum, hudelem, "y", 0);
        setluimenudata(localclientnum, hudelem, "width", size);
        setluimenudata(localclientnum, hudelem, "height", size);
        setluimenudata(localclientnum, hudelem, "alpha", 1);
        setluimenudata(localclientnum, hudelem, "material", materialname);
        setluimenudata(localclientnum, hudelem, "red", 1);
        setluimenudata(localclientnum, hudelem, "green", 0);
        setluimenudata(localclientnum, hudelem, "blue", 0);
        setluimenudata(localclientnum, hudelem, "zRot", 0);
        openluimenu(localclientnum, hudelem);
    }
    return hudelem;
}

