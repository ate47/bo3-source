#using scripts/shared/filter_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace explode;

// Namespace explode
// Params 0, eflags: 0x2
// Checksum 0x8d9235a8, Offset: 0x198
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("explode", &__init__, undefined, undefined);
}

// Namespace explode
// Params 0, eflags: 0x1 linked
// Checksum 0x5b05be23, Offset: 0x1d8
// Size: 0xb4
function __init__() {
    level.dirt_enable_explosion = getdvarint("scr_dirt_enable_explosion", 1);
    level.dirt_enable_slide = getdvarint("scr_dirt_enable_slide", 1);
    level.dirt_enable_fall_damage = getdvarint("scr_dirt_enable_fall_damage", 1);
    callback::on_localplayer_spawned(&localplayer_spawned);
    /#
        level thread updatedvars();
    #/
}

/#

    // Namespace explode
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe604f422, Offset: 0x298
    // Size: 0x98
    function updatedvars() {
        while (true) {
            level.dirt_enable_explosion = getdvarint("<dev string:x28>", level.dirt_enable_explosion);
            level.dirt_enable_slide = getdvarint("<dev string:x42>", level.dirt_enable_slide);
            level.dirt_enable_fall_damage = getdvarint("<dev string:x58>", level.dirt_enable_fall_damage);
            wait 1;
        }
    }

#/

// Namespace explode
// Params 1, eflags: 0x1 linked
// Checksum 0x9e3309c9, Offset: 0x338
// Size: 0xdc
function localplayer_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    if (level.dirt_enable_explosion || level.dirt_enable_slide || level.dirt_enable_fall_damage) {
        filter::init_filter_sprite_dirt(self);
        filter::disable_filter_sprite_dirt(self, 5);
        if (level.dirt_enable_explosion) {
            self thread watchforexplosion(localclientnum);
        }
        if (level.dirt_enable_slide) {
            self thread watchforplayerslide(localclientnum);
        }
        if (level.dirt_enable_fall_damage) {
            self thread watchforplayerfalldamage(localclientnum);
        }
    }
}

// Namespace explode
// Params 1, eflags: 0x1 linked
// Checksum 0xf7871b3f, Offset: 0x420
// Size: 0x98
function watchforplayerfalldamage(localclientnum) {
    self endon(#"entityshutdown");
    seed = 0;
    xdir = 0;
    ydir = 270;
    while (true) {
        self waittill(#"fall_damage");
        self thread dothedirty(localclientnum, xdir, ydir, 1, 1000, 500);
    }
}

// Namespace explode
// Params 1, eflags: 0x1 linked
// Checksum 0xf408b1cd, Offset: 0x4c0
// Size: 0x1d0
function watchforplayerslide(localclientnum) {
    self endon(#"entityshutdown");
    seed = 0;
    self.wasplayersliding = 0;
    xdir = 0;
    ydir = 6000;
    while (true) {
        self.isplayersliding = self isplayersliding();
        if (self.isplayersliding) {
            if (!self.wasplayersliding) {
                self notify(#"endthedirty");
                seed = randomfloatrange(0, 1);
            }
            filter::set_filter_sprite_dirt_opacity(self, 5, 1);
            filter::set_filter_sprite_dirt_seed_offset(self, 5, seed);
            filter::enable_filter_sprite_dirt(self, 5);
            filter::set_filter_sprite_dirt_source_position(self, 5, xdir, ydir, 1);
            filter::set_filter_sprite_dirt_elapsed(self, 5, getservertime(localclientnum));
        } else if (self.wasplayersliding) {
            self thread dothedirty(localclientnum, xdir, ydir, 1, 300, 300);
        }
        self.wasplayersliding = self.isplayersliding;
        wait 0.016;
    }
}

// Namespace explode
// Params 6, eflags: 0x1 linked
// Checksum 0xf110aae7, Offset: 0x698
// Size: 0x204
function dothedirty(localclientnum, right, up, distance, dirtduration, dirtfadetime) {
    self endon(#"entityshutdown");
    self notify(#"dothedirty");
    self endon(#"dothedirty");
    self endon(#"endthedirty");
    filter::enable_filter_sprite_dirt(self, 5);
    filter::set_filter_sprite_dirt_seed_offset(self, 5, randomfloatrange(0, 1));
    starttime = getservertime(localclientnum);
    currenttime = starttime;
    for (elapsedtime = 0; elapsedtime < dirtduration; elapsedtime = currenttime - starttime) {
        if (elapsedtime > dirtduration - dirtfadetime) {
            filter::set_filter_sprite_dirt_opacity(self, 5, (dirtduration - elapsedtime) / dirtfadetime);
        } else {
            filter::set_filter_sprite_dirt_opacity(self, 5, 1);
        }
        filter::set_filter_sprite_dirt_source_position(self, 5, right, up, distance);
        filter::set_filter_sprite_dirt_elapsed(self, 5, currenttime);
        wait 0.016;
        currenttime = getservertime(localclientnum);
    }
    filter::disable_filter_sprite_dirt(self, 5);
}

// Namespace explode
// Params 1, eflags: 0x1 linked
// Checksum 0xb6f42e6e, Offset: 0x8a8
// Size: 0x3a8
function watchforexplosion(localclientnum) {
    self endon(#"entityshutdown");
    while (true) {
        localclientnum, position, mod, weapon, owner_cent = level waittill(#"explode");
        explosiondistance = distance(self.origin, position);
        if ((mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE_SPLASH") && explosiondistance < 600 && !getinkillcam(localclientnum) && !isthirdperson(localclientnum)) {
            cameraangles = self getcamangles();
            if (!isdefined(cameraangles)) {
                continue;
            }
            forwardvec = vectornormalize(anglestoforward(cameraangles));
            upvec = vectornormalize(anglestoup(cameraangles));
            rightvec = vectornormalize(anglestoright(cameraangles));
            explosionvec = vectornormalize(position - self getcampos());
            if (vectordot(forwardvec, explosionvec) > 0) {
                trace = bullettrace(getlocalclienteyepos(localclientnum), position, 0, self);
                if (trace["fraction"] >= 0.9) {
                    udot = -1 * vectordot(explosionvec, upvec);
                    rdot = vectordot(explosionvec, rightvec);
                    udotabs = abs(udot);
                    rdotabs = abs(rdot);
                    if (udotabs > rdotabs) {
                        if (udot > 0) {
                            udot = 1;
                        } else {
                            udot = -1;
                        }
                    } else if (rdot > 0) {
                        rdot = 1;
                    } else {
                        rdot = -1;
                    }
                    self thread dothedirty(localclientnum, rdot, udot, 1 - explosiondistance / 600, 2000, 500);
                }
            }
        }
    }
}

