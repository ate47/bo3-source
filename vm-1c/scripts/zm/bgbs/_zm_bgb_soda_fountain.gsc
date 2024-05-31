#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/array_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_soda_fountain;

// Namespace zm_bgb_soda_fountain
// Params 0, eflags: 0x2
// namespace_78eb0295<file_0>::function_2dc19561
// Checksum 0x53b3b716, Offset: 0x188
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_soda_fountain", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_soda_fountain
// Params 0, eflags: 0x1 linked
// namespace_78eb0295<file_0>::function_8c87d8eb
// Checksum 0x3f0c8e30, Offset: 0x1c8
// Size: 0x54
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_soda_fountain", "event", &event, undefined, undefined, undefined);
}

// Namespace zm_bgb_soda_fountain
// Params 0, eflags: 0x1 linked
// namespace_78eb0295<file_0>::function_279e4e97
// Checksum 0xf5a131a5, Offset: 0x228
// Size: 0x178
function event() {
    self endon(#"disconnect");
    self endon(#"bgb_update");
    self.var_76382430 = 5;
    while (self.var_76382430 > 0) {
        str_perk = self waittill(#"perk_purchased");
        self bgb::do_one_shot_use();
        a_str_perks = getarraykeys(level._custom_perks);
        if (isinarray(a_str_perks, str_perk)) {
            arrayremovevalue(a_str_perks, str_perk);
        }
        a_str_perks = array::randomize(a_str_perks);
        for (i = 0; i < a_str_perks.size; i++) {
            if (!self hasperk(a_str_perks[i])) {
                self zm_perks::give_perk(a_str_perks[i], 0);
                break;
            }
        }
        self.var_76382430--;
        self bgb::set_timer(self.var_76382430, 5);
    }
}

