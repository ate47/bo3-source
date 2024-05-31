#using scripts/cp/bonuszm/_bonuszm;
#using scripts/cp/bonuszm/_bonuszm_spawner_shared;
#using scripts/codescripts/struct;

#namespace namespace_a432d965;

// Namespace namespace_a432d965
// Params 0, eflags: 0x2
// namespace_a432d965<file_0>::function_dc036a7c
// Checksum 0xca21c695, Offset: 0x5d8
// Size: 0x9c
function autoexec function_dc036a7c() {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    level.var_a432d965 = struct::get_script_bundle("bonuszmdata", getdvarstring("mapname"));
    level.var_e9d4a03e = &function_e9d4a03e;
    level.var_fd2d1f37 = &function_fd2d1f37;
    level.var_27fb20e1 = &function_27fb20e1;
}

// Namespace namespace_a432d965
// Params 2, eflags: 0x1 linked
// namespace_a432d965<file_0>::function_da5f2c0d
// Checksum 0x494bd8b7, Offset: 0x680
// Size: 0xe34
function function_da5f2c0d(mapname, var_b0614bba) {
    level.var_a9e78bf7 = undefined;
    if (!isdefined(level.var_a432d965)) {
        function_9a6a6726();
        function_97b4bacb(1, 0);
        function_4542e087();
        namespace_2396e2d7::function_fc1970dd();
        return;
    }
    skiptoindex = undefined;
    prefix = "";
    var_e6879fdc = function_e8ef6cb0(level.var_a432d965, "skiptocount");
    if (!isdefined(var_e6879fdc)) {
        var_e6879fdc = 0;
    }
    for (i = 1; i <= var_e6879fdc; i++) {
        prefix = function_15c7079(i);
        var_454219da = function_e8ef6cb0(level.var_a432d965, prefix + "skiptoname");
        if (var_454219da == var_b0614bba) {
            skiptoindex = i;
            break;
        }
    }
    level.var_a9e78bf7 = [];
    if (!isdefined(skiptoindex)) {
        /#
            level.var_5deb2d16 = 1;
        #/
        function_9a6a6726();
        function_97b4bacb(1, 0);
        function_4542e087();
        namespace_2396e2d7::function_fc1970dd();
        return;
    }
    /#
        level.var_5deb2d16 = 0;
    #/
    level.var_a9e78bf7["skiptoname"] = var_454219da;
    level.var_a9e78bf7["powerdropchance"] = function_e8ef6cb0(level.var_a432d965, "powerdropchance");
    level.var_a9e78bf7["cybercoredropchance"] = function_e8ef6cb0(level.var_a432d965, "cybercoredropchance");
    level.var_a9e78bf7["cybercoreupgradeddropchance"] = function_e8ef6cb0(level.var_a432d965, "cybercoreupgradeddropchance");
    level.var_a9e78bf7["maxdropammochance"] = function_e8ef6cb0(level.var_a432d965, "maxdropammochance");
    level.var_a9e78bf7["maxdropammoupgradedchance"] = function_e8ef6cb0(level.var_a432d965, "maxdropammoupgradedchance");
    level.var_a9e78bf7["weapondropchance"] = function_e8ef6cb0(level.var_a432d965, "weapondropchance");
    level.var_a9e78bf7["instakilldropchance"] = function_e8ef6cb0(level.var_a432d965, "instakilldropchance");
    level.var_a9e78bf7["instakillupgradeddropchance"] = function_e8ef6cb0(level.var_a432d965, "instakillupgradeddropchance");
    level.var_a9e78bf7["powerupdropsenabled"] = function_e8ef6cb0(level.var_a432d965, prefix + "powerupdropsenabled");
    level.var_a9e78bf7["zigzagdeviationmin"] = function_e8ef6cb0(level.var_a432d965, prefix + "zigzagdeviationmin");
    level.var_a9e78bf7["zigzagdeviationmax"] = function_e8ef6cb0(level.var_a432d965, prefix + "zigzagdeviationmax");
    level.var_a9e78bf7["zigzagdeviationmintime"] = function_e8ef6cb0(level.var_a432d965, prefix + "zigzagdeviationmintime");
    level.var_a9e78bf7["zigzagdeviationmaxtime"] = function_e8ef6cb0(level.var_a432d965, prefix + "zigzagdeviationmaxtime");
    level.var_a9e78bf7["onlyuseonstart"] = function_e8ef6cb0(level.var_a432d965, prefix + "onlyuseonstart");
    level.var_a9e78bf7["zombifyenabled"] = function_e8ef6cb0(level.var_a432d965, prefix + "zombifyenabled");
    level.var_a9e78bf7["startunaware"] = function_e8ef6cb0(level.var_a432d965, prefix + "startunaware");
    level.var_a9e78bf7["alertnessspreaddelay"] = function_e8ef6cb0(level.var_a432d965, prefix + "alertnessspreaddelay");
    level.var_a9e78bf7["forcecleanuponcompletion"] = function_e8ef6cb0(level.var_a432d965, prefix + "forcecleanuponcompletion");
    level.var_a9e78bf7["disablefailsafelogic"] = function_e8ef6cb0(level.var_a432d965, prefix + "disablefailsafelogic");
    level.var_a9e78bf7["extraspawns"] = function_e8ef6cb0(level.var_a432d965, prefix + "extraspawns");
    level.var_a9e78bf7["extraspawngapmin"] = function_e8ef6cb0(level.var_a432d965, prefix + "extraspawngapmin");
    level.var_a9e78bf7["walkpercent"] = function_e8ef6cb0(level.var_a432d965, prefix + "walkpercent");
    level.var_a9e78bf7["runpercent"] = function_e8ef6cb0(level.var_a432d965, prefix + "runpercent");
    level.var_a9e78bf7["sprintpercent"] = function_e8ef6cb0(level.var_a432d965, prefix + "sprintpercent");
    level.var_a9e78bf7["levelonehealth"] = function_e8ef6cb0(level.var_a432d965, prefix + "levelonehealth");
    level.var_a9e78bf7["leveltwohealth"] = function_e8ef6cb0(level.var_a432d965, prefix + "leveltwohealth");
    level.var_a9e78bf7["levelthreehealth"] = function_e8ef6cb0(level.var_a432d965, prefix + "levelthreehealth");
    level.var_a9e78bf7["levelonezombies"] = function_e8ef6cb0(level.var_a432d965, prefix + "levelonezombies");
    level.var_a9e78bf7["leveltwozombies"] = function_e8ef6cb0(level.var_a432d965, prefix + "leveltwozombies");
    level.var_a9e78bf7["levelthreezombies"] = function_e8ef6cb0(level.var_a432d965, prefix + "levelthreezombies");
    level.var_a9e78bf7["suicidalzombiechance"] = function_e8ef6cb0(level.var_a432d965, prefix + "suicidalzombiechance");
    level.var_a9e78bf7["suicidalzombieupgradedchance"] = function_e8ef6cb0(level.var_a432d965, prefix + "suicidalzombieupgradedchance");
    level.var_a9e78bf7["deimosinfectedzombiechance"] = function_e8ef6cb0(level.var_a432d965, prefix + "deimosinfectedzombiechance");
    level.var_a9e78bf7["sparkzombiechance"] = function_e8ef6cb0(level.var_a432d965, prefix + "sparkzombiechance");
    level.var_a9e78bf7["sparkzombieupgradedchance"] = function_e8ef6cb0(level.var_a432d965, prefix + "sparkzombieupgradedchance");
    level.var_a9e78bf7["maxreachabilitylevel"] = function_e8ef6cb0(level.var_a432d965, prefix + "maxreachabilitylevel");
    level.var_a9e78bf7["reachabilityinterval"] = function_e8ef6cb0(level.var_a432d965, prefix + "reachabilityinterval");
    level.var_a9e78bf7["maxreachabilityparasites"] = function_e8ef6cb0(level.var_a432d965, prefix + "maxreachabilityparasites");
    level.var_a9e78bf7["powerdropsscalar"] = function_e8ef6cb0(level.var_a432d965, prefix + "powerdropsscalar");
    level.var_a9e78bf7["pathabilityenabled"] = function_e8ef6cb0(level.var_a432d965, prefix + "pathabilityenabled");
    level.var_a9e78bf7["sprinttoplayerdistance"] = function_e8ef6cb0(level.var_a432d965, prefix + "sprinttoplayerdistance");
    level.var_a9e78bf7["skipobjectivewait"] = function_e8ef6cb0(level.var_a432d965, prefix + "skipobjectivewait");
    level.var_a9e78bf7["zombiehealthscale1"] = function_e8ef6cb0(level.var_a432d965, "zombiehealthscale1");
    level.var_a9e78bf7["zombiehealthscale2"] = function_e8ef6cb0(level.var_a432d965, "zombiehealthscale2");
    level.var_a9e78bf7["zombiehealthscale3"] = function_e8ef6cb0(level.var_a432d965, "zombiehealthscale3");
    level.var_a9e78bf7["zombiehealthscale4"] = function_e8ef6cb0(level.var_a432d965, "zombiehealthscale4");
    level.var_a9e78bf7["zombiehealthscale5"] = function_e8ef6cb0(level.var_a432d965, "zombiehealthscale5");
    level.var_a9e78bf7["extrazombiescale1"] = function_e8ef6cb0(level.var_a432d965, "extrazombiescale1");
    level.var_a9e78bf7["extrazombiescale2"] = function_e8ef6cb0(level.var_a432d965, "extrazombiescale2");
    level.var_a9e78bf7["extrazombiescale3"] = function_e8ef6cb0(level.var_a432d965, "extrazombiescale3");
    level.var_a9e78bf7["extrazombiescale4"] = function_e8ef6cb0(level.var_a432d965, "extrazombiescale4");
    level.var_a9e78bf7["magicboxonlyweaponchance"] = function_e8ef6cb0(level.var_a432d965, "magicboxonlyweaponchance");
    level.var_a9e78bf7["maxmagicboxonlyweapons"] = function_e8ef6cb0(level.var_a432d965, "maxmagicboxonlyweapons");
    level.var_a9e78bf7["camochance"] = function_e8ef6cb0(level.var_a432d965, "camochance");
    function_9a6a6726();
    function_97b4bacb(0, 1);
    function_4542e087();
    namespace_2396e2d7::function_fc1970dd();
    namespace_2396e2d7::function_b6c845e8();
    namespace_293e8aad::function_aaa07980();
    level._zombiezigzagdistancemin = level.var_a9e78bf7["zigzagdeviationmin"];
    level._zombiezigzagdistancemax = level.var_a9e78bf7["zigzagdeviationmax"];
    level._zombiezigzagtimemin = level.var_a9e78bf7["zigzagdeviationmintime"];
    level._zombiezigzagtimemax = level.var_a9e78bf7["zigzagdeviationmaxtime"];
    if (level.var_a9e78bf7["startunaware"]) {
        level.var_3004e0c8 = 0;
        return;
    }
    level.var_3004e0c8 = 1;
}

// Namespace namespace_a432d965
// Params 0, eflags: 0x1 linked
// namespace_a432d965<file_0>::function_9a6a6726
// Checksum 0xe2103e6, Offset: 0x14c0
// Size: 0x1d6
function function_9a6a6726() {
    if (!isdefined(level.var_a432d965)) {
        return;
    }
    if (!isdefined(level.var_a9e78bf7)) {
        return;
    }
    level.var_a9e78bf7["aitypeMale1"] = function_e8ef6cb0(level.var_a432d965, "aitypeMale1");
    level.var_a9e78bf7["aitypeMale2"] = function_e8ef6cb0(level.var_a432d965, "aitypeMale2");
    level.var_a9e78bf7["aitypeMale3"] = function_e8ef6cb0(level.var_a432d965, "aitypeMale3");
    level.var_a9e78bf7["aitypeMale4"] = function_e8ef6cb0(level.var_a432d965, "aitypeMale4");
    level.var_a9e78bf7["maleSpawnChance2"] = function_e8ef6cb0(level.var_a432d965, "maleSpawnChance2");
    level.var_a9e78bf7["maleSpawnChance3"] = function_e8ef6cb0(level.var_a432d965, "maleSpawnChance3");
    level.var_a9e78bf7["maleSpawnChance4"] = function_e8ef6cb0(level.var_a432d965, "maleSpawnChance4");
    level.var_a9e78bf7["aitypeFemale"] = function_e8ef6cb0(level.var_a432d965, "aitypeFemale");
    level.var_a9e78bf7["femaleSpawnChance"] = function_e8ef6cb0(level.var_a432d965, "femaleSpawnChance");
}

// Namespace namespace_a432d965
// Params 2, eflags: 0x1 linked
// namespace_a432d965<file_0>::function_97b4bacb
// Checksum 0xca6321f4, Offset: 0x16a0
// Size: 0xf86
function function_97b4bacb(zombify, var_a621e856) {
    if (!isdefined(level.var_a9e78bf7["powerdropchance"])) {
        if (isdefined(level.var_a432d965)) {
            level.var_a9e78bf7["powerdropchance"] = function_e8ef6cb0(level.var_a432d965, "powerdropchance");
            if (!isdefined(level.var_a9e78bf7["powerdropchance"])) {
                level.var_a9e78bf7["powerdropchance"] = 0;
            }
        } else {
            level.var_a9e78bf7["powerdropchance"] = 40;
        }
    }
    if (!isdefined(level.var_a9e78bf7["maxdropammochance"])) {
        if (isdefined(level.var_a432d965)) {
            level.var_a9e78bf7["maxdropammochance"] = function_e8ef6cb0(level.var_a432d965, "maxdropammochance");
            if (!isdefined(level.var_a9e78bf7["maxdropammochance"])) {
                level.var_a9e78bf7["maxdropammochance"] = 0;
            }
        } else {
            level.var_a9e78bf7["maxdropammochance"] = 50;
        }
    }
    if (!isdefined(level.var_a9e78bf7["maxdropammoupgradedchance"])) {
        if (isdefined(level.var_a432d965)) {
            level.var_a9e78bf7["maxdropammoupgradedchance"] = function_e8ef6cb0(level.var_a432d965, "maxdropammoupgradedchance");
            if (!isdefined(level.var_a9e78bf7["maxdropammoupgradedchance"])) {
                level.var_a9e78bf7["maxdropammoupgradedchance"] = 0;
            }
        } else {
            level.var_a9e78bf7["maxdropammoupgradedchance"] = 0;
        }
    }
    if (!isdefined(level.var_a9e78bf7["cybercoredropchance"])) {
        if (isdefined(level.var_a432d965)) {
            level.var_a9e78bf7["cybercoredropchance"] = function_e8ef6cb0(level.var_a432d965, "cybercoredropchance");
            if (!isdefined(level.var_a9e78bf7["cybercoredropchance"])) {
                level.var_a9e78bf7["cybercoredropchance"] = 0;
            }
        } else {
            level.var_a9e78bf7["cybercoredropchance"] = 30;
        }
    }
    if (!isdefined(level.var_a9e78bf7["cybercoreupgradeddropchance"])) {
        if (isdefined(level.var_a432d965)) {
            level.var_a9e78bf7["cybercoreupgradeddropchance"] = function_e8ef6cb0(level.var_a432d965, "cybercoreupgradeddropchance");
            if (!isdefined(level.var_a9e78bf7["cybercoreupgradeddropchance"])) {
                level.var_a9e78bf7["cybercoreupgradeddropchance"] = 0;
            }
        } else {
            level.var_a9e78bf7["cybercoreupgradeddropchance"] = 0;
        }
    }
    if (!isdefined(level.var_a9e78bf7["rapsdropchance"])) {
        if (isdefined(level.var_a432d965)) {
            level.var_a9e78bf7["rapsdropchance"] = function_e8ef6cb0(level.var_a432d965, "rapsdropchance");
            if (!isdefined(level.var_a9e78bf7["rapsdropchance"])) {
                level.var_a9e78bf7["rapsdropchance"] = 0;
            }
        } else {
            level.var_a9e78bf7["rapsdropchance"] = 0;
        }
    }
    if (!isdefined(level.var_a9e78bf7["weapondropchance"])) {
        if (isdefined(level.var_a432d965)) {
            level.var_a9e78bf7["weapondropchance"] = function_e8ef6cb0(level.var_a432d965, "weapondropchance");
            if (!isdefined(level.var_a9e78bf7["weapondropchance"])) {
                level.var_a9e78bf7["weapondropchance"] = 0;
            }
        } else {
            level.var_a9e78bf7["weapondropchance"] = 20;
        }
    }
    if (!isdefined(level.var_a9e78bf7["instakilldropchance"])) {
        if (isdefined(level.var_a432d965)) {
            level.var_a9e78bf7["instakilldropchance"] = function_e8ef6cb0(level.var_a432d965, "instakilldropchance");
            if (!isdefined(level.var_a9e78bf7["instakilldropchance"])) {
                level.var_a9e78bf7["instakilldropchance"] = 0;
            }
        } else {
            level.var_a9e78bf7["powerdropchance"] = 15;
        }
    }
    if (!isdefined(level.var_a9e78bf7["instakillupgradeddropchance"])) {
        if (isdefined(level.var_a432d965)) {
            level.var_a9e78bf7["instakillupgradeddropchance"] = function_e8ef6cb0(level.var_a432d965, "instakillupgradeddropchance");
            if (!isdefined(level.var_a9e78bf7["instakillupgradeddropchance"])) {
                level.var_a9e78bf7["instakillupgradeddropchance"] = 0;
            }
        } else {
            level.var_a9e78bf7["instakillupgradeddropchance"] = 0;
        }
    }
    if (!isdefined(level.var_a9e78bf7["powerupdropsenabled"])) {
        level.var_a9e78bf7["powerupdropsenabled"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["waituntilskiptostarts"])) {
        level.var_a9e78bf7["waituntilskiptostarts"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["skiptoname"])) {
        level.var_a9e78bf7["skiptoname"] = "default";
    }
    if (!isdefined(level.var_a9e78bf7["onlyuseonstart"])) {
        level.var_a9e78bf7["onlyuseonstart"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["zombifyenabled"])) {
        level.var_a9e78bf7["zombifyenabled"] = zombify;
    }
    if (!isdefined(level.var_a9e78bf7["startunaware"])) {
        level.var_a9e78bf7["startunaware"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["alertnessspreaddelay"])) {
        level.var_a9e78bf7["alertnessspreaddelay"] = 2;
    }
    if (!isdefined(level.var_a9e78bf7["forcecleanuponcompletion"])) {
        level.var_a9e78bf7["forcecleanuponcompletion"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["disablefailsafelogic"])) {
        level.var_a9e78bf7["disablefailsafelogic"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["extraspawns"])) {
        level.var_a9e78bf7["extraspawns"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["zigzagdeviationmin"])) {
        level.var_a9e78bf7["zigzagdeviationmin"] = -6;
    }
    if (!isdefined(level.var_a9e78bf7["zigzagdeviationmax"])) {
        level.var_a9e78bf7["zigzagdeviationmax"] = 400;
    }
    if (!isdefined(level.var_a9e78bf7["zigzagdeviationmintime"])) {
        level.var_a9e78bf7["zigzagdeviationmintime"] = 2500;
    }
    if (!isdefined(level.var_a9e78bf7["zigzagdeviationmaxtime"])) {
        level.var_a9e78bf7["zigzagdeviationmaxtime"] = 4000;
    }
    if (!isdefined(level.var_a9e78bf7["extraspawngapmin"])) {
        level.var_a9e78bf7["extraspawngapmin"] = 2;
    }
    if (!isdefined(level.var_a9e78bf7["walkpercent"])) {
        if (isdefined(var_a621e856) && var_a621e856) {
            level.var_a9e78bf7["walkpercent"] = 0;
        } else {
            level.var_a9e78bf7["walkpercent"] = 33;
        }
    }
    if (!isdefined(level.var_a9e78bf7["runpercent"])) {
        if (isdefined(var_a621e856) && var_a621e856) {
            level.var_a9e78bf7["runpercent"] = 0;
        } else {
            level.var_a9e78bf7["runpercent"] = 33;
        }
    }
    if (!isdefined(level.var_a9e78bf7["sprintpercent"])) {
        if (isdefined(var_a621e856) && var_a621e856) {
            level.var_a9e78bf7["sprintpercent"] = 0;
        } else {
            level.var_a9e78bf7["sprintpercent"] = 34;
        }
    }
    if (!isdefined(level.var_a9e78bf7["levelonehealth"])) {
        level.var_a9e78bf7["levelonehealth"] = -106;
    }
    if (!isdefined(level.var_a9e78bf7["leveltwohealth"])) {
        level.var_a9e78bf7["leveltwohealth"] = 350;
    }
    if (!isdefined(level.var_a9e78bf7["levelthreehealth"])) {
        level.var_a9e78bf7["levelthreehealth"] = 650;
    }
    if (!isdefined(level.var_a9e78bf7["levelonezombies"])) {
        if (isdefined(var_a621e856) && var_a621e856) {
            level.var_a9e78bf7["levelonezombies"] = 0;
        } else {
            level.var_a9e78bf7["levelonezombies"] = 33;
        }
    }
    if (!isdefined(level.var_a9e78bf7["leveltwozombies"])) {
        if (isdefined(var_a621e856) && var_a621e856) {
            level.var_a9e78bf7["leveltwozombies"] = 0;
        } else {
            level.var_a9e78bf7["leveltwozombies"] = 33;
        }
    }
    if (!isdefined(level.var_a9e78bf7["levelthreezombies"])) {
        if (isdefined(var_a621e856) && var_a621e856) {
            level.var_a9e78bf7["levelthreezombies"] = 0;
        } else {
            level.var_a9e78bf7["levelthreezombies"] = 34;
        }
    }
    if (!isdefined(level.var_a9e78bf7["zombiehealthscale1"])) {
        level.var_a9e78bf7["zombiehealthscale1"] = 0.5;
    }
    if (!isdefined(level.var_a9e78bf7["zombiehealthscale2"])) {
        level.var_a9e78bf7["zombiehealthscale2"] = 1;
    }
    if (!isdefined(level.var_a9e78bf7["zombiehealthscale3"])) {
        level.var_a9e78bf7["zombiehealthscale3"] = 1.25;
    }
    if (!isdefined(level.var_a9e78bf7["zombiehealthscale4"])) {
        level.var_a9e78bf7["zombiehealthscale4"] = 1.5;
    }
    if (!isdefined(level.var_a9e78bf7["zombiehealthscale5"])) {
        level.var_a9e78bf7["zombiehealthscale5"] = 2;
    }
    if (!isdefined(level.var_a9e78bf7["extrazombiescale1"])) {
        level.var_a9e78bf7["extrazombiescale1"] = 1;
    }
    if (!isdefined(level.var_a9e78bf7["extrazombiescale2"])) {
        level.var_a9e78bf7["extrazombiescale2"] = 1.5;
    }
    if (!isdefined(level.var_a9e78bf7["extrazombiescale3"])) {
        level.var_a9e78bf7["extrazombiescale3"] = 1.75;
    }
    if (!isdefined(level.var_a9e78bf7["extrazombiescale4"])) {
        level.var_a9e78bf7["extrazombiescale4"] = 2;
    }
    if (!isdefined(level.var_a9e78bf7["suicidalzombiechance"])) {
        level.var_a9e78bf7["suicidalzombiechance"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["suicidalzombieupgradedchance"])) {
        level.var_a9e78bf7["suicidalzombieupgradedchance"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["deimosinfectedzombiechance"])) {
        level.var_a9e78bf7["deimosinfectedzombiechance"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["sparkzombiechance"])) {
        level.var_a9e78bf7["sparkzombiechance"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["sparkzombieupgradedchance"])) {
        level.var_a9e78bf7["sparkzombieupgradedchance"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["magicboxonlyweaponchance"])) {
        level.var_a9e78bf7["magicboxonlyweaponchance"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["maxmagicboxonlyweapons"])) {
        level.var_a9e78bf7["maxmagicboxonlyweapons"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["camochance"])) {
        level.var_a9e78bf7["camochance"] = 30;
    }
    if (!isdefined(level.var_a9e78bf7["pathabilityenabled"])) {
        level.var_a9e78bf7["pathabilityenabled"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["sprinttoplayerdistance"])) {
        level.var_a9e78bf7["sprinttoplayerdistance"] = 1000;
    }
    if (!isdefined(level.var_a9e78bf7["skipobjectivewait"])) {
        level.var_a9e78bf7["skipobjectivewait"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["maxreachabilitylevel"])) {
        level.var_a9e78bf7["maxreachabilitylevel"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["reachabilityinterval"])) {
        level.var_a9e78bf7["reachabilityinterval"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["maxreachabilityparasites"])) {
        level.var_a9e78bf7["maxreachabilityparasites"] = 0;
    }
    if (!isdefined(level.var_a9e78bf7["powerdropsscalar"])) {
        level.var_a9e78bf7["powerdropsscalar"] = 1;
    }
}

// Namespace namespace_a432d965
// Params 1, eflags: 0x1 linked
// namespace_a432d965<file_0>::function_15c7079
// Checksum 0x632909f, Offset: 0x2630
// Size: 0x20
function function_15c7079(index) {
    return "skipto" + index + "_";
}

// Namespace namespace_a432d965
// Params 0, eflags: 0x5 linked
// namespace_a432d965<file_0>::function_4542e087
// Checksum 0x44553725, Offset: 0x2658
// Size: 0x194
function private function_4542e087() {
    if (!level.var_a9e78bf7["zombifyenabled"]) {
        return;
    }
    var_939c81c8 = level.var_a9e78bf7["levelonezombies"] + level.var_a9e78bf7["leveltwozombies"] + level.var_a9e78bf7["levelthreezombies"];
    assert(var_939c81c8 == 100, "maxdropammochance" + level.var_a9e78bf7["maxdropammochance"]);
    var_939c81c8 = level.var_a9e78bf7["walkpercent"] + level.var_a9e78bf7["runpercent"] + level.var_a9e78bf7["sprintpercent"];
    assert(var_939c81c8 == 100, "maxdropammochance" + level.var_a9e78bf7["maxdropammochance"]);
    assert(level.var_a9e78bf7["maxdropammochance"] < level.var_a9e78bf7["maxdropammochance"], "maxdropammochance");
    assert(level.var_a9e78bf7["maxdropammochance"] < level.var_a9e78bf7["maxdropammochance"], "maxdropammochance");
}

// Namespace namespace_a432d965
// Params 3, eflags: 0x5 linked
// namespace_a432d965<file_0>::function_e9d4a03e
// Checksum 0xee8dc0e0, Offset: 0x27f8
// Size: 0xd2
function private function_e9d4a03e(var_68d35041, var_dbe80e3b, var_5a7ff9f0) {
    if (!level.var_a9e78bf7["zombifyenabled"]) {
        return;
    }
    var_939c81c8 = var_68d35041 + var_dbe80e3b + var_5a7ff9f0;
    assert(var_939c81c8 == 100, "maxdropammochance" + level.var_a9e78bf7["maxdropammochance"]);
    level.var_a9e78bf7["walkpercent"] = var_68d35041;
    level.var_a9e78bf7["runpercent"] = var_dbe80e3b;
    level.var_a9e78bf7["sprintpercent"] = var_5a7ff9f0;
}

// Namespace namespace_a432d965
// Params 3, eflags: 0x5 linked
// namespace_a432d965<file_0>::function_fd2d1f37
// Checksum 0x43fb351e, Offset: 0x28d8
// Size: 0x7a
function private function_fd2d1f37(var_52292ab5, var_d3cfcdb3, var_dd13b525) {
    if (!level.var_a9e78bf7["zombifyenabled"]) {
        return;
    }
    level.var_a9e78bf7["levelonehealth"] = var_52292ab5;
    level.var_a9e78bf7["leveltwohealth"] = var_d3cfcdb3;
    level.var_a9e78bf7["levelthreehealth"] = var_dd13b525;
}

// Namespace namespace_a432d965
// Params 1, eflags: 0x5 linked
// namespace_a432d965<file_0>::function_27fb20e1
// Checksum 0x6139457d, Offset: 0x2960
// Size: 0x52
function private function_27fb20e1(chance) {
    if (!level.var_a9e78bf7["zombifyenabled"]) {
        return;
    }
    if (chance > 100) {
        chance = 100;
    }
    level.var_a9e78bf7["suicidalzombiechance"] = chance;
}

// Namespace namespace_a432d965
// Params 1, eflags: 0x4
// namespace_a432d965<file_0>::function_481f94
// Checksum 0xb3f5ed5, Offset: 0x29c0
// Size: 0x52
function private function_481f94(chance) {
    if (!level.var_a9e78bf7["zombifyenabled"]) {
        return;
    }
    if (chance > 100) {
        chance = 100;
    }
    level.var_a9e78bf7["sparkzombiechance"] = chance;
}

