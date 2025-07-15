#using scripts/cp/_accolades;
#using scripts/cp/_skipto;
#using scripts/cp/gametypes/_save;

#namespace decorations;

// Namespace decorations
// Params 1
// Checksum 0xbe24ebc8, Offset: 0x238
// Size: 0xbe, Type: bool
function function_25328f50( var_aeda862b )
{
    a_decorations = self getdecorations( 1 );
    
    foreach ( decoration in a_decorations )
    {
        if ( decoration.name == var_aeda862b )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace decorations
// Params 1
// Checksum 0xc88625d6, Offset: 0x300
// Size: 0x124
function function_59f1fa79( map_name )
{
    if ( !isdefined( map_name ) )
    {
        map_name = getrootmapname();
    }
    
    var_ebb087c2 = self savegame::get_player_data( "accolades" );
    
    if ( isdefined( var_ebb087c2 ) )
    {
        foreach ( accolade in var_ebb087c2 )
        {
            if ( !( isdefined( accolade.is_completed ) && accolade.is_completed ) )
            {
                return 0;
            }
        }
        
        self setdstat( "PlayerStatsByMap", map_name, "allAccoladesComplete", 1 );
    }
}

// Namespace decorations
// Params 0
// Checksum 0x22b99d7, Offset: 0x430
// Size: 0xf4, Type: bool
function function_e72fc18()
{
    var_c02de660 = skipto::function_23eda99c();
    
    foreach ( mission in var_c02de660 )
    {
        if ( !( isdefined( self getdstat( "PlayerStatsByMap", mission, "allAccoladesComplete" ) ) && self getdstat( "PlayerStatsByMap", mission, "allAccoladesComplete" ) ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace decorations
// Params 0
// Checksum 0xb2c3d069, Offset: 0x530
// Size: 0x90, Type: bool
function function_45ddfa6()
{
    for ( itemindex = 100; itemindex < 141 ; itemindex++ )
    {
        var_f62f7b55 = tablelookup( "gamedata/stats/cp/cp_statstable.csv", 0, itemindex, 17 );
        
        if ( var_f62f7b55 == "" )
        {
            continue;
        }
        
        if ( !self isitempurchased( itemindex ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace decorations
// Params 0
// Checksum 0x50cf07f1, Offset: 0x5c8
// Size: 0x20, Type: bool
function function_59727018()
{
    return isdefined( self.var_d1b47d51 ) && self.var_d1b47d51 >= 35000;
}

// Namespace decorations
// Params 0
// Checksum 0xe2a2060b, Offset: 0x5f0
// Size: 0xa8, Type: bool
function function_13cc355e()
{
    maxrank = tablelookup( "gamedata/tables/cp/cp_rankTable.csv", 0, "maxrank", 1 );
    var_4223990f = int( tablelookup( "gamedata/tables/cp/cp_rankTable.csv", 0, maxrank, 2 ) );
    return self getdstat( "PlayerStatsList", "RANKXP", "statValue" ) >= var_4223990f;
}

// Namespace decorations
// Params 0
// Checksum 0x4aa8d7bd, Offset: 0x6a0
// Size: 0xc0, Type: bool
function function_7006b9ad()
{
    for ( itemindex = 1; itemindex < 76 ; itemindex++ )
    {
        var_8e9deedf = tablelookup( "gamedata/stats/cp/cp_statstable.csv", 0, itemindex, 17 );
        
        if ( var_8e9deedf == "" )
        {
            continue;
        }
        
        var_1976a117 = tablelookup( "gamedata/stats/cp/cp_statstable.csv", 0, itemindex, 4 );
        
        if ( !self isitempurchased( itemindex ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace decorations
// Params 1
// Checksum 0x758a52d6, Offset: 0x768
// Size: 0x120, Type: bool
function function_931263b1( difficulty )
{
    foreach ( mission in skipto::function_23eda99c() )
    {
        var_a4b6fa1f = self getdstat( "PlayerStatsByMap", mission, "highestStats", "HIGHEST_DIFFICULTY" );
        
        if ( var_a4b6fa1f < difficulty )
        {
            return false;
        }
        
        checkpointused = self getdstat( "PlayerStatsByMap", mission, "checkpointUsed" );
        
        if ( isdefined( checkpointused ) && checkpointused )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace decorations
// Params 0
// Checksum 0x13458d59, Offset: 0x890
// Size: 0x6c
function function_2bc66a34()
{
    kills = self getdstat( "PlayerStatsList", "KILLS", "statValue" );
    
    if ( kills >= 2000 )
    {
        self givedecoration( "cp_medal_kill_enemies" );
    }
}

// Namespace decorations
// Params 0
// Checksum 0x9417d87e, Offset: 0x908
// Size: 0x21a, Type: bool
function function_7b01cb74()
{
    for ( itemindex = 1; itemindex < 60 ; itemindex++ )
    {
        var_4d26d5ca = tablelookup( "gamedata/stats/cp/cp_statstable.csv", 0, itemindex, 12 );
        
        if ( var_4d26d5ca == "-1" )
        {
            continue;
        }
        
        var_1976a117 = tablelookup( "gamedata/stats/cp/cp_statstable.csv", 0, itemindex, 4 );
        var_f41ce74f = tablelookuprownum( "gamedata/weapons/cp/cp_gunlevels.csv", 2, var_1976a117 );
        
        if ( var_f41ce74f == -1 )
        {
            continue;
        }
        
        rankid = tablelookupcolumnforrow( "gamedata/weapons/cp/cp_gunlevels.csv", var_f41ce74f, 0 );
        var_f554224b = tablelookupcolumnforrow( "gamedata/weapons/cp/cp_gunlevels.csv", var_f41ce74f, 2 );
        var_3f3ab3c1 = var_f41ce74f;
        
        while ( var_f554224b == var_1976a117 )
        {
            rankid = tablelookupcolumnforrow( "gamedata/weapons/cp/cp_gunlevels.csv", var_3f3ab3c1, 0 );
            var_3f3ab3c1++;
            var_f554224b = tablelookupcolumnforrow( "gamedata/weapons/cp/cp_gunlevels.csv", var_3f3ab3c1, 2 );
        }
        
        var_b0863e9a = int( rankid );
        var_b47d78c4 = self getcurrentgunrank( itemindex );
        
        if ( !isdefined( var_b47d78c4 ) )
        {
            var_b47d78c4 = 0;
        }
        
        if ( var_b47d78c4 < var_b0863e9a )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace decorations
// Params 0
// Checksum 0x3716a6f, Offset: 0xb30
// Size: 0x1de, Type: bool
function function_6cd12a29()
{
    for ( itemindex = 1; itemindex < 60 ; itemindex++ )
    {
        var_4d26d5ca = tablelookup( "gamedata/stats/cp/cp_statstable.csv", 0, itemindex, 12 );
        
        if ( var_4d26d5ca == "-1" )
        {
            continue;
        }
        
        weapon_group = tablelookup( "gamedata/stats/cp/cp_statstable.csv", 0, itemindex, 2 );
        
        if ( weapon_group == "" )
        {
            continue;
        }
        
        var_1976a117 = tablelookup( "gamedata/stats/cp/cp_statstable.csv", 0, itemindex, 4 );
        
        if ( var_1976a117 == "hero_annihilator" || var_1976a117 == "hero_pineapplegun" )
        {
            continue;
        }
        
        var_c1b6a586 = tablelookuprownum( "gamedata/stats/cp/statsmilestones3.csv", 3, weapon_group );
        
        if ( var_c1b6a586 == -1 )
        {
            continue;
        }
        
        var_ed54f9d7 = tablelookup( "gamedata/stats/cp/statsmilestones3.csv", 3, weapon_group, 1, 3, 2 );
        var_15879d61 = int( var_ed54f9d7 );
        
        if ( self getdstat( "ItemStats", itemindex, "stats", "kills", "statValue" ) < var_15879d61 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace decorations
// Params 0
// Checksum 0x9ec2b837, Offset: 0xd18
// Size: 0x4e, Type: bool
function function_bea4ff57()
{
    if ( !function_13cc355e() )
    {
        return false;
    }
    
    if ( !function_7b01cb74() )
    {
        return false;
    }
    
    if ( !function_6cd12a29() )
    {
        return false;
    }
    
    return true;
}

