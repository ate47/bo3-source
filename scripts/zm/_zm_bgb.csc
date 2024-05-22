#using scripts/zm/_zm_bgb_machine;
#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace bgb;

// Namespace bgb
// Params 0, eflags: 0x2
// Checksum 0x8e44099b, Offset: 0x278
// Size: 0x3c
function function_2dc19561() {
    system::register("bgb", &__init__, &__main__, undefined);
}

// Namespace bgb
// Params 0, eflags: 0x1 linked
// Checksum 0x9f12a9d8, Offset: 0x2c0
// Size: 0x236
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    level.weaponbgbgrab = getweapon("zombie_bgb_grab");
    callback::on_localclient_connect(&on_player_connect);
    level.bgb = [];
    level.bgb_pack = [];
    clientfield::register("clientuimodel", "bgb_current", 1, 8, "int", &function_cec2dbda, 0, 0);
    clientfield::register("clientuimodel", "bgb_display", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "bgb_timer", 1, 8, "float", undefined, 0, 0);
    clientfield::register("clientuimodel", "bgb_activations_remaining", 1, 3, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "bgb_invalid_use", 1, 1, "counter", undefined, 0, 0);
    clientfield::register("clientuimodel", "bgb_one_shot_use", 1, 1, "counter", undefined, 0, 0);
    clientfield::register("toplayer", "bgb_blow_bubble", 1, 1, "counter", &bgb_blow_bubble, 0, 0);
    level._effect["bgb_blow_bubble"] = "zombie/fx_bgb_bubble_blow_zmb";
}

// Namespace bgb
// Params 0, eflags: 0x5 linked
// Checksum 0xe5df4326, Offset: 0x500
// Size: 0x2c
function __main__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb_finalize();
}

// Namespace bgb
// Params 1, eflags: 0x5 linked
// Checksum 0xf80d05eb, Offset: 0x538
// Size: 0x3c
function on_player_connect(localclientnum) {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    self thread bgb_player_init(localclientnum);
}

// Namespace bgb
// Params 1, eflags: 0x5 linked
// Checksum 0x7253b4eb, Offset: 0x580
// Size: 0x42
function bgb_player_init(localclientnum) {
    if (isdefined(level.bgb_pack[localclientnum])) {
        return;
    }
    level.bgb_pack[localclientnum] = getbubblegumpack(localclientnum);
}

// Namespace bgb
// Params 0, eflags: 0x5 linked
// Checksum 0x92d48920, Offset: 0x5d0
// Size: 0x384
function bgb_finalize() {
    level.var_f3c83828 = [];
    level.var_f3c83828[0] = "base";
    level.var_f3c83828[1] = "speckled";
    level.var_f3c83828[2] = "shiny";
    level.var_f3c83828[3] = "swirl";
    level.var_f3c83828[4] = "pinwheel";
    var_a804a5cf = util::function_bc37a245();
    level.bgb_item_index_to_name = [];
    keys = getarraykeys(level.bgb);
    for (i = 0; i < keys.size; i++) {
        level.bgb[keys[i]].item_index = getitemindexfromref(keys[i]);
        level.bgb[keys[i]].rarity = int(tablelookup(var_a804a5cf, 0, level.bgb[keys[i]].item_index, 16));
        if (0 == level.bgb[keys[i]].rarity || 4 == level.bgb[keys[i]].rarity) {
            level.bgb[keys[i]].consumable = 0;
        } else {
            level.bgb[keys[i]].consumable = 1;
        }
        level.bgb[keys[i]].camo_index = int(tablelookup(var_a804a5cf, 0, level.bgb[keys[i]].item_index, 5));
        level.bgb[keys[i]].flying_gumball_tag = "tag_gumball_" + level.bgb[keys[i]].limit_type;
        level.bgb[keys[i]].var_ece14434 = "tag_gumball_" + level.bgb[keys[i]].limit_type + "_" + level.var_f3c83828[level.bgb[keys[i]].rarity];
        level.bgb_item_index_to_name[level.bgb[keys[i]].item_index] = keys[i];
    }
}

// Namespace bgb
// Params 2, eflags: 0x1 linked
// Checksum 0x8c8068f6, Offset: 0x960
// Size: 0x144
function register(name, limit_type) {
    /#
        assert(isdefined(name), "bgb_activations_remaining");
    #/
    /#
        assert("bgb_activations_remaining" != name, "bgb_activations_remaining" + "bgb_activations_remaining" + "bgb_activations_remaining");
    #/
    /#
        assert(!isdefined(level.bgb[name]), "bgb_activations_remaining" + name + "bgb_activations_remaining");
    #/
    /#
        assert(isdefined(limit_type), "bgb_activations_remaining" + name + "bgb_activations_remaining");
    #/
    level.bgb[name] = spawnstruct();
    level.bgb[name].name = name;
    level.bgb[name].limit_type = limit_type;
}

// Namespace bgb
// Params 2, eflags: 0x5 linked
// Checksum 0x199c3ca9, Offset: 0xab0
// Size: 0x17c
function function_78c4bfa(localclientnum, time) {
    self endon(#"death");
    self endon(#"entityshutdown");
    if (isdemoplaying()) {
        return;
    }
    if (!isdefined(self.bgb) || !isdefined(level.bgb[self.bgb])) {
        return;
    }
    switch (level.bgb[self.bgb].limit_type) {
    case 22:
        color = (25, 0, 50) / -1;
        break;
    case 23:
        color = (100, 50, 0) / -1;
        break;
    case 24:
        color = (1, -107, -12) / -1;
        break;
    case 25:
        color = (19, -12, 20) / -1;
        break;
    default:
        return;
    }
    self setcontrollerlightbarcolor(localclientnum, color);
    wait(time);
    if (isdefined(self)) {
        self setcontrollerlightbarcolor(localclientnum);
    }
}

// Namespace bgb
// Params 7, eflags: 0x5 linked
// Checksum 0xd8dc07cd, Offset: 0xc38
// Size: 0x6c
function function_cec2dbda(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.bgb = level.bgb_item_index_to_name[newval];
    self thread function_78c4bfa(localclientnum, 3);
}

// Namespace bgb
// Params 2, eflags: 0x5 linked
// Checksum 0x8b49ea30, Offset: 0xcb0
// Size: 0x94
function function_c8a1c86(localclientnum, fx) {
    if (isdefined(self.var_d7197e33)) {
        deletefx(localclientnum, self.var_d7197e33, 1);
    }
    if (isdefined(fx)) {
        self.var_d7197e33 = playfxoncamera(localclientnum, fx);
        self playsound(0, "zmb_bgb_blow_bubble_plr");
    }
}

// Namespace bgb
// Params 7, eflags: 0x5 linked
// Checksum 0x66c74291, Offset: 0xd50
// Size: 0x84
function bgb_blow_bubble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_c8a1c86(localclientnum, level._effect["bgb_blow_bubble"]);
    self thread function_78c4bfa(localclientnum, 0.5);
}

