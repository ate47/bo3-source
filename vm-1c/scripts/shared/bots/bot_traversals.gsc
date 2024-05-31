#using scripts/shared/bots/bot_buttons;
#using scripts/shared/bots/_bot;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/weapons_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;

#namespace bot;

// Namespace bot
// Params 2, eflags: 0x1 linked
// Checksum 0xc0fa4637, Offset: 0x1e8
// Size: 0x2e4
function callback_botentereduseredge(startnode, endnode) {
    zdelta = endnode.origin[2] - startnode.origin[2];
    var_c8bf42bc = distance2d(startnode.origin, endnode.origin);
    var_fc8c7863 = getdvarfloat("player_standingViewHeight", 0);
    var_70bfad97 = var_fc8c7863 * getdvarfloat("player_swimHeightRatio", 0);
    var_d5ec191 = getwaterheight(startnode.origin);
    var_2a0bdecb = var_d5ec191 != 0 && var_d5ec191 > startnode.origin[2] + var_70bfad97;
    var_89153ffc = getwaterheight(endnode.origin);
    var_a56d3a36 = var_89153ffc != 0 && var_89153ffc > endnode.origin[2] + var_70bfad97;
    if (iswallrunnode(endnode)) {
        self thread function_b5d37467(startnode, endnode);
        return;
    }
    if (var_2a0bdecb && !var_a56d3a36) {
        self thread function_46343d89(startnode, endnode);
        return;
    }
    if (var_2a0bdecb && var_a56d3a36) {
        self thread function_6185fafe(startnode, endnode);
        return;
    }
    if (zdelta >= 0) {
        self thread jump_up_traversal(startnode, endnode);
        return;
    }
    if (zdelta < 0) {
        self thread jump_down_traversal(startnode, endnode);
        return;
    }
    self botreleasemanualcontrol();
    println("<unknown string>", self.name, "<unknown string>");
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x68a36fc9, Offset: 0x4d8
// Size: 0x7a
function function_e6661162() {
    return !self isonground() || self iswallrunning() || self isdoublejumping() || self ismantling() || self issliding();
}

// Namespace bot
// Params 2, eflags: 0x1 linked
// Checksum 0x78d7d076, Offset: 0x560
// Size: 0xd0
function function_46343d89(startnode, endnode) {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    level endon(#"game_ended");
    self thread function_2c357c23();
    self function_7b22f8c6(endnode.origin);
    while (self isplayerunderwater()) {
        self function_5e7eba3b();
        wait(0.05);
    }
    while (true) {
        self function_dc2a7991();
        wait(0.05);
    }
}

// Namespace bot
// Params 2, eflags: 0x1 linked
// Checksum 0x402f9fdf, Offset: 0x638
// Size: 0x7c
function function_6185fafe(startnode, endnode) {
    self endon(#"death");
    level endon(#"game_ended");
    self endon(#"hash_4c7b12b7");
    self function_7b22f8c6(endnode.origin);
    wait(0.5);
    self function_4c7b12b7();
}

// Namespace bot
// Params 2, eflags: 0x1 linked
// Checksum 0x9934ed08, Offset: 0x6c0
// Size: 0x2f4
function jump_up_traversal(startnode, endnode) {
    self endon(#"death");
    level endon(#"game_ended");
    self endon(#"hash_4c7b12b7");
    self thread function_2c357c23();
    ledgetop = checknavmeshdirection(endnode.origin, self.origin - endnode.origin, -128, 1);
    height = ledgetop[2] - self.origin[2];
    if (height <= 72) {
        self thread jump_to(ledgetop);
        return;
    }
    /#
    #/
    dist = distance2d(self.origin, ledgetop);
    var_c9ff4189 = checknavmeshdirection(self.origin, ledgetop - self.origin, dist + 15, 1);
    var_13e97600 = distance2d(self.origin, var_c9ff4189);
    if (var_13e97600 <= dist) {
        self thread jump_to(ledgetop);
        return;
    }
    dist -= 15;
    height -= 72;
    t = height / 80;
    var_a625f80c = self function_a2e25eae();
    speed = self getplayerspeed();
    movedist = t * var_a625f80c;
    if (!movedist || dist > movedist) {
        self thread jump_to(ledgetop);
        return;
    }
    self botsetmovemagnitude(dist / movedist);
    wait(0.05);
    self thread jump_to(ledgetop);
    wait(0.05);
    while (self.origin[2] + 72 < ledgetop[2]) {
        wait(0.05);
    }
    self botsetmovemagnitude(1);
}

// Namespace bot
// Params 2, eflags: 0x1 linked
// Checksum 0x83c67b84, Offset: 0x9c0
// Size: 0x3f4
function jump_down_traversal(startnode, endnode) {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    level endon(#"game_ended");
    self thread function_2c357c23();
    fwd = (endnode.origin[0] - startnode.origin[0], endnode.origin[1] - startnode.origin[1], 0);
    fwd = vectornormalize(fwd) * -128;
    start = startnode.origin + (0, 0, 16);
    end = startnode.origin + fwd + (0, 0, 16);
    result = bullettrace(start, end, 0, self);
    if (result["surfacetype"] != "none") {
        self function_7b22f8c6(endnode.origin);
        wait(0.05);
        self function_793ac1aa();
        return;
    }
    dist = distance2d(startnode.origin, endnode.origin);
    height = startnode.origin[2] - endnode.origin[2];
    gravity = self getplayergravity();
    t = sqrt(2 * height / gravity);
    var_a625f80c = self function_a2e25eae();
    if (t * var_a625f80c < dist) {
        ledgetop = checknavmeshdirection(startnode.origin, endnode.origin - startnode.origin, -128, 1);
        var_13e97600 = dist - distance2d(startnode.origin, ledgetop);
        var_c9ff4189 = checknavmeshdirection(endnode.origin, startnode.origin - endnode.origin, var_13e97600, 1);
        var_1c7f5b12 = distance2d(ledgetop, var_c9ff4189);
        if (var_1c7f5b12 > 30) {
            self thread jump_to(endnode.origin);
            return;
        }
    }
    self function_7b22f8c6(endnode.origin);
}

// Namespace bot
// Params 3, eflags: 0x1 linked
// Checksum 0xd9f82b86, Offset: 0xdc0
// Size: 0x1cc
function function_b5d37467(startnode, endnode, vector) {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    level endon(#"game_ended");
    self thread function_2c357c23();
    wallnormal = getnavmeshfacenormal(endnode.origin, 30);
    wallnormal = vectornormalize((wallnormal[0], wallnormal[1], 0));
    traversaldir = (startnode.origin[0] - endnode.origin[0], startnode.origin[1] - endnode.origin[1], 0);
    cross = vectorcross(wallnormal, traversaldir);
    var_88fb49cd = vectorcross(wallnormal, cross);
    self botsetlookangles(var_88fb49cd);
    self thread jump_to(endnode.origin, vector);
    self thread function_dd501ea(startnode, endnode, wallnormal, var_88fb49cd);
}

// Namespace bot
// Params 4, eflags: 0x1 linked
// Checksum 0x6fb6c82c, Offset: 0xf98
// Size: 0x174
function function_dd501ea(startnode, endnode, wallnormal, var_88fb49cd) {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    level endon(#"game_ended");
    self waittill(#"wallrun_begin");
    self thread function_2c357c23();
    self function_9fa7f8a3();
    self function_c14cc56c(var_88fb49cd);
    self function_41b866d3();
    index = self getnodeindexonpath(startnode);
    index++;
    var_c3cecb77 = self getnexttraversalnodeonpath(index);
    if (isdefined(var_c3cecb77)) {
        var_b024a368 = getothernodeinnegotiationpair(var_c3cecb77);
        if (isdefined(var_b024a368)) {
            self thread function_30486e13(var_c3cecb77, var_b024a368, wallnormal, vectornormalize(var_88fb49cd));
        }
    }
}

// Namespace bot
// Params 4, eflags: 0x1 linked
// Checksum 0xce6e2cbd, Offset: 0x1118
// Size: 0x3b2
function function_30486e13(startnode, endnode, wallnormal, var_c1dc8db1) {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    level endon(#"game_ended");
    self thread function_2c357c23();
    gravity = self getplayergravity();
    vup = sqrt(80 * gravity);
    var_5c76b792 = vup / gravity;
    var_8edc7156 = self.origin[2] + 40;
    falldist = var_8edc7156 - endnode.origin[2];
    if (falldist > 0) {
        var_28ab58ec = sqrt(falldist / 0.5 * gravity);
    } else {
        var_28ab58ec = 0;
    }
    t = var_5c76b792 + var_28ab58ec;
    exitdir = endnode.origin - startnode.origin;
    var_14b3f23a = vectordot(exitdir, wallnormal);
    var_2aab1ec = var_14b3f23a / t;
    if (var_2aab1ec <= -56) {
        dot = sqrt(var_2aab1ec / -56);
        vforward = sqrt(40000 * dot * dot - var_2aab1ec * var_2aab1ec);
    } else {
        vforward = 0;
    }
    while (true) {
        wait(0.05);
        var_834051a9 = endnode.origin - self.origin;
        enddist = vectordot(var_834051a9, var_c1dc8db1);
        var_10d80214 = self function_a2e25eae();
        var_b1a6857a = (var_10d80214 + vforward) * t;
        if (enddist <= var_b1a6857a) {
            var_ee3a8d7e = wallnormal * var_2aab1ec + var_c1dc8db1 * vforward;
            if (iswallrunnode(endnode)) {
                self thread function_b5d37467(startnode, endnode, var_ee3a8d7e);
                return;
            }
            self function_546ecee9(endnode.origin);
            self thread jump_to(endnode.origin, var_ee3a8d7e);
            return;
        }
    }
}

// Namespace bot
// Params 2, eflags: 0x1 linked
// Checksum 0x803d52f2, Offset: 0x14d8
// Size: 0x254
function jump_to(target, vector) {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    level endon(#"game_ended");
    if (isdefined(vector)) {
        self function_c14cc56c(vector);
        movedir = vectornormalize((vector[0], vector[1], 0));
    } else {
        self function_7b22f8c6(target);
        targetdelta = target - self.origin;
        movedir = vectornormalize((targetdelta[0], targetdelta[1], 0));
    }
    velocity = self getvelocity();
    var_819400cd = vectornormalize((velocity[0], velocity[1], 0));
    if (vectordot(movedir, var_819400cd) < 0.94) {
        wait(0.05);
    }
    self function_793ac1aa();
    wait(0.05);
    while (!self isonground() && !self ismantling() && !self iswallrunning() && !self function_6918d9ba(target)) {
        function_dc2a7991();
        if (!isdefined(vector)) {
            self function_7b22f8c6(target);
        }
        wait(0.05);
    }
    function_41b866d3();
}

// Namespace bot
// Params 1, eflags: 0x0
// Checksum 0x90aeb63a, Offset: 0x1738
// Size: 0x68
function function_6581f3cc(target) {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    level endon(#"game_ended");
    while (!self ismantling()) {
        self function_7b22f8c6(target);
        wait(0.05);
    }
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0x9dc7c993, Offset: 0x17a8
// Size: 0x192
function function_6918d9ba(target) {
    velocity = self getvelocity();
    targetdir = target - self.origin;
    targetdir = (targetdir[0], targetdir[1], 0);
    if (self.origin[2] > target[2] && vectordot(velocity, targetdir) <= 0) {
        return true;
    }
    targetdist = length(targetdir);
    targetspeed = length(velocity);
    if (targetspeed == 0) {
        return false;
    }
    t = targetdist / targetspeed;
    gravity = self getplayergravity();
    height = self.origin[2] + velocity[2] * t - gravity * t * t * 0.5;
    /#
    #/
    return height >= target[2] + 32;
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x6d967e2d, Offset: 0x1948
// Size: 0x54
function function_a2e25eae() {
    velocity = self getvelocity();
    var_a625f80c = distance2d(velocity, (0, 0, 0));
    return var_a625f80c;
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x177dd094, Offset: 0x19a8
// Size: 0x8c
function function_2c357c23() {
    self notify(#"hash_8a16cc3b");
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    self endon(#"hash_8a16cc3b");
    level endon(#"game_ended");
    self thread function_f0530225();
    self thread function_fe1ccdcd();
    self waittill(#"acrobatics_end");
    self thread function_4c7b12b7();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x4b194b02, Offset: 0x1a40
// Size: 0x9c
function function_fe1ccdcd() {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    self endon(#"hash_8a16cc3b");
    level endon(#"game_ended");
    while (self isplayerswimming()) {
        wait(0.05);
    }
    wait(0.05);
    while (!self isplayerswimming()) {
        wait(0.05);
    }
    self thread function_4c7b12b7();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xe44b6d65, Offset: 0x1ae8
// Size: 0x64
function function_f0530225() {
    self endon(#"death");
    self endon(#"hash_4c7b12b7");
    self endon(#"hash_8a16cc3b");
    level endon(#"game_ended");
    wait(8);
    self thread function_4c7b12b7();
    self function_5ee14aca();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x2cd6aef7, Offset: 0x1b58
// Size: 0x6c
function function_4c7b12b7() {
    self notify(#"hash_4c7b12b7");
    self function_41b866d3();
    self function_66d6ef34();
    self botsetmovemagnitude(1);
    self botreleasemanualcontrol();
}

