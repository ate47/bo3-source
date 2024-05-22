#using scripts/shared/ai/systems/weaponlist;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/util_shared;
#using scripts/shared/name_shared;
#using scripts/shared/gameskill_shared;

#using_animtree("generic");

#namespace init;

// Namespace init
// Params 1, eflags: 0x1 linked
// Checksum 0x49bea41e, Offset: 0x238
// Size: 0xe8
function initweapon(weapon) {
    self.weaponinfo[weapon.name] = spawnstruct();
    self.weaponinfo[weapon.name].position = "none";
    self.weaponinfo[weapon.name].hasclip = 1;
    if (isdefined(weapon.clipmodel)) {
        self.weaponinfo[weapon.name].useclip = 1;
        return;
    }
    self.weaponinfo[weapon.name].useclip = 0;
}

// Namespace init
// Params 0, eflags: 0x1 linked
// Checksum 0x5e702d00, Offset: 0x328
// Size: 0x564
function main() {
    self.a = spawnstruct();
    self.a.weaponpos = [];
    if (self.weapon == level.weaponnone) {
        self aiutility::setcurrentweapon(level.weaponnone);
    }
    self aiutility::setprimaryweapon(self.weapon);
    if (self.secondaryweapon == level.weaponnone) {
        self aiutility::setsecondaryweapon(level.weaponnone);
    }
    self aiutility::setsecondaryweapon(self.secondaryweapon);
    self aiutility::setcurrentweapon(self.primaryweapon);
    self.initial_primaryweapon = self.primaryweapon;
    self.initial_secondaryweapon = self.secondaryweapon;
    self initweapon(self.primaryweapon);
    self initweapon(self.secondaryweapon);
    self initweapon(self.sidearm);
    self.weapon_positions = array("left", "right", "chest", "back");
    for (i = 0; i < self.weapon_positions.size; i++) {
        self.a.weaponpos[self.weapon_positions[i]] = level.weaponnone;
    }
    self.lastweapon = self.weapon;
    self thread begingrenadetracking();
    self thread function_b44e1bfd();
    firstinit();
    self.a.rockets = 3;
    self.a.rocketvisible = 1;
    self.a.pose = "stand";
    self.a.prevpose = self.a.pose;
    self.a.movement = "stop";
    self.a.special = "none";
    self.a.gunhand = "none";
    shared::placeweaponon(self.primaryweapon, "right");
    if (isdefined(self.secondaryweaponclass) && self.secondaryweaponclass != "none" && self.secondaryweaponclass != "pistol") {
        shared::placeweaponon(self.secondaryweapon, "back");
    }
    self.a.combatendtime = gettime();
    self.a.nextgrenadetrytime = 0;
    self.a.isaiming = 0;
    self.rightaimlimit = 45;
    self.leftaimlimit = -45;
    self.upaimlimit = 45;
    self.downaimlimit = -45;
    self.walk = 0;
    self.sprint = 0;
    self.a.postscriptfunc = undefined;
    self.baseaccuracy = self.accuracy;
    if (!isdefined(self.script_accuracy)) {
        self.script_accuracy = 1;
    }
    if (self.team == "axis" || self.team == "team3") {
        self thread gameskill::function_f7773608();
    } else if (self.team == "allies") {
        self thread gameskill::function_54f3f08b();
    }
    self.a.misstime = 0;
    self.bulletsinclip = self.weapon.clipsize;
    self.lastenemysighttime = 0;
    self.combattime = 0;
    self.suppressed = 0;
    self.suppressedtime = 0;
    if (self.team == "allies") {
        self.suppressionthreshold = 0.75;
    } else {
        self.suppressionthreshold = 0.5;
    }
    if (self.team == "allies") {
        self.randomgrenaderange = 0;
    } else {
        self.randomgrenaderange = -128;
    }
    self.reacquire_state = 0;
}

// Namespace init
// Params 0, eflags: 0x0
// Checksum 0x834d6028, Offset: 0x898
// Size: 0x24
function setnameandrank() {
    self endon(#"death");
    self name::get();
}

// Namespace init
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x8c8
// Size: 0x4
function donothing() {
    
}

// Namespace init
// Params 0, eflags: 0x0
// Checksum 0xf199c4b9, Offset: 0x8d8
// Size: 0x38
function set_anim_playback_rate() {
    self.animplaybackrate = 0.9 + randomfloat(0.2);
    self.moveplaybackrate = 1;
}

// Namespace init
// Params 0, eflags: 0x0
// Checksum 0x3a96d7c2, Offset: 0x918
// Size: 0x2c
function trackvelocity() {
    self endon(#"death");
    for (;;) {
        self.oldorigin = self.origin;
        wait(0.2);
    }
}

/#

    // Namespace init
    // Params 1, eflags: 0x0
    // Checksum 0xb2ff24e9, Offset: 0x950
    // Size: 0x410
    function checkapproachangles(transtypes) {
        idealtransangles[1] = 45;
        idealtransangles[2] = 0;
        idealtransangles[3] = -45;
        idealtransangles[4] = 90;
        idealtransangles[6] = -90;
        idealtransangles[7] = -121;
        idealtransangles[8] = -76;
        idealtransangles[9] = -135;
        wait(0.05);
        for (i = 1; i <= 9; i++) {
            for (j = 0; j < transtypes.size; j++) {
                trans = transtypes[j];
                idealadd = 0;
                if (trans == "axis" || trans == "axis") {
                    idealadd = 90;
                } else if (trans == "axis" || trans == "axis") {
                    idealadd = -90;
                }
                if (isdefined(anim.covertransangles[trans][i])) {
                    correctangle = angleclamp180(idealtransangles[i] + idealadd);
                    actualangle = angleclamp180(anim.covertransangles[trans][i]);
                    if (absangleclamp180(actualangle - correctangle) > 7) {
                        println("axis" + trans + "axis" + i + "axis" + actualangle + "axis" + correctangle + "axis");
                    }
                }
            }
        }
        for (i = 1; i <= 9; i++) {
            for (j = 0; j < transtypes.size; j++) {
                trans = transtypes[j];
                idealadd = 0;
                if (trans == "axis" || trans == "axis") {
                    idealadd = 90;
                } else if (trans == "axis" || trans == "axis") {
                    idealadd = -90;
                }
                if (isdefined(anim.coverexitangles[trans][i])) {
                    correctangle = angleclamp180(-1 * (idealtransangles[i] + idealadd + -76));
                    actualangle = angleclamp180(anim.coverexitangles[trans][i]);
                    if (absangleclamp180(actualangle - correctangle) > 7) {
                        println("axis" + trans + "axis" + i + "axis" + actualangle + "axis" + correctangle + "axis");
                    }
                }
            }
        }
    }

#/

// Namespace init
// Params 2, eflags: 0x0
// Checksum 0x485c7c83, Offset: 0xd68
// Size: 0x2a
function getexitsplittime(approachtype, dir) {
    return anim.coverexitsplit[approachtype][dir];
}

// Namespace init
// Params 2, eflags: 0x0
// Checksum 0x1d9807cf, Offset: 0xda0
// Size: 0x2a
function gettranssplittime(approachtype, dir) {
    return anim.covertranssplit[approachtype][dir];
}

// Namespace init
// Params 0, eflags: 0x1 linked
// Checksum 0xa42ba06f, Offset: 0xdd8
// Size: 0x16c
function firstinit() {
    if (isdefined(anim.notfirsttime)) {
        return;
    }
    anim.notfirsttime = 1;
    anim.grenadetimers["player_frag_grenade_sp"] = randomintrange(1000, 20000);
    anim.grenadetimers["player_flash_grenade_sp"] = randomintrange(1000, 20000);
    anim.grenadetimers["player_double_grenade"] = randomintrange(10000, 60000);
    anim.grenadetimers["AI_frag_grenade_sp"] = randomintrange(0, 20000);
    anim.grenadetimers["AI_flash_grenade_sp"] = randomintrange(0, 20000);
    anim.numgrenadesinprogresstowardsplayer = 0;
    anim.lastgrenadelandednearplayertime = -1000000;
    anim.lastfraggrenadetoplayerstart = -1000000;
    thread setnextplayergrenadetime();
    if (!isdefined(level.flag)) {
        level.flag = [];
    }
    level.painai = undefined;
    anim.covercrouchleanpitch = -55;
}

// Namespace init
// Params 0, eflags: 0x0
// Checksum 0xebe0aaa1, Offset: 0xf50
// Size: 0x34
function onplayerconnect() {
    player = self;
    firstinit();
    player.invul = 0;
}

// Namespace init
// Params 0, eflags: 0x1 linked
// Checksum 0xd36ab55d, Offset: 0xf90
// Size: 0x156
function setnextplayergrenadetime() {
    waittillframeend();
    if (isdefined(anim.playergrenaderangetime)) {
        maxtime = int(anim.playergrenaderangetime * 0.7);
        if (maxtime < 1) {
            maxtime = 1;
        }
        anim.grenadetimers["player_frag_grenade_sp"] = randomintrange(0, maxtime);
        anim.grenadetimers["player_flash_grenade_sp"] = randomintrange(0, maxtime);
    }
    if (isdefined(anim.playerdoublegrenadetime)) {
        maxtime = int(anim.playerdoublegrenadetime);
        mintime = int(maxtime / 2);
        if (maxtime <= mintime) {
            maxtime = mintime + 1;
        }
        anim.grenadetimers["player_double_grenade"] = randomintrange(mintime, maxtime);
    }
}

// Namespace init
// Params 1, eflags: 0x1 linked
// Checksum 0x320caed, Offset: 0x10f0
// Size: 0xc4
function addtomissiles(grenade) {
    if (!isdefined(level.missileentities)) {
        level.missileentities = [];
    }
    if (!isdefined(level.missileentities)) {
        level.missileentities = [];
    } else if (!isarray(level.missileentities)) {
        level.missileentities = array(level.missileentities);
    }
    level.missileentities[level.missileentities.size] = grenade;
    while (isdefined(grenade)) {
        wait(0.05);
    }
    arrayremovevalue(level.missileentities, grenade);
}

// Namespace init
// Params 0, eflags: 0x1 linked
// Checksum 0x6e31397b, Offset: 0x11c0
// Size: 0xb8
function function_b44e1bfd() {
    if (!isdefined(level.missileentities)) {
        level.missileentities = [];
    }
    self endon(#"death");
    self thread function_48cec971();
    self thread function_a86baa0f();
    for (;;) {
        grenade, weapon = self waittill(#"grenade_fire");
        grenade.owner = self;
        grenade.weapon = weapon;
        level thread addtomissiles(grenade);
    }
}

// Namespace init
// Params 0, eflags: 0x1 linked
// Checksum 0xcad206b4, Offset: 0x1280
// Size: 0x78
function function_48cec971() {
    self endon(#"death");
    for (;;) {
        grenade, weapon = self waittill(#"grenade_launcher_fire");
        grenade.owner = self;
        grenade.weapon = weapon;
        level thread addtomissiles(grenade);
    }
}

// Namespace init
// Params 0, eflags: 0x1 linked
// Checksum 0xe8657850, Offset: 0x1300
// Size: 0x78
function function_a86baa0f() {
    self endon(#"death");
    for (;;) {
        grenade, weapon = self waittill(#"missile_fire");
        grenade.owner = self;
        grenade.weapon = weapon;
        level thread addtomissiles(grenade);
    }
}

// Namespace init
// Params 0, eflags: 0x1 linked
// Checksum 0x623988c7, Offset: 0x1380
// Size: 0x50
function begingrenadetracking() {
    self endon(#"death");
    for (;;) {
        grenade, weapon = self waittill(#"grenade_fire");
        grenade thread grenade_earthquake();
    }
}

// Namespace init
// Params 0, eflags: 0x1 linked
// Checksum 0x653fca96, Offset: 0x13d8
// Size: 0x1e
function endondeath() {
    self waittill(#"death");
    waittillframeend();
    self notify(#"end_explode");
}

// Namespace init
// Params 0, eflags: 0x1 linked
// Checksum 0x56af4433, Offset: 0x1400
// Size: 0x84
function grenade_earthquake() {
    self thread endondeath();
    self endon(#"end_explode");
    position = self waittill(#"explode");
    playrumbleonposition("grenade_rumble", position);
    earthquake(0.3, 0.5, position, 400);
}

// Namespace init
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x1490
// Size: 0x4
function end_script() {
    
}

