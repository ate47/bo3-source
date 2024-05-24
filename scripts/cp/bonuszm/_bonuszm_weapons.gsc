#using scripts/shared/weapons/_weapons;
#using scripts/shared/math_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_fdfaa57d;

// Namespace namespace_fdfaa57d
// Method(s) 2 Total 2
class class_a17e6f03 {

}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x2
// Checksum 0x30387a33, Offset: 0x248
// Size: 0x154
function autoexec function_58d5283a() {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    mapname = getdvarstring("mapname");
    level.var_acba406b = [];
    level.var_ed11f8b7 = [];
    level.var_5e3f3853 = 0;
    level.var_24893e7 = spawn("script_model", (0, 0, 0));
    level.var_24893e7 sethighdetail(1);
    level.var_24893e7 ghost();
    level.var_a432d965 = struct::get_script_bundle("bonuszmdata", mapname);
    var_6a173bd1 = function_e8ef6cb0(level.var_a432d965, "weaponsTable");
    /#
        assert(isdefined(var_6a173bd1));
    #/
    function_549c28ac("gamedata/tables/cpzm/" + var_6a173bd1);
}

// Namespace namespace_fdfaa57d
// Params 1, eflags: 0x1 linked
// Checksum 0x9597f221, Offset: 0x3a8
// Size: 0x24e
function function_549c28ac(var_6a173bd1) {
    noneweapon = getweapon("none");
    numweapons = tablelookuprowcount(var_6a173bd1);
    for (i = 0; i < numweapons; i++) {
        var_279890e8 = new class_a17e6f03();
        var_279890e8.weaponname = tablelookupcolumnforrow(var_6a173bd1, i, 0);
        var_279890e8.var_bc6ce097 = int(tablelookupcolumnforrow(var_6a173bd1, i, 1));
        var_279890e8.maxattachments = int(tablelookupcolumnforrow(var_6a173bd1, i, 2));
        var_279890e8.var_83fbee4b = tablelookupcolumnforrow(var_6a173bd1, i, 3);
        if (!isdefined(var_279890e8.weaponname) || getweapon(var_279890e8.weaponname) == noneweapon) {
            continue;
        }
        if (var_279890e8.var_83fbee4b == "") {
            var_279890e8.var_83fbee4b = 0;
        } else {
            var_279890e8.var_83fbee4b = int(var_279890e8.var_83fbee4b);
        }
        if (var_279890e8.var_83fbee4b) {
            array::add(level.var_ed11f8b7, var_279890e8);
            continue;
        }
        array::add(level.var_acba406b, var_279890e8);
    }
}

// Namespace namespace_fdfaa57d
// Params 1, eflags: 0x1 linked
// Checksum 0x97a564d, Offset: 0x600
// Size: 0xea
function function_1e2e0936(var_1010f96a) {
    if (!isdefined(var_1010f96a)) {
        var_1010f96a = 0;
    }
    if (isdefined(level.var_fd21e404)) {
        weaponinfo = level.var_fd21e404;
    }
    level.var_fd21e404 = function_53200e4d(var_1010f96a);
    level.var_24893e7 useweaponmodel(level.var_fd21e404[0], level.var_fd21e404[0].worldmodel);
    level.var_24893e7 setweaponrenderoptions(level.var_fd21e404[2], 0, 0, 0, 0);
    if (isdefined(weaponinfo)) {
        return weaponinfo;
    }
    return function_53200e4d(var_1010f96a);
}

// Namespace namespace_fdfaa57d
// Params 1, eflags: 0x1 linked
// Checksum 0x93e48692, Offset: 0x6f8
// Size: 0x890
function function_53200e4d(var_1010f96a) {
    /#
        assert(isdefined(level.var_acba406b));
    #/
    /#
        assert(isdefined(level.var_ed11f8b7));
    #/
    /#
        assert(isdefined(level.var_a9e78bf7["magicboxonlyweaponchance"]));
    #/
    var_82d771df = undefined;
    var_d9cb0358 = [];
    if (var_1010f96a && level.var_5e3f3853 < level.var_a9e78bf7["maxmagicboxonlyweapons"] && randomint(100) < level.var_a9e78bf7["magicboxonlyweaponchance"] && level.var_ed11f8b7.size) {
        level.var_5e3f3853++;
        var_279890e8 = array::random(level.var_ed11f8b7);
    } else {
        var_279890e8 = array::random(level.var_acba406b);
    }
    numattachments = 0;
    if (var_279890e8.var_bc6ce097 >= 0 && var_279890e8.maxattachments > 0) {
        numattachments = randomintrange(var_279890e8.var_bc6ce097, var_279890e8.maxattachments);
    }
    if (numattachments > 0) {
        weapon = getweapon(var_279890e8.weaponname);
        var_d9cb0358 = getrandomcompatibleattachmentsforweapon(weapon, numattachments);
    }
    var_65ce895e = undefined;
    var_2106259a = 0;
    if (isdefined(var_d9cb0358) && isarray(var_d9cb0358) && var_d9cb0358.size) {
        var_82d771df = getweapon(var_279890e8.weaponname, var_d9cb0358);
        if (isdefined(var_82d771df)) {
            var_2106259a = 1;
            switch (var_d9cb0358.size) {
            case 8:
                var_65ce895e = getattachmentcosmeticvariantindexes(var_82d771df, var_d9cb0358[0], math::cointoss(), var_d9cb0358[1], math::cointoss(), var_d9cb0358[2], math::cointoss(), var_d9cb0358[3], math::cointoss(), var_d9cb0358[4], math::cointoss(), var_d9cb0358[5], math::cointoss(), var_d9cb0358[6], math::cointoss(), var_d9cb0358[7], math::cointoss());
                break;
            case 7:
                var_65ce895e = getattachmentcosmeticvariantindexes(var_82d771df, var_d9cb0358[0], math::cointoss(), var_d9cb0358[1], math::cointoss(), var_d9cb0358[2], math::cointoss(), var_d9cb0358[3], math::cointoss(), var_d9cb0358[4], math::cointoss(), var_d9cb0358[5], math::cointoss(), var_d9cb0358[6], math::cointoss());
                break;
            case 6:
                var_65ce895e = getattachmentcosmeticvariantindexes(var_82d771df, var_d9cb0358[0], math::cointoss(), var_d9cb0358[1], math::cointoss(), var_d9cb0358[2], math::cointoss(), var_d9cb0358[3], math::cointoss(), var_d9cb0358[4], math::cointoss(), var_d9cb0358[5], math::cointoss());
                break;
            case 5:
                var_65ce895e = getattachmentcosmeticvariantindexes(var_82d771df, var_d9cb0358[0], math::cointoss(), var_d9cb0358[1], math::cointoss(), var_d9cb0358[2], math::cointoss(), var_d9cb0358[3], math::cointoss(), var_d9cb0358[4], math::cointoss());
                break;
            case 4:
                var_65ce895e = getattachmentcosmeticvariantindexes(var_82d771df, var_d9cb0358[0], math::cointoss(), var_d9cb0358[1], math::cointoss(), var_d9cb0358[2], math::cointoss(), var_d9cb0358[3], math::cointoss());
                break;
            case 3:
                var_65ce895e = getattachmentcosmeticvariantindexes(var_82d771df, var_d9cb0358[0], math::cointoss(), var_d9cb0358[1], math::cointoss(), var_d9cb0358[2], math::cointoss());
                break;
            case 2:
                var_65ce895e = getattachmentcosmeticvariantindexes(var_82d771df, var_d9cb0358[0], math::cointoss(), var_d9cb0358[1], math::cointoss());
                break;
            case 1:
                var_65ce895e = getattachmentcosmeticvariantindexes(var_82d771df, var_d9cb0358[0], math::cointoss());
                break;
            }
        }
    }
    if (!var_2106259a) {
        var_82d771df = getweapon(var_279890e8.weaponname);
    }
    weaponinfo = [];
    weaponinfo[0] = var_82d771df;
    weaponinfo[1] = var_65ce895e;
    if (randomint(100) < level.var_a9e78bf7["camochance"]) {
        weaponinfo[2] = array::random(array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 18, 19, 20, 21, 22, 23, 24, 25));
    } else {
        weaponinfo[2] = 0;
    }
    /#
        assert(weaponinfo[0] != level.weaponnone);
    #/
    return weaponinfo;
}

// Namespace namespace_fdfaa57d
// Params 2, eflags: 0x1 linked
// Checksum 0xe01c7cc, Offset: 0xf90
// Size: 0x48c
function function_43128d49(weaponinfo, var_fe7b5ca3) {
    if (!isdefined(var_fe7b5ca3)) {
        var_fe7b5ca3 = 1;
    }
    /#
        assert(isdefined(weaponinfo));
    #/
    randomweapon = weaponinfo[0];
    var_d6c5d457 = weaponinfo[1];
    var_54a70e6e = weaponinfo[2];
    if (!isdefined(randomweapon)) {
        return;
    }
    if (randomweapon == level.weaponnone) {
        return;
    }
    a_weaponlist = self getweaponslist();
    var_961f11b8 = [];
    foreach (weapon in a_weaponlist) {
        if (isdefined(weapon.isheroweapon) && weapon.isheroweapon) {
            if (!isdefined(var_961f11b8)) {
                var_961f11b8 = [];
            } else if (!isarray(var_961f11b8)) {
                var_961f11b8 = array(var_961f11b8);
            }
            var_961f11b8[var_961f11b8.size] = weapon;
        }
    }
    var_4044e31f = self getweaponslistprimaries();
    foreach (weapon in var_4044e31f) {
        if (weapon.isheroweapon || !var_fe7b5ca3) {
            self takeweapon(weapon);
            continue;
        }
        self function_132d9eee(weapon);
    }
    camooptions = self calcweaponoptions(var_54a70e6e, 0, 0, 0);
    if (isdefined(var_d6c5d457)) {
        self giveweapon(randomweapon, camooptions, var_d6c5d457);
    } else {
        self giveweapon(randomweapon, camooptions);
    }
    if (self hasweapon(randomweapon)) {
        self setweaponammoclip(randomweapon, randomweapon.clipsize);
        self givemaxammo(randomweapon);
    }
    foreach (weapon in var_961f11b8) {
        self giveweapon(weapon);
        self setweaponammoclip(weapon, weapon.clipsize);
        self givemaxammo(weapon);
    }
    if (self hasweapon(randomweapon)) {
        self switchtoweapon(randomweapon);
        return;
    }
    if (var_4044e31f.size) {
        self switchtoweapon(var_4044e31f[0]);
    }
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x0
// Checksum 0xa9502087, Offset: 0x1428
// Size: 0x156
function function_7e774306() {
    level.var_3d2f81f1 = getweapon("ar_standard");
    while (true) {
        level waittill(#"hash_1c353a4f");
        foreach (player in level.activeplayers) {
            player function_be94c003();
        }
        level waittill(#"hash_14c06c0c");
        foreach (player in level.activeplayers) {
            player function_d5efb07f();
        }
    }
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0x639c1fbf, Offset: 0x1588
// Size: 0x94
function function_be94c003() {
    self.var_c74b20c1 = self getcurrentweapon();
    if (self hasweapon(level.var_3d2f81f1)) {
        self.var_7a5a5490 = 1;
    } else {
        self giveweapon(level.var_3d2f81f1);
    }
    self switchtoweapon(level.var_3d2f81f1);
}

// Namespace namespace_fdfaa57d
// Params 0, eflags: 0x1 linked
// Checksum 0x5600cdc8, Offset: 0x1628
// Size: 0x7c
function function_d5efb07f() {
    if (!(isdefined(self.var_7a5a5490) && self.var_7a5a5490)) {
        self takeweapon(level.var_3d2f81f1);
    }
    if (isdefined(self.var_c74b20c1) && self hasweapon(self.var_c74b20c1)) {
        self switchtoweapon(self.var_c74b20c1);
    }
}

// Namespace namespace_fdfaa57d
// Params 1, eflags: 0x1 linked
// Checksum 0xec9d94b6, Offset: 0x16b0
// Size: 0x174
function function_132d9eee(weapon) {
    clipammo = self getweaponammoclip(weapon);
    stockammo = self getweaponammostock(weapon);
    stockmax = weapon.maxammo;
    if (stockammo > stockmax) {
        stockammo = stockmax;
    }
    item = self dropitem(weapon, "tag_origin");
    if (!isdefined(item)) {
        /#
            iprintlnbold("magicboxonlyweaponchance" + weapon.name + "magicboxonlyweaponchance");
        #/
        return;
    }
    level weapons::drop_limited_weapon(weapon, self, item);
    item itemweaponsetammo(clipammo, stockammo);
    item.owner = self;
    item thread weapons::watch_pickup();
    item thread weapons::delete_pickup_after_awhile();
}

