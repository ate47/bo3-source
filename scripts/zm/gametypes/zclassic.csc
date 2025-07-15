#using scripts/codescripts/struct;

#namespace zclassic;

// Namespace zclassic
// Params 0
// Checksum 0x300d1f10, Offset: 0x98
// Size: 0x54
function main()
{
    level._zombie_gamemodeprecache = &onprecachegametype;
    level._zombie_gamemodemain = &onstartgametype;
    println( "<dev string:x28>" );
}

// Namespace zclassic
// Params 0
// Checksum 0x9f25cf76, Offset: 0xf8
// Size: 0x24
function onprecachegametype()
{
    println( "<dev string:x44>" );
}

// Namespace zclassic
// Params 0
// Checksum 0x3386bc5d, Offset: 0x128
// Size: 0x24
function onstartgametype()
{
    println( "<dev string:x64>" );
}

