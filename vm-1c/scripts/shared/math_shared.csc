#namespace math;

// Namespace math
// Params 3, eflags: 0x0
// Checksum 0xefad7952, Offset: 0x70
// Size: 0x54
function clamp(val, val_min, val_max) {
    if (val < val_min) {
        val = val_min;
    } else if (val > val_max) {
        val = val_max;
    }
    return val;
}

// Namespace math
// Params 5, eflags: 0x0
// Checksum 0x20f0638c, Offset: 0xd0
// Size: 0x6a
function linear_map(num, min_a, max_a, min_b, max_b) {
    return clamp((num - min_a) / (max_a - min_a) * (max_b - min_b) + min_b, min_b, max_b);
}

// Namespace math
// Params 4, eflags: 0x0
// Checksum 0x2d8e3beb, Offset: 0x148
// Size: 0xa6
function lag(desired, curr, k, dt) {
    r = 0;
    if (k * dt >= 1 || k <= 0) {
        r = desired;
    } else {
        err = desired - curr;
        r = curr + k * err * dt;
    }
    return r;
}

// Namespace math
// Params 1, eflags: 0x0
// Checksum 0xf2bcc5a7, Offset: 0x1f8
// Size: 0xb8
function array_average(array) {
    assert(isarray(array));
    assert(array.size > 0);
    total = 0;
    for (i = 0; i < array.size; i++) {
        total += array[i];
    }
    return total / array.size;
}

// Namespace math
// Params 2, eflags: 0x0
// Checksum 0xeef13f9a, Offset: 0x2b8
// Size: 0x132
function array_std_deviation(array, mean) {
    assert(isarray(array));
    assert(array.size > 0);
    tmp = [];
    for (i = 0; i < array.size; i++) {
        tmp[i] = (array[i] - mean) * (array[i] - mean);
    }
    total = 0;
    for (i = 0; i < tmp.size; i++) {
        total += tmp[i];
    }
    return sqrt(total / array.size);
}

// Namespace math
// Params 2, eflags: 0x0
// Checksum 0xd66952a, Offset: 0x3f8
// Size: 0xb4
function vector_compare(vec1, vec2) {
    return abs(vec1[0] - vec2[0]) < 0.001 && abs(vec1[1] - vec2[1]) < 0.001 && abs(vec1[2] - vec2[2]) < 0.001;
}

// Namespace math
// Params 1, eflags: 0x0
// Checksum 0xa5d827d6, Offset: 0x4b8
// Size: 0x6c
function random_vector(max_length) {
    return (randomfloatrange(-1 * max_length, max_length), randomfloatrange(-1 * max_length, max_length), randomfloatrange(-1 * max_length, max_length));
}

// Namespace math
// Params 2, eflags: 0x0
// Checksum 0xe2576ba5, Offset: 0x530
// Size: 0x76
function angle_dif(oldangle, newangle) {
    outvalue = (oldangle - newangle) % 360;
    if (outvalue < 0) {
        outvalue += 360;
    }
    if (outvalue > -76) {
        outvalue = (outvalue - 360) * -1;
    }
    return outvalue;
}

// Namespace math
// Params 1, eflags: 0x0
// Checksum 0x8b05057c, Offset: 0x5b0
// Size: 0x22
function sign(x) {
    if (x >= 0) {
        return 1;
    }
    return -1;
}

// Namespace math
// Params 0, eflags: 0x0
// Checksum 0xbd395a9d, Offset: 0x5e0
// Size: 0x20
function cointoss() {
    return randomint(100) >= 50;
}

