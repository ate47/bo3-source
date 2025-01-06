#using scripts/codescripts/struct;
#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#using_animtree("generic");

#namespace namespace_e44205a2;

// Namespace namespace_e44205a2
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x578
// Size: 0x4
function init() {
    
}

// Namespace namespace_e44205a2
// Params 0, eflags: 0x0
// Checksum 0x6af5eabc, Offset: 0x588
// Size: 0x1fc
function main() {
    namespace_d00ec32::function_36b56038(2, 64);
    level._effect["puke_reaction"] = "water/fx_liquid_vomit";
    level.cybercom.var_9b2c750e = spawnstruct();
    level.cybercom.var_9b2c750e.var_875da84b = &function_875da84b;
    level.cybercom.var_9b2c750e.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.var_9b2c750e.var_bdb47551 = &function_bdb47551;
    level.cybercom.var_9b2c750e.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.var_9b2c750e.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.var_9b2c750e._on = &_on;
    level.cybercom.var_9b2c750e._off = &_off;
    level.cybercom.var_9b2c750e.var_4135a1c4 = &function_4135a1c4;
    level.cybercom.var_9b2c750e.var_106f11dd = array("c_54i_cqb_head1", "c_nrc_cqb_head", "c_nrc_cqb_f_head", "c_54i_supp_head1", "c_54i_supp_head1", "c_nrc_sniper_head", "c_nrc_suppressor_head");
}

// Namespace namespace_e44205a2
// Params 1, eflags: 0x0
// Checksum 0xde61ff3e, Offset: 0x790
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_e44205a2
// Params 2, eflags: 0x0
// Checksum 0xf7208179, Offset: 0x7a8
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_e44205a2
// Params 2, eflags: 0x0
// Checksum 0xf4c16b13, Offset: 0x7c8
// Size: 0x1b4
function function_bdb47551(slot, weapon) {
    self.cybercom.var_110c156a = getdvarint("scr_mrpukey_target_count", 4);
    self.cybercom.var_cf33c5a4 = getdvarfloat("scr_pukey_fov", 0.968);
    if (self function_1a9006bd("cybercom_mrpukey") == 2) {
        self.cybercom.var_f72b478f = getdvarfloat("scr_pukey_upgraded_fov", 0.92);
        self.cybercom.var_110c156a = getdvarint("scr_mrpukey_target_count_upgraded", 5);
    }
    self.cybercom.var_9d8e0758 = &function_8aac802c;
    self.cybercom.var_c40accd3 = &function_602b28e9;
    self thread cybercom::function_b5f4e597(weapon);
    self cybercom::function_8257bcb3("base_rifle", 5);
    self cybercom::function_8257bcb3("fem_rifle", 5);
    self cybercom::function_8257bcb3("riotshield", 2);
}

// Namespace namespace_e44205a2
// Params 2, eflags: 0x0
// Checksum 0x14d873f9, Offset: 0x988
// Size: 0x62
function function_39ea6a1b(slot, weapon) {
    self _off(slot, weapon);
    self.cybercom.var_9d8e0758 = undefined;
    self.cybercom.var_c40accd3 = undefined;
    self.cybercom.var_f72b478f = undefined;
}

// Namespace namespace_e44205a2
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x9f8
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_e44205a2
// Params 2, eflags: 0x0
// Checksum 0x606eeadc, Offset: 0xa08
// Size: 0x54
function _on(slot, weapon) {
    self thread function_2de61c3f(slot, weapon);
    self _off(slot, weapon);
}

// Namespace namespace_e44205a2
// Params 2, eflags: 0x0
// Checksum 0x7bf646e9, Offset: 0xa68
// Size: 0x3a
function _off(slot, weapon) {
    self thread cybercom::function_d51412df(weapon);
    self.cybercom.var_301030f7 = undefined;
}

// Namespace namespace_e44205a2
// Params 2, eflags: 0x0
// Checksum 0x6a6d4cbc, Offset: 0xab0
// Size: 0xa8
function function_4135a1c4(slot, weapon) {
    if (!(isdefined(self.cybercom.var_301030f7) && self.cybercom.var_301030f7)) {
        assert(self.cybercom.var_2e20c9bd == weapon);
        self thread cybercom::function_2006f7d0(slot, weapon, self.cybercom.var_110c156a);
        self.cybercom.var_301030f7 = 1;
    }
}

// Namespace namespace_e44205a2
// Params 1, eflags: 0x4
// Checksum 0x13c08c9b, Offset: 0xb60
// Size: 0x200
function private function_602b28e9(target) {
    if (target cybercom::function_8fd8f5b1("cybercom_mrpukey")) {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (isdefined(target.is_disabled) && target.is_disabled) {
        self cybercom::function_29bf9dee(target, 6);
        return false;
    }
    if (isactor(target) && target cybercom::getentitypose() != "stand" && target cybercom::getentitypose() != "crouch") {
        return false;
    }
    if (isvehicle(target) || !isdefined(target.archetype)) {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (isactor(target) && target.archetype != "human" && target.archetype != "human_riotshield") {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (isactor(target) && !target isonground() && !target cybercom::function_421746e0()) {
        return false;
    }
    return true;
}

// Namespace namespace_e44205a2
// Params 1, eflags: 0x4
// Checksum 0xa7fa5be3, Offset: 0xd68
// Size: 0x52
function private function_8aac802c(weapon) {
    return arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
}

// Namespace namespace_e44205a2
// Params 2, eflags: 0x4
// Checksum 0xd3560dcd, Offset: 0xdc8
// Size: 0x2e4
function private function_2de61c3f(slot, weapon) {
    upgraded = self function_1a9006bd("cybercom_mrpukey") == 2;
    aborted = 0;
    fired = 0;
    foreach (item in self.cybercom.var_d1460543) {
        if (isdefined(item.inrange) && isdefined(item.target) && item.inrange) {
            if (item.inrange == 1) {
                if (!cybercom::function_7a7d1608(item.target, weapon)) {
                    continue;
                }
                self thread challenges::function_96ed590f("cybercom_uses_chaos");
                item.target thread _puke(upgraded, 0, self, weapon);
                fired++;
                continue;
            }
            if (item.inrange == 2) {
                aborted++;
            }
        }
    }
    if (aborted && !fired) {
        self.cybercom.var_d1460543 = [];
        self cybercom::function_29bf9dee(undefined, 1, 0);
    }
    cybercom::function_adc40f11(weapon, fired);
    if (fired && isplayer(self)) {
        itemindex = getitemindexfromref("cybercom_mrpukey");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "kills", "statValue", fired);
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
}

// Namespace namespace_e44205a2
// Params 4, eflags: 0x4
// Checksum 0xbdb74fcd, Offset: 0x10b8
// Size: 0x1ec
function private _puke(upgraded, secondary, attacker, weapon) {
    if (!isdefined(upgraded)) {
        upgraded = 0;
    }
    if (!isdefined(secondary)) {
        secondary = 0;
    }
    self notify(#"cybercom_action", weapon, attacker);
    weapon = getweapon("gadget_mrpukey");
    self.ignoreall = 1;
    self.is_disabled = 1;
    self dodamage(self.health + 666, self.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
    if (self function_ceb2ee11()) {
        self waittill(#"puke");
        playfxontag(level._effect["puke_reaction"], self, "j_neck");
        if (isdefined(self.voiceprefix) && isdefined(self.var_273d3e89)) {
            self thread battlechatter::function_81d8fcf2(self.voiceprefix + self.var_273d3e89 + "_puke", 1);
        }
        return;
    }
    wait 0.2;
    if (isdefined(self)) {
        if (isdefined(self.voiceprefix) && isdefined(self.var_273d3e89)) {
            self thread battlechatter::function_81d8fcf2(self.voiceprefix + self.var_273d3e89 + "_exert_sonic", 1);
        }
    }
}

// Namespace namespace_e44205a2
// Params 0, eflags: 0x0
// Checksum 0xada038db, Offset: 0x12b0
// Size: 0xa8
function function_ceb2ee11() {
    attachsize = self getattachsize();
    for (i = 0; i < attachsize; i++) {
        model_name = self getattachmodelname(i);
        if (isinarray(level.cybercom.var_9b2c750e.var_106f11dd, model_name)) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_e44205a2
// Params 3, eflags: 0x0
// Checksum 0x7b482510, Offset: 0x1360
// Size: 0x2ca
function function_da7ef8ba(target, var_9bc2efcb, upgraded) {
    if (!isdefined(var_9bc2efcb)) {
        var_9bc2efcb = 1;
    }
    if (!isdefined(target)) {
        return;
    }
    if (self.archetype != "human") {
        return;
    }
    validtargets = [];
    if (isarray(target)) {
        foreach (guy in target) {
            if (!function_602b28e9(guy)) {
                continue;
            }
            validtargets[validtargets.size] = guy;
        }
    } else {
        if (!function_602b28e9(target)) {
            return;
        }
        validtargets[validtargets.size] = target;
    }
    if (isdefined(var_9bc2efcb) && var_9bc2efcb) {
        type = self cybercom::function_5e3d3aa();
        self orientmode("face default");
        self animscripted("ai_cybercom_anim", self.origin, self.angles, "ai_base_rifle_" + type + "_exposed_cybercom_activate");
        self waittillmatch(#"ai_cybercom_anim", "fire");
    }
    weapon = getweapon("gadget_mrpukey");
    foreach (guy in validtargets) {
        if (!cybercom::function_7a7d1608(guy, weapon)) {
            continue;
        }
        guy thread _puke(upgraded, 0, self);
        wait 0.05;
    }
}

