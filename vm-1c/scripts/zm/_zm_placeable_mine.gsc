#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_audio;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_placeable_mine;

// Namespace zm_placeable_mine
// Params 0, eflags: 0x2
// Checksum 0xf8bbdc12, Offset: 0x2a8
// Size: 0x2c
function autoexec function_2dc19561() {
    system::register("placeable_mine", undefined, &__main__, undefined);
}

// Namespace zm_placeable_mine
// Params 0, eflags: 0x5 linked
// Checksum 0x835e99c8, Offset: 0x2e0
// Size: 0x24
function private __main__() {
    if (isdefined(level.placeable_mines)) {
        level thread replenish_after_rounds();
    }
}

// Namespace zm_placeable_mine
// Params 0, eflags: 0x5 linked
// Checksum 0x80b3d893, Offset: 0x310
// Size: 0x70
function private init_internal() {
    if (isdefined(level.placeable_mines)) {
        return;
    }
    level.placeable_mines = [];
    level.placeable_mines_on_damage = &placeable_mine_damage;
    level.pickup_placeable_mine = &pickup_placeable_mine;
    level.pickup_placeable_mine_trigger_listener = &pickup_placeable_mine_trigger_listener;
    level.placeable_mine_planted_callbacks = [];
}

// Namespace zm_placeable_mine
// Params 0, eflags: 0x1 linked
// Checksum 0x49678755, Offset: 0x388
// Size: 0x62
function get_first_available() {
    if (isdefined(level.placeable_mines) && level.placeable_mines.size > 0) {
        str_key = getarraykeys(level.placeable_mines)[0];
        return level.placeable_mines[str_key];
    }
    return level.weaponnone;
}

// Namespace zm_placeable_mine
// Params 2, eflags: 0x1 linked
// Checksum 0xaa8a7e11, Offset: 0x3f8
// Size: 0x72
function add_mine_type(mine_name, str_retrieval_prompt) {
    init_internal();
    weaponobjects::function_daf3d8b3(mine_name, str_retrieval_prompt);
    level.placeable_mines[mine_name] = getweapon(mine_name);
    level.placeable_mine_planted_callbacks[mine_name] = [];
}

// Namespace zm_placeable_mine
// Params 1, eflags: 0x1 linked
// Checksum 0xc8230f66, Offset: 0x478
// Size: 0x92
function add_weapon_to_mine_slot(mine_name) {
    init_internal();
    level.placeable_mines[mine_name] = getweapon(mine_name);
    level.placeable_mine_planted_callbacks[mine_name] = [];
    if (!isdefined(level.placeable_mines_in_name_only)) {
        level.placeable_mines_in_name_only = [];
    }
    level.placeable_mines_in_name_only[mine_name] = getweapon(mine_name);
}

// Namespace zm_placeable_mine
// Params 1, eflags: 0x0
// Checksum 0xf6d4cef8, Offset: 0x518
// Size: 0x18
function set_max_per_player(n_max_per_player) {
    level.placeable_mines_max_per_player = n_max_per_player;
}

// Namespace zm_placeable_mine
// Params 2, eflags: 0x1 linked
// Checksum 0x485a70a1, Offset: 0x538
// Size: 0xb0
function add_planted_callback(fn_planted_cb, wpn_name) {
    if (!isdefined(level.placeable_mine_planted_callbacks[wpn_name])) {
        level.placeable_mine_planted_callbacks[wpn_name] = [];
    } else if (!isarray(level.placeable_mine_planted_callbacks[wpn_name])) {
        level.placeable_mine_planted_callbacks[wpn_name] = array(level.placeable_mine_planted_callbacks[wpn_name]);
    }
    level.placeable_mine_planted_callbacks[wpn_name][level.placeable_mine_planted_callbacks[wpn_name].size] = fn_planted_cb;
}

// Namespace zm_placeable_mine
// Params 1, eflags: 0x5 linked
// Checksum 0x2d51c8f1, Offset: 0x5f0
// Size: 0xa0
function private run_planted_callbacks(e_planter) {
    foreach (fn in level.placeable_mine_planted_callbacks[self.weapon.name]) {
        self thread [[ fn ]](e_planter);
    }
}

// Namespace zm_placeable_mine
// Params 0, eflags: 0x5 linked
// Checksum 0xdf12834a, Offset: 0x698
// Size: 0x34
function private safe_to_plant() {
    if (isdefined(level.placeable_mines_max_per_player) && self.owner.placeable_mines.size >= level.placeable_mines_max_per_player) {
        return false;
    }
    return true;
}

// Namespace zm_placeable_mine
// Params 0, eflags: 0x5 linked
// Checksum 0xea0a8be2, Offset: 0x6d8
// Size: 0x2c
function private wait_and_detonate() {
    wait 0.1;
    self detonate(self.owner);
}

// Namespace zm_placeable_mine
// Params 1, eflags: 0x5 linked
// Checksum 0xf8466fe8, Offset: 0x710
// Size: 0x160
function private mine_watch(wpn_type) {
    self endon(#"death");
    self notify(#"mine_watch");
    self endon(#"mine_watch");
    while (true) {
        mine, fired_weapon = self waittill(#"grenade_fire");
        if (fired_weapon == wpn_type) {
            mine.owner = self;
            mine.team = self.team;
            mine.weapon = fired_weapon;
            self notify("zmb_enable_" + fired_weapon.name + "_prompt");
            if (mine safe_to_plant()) {
                mine run_planted_callbacks(self);
                self zm_stats::increment_client_stat(fired_weapon.name + "_planted");
                self zm_stats::increment_player_stat(fired_weapon.name + "_planted");
                continue;
            }
            mine thread wait_and_detonate();
        }
    }
}

// Namespace zm_placeable_mine
// Params 1, eflags: 0x1 linked
// Checksum 0xb8d25709, Offset: 0x878
// Size: 0x3a
function is_true_placeable_mine(mine_name) {
    if (!isdefined(level.placeable_mines_in_name_only)) {
        return true;
    }
    if (!isdefined(level.placeable_mines_in_name_only[mine_name])) {
        return true;
    }
    return false;
}

// Namespace zm_placeable_mine
// Params 2, eflags: 0x1 linked
// Checksum 0xe6820507, Offset: 0x8c0
// Size: 0x170
function setup_for_player(wpn_type, ui_model) {
    if (!isdefined(ui_model)) {
        ui_model = "hudItems.showDpadRight";
    }
    if (!isdefined(self.placeable_mines)) {
        self.placeable_mines = [];
    }
    if (isdefined(self.last_placeable_mine_uimodel)) {
        self clientfield::set_player_uimodel(self.last_placeable_mine_uimodel, 0);
    }
    if (is_true_placeable_mine(wpn_type.name)) {
        self thread mine_watch(wpn_type);
    }
    self giveweapon(wpn_type);
    self zm_utility::set_player_placeable_mine(wpn_type);
    self setactionslot(4, "weapon", wpn_type);
    startammo = wpn_type.startammo;
    if (startammo) {
        self setweaponammostock(wpn_type, startammo);
    }
    if (isdefined(ui_model)) {
        self clientfield::set_player_uimodel(ui_model, 1);
    }
    self.last_placeable_mine_uimodel = ui_model;
}

// Namespace zm_placeable_mine
// Params 1, eflags: 0x1 linked
// Checksum 0x56bd53ea, Offset: 0xa38
// Size: 0x30
function disable_prompt_for_player(wpn_type) {
    self notify("zmb_disable_" + wpn_type.name + "_prompt");
}

// Namespace zm_placeable_mine
// Params 0, eflags: 0x1 linked
// Checksum 0x97206e3d, Offset: 0xa70
// Size: 0x8a
function disable_all_prompts_for_player() {
    foreach (mine in level.placeable_mines) {
        self disable_prompt_for_player(mine);
    }
}

// Namespace zm_placeable_mine
// Params 0, eflags: 0x5 linked
// Checksum 0xc346b41b, Offset: 0xb08
// Size: 0x2bc
function private pickup_placeable_mine() {
    player = self.owner;
    wpn_type = self.weapon;
    if (player.is_drinking > 0) {
        return;
    }
    current_player_mine = player zm_utility::get_player_placeable_mine();
    if (current_player_mine != wpn_type) {
        player takeweapon(current_player_mine);
    }
    if (!player hasweapon(wpn_type)) {
        player thread mine_watch(wpn_type);
        player giveweapon(wpn_type);
        player zm_utility::set_player_placeable_mine(wpn_type);
        player setactionslot(4, "weapon", wpn_type);
        player setweaponammoclip(wpn_type, 0);
        player notify("zmb_enable_" + wpn_type.name + "_prompt");
    } else {
        clip_ammo = player getweaponammoclip(wpn_type);
        clip_max_ammo = wpn_type.clipsize;
        if (clip_ammo >= clip_max_ammo) {
            self zm_utility::destroy_ent();
            player disable_prompt_for_player(wpn_type);
            return;
        }
    }
    self zm_utility::pick_up();
    clip_ammo = player getweaponammoclip(wpn_type);
    clip_max_ammo = wpn_type.clipsize;
    if (clip_ammo >= clip_max_ammo) {
        player disable_prompt_for_player(wpn_type);
    }
    player zm_stats::increment_client_stat(wpn_type.name + "_pickedup");
    player zm_stats::increment_player_stat(wpn_type.name + "_pickedup");
}

// Namespace zm_placeable_mine
// Params 2, eflags: 0x5 linked
// Checksum 0x9c0ce992, Offset: 0xdd0
// Size: 0x54
function private pickup_placeable_mine_trigger_listener(trigger, player) {
    self thread pickup_placeable_mine_trigger_listener_enable(trigger, player);
    self thread pickup_placeable_mine_trigger_listener_disable(trigger, player);
}

// Namespace zm_placeable_mine
// Params 2, eflags: 0x5 linked
// Checksum 0x76825ad7, Offset: 0xe30
// Size: 0xb8
function private pickup_placeable_mine_trigger_listener_enable(trigger, player) {
    self endon(#"delete");
    self endon(#"death");
    while (true) {
        player util::waittill_any("zmb_enable_" + self.weapon.name + "_prompt", "spawned_player");
        if (!isdefined(trigger)) {
            return;
        }
        trigger triggerenable(1);
        trigger linkto(self);
    }
}

// Namespace zm_placeable_mine
// Params 2, eflags: 0x5 linked
// Checksum 0xe3d0407e, Offset: 0xef0
// Size: 0x98
function private pickup_placeable_mine_trigger_listener_disable(trigger, player) {
    self endon(#"delete");
    self endon(#"death");
    while (true) {
        player waittill("zmb_disable_" + self.weapon.name + "_prompt");
        if (!isdefined(trigger)) {
            return;
        }
        trigger unlink();
        trigger triggerenable(0);
    }
}

// Namespace zm_placeable_mine
// Params 0, eflags: 0x5 linked
// Checksum 0x69c4b4ee, Offset: 0xf90
// Size: 0x1ac
function private placeable_mine_damage() {
    self endon(#"death");
    self setcandamage(1);
    self.health = 100000;
    self.maxhealth = self.health;
    attacker = undefined;
    while (true) {
        amount, attacker = self waittill(#"damage");
        if (!isdefined(self)) {
            return;
        }
        self.health = self.maxhealth;
        if (!isplayer(attacker)) {
            continue;
        }
        if (isdefined(self.owner) && attacker == self.owner) {
            continue;
        }
        if (isdefined(attacker.pers) && isdefined(attacker.pers["team"]) && attacker.pers["team"] != level.zombie_team) {
            continue;
        }
        break;
    }
    if (level.satchelexplodethisframe) {
        wait 0.1 + randomfloat(0.4);
    } else {
        wait 0.05;
    }
    if (!isdefined(self)) {
        return;
    }
    level.satchelexplodethisframe = 1;
    thread reset_satchel_explode_this_frame();
    self detonate(attacker);
}

// Namespace zm_placeable_mine
// Params 0, eflags: 0x5 linked
// Checksum 0x36342f21, Offset: 0x1148
// Size: 0x18
function private reset_satchel_explode_this_frame() {
    wait 0.05;
    level.satchelexplodethisframe = 0;
}

// Namespace zm_placeable_mine
// Params 0, eflags: 0x5 linked
// Checksum 0x977c8570, Offset: 0x1168
// Size: 0x214
function private replenish_after_rounds() {
    while (true) {
        level waittill(#"between_round_over");
        if (isdefined(level.var_d109cb41)) {
            [[ level.var_d109cb41 ]]();
            continue;
        }
        if (!level flag::exists("teleporter_used") || !level flag::get("teleporter_used")) {
            players = getplayers();
            for (i = 0; i < players.size; i++) {
                foreach (mine in level.placeable_mines) {
                    if (players[i] zm_utility::is_player_placeable_mine(mine) && is_true_placeable_mine(mine.name)) {
                        players[i] giveweapon(mine);
                        players[i] zm_utility::set_player_placeable_mine(mine);
                        players[i] setactionslot(4, "weapon", mine);
                        players[i] setweaponammoclip(mine, 2);
                        break;
                    }
                }
            }
        }
    }
}

// Namespace zm_placeable_mine
// Params 0, eflags: 0x1 linked
// Checksum 0x9343b07d, Offset: 0x1388
// Size: 0x172
function setup_watchers() {
    if (isdefined(level.placeable_mines)) {
        foreach (mine_type in level.placeable_mines) {
            watcher = self weaponobjects::createuseweaponobjectwatcher(mine_type.name, self.team);
            watcher.onspawnretrievetriggers = &on_spawn_retrieve_trigger;
            watcher.adjusttriggerorigin = &adjust_trigger_origin;
            watcher.pickup = level.pickup_placeable_mine;
            watcher.pickup_trigger_listener = level.pickup_placeable_mine_trigger_listener;
            watcher.skip_weapon_object_damage = 1;
            watcher.headicon = 0;
            watcher.watchforfire = 1;
            watcher.ondetonatecallback = &placeable_mine_detonate;
            watcher.ondamage = level.placeable_mines_on_damage;
        }
    }
}

// Namespace zm_placeable_mine
// Params 2, eflags: 0x5 linked
// Checksum 0x7c620d33, Offset: 0x1508
// Size: 0x5c
function private on_spawn_retrieve_trigger(watcher, player) {
    self weaponobjects::function_26f3ad87(watcher, player);
    if (isdefined(self.pickuptrigger)) {
        self.pickuptrigger sethintlowpriority(0);
    }
}

// Namespace zm_placeable_mine
// Params 1, eflags: 0x5 linked
// Checksum 0xc501c98e, Offset: 0x1570
// Size: 0x28
function private adjust_trigger_origin(origin) {
    origin += (0, 0, 20);
    return origin;
}

// Namespace zm_placeable_mine
// Params 3, eflags: 0x5 linked
// Checksum 0x3fb965aa, Offset: 0x15a0
// Size: 0xcc
function private placeable_mine_detonate(attacker, weapon, target) {
    if (weapon.isemp) {
        self delete();
        return;
    }
    if (isdefined(attacker)) {
        self detonate(attacker);
        return;
    }
    if (isdefined(self.owner) && isplayer(self.owner)) {
        self detonate(self.owner);
        return;
    }
    self detonate();
}

