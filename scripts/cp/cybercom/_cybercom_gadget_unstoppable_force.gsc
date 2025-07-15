#using scripts/codescripts/struct;
#using scripts/cp/_achievements;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace cybercom_gadget_unstoppable_force;

// Namespace cybercom_gadget_unstoppable_force
// Params 0
// Checksum 0x99ec1590, Offset: 0x490
// Size: 0x4
function init()
{
    
}

// Namespace cybercom_gadget_unstoppable_force
// Params 0
// Checksum 0xd56624ed, Offset: 0x4a0
// Size: 0x1b4
function main()
{
    cybercom_gadget::registerability( 1, 32, 1 );
    level.cybercom.unstoppable_force = spawnstruct();
    level.cybercom.unstoppable_force._is_flickering = &_is_flickering;
    level.cybercom.unstoppable_force._on_flicker = &_on_flicker;
    level.cybercom.unstoppable_force._on_give = &_on_give;
    level.cybercom.unstoppable_force._on_take = &_on_take;
    level.cybercom.unstoppable_force._on_connect = &_on_connect;
    level.cybercom.unstoppable_force._on = &_on;
    level.cybercom.unstoppable_force._off = &_off;
    level.cybercom.unstoppable_force._is_primed = &_is_primed;
    level.cybercom.unstoppable_force.weapon = getweapon( "gadget_unstoppable_force" );
}

// Namespace cybercom_gadget_unstoppable_force
// Params 1
// Checksum 0xb8a858d, Offset: 0x660
// Size: 0xc
function _is_flickering( slot )
{
    
}

// Namespace cybercom_gadget_unstoppable_force
// Params 2
// Checksum 0x2d847b4d, Offset: 0x678
// Size: 0x14
function _on_flicker( slot, weapon )
{
    
}

// Namespace cybercom_gadget_unstoppable_force
// Params 2
// Checksum 0x7cc6630e, Offset: 0x698
// Size: 0x4c
function _on_give( slot, weapon )
{
    self.cybercom.targetlockcb = undefined;
    self.cybercom.targetlockrequirementcb = undefined;
    self thread cybercom::function_b5f4e597( weapon );
}

// Namespace cybercom_gadget_unstoppable_force
// Params 2
// Checksum 0xf459e1fc, Offset: 0x6f0
// Size: 0x22
function _on_take( slot, weapon )
{
    self.cybercom.is_primed = undefined;
}

// Namespace cybercom_gadget_unstoppable_force
// Params 0
// Checksum 0x99ec1590, Offset: 0x720
// Size: 0x4
function _on_connect()
{
    
}

// Namespace cybercom_gadget_unstoppable_force
// Params 2
// Checksum 0xbb463f3, Offset: 0x730
// Size: 0x144
function _on( slot, weapon )
{
    self disableoffhandweapons();
    self disableweaponcycling();
    achievements::function_386309ce( self );
    self.cybercom.is_primed = undefined;
    self notify( weapon.name + "_fired" );
    level notify( weapon.name + "_fired" );
    self thread function_875f1595( slot, weapon );
    
    if ( isplayer( self ) )
    {
        itemindex = getitemindexfromref( "cybercom_unstoppableforce" );
        
        if ( isdefined( itemindex ) )
        {
            self adddstat( "ItemStats", itemindex, "stats", "used", "statValue", 1 );
        }
    }
}

// Namespace cybercom_gadget_unstoppable_force
// Params 2
// Checksum 0xe2461242, Offset: 0x880
// Size: 0xb4
function _off( slot, weapon )
{
    self clientfield::set_to_player( "unstoppableforce_state", 0 );
    self notify( #"unstoppable_watch_collisions" );
    self notify( #"hash_1f17ce9a" );
    self playsound( "gdt_unstoppable_stop" );
    self gadgetpowerset( slot, 0 );
    self enableoffhandweapons();
    self enableweaponcycling();
}

// Namespace cybercom_gadget_unstoppable_force
// Params 2, eflags: 0x4
// Checksum 0x2b856617, Offset: 0x940
// Size: 0x44
function private function_1852a14f( slot, weapon )
{
    self endon( #"weapon_melee_juke" );
    wait 0.5;
    self gadgetpowerchange( slot, -100 );
}

// Namespace cybercom_gadget_unstoppable_force
// Params 2, eflags: 0x4
// Checksum 0x1292c7b8, Offset: 0x990
// Size: 0x54
function private function_6c3ee126( slot, weapon )
{
    self endon( #"disconnect" );
    self endon( #"hash_1f17ce9a" );
    self waittill( #"weapon_melee_juke_end" );
    self gadgetpowerset( slot, 0 );
}

// Namespace cybercom_gadget_unstoppable_force
// Params 2, eflags: 0x4
// Checksum 0xf2827496, Offset: 0x9f0
// Size: 0xbc
function private function_98296a6a( slot, weapon )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self waittill( #"weapon_juke_end_requested", endreason );
    
    if ( endreason == 2 )
    {
        earthquake( 1, 0.75, self.origin, 100 );
        self playrumbleonentity( "riotshield_impact" );
        self playsound( "gdt_unstoppable_hit_wall" );
    }
}

// Namespace cybercom_gadget_unstoppable_force
// Params 2
// Checksum 0x6eafd620, Offset: 0xab8
// Size: 0x14
function _is_primed( slot, weapon )
{
    
}

// Namespace cybercom_gadget_unstoppable_force
// Params 2, eflags: 0x4
// Checksum 0x40fa9ea2, Offset: 0xad8
// Size: 0x114
function private function_875f1595( slot, weapon )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"hash_1f17ce9a" );
    self clientfield::set_to_player( "unstoppableforce_state", 1 );
    wait 0.05;
    
    if ( self isswitchingweapons() )
    {
        self waittill( #"weapon_change_complete" );
    }
    
    self thread watch_collisions( weapon );
    self thread function_6c3ee126( slot, weapon );
    self thread function_98296a6a( slot, weapon );
    self thread function_1852a14f( slot, weapon );
    self queuemeleeactionstate();
}

// Namespace cybercom_gadget_unstoppable_force
// Params 1, eflags: 0x4
// Checksum 0x6e8607a5, Offset: 0xbf8
// Size: 0x1b0, Type: bool
function private _is_good_target( target )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    if ( !isalive( target ) )
    {
        return false;
    }
    
    if ( target cybercom::cybercom_aicheckoptout( "cybercom_unstoppableforce" ) )
    {
        return false;
    }
    
    if ( !( isdefined( target.takedamage ) && target.takedamage ) )
    {
        return false;
    }
    
    if ( isactor( target ) )
    {
        if ( target isinscriptedstate() && !( isdefined( target.is_disabled ) && target.is_disabled ) )
        {
            if ( !target cybercom::function_421746e0() )
            {
                return false;
            }
        }
    }
    
    if ( !( isdefined( target.allowdeath ) && target.allowdeath ) )
    {
        return false;
    }
    
    if ( isdefined( target.blockingpain ) && target.blockingpain )
    {
        return false;
    }
    
    if ( isactor( target ) && target cybercom::getentitypose() != "stand" && target cybercom::getentitypose() != "crouch" )
    {
        return false;
    }
    
    return true;
}

// Namespace cybercom_gadget_unstoppable_force
// Params 0, eflags: 0x4
// Checksum 0xc43471f1, Offset: 0xdb0
// Size: 0x106
function private _get_valid_targets()
{
    enemies = arraycombine( getaiteamarray( "axis" ), getaiteamarray( "team3" ), 0, 0 );
    valid = [];
    
    foreach ( mf in enemies )
    {
        if ( !_is_good_target( mf ) )
        {
            continue;
        }
        
        valid[ valid.size ] = mf;
    }
    
    return valid;
}

// Namespace cybercom_gadget_unstoppable_force
// Params 0, eflags: 0x4
// Checksum 0xf18a0b83, Offset: 0xec0
// Size: 0x2a
function private function_40b93b78()
{
    self stopjukemove();
    self notify( #"unstoppable_watch_collisions" );
}

// Namespace cybercom_gadget_unstoppable_force
// Params 2, eflags: 0x4
// Checksum 0xcfcb6134, Offset: 0xef8
// Size: 0x304
function private hit_vehicle( enemy, weapon )
{
    if ( enemy cybercom::islinked() )
    {
        enemy unlink();
    }
    
    enemy notify( #"cybercom_action", weapon, self );
    
    if ( enemy.scriptvehicletype == "quadtank" || enemy.scriptvehicletype == "siegebot" )
    {
        enemy dodamage( getdvarint( "scr_unstoppable_heavy_vehicle_damage", 300 ), self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.weapon, -1, 1 );
        self function_40b93b78();
        return;
    }
    
    if ( enemy.scriptvehicletype == "raps" || enemy.scriptvehicletype == "wasp" )
    {
        enemy dodamage( enemy.health, self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.weapon, -1, 1 );
        return;
    }
    
    if ( enemy.scriptvehicletype == "amws" )
    {
        enemy dodamage( enemy.health, self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.weapon, -1, 1 );
        self function_40b93b78();
        return;
    }
    
    if ( enemy.scriptvehicletype == "" )
    {
        if ( enemy.archetype == "turret" )
        {
            enemy dodamage( enemy.health, self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.weapon, -1, 1 );
            self function_40b93b78();
        }
    }
}

// Namespace cybercom_gadget_unstoppable_force
// Params 2
// Checksum 0x61394378, Offset: 0x1208
// Size: 0x264
function hit_enemy( guy, weapon )
{
    if ( guy cybercom::islinked() )
    {
        guy unlink();
    }
    
    guy notify( #"cybercom_action", weapon, self );
    
    if ( guy.archetype == "warlord" )
    {
        if ( isdefined( guy.is_disabled ) && guy.is_disabled )
        {
            guy dodamage( guy.health, self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.var_bf0de5fb, -1, 1 );
        }
        else
        {
            guy dodamage( getdvarint( "scr_unstoppable_warlord_damage", 40 ), self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.weapon, -1, 1 );
        }
    }
    else if ( guy.archetype == "human_riotshield" )
    {
        guy dodamage( guy.health, self.origin, self, self, "none", "MOD_IMPACT", 0, weapon, -1, 1 );
        guy notify( #"bhtn_action_notify", "reactBodyBlow" );
    }
    else
    {
        guy function_b4852552( self );
    }
    
    if ( guy.archetype == "robot" )
    {
        self playsound( "gdt_unstoppable_hit_bot" );
        return;
    }
    
    self playsound( "gdt_unstoppable_hit_human" );
}

// Namespace cybercom_gadget_unstoppable_force
// Params 1
// Checksum 0xbb304b91, Offset: 0x1478
// Size: 0x1c0
function watch_collisions( weapon )
{
    self notify( #"unstoppable_watch_collisions" );
    self endon( #"unstoppable_watch_collisions" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        enemies = function_518996b3();
        hit = 0;
        
        foreach ( guy in enemies )
        {
            hit++;
            
            if ( isvehicle( guy ) )
            {
                self playsound( "gdt_unstoppable_hit_veh" );
                self hit_vehicle( guy, weapon );
                continue;
            }
            
            self hit_enemy( guy, weapon );
        }
        
        if ( hit )
        {
            earthquake( 1, 0.75, self.origin, 100 );
            self playrumbleonentity( "damage_heavy" );
        }
        
        wait 0.05;
    }
}

// Namespace cybercom_gadget_unstoppable_force
// Params 0
// Checksum 0x1a0511bb, Offset: 0x1640
// Size: 0x336
function function_518996b3()
{
    enemies = _get_valid_targets();
    view_pos = self.origin;
    validtargets = array::get_all_closest( view_pos, enemies, undefined, undefined, 120 );
    
    if ( !isdefined( validtargets ) )
    {
        return;
    }
    
    forward = anglestoforward( self getplayerangles() );
    up = anglestoup( self getplayerangles() );
    segment_start = view_pos + 36 * forward;
    segment_end = segment_start + ( 120 - 36 ) * forward;
    fling_force = getdvarint( "scr_unstoppable_fling_force", 175 );
    fling_force_vlo = fling_force * 0.5;
    fling_force_vhi = fling_force * 0.6;
    enemies = [];
    
    for ( i = 0; i < validtargets.size ; i++ )
    {
        if ( !isdefined( validtargets[ i ] ) || !isalive( validtargets[ i ] ) )
        {
            continue;
        }
        
        test_origin = validtargets[ i ] getcentroid();
        radial_origin = pointonsegmentnearesttopoint( segment_start, segment_end, test_origin );
        lateral = test_origin - radial_origin;
        
        if ( abs( lateral[ 2 ] ) > 72 )
        {
            continue;
        }
        
        lateral = ( lateral[ 0 ], lateral[ 1 ], 0 );
        len = length( lateral );
        
        if ( len > 36 )
        {
            continue;
        }
        
        lateral = ( lateral[ 0 ], lateral[ 1 ], 0 );
        validtargets[ i ].fling_vec = fling_force * forward + randomfloatrange( fling_force_vlo, fling_force_vhi ) * up;
        enemies[ enemies.size ] = validtargets[ i ];
    }
    
    return enemies;
}

// Namespace cybercom_gadget_unstoppable_force
// Params 1
// Checksum 0xda4231cc, Offset: 0x1980
// Size: 0xbc
function function_b4852552( player )
{
    if ( !isdefined( self ) || !isalive( self ) )
    {
        return;
    }
    
    self dodamage( self.health, player.origin, player, player, "", "MOD_IMPACT" );
    
    if ( isdefined( self.fling_vec ) )
    {
        self startragdoll( 1 );
        self launchragdoll( self.fling_vec );
    }
}

