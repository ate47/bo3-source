#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/water_surface;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace waterfall;

// Namespace waterfall
// Params 1, eflags: 0x1 linked
// Checksum 0x1a70c90f, Offset: 0x210
// Size: 0xca
function waterfalloverlay(localclientnum) {
    triggers = getentarray(localclientnum, "waterfall", "targetname");
    foreach (trigger in triggers) {
        trigger thread setupwaterfall(localclientnum);
    }
}

// Namespace waterfall
// Params 1, eflags: 0x1 linked
// Checksum 0xfd5d4b84, Offset: 0x2e8
// Size: 0xca
function waterfallmistoverlay(localclientnum) {
    triggers = getentarray(localclientnum, "waterfall_mist", "targetname");
    foreach (trigger in triggers) {
        trigger thread setupwaterfallmist(localclientnum);
    }
}

// Namespace waterfall
// Params 1, eflags: 0x1 linked
// Checksum 0x63426d8c, Offset: 0x3c0
// Size: 0x44
function waterfallmistoverlayreset(localclientnum) {
    localplayer = getlocalplayer(localclientnum);
    localplayer.rainopacity = 0;
}

// Namespace waterfall
// Params 1, eflags: 0x1 linked
// Checksum 0x3afb91a9, Offset: 0x410
// Size: 0x128
function setupwaterfallmist(localclientnum) {
    level notify("setupWaterfallmist_waterfall_csc" + localclientnum);
    level endon("setupWaterfallmist_waterfall_csc" + localclientnum);
    trigger = self;
    for (;;) {
        trigplayer = trigger waittill(#"trigger");
        if (!trigplayer islocalplayer()) {
            continue;
        }
        localclientnum = trigplayer getlocalclientnumber();
        if (isdefined(localclientnum)) {
            localplayer = getlocalplayer(localclientnum);
        } else {
            localplayer = trigplayer;
        }
        filter::init_filter_sprite_rain(localplayer);
        trigger thread trigger::function_thread(localplayer, &trig_enter_waterfall_mist, &trig_leave_waterfall_mist);
    }
}

// Namespace waterfall
// Params 2, eflags: 0x1 linked
// Checksum 0x181d276e, Offset: 0x540
// Size: 0x118
function setupwaterfall(localclientnum, localowner) {
    level notify("setupWaterfall_waterfall_csc" + localclientnum);
    level endon("setupWaterfall_waterfall_csc" + localclientnum);
    trigger = self;
    for (;;) {
        trigplayer = trigger waittill(#"trigger");
        if (!trigplayer islocalplayer()) {
            continue;
        }
        localclientnum = trigplayer getlocalclientnumber();
        if (isdefined(localclientnum)) {
            localplayer = getlocalplayer(localclientnum);
        } else {
            localplayer = trigplayer;
        }
        trigger thread trigger::function_thread(localplayer, &trig_enter_waterfall, &trig_leave_waterfall);
    }
}

// Namespace waterfall
// Params 1, eflags: 0x1 linked
// Checksum 0xf395f41, Offset: 0x660
// Size: 0xb8
function trig_enter_waterfall(localplayer) {
    trigger = self;
    localclientnum = localplayer.localclientnum;
    localplayer thread postfx::playpostfxbundle("pstfx_waterfall");
    playsound(0, "amb_waterfall_hit", (0, 0, 0));
    while (trigger istouching(localplayer)) {
        localplayer playrumbleonentity(localclientnum, "waterfall_rumble");
        wait(0.1);
    }
}

// Namespace waterfall
// Params 1, eflags: 0x1 linked
// Checksum 0x235a7961, Offset: 0x720
// Size: 0x84
function trig_leave_waterfall(localplayer) {
    trigger = self;
    localclientnum = localplayer.localclientnum;
    localplayer postfx::stoppostfxbundle();
    if (isunderwater(localclientnum) == 0) {
        localplayer thread water_surface::startwatersheeting();
    }
}

// Namespace waterfall
// Params 1, eflags: 0x1 linked
// Checksum 0xd9836bd, Offset: 0x7b0
// Size: 0x1f0
function trig_enter_waterfall_mist(localplayer) {
    localplayer endon(#"entityshutdown");
    trigger = self;
    if (!isdefined(localplayer.rainopacity)) {
        localplayer.rainopacity = 0;
    }
    if (localplayer.rainopacity == 0) {
        filter::set_filter_sprite_rain_seed_offset(localplayer, 0, randomfloat(1));
    }
    filter::enable_filter_sprite_rain(localplayer, 0);
    while (trigger istouching(localplayer)) {
        localclientnum = trigger.localclientnum;
        if (!isdefined(localclientnum)) {
            localclientnum = localplayer getlocalclientnumber();
        }
        if (isunderwater(localclientnum)) {
            filter::disable_filter_sprite_rain(localplayer, 0);
            break;
        }
        localplayer.rainopacity += 0.003;
        if (localplayer.rainopacity > 1) {
            localplayer.rainopacity = 1;
        }
        filter::set_filter_sprite_rain_opacity(localplayer, 0, localplayer.rainopacity);
        filter::set_filter_sprite_rain_elapsed(localplayer, 0, localplayer getclienttime());
        wait(0.016);
    }
}

// Namespace waterfall
// Params 1, eflags: 0x1 linked
// Checksum 0x8382a05c, Offset: 0x9a8
// Size: 0x174
function trig_leave_waterfall_mist(localplayer) {
    localplayer endon(#"entityshutdown");
    trigger = self;
    if (isdefined(localplayer.rainopacity)) {
        while (!trigger istouching(localplayer) && localplayer.rainopacity > 0) {
            localclientnum = trigger.localclientnum;
            if (isunderwater(localclientnum)) {
                filter::disable_filter_sprite_rain(localplayer, 0);
                break;
            }
            localplayer.rainopacity -= 0.005;
            filter::set_filter_sprite_rain_opacity(localplayer, 0, localplayer.rainopacity);
            filter::set_filter_sprite_rain_elapsed(localplayer, 0, localplayer getclienttime());
            wait(0.016);
        }
    }
    localplayer.rainopacity = 0;
    filter::disable_filter_sprite_rain(localplayer, 0);
}

