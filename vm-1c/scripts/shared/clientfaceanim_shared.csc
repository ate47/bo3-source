#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace clientfaceanim;

// Namespace clientfaceanim
// Params 0, eflags: 0x2
// Checksum 0x80e118d8, Offset: 0x328
// Size: 0x2c
function autoexec __init__sytem__() {
    system::register("clientfaceanim_shared", undefined, &main, undefined);
}

// Namespace clientfaceanim
// Params 0, eflags: 0x0
// Checksum 0xa42d971c, Offset: 0x360
// Size: 0x3c
function main() {
    callback::on_spawned(&on_player_spawned);
    level._clientfaceanimonplayerspawned = &on_player_spawned;
}

// Namespace clientfaceanim
// Params 1, eflags: 0x4
// Checksum 0xbbe2c022, Offset: 0x3a8
// Size: 0x5c
function private on_player_spawned(localclientnum) {
    function_4f353102(localclientnum);
    self callback::on_shutdown(&on_player_shutdown);
    self thread on_player_death(localclientnum);
}

// Namespace clientfaceanim
// Params 1, eflags: 0x4
// Checksum 0x313d414b, Offset: 0x410
// Size: 0xd8
function private on_player_shutdown(localclientnum) {
    if (self isplayer()) {
        self notify(#"stopfacialthread");
        corpse = self getplayercorpse();
        if (!isdefined(corpse)) {
            return;
        }
        if (isdefined(corpse.facialdeathanimstarted) && corpse.facialdeathanimstarted) {
            return;
        }
        corpse util::waittill_dobj(localclientnum);
        if (isdefined(corpse)) {
            corpse applydeathanim(localclientnum);
            corpse.facialdeathanimstarted = 1;
        }
    }
}

// Namespace clientfaceanim
// Params 1, eflags: 0x4
// Checksum 0xf32c995, Offset: 0x4f0
// Size: 0xe8
function private on_player_death(localclientnum) {
    self endon(#"entityshutdown");
    self waittill(#"death");
    if (self isplayer()) {
        self notify(#"stopfacialthread");
        corpse = self getplayercorpse();
        if (isdefined(corpse.facialdeathanimstarted) && corpse.facialdeathanimstarted) {
            return;
        }
        corpse util::waittill_dobj(localclientnum);
        if (isdefined(corpse)) {
            corpse applydeathanim(localclientnum);
            corpse.facialdeathanimstarted = 1;
        }
    }
}

// Namespace clientfaceanim
// Params 1, eflags: 0x4
// Checksum 0xfa166f08, Offset: 0x5e0
// Size: 0x54
function private function_4f353102(localclientnum) {
    buildandvalidatefacialanimationlist(localclientnum);
    if (self isplayer()) {
        self thread function_48af690b(localclientnum);
    }
}

// Namespace clientfaceanim
// Params 1, eflags: 0x0
// Checksum 0xc86e8f29, Offset: 0x640
// Size: 0x2ba
function buildandvalidatefacialanimationlist(localclientnum) {
    if (!isdefined(level.__clientfacialanimationslist)) {
        level.__clientfacialanimationslist = [];
        level.__clientfacialanimationslist["combat"] = array("ai_face_male_generic_idle_1", "ai_face_male_generic_idle_2", "ai_face_male_generic_idle_3");
        level.__clientfacialanimationslist["combat_shoot"] = array("ai_face_male_aim_fire_1", "ai_face_male_aim_fire_2", "ai_face_male_aim_fire_3");
        level.__clientfacialanimationslist["death"] = array("ai_face_male_death_1", "ai_face_male_death_2", "ai_face_male_death_3");
        level.__clientfacialanimationslist["melee"] = array("ai_face_male_melee_1");
        level.__clientfacialanimationslist["pain"] = array("ai_face_male_pain_1");
        level.__clientfacialanimationslist["swimming"] = array("mp_face_male_swim_idle_1");
        level.__clientfacialanimationslist["jumping"] = array("mp_face_male_jump_idle_1");
        level.__clientfacialanimationslist["sliding"] = array("mp_face_male_slides_1");
        level.__clientfacialanimationslist["sprinting"] = array("mp_face_male_sprint_1");
        level.__clientfacialanimationslist["wallrunning"] = array("mp_face_male_wall_run_1");
        deathanims = level.__clientfacialanimationslist["death"];
        foreach (deathanim in deathanims) {
            assert(!isanimlooping(localclientnum, deathanim), "<dev string:x28>" + deathanim + "<dev string:x4e>");
        }
    }
}

// Namespace clientfaceanim
// Params 1, eflags: 0x4
// Checksum 0x5cbb042c, Offset: 0x908
// Size: 0x170
function private facialanimationthink_getwaittime(localclientnum) {
    if (!isdefined(localclientnum)) {
        return 1;
    }
    min_wait = 0.1;
    max_wait = 1;
    min_wait_distance_sq = 2500;
    max_wait_distance_sq = 640000;
    local_player = getlocalplayer(localclientnum);
    if (!isdefined(local_player)) {
        return max_wait;
    }
    if (local_player == self && !isthirdperson(localclientnum)) {
        return max_wait;
    }
    distancesq = distancesquared(local_player.origin, self.origin);
    if (distancesq > max_wait_distance_sq) {
        distance_factor = 1;
    } else if (distancesq < min_wait_distance_sq) {
        distance_factor = 0;
    } else {
        distance_factor = (distancesq - min_wait_distance_sq) / (max_wait_distance_sq - min_wait_distance_sq);
    }
    return (max_wait - min_wait) * distance_factor + min_wait;
}

// Namespace clientfaceanim
// Params 1, eflags: 0x4
// Checksum 0xb6d6ef24, Offset: 0xa80
// Size: 0xf2
function private function_48af690b(localclientnum) {
    self endon(#"entityshutdown");
    self notify(#"stopfacialthread");
    self endon(#"stopfacialthread");
    if (isdefined(self.var_d4f49ba0)) {
        return;
    }
    self.var_d4f49ba0 = 1;
    assert(self isplayer());
    self util::waittill_dobj(localclientnum);
    while (isdefined(self)) {
        updatefacialanimforplayer(localclientnum, self);
        wait_time = self facialanimationthink_getwaittime(localclientnum);
        if (!isdefined(wait_time)) {
            wait_time = 1;
        }
        wait wait_time;
    }
}

// Namespace clientfaceanim
// Params 2, eflags: 0x4
// Checksum 0x4e24a182, Offset: 0xb80
// Size: 0x2a8
function private updatefacialanimforplayer(localclientnum, player) {
    if (!isdefined(player)) {
        return;
    }
    if (!isdefined(localclientnum)) {
        return;
    }
    if (!isdefined(player._currentfacestate)) {
        player._currentfacestate = "inactive";
    }
    currfacestate = player._currentfacestate;
    nextfacestate = player._currentfacestate;
    if (player isinscritpedanim()) {
        clearallfacialanims(localclientnum);
        player._currentfacestate = "inactive";
        return;
    }
    if (player isplayerdead()) {
        nextfacestate = "death";
    } else if (player isplayerfiring()) {
        nextfacestate = "combat_shoot";
    } else if (player isplayersliding()) {
        nextfacestate = "sliding";
    } else if (player isplayerwallrunning()) {
        nextfacestate = "wallrunning";
    } else if (player isplayersprinting()) {
        nextfacestate = "sprinting";
    } else if (player isplayerjumping() || player isplayerdoublejumping()) {
        nextfacestate = "jumping";
    } else if (player isplayerswimming()) {
        nextfacestate = "swimming";
    } else {
        nextfacestate = "combat";
    }
    if (player._currentfacestate == "inactive" || currfacestate != nextfacestate) {
        assert(isdefined(level.__clientfacialanimationslist[nextfacestate]));
        applynewfaceanim(localclientnum, array::random(level.__clientfacialanimationslist[nextfacestate]));
        player._currentfacestate = nextfacestate;
    }
}

// Namespace clientfaceanim
// Params 2, eflags: 0x4
// Checksum 0x962f22e9, Offset: 0xe30
// Size: 0x7c
function private applynewfaceanim(localclientnum, animation) {
    clearallfacialanims(localclientnum);
    if (isdefined(animation)) {
        self._currentfaceanim = animation;
        self setflaggedanimknob("ai_secondary_facial_anim", animation, 1, 0.1, 1);
    }
}

// Namespace clientfaceanim
// Params 1, eflags: 0x4
// Checksum 0x4e830b8d, Offset: 0xeb8
// Size: 0xa4
function private applydeathanim(localclientnum) {
    if (isdefined(self._currentfacestate) && self._currentfacestate == "death") {
        return;
    }
    if (isdefined(self) && isdefined(level.__clientfacialanimationslist) && isdefined(level.__clientfacialanimationslist["death"])) {
        self._currentfacestate = "death";
        applynewfaceanim(localclientnum, array::random(level.__clientfacialanimationslist["death"]));
    }
}

// Namespace clientfaceanim
// Params 1, eflags: 0x4
// Checksum 0x87d8f06a, Offset: 0xf68
// Size: 0x66
function private clearallfacialanims(localclientnum) {
    if (isdefined(self._currentfaceanim) && self hasdobj(localclientnum)) {
        self clearanim(self._currentfaceanim, 0.2);
    }
    self._currentfaceanim = undefined;
}

