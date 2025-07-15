#using scripts/codescripts/struct;
#using scripts/shared/aat_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_aat_blast_furnace;

// Namespace zm_aat_blast_furnace
// Params 0, eflags: 0x2
// Checksum 0x45b18c7a, Offset: 0x2a0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_aat_blast_furnace", &__init__, undefined, "aat" );
}

// Namespace zm_aat_blast_furnace
// Params 0
// Checksum 0x3490d32e, Offset: 0x2e0
// Size: 0x144
function __init__()
{
    if ( !( isdefined( level.aat_in_use ) && level.aat_in_use ) )
    {
        return;
    }
    
    aat::register( "zm_aat_blast_furnace", 0.15, 0, 15, 0, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr" );
    clientfield::register( "actor", "zm_aat_blast_furnace" + "_explosion", 1, 1, "counter" );
    clientfield::register( "vehicle", "zm_aat_blast_furnace" + "_explosion_vehicle", 1, 1, "counter" );
    clientfield::register( "actor", "zm_aat_blast_furnace" + "_burn", 1, 1, "counter" );
    clientfield::register( "vehicle", "zm_aat_blast_furnace" + "_burn_vehicle", 1, 1, "counter" );
}

// Namespace zm_aat_blast_furnace
// Params 4
// Checksum 0xd336c103, Offset: 0x430
// Size: 0x44
function result( death, attacker, mod, weapon )
{
    self thread blast_furnace_explosion( attacker, weapon );
}

// Namespace zm_aat_blast_furnace
// Params 2
// Checksum 0xe49ec50e, Offset: 0x480
// Size: 0x3cc
function blast_furnace_explosion( e_attacker, w_weapon )
{
    if ( isvehicle( self ) )
    {
        self thread clientfield::increment( "zm_aat_blast_furnace" + "_explosion_vehicle" );
    }
    else
    {
        self thread clientfield::increment( "zm_aat_blast_furnace" + "_explosion" );
    }
    
    a_e_blasted_zombies = array::get_all_closest( self.origin, getaiteamarray( "axis" ), undefined, undefined, 120 );
    
    if ( a_e_blasted_zombies.size > 0 )
    {
        for ( i = 0; i < a_e_blasted_zombies.size ; i++ )
        {
            if ( isalive( a_e_blasted_zombies[ i ] ) )
            {
                if ( isdefined( level.aat[ "zm_aat_blast_furnace" ].immune_result_indirect[ a_e_blasted_zombies[ i ].archetype ] ) && level.aat[ "zm_aat_blast_furnace" ].immune_result_indirect[ a_e_blasted_zombies[ i ].archetype ] )
                {
                    arrayremovevalue( a_e_blasted_zombies, a_e_blasted_zombies[ i ] );
                    continue;
                }
                
                if ( a_e_blasted_zombies[ i ] == self && !( isdefined( level.aat[ "zm_aat_blast_furnace" ].immune_result_direct[ a_e_blasted_zombies[ i ].archetype ] ) && level.aat[ "zm_aat_blast_furnace" ].immune_result_direct[ a_e_blasted_zombies[ i ].archetype ] ) )
                {
                    self thread zombie_death_gib( e_attacker, w_weapon );
                    
                    if ( isvehicle( a_e_blasted_zombies[ i ] ) )
                    {
                        a_e_blasted_zombies[ i ] thread clientfield::increment( "zm_aat_blast_furnace" + "_burn_vehicle" );
                    }
                    else
                    {
                        a_e_blasted_zombies[ i ] thread clientfield::increment( "zm_aat_blast_furnace" + "_burn" );
                    }
                    
                    arrayremovevalue( a_e_blasted_zombies, a_e_blasted_zombies[ i ] );
                    continue;
                }
                
                if ( isvehicle( a_e_blasted_zombies[ i ] ) )
                {
                    a_e_blasted_zombies[ i ] thread clientfield::increment( "zm_aat_blast_furnace" + "_burn_vehicle" );
                    continue;
                }
                
                a_e_blasted_zombies[ i ] thread clientfield::increment( "zm_aat_blast_furnace" + "_burn" );
            }
        }
        
        wait 0.25;
        a_e_blasted_zombies = array::remove_dead( a_e_blasted_zombies );
        a_e_blasted_zombies = array::remove_undefined( a_e_blasted_zombies );
        array::thread_all( a_e_blasted_zombies, &blast_furnace_zombie_burn, e_attacker, w_weapon );
    }
}

// Namespace zm_aat_blast_furnace
// Params 2
// Checksum 0x4dbbdce1, Offset: 0x858
// Size: 0xd0
function blast_furnace_zombie_burn( e_attacker, w_weapon )
{
    self endon( #"death" );
    n_damage = self.health / 6;
    i = 0;
    
    while ( i <= 6 )
    {
        if ( self.health < n_damage )
        {
            e_attacker zm_stats::increment_challenge_stat( "ZOMBIE_HUNTER_BLAST_FURNACE" );
        }
        
        self dodamage( n_damage, self.origin, e_attacker, undefined, "none", "MOD_UNKNOWN", 0, w_weapon );
        i++;
        wait 0.5;
    }
}

// Namespace zm_aat_blast_furnace
// Params 2
// Checksum 0x8ad1d450, Offset: 0x930
// Size: 0xec
function zombie_death_gib( e_attacker, w_weapon )
{
    gibserverutils::gibhead( self );
    
    if ( math::cointoss() )
    {
        gibserverutils::gibleftarm( self );
    }
    else
    {
        gibserverutils::gibrightarm( self );
    }
    
    gibserverutils::giblegs( self );
    self dodamage( self.health, self.origin, e_attacker );
    
    if ( isdefined( e_attacker ) && isplayer( e_attacker ) )
    {
        e_attacker zm_stats::increment_challenge_stat( "ZOMBIE_HUNTER_BLAST_FURNACE" );
    }
}

