#using scripts/codescripts/struct;
#using scripts/cp/voice/voice_newworld;
#using scripts/shared/music_shared;

#namespace cp_mi_zurich_newworld_sound;

// Namespace cp_mi_zurich_newworld_sound
// Params 0
// Checksum 0x6405a8ca, Offset: 0x230
// Size: 0x5c
function main()
{
    voice_newworld::init_voice();
    level thread function_9c5a4eb0();
    level thread function_9c09862a();
    level thread function_3c510972();
}

// Namespace cp_mi_zurich_newworld_sound
// Params 0
// Checksum 0x68f5f2fb, Offset: 0x298
// Size: 0x2c
function function_9c5a4eb0()
{
    level waittill( #"hash_d195be99" );
    wait 2;
    music::setmusicstate( "brave" );
}

// Namespace cp_mi_zurich_newworld_sound
// Params 0
// Checksum 0x57b98341, Offset: 0x2d0
// Size: 0x2c
function function_9c09862a()
{
    level waittill( #"hash_ddeafd5d" );
    music::setmusicstate( "intro" );
}

// Namespace cp_mi_zurich_newworld_sound
// Params 0
// Checksum 0x2d910a52, Offset: 0x308
// Size: 0x2c
function function_3c510972()
{
    level waittill( #"hash_79929eec" );
    wait 3;
    music::setmusicstate( "hall_introduction" );
}

#namespace namespace_e38c3c58;

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0xc2698042, Offset: 0x340
// Size: 0x1c
function function_973b77f9()
{
    music::setmusicstate( "none" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0x605080bc, Offset: 0x368
// Size: 0x1c
function function_d942ea3b()
{
    music::setmusicstate( "subway_tension_loop" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0x37d9319e, Offset: 0x390
// Size: 0x1c
function function_71fee4f3()
{
    music::setmusicstate( "brave_hallway" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0x3a012352, Offset: 0x3b8
// Size: 0x1c
function function_68f4508b()
{
    music::setmusicstate( "brave_big_room" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0xa5eabe04, Offset: 0x3e0
// Size: 0x1c
function function_d4def1a6()
{
    music::setmusicstate( "brave_post_hallway" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0x43e1bf3d, Offset: 0x408
// Size: 0x1c
function function_964ce03c()
{
    music::setmusicstate( "hack" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0x328ad1d7, Offset: 0x430
// Size: 0x1c
function function_fa2e45b8()
{
    music::setmusicstate( "battle_1" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0x501e4cbd, Offset: 0x458
// Size: 0x1c
function function_606b7b8()
{
    music::setmusicstate( "chase" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0x1439f0b3, Offset: 0x480
// Size: 0x1c
function function_f4a6634b()
{
    music::setmusicstate( "brain_suck" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0xffd5dd15, Offset: 0x4a8
// Size: 0x1c
function function_92eefdb3()
{
    music::setmusicstate( "diaz_wall_training" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0x86487f7f, Offset: 0x4d0
// Size: 0x1c
function function_d8182956()
{
    music::setmusicstate( "diaz_drone_training" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0x92d6d9e4, Offset: 0x4f8
// Size: 0x1c
function function_ccafa212()
{
    music::setmusicstate( "foundry_battle" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0x5d510df7, Offset: 0x520
// Size: 0x1c
function function_bb8ce831()
{
    music::setmusicstate( "tension_loop_1" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0xe1899e4c, Offset: 0x548
// Size: 0x24
function function_57c68b7b()
{
    wait 3;
    music::setmusicstate( "inside_man" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0x6a04fa2d, Offset: 0x578
// Size: 0x1c
function function_a99be221()
{
    music::setmusicstate( "train_battle" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0xe6049706, Offset: 0x5a0
// Size: 0x1c
function function_922297e3()
{
    music::setmusicstate( "bomb_disarm" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0x53b9a66c, Offset: 0x5c8
// Size: 0x1c
function function_9c65cf9a()
{
    music::setmusicstate( "wake_up" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0xbc73dd64, Offset: 0x5f0
// Size: 0x1c
function function_a693b757()
{
    music::setmusicstate( "interface" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0xd3e76538, Offset: 0x618
// Size: 0x1c
function function_57a2519c()
{
    music::setmusicstate( "none" );
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0x41ed8ebc, Offset: 0x640
// Size: 0xdc
function function_5a7ad30()
{
    if ( !isdefined( level.var_485316b5 ) )
    {
        level.var_485316b5 = spawn( "script_origin", ( -25886, 39179, 4219 ) );
    }
    
    wait 5;
    level.var_485316b5 playloopsound( "vox_civ_train_walla" );
    level waittill( #"panic" );
    level.var_485316b5 stoploopsound();
    level.var_485316b5 playloopsound( "vox_civ_panic_train" );
    level waittill( #"hash_a0228009" );
    level.var_485316b5 stoploopsound();
}

// Namespace namespace_e38c3c58
// Params 0
// Checksum 0xf05d03a5, Offset: 0x728
// Size: 0xa4
function function_c132cd41()
{
    if ( !isdefined( level.var_de0151a7 ) )
    {
        level.var_de0151a7 = spawn( "script_origin", ( -26271, 15583, 4212 ) );
    }
    
    level.var_de0151a7 playloopsound( "amb_train_interior_ending" );
    level waittill( #"hash_c053b2ca" );
    level.var_de0151a7 stoploopsound( 1 );
    wait 1;
    level.var_de0151a7 delete();
}

