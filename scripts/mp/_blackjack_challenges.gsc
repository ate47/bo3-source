#using scripts/mp/_util;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/_challenges;
#using scripts/shared/weapons/_weapon_utils;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/drown;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace blackjack_challenges;

// Namespace blackjack_challenges
// Params 0, eflags: 0x2
// Checksum 0xc2d5bb97, Offset: 0x4d8
// Size: 0x34
function function_2dc19561() {
    system::register("blackjack_challenges", &__init__, undefined, undefined);
}

// Namespace blackjack_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xf1116abe, Offset: 0x518
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&start_gametype);
}

// Namespace blackjack_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xf65c330a, Offset: 0x548
// Size: 0xec
function start_gametype() {
    if (!isdefined(level.challengescallbacks)) {
        level.challengescallbacks = [];
    }
    waittillframeend();
    if (challenges::canprocesschallenges()) {
        challenges::registerchallengescallback("playerKilled", &challenge_kills);
        challenges::registerchallengescallback("roundEnd", &challenge_round_ended);
        challenges::registerchallengescallback("gameEnd", &challenge_game_ended);
        scoreevents::register_hero_ability_kill_event(&on_hero_ability_kill);
    }
    callback::on_connect(&on_player_connect);
}

// Namespace blackjack_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x5af21772, Offset: 0x640
// Size: 0x19a
function on_player_connect() {
    player = self;
    if (challenges::canprocesschallenges()) {
        specialistindex = player getspecialistindex();
        isblackjack = specialistindex == 9;
        if (isblackjack) {
            player thread track_blackjack_consumable();
            if (!isdefined(self.pers["blackjack_challenge_active"])) {
                remaining_time = player consumableget("blackjack", "awarded") - player consumableget("blackjack", "consumed");
                if (remaining_time > 0) {
                    special_card_earned = player get_challenge_stat("special_card_earned");
                    if (!special_card_earned) {
                        player.pers["blackjack_challenge_active"] = 1;
                        player.pers["blackjack_unique_specialist_kills"] = 0;
                        player.pers["blackjack_specialist_kills"] = 0;
                        player.pers["blackjack_unique_weapon_mask"] = 0;
                        player.pers["blackjack_unique_ability_mask"] = 0;
                    }
                }
            }
        }
    }
}

// Namespace blackjack_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x2bcd7258, Offset: 0x7e8
// Size: 0x1a
function is_challenge_active() {
    return self.pers["blackjack_challenge_active"] === 1;
}

// Namespace blackjack_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0xa91fbdb2, Offset: 0x810
// Size: 0x164
function on_hero_ability_kill(ability, victimability) {
    player = self;
    if (!isdefined(player) || !isplayer(player)) {
        return;
    }
    if (!isdefined(player.isroulette) || !player.isroulette) {
        return;
    }
    if (player is_challenge_active()) {
        player.pers["blackjack_specialist_kills"]++;
        currentheroabilitymask = player.pers["blackjack_unique_ability_mask"];
        heroabilitymask = get_hero_ability_mask(ability);
        newheroabilitymask = heroabilitymask | currentheroabilitymask;
        if (newheroabilitymask != currentheroabilitymask) {
            player.pers["blackjack_unique_specialist_kills"]++;
            player.pers["blackjack_unique_ability_mask"] = newheroabilitymask;
        }
        player check_blackjack_challenge();
    }
}

/#

    // Namespace blackjack_challenges
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd8e576b2, Offset: 0x980
    // Size: 0x44
    function debug_print_already_earned() {
        if (getdvarint("special_card_earned", 0) == 0) {
            return;
        }
        iprintln("special_card_earned");
    }

    // Namespace blackjack_challenges
    // Params 0, eflags: 0x1 linked
    // Checksum 0x24c67f26, Offset: 0x9d0
    // Size: 0x8c
    function debug_print_kill_info() {
        if (getdvarint("special_card_earned", 0) == 0) {
            return;
        }
        player = self;
        iprintln("special_card_earned" + player.pers["special_card_earned"] + "special_card_earned" + player.pers["special_card_earned"]);
    }

    // Namespace blackjack_challenges
    // Params 0, eflags: 0x1 linked
    // Checksum 0x16f15520, Offset: 0xa68
    // Size: 0x44
    function debug_print_earned() {
        if (getdvarint("special_card_earned", 0) == 0) {
            return;
        }
        iprintln("special_card_earned");
    }

#/

// Namespace blackjack_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x21829ff7, Offset: 0xab8
// Size: 0x10c
function check_blackjack_challenge() {
    player = self;
    /#
        debug_print_kill_info();
    #/
    special_card_earned = player get_challenge_stat("special_card_earned");
    if (special_card_earned) {
        /#
            debug_print_already_earned();
        #/
        return;
    }
    if (player.pers["blackjack_specialist_kills"] >= 4 && player.pers["blackjack_unique_specialist_kills"] >= 2) {
        player set_challenge_stat("special_card_earned", 1);
        player addplayerstat("blackjack_challenge", 1);
        /#
            debug_print_earned();
        #/
    }
}

// Namespace blackjack_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x9ae37cb, Offset: 0xbd0
// Size: 0x234
function challenge_kills(data) {
    attackeristhief = data.attackeristhief;
    attackerisroulette = data.attackerisroulette;
    attackeristhieforroulette = attackeristhief || attackerisroulette;
    if (!attackeristhieforroulette) {
        return;
    }
    victim = data.victim;
    attacker = data.attacker;
    player = attacker;
    weapon = data.weapon;
    if (!isdefined(weapon) || weapon == level.weaponnone) {
        return;
    }
    if (!isdefined(player) || !isplayer(player)) {
        return;
    }
    if (attackeristhief) {
        if (weapon.isheroweapon === 1) {
            if (player is_challenge_active()) {
                player.pers["blackjack_specialist_kills"]++;
                currentheroweaponmask = player.pers["blackjack_unique_weapon_mask"];
                heroweaponmask = get_hero_weapon_mask(attacker, weapon);
                newheroweaponmask = heroweaponmask | currentheroweaponmask;
                if (newheroweaponmask != currentheroweaponmask) {
                    player.pers["blackjack_unique_specialist_kills"] = player.pers["blackjack_unique_specialist_kills"] + 1;
                    player.pers["blackjack_unique_weapon_mask"] = newheroweaponmask;
                }
                player check_blackjack_challenge();
            }
        }
    }
}

// Namespace blackjack_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x850211dd, Offset: 0xe10
// Size: 0x2a
function get_challenge_stat(stat_name) {
    return self getdstat("tenthspecialistcontract", stat_name);
}

// Namespace blackjack_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0xb8464184, Offset: 0xe48
// Size: 0x3a
function set_challenge_stat(stat_name, stat_value) {
    return self setdstat("tenthspecialistcontract", stat_name, stat_value);
}

// Namespace blackjack_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0xd6a558f2, Offset: 0xe90
// Size: 0x14e
function get_hero_weapon_mask(attacker, weapon) {
    if (!isdefined(weapon)) {
        return 0;
    }
    if (isdefined(weapon.isheroweapon) && !weapon.isheroweapon) {
        return 0;
    }
    switch (weapon.name) {
    case 27:
    case 28:
        return 1;
    case 23:
        return 2;
    case 25:
    case 26:
        return 4;
    case 21:
    case 22:
        return 8;
    case 29:
    case 30:
        return 16;
    case 16:
        return 32;
    case 17:
    case 18:
    case 19:
    case 20:
        return 64;
    case 24:
        return -128;
    case 15:
        return 256;
    default:
        return 0;
    }
}

// Namespace blackjack_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x22012578, Offset: 0xfe8
// Size: 0xe2
function get_hero_ability_mask(ability) {
    if (!isdefined(ability)) {
        return 0;
    }
    switch (ability.name) {
    case 33:
        return 1;
    case 36:
        return 2;
    case 35:
        return 4;
    case 37:
        return 8;
    case 31:
        return 16;
    case 32:
        return 32;
    case 39:
        return 64;
    case 38:
        return -128;
    case 34:
        return 256;
    default:
        return 0;
    }
}

// Namespace blackjack_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xdd4ca033, Offset: 0x10d8
// Size: 0x9c
function challenge_game_ended(data) {
    if (!isdefined(data)) {
        return;
    }
    player = data.player;
    if (!isdefined(player)) {
        return;
    }
    if (!isplayer(player)) {
        return;
    }
    if (player util::is_bot()) {
        return;
    }
    if (!player is_challenge_active()) {
        return;
    }
    player report_consumable();
}

// Namespace blackjack_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xd4c7e9bd, Offset: 0x1180
// Size: 0x9c
function challenge_round_ended(data) {
    if (!isdefined(data)) {
        return;
    }
    player = data.player;
    if (!isdefined(player)) {
        return;
    }
    if (!isplayer(player)) {
        return;
    }
    if (player util::is_bot()) {
        return;
    }
    if (!player is_challenge_active()) {
        return;
    }
    player report_consumable();
}

// Namespace blackjack_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x872bf806, Offset: 0x1228
// Size: 0xd8
function track_blackjack_consumable() {
    level endon(#"game_ended");
    self notify(#"track_blackjack_consumable_singleton");
    self endon(#"track_blackjack_consumable_singleton");
    self endon(#"disconnect");
    player = self;
    if (!isdefined(player.last_blackjack_consumable_time)) {
        player.last_blackjack_consumable_time = 0;
    }
    while (isdefined(player)) {
        random_wait_time = getdvarfloat("mp_blackjack_consumable_wait", 20) + randomfloatrange(-5, 5);
        wait(random_wait_time);
        player report_consumable();
    }
}

// Namespace blackjack_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xaecf943d, Offset: 0x1308
// Size: 0x178
function report_consumable() {
    player = self;
    if (!isdefined(player)) {
        return;
    }
    if (!isdefined(player.timeplayed) || !isdefined(player.timeplayed["total"])) {
        return;
    }
    current_time_played = player.timeplayed["total"];
    time_to_report = current_time_played - player.last_blackjack_consumable_time;
    if (time_to_report > 0) {
        max_time_to_report = player consumableget("blackjack", "awarded") - player consumableget("blackjack", "consumed");
        consumable_increment = int(min(time_to_report, max_time_to_report));
        if (consumable_increment > 0) {
            player consumableincrement("blackjack", "consumed", consumable_increment);
        }
    }
    player.last_blackjack_consumable_time = current_time_played;
}

