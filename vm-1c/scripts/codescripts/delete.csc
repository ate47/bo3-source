#namespace delete;

// Namespace delete
// Params 0, eflags: 0x1 linked
// Checksum 0xe409724c, Offset: 0x70
// Size: 0xfc
function main() {
    assert(isdefined(self));
    wait 0;
    if (isdefined(self)) {
        /#
            if (isdefined(self.classname)) {
                if (self.classname == "<dev string:x28>" || self.classname == "<dev string:x35>" || self.classname == "<dev string:x44>") {
                    println("<dev string:x55>");
                    println("<dev string:x56>" + self getentitynumber() + "<dev string:x94>" + self.origin);
                    println("<dev string:x55>");
                }
            }
        #/
        self delete();
    }
}

