#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_callbacks;

#namespace zm_ai_margwa_elemental;

// Namespace zm_ai_margwa_elemental
// Params 0, eflags: 0x2
// Checksum 0xf1a5b2f1, Offset: 0x708
// Size: 0x40a
function autoexec init()
{
    callback::add_weapon_type( "launcher_shadow_margwa", &function_894980af );
    clientfield::register( "actor", "margwa_elemental_type", 15000, 3, "int", &function_1fb4e300, 0, 0 );
    clientfield::register( "actor", "margwa_defense_actor_appear_disappear_fx", 15000, 1, "int", &function_345693f6, 0, 0 );
    clientfield::register( "scriptmover", "play_margwa_fire_attack_fx", 15000, 1, "counter", &function_c46381fc, 0, 0 );
    clientfield::register( "scriptmover", "margwa_defense_hovering_fx", 15000, 3, "int", &function_abb174cf, 0, 0 );
    clientfield::register( "actor", "shadow_margwa_attack_portal_fx", 15000, 1, "int", &shadow_margwa_attack_portal_fx, 0, 0 );
    clientfield::register( "actor", "margwa_shock_fx", 15000, 1, "int", &death_ray_shock_fx, 0, 0 );
    level._effect[ "margwa_fire_roar" ] = "dlc4/genesis/fx_margwa_roar_fire";
    level._effect[ "margwa_fire_spawn" ] = "dlc4/genesis/fx_margwa_spawn_fire";
    level._effect[ "margwa_fire_attack_explosion" ] = "dlc4/genesis/fx_margwa_attack_fire";
    level._effect[ "margwa_fire_defense_disappear" ] = "dlc4/genesis/fx_margwa_attack_fire";
    level._effect[ "margwa_fire_defense_appear" ] = "dlc4/genesis/fx_margwa_attack_fire";
    level._effect[ "margwa_fire_defense_fireball" ] = "zombie/fx_meatball_portal_sky_zod_zmb";
    level._effect[ "margwa_fire_head_hit" ] = "dlc4/genesis/fx_margwa_head_shot_fire";
    level._effect[ "margwa_shadow_roar" ] = "dlc4/genesis/fx_margwa_roar_shadow";
    level._effect[ "margwa_shadow_spawn" ] = "dlc4/genesis/fx_margwa_spawn_shadow";
    level._effect[ "margwa_shadow_attack_portal_open" ] = "dlc4/genesis/fx_margwa_portal_open_shadow";
    level._effect[ "margwa_shadow_attack_portal_loop" ] = "dlc4/genesis/fx_margwa_portal_loop_shadow";
    level._effect[ "margwa_shadow_attack_portal_close" ] = "dlc4/genesis/fx_margwa_portal_close_shadow";
    level._effect[ "margwa_shadow_defense_disappear" ] = "dlc1/castle/fx_demon_gate_portal_open";
    level._effect[ "margwa_shadow_defense_appear" ] = "dlc1/castle/fx_demon_gate_portal_open";
    level._effect[ "margwa_shadow_defense_ball" ] = "smoke/fx_smk_barrel_30x30";
    level._effect[ "margwa_shadow_head_hit" ] = "dlc4/genesis/fx_margwa_head_shot_shadow";
    level._effect[ "margwa_light_roar" ] = "dlc4/genesis/fx_margwa_roar_light";
    level._effect[ "margwa_light_spawn" ] = "dlc4/genesis/fx_margwa_spawn";
    level._effect[ "margwa_electric_roar" ] = "dlc4/genesis/fx_margwa_roar_electricity";
    level._effect[ "margwa_electric_spawn" ] = "dlc4/genesis/fx_margwa_spawn";
}

// Namespace zm_ai_margwa_elemental
// Params 7, eflags: 0x4
// Checksum 0xdecc5c06, Offset: 0xb20
// Size: 0xfe
function private function_1fb4e300( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self util::waittill_dobj( localclientnum );
    
    switch ( newval )
    {
        case 1:
            self function_fd0bfd3( localclientnum );
            break;
        case 2:
            self function_8a262a34( localclientnum );
            break;
        case 3:
            self function_78f9b77d( localclientnum );
            break;
        case 4:
            self function_ec63e97f( localclientnum );
            break;
    }
}

// Namespace zm_ai_margwa_elemental
// Params 7
// Checksum 0xf052bff3, Offset: 0xc28
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

// Namespace zm_ai_margwa_elemental
// Params 1
// Checksum 0x3b93dcd7, Offset: 0xd58
// Size: 0x4c
function function_7772592b( localclientnum )
{
    self notify( #"hash_51adc559" );
    self endon( #"hash_51adc559" );
    level waittill( #"demo_jump" );
    self function_51adc559( localclientnum );
}

// Namespace zm_ai_margwa_elemental
// Params 1
// Checksum 0x32d3f892, Offset: 0xdb0
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

// Namespace zm_ai_margwa_elemental
// Params 1, eflags: 0x4
// Checksum 0x123f4fc3, Offset: 0xe10
// Size: 0x6c
function private function_fd0bfd3( localclientnum )
{
    self.margwa_roar_effect = level._effect[ "margwa_fire_roar" ];
    self.margwa_spawn_effect = level._effect[ "margwa_fire_spawn" ];
    self.margwa_head_hit_fx = level._effect[ "margwa_fire_head_hit" ];
    self.margwa_play_spawn_effect = &function_740a099a;
}

// Namespace zm_ai_margwa_elemental
// Params 1, eflags: 0x4
// Checksum 0x2d004102, Offset: 0xe88
// Size: 0x3c
function private function_8a262a34( localclientnum )
{
    self.margwa_roar_effect = level._effect[ "margwa_electric_roar" ];
    self.margwa_spawn_effect = level._effect[ "margwa_electric_spawn" ];
}

// Namespace zm_ai_margwa_elemental
// Params 1, eflags: 0x4
// Checksum 0xafe35aa0, Offset: 0xed0
// Size: 0x6c
function private function_ec63e97f( localclientnum )
{
    self.margwa_roar_effect = level._effect[ "margwa_shadow_roar" ];
    self.margwa_spawn_effect = level._effect[ "margwa_shadow_spawn" ];
    self.margwa_head_hit_fx = level._effect[ "margwa_shadow_head_hit" ];
    self.margwa_play_spawn_effect = &function_740a099a;
}

// Namespace zm_ai_margwa_elemental
// Params 1, eflags: 0x4
// Checksum 0x323cd0e, Offset: 0xf48
// Size: 0x3c
function private function_78f9b77d( localclientnum )
{
    self.margwa_roar_effect = level._effect[ "margwa_light_roar" ];
    self.margwa_spawn_effect = level._effect[ "margwa_light_spawn" ];
}

// Namespace zm_ai_margwa_elemental
// Params 1, eflags: 0x4
// Checksum 0x2eb17811, Offset: 0xf90
// Size: 0x34
function private function_740a099a( localclientnum )
{
    playfxontag( localclientnum, self.margwa_spawn_effect, self, "tag_origin" );
}

// Namespace zm_ai_margwa_elemental
// Params 7, eflags: 0x4
// Checksum 0x9a1bc5ab, Offset: 0xfd0
// Size: 0x64
function private function_c46381fc( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playfxontag( localclientnum, "dlc4/genesis/fx_margwa_attack_fire", self, "tag_origin" );
}

// Namespace zm_ai_margwa_elemental
// Params 7, eflags: 0x4
// Checksum 0xf5a8f9a5, Offset: 0x1040
// Size: 0x94
function private function_345693f6( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        playfx( localclientnum, level._effect[ "margwa_fire_defense_disappear" ], self gettagorigin( "j_spine_1" ) );
    }
}

// Namespace zm_ai_margwa_elemental
// Params 7, eflags: 0x4
// Checksum 0xe4975a6, Offset: 0x10e0
// Size: 0x2e4
function private function_abb174cf( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        playfxontag( localclientnum, level._effect[ "margwa_fire_defense_appear" ], self, "tag_origin" );
        self.var_aeae71fc = playfxontag( localclientnum, level._effect[ "margwa_fire_defense_fireball" ], self, "tag_origin" );
        self.var_dd81a0f6 = level._effect[ "margwa_fire_defense_appear" ];
    }
    
    if ( newval == 2 )
    {
        playfxontag( localclientnum, level._effect[ "margwa_fire_defense_appear" ], self, "tag_origin" );
        self.var_aeae71fc = playfxontag( localclientnum, level._effect[ "margwa_fire_defense_fireball" ], self, "tag_origin" );
        self.var_dd81a0f6 = level._effect[ "margwa_fire_defense_appear" ];
    }
    
    if ( newval == 3 )
    {
        playfxontag( localclientnum, level._effect[ "margwa_fire_defense_appear" ], self, "tag_origin" );
        self.var_aeae71fc = playfxontag( localclientnum, level._effect[ "margwa_fire_defense_fireball" ], self, "tag_origin" );
        self.var_dd81a0f6 = level._effect[ "margwa_fire_defense_appear" ];
    }
    
    if ( newval == 4 )
    {
        playfxontag( localclientnum, level._effect[ "margwa_shadow_defense_appear" ], self, "tag_origin" );
        self.var_aeae71fc = playfxontag( localclientnum, level._effect[ "margwa_shadow_defense_ball" ], self, "tag_origin" );
        self.var_dd81a0f6 = level._effect[ "margwa_shadow_defense_appear" ];
    }
    
    if ( newval == 0 && isdefined( self.var_aeae71fc ) )
    {
        stopfx( localclientnum, self.var_aeae71fc );
        
        if ( isdefined( self.var_dd81a0f6 ) )
        {
            playfxontag( localclientnum, self.var_dd81a0f6, self, "tag_origin" );
        }
    }
}

// Namespace zm_ai_margwa_elemental
// Params 7, eflags: 0x4
// Checksum 0x6ab63b7c, Offset: 0x13d0
// Size: 0x294
function private shadow_margwa_attack_portal_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        vector = anglestoforward( self.angles );
        portal_pos = self.origin + vector * 96 + ( 0, 0, 72 );
        self.shadow_margwa_attack_portal_fx = playfx( localclientnum, level._effect[ "margwa_shadow_attack_portal_open" ], portal_pos, vector );
        playsound( 0, "zmb_margwa_shadow_portal_open", portal_pos );
        audio::playloopat( "zmb_margwa_shadow_portal_lp", portal_pos );
        wait 0.45;
        
        if ( isalive( self ) && self clientfield::get( "shadow_margwa_attack_portal_fx" ) == 1 )
        {
            self.shadow_margwa_attack_portal_fx = playfx( localclientnum, level._effect[ "margwa_shadow_attack_portal_loop" ], portal_pos, vector );
        }
    }
    
    if ( newval == 0 && isdefined( self.shadow_margwa_attack_portal_fx ) )
    {
        vector = anglestoforward( self.angles );
        portal_pos = self.origin + vector * 96 + ( 0, 0, 72 );
        
        if ( isdefined( self.shadow_margwa_attack_portal_fx ) )
        {
            stopfx( localclientnum, self.shadow_margwa_attack_portal_fx );
        }
        
        playsound( 0, "zmb_margwa_shadow_portal_close", portal_pos );
        audio::stoploopat( "zmb_margwa_shadow_portal_lp", portal_pos );
        playfx( localclientnum, level._effect[ "margwa_shadow_attack_portal_close" ], portal_pos, vector );
    }
}

#using_animtree( "generic" );

// Namespace zm_ai_margwa_elemental
// Params 1
// Checksum 0xe59a765e, Offset: 0x1670
// Size: 0x7c
function function_894980af( localclientnum )
{
    self util::waittill_dobj( localclientnum );
    skull = self;
    
    if ( isdefined( skull ) )
    {
        skull useanimtree( #animtree );
        skull setanim( "ai_zm_dlc4_chomper_shadow_margwa_projectile" );
    }
}

