#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/weapons/_bouncingbetty;
#using scripts/shared/weapons/_weaponobjects;

#namespace zm_genesis_amb;

// Namespace zm_genesis_amb
// Params 0, eflags: 0x0
// Checksum 0x25fad8dd, Offset: 0x1d0
// Size: 0x3c
function main() {
    level flag::init("ambient_solar_flares_on");
    level thread function_25b0085d();
}

// Namespace zm_genesis_amb
// Params 0, eflags: 0x0
// Checksum 0xdba4d479, Offset: 0x218
// Size: 0x238
function function_25b0085d() {
    level waittill(#"start_zombie_round_logic");
    if (getdvarint("splitscreen_playerCount") >= 2) {
        return;
    }
    level flag::set("ambient_solar_flares_on");
    while (true) {
        wait randomfloatrange(40, 60);
        var_9a813858 = 0;
        if (!level flag::get("ambient_solar_flares_on")) {
            level flag::wait_till("ambient_solar_flares_on");
        }
        do {
            str_target_zone = undefined;
            var_717fac8 = array::random(level.activeplayers);
            if (!isdefined(var_717fac8.var_a3d40b8)) {
                wait 0.5;
                continue;
            }
            str_zone = var_717fac8.var_a3d40b8;
            var_32db8f92 = strtok(str_zone, "_");
            str_target_zone = var_32db8f92[0];
            if (str_target_zone === "apothicon") {
                str_target_zone = undefined;
                wait 0.5;
                continue;
            }
            wait 0.05;
        } while (!isdefined(str_target_zone));
        if (str_target_zone == "start") {
            str_target_zone = "sheffield";
        }
        var_9949c988 = randomintrange(1, 4);
        var_3f75b0e3 = "lgtexp_solarflare_" + str_target_zone + "_0" + var_9949c988;
        exploder::exploder_duration(var_3f75b0e3, 4);
    }
}

