#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/warlord;

#namespace warlordinterface;

// Namespace warlordinterface
// Params 0
// Checksum 0xb93c4b1a, Offset: 0xe8
// Size: 0x3c
function registerwarlordinterfaceattributes()
{
    ai::registermatchedinterface( "warlord", "can_be_meleed", 0, array( 1, 0 ) );
}

// Namespace warlordinterface
// Params 4
// Checksum 0x8ea2474c, Offset: 0x130
// Size: 0x4c
function addpreferedpoint( position, min_duration, max_duration, name )
{
    warlordserverutils::addpreferedpoint( self, position, min_duration, max_duration, name );
}

// Namespace warlordinterface
// Params 1
// Checksum 0x3c9366c3, Offset: 0x188
// Size: 0x24
function deletepreferedpoint( name )
{
    warlordserverutils::deletepreferedpoint( self, name );
}

// Namespace warlordinterface
// Params 0
// Checksum 0x195bb928, Offset: 0x1b8
// Size: 0x1c
function clearallpreferedpoints()
{
    warlordserverutils::clearallpreferedpoints( self );
}

// Namespace warlordinterface
// Params 0
// Checksum 0x1be4a021, Offset: 0x1e0
// Size: 0x1c
function clearpreferedpointsoutsidegoal()
{
    warlordserverutils::clearpreferedpointsoutsidegoal( self );
}

// Namespace warlordinterface
// Params 1
// Checksum 0xf5a33898, Offset: 0x208
// Size: 0x24
function setwarlordaggressivemode( b_aggressive_mode )
{
    warlordserverutils::setwarlordaggressivemode( self );
}

