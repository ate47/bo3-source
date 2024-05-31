#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;

#namespace zm_puppet;

/#

    // Namespace zm_puppet
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2f419328, Offset: 0xa0
    // Size: 0x20c
    function wait_for_puppet_pickup() {
        self endon(#"death");
        self.iscurrentlypuppet = 0;
        while (true) {
            if (isdefined(self.ispuppet) && self.ispuppet && !self.iscurrentlypuppet) {
                self notify(#"stop_zombie_goto_entrance");
                self.iscurrentlypuppet = 1;
            }
            if (!(isdefined(self.ispuppet) && self.ispuppet) && self.iscurrentlypuppet) {
                self.iscurrentlypuppet = 0;
            }
            if (isdefined(self.ispuppet) && self.ispuppet && zm_utility::check_point_in_playable_area(self.origin) && !isdefined(self.completed_emerging_into_playable_area)) {
                self zm_spawner::zombie_complete_emerging_into_playable_area();
                self.barricade_enter = 0;
            }
            player = getplayers()[0];
            if (isdefined(player) && player buttonpressed("<unknown string>")) {
                if (self.iscurrentlypuppet) {
                    if (zm_utility::check_point_in_playable_area(self.goalpos) && !zm_utility::check_point_in_playable_area(self.origin)) {
                        self.backedupgoal = self.goalpos;
                        self thread zm_spawner::function_1352119c(self.backupnode, 0);
                    }
                    if (!zm_utility::check_point_in_playable_area(self.goalpos) && isdefined(self.backupnode) && self.goalpos != self.backupnode.origin) {
                        self notify(#"stop_zombie_goto_entrance");
                    }
                }
            }
            wait(0.05);
        }
    }

#/
