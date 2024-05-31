#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_audio;
#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_72c864a4;

// Namespace namespace_72c864a4
// Params 0, eflags: 0x1 linked
// namespace_72c864a4<file_0>::function_c2eb9077
// Checksum 0x99ec1590, Offset: 0x748
// Size: 0x4
function precachecustomcharacters() {
    
}

// Namespace namespace_72c864a4
// Params 0, eflags: 0x1 linked
// namespace_72c864a4<file_0>::function_64b491e4
// Checksum 0x5a5dd539, Offset: 0x758
// Size: 0x24
function initcharacterstartindex() {
    level.characterstartindex = randomint(4);
}

// Namespace namespace_72c864a4
// Params 0, eflags: 0x0
// namespace_72c864a4<file_0>::function_31420e52
// Checksum 0x114a29d7, Offset: 0x788
// Size: 0x3e
function selectcharacterindextouse() {
    if (level.characterstartindex >= 4) {
        level.characterstartindex = 0;
    }
    self.characterindex = level.characterstartindex;
    level.characterstartindex++;
    return self.characterindex;
}

// Namespace namespace_72c864a4
// Params 0, eflags: 0x1 linked
// namespace_72c864a4<file_0>::function_2b7aef11
// Checksum 0x6ebaf324, Offset: 0x7d0
// Size: 0x214
function assign_lowest_unused_character_index() {
    charindexarray = [];
    charindexarray[0] = 0;
    charindexarray[1] = 1;
    charindexarray[2] = 2;
    charindexarray[3] = 3;
    players = getplayers();
    if (players.size == 1) {
        charindexarray = array::randomize(charindexarray);
        if (charindexarray[0] == 2) {
            level.var_fe571972 = 1;
        }
        return charindexarray[0];
    } else {
        var_266da916 = 0;
        foreach (player in players) {
            if (isdefined(player.characterindex)) {
                arrayremovevalue(charindexarray, player.characterindex, 0);
                var_266da916++;
            }
        }
        if (charindexarray.size > 0) {
            if (var_266da916 == players.size - 1) {
                if (!(isdefined(level.var_fe571972) && level.var_fe571972)) {
                    level.var_fe571972 = 1;
                    return 2;
                }
            }
            charindexarray = array::randomize(charindexarray);
            if (charindexarray[0] == 2) {
                level.var_fe571972 = 1;
            }
            return charindexarray[0];
        }
    }
    return 0;
}

// Namespace namespace_72c864a4
// Params 0, eflags: 0x1 linked
// namespace_72c864a4<file_0>::function_a0c0aeb
// Checksum 0x535ad2a0, Offset: 0x9f0
// Size: 0x2a4
function givecustomcharacters() {
    self detachall();
    if (!isdefined(self.characterindex)) {
        self.characterindex = assign_lowest_unused_character_index();
    }
    self.favorite_wall_weapons_list = [];
    self.talks_in_danger = 0;
    /#
        if (getdvarstring("vox_plr_0_exert_burp_2") != "vox_plr_0_exert_burp_2") {
            self.characterindex = getdvarint("vox_plr_0_exert_burp_2");
        }
    #/
    self setcharacterbodytype(self.characterindex);
    self setcharacterbodystyle(0);
    self setcharacterhelmetstyle(0);
    switch (self.characterindex) {
    case 1:
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("870mcs");
        break;
    case 0:
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("frag_grenade");
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("bouncingbetty");
        break;
    case 3:
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("hk416");
        break;
    case 2:
        self.talks_in_danger = 1;
        level.rich_sq_player = self;
        level.var_b879b3b4 = self;
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("pistol_standard");
        break;
    }
    self setmovespeedscale(1);
    self function_ba25e637(4);
    self function_e67885f8(0);
    self thread set_exert_id();
}

// Namespace namespace_72c864a4
// Params 0, eflags: 0x1 linked
// namespace_72c864a4<file_0>::function_f7f01a5c
// Checksum 0xd002341d, Offset: 0xca0
// Size: 0x54
function set_exert_id() {
    self endon(#"disconnect");
    util::wait_network_frame();
    util::wait_network_frame();
    self zm_audio::setexertvoice(self.characterindex + 1);
}

// Namespace namespace_72c864a4
// Params 0, eflags: 0x0
// namespace_72c864a4<file_0>::function_80f102b1
// Checksum 0xbbf2f9fb, Offset: 0xd00
// Size: 0x8ba
function setup_personality_character_exerts() {
    level.exert_sounds[1]["burp"][0] = "vox_plr_0_exert_burp_0";
    level.exert_sounds[1]["burp"][1] = "vox_plr_0_exert_burp_1";
    level.exert_sounds[1]["burp"][2] = "vox_plr_0_exert_burp_2";
    level.exert_sounds[1]["burp"][3] = "vox_plr_0_exert_burp_3";
    level.exert_sounds[1]["burp"][4] = "vox_plr_0_exert_burp_4";
    level.exert_sounds[1]["burp"][5] = "vox_plr_0_exert_burp_5";
    level.exert_sounds[1]["burp"][6] = "vox_plr_0_exert_burp_6";
    level.exert_sounds[2]["burp"][0] = "vox_plr_1_exert_burp_0";
    level.exert_sounds[2]["burp"][1] = "vox_plr_1_exert_burp_1";
    level.exert_sounds[2]["burp"][2] = "vox_plr_1_exert_burp_2";
    level.exert_sounds[2]["burp"][3] = "vox_plr_1_exert_burp_3";
    level.exert_sounds[3]["burp"][0] = "vox_plr_2_exert_burp_0";
    level.exert_sounds[3]["burp"][1] = "vox_plr_2_exert_burp_1";
    level.exert_sounds[3]["burp"][2] = "vox_plr_2_exert_burp_2";
    level.exert_sounds[3]["burp"][3] = "vox_plr_2_exert_burp_3";
    level.exert_sounds[3]["burp"][4] = "vox_plr_2_exert_burp_4";
    level.exert_sounds[3]["burp"][5] = "vox_plr_2_exert_burp_5";
    level.exert_sounds[3]["burp"][6] = "vox_plr_2_exert_burp_6";
    level.exert_sounds[4]["burp"][0] = "vox_plr_3_exert_burp_0";
    level.exert_sounds[4]["burp"][1] = "vox_plr_3_exert_burp_1";
    level.exert_sounds[4]["burp"][2] = "vox_plr_3_exert_burp_2";
    level.exert_sounds[4]["burp"][3] = "vox_plr_3_exert_burp_3";
    level.exert_sounds[4]["burp"][4] = "vox_plr_3_exert_burp_4";
    level.exert_sounds[4]["burp"][5] = "vox_plr_3_exert_burp_5";
    level.exert_sounds[4]["burp"][6] = "vox_plr_3_exert_burp_6";
    level.exert_sounds[1]["hitmed"][0] = "vox_plr_0_exert_pain_medium_0";
    level.exert_sounds[1]["hitmed"][1] = "vox_plr_0_exert_pain_medium_1";
    level.exert_sounds[1]["hitmed"][2] = "vox_plr_0_exert_pain_medium_2";
    level.exert_sounds[1]["hitmed"][3] = "vox_plr_0_exert_pain_medium_3";
    level.exert_sounds[2]["hitmed"][0] = "vox_plr_1_exert_pain_medium_0";
    level.exert_sounds[2]["hitmed"][1] = "vox_plr_1_exert_pain_medium_1";
    level.exert_sounds[2]["hitmed"][2] = "vox_plr_1_exert_pain_medium_2";
    level.exert_sounds[2]["hitmed"][3] = "vox_plr_1_exert_pain_medium_3";
    level.exert_sounds[3]["hitmed"][0] = "vox_plr_2_exert_pain_medium_0";
    level.exert_sounds[3]["hitmed"][1] = "vox_plr_2_exert_pain_medium_1";
    level.exert_sounds[3]["hitmed"][2] = "vox_plr_2_exert_pain_medium_2";
    level.exert_sounds[3]["hitmed"][3] = "vox_plr_2_exert_pain_medium_3";
    level.exert_sounds[4]["hitmed"][0] = "vox_plr_3_exert_pain_medium_0";
    level.exert_sounds[4]["hitmed"][1] = "vox_plr_3_exert_pain_medium_1";
    level.exert_sounds[4]["hitmed"][2] = "vox_plr_3_exert_pain_medium_2";
    level.exert_sounds[4]["hitmed"][3] = "vox_plr_3_exert_pain_medium_3";
    level.exert_sounds[1]["hitlrg"][0] = "vox_plr_0_exert_pain_high_0";
    level.exert_sounds[1]["hitlrg"][1] = "vox_plr_0_exert_pain_high_1";
    level.exert_sounds[1]["hitlrg"][2] = "vox_plr_0_exert_pain_high_2";
    level.exert_sounds[1]["hitlrg"][3] = "vox_plr_0_exert_pain_high_3";
    level.exert_sounds[2]["hitlrg"][0] = "vox_plr_1_exert_pain_high_0";
    level.exert_sounds[2]["hitlrg"][1] = "vox_plr_1_exert_pain_high_1";
    level.exert_sounds[2]["hitlrg"][2] = "vox_plr_1_exert_pain_high_2";
    level.exert_sounds[2]["hitlrg"][3] = "vox_plr_1_exert_pain_high_3";
    level.exert_sounds[3]["hitlrg"][0] = "vox_plr_2_exert_pain_high_0";
    level.exert_sounds[3]["hitlrg"][1] = "vox_plr_2_exert_pain_high_1";
    level.exert_sounds[3]["hitlrg"][2] = "vox_plr_2_exert_pain_high_2";
    level.exert_sounds[3]["hitlrg"][3] = "vox_plr_2_exert_pain_high_3";
    level.exert_sounds[4]["hitlrg"][0] = "vox_plr_3_exert_pain_high_0";
    level.exert_sounds[4]["hitlrg"][1] = "vox_plr_3_exert_pain_high_1";
    level.exert_sounds[4]["hitlrg"][2] = "vox_plr_3_exert_pain_high_2";
    level.exert_sounds[4]["hitlrg"][3] = "vox_plr_3_exert_pain_high_3";
}

