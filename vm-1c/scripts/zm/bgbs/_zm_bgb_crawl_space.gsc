#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_crawl_space;

// Namespace zm_bgb_crawl_space
// Params 0, eflags: 0x2
// Checksum 0x97f9be4a, Offset: 0x1b0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_crawl_space", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_crawl_space
// Params 0, eflags: 0x0
// Checksum 0x83252f4c, Offset: 0x1f0
// Size: 0x54
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_crawl_space", "activated", 5, undefined, undefined, undefined, &activation);
}

// Namespace zm_bgb_crawl_space
// Params 0, eflags: 0x0
// Checksum 0xbb425f2f, Offset: 0x250
// Size: 0x116
function activation() {
    a_ai = getaiarray();
    for (i = 0; i < a_ai.size; i++) {
        if (isdefined(a_ai[i]) && isalive(a_ai[i]) && a_ai[i].archetype === "zombie" && isdefined(a_ai[i].gibdef)) {
            var_5a3ad5d6 = distancesquared(self.origin, a_ai[i].origin);
            if (var_5a3ad5d6 < 360000) {
                a_ai[i] zombie_utility::makezombiecrawler();
            }
        }
    }
}

