#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/util_shared;

#namespace zm_zod_fx;

// Namespace zm_zod_fx
// Params 0
// Checksum 0x7b618d5d, Offset: 0x648
// Size: 0x44
function main()
{
    precache_createfx_fx();
    precache_scripted_fx();
    callback::on_localclient_connect( &function_129a815f );
}

// Namespace zm_zod_fx
// Params 0
// Checksum 0xb2c8e393, Offset: 0x698
// Size: 0x26a
function precache_scripted_fx()
{
    level._effect[ "ritual_altar" ] = "zombie/fx_ritual_altar_zod_zmb";
    level._effect[ "ritual_trail" ] = "zombie/fx_ritual_key_trail_zod_zmb";
    level._effect[ "ritual_glow_chest" ] = "zombie/fx_ritual_sacrafice_glow_chest_zod_zmb";
    level._effect[ "ritual_glow_head" ] = "zombie/fx_ritual_sacrafice_glow_head_zod_zmb";
    level._effect[ "ritual_bloodsplosion" ] = "zombie/fx_ritual_sacrafice_death_zod_zmb";
    level._effect[ "darkfire_portal" ] = "zombie/fx_portal_buffed_spawn_zod_zmb";
    level._effect[ "curse_circle" ] = "zombie/fx_sword_quest_ground_fire_purple_zod_zmb";
    level._effect[ "mini_curse_circle" ] = "zombie/fx_sword_quest_ground_fire_sm_zod_zmb";
    level._effect[ "curse_tell" ] = "zombie/fx_shdw_spell_tell_zod_zmb";
    level._effect[ "darkfire_buff" ] = "zombie/fx_fire_head_buffed_zod_zmb";
    level._effect[ "parasite_buff" ] = "zombie/fx_parasite_buff_zod_zmb";
    level._effect[ "meatball_buff" ] = "zombie/fx_meatball_buff_zod_zmb";
    level._effect[ "margwa_buff" ] = "zombie/fx_margwa_buff_zod_zmb";
    level._effect[ "pap_altar_glow" ] = "zombie/fx_ritual_altar_pap_zod_zmb";
    level._effect[ "crane_light" ] = "light/fx_light_zm_crane_light";
    level._effect[ "cultist_crate_personal_item" ] = "zombie/fx_cultist_crate_smk_zod_zmb";
    level._effect[ "sword_quest_ground_tell" ] = "zombie/fx_sword_quest_egg_ground_tell_zod_zmb";
    level._effect[ "sword_quest_ground_glow" ] = "zombie/fx_sword_quest_egg_ground_glow_zod_zmb";
    level._effect[ "sword_quest_egg_explosion" ] = "zombie/fx_sword_quest_egg_explo_zod_zmb";
    level._effect[ "sword_quest_sword_glow" ] = "zombie/fx_sword_quest_glow_zod_zmb";
    level._effect[ "gateworm_basin_placed" ] = "zombie/fx_ritual_pap_basin_fire_zod_zmb";
    level._effect[ "gateworm_basin_quest_complete" ] = "zombie/fx_ritual_pap_basin_fire_lg_zod_zmb";
}

// Namespace zm_zod_fx
// Params 0
// Checksum 0x99ec1590, Offset: 0x910
// Size: 0x4
function precache_createfx_fx()
{
    
}

// Namespace zm_zod_fx
// Params 1
// Checksum 0x3ad0a71d, Offset: 0x920
// Size: 0x24
function function_129a815f( localclientnum )
{
    thread function_47ecaed4( localclientnum );
}

// Namespace zm_zod_fx
// Params 1
// Checksum 0x4099864b, Offset: 0x950
// Size: 0x1e8
function function_47ecaed4( localclientnum )
{
    level.var_ff4acd38 = [];
    i = 0;
    
    for ( var_8c9a6a50 = getent( localclientnum, "lighthouse_light_ring_1", "targetname" ); isdefined( var_8c9a6a50 ) ; var_8c9a6a50 = getent( localclientnum, "lighthouse_light_ring_" + i + 1, "targetname" ) )
    {
        level.var_ff4acd38[ i ] = var_8c9a6a50;
        i++;
    }
    
    for ( ;; )
    {
        function_e9849e59( localclientnum );
        wait 1;
        
        for ( i = 0; i < 4 ; i++ )
        {
            level.var_ff4acd38[ i ] show();
            exploder::exploder( "lighthouse_light_ring_" + i + 1 );
            wait 0.5;
        }
        
        exploder::exploder( "lighthouse_light_spotlight" );
        wait 1;
        function_e9849e59( localclientnum );
        wait 0.5;
        function_fe8322ed( localclientnum );
        wait 0.25;
        function_e9849e59( localclientnum );
        wait 0.25;
        function_fe8322ed( localclientnum );
        wait 1.25;
    }
}

// Namespace zm_zod_fx
// Params 1
// Checksum 0x5ce81e5d, Offset: 0xb40
// Size: 0x94
function function_e9849e59( localclientnum )
{
    for ( i = 0; i < level.var_ff4acd38.size ; i++ )
    {
        level.var_ff4acd38[ i ] hide();
        exploder::stop_exploder( "lighthouse_light_ring_" + i + 1 );
    }
    
    exploder::stop_exploder( "lighthouse_light_spotlight" );
}

// Namespace zm_zod_fx
// Params 1
// Checksum 0xf3d3b111, Offset: 0xbe0
// Size: 0x94
function function_fe8322ed( localclientnum )
{
    for ( i = 0; i < level.var_ff4acd38.size ; i++ )
    {
        level.var_ff4acd38[ i ] show();
        exploder::exploder( "lighthouse_light_ring_" + i + 1 );
    }
    
    exploder::exploder( "lighthouse_light_spotlight" );
}

