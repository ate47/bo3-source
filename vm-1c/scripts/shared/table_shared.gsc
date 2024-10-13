#namespace table;

// Namespace table
// Params 3, eflags: 0x1 linked
// Checksum 0xb1e72bda, Offset: 0x80
// Size: 0x280
function load(str_filename, str_table_start, b_convert_numbers) {
    if (!isdefined(b_convert_numbers)) {
        b_convert_numbers = 1;
    }
    a_table = [];
    n_header_row = tablelookuprownum(str_filename, 0, str_table_start);
    assert(n_header_row > -1, "<dev string:x28>");
    a_headers = tablelookuprow(str_filename, n_header_row);
    n_row = n_header_row + 1;
    do {
        a_row = tablelookuprow(str_filename, n_row);
        if (isdefined(a_row) && a_row.size > 0) {
            index = strstrip(a_row[0]);
            if (index != "") {
                if (index == "table_end") {
                    break;
                }
                if (b_convert_numbers) {
                    index = str_to_num(index);
                }
                a_table[index] = [];
                for (val = 1; val < a_row.size; val++) {
                    if (strstrip(a_headers[val]) != "" && strstrip(a_row[val]) != "") {
                        value = a_row[val];
                        if (b_convert_numbers) {
                            value = str_to_num(value);
                        }
                        a_table[index][a_headers[val]] = value;
                    }
                }
            }
        }
        n_row++;
    } while (isdefined(a_row) && a_row.size > 0);
    return a_table;
}

// Namespace table
// Params 1, eflags: 0x1 linked
// Checksum 0x3c48f56, Offset: 0x308
// Size: 0x7c
function str_to_num(value) {
    if (strisint(value)) {
        value = int(value);
    } else if (strisfloat(value)) {
        value = float(value);
    }
    return value;
}

