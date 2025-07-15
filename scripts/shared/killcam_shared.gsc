#namespace killcam;

// Namespace killcam
// Params 1
// Checksum 0xb03fd074, Offset: 0x78
// Size: 0x7a
function get_killcam_entity_start_time( killcamentity )
{
    killcamentitystarttime = 0;
    
    if ( isdefined( killcamentity ) )
    {
        if ( isdefined( killcamentity.starttime ) )
        {
            killcamentitystarttime = killcamentity.starttime;
        }
        else
        {
            killcamentitystarttime = killcamentity.birthtime;
        }
        
        if ( !isdefined( killcamentitystarttime ) )
        {
            killcamentitystarttime = 0;
        }
    }
    
    return killcamentitystarttime;
}

// Namespace killcam
// Params 1
// Checksum 0x9aa781f7, Offset: 0x100
// Size: 0x6c
function store_killcam_entity_on_entity( killcam_entity )
{
    assert( isdefined( killcam_entity ) );
    self.killcamentitystarttime = get_killcam_entity_start_time( killcam_entity );
    self.killcamentityindex = killcam_entity getentitynumber();
}

