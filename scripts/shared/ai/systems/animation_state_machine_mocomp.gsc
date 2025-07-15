#namespace animationstatenetwork;

// Namespace animationstatenetwork
// Params 0, eflags: 0x2
// Checksum 0x7dc7c359, Offset: 0xc8
// Size: 0x10
function autoexec initanimationmocomps()
{
    level._animationmocomps = [];
}

// Namespace animationstatenetwork
// Params 6
// Checksum 0xb8f8acde, Offset: 0xe0
// Size: 0x13c
function runanimationmocomp( mocompname, mocompstatus, asmentity, mocompanim, mocompanimblendouttime, mocompduration )
{
    assert( mocompstatus >= 0 && mocompstatus <= 2, "<dev string:x28>" + mocompstatus + "<dev string:x48>" );
    assert( isdefined( level._animationmocomps[ mocompname ] ), "<dev string:x61>" + mocompname + "<dev string:x85>" );
    
    if ( mocompstatus == 0 )
    {
        mocompstatus = "asm_mocomp_start";
    }
    else if ( mocompstatus == 1 )
    {
        mocompstatus = "asm_mocomp_update";
    }
    else
    {
        mocompstatus = "asm_mocomp_terminate";
    }
    
    animationmocompresult = asmentity [[ level._animationmocomps[ mocompname ][ mocompstatus ] ]]( asmentity, mocompanim, mocompanimblendouttime, "", mocompduration );
    return animationmocompresult;
}

// Namespace animationstatenetwork
// Params 4
// Checksum 0x789731e0, Offset: 0x228
// Size: 0x234
function registeranimationmocomp( mocompname, startfuncptr, updatefuncptr, terminatefuncptr )
{
    mocompname = tolower( mocompname );
    assert( isstring( mocompname ), "<dev string:x97>" );
    assert( !isdefined( level._animationmocomps[ mocompname ] ), "<dev string:xd6>" + mocompname + "<dev string:xe8>" );
    level._animationmocomps[ mocompname ] = array();
    assert( isdefined( startfuncptr ) && isfunctionptr( startfuncptr ), "<dev string:x100>" );
    level._animationmocomps[ mocompname ][ "asm_mocomp_start" ] = startfuncptr;
    
    if ( isdefined( updatefuncptr ) )
    {
        assert( isfunctionptr( updatefuncptr ), "<dev string:x15d>" );
        level._animationmocomps[ mocompname ][ "asm_mocomp_update" ] = updatefuncptr;
    }
    else
    {
        level._animationmocomps[ mocompname ][ "asm_mocomp_update" ] = &animationmocompemptyfunc;
    }
    
    if ( isdefined( terminatefuncptr ) )
    {
        assert( isfunctionptr( terminatefuncptr ), "<dev string:x1b7>" );
        level._animationmocomps[ mocompname ][ "asm_mocomp_terminate" ] = terminatefuncptr;
        return;
    }
    
    level._animationmocomps[ mocompname ][ "asm_mocomp_terminate" ] = &animationmocompemptyfunc;
}

// Namespace animationstatenetwork
// Params 5
// Checksum 0x2cf62241, Offset: 0x468
// Size: 0x2c
function animationmocompemptyfunc( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    
}

