#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;

#namespace zm_ai_faller;

// Namespace zm_ai_faller
// Params 0, eflags: 0x2
// Checksum 0x13fa66b9, Offset: 0x578
// Size: 0x64
function autoexec init() {
    function_42a584ba();
    animationstatenetwork::registernotetrackhandlerfunction("faller_melee", &handle_fall_notetracks);
    animationstatenetwork::registernotetrackhandlerfunction("deathout", &function_ed7cd46d);
}

// Namespace zm_ai_faller
// Params 0, eflags: 0x4
// Checksum 0xf8cc7c68, Offset: 0x5e8
// Size: 0x124
function private function_42a584ba() {
    behaviortreenetworkutility::registerbehaviortreeaction("fallerDropAction", &fallerDropAction, &function_c8069639, &function_847e3d27);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldFallerDrop", &shouldFallerDrop);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isFallerInCeiling", &isFallerInCeiling);
    behaviortreenetworkutility::registerbehaviortreescriptapi("fallerCeilingDeath", &fallerCeilingDeath);
    animationstatenetwork::registeranimationmocomp("mocomp_drop@faller", &function_dcaa5c5d, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_ceiling_death@faller", &function_1cdd0ab1, undefined, undefined);
}

// Namespace zm_ai_faller
// Params 2, eflags: 0x0
// Checksum 0xca56724b, Offset: 0x718
// Size: 0x30
function fallerDropAction(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    return 5;
}

// Namespace zm_ai_faller
// Params 2, eflags: 0x0
// Checksum 0xa4416119, Offset: 0x750
// Size: 0x74
function function_c8069639(entity, asmstatename) {
    ground_pos = zm_utility::groundpos_ignore_water_new(entity.origin);
    if (entity.origin[2] - ground_pos[2] < 20) {
        return 4;
    }
    return 5;
}

// Namespace zm_ai_faller
// Params 2, eflags: 0x0
// Checksum 0xaa4040c8, Offset: 0x7d0
// Size: 0x28
function function_847e3d27(entity, asmstatename) {
    entity.var_d6136365 = 0;
    return 4;
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0xe233545e, Offset: 0x800
// Size: 0x3a
function shouldFallerDrop(entity) {
    if (isdefined(entity.var_d6136365) && entity.var_d6136365) {
        return true;
    }
    return false;
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0x513c4537, Offset: 0x848
// Size: 0x60
function isFallerInCeiling(entity) {
    if (isdefined(entity.in_the_ceiling) && entity.in_the_ceiling && !(isdefined(entity.var_957e7a97) && entity.var_957e7a97)) {
        return true;
    }
    return false;
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0x61f297d1, Offset: 0x8b0
// Size: 0xc
function fallerCeilingDeath(entity) {
    
}

// Namespace zm_ai_faller
// Params 5, eflags: 0x4
// Checksum 0xa7cbe30, Offset: 0x8c8
// Size: 0x4c
function private function_dcaa5c5d(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("nogravity", 0);
}

// Namespace zm_ai_faller
// Params 5, eflags: 0x4
// Checksum 0x3da83c5c, Offset: 0x920
// Size: 0x4c
function private function_1cdd0ab1(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("noclip", 0);
}

// Namespace zm_ai_faller
// Params 0, eflags: 0x0
// Checksum 0x3ce509a6, Offset: 0x978
// Size: 0x64
function zombie_faller_delete() {
    level.zombie_total++;
    self zombie_utility::reset_attack_spot();
    if (isdefined(self.zombie_faller_location)) {
        self.zombie_faller_location.is_enabled = 1;
        self.zombie_faller_location = undefined;
    }
    self delete();
}

// Namespace zm_ai_faller
// Params 0, eflags: 0x0
// Checksum 0x67a401f2, Offset: 0x9e8
// Size: 0x112
function faller_script_parameters() {
    if (isdefined(self.script_parameters)) {
        parms = strtok(self.script_parameters, ";");
        if (isdefined(parms) && parms.size > 0) {
            for (i = 0; i < parms.size; i++) {
                if (parms[i] == "drop_now") {
                    self.drop_now = 1;
                }
                if (parms[i] == "drop_not_occupied") {
                    self.drop_not_occupied = 1;
                }
                if (parms[i] == "emerge_top") {
                    self.emerge_top = 1;
                }
                if (parms[i] == "emerge_bottom") {
                    self.emerge_bottom = 1;
                }
            }
        }
    }
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0x3ad4a001, Offset: 0xb08
// Size: 0x9c
function setup_deathfunc(func_name) {
    self endon(#"death");
    while (!(isdefined(self.zombie_init_done) && self.zombie_init_done)) {
        util::wait_network_frame();
    }
    if (isdefined(func_name)) {
        self.deathfunction = func_name;
        return;
    }
    if (isdefined(level.custom_faller_death)) {
        self.deathfunction = level.custom_faller_death;
        return;
    }
    self.deathfunction = &zombie_fall_death_func;
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0x9ca4d436, Offset: 0xbb0
// Size: 0x4ba
function do_zombie_fall(spot) {
    self endon(#"death");
    if (!(isdefined(level.var_11b27d68) && level.var_11b27d68)) {
        level.var_11b27d68 = 1;
        var_c3b8a871 = self animmappingsearch(istring("anim_faller_emerge"));
        level.var_5049e503 = getanimlength(var_c3b8a871);
        var_c3b8a871 = self animmappingsearch(istring("anim_faller_attack_01"));
        level.var_92638fcc = getanimlength(var_c3b8a871);
        var_c3b8a871 = self animmappingsearch(istring("anim_faller_attack_02"));
        level.var_a98bc3d1 = getanimlength(var_c3b8a871);
        var_c3b8a871 = self animmappingsearch(istring("anim_faller_fall"));
        level.var_c16b47b3 = getanimlength(var_c3b8a871);
    }
    self.zombie_faller_location = spot;
    self.zombie_faller_location.is_enabled = 0;
    self.zombie_faller_location faller_script_parameters();
    if (isdefined(self.zombie_faller_location.emerge_top) && (isdefined(self.zombie_faller_location.emerge_bottom) && self.zombie_faller_location.emerge_bottom || self.zombie_faller_location.emerge_top)) {
        self do_zombie_emerge(spot);
        return;
    }
    self thread setup_deathfunc();
    self.no_powerups = 1;
    self.in_the_ceiling = 1;
    self.anchor = spawn("script_origin", self.origin);
    self.anchor.angles = self.angles;
    self linkto(self.anchor);
    if (!isdefined(spot.angles)) {
        spot.angles = (0, 0, 0);
    }
    anim_org = spot.origin;
    anim_ang = spot.angles;
    self ghost();
    self.anchor moveto(anim_org, 0.05);
    self.anchor waittill(#"movedone");
    target_org = zombie_utility::get_desired_origin();
    if (isdefined(target_org)) {
        anim_ang = vectortoangles(target_org - self.origin);
        self.anchor rotateto((0, anim_ang[1], 0), 0.05);
        self.anchor waittill(#"rotatedone");
    }
    self unlink();
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    self thread zombie_utility::hide_pop();
    self thread zombie_fall_death(spot);
    self thread zombie_fall_fx(spot);
    self thread zombie_faller_death_wait();
    self thread zombie_faller_do_fall();
    self.no_powerups = 0;
    self notify(#"risen", spot.script_string);
}

// Namespace zm_ai_faller
// Params 0, eflags: 0x0
// Checksum 0x1fd59106, Offset: 0x1078
// Size: 0x470
function zombie_faller_do_fall() {
    self endon(#"death");
    self animscripted("fall_anim", self.origin, self.zombie_faller_location.angles, "ai_zm_dlc5_zombie_ceiling_emerge_01");
    wait level.var_5049e503;
    self.zombie_faller_wait_start = gettime();
    self.zombie_faller_should_drop = 0;
    self thread zombie_fall_wait();
    self thread zombie_faller_watch_all_players();
    while (!self.zombie_faller_should_drop) {
        if (self zombie_fall_should_attack(self.zombie_faller_location)) {
            if (math::cointoss()) {
                self animscripted("fall_anim", self.origin, self.zombie_faller_location.angles, "ai_zm_dlc5_zombie_ceiling_attack_01");
                wait level.var_92638fcc;
            } else {
                self animscripted("fall_anim", self.origin, self.zombie_faller_location.angles, "ai_zm_dlc5_zombie_ceiling_attack_02");
                wait level.var_a98bc3d1;
            }
            if (!self zombie_faller_always_drop() && randomfloat(1) > 0.5) {
                self.zombie_faller_should_drop = 1;
            }
            continue;
        }
        if (self zombie_faller_always_drop()) {
            self.zombie_faller_should_drop = 1;
            break;
        }
        if (gettime() >= self.zombie_faller_wait_start + 20000) {
            self.zombie_faller_should_drop = 1;
            break;
        }
        if (self zombie_faller_drop_not_occupied()) {
            self.zombie_faller_should_drop = 1;
            break;
        }
        if (math::cointoss()) {
            self animscripted("fall_anim", self.origin, self.zombie_faller_location.angles, "ai_zm_dlc5_zombie_ceiling_attack_01");
            wait level.var_92638fcc;
            continue;
        }
        self animscripted("fall_anim", self.origin, self.zombie_faller_location.angles, "ai_zm_dlc5_zombie_ceiling_attack_02");
        wait level.var_a98bc3d1;
    }
    self notify(#"falling");
    spot = self.zombie_faller_location;
    self zombie_faller_enable_location();
    self animscripted("fall_anim", self.origin, spot.angles, "ai_zm_dlc5_zombie_ceiling_dropdown_01");
    wait level.var_c16b47b3;
    self.deathfunction = &zm_spawner::zombie_death_animscript;
    self.var_957e7a97 = 1;
    self notify(#"fall_anim_finished");
    spot notify(#"stop_zombie_fall_fx");
    self stopanimscripted();
    landanimdelta = 15;
    ground_pos = zm_utility::groundpos_ignore_water_new(self.origin);
    physdist = self.origin[2] - ground_pos[2] + landanimdelta;
    if (physdist > 0) {
        self.var_d6136365 = 1;
        self waittill(#"zombie_land_done");
    }
    self.in_the_ceiling = 0;
    self traversemode("gravity");
    self.no_powerups = 0;
}

// Namespace zm_ai_faller
// Params 0, eflags: 0x0
// Checksum 0xc94dd61a, Offset: 0x14f0
// Size: 0x98
function zombie_fall_loop() {
    self endon(#"death");
    self setanimstatefromasd("zm_faller_fall_loop");
    while (true) {
        ground_pos = zm_utility::groundpos_ignore_water_new(self.origin);
        if (self.origin[2] - ground_pos[2] < 20) {
            self notify(#"faller_on_ground");
            break;
        }
        wait 0.05;
    }
}

// Namespace zm_ai_faller
// Params 0, eflags: 0x0
// Checksum 0x75137165, Offset: 0x1590
// Size: 0x4a
function zombie_land() {
    self setanimstatefromasd("zm_faller_land");
    zombie_shared::donotetracks("land_anim");
    self notify(#"zombie_land_done");
}

// Namespace zm_ai_faller
// Params 0, eflags: 0x0
// Checksum 0xb5405e42, Offset: 0x15e8
// Size: 0x32
function zombie_faller_always_drop() {
    if (isdefined(self.zombie_faller_location.drop_now) && self.zombie_faller_location.drop_now) {
        return true;
    }
    return false;
}

// Namespace zm_ai_faller
// Params 0, eflags: 0x0
// Checksum 0x4cbf7802, Offset: 0x1628
// Size: 0x70
function zombie_faller_drop_not_occupied() {
    if (isdefined(self.zombie_faller_location.drop_not_occupied) && self.zombie_faller_location.drop_not_occupied) {
        if (isdefined(self.zone_name) && isdefined(level.zones[self.zone_name])) {
            return !level.zones[self.zone_name].is_occupied;
        }
    }
    return false;
}

// Namespace zm_ai_faller
// Params 0, eflags: 0x0
// Checksum 0x7ad7e060, Offset: 0x16a0
// Size: 0x66
function zombie_faller_watch_all_players() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        self thread zombie_faller_watch_player(players[i]);
    }
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0xd09be2a, Offset: 0x1710
// Size: 0x298
function zombie_faller_watch_player(player) {
    self endon(#"falling");
    self endon(#"death");
    player endon(#"disconnect");
    range = -56;
    rangesqr = range * range;
    timer = 5000;
    inrange = 0;
    inrangetime = 0;
    closerange = 60;
    closerangesqr = closerange * closerange;
    dirtoplayerenter = (0, 0, 0);
    incloserange = 0;
    while (true) {
        distsqr = distance2dsquared(self.origin, player.origin);
        if (distsqr < rangesqr) {
            if (inrange) {
                if (inrangetime + timer < gettime()) {
                    self.zombie_faller_should_drop = 1;
                    break;
                }
            } else {
                inrange = 1;
                inrangetime = gettime();
            }
        } else {
            inrange = 0;
        }
        if (distsqr < closerangesqr) {
            if (!incloserange) {
                dirtoplayerenter = player.origin - self.origin;
                dirtoplayerenter = (dirtoplayerenter[0], dirtoplayerenter[1], 0);
                dirtoplayerenter = vectornormalize(dirtoplayerenter);
            }
            incloserange = 1;
        } else {
            if (incloserange) {
                dirtoplayerexit = player.origin - self.origin;
                dirtoplayerexit = (dirtoplayerexit[0], dirtoplayerexit[1], 0);
                dirtoplayerexit = vectornormalize(dirtoplayerexit);
                if (vectordot(dirtoplayerenter, dirtoplayerexit) < 0) {
                    self.zombie_faller_should_drop = 1;
                    break;
                }
            }
            incloserange = 0;
        }
        wait 0.1;
    }
}

// Namespace zm_ai_faller
// Params 0, eflags: 0x0
// Checksum 0x1920c2c8, Offset: 0x19b0
// Size: 0x104
function zombie_fall_wait() {
    self endon(#"falling");
    self endon(#"death");
    if (isdefined(self.zone_name)) {
        if (isdefined(level.zones) && isdefined(level.zones[self.zone_name])) {
            zone = level.zones[self.zone_name];
            while (true) {
                if (!zone.is_enabled || !zone.is_active) {
                    if (!self potentially_visible(2250000)) {
                        if (self.health != level.zombie_health) {
                            self.zombie_faller_should_drop = 1;
                            break;
                        } else {
                            self zombie_faller_delete();
                            return;
                        }
                    }
                }
                wait 0.5;
            }
        }
    }
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0xde7b74d6, Offset: 0x1ac0
// Size: 0x3a
function zombie_fall_should_attack(spot) {
    victims = zombie_fall_get_vicitims(spot);
    return victims.size > 0;
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0xe7bc0dac, Offset: 0x1b08
// Size: 0x1ae
function zombie_fall_get_vicitims(spot) {
    ret = [];
    players = getplayers();
    checkdist2 = 40;
    checkdist2 *= checkdist2;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (player laststand::player_is_in_laststand()) {
            continue;
        }
        stance = player getstance();
        if (stance == "crouch" || stance == "prone") {
            continue;
        }
        zcheck = self.origin[2] - player.origin[2];
        if (zcheck < 0 || zcheck > 120) {
            continue;
        }
        dist2 = distance2dsquared(player.origin, self.origin);
        if (dist2 < checkdist2) {
            ret[ret.size] = player;
        }
    }
    return ret;
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0x73a5a7ea, Offset: 0x1cc0
// Size: 0x26
function get_fall_anim(spot) {
    return level._zombie_fall_anims[self.animname]["fall"];
}

// Namespace zm_ai_faller
// Params 0, eflags: 0x0
// Checksum 0xb23e972, Offset: 0x1cf0
// Size: 0x2e
function zombie_faller_enable_location() {
    if (isdefined(self.zombie_faller_location)) {
        self.zombie_faller_location.is_enabled = 1;
        self.zombie_faller_location = undefined;
    }
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0x3274533, Offset: 0x1d28
// Size: 0x4c
function zombie_faller_death_wait(endon_notify) {
    self endon(#"falling");
    if (isdefined(endon_notify)) {
        self endon(endon_notify);
    }
    self waittill(#"death");
    self zombie_faller_enable_location();
}

// Namespace zm_ai_faller
// Params 8, eflags: 0x0
// Checksum 0x8c496c28, Offset: 0x1d80
// Size: 0x8a
function zombie_fall_death_func(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    self animmode("noclip");
    self.deathanim = "zm_faller_emerge_death";
    return self zm_spawner::zombie_death_animscript();
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0xe99c5569, Offset: 0x1e18
// Size: 0x9c
function zombie_fall_death(spot) {
    self endon(#"fall_anim_finished");
    while (self.health > 1) {
        self waittill(#"damage", amount, attacker, dir, p, type);
    }
    self stopanimscripted();
    spot notify(#"stop_zombie_fall_fx");
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0x2e4df493, Offset: 0x1ec0
// Size: 0xc4
function _damage_mod_to_damage_type(type) {
    toks = strtok(type, "_");
    if (toks.size < 2) {
        return type;
    }
    returnstr = toks[1];
    for (i = 2; i < toks.size; i++) {
        returnstr += toks[i];
    }
    returnstr = tolower(returnstr);
    return returnstr;
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0x261fdf1a, Offset: 0x1f90
// Size: 0x9e
function zombie_fall_fx(spot) {
    spot thread zombie_fall_dust_fx(self);
    spot thread zombie_fall_burst_fx();
    playsoundatposition("zmb_zombie_spawn", spot.origin);
    self endon(#"death");
    spot endon(#"stop_zombie_fall_fx");
    wait 1;
    if (self.zombie_move_speed != "sprint") {
        wait 1;
    }
}

// Namespace zm_ai_faller
// Params 0, eflags: 0x0
// Checksum 0xda8a2ce2, Offset: 0x2038
// Size: 0xec
function zombie_fall_burst_fx() {
    self endon(#"stop_zombie_fall_fx");
    self endon(#"fall_anim_finished");
    playfx(level._effect["rise_burst"], self.origin + (0, 0, randomintrange(5, 10)));
    wait 0.25;
    playfx(level._effect["rise_billow"], self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0x369db453, Offset: 0x2130
// Size: 0xce
function zombie_fall_dust_fx(zombie) {
    dust_tag = "J_SpineUpper";
    self endon(#"stop_zombie_fall_dust_fx");
    self thread stop_zombie_fall_dust_fx(zombie);
    dust_time = 4.5;
    dust_interval = 0.3;
    for (t = 0; t < dust_time; t += dust_interval) {
        playfxontag(level._effect["rise_dust"], zombie, dust_tag);
        wait dust_interval;
    }
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0x3e2cbd5e, Offset: 0x2208
// Size: 0x26
function stop_zombie_fall_dust_fx(zombie) {
    zombie waittill(#"death");
    self notify(#"stop_zombie_fall_dust_fx");
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0x42acdb67, Offset: 0x2238
// Size: 0x18
function function_ed7cd46d(entity) {
    self.in_the_ceiling = 0;
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0x68d7655f, Offset: 0x2258
// Size: 0xc2
function handle_fall_notetracks(entity) {
    victims = zombie_fall_get_vicitims(entity.zombie_faller_location);
    for (i = 0; i < victims.size; i++) {
        victims[i] dodamage(entity.meleedamage, entity.origin, self, self, "none", "MOD_MELEE");
        entity.zombie_faller_should_drop = 1;
    }
}

// Namespace zm_ai_faller
// Params 8, eflags: 0x0
// Checksum 0xf3e64135, Offset: 0x2328
// Size: 0x8a
function faller_death_ragdoll(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    self startragdoll();
    self launchragdoll((0, 0, -1));
    return self zm_spawner::zombie_death_animscript();
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0x3f7fcf10, Offset: 0x23c0
// Size: 0x1c0
function in_player_fov(player) {
    playerangles = player getplayerangles();
    playerforwardvec = anglestoforward(playerangles);
    playerunitforwardvec = vectornormalize(playerforwardvec);
    banzaipos = self.origin;
    playerpos = player getorigin();
    playertobanzaivec = banzaipos - playerpos;
    playertobanzaiunitvec = vectornormalize(playertobanzaivec);
    forwarddotbanzai = vectordot(playerunitforwardvec, playertobanzaiunitvec);
    anglefromcenter = acos(forwarddotbanzai);
    playerfov = getdvarfloat("cg_fov");
    banzaivsplayerfovbuffer = getdvarfloat("g_banzai_player_fov_buffer");
    if (banzaivsplayerfovbuffer <= 0) {
        banzaivsplayerfovbuffer = 0.2;
    }
    inplayerfov = anglefromcenter <= playerfov * 0.5 * (1 - banzaivsplayerfovbuffer);
    return inplayerfov;
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0x57e9a328, Offset: 0x2588
// Size: 0x104
function potentially_visible(how_close) {
    if (!isdefined(how_close)) {
        how_close = 1000000;
    }
    potentiallyvisible = 0;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        dist = distancesquared(self.origin, players[i].origin);
        if (dist < how_close) {
            inplayerfov = self in_player_fov(players[i]);
            if (inplayerfov) {
                potentiallyvisible = 1;
                break;
            }
        }
    }
    return potentiallyvisible;
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0xb9414a6, Offset: 0x2698
// Size: 0x134
function do_zombie_emerge(spot) {
    self endon(#"death");
    self thread setup_deathfunc(&faller_death_ragdoll);
    self.no_powerups = 1;
    self.in_the_ceiling = 1;
    anim_org = spot.origin;
    anim_ang = spot.angles;
    self thread zombie_emerge_fx(spot);
    self thread zombie_faller_death_wait("risen");
    if (isdefined(level.custom_faller_entrance_logic)) {
        self thread [[ level.custom_faller_entrance_logic ]]();
    }
    self zombie_faller_emerge(spot);
    self.create_eyes = 1;
    wait 0.1;
    self notify(#"risen", spot.script_string);
    self zombie_faller_enable_location();
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0xe181ae95, Offset: 0x27d8
// Size: 0x11c
function zombie_faller_emerge(spot) {
    self endon(#"death");
    if (isdefined(self.zombie_faller_location.emerge_bottom) && self.zombie_faller_location.emerge_bottom) {
        self animscripted("fall_anim", self.zombie_faller_location.origin, self.zombie_faller_location.angles, "zombie_riser_elevator_from_floor");
    } else {
        self animscripted("fall_anim", self.zombie_faller_location.origin, self.zombie_faller_location.angles, "zombie_riser_elevator_from_ceiling");
    }
    self zombie_shared::donotetracks("rise_anim");
    self.deathfunction = &zm_spawner::zombie_death_animscript;
    self.in_the_ceiling = 0;
    self.no_powerups = 0;
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0x56f15670, Offset: 0x2900
// Size: 0x6a
function zombie_emerge_fx(spot) {
    spot thread zombie_emerge_dust_fx(self);
    playsoundatposition("zmb_zombie_spawn", spot.origin);
    self endon(#"death");
    spot endon(#"stop_zombie_fall_fx");
    wait 1;
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0x66e0bade, Offset: 0x2978
// Size: 0xce
function zombie_emerge_dust_fx(zombie) {
    dust_tag = "J_SpineUpper";
    self endon(#"stop_zombie_fall_dust_fx");
    self thread stop_zombie_fall_dust_fx(zombie);
    dust_time = 3.5;
    dust_interval = 0.5;
    for (t = 0; t < dust_time; t += dust_interval) {
        playfxontag(level._effect["rise_dust"], zombie, dust_tag);
        wait dust_interval;
    }
}

// Namespace zm_ai_faller
// Params 1, eflags: 0x0
// Checksum 0xe0dcd8a0, Offset: 0x2a50
// Size: 0x26
function stop_zombie_emerge_dust_fx(zombie) {
    zombie waittill(#"death");
    self notify(#"stop_zombie_fall_dust_fx");
}

