#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace cybercom_gadget_active_camo;

// Namespace cybercom_gadget_active_camo
// Params 0
// Checksum 0x99ec1590, Offset: 0x428
// Size: 0x4
function init()
{
    
}

// Namespace cybercom_gadget_active_camo
// Params 0
// Checksum 0x8dce94e8, Offset: 0x438
// Size: 0x17c
function main()
{
    cybercom_gadget::registerability( 1, 8, 1 );
    level.cybercom.active_camo = spawnstruct();
    level.cybercom.active_camo._on_flicker = &_on_flicker;
    level.cybercom.active_camo._on_give = &_on_give;
    level.cybercom.active_camo._on_take = &_on_take;
    level.cybercom.active_camo._on_connect = &_on_connect;
    level.cybercom.active_camo._on = &_on;
    level.cybercom.active_camo._off = &_off;
    level.cybercom.active_cammo_upgraded_weap = getweapon( "gadget_active_camo_upgraded" );
    callback::on_disconnect( &_on_disconnect );
}

// Namespace cybercom_gadget_active_camo
// Params 2
// Checksum 0x7db35dd1, Offset: 0x5c0
// Size: 0x14
function _on_flicker( slot, weapon )
{
    
}

// Namespace cybercom_gadget_active_camo
// Params 2
// Checksum 0x63fab902, Offset: 0x5e0
// Size: 0x4c
function _on_give( slot, weapon )
{
    self.cybercom.targetlockcb = undefined;
    self.cybercom.targetlockrequirementcb = undefined;
    self thread cybercom::function_b5f4e597( weapon );
}

// Namespace cybercom_gadget_active_camo
// Params 2
// Checksum 0x93e8d6d6, Offset: 0x638
// Size: 0x3a
function _on_take( slot, weapon )
{
    self notify( #"active_camo_off" );
    self notify( #"active_camo_taken" );
    self notify( #"delete_false_target" );
}

// Namespace cybercom_gadget_active_camo
// Params 0
// Checksum 0x99ec1590, Offset: 0x680
// Size: 0x4
function _on_connect()
{
    
}

// Namespace cybercom_gadget_active_camo
// Params 0
// Checksum 0x4ad88a8d, Offset: 0x690
// Size: 0x2a
function _on_disconnect()
{
    self notify( #"delete_false_target" );
    self notify( #"active_camo_off" );
    self notify( #"active_camo_taken" );
}

// Namespace cybercom_gadget_active_camo
// Params 2
// Checksum 0x1938cdf, Offset: 0x6c8
// Size: 0x21c
function _on( slot, weapon )
{
    self endon( #"active_camo_off" );
    self endon( #"death" );
    self endon( #"disconnect" );
    self clientfield::set( "camo_shader", 1 );
    cybercom::function_adc40f11( weapon, 1 );
    self.cybercom.oldignore = isdefined( self.ignoreme ) && self.ignoreme ? 1 : 0;
    self.ignoreme = 1;
    self.active_camo = 1;
    self playrumbleonentity( "tank_rumble" );
    self thread function_b4902c73( slot, weapon, "scene_disable_player_stuff", "active_camo_taken" );
    self thread _camo_createfalsetarget();
    self thread cybercom::function_c3c6aff4( slot, weapon, "changed_class", "active_camo_off" );
    self thread cybercom::function_c3c6aff4( slot, weapon, "cybercom_disabled", "active_camo_off" );
    self thread function_cba091b7( slot, weapon );
    
    if ( isplayer( self ) )
    {
        itemindex = getitemindexfromref( "cybercom_camo" );
        
        if ( isdefined( itemindex ) )
        {
            self adddstat( "ItemStats", itemindex, "stats", "used", "statValue", 1 );
        }
    }
}

// Namespace cybercom_gadget_active_camo
// Params 2
// Checksum 0xe1a843cc, Offset: 0x8f0
// Size: 0xfe
function _off( slot, weapon )
{
    if ( getdvarint( "tu1_cybercomActiveCamoIgnoreMeFix", 1 ) )
    {
        if ( isdefined( self.cybercom.oldignore ) && self.cybercom.oldignore && self.ignoreme )
        {
        }
        else
        {
            self.ignoreme = 0;
        }
    }
    else if ( isdefined( self.cybercom.oldignore ) )
    {
        self.ignoreme = self.cybercom.oldignore;
    }
    
    self.active_camo = undefined;
    
    /#
        if ( isdefined( self.ignoreme ) && self.ignoreme )
        {
            iprintlnbold( "<dev string:x28>" );
        }
    #/
    
    self notify( #"delete_false_target" );
    self notify( #"active_camo_off" );
}

// Namespace cybercom_gadget_active_camo
// Params 2
// Checksum 0x1a5d7ba6, Offset: 0x9f8
// Size: 0x84
function function_cba091b7( slot, weapon )
{
    self notify( #"hash_cba091b7" );
    self endon( #"hash_cba091b7" );
    self endon( #"disconnect" );
    self endon( #"active_camo_off" );
    self flagsys::wait_till( "mobile_armory_in_use" );
    self gadgetdeactivate( slot, weapon );
}

// Namespace cybercom_gadget_active_camo
// Params 4
// Checksum 0xc0e39802, Offset: 0xa88
// Size: 0xe4
function function_b4902c73( slot, weapon, waitnote, endnote )
{
    self notify( endnote + waitnote + weapon.name );
    self endon( endnote + waitnote + weapon.name );
    self endon( endnote );
    self endon( #"disconnect" );
    self waittill( waitnote );
    
    if ( self hasweapon( weapon ) && isdefined( self.cybercom.activecybercomweapon ) && self.cybercom.activecybercomweapon == weapon )
    {
        self gadgetdeactivate( slot, weapon );
    }
}

// Namespace cybercom_gadget_active_camo
// Params 4, eflags: 0x4
// Checksum 0xccc0772e, Offset: 0xb78
// Size: 0xc2
function private _camo_killreactivateonnotify( slot, note, durationmin, durationmax )
{
    if ( !isdefined( durationmin ) )
    {
        durationmin = 300;
    }
    
    if ( !isdefined( durationmax ) )
    {
        durationmax = 1000;
    }
    
    self endon( #"active_camo_taken" );
    self endon( #"disconnect" );
    self notify( "_camo_killReActivateOnNotify" + slot + note );
    self endon( "_camo_killReActivateOnNotify" + slot + note );
    
    while ( true )
    {
        self waittill( note, param );
        self notify( #"kill_active_cammo_reactivate" );
    }
}

// Namespace cybercom_gadget_active_camo
// Params 0, eflags: 0x4
// Checksum 0x1faa3acf, Offset: 0xc48
// Size: 0x224
function private _camo_createfalsetarget()
{
    self notify( #"delete_false_target" );
    self endon( #"delete_false_target" );
    fakeme = spawn( "script_model", self.origin );
    fakeme setmodel( "tag_origin" );
    fakeme makesentient();
    fakeme.origin += ( 0, 0, 30 );
    fakeme.team = self.team;
    self thread cybercom::deleteentonnote( "disconnect", fakeme );
    self thread cybercom::deleteentonnote( "active_camo_off", fakeme );
    self thread cybercom::deleteentonnote( "delete_false_target", fakeme );
    self thread function_c51ef296( fakeme );
    zmin = self.origin[ 2 ];
    
    while ( isdefined( fakeme ) )
    {
        fakeme.origin += ( randomintrange( -50, 50 ), randomintrange( -50, 50 ), randomintrange( -5, 5 ) );
        
        if ( fakeme.origin[ 2 ] < zmin )
        {
            fakeme.origin = ( fakeme.origin[ 0 ], fakeme.origin[ 1 ], zmin );
        }
        
        wait 0.5;
    }
}

// Namespace cybercom_gadget_active_camo
// Params 1, eflags: 0x4
// Checksum 0xdef7cfee, Offset: 0xe78
// Size: 0x5c
function private function_c51ef296( fakeent )
{
    fakeent endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"weapon_fired", projectile );
        fakeent.origin = self.origin;
    }
}

// Namespace cybercom_gadget_active_camo
// Params 0, eflags: 0x4
// Checksum 0xbc6f286a, Offset: 0xee0
// Size: 0xe0
function private _active_cammo_reactivate()
{
    self notify( #"_active_cammo_reactivate" );
    self endon( #"_active_cammo_reactivate" );
    self endon( #"active_camo_taken" );
    self endon( #"kill_active_cammo_reactivate" );
    
    while ( true )
    {
        self waittill( #"gadget_forced_off", slot, weapon );
        
        if ( isdefined( weapon ) && weapon == level.cybercom.active_cammo_upgraded_weap )
        {
            wait getdvarint( "scr_active_camo_melee_escape_duration_SEC", 1 );
            
            if ( !self gadgetisactive( slot ) )
            {
                self gadgetactivate( slot, weapon, 0 );
            }
        }
    }
}

