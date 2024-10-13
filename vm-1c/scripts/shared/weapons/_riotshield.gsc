#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#using_animtree("mp_riotshield");

#namespace riotshield;

// Namespace riotshield
// Params 0, eflags: 0x1 linked
// Checksum 0xabc8fb53, Offset: 0x540
// Size: 0x144
function init_shared() {
    if (!isdefined(level.weaponriotshield)) {
        level.weaponriotshield = getweapon("riotshield");
    }
    level.deployedshieldmodel = "t6_wpn_shield_carry_world";
    level.stowedshieldmodel = "t6_wpn_shield_stow_world";
    level.carriedshieldmodel = "t6_wpn_shield_carry_world";
    level.detectshieldmodel = "t6_wpn_shield_carry_world_detect";
    level.riotshielddestroyanim = mp_riotshield%o_riot_stand_destroyed;
    level.riotshielddeployanim = mp_riotshield%o_riot_stand_deploy;
    level.riotshieldshotanimfront = mp_riotshield%o_riot_stand_shot;
    level.riotshieldshotanimback = mp_riotshield%o_riot_stand_shot_back;
    level.riotshieldmeleeanimfront = mp_riotshield%o_riot_stand_melee_front;
    level.riotshieldmeleeanimback = mp_riotshield%o_riot_stand_melee_back;
    level.riotshield_placement_zoffset = 26;
    thread register();
    callback::on_spawned(&on_player_spawned);
}

// Namespace riotshield
// Params 0, eflags: 0x1 linked
// Checksum 0x77681d8f, Offset: 0x690
// Size: 0x34
function register() {
    clientfield::register("scriptmover", "riotshield_state", 1, 2, "int");
}

// Namespace riotshield
// Params 0, eflags: 0x1 linked
// Checksum 0xa1a2f67b, Offset: 0x6d0
// Size: 0x94
function watchpregameclasschange() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"track_riot_shield");
    self waittill(#"changed_class");
    if (level.ingraceperiod && !self.hasdonecombat) {
        self clearstowedweapon();
        self refreshshieldattachment();
        self thread trackriotshield();
    }
}

// Namespace riotshield
// Params 0, eflags: 0x1 linked
// Checksum 0x8b435af6, Offset: 0x770
// Size: 0x10c
function watchriotshieldpickup() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"track_riot_shield");
    self notify(#"watch_riotshield_pickup");
    self endon(#"watch_riotshield_pickup");
    self waittill(#"pickup_riotshield");
    self endon(#"weapon_change");
    println("<dev string:x28>");
    wait 0.5;
    println("<dev string:x60>");
    currentweapon = self getcurrentweapon();
    self.hasriotshield = self hasriotshield();
    self.hasriotshieldequipped = currentweapon.isriotshield;
    self refreshshieldattachment();
}

// Namespace riotshield
// Params 0, eflags: 0x1 linked
// Checksum 0x49ebdaf, Offset: 0x888
// Size: 0x258
function trackriotshield() {
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"track_riot_shield");
    self endon(#"track_riot_shield");
    self thread watchpregameclasschange();
    newweapon = self waittill(#"weapon_change");
    self refreshshieldattachment();
    currentweapon = self getcurrentweapon();
    self.hasriotshield = self hasriotshield();
    self.hasriotshieldequipped = currentweapon.isriotshield;
    self.lastnonshieldweapon = level.weaponnone;
    while (true) {
        self thread watchriotshieldpickup();
        currentweapon = self getcurrentweapon();
        currentweapon = self getcurrentweapon();
        self.hasriotshield = self hasriotshield();
        self.hasriotshieldequipped = currentweapon.isriotshield;
        refresh_attach = 0;
        newweapon = self waittill(#"weapon_change");
        if (newweapon.isriotshield) {
            refresh_attach = 1;
            if (isdefined(self.riotshieldentity)) {
                self notify(#"destroy_riotshield");
            }
            if (self.hasriotshield) {
                if (isdefined(self.riotshieldtakeweapon)) {
                    self takeweapon(self.riotshieldtakeweapon);
                    self.riotshieldtakeweapon = undefined;
                }
            }
            if (isvalidnonshieldweapon(currentweapon)) {
                self.lastnonshieldweapon = currentweapon;
            }
        }
        if (self.hasriotshield || refresh_attach == 1) {
            self refreshshieldattachment();
        }
    }
}

// Namespace riotshield
// Params 1, eflags: 0x1 linked
// Checksum 0xaaaa4193, Offset: 0xae8
// Size: 0x82
function isvalidnonshieldweapon(weapon) {
    if (killstreaks::is_killstreak_weapon(weapon)) {
        return false;
    }
    if (weapon.iscarriedkillstreak) {
        return false;
    }
    if (weapon.isgameplayweapon) {
        return false;
    }
    if (weapon == level.weaponnone) {
        return false;
    }
    if (weapon.isequipment) {
        return false;
    }
    return true;
}

// Namespace riotshield
// Params 0, eflags: 0x1 linked
// Checksum 0xd9bbf2c0, Offset: 0xb78
// Size: 0x24
function startriotshielddeploy() {
    self notify(#"start_riotshield_deploy");
    self thread watchriotshielddeploy();
}

// Namespace riotshield
// Params 1, eflags: 0x1 linked
// Checksum 0x814fa445, Offset: 0xba8
// Size: 0x16e
function resetreconmodelvisibility(owner) {
    if (!isdefined(self)) {
        return;
    }
    self setinvisibletoall();
    self setforcenocull();
    if (!isdefined(owner)) {
        return;
    }
    for (i = 0; i < level.players.size; i++) {
        if (level.players[i] hasperk("specialty_showenemyequipment")) {
            if (level.players[i].team == "spectator") {
                continue;
            }
            isenemy = 1;
            if (level.teambased) {
                if (level.players[i].team == owner.team) {
                    isenemy = 0;
                }
            } else if (level.players[i] == owner) {
                isenemy = 0;
            }
            if (isenemy) {
                self setvisibletoplayer(level.players[i]);
            }
        }
    }
}

// Namespace riotshield
// Params 2, eflags: 0x1 linked
// Checksum 0x267c6cbb, Offset: 0xd20
// Size: 0x68
function resetreconmodelonevent(eventname, owner) {
    self endon(#"death");
    for (;;) {
        newowner = level waittill(eventname);
        if (isdefined(newowner)) {
            owner = newowner;
        }
        self resetreconmodelvisibility(owner);
    }
}

// Namespace riotshield
// Params 2, eflags: 0x1 linked
// Checksum 0x51daaaf9, Offset: 0xd90
// Size: 0x120
function attachreconmodel(modelname, owner) {
    if (!isdefined(self)) {
        return;
    }
    reconmodel = spawn("script_model", self.origin);
    reconmodel.angles = self.angles;
    reconmodel setmodel(modelname);
    reconmodel.model_name = modelname;
    reconmodel linkto(self);
    reconmodel setcontents(0);
    reconmodel resetreconmodelvisibility(owner);
    reconmodel thread resetreconmodelonevent("joined_team", owner);
    reconmodel thread resetreconmodelonevent("player_spawned", owner);
    self.reconmodel = reconmodel;
}

// Namespace riotshield
// Params 2, eflags: 0x1 linked
// Checksum 0x19b6fe81, Offset: 0xeb8
// Size: 0x150
function spawnriotshieldcover(origin, angles) {
    shield_ent = spawn("script_model", origin, 1);
    shield_ent.targetname = "riotshield_mp";
    shield_ent.angles = angles;
    shield_ent setmodel(level.deployedshieldmodel);
    shield_ent setowner(self);
    shield_ent.owner = self;
    shield_ent.team = self.team;
    shield_ent setteam(self.team);
    shield_ent attachreconmodel(level.detectshieldmodel, self);
    shield_ent useanimtree(#mp_riotshield);
    shield_ent setscriptmoverflag(0);
    shield_ent disconnectpaths();
    return shield_ent;
}

// Namespace riotshield
// Params 0, eflags: 0x1 linked
// Checksum 0x2c70e987, Offset: 0x1010
// Size: 0x424
function watchriotshielddeploy() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"start_riotshield_deploy");
    deploy_attempt, weapon = self waittill(#"deploy_riotshield");
    self setplacementhint(1);
    placement_hint = 0;
    if (deploy_attempt) {
        placement = self canplaceriotshield("deploy_riotshield");
        if (placement["result"]) {
            self.hasdonecombat = 1;
            zoffset = level.riotshield_placement_zoffset;
            shield_ent = self spawnriotshieldcover(placement["origin"] + (0, 0, zoffset), placement["angles"]);
            item_ent = deployriotshield(self, shield_ent);
            primaries = self getweaponslistprimaries();
            /#
                assert(isdefined(item_ent));
                assert(!isdefined(self.riotshieldretrievetrigger));
                assert(!isdefined(self.riotshieldentity));
                if (level.gametype != "<dev string:x97>") {
                    assert(primaries.size > 0);
                }
            #/
            shield_ent clientfield::set("riotshield_state", 1);
            shield_ent.reconmodel clientfield::set("riotshield_state", 1);
            if (level.gametype != "shrp") {
                if (self.lastnonshieldweapon != level.weaponnone && self hasweapon(self.lastnonshieldweapon)) {
                    self switchtoweapon(self.lastnonshieldweapon);
                } else {
                    self switchtoweapon(primaries[0]);
                }
            }
            if (!self hasweapon(level.weaponbasemeleeheld)) {
                self giveweapon(level.weaponbasemeleeheld);
                self.riotshieldtakeweapon = level.weaponbasemeleeheld;
            }
            self.riotshieldretrievetrigger = item_ent;
            self.riotshieldentity = shield_ent;
            self thread watchdeployedriotshieldents();
            self thread deleteshieldontriggerdeath(self.riotshieldretrievetrigger);
            self thread deleteshieldonplayerdeathordisconnect(shield_ent);
            self.riotshieldentity thread watchdeployedriotshielddamage();
            level notify(#"riotshield_planted", self);
        } else {
            placement_hint = 1;
            clip_max_ammo = weapon.clipsize;
            self setweaponammoclip(weapon, clip_max_ammo);
        }
    } else {
        placement_hint = 1;
    }
    if (placement_hint) {
        self setriotshieldfailhint();
    }
}

// Namespace riotshield
// Params 1, eflags: 0x0
// Checksum 0x622d8140, Offset: 0x1440
// Size: 0x11e
function riotshielddistancetest(origin) {
    assert(isdefined(origin));
    min_dist_squared = getdvarfloat("riotshield_deploy_limit_radius");
    min_dist_squared *= min_dist_squared;
    for (i = 0; i < level.players.size; i++) {
        if (isdefined(level.players[i].riotshieldentity)) {
            dist_squared = distancesquared(level.players[i].riotshieldentity.origin, origin);
            if (min_dist_squared > dist_squared) {
                println("<dev string:x9c>");
                return false;
            }
        }
    }
    return true;
}

// Namespace riotshield
// Params 0, eflags: 0x1 linked
// Checksum 0x25742695, Offset: 0x1568
// Size: 0xec
function watchdeployedriotshieldents() {
    /#
        assert(isdefined(self.riotshieldretrievetrigger));
        assert(isdefined(self.riotshieldentity));
    #/
    self waittill(#"destroy_riotshield");
    if (isdefined(self.riotshieldretrievetrigger)) {
        self.riotshieldretrievetrigger delete();
    }
    if (isdefined(self.riotshieldentity)) {
        if (isdefined(self.riotshieldentity.reconmodel)) {
            self.riotshieldentity.reconmodel delete();
        }
        self.riotshieldentity connectpaths();
        self.riotshieldentity delete();
    }
}

// Namespace riotshield
// Params 0, eflags: 0x1 linked
// Checksum 0x37061f2a, Offset: 0x1660
// Size: 0x33c
function watchdeployedriotshielddamage() {
    self endon(#"death");
    damagemax = getdvarint("riotshield_deployed_health");
    self.damagetaken = 0;
    while (true) {
        self.maxhealth = 100000;
        self.health = self.maxhealth;
        damage, attacker, direction, point, type, tagname, modelname, partname, weapon, idflags = self waittill(#"damage");
        if (!isdefined(attacker)) {
            continue;
        }
        assert(isdefined(self.owner) && isdefined(self.owner.team));
        if (isplayer(attacker)) {
            if (level.teambased && attacker.team == self.owner.team && attacker != self.owner) {
                continue;
            }
        }
        if (type == "MOD_MELEE" || type == "MOD_MELEE_ASSASSINATE") {
            damage *= getdvarfloat("riotshield_melee_damage_scale");
        } else if (type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET") {
            damage *= getdvarfloat("riotshield_bullet_damage_scale");
        } else if (type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_EXPLOSIVE" || type == "MOD_EXPLOSIVE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH") {
            damage *= getdvarfloat("riotshield_explosive_damage_scale");
        } else if (type == "MOD_IMPACT") {
            damage *= getdvarfloat("riotshield_projectile_damage_scale");
        } else if (type == "MOD_CRUSH") {
            damage = damagemax;
        }
        self.damagetaken += damage;
        if (self.damagetaken >= damagemax) {
            self thread damagethendestroyriotshield(attacker, weapon);
            break;
        }
    }
}

// Namespace riotshield
// Params 2, eflags: 0x1 linked
// Checksum 0x22736a25, Offset: 0x19a8
// Size: 0x16c
function damagethendestroyriotshield(attacker, weapon) {
    self notify(#"damagethendestroyriotshield");
    self endon(#"death");
    if (isdefined(self.owner.riotshieldretrievetrigger)) {
        self.owner.riotshieldretrievetrigger delete();
    }
    if (isdefined(self.reconmodel)) {
        self.reconmodel delete();
    }
    self connectpaths();
    self.owner.riotshieldentity = undefined;
    self notsolid();
    self clientfield::set("riotshield_state", 2);
    if (isdefined(attacker) && attacker != self.owner && isplayer(attacker)) {
        scoreevents::processscoreevent("destroyed_shield", attacker, self.owner, weapon);
    }
    wait getdvarfloat("riotshield_destroyed_cleanup_time");
    self delete();
}

// Namespace riotshield
// Params 1, eflags: 0x1 linked
// Checksum 0x2176b6ce, Offset: 0x1b20
// Size: 0x42
function deleteshieldontriggerdeath(shield_trigger) {
    shield_trigger util::waittill_any("trigger", "death");
    self notify(#"destroy_riotshield");
}

// Namespace riotshield
// Params 1, eflags: 0x1 linked
// Checksum 0x8b35e804, Offset: 0x1b70
// Size: 0x6c
function deleteshieldonplayerdeathordisconnect(shield_ent) {
    shield_ent endon(#"death");
    shield_ent endon(#"damagethendestroyriotshield");
    self util::waittill_any("death", "disconnect", "remove_planted_weapons");
    shield_ent thread damagethendestroyriotshield();
}

// Namespace riotshield
// Params 2, eflags: 0x1 linked
// Checksum 0x7e4ab3eb, Offset: 0x1be8
// Size: 0x74
function watchriotshieldstuckentitydeath(grenade, owner) {
    grenade endon(#"death");
    self util::waittill_any("damageThenDestroyRiotshield", "death", "disconnect", "weapon_change", "deploy_riotshield");
    grenade detonate(owner);
}

// Namespace riotshield
// Params 0, eflags: 0x1 linked
// Checksum 0xa762d4c4, Offset: 0x1c68
// Size: 0x34
function on_player_spawned() {
    self thread watch_riot_shield_use();
    self thread begin_other_grenade_tracking();
}

// Namespace riotshield
// Params 0, eflags: 0x1 linked
// Checksum 0x17cf46a0, Offset: 0x1ca8
// Size: 0x50
function watch_riot_shield_use() {
    self endon(#"death");
    self endon(#"disconnect");
    self thread trackriotshield();
    for (;;) {
        self waittill(#"raise_riotshield");
        self thread startriotshielddeploy();
    }
}

// Namespace riotshield
// Params 0, eflags: 0x1 linked
// Checksum 0x78b77817, Offset: 0x1d00
// Size: 0xd2
function begin_other_grenade_tracking() {
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"hash_7fac4805");
    self endon(#"hash_7fac4805");
    for (;;) {
        grenade, weapon, cooktime = self waittill(#"grenade_fire");
        if (grenade util::ishacked()) {
            continue;
        }
        switch (weapon.name) {
        case "explosive_bolt":
        case "proximity_grenade":
        case "sticky_grenade":
            grenade thread check_stuck_to_shield();
            break;
        }
    }
}

// Namespace riotshield
// Params 0, eflags: 0x1 linked
// Checksum 0xc37a4a67, Offset: 0x1de0
// Size: 0x54
function check_stuck_to_shield() {
    self endon(#"death");
    other, owner = self waittill(#"stuck_to_shield");
    other watchriotshieldstuckentitydeath(self, owner);
}

