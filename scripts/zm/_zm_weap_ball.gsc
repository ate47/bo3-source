#using scripts/zm/_zm_hero_weapon;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_util;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/_oob;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/systems/gib;
#using scripts/codescripts/struct;

#namespace ball;

// Namespace ball
// Params 0, eflags: 0x2
// Checksum 0x3cfcec76, Offset: 0x880
// Size: 0x3c
function function_2dc19561() {
    system::register("ball", &__init__, &__main__, undefined);
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x8886b071, Offset: 0x8c8
// Size: 0x1d4
function __init__() {
    clientfield::register("allplayers", "ballcarrier", 15000, 1, "int");
    clientfield::register("allplayers", "passoption", 15000, 1, "int");
    clientfield::register("world", "ball_away", 15000, 1, "int");
    clientfield::register("world", "ball_score_allies", 15000, 1, "int");
    clientfield::register("world", "ball_score_axis", 15000, 1, "int");
    clientfield::register("scriptmover", "ball_on_ground_fx", 15000, 1, "int");
    level.ballweapon = getweapon("ball");
    level.var_d566bdba = getweapon("ball_world");
    level.var_aff3334d = getweapon("ball_world_pass");
    level._grab_minigun = &function_18041b1b;
    zm_hero_weapon::function_d29010f8("ball");
    zm::register_zombie_damage_override_callback(&function_f1b94849);
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0xa3e3beb3, Offset: 0xaa8
// Size: 0x2c
function function_18041b1b(player) {
    player function_257ed160(player, 0);
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0x7ffd82ea, Offset: 0xae0
// Size: 0x18
function function_797c5146(weapon) {
    return weapon == level.var_d566bdba;
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0x6ec218ad, Offset: 0xb00
// Size: 0x18
function function_3652dc9c(weapon) {
    return weapon == level.ballweapon;
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0xc43d0c8b, Offset: 0xb20
// Size: 0x31e
function function_c004c2bd() {
    playfx("dlc4/genesis/fx_weapon_key_throw_impact", self.origin);
    playsoundatposition("wpn_summoning_key_impact", self.origin);
    zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, -106);
    if (!isdefined(zombies)) {
        return;
    }
    dist_sq = -106 * -106;
    var_c8f67e5c = [];
    for (i = 0; i < zombies.size; i++) {
        if (isdefined(zombies[i].ignore_nuke) && zombies[i].ignore_nuke) {
            continue;
        }
        if (isdefined(zombies[i].marked_for_death) && zombies[i].marked_for_death) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
            continue;
        }
        zombies[i].marked_for_death = 1;
        if (isvehicle(zombies[i])) {
            zombies[i] clientfield::increment("zm_bgb_burned_out" + "_fire_torso" + "_vehicle");
        } else {
            zombies[i] clientfield::increment("zm_bgb_burned_out" + "_fire_torso" + "_actor");
        }
        var_c8f67e5c[var_c8f67e5c.size] = zombies[i];
    }
    for (i = 0; i < var_c8f67e5c.size; i++) {
        util::wait_network_frame();
        if (!isdefined(var_c8f67e5c[i])) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(var_c8f67e5c[i])) {
            continue;
        }
        if (!(isdefined(var_c8f67e5c[i].exclude_cleanup_adding_to_total) && var_c8f67e5c[i].exclude_cleanup_adding_to_total)) {
            level.zombie_total++;
        }
        var_c8f67e5c[i] dodamage(var_c8f67e5c[i].health + 666, var_c8f67e5c[i].origin);
    }
}

// Namespace ball
// Params 13, eflags: 0x1 linked
// Checksum 0xf42efbab, Offset: 0xe48
// Size: 0x1f4
function function_f1b94849(willbekilled, inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (function_797c5146(weapon) && isdefined(self.var_c732138b)) {
        return self [[ self.var_c732138b ]]();
    }
    if (self.archetype === "mechz" || self.archetype === "margwa") {
        return 0;
    }
    if (self function_797c5146(weapon)) {
        launchvector = vectorscale(vdir, 0.1);
        self thread zm_spawner::zombie_ragdoll_then_explode(launchvector, attacker);
        self thread function_c004c2bd();
        playfxontag("dlc4/genesis/fx_weapon_key_impact_fire_torso_zmb", self, "j_spine4");
        return 1;
    } else if (self function_3652dc9c(weapon)) {
        if (!(isdefined(self.exclude_cleanup_adding_to_total) && self.exclude_cleanup_adding_to_total)) {
            level.zombie_total++;
        }
        playfxontag("dlc4/genesis/fx_weapon_key_impact_fire_torso_zmb", self, "j_spine4");
        self dodamage(self.health + 666, self.origin);
        return 1;
    }
    return 0;
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x615ad18, Offset: 0x1048
// Size: 0x44
function __main__() {
    callback::on_connect(&function_cffd1019);
    level.var_4f928387 = undefined;
    level.ball = undefined;
    level.objectivepingdelay = 1;
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0xf3bd672c, Offset: 0x1098
// Size: 0x3c
function function_cffd1019() {
    self flag::init("has_ball");
    self thread function_804453f1();
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x330a59f0, Offset: 0x10e0
// Size: 0x74
function function_804453f1() {
    self endon(#"disconnect");
    self flag::wait_till("has_ball");
    self thread ball_pass_watch();
    self thread ball_shoot_watch();
    self thread ball_weapon_change_watch();
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x819a5384, Offset: 0x1160
// Size: 0x68
function function_481ef46f() {
    if (isdefined(level.ball)) {
        if (isdefined(level.ball.carrier)) {
            return;
        }
        if (isdefined(level.ball.projectile)) {
            if (!level.ball.projectile isonground()) {
                return level.ball;
            }
        }
    }
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x11ff7059, Offset: 0x11d8
// Size: 0x8a
function function_4dbb4a6a() {
    self endon(#"reset");
    self endon(#"pickup_object");
    if (isdefined(self.projectile)) {
        if (self.projectile isonground()) {
            return;
        }
        self.projectile endon(#"death");
        self.projectile endon(#"stationary");
        self.projectile endon(#"grenade_bounce");
        while (true) {
            wait(1);
        }
    }
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0xd17cca66, Offset: 0x1270
// Size: 0x30
function function_6dd12da4() {
    self endon(#"disconnect");
    self waittill(#"spawned");
    if (self.sessionstate == "playing") {
    }
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x4ae72b98, Offset: 0x12a8
// Size: 0xdc
function function_83143ec0() {
    ball = function_481ef46f();
    if (isdefined(ball)) {
        level notify(#"game_ended");
        foreach (player in level.players) {
            player thread function_6dd12da4();
        }
        ball function_4dbb4a6a();
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xe7221575, Offset: 0x1390
// Size: 0x14
function function_25dd17ea() {
    function_83143ec0();
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xfa31ede2, Offset: 0x13b0
// Size: 0x15c
function function_972a6af9() {
    function_83143ec0();
    winner = undefined;
    if (level.teambased) {
        foreach (team in level.teams) {
            if (game["teamSuddenDeath"][team]) {
                winner = team;
                break;
            }
        }
        if (isdefined(winner)) {
        }
    } else {
        /#
            if (isdefined(winner)) {
                print("ball_score_axis" + winner.name);
            } else {
                print("ball_score_axis");
            }
        #/
    }
    setdvar("ui_text_endreason", game["strings"]["time_limit_reached"]);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x133d2fcd, Offset: 0x1518
// Size: 0x5c
function onspawnplayer(predictedspawn) {
    self.var_1821be2 = 0;
    self.var_bbc60d50 = undefined;
    self clientfield::set("ctf_flag_carrier", 0);
    self thread function_67cb1206();
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x79f4010a, Offset: 0x1580
// Size: 0x148
function function_67cb1206() {
    self endon(#"death");
    self endon(#"delete");
    player = self;
    ball = getweapon("ball");
    while (true) {
        if (isdefined(ball) && player hasweapon(ball)) {
            curweapon = player getcurrentweapon();
            if (isdefined(curweapon) && curweapon != ball) {
                if (curweapon.isheroweapon) {
                    slot = self gadgetgetslot(curweapon);
                }
                player switchtoweaponimmediate(ball);
                player disableweaponcycling();
                player disableoffhandweapons();
            }
        }
        wait(0.05);
    }
}

// Namespace ball
// Params 9, eflags: 0x0
// Checksum 0x687fb336, Offset: 0x16d0
// Size: 0x1f0
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (isdefined(self.carryobject)) {
    } else if (isdefined(attacker.carryobject) && attacker.team != self.team) {
    }
    if (isdefined(level.ball)) {
        ballcarrier = level.ball.carrier;
        if (isdefined(ballcarrier)) {
            var_bf7df05c = level.ball.carrier.origin;
            iscarried = 1;
        } else {
            var_bf7df05c = level.ball.curorigin;
            iscarried = 0;
        }
        if (iscarried && isdefined(attacker) && isdefined(attacker.team) && attacker != self && ballcarrier != attacker) {
            if (attacker.team == level.ball.carrier.team) {
                dist = distance2dsquared(self.origin, var_bf7df05c);
                if (dist < level.defaultoffenseradiussq) {
                    attacker addplayerstat("defend_carrier", 1);
                    return;
                }
            }
        }
    }
    victim = self;
}

// Namespace ball
// Params 6, eflags: 0x0
// Checksum 0x2b685efc, Offset: 0x18c8
// Size: 0x154
function function_6be95ac8(startpos, startangles, index, count, defaultdistance, rotation) {
    currentangle = startangles[1] + 360 / count * 0.5 + 360 / count * index;
    coscurrent = cos(currentangle + rotation);
    sincurrent = sin(currentangle + rotation);
    new_position = startpos + (defaultdistance * coscurrent, defaultdistance * sincurrent, 0);
    clip_mask = 1 | 8;
    trace = physicstrace(startpos, new_position, (-5, -5, -5), (5, 5, 5), self, clip_mask);
    return trace["position"];
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0x69580572, Offset: 0x1a28
// Size: 0x11c
function function_b4352e6c(player) {
    direction = player getplayerangles();
    direction_vec = anglestoforward(direction);
    eye = player geteye();
    scale = 8000;
    direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
    trace = bullettrace(eye, eye + direction_vec, 0, undefined);
    var_a1c100ee = trace["position"];
    function_4bff2a85(var_a1c100ee);
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0x9835a869, Offset: 0x1b50
// Size: 0x7c
function function_7eb07bb0(player) {
    if (!isdefined(player) || !isdefined(player.carryobject)) {
        return;
    }
    var_e870556 = player.carryobject;
    function_257ed160(player, 0);
    var_e870556 function_a41df27c();
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x4bccbdab, Offset: 0x1bd8
// Size: 0xf6
function function_a41df27c() {
    self notify(#"reset");
    visual = self.visuals[0];
    linkedparent = visual getlinkedent();
    if (isdefined(linkedparent)) {
        visual unlink();
    }
    visual delete();
    if (isdefined(self.projectile)) {
        self.projectile delete();
    }
    self gameobjects::allow_carry("none");
    level.var_4f928387 delete();
    level.ball = undefined;
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0xa72152b5, Offset: 0x1cd8
// Size: 0x6c
function function_5faeea5e(player) {
    level.var_4f928387 = spawn("trigger_radius", player.origin + (0, 0, 0), 2, 50, 50);
    level.ball = function_dbf94d16(level.var_4f928387);
}

// Namespace ball
// Params 2, eflags: 0x1 linked
// Checksum 0x8bf9cfff, Offset: 0x1d50
// Size: 0x20c
function function_257ed160(player, var_501dd320) {
    if (!isdefined(player) || !isdefined(player.carryobject)) {
        return;
    }
    if (isdefined(player.carryobject.scorefrozenuntil) && player.carryobject.scorefrozenuntil > gettime()) {
        return;
    }
    player.carryobject.scorefrozenuntil = gettime() + 10000;
    ball_check_assist(player, 1);
    team = self.team;
    otherteam = util::getotherteam(team);
    if (isdefined(player.var_6221f6f)) {
        player.var_6221f6f.inuse = 0;
    }
    ball = player.carryobject;
    ball.lastcarrierscored = 1;
    player gameobjects::take_carry_weapon(ball.carryweapon);
    ball ball_set_dropped(1);
    if (var_501dd320) {
        ball thread function_db6a152e(self);
    }
    if (isdefined(player.pers["carries"])) {
        player.pers["carries"]++;
        player.carries = player.pers["carries"];
    }
    ball_give_score(otherteam, level.carryscore);
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0xb0d447ae, Offset: 0x1f68
// Size: 0x5c
function function_4bff2a85(v_pos) {
    level.var_4f928387 = spawn("trigger_radius", v_pos, 2, 50, 50);
    level.ball = function_dbf94d16(level.var_4f928387);
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x20155a78, Offset: 0x1fd0
// Size: 0x1bc
function function_b22de10a(trigger, team) {
    useobj = gameobjects::create_use_object(team, trigger, [], (0, 0, trigger.height * 0.5), istring("ball_goal_" + team));
    useobj gameobjects::set_visible_team("any");
    useobj gameobjects::set_model_visibility(1);
    useobj gameobjects::allow_use("enemy");
    useobj gameobjects::set_use_time(0);
    if (isdefined(level.ball)) {
        useobj gameobjects::set_key_object(level.ball);
    }
    useobj.var_cd77875d = &function_ce3bd9c9;
    useobj.onuse = &function_3d1ee3cc;
    useobj.ball_in_goal = 0;
    useobj.radiussq = trigger.radius * trigger.radius;
    useobj.center = trigger.origin + (0, 0, trigger.height * 0.5);
    return useobj;
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0x975b8988, Offset: 0x2198
// Size: 0x14
function function_ce3bd9c9(player) {
    return !self.ball_in_goal;
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0xe9fbf82, Offset: 0x21b8
// Size: 0x2cc
function function_3d1ee3cc(player) {
    if (!isdefined(player) || !isdefined(player.carryobject)) {
        return;
    }
    if (isdefined(player.carryobject.scorefrozenuntil) && player.carryobject.scorefrozenuntil > gettime()) {
        return;
    }
    self function_85e74fc9();
    player.carryobject.scorefrozenuntil = gettime() + 10000;
    ball_check_assist(player, 1);
    team = self.team;
    otherteam = util::getotherteam(team);
    if (should_record_final_score_cam(otherteam, level.carryscore)) {
    }
    if (isdefined(player.var_6221f6f)) {
        player.var_6221f6f.inuse = 0;
    }
    ball = player.carryobject;
    ball.lastcarrierscored = 1;
    player gameobjects::take_carry_weapon(ball.carryweapon);
    ball ball_set_dropped(1);
    ball thread function_db6a152e(self);
    if (isdefined(player.pers["carries"])) {
        player.pers["carries"]++;
        player.carries = player.pers["carries"];
    }
    bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ball_capture", team, player.origin);
    player recordgameevent("capture");
    player addplayerstatwithgametype("CARRIES", 1);
    player addplayerstatwithgametype("captures", 1);
    ball_give_score(otherteam, level.carryscore);
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0xa276a0d5, Offset: 0x2490
// Size: 0x360
function function_dbf94d16(trigger) {
    visuals = [];
    visuals[0] = spawn("script_model", trigger.origin);
    visuals[0] setmodel("wpn_t7_zmb_dlc4_summoning_key_world");
    visuals[0] notsolid();
    trigger enablelinkto();
    trigger linkto(visuals[0]);
    trigger.no_moving_platfrom_unlink = 1;
    var_afffeadd = gameobjects::create_carry_object("neutral", trigger, visuals, (0, 0, 0), istring("ball_ball"), "mpl_hit_alert_ballholder");
    var_afffeadd gameobjects::allow_carry("any");
    var_afffeadd gameobjects::set_drop_offset(16);
    var_afffeadd.objectiveonvisuals = 1;
    var_afffeadd.allowweapons = 0;
    var_afffeadd.carryweapon = getweapon("ball");
    var_afffeadd.keepcarryweapon = 1;
    var_afffeadd.waterbadtrigger = 0;
    var_afffeadd.disallowremotecontrol = 1;
    var_afffeadd.disallowplaceablepickup = 1;
    var_afffeadd gameobjects::update_objective();
    var_afffeadd.canuseobject = &function_b861e1df;
    var_afffeadd.onpickup = &function_6ce143ff;
    var_afffeadd.setdropped = &ball_set_dropped;
    var_afffeadd.onreset = &function_df2611a2;
    var_afffeadd.pickuptimeoutoverride = &ball_physics_timeout;
    var_afffeadd.carryweaponthink = &function_804453f1;
    var_afffeadd.onuse = &function_756cbdda;
    var_afffeadd.in_goal = 0;
    var_afffeadd.lastcarrierscored = 0;
    var_afffeadd.lastcarrierteam = "neutral";
    if (isdefined(level.idleflagreturntime) && level.idleflagreturntime > 0) {
        var_afffeadd.autoresettime = level.idleflagreturntime;
    } else {
        var_afffeadd.autoresettime = 15;
    }
    playfxontag("ui/fx_uplink_ball_trail", var_afffeadd.visuals[0], "tag_origin");
    return var_afffeadd;
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0x41b53a29, Offset: 0x27f8
// Size: 0x24c
function function_756cbdda(player) {
    if (!isalive(player)) {
        return;
    }
    while (!zm_laststand::laststand_has_players_weapons_returned(player)) {
        wait(0.05);
    }
    if (self.type == "carryObject") {
        if (isdefined(player.carryobject)) {
            if (isdefined(player.carryobject.swappable) && player.carryobject.swappable) {
                player.carryobject thread gameobjects::set_dropped();
            } else {
                if (isdefined(self.onpickupfailed)) {
                    self [[ self.onpickupfailed ]](player);
                }
                return;
            }
        }
        player gameobjects::give_object(self);
    } else if (self.type == "packObject") {
        if (isdefined(level.max_packobjects) && level.max_packobjects <= player.packobject.size) {
            if (isdefined(self.onpickupfailed)) {
                self [[ self.onpickupfailed ]](player);
            }
            return;
        }
        player gameobjects::give_pack_object(self);
    }
    self gameobjects::set_carrier(player);
    self gameobjects::ghost_visuals();
    self.trigger.origin += (0, 0, 10000);
    self notify(#"pickup_object");
    level notify(#"po");
    if (isdefined(self.onpickup)) {
        self [[ self.onpickup ]](player);
    }
    self gameobjects::function_2158302c();
    self gameobjects::function_a45fe1cc();
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0xa835b23b, Offset: 0x2a50
// Size: 0x308
function function_b861e1df(player) {
    if (!isdefined(player)) {
        return false;
    }
    if (!self gameobjects::can_interact_with(player)) {
        return false;
    }
    if (isdefined(self.droptime) && self.droptime >= gettime()) {
        return false;
    }
    if (isdefined(player.resurrect_weapon) && player getcurrentweapon() == player.resurrect_weapon) {
        return false;
    }
    if (player iscarryingturret()) {
        return false;
    }
    currentweapon = player getcurrentweapon();
    if (isdefined(currentweapon)) {
        if (!valid_ball_pickup_weapon(currentweapon)) {
            return false;
        }
    }
    nextweapon = player.changingweapon;
    if (isdefined(nextweapon) && player isswitchingweapons()) {
        if (!valid_ball_pickup_weapon(nextweapon)) {
            return false;
        }
    }
    if (player player_no_pickup_time()) {
        return false;
    }
    ball = self.visuals[0];
    thresh = 15;
    dist2 = distance2dsquared(ball.origin, player.origin);
    if (dist2 < thresh * thresh) {
        return true;
    }
    ball = self.visuals[0];
    start = player geteye();
    end = (self.curorigin[0], self.curorigin[1], self.curorigin[2] + 5);
    if (isdefined(self.carrier) && isplayer(self.carrier)) {
        end = self.carrier geteye();
    }
    if (!sighttracepassed(end, start, 0, ball) && !sighttracepassed(end, player.origin, 0, ball)) {
        return false;
    }
    return true;
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x939d91aa, Offset: 0x2d60
// Size: 0x1a0
function function_9e348528() {
    self.isresetting = 1;
    self notify(#"reset");
    origin = self.curorigin;
    if (isdefined(self.projectile)) {
        origin = self.projectile.origin;
    }
    foreach (visual in self.visuals) {
        visual.origin = origin;
        visual.angles = visual.baseangles;
        visual dontinterpolate();
        visual show();
    }
    if (isdefined(self.projectile)) {
        self.projectile delete();
    }
    self gameobjects::clear_carrier();
    gameobjects::function_a45fe1cc();
    gameobjects::function_2158302c();
    gameobjects::update_objective();
    self.isresetting = 0;
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0x35cb1c5e, Offset: 0x2f08
// Size: 0x39c
function function_6ce143ff(player) {
    if (!isalive(player)) {
        self function_9e348528();
        return;
    }
    player disableusability();
    player disableoffhandweapons();
    level.usestartspawns = 0;
    level clientfield::set("ball_away", 1);
    self.visuals[0] clientfield::set("ball_on_ground_fx", 0);
    linkedparent = self.visuals[0] getlinkedent();
    if (isdefined(linkedparent)) {
        self.visuals[0] unlink();
    }
    player resetflashback();
    pass = 0;
    ball_velocity = 0;
    if (isdefined(self.projectile)) {
        pass = 1;
        ball_velocity = self.projectile getvelocity();
        self.projectile delete();
    }
    if (pass) {
        if (self.lastcarrierteam == player.team) {
            if (self.lastcarrier != player) {
                player.passtime = gettime();
                player.passplayer = self.lastcarrier;
            }
        } else if (length(ball_velocity) > 0.1) {
        }
    }
    otherteam = util::getotherteam(player.team);
    self.lastcarrierscored = 0;
    self.lastcarrier = player;
    self.lastcarrierteam = player.team;
    self function_74db1ec9(player.team);
    player.balldropdelay = getdvarint("scr_ball_water_drop_delay", 10);
    player.objective = 1;
    player.hasperksprintfire = player hasperk("specialty_sprintfire");
    player setperk("specialty_sprintfire");
    player clientfield::set("ballcarrier", 1);
    player thread player_update_pass_target(self);
    player recordgameevent("pickup");
    player flag::set("has_ball");
}

// Namespace ball
// Params 1, eflags: 0x5 linked
// Checksum 0x1d222c64, Offset: 0x32b0
// Size: 0xb6
function function_a472302d(team) {
    self.ownerteam = team;
    if (team != "any") {
        self.team = team;
        foreach (visual in self.visuals) {
            visual.team = team;
        }
    }
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0x23dcadea, Offset: 0x3370
// Size: 0x3c
function function_74db1ec9(team) {
    self function_a472302d(team);
    self gameobjects::update_trigger();
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x1acdd324, Offset: 0x33b8
// Size: 0x138
function ball_carrier_cleanup() {
    self function_74db1ec9("neutral");
    if (isdefined(self.carrier)) {
        self.carrier clientfield::set("ballcarrier", 0);
        self.carrier.balldropdelay = undefined;
        self.carrier.nopickuptime = gettime() + 500;
        self.carrier player_clear_pass_target();
        self.carrier notify(#"hash_bf5529ed");
        if (!self.carrier.hasperksprintfire) {
            self.carrier unsetperk("specialty_sprintfire");
        }
        self.carrier enableusability();
        self.carrier enableoffhandweapons();
        self.carrier setballpassallowed(0);
        self.carrier.objective = 0;
    }
}

// Namespace ball
// Params 2, eflags: 0x1 linked
// Checksum 0x14b8f1ee, Offset: 0x34f8
// Size: 0x150
function function_8f5b30b3(origin, angles) {
    self.isresetting = 1;
    foreach (visual in self.visuals) {
        visual.origin = origin;
        visual.angles = angles;
        visual dontinterpolate();
        visual show();
    }
    self.trigger.origin = origin;
    self.curorigin = self.trigger.origin;
    self gameobjects::clear_carrier();
    gameobjects::function_a45fe1cc();
    gameobjects::function_2158302c();
    self.isresetting = 0;
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0xb0b45124, Offset: 0x3650
// Size: 0x238
function ball_set_dropped(skip_physics) {
    if (!isdefined(skip_physics)) {
        skip_physics = 0;
    }
    self.isresetting = 1;
    self.droptime = gettime();
    self notify(#"dropped");
    dropangles = (0, 0, 0);
    carrier = self.carrier;
    if (isdefined(carrier) && carrier.team != "spectator") {
        droporigin = carrier.origin;
        dropangles = carrier.angles;
    } else {
        droporigin = self.origin;
    }
    if (!isdefined(droporigin)) {
        droporigin = self.safeorigin;
    }
    droporigin += (0, 0, 40);
    if (isdefined(self.projectile)) {
        self.projectile delete();
    }
    self ball_carrier_cleanup();
    self gameobjects::clear_carrier();
    self function_8f5b30b3(droporigin, dropangles);
    self thread gameobjects::pickup_timeout(droporigin[2], droporigin[2] - 40);
    self.isresetting = 0;
    if (!skip_physics) {
        angles = (0, dropangles[1], 0);
        forward = anglestoforward(angles);
        velocity = forward * -6 + (0, 0, 140);
        ball_physics_launch(velocity);
    }
    return true;
}

// Namespace ball
// Params 3, eflags: 0x1 linked
// Checksum 0xaca9dade, Offset: 0x3890
// Size: 0x154
function function_df2611a2(prev_origin, var_fd894ecd, var_6f3d4b2e) {
    if (!isdefined(var_fd894ecd)) {
        var_fd894ecd = 1;
    }
    if (isdefined(level.gameended) && level.gameended) {
        return;
    }
    visual = self.visuals[0];
    linkedparent = visual getlinkedent();
    if (isdefined(linkedparent)) {
        visual unlink();
    }
    if (isdefined(self.projectile)) {
        self.projectile delete();
    }
    if (!self gameobjects::get_flags(1)) {
        playfx("ui/fx_uplink_ball_vanish", prev_origin);
        self function_6dc166ee();
    }
    self.lastcarrierteam = "none";
    self thread function_7cd85c83(var_fd894ecd, var_6f3d4b2e);
}

// Namespace ball
// Params 2, eflags: 0x1 linked
// Checksum 0xee158203, Offset: 0x39f0
// Size: 0x100
function ball_return_home(var_fd894ecd, var_6f3d4b2e) {
    self.isresetting = 1;
    prev_origin = self.trigger.origin;
    self notify(#"reset");
    self gameobjects::move_visuals_to_base();
    self.trigger.origin = self.trigger.baseorigin;
    self.curorigin = self.trigger.origin;
    if (isdefined(self.onreset)) {
        self [[ self.onreset ]](prev_origin, var_fd894ecd, var_6f3d4b2e);
    }
    self gameobjects::clear_carrier();
    gameobjects::function_a45fe1cc();
    gameobjects::function_2158302c();
    self.isresetting = 0;
}

// Namespace ball
// Params 3, eflags: 0x1 linked
// Checksum 0x810cdb60, Offset: 0x3af8
// Size: 0x294
function function_98827162(var_fd894ecd, var_a987c5a2, var_6f3d4b2e) {
    if (!isdefined(var_fd894ecd)) {
        var_fd894ecd = 1;
    }
    self.visuals[0] clientfield::set("ball_on_ground_fx", 0);
    if (isdefined(var_a987c5a2)) {
        self.trigger.baseorigin = var_a987c5a2;
        foreach (visual in self.visuals) {
            visual.baseorigin = var_a987c5a2;
        }
    } else if (zm_utility::is_player_valid(self.lastcarrier)) {
        while (isdefined(self.lastcarrier.is_flung) && self.lastcarrier.is_flung) {
            wait(0.1);
        }
        if (!self.lastcarrier isonground()) {
            var_195da49c = bullettrace(self.lastcarrier.origin, self.lastcarrier.origin + (0, 0, -100000), 0, self.lastcarrier)["position"] + (0, 0, 16);
        } else {
            var_195da49c = self.lastcarrier.origin;
        }
        self.trigger.baseorigin = var_195da49c;
        foreach (visual in self.visuals) {
            visual.baseorigin = var_195da49c;
        }
    }
    self thread ball_return_home(var_fd894ecd, var_6f3d4b2e);
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0x149319cd, Offset: 0x3d98
// Size: 0x234
function function_db6a152e(goal) {
    self notify(#"score_event");
    self.in_goal = 1;
    goal.ball_in_goal = 1;
    if (isdefined(self.projectile)) {
        self.projectile delete();
    }
    self gameobjects::allow_carry("none");
    var_c3f5985e = 0.4;
    var_55f7566e = 1.2;
    rotate_time = 1;
    var_85678934 = var_c3f5985e + rotate_time;
    total_time = var_85678934 + var_55f7566e;
    visual = self.visuals[0];
    visual moveto(self.trigger.origin, var_c3f5985e, 0, var_c3f5985e);
    visual rotatevelocity((1080, 1080, 0), total_time, total_time, 0);
    wait(var_85678934);
    goal.ball_in_goal = 0;
    self.visibleteam = "neutral";
    self gameobjects::function_85576d4d("friendly", 0);
    self gameobjects::function_85576d4d("enemy", 0);
    self gameobjects::update_objective();
    visual movez(4000, var_55f7566e, var_55f7566e * 0.1, 0);
    wait(var_55f7566e);
    self thread ball_return_home();
}

// Namespace ball
// Params 2, eflags: 0x1 linked
// Checksum 0x2f148195, Offset: 0x3fd8
// Size: 0x278
function function_7cd85c83(var_fd894ecd, var_6f3d4b2e) {
    if (!isdefined(var_6f3d4b2e)) {
        var_6f3d4b2e = 0;
    }
    self endon(#"pickup_object");
    self gameobjects::allow_carry("any");
    self function_74db1ec9("neutral");
    visual = self.visuals[0];
    if (var_fd894ecd) {
        visual.origin = visual.baseorigin + (0, 0, 4000);
        visual dontinterpolate();
        fall_time = 3;
        visual moveto(visual.baseorigin, fall_time, 0, fall_time);
        visual rotatevelocity((0, 720, 0), fall_time, 0, fall_time);
        visual thread function_c2bef09f();
    }
    self.visibleteam = "any";
    self gameobjects::function_85576d4d("friendly", 1);
    self gameobjects::function_85576d4d("enemy", 1);
    if (var_fd894ecd) {
        wait(fall_time);
    }
    level clientfield::set("ball_away", 0);
    visual clientfield::set("ball_on_ground_fx", 1);
    if (!(isdefined(var_6f3d4b2e) && var_6f3d4b2e) && isdefined(level.var_1c0253f1)) {
        self thread [[ level.var_1c0253f1 ]]();
    }
    playfxontag("ui/fx_uplink_ball_trail", visual, "tag_origin");
    self thread ball_download_fx(visual, fall_time);
    self.in_goal = 0;
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x1090abd, Offset: 0x4258
// Size: 0x44
function function_c2bef09f() {
    self playloopsound("prj_ball_loop");
    level waittill(#"po");
    self stoploopsound();
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0x44e19c7f, Offset: 0x42a8
// Size: 0xe4
function function_b8faebaf(var_dbefa1ce) {
    self notify(#"reset");
    visual = self.visuals[0];
    linkedparent = visual getlinkedent();
    if (isdefined(linkedparent)) {
        visual unlink();
    }
    if (isdefined(self.projectile)) {
        self.projectile delete();
    }
    self gameobjects::allow_carry("none");
    wait(var_dbefa1ce);
    self gameobjects::allow_carry("any");
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0xfd4a190a, Offset: 0x4398
// Size: 0x254
function ball_pass_watch() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"drop_object");
    while (true) {
        weapon = self waittill(#"ball_pass");
        if (!isdefined(self.pass_target)) {
            playerangles = self getplayerangles();
            playerangles = (math::clamp(playerangles[0], -85, 85), playerangles[1], playerangles[2]);
            dir = anglestoforward(playerangles);
            force = 90;
            self.carryobject thread ball_physics_launch_drop(dir * force, self);
            return;
        }
        break;
    }
    if (isdefined(self.carryobject)) {
        self thread ball_pass_or_throw_active();
        pass_target = self.pass_target;
        var_bd2ced7c = self.pass_target.origin;
        wait(0.15);
        if (isdefined(self.pass_target)) {
            pass_target = self.pass_target;
            self.carryobject thread ball_pass_projectile(self, pass_target, var_bd2ced7c);
            return;
        }
        playerangles = self getplayerangles();
        playerangles = (math::clamp(playerangles[0], -85, 85), playerangles[1], playerangles[2]);
        dir = anglestoforward(playerangles);
        force = 90;
        self.carryobject thread ball_physics_launch_drop(dir * force, self);
    }
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x5dcac164, Offset: 0x45f8
// Size: 0x264
function ball_shoot_watch() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"drop_object");
    extra_pitch = getdvarfloat("scr_ball_shoot_extra_pitch", -6);
    force = getdvarfloat("scr_ball_shoot_force", 1200);
    playsoundatposition("wpn_ball_pickup", self.origin);
    self playloopsound("prj_ball_loop_idle");
    while (true) {
        weapon = self waittill(#"weapon_fired");
        self stoploopsound();
        self playsound("wpn_throw_ball");
        if (weapon != getweapon("ball")) {
            continue;
        }
        break;
    }
    if (isdefined(self.carryobject)) {
        playerangles = self getplayerangles();
        playerangles += (extra_pitch, 0, 0);
        playerangles = (math::clamp(playerangles[0], -85, 85), playerangles[1], playerangles[2]);
        dir = anglestoforward(playerangles);
        self thread ball_pass_or_throw_active();
        self thread ball_check_pass_kill_pickup(self.carryobject);
        self.carryobject ball_create_killcam_ent();
        self.carryobject thread ball_physics_launch_drop(dir * force, self, 1);
    }
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x64d8bd34, Offset: 0x4868
// Size: 0x1d4
function ball_weapon_change_watch() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"drop_object");
    ballweapon = getweapon("ball");
    while (true) {
        if (ballweapon == self getcurrentweapon()) {
            break;
        }
        self waittill(#"weapon_change");
    }
    while (true) {
        weapon, lastweapon = self waittill(#"weapon_change");
        if (isdefined(weapon) && weapon.gadget_type == 14) {
            break;
        }
        if (weapon === level.weaponnone && lastweapon === ballweapon) {
            break;
        }
    }
    playerangles = self getplayerangles();
    playerangles = (math::clamp(playerangles[0], -85, 85), absangleclamp360(playerangles[1] + 20), playerangles[2]);
    dir = anglestoforward(playerangles);
    force = 90;
    self.carryobject thread ball_physics_launch_drop(dir * force, self);
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0xac2a4257, Offset: 0x4a48
// Size: 0x48
function valid_ball_pickup_weapon(weapon) {
    if (weapon == level.weaponnone) {
        return false;
    }
    if (weapon == getweapon("ball")) {
        return false;
    }
    return true;
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x5f1eade5, Offset: 0x4a98
// Size: 0x1a
function player_no_pickup_time() {
    return isdefined(self.nopickuptime) && self.nopickuptime > gettime();
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x63f8d550, Offset: 0x4ac0
// Size: 0xa4
function function_40dff2cd(trigger) {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        if (self isplayerunderwater()) {
            if (isdefined(level.ball)) {
                if (isdefined(level.ball.carrier) && level.ball.carrier == self) {
                    level.ball gameobjects::set_dropped();
                    return;
                }
            }
        }
        self.balldropdelay = undefined;
        wait(0.05);
    }
}

// Namespace ball
// Params 3, eflags: 0x1 linked
// Checksum 0xae34336, Offset: 0x4b70
// Size: 0x4c
function ball_physics_launch_drop(force, droppingplayer, switchweapon) {
    ball_set_dropped(1);
    ball_physics_launch(force, droppingplayer);
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0x3e8390a9, Offset: 0x4bc8
// Size: 0x1a4
function ball_check_pass_kill_pickup(carryobj) {
    self endon(#"death");
    self endon(#"disconnect");
    carryobj endon(#"reset");
    timer = spawnstruct();
    timer endon(#"hash_88be9d37");
    timer thread timer_run(1.5);
    carryobj waittill(#"pickup_object");
    timer timer_cancel();
    if (!isdefined(carryobj.carrier) || carryobj.carrier.team == self.team) {
        return;
    }
    carryobj.carrier endon(#"disconnect");
    timer thread timer_run(5);
    attacker = carryobj.carrier waittill(#"death");
    timer timer_cancel();
    if (!isdefined(attacker) || attacker != self) {
        return;
    }
    timer thread timer_run(2);
    carryobj waittill(#"pickup_object");
    timer timer_cancel();
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0x38fcf7f2, Offset: 0x4d78
// Size: 0x2a
function timer_run(time) {
    self endon(#"hash_a5c97639");
    wait(time);
    self notify(#"hash_88be9d37");
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x30570cd0, Offset: 0x4db0
// Size: 0x12
function timer_cancel() {
    self notify(#"hash_a5c97639");
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0x26071c78, Offset: 0x4dd0
// Size: 0xfc
function adjust_for_stance(ball) {
    target = self;
    target endon(#"hash_4ae8aa2c");
    var_5fe7ebc7 = 0;
    while (isdefined(target) && isdefined(ball)) {
        var_e13766c7 = 50;
        switch (target getstance()) {
        case 65:
            var_e13766c7 = 30;
            break;
        case 66:
            var_e13766c7 = 15;
            break;
        }
        if (var_e13766c7 != var_5fe7ebc7) {
            ball ballsettarget(target, (0, 0, var_e13766c7));
            var_e13766c7 = var_5fe7ebc7;
        }
        wait(0.05);
    }
}

// Namespace ball
// Params 3, eflags: 0x1 linked
// Checksum 0x57433828, Offset: 0x4ed8
// Size: 0x444
function ball_pass_projectile(var_c7e075bf, target, var_bd2ced7c) {
    ball_set_dropped(1);
    if (isdefined(target)) {
        var_bd2ced7c = target.origin;
    }
    offset = (0, 0, 60);
    if (target getstance() == "prone") {
        offset = (0, 0, 15);
    } else if (target getstance() == "crouch") {
        offset = (0, 0, 30);
    }
    playerangles = var_c7e075bf getplayerangles();
    playerangles = (0, playerangles[1], 0);
    dir = anglestoforward(playerangles);
    delta = dir * 50;
    origin = self.visuals[0].origin + delta;
    size = 5;
    trace = physicstrace(self.visuals[0].origin, origin, (size * -1, size * -1, size * -1), (size, size, size), var_c7e075bf, 1);
    if (trace["fraction"] < 1) {
        t = 0.7 * trace["fraction"];
        self function_8f5b30b3(self.visuals[0].origin + delta * t, self.visuals[0].angles);
    } else {
        self function_8f5b30b3(trace["position"], self.visuals[0].angles);
    }
    var_c23fae42 = vectornormalize(var_bd2ced7c + offset - self.visuals[0].origin);
    var_59ae0bde = var_c23fae42 * 850;
    var_c7e075bf flag::clear("has_ball");
    self.projectile = var_c7e075bf magicmissile(level.var_aff3334d, self.visuals[0].origin, var_59ae0bde);
    target thread adjust_for_stance(self.projectile);
    self.visuals[0] linkto(self.projectile);
    self gameobjects::ghost_visuals();
    self ball_create_killcam_ent();
    self ball_clear_contents();
    self thread ball_on_projectile_hit_client(var_c7e075bf);
    self thread ball_on_projectile_death();
    self thread function_859e9fab();
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x4bf1ca61, Offset: 0x5328
// Size: 0xc4
function ball_on_projectile_death() {
    self.projectile waittill(#"death");
    ball = self.visuals[0];
    if (!isdefined(self.carrier) && !self.in_goal) {
        if (ball.origin != ball.baseorigin + (0, 0, 4000)) {
            self ball_physics_launch((0, 0, 10));
        }
    }
    self ball_restore_contents();
    ball notify(#"hash_4ae8aa2c");
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x332ad60e, Offset: 0x53f8
// Size: 0x6a
function ball_restore_contents() {
    if (isdefined(self.visuals[0].var_f8f65741)) {
        self.visuals[0] setcontents(self.visuals[0].var_f8f65741);
        self.visuals[0].var_f8f65741 = undefined;
    }
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0xfd5cff9e, Offset: 0x5470
// Size: 0x74
function ball_on_projectile_hit_client(var_c7e075bf) {
    self endon(#"hash_4ae8aa2c");
    player = self.projectile waittill(#"projectile_impact_player");
    self.trigger notify(#"trigger", player);
    if (isdefined(var_c7e075bf)) {
        var_c7e075bf recordgameevent("pass");
    }
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x8cf20c73, Offset: 0x54f0
// Size: 0x38
function ball_clear_contents() {
    self.visuals[0].var_f8f65741 = self.visuals[0] setcontents(0);
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x248926a5, Offset: 0x5530
// Size: 0x9c
function ball_create_killcam_ent() {
    if (isdefined(self.killcament)) {
        self.killcament delete();
    }
    self.killcament = spawn("script_model", self.visuals[0].origin);
    self.killcament linkto(self.visuals[0]);
    self.killcament setcontents(0);
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0xd3432320, Offset: 0x55d8
// Size: 0x98
function ball_pass_or_throw_active() {
    self endon(#"death");
    self endon(#"disconnect");
    self.pass_or_throw_active = 1;
    self allowmelee(0);
    while (getweapon("ball") == self getcurrentweapon()) {
        wait(0.05);
    }
    self allowmelee(1);
    self.pass_or_throw_active = 0;
}

// Namespace ball
// Params 2, eflags: 0x1 linked
// Checksum 0x6787e55c, Offset: 0x5678
// Size: 0x20
function ball_download_fx(var_7ee2b1c, waittime) {
    self.scorefrozenuntil = 0;
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xb9b95269, Offset: 0x56a0
// Size: 0x1c
function function_2635f289() {
    ball_assign_start(level.var_4f928387);
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0x1db264e1, Offset: 0x56c8
// Size: 0xd4
function ball_assign_start(start) {
    foreach (vis in self.visuals) {
        vis.baseorigin = start.origin;
    }
    self.trigger.baseorigin = start.origin;
    self.current_start = start;
    start.in_use = 1;
}

// Namespace ball
// Params 2, eflags: 0x1 linked
// Checksum 0xb76a53ff, Offset: 0x57a8
// Size: 0x36c
function ball_physics_launch(force, droppingplayer) {
    visuals = self.visuals[0];
    visuals.origin_prev = undefined;
    origin = visuals.origin;
    owner = visuals;
    if (isdefined(droppingplayer)) {
        owner = droppingplayer;
        owner flag::clear("has_ball");
        origin = droppingplayer getweaponmuzzlepoint();
        right = anglestoright(force);
        origin += (right[0], right[1], 0) * 7;
        startpos = origin;
        delta = vectornormalize(force) * 80;
        size = 5;
        trace = physicstrace(startpos, startpos + delta, (size * -1, size * -1, size * -1), (size, size, size), droppingplayer, 1);
        if (trace["fraction"] < 1) {
            t = 0.7 * trace["fraction"];
            self function_8f5b30b3(startpos + delta * t, visuals.angles);
        } else {
            self function_8f5b30b3(trace["position"], visuals.angles);
        }
    }
    grenade = owner magicmissile(level.var_d566bdba, visuals.origin, force);
    grenade playloopsound("prj_ball_loop");
    visuals linkto(grenade);
    self gameobjects::ghost_visuals();
    self.projectile = grenade;
    visuals dontinterpolate();
    self thread ball_physics_out_of_level();
    self thread function_859e9fab();
    self thread ball_physics_touch_cant_pickup_player(droppingplayer);
    self thread function_96acd1aa();
    self.var_b4c16cba = 0;
    self thread function_1b26c689();
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0xe62eb836, Offset: 0x5b20
// Size: 0xa0
function function_1b26c689() {
    self endon(#"death");
    while (true) {
        pos, normal = self.projectile waittill(#"grenade_bounce");
        if (self.var_b4c16cba == 0) {
            dot = vectordot(normal, (0, 0, 1));
            self.projectile thread function_c004c2bd();
        }
        self.var_b4c16cba++;
    }
}

// Namespace ball
// Params 2, eflags: 0x1 linked
// Checksum 0x6743b5d7, Offset: 0x5bc8
// Size: 0x15c
function function_fed77788(var_bdc0f958, v_force) {
    visuals = self.visuals[0];
    visuals unlink();
    wait(0.05);
    if (isdefined(self.projectile)) {
        self.projectile delete();
    }
    grenade = visuals magicmissile(level.var_d566bdba, var_bdc0f958, v_force);
    visuals linkto(grenade);
    self gameobjects::ghost_visuals();
    self.projectile = grenade;
    visuals dontinterpolate();
    self thread ball_physics_out_of_level();
    self thread function_96acd1aa();
    self thread gameobjects::pickup_timeout(var_bdc0f958[2], var_bdc0f958[2] - 400);
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x3897865d, Offset: 0x5d30
// Size: 0x124
function function_96acd1aa() {
    self endon(#"reset");
    self endon(#"pickup_object");
    visual = self.visuals[0];
    while (true) {
        var_4fca0920 = isdefined(self.isresetting) && (isdefined(self.in_goal) && self.in_goal || self.isresetting);
        if (!var_4fca0920) {
            if (!isdefined(visual)) {
                return;
            }
            if (visual oob::istouchinganyoobtrigger() || visual function_b2a406b0() || self gameobjects::should_be_reset(visual.origin[2], visual.origin[2] + 10, 1)) {
                self function_98827162();
                return;
            }
        }
        wait(0.05);
    }
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0x39376613, Offset: 0x5e60
// Size: 0x140
function ball_physics_touch_cant_pickup_player(droppingplayer) {
    self endon(#"reset");
    self endon(#"pickup_object");
    ball = self.visuals[0];
    trigger = self.trigger;
    while (true) {
        player = trigger waittill(#"trigger");
        if (isactor(player)) {
            continue;
        }
        if (isdefined(droppingplayer) && droppingplayer == player && player player_no_pickup_time()) {
            continue;
        }
        if (self.droptime >= gettime()) {
            continue;
        }
        if (ball.origin == ball.baseorigin + (0, 0, 4000)) {
            continue;
        }
        if (!function_b861e1df(player) && self.droptime + -56 < gettime()) {
        }
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x3593f924, Offset: 0x5fa8
// Size: 0x92
function ball_physics_fake_bounce() {
    ball = self.visuals[0];
    vel = ball getvelocity();
    bounceforce = length(vel) / 10;
    var_553a55d2 = -1 * vectornormalize(vel);
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x6048
// Size: 0x4
function function_859e9fab() {
    
}

// Namespace ball
// Params 4, eflags: 0x0
// Checksum 0xfd1fec38, Offset: 0x6058
// Size: 0xe4
function function_12bbc0ef(line_start, line_end, var_494a9d56, sphere_radius) {
    dir = vectornormalize(line_end - line_start);
    a = vectordot(dir, line_start - var_494a9d56);
    a *= a;
    b = line_start - var_494a9d56;
    b *= b;
    c = sphere_radius * sphere_radius;
    return a - b + c >= 0;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x6bb7b9cd, Offset: 0x6148
// Size: 0x284
function ball_touched_goal(goal) {
    if (isdefined(self.claimplayer)) {
        return;
    }
    if (isdefined(self.scorefrozenuntil) && self.scorefrozenuntil > gettime()) {
        return;
    }
    self gameobjects::allow_carry("none");
    goal function_85e74fc9();
    self.scorefrozenuntil = gettime() + 10000;
    team = goal.team;
    otherteam = util::getotherteam(team);
    if (isdefined(self.lastcarrier)) {
        if (isdefined(self.lastcarrier.pers["throws"])) {
            self.lastcarrier.pers["throws"]++;
            self.lastcarrier.throws = self.lastcarrier.pers["throws"];
        }
        bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ball_throw", team, self.lastcarrier.origin);
        self.lastcarrier recordgameevent("throw");
        self.lastcarrier addplayerstatwithgametype("THROWS", 1);
        self.lastcarrierscored = 1;
        ball_check_assist(self.lastcarrier, 0);
        if (isdefined(self.killcament) && should_record_final_score_cam(otherteam, level.throwscore)) {
        }
        self.lastcarrier addplayerstatwithgametype("CAPTURES", 1);
    }
    if (isdefined(self.killcament)) {
        self.killcament unlink();
    }
    self thread function_db6a152e(goal);
    ball_give_score(otherteam, level.throwscore);
}

// Namespace ball
// Params 2, eflags: 0x1 linked
// Checksum 0x6eeca1da, Offset: 0x63d8
// Size: 0xa4
function ball_give_score(team, score) {
    if (isdefined(game["overtime_round"])) {
        if (game["overtime_round"] == 1) {
            return;
        }
        if (game["ball_overtime_first_winner"] === team) {
        }
        team_score = [[ level._getteamscore ]](team);
        var_c97a682c = [[ level._getteamscore ]](util::getotherteam(team));
    }
}

// Namespace ball
// Params 2, eflags: 0x1 linked
// Checksum 0x7dd2b369, Offset: 0x6488
// Size: 0x74
function should_record_final_score_cam(team, var_6db4572f) {
    team_score = [[ level._getteamscore ]](team);
    var_c97a682c = [[ level._getteamscore ]](util::getotherteam(team));
    return team_score + var_6db4572f >= var_c97a682c;
}

// Namespace ball
// Params 2, eflags: 0x1 linked
// Checksum 0xbcdd10b2, Offset: 0x6508
// Size: 0x5e
function ball_check_assist(player, var_84a3cadc) {
    if (!isdefined(player.passtime) || !isdefined(player.passplayer)) {
        return;
    }
    if (player.passtime + 3000 < gettime()) {
        return;
    }
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x3c68052a, Offset: 0x6570
// Size: 0x184
function ball_physics_timeout() {
    self endon(#"reset");
    self endon(#"pickup_object");
    self endon(#"score_event");
    if (isdefined(self.autoresettime) && self.autoresettime > 15) {
        var_394347f7 = self.autoresettime;
    } else {
        var_394347f7 = 15;
    }
    if (isdefined(self.projectile)) {
        var_2615ab42 = self.projectile util::function_183e3618(var_394347f7, "stationary", self, "reset", "pickup_object", "score_event");
        if (!isdefined(var_2615ab42)) {
            return;
        }
        if (var_2615ab42 == "stationary") {
            str_zone_name = self.projectile zm_utility::get_current_zone();
            if (isdefined(str_zone_name) && ispointonnavmesh(self.projectile.origin)) {
                self.visuals[0] clientfield::set("ball_on_ground_fx", 1);
                if (isdefined(level.var_1c0253f1)) {
                    self thread [[ level.var_1c0253f1 ]]();
                }
                return;
            }
        }
    }
    self function_98827162();
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x1de890ed, Offset: 0x6700
// Size: 0x54
function ball_physics_out_of_level() {
    self endon(#"reset");
    self endon(#"pickup_object");
    ball = self.visuals[0];
    self waittill(#"hash_369e04c9");
    self function_98827162(0);
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0xf336a46, Offset: 0x6760
// Size: 0x398
function player_update_pass_target(var_afffeadd) {
    self notify(#"hash_227c656a");
    self endon(#"hash_227c656a");
    self endon(#"disconnect");
    self endon(#"hash_bf5529ed");
    test_dot = 0.8;
    while (true) {
        new_target = undefined;
        if (!self isonladder()) {
            playerdir = anglestoforward(self getplayerangles());
            playereye = self geteye();
            var_9ee2cc0f = [];
            foreach (target in level.players) {
                if (target.team != self.team) {
                    continue;
                }
                if (!isalive(target)) {
                    continue;
                }
                if (!var_afffeadd function_b861e1df(target)) {
                    continue;
                }
                targeteye = target geteye();
                distsq = distancesquared(targeteye, playereye);
                if (distsq > 1000000) {
                    continue;
                }
                dirtotarget = vectornormalize(targeteye - playereye);
                dot = vectordot(playerdir, dirtotarget);
                if (dot > test_dot) {
                    target.pass_dot = dot;
                    target.var_4e7a846b = targeteye;
                    var_9ee2cc0f[var_9ee2cc0f.size] = target;
                }
            }
            var_9ee2cc0f = array::quicksort(var_9ee2cc0f, &compare_player_pass_dot);
            foreach (target in var_9ee2cc0f) {
                if (sighttracepassed(playereye, target.var_4e7a846b, 0, target)) {
                    new_target = target;
                    break;
                }
            }
        }
        self player_set_pass_target(new_target);
        wait(0.05);
    }
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x6b00
// Size: 0x4
function function_6dc166ee() {
    
}

// Namespace ball
// Params 2, eflags: 0x1 linked
// Checksum 0x98d0a7ce, Offset: 0x6b10
// Size: 0x30
function compare_player_pass_dot(left, right) {
    return left.pass_dot >= right.pass_dot;
}

// Namespace ball
// Params 1, eflags: 0x1 linked
// Checksum 0x949d5fcf, Offset: 0x6b48
// Size: 0x19c
function player_set_pass_target(new_target) {
    if (isdefined(self.pass_target) && isdefined(new_target) && self.pass_target == new_target) {
        return;
    }
    if (!isdefined(self.pass_target) && !isdefined(new_target)) {
        return;
    }
    self player_clear_pass_target();
    if (isdefined(new_target)) {
        offset = (0, 0, 80);
        new_target clientfield::set("passoption", 1);
        self.pass_target = new_target;
        team_players = [];
        foreach (player in level.players) {
            if (player.team == self.team && player != self && player != new_target) {
                team_players[team_players.size] = player;
            }
        }
        self setballpassallowed(1);
    }
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x856ab54e, Offset: 0x6cf0
// Size: 0x134
function player_clear_pass_target() {
    if (isdefined(self.pass_icon)) {
        self.pass_icon destroy();
    }
    team_players = [];
    foreach (player in level.players) {
        if (player.team == self.team && player != self) {
            team_players[team_players.size] = player;
        }
    }
    if (isdefined(self.pass_target)) {
        self.pass_target clientfield::set("passoption", 0);
    }
    self.pass_target = undefined;
    self setballpassallowed(0);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x88baa0c3, Offset: 0x6e30
// Size: 0xba
function function_22c4dbca(z_offset) {
    tracestart = self.origin + (0, 0, 32);
    traceend = self.origin + (0, 0, -1000);
    trace = bullettrace(tracestart, traceend, 0, undefined);
    self.ground_origin = trace["position"];
    return trace["fraction"] != 0 && trace["fraction"] != 1;
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x7a7360a0, Offset: 0x6ef8
// Size: 0x54
function function_85e74fc9() {
    key = "ball_score_" + self.team;
    level clientfield::set(key, !level clientfield::get(key));
}

// Namespace ball
// Params 0, eflags: 0x1 linked
// Checksum 0x3dbde67a, Offset: 0x6f58
// Size: 0x1e6
function function_b2a406b0() {
    if (!isdefined(level.var_665382a2)) {
        return 0;
    }
    var_41383ff5 = [];
    result = 0;
    foreach (trigger in level.var_665382a2) {
        if (!isdefined(trigger)) {
            if (!isdefined(var_41383ff5)) {
                var_41383ff5 = [];
            } else if (!isarray(var_41383ff5)) {
                var_41383ff5 = array(var_41383ff5);
            }
            var_41383ff5[var_41383ff5.size] = trigger;
            continue;
        }
        if (!trigger istriggerenabled()) {
            continue;
        }
        if (self istouching(trigger)) {
            result = 1;
            break;
        }
    }
    foreach (trigger in var_41383ff5) {
        arrayremovevalue(level.var_665382a2, trigger);
    }
    var_41383ff5 = [];
    var_41383ff5 = undefined;
    return result;
}

