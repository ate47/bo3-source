#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/codescripts/struct;

#using_animtree("zm_ally");

#namespace zm_clone;

// Namespace zm_clone
// Params 4, eflags: 0x1 linked
// Checksum 0x46c1b98d, Offset: 0x1a8
// Size: 0x2f4
function spawn_player_clone(player, origin, forceweapon, forcemodel) {
    if (!isdefined(origin)) {
        origin = player.origin;
    }
    primaryweapons = player getweaponslistprimaries();
    if (isdefined(forceweapon)) {
        weapon = forceweapon;
    } else if (primaryweapons.size) {
        weapon = primaryweapons[0];
    } else {
        weapon = player getcurrentweapon();
    }
    weaponmodel = weapon.worldmodel;
    spawner = getent("fake_player_spawner", "targetname");
    if (isdefined(spawner)) {
        clone = spawner spawnfromspawner();
        clone.origin = origin;
        clone.isactor = 1;
    } else {
        clone = spawn("script_model", origin);
        clone.isactor = 0;
    }
    if (isdefined(forcemodel)) {
        clone setmodel(forcemodel);
    } else {
        mdl_body = player getcharacterbodymodel();
        clone setmodel(mdl_body);
        var_6f30937d = player getcharacterbodyrenderoptions();
        clone setbodyrenderoptions(var_6f30937d, var_6f30937d, var_6f30937d);
    }
    if (weaponmodel != "" && weaponmodel != "none") {
        clone attach(weaponmodel, "tag_weapon_right");
    }
    clone.team = player.team;
    clone.is_inert = 1;
    clone.zombie_move_speed = "walk";
    clone.script_noteworthy = "corpse_clone";
    clone.actor_damage_func = &clone_damage_func;
    return clone;
}

// Namespace zm_clone
// Params 11, eflags: 0x1 linked
// Checksum 0x2b27c8a2, Offset: 0x4a8
// Size: 0xa2
function clone_damage_func(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    idamage = 0;
    if (weapon.isballisticknife && zm_weapons::is_weapon_upgraded(weapon)) {
        self notify(#"player_revived", eattacker);
    }
    return idamage;
}

// Namespace zm_clone
// Params 1, eflags: 0x0
// Checksum 0x81e12050, Offset: 0x558
// Size: 0x6c
function clone_give_weapon(weapon) {
    weaponmodel = weapon.worldmodel;
    if (weaponmodel != "" && weaponmodel != "none") {
        self attach(weaponmodel, "tag_weapon_right");
    }
}

// Namespace zm_clone
// Params 1, eflags: 0x1 linked
// Checksum 0x4348116f, Offset: 0x5d0
// Size: 0x4c
function clone_animate(animtype) {
    if (self.isactor) {
        self thread clone_actor_animate(animtype);
        return;
    }
    self thread clone_mover_animate(animtype);
}

// Namespace zm_clone
// Params 1, eflags: 0x1 linked
// Checksum 0x47fbb9dc, Offset: 0x628
// Size: 0x7e
function clone_actor_animate(animtype) {
    wait 0.1;
    switch (animtype) {
    case "laststand":
        self setanimstatefromasd("laststand");
        break;
    case "idle":
    default:
        self setanimstatefromasd("idle");
        break;
    }
}

// Namespace zm_clone
// Params 1, eflags: 0x1 linked
// Checksum 0x853f6af0, Offset: 0x6b0
// Size: 0x12e
function clone_mover_animate(animtype) {
    self useanimtree(#zm_ally);
    switch (animtype) {
    case "laststand":
        self setanim(zm_ally%pb_laststand_idle);
        break;
    case "afterlife":
        self setanim(zm_ally%pb_afterlife_laststand_idle);
        break;
    case "chair":
        self setanim(zm_ally%ai_actor_elec_chair_idle);
        break;
    case "falling":
        self setanim(zm_ally%pb_falling_loop);
        break;
    case "idle":
    default:
        self setanim(zm_ally%pb_stand_alert);
        break;
    }
}

