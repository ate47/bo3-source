#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace blood;

// Namespace blood
// Params 0, eflags: 0x2
// Checksum 0x78316ba3, Offset: 0x1b8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "blood", &__init__, undefined, undefined );
}

// Namespace blood
// Params 0
// Checksum 0xa02bb25c, Offset: 0x1f8
// Size: 0xc4
function __init__()
{
    level.bloodstage3 = getdvarfloat( "cg_t7HealthOverlay_Threshold3", 0.5 );
    level.bloodstage2 = getdvarfloat( "cg_t7HealthOverlay_Threshold2", 0.8 );
    level.bloodstage1 = getdvarfloat( "cg_t7HealthOverlay_Threshold1", 0.99 );
    level.use_digital_blood_enabled = getdvarfloat( "scr_use_digital_blood_enabled", 1 );
    callback::on_localplayer_spawned( &localplayer_spawned );
}

// Namespace blood
// Params 1
// Checksum 0x8b034714, Offset: 0x2c8
// Size: 0x12c
function localplayer_spawned( localclientnum )
{
    if ( self != getlocalplayer( localclientnum ) )
    {
        return;
    }
    
    /#
        level.use_digital_blood_enabled = getdvarfloat( "<dev string:x28>", level.use_digital_blood_enabled );
    #/
    
    self.use_digital_blood = 0;
    bodytype = self getcharacterbodytype();
    
    if ( level.use_digital_blood_enabled && bodytype >= 0 )
    {
        bodytypefields = getcharacterfields( bodytype, currentsessionmode() );
        self.use_digital_blood = isdefined( bodytypefields.digitalblood ) ? bodytypefields.digitalblood : 0;
    }
    
    self thread player_watch_blood( localclientnum );
    self thread player_watch_blood_shutdown( localclientnum );
}

// Namespace blood
// Params 1
// Checksum 0x134c5b6b, Offset: 0x400
// Size: 0x4c
function player_watch_blood_shutdown( localclientnum )
{
    self util::waittill_any( "entityshutdown", "death" );
    self disable_blood( localclientnum );
}

// Namespace blood
// Params 1
// Checksum 0x70d371a3, Offset: 0x458
// Size: 0xfc
function enable_blood( localclientnum )
{
    self.blood_enabled = 1;
    filter::init_filter_feedback_blood( localclientnum, self.use_digital_blood );
    filter::enable_filter_feedback_blood( localclientnum, 2, 2, self.use_digital_blood );
    filter::set_filter_feedback_blood_sundir( localclientnum, 2, 2, 65, 32 );
    filter::init_filter_sprite_blood_heavy( localclientnum, self.use_digital_blood );
    filter::enable_filter_sprite_blood_heavy( localclientnum, 2, 1, self.use_digital_blood );
    filter::set_filter_sprite_blood_seed_offset( localclientnum, 2, 1, randomfloat( 1 ) );
}

// Namespace blood
// Params 1
// Checksum 0xd70ee0da, Offset: 0x560
// Size: 0x8c
function disable_blood( localclientnum )
{
    if ( isdefined( self ) )
    {
        self.blood_enabled = 0;
    }
    
    filter::disable_filter_feedback_blood( localclientnum, 2, 2 );
    filter::disable_filter_sprite_blood( localclientnum, 2, 1 );
    
    if ( !( isdefined( self.nobloodlightbarchange ) && self.nobloodlightbarchange ) )
    {
        setcontrollerlightbarcolor( localclientnum );
    }
}

// Namespace blood
// Params 2
// Checksum 0xa59d1b, Offset: 0x5f8
// Size: 0x1dc
function blood_in( localclientnum, playerhealth )
{
    if ( playerhealth < level.bloodstage3 )
    {
        self.stage3amount = ( level.bloodstage3 - playerhealth ) / level.bloodstage3;
    }
    else
    {
        self.stage3amount = 0;
    }
    
    if ( playerhealth < level.bloodstage2 )
    {
        self.stage2amount = ( level.bloodstage2 - playerhealth ) / level.bloodstage2;
    }
    else
    {
        self.stage2amount = 0;
    }
    
    filter::set_filter_feedback_blood_vignette( localclientnum, 2, 2, self.stage3amount );
    filter::set_filter_feedback_blood_opacity( localclientnum, 2, 2, self.stage2amount );
    
    if ( playerhealth < level.bloodstage1 )
    {
        minstage1health = 0.55;
        assert( level.bloodstage1 > minstage1health );
        stagehealth = playerhealth - minstage1health;
        
        if ( stagehealth < 0 )
        {
            stagehealth = 0;
        }
        
        self.stage1amount = 1 - stagehealth / ( level.bloodstage1 - minstage1health );
    }
    else
    {
        self.stage1amount = 0;
    }
    
    filter::set_filter_sprite_blood_opacity( localclientnum, 2, 1, self.stage1amount );
    filter::set_filter_sprite_blood_elapsed( localclientnum, 2, 1, getservertime( localclientnum ) );
}

// Namespace blood
// Params 1
// Checksum 0x99281da8, Offset: 0x7e0
// Size: 0x1c4
function blood_out( localclientnum )
{
    currenttime = getservertime( localclientnum );
    elapsedtime = currenttime - self.lastbloodupdate;
    self.lastbloodupdate = currenttime;
    subtract = elapsedtime / 1000;
    
    if ( self.stage3amount > 0 )
    {
        self.stage3amount -= subtract;
    }
    
    if ( self.stage3amount < 0 )
    {
        self.stage3amount = 0;
    }
    
    if ( self.stage2amount > 0 )
    {
        self.stage2amount -= subtract;
    }
    
    if ( self.stage2amount < 0 )
    {
        self.stage2amount = 0;
    }
    
    filter::set_filter_feedback_blood_vignette( localclientnum, 2, 2, self.stage3amount );
    filter::set_filter_feedback_blood_opacity( localclientnum, 2, 2, self.stage2amount );
    
    if ( self.stage1amount > 0 )
    {
        self.stage1amount -= subtract;
    }
    
    if ( self.stage1amount < 0 )
    {
        self.stage1amount = 0;
    }
    
    filter::set_filter_sprite_blood_opacity( localclientnum, 2, 1, self.stage1amount );
    filter::set_filter_sprite_blood_elapsed( localclientnum, 2, 1, getservertime( localclientnum ) );
}

// Namespace blood
// Params 1
// Checksum 0xea9ec669, Offset: 0x9b0
// Size: 0x3d0
function player_watch_blood( localclientnum )
{
    self endon( #"disconnect" );
    self endon( #"entityshutdown" );
    self endon( #"death" );
    self endon( #"killbloodoverlay" );
    self.stage2amount = 0;
    self.stage3amount = 0;
    self.lastbloodupdate = 0;
    priorplayerhealth = renderhealthoverlayhealth( localclientnum );
    self blood_in( localclientnum, priorplayerhealth );
    
    while ( true )
    {
        if ( renderhealthoverlay( localclientnum ) && !( isdefined( self.nobloodoverlay ) && self.nobloodoverlay ) )
        {
            shouldenabledoverlay = 0;
            playerhealth = renderhealthoverlayhealth( localclientnum );
            
            if ( playerhealth < priorplayerhealth )
            {
                shouldenabledoverlay = 1;
                self blood_in( localclientnum, playerhealth );
            }
            else if ( playerhealth == priorplayerhealth && playerhealth != 1 )
            {
                shouldenabledoverlay = 1;
                self.lastbloodupdate = getservertime( localclientnum );
            }
            else if ( self.stage2amount > 0 || self.stage3amount > 0 )
            {
                shouldenabledoverlay = 1;
                self blood_out( localclientnum );
            }
            else if ( isdefined( self.blood_enabled ) && self.blood_enabled )
            {
                self disable_blood( localclientnum );
            }
            
            priorplayerhealth = playerhealth;
            
            if ( !( isdefined( self.blood_enabled ) && self.blood_enabled ) && shouldenabledoverlay )
            {
                self enable_blood( localclientnum );
            }
            
            if ( !( isdefined( self.nobloodlightbarchange ) && self.nobloodlightbarchange ) )
            {
                if ( self.stage3amount > 0 )
                {
                    setcontrollerlightbarcolorpulsing( localclientnum, ( 1, 0, 0 ), 600 );
                }
                else if ( self.stage2amount == 1 )
                {
                    setcontrollerlightbarcolorpulsing( localclientnum, ( 0.8, 0, 0 ), 1200 );
                }
                else if ( !sessionmodeiscampaigngame() || getgadgetpower( localclientnum ) == 1 && codegetuimodelclientfield( self, "playerAbilities.inRange" ) )
                {
                    setcontrollerlightbarcolorpulsing( localclientnum, ( 1, 1, 0 ), 2000 );
                }
                else if ( isdefined( self.controllercolor ) )
                {
                    setcontrollerlightbarcolor( localclientnum, self.controllercolor );
                }
                else
                {
                    setcontrollerlightbarcolor( localclientnum );
                }
            }
        }
        else if ( isdefined( self.blood_enabled ) && self.blood_enabled )
        {
            self disable_blood( localclientnum );
        }
        
        wait 0.016;
    }
}

// Namespace blood
// Params 3
// Checksum 0xc2ea4d1f, Offset: 0xd88
// Size: 0xc4
function setcontrollerlightbarcolorpulsing( localclientnum, color, pulserate )
{
    curcolor = color * 0.2;
    scale = gettime() % pulserate / pulserate * 0.5;
    
    if ( scale > 1 )
    {
        scale = ( scale - 2 ) * -1;
    }
    
    curcolor += color * 0.8 * scale;
    setcontrollerlightbarcolor( localclientnum, curcolor );
}

