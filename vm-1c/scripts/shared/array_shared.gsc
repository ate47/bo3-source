#using scripts/shared/util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace array;

// Namespace array
// Params 8, eflags: 0x1 linked
// Checksum 0x48f2ea9e, Offset: 0x120
// Size: 0x19e
function filter(&array, b_keep_keys, func_filter, arg1, arg2, arg3, arg4, arg5) {
    a_new = [];
    foreach (key, val in array) {
        if (util::single_func(self, func_filter, val, arg1, arg2, arg3, arg4, arg5)) {
            if (isstring(key) || isweapon(key)) {
                if (isdefined(b_keep_keys) && !b_keep_keys) {
                    a_new[a_new.size] = val;
                } else {
                    a_new[key] = val;
                }
                continue;
            }
            if (isdefined(b_keep_keys) && b_keep_keys) {
                a_new[key] = val;
                continue;
            }
            a_new[a_new.size] = val;
        }
    }
    return a_new;
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0xae5f9937, Offset: 0x2c8
// Size: 0x3a
function remove_dead(&array, b_keep_keys) {
    return filter(array, b_keep_keys, &_filter_dead);
}

// Namespace array
// Params 1, eflags: 0x1 linked
// Checksum 0xca3cbb34, Offset: 0x310
// Size: 0x12
function _filter_undefined(val) {
    return isdefined(val);
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0x1c8eb978, Offset: 0x330
// Size: 0x3a
function remove_undefined(&array, b_keep_keys) {
    return filter(array, b_keep_keys, &_filter_undefined);
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0xe5050ba, Offset: 0x378
// Size: 0x14e
function cleanup(&array, var_ec434b96) {
    if (!isdefined(var_ec434b96)) {
        var_ec434b96 = 0;
    }
    a_keys = getarraykeys(array);
    for (i = a_keys.size - 1; i >= 0; i--) {
        key = a_keys[i];
        if (isarray(array[key]) && array[key].size) {
            cleanup(array[key], var_ec434b96);
            continue;
        }
        if (!var_ec434b96 && isarray(array[key]) && (!isdefined(array[key]) || !array[key].size)) {
            arrayremoveindex(array, key);
        }
    }
}

// Namespace array
// Params 3, eflags: 0x1 linked
// Checksum 0xfd64d624, Offset: 0x4d0
// Size: 0x4a
function filter_classname(&array, b_keep_keys, str_classname) {
    return filter(array, b_keep_keys, &_filter_classname, str_classname);
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0xd43d8948, Offset: 0x528
// Size: 0x3a
function get_touching(&array, b_keep_keys) {
    return filter(array, b_keep_keys, &istouching);
}

// Namespace array
// Params 3, eflags: 0x1 linked
// Checksum 0x2d00f0bb, Offset: 0x570
// Size: 0xec
function remove_index(array, index, b_keep_keys) {
    a_new = [];
    foreach (key, val in array) {
        if (key == index) {
            continue;
        }
        if (isdefined(b_keep_keys) && b_keep_keys) {
            a_new[key] = val;
            continue;
        }
        a_new[a_new.size] = val;
    }
    return a_new;
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0x38f99515, Offset: 0x668
// Size: 0xfa
function delete_all(&array, is_struct) {
    foreach (ent in array) {
        if (isdefined(ent)) {
            if (isdefined(is_struct) && is_struct) {
                ent struct::delete();
                continue;
            }
            if (isdefined(ent.__vtable)) {
                ent notify(#"death");
                ent = undefined;
                continue;
            }
            ent delete();
        }
    }
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0xfc87acd1, Offset: 0x770
// Size: 0x8e
function notify_all(&array, str_notify) {
    foreach (elem in array) {
        elem notify(str_notify);
    }
}

// Namespace array
// Params 8, eflags: 0x1 linked
// Checksum 0xbfc1eda4, Offset: 0x808
// Size: 0x4cc
function thread_all(&entities, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    assert(isdefined(entities), "<dev string:x28>");
    assert(isdefined(func), "<dev string:x5b>");
    if (isarray(entities)) {
        if (isdefined(arg6)) {
            foreach (ent in entities) {
                ent thread [[ func ]](arg1, arg2, arg3, arg4, arg5, arg6);
            }
        } else if (isdefined(arg5)) {
            foreach (ent in entities) {
                ent thread [[ func ]](arg1, arg2, arg3, arg4, arg5);
            }
        } else if (isdefined(arg4)) {
            foreach (ent in entities) {
                ent thread [[ func ]](arg1, arg2, arg3, arg4);
            }
        } else if (isdefined(arg3)) {
            foreach (ent in entities) {
                ent thread [[ func ]](arg1, arg2, arg3);
            }
        } else if (isdefined(arg2)) {
            foreach (ent in entities) {
                ent thread [[ func ]](arg1, arg2);
            }
        } else if (isdefined(arg1)) {
            foreach (ent in entities) {
                ent thread [[ func ]](arg1);
            }
        } else {
            foreach (ent in entities) {
                ent thread [[ func ]]();
            }
        }
        return;
    }
    util::single_thread(entities, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace array
// Params 7, eflags: 0x1 linked
// Checksum 0xc4372881, Offset: 0xce0
// Size: 0x16c
function thread_all_ents(&entities, func, arg1, arg2, arg3, arg4, arg5) {
    assert(isdefined(entities), "<dev string:x8a>");
    assert(isdefined(func), "<dev string:xc2>");
    if (isarray(entities)) {
        if (entities.size) {
            keys = getarraykeys(entities);
            for (i = 0; i < keys.size; i++) {
                util::single_thread(self, func, entities[keys[i]], arg1, arg2, arg3, arg4, arg5);
            }
        }
        return;
    }
    util::single_thread(self, func, entities, arg1, arg2, arg3, arg4, arg5);
}

// Namespace array
// Params 8, eflags: 0x1 linked
// Checksum 0x3c895dc1, Offset: 0xe58
// Size: 0x4cc
function run_all(&entities, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    assert(isdefined(entities), "<dev string:xf6>");
    assert(isdefined(func), "<dev string:x126>");
    if (isarray(entities)) {
        if (isdefined(arg6)) {
            foreach (ent in entities) {
                ent [[ func ]](arg1, arg2, arg3, arg4, arg5, arg6);
            }
        } else if (isdefined(arg5)) {
            foreach (ent in entities) {
                ent [[ func ]](arg1, arg2, arg3, arg4, arg5);
            }
        } else if (isdefined(arg4)) {
            foreach (ent in entities) {
                ent [[ func ]](arg1, arg2, arg3, arg4);
            }
        } else if (isdefined(arg3)) {
            foreach (ent in entities) {
                ent [[ func ]](arg1, arg2, arg3);
            }
        } else if (isdefined(arg2)) {
            foreach (ent in entities) {
                ent [[ func ]](arg1, arg2);
            }
        } else if (isdefined(arg1)) {
            foreach (ent in entities) {
                ent [[ func ]](arg1);
            }
        } else {
            foreach (ent in entities) {
                ent [[ func ]]();
            }
        }
        return;
    }
    util::single_func(entities, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0xc2768df0, Offset: 0x1330
// Size: 0xf0
function exclude(array, array_exclude) {
    newarray = array;
    if (isarray(array_exclude)) {
        foreach (exclude_item in array_exclude) {
            arrayremovevalue(newarray, exclude_item);
        }
    } else {
        arrayremovevalue(newarray, array_exclude);
    }
    return newarray;
}

// Namespace array
// Params 3, eflags: 0x1 linked
// Checksum 0x416f7f3a, Offset: 0x1428
// Size: 0x72
function add(&array, item, allow_dupes) {
    if (!isdefined(allow_dupes)) {
        allow_dupes = 1;
    }
    if (isdefined(item)) {
        if (allow_dupes || !isinarray(array, item)) {
            array[array.size] = item;
        }
    }
}

// Namespace array
// Params 3, eflags: 0x1 linked
// Checksum 0xea169ce6, Offset: 0x14a8
// Size: 0xd2
function add_sorted(&array, item, allow_dupes) {
    if (!isdefined(allow_dupes)) {
        allow_dupes = 1;
    }
    if (isdefined(item)) {
        if (allow_dupes || !isinarray(array, item)) {
            for (i = 0; i <= array.size; i++) {
                if (i == array.size || item <= array[i]) {
                    arrayinsert(array, item, i);
                    break;
                }
            }
        }
    }
}

// Namespace array
// Params 3, eflags: 0x1 linked
// Checksum 0xf8dcb179, Offset: 0x1588
// Size: 0x16e
function wait_till(&array, notifies, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    s_tracker = spawnstruct();
    s_tracker._wait_count = 0;
    foreach (ent in array) {
        if (isdefined(ent)) {
            ent thread util::timeout(n_timeout, &util::_waitlogic, s_tracker, notifies);
        }
    }
    if (s_tracker._wait_count > 0) {
        s_tracker waittill(#"waitlogic_finished");
    }
}

// Namespace array
// Params 4, eflags: 0x1 linked
// Checksum 0xf010e87b, Offset: 0x1700
// Size: 0x1b6
function wait_till_match(&array, str_notify, str_match, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    s_tracker = spawnstruct();
    s_tracker._array_wait_count = 0;
    foreach (ent in array) {
        if (isdefined(ent)) {
            s_tracker._array_wait_count++;
            ent thread util::timeout(n_timeout, &_waitlogic_match, s_tracker, str_notify, str_match);
            ent thread util::timeout(n_timeout, &_waitlogic_death, s_tracker);
        }
    }
    if (s_tracker._array_wait_count > 0) {
        s_tracker waittill(#"array_wait");
    }
}

// Namespace array
// Params 3, eflags: 0x1 linked
// Checksum 0xc6a73a2a, Offset: 0x18c0
// Size: 0x4c
function _waitlogic_match(s_tracker, str_notify, str_match) {
    self endon(#"death");
    self waittillmatch(str_notify, str_match);
    update_waitlogic_tracker(s_tracker);
}

// Namespace array
// Params 1, eflags: 0x1 linked
// Checksum 0xc0595426, Offset: 0x1918
// Size: 0x2c
function _waitlogic_death(s_tracker) {
    self waittill(#"death");
    update_waitlogic_tracker(s_tracker);
}

// Namespace array
// Params 1, eflags: 0x1 linked
// Checksum 0x4abf1116, Offset: 0x1950
// Size: 0x40
function update_waitlogic_tracker(s_tracker) {
    s_tracker._array_wait_count--;
    if (s_tracker._array_wait_count == 0) {
        s_tracker notify(#"array_wait");
    }
}

// Namespace array
// Params 2, eflags: 0x0
// Checksum 0x99a39a50, Offset: 0x1998
// Size: 0xcc
function flag_wait(&array, str_flag) {
    do {
        var_51b0e732 = 0;
        for (i = 0; i < array.size; i++) {
            ent = array[i];
            if (isdefined(ent) && !ent flag::get(str_flag)) {
                ent util::waittill_either("death", str_flag);
                var_51b0e732 = 1;
                break;
            }
        }
    } while (var_51b0e732);
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0x838c7c25, Offset: 0x1a70
// Size: 0xcc
function flagsys_wait(&array, str_flag) {
    do {
        var_51b0e732 = 0;
        for (i = 0; i < array.size; i++) {
            ent = array[i];
            if (isdefined(ent) && !ent flagsys::get(str_flag)) {
                ent util::waittill_either("death", str_flag);
                var_51b0e732 = 1;
                break;
            }
        }
    } while (var_51b0e732);
}

// Namespace array
// Params 2, eflags: 0x21 linked variadic
// Checksum 0x46708e91, Offset: 0x1b48
// Size: 0x150
function flagsys_wait_any_flag(&array, ...) {
    do {
        var_51b0e732 = 0;
        for (i = 0; i < array.size; i++) {
            ent = array[i];
            if (isdefined(ent)) {
                b_flag_set = 0;
                foreach (str_flag in vararg) {
                    if (ent flagsys::get(str_flag)) {
                        b_flag_set = 1;
                        break;
                    }
                }
                if (!b_flag_set) {
                    ent util::function_c7f20692(vararg);
                    var_51b0e732 = 1;
                }
            }
        }
    } while (var_51b0e732);
}

// Namespace array
// Params 2, eflags: 0x0
// Checksum 0x8dc809c9, Offset: 0x1ca0
// Size: 0xbc
function flagsys_wait_any(&array, str_flag) {
    foreach (ent in array) {
        if (ent flagsys::get(str_flag)) {
            return ent;
        }
    }
    wait_any(array, str_flag);
}

// Namespace array
// Params 2, eflags: 0x0
// Checksum 0x117caedc, Offset: 0x1d68
// Size: 0x9e
function flag_wait_clear(&array, str_flag) {
    do {
        var_51b0e732 = 0;
        for (i = 0; i < array.size; i++) {
            ent = array[i];
            if (ent flag::get(str_flag)) {
                ent waittill(str_flag);
                var_51b0e732 = 1;
            }
        }
    } while (var_51b0e732);
}

// Namespace array
// Params 3, eflags: 0x1 linked
// Checksum 0x629872e9, Offset: 0x1e10
// Size: 0x10e
function flagsys_wait_clear(&array, str_flag, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    do {
        var_51b0e732 = 0;
        for (i = 0; i < array.size; i++) {
            ent = array[i];
            if (isdefined(ent) && ent flagsys::get(str_flag)) {
                ent waittill(str_flag);
                var_51b0e732 = 1;
            }
        }
    } while (var_51b0e732);
}

// Namespace array
// Params 3, eflags: 0x1 linked
// Checksum 0xfe2df630, Offset: 0x1f28
// Size: 0x164
function wait_any(array, msg, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    s_tracker = spawnstruct();
    foreach (ent in array) {
        if (isdefined(ent)) {
            level thread util::timeout(n_timeout, &_waitlogic2, s_tracker, ent, msg);
        }
    }
    s_tracker endon(#"array_wait");
    wait_till(array, "death");
}

// Namespace array
// Params 3, eflags: 0x1 linked
// Checksum 0x9dfd6d35, Offset: 0x2098
// Size: 0x6c
function _waitlogic2(s_tracker, ent, msg) {
    s_tracker endon(#"array_wait");
    if (msg != "death") {
        ent endon(#"death");
    }
    ent util::function_c7f20692(msg);
    s_tracker notify(#"array_wait");
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0x633ad1f, Offset: 0x2110
// Size: 0xcc
function flag_wait_any(array, str_flag) {
    self endon(#"death");
    foreach (ent in array) {
        if (ent flag::get(str_flag)) {
            return ent;
        }
    }
    wait_any(array, str_flag);
}

// Namespace array
// Params 1, eflags: 0x1 linked
// Checksum 0xc1adb6a4, Offset: 0x21e8
// Size: 0x68
function random(array) {
    if (array.size > 0) {
        keys = getarraykeys(array);
        return array[keys[randomint(keys.size)]];
    }
}

// Namespace array
// Params 1, eflags: 0x1 linked
// Checksum 0xb435e2ce, Offset: 0x2258
// Size: 0x9c
function randomize(array) {
    for (i = 0; i < array.size; i++) {
        j = randomint(array.size);
        temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    return array;
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0x6d15f724, Offset: 0x2300
// Size: 0x66
function function_4097a53e(array, n_size) {
    a_ret = [];
    for (i = 0; i < n_size; i++) {
        a_ret[i] = array[i];
    }
    return a_ret;
}

// Namespace array
// Params 1, eflags: 0x1 linked
// Checksum 0x64b3717f, Offset: 0x2370
// Size: 0x68
function reverse(array) {
    a_array2 = [];
    for (i = array.size - 1; i >= 0; i--) {
        a_array2[a_array2.size] = array[i];
    }
    return a_array2;
}

// Namespace array
// Params 1, eflags: 0x0
// Checksum 0x1d20894a, Offset: 0x23e0
// Size: 0xaa
function remove_keys(array) {
    a_new = [];
    foreach (val in array) {
        if (isdefined(val)) {
            a_new[a_new.size] = val;
        }
    }
    return a_new;
}

// Namespace array
// Params 3, eflags: 0x1 linked
// Checksum 0xcbcaada3, Offset: 0x2498
// Size: 0x5a
function swap(&array, index1, index2) {
    temp = array[index1];
    array[index1] = array[index2];
    array[index2] = temp;
}

// Namespace array
// Params 3, eflags: 0x1 linked
// Checksum 0x54e5164a, Offset: 0x2500
// Size: 0xc2
function pop(&array, index, b_keep_keys) {
    if (!isdefined(b_keep_keys)) {
        b_keep_keys = 1;
    }
    if (array.size > 0) {
        if (!isdefined(index)) {
            keys = getarraykeys(array);
            index = keys[0];
        }
        if (isdefined(array[index])) {
            ret = array[index];
            arrayremoveindex(array, index, b_keep_keys);
            return ret;
        }
    }
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0x97e768ca, Offset: 0x25d0
// Size: 0x82
function pop_front(&array, b_keep_keys) {
    if (!isdefined(b_keep_keys)) {
        b_keep_keys = 1;
    }
    keys = getarraykeys(array);
    index = keys[keys.size - 1];
    return pop(array, index, b_keep_keys);
}

// Namespace array
// Params 3, eflags: 0x1 linked
// Checksum 0xa246b8c, Offset: 0x2660
// Size: 0x104
function push(&array, val, index) {
    if (!isdefined(index)) {
        index = 0;
        foreach (key in getarraykeys(array)) {
            if (isint(key) && key >= index) {
                index = key + 1;
            }
        }
    }
    arrayinsert(array, val, index);
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0xb3701521, Offset: 0x2770
// Size: 0x34
function push_front(&array, val) {
    push(array, val, 0);
}

/#

    // Namespace array
    // Params 3, eflags: 0x0
    // Checksum 0x73f13020, Offset: 0x27b0
    // Size: 0x3c
    function function_b02c2d9b(org, &array, dist) {
        assert(0, "<dev string:x152>");
    }

#/

// Namespace array
// Params 3, eflags: 0x0
// Checksum 0x2803df89, Offset: 0x27f8
// Size: 0x4c
function function_8e7b4ab7(org, &array, dist) {
    if (!isdefined(dist)) {
        dist = undefined;
    }
    assert(0, "<dev string:x186>");
}

// Namespace array
// Params 2, eflags: 0x0
// Checksum 0xf131ca05, Offset: 0x2850
// Size: 0x1e
function closerfunc(dist1, dist2) {
    return dist1 >= dist2;
}

// Namespace array
// Params 2, eflags: 0x0
// Checksum 0xc1c365ed, Offset: 0x2878
// Size: 0x1e
function fartherfunc(dist1, dist2) {
    return dist1 <= dist2;
}

// Namespace array
// Params 5, eflags: 0x0
// Checksum 0x1d0b4f1c, Offset: 0x28a0
// Size: 0xc4
function get_all_farthest(org, &array, a_exclude, n_max, n_maxdist) {
    if (!isdefined(n_max)) {
        n_max = array.size;
    }
    a_ret = exclude(array, a_exclude);
    if (isdefined(n_maxdist)) {
        a_ret = arraysort(a_ret, org, 0, n_max, n_maxdist);
    } else {
        a_ret = arraysort(a_ret, org, 0, n_max);
    }
    return a_ret;
}

// Namespace array
// Params 5, eflags: 0x1 linked
// Checksum 0x388139b5, Offset: 0x2970
// Size: 0xcc
function get_all_closest(org, &array, a_exclude, n_max, n_maxdist) {
    if (!isdefined(n_max)) {
        n_max = array.size;
    }
    a_ret = exclude(array, a_exclude);
    if (isdefined(n_maxdist)) {
        a_ret = arraysort(a_ret, org, 1, n_max, n_maxdist);
    } else {
        a_ret = arraysort(a_ret, org, 1, n_max);
    }
    return a_ret;
}

// Namespace array
// Params 1, eflags: 0x1 linked
// Checksum 0x1874d73b, Offset: 0x2a48
// Size: 0x22
function alphabetize(&array) {
    return sort_by_value(array, 1);
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0x2fa18433, Offset: 0x2a78
// Size: 0x4a
function sort_by_value(&array, b_lowest_first) {
    if (!isdefined(b_lowest_first)) {
        b_lowest_first = 0;
    }
    return merge_sort(array, &function_4f5118cb, b_lowest_first);
}

// Namespace array
// Params 3, eflags: 0x1 linked
// Checksum 0x8fcaa61b, Offset: 0x2ad0
// Size: 0x40
function function_4f5118cb(val1, val2, b_lowest_first) {
    if (b_lowest_first) {
        return (val1 < val2);
    }
    return val1 > val2;
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0x602f5fb4, Offset: 0x2b18
// Size: 0x4a
function sort_by_script_int(&a_ents, b_lowest_first) {
    if (!isdefined(b_lowest_first)) {
        b_lowest_first = 0;
    }
    return merge_sort(a_ents, &function_d1b42ee9, b_lowest_first);
}

// Namespace array
// Params 3, eflags: 0x1 linked
// Checksum 0x7d1d00ff, Offset: 0x2b70
// Size: 0x62
function function_d1b42ee9(e1, e2, b_lowest_first) {
    if (b_lowest_first) {
        return (e1.script_int < e2.script_int);
    }
    return e1.script_int > e2.script_int;
}

// Namespace array
// Params 3, eflags: 0x1 linked
// Checksum 0xce74a113, Offset: 0x2be0
// Size: 0x1e4
function merge_sort(&current_list, func_sort, param) {
    if (current_list.size <= 1) {
        return current_list;
    }
    left = [];
    right = [];
    middle = current_list.size / 2;
    for (x = 0; x < middle; x++) {
        if (!isdefined(left)) {
            left = [];
        } else if (!isarray(left)) {
            left = array(left);
        }
        left[left.size] = current_list[x];
    }
    while (x < current_list.size) {
        if (!isdefined(right)) {
            right = [];
        } else if (!isarray(right)) {
            right = array(right);
        }
        right[right.size] = current_list[x];
        x++;
    }
    left = merge_sort(left, func_sort, param);
    right = merge_sort(right, func_sort, param);
    result = merge(left, right, func_sort, param);
    return result;
}

// Namespace array
// Params 4, eflags: 0x1 linked
// Checksum 0x88388d37, Offset: 0x2dd0
// Size: 0x192
function merge(left, right, func_sort, param) {
    result = [];
    li = 0;
    for (ri = 0; li < left.size && ri < right.size; ri++) {
        b_result = undefined;
        if (isdefined(param)) {
            b_result = [[ func_sort ]](left[li], right[ri], param);
        } else {
            b_result = [[ func_sort ]](left[li], right[ri]);
        }
        if (b_result) {
            result[result.size] = left[li];
            li++;
            continue;
        }
        result[result.size] = right[ri];
    }
    while (li < left.size) {
        result[result.size] = left[li];
        li++;
    }
    while (ri < right.size) {
        result[result.size] = right[ri];
        ri++;
    }
    return result;
}

// Namespace array
// Params 3, eflags: 0x1 linked
// Checksum 0x623bc17e, Offset: 0x2f70
// Size: 0xba
function function_5fee9333(&a, var_82126fd8, val) {
    if (!isdefined(a)) {
        a = [];
        a[0] = val;
        return;
    }
    for (i = 0; i < a.size; i++) {
        if ([[ var_82126fd8 ]](a[i], val) <= 0) {
            arrayinsert(a, val, i);
            return;
        }
    }
    a[a.size] = val;
}

// Namespace array
// Params 7, eflags: 0x1 linked
// Checksum 0xdc8831e9, Offset: 0x3038
// Size: 0x1bc
function spread_all(&entities, func, arg1, arg2, arg3, arg4, arg5) {
    assert(isdefined(entities), "<dev string:x1bb>");
    assert(isdefined(func), "<dev string:x1f3>");
    if (isarray(entities)) {
        foreach (ent in entities) {
            if (isdefined(ent)) {
                util::single_thread(ent, func, arg1, arg2, arg3, arg4, arg5);
            }
            wait randomfloatrange(0.0666667, 0.133333);
        }
        return;
    }
    util::single_thread(entities, func, arg1, arg2, arg3, arg4, arg5);
    wait randomfloatrange(0.0666667, 0.133333);
}

// Namespace array
// Params 2, eflags: 0x0
// Checksum 0x85a7d872, Offset: 0x3200
// Size: 0x3c
function wait_till_touching(&a_ents, e_volume) {
    while (!is_touching(a_ents, e_volume)) {
        wait 0.05;
    }
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0xad2808cd, Offset: 0x3248
// Size: 0xa4
function is_touching(&a_ents, e_volume) {
    foreach (e_ent in a_ents) {
        if (!e_ent istouching(e_volume)) {
            return false;
        }
    }
    return true;
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0xfb7e7375, Offset: 0x32f8
// Size: 0xbe
function contains(array_or_val, value) {
    if (isarray(array_or_val)) {
        foreach (element in array_or_val) {
            if (element === value) {
                return true;
            }
        }
        return false;
    }
    return array_or_val === value;
}

// Namespace array
// Params 1, eflags: 0x1 linked
// Checksum 0x1e69047e, Offset: 0x33c0
// Size: 0x22
function _filter_dead(val) {
    return isalive(val);
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0xdf98b053, Offset: 0x33f0
// Size: 0x32
function _filter_classname(val, arg) {
    return issubstr(val.classname, arg);
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0x807f5242, Offset: 0x3430
// Size: 0x3a
function quicksort(array, compare_func) {
    return quicksortmid(array, 0, array.size - 1, compare_func);
}

// Namespace array
// Params 4, eflags: 0x1 linked
// Checksum 0x866a62f6, Offset: 0x3478
// Size: 0x1de
function quicksortmid(array, start, end, compare_func) {
    i = start;
    k = end;
    if (!isdefined(compare_func)) {
        compare_func = &quicksort_compare;
    }
    if (end - start >= 1) {
        pivot = array[start];
        while (k > i) {
            while ([[ compare_func ]](array[i], pivot) && i <= end && k > i) {
                i++;
            }
            while (![[ compare_func ]](array[k], pivot) && k >= start && k >= i) {
                k--;
            }
            if (k > i) {
                swap(array, i, k);
            }
        }
        swap(array, start, k);
        array = quicksortmid(array, start, k - 1, compare_func);
        array = quicksortmid(array, k + 1, end, compare_func);
    } else {
        return array;
    }
    return array;
}

// Namespace array
// Params 2, eflags: 0x1 linked
// Checksum 0xb0a4b4ab, Offset: 0x3660
// Size: 0x1e
function quicksort_compare(left, right) {
    return left <= right;
}

