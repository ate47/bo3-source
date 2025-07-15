#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;

#namespace aat;

// Namespace aat
// Params 0, eflags: 0x2
// Checksum 0x76876137, Offset: 0x1f0
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "aat", &__init__, &__main__, undefined );
}

// Namespace aat
// Params 0, eflags: 0x4
// Checksum 0xbb1b5306, Offset: 0x238
// Size: 0x1bc
function private __init__()
{
    if ( !( isdefined( level.aat_in_use ) && level.aat_in_use ) )
    {
        return;
    }
    
    level.aat_initializing = 1;
    level.aat = [];
    level.aat[ "none" ] = spawnstruct();
    level.aat[ "none" ].name = "none";
    level.aat_reroll = [];
    callback::on_connect( &on_player_connect );
    spawners = getspawnerarray();
    
    foreach ( spawner in spawners )
    {
        spawner spawner::add_spawn_function( &aat_cooldown_init );
    }
    
    level.aat_exemptions = [];
    zm::register_vehicle_damage_callback( &aat_vehicle_damage_monitor );
    callback::on_finalize_initialization( &finalize_clientfields );
    
    /#
        level thread setup_devgui();
    #/
}

// Namespace aat
// Params 0
// Checksum 0x8a25a474, Offset: 0x400
// Size: 0x3c
function __main__()
{
    if ( !( isdefined( level.aat_in_use ) && level.aat_in_use ) )
    {
        return;
    }
    
    zm::register_zombie_damage_override_callback( &aat_response );
}

// Namespace aat
// Params 0, eflags: 0x4
// Checksum 0x4dfe6e68, Offset: 0x448
// Size: 0xd8
function private on_player_connect()
{
    self.aat = [];
    self.aat_cooldown_start = [];
    keys = getarraykeys( level.aat );
    
    foreach ( key in keys )
    {
        self.aat_cooldown_start[ key ] = 0;
    }
    
    self thread watch_weapon_changes();
    
    /#
    #/
}

/#

    // Namespace aat
    // Params 0, eflags: 0x4
    // Checksum 0x6f2a47f7, Offset: 0x528
    // Size: 0x184, Type: dev
    function private setup_devgui()
    {
        waittillframeend();
        setdvar( "<dev string:x28>", "<dev string:x3b>" );
        aat_devgui_base = "<dev string:x3c>";
        keys = getarraykeys( level.aat );
        
        foreach ( key in keys )
        {
            if ( key != "<dev string:x54>" )
            {
                adddebugcommand( aat_devgui_base + key + "<dev string:x59>" + "<dev string:x28>" + "<dev string:x61>" + key + "<dev string:x63>" );
            }
        }
        
        adddebugcommand( aat_devgui_base + "<dev string:x67>" + "<dev string:x28>" + "<dev string:x61>" + "<dev string:x54>" + "<dev string:x63>" );
        level thread aat_devgui_think();
    }

    // Namespace aat
    // Params 0, eflags: 0x4
    // Checksum 0x249169ae, Offset: 0x6b8
    // Size: 0x158, Type: dev
    function private aat_devgui_think()
    {
        for ( ;; )
        {
            aat_name = getdvarstring( "<dev string:x28>" );
            
            if ( aat_name != "<dev string:x3b>" )
            {
                for ( i = 0; i < level.players.size ; i++ )
                {
                    if ( aat_name == "<dev string:x54>" )
                    {
                        level.players[ i ] thread remove( level.players[ i ] getcurrentweapon() );
                    }
                    else
                    {
                        level.players[ i ] thread acquire( level.players[ i ] getcurrentweapon(), aat_name );
                    }
                    
                    level.players[ i ] thread aat_set_debug_text( aat_name, 0, 0, 0 );
                }
            }
            
            setdvar( "<dev string:x28>", "<dev string:x3b>" );
            wait 0.5;
        }
    }

    // Namespace aat
    // Params 0, eflags: 0x4
    // Checksum 0x516dc590, Offset: 0x818
    // Size: 0x15c, Type: dev
    function private aat_debug_text_display_init()
    {
        self.aat_debug_text = newclienthudelem( self );
        self.aat_debug_text.elemtype = "<dev string:x7c>";
        self.aat_debug_text.font = "<dev string:x81>";
        self.aat_debug_text.fontscale = 1.8;
        self.aat_debug_text.horzalign = "<dev string:x8b>";
        self.aat_debug_text.vertalign = "<dev string:x90>";
        self.aat_debug_text.alignx = "<dev string:x8b>";
        self.aat_debug_text.aligny = "<dev string:x90>";
        self.aat_debug_text.x = 15;
        self.aat_debug_text.y = 15;
        self.aat_debug_text.sort = 2;
        self.aat_debug_text.color = ( 1, 1, 1 );
        self.aat_debug_text.alpha = 1;
        self.aat_debug_text.hidewheninmenu = 1;
        self thread aat_debug_text_display_monitor();
    }

    // Namespace aat
    // Params 0, eflags: 0x4
    // Checksum 0x7b8de09d, Offset: 0x980
    // Size: 0x90, Type: dev
    function private aat_debug_text_display_monitor()
    {
        self endon( #"disconnect" );
        
        while ( true )
        {
            self waittill( #"weapon_change", weapon );
            name = "<dev string:x54>";
            
            if ( isdefined( self.aat[ weapon ] ) )
            {
                name = self.aat[ weapon ];
            }
            
            self thread aat_set_debug_text( name, 0, 0, 0 );
        }
    }

#/

// Namespace aat
// Params 4, eflags: 0x4
// Checksum 0x7eaa0364, Offset: 0xa18
// Size: 0x1f4
function private aat_set_debug_text( name, success, success_reroll, fail )
{
    /#
        self notify( #"aat_set_debug_text_thread" );
        self endon( #"aat_set_debug_text_thread" );
        self endon( #"disconnect" );
        
        if ( !isdefined( self.aat_debug_text ) )
        {
            return;
        }
        
        percentage = "<dev string:x94>";
        
        if ( isdefined( level.aat[ name ] ) && name != "<dev string:x54>" )
        {
            percentage = level.aat[ name ].percentage;
        }
        
        self.aat_debug_text fadeovertime( 0.05 );
        self.aat_debug_text.alpha = 1;
        self.aat_debug_text settext( "<dev string:x98>" + name + "<dev string:x9e>" + percentage );
        
        if ( success )
        {
            self.aat_debug_text.color = ( 0, 1, 0 );
        }
        else if ( success_reroll )
        {
            self.aat_debug_text.color = ( 0.8, 0, 0.8 );
        }
        else if ( fail )
        {
            self.aat_debug_text.color = ( 1, 0, 0 );
        }
        else
        {
            self.aat_debug_text.color = ( 1, 1, 1 );
        }
        
        wait 1;
        self.aat_debug_text fadeovertime( 1 );
        self.aat_debug_text.color = ( 1, 1, 1 );
        
        if ( "<dev string:x54>" == name )
        {
            self.aat_debug_text.alpha = 0;
        }
    #/
}

// Namespace aat
// Params 0
// Checksum 0x9c126700, Offset: 0xc18
// Size: 0xb8
function aat_cooldown_init()
{
    self.aat_cooldown_start = [];
    keys = getarraykeys( level.aat );
    
    foreach ( key in keys )
    {
        self.aat_cooldown_start[ key ] = 0;
    }
}

// Namespace aat
// Params 15, eflags: 0x4
// Checksum 0x9e699fb9, Offset: 0xcd8
// Size: 0x100
function private aat_vehicle_damage_monitor( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    willbekilled = self.health - idamage <= 0;
    
    if ( isdefined( level.aat_in_use ) && level.aat_in_use )
    {
        self thread aat_response( willbekilled, einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, vsurfacenormal );
    }
    
    return idamage;
}

// Namespace aat
// Params 1
// Checksum 0x8503cb0e, Offset: 0xde0
// Size: 0x38
function get_nonalternate_weapon( weapon )
{
    if ( isdefined( weapon ) && weapon.isaltmode )
    {
        return weapon.altweapon;
    }
    
    return weapon;
}

// Namespace aat
// Params 13
// Checksum 0x2031490d, Offset: 0xe20
// Size: 0x5fc
function aat_response( death, inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype )
{
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( mod != "MOD_PISTOL_BULLET" && mod != "MOD_RIFLE_BULLET" && mod != "MOD_GRENADE" && mod != "MOD_PROJECTILE" && mod != "MOD_EXPLOSIVE" && mod != "MOD_IMPACT" )
    {
        return;
    }
    
    weapon = get_nonalternate_weapon( weapon );
    name = attacker.aat[ weapon ];
    
    if ( !isdefined( name ) )
    {
        return;
    }
    
    if ( death && !level.aat[ name ].occurs_on_death )
    {
        return;
    }
    
    if ( !isdefined( self.archetype ) )
    {
        return;
    }
    
    if ( isdefined( level.aat[ name ].immune_trigger[ self.archetype ] ) && level.aat[ name ].immune_trigger[ self.archetype ] )
    {
        return;
    }
    
    now = gettime() / 1000;
    
    if ( now <= self.aat_cooldown_start[ name ] + level.aat[ name ].cooldown_time_entity )
    {
        return;
    }
    
    if ( now <= attacker.aat_cooldown_start[ name ] + level.aat[ name ].cooldown_time_attacker )
    {
        return;
    }
    
    if ( now <= level.aat[ name ].cooldown_time_global_start + level.aat[ name ].cooldown_time_global )
    {
        return;
    }
    
    if ( isdefined( level.aat[ name ].validation_func ) )
    {
        if ( !self [[ level.aat[ name ].validation_func ]]() )
        {
            return;
        }
    }
    
    success = 0;
    reroll_icon = undefined;
    percentage = level.aat[ name ].percentage;
    
    /#
        aat_percentage_override = getdvarfloat( "<dev string:xa5>" );
        
        if ( aat_percentage_override > 0 )
        {
            percentage = aat_percentage_override;
        }
    #/
    
    if ( percentage >= randomfloat( 1 ) )
    {
        success = 1;
        attacker thread aat_set_debug_text( name, 1, 0, 0 );
    }
    
    if ( !success )
    {
        keys = getarraykeys( level.aat_reroll );
        keys = array::randomize( keys );
        
        foreach ( key in keys )
        {
            if ( attacker [[ level.aat_reroll[ key ].active_func ]]() )
            {
                for ( i = 0; i < level.aat_reroll[ key ].count ; i++ )
                {
                    if ( percentage >= randomfloat( 1 ) )
                    {
                        success = 1;
                        reroll_icon = level.aat_reroll[ key ].damage_feedback_icon;
                        attacker thread aat_set_debug_text( name, 0, 1, 0 );
                        break;
                    }
                }
            }
            
            if ( success )
            {
                break;
            }
        }
    }
    
    if ( !success )
    {
        attacker thread aat_set_debug_text( name, 0, 0, 1 );
        return;
    }
    
    level.aat[ name ].cooldown_time_global_start = now;
    attacker.aat_cooldown_start[ name ] = now;
    self thread [[ level.aat[ name ].result_func ]]( death, attacker, mod, weapon );
    attacker thread damagefeedback::update_override( level.aat[ name ].damage_feedback_icon, level.aat[ name ].damage_feedback_sound, reroll_icon );
}

// Namespace aat
// Params 10
// Checksum 0x412b79f4, Offset: 0x1428
// Size: 0x5e8
function register( name, percentage, cooldown_time_entity, cooldown_time_attacker, cooldown_time_global, occurs_on_death, result_func, damage_feedback_icon, damage_feedback_sound, validation_func )
{
    assert( isdefined( level.aat_initializing ) && level.aat_initializing, "<dev string:xc1>" );
    assert( isdefined( name ), "<dev string:x12c>" );
    assert( "<dev string:x54>" != name, "<dev string:x152>" + "<dev string:x54>" + "<dev string:x174>" );
    assert( !isdefined( level.aat[ name ] ), "<dev string:x1ab>" + name + "<dev string:x1c2>" );
    assert( isdefined( percentage ), "<dev string:x1ab>" + name + "<dev string:x1e0>" );
    assert( 0 <= percentage && 1 > percentage, "<dev string:x1ab>" + name + "<dev string:x1fe>" );
    assert( isdefined( cooldown_time_entity ), "<dev string:x1ab>" + name + "<dev string:x247>" );
    assert( 0 <= cooldown_time_entity, "<dev string:x1ab>" + name + "<dev string:x26f>" );
    assert( isdefined( cooldown_time_entity ), "<dev string:x1ab>" + name + "<dev string:x2b2>" );
    assert( 0 <= cooldown_time_entity, "<dev string:x1ab>" + name + "<dev string:x2dc>" );
    assert( isdefined( cooldown_time_global ), "<dev string:x1ab>" + name + "<dev string:x321>" );
    assert( 0 <= cooldown_time_global, "<dev string:x1ab>" + name + "<dev string:x349>" );
    assert( isdefined( occurs_on_death ), "<dev string:x1ab>" + name + "<dev string:x38c>" );
    assert( isdefined( result_func ), "<dev string:x1ab>" + name + "<dev string:x3af>" );
    assert( isdefined( damage_feedback_icon ), "<dev string:x1ab>" + name + "<dev string:x3ce>" );
    assert( isstring( damage_feedback_icon ), "<dev string:x1ab>" + name + "<dev string:x3f6>" );
    assert( isdefined( damage_feedback_sound ), "<dev string:x1ab>" + name + "<dev string:x41f>" );
    assert( isstring( damage_feedback_sound ), "<dev string:x1ab>" + name + "<dev string:x448>" );
    level.aat[ name ] = spawnstruct();
    level.aat[ name ].name = name;
    level.aat[ name ].hash_id = hashstring( name );
    level.aat[ name ].percentage = percentage;
    level.aat[ name ].cooldown_time_entity = cooldown_time_entity;
    level.aat[ name ].cooldown_time_attacker = cooldown_time_attacker;
    level.aat[ name ].cooldown_time_global = cooldown_time_global;
    level.aat[ name ].cooldown_time_global_start = 0;
    level.aat[ name ].occurs_on_death = occurs_on_death;
    level.aat[ name ].result_func = result_func;
    level.aat[ name ].damage_feedback_icon = damage_feedback_icon;
    level.aat[ name ].damage_feedback_sound = damage_feedback_sound;
    level.aat[ name ].validation_func = validation_func;
    level.aat[ name ].immune_trigger = [];
    level.aat[ name ].immune_result_direct = [];
    level.aat[ name ].immune_result_indirect = [];
}

// Namespace aat
// Params 5
// Checksum 0x37aaa5cd, Offset: 0x1a18
// Size: 0x21e
function register_immunity( name, archetype, immune_trigger, immune_result_direct, immune_result_indirect )
{
    while ( level.aat_initializing !== 0 )
    {
        wait 0.05;
    }
    
    assert( isdefined( name ), "<dev string:x12c>" );
    assert( isdefined( archetype ), "<dev string:x472>" );
    assert( isdefined( immune_trigger ), "<dev string:x49d>" );
    assert( isdefined( immune_result_direct ), "<dev string:x4cd>" );
    assert( isdefined( immune_result_indirect ), "<dev string:x503>" );
    
    if ( !isdefined( level.aat[ name ].immune_trigger ) )
    {
        level.aat[ name ].immune_trigger = [];
    }
    
    if ( !isdefined( level.aat[ name ].immune_result_direct ) )
    {
        level.aat[ name ].immune_result_direct = [];
    }
    
    if ( !isdefined( level.aat[ name ].immune_result_indirect ) )
    {
        level.aat[ name ].immune_result_indirect = [];
    }
    
    level.aat[ name ].immune_trigger[ archetype ] = immune_trigger;
    level.aat[ name ].immune_result_direct[ archetype ] = immune_result_direct;
    level.aat[ name ].immune_result_indirect[ archetype ] = immune_result_indirect;
}

// Namespace aat
// Params 0
// Checksum 0x6b9ed8d1, Offset: 0x1c40
// Size: 0x180
function finalize_clientfields()
{
    println( "<dev string:x53b>" );
    
    if ( level.aat.size > 1 )
    {
        array::alphabetize( level.aat );
        i = 0;
        
        foreach ( aat in level.aat )
        {
            aat.clientfield_index = i;
            i++;
            println( "<dev string:x555>" + aat.name );
        }
        
        n_bits = getminbitcountfornum( level.aat.size - 1 );
        clientfield::register( "toplayer", "aat_current", 1, n_bits, "int" );
    }
    
    level.aat_initializing = 0;
}

// Namespace aat
// Params 1
// Checksum 0xd31efc16, Offset: 0x1dc8
// Size: 0x3a
function register_aat_exemption( weapon )
{
    weapon = get_nonalternate_weapon( weapon );
    level.aat_exemptions[ weapon ] = 1;
}

// Namespace aat
// Params 1
// Checksum 0xfc2a3a52, Offset: 0x1e10
// Size: 0x36, Type: bool
function is_exempt_weapon( weapon )
{
    weapon = get_nonalternate_weapon( weapon );
    return isdefined( level.aat_exemptions[ weapon ] );
}

// Namespace aat
// Params 4
// Checksum 0xc6af835a, Offset: 0x1e50
// Size: 0x264
function register_reroll( name, count, active_func, damage_feedback_icon )
{
    assert( isdefined( name ), "<dev string:x55a>" );
    assert( "<dev string:x54>" != name, "<dev string:x588>" + "<dev string:x54>" + "<dev string:x174>" );
    assert( !isdefined( level.aat[ name ] ), "<dev string:x5b1>" + name + "<dev string:x1c2>" );
    assert( isdefined( count ), "<dev string:x5d5>" + name + "<dev string:x5fa>" );
    assert( 0 < count, "<dev string:x5d5>" + name + "<dev string:x613>" );
    assert( isdefined( active_func ), "<dev string:x5d5>" + name + "<dev string:x633>" );
    assert( isdefined( damage_feedback_icon ), "<dev string:x5d5>" + name + "<dev string:x3ce>" );
    assert( isstring( damage_feedback_icon ), "<dev string:x5d5>" + name + "<dev string:x3f6>" );
    level.aat_reroll[ name ] = spawnstruct();
    level.aat_reroll[ name ].name = name;
    level.aat_reroll[ name ].count = count;
    level.aat_reroll[ name ].active_func = active_func;
    level.aat_reroll[ name ].damage_feedback_icon = damage_feedback_icon;
}

// Namespace aat
// Params 1
// Checksum 0xcd56baf7, Offset: 0x20c0
// Size: 0xc0
function getaatonweapon( weapon )
{
    weapon = get_nonalternate_weapon( weapon );
    
    if ( !isdefined( self.aat ) || weapon == level.weaponnone || !( isdefined( level.aat_in_use ) && level.aat_in_use ) || is_exempt_weapon( weapon ) || !isdefined( self.aat[ weapon ] ) || !isdefined( level.aat[ self.aat[ weapon ] ] ) )
    {
        return undefined;
    }
    
    return level.aat[ self.aat[ weapon ] ];
}

// Namespace aat
// Params 2
// Checksum 0x35532001, Offset: 0x2188
// Size: 0x25c
function acquire( weapon, name )
{
    if ( !( isdefined( level.aat_in_use ) && level.aat_in_use ) )
    {
        return;
    }
    
    assert( isdefined( weapon ), "<dev string:x652>" );
    assert( weapon != level.weaponnone, "<dev string:x679>" );
    weapon = get_nonalternate_weapon( weapon );
    
    if ( is_exempt_weapon( weapon ) )
    {
        return;
    }
    
    if ( isdefined( name ) )
    {
        assert( "<dev string:x54>" != name, "<dev string:x6ad>" + "<dev string:x54>" + "<dev string:x174>" );
        assert( isdefined( level.aat[ name ] ), "<dev string:x6ce>" + name + "<dev string:x6e4>" );
        self.aat[ weapon ] = name;
    }
    else
    {
        keys = getarraykeys( level.aat );
        arrayremovevalue( keys, "none" );
        
        if ( isdefined( self.aat[ weapon ] ) )
        {
            arrayremovevalue( keys, self.aat[ weapon ] );
        }
        
        rand = randomint( keys.size );
        self.aat[ weapon ] = keys[ rand ];
    }
    
    if ( weapon == self getcurrentweapon() )
    {
        self clientfield::set_to_player( "aat_current", level.aat[ self.aat[ weapon ] ].clientfield_index );
    }
}

// Namespace aat
// Params 1
// Checksum 0x27eb2834, Offset: 0x23f0
// Size: 0xa4
function remove( weapon )
{
    if ( !( isdefined( level.aat_in_use ) && level.aat_in_use ) )
    {
        return;
    }
    
    assert( isdefined( weapon ), "<dev string:x6fb>" );
    assert( weapon != level.weaponnone, "<dev string:x721>" );
    weapon = get_nonalternate_weapon( weapon );
    self.aat[ weapon ] = undefined;
}

// Namespace aat
// Params 0
// Checksum 0xd8e52f7b, Offset: 0x24a0
// Size: 0xc8
function watch_weapon_changes()
{
    self endon( #"disconnect" );
    self endon( #"entityshutdown" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"weapon_change", weapon );
        weapon = get_nonalternate_weapon( weapon );
        name = "none";
        
        if ( isdefined( self.aat[ weapon ] ) )
        {
            name = self.aat[ weapon ];
        }
        
        self clientfield::set_to_player( "aat_current", level.aat[ name ].clientfield_index );
    }
}

