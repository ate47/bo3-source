#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_proximity_grenade;

#namespace armblade;

// Namespace armblade
// Params 0, eflags: 0x2
// Checksum 0xaadaf54, Offset: 0x190
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "armblade", &__init__, undefined, undefined );
}

// Namespace armblade
// Params 0
// Checksum 0x78ff9695, Offset: 0x1d0
// Size: 0x44
function __init__()
{
    level.weaponarmblade = getweapon( "hero_armblade" );
    callback::on_spawned( &on_player_spawned );
}

// Namespace armblade
// Params 0
// Checksum 0x77faff85, Offset: 0x220
// Size: 0x1c
function on_player_spawned()
{
    self thread armblade_sound_thread();
}

// Namespace armblade
// Params 0
// Checksum 0xc0d48719, Offset: 0x248
// Size: 0x130
function armblade_sound_thread()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    
    for ( ;; )
    {
        result = self util::waittill_any_return( "weapon_change", "disconnect" );
        
        if ( isdefined( result ) )
        {
            if ( result == "weapon_change" && self getcurrentweapon() == level.weaponarmblade )
            {
                if ( !isdefined( self.armblade_loop_sound ) )
                {
                    self.armblade_loop_sound = spawn( "script_origin", self.origin );
                    self.armblade_loop_sound linkto( self );
                }
                
                self.armblade_loop_sound playloopsound( "wpn_armblade_idle", 0.25 );
                continue;
            }
            
            if ( isdefined( self.armblade_loop_sound ) )
            {
                self.armblade_loop_sound stoploopsound( 0.25 );
            }
        }
    }
}

