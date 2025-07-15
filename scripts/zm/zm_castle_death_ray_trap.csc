#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/beam_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_weapons;

#namespace zm_castle_death_ray_trap;

// Namespace zm_castle_death_ray_trap
// Params 0
// Checksum 0xe332f20f, Offset: 0x3d8
// Size: 0x264
function main()
{
    level._effect[ "console_green_light" ] = "dlc1/castle/fx_glow_panel_green_castle";
    level._effect[ "console_red_light" ] = "dlc1/castle/fx_glow_panel_red_castle";
    level._effect[ "tesla_zombie_shock" ] = "dlc1/castle/fx_tesla_trap_body_shock";
    level._effect[ "tesla_zombie_explode" ] = "dlc1/castle/fx_tesla_trap_body_exp";
    clientfield::register( "actor", "death_ray_shock_fx", 5000, 1, "int", &death_ray_shock_fx, 0, 0 );
    clientfield::register( "actor", "death_ray_shock_eye_fx", 5000, 1, "int", &death_ray_shock_eye_fx, 0, 0 );
    clientfield::register( "actor", "death_ray_explode_fx", 5000, 1, "counter", &death_ray_explode_fx, 0, 0 );
    clientfield::register( "scriptmover", "death_ray_status_light", 5000, 2, "int", &death_ray_status_light, 0, 0 );
    clientfield::register( "actor", "tesla_beam_fx", 5000, 1, "counter", &function_200eea36, 0, 0 );
    clientfield::register( "toplayer", "tesla_beam_fx", 5000, 1, "counter", &function_200eea36, 0, 0 );
    clientfield::register( "actor", "tesla_beam_mechz", 5000, 1, "int", &tesla_beam_mechz, 0, 0 );
}

// Namespace zm_castle_death_ray_trap
// Params 7
// Checksum 0x7e36bedb, Offset: 0x648
// Size: 0x124
function death_ray_shock_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self function_51adc559( localclientnum );
    
    if ( newval )
    {
        if ( !isdefined( self.tesla_shock_fx ) )
        {
            tag = "J_SpineUpper";
            
            if ( !self isai() )
            {
                tag = "tag_origin";
            }
            
            self.tesla_shock_fx = playfxontag( localclientnum, level._effect[ "tesla_zombie_shock" ], self, tag );
            self playsound( 0, "zmb_electrocute_zombie" );
        }
        
        if ( isdemoplaying() )
        {
            self thread function_7772592b( localclientnum );
        }
    }
}

// Namespace zm_castle_death_ray_trap
// Params 1
// Checksum 0xdc26ab0d, Offset: 0x778
// Size: 0x4c
function function_7772592b( localclientnum )
{
    self notify( #"hash_51adc559" );
    self endon( #"hash_51adc559" );
    level waittill( #"demo_jump" );
    self function_51adc559( localclientnum );
}

// Namespace zm_castle_death_ray_trap
// Params 1
// Checksum 0xb62d7854, Offset: 0x7d0
// Size: 0x52
function function_51adc559( localclientnum )
{
    if ( isdefined( self.tesla_shock_fx ) )
    {
        deletefx( localclientnum, self.tesla_shock_fx, 1 );
        self.tesla_shock_fx = undefined;
    }
    
    self notify( #"hash_51adc559" );
}

// Namespace zm_castle_death_ray_trap
// Params 7
// Checksum 0x68d17467, Offset: 0x830
// Size: 0xc6
function death_ray_shock_eye_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        if ( !isdefined( self.var_5f35d5e4 ) )
        {
            self.var_5f35d5e4 = playfxontag( localclientnum, level._effect[ "death_ray_shock_eyes" ], self, "J_Eyeball_LE" );
        }
        
        return;
    }
    
    deletefx( localclientnum, self.var_5f35d5e4, 1 );
    self.var_5f35d5e4 = undefined;
}

// Namespace zm_castle_death_ray_trap
// Params 7
// Checksum 0xc097a2b8, Offset: 0x900
// Size: 0x6c
function death_ray_explode_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playfxontag( localclientnum, level._effect[ "tesla_zombie_explode" ], self, "j_spine4" );
}

// Namespace zm_castle_death_ray_trap
// Params 7
// Checksum 0x2cc74244, Offset: 0x978
// Size: 0x17c
function death_ray_status_light( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    v_forward = anglestoright( self.angles );
    v_forward *= -1;
    v_up = anglestoup( self.angles );
    
    if ( isdefined( self.status_fx ) )
    {
        deletefx( localclientnum, self.status_fx, 1 );
        self.status_fx = undefined;
    }
    
    switch ( newval )
    {
        case 0:
            break;
        case 1:
            str_fx_name = "console_green_light";
            tag = "tag_fx_light_green";
            break;
        case 2:
            str_fx_name = "console_red_light";
            tag = "tag_fx_light_red";
            break;
    }
    
    self.status_fx = playfxontag( localclientnum, level._effect[ str_fx_name ], self, tag );
}

// Namespace zm_castle_death_ray_trap
// Params 7
// Checksum 0x1abb6518, Offset: 0xb00
// Size: 0x13c
function function_200eea36( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    a_s_source = [];
    array::add( a_s_source, struct::get( "bolt_source_1" ), 0 );
    array::add( a_s_source, struct::get( "bolt_source_2" ), 0 );
    s_source = arraygetclosest( self.origin, a_s_source );
    
    if ( s_source.targetname === "bolt_source_1" )
    {
        str_beam = "electric_arc_beam_tesla_trap_1_primary";
    }
    else
    {
        str_beam = "electric_arc_beam_tesla_trap_2_primary";
    }
    
    self thread function_ec4ecaed( localclientnum, s_source, str_beam );
}

// Namespace zm_castle_death_ray_trap
// Params 3
// Checksum 0x4e3ee856, Offset: 0xc48
// Size: 0xfc
function function_ec4ecaed( localclientnum, s_source, str_beam )
{
    mdl_source = util::spawn_model( localclientnum, "tag_origin", s_source.origin, s_source.angles );
    level beam::launch( mdl_source, "tag_origin", self, "j_spinelower", str_beam );
    level util::waittill_any_timeout( 1.5, "demo_jump" );
    level beam::kill( mdl_source, "tag_origin", self, "j_spinelower", str_beam );
    mdl_source delete();
}

// Namespace zm_castle_death_ray_trap
// Params 7
// Checksum 0x8e946630, Offset: 0xd50
// Size: 0x1d4
function tesla_beam_mechz( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        a_s_source = [];
        array::add( a_s_source, struct::get( "bolt_source_1" ), 0 );
        array::add( a_s_source, struct::get( "bolt_source_2" ), 0 );
        s_source = arraygetclosest( self.origin, a_s_source );
        
        if ( s_source.targetname === "bolt_source_1" )
        {
            self.str_beam = "electric_arc_beam_tesla_trap_1_primary";
        }
        else
        {
            self.str_beam = "electric_arc_beam_tesla_trap_2_primary";
        }
        
        self.mdl_source = util::spawn_model( localclientnum, "tag_origin", s_source.origin, s_source.angles );
        level beam::launch( self.mdl_source, "tag_origin", self, "j_spinelower", self.str_beam );
        
        if ( isdemoplaying() )
        {
            self thread function_3c5fc735( localclientnum );
        }
        
        return;
    }
    
    function_1139a457( localclientnum );
}

// Namespace zm_castle_death_ray_trap
// Params 1
// Checksum 0xa92b0a90, Offset: 0xf30
// Size: 0x4c
function function_3c5fc735( localclientnum )
{
    self notify( #"hash_1139a457" );
    self endon( #"hash_1139a457" );
    level waittill( #"demo_jump" );
    function_1139a457( localclientnum );
}

// Namespace zm_castle_death_ray_trap
// Params 1
// Checksum 0x6ec0dc46, Offset: 0xf88
// Size: 0x8a
function function_1139a457( localclientnum )
{
    if ( isdefined( self.mdl_source ) && isdefined( self.str_beam ) )
    {
        level beam::kill( self.mdl_source, "tag_origin", self, "j_spinelower", self.str_beam );
        self.mdl_source delete();
        self.str_beam = undefined;
        self notify( #"hash_1139a457" );
    }
}

