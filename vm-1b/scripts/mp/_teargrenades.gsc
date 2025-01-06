#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_perplayer;
#using scripts/shared/util_shared;

#namespace _teargrenades;

// Namespace _teargrenades
// Params 0, eflags: 0x0
// Checksum 0xd672c535, Offset: 0x138
// Size: 0x82
function main() {
    level.var_c8c0c927 = -86;
    level.var_5081b9c0 = -128;
    level.var_4b16ff7b = 7;
    level.var_c3da1428 = 23;
    level.var_51c0f2d0 = 3;
    level.var_969b009c = 4;
    var_f59a892e = perplayer::init("tear_grenade_monitor", &function_b8add1a2, &function_2641b450);
    perplayer::enable(var_f59a892e);
}

// Namespace _teargrenades
// Params 0, eflags: 0x0
// Checksum 0x1d1160e5, Offset: 0x1c8
// Size: 0x12
function function_b8add1a2() {
    self thread function_ba1b8fa();
}

// Namespace _teargrenades
// Params 1, eflags: 0x0
// Checksum 0x3dcb626f, Offset: 0x1e8
// Size: 0x13
function function_2641b450(disconnected) {
    self notify(#"hash_235a6bdd");
}

// Namespace _teargrenades
// Params 0, eflags: 0x0
// Checksum 0x734b2cbb, Offset: 0x208
// Size: 0x1c1
function function_ba1b8fa() {
    self endon(#"hash_235a6bdd");
    wait 0.05;
    weapon = getweapon("tear_grenade");
    if (!self hasweapon(weapon)) {
        return;
    }
    var_c9443414 = self getammocount(weapon);
    while (true) {
        ammo = self getammocount(weapon);
        if (ammo < var_c9443414) {
            num = var_c9443414 - ammo;
            /#
            #/
            for (i = 0; i < num; i++) {
                grenades = getentarray("grenade", "classname");
                bestdist = undefined;
                var_e0afd4a6 = undefined;
                for (g = 0; g < grenades.size; g++) {
                    if (!isdefined(grenades[g].var_b3462f2d)) {
                        dist = distance(grenades[g].origin, self.origin + (0, 0, 48));
                        if (!isdefined(bestdist) || dist < bestdist) {
                            bestdist = dist;
                            var_e0afd4a6 = g;
                        }
                    }
                }
                if (isdefined(bestdist)) {
                    grenades[var_e0afd4a6].var_b3462f2d = 1;
                    grenades[var_e0afd4a6] thread function_b0dbd0d8(self.team);
                }
            }
        }
        var_c9443414 = ammo;
        wait 0.05;
    }
}

// Namespace _teargrenades
// Params 1, eflags: 0x0
// Checksum 0xd60a6005, Offset: 0x3d8
// Size: 0x42
function function_b0dbd0d8(team) {
    wait level.var_969b009c;
    ent = spawnstruct();
    ent thread tear(self.origin);
}

// Namespace _teargrenades
// Params 1, eflags: 0x0
// Checksum 0xe5016e90, Offset: 0x428
// Size: 0x1a5
function tear(pos) {
    trig = spawn("trigger_radius", pos, 0, level.var_c8c0c927, level.var_5081b9c0);
    starttime = gettime();
    self thread function_700f69bc();
    self endon(#"hash_dcd5f169");
    while (true) {
        trig waittill(#"trigger", player);
        if (player.sessionstate != "playing") {
            continue;
        }
        time = (gettime() - starttime) / 1000;
        currad = level.var_c8c0c927;
        curheight = level.var_5081b9c0;
        if (time < level.var_4b16ff7b) {
            currad *= time / level.var_4b16ff7b;
            curheight *= time / level.var_4b16ff7b;
        }
        offset = player.origin + (0, 0, 32) - pos;
        var_90735bc6 = (offset[0], offset[1], 0);
        if (lengthsquared(var_90735bc6) > currad * currad) {
            continue;
        }
        if (player.origin[2] - pos[2] > curheight) {
            continue;
        }
        player.var_fcc4fa8f = gettime();
        if (!isdefined(player.var_580ff16b)) {
            player thread function_580ff16b();
        }
    }
}

// Namespace _teargrenades
// Params 0, eflags: 0x0
// Checksum 0xc41eb76e, Offset: 0x5d8
// Size: 0x13
function function_700f69bc() {
    wait level.var_c3da1428;
    self notify(#"hash_dcd5f169");
}

// Namespace _teargrenades
// Params 0, eflags: 0x0
// Checksum 0x6e8d8e4e, Offset: 0x5f8
// Size: 0xa5
function function_580ff16b() {
    self endon(#"death");
    self endon(#"disconnect");
    self.var_580ff16b = 1;
    if (self util::mayapplyscreeneffect()) {
        self shellshock("teargas", 60);
    }
    while (true) {
        if (gettime() - self.var_fcc4fa8f > level.var_51c0f2d0 * 1000) {
            break;
        }
        wait 1;
    }
    self shellshock("teargas", 1);
    if (self util::mayapplyscreeneffect()) {
        self.var_580ff16b = undefined;
    }
}

/#

    // Namespace _teargrenades
    // Params 3, eflags: 0x0
    // Checksum 0x9ca46abd, Offset: 0x6a8
    // Size: 0x201
    function drawcylinder(pos, rad, height) {
        time = 0;
        while (true) {
            currad = rad;
            curheight = height;
            if (time < level.var_4b16ff7b) {
                currad *= time / level.var_4b16ff7b;
                curheight *= time / level.var_4b16ff7b;
            }
            for (r = 0; r < 20; r++) {
                theta = r / 20 * 360;
                theta2 = (r + 1) / 20 * 360;
                line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0));
                line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight));
                line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight));
            }
            time += 0.05;
            if (time > level.var_c3da1428) {
                break;
            }
            wait 0.05;
        }
    }

#/
