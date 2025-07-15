#using scripts/codescripts/struct;
#using scripts/cp/_achievements;
#using scripts/cp/_decorations;
#using scripts/cp/_util;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace challenges;

// Namespace challenges
// Params 0, eflags: 0x2
// Checksum 0xd8275cfe, Offset: 0x5f0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "challenges", &__init__, undefined, undefined );
}

// Namespace challenges
// Params 0
// Checksum 0x74775ef2, Offset: 0x630
// Size: 0x34
function __init__()
{
    init_shared();
    callback::on_start_gametype( &start_gametype );
}

// Namespace challenges
// Params 0
// Checksum 0x38e32ddb, Offset: 0x670
// Size: 0x114
function start_gametype()
{
    if ( !isdefined( level.challengescallbacks ) )
    {
        level.challengescallbacks = [];
    }
    
    waittillframeend();
    
    if ( canprocesschallenges() )
    {
        registerchallengescallback( "actorKilled", &challengeactorkills );
        registerchallengescallback( "actorDamaged", &function_e0360654 );
        registerchallengescallback( "VehicleKilled", &function_2acd9b03 );
        registerchallengescallback( "VehicleDamage", &challengeactorkills );
    }
    
    callback::on_connect( &on_player_connect );
    callback::on_connect( &function_dadf37f9 );
}

// Namespace challenges
// Params 2
// Checksum 0x993a9a3d, Offset: 0x790
// Size: 0x2c
function function_2acd9b03( data, time )
{
    challengeactorkills( data, time );
}

// Namespace challenges
// Params 2
// Checksum 0xc5a0048, Offset: 0x7c8
// Size: 0x2c
function function_7d1957ed( data, time )
{
    function_e0360654( data, time );
}

// Namespace challenges
// Params 2
// Checksum 0x863cbaff, Offset: 0x800
// Size: 0x112
function function_e0360654( data, time )
{
    if ( isdefined( data ) )
    {
        switch ( data.weapon.rootweapon.name )
        {
            case "emp_grenade":
                break;
            case "ravage_core_emp_grenade":
            default:
                if ( !isdefined( data.victim.var_fcad099b ) && data.victim.archetype != "human" )
                {
                    data.attacker addplayerstat( "cybercom_uses_esdamage", 1 );
                    data.attacker addplayerstat( "cybercom_uses_ravagecore", 1 );
                    data.victim.var_fcad099b = 1;
                }
                
                break;
        }
    }
}

// Namespace challenges
// Params 2
// Checksum 0xb272c501, Offset: 0x920
// Size: 0x5ac
function challengeactorkills( data, time )
{
    if ( isdefined( data ) )
    {
        if ( isdefined( data.victim ) && isdefined( data.victim.swarm ) )
        {
            data.attacker addplayerstat( "cybercom_uses_fireflies", 1 );
            data.attacker thread function_96ed590f( "cybercom_uses_chaos" );
        }
        
        if ( isdefined( data.attacker.hijacked_vehicle_entity ) )
        {
            data.attacker addplayerstat( "cybercom_uses_remotehijack", 1 );
        }
        
        if ( data.smeansofdeath == "MOD_GRENADE_SPLASH" || data.smeansofdeath == "MOD_ELECTROCUTED" || data.smeansofdeath == "MOD_GRENADE" || data.smeansofdeath == "MOD_EXPLOSIVE" || data.smeansofdeath == "MOD_BURNED" || data.smeansofdeath == "MOD_PROJECTILE_SPLASH" )
        {
            if ( data.weapon.rootweapon.name != "gadget_concussive_wave" && data.weapon.rootweapon.name != "hero_gravityspikes_cybercom_upgraded" )
            {
                data.attacker addplayerstat( "cybercom_uses_explosives", 1 );
                
                if ( isdefined( data.attacker.heroability ) )
                {
                    if ( data.attacker.heroability.name == "gadget_immolation_upgraded" || data.attacker.heroability.name == "gadget_immolation" )
                    {
                        data.attacker notify( #"hash_a15c319", data.victim );
                    }
                }
            }
        }
        
        switch ( data.weapon.rootweapon.name )
        {
            case "gadget_rapid_strike":
            case "gadget_rapid_strike_upgraded":
                data.attacker notify( #"hash_e11b0770" );
                data.attacker thread function_4c17acc8();
                break;
            case "gadget_immolation":
            case "gadget_immolation_upgraded":
                if ( isdefined( data.victim ) && isdefined( data.attacker ) && !isdefined( data.victim.var_e9560d5 ) )
                {
                    data.victim.var_e9560d5 = 1;
                    data.attacker addplayerstat( "cybercom_uses_immolation", 1 );
                    data.attacker thread function_8ef347b3( data.victim.origin );
                }
                
                break;
            case "gadget_unstoppable_force":
            case "gadget_unstoppable_force_upgraded":
                data.attacker addplayerstat( "cybercom_uses_force", 1 );
                data.attacker addplayerstat( "cybercom_uses_martial", 1 );
                break;
            case "ravage_core_emp_grenade":
            default:
                if ( isdefined( data.victim ) && !isdefined( data.victim.var_fcad099b ) )
                {
                    data.attacker addplayerstat( "cybercom_uses_ravagecore", 1 );
                    data.victim.var_fcad099b = 1;
                }
                
                break;
            case "gadget_concussive_wave":
            case "hero_gravityspikes_cybercom_upgraded":
                if ( isvehicle( data.victim ) )
                {
                    data.attacker addplayerstat( "cybercom_uses_martial", 1 );
                    data.attacker addplayerstat( "cybercom_uses_concussive", 1 );
                }
                
                break;
        }
        
        if ( isdefined( data.attacker ) && isplayer( data.attacker ) )
        {
            data.attacker decorations::function_2bc66a34();
        }
    }
}

// Namespace challenges
// Params 1
// Checksum 0xac05f0d4, Offset: 0xed8
// Size: 0x128
function function_8ef347b3( v_location )
{
    self endon( #"death" );
    self endon( #"stop_catching_immolation_secondaries" );
    
    if ( !isdefined( v_location ) )
    {
        return;
    }
    
    self util::delay_notify( 2, "stop_catching_immolation_secondaries" );
    n_start_time = gettime();
    
    while ( gettime() - n_start_time < 2 )
    {
        self waittill( #"hash_a15c319", e_enemy );
        
        if ( !isdefined( e_enemy ) )
        {
            break;
        }
        
        if ( length( v_location - e_enemy.origin ) < 200 )
        {
            if ( isdefined( e_enemy ) && isdefined( self ) && !isdefined( e_enemy.var_e9560d5 ) )
            {
                e_enemy.var_e9560d5 = 1;
                self addplayerstat( "cybercom_uses_immolation", 1 );
            }
        }
    }
}

// Namespace challenges
// Params 0
// Checksum 0xc776fe1d, Offset: 0x1008
// Size: 0x90
function function_4c17acc8()
{
    self endon( #"death" );
    self endon( #"stop_catching_rapid_strike_attacks" );
    self util::delay_notify( 2, "stop_catching_rapid_strike_attacks" );
    n_start_time = gettime();
    
    while ( gettime() - n_start_time < 2 )
    {
        self waittill( #"hash_e11b0770" );
        self addplayerstat( "cybercom_uses_rapidstrike", 1 );
    }
}

// Namespace challenges
// Params 6
// Checksum 0xad7fff03, Offset: 0x10a0
// Size: 0x164
function actorkilled( einflictor, attacker, idamage, smeansofdeath, weapon, shitloc )
{
    if ( !isdefined( weapon ) )
    {
        weapon = level.weaponnone;
    }
    
    attacker endon( #"disconnect" );
    data = spawnstruct();
    data.victim = self;
    data.einflictor = einflictor;
    data.attacker = attacker;
    data.idamage = idamage;
    data.smeansofdeath = smeansofdeath;
    data.weapon = weapon;
    data.shitloc = shitloc;
    data.time = gettime();
    data.victimweapon = data.victim.currentweapon;
    waitandprocessactorkilledcallback( data );
    data.attacker notify( #"actorkilledchallengesprocessed" );
}

// Namespace challenges
// Params 1
// Checksum 0xf2197840, Offset: 0x1210
// Size: 0x8c
function waitandprocessactorkilledcallback( data )
{
    if ( isdefined( data.attacker ) )
    {
        data.attacker endon( #"disconnect" );
    }
    
    wait 0.05;
    util::waittillslowprocessallowed();
    level thread dochallengecallback( "actorKilled", data );
    level thread doscoreeventcallback( "actorKilled", data );
}

// Namespace challenges
// Params 5
// Checksum 0x5dc5e347, Offset: 0x12a8
// Size: 0x144
function actordamaged( einflictor, attacker, idamage, weapon, shitloc )
{
    if ( !isdefined( weapon ) )
    {
        weapon = level.weaponnone;
    }
    
    attacker endon( #"disconnect" );
    data = spawnstruct();
    data.victim = self;
    data.einflictor = einflictor;
    data.attacker = attacker;
    data.idamage = idamage;
    data.weapon = weapon;
    data.shitloc = shitloc;
    data.time = gettime();
    data.victimweapon = data.victim.currentweapon;
    function_2a703585( data );
    data.attacker notify( #"hash_3cf360d1" );
}

// Namespace challenges
// Params 1
// Checksum 0x4b995b36, Offset: 0x13f8
// Size: 0x6c
function function_2a703585( data )
{
    if ( isdefined( data.attacker ) )
    {
        data.attacker endon( #"disconnect" );
    }
    
    wait 0.05;
    util::waittillslowprocessallowed();
    level thread dochallengecallback( "actorDamaged", data );
}

// Namespace challenges
// Params 6
// Checksum 0xe3c968f5, Offset: 0x1470
// Size: 0x164
function vehiclekilled( einflictor, attacker, idamage, smeansofdeath, weapon, shitloc )
{
    if ( !isdefined( weapon ) )
    {
        weapon = level.weaponnone;
    }
    
    attacker endon( #"disconnect" );
    data = spawnstruct();
    data.victim = self;
    data.einflictor = einflictor;
    data.attacker = attacker;
    data.idamage = idamage;
    data.smeansofdeath = smeansofdeath;
    data.weapon = weapon;
    data.shitloc = shitloc;
    data.time = gettime();
    data.victimweapon = data.victim.currentweapon;
    function_79c2e402( data );
    data.attacker notify( #"hash_962e5616" );
}

// Namespace challenges
// Params 1
// Checksum 0x117e1508, Offset: 0x15e0
// Size: 0x6c
function function_79c2e402( data )
{
    if ( isdefined( data.attacker ) )
    {
        data.attacker endon( #"disconnect" );
    }
    
    wait 0.05;
    util::waittillslowprocessallowed();
    level thread dochallengecallback( "VehicleKilled", data );
}

// Namespace challenges
// Params 5
// Checksum 0x18d2845e, Offset: 0x1658
// Size: 0x144
function vehicledamaged( einflictor, attacker, idamage, weapon, shitloc )
{
    if ( !isdefined( weapon ) )
    {
        weapon = level.weaponnone;
    }
    
    attacker endon( #"disconnect" );
    data = spawnstruct();
    data.victim = self;
    data.einflictor = einflictor;
    data.attacker = attacker;
    data.idamage = idamage;
    data.weapon = weapon;
    data.shitloc = shitloc;
    data.time = gettime();
    data.victimweapon = data.victim.currentweapon;
    function_c0fc6584( data );
    data.attacker notify( #"hash_37eb53e2" );
}

// Namespace challenges
// Params 1
// Checksum 0xa9095c, Offset: 0x17a8
// Size: 0x6c
function function_c0fc6584( data )
{
    if ( isdefined( data.attacker ) )
    {
        data.attacker endon( #"disconnect" );
    }
    
    wait 0.05;
    util::waittillslowprocessallowed();
    level thread dochallengecallback( "VehicleDamaged", data );
}

// Namespace challenges
// Params 0
// Checksum 0xf525f3c3, Offset: 0x1820
// Size: 0x24
function function_85ec34dc()
{
    self thread function_96ed590f( "career_decorations" );
}

// Namespace challenges
// Params 2
// Checksum 0xd204ceae, Offset: 0x1850
// Size: 0x64
function function_96ed590f( statname, n_amount )
{
    if ( !isdefined( n_amount ) )
    {
        n_amount = 1;
    }
    
    self endon( #"disconnect" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self addplayerstat( statname, n_amount );
}

// Namespace challenges
// Params 0
// Checksum 0xf86d77fb, Offset: 0x18c0
// Size: 0x34
function function_dadf37f9()
{
    self.challenge_callback_cp = &function_97666686;
    
    /#
        self thread function_4f96d6bd();
    #/
}

// Namespace challenges
// Params 1
// Checksum 0x1ac98396, Offset: 0x1900
// Size: 0x2a
function function_7fd6c70d( challenge_index )
{
    return tablelookup( "gamedata/stats/cp/statsmilestones3.csv", 0, challenge_index, 5 );
}

// Namespace challenges
// Params 7
// Checksum 0x396ab483, Offset: 0x1938
// Size: 0x216
function function_97666686( rewardxp, maxval, row, tablenumber, challengetype, itemindex, challengeindex )
{
    self function_5bb05b72();
    
    if ( challengeindex == 565 )
    {
        self givedecoration( "cp_medal_all_accolades" );
    }
    
    tier = int( tablelookup( "gamedata/stats/cp/statsmilestones3.csv", 0, challengeindex, 1 ) );
    
    switch ( challengetype )
    {
        case 0:
            challengename = function_7fd6c70d( challengeindex );
            
            switch ( challengename )
            {
                default:
                    break;
                case "CP_CHALLENGES_ALL_COMPLETE":
                    self givedecoration( "cp_medal_all_calling_cards" );
                    break;
            }
            
            break;
        case 1:
            if ( itemindex != 0 )
            {
                self setdstat( "ItemStats", itemindex, "challengeCompleted", tier, 1 );
                self achievements::checkweaponchallengecomplete( tier );
            }
            
            break;
        case 4:
            var_2de0b3d4 = tablelookup( "gamedata/stats/cp/statsmilestones3.csv", 0, challengeindex, 13 );
            self setdstat( "Attachments", var_2de0b3d4, "challengeCompleted", tier, 1 );
            break;
    }
}

// Namespace challenges
// Params 0
// Checksum 0x36b617a0, Offset: 0x1b58
// Size: 0x2ac
function function_5bb05b72()
{
    if ( sessionmodeisonlinegame() )
    {
        return;
    }
    
    var_671e7f8c = self getdstat( "PlayerStatsList", "cp_challenges", "statValue" );
    
    if ( var_671e7f8c > 0 )
    {
        var_2b0fb6af = tablelookuprowcount( "gamedata/stats/cp/statsmilestones3.csv" );
        challenge_data = [];
        
        for ( i = 0; i < var_2b0fb6af - 1 ; i++ )
        {
            challenge_data = tablelookuprow( "gamedata/stats/cp/statsmilestones3.csv", i );
            var_ec486758 = challenge_data[ 3 ];
            
            if ( var_ec486758 == "global" )
            {
                challenge_stat_name = challenge_data[ 4 ];
                
                if ( isdefined( challenge_stat_name ) && challenge_stat_name != "" )
                {
                    var_db5490e3 = self getdstat( "PlayerStatsList", challenge_stat_name, "statValue" );
                    
                    if ( challenge_data[ 10 ] != "" )
                    {
                        var_60596ad1 = int( challenge_data[ 2 ] );
                        
                        if ( var_db5490e3 >= var_60596ad1 )
                        {
                            var_9050c19b = "";
                            var_9050c19b = challenge_data[ 16 ];
                            
                            switch ( var_9050c19b )
                            {
                                case "missions":
                                    self addplayerstat( "conf_gamemode_mastery", 1 );
                                    break;
                                default:
                                    self addplayerstat( "hq_gamemode_mastery", 1 );
                                    break;
                                case "career":
                                    self addplayerstat( "career_mastery", 1 );
                                    break;
                            }
                        }
                    }
                }
            }
        }
        
        self setdstat( "PlayerStatsList", "cp_challenges", "StatValue", 0 );
    }
}

/#

    // Namespace challenges
    // Params 0
    // Checksum 0xf99a4f15, Offset: 0x1e10
    // Size: 0x70, Type: dev
    function function_4f96d6bd()
    {
        while ( true )
        {
            if ( getdvarint( "<dev string:x28>", 0 ) == 1 )
            {
                self function_f2d8f1d0();
                setdvar( "<dev string:x28>", 0 );
            }
            
            wait 0.1;
        }
    }

    // Namespace challenges
    // Params 0
    // Checksum 0x52124038, Offset: 0x1e88
    // Size: 0x4ca, Type: dev
    function function_f2d8f1d0()
    {
        var_2884746a = [];
        array::add( var_2884746a, "<dev string:x44>" );
        array::add( var_2884746a, "<dev string:x55>" );
        array::add( var_2884746a, "<dev string:x66>" );
        array::add( var_2884746a, "<dev string:x77>" );
        array::add( var_2884746a, "<dev string:x88>" );
        array::add( var_2884746a, "<dev string:x99>" );
        array::add( var_2884746a, "<dev string:xaa>" );
        array::add( var_2884746a, "<dev string:xbb>" );
        array::add( var_2884746a, "<dev string:xcc>" );
        array::add( var_2884746a, "<dev string:xdd>" );
        array::add( var_2884746a, "<dev string:xee>" );
        array::add( var_2884746a, "<dev string:xff>" );
        array::add( var_2884746a, "<dev string:x115>" );
        array::add( var_2884746a, "<dev string:x12b>" );
        array::add( var_2884746a, "<dev string:x141>" );
        array::add( var_2884746a, "<dev string:x155>" );
        array::add( var_2884746a, "<dev string:x170>" );
        array::add( var_2884746a, "<dev string:x18a>" );
        array::add( var_2884746a, "<dev string:x1a3>" );
        array::add( var_2884746a, "<dev string:x1ba>" );
        array::add( var_2884746a, "<dev string:x1d3>" );
        array::add( var_2884746a, "<dev string:x1e7>" );
        array::add( var_2884746a, "<dev string:x200>" );
        array::add( var_2884746a, "<dev string:x218>" );
        array::add( var_2884746a, "<dev string:x231>" );
        array::add( var_2884746a, "<dev string:x242>" );
        array::add( var_2884746a, "<dev string:x250>" );
        array::add( var_2884746a, "<dev string:x264>" );
        array::add( var_2884746a, "<dev string:x27b>" );
        array::add( var_2884746a, "<dev string:x291>" );
        array::add( var_2884746a, "<dev string:x2a8>" );
        array::add( var_2884746a, "<dev string:x2bc>" );
        
        foreach ( challenge in var_2884746a )
        {
            self addplayerstat( challenge, 1000 );
            iprintln( "<dev string:x2d5>" + challenge );
            wait 1;
        }
    }

#/
