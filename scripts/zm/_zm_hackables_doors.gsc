#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_equip_hacker;

#namespace zm_hackables_doors;

// Namespace zm_hackables_doors
// Params 0
// Checksum 0xea963748, Offset: 0x148
// Size: 0x12a
function door_struct_debug()
{
    while ( true )
    {
        wait 0.1;
        origin = self.origin;
        point = origin;
        
        for ( i = 1; i < 5 ; i++ )
        {
            point = origin + anglestoforward( self.door.angles ) * i * 2;
            passed = bullettracepassed( point, origin, 0, undefined );
            color = ( 0, 255, 0 );
            
            if ( !passed )
            {
                color = ( 255, 0, 0 );
            }
            
            /#
                print3d( point, "<dev string:x28>", color, 1, 1 );
            #/
        }
    }
}

// Namespace zm_hackables_doors
// Params 2
// Checksum 0x2f1921bd, Offset: 0x280
// Size: 0x206
function hack_doors( targetname, door_activate_func )
{
    if ( !isdefined( targetname ) )
    {
        targetname = "zombie_door";
    }
    
    doors = getentarray( targetname, "targetname" );
    
    if ( !isdefined( door_activate_func ) )
    {
        door_activate_func = &zm_blockers::door_opened;
    }
    
    for ( i = 0; i < doors.size ; i++ )
    {
        door = doors[ i ];
        struct = spawnstruct();
        struct.origin = door.origin + anglestoforward( door.angles ) * 2;
        struct.radius = 48;
        struct.height = 72;
        struct.script_float = 32.7;
        struct.script_int = 200;
        struct.door = door;
        struct.no_bullet_trace = 1;
        struct.door_activate_func = door_activate_func;
        trace_passed = 0;
        door thread hide_door_buy_when_hacker_active( struct );
        zm_equip_hacker::register_pooled_hackable_struct( struct, &door_hack );
        door thread watch_door_for_open( struct );
    }
}

// Namespace zm_hackables_doors
// Params 1
// Checksum 0x89ea7117, Offset: 0x490
// Size: 0x44
function hide_door_buy_when_hacker_active( door_struct )
{
    self endon( #"death" );
    self endon( #"door_hacked" );
    self endon( #"door_opened" );
    zm_equip_hacker::hide_hint_when_hackers_active();
}

// Namespace zm_hackables_doors
// Params 1
// Checksum 0x4d13b7ef, Offset: 0x4e0
// Size: 0x44
function watch_door_for_open( door_struct )
{
    self waittill( #"door_opened" );
    self endon( #"door_hacked" );
    remove_all_door_hackables_that_target_door( door_struct.door );
}

// Namespace zm_hackables_doors
// Params 1
// Checksum 0x29ce261a, Offset: 0x530
// Size: 0x78
function door_hack( hacker )
{
    self.door notify( #"door_hacked" );
    self.door notify( #"kill_door_think" );
    remove_all_door_hackables_that_target_door( self.door );
    self.door [[ self.door_activate_func ]]();
    self.door._door_open = 1;
}

// Namespace zm_hackables_doors
// Params 1
// Checksum 0x660d7ad6, Offset: 0x5b0
// Size: 0xee
function remove_all_door_hackables_that_target_door( door )
{
    candidates = [];
    
    for ( i = 0; i < level._hackable_objects.size ; i++ )
    {
        obj = level._hackable_objects[ i ];
        
        if ( isdefined( obj.door ) && obj.door.target == door.target )
        {
            candidates[ candidates.size ] = obj;
        }
    }
    
    for ( i = 0; i < candidates.size ; i++ )
    {
        zm_equip_hacker::deregister_hackable_struct( candidates[ i ] );
    }
}

