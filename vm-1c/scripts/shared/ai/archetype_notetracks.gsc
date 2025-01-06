#using scripts/shared/ai/archetype_human_cover;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/ai_blackboard;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/ai_shared;

#namespace animationstatenetwork;

// Namespace animationstatenetwork
// Params 0, eflags: 0x2
// Checksum 0xf6c90615, Offset: 0x438
// Size: 0x43c
function autoexec registerdefaultnotetrackhandlerfunctions() {
    registernotetrackhandlerfunction("fire", &notetrackfirebullet);
    registernotetrackhandlerfunction("gib_disable", &notetrackgibdisable);
    registernotetrackhandlerfunction("gib = \"head\"", &gibserverutils::gibhead);
    registernotetrackhandlerfunction("gib = \"arm_left\"", &gibserverutils::gibleftarm);
    registernotetrackhandlerfunction("gib = \"arm_right\"", &gibserverutils::gibrightarm);
    registernotetrackhandlerfunction("gib = \"leg_left\"", &gibserverutils::gibleftleg);
    registernotetrackhandlerfunction("gib = \"leg_right\"", &gibserverutils::gibrightleg);
    registernotetrackhandlerfunction("dropgun", &notetrackdropgun);
    registernotetrackhandlerfunction("gun drop", &notetrackdropgun);
    registernotetrackhandlerfunction("drop_shield", &notetrackdropshield);
    registernotetrackhandlerfunction("hide_weapon", &notetrackhideweapon);
    registernotetrackhandlerfunction("show_weapon", &notetrackshowweapon);
    registernotetrackhandlerfunction("hide_ai", &notetrackhideai);
    registernotetrackhandlerfunction("show_ai", &notetrackshowai);
    registernotetrackhandlerfunction("attach_knife", &notetrackattachknife);
    registernotetrackhandlerfunction("detach_knife", &notetrackdetachknife);
    registernotetrackhandlerfunction("grenade_throw", &notetrackgrenadethrow);
    registernotetrackhandlerfunction("start_ragdoll", &notetrackstartragdoll);
    registernotetrackhandlerfunction("ragdoll_nodeath", &notetrackstartragdollnodeath);
    registernotetrackhandlerfunction("unsync", &notetrackmeleeunsync);
    registernotetrackhandlerfunction("step1", &notetrackstaircasestep1);
    registernotetrackhandlerfunction("step2", &notetrackstaircasestep2);
    registernotetrackhandlerfunction("anim_movement = \"stop\"", &notetrackanimmovementstop);
    registerblackboardnotetrackhandler("anim_pose = \"stand\"", "_stance", "stand");
    registerblackboardnotetrackhandler("anim_pose = \"crouch\"", "_stance", "crouch");
    registerblackboardnotetrackhandler("anim_pose = \"prone_front\"", "_stance", "prone_front");
    registerblackboardnotetrackhandler("anim_pose = \"prone_back\"", "_stance", "prone_back");
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0x15562793, Offset: 0x880
// Size: 0x64
function private notetrackanimmovementstop(entity) {
    if (entity haspath()) {
        entity pathmode("move delayed", 1, randomfloatrange(2, 4));
    }
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0xae971b2d, Offset: 0x8f0
// Size: 0x5c
function private notetrackstaircasestep1(entity) {
    numsteps = blackboard::getblackboardattribute(entity, "_staircase_num_steps");
    numsteps++;
    blackboard::setblackboardattribute(entity, "_staircase_num_steps", numsteps);
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0xc0e3500, Offset: 0x958
// Size: 0x6c
function private notetrackstaircasestep2(entity) {
    numsteps = blackboard::getblackboardattribute(entity, "_staircase_num_steps");
    numsteps += 2;
    blackboard::setblackboardattribute(entity, "_staircase_num_steps", numsteps);
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0xbe7e929d, Offset: 0x9d0
// Size: 0x94
function private notetrackdropguninternal(entity) {
    if (entity.weapon == level.weaponnone) {
        return;
    }
    entity.lastweapon = entity.weapon;
    primaryweapon = entity.primaryweapon;
    secondaryweapon = entity.secondaryweapon;
    entity thread shared::dropaiweapon();
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0xc300680f, Offset: 0xa70
// Size: 0x68
function private notetrackattachknife(entity) {
    if (!(isdefined(entity._ai_melee_attachedknife) && entity._ai_melee_attachedknife)) {
        entity attach("t6_wpn_knife_melee", "TAG_WEAPON_LEFT");
        entity._ai_melee_attachedknife = 1;
    }
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0xa3bb392a, Offset: 0xae0
// Size: 0x64
function private notetrackdetachknife(entity) {
    if (isdefined(entity._ai_melee_attachedknife) && entity._ai_melee_attachedknife) {
        entity detach("t6_wpn_knife_melee", "TAG_WEAPON_LEFT");
        entity._ai_melee_attachedknife = 0;
    }
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0xca0aadc8, Offset: 0xb50
// Size: 0x24
function private notetrackhideweapon(entity) {
    entity ai::gun_remove();
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0x2ebcf9de, Offset: 0xb80
// Size: 0x24
function private notetrackshowweapon(entity) {
    entity ai::gun_recall();
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0x2d0caf1b, Offset: 0xbb0
// Size: 0x24
function private notetrackhideai(entity) {
    entity hide();
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0x6038f3bc, Offset: 0xbe0
// Size: 0x24
function private notetrackshowai(entity) {
    entity show();
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0xcc16f3ea, Offset: 0xc10
// Size: 0xb4
function private notetrackstartragdoll(entity) {
    if (isactor(entity) && entity isinscriptedstate()) {
        entity.overrideactordamage = undefined;
        entity.allowdeath = 1;
        entity.skipdeath = 1;
        entity kill();
    }
    notetrackdropguninternal(entity);
    entity startragdoll();
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x0
// Checksum 0x210ee748, Offset: 0xcd0
// Size: 0x4c
function _delayedragdoll(entity) {
    wait 0.25;
    if (isdefined(entity) && !entity isragdoll()) {
        entity startragdoll();
    }
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x0
// Checksum 0xa7c3b49f, Offset: 0xd28
// Size: 0x54
function notetrackstartragdollnodeath(entity) {
    if (isdefined(entity._ai_melee_opponent)) {
        entity._ai_melee_opponent unlink();
    }
    entity thread _delayedragdoll(entity);
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0x989220d0, Offset: 0xd88
// Size: 0x104
function private notetrackfirebullet(animationentity) {
    if (isactor(animationentity) && animationentity isinscriptedstate()) {
        if (animationentity.weapon != level.weaponnone) {
            animationentity notify(#"about_to_shoot");
            startpos = animationentity gettagorigin("tag_flash");
            endpos = startpos + vectorscale(animationentity getweaponforwarddir(), 100);
            magicbullet(animationentity.weapon, startpos, endpos, animationentity);
            animationentity notify(#"shoot");
            animationentity.bulletsinclip--;
        }
    }
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0x1b2c6e95, Offset: 0xe98
// Size: 0x24
function private notetrackdropgun(animationentity) {
    notetrackdropguninternal(animationentity);
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0xfda9364, Offset: 0xec8
// Size: 0x24
function private notetrackdropshield(animationentity) {
    aiutility::dropriotshield(animationentity);
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0x6729fe6e, Offset: 0xef8
// Size: 0xd4
function private notetrackgrenadethrow(animationentity) {
    if (archetype_human_cover::shouldthrowgrenadeatcovercondition(animationentity, 1)) {
        animationentity grenadethrow();
        return;
    }
    if (isdefined(animationentity.grenadethrowposition)) {
        arm_offset = archetype_human_cover::temp_get_arm_offset(animationentity, animationentity.grenadethrowposition);
        throw_vel = animationentity canthrowgrenadepos(arm_offset, animationentity.grenadethrowposition);
        if (isdefined(throw_vel)) {
            animationentity grenadethrow();
        }
    }
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0x81c1a10b, Offset: 0xfd8
// Size: 0x74
function private notetrackmeleeunsync(animationentity) {
    if (isdefined(animationentity) && isdefined(animationentity.enemy)) {
        if (isdefined(animationentity.enemy._ai_melee_markeddead) && animationentity.enemy._ai_melee_markeddead) {
            animationentity unlink();
        }
    }
}

// Namespace animationstatenetwork
// Params 1, eflags: 0x4
// Checksum 0xe786be4e, Offset: 0x1058
// Size: 0x4c
function private notetrackgibdisable(animationentity) {
    if (animationentity ai::has_behavior_attribute("can_gib")) {
        animationentity ai::set_behavior_attribute("can_gib", 0);
    }
}

