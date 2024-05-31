#using scripts/shared/hostmigration_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace vehicle;

// Namespace vehicle
// Params 0, eflags: 0x2
// namespace_96fa87af<file_0>::function_2dc19561
// Checksum 0x740b637c, Offset: 0x390
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("vehicleriders", &__init__, undefined, undefined);
}

// Namespace vehicle
// Params 0, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_8c87d8eb
// Checksum 0xc57cf260, Offset: 0x3d0
// Size: 0x524
function __init__() {
    level.var_ca190c08 = [];
    level.var_ca190c08["all"] = "all";
    level.var_ca190c08["driver"] = "driver";
    level.var_ca190c08["passengers"] = "passenger";
    level.var_ca190c08["crew"] = "crew";
    level.var_ca190c08["gunners"] = "gunner";
    a_registered_fields = [];
    foreach (bundle in struct::get_script_bundles("vehicleriders")) {
        foreach (object in bundle.objects) {
            if (isstring(object.vehicleenteranim)) {
                array::add(a_registered_fields, object.position + "_enter", 0);
            }
            if (isstring(object.vehicleexitanim)) {
                array::add(a_registered_fields, object.position + "_exit", 0);
            }
            if (isstring(object.vehicleriderdeathanim)) {
                array::add(a_registered_fields, object.position + "_death", 0);
            }
        }
    }
    foreach (str_clientfield in a_registered_fields) {
        clientfield::register("vehicle", str_clientfield, 1, 1, "counter");
    }
    level.var_14c128 = [];
    level.var_14c128["driver"] = 0;
    for (i = 1; i <= 4; i++) {
        level.var_14c128["gunner" + i] = i;
    }
    var_2a391571 = 1;
    for (i = 4 + 1; i <= 10; i++) {
        level.var_14c128["passenger" + var_2a391571] = i;
        var_2a391571++;
    }
    foreach (s in struct::get_script_bundles("vehicleriders")) {
        if (!isdefined(s.var_1b5b8330)) {
            s.var_1b5b8330 = 0;
        }
        if (!isdefined(s.highexitlandheight)) {
            s.highexitlandheight = 32;
        }
    }
    callback::on_vehicle_spawned(&on_vehicle_spawned);
    callback::on_ai_spawned(&on_ai_spawned);
    callback::on_vehicle_killed(&on_vehicle_killed);
}

// Namespace vehicle
// Params 1, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_755f3ae5
// Checksum 0xb1f335ae, Offset: 0x900
// Size: 0x18
function function_755f3ae5(str_position) {
    return level.var_14c128[str_position];
}

// Namespace vehicle
// Params 0, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_82c5e7ec
// Checksum 0xdf4f3292, Offset: 0x920
// Size: 0x14
function on_vehicle_spawned() {
    spawn_riders();
}

// Namespace vehicle
// Params 0, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_87f30e90
// Checksum 0xbc203bf2, Offset: 0x940
// Size: 0x34
function on_ai_spawned() {
    if (isvehicle(self)) {
        self spawn_riders();
    }
}

// Namespace vehicle
// Params 2, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_cd99e01f
// Checksum 0x7348f1c3, Offset: 0x980
// Size: 0x9c
function function_cd99e01f(vh, str_pos) {
    array::add(vh.riders, self, 0);
    vh flagsys::set(str_pos + "occupied");
    self flagsys::set("vehiclerider");
    self thread function_86bcb302(vh, str_pos);
}

// Namespace vehicle
// Params 2, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_d3fa882a
// Checksum 0xaf4ad136, Offset: 0xa28
// Size: 0x7c
function function_d3fa882a(vh, str_pos) {
    arrayremovevalue(vh.riders, self);
    vh flagsys::clear(str_pos + "occupied");
    self flagsys::clear("vehiclerider");
}

// Namespace vehicle
// Params 2, eflags: 0x5 linked
// namespace_96fa87af<file_0>::function_86bcb302
// Checksum 0x310e2164, Offset: 0xab0
// Size: 0x5c
function private function_86bcb302(vh, str_pos) {
    vh endon(#"death");
    vh endon(str_pos + "occupied");
    self waittill(#"death");
    function_d3fa882a(vh, str_pos);
}

// Namespace vehicle
// Params 1, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_5a2fe36b
// Checksum 0x7e098a4e, Offset: 0xb18
// Size: 0x122
function function_5a2fe36b(ai) {
    foreach (s_rider in function_45c6f51b(ai).objects) {
        seat_index = function_755f3ae5(s_rider.position);
        if (seat_index <= 4) {
            if (self isvehicleseatoccupied(seat_index)) {
                continue;
            }
        }
        if (!flagsys::get(s_rider.position + "occupied")) {
            return s_rider.position;
        }
    }
}

// Namespace vehicle
// Params 0, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_ccac797e
// Checksum 0xd8eb495a, Offset: 0xc48
// Size: 0x11a
function spawn_riders() {
    self endon(#"death");
    self.riders = [];
    if (isdefined(self.script_vehicleride)) {
        a_spawners = getspawnerarray(self.script_vehicleride, "script_vehicleride");
        foreach (sp in a_spawners) {
            ai_rider = sp spawner::spawn(1);
            if (isdefined(ai_rider)) {
                ai_rider get_in(self, ai_rider.script_startingposition, 1);
            }
        }
    }
}

// Namespace vehicle
// Params 1, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_45c6f51b
// Checksum 0x46bc1a5d, Offset: 0xd70
// Size: 0x94
function function_45c6f51b(ai) {
    vh = self;
    if (isdefined(ai.archetype) && ai.archetype == "robot") {
        bundle = vh get_robot_bundle();
    } else {
        bundle = vh get_bundle();
    }
    return bundle;
}

// Namespace vehicle
// Params 2, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_eedc9d25
// Checksum 0xab57fc29, Offset: 0xe10
// Size: 0xfc
function function_eedc9d25(vh, str_pos) {
    if (!isdefined(str_pos)) {
        str_pos = "driver";
    }
    ai = self;
    bundle = undefined;
    bundle = vh function_45c6f51b(ai);
    foreach (s_rider in bundle.objects) {
        if (s_rider.position == str_pos) {
            return s_rider;
        }
    }
}

// Namespace vehicle
// Params 3, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_230eadd7
// Checksum 0xdc9c9654, Offset: 0xf18
// Size: 0x5b4
function get_in(vh, str_pos, var_b98c3119) {
    if (!isdefined(var_b98c3119)) {
        var_b98c3119 = 0;
    }
    self endon(#"death");
    vh endon(#"death");
    if (!isdefined(str_pos)) {
        str_pos = vh function_5a2fe36b(self);
    }
    assert(isdefined(str_pos), "_enter");
    if (!isdefined(str_pos)) {
        return;
    }
    if (!isdefined(vh.var_58a89d24) || !vh.var_58a89d24) {
        seat_index = level.var_14c128[str_pos];
        if (seat_index <= 4) {
            var_a6ccaa06 = !vh isvehicleseatoccupied(seat_index);
            assert(var_a6ccaa06, "_enter");
            if (!var_a6ccaa06) {
                return;
            }
        }
    }
    function_cd99e01f(vh, str_pos);
    if (!var_b98c3119 && self flagsys::get("in_vehicle")) {
        get_out();
    }
    if (colors::is_color_ai()) {
        colors::disable();
    }
    function_ce794bff(vh, str_pos);
    if (!var_b98c3119) {
        self animation::set_death_anim(self.var_1b425382.var_77094522);
        animation::reach(self.var_1b425382.enteranim, self.vehicle, self.var_1b425382.aligntag);
        if (isdefined(self.var_1b425382.vehicleenteranim)) {
            vh clientfield::increment(self.var_1b425382.position + "_enter", 1);
            self setanim(self.var_1b425382.vehicleenteranim, 1, 0, 1);
        }
        self animation::play(self.var_1b425382.enteranim, self.vehicle, self.var_1b425382.aligntag);
    }
    if (isdefined(self.var_1b425382) && isdefined(self.var_1b425382.rideanim)) {
        self thread animation::play(self.var_1b425382.rideanim, self.vehicle, self.var_1b425382.aligntag, 1, 0.2, 0.2, 0, 0, 0, 0);
    } else if (!isdefined(level.var_14c128[str_pos])) {
        assert("_enter" + str_pos);
    } else if (isdefined(self.var_1b425382)) {
        v_tag_pos = vh gettagorigin(self.var_1b425382.aligntag);
        v_tag_ang = vh gettagangles(self.var_1b425382.aligntag);
        if (isdefined(v_tag_pos)) {
            self forceteleport(v_tag_pos, v_tag_ang);
        }
    } else {
        errormsg("_enter");
    }
    if (isactor(self)) {
        self pathmode("dont move");
        self.disableammodrop = 1;
        self.dontdropweapon = 1;
    }
    if (isdefined(level.var_14c128[str_pos])) {
        if (!isdefined(self.vehicle.var_58a89d24) || !self.vehicle.var_58a89d24) {
            seat_index = level.var_14c128[str_pos];
            if (seat_index <= 4) {
                if (self.vehicle isvehicleseatoccupied(seat_index)) {
                    get_out();
                    return;
                }
            }
        }
        self.vehicle usevehicle(self, level.var_14c128[str_pos]);
    }
    self flagsys::set("in_vehicle");
    self thread handle_rider_death();
}

// Namespace vehicle
// Params 0, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_50e738ed
// Checksum 0xb9b42575, Offset: 0x14d8
// Size: 0x104
function handle_rider_death() {
    self endon(#"exiting_vehicle");
    self.vehicle endon(#"death");
    if (isdefined(self.var_1b425382.ridedeathanim)) {
        self animation::set_death_anim(self.var_1b425382.ridedeathanim);
    }
    self waittill(#"death");
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.vehicle) && isdefined(self.var_1b425382) && isdefined(self.var_1b425382.vehicleriderdeathanim)) {
        self.vehicle clientfield::increment(self.var_1b425382.position + "_death", 1);
        self.vehicle setanimknobrestart(self.var_1b425382.vehicleriderdeathanim, 1, 0, 1);
    }
}

// Namespace vehicle
// Params 1, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_bc218457
// Checksum 0xee273b79, Offset: 0x15e8
// Size: 0x34
function delete_rider_asap(entity) {
    wait(0.05);
    if (isdefined(entity)) {
        entity delete();
    }
}

// Namespace vehicle
// Params 1, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_36fe7898
// Checksum 0xf7c79348, Offset: 0x1628
// Size: 0x174
function kill_rider(entity) {
    if (isdefined(entity)) {
        if (isalive(entity) && !gibserverutils::isgibbed(entity, 2)) {
            if (entity isplayinganimscripted()) {
                entity stopanimscripted();
            }
            if (getdvarint("tu1_vehicleRidersInvincibility", 1)) {
                util::stop_magic_bullet_shield(entity);
            }
            gibserverutils::gibleftarm(entity);
            gibserverutils::gibrightarm(entity);
            gibserverutils::giblegs(entity);
            gibserverutils::annihilate(entity);
            entity unlink();
            entity kill();
        }
        entity ghost();
        level thread delete_rider_asap(entity);
    }
}

// Namespace vehicle
// Params 1, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_5cf145c9
// Checksum 0xf36b70d7, Offset: 0x17a8
// Size: 0xa2
function on_vehicle_killed(params) {
    if (isdefined(self.riders)) {
        foreach (rider in self.riders) {
            kill_rider(rider);
        }
    }
}

// Namespace vehicle
// Params 2, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_ea08d46f
// Checksum 0xa56f469f, Offset: 0x1858
// Size: 0xce
function function_ea08d46f(vh, str_pos) {
    if (vh flagsys::get(str_pos + "occupied")) {
        return false;
    }
    if (anglestoup(vh.angles)[2] < 0.3) {
        return false;
    }
    seat_index = function_755f3ae5(str_pos);
    if (seat_index <= 4) {
        if (vh isvehicleseatoccupied(seat_index)) {
            return false;
        }
    }
    return true;
}

// Namespace vehicle
// Params 2, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_293281a2
// Checksum 0xcbce2e0a, Offset: 0x1930
// Size: 0x116
function function_293281a2(vh, str_pos) {
    if (!function_ea08d46f(vh, str_pos)) {
        return false;
    }
    var_1b425382 = self function_eedc9d25(vh, str_pos);
    v_tag_org = vh gettagorigin(var_1b425382.aligntag);
    v_tag_ang = vh gettagangles(var_1b425382.aligntag);
    var_1a48cfbd = getstartorigin(v_tag_org, v_tag_ang, var_1b425382.enteranim);
    if (!self findpath(self.origin, var_1a48cfbd)) {
        return false;
    }
    return true;
}

// Namespace vehicle
// Params 1, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_dca9dba2
// Checksum 0xd65708d8, Offset: 0x1a50
// Size: 0x3ca
function get_out(str_mode) {
    ai = self;
    self endon(#"death");
    self notify(#"exiting_vehicle");
    assert(isalive(self), "_enter");
    assert(isdefined(self.vehicle), "_enter");
    if (isdefined(self.vehicle.vehicleclass) && (isdefined(self.vehicle.vehicleclass) && self.vehicle.vehicleclass == "helicopter" || self.vehicle.vehicleclass == "plane")) {
        if (!isdefined(str_mode)) {
            str_mode = "variable";
        }
    } else if (!isdefined(str_mode)) {
        str_mode = "ground";
    }
    bundle = self.vehicle function_45c6f51b(ai);
    var_6580426c = bundle.var_1b5b8330;
    if (isdefined(self.var_1b425382.vehicleexitanim)) {
        self.vehicle clientfield::increment(self.var_1b425382.position + "_exit", 1);
        self.vehicle setanim(self.var_1b425382.vehicleexitanim, 1, 0, 1);
    }
    switch (str_mode) {
    case 23:
        exit_ground();
        break;
    case 24:
        function_63b86466();
        break;
    case 22:
        exit_variable();
        break;
    default:
        assertmsg("_enter");
        break;
    }
    if (isactor(self)) {
        self pathmode("move allowed");
        self.disableammodrop = 0;
        self.dontdropweapon = 0;
    }
    if (isdefined(self.vehicle)) {
        function_d3fa882a(self.vehicle, self.var_1b425382.position);
        if (isdefined(level.var_14c128[self.var_1b425382.position]) && self flagsys::get("in_vehicle")) {
            self.vehicle usevehicle(self, level.var_14c128[self.var_1b425382.position]);
        }
    }
    self flagsys::clear("in_vehicle");
    self.vehicle = undefined;
    self.var_1b425382 = undefined;
    self animation::set_death_anim(undefined);
    set_goal();
    self notify(#"exited_vehicle");
}

// Namespace vehicle
// Params 0, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_90d3ed43
// Checksum 0xbb29c691, Offset: 0x1e28
// Size: 0x5c
function set_goal() {
    if (colors::is_color_ai()) {
        colors::enable();
        return;
    }
    if (!isdefined(self.target)) {
        self setgoal(self.origin);
    }
}

// Namespace vehicle
// Params 4, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_e8860e34
// Checksum 0x26bf2d3c, Offset: 0x1e90
// Size: 0x246
function unload(str_group, str_mode, var_86f1d254, var_bfe5d67f) {
    if (!isdefined(str_group)) {
        str_group = "all";
    }
    self notify(#"unload", str_group);
    assert(isdefined(level.var_ca190c08[str_group]), str_group + "_enter");
    str_group = level.var_ca190c08[str_group];
    var_3346855c = [];
    foreach (ai_rider in self.riders) {
        if (str_group == "all" || issubstr(ai_rider.var_1b425382.position, str_group)) {
            ai_rider thread get_out(str_mode);
            if (!isdefined(var_3346855c)) {
                var_3346855c = [];
            } else if (!isarray(var_3346855c)) {
                var_3346855c = array(var_3346855c);
            }
            var_3346855c[var_3346855c.size] = ai_rider;
        }
    }
    if (var_3346855c.size > 0) {
        if (var_86f1d254 === 1) {
            remove_riders_after_wait(var_bfe5d67f, var_3346855c);
        }
        array::flagsys_wait_clear(var_3346855c, "in_vehicle", isdefined(self.unloadtimeout) ? self.unloadtimeout : 4);
        self notify(#"unload", var_3346855c);
    }
}

// Namespace vehicle
// Params 2, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_b6910714
// Checksum 0xf122f610, Offset: 0x20e0
// Size: 0xb2
function remove_riders_after_wait(wait_time, a_riders_to_remove) {
    wait(wait_time);
    if (isdefined(a_riders_to_remove)) {
        foreach (ai in a_riders_to_remove) {
            arrayremovevalue(self.riders, ai);
        }
    }
}

// Namespace vehicle
// Params 0, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_fb072d47
// Checksum 0xd8670307, Offset: 0x21a0
// Size: 0x7c
function ragdoll_dead_exit_rider() {
    self endon(#"exited_vehicle");
    self waittill(#"death");
    if (isactor(self) && !self isragdoll()) {
        self unlink();
        self startragdoll();
    }
}

// Namespace vehicle
// Params 0, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_388494f1
// Checksum 0xfa739e92, Offset: 0x2228
// Size: 0x104
function exit_ground() {
    self animation::set_death_anim(self.var_1b425382.exitgrounddeathanim);
    if (!isdefined(self.var_1b425382.exitgrounddeathanim)) {
        self thread ragdoll_dead_exit_rider();
    }
    assert(isstring(self.var_1b425382.exitgroundanim), "_enter" + self.var_1b425382.position + "_enter");
    if (isstring(self.var_1b425382.exitgroundanim)) {
        animation::play(self.var_1b425382.exitgroundanim, self.vehicle, self.var_1b425382.aligntag);
    }
}

// Namespace vehicle
// Params 0, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_63b86466
// Checksum 0x843a5cd7, Offset: 0x2338
// Size: 0xac
function function_63b86466() {
    self animation::set_death_anim(self.var_1b425382.var_24c6bf4e);
    assert(isdefined(self.var_1b425382.var_60cf8622), "_enter" + self.var_1b425382.position + "_enter");
    animation::play(self.var_1b425382.var_60cf8622, self.vehicle, self.var_1b425382.aligntag);
}

// Namespace vehicle
// Params 0, eflags: 0x5 linked
// namespace_96fa87af<file_0>::function_af1320d0
// Checksum 0x48433335, Offset: 0x23f0
// Size: 0x64
function private handle_falling_death() {
    self endon(#"landed");
    self waittill(#"death");
    if (isactor(self)) {
        self unlink();
        self startragdoll();
    }
}

// Namespace vehicle
// Params 3, eflags: 0x5 linked
// namespace_96fa87af<file_0>::function_f3585099
// Checksum 0x83c8381b, Offset: 0x2460
// Size: 0x18e
function private forward_euler_integration(e_move, v_target_landing, n_initial_speed) {
    landed = 0;
    var_af0234d7 = 0.1;
    position = self.origin;
    velocity = (0, 0, n_initial_speed * -1);
    gravity = (0, 0, -385.8);
    while (!landed) {
        previousposition = position;
        velocity += gravity * var_af0234d7;
        position += velocity * var_af0234d7;
        if (position[2] + velocity[2] * var_af0234d7 <= v_target_landing[2]) {
            landed = 1;
            position = v_target_landing;
        }
        /#
            recordline(previousposition, position, (1, 0.5, 0), "_enter", self);
        #/
        hostmigration::waittillhostmigrationdone();
        e_move moveto(position, var_af0234d7);
        if (!landed) {
            wait(var_af0234d7);
        }
    }
}

// Namespace vehicle
// Params 0, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_4f64b70
// Checksum 0xcd07a880, Offset: 0x25f8
// Size: 0x48c
function exit_variable() {
    ai = self;
    self endon(#"death");
    self notify(#"exiting_vehicle");
    self thread handle_falling_death();
    self animation::set_death_anim(self.var_1b425382.exithighdeathanim);
    assert(isdefined(self.var_1b425382.exithighanim), "_enter" + self.var_1b425382.position + "_enter");
    animation::play(self.var_1b425382.exithighanim, self.vehicle, self.var_1b425382.aligntag, 1, 0, 0);
    self animation::set_death_anim(self.var_1b425382.exithighloopdeathanim);
    n_cur_height = get_height(self.vehicle);
    bundle = self.vehicle function_45c6f51b(ai);
    n_target_height = bundle.highexitlandheight;
    if (isdefined(self.dropundervehicleoriginoverride) && (isdefined(self.var_1b425382.dropundervehicleorigin) && self.var_1b425382.dropundervehicleorigin || self.dropundervehicleoriginoverride)) {
        v_target_landing = (self.vehicle.origin[0], self.vehicle.origin[1], self.origin[2] - n_cur_height + n_target_height);
    } else {
        v_target_landing = (self.origin[0], self.origin[1], self.origin[2] - n_cur_height + n_target_height);
    }
    if (isdefined(self.overridedropposition)) {
        v_target_landing = (self.overridedropposition[0], self.overridedropposition[1], v_target_landing[2]);
    }
    if (isdefined(self.targetangles)) {
        angles = self.targetangles;
    } else {
        angles = self.angles;
    }
    e_move = util::spawn_model("tag_origin", self.origin, angles);
    self thread exit_high_loop_anim(e_move);
    distance = n_target_height - n_cur_height;
    initialspeed = bundle.dropspeed;
    acceleration = 385.8;
    n_fall_time = (initialspeed * -1 + sqrt(pow(initialspeed, 2) - 2 * acceleration * distance)) / acceleration;
    self notify(#"falling", n_fall_time);
    forward_euler_integration(e_move, v_target_landing, bundle.dropspeed);
    e_move waittill(#"movedone");
    self notify(#"landing");
    self animation::set_death_anim(self.var_1b425382.exithighlanddeathanim);
    animation::play(self.var_1b425382.exithighlandanim, e_move, "tag_origin");
    self notify(#"landed");
    self unlink();
    wait(0.05);
    e_move delete();
}

// Namespace vehicle
// Params 1, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_2b44d3d7
// Checksum 0x57dd9dee, Offset: 0x2a90
// Size: 0x58
function exit_high_loop_anim(e_parent) {
    self endon(#"death");
    self endon(#"landing");
    while (true) {
        animation::play(self.var_1b425382.exithighloopanim, e_parent, "tag_origin");
    }
}

// Namespace vehicle
// Params 1, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_4f826843
// Checksum 0xa63570e0, Offset: 0x2af0
// Size: 0xea
function get_height(e_ignore) {
    if (!isdefined(e_ignore)) {
        e_ignore = self;
    }
    trace = groundtrace(self.origin + (0, 0, 10), self.origin + (0, 0, -10000), 0, e_ignore, 0);
    /#
        recordline(self.origin + (0, 0, 10), trace["_enter"], (1, 0.5, 0), "_enter", self);
    #/
    return distance(self.origin, trace["position"]);
}

// Namespace vehicle
// Params 0, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_c983f0ce
// Checksum 0xd1dc17f2, Offset: 0x2be8
// Size: 0x4a
function get_bundle() {
    assert(isdefined(self.vehicleridersbundle), "_enter");
    return struct::get_script_bundle("vehicleriders", self.vehicleridersbundle);
}

// Namespace vehicle
// Params 0, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_14f13661
// Checksum 0xb237f061, Offset: 0x2c40
// Size: 0x4a
function get_robot_bundle() {
    assert(isdefined(self.vehicleridersrobotbundle), "_enter");
    return struct::get_script_bundle("vehicleriders", self.vehicleridersrobotbundle);
}

// Namespace vehicle
// Params 1, eflags: 0x1 linked
// namespace_96fa87af<file_0>::function_ad4ec07a
// Checksum 0x6cee42b7, Offset: 0x2c98
// Size: 0xb8
function function_ad4ec07a(str_pos) {
    if (isdefined(self.riders)) {
        foreach (ai in self.riders) {
            if (isdefined(ai) && ai.var_1b425382.position == str_pos) {
                return ai;
            }
        }
    }
}

// Namespace vehicle
// Params 2, eflags: 0x5 linked
// namespace_96fa87af<file_0>::function_ce794bff
// Checksum 0xbb12bcb5, Offset: 0x2d58
// Size: 0xd4
function private function_ce794bff(vh, str_pos) {
    assert(isdefined(self.vehicle) || isdefined(vh), "_enter");
    assert(isdefined(self.var_1b425382) || isdefined(str_pos), "_enter");
    if (isdefined(vh)) {
        self.vehicle = vh;
    }
    if (!isdefined(str_pos)) {
        str_pos = self.var_1b425382.position;
    }
    self.var_1b425382 = self function_eedc9d25(self.vehicle, str_pos);
}

