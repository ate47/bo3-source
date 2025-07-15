#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace entityheadicons;

// Namespace entityheadicons
// Params 0
// Checksum 0xfc589875, Offset: 0x160
// Size: 0x24
function init_shared()
{
    callback::on_start_gametype( &start_gametype );
}

// Namespace entityheadicons
// Params 0
// Checksum 0xd3748abf, Offset: 0x190
// Size: 0xb8
function start_gametype()
{
    if ( isdefined( level.initedentityheadicons ) )
    {
        return;
    }
    
    level.initedentityheadicons = 1;
    assert( isdefined( game[ "<dev string:x28>" ] ), "<dev string:x3f>" );
    assert( isdefined( game[ "<dev string:x85>" ] ), "<dev string:x9a>" );
    
    if ( !level.teambased )
    {
        return;
    }
    
    if ( !isdefined( level.setentityheadicon ) )
    {
        level.setentityheadicon = &setentityheadicon;
    }
    
    level.entitieswithheadicons = [];
}

// Namespace entityheadicons
// Params 5
// Checksum 0x349b1bc6, Offset: 0x250
// Size: 0x384
function setentityheadicon( team, owner, offset, objective, constant_size )
{
    if ( !level.teambased && !isdefined( owner ) )
    {
        return;
    }
    
    if ( !isdefined( constant_size ) )
    {
        constant_size = 0;
    }
    
    if ( !isdefined( self.entityheadiconteam ) )
    {
        self.entityheadiconteam = "none";
        self.entityheadicons = [];
        self.entityheadobjectives = [];
    }
    
    if ( level.teambased && !isdefined( owner ) )
    {
        if ( team == self.entityheadiconteam )
        {
            return;
        }
        
        self.entityheadiconteam = team;
    }
    
    if ( isdefined( offset ) )
    {
        self.entityheadiconoffset = offset;
    }
    else
    {
        self.entityheadiconoffset = ( 0, 0, 0 );
    }
    
    if ( isdefined( self.entityheadicons ) )
    {
        for ( i = 0; i < self.entityheadicons.size ; i++ )
        {
            if ( isdefined( self.entityheadicons[ i ] ) )
            {
                self.entityheadicons[ i ] destroy();
            }
        }
    }
    
    if ( isdefined( self.entityheadobjectives ) )
    {
        for ( i = 0; i < self.entityheadobjectives.size ; i++ )
        {
            if ( isdefined( self.entityheadobjectives[ i ] ) )
            {
                objective_delete( self.entityheadobjectives[ i ] );
                self.entityheadobjectives[ i ] = undefined;
            }
        }
    }
    
    self.entityheadicons = [];
    self.entityheadobjectives = [];
    self notify( #"kill_entity_headicon_thread" );
    
    if ( !isdefined( objective ) )
    {
        objective = game[ "entity_headicon_" + team ];
    }
    
    if ( isdefined( objective ) )
    {
        if ( isdefined( owner ) && !level.teambased )
        {
            if ( !isplayer( owner ) )
            {
                assert( isdefined( owner.owner ), "<dev string:xde>" );
                owner = owner.owner;
            }
            
            if ( isstring( objective ) )
            {
                owner updateentityheadclienticon( self, objective, constant_size );
            }
            else
            {
                owner updateentityheadclientobjective( self, objective, constant_size );
            }
        }
        else if ( isdefined( owner ) && team != "none" )
        {
            if ( isstring( objective ) )
            {
                owner updateentityheadteamicon( self, team, objective, constant_size );
            }
            else
            {
                owner updateentityheadteamobjective( self, team, objective, constant_size );
            }
        }
    }
    
    self thread destroyheadiconsondeath();
}

// Namespace entityheadicons
// Params 4
// Checksum 0xc517f71f, Offset: 0x5e0
// Size: 0x1aa
function updateentityheadteamicon( entity, team, icon, constant_size )
{
    friendly_blue_color = array( 0.584, 0.839, 0.867 );
    headicon = newteamhudelem( team );
    headicon.archived = 1;
    headicon.x = entity.entityheadiconoffset[ 0 ];
    headicon.y = entity.entityheadiconoffset[ 1 ];
    headicon.z = entity.entityheadiconoffset[ 2 ];
    headicon.alpha = 0.8;
    headicon.color = ( friendly_blue_color[ 0 ], friendly_blue_color[ 1 ], friendly_blue_color[ 2 ] );
    headicon setshader( icon, 6, 6 );
    headicon setwaypoint( constant_size );
    headicon settargetent( entity );
    entity.entityheadicons[ entity.entityheadicons.size ] = headicon;
}

// Namespace entityheadicons
// Params 3
// Checksum 0x971bf79f, Offset: 0x798
// Size: 0x14a
function updateentityheadclienticon( entity, icon, constant_size )
{
    headicon = newclienthudelem( self );
    headicon.archived = 1;
    headicon.x = entity.entityheadiconoffset[ 0 ];
    headicon.y = entity.entityheadiconoffset[ 1 ];
    headicon.z = entity.entityheadiconoffset[ 2 ];
    headicon.alpha = 0.8;
    headicon setshader( icon, 6, 6 );
    headicon setwaypoint( constant_size );
    headicon settargetent( entity );
    entity.entityheadicons[ entity.entityheadicons.size ] = headicon;
}

// Namespace entityheadicons
// Params 4
// Checksum 0x1ad8570c, Offset: 0x8f0
// Size: 0xc2
function updateentityheadteamobjective( entity, team, objective, constant_size )
{
    headiconobjectiveid = gameobjects::get_next_obj_id();
    objective_add( headiconobjectiveid, "active", entity, objective );
    objective_team( headiconobjectiveid, team );
    objective_setcolor( headiconobjectiveid, &"FriendlyBlue" );
    entity.entityheadobjectives[ entity.entityheadobjectives.size ] = headiconobjectiveid;
}

// Namespace entityheadicons
// Params 3
// Checksum 0xaa858299, Offset: 0x9c0
// Size: 0xd2
function updateentityheadclientobjective( entity, objective, constant_size )
{
    headiconobjectiveid = gameobjects::get_next_obj_id();
    objective_add( headiconobjectiveid, "active", entity, objective );
    objective_setinvisibletoall( headiconobjectiveid );
    objective_setvisibletoplayer( headiconobjectiveid, self );
    objective_setcolor( headiconobjectiveid, &"FriendlyBlue" );
    entity.entityheadobjectives[ entity.entityheadobjectives.size ] = headiconobjectiveid;
}

// Namespace entityheadicons
// Params 0
// Checksum 0xe5451607, Offset: 0xaa0
// Size: 0x11e
function destroyheadiconsondeath()
{
    self notify( #"destroyheadiconsondeath_singleton" );
    self endon( #"destroyheadiconsondeath_singleton" );
    self util::waittill_any( "death", "hacked" );
    
    for ( i = 0; i < self.entityheadicons.size ; i++ )
    {
        if ( isdefined( self.entityheadicons[ i ] ) )
        {
            self.entityheadicons[ i ] destroy();
        }
    }
    
    for ( i = 0; i < self.entityheadobjectives.size ; i++ )
    {
        if ( isdefined( self.entityheadobjectives[ i ] ) )
        {
            gameobjects::release_obj_id( self.entityheadobjectives[ i ] );
            objective_delete( self.entityheadobjectives[ i ] );
        }
    }
}

// Namespace entityheadicons
// Params 0
// Checksum 0x65aff947, Offset: 0xbc8
// Size: 0x100
function destroyentityheadicons()
{
    if ( isdefined( self.entityheadicons ) )
    {
        for ( i = 0; i < self.entityheadicons.size ; i++ )
        {
            if ( isdefined( self.entityheadicons[ i ] ) )
            {
                self.entityheadicons[ i ] destroy();
            }
        }
    }
    
    if ( isdefined( self.entityheadobjectives ) )
    {
        for ( i = 0; i < self.entityheadobjectives.size ; i++ )
        {
            if ( isdefined( self.entityheadobjectives[ i ] ) )
            {
                gameobjects::release_obj_id( self.entityheadobjectives[ i ] );
                objective_delete( self.entityheadobjectives[ i ] );
            }
        }
    }
    
    self.entityheadobjectives = [];
}

// Namespace entityheadicons
// Params 1
// Checksum 0xe42c2e4f, Offset: 0xcd0
// Size: 0x84
function updateentityheadiconpos( headicon )
{
    headicon.x = self.origin[ 0 ] + self.entityheadiconoffset[ 0 ];
    headicon.y = self.origin[ 1 ] + self.entityheadiconoffset[ 1 ];
    headicon.z = self.origin[ 2 ] + self.entityheadiconoffset[ 2 ];
}

// Namespace entityheadicons
// Params 0
// Checksum 0xd7bae5e0, Offset: 0xd60
// Size: 0x92
function setentityheadiconshiddenwhilecontrolling()
{
    if ( isdefined( self.entityheadicons ) )
    {
        foreach ( icon in self.entityheadicons )
        {
            icon.hidewhileremotecontrolling = 1;
        }
    }
}

