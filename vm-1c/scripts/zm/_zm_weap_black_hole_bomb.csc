#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_vortex;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_weapons;

#namespace zm_weap_black_hole_bomb;

// Namespace zm_weap_black_hole_bomb
// Params 0, eflags: 0x2
// Checksum 0xacd98a2a, Offset: 0x390
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_weap_black_hole_bomb", &__init__, undefined, undefined);
}

// Namespace zm_weap_black_hole_bomb
// Params 0, eflags: 0x0
// Checksum 0x59e6f1eb, Offset: 0x3d0
// Size: 0x1bc
function __init__() {
    level._effect["black_hole_bomb_portal"] = "dlc5/cosmo/fx_zmb_blackhole_looping";
    level._effect["black_hole_bomb_event_horizon"] = "dlc5/cosmo/fx_zmb_blackhole_implode";
    level._effect["black_hole_bomb_marker_flare"] = "dlc5/cosmo/fx_zmb_blackhole_flare_marker";
    level._effect["black_hole_bomb_zombie_pull"] = "dlc5/cosmo/fx_blackhole_zombie_breakup";
    level.var_b328ac02 = [];
    level.var_ff11ae70 = "zombie_cosmodrome_blackhole";
    level.var_d0675b40 = 2;
    level.var_f5d32c5f = 1;
    level.var_4c04cef3 = 10;
    visionset_mgr::register_visionset_info("zombie_cosmodrome_blackhole", 21000, 30, undefined, "zombie_cosmodrome_blackhole");
    clientfield::register("toplayer", "bhb_viewlights", 21000, 2, "int", &bhb_viewlights, 0, 0);
    clientfield::register("scriptmover", "toggle_black_hole_deployed", 21000, 1, "int", &function_437a4164, 0, 0);
    clientfield::register("actor", "toggle_black_hole_being_pulled", 21000, 1, "int", &function_13471301, 0, 1);
}

// Namespace zm_weap_black_hole_bomb
// Params 7, eflags: 0x0
// Checksum 0xff77edf9, Offset: 0x598
// Size: 0xa4
function bhb_viewlights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 100, newval, 0);
        return;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
}

// Namespace zm_weap_black_hole_bomb
// Params 7, eflags: 0x0
// Checksum 0x933466e6, Offset: 0x648
// Size: 0xae
function function_437a4164(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (localclientnum != 0) {
        return;
    }
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        level thread function_65616fbd(i, self);
    }
}

// Namespace zm_weap_black_hole_bomb
// Params 2, eflags: 0x0
// Checksum 0xaf4a9b68, Offset: 0x700
// Size: 0x224
function function_65616fbd(local_client_num, var_d89c34cf) {
    var_a2931b79 = spawn(local_client_num, var_d89c34cf.origin, "script_model");
    var_a2931b79 setmodel("tag_origin");
    playsound(0, "wpn_bhbomb_portal_start", var_a2931b79.origin);
    var_a2931b79.sndlooper = var_a2931b79 playloopsound("wpn_bhbomb_portal_loop");
    playfxontag(local_client_num, level._effect["black_hole_bomb_portal"], var_a2931b79, "tag_origin");
    playfxontag(local_client_num, level._effect["black_hole_bomb_marker_flare"], var_a2931b79, "tag_origin");
    var_d89c34cf waittill(#"entityshutdown");
    if (isdefined(var_a2931b79.sndlooper)) {
        var_a2931b79 stoploopsound(var_a2931b79.sndlooper);
    }
    var_864fa4e6 = spawn(local_client_num, var_a2931b79.origin, "script_model");
    var_864fa4e6 setmodel("tag_origin");
    var_a2931b79 delete();
    playfxontag(local_client_num, level._effect["black_hole_bomb_event_horizon"], var_864fa4e6, "tag_origin");
    wait 0.2;
    var_864fa4e6 delete();
}

// Namespace zm_weap_black_hole_bomb
// Params 2, eflags: 0x0
// Checksum 0x726acbc3, Offset: 0x930
// Size: 0xa4
function function_2aac6f7b(ent_model, var_26cba5b) {
    var_97b57ad6 = spawnstruct();
    var_97b57ad6.origin = ent_model.origin;
    var_97b57ad6.var_87bd727f = 1;
    array::add(level.var_b328ac02, var_97b57ad6);
    ent_model waittill(#"entityshutdown");
    var_97b57ad6.var_87bd727f = 0;
    wait 0.2;
}

// Namespace zm_weap_black_hole_bomb
// Params 7, eflags: 0x0
// Checksum 0xab804352, Offset: 0x9e0
// Size: 0x1e4
function function_13471301(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"death");
    self endon(#"entityshutdown");
    if (localclientnum != 0) {
        return;
    }
    if (newval) {
        self.var_778a482a = spawn(localclientnum, self.origin, "script_model");
        self.var_778a482a.angles = self.angles;
        self.var_778a482a linkto(self, "tag_origin");
        self.var_778a482a setmodel("tag_origin");
        level thread function_aedc4b92(self, self.var_778a482a);
        players = getlocalplayers();
        for (i = 0; i < players.size; i++) {
            playfxontag(i, level._effect["black_hole_bomb_zombie_pull"], self.var_778a482a, "tag_origin");
        }
        return;
    }
    if (isdefined(self.var_778a482a)) {
        self.var_778a482a notify(#"hash_8b2f8cb6");
        self.var_778a482a unlink();
        self.var_778a482a delete();
    }
}

// Namespace zm_weap_black_hole_bomb
// Params 2, eflags: 0x0
// Checksum 0x675d8ea9, Offset: 0xbd0
// Size: 0x5c
function function_aedc4b92(var_3df01f81, var_be0a9746) {
    var_be0a9746 endon(#"hash_8b2f8cb6");
    if (!isdefined(var_3df01f81)) {
        return;
    }
    var_3df01f81 waittill(#"entityshutdown");
    if (isdefined(var_be0a9746)) {
        var_be0a9746 delete();
    }
}

