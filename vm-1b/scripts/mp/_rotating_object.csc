#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace rotating_object;

// Namespace rotating_object
// Params 0, eflags: 0x2
// Checksum 0x3035d29d, Offset: 0x140
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("rotating_object", &__init__, undefined, undefined);
}

// Namespace rotating_object
// Params 0, eflags: 0x0
// Checksum 0xc7047bb9, Offset: 0x178
// Size: 0x22
function __init__() {
    callback::on_localclient_connect(&init);
}

// Namespace rotating_object
// Params 1, eflags: 0x0
// Checksum 0x300898b8, Offset: 0x1a8
// Size: 0x52
function init(localclientnum) {
    rotating_objects = getentarray(localclientnum, "rotating_object", "targetname");
    array::thread_all(rotating_objects, &rotating_object_think);
}

// Namespace rotating_object
// Params 0, eflags: 0x0
// Checksum 0xc47a04a0, Offset: 0x208
// Size: 0x15d
function rotating_object_think() {
    self endon(#"entityshutdown");
    util::waitforallclients();
    axis = "yaw";
    direction = 360;
    revolutions = 100;
    rotate_time = 12;
    if (isdefined(self.script_noteworthy)) {
        axis = self.script_noteworthy;
    }
    if (isdefined(self.script_float)) {
        rotate_time = self.script_float;
    }
    if (rotate_time == 0) {
        rotate_time = 12;
    }
    if (rotate_time < 0) {
        direction *= -1;
        rotate_time *= -1;
    }
    angles = self.angles;
    while (true) {
        switch (axis) {
        case "roll":
            self rotateroll(direction * revolutions, rotate_time * revolutions);
            break;
        case "pitch":
            self rotatepitch(direction * revolutions, rotate_time * revolutions);
            break;
        case "yaw":
        default:
            self rotateyaw(direction * revolutions, rotate_time * revolutions);
            break;
        }
        self waittill(#"rotatedone");
        self.angles = angles;
    }
}

