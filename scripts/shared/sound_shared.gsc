#using scripts/shared/util_shared;

#namespace sound;

// Namespace sound
// Params 3, eflags: 0x1 linked
// Checksum 0x58245982, Offset: 0xb8
// Size: 0xa4
function loop_fx_sound(alias, origin, ender) {
    org = spawn("script_origin", (0, 0, 0));
    if (isdefined(ender)) {
        thread loop_delete(ender, org);
        self endon(ender);
    }
    org.origin = origin;
    org playloopsound(alias);
}

// Namespace sound
// Params 2, eflags: 0x1 linked
// Checksum 0xd927be59, Offset: 0x168
// Size: 0x44
function loop_delete(ender, ent) {
    ent endon(#"death");
    self waittill(ender);
    ent delete();
}

// Namespace sound
// Params 3, eflags: 0x1 linked
// Checksum 0x5b6206dd, Offset: 0x1b8
// Size: 0xc4
function play_in_space(alias, origin, master) {
    org = spawn("script_origin", (0, 0, 1));
    if (!isdefined(origin)) {
        origin = self.origin;
    }
    org.origin = origin;
    org playsoundwithnotify(alias, "sounddone");
    org waittill(#"sounddone");
    if (isdefined(org)) {
        org delete();
    }
}

// Namespace sound
// Params 3, eflags: 0x1 linked
// Checksum 0xe6c1c665, Offset: 0x288
// Size: 0x15c
function loop_on_tag(alias, tag, bstopsoundondeath) {
    org = spawn("script_origin", (0, 0, 0));
    org endon(#"death");
    if (!isdefined(bstopsoundondeath)) {
        bstopsoundondeath = 1;
    }
    if (bstopsoundondeath) {
        thread util::delete_on_death(org);
    }
    if (isdefined(tag)) {
        org linkto(self, tag, (0, 0, 0), (0, 0, 0));
    } else {
        org.origin = self.origin;
        org.angles = self.angles;
        org linkto(self);
    }
    org playloopsound(alias);
    self waittill("stop sound" + alias);
    org stoploopsound(alias);
    org delete();
}

// Namespace sound
// Params 3, eflags: 0x1 linked
// Checksum 0x4b1702d3, Offset: 0x3f0
// Size: 0x19c
function play_on_tag(alias, tag, ends_on_death) {
    org = spawn("script_origin", (0, 0, 0));
    org endon(#"death");
    thread delete_on_death_wait(org, "sounddone");
    if (isdefined(tag)) {
        org.origin = self gettagorigin(tag);
        org linkto(self, tag, (0, 0, 0), (0, 0, 0));
    } else {
        org.origin = self.origin;
        org.angles = self.angles;
        org linkto(self);
    }
    org playsoundwithnotify(alias, "sounddone");
    if (isdefined(ends_on_death)) {
        /#
            assert(ends_on_death, "<unknown string>");
        #/
        wait_for_sounddone_or_death(org);
        wait(0.05);
    } else {
        org waittill(#"sounddone");
    }
    org delete();
}

// Namespace sound
// Params 1, eflags: 0x0
// Checksum 0x5a2cfddf, Offset: 0x598
// Size: 0x24
function play_on_entity(alias) {
    play_on_tag(alias);
}

// Namespace sound
// Params 1, eflags: 0x1 linked
// Checksum 0x32ae8974, Offset: 0x5c8
// Size: 0x26
function wait_for_sounddone_or_death(org) {
    self endon(#"death");
    org waittill(#"sounddone");
}

// Namespace sound
// Params 1, eflags: 0x0
// Checksum 0x16a8d5e0, Offset: 0x5f8
// Size: 0x20
function stop_loop_on_entity(alias) {
    self notify("stop sound" + alias);
}

// Namespace sound
// Params 2, eflags: 0x0
// Checksum 0xe09ca0e2, Offset: 0x620
// Size: 0x164
function loop_on_entity(alias, offset) {
    org = spawn("script_origin", (0, 0, 0));
    org endon(#"death");
    thread util::delete_on_death(org);
    if (isdefined(offset)) {
        org.origin = self.origin + offset;
        org.angles = self.angles;
        org linkto(self);
    } else {
        org.origin = self.origin;
        org.angles = self.angles;
        org linkto(self);
    }
    org playloopsound(alias);
    self waittill("stop sound" + alias);
    org stoploopsound(0.1);
    org delete();
}

// Namespace sound
// Params 3, eflags: 0x1 linked
// Checksum 0x43cf5034, Offset: 0x790
// Size: 0xcc
function loop_in_space(alias, origin, ender) {
    org = spawn("script_origin", (0, 0, 1));
    if (!isdefined(origin)) {
        origin = self.origin;
    }
    org.origin = origin;
    org playloopsound(alias);
    level waittill(ender);
    org stoploopsound();
    wait(0.1);
    org delete();
}

// Namespace sound
// Params 2, eflags: 0x1 linked
// Checksum 0x5e68983, Offset: 0x868
// Size: 0x4c
function delete_on_death_wait(ent, sounddone) {
    ent endon(#"death");
    self waittill(#"death");
    if (isdefined(ent)) {
        ent delete();
    }
}

// Namespace sound
// Params 2, eflags: 0x1 linked
// Checksum 0xe2110bab, Offset: 0x8c0
// Size: 0x176
function play_on_players(sound, team) {
    /#
        assert(isdefined(level.players));
    #/
    if (level.splitscreen) {
        if (isdefined(level.players[0])) {
            level.players[0] playlocalsound(sound);
        }
        return;
    }
    if (isdefined(team)) {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (isdefined(player.pers["team"]) && player.pers["team"] == team) {
                player playlocalsound(sound);
            }
        }
        return;
    }
    for (i = 0; i < level.players.size; i++) {
        level.players[i] playlocalsound(sound);
    }
}

