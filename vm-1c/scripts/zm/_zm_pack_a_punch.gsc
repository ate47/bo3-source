#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_util;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/aat_shared;
#using scripts/codescripts/struct;

#namespace namespace_d0ad3850;

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x2
// namespace_d0ad3850<file_0>::function_2dc19561
// Checksum 0x2b4f5016, Offset: 0x718
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_pack_a_punch", &__init__, &__main__, undefined);
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x1 linked
// namespace_d0ad3850<file_0>::function_8c87d8eb
// Checksum 0x994dddf, Offset: 0x760
// Size: 0x44
function __init__() {
    zm_pap_util::init_parameters();
    clientfield::register("zbarrier", "pap_working_FX", 5000, 1, "int");
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x1 linked
// namespace_d0ad3850<file_0>::function_5b6b9132
// Checksum 0x8dc97a36, Offset: 0x7b0
// Size: 0x10c
function __main__() {
    if (!isdefined(level.pap_zbarrier_state_func)) {
        level.pap_zbarrier_state_func = &process_pap_zbarrier_state;
    }
    spawn_init();
    vending_weapon_upgrade_trigger = zm_pap_util::function_f925b7b9();
    if (vending_weapon_upgrade_trigger.size >= 1) {
        array::thread_all(vending_weapon_upgrade_trigger, &function_c101a20e);
    }
    old_packs = getentarray("zombie_vending_upgrade", "targetname");
    for (i = 0; i < old_packs.size; i++) {
        vending_weapon_upgrade_trigger[vending_weapon_upgrade_trigger.size] = old_packs[i];
    }
    level flag::init("pack_machine_in_use");
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_bc6d6beb
// Checksum 0x90676372, Offset: 0x8c8
// Size: 0x484
function private spawn_init() {
    zbarriers = getentarray("zm_pack_a_punch", "targetname");
    for (i = 0; i < zbarriers.size; i++) {
        if (!zbarriers[i] iszbarrier()) {
            continue;
        }
        if (!isdefined(level.pack_a_punch.interaction_height)) {
            level.pack_a_punch.interaction_height = 35;
        }
        if (!isdefined(level.pack_a_punch.var_1adcb0d3)) {
            level.pack_a_punch.var_1adcb0d3 = 40;
        }
        if (!isdefined(level.pack_a_punch.interaction_trigger_height)) {
            level.pack_a_punch.interaction_trigger_height = 70;
        }
        use_trigger = spawn("trigger_radius_use", zbarriers[i].origin + (0, 0, level.pack_a_punch.interaction_height), 0, level.pack_a_punch.var_1adcb0d3, level.pack_a_punch.interaction_trigger_height);
        use_trigger.script_noteworthy = "pack_a_punch";
        use_trigger triggerignoreteam();
        use_trigger thread function_25b72b5f();
        use_trigger flag::init("pap_offering_gun");
        collision = spawn("script_model", zbarriers[i].origin, 1);
        collision.angles = zbarriers[i].angles;
        collision setmodel("zm_collision_perks1");
        collision.script_noteworthy = "clip";
        collision disconnectpaths();
        use_trigger.clip = collision;
        use_trigger.zbarrier = zbarriers[i];
        use_trigger.script_sound = "mus_perks_packa_jingle";
        use_trigger.script_label = "mus_perks_packa_sting";
        use_trigger.var_e1405ef7 = 1;
        use_trigger.target = "vending_packapunch";
        use_trigger.zbarrier.targetname = "vending_packapunch";
        powered_on = get_start_state();
        use_trigger.powered = zm_power::add_powered_item(&turn_on, &turn_off, &function_d948efbd, &cost_func, 0, powered_on, use_trigger);
        if (isdefined(level.pack_a_punch.custom_power_think)) {
            use_trigger thread [[ level.pack_a_punch.custom_power_think ]](powered_on);
        } else {
            use_trigger thread toggle_think(powered_on);
        }
        if (!isdefined(level.pack_a_punch.triggers)) {
            level.pack_a_punch.triggers = [];
        } else if (!isarray(level.pack_a_punch.triggers)) {
            level.pack_a_punch.triggers = array(level.pack_a_punch.triggers);
        }
        level.pack_a_punch.triggers[level.pack_a_punch.triggers.size] = use_trigger;
    }
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_25b72b5f
// Checksum 0x2df1e363, Offset: 0xd58
// Size: 0xe8
function private function_25b72b5f() {
    level endon(#"pack_a_punch_off");
    level waittill(#"pack_a_punch_on");
    self thread function_28497573();
    while (true) {
        foreach (e_player in level.players) {
            if (e_player istouching(self)) {
                self zm_pap_util::update_hint_string(e_player);
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_28497573
// Checksum 0xfd722404, Offset: 0xe48
// Size: 0x24
function private function_28497573() {
    level waittill(#"pack_a_punch_off");
    self thread function_25b72b5f();
}

// Namespace namespace_d0ad3850
// Params 5, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_c732917e
// Checksum 0x2fca6d05, Offset: 0xe78
// Size: 0x4bc
function private third_person_weapon_upgrade(current_weapon, upgrade_weapon, packa_rollers, pap_machine, trigger) {
    level endon(#"pack_a_punch_off");
    trigger endon(#"pap_player_disconnected");
    current_weapon = self getbuildkitweapon(current_weapon, 0);
    upgrade_weapon = self getbuildkitweapon(upgrade_weapon, 1);
    trigger.current_weapon = current_weapon;
    trigger.current_weapon_options = self getbuildkitweaponoptions(trigger.current_weapon);
    trigger.var_6ee636a9 = self getbuildkitattachmentcosmeticvariantindexes(trigger.current_weapon, 0);
    trigger.upgrade_weapon = upgrade_weapon;
    upgrade_weapon.var_a61c0755 = zm_weapons::function_11a37a(upgrade_weapon.var_a61c0755);
    trigger.upgrade_weapon_options = self getbuildkitweaponoptions(trigger.upgrade_weapon, upgrade_weapon.var_a61c0755);
    trigger.var_3242041a = self getbuildkitattachmentcosmeticvariantindexes(trigger.upgrade_weapon, 1);
    trigger.zbarrier setweapon(trigger.current_weapon);
    trigger.zbarrier setweaponoptions(trigger.current_weapon_options);
    trigger.zbarrier setattachmentcosmeticvariantindexes(trigger.var_6ee636a9);
    trigger.zbarrier set_pap_zbarrier_state("take_gun");
    var_e6ee24 = trigger.pap_machine;
    origin_offset = (0, 0, 0);
    angles_offset = (0, 0, 0);
    origin_base = self.origin;
    angles_base = self.angles;
    if (isdefined(var_e6ee24)) {
        origin_offset = (0, 0, level.pack_a_punch.interaction_height);
        angles_offset = (0, 90, 0);
        origin_base = var_e6ee24.origin;
        angles_base = var_e6ee24.angles;
    } else {
        var_e6ee24 = self;
    }
    forward = anglestoforward(angles_base + angles_offset);
    interact_offset = origin_offset + forward * -25;
    offsetdw = (3, 3, 3);
    pap_machine [[ level.pack_a_punch.var_1a77f755 ]](self, trigger, origin_offset, angles_offset);
    self playsound("zmb_perks_packa_upgrade");
    wait(0.35);
    wait(3);
    trigger.zbarrier setweapon(upgrade_weapon);
    trigger.zbarrier setweaponoptions(trigger.upgrade_weapon_options);
    trigger.zbarrier setattachmentcosmeticvariantindexes(trigger.var_3242041a);
    trigger.zbarrier set_pap_zbarrier_state("eject_gun");
    if (isdefined(self)) {
        self playsound("zmb_perks_packa_ready");
    } else {
        return;
    }
    var_e6ee24 thread [[ level.pack_a_punch.var_78a3b3e0 ]](self, trigger, origin_offset, interact_offset);
}

// Namespace namespace_d0ad3850
// Params 1, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_230466aa
// Checksum 0xe5e9c4e1, Offset: 0x1340
// Size: 0xe6
function private can_pack_weapon(weapon) {
    if (weapon.isriotshield) {
        return false;
    }
    if (level flag::get("pack_machine_in_use")) {
        return true;
    }
    if (!(isdefined(level.b_allow_idgun_pap) && level.b_allow_idgun_pap) && isdefined(level.idgun_weapons)) {
        if (isinarray(level.idgun_weapons, weapon)) {
            return false;
        }
    }
    weapon = self zm_weapons::get_nonalternate_weapon(weapon);
    if (!zm_weapons::is_weapon_or_base_included(weapon)) {
        return false;
    }
    if (!self zm_weapons::can_upgrade_weapon(weapon)) {
        return false;
    }
    return true;
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_8b30c8c2
// Checksum 0x572511ff, Offset: 0x1430
// Size: 0x100
function private player_use_can_pack_now() {
    if (isdefined(self.intermission) && (self laststand::player_is_in_laststand() || self.intermission) || self isthrowinggrenade()) {
        return false;
    }
    if (!self zm_magicbox::can_buy_weapon() || self bgb::is_enabled("zm_bgb_disorderly_combat")) {
        return false;
    }
    if (self zm_equipment::hacker_active()) {
        return false;
    }
    current_weapon = self getcurrentweapon();
    if (!self can_pack_weapon(current_weapon) && !zm_weapons::weapon_supports_aat(current_weapon)) {
        return false;
    }
    return true;
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_88d56c01
// Checksum 0x48227dce, Offset: 0x1538
// Size: 0x144
function private function_88d56c01() {
    self endon(#"death");
    self endon(#"pack_a_punch_off");
    self notify(#"hash_c29ef16b");
    self endon(#"hash_c29ef16b");
    while (true) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (isdefined(self.pack_player) && self.pack_player != players[i] || !players[i] player_use_can_pack_now() || players[i] bgb::is_active("zm_bgb_ephemeral_enhancement")) {
                self setinvisibletoplayer(players[i], 1);
                continue;
            }
            self setinvisibletoplayer(players[i], 0);
        }
        wait(0.1);
    }
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_c101a20e
// Checksum 0x31e2906d, Offset: 0x1688
// Size: 0xb88
function private function_c101a20e() {
    level endon(#"pack_a_punch_off");
    pap_machine = getent(self.target, "targetname");
    self.pap_machine = pap_machine;
    var_e0acf2a = getentarray("perksacola", "targetname");
    packa_rollers = spawn("script_origin", self.origin);
    packa_timer = spawn("script_origin", self.origin);
    packa_rollers linkto(self);
    packa_timer linkto(self);
    self usetriggerrequirelookat();
    self sethintstring(%ZOMBIE_NEED_POWER);
    self setcursorhint("HINT_NOICON");
    power_off = !self is_on();
    if (power_off) {
        var_db43bbe6 = [];
        var_db43bbe6[0] = pap_machine;
        level waittill(#"pack_a_punch_on");
    }
    self triggerenable(1);
    if (isdefined(level.pack_a_punch.power_on_callback)) {
        pap_machine thread [[ level.pack_a_punch.power_on_callback ]]();
    }
    self thread function_88d56c01();
    pap_machine playloopsound("zmb_perks_packa_loop");
    self thread shutoffpapsounds(pap_machine, packa_rollers, packa_timer);
    self thread function_45b5c3f2();
    for (;;) {
        self.pack_player = undefined;
        player = self waittill(#"trigger");
        if (isdefined(pap_machine.state) && pap_machine.state == "leaving") {
            continue;
        }
        index = zm_utility::get_player_index(player);
        current_weapon = player getcurrentweapon();
        current_weapon = player zm_weapons::switch_from_alt_weapon(current_weapon);
        if (isdefined(level.pack_a_punch.custom_validation)) {
            valid = self [[ level.pack_a_punch.custom_validation ]](player);
            if (!valid) {
                continue;
            }
        }
        if (!player zm_weapons::can_upgrade_weapon(current_weapon) && (isdefined(player.intermission) && (!player zm_magicbox::can_buy_weapon() || player laststand::player_is_in_laststand() || player.intermission) || player isthrowinggrenade() || !zm_weapons::weapon_supports_aat(current_weapon))) {
            wait(0.1);
            continue;
        }
        if (player isswitchingweapons()) {
            wait(0.1);
            if (player isswitchingweapons()) {
                continue;
            }
        }
        if (!zm_weapons::is_weapon_or_base_included(current_weapon)) {
            continue;
        }
        current_cost = self.cost;
        player.var_4eccd922 = undefined;
        player.restore_clip = undefined;
        player.restore_stock = undefined;
        var_c82b7e5a = undefined;
        player.restore_max = undefined;
        b_weapon_supports_aat = zm_weapons::weapon_supports_aat(current_weapon);
        var_ca548511 = 0;
        currentaathashid = -1;
        if (b_weapon_supports_aat) {
            current_cost = self.var_ebe0c72f;
            var_f360dd32 = player aat::getaatonweapon(current_weapon);
            if (isdefined(var_f360dd32)) {
                currentaathashid = var_f360dd32.hash_id;
            }
            player.var_4eccd922 = 1;
            player.restore_clip = player getweaponammoclip(current_weapon);
            player.restore_clip_size = current_weapon.clipsize;
            player.restore_stock = player getweaponammostock(current_weapon);
            player.restore_max = current_weapon.maxammo;
            var_ca548511 = 1;
        }
        if (player namespace_25f8c2ad::function_dc08b4af()) {
            current_cost = player namespace_25f8c2ad::function_4ef410da(current_cost);
        }
        if (!player zm_score::can_player_purchase(current_cost)) {
            self playsound("zmb_perks_packa_deny");
            if (isdefined(level.pack_a_punch.var_43867716)) {
                player [[ level.pack_a_punch.var_43867716 ]]();
            } else {
                player zm_audio::create_and_play_dialog("general", "outofmoney", 0);
            }
            continue;
        }
        self.pack_player = player;
        level flag::set("pack_machine_in_use");
        demo::bookmark("zm_player_use_packapunch", gettime(), player);
        player zm_stats::increment_client_stat("use_pap");
        player zm_stats::increment_player_stat("use_pap");
        weaponidx = undefined;
        if (isdefined(current_weapon)) {
            weaponidx = matchrecordgetweaponindex(current_weapon);
        }
        if (isdefined(weaponidx)) {
            if (!var_ca548511) {
                player recordmapevent(19, gettime(), player.origin, level.round_number, weaponidx, current_cost);
                player zm_stats::increment_challenge_stat("ZM_DAILY_PACK_5_WEAPONS");
                player zm_stats::increment_challenge_stat("ZM_DAILY_PACK_10_WEAPONS");
            } else {
                player recordmapevent(25, gettime(), player.origin, level.round_number, weaponidx, currentaathashid);
                player zm_stats::increment_challenge_stat("ZM_DAILY_REPACK_WEAPONS");
            }
        }
        self thread destroy_weapon_in_blackout(player);
        player zm_score::minus_to_player_score(current_cost);
        self thread zm_audio::sndperksjingles_player(1);
        player zm_audio::create_and_play_dialog("general", "pap_wait");
        self triggerenable(0);
        player thread function_4edd595f();
        self.current_weapon = current_weapon;
        upgrade_weapon = zm_weapons::get_upgrade_weapon(current_weapon, b_weapon_supports_aat);
        player third_person_weapon_upgrade(current_weapon, upgrade_weapon, packa_rollers, pap_machine, self);
        self triggerenable(1);
        self setcursorhint("HINT_WEAPON", upgrade_weapon);
        self flag::set("pap_offering_gun");
        if (isdefined(player)) {
            self setinvisibletoall();
            self setvisibletoplayer(player);
            self thread wait_for_player_to_take(player, current_weapon, packa_timer, b_weapon_supports_aat, var_ca548511);
            self thread wait_for_timeout(current_weapon, packa_timer, player, var_ca548511);
            self util::waittill_any("pap_timeout", "pap_taken", "pap_player_disconnected");
        } else {
            self wait_for_timeout(current_weapon, packa_timer, player, var_ca548511);
        }
        self.zbarrier set_pap_zbarrier_state("powered");
        self setcursorhint("HINT_NOICON");
        self.current_weapon = level.weaponnone;
        self flag::clear("pap_offering_gun");
        self thread function_88d56c01();
        self.pack_player = undefined;
        level flag::clear("pack_machine_in_use");
    }
}

// Namespace namespace_d0ad3850
// Params 3, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_21252065
// Checksum 0xcbc2b9b9, Offset: 0x2218
// Size: 0xb0
function private shutoffpapsounds(ent1, ent2, ent3) {
    while (true) {
        level waittill(#"pack_a_punch_off");
        level thread turnonpapsounds(ent1);
        ent1 stoploopsound(0.1);
        ent2 stoploopsound(0.1);
        ent3 stoploopsound(0.1);
    }
}

// Namespace namespace_d0ad3850
// Params 1, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_e5642b7e
// Checksum 0x8657725f, Offset: 0x22d0
// Size: 0x34
function private turnonpapsounds(ent) {
    level waittill(#"pack_a_punch_on");
    ent playloopsound("zmb_perks_packa_loop");
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_45b5c3f2
// Checksum 0x1b0b260d, Offset: 0x2310
// Size: 0x64
function private function_45b5c3f2() {
    level endon(#"pack_a_punch_off");
    while (true) {
        self.cost = 5000;
        self.var_ebe0c72f = 2500;
        level waittill(#"hash_ab83a4db");
        self.cost = 1000;
        self.var_ebe0c72f = 500;
        level waittill(#"bonfire_sale_off");
    }
}

// Namespace namespace_d0ad3850
// Params 5, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_f6432d4c
// Checksum 0xdff64bf0, Offset: 0x2380
// Size: 0x64c
function private wait_for_player_to_take(player, weapon, packa_timer, b_weapon_supports_aat, var_ca548511) {
    current_weapon = self.current_weapon;
    upgrade_weapon = self.upgrade_weapon;
    assert(isdefined(current_weapon), "pack_a_punch");
    assert(isdefined(upgrade_weapon), "pack_a_punch");
    self endon(#"pap_timeout");
    level endon(#"pack_a_punch_off");
    while (isdefined(player)) {
        packa_timer playloopsound("zmb_perks_packa_ticktock");
        trigger_player = self waittill(#"trigger");
        if (level.pack_a_punch.grabbable_by_anyone) {
            player = trigger_player;
        }
        packa_timer stoploopsound(0.05);
        if (trigger_player == player) {
            player zm_stats::increment_client_stat("pap_weapon_grabbed");
            player zm_stats::increment_player_stat("pap_weapon_grabbed");
            current_weapon = player getcurrentweapon();
            /#
                if (level.weaponnone == current_weapon) {
                    iprintlnbold("pack_a_punch");
                }
            #/
            if (zm_utility::is_player_valid(player) && !(player.is_drinking > 0) && !zm_utility::is_placeable_mine(current_weapon) && !zm_equipment::is_equipment(current_weapon) && !player zm_utility::is_player_revive_tool(current_weapon) && level.weaponnone != current_weapon && !player zm_equipment::hacker_active()) {
                demo::bookmark("zm_player_grabbed_packapunch", gettime(), player);
                self notify(#"pap_taken");
                player notify(#"pap_taken");
                player.pap_used = 1;
                weapon_limit = zm_utility::get_player_weapon_limit(player);
                player zm_weapons::take_fallback_weapon();
                primaries = player getweaponslistprimaries();
                if (isdefined(primaries) && primaries.size >= weapon_limit) {
                    upgrade_weapon = player zm_weapons::weapon_give(upgrade_weapon);
                } else {
                    upgrade_weapon = player zm_weapons::give_build_kit_weapon(upgrade_weapon);
                    player givestartammo(upgrade_weapon);
                }
                player notify(#"weapon_give", upgrade_weapon);
                aatid = -1;
                if (isdefined(b_weapon_supports_aat) && b_weapon_supports_aat) {
                    player thread aat::acquire(upgrade_weapon);
                    aatobj = player aat::getaatonweapon(upgrade_weapon);
                    if (isdefined(aatobj)) {
                        aatid = aatobj.hash_id;
                    }
                } else {
                    player thread aat::remove(upgrade_weapon);
                }
                weaponidx = undefined;
                if (isdefined(weapon)) {
                    weaponidx = matchrecordgetweaponindex(weapon);
                }
                if (isdefined(weaponidx)) {
                    if (!var_ca548511) {
                        player recordmapevent(27, gettime(), player.origin, level.round_number, weaponidx, aatid);
                    } else {
                        player recordmapevent(28, gettime(), player.origin, level.round_number, weaponidx, aatid);
                    }
                }
                player switchtoweapon(upgrade_weapon);
                if (isdefined(player.var_4eccd922) && player.var_4eccd922) {
                    new_clip = player.restore_clip + upgrade_weapon.clipsize - player.restore_clip_size;
                    new_stock = player.restore_stock + upgrade_weapon.maxammo - player.restore_max;
                    player setweaponammostock(upgrade_weapon, new_stock);
                    player setweaponammoclip(upgrade_weapon, new_clip);
                }
                player.var_4eccd922 = undefined;
                player.restore_clip = undefined;
                player.restore_stock = undefined;
                player.restore_max = undefined;
                player.restore_clip_size = undefined;
                player zm_weapons::play_weapon_vo(upgrade_weapon);
                return;
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_d0ad3850
// Params 4, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_369019ca
// Checksum 0x36eaffd3, Offset: 0x29d8
// Size: 0x204
function private wait_for_timeout(weapon, packa_timer, player, var_ca548511) {
    self endon(#"pap_taken");
    self endon(#"pap_player_disconnected");
    self thread wait_for_disconnect(player);
    wait(level.pack_a_punch.timeout);
    self notify(#"pap_timeout");
    packa_timer stoploopsound(0.05);
    packa_timer playsound("zmb_perks_packa_deny");
    if (isdefined(player)) {
        player zm_stats::increment_client_stat("pap_weapon_not_grabbed");
        player zm_stats::increment_player_stat("pap_weapon_not_grabbed");
        weaponidx = undefined;
        if (isdefined(weapon)) {
            weaponidx = matchrecordgetweaponindex(weapon);
        }
        if (isdefined(weaponidx)) {
            if (!var_ca548511) {
                player recordmapevent(20, gettime(), player.origin, level.round_number, weaponidx);
                return;
            }
            aatonweapon = player aat::getaatonweapon(weapon);
            aathash = -1;
            if (isdefined(aatonweapon)) {
                aathash = aatonweapon.hash_id;
            }
            player recordmapevent(26, gettime(), player.origin, level.round_number, weaponidx, aathash);
        }
    }
}

// Namespace namespace_d0ad3850
// Params 1, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_d4889b6b
// Checksum 0x6c21b74e, Offset: 0x2be8
// Size: 0x62
function private wait_for_disconnect(player) {
    self endon(#"pap_taken");
    self endon(#"pap_timeout");
    while (isdefined(player)) {
        wait(0.1);
    }
    println("pack_a_punch");
    self notify(#"pap_player_disconnected");
}

// Namespace namespace_d0ad3850
// Params 1, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_ce1e5936
// Checksum 0xefa9743c, Offset: 0x2c58
// Size: 0xa4
function private destroy_weapon_in_blackout(player) {
    self endon(#"pap_timeout");
    self endon(#"pap_taken");
    self endon(#"pap_player_disconnected");
    level waittill(#"pack_a_punch_off");
    self.zbarrier set_pap_zbarrier_state("take_gun");
    player playlocalsound(level.zmb_laugh_alias);
    wait(1.5);
    self.zbarrier set_pap_zbarrier_state("power_off");
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_4edd595f
// Checksum 0x2e8ec0da, Offset: 0x2d08
// Size: 0x74
function private function_4edd595f() {
    self endon(#"disconnect");
    self function_bfc21a18();
    self util::waittill_any("fake_death", "death", "player_downed", "weapon_change_complete");
    self function_5f10c30c();
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_bfc21a18
// Checksum 0x783b0945, Offset: 0x2d88
// Size: 0x13c
function private function_bfc21a18() {
    self zm_utility::increment_is_drinking();
    self zm_utility::disable_player_move_states(1);
    primaries = self getweaponslistprimaries();
    original_weapon = self getcurrentweapon();
    weapon = getweapon("zombie_knuckle_crack");
    if (original_weapon != level.weaponnone && !zm_utility::is_placeable_mine(original_weapon) && !zm_equipment::is_equipment(original_weapon)) {
        self notify(#"hash_987c489b");
        self takeweapon(original_weapon);
    } else {
        return;
    }
    self giveweapon(weapon);
    self switchtoweapon(weapon);
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_5f10c30c
// Checksum 0x22bd43a8, Offset: 0x2ed0
// Size: 0x104
function private function_5f10c30c() {
    self zm_utility::enable_player_move_states();
    weapon = getweapon("zombie_knuckle_crack");
    if (isdefined(self.intermission) && (self laststand::player_is_in_laststand() || self.intermission)) {
        self takeweapon(weapon);
        return;
    }
    self zm_utility::decrement_is_drinking();
    self takeweapon(weapon);
    primaries = self getweaponslistprimaries();
    if (self.is_drinking > 0) {
        return;
    }
    self zm_weapons::switch_back_primary_weapon();
}

// Namespace namespace_d0ad3850
// Params 3, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_d948efbd
// Checksum 0xf4f4e538, Offset: 0x2fe0
// Size: 0xf2
function private function_d948efbd(delta, origin, radius) {
    if (isdefined(self.target)) {
        paporigin = self.target.origin;
        if (isdefined(self.target.trigger_off) && self.target.trigger_off) {
            paporigin = self.target.realorigin;
        } else if (isdefined(self.target.disabled) && self.target.disabled) {
            paporigin += (0, 0, 10000);
        }
        if (distancesquared(paporigin, origin) < radius * radius) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_d0ad3850
// Params 2, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_58adff7c
// Checksum 0x221abc61, Offset: 0x30e0
// Size: 0x42
function private turn_on(origin, radius) {
    println("pack_a_punch");
    level notify(#"pack_a_punch_on");
}

// Namespace namespace_d0ad3850
// Params 2, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_91c0b9aa
// Checksum 0x21cebb9d, Offset: 0x3130
// Size: 0x6c
function private turn_off(origin, radius) {
    println("pack_a_punch");
    level notify(#"pack_a_punch_off");
    self.target notify(#"death");
    self.target thread function_c101a20e();
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_a8fcf257
// Checksum 0xb9b8c0ff, Offset: 0x31a8
// Size: 0x22
function private is_on() {
    if (isdefined(self.powered)) {
        return self.powered.power;
    }
    return 0;
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_221925f0
// Checksum 0x95727f74, Offset: 0x31d8
// Size: 0x22
function private get_start_state() {
    if (isdefined(level.vending_machines_powered_on_at_start) && level.vending_machines_powered_on_at_start) {
        return true;
    }
    return false;
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_774657d3
// Checksum 0xac719ad8, Offset: 0x3208
// Size: 0x6e
function private cost_func() {
    if (isdefined(self.one_time_cost)) {
        cost = self.one_time_cost;
        self.one_time_cost = undefined;
        return cost;
    }
    if (isdefined(level._power_global) && level._power_global) {
        return 0;
    }
    if (isdefined(self.self_powered) && self.self_powered) {
        return 0;
    }
    return 1;
}

// Namespace namespace_d0ad3850
// Params 1, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_80d5ed1c
// Checksum 0x4a89c120, Offset: 0x3280
// Size: 0xa4
function private toggle_think(powered_on) {
    if (!powered_on) {
        self.zbarrier set_pap_zbarrier_state("initial");
        level waittill(#"pack_a_punch_on");
    }
    for (;;) {
        self.zbarrier set_pap_zbarrier_state("power_on");
        level waittill(#"pack_a_punch_off");
        self.zbarrier set_pap_zbarrier_state("power_off");
        level waittill(#"pack_a_punch_on");
    }
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_80630ca5
// Checksum 0xb6fb840b, Offset: 0x3330
// Size: 0x3c
function private pap_initial() {
    self zbarrierpieceuseattachweapon(3);
    self setzbarrierpiecestate(0, "closed");
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_2f78cdc4
// Checksum 0x5671f2ce, Offset: 0x3378
// Size: 0x24
function private pap_power_off() {
    self setzbarrierpiecestate(0, "closing");
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_1a50a82e
// Checksum 0x922584aa, Offset: 0x33a8
// Size: 0x9c
function private pap_power_on() {
    self endon(#"zbarrier_state_change");
    self setzbarrierpiecestate(0, "opening");
    while (self getzbarrierpiecestate(0) == "opening") {
        wait(0.05);
    }
    self playsound("zmb_perks_power_on");
    self thread set_pap_zbarrier_state("powered");
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_5287da71
// Checksum 0x309c4005, Offset: 0x3450
// Size: 0xf0
function private pap_powered() {
    self endon(#"zbarrier_state_change");
    self setzbarrierpiecestate(4, "closed");
    if (self.classname === "zbarrier_zm_castle_packapunch" || self.classname === "zbarrier_zm_tomb_packapunch") {
        self clientfield::set("pap_working_FX", 0);
    }
    while (true) {
        wait(randomfloatrange(-76, 1800));
        self setzbarrierpiecestate(4, "opening");
        wait(randomfloatrange(-76, 1800));
        self setzbarrierpiecestate(4, "closing");
    }
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_d87a0841
// Checksum 0x7aab39d1, Offset: 0x3548
// Size: 0xb4
function private pap_take_gun() {
    self setzbarrierpiecestate(1, "opening");
    self setzbarrierpiecestate(2, "opening");
    self setzbarrierpiecestate(3, "opening");
    wait(0.1);
    if (self.classname === "zbarrier_zm_castle_packapunch" || self.classname === "zbarrier_zm_tomb_packapunch") {
        self clientfield::set("pap_working_FX", 1);
    }
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_465af671
// Checksum 0x1c6ca453, Offset: 0x3608
// Size: 0x64
function private pap_eject_gun() {
    self setzbarrierpiecestate(1, "closing");
    self setzbarrierpiecestate(2, "closing");
    self setzbarrierpiecestate(3, "closing");
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_52aa32cd
// Checksum 0xbc096c7b, Offset: 0x3678
// Size: 0x82
function private pap_leaving() {
    self setzbarrierpiecestate(5, "closing");
    do {
        wait(0.05);
    } while (self getzbarrierpiecestate(5) == "closing");
    self setzbarrierpiecestate(5, "closed");
    self notify(#"leave_anim_done");
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_6a09ed4f
// Checksum 0xab54eab1, Offset: 0x3708
// Size: 0x9c
function private pap_arriving() {
    self endon(#"zbarrier_state_change");
    self setzbarrierpiecestate(0, "opening");
    while (self getzbarrierpiecestate(0) == "opening") {
        wait(0.05);
    }
    self playsound("zmb_perks_power_on");
    self thread set_pap_zbarrier_state("powered");
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x4
// namespace_d0ad3850<file_0>::function_709d39f9
// Checksum 0xbfb74bb9, Offset: 0x37b0
// Size: 0xa
function private get_pap_zbarrier_state() {
    return self.state;
}

// Namespace namespace_d0ad3850
// Params 1, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_185bf84d
// Checksum 0xe8b5831b, Offset: 0x37c8
// Size: 0x80
function private set_pap_zbarrier_state(state) {
    for (i = 0; i < self getnumzbarrierpieces(); i++) {
        self hidezbarrierpiece(i);
    }
    self notify(#"zbarrier_state_change");
    self [[ level.pap_zbarrier_state_func ]](state);
}

// Namespace namespace_d0ad3850
// Params 1, eflags: 0x5 linked
// namespace_d0ad3850<file_0>::function_8b443f5c
// Checksum 0x91bcefc5, Offset: 0x3850
// Size: 0x326
function private process_pap_zbarrier_state(state) {
    switch (state) {
    case 52:
        self showzbarrierpiece(0);
        self thread pap_initial();
        self.state = "initial";
        break;
    case 46:
        self showzbarrierpiece(0);
        self thread pap_power_off();
        self.state = "power_off";
        break;
    case 53:
        self showzbarrierpiece(0);
        self thread pap_power_on();
        self.state = "power_on";
        break;
    case 41:
        self showzbarrierpiece(4);
        self thread pap_powered();
        self.state = "powered";
        break;
    case 16:
        self showzbarrierpiece(1);
        self showzbarrierpiece(2);
        self showzbarrierpiece(3);
        self thread pap_take_gun();
        self.state = "take_gun";
        break;
    case 18:
        self showzbarrierpiece(1);
        self showzbarrierpiece(2);
        self showzbarrierpiece(3);
        self thread pap_eject_gun();
        self.state = "eject_gun";
        break;
    case 27:
        self showzbarrierpiece(5);
        self thread pap_leaving();
        self.state = "leaving";
        break;
    case 60:
        self showzbarrierpiece(0);
        self thread pap_arriving();
        self.state = "arriving";
        break;
    case 61:
        self.state = "hidden";
        break;
    default:
        if (isdefined(level.var_f61b6c1)) {
            self [[ level.var_f61b6c1 ]](state);
        }
        break;
    }
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x1 linked
// namespace_d0ad3850<file_0>::function_42295108
// Checksum 0x40cb1afe, Offset: 0x3b80
// Size: 0x24
function set_state_initial() {
    self set_pap_zbarrier_state("initial");
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x1 linked
// namespace_d0ad3850<file_0>::function_fcf61f94
// Checksum 0xadcbddb1, Offset: 0x3bb0
// Size: 0x24
function set_state_leaving() {
    self set_pap_zbarrier_state("leaving");
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x1 linked
// namespace_d0ad3850<file_0>::function_1f8fb8c4
// Checksum 0x788533d, Offset: 0x3be0
// Size: 0x24
function set_state_arriving() {
    self set_pap_zbarrier_state("arriving");
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x1 linked
// namespace_d0ad3850<file_0>::function_d05da5ed
// Checksum 0xf57fea00, Offset: 0x3c10
// Size: 0x24
function set_state_power_on() {
    self set_pap_zbarrier_state("power_on");
}

// Namespace namespace_d0ad3850
// Params 0, eflags: 0x1 linked
// namespace_d0ad3850<file_0>::function_3dd52fe8
// Checksum 0xd3c7e32d, Offset: 0x3c40
// Size: 0x24
function set_state_hidden() {
    self set_pap_zbarrier_state("hidden");
}

