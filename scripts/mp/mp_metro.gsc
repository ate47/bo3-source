#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_metro_fx;
#using scripts/mp/mp_metro_sound;
#using scripts/mp/mp_metro_train;
#using scripts/shared/clientfield_shared;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_metro;

// Namespace mp_metro
// Params 0
// Checksum 0x15cb9fb7, Offset: 0x1d8
// Size: 0x1ac
function main()
{
    precache();
    setdvar( "phys_buoyancy", 1 );
    clientfield::register( "scriptmover", "mp_metro_train_timer", 1, 1, "int" );
    mp_metro_fx::main();
    mp_metro_sound::main();
    load::main();
    compass::setupminimap( "compass_map_mp_metro" );
    setdvar( "compassmaxrange", "2100" );
    level.cleandepositpoints = array( ( -399.059, 1.39783, -47.875 ), ( -1539.2, -239.678, -207.875 ), ( 878.216, -0.543464, -47.875 ), ( 69.9086, 1382.49, 0.125 ) );
    
    if ( getgametypesetting( "allowMapScripting" ) )
    {
        level thread mp_metro_train::init();
    }
    
    /#
        level thread devgui_metro();
        execdevgui( "<dev string:x28>" );
    #/
}

// Namespace mp_metro
// Params 0
// Checksum 0x99ec1590, Offset: 0x390
// Size: 0x4
function precache()
{
    
}

/#

    // Namespace mp_metro
    // Params 0
    // Checksum 0x1961e654, Offset: 0x3a0
    // Size: 0x100, Type: dev
    function devgui_metro()
    {
        setdvar( "<dev string:x3f>", "<dev string:x4d>" );
        
        for ( ;; )
        {
            wait 0.5;
            devgui_string = getdvarstring( "<dev string:x3f>" );
            
            switch ( devgui_string )
            {
                case "<dev string:x4d>":
                    break;
                case "<dev string:x4e>":
                    level notify( #"train_start_1" );
                    break;
                case "<dev string:x5c>":
                    level notify( #"train_start_2" );
                    break;
                default:
                    break;
            }
            
            if ( getdvarstring( "<dev string:x3f>" ) != "<dev string:x4d>" )
            {
                setdvar( "<dev string:x3f>", "<dev string:x4d>" );
            }
        }
    }

#/
