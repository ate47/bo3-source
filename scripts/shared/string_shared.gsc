#using scripts/shared/array_shared;

#namespace string;

/#

    // Namespace string
    // Params 3
    // Checksum 0xa8cce6fe, Offset: 0x98
    // Size: 0x10c, Type: dev
    function rfill( str_input, n_length, str_fill_char )
    {
        if ( !isdefined( str_fill_char ) )
        {
            str_fill_char = "<dev string:x28>";
        }
        
        if ( str_fill_char == "<dev string:x2a>" )
        {
            str_fill_char = "<dev string:x28>";
        }
        
        assert( str_fill_char.size == 1, "<dev string:x2b>" );
        str_input = "<dev string:x2a>" + str_input;
        n_fill_count = n_length - str_input.size;
        str_fill = "<dev string:x2a>";
        
        if ( n_fill_count > 0 )
        {
            for ( i = 0; i < n_fill_count ; i++ )
            {
                str_fill += str_fill_char;
            }
        }
        
        return str_fill + str_input;
    }

#/
