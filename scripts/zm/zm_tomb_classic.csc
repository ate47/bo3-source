#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/zm_tomb_craftables;

#namespace zm_tomb_classic;

// Namespace zm_tomb_classic
// Params 0
// Checksum 0x99ec1590, Offset: 0x110
// Size: 0x4
function precache()
{
    
}

// Namespace zm_tomb_classic
// Params 0
// Checksum 0x89d5652d, Offset: 0x120
// Size: 0x24
function premain()
{
    zm_tomb_craftables::include_craftables();
    zm_tomb_craftables::init_craftables();
}

// Namespace zm_tomb_classic
// Params 0
// Checksum 0x99ec1590, Offset: 0x150
// Size: 0x4
function main()
{
    
}

