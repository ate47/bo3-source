#namespace delete;

// Namespace delete
// Params 0, eflags: 0x1 linked
// Checksum 0xb5ab1af4, Offset: 0x70
// Size: 0xfc
function main() {
    assert(isdefined(self));
    wait(0);
    if (isdefined(self)) {
        /#
            if (isdefined(self.classname)) {
                if (self.classname == "<unknown string>" || self.classname == "<unknown string>" || self.classname == "<unknown string>") {
                    println("<unknown string>");
                    println("<unknown string>" + self getentitynumber() + "<unknown string>" + self.origin);
                    println("<unknown string>");
                }
            }
        #/
        self delete();
    }
}

