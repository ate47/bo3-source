#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/shared/callbacks_shared;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_freerun_01;

// Namespace mp_freerun_01
// Params 0
// Checksum 0xc6a2dace, Offset: 0x1a8
// Size: 0x34
function main()
{
    precache();
    load::main();
    init();
}

// Namespace mp_freerun_01
// Params 0
// Checksum 0x99ec1590, Offset: 0x1e8
// Size: 0x4
function precache()
{
    
}

// Namespace mp_freerun_01
// Params 0
// Checksum 0x99ec1590, Offset: 0x1f8
// Size: 0x4
function init()
{
    
}

// Namespace mp_freerun_01
// Params 0
// Checksum 0x6f62621a, Offset: 0x208
// Size: 0x1ac
function speed_test_init()
{
    trigger1 = getent( "speed_trigger1", "targetname" );
    trigger2 = getent( "speed_trigger2", "targetname" );
    trigger3 = getent( "speed_trigger3", "targetname" );
    trigger4 = getent( "speed_trigger4", "targetname" );
    trigger5 = getent( "speed_trigger5", "targetname" );
    trigger6 = getent( "speed_trigger6", "targetname" );
    trigger1 thread speed_test();
    trigger2 thread speed_test();
    trigger3 thread speed_test();
    trigger4 thread speed_test();
    trigger5 thread speed_test();
    trigger6 thread speed_test();
}

// Namespace mp_freerun_01
// Params 0
// Checksum 0xf42e5cc3, Offset: 0x3c0
// Size: 0x80
function speed_test()
{
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( isplayer( player ) )
        {
            self thread util::trigger_thread( player, &player_on_trigger, &player_off_trigger );
        }
        
        wait 0.05;
    }
}

// Namespace mp_freerun_01
// Params 2
// Checksum 0x96e4303, Offset: 0x448
// Size: 0xc2
function player_on_trigger( player, endon_string )
{
    player endon( #"death" );
    player endon( #"disconnect" );
    player endon( endon_string );
    
    if ( isdefined( player._speed_test2 ) )
    {
        player._speed_test1 = gettime();
        total_time = player._speed_test1 - player._speed_test2;
        iprintlnbold( "" + total_time / 1000 + "seconds" );
        player._speed_test2 = undefined;
    }
}

// Namespace mp_freerun_01
// Params 1
// Checksum 0x94ce140a, Offset: 0x518
// Size: 0x56
function player_off_trigger( player )
{
    player endon( #"death" );
    player endon( #"disconnect" );
    player._speed_test2 = gettime();
    
    if ( isdefined( player._speed_test1 ) )
    {
        player._speed_test1 = undefined;
    }
}

