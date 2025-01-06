#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/util_shared;

#namespace array;

// Namespace array
// Params 8, eflags: 0x0
// Checksum 0x4ea9f1f3, Offset: 0x120
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
// Params 2, eflags: 0x0
// Checksum 0xedc67dd3, Offset: 0x2c8
// Size: 0x60
function remove_undefined(array, b_keep_keys) {
    if (isdefined(b_keep_keys)) {
        arrayremovevalue(array, undefined, b_keep_keys);
    } else {
        arrayremovevalue(array, undefined);
    }
    return array;
}

// Namespace array
// Params 2, eflags: 0x0
// Checksum 0xa1b25701, Offset: 0x330
// Size: 0x3a
function get_touching(&array, b_keep_keys) {
    return filter(array, b_keep_keys, &istouching);
}

// Namespace array
// Params 3, eflags: 0x0
// Checksum 0x33526f10, Offset: 0x378
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
// Params 2, eflags: 0x0
// Checksum 0xda7d54cd, Offset: 0x470
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
// Params 2, eflags: 0x0
// Checksum 0x3dae409a, Offset: 0x578
// Size: 0x8e
function notify_all(&array, str_notify) {
    foreach (elem in array) {
        elem notify(str_notify);
    }
}

// Namespace array
// Params 8, eflags: 0x0
// Checksum 0xe0409060, Offset: 0x610
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
// Params 7, eflags: 0x0
// Checksum 0x25d9a24f, Offset: 0xae8
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
// Params 8, eflags: 0x0
// Checksum 0x36deb30, Offset: 0xc60
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
// Params 2, eflags: 0x0
// Checksum 0xcfeb73c6, Offset: 0x1138
// Size: 0xa8
function exclude(array, array_exclude) {
    newarray = array;
    if (isarray(array_exclude)) {
        for (i = 0; i < array_exclude.size; i++) {
            arrayremovevalue(newarray, array_exclude[i]);
        }
    } else {
        arrayremovevalue(newarray, array_exclude);
    }
    return newarray;
}

// Namespace array
// Params 3, eflags: 0x0
// Checksum 0xa6b8ecb7, Offset: 0x11e8
// Size: 0x76
function add(&array, item, allow_dupes) {
    if (!isdefined(allow_dupes)) {
        allow_dupes = 1;
    }
    if (isdefined(item)) {
        if (allow_dupes || !isinarray(array, item)) {
            array[array.size] = item;
        }
    }
    return array;
}

// Namespace array
// Params 3, eflags: 0x0
// Checksum 0xe0c45f1e, Offset: 0x1268
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
// Params 3, eflags: 0x0
// Checksum 0x8f8fd719, Offset: 0x1348
// Size: 0x16e
function wait_till(&array, msg, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    s_tracker = spawnstruct();
    s_tracker._wait_count = 0;
    foreach (ent in array) {
        if (isdefined(ent)) {
            ent thread util::timeout(n_timeout, &util::_waitlogic, s_tracker, msg);
        }
    }
    if (s_tracker._wait_count > 0) {
        s_tracker waittill(#"waitlogic_finished");
    }
}

// Namespace array
// Params 2, eflags: 0x0
// Checksum 0x11947c1a, Offset: 0x14c0
// Size: 0x86
function flag_wait(&array, str_flag) {
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (!ent flag::get(str_flag)) {
            ent waittill(str_flag);
            i = -1;
        }
    }
}

// Namespace array
// Params 2, eflags: 0x0
// Checksum 0x110c2047, Offset: 0x1550
// Size: 0x86
function flagsys_wait(&array, str_flag) {
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (!ent flagsys::get(str_flag)) {
            ent waittill(str_flag);
            i = -1;
        }
    }
}

// Namespace array
// Params 2, eflags: 0x20 variadic
// Checksum 0x1733a161, Offset: 0x15e0
// Size: 0x138
function flagsys_wait_any_flag(&array, ...) {
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
                i = -1;
            }
        }
    }
}

// Namespace array
// Params 2, eflags: 0x0
// Checksum 0x172ab17a, Offset: 0x1720
// Size: 0x86
function flag_wait_clear(&array, str_flag) {
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (ent flag::get(str_flag)) {
            ent waittill(str_flag);
            i = -1;
        }
    }
}

// Namespace array
// Params 2, eflags: 0x0
// Checksum 0x23e66c2e, Offset: 0x17b0
// Size: 0x86
function flagsys_wait_clear(&array, str_flag) {
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (ent flagsys::get(str_flag)) {
            ent waittill(str_flag);
            i = -1;
        }
    }
}

// Namespace array
// Params 3, eflags: 0x0
// Checksum 0x24910351, Offset: 0x1840
// Size: 0x1f4
function wait_any(array, msg, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    s_tracker = spawnstruct();
    a_structs = [];
    foreach (ent in array) {
        if (isdefined(ent)) {
            s = spawnstruct();
            s thread util::timeout(n_timeout, &_waitlogic2, s_tracker, ent, msg);
            if (!isdefined(a_structs)) {
                a_structs = [];
            } else if (!isarray(a_structs)) {
                a_structs = array(a_structs);
            }
            a_structs[a_structs.size] = s;
        }
    }
    s_tracker endon(#"array_wait");
    wait_till(array, "death");
}

// Namespace array
// Params 3, eflags: 0x0
// Checksum 0xe122f8e2, Offset: 0x1a40
// Size: 0x50
function _waitlogic2(s_tracker, ent, msg) {
    s_tracker endon(#"array_wait");
    ent endon(#"death");
    ent waittill(msg);
    s_tracker notify(#"array_wait");
}

// Namespace array
// Params 2, eflags: 0x0
// Checksum 0xb9f72e12, Offset: 0x1a98
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
// Params 1, eflags: 0x0
// Checksum 0x37de7978, Offset: 0x1b70
// Size: 0x56
function random(array) {
    keys = getarraykeys(array);
    return array[keys[randomint(keys.size)]];
}

// Namespace array
// Params 1, eflags: 0x0
// Checksum 0x33e209a5, Offset: 0x1bd0
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
// Params 1, eflags: 0x0
// Checksum 0xbb8ca7ab, Offset: 0x1c78
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
// Checksum 0x1eedcd47, Offset: 0x1ce8
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
// Params 3, eflags: 0x0
// Checksum 0xc64da545, Offset: 0x1da0
// Size: 0xaa
function swap(&array, index1, index2) {
    assert(index1 < array.size, "<dev string:x152>");
    assert(index2 < array.size, "<dev string:x16e>");
    temp = array[index1];
    array[index1] = array[index2];
    array[index2] = temp;
}

// Namespace array
// Params 3, eflags: 0x0
// Checksum 0xb58035df, Offset: 0x1e58
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
// Params 2, eflags: 0x0
// Checksum 0xc2569658, Offset: 0x1f28
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
// Params 3, eflags: 0x0
// Checksum 0xef751fe6, Offset: 0x1fb8
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
// Params 2, eflags: 0x0
// Checksum 0xf0326f59, Offset: 0x20c8
// Size: 0x34
function push_front(&array, val) {
    push(array, val, 0);
}

// Namespace array
// Params 3, eflags: 0x0
// Checksum 0x5bcf3371, Offset: 0x2108
// Size: 0x4c
function function_b02c2d9b(org, &array, dist) {
    if (!isdefined(dist)) {
        dist = undefined;
    }
    assert(0, "<dev string:x18a>");
}

// Namespace array
// Params 3, eflags: 0x0
// Checksum 0xd538273a, Offset: 0x2160
// Size: 0x4c
function function_8e7b4ab7(org, &array, dist) {
    if (!isdefined(dist)) {
        dist = undefined;
    }
    assert(0, "<dev string:x1be>");
}

// Namespace array
// Params 2, eflags: 0x0
// Checksum 0x7d943098, Offset: 0x21b8
// Size: 0x1e
function closerfunc(dist1, dist2) {
    return dist1 >= dist2;
}

// Namespace array
// Params 2, eflags: 0x0
// Checksum 0xd36a7f6b, Offset: 0x21e0
// Size: 0x1e
function fartherfunc(dist1, dist2) {
    return dist1 <= dist2;
}

// Namespace array
// Params 4, eflags: 0x0
// Checksum 0x12bfba14, Offset: 0x2208
// Size: 0xdc
function get_all_farthest(org, &array, excluders, max) {
    sorted_array = function_b02c2d9b(org, array, excluders);
    if (isdefined(max)) {
        temp_array = [];
        for (i = 0; i < sorted_array.size; i++) {
            temp_array[temp_array.size] = sorted_array[sorted_array.size - i];
        }
        sorted_array = temp_array;
    }
    sorted_array = reverse(sorted_array);
    return sorted_array;
}

// Namespace array
// Params 5, eflags: 0x0
// Checksum 0xdebff42f, Offset: 0x22f0
// Size: 0x330
function get_all_closest(org, &array, excluders, max, maxdist) {
    if (!isdefined(max)) {
        max = array.size;
    }
    if (!isdefined(excluders)) {
        excluders = [];
    }
    maxdists2rd = undefined;
    if (isdefined(maxdist)) {
        maxdists2rd = maxdist * maxdist;
    }
    dist = [];
    index = [];
    for (i = 0; i < array.size; i++) {
        if (!isdefined(array[i])) {
            continue;
        }
        excluded = 0;
        for (p = 0; p < excluders.size; p++) {
            if (array[i] != excluders[p]) {
                continue;
            }
            excluded = 1;
            break;
        }
        if (excluded) {
            continue;
        }
        length = distancesquared(org, array[i].origin);
        if (isdefined(maxdists2rd) && maxdists2rd < length) {
            continue;
        }
        dist[dist.size] = length;
        index[index.size] = i;
    }
    for (;;) {
        change = 0;
        for (i = 0; i < dist.size - 1; i++) {
            if (dist[i] <= dist[i + 1]) {
                continue;
            }
            change = 1;
            temp = dist[i];
            dist[i] = dist[i + 1];
            dist[i + 1] = temp;
            temp = index[i];
            index[i] = index[i + 1];
            index[i + 1] = temp;
        }
        if (!change) {
            break;
        }
    }
    newarray = [];
    if (max > dist.size) {
        max = dist.size;
    }
    for (i = 0; i < max; i++) {
        newarray[i] = array[index[i]];
    }
    return newarray;
}

// Namespace array
// Params 1, eflags: 0x0
// Checksum 0xc5d2ad4, Offset: 0x2628
// Size: 0x22
function alphabetize(&array) {
    return sort_by_value(array, 1);
}

// Namespace array
// Params 2, eflags: 0x0
// Checksum 0xab0399a9, Offset: 0x2658
// Size: 0x4a
function sort_by_value(&array, b_lowest_first) {
    if (!isdefined(b_lowest_first)) {
        b_lowest_first = 0;
    }
    return merge_sort(array, &function_4f5118cb, b_lowest_first);
}

// Namespace array
// Params 3, eflags: 0x0
// Checksum 0xf5caeb0f, Offset: 0x26b0
// Size: 0x40
function function_4f5118cb(val1, val2, b_lowest_first) {
    if (b_lowest_first) {
        return (val1 < val2);
    }
    return val1 > val2;
}

// Namespace array
// Params 2, eflags: 0x0
// Checksum 0x1d35fde7, Offset: 0x26f8
// Size: 0x4a
function sort_by_script_int(&a_ents, b_lowest_first) {
    if (!isdefined(b_lowest_first)) {
        b_lowest_first = 0;
    }
    return merge_sort(a_ents, &function_d1b42ee9, b_lowest_first);
}

// Namespace array
// Params 3, eflags: 0x0
// Checksum 0xc7217c81, Offset: 0x2750
// Size: 0x62
function function_d1b42ee9(e1, e2, b_lowest_first) {
    if (b_lowest_first) {
        return (e1.script_int < e2.script_int);
    }
    return e1.script_int > e2.script_int;
}

// Namespace array
// Params 3, eflags: 0x0
// Checksum 0xe0fc88b5, Offset: 0x27c0
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
// Params 4, eflags: 0x0
// Checksum 0xc9ef56e8, Offset: 0x29b0
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
// Params 7, eflags: 0x0
// Checksum 0x69a07e96, Offset: 0x2b50
// Size: 0x1b4
function spread_all(&entities, func, arg1, arg2, arg3, arg4, arg5) {
    assert(isdefined(entities), "<dev string:x1f3>");
    assert(isdefined(func), "<dev string:x22b>");
    if (isarray(entities)) {
        foreach (ent in entities) {
            util::single_thread(ent, func, arg1, arg2, arg3, arg4, arg5);
            wait randomfloatrange(0.0666667, 0.133333);
        }
        return;
    }
    util::single_thread(entities, func, arg1, arg2, arg3, arg4, arg5);
    wait randomfloatrange(0.0666667, 0.133333);
}

