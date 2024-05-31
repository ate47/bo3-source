#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace gfx;

// Namespace gfx
// Params 8, eflags: 0x1 linked
// Checksum 0x2d77b00c, Offset: 0x260
// Size: 0x5ec
function setstage(localclientnum, bundle, filterid, stageprefix, stagelength, accumtime, totalaccumtime, setconstants) {
    num_consts = getstructfieldorzero(bundle, stageprefix + "num_consts");
    for (constidx = 0; constidx < num_consts; constidx++) {
        constprefix = stageprefix + "c";
        if (constidx < 10) {
            constprefix += "0";
        }
        constprefix += constidx + "_";
        startvalue = getshaderconstantvalue(bundle, constprefix, "start", 0);
        endvalue = getshaderconstantvalue(bundle, constprefix, "end", 0);
        delays = getshaderconstantvalue(bundle, constprefix, "delay", 1);
        channels = function_e8ef6cb0(bundle, constprefix + "channels");
        iscolor = channels == "color" || isstring(channels) && channels == "color+alpha";
        animname = function_e8ef6cb0(bundle, constprefix + "anm");
        values = [];
        for (i = 0; i < 4; i++) {
            values[i] = 0;
        }
        for (chanidx = 0; chanidx < startvalue.size; chanidx++) {
            delaytime = delays[iscolor ? 0 : chanidx] * 1000;
            if (accumtime > delaytime && stagelength > delaytime) {
                timeratio = (accumtime - delaytime) / (stagelength - delaytime);
                timeratio = math::clamp(timeratio, 0, 1);
                lerpratio = 0;
                delta = endvalue[chanidx] - startvalue[chanidx];
                switch (animname) {
                case 14:
                    lerpratio = timeratio;
                    break;
                case 18:
                    lerpratio = 1;
                    break;
                case 11:
                    lerpratio = timeratio * timeratio;
                    break;
                case 13:
                    lerpratio = timeratio * -1 * (timeratio - 2);
                    break;
                case 12:
                    timeratio *= 2;
                    if (timeratio < 1) {
                        lerpratio = 0.5 * lerpratio * lerpratio;
                    } else {
                        timeratio -= 1;
                        lerpratio = -0.5 * (lerpratio * (lerpratio - 2) - 1);
                    }
                    break;
                case 16:
                    lerpratio = timeratio;
                    break;
                case 15:
                    if (timeratio > 0.5) {
                        lerpratio = 1 - timeratio;
                    } else {
                        lerpratio = timeratio;
                    }
                    break;
                case 17:
                    lerpratio = 0.5 - 0.5 * cos(360 * timeratio);
                    break;
                default:
                    break;
                }
                lerpratio = math::clamp(lerpratio, 0, 1);
                values[chanidx] = startvalue[chanidx] + lerpratio * delta;
                continue;
            }
            values[chanidx] = startvalue[chanidx];
        }
        [[ setconstants ]](localclientnum, function_e8ef6cb0(bundle, constprefix + "name"), filterid, values);
    }
    stageconstants = [];
    stageconstants[0] = totalaccumtime;
    stageconstants[1] = accumtime;
    stageconstants[2] = stagelength;
    stageconstants[3] = 0;
    [[ setconstants ]](localclientnum, "scriptvector7", filterid, stageconstants);
}

// Namespace gfx
// Params 4, eflags: 0x1 linked
// Checksum 0x99e635a9, Offset: 0x858
// Size: 0x4ae
function getshaderconstantvalue(bundle, constprefix, constname, delay) {
    channels = function_e8ef6cb0(bundle, constprefix + "channels");
    if (channels == "color" || delay && isstring(channels) && channels == "color+alpha") {
        channels = "1";
    }
    vals = [];
    switch (channels) {
    case 21:
    case 1:
        vals[0] = getstructfieldorzero(bundle, constprefix + constname + "_x");
        break;
    case 30:
    case 2:
        vals[0] = getstructfieldorzero(bundle, constprefix + constname + "_x");
        vals[1] = getstructfieldorzero(bundle, constprefix + constname + "_y");
        break;
    case 31:
    case 3:
        vals[0] = getstructfieldorzero(bundle, constprefix + constname + "_x");
        vals[1] = getstructfieldorzero(bundle, constprefix + constname + "_y");
        vals[2] = getstructfieldorzero(bundle, constprefix + constname + "_z");
        break;
    case 4:
    case 32:
        vals[0] = getstructfieldorzero(bundle, constprefix + constname + "_x");
        vals[1] = getstructfieldorzero(bundle, constprefix + constname + "_y");
        vals[2] = getstructfieldorzero(bundle, constprefix + constname + "_z");
        vals[3] = getstructfieldorzero(bundle, constprefix + constname + "_w");
        break;
    case 8:
        vals[0] = getstructfieldorzero(bundle, constprefix + constname + "_clr_r");
        vals[1] = getstructfieldorzero(bundle, constprefix + constname + "_clr_g");
        vals[2] = getstructfieldorzero(bundle, constprefix + constname + "_clr_b");
        break;
    case 9:
        vals[0] = getstructfieldorzero(bundle, constprefix + constname + "_clr_r");
        vals[1] = getstructfieldorzero(bundle, constprefix + constname + "_clr_g");
        vals[2] = getstructfieldorzero(bundle, constprefix + constname + "_clr_b");
        vals[3] = getstructfieldorzero(bundle, constprefix + constname + "_clr_a");
        break;
    }
    return vals;
}

// Namespace gfx
// Params 2, eflags: 0x1 linked
// Checksum 0xa0c3e150, Offset: 0xd10
// Size: 0x4e
function getstructfieldorzero(bundle, field) {
    ret = function_e8ef6cb0(bundle, field);
    if (!isdefined(ret)) {
        ret = 0;
    }
    return ret;
}

// Namespace gfx
// Params 1, eflags: 0x1 linked
// Checksum 0x8933aded, Offset: 0xd68
// Size: 0x8e
function getshaderconstantindex(codeconstname) {
    switch (codeconstname) {
    case 33:
        return 0;
    case 34:
        return 4;
    case 35:
        return 8;
    case 36:
        return 12;
    case 37:
        return 16;
    case 38:
        return 20;
    case 39:
        return 24;
    case 20:
        return 28;
    }
    return -1;
}

