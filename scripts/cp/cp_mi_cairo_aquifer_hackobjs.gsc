#using scripts/codescripts/struct;
#using scripts/cp/_hacking;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/shared/flag_shared;

#namespace cp_mi_cairo_aquifer_hackobjs;

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 0
// Checksum 0x30c5e008, Offset: 0x210
// Size: 0x14
function main()
{
    init_skiptos();
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 0
// Checksum 0x99ec1590, Offset: 0x230
// Size: 0x4
function init_skiptos()
{
    
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 2
// Checksum 0x1ce65449, Offset: 0x240
// Size: 0xf4
function skipto_attack_tanks( a, b )
{
    tank_obj = getent( "tank_obj_target", "targetname" );
    level.tank_targ = spawnstruct();
    level.tank_targ.origin = tank_obj.origin;
    objectives::set( "obj_attack_tanks", level.tank_targ );
    iprintln( "waiting placeholder for attack tanks" );
    wait 5;
    objectives::complete( "obj_attack_tanks", level.tank_targ );
    skipto::objective_completed( a );
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 2
// Checksum 0x4a49a2db, Offset: 0x340
// Size: 0xf4
function skipto_hack_1( a, b )
{
    hack_trig_1 = getent( "exterior_hack_trig_1", "targetname" );
    level.hack_trig1 = struct::get( hack_trig_1.target, "targetname" );
    objectives::set( "cp_mi_cairo_aquifer_hack_obj1", level.hack_trig1 );
    hack_trig_1 hacking::init_hack_trigger( 1 );
    hack_trig_1 hacking::trigger_wait();
    objectives::complete( "cp_mi_cairo_aquifer_hack_obj1", level.hack_trig1 );
    skipto::objective_completed( a );
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 2
// Checksum 0x8ce95ad1, Offset: 0x440
// Size: 0xf4
function skipto_hack_2( a, b )
{
    hack_trig_2 = getent( "exterior_hack_trig_2", "targetname" );
    level.hack_trig2 = struct::get( hack_trig_2.target, "targetname" );
    objectives::set( "cp_mi_cairo_aquifer_hack_obj2", level.hack_trig2 );
    hack_trig_2 hacking::init_hack_trigger( 1 );
    hack_trig_2 hacking::trigger_wait();
    objectives::complete( "cp_mi_cairo_aquifer_hack_obj2", level.hack_trig2 );
    skipto::objective_completed( a );
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 2
// Checksum 0xadc1679a, Offset: 0x540
// Size: 0x104
function skipto_hack_3( a, b )
{
    hack_trig_3 = getent( "exterior_hack_trig_3", "targetname" );
    level.hack_trig3 = spawnstruct();
    level.hack_trig3.origin = hack_trig_3.origin;
    objectives::set( "cp_mi_cairo_aquifer_hack_obj3", level.hack_trig3 );
    hack_trig_3 hacking::init_hack_trigger( 5 );
    hack_trig_3 hacking::trigger_wait();
    objectives::complete( "cp_mi_cairo_aquifer_hack_obj3", level.hack_trig3 );
    skipto::objective_completed( a );
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 4
// Checksum 0xa23e278a, Offset: 0x650
// Size: 0x4c
function done( a, b, c, d )
{
    iprintln( "######## " + a + " is completed ########" );
}

