#using scripts/shared/util_shared;
#using scripts/shared/math_shared;

#namespace face;

// Namespace face
// Params 1, eflags: 0x0
// Checksum 0xad7967b3, Offset: 0x198
// Size: 0x114
function saygenericdialogue(typestring) {
    if (level.disablegenericdialog) {
        return;
    }
    switch (typestring) {
    case 0:
        importance = 0.5;
        break;
    case 4:
        importance = 0.5;
        typestring = "attack";
        break;
    case 1:
        importance = 0.7;
        break;
    case 3:
        importance = 0.4;
        break;
    case 2:
        wait(0.01);
        importance = 0.4;
        break;
    default:
        println(" " + typestring);
        importance = 0.3;
        break;
    }
    saygenericdialoguewithimportance(typestring, importance);
}

// Namespace face
// Params 2, eflags: 0x1 linked
// Checksum 0x7d7ea58a, Offset: 0x2b8
// Size: 0xb4
function saygenericdialoguewithimportance(typestring, importance) {
    soundalias = "dds_";
    if (isdefined(self.dds_characterid)) {
        soundalias += self.dds_characterid;
    } else {
        println(" ");
        return;
    }
    soundalias += "_" + typestring;
    if (soundexists(soundalias)) {
        self thread playfacethread(undefined, soundalias, importance);
    }
}

// Namespace face
// Params 1, eflags: 0x0
// Checksum 0xae0f325c, Offset: 0x378
// Size: 0x20
function setidlefacedelayed(facialanimationarray) {
    self.a.idleface = facialanimationarray;
}

// Namespace face
// Params 1, eflags: 0x0
// Checksum 0xeaf5d1ef, Offset: 0x3a0
// Size: 0x44
function setidleface(facialanimationarray) {
    if (!anim.usefacialanims) {
        return;
    }
    self.a.idleface = facialanimationarray;
    self playidleface();
}

// Namespace face
// Params 7, eflags: 0x1 linked
// Checksum 0xcda62950, Offset: 0x3f0
// Size: 0x6c
function sayspecificdialogue(facialanim, soundalias, importance, notifystring, waitornot, timetowait, toplayer) {
    self thread playfacethread(facialanim, soundalias, importance, notifystring, waitornot, timetowait, toplayer);
}

// Namespace face
// Params 0, eflags: 0x1 linked
// Checksum 0x1787f7b3, Offset: 0x468
// Size: 0x4
function playidleface() {
    
}

// Namespace face
// Params 7, eflags: 0x1 linked
// Checksum 0x2c36f57b, Offset: 0x478
// Size: 0x6a8
function playfacethread(facialanim, str_script_alias, importance, notifystring, waitornot, timetowait, toplayer) {
    self endon(#"death");
    if (!isdefined(str_script_alias)) {
        wait(1);
        self notify(notifystring);
        return;
    }
    str_notify_alias = str_script_alias;
    if (!isdefined(level.numberofimportantpeopletalking)) {
        level.numberofimportantpeopletalking = 0;
    }
    if (!isdefined(level.talknotifyseed)) {
        level.talknotifyseed = 0;
    }
    if (!isdefined(notifystring)) {
        notifystring = "PlayFaceThread " + str_script_alias;
    }
    if (!isdefined(self.a)) {
        self.a = spawnstruct();
    }
    if (!isdefined(self.a.facialsounddone)) {
        self.a.facialsounddone = 1;
    }
    if (!isdefined(self.istalking)) {
        self.istalking = 0;
    }
    if (self.istalking) {
        if (isdefined(self.a.currentdialogimportance)) {
            if (importance < self.a.currentdialogimportance) {
                wait(1);
                self notify(notifystring);
                return;
            } else if (importance == self.a.currentdialogimportance) {
                if (self.a.facialsoundalias == str_script_alias) {
                    return;
                }
                println(" " + self.a.facialsoundalias + " " + str_script_alias);
                while (self.istalking) {
                    self waittill(#"hash_90f83311");
                }
            }
        } else {
            println(" " + self.a.facialsoundalias + " " + str_script_alias);
            self stopsound(self.a.facialsoundalias);
            self notify(#"hash_ad4a3c97");
            while (self.istalking) {
                self waittill(#"hash_90f83311");
            }
        }
    }
    assert(self.a.facialsounddone);
    assert(self.a.facialsoundalias == undefined);
    assert(self.a.facialsoundnotify == undefined);
    assert(self.a.currentdialogimportance == undefined);
    assert(!self.istalking);
    self notify(#"bc_interrupt");
    self.istalking = 1;
    self.a.facialsounddone = 0;
    self.a.facialsoundnotify = notifystring;
    self.a.facialsoundalias = str_script_alias;
    self.a.currentdialogimportance = importance;
    if (importance == 1) {
        level.numberofimportantpeopletalking += 1;
    }
    /#
        if (level.numberofimportantpeopletalking > 1) {
            println(" " + str_script_alias);
        }
    #/
    uniquenotify = notifystring + " " + level.talknotifyseed;
    level.talknotifyseed += 1;
    if (isdefined(level.scr_sound) && isdefined(level.scr_sound["generic"])) {
        str_vox_file = level.scr_sound["generic"][str_script_alias];
    }
    if (isdefined(str_vox_file)) {
        if (soundexists(str_vox_file)) {
            if (isplayer(toplayer)) {
                self thread _play_sound_to_player_with_notify(str_vox_file, toplayer, uniquenotify);
            } else if (isdefined(self gettagorigin("J_Head"))) {
                self playsoundwithnotify(str_vox_file, uniquenotify, "J_Head");
            } else {
                self playsoundwithnotify(str_vox_file, uniquenotify);
            }
        } else {
            /#
                println(" " + str_script_alias + " ");
                self thread _missing_dialog(str_script_alias, str_vox_file, uniquenotify);
            #/
        }
    } else {
        self thread _temp_dialog(str_script_alias, uniquenotify);
    }
    self util::waittill_any("death", "cancel speaking", uniquenotify);
    if (importance == 1) {
        level.numberofimportantpeopletalking -= 1;
        level.importantpeopletalkingtime = gettime();
    }
    if (isdefined(self)) {
        self.istalking = 0;
        self.a.facialsounddone = 1;
        self.a.facialsoundnotify = undefined;
        self.a.facialsoundalias = undefined;
        self.a.currentdialogimportance = undefined;
        self.lastsaytime = gettime();
    }
    self notify(#"hash_90f83311", str_notify_alias);
    self notify(notifystring);
}

// Namespace face
// Params 3, eflags: 0x1 linked
// Checksum 0x8d055a2a, Offset: 0xb28
// Size: 0xaa
function _play_sound_to_player_with_notify(soundalias, toplayer, uniquenotify) {
    self endon(#"death");
    toplayer endon(#"death");
    self playsoundtoplayer(soundalias, toplayer);
    n_playbacktime = soundgetplaybacktime(soundalias);
    if (n_playbacktime > 0) {
        wait(n_playbacktime * 0.001);
    } else {
        wait(1);
    }
    self notify(uniquenotify);
}

// Namespace face
// Params 3, eflags: 0x5 linked
// Checksum 0x9ffd662d, Offset: 0xbe0
// Size: 0x33e
function private _temp_dialog(str_line, uniquenotify, b_missing_vo) {
    if (!isdefined(b_missing_vo)) {
        b_missing_vo = 0;
    }
    setdvar("bgcache_disablewarninghints", 1);
    if (!b_missing_vo && isdefined(self.propername)) {
        str_line = self.propername + ": " + str_line;
    }
    foreach (player in level.players) {
        if (!isdefined(player getluimenu("TempDialog"))) {
            player openluimenu("TempDialog");
        }
        player setluimenudata(player getluimenu("TempDialog"), "dialogText", str_line);
        if (b_missing_vo) {
            player setluimenudata(player getluimenu("TempDialog"), "title", "MISSING VO SOUND");
            continue;
        }
        player setluimenudata(player getluimenu("TempDialog"), "title", "TEMP VO");
    }
    n_wait_time = (strtok(str_line, " ").size - 1) / 2;
    n_wait_time = math::clamp(n_wait_time, 2, 5);
    util::waittill_any_timeout(n_wait_time, "death", "cancel speaking");
    foreach (player in level.players) {
        if (isdefined(player getluimenu("TempDialog"))) {
            player closeluimenu(player getluimenu("TempDialog"));
        }
    }
    setdvar("bgcache_disablewarninghints", 0);
    self notify(uniquenotify);
}

// Namespace face
// Params 3, eflags: 0x5 linked
// Checksum 0x9d9fde07, Offset: 0xf28
// Size: 0x54
function private _missing_dialog(str_script_alias, str_vox_file, uniquenotify) {
    _temp_dialog("script id: " + str_script_alias + " sound alias: " + str_vox_file, uniquenotify, 1);
}

// Namespace face
// Params 3, eflags: 0x0
// Checksum 0x4ff23ab5, Offset: 0xf88
// Size: 0x5a
function playface_waitfornotify(waitforstring, notifystring, killmestring) {
    self endon(#"death");
    self endon(killmestring);
    self waittill(waitforstring);
    self.a.facewaitforresult = "notify";
    self notify(notifystring);
}

// Namespace face
// Params 3, eflags: 0x0
// Checksum 0xdc9ea251, Offset: 0xff0
// Size: 0x56
function playface_waitfortime(time, notifystring, killmestring) {
    self endon(#"death");
    self endon(killmestring);
    wait(time);
    self.a.facewaitforresult = "time";
    self notify(notifystring);
}

