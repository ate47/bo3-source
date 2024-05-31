#using scripts/shared/util_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace laststand;

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xf997efc, Offset: 0x190
// Size: 0x40
function player_is_in_laststand() {
    if (!(isdefined(self.no_revive_trigger) && self.no_revive_trigger)) {
        return isdefined(self.revivetrigger);
    }
    return isdefined(self.laststand) && self.laststand;
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x310e3175, Offset: 0x1d8
// Size: 0x82
function player_num_in_laststand() {
    num = 0;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i] player_is_in_laststand()) {
            num++;
        }
    }
    return num;
}

// Namespace laststand
// Params 0, eflags: 0x0
// Checksum 0x4fddb829, Offset: 0x268
// Size: 0x26
function player_all_players_in_laststand() {
    return player_num_in_laststand() == getplayers().size;
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xda614525, Offset: 0x298
// Size: 0x16
function player_any_player_in_laststand() {
    return player_num_in_laststand() > 0;
}

// Namespace laststand
// Params 3, eflags: 0x0
// Checksum 0x196606, Offset: 0x2b8
// Size: 0x38
function function_cd4ced7a(sweapon, smeansofdeath, shitloc) {
    if (level.laststandpistol == "none") {
        return false;
    }
    return true;
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xf977ffa6, Offset: 0x2f8
// Size: 0x36
function function_4a66f284() {
    if (isdefined(self.suicideprompt)) {
        self.suicideprompt destroy();
    }
    self.suicideprompt = undefined;
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x9c90e015, Offset: 0x338
// Size: 0xbc
function function_9a3e66fc() {
    self endon(#"disconnect");
    self endon(#"stop_revive_trigger");
    self endon(#"player_revived");
    self endon(#"bled_out");
    level util::waittill_any("game_ended", "stop_suicide_trigger");
    self function_4a66f284();
    if (isdefined(self.var_292c9541)) {
        self.var_292c9541 destroy();
    }
    if (isdefined(self.var_af0e0d25)) {
        self.var_af0e0d25 hud::destroyelem();
    }
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xbe6acc14, Offset: 0x400
// Size: 0xac
function function_a5c40dbc() {
    self endon(#"disconnect");
    self endon(#"stop_revive_trigger");
    self util::waittill_any("bled_out", "player_revived", "fake_death");
    self function_4a66f284();
    if (isdefined(self.var_af0e0d25)) {
        self.var_af0e0d25 hud::destroyelem();
    }
    if (isdefined(self.var_292c9541)) {
        self.var_292c9541 destroy();
    }
}

// Namespace laststand
// Params 2, eflags: 0x1 linked
// Checksum 0xdbf1bb69, Offset: 0x4b8
// Size: 0x15a
function is_facing(facee, requireddot) {
    if (!isdefined(requireddot)) {
        requireddot = 0.9;
    }
    orientation = self getplayerangles();
    forwardvec = anglestoforward(orientation);
    forwardvec2d = (forwardvec[0], forwardvec[1], 0);
    unitforwardvec2d = vectornormalize(forwardvec2d);
    tofaceevec = facee.origin - self.origin;
    tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
    unittofaceevec2d = vectornormalize(tofaceevec2d);
    dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
    return dotproduct > requireddot;
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x5cfc7d19, Offset: 0x620
// Size: 0x138
function revive_hud_create() {
    self.revive_hud = newclienthudelem(self);
    self.revive_hud.alignx = "center";
    self.revive_hud.aligny = "middle";
    self.revive_hud.horzalign = "center";
    self.revive_hud.vertalign = "bottom";
    self.revive_hud.foreground = 1;
    self.revive_hud.font = "default";
    self.revive_hud.fontscale = 1.5;
    self.revive_hud.alpha = 0;
    self.revive_hud.color = (1, 1, 1);
    self.revive_hud.hidewheninmenu = 1;
    self.revive_hud settext("");
    self.revive_hud.y = -148;
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xcce6bb0d, Offset: 0x760
// Size: 0x50
function function_89c586ec() {
    assert(isdefined(self));
    assert(isdefined(self.revive_hud));
    self.revive_hud.alpha = 1;
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xfcd44f36, Offset: 0x7b8
// Size: 0x50
function revive_hud_show_n_fade(time) {
    function_89c586ec();
    self.revive_hud fadeovertime(time);
    self.revive_hud.alpha = 0;
}

/#

    // Namespace laststand
    // Params 3, eflags: 0x0
    // Checksum 0xd86f4efd, Offset: 0x810
    // Size: 0x25e
    function drawcylinder(pos, rad, height) {
        currad = rad;
        curheight = height;
        for (r = 0; r < 20; r++) {
            theta = r / 20 * 360;
            theta2 = (r + 1) / 20 * 360;
            line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0));
            line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight));
            line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight));
        }
    }

#/

// Namespace laststand
// Params 0, eflags: 0x0
// Checksum 0xa29137ba, Offset: 0xa78
// Size: 0x7e
function function_fa369ede() {
    assert(level.var_da98bf76, "bottom");
    if (level.var_da98bf76 && isdefined(self.var_5ad7ff7e) && isdefined(self.var_5ad7ff7e.var_5aa0f5d3)) {
        return max(0, self.var_5ad7ff7e.var_5aa0f5d3);
    }
    return 0;
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x8eab02c1, Offset: 0xb00
// Size: 0xda
function function_cd85ffaf(increment) {
    assert(level.var_da98bf76, "bottom");
    assert(isdefined(increment), "bottom");
    increment = isdefined(increment) ? increment : 0;
    self.var_5ad7ff7e.var_5aa0f5d3 = max(0, increment ? self.var_5ad7ff7e.var_5aa0f5d3 + 1 : self.var_5ad7ff7e.var_5aa0f5d3 - 1);
    self notify(#"hash_e4b1bf1f");
}

// Namespace laststand
// Params 0, eflags: 0x0
// Checksum 0xb0221d88, Offset: 0xbe8
// Size: 0x50
function function_590a49b2() {
    println("bottom");
    self.var_5ad7ff7e = spawnstruct();
    self.var_5ad7ff7e.var_5aa0f5d3 = 0;
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x7a430a53, Offset: 0xc40
// Size: 0x84
function function_5d050fca() {
    self endon(#"player_revived");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"damage");
        self.var_5ad7ff7e.var_8b479de8 -= 0.1;
        if (self.var_5ad7ff7e.var_8b479de8 < 0) {
            self.var_5ad7ff7e.var_8b479de8 = 0;
        }
    }
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x7210c0c0, Offset: 0xcd0
// Size: 0x190
function function_5006c91f() {
    self endon(#"player_revived");
    self endon(#"disconnect");
    hudelem = newclienthudelem(self);
    hudelem.alignx = "left";
    hudelem.aligny = "middle";
    hudelem.horzalign = "left";
    hudelem.vertalign = "middle";
    hudelem.x = 5;
    hudelem.y = -86;
    hudelem.font = "big";
    hudelem.fontscale = 1.5;
    hudelem.foreground = 1;
    hudelem.hidewheninmenu = 1;
    hudelem.hidewhendead = 1;
    hudelem.sort = 2;
    hudelem.label = %SO_WAR_LASTSTAND_GETUP_BAR;
    self thread function_fed0ee90(hudelem);
    while (true) {
        hudelem setvalue(self.var_5ad7ff7e.var_8b479de8);
        wait(0.05);
    }
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xd86b10f0, Offset: 0xe68
// Size: 0x4c
function function_fed0ee90(hudelem) {
    self util::waittill_either("player_revived", "disconnect");
    hudelem destroy();
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xa6344d42, Offset: 0xec0
// Size: 0x6c
function function_d4eb424f() {
    self endon(#"player_revived");
    self endon(#"player_suicide");
    self endon(#"bled_out");
    trig = self.revivetrigger;
    self waittill(#"disconnect");
    if (isdefined(trig)) {
        trig delete();
    }
}

