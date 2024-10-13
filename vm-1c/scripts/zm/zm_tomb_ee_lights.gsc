#using scripts/zm/zm_tomb_quest_crypt;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_tomb_ee_lights;

// Namespace zm_tomb_ee_lights
// Params 0, eflags: 0x1 linked
// Checksum 0xb7b91082, Offset: 0x388
// Size: 0x3de
function main() {
    clientfield::register("world", "light_show", 21000, 2, "int");
    level flag::init("show_morse_code");
    function_d4d827dc();
    while (!level flag::exists("start_zombie_round_logic")) {
        wait 0.5;
    }
    level flag::wait_till("start_zombie_round_logic");
    var_c0617dfa = getentarray("crypt_puzzle_disc", "script_noteworthy");
    var_9e71f2a3 = [];
    foreach (var_5868c432 in var_c0617dfa) {
        if (isdefined(var_5868c432.script_int)) {
            var_9e71f2a3[var_5868c432.script_int - 1] = var_5868c432;
        }
    }
    level flag::wait_till_any(array("ee_all_staffs_upgraded", "show_morse_code"));
    while (true) {
        clientfield::set("light_show", 1);
        if (randomint(100) < 10) {
            turn_all_lights_off(var_9e71f2a3);
            wait 10;
            clientfield::set("light_show", 3);
            function_8859f58a(var_9e71f2a3, "GIOVAN BATTISTA BELLASO");
            clientfield::set("light_show", 1);
        }
        turn_all_lights_off(var_9e71f2a3);
        wait 10;
        clientfield::set("light_show", 2);
        function_8859f58a(var_9e71f2a3, level.var_39f432c0);
        foreach (message in level.var_3f7b1f4c) {
            clientfield::set("light_show", 1);
            var_ff05a5e4 = function_bd0e42fc(message, level.var_39f432c0);
            turn_all_lights_off(var_9e71f2a3);
            wait 10;
            function_8859f58a(var_9e71f2a3, var_ff05a5e4);
        }
    }
}

// Namespace zm_tomb_ee_lights
// Params 0, eflags: 0x1 linked
// Checksum 0xaf88a798, Offset: 0x770
// Size: 0x3bc
function function_d4d827dc() {
    level.var_b81c6603 = [];
    level.var_b81c6603["A"] = ".-";
    level.var_b81c6603["B"] = "-...";
    level.var_b81c6603["C"] = "-.-.";
    level.var_b81c6603["D"] = "-..";
    level.var_b81c6603["E"] = ".";
    level.var_b81c6603["F"] = "..-.";
    level.var_b81c6603["G"] = "--.";
    level.var_b81c6603["H"] = "....";
    level.var_b81c6603["I"] = "..";
    level.var_b81c6603["J"] = ".---";
    level.var_b81c6603["K"] = "-.-";
    level.var_b81c6603["L"] = ".-..";
    level.var_b81c6603["M"] = "--";
    level.var_b81c6603["N"] = "-.";
    level.var_b81c6603["O"] = "---";
    level.var_b81c6603["P"] = ".--.";
    level.var_b81c6603["Q"] = "--.-";
    level.var_b81c6603["R"] = ".-.";
    level.var_b81c6603["S"] = "...";
    level.var_b81c6603["T"] = "-";
    level.var_b81c6603["U"] = "..-";
    level.var_b81c6603["V"] = "...-";
    level.var_b81c6603["W"] = ".--";
    level.var_b81c6603["X"] = "-..-";
    level.var_b81c6603["Y"] = "-.--";
    level.var_b81c6603["Z"] = "--..";
    level.var_3f7b1f4c = [];
    level.var_3f7b1f4c[0] = "WARN MESSINES";
    level.var_3f7b1f4c[1] = "SOMETHING BLUE IN THE EARTH";
    level.var_3f7b1f4c[2] = "NOT CLAY";
    level.var_3f7b1f4c[3] = "WE GREW WEAK";
    level.var_3f7b1f4c[4] = "THOUGHT IT WAS FLU";
    level.var_3f7b1f4c[5] = "MEN BECAME BEASTS";
    level.var_3f7b1f4c[6] = "BLOOD TURNED TO ASH";
    level.var_3f7b1f4c[7] = "LIBERATE TUTE DE INFERNIS";
    level.var_39f432c0 = "INFERNO";
}

// Namespace zm_tomb_ee_lights
// Params 1, eflags: 0x1 linked
// Checksum 0x8b90e740, Offset: 0xb38
// Size: 0x92
function turn_all_lights_off(var_8cbb315d) {
    foreach (var_5868c432 in var_8cbb315d) {
        var_5868c432 zm_tomb_quest_crypt::function_f78a1a6c(0);
    }
}

// Namespace zm_tomb_ee_lights
// Params 1, eflags: 0x1 linked
// Checksum 0xf8128bc9, Offset: 0xbd8
// Size: 0x92
function function_d0b291ec(var_8cbb315d) {
    foreach (var_5868c432 in var_8cbb315d) {
        var_5868c432 zm_tomb_quest_crypt::function_f78a1a6c(1);
    }
}

// Namespace zm_tomb_ee_lights
// Params 2, eflags: 0x1 linked
// Checksum 0xa8cec5f8, Offset: 0xc78
// Size: 0x1ac
function function_bd0e42fc(var_cc38a712, str_key) {
    var_ac99a070 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    var_932b937f = [];
    num = 0;
    for (i = 0; i < var_ac99a070.size; i++) {
        letter = var_ac99a070[i];
        var_932b937f[letter] = num;
        num++;
    }
    var_67c63931 = [];
    j = 0;
    for (i = 0; i < var_cc38a712.size; i++) {
        var_eebdb43b = str_key[j % str_key.size];
        var_3bb87ff3 = var_cc38a712[i];
        var_bc5fa1e4 = var_932b937f[var_3bb87ff3];
        if (!isdefined(var_bc5fa1e4)) {
            var_67c63931[var_67c63931.size] = var_3bb87ff3;
            continue;
        }
        var_e8d008a5 = var_932b937f[var_eebdb43b];
        var_70f872d1 = (var_bc5fa1e4 + var_e8d008a5) % var_ac99a070.size;
        var_67c63931[var_67c63931.size] = var_ac99a070[var_70f872d1];
        j++;
    }
    return var_67c63931;
}

// Namespace zm_tomb_ee_lights
// Params 2, eflags: 0x1 linked
// Checksum 0xb4e90173, Offset: 0xe30
// Size: 0x12e
function function_8859f58a(var_8cbb315d, message) {
    for (i = 0; i < message.size; i++) {
        letter = message[i];
        var_b3e9f5b = level.var_b81c6603[letter];
        if (isdefined(var_b3e9f5b)) {
            for (j = 0; j < var_b3e9f5b.size; j++) {
                function_d0b291ec(var_8cbb315d);
                if (var_b3e9f5b[j] == ".") {
                    wait 0.2;
                } else if (var_b3e9f5b[j] == "-") {
                    wait 1;
                }
                turn_all_lights_off(var_8cbb315d);
                wait 0.5;
            }
        } else {
            wait 2;
        }
        wait 1.5;
    }
}

