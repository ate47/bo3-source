#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace rotating_object;

// Namespace rotating_object
// Params 0, eflags: 0x2
// Checksum 0xd170aac3, Offset: 0x140
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("rotating_object", &__init__, undefined, undefined);
}

// Namespace rotating_object
// Params 0, eflags: 0x0
// Checksum 0xbb38f61, Offset: 0x180
// Size: 0x24
function __init__() {
    callback::on_localclient_connect(&init);
}

// Namespace rotating_object
// Params 1, eflags: 0x0
// Checksum 0xbf3a65a, Offset: 0x1b0
// Size: 0x64
function init(localclientnum) {
    rotating_objects = getentarray(localclientnum, "rotating_object", "targetname");
    array::thread_all(rotating_objects, &rotating_object_think);
}

// Namespace rotating_object
// Params 0, eflags: 0x0
// Checksum 0xd8ec663d, Offset: 0x220
// Size: 0x1dc
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

