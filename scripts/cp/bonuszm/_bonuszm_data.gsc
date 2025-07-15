#using scripts/codescripts/struct;
#using scripts/cp/bonuszm/_bonuszm;
#using scripts/cp/bonuszm/_bonuszm_spawner_shared;

#namespace bonuszmdata;

// Namespace bonuszmdata
// Params 0, eflags: 0x2
// Checksum 0xca21c695, Offset: 0x5d8
// Size: 0x9c
function autoexec function_dc036a7c()
{
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    level.bonuszmdata = struct::get_script_bundle( "bonuszmdata", getdvarstring( "mapname" ) );
    level.bzm_overridelocomotion = &bzm_overridelocomotion;
    level.bzm_overridehealth = &bzm_overridehealth;
    level.bzm_overridesuicidalchance = &bzm_overridesuicidalchance;
}

// Namespace bonuszmdata
// Params 2
// Checksum 0x494bd8b7, Offset: 0x680
// Size: 0xe34
function function_da5f2c0d( mapname, checkpointname )
{
    level.var_a9e78bf7 = undefined;
    
    if ( !isdefined( level.bonuszmdata ) )
    {
        function_9a6a6726();
        function_97b4bacb( 1, 0 );
        function_4542e087();
        bonuszmspawner::function_fc1970dd();
        return;
    }
    
    skiptoindex = undefined;
    prefix = "";
    var_e6879fdc = getstructfield( level.bonuszmdata, "skiptocount" );
    
    if ( !isdefined( var_e6879fdc ) )
    {
        var_e6879fdc = 0;
    }
    
    for ( i = 1; i <= var_e6879fdc ; i++ )
    {
        prefix = function_15c7079( i );
        skiptoname = getstructfield( level.bonuszmdata, prefix + "skiptoname" );
        
        if ( skiptoname == checkpointname )
        {
            skiptoindex = i;
            break;
        }
    }
    
    level.var_a9e78bf7 = [];
    
    if ( !isdefined( skiptoindex ) )
    {
        /#
            level.var_5deb2d16 = 1;
        #/
        
        function_9a6a6726();
        function_97b4bacb( 1, 0 );
        function_4542e087();
        bonuszmspawner::function_fc1970dd();
        return;
    }
    
    /#
        level.var_5deb2d16 = 0;
    #/
    
    level.var_a9e78bf7[ "skiptoname" ] = skiptoname;
    level.var_a9e78bf7[ "powerdropchance" ] = getstructfield( level.bonuszmdata, "powerdropchance" );
    level.var_a9e78bf7[ "cybercoredropchance" ] = getstructfield( level.bonuszmdata, "cybercoredropchance" );
    level.var_a9e78bf7[ "cybercoreupgradeddropchance" ] = getstructfield( level.bonuszmdata, "cybercoreupgradeddropchance" );
    level.var_a9e78bf7[ "maxdropammochance" ] = getstructfield( level.bonuszmdata, "maxdropammochance" );
    level.var_a9e78bf7[ "maxdropammoupgradedchance" ] = getstructfield( level.bonuszmdata, "maxdropammoupgradedchance" );
    level.var_a9e78bf7[ "weapondropchance" ] = getstructfield( level.bonuszmdata, "weapondropchance" );
    level.var_a9e78bf7[ "instakilldropchance" ] = getstructfield( level.bonuszmdata, "instakilldropchance" );
    level.var_a9e78bf7[ "instakillupgradeddropchance" ] = getstructfield( level.bonuszmdata, "instakillupgradeddropchance" );
    level.var_a9e78bf7[ "powerupdropsenabled" ] = getstructfield( level.bonuszmdata, prefix + "powerupdropsenabled" );
    level.var_a9e78bf7[ "zigzagdeviationmin" ] = getstructfield( level.bonuszmdata, prefix + "zigzagdeviationmin" );
    level.var_a9e78bf7[ "zigzagdeviationmax" ] = getstructfield( level.bonuszmdata, prefix + "zigzagdeviationmax" );
    level.var_a9e78bf7[ "zigzagdeviationmintime" ] = getstructfield( level.bonuszmdata, prefix + "zigzagdeviationmintime" );
    level.var_a9e78bf7[ "zigzagdeviationmaxtime" ] = getstructfield( level.bonuszmdata, prefix + "zigzagdeviationmaxtime" );
    level.var_a9e78bf7[ "onlyuseonstart" ] = getstructfield( level.bonuszmdata, prefix + "onlyuseonstart" );
    level.var_a9e78bf7[ "zombifyenabled" ] = getstructfield( level.bonuszmdata, prefix + "zombifyenabled" );
    level.var_a9e78bf7[ "startunaware" ] = getstructfield( level.bonuszmdata, prefix + "startunaware" );
    level.var_a9e78bf7[ "alertnessspreaddelay" ] = getstructfield( level.bonuszmdata, prefix + "alertnessspreaddelay" );
    level.var_a9e78bf7[ "forcecleanuponcompletion" ] = getstructfield( level.bonuszmdata, prefix + "forcecleanuponcompletion" );
    level.var_a9e78bf7[ "disablefailsafelogic" ] = getstructfield( level.bonuszmdata, prefix + "disablefailsafelogic" );
    level.var_a9e78bf7[ "extraspawns" ] = getstructfield( level.bonuszmdata, prefix + "extraspawns" );
    level.var_a9e78bf7[ "extraspawngapmin" ] = getstructfield( level.bonuszmdata, prefix + "extraspawngapmin" );
    level.var_a9e78bf7[ "walkpercent" ] = getstructfield( level.bonuszmdata, prefix + "walkpercent" );
    level.var_a9e78bf7[ "runpercent" ] = getstructfield( level.bonuszmdata, prefix + "runpercent" );
    level.var_a9e78bf7[ "sprintpercent" ] = getstructfield( level.bonuszmdata, prefix + "sprintpercent" );
    level.var_a9e78bf7[ "levelonehealth" ] = getstructfield( level.bonuszmdata, prefix + "levelonehealth" );
    level.var_a9e78bf7[ "leveltwohealth" ] = getstructfield( level.bonuszmdata, prefix + "leveltwohealth" );
    level.var_a9e78bf7[ "levelthreehealth" ] = getstructfield( level.bonuszmdata, prefix + "levelthreehealth" );
    level.var_a9e78bf7[ "levelonezombies" ] = getstructfield( level.bonuszmdata, prefix + "levelonezombies" );
    level.var_a9e78bf7[ "leveltwozombies" ] = getstructfield( level.bonuszmdata, prefix + "leveltwozombies" );
    level.var_a9e78bf7[ "levelthreezombies" ] = getstructfield( level.bonuszmdata, prefix + "levelthreezombies" );
    level.var_a9e78bf7[ "suicidalzombiechance" ] = getstructfield( level.bonuszmdata, prefix + "suicidalzombiechance" );
    level.var_a9e78bf7[ "suicidalzombieupgradedchance" ] = getstructfield( level.bonuszmdata, prefix + "suicidalzombieupgradedchance" );
    level.var_a9e78bf7[ "deimosinfectedzombiechance" ] = getstructfield( level.bonuszmdata, prefix + "deimosinfectedzombiechance" );
    level.var_a9e78bf7[ "sparkzombiechance" ] = getstructfield( level.bonuszmdata, prefix + "sparkzombiechance" );
    level.var_a9e78bf7[ "sparkzombieupgradedchance" ] = getstructfield( level.bonuszmdata, prefix + "sparkzombieupgradedchance" );
    level.var_a9e78bf7[ "maxreachabilitylevel" ] = getstructfield( level.bonuszmdata, prefix + "maxreachabilitylevel" );
    level.var_a9e78bf7[ "reachabilityinterval" ] = getstructfield( level.bonuszmdata, prefix + "reachabilityinterval" );
    level.var_a9e78bf7[ "maxreachabilityparasites" ] = getstructfield( level.bonuszmdata, prefix + "maxreachabilityparasites" );
    level.var_a9e78bf7[ "powerdropsscalar" ] = getstructfield( level.bonuszmdata, prefix + "powerdropsscalar" );
    level.var_a9e78bf7[ "pathabilityenabled" ] = getstructfield( level.bonuszmdata, prefix + "pathabilityenabled" );
    level.var_a9e78bf7[ "sprinttoplayerdistance" ] = getstructfield( level.bonuszmdata, prefix + "sprinttoplayerdistance" );
    level.var_a9e78bf7[ "skipobjectivewait" ] = getstructfield( level.bonuszmdata, prefix + "skipobjectivewait" );
    level.var_a9e78bf7[ "zombiehealthscale1" ] = getstructfield( level.bonuszmdata, "zombiehealthscale1" );
    level.var_a9e78bf7[ "zombiehealthscale2" ] = getstructfield( level.bonuszmdata, "zombiehealthscale2" );
    level.var_a9e78bf7[ "zombiehealthscale3" ] = getstructfield( level.bonuszmdata, "zombiehealthscale3" );
    level.var_a9e78bf7[ "zombiehealthscale4" ] = getstructfield( level.bonuszmdata, "zombiehealthscale4" );
    level.var_a9e78bf7[ "zombiehealthscale5" ] = getstructfield( level.bonuszmdata, "zombiehealthscale5" );
    level.var_a9e78bf7[ "extrazombiescale1" ] = getstructfield( level.bonuszmdata, "extrazombiescale1" );
    level.var_a9e78bf7[ "extrazombiescale2" ] = getstructfield( level.bonuszmdata, "extrazombiescale2" );
    level.var_a9e78bf7[ "extrazombiescale3" ] = getstructfield( level.bonuszmdata, "extrazombiescale3" );
    level.var_a9e78bf7[ "extrazombiescale4" ] = getstructfield( level.bonuszmdata, "extrazombiescale4" );
    level.var_a9e78bf7[ "magicboxonlyweaponchance" ] = getstructfield( level.bonuszmdata, "magicboxonlyweaponchance" );
    level.var_a9e78bf7[ "maxmagicboxonlyweapons" ] = getstructfield( level.bonuszmdata, "maxmagicboxonlyweapons" );
    level.var_a9e78bf7[ "camochance" ] = getstructfield( level.bonuszmdata, "camochance" );
    function_9a6a6726();
    function_97b4bacb( 0, 1 );
    function_4542e087();
    bonuszmspawner::function_fc1970dd();
    bonuszmspawner::function_b6c845e8();
    bonuszm::function_aaa07980();
    level._zombiezigzagdistancemin = level.var_a9e78bf7[ "zigzagdeviationmin" ];
    level._zombiezigzagdistancemax = level.var_a9e78bf7[ "zigzagdeviationmax" ];
    level._zombiezigzagtimemin = level.var_a9e78bf7[ "zigzagdeviationmintime" ];
    level._zombiezigzagtimemax = level.var_a9e78bf7[ "zigzagdeviationmaxtime" ];
    
    if ( level.var_a9e78bf7[ "startunaware" ] )
    {
        level.var_3004e0c8 = 0;
        return;
    }
    
    level.var_3004e0c8 = 1;
}

// Namespace bonuszmdata
// Params 0
// Checksum 0xe2103e6, Offset: 0x14c0
// Size: 0x1d6
function function_9a6a6726()
{
    if ( !isdefined( level.bonuszmdata ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_a9e78bf7 ) )
    {
        return;
    }
    
    level.var_a9e78bf7[ "aitypeMale1" ] = getstructfield( level.bonuszmdata, "aitypeMale1" );
    level.var_a9e78bf7[ "aitypeMale2" ] = getstructfield( level.bonuszmdata, "aitypeMale2" );
    level.var_a9e78bf7[ "aitypeMale3" ] = getstructfield( level.bonuszmdata, "aitypeMale3" );
    level.var_a9e78bf7[ "aitypeMale4" ] = getstructfield( level.bonuszmdata, "aitypeMale4" );
    level.var_a9e78bf7[ "maleSpawnChance2" ] = getstructfield( level.bonuszmdata, "maleSpawnChance2" );
    level.var_a9e78bf7[ "maleSpawnChance3" ] = getstructfield( level.bonuszmdata, "maleSpawnChance3" );
    level.var_a9e78bf7[ "maleSpawnChance4" ] = getstructfield( level.bonuszmdata, "maleSpawnChance4" );
    level.var_a9e78bf7[ "aitypeFemale" ] = getstructfield( level.bonuszmdata, "aitypeFemale" );
    level.var_a9e78bf7[ "femaleSpawnChance" ] = getstructfield( level.bonuszmdata, "femaleSpawnChance" );
}

// Namespace bonuszmdata
// Params 2
// Checksum 0xca6321f4, Offset: 0x16a0
// Size: 0xf86
function function_97b4bacb( zombify, var_a621e856 )
{
    if ( !isdefined( level.var_a9e78bf7[ "powerdropchance" ] ) )
    {
        if ( isdefined( level.bonuszmdata ) )
        {
            level.var_a9e78bf7[ "powerdropchance" ] = getstructfield( level.bonuszmdata, "powerdropchance" );
            
            if ( !isdefined( level.var_a9e78bf7[ "powerdropchance" ] ) )
            {
                level.var_a9e78bf7[ "powerdropchance" ] = 0;
            }
        }
        else
        {
            level.var_a9e78bf7[ "powerdropchance" ] = 40;
        }
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "maxdropammochance" ] ) )
    {
        if ( isdefined( level.bonuszmdata ) )
        {
            level.var_a9e78bf7[ "maxdropammochance" ] = getstructfield( level.bonuszmdata, "maxdropammochance" );
            
            if ( !isdefined( level.var_a9e78bf7[ "maxdropammochance" ] ) )
            {
                level.var_a9e78bf7[ "maxdropammochance" ] = 0;
            }
        }
        else
        {
            level.var_a9e78bf7[ "maxdropammochance" ] = 50;
        }
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "maxdropammoupgradedchance" ] ) )
    {
        if ( isdefined( level.bonuszmdata ) )
        {
            level.var_a9e78bf7[ "maxdropammoupgradedchance" ] = getstructfield( level.bonuszmdata, "maxdropammoupgradedchance" );
            
            if ( !isdefined( level.var_a9e78bf7[ "maxdropammoupgradedchance" ] ) )
            {
                level.var_a9e78bf7[ "maxdropammoupgradedchance" ] = 0;
            }
        }
        else
        {
            level.var_a9e78bf7[ "maxdropammoupgradedchance" ] = 0;
        }
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "cybercoredropchance" ] ) )
    {
        if ( isdefined( level.bonuszmdata ) )
        {
            level.var_a9e78bf7[ "cybercoredropchance" ] = getstructfield( level.bonuszmdata, "cybercoredropchance" );
            
            if ( !isdefined( level.var_a9e78bf7[ "cybercoredropchance" ] ) )
            {
                level.var_a9e78bf7[ "cybercoredropchance" ] = 0;
            }
        }
        else
        {
            level.var_a9e78bf7[ "cybercoredropchance" ] = 30;
        }
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "cybercoreupgradeddropchance" ] ) )
    {
        if ( isdefined( level.bonuszmdata ) )
        {
            level.var_a9e78bf7[ "cybercoreupgradeddropchance" ] = getstructfield( level.bonuszmdata, "cybercoreupgradeddropchance" );
            
            if ( !isdefined( level.var_a9e78bf7[ "cybercoreupgradeddropchance" ] ) )
            {
                level.var_a9e78bf7[ "cybercoreupgradeddropchance" ] = 0;
            }
        }
        else
        {
            level.var_a9e78bf7[ "cybercoreupgradeddropchance" ] = 0;
        }
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "rapsdropchance" ] ) )
    {
        if ( isdefined( level.bonuszmdata ) )
        {
            level.var_a9e78bf7[ "rapsdropchance" ] = getstructfield( level.bonuszmdata, "rapsdropchance" );
            
            if ( !isdefined( level.var_a9e78bf7[ "rapsdropchance" ] ) )
            {
                level.var_a9e78bf7[ "rapsdropchance" ] = 0;
            }
        }
        else
        {
            level.var_a9e78bf7[ "rapsdropchance" ] = 0;
        }
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "weapondropchance" ] ) )
    {
        if ( isdefined( level.bonuszmdata ) )
        {
            level.var_a9e78bf7[ "weapondropchance" ] = getstructfield( level.bonuszmdata, "weapondropchance" );
            
            if ( !isdefined( level.var_a9e78bf7[ "weapondropchance" ] ) )
            {
                level.var_a9e78bf7[ "weapondropchance" ] = 0;
            }
        }
        else
        {
            level.var_a9e78bf7[ "weapondropchance" ] = 20;
        }
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "instakilldropchance" ] ) )
    {
        if ( isdefined( level.bonuszmdata ) )
        {
            level.var_a9e78bf7[ "instakilldropchance" ] = getstructfield( level.bonuszmdata, "instakilldropchance" );
            
            if ( !isdefined( level.var_a9e78bf7[ "instakilldropchance" ] ) )
            {
                level.var_a9e78bf7[ "instakilldropchance" ] = 0;
            }
        }
        else
        {
            level.var_a9e78bf7[ "powerdropchance" ] = 15;
        }
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "instakillupgradeddropchance" ] ) )
    {
        if ( isdefined( level.bonuszmdata ) )
        {
            level.var_a9e78bf7[ "instakillupgradeddropchance" ] = getstructfield( level.bonuszmdata, "instakillupgradeddropchance" );
            
            if ( !isdefined( level.var_a9e78bf7[ "instakillupgradeddropchance" ] ) )
            {
                level.var_a9e78bf7[ "instakillupgradeddropchance" ] = 0;
            }
        }
        else
        {
            level.var_a9e78bf7[ "instakillupgradeddropchance" ] = 0;
        }
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "powerupdropsenabled" ] ) )
    {
        level.var_a9e78bf7[ "powerupdropsenabled" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "waituntilskiptostarts" ] ) )
    {
        level.var_a9e78bf7[ "waituntilskiptostarts" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "skiptoname" ] ) )
    {
        level.var_a9e78bf7[ "skiptoname" ] = "default";
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "onlyuseonstart" ] ) )
    {
        level.var_a9e78bf7[ "onlyuseonstart" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "zombifyenabled" ] ) )
    {
        level.var_a9e78bf7[ "zombifyenabled" ] = zombify;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "startunaware" ] ) )
    {
        level.var_a9e78bf7[ "startunaware" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "alertnessspreaddelay" ] ) )
    {
        level.var_a9e78bf7[ "alertnessspreaddelay" ] = 2;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "forcecleanuponcompletion" ] ) )
    {
        level.var_a9e78bf7[ "forcecleanuponcompletion" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "disablefailsafelogic" ] ) )
    {
        level.var_a9e78bf7[ "disablefailsafelogic" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "extraspawns" ] ) )
    {
        level.var_a9e78bf7[ "extraspawns" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "zigzagdeviationmin" ] ) )
    {
        level.var_a9e78bf7[ "zigzagdeviationmin" ] = 250;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "zigzagdeviationmax" ] ) )
    {
        level.var_a9e78bf7[ "zigzagdeviationmax" ] = 400;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "zigzagdeviationmintime" ] ) )
    {
        level.var_a9e78bf7[ "zigzagdeviationmintime" ] = 2500;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "zigzagdeviationmaxtime" ] ) )
    {
        level.var_a9e78bf7[ "zigzagdeviationmaxtime" ] = 4000;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "extraspawngapmin" ] ) )
    {
        level.var_a9e78bf7[ "extraspawngapmin" ] = 2;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "walkpercent" ] ) )
    {
        if ( isdefined( var_a621e856 ) && var_a621e856 )
        {
            level.var_a9e78bf7[ "walkpercent" ] = 0;
        }
        else
        {
            level.var_a9e78bf7[ "walkpercent" ] = 33;
        }
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "runpercent" ] ) )
    {
        if ( isdefined( var_a621e856 ) && var_a621e856 )
        {
            level.var_a9e78bf7[ "runpercent" ] = 0;
        }
        else
        {
            level.var_a9e78bf7[ "runpercent" ] = 33;
        }
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "sprintpercent" ] ) )
    {
        if ( isdefined( var_a621e856 ) && var_a621e856 )
        {
            level.var_a9e78bf7[ "sprintpercent" ] = 0;
        }
        else
        {
            level.var_a9e78bf7[ "sprintpercent" ] = 34;
        }
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "levelonehealth" ] ) )
    {
        level.var_a9e78bf7[ "levelonehealth" ] = 150;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "leveltwohealth" ] ) )
    {
        level.var_a9e78bf7[ "leveltwohealth" ] = 350;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "levelthreehealth" ] ) )
    {
        level.var_a9e78bf7[ "levelthreehealth" ] = 650;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "levelonezombies" ] ) )
    {
        if ( isdefined( var_a621e856 ) && var_a621e856 )
        {
            level.var_a9e78bf7[ "levelonezombies" ] = 0;
        }
        else
        {
            level.var_a9e78bf7[ "levelonezombies" ] = 33;
        }
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "leveltwozombies" ] ) )
    {
        if ( isdefined( var_a621e856 ) && var_a621e856 )
        {
            level.var_a9e78bf7[ "leveltwozombies" ] = 0;
        }
        else
        {
            level.var_a9e78bf7[ "leveltwozombies" ] = 33;
        }
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "levelthreezombies" ] ) )
    {
        if ( isdefined( var_a621e856 ) && var_a621e856 )
        {
            level.var_a9e78bf7[ "levelthreezombies" ] = 0;
        }
        else
        {
            level.var_a9e78bf7[ "levelthreezombies" ] = 34;
        }
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "zombiehealthscale1" ] ) )
    {
        level.var_a9e78bf7[ "zombiehealthscale1" ] = 0.5;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "zombiehealthscale2" ] ) )
    {
        level.var_a9e78bf7[ "zombiehealthscale2" ] = 1;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "zombiehealthscale3" ] ) )
    {
        level.var_a9e78bf7[ "zombiehealthscale3" ] = 1.25;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "zombiehealthscale4" ] ) )
    {
        level.var_a9e78bf7[ "zombiehealthscale4" ] = 1.5;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "zombiehealthscale5" ] ) )
    {
        level.var_a9e78bf7[ "zombiehealthscale5" ] = 2;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "extrazombiescale1" ] ) )
    {
        level.var_a9e78bf7[ "extrazombiescale1" ] = 1;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "extrazombiescale2" ] ) )
    {
        level.var_a9e78bf7[ "extrazombiescale2" ] = 1.5;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "extrazombiescale3" ] ) )
    {
        level.var_a9e78bf7[ "extrazombiescale3" ] = 1.75;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "extrazombiescale4" ] ) )
    {
        level.var_a9e78bf7[ "extrazombiescale4" ] = 2;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "suicidalzombiechance" ] ) )
    {
        level.var_a9e78bf7[ "suicidalzombiechance" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "suicidalzombieupgradedchance" ] ) )
    {
        level.var_a9e78bf7[ "suicidalzombieupgradedchance" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "deimosinfectedzombiechance" ] ) )
    {
        level.var_a9e78bf7[ "deimosinfectedzombiechance" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "sparkzombiechance" ] ) )
    {
        level.var_a9e78bf7[ "sparkzombiechance" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "sparkzombieupgradedchance" ] ) )
    {
        level.var_a9e78bf7[ "sparkzombieupgradedchance" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "magicboxonlyweaponchance" ] ) )
    {
        level.var_a9e78bf7[ "magicboxonlyweaponchance" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "maxmagicboxonlyweapons" ] ) )
    {
        level.var_a9e78bf7[ "maxmagicboxonlyweapons" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "camochance" ] ) )
    {
        level.var_a9e78bf7[ "camochance" ] = 30;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "pathabilityenabled" ] ) )
    {
        level.var_a9e78bf7[ "pathabilityenabled" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "sprinttoplayerdistance" ] ) )
    {
        level.var_a9e78bf7[ "sprinttoplayerdistance" ] = 1000;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "skipobjectivewait" ] ) )
    {
        level.var_a9e78bf7[ "skipobjectivewait" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "maxreachabilitylevel" ] ) )
    {
        level.var_a9e78bf7[ "maxreachabilitylevel" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "reachabilityinterval" ] ) )
    {
        level.var_a9e78bf7[ "reachabilityinterval" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "maxreachabilityparasites" ] ) )
    {
        level.var_a9e78bf7[ "maxreachabilityparasites" ] = 0;
    }
    
    if ( !isdefined( level.var_a9e78bf7[ "powerdropsscalar" ] ) )
    {
        level.var_a9e78bf7[ "powerdropsscalar" ] = 1;
    }
}

// Namespace bonuszmdata
// Params 1
// Checksum 0x632909f, Offset: 0x2630
// Size: 0x20
function function_15c7079( index )
{
    return "skipto" + index + "_";
}

// Namespace bonuszmdata
// Params 0, eflags: 0x4
// Checksum 0x44553725, Offset: 0x2658
// Size: 0x194
function private function_4542e087()
{
    if ( !level.var_a9e78bf7[ "zombifyenabled" ] )
    {
        return;
    }
    
    total_percentage = level.var_a9e78bf7[ "levelonezombies" ] + level.var_a9e78bf7[ "leveltwozombies" ] + level.var_a9e78bf7[ "levelthreezombies" ];
    assert( total_percentage == 100, "<dev string:x28>" + level.var_a9e78bf7[ "<dev string:x5d>" ] );
    total_percentage = level.var_a9e78bf7[ "walkpercent" ] + level.var_a9e78bf7[ "runpercent" ] + level.var_a9e78bf7[ "sprintpercent" ];
    assert( total_percentage == 100, "<dev string:x68>" + level.var_a9e78bf7[ "<dev string:x5d>" ] );
    assert( level.var_a9e78bf7[ "<dev string:xa7>" ] < level.var_a9e78bf7[ "<dev string:xba>" ], "<dev string:xcd>" );
    assert( level.var_a9e78bf7[ "<dev string:x105>" ] < level.var_a9e78bf7[ "<dev string:x11c>" ], "<dev string:x133>" );
}

// Namespace bonuszmdata
// Params 3, eflags: 0x4
// Checksum 0xee8dc0e0, Offset: 0x27f8
// Size: 0xd2
function private bzm_overridelocomotion( walkpercent, runpercent, sprintpercent )
{
    if ( !level.var_a9e78bf7[ "zombifyenabled" ] )
    {
        return;
    }
    
    total_percentage = walkpercent + runpercent + sprintpercent;
    assert( total_percentage == 100, "<dev string:x68>" + level.var_a9e78bf7[ "<dev string:x5d>" ] );
    level.var_a9e78bf7[ "walkpercent" ] = walkpercent;
    level.var_a9e78bf7[ "runpercent" ] = runpercent;
    level.var_a9e78bf7[ "sprintpercent" ] = sprintpercent;
}

// Namespace bonuszmdata
// Params 3, eflags: 0x4
// Checksum 0x43fb351e, Offset: 0x28d8
// Size: 0x7a
function private bzm_overridehealth( levelonehealth, leveltwohealth, levelthreehealth )
{
    if ( !level.var_a9e78bf7[ "zombifyenabled" ] )
    {
        return;
    }
    
    level.var_a9e78bf7[ "levelonehealth" ] = levelonehealth;
    level.var_a9e78bf7[ "leveltwohealth" ] = leveltwohealth;
    level.var_a9e78bf7[ "levelthreehealth" ] = levelthreehealth;
}

// Namespace bonuszmdata
// Params 1, eflags: 0x4
// Checksum 0x6139457d, Offset: 0x2960
// Size: 0x52
function private bzm_overridesuicidalchance( chance )
{
    if ( !level.var_a9e78bf7[ "zombifyenabled" ] )
    {
        return;
    }
    
    if ( chance > 100 )
    {
        chance = 100;
    }
    
    level.var_a9e78bf7[ "suicidalzombiechance" ] = chance;
}

// Namespace bonuszmdata
// Params 1, eflags: 0x4
// Checksum 0xb3f5ed5, Offset: 0x29c0
// Size: 0x52
function private function_481f94( chance )
{
    if ( !level.var_a9e78bf7[ "zombifyenabled" ] )
    {
        return;
    }
    
    if ( chance > 100 )
    {
        chance = 100;
    }
    
    level.var_a9e78bf7[ "sparkzombiechance" ] = chance;
}

