#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_efc40536;

// Namespace namespace_efc40536
// Params 0, eflags: 0x0
// namespace_efc40536<file_0>::function_1463e4e5
// Checksum 0xf92c74cf, Offset: 0x1a8
// Size: 0xb4
function init_shared() {
    level._effect["acousticsensor_enemy_light"] = "_t6/misc/fx_equip_light_red";
    level._effect["acousticsensor_friendly_light"] = "_t6/misc/fx_equip_light_green";
    if (!isdefined(level.var_e1b96029)) {
        level.var_e1b96029 = [];
    }
    if (!isdefined(level.var_e19ee9a4)) {
        level.var_e19ee9a4 = 0;
    }
    callback::on_localclient_connect(&on_player_connect);
    callback::add_weapon_type("acoustic_sensor", &spawned);
}

// Namespace namespace_efc40536
// Params 1, eflags: 0x0
// namespace_efc40536<file_0>::function_fb4f96b5
// Checksum 0xadac86c9, Offset: 0x268
// Size: 0x44
function on_player_connect(localclientnum) {
    setlocalradarenabled(localclientnum, 0);
    if (localclientnum == 0) {
        level thread function_e128e674();
    }
}

// Namespace namespace_efc40536
// Params 3, eflags: 0x0
// namespace_efc40536<file_0>::function_bb05d439
// Checksum 0x4bc47850, Offset: 0x2b8
// Size: 0x9e
function function_bb05d439(handle, var_f0a669b2, owner) {
    var_efc40536 = spawnstruct();
    var_efc40536.handle = handle;
    var_efc40536.var_f0a669b2 = var_f0a669b2;
    var_efc40536.owner = owner;
    size = level.var_e1b96029.size;
    level.var_e1b96029[size] = var_efc40536;
}

// Namespace namespace_efc40536
// Params 1, eflags: 0x0
// namespace_efc40536<file_0>::function_98918d12
// Checksum 0x1538f359, Offset: 0x360
// Size: 0x114
function function_98918d12(var_e19ee9a4) {
    for (i = 0; i < level.var_e1b96029.size; i++) {
        last = level.var_e1b96029.size - 1;
        if (level.var_e1b96029[i].handle == var_e19ee9a4) {
            level.var_e1b96029[i].handle = level.var_e1b96029[last].handle;
            level.var_e1b96029[i].var_f0a669b2 = level.var_e1b96029[last].var_f0a669b2;
            level.var_e1b96029[i].owner = level.var_e1b96029[last].owner;
            level.var_e1b96029[last] = undefined;
            return;
        }
    }
}

// Namespace namespace_efc40536
// Params 1, eflags: 0x0
// namespace_efc40536<file_0>::function_ab1f9ea1
// Checksum 0x39bf2601, Offset: 0x480
// Size: 0xa4
function spawned(localclientnum) {
    handle = level.var_e19ee9a4;
    level.var_e19ee9a4++;
    self thread watchshutdown(handle);
    owner = self getowner(localclientnum);
    function_bb05d439(handle, self, owner);
    util::local_players_entity_thread(self, &function_8bbd150b);
}

// Namespace namespace_efc40536
// Params 1, eflags: 0x0
// namespace_efc40536<file_0>::function_8bbd150b
// Checksum 0x121b875f, Offset: 0x530
// Size: 0x54
function function_8bbd150b(localclientnum) {
    self endon(#"entityshutdown");
    self thread fx::blinky_light(localclientnum, "tag_light", level._effect["acousticsensor_friendly_light"], level._effect["acousticsensor_enemy_light"]);
}

// Namespace namespace_efc40536
// Params 1, eflags: 0x0
// namespace_efc40536<file_0>::function_e42ff528
// Checksum 0x5b6ad378, Offset: 0x590
// Size: 0x2c
function watchshutdown(handle) {
    self waittill(#"entityshutdown");
    function_98918d12(handle);
}

// Namespace namespace_efc40536
// Params 0, eflags: 0x0
// namespace_efc40536<file_0>::function_e128e674
// Checksum 0xf132eb, Offset: 0x5c8
// Size: 0x234
function function_e128e674() {
    self endon(#"entityshutdown");
    var_c8eafd69 = [];
    var_1fdb8fee = -1;
    util::waitforclient(0);
    while (true) {
        localplayers = level.localplayers;
        if (var_1fdb8fee != 0 || level.var_e1b96029.size != 0) {
            for (i = 0; i < localplayers.size; i++) {
                var_c8eafd69[i] = 0;
            }
            for (i = 0; i < level.var_e1b96029.size; i++) {
                if (isdefined(level.var_e1b96029[i].var_f0a669b2.stunned) && level.var_e1b96029[i].var_f0a669b2.stunned) {
                    continue;
                }
                for (j = 0; j < localplayers.size; j++) {
                    if (localplayers[j] == level.var_e1b96029[i].var_f0a669b2 getowner(j)) {
                        var_c8eafd69[j] = 1;
                        setlocalradarposition(j, level.var_e1b96029[i].var_f0a669b2.origin);
                    }
                }
            }
            for (i = 0; i < localplayers.size; i++) {
                setlocalradarenabled(i, var_c8eafd69[i]);
            }
        }
        var_1fdb8fee = level.var_e1b96029.size;
        wait(0.1);
    }
}

