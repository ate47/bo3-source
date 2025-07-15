#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;

#namespace mp_city_sound;

// Namespace mp_city_sound
// Params 0
// Checksum 0x9b33e655, Offset: 0x1e0
// Size: 0x64
function main()
{
    function_d5fdab67();
    function_435ae334();
    function_f321b162();
    level thread function_16ed034f();
    level thread function_fedfe893();
}

// Namespace mp_city_sound
// Params 0
// Checksum 0x171ecd6b, Offset: 0x250
// Size: 0x94
function function_56481761()
{
    if ( !isdefined( self.var_6250a5f2 ) )
    {
        return;
    }
    
    self stopsound( self.var_6250a5f2 );
    wait 0.05;
    self playloopsound( "amb_vortex_alarm" );
    
    while ( level flag::get( "city_vortex_sequence_playing" ) )
    {
        wait 1;
    }
    
    self stoploopsound();
}

// Namespace mp_city_sound
// Params 0
// Checksum 0x5d1c0839, Offset: 0x2f0
// Size: 0x40
function function_435ae334()
{
    for ( i = 0; i < 5 ; i++ )
    {
        level.var_e84bf965[ i ] = i;
    }
}

// Namespace mp_city_sound
// Params 0
// Checksum 0x10018308, Offset: 0x338
// Size: 0x570
function function_d5fdab67()
{
    level.var_a439908d = [];
    level.var_acff2f79 = [];
    var_85e31a8d = struct::get_array( "snd_medical_pa", "targetname" );
    
    foreach ( var_372de8ef in var_85e31a8d )
    {
        e_snd = spawn( "script_model", var_372de8ef.origin );
        level.var_acff2f79[ level.var_acff2f79.size ] = e_snd;
        level.var_a439908d[ level.var_a439908d.size ] = e_snd;
        e_snd.script_string = var_372de8ef.script_string;
    }
    
    level.var_622fef9a = [];
    var_85e31a8d = struct::get_array( "snd_science_pa", "targetname" );
    
    foreach ( var_372de8ef in var_85e31a8d )
    {
        e_snd = spawn( "script_model", var_372de8ef.origin );
        level.var_622fef9a[ level.var_622fef9a.size ] = e_snd;
        level.var_a439908d[ level.var_a439908d.size ] = e_snd;
        e_snd.script_string = var_372de8ef.script_string;
    }
    
    level.var_c406109 = [];
    var_85e31a8d = struct::get_array( "snd_housing_pa", "targetname" );
    
    foreach ( var_372de8ef in var_85e31a8d )
    {
        e_snd = spawn( "script_model", var_372de8ef.origin );
        level.var_c406109[ level.var_c406109.size ] = e_snd;
        level.var_a439908d[ level.var_a439908d.size ] = e_snd;
        e_snd.script_string = var_372de8ef.script_string;
    }
    
    level.var_d4300506 = [];
    var_85e31a8d = struct::get_array( "snd_security_pa", "targetname" );
    
    foreach ( var_372de8ef in var_85e31a8d )
    {
        e_snd = spawn( "script_model", var_372de8ef.origin );
        level.var_d4300506[ level.var_d4300506.size ] = e_snd;
        level.var_a439908d[ level.var_a439908d.size ] = e_snd;
        e_snd.script_string = var_372de8ef.script_string;
    }
    
    level.var_c4f0b04e = [];
    var_85e31a8d = struct::get_array( "snd_loop_pa", "targetname" );
    
    foreach ( var_372de8ef in var_85e31a8d )
    {
        e_snd = spawn( "script_model", var_372de8ef.origin );
        level.var_c4f0b04e[ level.var_c4f0b04e.size ] = e_snd;
        level.var_a439908d[ level.var_a439908d.size ] = e_snd;
    }
    
    for ( i = 0; i < 5 ; i++ )
    {
        level.var_209a8e7a[ i ] = i;
    }
}

// Namespace mp_city_sound
// Params 0
// Checksum 0x2147682d, Offset: 0x8b0
// Size: 0xf4
function function_f321b162()
{
    level.var_fbe4da77 = array( 20, 20, 20, 20, 10 );
    
    foreach ( location in level.var_209a8e7a )
    {
        for ( i = 0; i < level.var_fbe4da77[ location ] ; i++ )
        {
            level.var_4ee0b380[ location ][ i ] = i + 1;
        }
    }
}

// Namespace mp_city_sound
// Params 1
// Checksum 0xba489071, Offset: 0x9b0
// Size: 0x56
function function_23038cdd( var_e9d60ada )
{
    for ( i = 0; i < level.var_fbe4da77[ var_e9d60ada ] ; i++ )
    {
        level.var_4ee0b380[ var_e9d60ada ][ i ] = i;
    }
}

// Namespace mp_city_sound
// Params 0
// Checksum 0x7d64df87, Offset: 0xa10
// Size: 0x208
function function_16ed034f()
{
    while ( true )
    {
        if ( !level flag::get( "city_vortex_sequence_playing" ) )
        {
            var_e9d60ada = array::random( level.var_e84bf965 );
            var_89777ded = function_7c5e2d56( var_e9d60ada );
            var_f50ea05b = function_5e102426( var_e9d60ada );
            
            foreach ( location in var_89777ded )
            {
                if ( isdefined( location.script_string ) && location.script_string == "indoor" )
                {
                    var_57c20e33 = var_f50ea05b + "_ind";
                    location playsound( var_57c20e33 );
                    location.var_6250a5f2 = var_57c20e33;
                    continue;
                }
                
                location playsound( var_f50ea05b );
                location.var_6250a5f2 = var_f50ea05b;
            }
            
            level.var_e84bf965 = array::exclude( level.var_e84bf965, var_e9d60ada );
            
            if ( level.var_e84bf965.size == 0 )
            {
                function_435ae334();
            }
        }
        
        wait randomfloatrange( 10, 15 );
    }
}

// Namespace mp_city_sound
// Params 1
// Checksum 0xb8047433, Offset: 0xc20
// Size: 0xa2
function function_7c5e2d56( var_e9d60ada )
{
    switch ( var_e9d60ada )
    {
        case 0:
            var_80e5cd2d = level.var_acff2f79;
            break;
        case 1:
            var_80e5cd2d = level.var_622fef9a;
            break;
        case 2:
            var_80e5cd2d = level.var_c406109;
            break;
        case 3:
            var_80e5cd2d = level.var_d4300506;
            break;
        case 4:
            var_80e5cd2d = level.var_c4f0b04e;
            break;
    }
    
    return var_80e5cd2d;
}

// Namespace mp_city_sound
// Params 1
// Checksum 0x86c5c968, Offset: 0xcd0
// Size: 0x124
function function_5e102426( var_e9d60ada )
{
    switch ( var_e9d60ada )
    {
        case 0:
            var_dd098336 = "vox_pavo_medical_";
            var_ac118c92 = 20;
            break;
        case 1:
            var_dd098336 = "vox_pavo_science_";
            var_ac118c92 = 20;
            break;
        case 2:
            var_dd098336 = "vox_pavo_housing_";
            var_ac118c92 = 20;
            break;
        case 3:
            var_dd098336 = "vox_pavo_security_";
            var_ac118c92 = 20;
            break;
        case 4:
            var_dd098336 = "vox_pavo_loop_";
            var_ac118c92 = 10;
            break;
    }
    
    var_3dfe5403 = function_21679d94( var_e9d60ada );
    var_f50ea05b = var_dd098336 + var_3dfe5403;
    return var_f50ea05b;
}

// Namespace mp_city_sound
// Params 1
// Checksum 0x8d2c51c9, Offset: 0xe00
// Size: 0x9e
function function_21679d94( var_e9d60ada )
{
    if ( level.var_4ee0b380[ var_e9d60ada ].size == 0 )
    {
        function_23038cdd( var_e9d60ada );
    }
    
    var_254eebed = array::random( level.var_4ee0b380[ var_e9d60ada ] );
    level.var_4ee0b380[ var_e9d60ada ] = array::exclude( level.var_4ee0b380[ var_e9d60ada ], var_254eebed );
    return var_254eebed;
}

// Namespace mp_city_sound
// Params 0
// Checksum 0xf60cc656, Offset: 0xea8
// Size: 0xbc
function function_fedfe893()
{
    var_5a08b0ed = struct::get_array( "snd_emergency", "targetname" );
    level thread function_4969995f();
    
    if ( !isdefined( var_5a08b0ed ) )
    {
        return;
    }
    
    for ( i = 0; i < 10 ; i++ )
    {
        var_f044f889[ i ] = "vox_emer_emergency_" + i + 1;
    }
    
    function_61448a1f( var_5a08b0ed, var_f044f889 );
}

// Namespace mp_city_sound
// Params 2
// Checksum 0xed93436b, Offset: 0xf70
// Size: 0x110
function function_61448a1f( var_5a08b0ed, var_f044f889 )
{
    level endon( #"disconnect" );
    i = 0;
    
    while ( true )
    {
        foreach ( speaker in var_5a08b0ed )
        {
            playsoundatposition( var_f044f889[ i ], speaker.origin );
        }
        
        if ( i == 9 )
        {
            i = 0;
        }
        else
        {
            i++;
        }
        
        wait randomfloatrange( 120, 180 );
    }
}

// Namespace mp_city_sound
// Params 0
// Checksum 0x84039c3b, Offset: 0x1088
// Size: 0x4e
function function_4969995f()
{
    level endon( #"disconnect" );
    
    while ( true )
    {
        level waittill( #"hash_4527d15e" );
        level flag::clear( "city_vortex_sequence_playing" );
        wait 1;
    }
}

