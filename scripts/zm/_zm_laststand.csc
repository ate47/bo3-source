#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_load;
#using scripts/zm/_util;

#namespace zm_laststand;

// Namespace zm_laststand
// Params 0, eflags: 0x2
// Checksum 0x796482e0, Offset: 0x1b0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_laststand", &__init__, undefined, undefined );
}

// Namespace zm_laststand
// Params 0
// Checksum 0x871fd196, Offset: 0x1f0
// Size: 0x18c
function __init__()
{
    level.laststands = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        level.laststands[ i ] = spawnstruct();
        level.laststands[ i ].bleedouttime = 0;
        level.laststands[ i ].laststand_update_clientfields = "laststand_update" + i;
        level.laststands[ i ].lastbleedouttime = 0;
        clientfield::register( "world", level.laststands[ i ].laststand_update_clientfields, 1, 5, "counter", &update_bleedout_timer, 0, 0 );
    }
    
    level thread wait_and_set_revive_shader_constant();
    visionset_mgr::register_visionset_info( "zombie_last_stand", 1, 31, undefined, "zombie_last_stand", 6 );
    visionset_mgr::register_visionset_info( "zombie_death", 1, 31, "zombie_last_stand", "zombie_death", 6 );
}

// Namespace zm_laststand
// Params 0
// Checksum 0xd2aa51d5, Offset: 0x388
// Size: 0xb0
function wait_and_set_revive_shader_constant()
{
    while ( true )
    {
        level waittill( #"notetrack", localclientnum, note );
        
        if ( note == "revive_shader_constant" )
        {
            player = getlocalplayer( localclientnum );
            player mapshaderconstant( localclientnum, 0, "scriptVector2", 0, 1, 0, getservertime( localclientnum ) / 1000 );
        }
    }
}

// Namespace zm_laststand
// Params 3
// Checksum 0x63717055, Offset: 0x440
// Size: 0x108
function animation_update( model, oldvalue, newvalue )
{
    self endon( #"new_val" );
    starttime = getrealtime();
    timesincelastupdate = 0;
    
    if ( oldvalue == newvalue )
    {
        newvalue = oldvalue - 1;
    }
    
    while ( timesincelastupdate <= 1 )
    {
        timesincelastupdate = ( getrealtime() - starttime ) / 1000;
        lerpvalue = lerpfloat( oldvalue, newvalue, timesincelastupdate ) / 30;
        setuimodelvalue( model, lerpvalue );
        wait 0.016;
    }
}

// Namespace zm_laststand
// Params 7
// Checksum 0x6fdf2aaa, Offset: 0x550
// Size: 0x2b4
function update_bleedout_timer( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    substr = getsubstr( fieldname, 16 );
    playernum = int( substr );
    level.laststands[ playernum ].lastbleedouttime = level.laststands[ playernum ].bleedouttime;
    level.laststands[ playernum ].bleedouttime = newval - 1;
    
    if ( level.laststands[ playernum ].lastbleedouttime < level.laststands[ playernum ].bleedouttime )
    {
        level.laststands[ playernum ].lastbleedouttime = level.laststands[ playernum ].bleedouttime;
    }
    
    model = getuimodel( getuimodelforcontroller( localclientnum ), "WorldSpaceIndicators.bleedOutModel" + playernum + ".bleedOutPercent" );
    
    if ( isdefined( model ) )
    {
        if ( newval == 30 )
        {
            level.laststands[ playernum ].bleedouttime = 0;
            level.laststands[ playernum ].lastbleedouttime = 0;
            setuimodelvalue( model, 1 );
            return;
        }
        
        if ( newval == 29 )
        {
            level.laststands[ playernum ] notify( #"new_val" );
            level.laststands[ playernum ] thread animation_update( model, 30, 28 );
            return;
        }
        
        level.laststands[ playernum ] notify( #"new_val" );
        level.laststands[ playernum ] thread animation_update( model, level.laststands[ playernum ].lastbleedouttime, level.laststands[ playernum ].bleedouttime );
    }
}

