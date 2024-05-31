#using scripts/shared/duplicaterenderbundle;
#using scripts/shared/gfx_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace postfx;

// Namespace postfx
// Params 0, eflags: 0x2
// namespace_bdde9225<file_0>::function_2dc19561
// Checksum 0x228dcdfc, Offset: 0x248
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("postfx_bundle", &__init__, undefined, undefined);
}

// Namespace postfx
// Params 0, eflags: 0x1 linked
// namespace_bdde9225<file_0>::function_8c87d8eb
// Checksum 0xb149bfc0, Offset: 0x288
// Size: 0x24
function __init__() {
    callback::on_localplayer_spawned(&localplayer_postfx_bundle_init);
}

// Namespace postfx
// Params 1, eflags: 0x1 linked
// namespace_bdde9225<file_0>::function_2dca7a10
// Checksum 0xdc4efc84, Offset: 0x2b8
// Size: 0x1c
function localplayer_postfx_bundle_init(localclientnum) {
    function_7e41df4();
}

// Namespace postfx
// Params 0, eflags: 0x1 linked
// namespace_bdde9225<file_0>::function_7e41df4
// Checksum 0x6938a182, Offset: 0x2e0
// Size: 0x64
function function_7e41df4() {
    if (isdefined(self.postfxbundelsinited)) {
        return;
    }
    self.postfxbundelsinited = 1;
    self.playingpostfxbundle = "";
    self.forcestoppostfxbundle = 0;
    self.exitpostfxbundle = 0;
    /#
        self thread postfxbundledebuglisten();
    #/
}

/#

    // Namespace postfx
    // Params 0, eflags: 0x1 linked
    // namespace_bdde9225<file_0>::function_6743421b
    // Checksum 0x8d0a5480, Offset: 0x350
    // Size: 0x1c0
    function postfxbundledebuglisten() {
        self endon(#"entityshutdown");
        setdvar("material", "material");
        setdvar("material", "material");
        setdvar("material", "material");
        while (true) {
            playbundlename = getdvarstring("material");
            if (playbundlename != "material") {
                self thread playpostfxbundle(playbundlename);
                setdvar("material", "material");
            }
            stopbundlename = getdvarstring("material");
            if (stopbundlename != "material") {
                self thread stoppostfxbundle();
                setdvar("material", "material");
            }
            stopbundlename = getdvarstring("material");
            if (stopbundlename != "material") {
                self thread exitpostfxbundle();
                setdvar("material", "material");
            }
            wait(0.5);
        }
    }

#/

// Namespace postfx
// Params 1, eflags: 0x1 linked
// namespace_bdde9225<file_0>::function_bca12b73
// Checksum 0x50299743, Offset: 0x518
// Size: 0x8b4
function playpostfxbundle(playbundlename) {
    self endon(#"entityshutdown");
    self endon(#"death");
    function_7e41df4();
    function_9493d991();
    bundle = struct::get_script_bundle("postfxbundle", playbundlename);
    if (!isdefined(bundle)) {
        println("material" + playbundlename + "material");
        return;
    }
    filterid = 0;
    totalaccumtime = 0;
    filter::init_filter_indices();
    self.playingpostfxbundle = playbundlename;
    localclientnum = self.localclientnum;
    looping = 0;
    enterstage = 0;
    exitstage = 0;
    finishlooponexit = 0;
    firstpersononly = 0;
    if (isdefined(bundle.looping)) {
        looping = bundle.looping;
    }
    if (isdefined(bundle.enterstage)) {
        enterstage = bundle.enterstage;
    }
    if (isdefined(bundle.exitstage)) {
        exitstage = bundle.exitstage;
    }
    if (isdefined(bundle.finishlooponexit)) {
        finishlooponexit = bundle.finishlooponexit;
    }
    if (isdefined(bundle.firstpersononly)) {
        firstpersononly = bundle.firstpersononly;
    }
    if (looping) {
        num_stages = 1;
        if (enterstage) {
            num_stages++;
        }
        if (exitstage) {
            num_stages++;
        }
    } else {
        num_stages = bundle.num_stages;
    }
    self.var_e55360b5 = undefined;
    if (isdefined(bundle.screencapture) && bundle.screencapture) {
        self.var_e55360b5 = playbundlename;
        createscenecodeimage(localclientnum, self.var_e55360b5);
        captureframe(localclientnum, self.var_e55360b5);
        setfilterpasscodetexture(localclientnum, filterid, 0, 0, self.var_e55360b5);
    }
    self thread watchentityshutdown(localclientnum, filterid);
    for (var_7e1e79fe = 0; var_7e1e79fe < num_stages && !self.forcestoppostfxbundle; var_7e1e79fe++) {
        stageprefix = "s";
        if (var_7e1e79fe < 10) {
            stageprefix += "0";
        }
        stageprefix += var_7e1e79fe + "_";
        stagelength = function_e8ef6cb0(bundle, stageprefix + "length");
        if (!isdefined(stagelength)) {
            function_381f14d2(localclientnum, stageprefix + "length not defined", filterid);
            return;
        }
        stagelength *= 1000;
        var_bb1ab626 = function_e8ef6cb0(bundle, stageprefix + "material");
        if (!isdefined(var_bb1ab626)) {
            function_381f14d2(localclientnum, stageprefix + "material not defined", filterid);
            return;
        }
        filter::map_material_helper(self, var_bb1ab626);
        setfilterpassmaterial(localclientnum, filterid, 0, filter::mapped_material_id(var_bb1ab626));
        setfilterpassenabled(localclientnum, filterid, 0, 1, 0, firstpersononly);
        var_d25f5a79 = function_e8ef6cb0(bundle, stageprefix + "screenCapture");
        if (isdefined(var_d25f5a79) && var_d25f5a79) {
            if (isdefined(self.var_e55360b5)) {
                freecodeimage(localclientnum, self.var_e55360b5);
                self.var_e55360b5 = undefined;
                setfilterpasscodetexture(localclientnum, filterid, 0, 0, "");
            }
            self.var_e55360b5 = stageprefix + playbundlename;
            createscenecodeimage(localclientnum, self.var_e55360b5);
            captureframe(localclientnum, self.var_e55360b5);
            setfilterpasscodetexture(localclientnum, filterid, 0, 0, self.var_e55360b5);
        }
        var_66dc8da6 = function_e8ef6cb0(bundle, stageprefix + "spriteFilter");
        if (isdefined(var_66dc8da6) && var_66dc8da6) {
            setfilterpassquads(localclientnum, filterid, 0, 2048);
        } else {
            setfilterpassquads(localclientnum, filterid, 0, 0);
        }
        thermal = function_e8ef6cb0(bundle, stageprefix + "thermal");
        enablethermaldraw(localclientnum, isdefined(thermal) && thermal);
        var_417f3f5 = enterstage && (!enterstage && var_7e1e79fe == 0 || looping && var_7e1e79fe == 1);
        accumtime = 0;
        prevtime = self getclienttime();
        while ((var_417f3f5 || accumtime < stagelength) && !self.forcestoppostfxbundle) {
            gfx::setstage(localclientnum, bundle, filterid, stageprefix, stagelength, accumtime, totalaccumtime, &function_8d3c3170);
            wait(0.016);
            currtime = self getclienttime();
            deltatime = currtime - prevtime;
            accumtime += deltatime;
            totalaccumtime += deltatime;
            prevtime = currtime;
            if (var_417f3f5) {
                while (accumtime >= stagelength) {
                    accumtime -= stagelength;
                }
                if (self.exitpostfxbundle) {
                    var_417f3f5 = 0;
                    if (!finishlooponexit) {
                        break;
                    }
                }
            }
        }
        setfilterpassenabled(localclientnum, filterid, 0, 0);
    }
    function_381f14d2(localclientnum, "Finished " + playbundlename, filterid);
}

// Namespace postfx
// Params 2, eflags: 0x1 linked
// namespace_bdde9225<file_0>::function_b712aa61
// Checksum 0xeecf8868, Offset: 0xdd8
// Size: 0x64
function watchentityshutdown(localclientnum, filterid) {
    self util::waittill_any("entityshutdown", "death", "finished_playing_postfx_bundle");
    function_381f14d2(localclientnum, "Entity Shutdown", filterid);
}

// Namespace postfx
// Params 4, eflags: 0x1 linked
// namespace_bdde9225<file_0>::function_8d3c3170
// Checksum 0xc9879422, Offset: 0xe48
// Size: 0x104
function function_8d3c3170(localclientnum, var_402c9c53, filterid, values) {
    var_84704bee = gfx::getshaderconstantindex(var_402c9c53);
    setfilterpassconstant(localclientnum, filterid, 0, var_84704bee + 0, values[0]);
    setfilterpassconstant(localclientnum, filterid, 0, var_84704bee + 1, values[1]);
    setfilterpassconstant(localclientnum, filterid, 0, var_84704bee + 2, values[2]);
    setfilterpassconstant(localclientnum, filterid, 0, var_84704bee + 3, values[3]);
}

// Namespace postfx
// Params 3, eflags: 0x1 linked
// namespace_bdde9225<file_0>::function_381f14d2
// Checksum 0x4d9b9b49, Offset: 0xf58
// Size: 0x12e
function function_381f14d2(localclientnum, msg, filterid) {
    /#
        if (isdefined(msg)) {
            println(msg);
        }
    #/
    if (isdefined(self)) {
        self notify(#"finished_playing_postfx_bundle");
        self.forcestoppostfxbundle = 0;
        self.exitpostfxbundle = 0;
        self.playingpostfxbundle = "";
    }
    setfilterpassquads(localclientnum, filterid, 0, 0);
    setfilterpassenabled(localclientnum, filterid, 0, 0);
    enablethermaldraw(localclientnum, 0);
    if (isdefined(self.var_e55360b5)) {
        setfilterpasscodetexture(localclientnum, filterid, 0, 0, "");
        freecodeimage(localclientnum, self.var_e55360b5);
        self.var_e55360b5 = undefined;
    }
}

// Namespace postfx
// Params 0, eflags: 0x1 linked
// namespace_bdde9225<file_0>::function_9493d991
// Checksum 0x83107ac0, Offset: 0x1090
// Size: 0x2c
function function_9493d991() {
    if (self.playingpostfxbundle != "") {
        stoppostfxbundle();
    }
}

// Namespace postfx
// Params 0, eflags: 0x1 linked
// namespace_bdde9225<file_0>::function_3d1a8db5
// Checksum 0xa81d07ee, Offset: 0x10c8
// Size: 0x76
function stoppostfxbundle() {
    self notify(#"hash_b4b813eb");
    self endon(#"hash_b4b813eb");
    if (isdefined(self.playingpostfxbundle) && self.playingpostfxbundle != "") {
        self.forcestoppostfxbundle = 1;
        while (self.playingpostfxbundle != "") {
            wait(0.016);
            if (!isdefined(self)) {
                return;
            }
        }
    }
}

// Namespace postfx
// Params 0, eflags: 0x1 linked
// namespace_bdde9225<file_0>::function_51f910fd
// Checksum 0xc55314bb, Offset: 0x1148
// Size: 0x48
function exitpostfxbundle() {
    if (!(isdefined(self.exitpostfxbundle) && self.exitpostfxbundle) && isdefined(self.playingpostfxbundle) && self.playingpostfxbundle != "") {
        self.exitpostfxbundle = 1;
    }
}

// Namespace postfx
// Params 3, eflags: 0x1 linked
// namespace_bdde9225<file_0>::function_ef318b3
// Checksum 0x910f2a31, Offset: 0x1198
// Size: 0x124
function setfrontendstreamingoverlay(localclientnum, system, enabled) {
    if (!isdefined(self.overlayclients)) {
        self.overlayclients = [];
    }
    if (!isdefined(self.overlayclients[localclientnum])) {
        self.overlayclients[localclientnum] = [];
    }
    self.overlayclients[localclientnum][system] = enabled;
    foreach (en in self.overlayclients[localclientnum]) {
        if (en) {
            enablefrontendstreamingoverlay(localclientnum, 1);
            return;
        }
    }
    enablefrontendstreamingoverlay(localclientnum, 0);
}

