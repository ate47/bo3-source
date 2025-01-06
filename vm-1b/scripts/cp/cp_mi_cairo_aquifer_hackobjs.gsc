#using scripts/codescripts/struct;
#using scripts/cp/_hacking;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/shared/flag_shared;

#namespace cp_mi_cairo_aquifer_hackobjs;

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 0, eflags: 0x0
// Checksum 0x53825017, Offset: 0x210
// Size: 0x12
function main() {
    function_a9192543();
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x230
// Size: 0x2
function function_a9192543() {
    
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 2, eflags: 0x0
// Checksum 0x15407d2, Offset: 0x240
// Size: 0xd2
function function_8f05da8(a, b) {
    var_56fa193b = getent("tank_obj_target", "targetname");
    level.var_72dad04 = spawnstruct();
    level.var_72dad04.origin = var_56fa193b.origin;
    objectives::set("obj_attack_tanks", level.var_72dad04);
    iprintln("waiting placeholder for attack tanks");
    wait 5;
    objectives::complete("obj_attack_tanks", level.var_72dad04);
    skipto::function_be8adfb8(a);
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 2, eflags: 0x0
// Checksum 0xba82e5ad, Offset: 0x320
// Size: 0xd2
function function_1316b781(a, b) {
    var_142bbbff = getent("exterior_hack_trig_1", "targetname");
    level.var_d997ef9c = struct::get(var_142bbbff.target, "targetname");
    objectives::set("cp_mi_cairo_aquifer_hack_obj1", level.var_d997ef9c);
    var_142bbbff hacking::function_68df65d8(1);
    var_142bbbff hacking::trigger_wait();
    objectives::complete("cp_mi_cairo_aquifer_hack_obj1", level.var_d997ef9c);
    skipto::function_be8adfb8(a);
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 2, eflags: 0x0
// Checksum 0x2a33f35f, Offset: 0x400
// Size: 0xd2
function function_391931ea(a, b) {
    var_a2244cc4 = getent("exterior_hack_trig_2", "targetname");
    level.var_4b9f5ed7 = struct::get(var_a2244cc4.target, "targetname");
    objectives::set("cp_mi_cairo_aquifer_hack_obj2", level.var_4b9f5ed7);
    var_a2244cc4 hacking::function_68df65d8(1);
    var_a2244cc4 hacking::trigger_wait();
    objectives::complete("cp_mi_cairo_aquifer_hack_obj2", level.var_4b9f5ed7);
    skipto::function_be8adfb8(a);
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 2, eflags: 0x0
// Checksum 0xf13313b1, Offset: 0x4e0
// Size: 0xda
function function_5f1bac53(a, b) {
    var_c826c72d = getent("exterior_hack_trig_3", "targetname");
    level.var_259ce46e = spawnstruct();
    level.var_259ce46e.origin = var_c826c72d.origin;
    objectives::set("cp_mi_cairo_aquifer_hack_obj3", level.var_259ce46e);
    var_c826c72d hacking::function_68df65d8(5);
    var_c826c72d hacking::trigger_wait();
    objectives::complete("cp_mi_cairo_aquifer_hack_obj3", level.var_259ce46e);
    skipto::function_be8adfb8(a);
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 4, eflags: 0x0
// Checksum 0xe83695b5, Offset: 0x5c8
// Size: 0x42
function done(a, b, c, d) {
    iprintln("######## " + a + " is completed ########");
}

