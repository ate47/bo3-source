#using scripts/codescripts/struct;
#using scripts/shared/ai/margwa;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_ai_margwa_elemental;
#using scripts/zm/_zm_ai_margwa_no_idgun;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_genesis_challenges;
#using scripts/zm/zm_genesis_portals;

#namespace zm_genesis_margwa;

// Namespace zm_genesis_margwa
// Params 0, eflags: 0x2
// Checksum 0xfc9e3b92, Offset: 0x4e8
// Size: 0x21c
function autoexec init() {
    function_e84ffe9c();
    spawner::add_archetype_spawn_function("margwa", &function_57c223eb);
    namespace_6c6fd2b0::function_5f9266e0("turret_zm_genesis");
    namespace_6c6fd2b0::function_5f9266e0("shotgun_energy");
    namespace_6c6fd2b0::function_5f9266e0("shotgun_energy_upgraded");
    namespace_6c6fd2b0::function_5f9266e0("pistol_energy");
    namespace_6c6fd2b0::function_5f9266e0("pistol_energy_upgraded");
    if (!isdefined(level.var_fd47363)) {
        level.var_fd47363 = [];
        level.var_fd47363["head_le"] = "c_zom_dlc4_margwa_chunks_le";
        level.var_fd47363["head_mid"] = "c_zom_dlc4_margwa_chunks_mid";
        level.var_fd47363["head_ri"] = "c_zom_dlc4_margwa_chunks_ri";
        level.var_fd47363["gore_le"] = "c_zom_dlc4_margwa_gore_le";
        level.var_fd47363["gore_mid"] = "c_zom_dlc4_margwa_gore_mid";
        level.var_fd47363["gore_ri"] = "c_zom_dlc4_margwa_gore_ri";
        level.var_2c028bba = level.var_fd47363["head_le"];
        level.var_72374095 = level.var_fd47363["head_mid"];
        level.var_c9a18bd = level.var_fd47363["head_ri"];
        level.var_4182a531 = level.var_fd47363["gore_le"];
        level.var_7ff16e00 = level.var_fd47363["gore_mid"];
        level.var_b9c5d5f0 = level.var_fd47363["gore_ri"];
    }
    if (!isdefined(level.var_6b7244b4)) {
        level.var_6b7244b4 = 100;
    }
}

// Namespace zm_genesis_margwa
// Params 0, eflags: 0x4
// Checksum 0xdfab5d47, Offset: 0x710
// Size: 0xa4
function private function_e84ffe9c() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("genesisMargwaVortexService", &function_96a94112);
    behaviortreenetworkutility::registerbehaviortreescriptapi("genesisMargwaSpiderService", &function_9f065361);
    behaviortreenetworkutility::registerbehaviortreescriptapi("genesisMargwaReactStunTerminate", &function_a5e64246);
    behaviortreenetworkutility::registerbehaviortreescriptapi("genesisMargwaReactIDGunTerminate", &function_a478da01);
}

// Namespace zm_genesis_margwa
// Params 1, eflags: 0x4
// Checksum 0x9b1db6b0, Offset: 0x7c0
// Size: 0x4e
function private function_96a94112(entity) {
    if (isdefined(entity.var_28763934) && entity.var_28763934 < gettime()) {
        return namespace_ca5ef87d::function_6312be59(entity);
    }
    return 0;
}

// Namespace zm_genesis_margwa
// Params 1, eflags: 0x4
// Checksum 0xbcbeb41a, Offset: 0x818
// Size: 0x112
function private function_9f065361(entity) {
    zombies = getaiteamarray(level.zombie_team);
    foreach (zombie in zombies) {
        if (zombie.archetype == "spider") {
            distsq = distancesquared(entity.origin, zombie.origin);
            if (distsq < 2304) {
                zombie kill();
            }
        }
    }
}

// Namespace zm_genesis_margwa
// Params 1, eflags: 0x4
// Checksum 0xd3d1f905, Offset: 0x938
// Size: 0x3c
function private function_a5e64246(entity) {
    namespace_6c6fd2b0::margwareactstunterminate(entity);
    entity.var_aa0a91dd = gettime() + 10000;
}

// Namespace zm_genesis_margwa
// Params 1, eflags: 0x4
// Checksum 0x60060ea8, Offset: 0x980
// Size: 0x3c
function private function_a478da01(entity) {
    namespace_6c6fd2b0::margwaReactIDGunTerminate(entity);
    entity.var_28763934 = gettime() + 10000;
}

// Namespace zm_genesis_margwa
// Params 0, eflags: 0x4
// Checksum 0xd263d8b3, Offset: 0x9c8
// Size: 0xc4
function private function_57c223eb() {
    self.var_5ffc5a7b = &function_c27412c6;
    self.var_d53ee8d8 = &function_cc95e566;
    self thread function_e1f5236a();
    self.var_654f1c0 = &function_df77c1c3;
    self.var_fbaea41d = &function_a8ffa66c;
    self.var_c732138b = &function_f769285c;
    self.var_aa0a91dd = gettime();
    self.var_28763934 = gettime();
    self.var_15704e8d = gettime();
    self.heroweapon_kill_power = 5;
}

// Namespace zm_genesis_margwa
// Params 0, eflags: 0x4
// Checksum 0xf05e19fc, Offset: 0xa98
// Size: 0x3c
function private function_9ba47060() {
    self endon(#"death");
    wait 0.1;
    if (isdefined(self.var_58ce2260)) {
        self.var_58ce2260 delete();
    }
}

// Namespace zm_genesis_margwa
// Params 0, eflags: 0x4
// Checksum 0x2212a137, Offset: 0xae0
// Size: 0x7c
function private function_f05e4819() {
    self endon(#"death");
    self.waiting = 1;
    self.var_b830cb9 = 1;
    self thread namespace_c96301ee::function_e9c9b15b();
    wait 2;
    self.var_6a46ac61 clientfield::set("margwa_fx_travel_tell", 0);
    self.waiting = 0;
    self.var_3993b370 = 0;
}

// Namespace zm_genesis_margwa
// Params 0, eflags: 0x4
// Checksum 0x28caf8c0, Offset: 0xb68
// Size: 0x2c
function private function_e1f5236a() {
    self endon(#"death");
    wait 1;
    self namespace_c96301ee::function_21573f43();
}

// Namespace zm_genesis_margwa
// Params 1, eflags: 0x4
// Checksum 0x4ca03370, Offset: 0xba0
// Size: 0x24
function private function_c27412c6(player) {
    self zm_genesis_challenges::function_ca31caac(undefined, player);
}

// Namespace zm_genesis_margwa
// Params 0, eflags: 0x4
// Checksum 0x4b1c6917, Offset: 0xbd0
// Size: 0x64
function private function_cc95e566() {
    if (math::cointoss()) {
        if (namespace_3de4ab6f::function_6bbd2a18(self)) {
            self.var_322364e8 = 1;
            return;
        }
        if (namespace_3de4ab6f::function_b9fad980(self)) {
            self.var_3c58b79c = 1;
        }
    }
}

// Namespace zm_genesis_margwa
// Params 2, eflags: 0x4
// Checksum 0x4b9cba47, Offset: 0xc40
// Size: 0x16c
function private function_df77c1c3(inflictor, attacker) {
    if (isdefined(self)) {
        foreach (head in self.head) {
            if (head.health > 0) {
                damage = self.var_b77c9d35 * 0.5;
                head.health -= damage;
                if (head.health <= 0) {
                    player = undefined;
                    if (isdefined(self.vortex)) {
                        player = self.vortex.attacker;
                    }
                    if (self namespace_c96301ee::function_a614f89c(head.model, player)) {
                        self kill();
                    }
                }
                return;
            }
        }
    }
}

// Namespace zm_genesis_margwa
// Params 1, eflags: 0x4
// Checksum 0xc3cd1678, Offset: 0xdb8
// Size: 0x10c
function private function_a8ffa66c(player) {
    if (isdefined(self)) {
        if (gettime() > self.var_15704e8d) {
            foreach (head in self.head) {
                if (head.health > 0) {
                    head.health = 0;
                    if (self namespace_c96301ee::function_a614f89c(head.model, player)) {
                        self kill();
                    }
                    self.var_15704e8d = gettime() + 10000;
                    return;
                }
            }
        }
    }
}

// Namespace zm_genesis_margwa
// Params 0, eflags: 0x4
// Checksum 0xddae50c2, Offset: 0xed0
// Size: 0x34
function private function_f769285c() {
    if (self function_2a03f05f()) {
        self.var_9e59b56e = 1;
        return true;
    }
    return false;
}

// Namespace zm_genesis_margwa
// Params 0, eflags: 0x0
// Checksum 0x7e1f3df3, Offset: 0xf10
// Size: 0x32
function function_2a03f05f() {
    if (isdefined(self.var_894f701d) && self.var_894f701d && self.var_aa0a91dd < gettime()) {
        return true;
    }
    return false;
}

