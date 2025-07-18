#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_equip_hacker;

#namespace zm_hackables_perks;

// Namespace zm_hackables_perks
// Params 0
// Checksum 0xf8c1c590, Offset: 0x168
// Size: 0x28c
function hack_perks()
{
    vending_triggers = getentarray( "zombie_vending", "targetname" );
    
    for ( i = 0; i < vending_triggers.size ; i++ )
    {
        struct = spawnstruct();
        
        if ( isdefined( vending_triggers[ i ].machine ) )
        {
            machine[ 0 ] = vending_triggers[ i ].machine;
        }
        else
        {
            machine = getentarray( vending_triggers[ i ].target, "targetname" );
        }
        
        struct.origin = machine[ 0 ].origin + anglestoright( machine[ 0 ].angles ) * 18 + ( 0, 0, 48 );
        struct.radius = 48;
        struct.height = 64;
        struct.script_float = 5;
        
        while ( !isdefined( vending_triggers[ i ].cost ) )
        {
            wait 0.05;
        }
        
        struct.script_int = int( vending_triggers[ i ].cost * -1 );
        struct.perk = vending_triggers[ i ];
        
        if ( isdefined( level._hack_perks_override ) )
        {
            struct = struct [[ level._hack_perks_override ]]();
        }
        
        vending_triggers[ i ].hackable = struct;
        struct.no_bullet_trace = 1;
        zm_equip_hacker::register_pooled_hackable_struct( struct, &perk_hack, &perk_hack_qualifier );
    }
    
    level._solo_revive_machine_expire_func = &solo_revive_expire_func;
}

// Namespace zm_hackables_perks
// Params 0
// Checksum 0xc5a10708, Offset: 0x400
// Size: 0x36
function solo_revive_expire_func()
{
    if ( isdefined( self.hackable ) )
    {
        zm_equip_hacker::deregister_hackable_struct( self.hackable );
        self.hackable = undefined;
    }
}

// Namespace zm_hackables_perks
// Params 1
// Checksum 0x69d95eb1, Offset: 0x440
// Size: 0x76, Type: bool
function perk_hack_qualifier( player )
{
    if ( isdefined( player._retain_perks ) )
    {
        return false;
    }
    
    if ( isdefined( self.perk ) && isdefined( self.perk.script_noteworthy ) )
    {
        if ( player hasperk( self.perk.script_noteworthy ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_hackables_perks
// Params 1
// Checksum 0xaef62bd, Offset: 0x4c0
// Size: 0x13a
function perk_hack( hacker )
{
    if ( level flag::get( "solo_game" ) && self.perk.script_noteworthy == "specialty_quickrevive" )
    {
        hacker.lives--;
    }
    
    hacker notify( self.perk.script_noteworthy + "_stop" );
    hacker playsoundtoplayer( "evt_perk_throwup", hacker );
    
    if ( isdefined( hacker.perk_hud ) )
    {
        keys = getarraykeys( hacker.perk_hud );
        
        for ( i = 0; i < hacker.perk_hud.size ; i++ )
        {
            hacker.perk_hud[ keys[ i ] ].x = i * 30;
        }
    }
}

