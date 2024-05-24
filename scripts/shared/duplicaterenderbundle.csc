#using scripts/shared/gfx_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_9e20367a;

// Namespace namespace_9e20367a
// Params 0, eflags: 0x2
// Checksum 0xb03b661a, Offset: 0x230
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("duplicate_render_bundle", &__init__, undefined, undefined);
}

// Namespace namespace_9e20367a
// Params 0, eflags: 0x1 linked
// Checksum 0x4fb7160b, Offset: 0x270
// Size: 0x24
function __init__() {
    callback::on_localplayer_spawned(&function_58c8343a);
}

// Namespace namespace_9e20367a
// Params 1, eflags: 0x1 linked
// Checksum 0x5a01651d, Offset: 0x2a0
// Size: 0x1c
function function_58c8343a(localclientnum) {
    function_e5e53b1a();
}

// Namespace namespace_9e20367a
// Params 0, eflags: 0x1 linked
// Checksum 0xbce53f3f, Offset: 0x2c8
// Size: 0x64
function function_e5e53b1a() {
    if (isdefined(self.var_7d9d66c0)) {
        return;
    }
    self.var_7d9d66c0 = 1;
    self.var_33b1de58 = "";
    self.var_53791ab9 = 0;
    self.var_b908ab6c = 0;
    /#
        self thread function_4d534504();
    #/
}

/#

    // Namespace namespace_9e20367a
    // Params 0, eflags: 0x1 linked
    // Checksum 0xdf8c00cc, Offset: 0x338
    // Size: 0x1c0
    function function_4d534504() {
        self endon(#"entityshutdown");
        setdvar("fb_", "fb_");
        setdvar("fb_", "fb_");
        setdvar("fb_", "fb_");
        while (true) {
            playbundlename = getdvarstring("fb_");
            if (playbundlename != "fb_") {
                self thread function_5584f24e(playbundlename);
                setdvar("fb_", "fb_");
            }
            stopbundlename = getdvarstring("fb_");
            if (stopbundlename != "fb_") {
                self thread function_503eb424();
                setdvar("fb_", "fb_");
            }
            stopbundlename = getdvarstring("fb_");
            if (stopbundlename != "fb_") {
                self thread function_b908ab6c();
                setdvar("fb_", "fb_");
            }
            wait(0.5);
        }
    }

#/

// Namespace namespace_9e20367a
// Params 1, eflags: 0x1 linked
// Checksum 0x2cc9b982, Offset: 0x500
// Size: 0x554
function function_5584f24e(playbundlename) {
    self endon(#"entityshutdown");
    function_e5e53b1a();
    function_1122e900();
    bundle = struct::get_script_bundle("duprenderbundle", playbundlename);
    if (!isdefined(bundle)) {
        /#
            println("fb_" + playbundlename + "fb_");
        #/
        return;
    }
    totalaccumtime = 0;
    filter::init_filter_indices();
    self.var_33b1de58 = playbundlename;
    localclientnum = self.localclientnum;
    looping = 0;
    enterstage = 0;
    exitstage = 0;
    finishlooponexit = 0;
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
    for (var_7e1e79fe = 0; var_7e1e79fe < num_stages && !self.var_53791ab9; var_7e1e79fe++) {
        stageprefix = "s";
        if (var_7e1e79fe < 10) {
            stageprefix += "0";
        }
        stageprefix += var_7e1e79fe + "_";
        stagelength = function_e8ef6cb0(bundle, stageprefix + "length");
        if (!isdefined(stagelength)) {
            function_145785e5(localclientnum, stageprefix + " length not defined");
            return;
        }
        stagelength *= 1000;
        function_9cd899ba(localclientnum, bundle, stageprefix + "fb_", 0);
        function_9cd899ba(localclientnum, bundle, stageprefix + "dupfb_", 1);
        function_9cd899ba(localclientnum, bundle, stageprefix + "sonar_", 2);
        var_417f3f5 = enterstage && (!enterstage && var_7e1e79fe == 0 || looping && var_7e1e79fe == 1);
        accumtime = 0;
        prevtime = self getclienttime();
        while ((var_417f3f5 || accumtime < stagelength) && !self.var_53791ab9) {
            gfx::setstage(localclientnum, bundle, undefined, stageprefix, stagelength, accumtime, totalaccumtime, &function_a6aaa147);
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
                if (self.var_b908ab6c) {
                    var_417f3f5 = 0;
                    if (!finishlooponexit) {
                        break;
                    }
                }
            }
        }
        self disableduplicaterendering();
    }
    function_145785e5(localclientnum, "Finished " + playbundlename);
}

// Namespace namespace_9e20367a
// Params 4, eflags: 0x1 linked
// Checksum 0xf41254a7, Offset: 0xa60
// Size: 0x1fc
function function_9cd899ba(localclientnum, bundle, prefix, type) {
    method = 0;
    var_c1436aeb = function_e8ef6cb0(bundle, prefix + "method");
    if (isdefined(var_c1436aeb)) {
        switch (var_c1436aeb) {
        case 17:
            method = 0;
            break;
        case 14:
            method = 1;
            break;
        case 13:
            method = 3;
            break;
        case 16:
            method = 3;
            break;
        case 18:
            method = 2;
            break;
        case 15:
            method = 4;
            break;
        }
    }
    materialname = function_e8ef6cb0(bundle, prefix + "mc_material");
    materialid = -1;
    if (isdefined(materialname) && materialname != "") {
        materialname = "mc/" + materialname;
        materialid = filter::mapped_material_id(materialname);
        if (!isdefined(materialid)) {
            filter::map_material_helper_by_localclientnum(localclientnum, materialname);
            materialid = filter::mapped_material_id();
            if (!isdefined(materialid)) {
                materialid = -1;
            }
        }
    }
    self addduplicaterenderoption(type, method, materialid);
}

// Namespace namespace_9e20367a
// Params 4, eflags: 0x1 linked
// Checksum 0x8a82312d, Offset: 0xc68
// Size: 0x6c
function function_a6aaa147(localclientnum, var_402c9c53, filterid, values) {
    self mapshaderconstant(localclientnum, 0, var_402c9c53, values[0], values[1], values[2], values[3]);
}

// Namespace namespace_9e20367a
// Params 2, eflags: 0x1 linked
// Checksum 0x48da07de, Offset: 0xce0
// Size: 0x64
function function_145785e5(localclientnum, msg) {
    /#
        if (isdefined(msg)) {
            println(msg);
        }
    #/
    self.var_53791ab9 = 0;
    self.var_b908ab6c = 0;
    self.var_33b1de58 = "";
}

// Namespace namespace_9e20367a
// Params 0, eflags: 0x1 linked
// Checksum 0x9277ac22, Offset: 0xd50
// Size: 0x2c
function function_1122e900() {
    if (self.var_33b1de58 != "") {
        function_503eb424();
    }
}

// Namespace namespace_9e20367a
// Params 0, eflags: 0x1 linked
// Checksum 0x3bd6c971, Offset: 0xd88
// Size: 0x72
function function_503eb424() {
    if (!(isdefined(self.var_53791ab9) && self.var_53791ab9) && isdefined(self.var_33b1de58) && self.var_33b1de58 != "") {
        self.var_53791ab9 = 1;
        while (self.var_33b1de58 != "") {
            wait(0.016);
            if (!isdefined(self)) {
                return;
            }
        }
    }
}

// Namespace namespace_9e20367a
// Params 0, eflags: 0x1 linked
// Checksum 0x20be7a97, Offset: 0xe08
// Size: 0x48
function function_b908ab6c() {
    if (!(isdefined(self.var_b908ab6c) && self.var_b908ab6c) && isdefined(self.var_33b1de58) && self.var_33b1de58 != "") {
        self.var_b908ab6c = 1;
    }
}

