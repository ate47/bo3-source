#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#using_animtree("bouncing_betty");

#namespace bouncingbetty;

// Namespace bouncingbetty
// Params 0, eflags: 0x1 linked
// Checksum 0xc22a486c, Offset: 0x468
// Size: 0x2d4
function init_shared() {
    level.bettydestroyedfx = "weapon/fx_betty_exp_destroyed";
    level._effect["fx_betty_friendly_light"] = "weapon/fx_betty_light_blue";
    level._effect["fx_betty_enemy_light"] = "weapon/fx_betty_light_orng";
    level.bettymindist = 20;
    level.bettystuntime = 1;
    bettyexplodeanim = bouncing_betty%o_spider_mine_detonate;
    bettydeployanim = bouncing_betty%o_spider_mine_deploy;
    level.bettyradius = getdvarint("betty_detect_radius", -76);
    level.bettyactivationdelay = getdvarfloat("betty_activation_delay", 1);
    level.bettygraceperiod = getdvarfloat("betty_grace_period", 0);
    level.bettydamageradius = getdvarint("betty_damage_radius", -76);
    level.bettydamagemax = getdvarint("betty_damage_max", -76);
    level.bettydamagemin = getdvarint("betty_damage_min", 70);
    level.bettydamageheight = getdvarint("betty_damage_cylinder_height", -56);
    level.bettyjumpheight = getdvarint("betty_jump_height_onground", 55);
    level.bettyjumpheightwall = getdvarint("betty_jump_height_wall", 20);
    level.bettyjumpheightwallangle = getdvarint("betty_onground_angle_threshold", 30);
    level.bettyjumpheightwallanglecos = cos(level.bettyjumpheightwallangle);
    level.bettyjumptime = getdvarfloat("betty_jump_time", 0.7);
    level.bettybombletspawndistance = 20;
    level.bettybombletcount = 4;
    level thread register();
    /#
        level thread bouncingbettydvarupdate();
    #/
    callback::function_367a33a8(&createbouncingbettywatcher);
}

// Namespace bouncingbetty
// Params 0, eflags: 0x1 linked
// Checksum 0x68c82c49, Offset: 0x748
// Size: 0x64
function register() {
    clientfield::register("missile", "bouncingbetty_state", 1, 2, "int");
    clientfield::register("scriptmover", "bouncingbetty_state", 1, 2, "int");
}

/#

    // Namespace bouncingbetty
    // Params 0, eflags: 0x1 linked
    // Checksum 0x69a91686, Offset: 0x7b8
    // Size: 0x1ee
    function bouncingbettydvarupdate() {
        for (;;) {
            level.bettyradius = getdvarint("betty_damage_radius", level.bettyradius);
            level.bettyactivationdelay = getdvarfloat("betty_damage_radius", level.bettyactivationdelay);
            level.bettygraceperiod = getdvarfloat("betty_damage_radius", level.bettygraceperiod);
            level.bettydamageradius = getdvarint("betty_damage_radius", level.bettydamageradius);
            level.bettydamagemax = getdvarint("betty_damage_radius", level.bettydamagemax);
            level.bettydamagemin = getdvarint("betty_damage_radius", level.bettydamagemin);
            level.bettydamageheight = getdvarint("betty_damage_radius", level.bettydamageheight);
            level.bettyjumpheight = getdvarint("betty_damage_radius", level.bettyjumpheight);
            level.bettyjumpheightwall = getdvarint("betty_damage_radius", level.bettyjumpheightwall);
            level.bettyjumpheightwallangle = getdvarint("betty_damage_radius", level.bettyjumpheightwallangle);
            level.bettyjumpheightwallanglecos = cos(level.bettyjumpheightwallangle);
            level.bettyjumptime = getdvarfloat("betty_damage_radius", level.bettyjumptime);
            wait(3);
        }
    }

#/

// Namespace bouncingbetty
// Params 0, eflags: 0x1 linked
// Checksum 0x21dbe58c, Offset: 0x9b0
// Size: 0x1b8
function createbouncingbettywatcher() {
    watcher = self weaponobjects::createproximityweaponobjectwatcher("bouncingbetty", self.team);
    watcher.onspawn = &onspawnbouncingbetty;
    watcher.watchforfire = 1;
    watcher.ondetonatecallback = &bouncingbettydetonate;
    watcher.activatesound = "wpn_betty_alert";
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.immediatedetonation = 1;
    watcher.immunespecialty = "specialty_immunetriggerbetty";
    watcher.detectionmindist = level.bettymindist;
    watcher.detectiongraceperiod = level.bettygraceperiod;
    watcher.detonateradius = level.bettyradius;
    watcher.onfizzleout = &onbouncingbettyfizzleout;
    watcher.stun = &weaponobjects::weaponstun;
    watcher.stuntime = level.bettystuntime;
    watcher.activationdelay = level.bettyactivationdelay;
}

// Namespace bouncingbetty
// Params 0, eflags: 0x1 linked
// Checksum 0xee4e0a1c, Offset: 0xb70
// Size: 0x74
function onbouncingbettyfizzleout() {
    if (isdefined(self.minemover)) {
        if (isdefined(self.minemover.killcament)) {
            self.minemover.killcament delete();
        }
        self.minemover delete();
    }
    self delete();
}

// Namespace bouncingbetty
// Params 2, eflags: 0x1 linked
// Checksum 0x956ae8b5, Offset: 0xbf0
// Size: 0xac
function onspawnbouncingbetty(watcher, owner) {
    weaponobjects::onspawnproximityweaponobject(watcher, owner);
    self.originalowner = owner;
    self thread spawnminemover();
    self trackonowner(owner);
    self thread trackusedstatondeath();
    self thread donotrackusedstatonpickup();
    self thread trackusedonhack();
}

// Namespace bouncingbetty
// Params 0, eflags: 0x1 linked
// Checksum 0xab87753b, Offset: 0xca8
// Size: 0x5e
function trackusedstatondeath() {
    self endon(#"do_not_track_used");
    self waittill(#"death");
    waittillframeend();
    if (isdefined(self.owner)) {
        self.owner trackbouncingbettyasused();
    }
    self notify(#"end_donotrackusedonpickup");
    self notify(#"end_donotrackusedonhacked");
}

// Namespace bouncingbetty
// Params 0, eflags: 0x1 linked
// Checksum 0x57835688, Offset: 0xd10
// Size: 0x2a
function donotrackusedstatonpickup() {
    self endon(#"end_donotrackusedonpickup");
    self waittill(#"picked_up");
    self notify(#"do_not_track_used");
}

// Namespace bouncingbetty
// Params 0, eflags: 0x1 linked
// Checksum 0x70bb5f68, Offset: 0xd48
// Size: 0x42
function trackusedonhack() {
    self endon(#"end_donotrackusedonhacked");
    self waittill(#"hacked");
    self.originalowner trackbouncingbettyasused();
    self notify(#"do_not_track_used");
}

// Namespace bouncingbetty
// Params 0, eflags: 0x1 linked
// Checksum 0xace15d4b, Offset: 0xd98
// Size: 0x54
function trackbouncingbettyasused() {
    if (isplayer(self)) {
        self addweaponstat(getweapon("bouncingbetty"), "used", 1);
    }
}

// Namespace bouncingbetty
// Params 1, eflags: 0x1 linked
// Checksum 0xaf8469e2, Offset: 0xdf8
// Size: 0x96
function trackonowner(owner) {
    if (level.trackbouncingbettiesonowner === 1) {
        if (!isdefined(owner)) {
            return;
        }
        if (!isdefined(owner.activebouncingbetties)) {
            owner.activebouncingbetties = [];
        } else {
            arrayremovevalue(owner.activebouncingbetties, undefined);
        }
        owner.activebouncingbetties[owner.activebouncingbetties.size] = self;
    }
}

// Namespace bouncingbetty
// Params 0, eflags: 0x1 linked
// Checksum 0x95e6a23, Offset: 0xe98
// Size: 0x2a4
function spawnminemover() {
    self endon(#"death");
    self util::waittillnotmoving();
    self clientfield::set("bouncingbetty_state", 2);
    self useanimtree(#bouncing_betty);
    self setanim(bouncing_betty%o_spider_mine_deploy, 1, 0, 1);
    minemover = spawn("script_model", self.origin);
    minemover.angles = self.angles;
    minemover setmodel("tag_origin");
    minemover.owner = self.owner;
    mineup = anglestoup(minemover.angles);
    z_offset = getdvarfloat("scr_bouncing_betty_killcam_offset", 18);
    minemover enablelinkto();
    minemover linkto(self);
    minemover.killcamoffset = vectorscale(mineup, z_offset);
    minemover.weapon = self.weapon;
    minemover playsound("wpn_betty_arm");
    killcament = spawn("script_model", minemover.origin + minemover.killcamoffset);
    killcament.angles = (0, 0, 0);
    killcament setmodel("tag_origin");
    killcament setweapon(self.weapon);
    minemover.killcament = killcament;
    self.minemover = minemover;
    self thread killminemoveronpickup();
}

// Namespace bouncingbetty
// Params 0, eflags: 0x1 linked
// Checksum 0xe7f9b829, Offset: 0x1148
// Size: 0x54
function killminemoveronpickup() {
    self.minemover endon(#"death");
    self util::waittill_any("picked_up", "hacked");
    self killminemover();
}

// Namespace bouncingbetty
// Params 0, eflags: 0x1 linked
// Checksum 0x6e34f188, Offset: 0x11a8
// Size: 0x5c
function killminemover() {
    if (isdefined(self.minemover)) {
        if (isdefined(self.minemover.killcament)) {
            self.minemover.killcament delete();
        }
        self.minemover delete();
    }
}

// Namespace bouncingbetty
// Params 3, eflags: 0x1 linked
// Checksum 0xbb0528b2, Offset: 0x1210
// Size: 0x15c
function bouncingbettydetonate(attacker, weapon, target) {
    if (isdefined(weapon) && weapon.isvalid) {
        self.destroyedby = attacker;
        if (isdefined(attacker)) {
            if (self.owner util::isenemyplayer(attacker)) {
                attacker challenges::destroyedexplosive(weapon);
                scoreevents::processscoreevent("destroyed_bouncingbetty", attacker, self.owner, weapon);
            }
        }
        self bouncingbettydestroyed();
        return;
    }
    if (isdefined(self.minemover)) {
        self.minemover.ignore_team_kills = 1;
        self.minemover setmodel(self.model);
        self.minemover thread bouncingbettyjumpandexplode();
        self delete();
        return;
    }
    self bouncingbettydestroyed();
}

// Namespace bouncingbetty
// Params 0, eflags: 0x1 linked
// Checksum 0x518785ed, Offset: 0x1378
// Size: 0xdc
function bouncingbettydestroyed() {
    playfx(level.bettydestroyedfx, self.origin);
    playsoundatposition("dst_equipment_destroy", self.origin);
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    self killminemover();
    self radiusdamage(self.origin, -128, 110, 10, self.owner, "MOD_EXPLOSIVE", self.weapon);
    self delete();
}

// Namespace bouncingbetty
// Params 0, eflags: 0x1 linked
// Checksum 0x58dec02a, Offset: 0x1460
// Size: 0x114
function bouncingbettyjumpandexplode() {
    jumpdir = vectornormalize(anglestoup(self.angles));
    if (jumpdir[2] > level.bettyjumpheightwallanglecos) {
        jumpheight = level.bettyjumpheight;
    } else {
        jumpheight = level.bettyjumpheightwall;
    }
    explodepos = self.origin + jumpdir * jumpheight;
    self.killcament moveto(explodepos + self.killcamoffset, level.bettyjumptime, 0, level.bettyjumptime);
    self clientfield::set("bouncingbetty_state", 1);
    wait(level.bettyjumptime);
    self thread mineexplode(jumpdir, explodepos);
}

// Namespace bouncingbetty
// Params 2, eflags: 0x1 linked
// Checksum 0x76eb6742, Offset: 0x1580
// Size: 0x17c
function mineexplode(explosiondir, explodepos) {
    if (!isdefined(self) || !isdefined(self.owner)) {
        return;
    }
    self playsound("wpn_betty_explo");
    self clientfield::set("sndRattle", 1);
    wait(0.05);
    if (!isdefined(self) || !isdefined(self.owner)) {
        return;
    }
    self cylinderdamage(explosiondir * level.bettydamageheight, explodepos, level.bettydamageradius, level.bettydamageradius, level.bettydamagemax, level.bettydamagemin, self.owner, "MOD_EXPLOSIVE", self.weapon);
    self ghost();
    wait(0.1);
    if (!isdefined(self) || !isdefined(self.owner)) {
        return;
    }
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    self.killcament delete();
    self delete();
}

