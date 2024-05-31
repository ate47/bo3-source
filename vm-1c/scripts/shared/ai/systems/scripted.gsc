#using_animtree("generic");

#namespace scripted;

// Namespace scripted
// Params 0, eflags: 0x1 linked
// namespace_6cff281b<file_0>::function_d290ebfa
// Checksum 0x31c6455e, Offset: 0x98
// Size: 0x78
function main() {
    self endon(#"death");
    self notify(#"killanimscript");
    self notify(#"clearsuppressionattack");
    self.codescripted["root"] = generic%body;
    self endon(#"end_sequence");
    self.a.script = "scripted";
    self waittill(#"killanimscript");
}

// Namespace scripted
// Params 9, eflags: 0x0
// namespace_6cff281b<file_0>::function_c35e6aab
// Checksum 0xa67b02c3, Offset: 0x118
// Size: 0x4c
function init(notifyname, origin, angles, theanim, animmode, root, rate, goaltime, lerptime) {
    
}

// Namespace scripted
// Params 0, eflags: 0x1 linked
// namespace_6cff281b<file_0>::function_9b08d9a2
// Checksum 0xea90fc5a, Offset: 0x170
// Size: 0x20
function end_script() {
    if (isdefined(self.___archetypeonbehavecallback)) {
        [[ self.___archetypeonbehavecallback ]](self);
    }
}

