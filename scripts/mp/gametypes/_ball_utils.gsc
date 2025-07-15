#namespace ball;

// Namespace ball
// Params 1
// Checksum 0x6693204a, Offset: 0x78
// Size: 0x3a
function add_ball_return_trigger( trigger )
{
    if ( !isdefined( level.ball_return_trigger ) )
    {
        level.ball_return_trigger = [];
    }
    
    level.ball_return_trigger[ level.ball_return_trigger.size ] = trigger;
}

