#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace bot;

// Namespace bot
// Params 0
// Checksum 0x75ffa77b, Offset: 0x140
// Size: 0x1c
function tap_attack_button()
{
    self bottapbutton( 0 );
}

// Namespace bot
// Params 0
// Checksum 0xb3d880d9, Offset: 0x168
// Size: 0x1c
function press_attack_button()
{
    self botpressbutton( 0 );
}

// Namespace bot
// Params 0
// Checksum 0xa48cf6e6, Offset: 0x190
// Size: 0x1c
function release_attack_button()
{
    self botreleasebutton( 0 );
}

// Namespace bot
// Params 0
// Checksum 0x9d7d8ed0, Offset: 0x1b8
// Size: 0x1c
function tap_melee_button()
{
    self bottapbutton( 2 );
}

// Namespace bot
// Params 0
// Checksum 0xb6119dc2, Offset: 0x1e0
// Size: 0x1c
function tap_reload_button()
{
    self bottapbutton( 4 );
}

// Namespace bot
// Params 0
// Checksum 0x7933018b, Offset: 0x208
// Size: 0x1c
function tap_use_button()
{
    self bottapbutton( 3 );
}

// Namespace bot
// Params 0
// Checksum 0x17ee89da, Offset: 0x230
// Size: 0x1c
function press_crouch_button()
{
    self botpressbutton( 9 );
}

// Namespace bot
// Params 0
// Checksum 0xddec69ce, Offset: 0x258
// Size: 0x1c
function press_use_button()
{
    self botpressbutton( 3 );
}

// Namespace bot
// Params 0
// Checksum 0xc4d15f07, Offset: 0x280
// Size: 0x1c
function release_use_button()
{
    self botreleasebutton( 3 );
}

// Namespace bot
// Params 0
// Checksum 0x33f4e241, Offset: 0x2a8
// Size: 0x1c
function press_sprint_button()
{
    self botpressbutton( 1 );
}

// Namespace bot
// Params 0
// Checksum 0xc0cb8156, Offset: 0x2d0
// Size: 0x1c
function release_sprint_button()
{
    self botreleasebutton( 1 );
}

// Namespace bot
// Params 0
// Checksum 0xda8d193c, Offset: 0x2f8
// Size: 0x1c
function press_frag_button()
{
    self botpressbutton( 14 );
}

// Namespace bot
// Params 0
// Checksum 0xb1235ab2, Offset: 0x320
// Size: 0x1c
function release_frag_button()
{
    self botreleasebutton( 14 );
}

// Namespace bot
// Params 0
// Checksum 0x43ec809c, Offset: 0x348
// Size: 0x1c
function tap_frag_button()
{
    self bottapbutton( 14 );
}

// Namespace bot
// Params 0
// Checksum 0x68c94938, Offset: 0x370
// Size: 0x1c
function press_offhand_button()
{
    self botpressbutton( 15 );
}

// Namespace bot
// Params 0
// Checksum 0xc60e6e25, Offset: 0x398
// Size: 0x1c
function release_offhand_button()
{
    self botreleasebutton( 15 );
}

// Namespace bot
// Params 0
// Checksum 0xef948000, Offset: 0x3c0
// Size: 0x1c
function tap_offhand_button()
{
    self bottapbutton( 15 );
}

// Namespace bot
// Params 0
// Checksum 0xd3efc323, Offset: 0x3e8
// Size: 0x1c
function press_throw_button()
{
    self botpressbutton( 24 );
}

// Namespace bot
// Params 0
// Checksum 0x29270269, Offset: 0x410
// Size: 0x1c
function release_throw_button()
{
    self botreleasebutton( 24 );
}

// Namespace bot
// Params 0
// Checksum 0x7e406c51, Offset: 0x438
// Size: 0x1c
function tap_jump_button()
{
    self bottapbutton( 10 );
}

// Namespace bot
// Params 0
// Checksum 0xe0bb035, Offset: 0x460
// Size: 0x1c
function press_jump_button()
{
    self botpressbutton( 10 );
}

// Namespace bot
// Params 0
// Checksum 0xc7ae8781, Offset: 0x488
// Size: 0x1c
function release_jump_button()
{
    self botreleasebutton( 10 );
}

// Namespace bot
// Params 0
// Checksum 0x2d774993, Offset: 0x4b0
// Size: 0x1c
function tap_ads_button()
{
    self bottapbutton( 11 );
}

// Namespace bot
// Params 0
// Checksum 0x216c0d22, Offset: 0x4d8
// Size: 0x1c
function press_ads_button()
{
    self botpressbutton( 11 );
}

// Namespace bot
// Params 0
// Checksum 0x9712a321, Offset: 0x500
// Size: 0x1c
function release_ads_button()
{
    self botreleasebutton( 11 );
}

// Namespace bot
// Params 0
// Checksum 0xc260f5d0, Offset: 0x528
// Size: 0x1c
function tap_doublejump_button()
{
    self bottapbutton( 65 );
}

// Namespace bot
// Params 0
// Checksum 0xbf64306e, Offset: 0x550
// Size: 0x1c
function press_doublejump_button()
{
    self botpressbutton( 65 );
}

// Namespace bot
// Params 0
// Checksum 0x2fa85805, Offset: 0x578
// Size: 0x1c
function release_doublejump_button()
{
    self botreleasebutton( 65 );
}

// Namespace bot
// Params 0
// Checksum 0x4ccde880, Offset: 0x5a0
// Size: 0x1c
function tap_offhand_special_button()
{
    self bottapbutton( 70 );
}

// Namespace bot
// Params 0
// Checksum 0xf56fe6f8, Offset: 0x5c8
// Size: 0x1c
function press_swim_up()
{
    self botpressbutton( 67 );
}

// Namespace bot
// Params 0
// Checksum 0xea4c1900, Offset: 0x5f0
// Size: 0x1c
function release_swim_up()
{
    self botreleasebutton( 67 );
}

// Namespace bot
// Params 0
// Checksum 0x5d43953c, Offset: 0x618
// Size: 0x1c
function press_swim_down()
{
    self botpressbutton( 68 );
}

// Namespace bot
// Params 0
// Checksum 0x87872c69, Offset: 0x640
// Size: 0x1c
function release_swim_down()
{
    self botreleasebutton( 68 );
}

