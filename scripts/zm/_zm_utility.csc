#using scripts/codescripts/struct;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_weapons;

#namespace zm_utility;

// Namespace zm_utility
// Params 1
// Checksum 0xb6ae7601, Offset: 0x120
// Size: 0x4c
function ignore_triggers( timer )
{
    self endon( #"death" );
    self.ignoretriggers = 1;
    
    if ( isdefined( timer ) )
    {
        wait timer;
    }
    else
    {
        wait 0.5;
    }
    
    self.ignoretriggers = 0;
}

// Namespace zm_utility
// Params 0
// Checksum 0x11d2e351, Offset: 0x178
// Size: 0x6, Type: bool
function is_encounter()
{
    return false;
}

// Namespace zm_utility
// Params 1
// Checksum 0xb233f14b, Offset: 0x188
// Size: 0x4c
function round_up_to_ten( score )
{
    new_score = score - score % 10;
    
    if ( new_score < score )
    {
        new_score += 10;
    }
    
    return new_score;
}

// Namespace zm_utility
// Params 2
// Checksum 0x2eea486c, Offset: 0x1e0
// Size: 0x70
function round_up_score( score, value )
{
    score = int( score );
    new_score = score - score % value;
    
    if ( new_score < score )
    {
        new_score += value;
    }
    
    return new_score;
}

// Namespace zm_utility
// Params 1
// Checksum 0xdd0d5faf, Offset: 0x258
// Size: 0x3c
function halve_score( n_score )
{
    n_score /= 2;
    n_score = round_up_score( n_score, 10 );
    return n_score;
}

// Namespace zm_utility
// Params 6
// Checksum 0x12f62812, Offset: 0x2a0
// Size: 0xf0
function spawn_weapon_model( localclientnum, weapon, model, origin, angles, options )
{
    if ( !isdefined( model ) )
    {
        model = weapon.worldmodel;
    }
    
    weapon_model = spawn( localclientnum, origin, "script_model" );
    
    if ( isdefined( angles ) )
    {
        weapon_model.angles = angles;
    }
    
    if ( isdefined( options ) )
    {
        weapon_model useweaponmodel( weapon, model, options );
    }
    else
    {
        weapon_model useweaponmodel( weapon, model );
    }
    
    return weapon_model;
}

// Namespace zm_utility
// Params 5
// Checksum 0x8b1bdca1, Offset: 0x398
// Size: 0xb0
function spawn_buildkit_weapon_model( localclientnum, weapon, camo, origin, angles )
{
    weapon_model = spawn( localclientnum, origin, "script_model" );
    
    if ( isdefined( angles ) )
    {
        weapon_model.angles = angles;
    }
    
    weapon_model usebuildkitweaponmodel( localclientnum, weapon, camo, zm_weapons::is_weapon_upgraded( weapon ) );
    return weapon_model;
}

// Namespace zm_utility
// Params 0
// Checksum 0xee3faa58, Offset: 0x450
// Size: 0x8, Type: bool
function is_classic()
{
    return true;
}

// Namespace zm_utility
// Params 1
// Checksum 0x24c4905c, Offset: 0x460
// Size: 0xb2
function is_gametype_active( a_gametypes )
{
    b_is_gametype_active = 0;
    
    if ( !isarray( a_gametypes ) )
    {
        a_gametypes = array( a_gametypes );
    }
    
    for ( i = 0; i < a_gametypes.size ; i++ )
    {
        if ( getdvarstring( "g_gametype" ) == a_gametypes[ i ] )
        {
            b_is_gametype_active = 1;
        }
    }
    
    return b_is_gametype_active;
}

// Namespace zm_utility
// Params 7
// Checksum 0x363e5e7b, Offset: 0x520
// Size: 0xa4
function setinventoryuimodels( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isspectating( localclientnum ) )
    {
        return;
    }
    
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "zmInventory." + fieldname ), newval );
}

// Namespace zm_utility
// Params 7
// Checksum 0x3437d677, Offset: 0x5d0
// Size: 0x84
function setsharedinventoryuimodels( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "zmInventory." + fieldname ), newval );
}

// Namespace zm_utility
// Params 7
// Checksum 0xa49f2bb2, Offset: 0x660
// Size: 0xdc
function zm_ui_infotext( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "zmInventory.infoText" ), fieldname );
        return;
    }
    
    setuimodelvalue( createuimodel( getuimodelforcontroller( localclientnum ), "zmInventory.infoText" ), "" );
}

/#

    // Namespace zm_utility
    // Params 4
    // Checksum 0x195d843, Offset: 0x748
    // Size: 0x2b6, Type: dev
    function drawcylinder( pos, rad, height, color )
    {
        currad = rad;
        curheight = height;
        debugstar( pos, 1, color );
        
        for ( r = 0; r < 20 ; r++ )
        {
            theta = r / 20 * 360;
            theta2 = ( r + 1 ) / 20 * 360;
            line( pos + ( cos( theta ) * currad, sin( theta ) * currad, 0 ), pos + ( cos( theta2 ) * currad, sin( theta2 ) * currad, 0 ), color, 1, 1, 100 );
            line( pos + ( cos( theta ) * currad, sin( theta ) * currad, curheight ), pos + ( cos( theta2 ) * currad, sin( theta2 ) * currad, curheight ), color, 1, 1, 100 );
            line( pos + ( cos( theta ) * currad, sin( theta ) * currad, 0 ), pos + ( cos( theta ) * currad, sin( theta ) * currad, curheight ), color, 1, 1, 100 );
        }
    }

#/

// Namespace zm_utility
// Params 1
// Checksum 0xbf9f9b53, Offset: 0xa08
// Size: 0xb0
function umbra_fix_logic( localclientnum )
{
    self endon( #"disconnect" );
    self endon( #"entityshutdown" );
    umbra_settometrigger( localclientnum, "" );
    
    while ( true )
    {
        in_fix_area = 0;
        
        if ( isdefined( level.custom_umbra_hotfix ) )
        {
            in_fix_area = self thread [[ level.custom_umbra_hotfix ]]( localclientnum );
        }
        
        if ( in_fix_area == 0 )
        {
            umbra_settometrigger( localclientnum, "" );
        }
        
        wait 0.05;
    }
}

// Namespace zm_utility
// Params 5
// Checksum 0xcbf2edac, Offset: 0xac0
// Size: 0x12e, Type: bool
function umbra_fix_trigger( localclientnum, pos, height, radius, umbra_name )
{
    bottomy = pos[ 2 ];
    topy = pos[ 2 ] + height;
    
    if ( self.origin[ 2 ] > bottomy && self.origin[ 2 ] < topy )
    {
        if ( distance2dsquared( self.origin, pos ) < radius * radius )
        {
            umbra_settometrigger( localclientnum, umbra_name );
            
            /#
                drawcylinder( pos, radius, height, ( 0, 1, 0 ) );
            #/
            
            return true;
        }
    }
    
    /#
        drawcylinder( pos, radius, height, ( 1, 0, 0 ) );
    #/
    
    return false;
}

