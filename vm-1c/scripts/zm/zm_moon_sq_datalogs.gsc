#using scripts/zm/zm_moon_sq;
#using scripts/zm/zm_moon_amb;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_80d0b0a9;

// Namespace namespace_80d0b0a9
// Params 0, eflags: 0x1 linked
// namespace_80d0b0a9<file_0>::function_c35e6aab
// Checksum 0xffae8298, Offset: 0x368
// Size: 0x404
function init() {
    var_cd9ea424 = array("vox_story_2_log_1", "vox_story_2_log_2", "vox_story_2_log_3", "vox_story_2_log_4", "vox_story_2_log_5", "vox_story_2_log_6");
    var_6fc7ca24 = [];
    var_6fc7ca24["vox_story_2_log_1"] = 40;
    var_6fc7ca24["vox_story_2_log_2"] = 28;
    var_6fc7ca24["vox_story_2_log_3"] = 29;
    var_6fc7ca24["vox_story_2_log_4"] = 52;
    var_6fc7ca24["vox_story_2_log_5"] = 37;
    var_6fc7ca24["vox_story_2_log_6"] = -118;
    i = 0;
    var_b3f5e95 = struct::get_array("sq_datalog", "targetname");
    player = struct::get("sq_reel_to_reel", "targetname");
    for (var_b3f5e95 = array::randomize(var_b3f5e95); i < var_cd9ea424.size; var_b3f5e95 = array::randomize(var_b3f5e95)) {
        var_53a5577b = var_b3f5e95[0];
        log = spawn("script_model", var_53a5577b.origin);
        if (isdefined(var_53a5577b.angles)) {
            log.angles = var_53a5577b.angles;
        }
        log setmodel("p7_zm_moo_data_reel");
        log thread namespace_6e97c459::function_dd92f786("pickedup");
        who = log waittill(#"pickedup");
        playsoundatposition("fly_log_pickup", who.origin);
        who.var_459a83f3 = 1;
        log delete();
        who namespace_6e97c459::function_f72f765e("sq", "datalog");
        player thread namespace_6e97c459::function_dd92f786("placed", &function_a4bcd62c);
        who = player waittill(#"placed");
        who.var_459a83f3 = undefined;
        who namespace_6e97c459::function_9f2411a3("sq", "datalog");
        sound_ent = spawn("script_origin", player.origin);
        sound_ent playsoundwithnotify(var_cd9ea424[i], "sounddone");
        sound_ent playloopsound("vox_radio_egg_snapshot", 1);
        wait(var_6fc7ca24[var_cd9ea424[i]]);
        sound_ent stoploopsound(1);
        i++;
        arrayremovevalue(var_b3f5e95, var_53a5577b);
    }
}

// Namespace namespace_80d0b0a9
// Params 0, eflags: 0x1 linked
// namespace_80d0b0a9<file_0>::function_a4bcd62c
// Checksum 0x20a4eecd, Offset: 0x778
// Size: 0x18
function function_a4bcd62c() {
    if (isdefined(self.var_459a83f3)) {
        return true;
    }
    return false;
}

