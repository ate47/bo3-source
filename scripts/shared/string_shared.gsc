#using scripts/shared/array_shared;

#namespace string;

/#

    // Namespace string
    // Params 3, eflags: 0x1 linked
    // Checksum 0xa8cce6fe, Offset: 0x98
    // Size: 0x10c
    function function_8e23acba(str_input, n_length, var_c50670d5) {
        if (!isdefined(var_c50670d5)) {
            var_c50670d5 = "<unknown string>";
        }
        if (var_c50670d5 == "<unknown string>") {
            var_c50670d5 = "<unknown string>";
        }
        /#
            assert(var_c50670d5.size == 1, "<unknown string>");
        #/
        str_input = "<unknown string>" + str_input;
        var_5ded4c4f = n_length - str_input.size;
        str_fill = "<unknown string>";
        if (var_5ded4c4f > 0) {
            for (i = 0; i < var_5ded4c4f; i++) {
                str_fill += var_c50670d5;
            }
        }
        return str_fill + str_input;
    }

#/
