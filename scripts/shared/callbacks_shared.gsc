#using scripts/shared/system_shared;
#using scripts/shared/simple_hostmigration;
#using scripts/shared/hud_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;

// Can't decompile export callback::finishcustomtraversallistener

#namespace callback;

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0xbf800c51, Offset: 0x1e8
// Size: 0x134
function callback(event, params) {
    if (isdefined(level._callbacks) && isdefined(level._callbacks[event])) {
        for (i = 0; i < level._callbacks[event].size; i++) {
            callback = level._callbacks[event][i][0];
            obj = level._callbacks[event][i][1];
            if (!isdefined(callback)) {
                continue;
            }
            if (isdefined(obj)) {
                if (isdefined(params)) {
                    obj thread [[ callback ]](self, params);
                } else {
                    obj thread [[ callback ]](self);
                }
                continue;
            }
            if (isdefined(params)) {
                self thread [[ callback ]](params);
                continue;
            }
            self thread [[ callback ]]();
        }
    }
}

// Namespace callback
// Params 3, eflags: 0x1 linked
// Checksum 0xf8621dc8, Offset: 0x328
// Size: 0x18c
function add_callback(event, func, obj) {
    /#
        assert(isdefined(event), "CP_ALL_DECORATIONS");
    #/
    if (!isdefined(level._callbacks) || !isdefined(level._callbacks[event])) {
        level._callbacks[event] = [];
    }
    foreach (callback in level._callbacks[event]) {
        if (callback[0] == func) {
            if (!isdefined(obj) || callback[1] == obj) {
                return;
            }
        }
    }
    array::add(level._callbacks[event], array(func, obj), 0);
    if (isdefined(obj)) {
        obj thread remove_callback_on_death(event, func);
    }
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0xe9a29850, Offset: 0x4c0
// Size: 0x3c
function remove_callback_on_death(event, func) {
    self waittill(#"death");
    remove_callback(event, func, self);
}

// Namespace callback
// Params 3, eflags: 0x1 linked
// Checksum 0x47454813, Offset: 0x508
// Size: 0x13e
function remove_callback(event, func, obj) {
    /#
        assert(isdefined(event), "CP_ALL_DECORATIONS");
    #/
    /#
        assert(isdefined(level._callbacks[event]), "CP_ALL_DECORATIONS");
    #/
    foreach (index, func_group in level._callbacks[event]) {
        if (func_group[0] == func) {
            if (func_group[1] === obj) {
                arrayremoveindex(level._callbacks[event], index, 0);
                break;
            }
        }
    }
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x59fb6166, Offset: 0x650
// Size: 0x34
function on_finalize_initialization(func, obj) {
    add_callback(#"hash_36fb1b1a", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0xa3bb1492, Offset: 0x690
// Size: 0x34
function on_connect(func, obj) {
    add_callback(#"hash_eaffea17", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x4a68b221, Offset: 0x6d0
// Size: 0x34
function remove_on_connect(func, obj) {
    remove_callback(#"hash_eaffea17", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x21382839, Offset: 0x710
// Size: 0x34
function on_connecting(func, obj) {
    add_callback(#"hash_fefe13f5", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x0
// Checksum 0xc650034d, Offset: 0x750
// Size: 0x34
function remove_on_connecting(func, obj) {
    remove_callback(#"hash_fefe13f5", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x4f79bac7, Offset: 0x790
// Size: 0x34
function on_disconnect(func, obj) {
    add_callback(#"hash_aebdd257", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0xeeefc98a, Offset: 0x7d0
// Size: 0x34
function remove_on_disconnect(func, obj) {
    remove_callback(#"hash_aebdd257", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0xb675cd4e, Offset: 0x810
// Size: 0x34
function on_spawned(func, obj) {
    add_callback(#"hash_bc12b61f", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x1b1f5633, Offset: 0x850
// Size: 0x34
function remove_on_spawned(func, obj) {
    remove_callback(#"hash_bc12b61f", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x12de6700, Offset: 0x890
// Size: 0x34
function on_loadout(func, obj) {
    add_callback(#"hash_33bba039", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x2b2c56fc, Offset: 0x8d0
// Size: 0x34
function remove_on_loadout(func, obj) {
    remove_callback(#"hash_33bba039", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x4683f8bd, Offset: 0x910
// Size: 0x34
function on_player_damage(func, obj) {
    add_callback(#"hash_ab5ecf6c", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x96eaa2de, Offset: 0x950
// Size: 0x34
function remove_on_player_damage(func, obj) {
    remove_callback(#"hash_ab5ecf6c", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x29a20c08, Offset: 0x990
// Size: 0x34
function on_start_gametype(func, obj) {
    add_callback(#"hash_cc62acca", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x8d185449, Offset: 0x9d0
// Size: 0x34
function on_joined_team(func, obj) {
    add_callback(#"hash_95a6c4c0", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0xa955467d, Offset: 0xa10
// Size: 0x34
function on_joined_spectate(func, obj) {
    add_callback(#"hash_4c5ae192", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x48cfde09, Offset: 0xa50
// Size: 0x34
function on_player_killed(func, obj) {
    add_callback(#"hash_bc435202", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x0
// Checksum 0xa9cbf769, Offset: 0xa90
// Size: 0x34
function remove_on_player_killed(func, obj) {
    remove_callback(#"hash_bc435202", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x1ba9bef2, Offset: 0xad0
// Size: 0x34
function on_ai_killed(func, obj) {
    add_callback(#"hash_fc2ec5ff", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x4fa015b1, Offset: 0xb10
// Size: 0x34
function remove_on_ai_killed(func, obj) {
    remove_callback(#"hash_fc2ec5ff", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x40c25da0, Offset: 0xb50
// Size: 0x34
function on_actor_killed(func, obj) {
    add_callback(#"hash_8c38c12e", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x464d37e4, Offset: 0xb90
// Size: 0x34
function remove_on_actor_killed(func, obj) {
    remove_callback(#"hash_8c38c12e", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0xb1a13417, Offset: 0xbd0
// Size: 0x34
function on_vehicle_spawned(func, obj) {
    add_callback(#"hash_bae82b92", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x0
// Checksum 0x4e9add3b, Offset: 0xc10
// Size: 0x34
function remove_on_vehicle_spawned(func, obj) {
    remove_callback(#"hash_bae82b92", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0xf010e8ca, Offset: 0xc50
// Size: 0x34
function on_vehicle_killed(func, obj) {
    add_callback(#"hash_acb66515", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x1019c3f2, Offset: 0xc90
// Size: 0x34
function remove_on_vehicle_killed(func, obj) {
    remove_callback(#"hash_acb66515", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0xa0498752, Offset: 0xcd0
// Size: 0x34
function on_ai_damage(func, obj) {
    add_callback(#"hash_eb4a4369", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x6a025514, Offset: 0xd10
// Size: 0x34
function remove_on_ai_damage(func, obj) {
    remove_callback(#"hash_eb4a4369", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0xb48f6ced, Offset: 0xd50
// Size: 0x34
function on_ai_spawned(func, obj) {
    add_callback(#"hash_f96ca9bc", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x6519d1ee, Offset: 0xd90
// Size: 0x34
function remove_on_ai_spawned(func, obj) {
    remove_callback(#"hash_f96ca9bc", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0xa14636cb, Offset: 0xdd0
// Size: 0x34
function on_actor_damage(func, obj) {
    add_callback(#"hash_7b543e98", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0xafe44382, Offset: 0xe10
// Size: 0x34
function remove_on_actor_damage(func, obj) {
    remove_callback(#"hash_7b543e98", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0xb00793e5, Offset: 0xe50
// Size: 0x34
function on_vehicle_damage(func, obj) {
    add_callback(#"hash_9bd1e27f", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x0
// Checksum 0x180d0c44, Offset: 0xe90
// Size: 0x34
function remove_on_vehicle_damage(func, obj) {
    remove_callback(#"hash_9bd1e27f", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x49724d9c, Offset: 0xed0
// Size: 0x34
function on_laststand(func, obj) {
    add_callback(#"hash_6751ab5b", func, obj);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0xc2655bd9, Offset: 0xf10
// Size: 0x34
function on_challenge_complete(func, obj) {
    add_callback(#"hash_b286c65c", func, obj);
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// Checksum 0xd96be601, Offset: 0xf50
// Size: 0x2c
function codecallback_preinitialization() {
    callback(#"hash_ecc6aecf");
    system::run_pre_systems();
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// Checksum 0xf10abc5d, Offset: 0xf88
// Size: 0x2c
function codecallback_finalizeinitialization() {
    system::run_post_systems();
    callback(#"hash_36fb1b1a");
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x8ed56e39, Offset: 0xfc0
// Size: 0x3e
function add_weapon_damage(weapontype, callback) {
    if (!isdefined(level.weapon_damage_callback_array)) {
        level.weapon_damage_callback_array = [];
    }
    level.weapon_damage_callback_array[weapontype] = callback;
}

// Namespace callback
// Params 5, eflags: 0x1 linked
// Checksum 0x817bf70f, Offset: 0x1008
// Size: 0xda
function callback_weapon_damage(eattacker, einflictor, weapon, meansofdeath, damage) {
    if (isdefined(level.weapon_damage_callback_array)) {
        if (isdefined(level.weapon_damage_callback_array[weapon])) {
            self thread [[ level.weapon_damage_callback_array[weapon] ]](eattacker, einflictor, weapon, meansofdeath, damage);
            return true;
        } else if (isdefined(level.weapon_damage_callback_array[weapon.rootweapon])) {
            self thread [[ level.weapon_damage_callback_array[weapon.rootweapon] ]](eattacker, einflictor, weapon, meansofdeath, damage);
            return true;
        }
    }
    return false;
}

// Namespace callback
// Params 1, eflags: 0x1 linked
// Checksum 0x39eafcca, Offset: 0x10f0
// Size: 0x44
function function_367a33a8(callback) {
    if (!isdefined(level.var_1a51bc10)) {
        level.var_1a51bc10 = [];
    }
    array::add(level.var_1a51bc10, callback);
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// Checksum 0x40668f64, Offset: 0x1140
// Size: 0x54
function function_25419ce() {
    if (isdefined(level.var_1a51bc10)) {
        for (x = 0; x < level.var_1a51bc10.size; x++) {
            self [[ level.var_1a51bc10[x] ]]();
        }
    }
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// Checksum 0xb20b5dfc, Offset: 0x11a0
// Size: 0x3c
function codecallback_startgametype() {
    if (!isdefined(level.gametypestarted) || !level.gametypestarted) {
        [[ level.callbackstartgametype ]]();
        level.gametypestarted = 1;
    }
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// Checksum 0x117ee0d9, Offset: 0x11e8
// Size: 0x1c
function codecallback_playerconnect() {
    self endon(#"disconnect");
    [[ level.callbackplayerconnect ]]();
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// Checksum 0x850de460, Offset: 0x1210
// Size: 0x64
function codecallback_playerdisconnect() {
    self notify(#"death");
    self.player_disconnected = 1;
    self notify(#"disconnect");
    level notify(#"disconnect", self);
    [[ level.callbackplayerdisconnect ]]();
    callback(#"hash_aebdd257");
}

// Namespace callback
// Params 0, eflags: 0x0
// Checksum 0x7ff90849, Offset: 0x1280
// Size: 0x34
function codecallback_migration_setupgametype() {
    /#
        println("CP_ALL_DECORATIONS");
    #/
    simple_hostmigration::migration_setupgametype();
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// Checksum 0xa3e742c0, Offset: 0x12c0
// Size: 0x34
function codecallback_hostmigration() {
    /#
        println("CP_ALL_DECORATIONS");
    #/
    [[ level.callbackhostmigration ]]();
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// Checksum 0x1da9cab5, Offset: 0x1300
// Size: 0x34
function codecallback_hostmigrationsave() {
    /#
        println("CP_ALL_DECORATIONS");
    #/
    [[ level.callbackhostmigrationsave ]]();
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// Checksum 0x5bd0d6fd, Offset: 0x1340
// Size: 0x34
function codecallback_prehostmigrationsave() {
    /#
        println("CP_ALL_DECORATIONS");
    #/
    [[ level.callbackprehostmigrationsave ]]();
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// Checksum 0xeeabbfa5, Offset: 0x1380
// Size: 0x34
function codecallback_playermigrated() {
    /#
        println("CP_ALL_DECORATIONS");
    #/
    [[ level.callbackplayermigrated ]]();
}

// Namespace callback
// Params d, eflags: 0x1 linked
// Checksum 0x8f21f542, Offset: 0x13c0
// Size: 0xb8
function codecallback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, vsurfacenormal) {
    self endon(#"disconnect");
    [[ level.callbackplayerdamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, vsurfacenormal);
}

// Namespace callback
// Params 9, eflags: 0x1 linked
// Checksum 0x91abe38a, Offset: 0x1480
// Size: 0x88
function codecallback_playerkilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, timeoffset, deathanimduration) {
    self endon(#"disconnect");
    [[ level.callbackplayerkilled ]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, timeoffset, deathanimduration);
}

// Namespace callback
// Params 9, eflags: 0x1 linked
// Checksum 0x3cf3c93e, Offset: 0x1510
// Size: 0x88
function codecallback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, timeoffset, delayoverride) {
    self endon(#"disconnect");
    [[ level.callbackplayerlaststand ]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, timeoffset, delayoverride);
}

// Namespace callback
// Params 8, eflags: 0x1 linked
// Checksum 0x21b2fc39, Offset: 0x15a0
// Size: 0x7c
function codecallback_playermelee(eattacker, idamage, weapon, vorigin, vdir, boneindex, shieldhit, frombehind) {
    self endon(#"disconnect");
    [[ level.callbackplayermelee ]](eattacker, idamage, weapon, vorigin, vdir, boneindex, shieldhit, frombehind);
}

// Namespace callback
// Params 1, eflags: 0x1 linked
// Checksum 0x48935066, Offset: 0x1628
// Size: 0x20
function codecallback_actorspawned(spawner) {
    [[ level.callbackactorspawned ]](spawner);
}

// Namespace callback
// Params f, eflags: 0x1 linked
// Checksum 0x1a0221f0, Offset: 0x1650
// Size: 0xc8
function codecallback_actordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
    [[ level.callbackactordamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal);
}

// Namespace callback
// Params 8, eflags: 0x1 linked
// Checksum 0x2ecfc077, Offset: 0x1720
// Size: 0x74
function codecallback_actorkilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, timeoffset) {
    [[ level.callbackactorkilled ]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, timeoffset);
}

// Namespace callback
// Params 1, eflags: 0x1 linked
// Checksum 0x7b9fad6f, Offset: 0x17a0
// Size: 0x20
function codecallback_actorcloned(original) {
    [[ level.callbackactorcloned ]](original);
}

// Namespace callback
// Params 1, eflags: 0x1 linked
// Checksum 0xd98ff782, Offset: 0x17c8
// Size: 0x2c
function codecallback_vehiclespawned(spawner) {
    if (isdefined(level.callbackvehiclespawned)) {
        [[ level.callbackvehiclespawned ]](spawner);
    }
}

// Namespace callback
// Params 8, eflags: 0x1 linked
// Checksum 0x33edc3ba, Offset: 0x1800
// Size: 0x74
function codecallback_vehiclekilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    [[ level.callbackvehiclekilled ]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
}

// Namespace callback
// Params f, eflags: 0x1 linked
// Checksum 0xb692cfa, Offset: 0x1880
// Size: 0xc8
function codecallback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    [[ level.callbackvehicledamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, damagefromunderneath, modelindex, partname, vsurfacenormal);
}

// Namespace callback
// Params d, eflags: 0x1 linked
// Checksum 0xed79f1cc, Offset: 0x1950
// Size: 0xb0
function codecallback_vehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, timeoffset) {
    [[ level.callbackvehicleradiusdamage ]](einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, timeoffset);
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// Checksum 0x404e990c, Offset: 0x1aa0
// Size: 0x6c
function killedcustomtraversallistener() {
    self endon(#"custom_traversal_cleanup");
    self waittill(#"death");
    if (isdefined(self)) {
        self finishtraversal();
        self stopanimscripted();
        self unlink();
    }
}

// Namespace callback
// Params 10, eflags: 0x1 linked
// Checksum 0xe2c15bc, Offset: 0x1b18
// Size: 0x1bc
function codecallback_playcustomtraversal(entity, var_db65f0f0, endparent, origin, angles, var_73e74270, animmode, playbackspeed, goaltime, lerptime) {
    entity.blockingpain = 1;
    entity.usegoalanimweight = 1;
    entity.customtraverseendnode = entity.traverseendnode;
    entity.customtraversestartnode = entity.traversestartnode;
    entity animmode("noclip", 0);
    entity orientmode("face angle", angles[1]);
    if (isdefined(endparent)) {
        offset = entity.origin - endparent.origin;
        entity linkto(endparent, "", offset);
    }
    entity animscripted("custom_traversal_anim_finished", origin, angles, var_73e74270, animmode, undefined, playbackspeed, goaltime, lerptime);
    entity thread finishcustomtraversallistener();
    entity thread killedcustomtraversallistener();
}

// Namespace callback
// Params 2, eflags: 0x0
// Checksum 0x8ede0787, Offset: 0x1ce0
// Size: 0x94
function codecallback_faceeventnotify(notify_msg, ent) {
    if (isdefined(ent) && isdefined(ent.do_face_anims) && ent.do_face_anims) {
        if (isdefined(level.face_event_handler) && isdefined(level.face_event_handler.events[notify_msg])) {
            ent sendfaceevent(level.face_event_handler.events[notify_msg]);
        }
    }
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x85c5ee2f, Offset: 0x1d80
// Size: 0xde
function codecallback_menuresponse(action, arg) {
    if (!isdefined(level.menuresponsequeue)) {
        level.menuresponsequeue = [];
        level thread menu_response_queue_pump();
    }
    index = level.menuresponsequeue.size;
    level.menuresponsequeue[index] = spawnstruct();
    level.menuresponsequeue[index].action = action;
    level.menuresponsequeue[index].arg = arg;
    level.menuresponsequeue[index].ent = self;
    level notify(#"menuresponse_queue");
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// Checksum 0x1e62d2e1, Offset: 0x1e68
// Size: 0x98
function menu_response_queue_pump() {
    while (true) {
        level waittill(#"menuresponse_queue");
        do {
            level.menuresponsequeue[0].ent notify(#"menuresponse", level.menuresponsequeue[0].action, level.menuresponsequeue[0].arg);
            arrayremoveindex(level.menuresponsequeue, 0, 0);
            wait(0.05);
        } while (level.menuresponsequeue.size > 0);
    }
}

// Namespace callback
// Params 3, eflags: 0x1 linked
// Checksum 0x542a4e23, Offset: 0x1f08
// Size: 0x5a
function codecallback_callserverscript(var_2123133d, label, param) {
    if (!isdefined(level._animnotifyfuncs)) {
        return;
    }
    if (isdefined(level._animnotifyfuncs[label])) {
        var_2123133d [[ level._animnotifyfuncs[label] ]](param);
    }
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0xb90539ac, Offset: 0x1f70
// Size: 0x52
function codecallback_callserverscriptonlevel(label, param) {
    if (!isdefined(level._animnotifyfuncs)) {
        return;
    }
    if (isdefined(level._animnotifyfuncs[label])) {
        level [[ level._animnotifyfuncs[label] ]](param);
    }
}

// Namespace callback
// Params 4, eflags: 0x1 linked
// Checksum 0xc1a0e47e, Offset: 0x1fd0
// Size: 0x94
function codecallback_launchsidemission(var_e5152480, str_gametype, var_d7bc23c2, var_c5147073) {
    switchmap_preload(var_e5152480, str_gametype, var_c5147073);
    luinotifyevent(%open_side_mission_countdown, 1, var_d7bc23c2);
    wait(10);
    luinotifyevent(%close_side_mission_countdown);
    switchmap_switch();
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x1c1e0fbb, Offset: 0x2070
// Size: 0x86
function codecallback_fadeblackscreen(duration, blendtime) {
    for (i = 0; i < level.players.size; i++) {
        if (isdefined(level.players[i])) {
            level.players[i] thread hud::fade_to_black_for_x_sec(0, duration, blendtime, blendtime);
        }
    }
}

// Namespace callback
// Params 1, eflags: 0x1 linked
// Checksum 0x3f1f9d49, Offset: 0x2100
// Size: 0x1e
function function_f39f3bec(var_4ffca9e2) {
    self notify(#"hash_ace111f5", var_4ffca9e2);
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// Checksum 0x2f23f6ef, Offset: 0x2128
// Size: 0x1a4
function abort_level() {
    /#
        println("CP_ALL_DECORATIONS");
    #/
    level.callbackstartgametype = &callback_void;
    level.callbackplayerconnect = &callback_void;
    level.callbackplayerdisconnect = &callback_void;
    level.callbackplayerdamage = &callback_void;
    level.callbackplayerkilled = &callback_void;
    level.callbackplayerlaststand = &callback_void;
    level.callbackplayermelee = &callback_void;
    level.callbackactordamage = &callback_void;
    level.callbackactorkilled = &callback_void;
    level.callbackvehicledamage = &callback_void;
    level.callbackvehiclekilled = &callback_void;
    level.callbackactorspawned = &callback_void;
    level.callbackbotentereduseredge = &callback_void;
    if (isdefined(level._gametype_default)) {
        setdvar("g_gametype", level._gametype_default);
    }
    exitlevel(0);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x7e7088b0, Offset: 0x22d8
// Size: 0x2a
function codecallback_glasssmash(pos, dir) {
    level notify(#"glass_smash", pos, dir);
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x3eb81165, Offset: 0x2310
// Size: 0x2c
function codecallback_botentereduseredge(startnode, endnode) {
    [[ level.callbackbotentereduseredge ]](startnode, endnode);
}

// Namespace callback
// Params 1, eflags: 0x1 linked
// Checksum 0x23be3dea, Offset: 0x2348
// Size: 0xd0
function codecallback_decoration(name) {
    a_decorations = self getdecorations(1);
    if (!isdefined(a_decorations)) {
        return;
    }
    if (a_decorations.size == 12) {
        self notify(#"hash_52c9c74a", "CP_ALL_DECORATIONS");
    }
    var_be5507da = self getdecorations();
    if (a_decorations.size == var_be5507da.size - 1) {
        self givedecoration("cp_medal_all_decorations");
    }
    level notify(#"decoration_awarded");
    [[ level.callbackdecorationawarded ]]();
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x2420
// Size: 0x4
function callback_void() {
    
}

