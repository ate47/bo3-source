#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/weapons/_tacticalinsertion;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/math_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace smokegrenade;

// Namespace smokegrenade
// Params 0, eflags: 0x1 linked
// Checksum 0xa4898f3b, Offset: 0x270
// Size: 0x8c
function init_shared() {
    level.willypetedamageradius = 300;
    level.willypetedamageheight = -128;
    level.smokegrenadeduration = 8;
    level.smokegrenadedissipation = 4;
    level.smokegrenadetotaltime = level.smokegrenadeduration + level.smokegrenadedissipation;
    level.fx_smokegrenade_single = "smoke_center";
    level.smoke_grenade_triggers = [];
    callback::on_spawned(&on_player_spawned);
}

// Namespace smokegrenade
// Params 5, eflags: 0x1 linked
// Checksum 0xf9d8a67c, Offset: 0x308
// Size: 0x134
function watchsmokegrenadedetonation(owner, statweapon, grenadeweaponname, duration, totaltime) {
    self endon(#"trophy_destroyed");
    owner addweaponstat(statweapon, "used", 1);
    position, surface = self waittill(#"explode");
    onefoot = (0, 0, 12);
    startpos = position + onefoot;
    smokeweapon = getweapon(grenadeweaponname);
    smokedetonate(owner, statweapon, smokeweapon, position, -128, totaltime, duration);
    damageeffectarea(owner, startpos, smokeweapon.explosionradius, level.willypetedamageheight, undefined);
}

// Namespace smokegrenade
// Params 7, eflags: 0x1 linked
// Checksum 0x9273d07c, Offset: 0x448
// Size: 0x160
function smokedetonate(owner, statweapon, smokeweapon, position, radius, effectlifetime, smokeblockduration) {
    dir_up = (0, 0, 1);
    ent = spawntimedfx(smokeweapon, position, dir_up, effectlifetime);
    ent setteam(owner.team);
    ent setowner(owner);
    ent thread smokeblocksight(radius);
    ent thread spawnsmokegrenadetrigger(smokeblockduration);
    if (isdefined(owner)) {
        owner.smokegrenadetime = gettime();
        owner.smokegrenadeposition = position;
    }
    thread playsmokesound(position, smokeblockduration, statweapon.projsmokestartsound, statweapon.projsmokeendsound, statweapon.projsmokeloopsound);
    return ent;
}

// Namespace smokegrenade
// Params 5, eflags: 0x1 linked
// Checksum 0xd0aef74c, Offset: 0x5b0
// Size: 0x9c
function damageeffectarea(owner, position, radius, height, killcament) {
    effectarea = spawn("trigger_radius", position, 0, radius, height);
    if (isdefined(level.dogsonflashdogs)) {
        owner thread [[ level.dogsonflashdogs ]](effectarea);
    }
    effectarea delete();
}

// Namespace smokegrenade
// Params 1, eflags: 0x1 linked
// Checksum 0xf846a3dc, Offset: 0x658
// Size: 0x98
function smokeblocksight(radius) {
    self endon(#"death");
    while (true) {
        fxblocksight(self, radius);
        /#
            if (getdvarint("<unknown string>", 0)) {
                sphere(self.origin, -128, (1, 0, 0), 0.25, 0, 10, 15);
            }
        #/
        wait(0.75);
    }
}

// Namespace smokegrenade
// Params 1, eflags: 0x1 linked
// Checksum 0xdf98b74c, Offset: 0x6f8
// Size: 0x11c
function spawnsmokegrenadetrigger(duration) {
    team = self.team;
    trigger = spawn("trigger_radius", self.origin, 0, -128, -128);
    if (!isdefined(level.smoke_grenade_triggers)) {
        level.smoke_grenade_triggers = [];
    } else if (!isarray(level.smoke_grenade_triggers)) {
        level.smoke_grenade_triggers = array(level.smoke_grenade_triggers);
    }
    level.smoke_grenade_triggers[level.smoke_grenade_triggers.size] = trigger;
    self util::waittill_any_timeout(duration, "death");
    arrayremovevalue(level.smoke_grenade_triggers, trigger);
    trigger delete();
}

// Namespace smokegrenade
// Params 0, eflags: 0x1 linked
// Checksum 0xab5b5d76, Offset: 0x820
// Size: 0x94
function function_c7ecc8f3() {
    foreach (trigger in level.smoke_grenade_triggers) {
        if (self istouching(trigger)) {
            return true;
        }
    }
    return false;
}

// Namespace smokegrenade
// Params 0, eflags: 0x1 linked
// Checksum 0x32980acc, Offset: 0x8c0
// Size: 0x24
function on_player_spawned() {
    self endon(#"disconnect");
    self thread begin_other_grenade_tracking();
}

// Namespace smokegrenade
// Params 0, eflags: 0x1 linked
// Checksum 0x5b9a858f, Offset: 0x8f0
// Size: 0xf0
function begin_other_grenade_tracking() {
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"hash_a852d5c9");
    self endon(#"hash_a852d5c9");
    weapon_smoke = getweapon("willy_pete");
    for (;;) {
        grenade, weapon, cooktime = self waittill(#"grenade_fire");
        if (grenade util::ishacked()) {
            continue;
        }
        if (weapon.rootweapon == weapon_smoke) {
            grenade thread watchsmokegrenadedetonation(self, weapon_smoke, level.fx_smokegrenade_single, level.smokegrenadeduration, level.smokegrenadetotaltime);
        }
    }
}

// Namespace smokegrenade
// Params 5, eflags: 0x1 linked
// Checksum 0x175271af, Offset: 0x9e8
// Size: 0x13c
function playsmokesound(position, duration, startsound, stopsound, loopsound) {
    smokesound = spawn("script_origin", (0, 0, 1));
    smokesound.origin = position;
    if (isdefined(startsound)) {
        smokesound playsound(startsound);
    }
    if (isdefined(loopsound)) {
        smokesound playloopsound(loopsound);
    }
    if (duration > 0.5) {
        wait(duration - 0.5);
    }
    if (isdefined(stopsound)) {
        thread sound::play_in_space(stopsound, position);
    }
    smokesound stoploopsound(0.5);
    wait(0.5);
    smokesound delete();
}

