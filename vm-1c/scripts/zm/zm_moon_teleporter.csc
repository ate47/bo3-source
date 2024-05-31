#using scripts/shared/util_shared;

#namespace namespace_591ce3c5;

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x0
// namespace_591ce3c5<file_0>::function_d290ebfa
// Checksum 0xa8e36342, Offset: 0x130
// Size: 0xce
function main() {
    level thread function_80009f4();
    util::waitforallclients();
    level.var_80a2e709 = level._effect["zombie_pentagon_teleporter"];
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        players[i] thread function_c76c401c(i);
        players[i] thread function_c19e773d(i);
    }
}

// Namespace namespace_591ce3c5
// Params 1, eflags: 0x0
// namespace_591ce3c5<file_0>::function_c76c401c
// Checksum 0x5c8f200e, Offset: 0x208
// Size: 0x1a2
function function_c76c401c(clientnum) {
    teleporters = getentarray(clientnum, "pentagon_teleport_fx", "targetname");
    level.fxents[clientnum] = [];
    level.var_aef21231[clientnum] = 1;
    for (i = 0; i < teleporters.size; i++) {
        fx_ent = spawn(clientnum, teleporters[i].origin, "script_model");
        fx_ent setmodel("tag_origin");
        fx_ent.angles = teleporters[i].angles;
        if (!isdefined(level.fxents[clientnum])) {
            level.fxents[clientnum] = [];
        } else if (!isarray(level.fxents[clientnum])) {
            level.fxents[clientnum] = array(level.fxents[clientnum]);
        }
        level.fxents[clientnum][level.fxents[clientnum].size] = fx_ent;
    }
}

// Namespace namespace_591ce3c5
// Params 3, eflags: 0x0
// namespace_591ce3c5<file_0>::function_fe2dfe37
// Checksum 0x98c2a46e, Offset: 0x3b8
// Size: 0x1a6
function function_fe2dfe37(clientnum, set, newent) {
    fx_array = level.fxents[clientnum];
    if (set && level.var_aef21231[clientnum] == 1) {
        println("<unknown string>", clientnum);
        level.var_aef21231[clientnum] = 0;
        for (i = 0; i < fx_array.size; i++) {
            if (isdefined(fx_array[i].portalfx)) {
                deletefx(clientnum, fx_array[i].portalfx);
            }
            wait(0.01);
            fx_array[i].portalfx = playfxontag(clientnum, level.var_80a2e709, fx_array[i], "tag_origin");
            playsound(clientnum, "evt_teleporter_start", fx_array[i].origin);
            fx_array[i] playloopsound("evt_teleporter_loop", 1.75);
        }
    }
}

// Namespace namespace_591ce3c5
// Params 1, eflags: 0x0
// namespace_591ce3c5<file_0>::function_c19e773d
// Checksum 0xdd8fd674, Offset: 0x568
// Size: 0x218
function function_c19e773d(clientnum) {
    while (true) {
        clientnum = level waittill(#"cool_fx");
        players = getlocalplayers();
        if (level.var_aef21231[clientnum] == 0) {
            fx_pos = undefined;
            closest = 512;
            for (i = 0; i < level.fxents[clientnum].size; i++) {
                if (isdefined(level.fxents[clientnum][i])) {
                    if (closest > distance(level.fxents[clientnum][i].origin, players[clientnum].origin)) {
                        closest = distance(level.fxents[clientnum][i].origin, players[clientnum].origin);
                        fx_pos = level.fxents[clientnum][i];
                    }
                }
            }
            if (isdefined(fx_pos) && isdefined(fx_pos.portalfx)) {
                deletefx(clientnum, fx_pos.portalfx);
                fx_pos.portalfx = playfxontag(clientnum, level._effect["zombie_pent_portal_cool"], fx_pos, "tag_origin");
                self thread function_fb46767a(fx_pos, clientnum);
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_591ce3c5
// Params 2, eflags: 0x0
// namespace_591ce3c5<file_0>::function_fb46767a
// Checksum 0x17359d1f, Offset: 0x788
// Size: 0xc8
function function_fb46767a(fx_pos, clientnum) {
    fx_pos thread function_7bbcd1cf();
    fx_pos waittill(#"hash_9f9eb622");
    if (isdefined(fx_pos) && isdefined(fx_pos.portalfx)) {
        deletefx(clientnum, fx_pos.portalfx);
        if (level.var_aef21231[clientnum] == 0) {
            fx_pos.portalfx = playfxontag(clientnum, level.var_80a2e709, fx_pos, "tag_origin");
        }
    }
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x0
// namespace_591ce3c5<file_0>::function_7bbcd1cf
// Checksum 0x28ab658f, Offset: 0x858
// Size: 0x6a
function function_7bbcd1cf() {
    time = 0;
    self.defcon_active = 0;
    self thread function_4d04821d();
    while (!self.defcon_active && time < 20) {
        wait(1);
        time++;
    }
    self notify(#"hash_9f9eb622");
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x0
// namespace_591ce3c5<file_0>::function_4d04821d
// Checksum 0xc2021e56, Offset: 0x8d0
// Size: 0x28
function function_4d04821d() {
    self endon(#"hash_9f9eb622");
    level waittill(#"hash_d33bd3e6");
    self.defcon_active = 1;
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x0
// namespace_591ce3c5<file_0>::function_80009f4
// Checksum 0x28b03046, Offset: 0x900
// Size: 0x50
function function_80009f4() {
    while (true) {
        clientnum = level waittill(#"ae1");
        visionsetnaked(clientnum, "flare", 0.4);
    }
}

