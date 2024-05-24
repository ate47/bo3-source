#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_29da2c3c;

// Namespace namespace_29da2c3c
// Params 0, eflags: 0x2
// Checksum 0xe7a39eb6, Offset: 0xe8
// Size: 0x84
function autoexec init() {
    zombie_utility::register_ignore_player_handler("margwa", &function_478e89a7);
    zombie_utility::register_ignore_player_handler("zombie", &function_478e89a7);
    level.var_66c4cad4 = &function_66c4cad4;
    level.var_979a9287 = &function_979a9287;
}

// Namespace namespace_29da2c3c
// Params 0, eflags: 0x4
// Checksum 0x3bee7064, Offset: 0x178
// Size: 0x216
function private function_478e89a7() {
    self.ignore_player = [];
    foreach (player in level.players) {
        if (isdefined(player.teleporting) && player.teleporting) {
            array::add(self.ignore_player, player);
            continue;
        }
        if (isdefined(player.var_65f06b5) && player.var_65f06b5) {
            var_d3443466 = [[ level.var_292a0ac9 ]]->function_3e62f527();
            if (!(isdefined(self.var_e0d198e4) && self.var_e0d198e4) && !(isdefined(var_d3443466) && var_d3443466)) {
                touching = [[ level.var_292a0ac9 ]]->function_406e4ba9(self);
                if (!touching) {
                    array::add(self.ignore_player, player);
                }
            }
        }
        if (isdefined(self.var_81ac9e79) && self.var_81ac9e79 && !(isdefined(player.var_84f1bc44) && player.var_84f1bc44)) {
            array::add(self.ignore_player, player);
            continue;
        }
        if (isdefined(self.var_de609f65) && player !== self.var_de609f65) {
            array::add(self.ignore_player, player);
        }
    }
}

// Namespace namespace_29da2c3c
// Params 0, eflags: 0x0
// Checksum 0xffd17d44, Offset: 0x398
// Size: 0x22
function function_66c4cad4() {
    if ([[ level.var_292a0ac9 ]]->function_406e4ba9(self)) {
        return true;
    }
    return false;
}

// Namespace namespace_29da2c3c
// Params 1, eflags: 0x0
// Checksum 0x895c738a, Offset: 0x3c8
// Size: 0x84
function function_979a9287(player) {
    if (isdefined(player.var_65f06b5) && player.var_65f06b5) {
        var_d3443466 = [[ level.var_292a0ac9 ]]->function_3e62f527();
        if (!(isdefined(self.var_e0d198e4) && self.var_e0d198e4) && !(isdefined(var_d3443466) && var_d3443466)) {
            return false;
        }
    }
    return true;
}

