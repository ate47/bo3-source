#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_98a305bf;

// Namespace namespace_98a305bf
// Params 0, eflags: 0x2
// Checksum 0xa96465a8, Offset: 0x168
// Size: 0x34
function function_2dc19561() {
    system::register("zm_demo", &__init__, undefined, undefined);
}

// Namespace namespace_98a305bf
// Params 0, eflags: 0x1 linked
// Checksum 0xd9c3bdfb, Offset: 0x1a8
// Size: 0x54
function __init__() {
    if (isdemoplaying()) {
        if (!isdefined(level.demolocalclients)) {
            level.demolocalclients = [];
        }
        callback::on_localclient_connect(&player_on_connect);
    }
}

// Namespace namespace_98a305bf
// Params 1, eflags: 0x1 linked
// Checksum 0x838493f1, Offset: 0x208
// Size: 0x24
function player_on_connect(localclientnum) {
    level thread watch_predicted_player_changes(localclientnum);
}

// Namespace namespace_98a305bf
// Params 1, eflags: 0x1 linked
// Checksum 0x3af5d63d, Offset: 0x238
// Size: 0x214
function watch_predicted_player_changes(localclientnum) {
    level.demolocalclients[localclientnum] = spawnstruct();
    level.demolocalclients[localclientnum].nonpredicted_local_player = getnonpredictedlocalplayer(localclientnum);
    level.demolocalclients[localclientnum].predicted_local_player = getlocalplayer(localclientnum);
    while (true) {
        nonpredicted_local_player = getnonpredictedlocalplayer(localclientnum);
        predicted_local_player = getlocalplayer(localclientnum);
        if (nonpredicted_local_player !== level.demolocalclients[localclientnum].nonpredicted_local_player) {
            level notify(#"demo_nplplayer_change", localclientnum, level.demolocalclients[localclientnum].nonpredicted_local_player, nonpredicted_local_player);
            level notify("demo_nplplayer_change" + localclientnum, level.demolocalclients[localclientnum].nonpredicted_local_player, nonpredicted_local_player);
            level.demolocalclients[localclientnum].nonpredicted_local_player = nonpredicted_local_player;
        }
        if (predicted_local_player !== level.demolocalclients[localclientnum].predicted_local_player) {
            level notify(#"demo_plplayer_change", localclientnum, level.demolocalclients[localclientnum].predicted_local_player, predicted_local_player);
            level notify("demo_plplayer_change" + localclientnum, level.demolocalclients[localclientnum].predicted_local_player, predicted_local_player);
            level.demolocalclients[localclientnum].predicted_local_player = predicted_local_player;
        }
        wait(0.016);
    }
}

