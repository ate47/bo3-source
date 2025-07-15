#namespace throttle;

// Namespace throttle
// Method(s) 6 Total 6
class throttle
{

    // Namespace throttle
    // Params 0
    // Checksum 0xe3809695, Offset: 0xc0
    // Size: 0x38
    constructor()
    {
        self.queue_ = [];
        self.processed_ = 0;
        self.processlimit_ = 1;
        self.updaterate_ = 0.05;
    }

    // Namespace throttle
    // Params 1
    // Checksum 0xe35b4acd, Offset: 0x250
    // Size: 0xb4
    function waitinqueue( entity )
    {
        if ( self.processed_ >= self.processlimit_ )
        {
            self.queue_[ self.queue_.size ] = entity;
            firstinqueue = 0;
            
            while ( !firstinqueue )
            {
                if ( !isdefined( entity ) )
                {
                    return;
                }
                
                if ( self.processed_ < self.processlimit_ && self.queue_[ 0 ] === entity )
                {
                    firstinqueue = 1;
                    self.queue_[ 0 ] = undefined;
                    continue;
                }
                
                wait self.updaterate_;
            }
        }
        
        self.processed_++;
    }

    // Namespace throttle
    // Params 2
    // Checksum 0x6bf13dd3, Offset: 0x1d8
    // Size: 0x6c
    function initialize( processlimit, updaterate )
    {
        if ( !isdefined( processlimit ) )
        {
            processlimit = 1;
        }
        
        if ( !isdefined( updaterate ) )
        {
            updaterate = 0.05;
        }
        
        self.processlimit_ = processlimit;
        self.updaterate_ = updaterate;
        self thread _updatethrottlethread( self );
    }

    // Namespace throttle
    // Params 0, eflags: 0x4
    // Checksum 0x2064fb3c, Offset: 0x110
    // Size: 0xc0
    function private _updatethrottle()
    {
        self.processed_ = 0;
        currentqueue = self.queue_;
        self.queue_ = [];
        
        foreach ( item in currentqueue )
        {
            if ( isdefined( item ) )
            {
                self.queue_[ self.queue_.size ] = item;
            }
        }
    }

    // Namespace throttle
    // Params 1, eflags: 0x4
    // Checksum 0xad52b6cf, Offset: 0x78
    // Size: 0x3c
    function private _updatethrottlethread( throttle )
    {
        while ( isdefined( throttle ) )
        {
            [[ throttle ]]->_updatethrottle();
            wait throttle.updaterate_;
        }
    }

}

